import { supabase } from "./supabase";
import { getCurrentUser } from "./helpers";

// ==========================================
// TYPES
// ==========================================

export interface GiftSuggestion {
  id: string;
  plan_id: string;
  user_id: string;
  name: string;
  description: string | null;
  price_range: string | null;
  purchase_url: string | null;
  image_url: string | null;
  is_purchased: boolean;
  purchased_at: string | null;
  category: GiftCategory;
  notes: string | null;
  created_at: string;
  updated_at: string;
}

export type GiftCategory =
  | "experience"
  | "handmade"
  | "tech"
  | "fashion"
  | "home"
  | "food"
  | "books"
  | "jewelry"
  | "subscription"
  | "other";

export interface RecipientInfo {
  name?: string;
  relation?: string;
  age?: number;
  interests?: string[];
  budget?: number;
  occasion?: string;
  language?: string;
}

export interface AiGiftSuggestion {
  name: string;
  description: string;
  price_range: string;
  category: GiftCategory;
  why_its_great: string;
}

// ==========================================
// AI GIFT SUGGESTIONS
// ==========================================

export async function getGiftSuggestions(
  recipientInfo: RecipientInfo,
): Promise<AiGiftSuggestion[]> {
  try {
    const { data, error } = await supabase.functions.invoke("ai-gifts", {
      body: {
        name: recipientInfo.name,
        age: recipientInfo.age,
        gender: undefined,
        interests: recipientInfo.interests?.join(", "),
        relationship: recipientInfo.relation,
        budget: recipientInfo.budget,
        language: recipientInfo.language ?? "tr",
      },
    });

    if (error) {
      if (__DEV__) {
        console.warn("Gift suggestion edge function error:", error);
      }
      return getDefaultSuggestions(recipientInfo);
    }

    const rawGifts: Array<{
      name: string;
      description: string;
      estimated_price: number;
      category: string;
      reason: string;
    }> = data?.gifts ?? [];

    if (!rawGifts.length) return getDefaultSuggestions(recipientInfo);

    const currencyMap: Record<string, string> = {
      tr: "TL",
      en: "$",
      de: "€",
      fr: "€",
      es: "€",
      it: "€",
      pt: "€",
      ru: "₽",
      ar: "$",
      ja: "¥",
      ko: "₩",
      zh: "¥",
      hi: "₹",
      nl: "€",
      pl: "zł",
      sv: "kr",
      uk: "₴",
    };
    const currency = currencyMap[recipientInfo.language ?? "tr"] ?? "TL";

    return rawGifts.map((g) => ({
      name: g.name,
      description: g.description,
      price_range: `${g.estimated_price} ${currency}`,
      category: (g.category as GiftCategory) ?? "other",
      why_its_great: g.reason,
    }));
  } catch (err) {
    if (__DEV__) {
      console.warn("getGiftSuggestions error:", err);
    }
    return getDefaultSuggestions(recipientInfo);
  }
}

// ==========================================
// GIFT CRUD
// ==========================================

export async function saveGiftIdea(
  planId: string,
  gift: {
    name: string;
    description?: string;
    price_range?: string;
    purchase_url?: string;
    image_url?: string;
    category?: GiftCategory;
    notes?: string;
  },
): Promise<GiftSuggestion> {
  const user = await getCurrentUser();

  const { data, error } = await supabase
    .from("gift_suggestions")
    .insert({
      plan_id: planId,
      user_id: user.id,
      name: gift.name,
      description: gift.description || null,
      price_range: gift.price_range || null,
      purchase_url: gift.purchase_url || null,
      image_url: gift.image_url || null,
      category: gift.category || "other",
      notes: gift.notes || null,
      is_purchased: false,
    })
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function getGiftsByPlan(
  planId: string,
): Promise<GiftSuggestion[]> {
  const { data, error } = await supabase
    .from("gift_suggestions")
    .select("*")
    .eq("plan_id", planId)
    .order("created_at", { ascending: false });

  if (error) throw error;
  return data || [];
}

/** Verify the current user owns the plan that contains this gift. */
async function verifyGiftOwnership(giftId: string): Promise<void> {
  const user = await getCurrentUser();
  const { data: gift } = await supabase
    .from("gift_suggestions")
    .select("plan_id")
    .eq("id", giftId)
    .single();

  if (!gift) throw new Error("Gift not found");

  const { data: plan } = await supabase
    .from("plans")
    .select("user_id")
    .eq("id", gift.plan_id)
    .single();

  if (!plan || plan.user_id !== user.id) {
    throw new Error("Not authorized to modify this gift");
  }
}

export async function updateGift(
  id: string,
  updates: Partial<
    Pick<
      GiftSuggestion,
      | "name"
      | "description"
      | "price_range"
      | "purchase_url"
      | "image_url"
      | "category"
      | "notes"
    >
  >,
): Promise<GiftSuggestion> {
  await verifyGiftOwnership(id);

  const { data, error } = await supabase
    .from("gift_suggestions")
    .update({ ...updates, updated_at: new Date().toISOString() })
    .eq("id", id)
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function markGiftPurchased(
  id: string,
  purchased: boolean = true,
): Promise<GiftSuggestion> {
  await verifyGiftOwnership(id);

  const { data, error } = await supabase
    .from("gift_suggestions")
    .update({
      is_purchased: purchased,
      purchased_at: purchased ? new Date().toISOString() : null,
      updated_at: new Date().toISOString(),
    })
    .eq("id", id)
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function removeGift(id: string): Promise<void> {
  await verifyGiftOwnership(id);

  const { error } = await supabase
    .from("gift_suggestions")
    .delete()
    .eq("id", id);

  if (error) throw error;
}

// ==========================================
// HELPERS
// ==========================================

function getDefaultSuggestions(info: RecipientInfo): AiGiftSuggestion[] {
  const suggestions: AiGiftSuggestion[] = [
    {
      name: "Personalized Photo Album",
      description: "A beautifully designed photo album with shared memories",
      price_range: "$20-50",
      category: "handmade",
      why_its_great: "Personal and sentimental — shows you put thought into it",
    },
    {
      name: "Experience Gift Card",
      description:
        "Gift card for a unique experience like cooking class, spa day, or concert",
      price_range: "$50-150",
      category: "experience",
      why_its_great: "Creates new memories together rather than adding clutter",
    },
    {
      name: "Custom Star Map",
      description:
        "A printed map of the night sky from a special date and location",
      price_range: "$30-60",
      category: "home",
      why_its_great: "Unique, romantic, and makes great wall decor",
    },
    {
      name: "Subscription Box",
      description:
        "Monthly subscription tailored to their interests (books, snacks, etc.)",
      price_range: "$15-40/month",
      category: "subscription",
      why_its_great: "The gift that keeps on giving month after month",
    },
    {
      name: "Wireless Earbuds",
      description: "High-quality wireless earbuds for music and podcasts",
      price_range: "$50-200",
      category: "tech",
      why_its_great: "Practical and something they will use every day",
    },
  ];

  // Filter by budget if provided
  if (info.budget && info.budget < 30) {
    return suggestions.filter(
      (s) => s.category === "handmade" || s.category === "subscription",
    );
  }

  return suggestions;
}
