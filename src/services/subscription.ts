/**
 * Subscription Service
 *
 * Defines plan tiers, feature gates, and usage limit helpers.
 * Designed to work with RevenueCat SDK once native setup is complete.
 */

export type SubscriptionPlan = "free" | "plus" | "pro";

export interface PlanFeatures {
  /** Maximum surprise plans per month */
  maxPlans: number;
  /** Maximum AI chat queries per month */
  maxAiChats: number;
  /** Access to premium / curated scenarios */
  premiumScenarios: boolean;
  /** Maximum co-organizers per plan */
  coOrganizers: number;
  /** Photo storage allowance in bytes */
  photoStorage: number;
  /** Ability to export plans as PDF */
  exportPDF: boolean;
  /** Priority customer support */
  prioritySupport: boolean;
  /** Access to custom / premium themes */
  customThemes: boolean;
}

// ---------------------------------------------------------------------------
// Plan feature definitions
// ---------------------------------------------------------------------------

const UNLIMITED = Number.MAX_SAFE_INTEGER;

export const PLAN_FEATURES: Record<SubscriptionPlan, PlanFeatures> = {
  free: {
    maxPlans: 3,
    maxAiChats: 5,
    premiumScenarios: false,
    coOrganizers: 1,
    photoStorage: 10 * 1024 * 1024, // 10 MB
    exportPDF: false,
    prioritySupport: false,
    customThemes: false,
  },
  plus: {
    maxPlans: 20,
    maxAiChats: 50,
    premiumScenarios: true,
    coOrganizers: 5,
    photoStorage: 500 * 1024 * 1024, // 500 MB
    exportPDF: true,
    prioritySupport: false,
    customThemes: true,
  },
  pro: {
    maxPlans: UNLIMITED,
    maxAiChats: UNLIMITED,
    premiumScenarios: true,
    coOrganizers: UNLIMITED,
    photoStorage: 5 * 1024 * 1024 * 1024, // 5 GB
    exportPDF: true,
    prioritySupport: true,
    customThemes: true,
  },
};

// ---------------------------------------------------------------------------
// Pricing (Turkish Lira)
// ---------------------------------------------------------------------------

export const PLAN_PRICES = {
  plus: {
    monthly: "\u20BA49.99",
    yearly: "\u20BA399.99",
    yearlyMonthly: "\u20BA33.33",
  },
  pro: {
    monthly: "\u20BA99.99",
    yearly: "\u20BA799.99",
    yearlyMonthly: "\u20BA66.66",
  },
} as const;

// ---------------------------------------------------------------------------
// Plan hierarchy helpers
// ---------------------------------------------------------------------------

const PLAN_RANK: Record<SubscriptionPlan, number> = {
  free: 0,
  plus: 1,
  pro: 2,
};

/**
 * Returns true if `current` plan is equal to or higher than `required`.
 */
export function isPlanAtLeast(
  current: SubscriptionPlan,
  required: SubscriptionPlan,
): boolean {
  return PLAN_RANK[current] >= PLAN_RANK[required];
}

// ---------------------------------------------------------------------------
// Feature gate helpers
// ---------------------------------------------------------------------------

/**
 * Check whether a boolean feature is available on the given plan.
 */
export function hasFeature(
  plan: SubscriptionPlan,
  feature: keyof PlanFeatures,
): boolean {
  const value = PLAN_FEATURES[plan][feature];
  if (typeof value === "boolean") return value;
  // For numeric features, treat > 0 as "has feature"
  return (value as number) > 0;
}

/**
 * Get the numeric limit for a feature on the given plan.
 * Returns 0 for boolean features that are false, 1 for true.
 */
export function getLimit(
  plan: SubscriptionPlan,
  feature: keyof PlanFeatures,
): number {
  const value = PLAN_FEATURES[plan][feature];
  if (typeof value === "number") return value;
  return value ? 1 : 0;
}

/**
 * Check whether a user can perform an action given their current usage.
 *
 * @param plan          The user's subscription plan
 * @param action        The feature / limit key to check
 * @param currentUsage  How many times the user has already used this feature this period
 * @returns             true if the user still has capacity
 */
export function canPerformAction(
  plan: SubscriptionPlan,
  action: keyof PlanFeatures,
  currentUsage: number,
): boolean {
  const limit = getLimit(plan, action);
  if (typeof PLAN_FEATURES[plan][action] === "boolean") {
    return PLAN_FEATURES[plan][action] as boolean;
  }
  return currentUsage < limit;
}

/**
 * Returns a human-readable limit string for display purposes.
 */
export function formatLimit(
  plan: SubscriptionPlan,
  feature: keyof PlanFeatures,
  locale: "tr" | "en" = "tr",
): string {
  const value = PLAN_FEATURES[plan][feature];

  if (typeof value === "boolean") {
    if (locale === "tr") return value ? "Evet" : "Hayır";
    return value ? "Yes" : "No";
  }

  if (value >= UNLIMITED) {
    return locale === "tr" ? "Sınırsız" : "Unlimited";
  }

  // Special formatting for storage (bytes -> human readable)
  if (feature === "photoStorage") {
    if (value >= 1024 * 1024 * 1024)
      return `${Math.round(value / (1024 * 1024 * 1024))} GB`;
    if (value >= 1024 * 1024) return `${Math.round(value / (1024 * 1024))} MB`;
    return `${Math.round(value / 1024)} KB`;
  }

  return String(value);
}

/**
 * Check whether a user can perform an action, with first-surprise bypass.
 *
 * If the user is on the free plan and hasn't completed their first surprise yet
 * (and has at most 1 plan), all features are unlocked.
 */
export function canPerformActionWithFirstSurprise(
  plan: SubscriptionPlan,
  action: keyof PlanFeatures,
  currentUsage: number,
  firstSurpriseCompleted: boolean,
  currentPlanCount: number,
): boolean {
  // First surprise free: bypass all limits for the very first plan
  if (plan === "free" && !firstSurpriseCompleted && currentPlanCount <= 1) {
    return true;
  }
  return canPerformAction(plan, action, currentUsage);
}

/**
 * Check whether the first-surprise free offer is active.
 */
export function isFirstSurpriseFreeActive(
  plan: SubscriptionPlan,
  firstSurpriseCompleted: boolean,
): boolean {
  return plan === "free" && !firstSurpriseCompleted;
}

/**
 * Returns the minimum plan required for a given boolean feature.
 */
export function minimumPlanFor(feature: keyof PlanFeatures): SubscriptionPlan {
  if (hasFeature("free", feature)) return "free";
  if (hasFeature("plus", feature)) return "plus";
  return "pro";
}
