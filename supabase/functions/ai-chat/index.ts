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
      message: { type: "string", required: true, maxLength: 2000 },
      context: { type: "object" },
      conversation_history: { type: "array" },
      language: { type: "string", maxLength: 10 },
    });
    if (invalid) return invalid;

    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);
    const rateLimited = await checkRateLimit(supabase, user.id);
    if (rateLimited) return rateLimited;
    const creditCheck = await checkCredits(supabase, user.id);
    if (creditCheck) return creditCheck;

    const {
      message,
      context,
      conversation_history = [],
      language = "tr",
    } = body;

    let contextInfo = "";

    if (context?.scenario_id) {
      const { data: scenario } = await supabase
        .from("scenarios")
        .select(
          "title_tr, title_en, description_tr, category:categories(name_tr)",
        )
        .eq("id", context.scenario_id)
        .single();
      if (scenario) {
        contextInfo += `\nAktif senaryo: ${scenario.title_tr} - ${scenario.description_tr} (Kategori: ${scenario.category?.name_tr})`;
      }
    }

    if (context?.plan_id) {
      const { data: plan } = await supabase
        .from("plans")
        .select(
          "title, event_date, recipient_name, budget, status, checklist:plan_checklist_items(title, is_completed)",
        )
        .eq("id", context.plan_id)
        .single();
      if (plan) {
        const completed =
          plan.checklist?.filter((c: any) => c.is_completed).length ?? 0;
        const total = plan.checklist?.length ?? 0;
        contextInfo += `\nAktif plan: "${plan.title}", Tarih: ${plan.event_date || "Belirlenmedi"}, Kişi: ${plan.recipient_name || "Belirlenmedi"}, Bütçe: ${plan.budget || "Belirlenmedi"} TL, Durum: ${plan.status}, Checklist: ${completed}/${total} tamamlandı`;
      }
    }

    const { data: categories } = await supabase
      .from("categories")
      .select("name_tr, slug")
      .eq("is_active", true);
    const categoryList =
      categories?.map((c: any) => c.name_tr).join(", ") || "";

    const systemPrompt = `Sen "Momentra" uygulamasının yapay zeka asistanısın. Kullanıcılara sürpriz planlama konusunda yardımcı oluyorsun.

Uzmanlık alanların:
- Sürpriz planlama ve organizasyon
- Hediye önerileri
- Bütçe yönetimi
- Yaratıcı fikirler
- Duygusal anlar yaratma

Mevcut kategoriler: ${categoryList}
${contextInfo}

Kurallar:
1. Sıcak, arkadaşça ve heyecanlı ol
2. Pratik ve uygulanabilir öneriler ver
3. Bütçeye dikkat et
4. Kültürel hassasiyetlere saygılı ol
5. ${language === "tr" ? "Türkçe" : "İngilizce"} yanıt ver
6. Gerektiğinde aksiyon öner (senaryo görüntüleme, plan oluşturma vb.)

JSON formatında yanıt ver:
{
  "reply": "Asistan yanıtı",
  "suggested_actions": [
    {
      "type": "view_scenario | create_plan | update_checklist",
      "label": "Buton etiketi",
      "data": { "key": "value" }
    }
  ]
}

suggested_actions opsiyonel - sadece mantıklı olduğunda ekle. Sadece JSON döndür.`;

    // Convert conversation history: "assistant" → "model" for Gemini
    const historyContents = conversation_history.map((msg: any) => ({
      role: msg.role === "assistant" ? "model" : "user",
      parts: [{ text: msg.content }],
    }));

    const response = await fetch(GEMINI_URL, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        system_instruction: { parts: [{ text: systemPrompt }] },
        contents: [
          ...historyContents,
          { role: "user", parts: [{ text: message }] },
        ],
        generationConfig: { temperature: 0.7, maxOutputTokens: 1024 },
      }),
    });

    const aiResult = await response.json();
    const content =
      aiResult.candidates?.[0]?.content?.parts?.[0]?.text ||
      '{"reply": "Bir hata oluştu, lütfen tekrar deneyin."}';

    let parsed;
    try {
      parsed = JSON.parse(content);
    } catch {
      parsed = { reply: content };
    }

    const tokensUsed =
      (aiResult.usageMetadata?.promptTokenCount ?? 0) +
      (aiResult.usageMetadata?.candidatesTokenCount ?? 0);
    await supabase.from("ai_interactions").insert({
      user_id: user.id,
      prompt_type: "chat",
      input_data: { message, context },
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
