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
      name: { type: "string", maxLength: 200 },
      age: { type: "number", min: 0, max: 150 },
      gender: { type: "string", maxLength: 50 },
      interests: { type: "string", maxLength: 500 },
      relationship: { type: "string", maxLength: 200 },
      budget: { type: "number", min: 0 },
      language: { type: "string", maxLength: 10 },
    });
    if (invalid) return invalid;

    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);
    const rateLimited = await checkRateLimit(supabase, user.id);
    if (rateLimited) return rateLimited;
    const creditCheck = await checkCredits(supabase, user.id);
    if (creditCheck) return creditCheck;

    const {
      name,
      age,
      gender,
      interests,
      relationship,
      budget,
      language = "tr",
    } = body;

    const languageNameMap: Record<string, string> = {
      tr: "Turkish",
      en: "English",
      de: "German",
      fr: "French",
      es: "Spanish",
      it: "Italian",
      pt: "Portuguese",
      ru: "Russian",
      ar: "Arabic",
      ja: "Japanese",
      ko: "Korean",
      zh: "Chinese",
      hi: "Hindi",
      nl: "Dutch",
      pl: "Polish",
      sv: "Swedish",
      uk: "Ukrainian",
    };
    const currencyMap: Record<string, string> = {
      tr: "TL",
      en: "USD",
      de: "EUR",
      fr: "EUR",
      es: "EUR",
      it: "EUR",
      pt: "EUR",
      ru: "RUB",
      ar: "USD",
      ja: "JPY",
      ko: "KRW",
      zh: "CNY",
      hi: "INR",
      nl: "EUR",
      pl: "PLN",
      sv: "SEK",
      uk: "UAH",
    };
    const targetLanguage = languageNameMap[language] ?? "English";
    const currency = currencyMap[language] ?? "USD";

    const systemPrompt = `You are a gift recommendation expert. Generate personalized gift ideas based on recipient information.

Rules:
1. Generate 5-8 unique, creative gift ideas
2. Each gift must be within the specified budget
3. Personalize suggestions based on the recipient's age, gender, interests, and relationship
4. Each item must have: name, description, estimated_price (number), category (tech/experience/fashion/home/food/hobby/personal/book), reason (why this gift suits them)
5. Include a mix of categories when possible
6. Respond entirely in ${targetLanguage} — all text fields must be in ${targetLanguage}

Return ONLY a JSON array of gift ideas, no additional text.
Example format:
[
  {
    "name": "...",
    "description": "...",
    "estimated_price": 500,
    "category": "tech",
    "reason": "..."
  }
]`;

    const userMessage = `Recipient: ${name || "Not specified"}
Age: ${age || "Not specified"}
Gender: ${gender || "Not specified"}
Interests: ${interests || "Not specified"}
Relationship: ${relationship || "Not specified"}
Budget: ${budget} ${currency}

Suggest personalized gift ideas in ${targetLanguage}.`;

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
      prompt_type: "gifts",
      input_data: { name, age, gender, interests, relationship, budget },
      response_data: parsed,
      model_used: "gemini-2.0-flash",
      tokens_used: tokensUsed,
    });

    return new Response(JSON.stringify({ gifts: parsed }), {
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
