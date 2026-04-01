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
      event_type: { type: "string", required: true, maxLength: 200 },
      mood: { type: "string", maxLength: 100 },
      duration_minutes: { type: "number", min: 1, max: 600 },
      language: { type: "string", maxLength: 10 },
    });
    if (invalid) return invalid;

    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);
    const rateLimited = await checkRateLimit(supabase, user.id);
    if (rateLimited) return rateLimited;
    const creditCheck = await checkCredits(supabase, user.id);
    if (creditCheck) return creditCheck;

    const { event_type, mood, duration_minutes = 60, language = "tr" } = body;

    const systemPrompt = `You are a music curator specializing in event playlists. Suggest songs for the given event.

Rules:
1. Suggest 10-15 songs that fit the event type and mood
2. Include a mix of well-known and interesting picks
3. Consider the event duration for the number of songs
4. Each song must have: title, artist, genre, mood (romantic/fun/energetic/chill/emotional), reason (why it fits)
5. Include both international and ${language === "tr" ? "Turkish" : "local"} songs
6. ${language === "tr" ? "Respond in Turkish for the reason field" : "Respond in English for the reason field"}

Return ONLY a JSON array of songs, no additional text.
Example format:
[
  {
    "title": "Perfect",
    "artist": "Ed Sheeran",
    "genre": "Pop",
    "mood": "romantic",
    "reason": "A timeless love song perfect for special moments"
  }
]`;

    const userMessage = `Event Type: ${event_type}
Mood: ${mood}
Duration: ${duration_minutes} minutes

Suggest a playlist.`;

    const response = await fetch(GEMINI_URL, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        system_instruction: { parts: [{ text: systemPrompt }] },
        contents: [{ role: "user", parts: [{ text: userMessage }] }],
        generationConfig: { temperature: 0.8, maxOutputTokens: 2048 },
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
      prompt_type: "music",
      input_data: { event_type, mood, duration_minutes },
      response_data: parsed,
      model_used: "gemini-2.0-flash",
      tokens_used: tokensUsed,
    });

    return new Response(JSON.stringify({ playlist: parsed }), {
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
