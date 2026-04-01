import { supabase } from "./supabase";
import { getCurrentUserId } from "./helpers";

/** Shape returned by fetchUserPlans with joined scenario/category */
interface PlanWithScenario {
  id: string;
  title: string;
  recipient_name: string | null;
  recipient_relation: string | null;
  budget: number | null;
  guest_count: number | null;
  status: string;
  event_date: string | null;
  created_at: string | null;
  scenario?: { category?: { slug: string; name_tr: string } } | null;
}

/** Shape returned by fetchFavoriteCategories with joined scenario/category */
interface FavoriteWithScenario {
  scenario?: { category?: { slug: string } } | null;
}

// ==========================================
// AI User Context - "Seni Tanıyorum" System
// Gathers user history, preferences, patterns
// to feed into all AI edge functions
// ==========================================

export interface UserAIContext {
  // User profile
  displayName: string | null;
  language: "tr" | "en";
  currency: string;

  // Surprise DNA - planning style preferences
  surpriseDna: SurpriseDNA | null;

  // Past plans summary
  pastPlans: PlanSummary[];
  totalPlansCreated: number;
  completedPlans: number;

  // Budget patterns
  budgetPatterns: BudgetPatterns;

  // Recipient patterns
  frequentRecipients: RecipientPattern[];

  // Favorite categories
  favoriteCategories: string[];

  // Seasonal context
  currentSeason: string;
  upcomingDates: UpcomingDate[];

  // Subscription tier
  subscriptionPlan: string;
}

export interface SurpriseDNA {
  // Planning style (1-5 scale)
  planningStyle: "spontaneous" | "meticulous" | "balanced";
  budgetTendency: "budget_conscious" | "moderate" | "generous";
  surpriseScale: "intimate" | "medium" | "grand";
  creativityLevel: "classic" | "creative" | "adventurous";
  // Detected from behavior
  preferredCategories: string[];
  avgBudget: number;
  avgGuestCount: number;
  preferredDayOfWeek: string | null;
  indoorOutdoorPreference: "indoor" | "outdoor" | "both";
}

export interface PlanSummary {
  id: string;
  title: string;
  recipientName: string | null;
  recipientRelation: string | null;
  category: string | null;
  budget: number | null;
  guestCount: number | null;
  status: string;
  eventDate: string | null;
  rating: number | null;
}

export interface BudgetPatterns {
  averageBudget: number;
  minBudget: number;
  maxBudget: number;
  totalSpent: number;
  budgetByCategory: Record<string, number>;
}

export interface RecipientPattern {
  name: string;
  relation: string | null;
  planCount: number;
  lastPlanDate: string | null;
}

export interface UpcomingDate {
  title: string;
  date: string;
  daysAway: number;
  recipientName?: string;
}

/**
 * Build a complete user context object for AI personalization.
 * This is passed to edge functions so Claude can give personalized advice.
 */
export async function buildUserAIContext(): Promise<UserAIContext | null> {
  const userId = await getCurrentUserId();
  if (!userId) return null;

  const [profile, plans, interactions, favorites, surpriseDna] =
    await Promise.all([
      fetchUserProfile(userId),
      fetchUserPlans(userId),
      fetchRecentInteractions(userId),
      fetchFavoriteCategories(userId),
      fetchSurpriseDNA(userId),
    ]);

  const pastPlans = plans.map((p) => ({
    id: p.id,
    title: p.title,
    recipientName: p.recipient_name,
    recipientRelation: p.recipient_relation,
    category: (p as PlanWithScenario).scenario?.category?.slug || null,
    budget: p.budget,
    guestCount: p.guest_count,
    status: p.status,
    eventDate: p.event_date,
    rating: null as number | null,
  }));

  const typedPlans = plans as unknown as PlanWithScenario[];
  const budgetPatterns = computeBudgetPatterns(typedPlans);
  const frequentRecipients = computeRecipientPatterns(typedPlans);
  const upcomingDates = computeUpcomingDates(typedPlans);

  return {
    displayName: profile?.display_name || null,
    language: (profile?.language as "tr" | "en") || "tr",
    currency: profile?.currency || "TRY",
    surpriseDna,
    pastPlans: pastPlans.slice(0, 10), // Last 10 plans
    totalPlansCreated: plans.length,
    completedPlans: plans.filter((p) => p.status === "completed").length,
    budgetPatterns,
    frequentRecipients,
    favoriteCategories: favorites,
    currentSeason: getCurrentSeason(),
    upcomingDates,
    subscriptionPlan: "free", // Will be overridden by caller
  };
}

