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
      plan_id: { type: "string" },
      scenario_id: { type: "string", required: true },
      event_date: { type: "string", maxLength: 20 },
      budget: { type: "number", min: 0 },
      guest_count: { type: "number", min: 0 },
      recipient_name: { type: "string", maxLength: 200 },
      recipient_relation: { type: "string", maxLength: 200 },
      special_requests: { type: "string", maxLength: 1000 },
      language: { type: "string", maxLength: 10 },
    });
    if (invalid) return invalid;

    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);
    const rateLimited = await checkRateLimit(supabase, user.id);
    if (rateLimited) return rateLimited;
    const creditCheck = await checkCredits(supabase, user.id);
    if (creditCheck) return creditCheck;

    const {
      plan_id,
      scenario_id,
      event_date,
      budget,
      guest_count,
      recipient_name,
      recipient_relation,
      special_requests,
      language = "tr",
    } = body;

    const { data: scenario, error: scenarioError } = await supabase
      .from("scenarios")
      .select("*, steps:scenario_steps(*), category:categories(*)")
      .eq("id", scenario_id)
      .order("step_number", { referencedTable: "scenario_steps" })
      .single();

    if (scenarioError || !scenario) throw new Error("Scenario not found");

    const stepsDetail = scenario.steps
      ?.map(
        (s: any) =>
          `Adım ${s.step_number}: ${s.title_tr} (${s.title_en}) - ${s.description_tr} | Gün öncesi: ${s.days_before ?? "?"}, Tahmini maliyet: ${s.estimated_cost ?? "?"} TL`,
      )
      .join("\n");

    const systemPrompt = `Sen bir sürpriz planlama uzmanısın. Kullanıcının seçtiği senaryoyu kişiselleştirmesine yardımcı ol.

Senaryo: ${scenario.title_tr} (${scenario.title_en})
Açıklama: ${scenario.description_tr}
Kategori: ${scenario.category?.name_tr}
Zorluk: ${scenario.difficulty}/5
Bütçe aralığı: ${scenario.min_budget}-${scenario.max_budget} TL

Mevcut adımlar:
${stepsDetail}

Kullanıcının bilgilerine göre her adımı kişiselleştir, bütçe dağılımı yap ve ek ipuçları ver.

JSON formatında yanıt ver:
{
  "customized_steps": [
    {
      "step_number": 1,
      "title": "Kişiselleştirilmiş başlık",
      "description": "Kişiselleştirilmiş açıklama",
      "tips": "Pratik ipuçları",
      "estimated_cost": 500
    }
  ],
  "budget_breakdown": {
    "total_estimated": 5000,
    "items": [
      { "name": "Kalem adı", "cost": 1000 }
    ]
  },
  "additional_tips": ["İpucu 1", "İpucu 2"]
}

Yanıtı ${language === "tr" ? "Türkçe" : "İngilizce"} olarak ver. Sadece JSON döndür.`;

    const userMessage = `Etkinlik tarihi: ${event_date || "Belirtilmedi"}
Bütçe: ${budget || "Belirtilmedi"} TL
Misafir sayısı: ${guest_count || "Belirtilmedi"}
Kime: ${recipient_name || "Belirtilmedi"} (${recipient_relation || "Belirtilmedi"})
Özel istekler: ${special_requests || "Yok"}`;

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
      parsed = {
        customized_steps: [],
        budget_breakdown: { total_estimated: 0, items: [] },
        additional_tips: [],
      };
    }

    const tokensUsed =
      (aiResult.usageMetadata?.promptTokenCount ?? 0) +
      (aiResult.usageMetadata?.candidatesTokenCount ?? 0);
    await supabase.from("ai_interactions").insert({
      user_id: user.id,
      prompt_type: "customization",
      input_data: {
        plan_id,
        scenario_id,
        event_date,
        budget,
        guest_count,
        recipient_name,
        recipient_relation,
        special_requests,
      },
      response_data: parsed,
      model_used: "gemini-2.0-flash",
      tokens_used: tokensUsed,
    });

    if (plan_id) {
      await supabase
        .from("plans")
        .update({
          ai_suggestions: parsed,
          updated_at: new Date().toISOString(),
        })
        .eq("id", plan_id);
    }

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
