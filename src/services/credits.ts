import { supabase } from "./supabase";
import { getCurrentUserId } from "./helpers";
import type { SubscriptionPlan } from "./subscription";
import { PLAN_FEATURES } from "./subscription";

/**
 * AI Credit System
 *
 * Tracks AI usage via the ai_interactions table.
 * Each plan tier has a monthly credit limit.
 */

/**
 * Returns the max AI credits for a given plan tier.
 */
export function getCreditsForPlan(plan: SubscriptionPlan): number {
  return PLAN_FEATURES[plan].maxAiChats;
}

/**
 * Fetch the number of AI interactions used this month for a user.
 */
export async function fetchAICreditsUsed(userId: string): Promise<number> {
  const now = new Date();
  const startOfMonth = new Date(
    now.getFullYear(),
    now.getMonth(),
    1,
  ).toISOString();

  const { count, error } = await supabase
    .from("ai_interactions")
    .select("*", { count: "exact", head: true })
    .eq("user_id", userId)
    .gte("created_at", startOfMonth);

  if (error) {
    if (__DEV__) {
      console.warn("Failed to fetch AI credits used:", error);
    }
    return 0;
  }

  return count ?? 0;
}

/**
 * Returns the remaining AI credits for a user this month.
 *
 * NOTE (v1.0): All users get unlimited credits while IAP is disabled.
 * Restore the per-plan limit logic (commented out below) in v1.1+ when
 * RevenueCat integration is enabled.
 */
export async function getRemainingCredits(
  _userId: string,
  _plan: SubscriptionPlan,
): Promise<number> {
  return Infinity;
  // Original implementation (restore for v1.1):
  // const maxCredits = getCreditsForPlan(_plan);
  // if (maxCredits >= Number.MAX_SAFE_INTEGER) return Infinity;
  // const used = await fetchAICreditsUsed(_userId);
  // return Math.max(0, maxCredits - used);
}

/**
 * Consume one AI credit by logging the interaction.
 * Returns the new remaining credit count.
 */
export async function consumeAICredit(
  userId: string,
  promptType: string,
  inputData: Record<string, unknown> = {},
  responseData: Record<string, unknown> = {},
  modelUsed: string = "edge-function",
): Promise<void> {
  const { error } = await supabase.from("ai_interactions").insert({
    user_id: userId,
    prompt_type: promptType,
    input_data: inputData,
    response_data: responseData,
    model_used: modelUsed,
  });

  if (error) {
    if (__DEV__) {
      console.warn("Failed to log AI interaction:", error);
    }
  }
}