// ---- Internal helpers ----

async function fetchUserProfile(userId: string) {
  const { data } = await supabase
    .from("profiles")
    .select("display_name, language, currency, timezone, preferences")
    .eq("id", userId)
    .single();
  return data;
}

async function fetchUserPlans(userId: string) {
  const { data } = await supabase
    .from("plans")
    .select(
      "id, title, recipient_name, recipient_relation, budget, guest_count, status, event_date, created_at, scenario:scenarios(category:categories(slug, name_tr))",
    )
    .eq("user_id", userId)
    .order("created_at", { ascending: false })
    .limit(50);
  return data || [];
}

async function fetchRecentInteractions(userId: string) {
  const { data } = await supabase
    .from("ai_interactions")
    .select("prompt_type, input_data, created_at")
    .eq("user_id", userId)
    .order("created_at", { ascending: false })
    .limit(20);
  return data || [];
}

async function fetchFavoriteCategories(userId: string) {
  const { data } = await supabase
    .from("favorites")
    .select("scenario:scenarios(category:categories(slug))")
    .eq("user_id", userId);

  if (!data) return [];

  const slugCounts: Record<string, number> = {};
  for (const fav of data) {
    const slug = (fav as FavoriteWithScenario).scenario?.category?.slug;
    if (slug) slugCounts[slug] = (slugCounts[slug] || 0) + 1;
  }

  return Object.entries(slugCounts)
    .sort((a, b) => b[1] - a[1])
    .map(([slug]) => slug)
    .slice(0, 5);
}

async function fetchSurpriseDNA(userId: string): Promise<SurpriseDNA | null> {
  const { data } = await supabase
    .from("profiles")
    .select("preferences")
    .eq("id", userId)
    .single();

  if (!data?.preferences) return null;
  const prefs = data.preferences as Record<string, unknown>;
  if (!prefs.surpriseDna) return null;
  return prefs.surpriseDna as SurpriseDNA;
}

function computeBudgetPatterns(plans: PlanWithScenario[]): BudgetPatterns {
  const budgets = plans
    .filter((p) => p.budget && p.budget > 0)
    .map((p) => p.budget as number);

  if (budgets.length === 0) {
    return {
      averageBudget: 0,
      minBudget: 0,
      maxBudget: 0,
      totalSpent: 0,
      budgetByCategory: {},
    };
  }

  const budgetByCategory: Record<string, number> = {};
  for (const p of plans) {
    if (p.budget && p.scenario?.category?.slug) {
      const cat = p.scenario.category.slug;
      budgetByCategory[cat] = (budgetByCategory[cat] || 0) + p.budget;
    }
  }

  return {
    averageBudget: Math.round(
      budgets.reduce((a, b) => a + b, 0) / budgets.length,
    ),
    minBudget: Math.min(...budgets),
    maxBudget: Math.max(...budgets),
    totalSpent: budgets.reduce((a, b) => a + b, 0),
    budgetByCategory,
  };
}

function computeRecipientPatterns(
  plans: PlanWithScenario[],
): RecipientPattern[] {
  const recipientMap: Record<string, RecipientPattern> = {};

  for (const p of plans) {
    if (!p.recipient_name) continue;
    const key = p.recipient_name.toLowerCase().trim();
    if (!recipientMap[key]) {
      recipientMap[key] = {
        name: p.recipient_name,
        relation: p.recipient_relation,
        planCount: 0,
        lastPlanDate: null,
      };
    }
    recipientMap[key].planCount++;
    if (
      !recipientMap[key].lastPlanDate ||
      (p.event_date && p.event_date > recipientMap[key].lastPlanDate!)
    ) {
      recipientMap[key].lastPlanDate = p.event_date;
    }
  }

  return Object.values(recipientMap)
    .sort((a, b) => b.planCount - a.planCount)
    .slice(0, 10);
}

