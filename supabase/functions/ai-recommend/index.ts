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
      occasion: { type: "string", maxLength: 200 },
      recipient: { type: "string", maxLength: 200 },
      budget_min: { type: "number", min: 0 },
      budget_max: { type: "number", min: 0 },
      guest_count: { type: "number", min: 0 },
      indoor_outdoor: { type: "string", maxLength: 50 },
      season: { type: "string", maxLength: 50 },
      preferences: { type: "string", maxLength: 1000 },
      language: { type: "string", maxLength: 10 },
    });
    if (invalid) return invalid;

    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);
    const rateLimited = await checkRateLimit(supabase, user.id);
    if (rateLimited) return rateLimited;
    const creditCheck = await checkCredits(supabase, user.id);
    if (creditCheck) return creditCheck;

    const {
      occasion,
      recipient,
      budget_min,
      budget_max,
      guest_count,
      indoor_outdoor,
      season,
      preferences,
      language = "tr",
    } = body;

    let query = supabase
      .from("scenarios")
      .select(
        "id, slug, title_tr, title_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, indoor_outdoor, season, tags, is_premium, category:categories(slug, name_tr, name_en)",
      )
      .eq("is_active", true);

    if (budget_max) query = query.lte("min_budget", budget_max);
    if (budget_min) query = query.gte("max_budget", budget_min);
    if (guest_count) query = query.lte("min_people", guest_count);
    if (indoor_outdoor && indoor_outdoor !== "both") {
      query = query.in("indoor_outdoor", [indoor_outdoor, "both"]);
    }

    const { data: scenarios, error } = await query.limit(50);
    if (error) throw error;

    if (!scenarios?.length) {
      return new Response(
        JSON.stringify({
          recommendations: [],
          general_tips_tr:
            "Maalesef kriterlerinize uygun senaryo bulunamadı. Filtreleri genişletmeyi deneyin.",
          general_tips_en:
            "Unfortunately no scenarios matching your criteria were found. Try broadening your filters.",
        }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" } },
      );
    }

    const scenarioList = scenarios
      .map(
        (s: any) =>
          `[ID:${s.id}] ${s.title_tr} (${s.title_en}) - Kategori: ${s.category?.name_tr}, Bütçe: ${s.min_budget}-${s.max_budget} TL, Kişi: ${s.min_people}-${s.max_people}, Zorluk: ${s.difficulty}/5, Mekan: ${s.indoor_outdoor}, Etiketler: ${s.tags?.join(", ")}`,
      )
      .join("\n");

    const systemPrompt = `Sen bir sürpriz planlama uzmanısın. Kullanıcının kriterlerine göre en uygun sürpriz senaryolarını öner.

Mevcut senaryolar:
${scenarioList}

Kullanıcının kriterlerine en uygun 3-5 senaryo seç ve her biri için neden uygun olduğunu açıkla.

JSON formatında yanıt ver:
{
  "recommendations": [
    {
      "scenario_id": "uuid",
      "score": 0.95,
      "reason_tr": "Türkçe açıklama",
      "reason_en": "English explanation"
    }
  ],
  "general_tips_tr": "Genel öneriler (Türkçe)",
  "general_tips_en": "General tips (English)"
}

Sadece JSON döndür, başka bir şey yazma.`;

    const userMessage = `Vesile: ${occasion || "Belirtilmedi"}
Kişi: ${recipient || "Belirtilmedi"}
Bütçe: ${budget_min || "?"}-${budget_max || "?"} TL
Misafir sayısı: ${guest_count || "Belirtilmedi"}
Mekan tercihi: ${indoor_outdoor || "Farketmez"}
Mevsim: ${season || "Farketmez"}
Özel tercihler: ${preferences || "Yok"}
Dil: ${language}`;

    const response = await fetch(GEMINI_URL, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        system_instruction: { parts: [{ text: systemPrompt }] },
        contents: [{ role: "user", parts: [{ text: userMessage }] }],
        generationConfig: { temperature: 0.7, maxOutputTokens: 1024 },
      }),
    });

    const aiResult = await response.json();
    const content = aiResult.candidates?.[0]?.content?.parts?.[0]?.text || "{}";

    let parsed;
    try {
      parsed = JSON.parse(content);
    } catch {
      parsed = {
        recommendations: [],
        general_tips_tr: "AI yanıtı işlenemedi.",
        general_tips_en: "Could not process AI response.",
      };
    }

    const tokensUsed =
      (aiResult.usageMetadata?.promptTokenCount ?? 0) +
      (aiResult.usageMetadata?.candidatesTokenCount ?? 0);
    await supabase.from("ai_interactions").insert({
      user_id: user.id,
      prompt_type: "recommendation",
      input_data: {
        occasion,
        recipient,
        budget_min,
        budget_max,
        guest_count,
        indoor_outdoor,
        season,
        preferences,
      },
      response_data: parsed,
      model_used: "gemini-2.0-flash",
      tokens_used: tokensUsed,
    });

    return new Response(JSON.stringify(parsed), {
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
