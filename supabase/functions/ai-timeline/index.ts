import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "jsr:@supabase/supabase-js@2";
import {
  corsHeaders,
  requireAuth,
  validateInput,
  checkRateLimit,
  checkCredits,
} from "../_shared/security.ts";

const GEMINI_API_KEY = Deno.env.get("GEMINI_API_KEY");
if (!GEMINI_API_KEY) throw new Error("GEMINI_API_KEY is not set");

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const GEMINI_URL = `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${GEMINI_API_KEY}`;

Deno.serve(async (req) => {
  if (req.method === "OPTIONS")
    return new Response("ok", { headers: corsHeaders });

  try {
    const user = await requireAuth(req);
    if (user instanceof Response) return user;

    const body = await req.json();
    const invalid = validateInput(body, {
      title: { type: "string", required: true, maxLength: 200 },
      event_date: { type: "string", required: true, maxLength: 20 },
      category: { type: "string", maxLength: 100 },
      budget: { type: "number", min: 0 },
      guest_count: { type: "number", min: 0 },
      language: { type: "string", maxLength: 10 },
    });
    if (invalid) return invalid;

    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);
    const rateLimited = await checkRateLimit(supabase, user.id);
    if (rateLimited) return rateLimited;
    const creditCheck = await checkCredits(supabase, user.id);
    if (creditCheck) return creditCheck;

    const {
      title,
      event_date,
      category,
      budget,
      guest_count,
      language = "tr",
    } = body;
    const today = new Date().toISOString().split("T")[0];

    const systemPrompt = `You are a surprise event planning assistant. Generate a smart preparation timeline for the given event.

Rules:
1. Generate 8-15 practical, actionable timeline items
2. Spread items across the preparation period from today (${today}) to the event date
3. Each item must have: title, description, due_date (YYYY-MM-DD), priority (high/medium/low), category (booking/shopping/decoration/communication/preparation/logistics)
4. Order items chronologically
5. Consider the budget and guest count for realistic tasks
6. ${language === "tr" ? "Respond in Turkish" : "Respond in English"}

Return ONLY a JSON array of timeline items, no additional text.
Example format:
[
  {
    "title": "Book venue",
    "description": "Research and reserve the event location",
    "due_date": "2024-03-01",
    "priority": "high",
    "category": "booking"
  }
]`;

    const userMessage = `Plan: "${title}"
Event Date: ${event_date}
Category: ${category}
Budget: ${budget} TL
Guest Count: ${guest_count || "Not specified"}

Generate a preparation timeline.`;

    const response = await fetch(GEMINI_URL, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        system_instruction: { parts: [{ text: systemPrompt }] },
        contents: [{ role: "user", parts: [{ text: userMessage }] }],
        generationConfig: { temperature: 0.7, maxOutputTokens: 2048 },
      }),
    });

    const aiResult = await response.json();
    const content = aiResult.candidates?.[0]?.content?.parts?.[0]?.text || "[]";

    let parsed;
    try {
      parsed = JSON.parse(content);
    } catch {
      const match = content.match(/\[[\s\S]*\]/);
      parsed = match ? JSON.parse(match[0]) : [];
    }

    const tokensUsed =
      (aiResult.usageMetadata?.promptTokenCount ?? 0) +
      (aiResult.usageMetadata?.candidatesTokenCount ?? 0);
    await supabase.from("ai_interactions").insert({
      user_id: user.id,
      prompt_type: "timeline",
      input_data: { title, event_date, category, budget, guest_count },
      response_data: parsed,
      model_used: "gemini-2.0-flash",
      tokens_used: tokensUsed,
    });

    return new Response(JSON.stringify({ timeline: parsed }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (error: any) {
    console.error("Error:", error);
    return new Response(
      JSON.stringify({ error: error?.message || "Internal server error" }),
      {
        status: 500,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      },
    );
  }
});
