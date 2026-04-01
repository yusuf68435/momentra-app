import { supabase } from "./supabase";
import type { Scenario, Category } from "../types/database";
import { DEFAULT_PAGE_LIMIT } from "../constants/defaults";
import { sanitizeQueryParam } from "../utils/crypto";

// ==========================================
// CATEGORIES
// ==========================================

export async function fetchCategories(): Promise<Category[]> {
  const { data, error } = await supabase
    .from("categories")
    .select("*")
    .order("sort_order");

  if (error) throw error;
  return data;
}

// ==========================================
// SCENARIOS
// ==========================================

export async function fetchScenarios(params?: {
  categoryId?: string;
  budgetMin?: number;
  budgetMax?: number;
  peopleCount?: number;
  indoorOutdoor?: string;
  difficulty?: number;
  search?: string;
  isFeatured?: boolean;
  isPremium?: boolean;
  limit?: number;
  offset?: number;
}): Promise<Scenario[]> {
  let query = supabase.from("scenarios").select("*, category:categories(*)");

  if (params?.categoryId) {
    query = query.eq("category_id", params.categoryId);
  }
  if (params?.budgetMin != null) {
    query = query.gte("min_budget", params.budgetMin);
  }
  if (params?.budgetMax != null) {
    query = query.lte("max_budget", params.budgetMax);
  }
  if (params?.peopleCount != null) {
    query = query.lte("min_people", params.peopleCount);
  }
  if (params?.indoorOutdoor && params.indoorOutdoor !== "both") {
    query = query.in("indoor_outdoor", [params.indoorOutdoor, "both"]);
  }
  if (params?.difficulty != null) {
    query = query.lte("difficulty", params.difficulty);
  }
  if (params?.search) {
    const sanitized = sanitizeQueryParam(params.search);
    query = query.or(
      `title_tr.ilike.%${sanitized}%,title_en.ilike.%${sanitized}%`,
    );
  }
  if (params?.isFeatured != null) {
    query = query.eq("is_featured", params.isFeatured);
  }
  if (params?.isPremium != null) {
    query = query.eq("is_premium", params.isPremium);
  }

  query = query
    .order("is_featured", { ascending: false })
    .order("rating_avg", { ascending: false });

  if (params?.limit) {
    query = query.limit(params.limit);
  }
  if (params?.offset) {
    query = query.range(
      params.offset,
      params.offset + (params?.limit ?? DEFAULT_PAGE_LIMIT) - 1,
    );
  }

  const { data, error } = await query;
  if (error) throw error;
  return data;
}

export async function fetchScenarioById(id: string): Promise<Scenario> {
  const { data, error } = await supabase
    .from("scenarios")
    .select(
      "*, category:categories(*), steps:scenario_steps(*), images:scenario_images(*)",
    )
    .eq("id", id)
    .order("step_number", { foreignTable: "scenario_steps" })
    .order("sort_order", { foreignTable: "scenario_images" })
    .single();

  if (error) throw error;
  return data;
}

export async function fetchScenarioBySlug(slug: string): Promise<Scenario> {
  const { data, error } = await supabase
    .from("scenarios")
    .select(
      "*, category:categories(*), steps:scenario_steps(*), images:scenario_images(*)",
    )
    .eq("slug", slug)
    .order("step_number", { foreignTable: "scenario_steps" })
    .order("sort_order", { foreignTable: "scenario_images" })
    .single();

  if (error) throw error;
  return data;
}

export async function fetchFeaturedScenarios(): Promise<Scenario[]> {
  return fetchScenarios({ isFeatured: true, limit: 10 });
}

export async function fetchScenariosByCategory(
  categorySlug: string,
): Promise<Scenario[]> {
  const { data: category } = await supabase
    .from("categories")
    .select("id")
    .eq("slug", categorySlug)
    .maybeSingle();

  if (!category) return [];
  return fetchScenarios({ categoryId: category.id });
}

export async function incrementViewCount(scenarioId: string): Promise<void> {
  await supabase.rpc("increment_view_count", { scenario_id: scenarioId });
}
