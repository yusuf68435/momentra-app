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
      description: { type: "string", maxLength: 1000 },
      event_date: { type: "string", maxLength: 20 },
      category: { type: "string", maxLength: 100 },
      budget: { type: "number", min: 0 },
      guest_count: { type: "number", min: 0 },
      venue: { type: "string", maxLength: 200 },
      trigger_conditions: { type: "array" },
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
      description,
      event_date,
      category,
      budget,
      guest_count,
      venue,
      trigger_conditions = [],
      language = "tr",
    } = body;

    const systemPrompt = `You are an event contingency planning expert. Generate a comprehensive backup plan (Plan B) for the given surprise event.

Rules:
1. Consider the original plan's constraints (budget, date, guests, venue)
2. Address the specified trigger conditions
3. The backup plan should be realistic and quickly implementable
4. Keep the backup plan within a similar or lower budget
5. ${language === "tr" ? "Respond in Turkish" : "Respond in English"}

Return ONLY a JSON object with this structure, no additional text:
{
  "title": "Backup plan title",
  "description": "Brief overview of the backup plan",
  "steps": [
    {
      "order": 1,
      "title": "Step title",
      "description": "Detailed step description",
      "time_needed": "30 minutes"
    }
  ],
  "estimated_cost": 500,
  "advantages": ["Advantage 1", "Advantage 2"]
}`;

    const triggersText =
      trigger_conditions.length > 0
        ? `Trigger Conditions: ${trigger_conditions.join(", ")}`
        : "Trigger Conditions: Bad weather, venue unavailable, key person can't attend";

    const userMessage = `Original Plan: "${title}"
Description: ${description || "Not specified"}
Event Date: ${event_date}
Category: ${category || "Not specified"}
Budget: ${budget} TL
Guest Count: ${guest_count || "Not specified"}
Venue: ${venue || "Not specified"}
${triggersText}

Generate a backup plan.`;

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
    const content = aiResult.candidates?.[0]?.content?.parts?.[0]?.text || "{}";

    let parsed;
    try {
      parsed = JSON.parse(content);
    } catch {
      const match = content.match(/\{[\s\S]*\}/);
      parsed = match
        ? JSON.parse(match[0])
        : {
            title: "Backup Plan",
            description: "Could not generate backup plan",
            steps: [],
            estimated_cost: 0,
            advantages: [],
          };
    }

    const tokensUsed =
      (aiResult.usageMetadata?.promptTokenCount ?? 0) +
      (aiResult.usageMetadata?.candidatesTokenCount ?? 0);
    await supabase.from("ai_interactions").insert({
      user_id: user.id,
      prompt_type: "backup",
      input_data: {
        title,
        description,
        event_date,
        category,
        budget,
        guest_count,
        venue,
        trigger_conditions,
      },
      response_data: parsed,
      model_used: "gemini-2.0-flash",
      tokens_used: tokensUsed,
    });

    return new Response(JSON.stringify({ backup_plan: parsed }), {
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