function computeUpcomingDates(plans: PlanWithScenario[]): UpcomingDate[] {
  const now = new Date();
  const upcoming: UpcomingDate[] = [];

  for (const p of plans) {
    if (!p.event_date) continue;
    const eventDate = new Date(p.event_date);
    const daysAway = Math.ceil(
      (eventDate.getTime() - now.getTime()) / (1000 * 60 * 60 * 24),
    );
    if (daysAway > 0 && daysAway <= 90) {
      upcoming.push({
        title: p.title,
        date: p.event_date,
        daysAway,
        recipientName: p.recipient_name ?? undefined,
      });
    }
  }

  return upcoming.sort((a, b) => a.daysAway - b.daysAway);
}

function getCurrentSeason(): string {
  const month = new Date().getMonth();
  if (month >= 2 && month <= 4) return "spring";
  if (month >= 5 && month <= 7) return "summer";
  if (month >= 8 && month <= 10) return "autumn";
  return "winter";
}

/**
 * Auto-detect Surprise DNA from user's planning history.
 * Called periodically to update the user's planning profile.
 */
export async function detectAndUpdateSurpriseDNA(): Promise<SurpriseDNA | null> {
  const userId = await getCurrentUserId();
  if (!userId) return null;

  const plans = await fetchUserPlans(userId);
  if (plans.length < 2) return null; // Need at least 2 plans to detect patterns

  const budgets = plans.filter((p) => p.budget).map((p) => p.budget as number);
  const avgBudget =
    budgets.length > 0
      ? budgets.reduce((a, b) => a + b, 0) / budgets.length
      : 0;
  const guestCounts = plans
    .filter((p) => p.guest_count)
    .map((p) => p.guest_count as number);
  const avgGuestCount =
    guestCounts.length > 0
      ? Math.round(guestCounts.reduce((a, b) => a + b, 0) / guestCounts.length)
      : 2;

  // Detect planning style based on how early plans are created before event
  const leadTimes = plans
    .filter((p) => p.event_date)
    .map((p) => {
      const created = p.created_at ? new Date(p.created_at) : new Date();
      const event = new Date(p.event_date!);
      return Math.ceil(
        (event.getTime() - created.getTime()) / (1000 * 60 * 60 * 24),
      );
    })
    .filter((d) => d > 0);

  const avgLeadTime =
    leadTimes.length > 0
      ? leadTimes.reduce((a, b) => a + b, 0) / leadTimes.length
      : 7;

  const planningStyle: SurpriseDNA["planningStyle"] =
    avgLeadTime <= 3
      ? "spontaneous"
      : avgLeadTime >= 14
        ? "meticulous"
        : "balanced";

  const budgetTendency: SurpriseDNA["budgetTendency"] =
    avgBudget <= 500
      ? "budget_conscious"
      : avgBudget >= 3000
        ? "generous"
        : "moderate";

  const surpriseScale: SurpriseDNA["surpriseScale"] =
    avgGuestCount <= 2 ? "intimate" : avgGuestCount >= 10 ? "grand" : "medium";

  // Detect preferred categories
  const categoryCounts: Record<string, number> = {};
  for (const p of plans) {
    const cat = (p as PlanWithScenario).scenario?.category?.slug;
    if (cat) categoryCounts[cat] = (categoryCounts[cat] || 0) + 1;
  }
  const preferredCategories = Object.entries(categoryCounts)
    .sort((a, b) => b[1] - a[1])
    .slice(0, 3)
    .map(([slug]) => slug);

  const dna: SurpriseDNA = {
    planningStyle,
    budgetTendency,
    surpriseScale,
    creativityLevel: "creative", // Default, can be set manually
    preferredCategories,
    avgBudget: Math.round(avgBudget),
    avgGuestCount,
    preferredDayOfWeek: null,
    indoorOutdoorPreference: "both",
  };

  // Save to profile preferences
  const { data: profile } = await supabase
    .from("profiles")
    .select("preferences")
    .eq("id", userId)
    .single();

  const currentPrefs = (profile?.preferences || {}) as Record<string, unknown>;
  await supabase
    .from("profiles")
    .update({
      preferences: { ...currentPrefs, surpriseDna: dna },
      updated_at: new Date().toISOString(),
    })
    .eq("id", userId);

  return dna;
}
