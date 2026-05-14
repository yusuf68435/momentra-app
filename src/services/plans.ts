import { supabase } from "./supabase";
import type { Plan, ChecklistItem, CompletionData } from "../types/database";
import { getCurrentUser } from "./helpers";

// ==========================================
// PLANS
// ==========================================

export async function fetchUserPlans(): Promise<Plan[]> {
  const user = await getCurrentUser();

  const { data, error } = await supabase
    .from("plans")
    .select(
      "*, scenario:scenarios(*, category:categories(*)), checklist:plan_checklist_items(*)",
    )
    .eq("user_id", user.id)
    .order("created_at", { ascending: false })
    .order("sort_order", { foreignTable: "plan_checklist_items" });

  if (error) throw error;
  return data;
}

export async function fetchPlanById(id: string): Promise<Plan> {
  const user = await getCurrentUser();

  // Try own plan first
  const { data, error } = await supabase
    .from("plans")
    .select(
      "*, scenario:scenarios(*, category:categories(*), steps:scenario_steps(*)), checklist:plan_checklist_items(*)",
    )
    .eq("id", id)
    .order("sort_order", { foreignTable: "plan_checklist_items" })
    .single();

  if (error) throw error;

  // Verify access: owner or accepted co-organizer
  if (data.user_id !== user.id) {
    const { data: coOrg } = await supabase
      .from("co_organizers")
      .select("id")
      .eq("plan_id", id)
      .eq("user_id", user.id)
      .eq("status", "accepted")
      .maybeSingle();

    if (!coOrg) throw new Error("Not authorized to view this plan");
  }

  return data;
}

export async function createPlan(plan: {
  scenario_id?: string;
  title: string;
  event_date?: string;
  event_time?: string;
  recipient_name?: string;
  recipient_relation?: string;
  location_text?: string;
  budget?: number;
  guest_count?: number;
  notes?: string;
  language?: "tr" | "en";
}): Promise<Plan> {
  const user = await getCurrentUser();

  // Remove language (not a DB column), keep everything else
  const { language, ...dbFields } = plan;

  const { data, error } = await supabase
    .from("plans")
    .insert({ ...dbFields, user_id: user.id })
    .select("*, scenario:scenarios(*, category:categories(*))")
    .single();

  if (error) throw error;

  // Auto-create checklist from scenario steps
  if (plan.scenario_id) {
    try {
      const { data: steps } = await supabase
        .from("scenario_steps")
        .select("*")
        .eq("scenario_id", plan.scenario_id)
        .order("step_number");

      if (steps?.length) {
        const lang = plan.language ?? "tr";
        const checklistItems = steps.map((step, idx) => ({
          plan_id: data.id,
          title:
            lang === "en"
              ? step.title_en ||
                step.title_tr ||
                step.title ||
                `Step ${idx + 1}`
              : step.title_tr ||
                step.title ||
                step.title_en ||
                `Adım ${idx + 1}`,
          sort_order: idx,
        }));

        await supabase.from("plan_checklist_items").insert(checklistItems);
      }
    } catch (e) {
      if (__DEV__) {
        console.warn("Failed to create checklist items:", e);
      }
    }
  }

  return fetchPlanById(data.id);
}

export async function updatePlan(
  id: string,
  updates: Partial<
    Pick<
      Plan,
      | "title"
      | "event_date"
      | "event_time"
      | "recipient_name"
      | "recipient_relation"
      | "location_text"
      | "budget"
      | "guest_count"
      | "notes"
      | "status"
      | "customizations"
      | "ai_suggestions"
    >
  >,
): Promise<Plan> {
  const user = await getCurrentUser();

  const { data, error } = await supabase
    .from("plans")
    .update({ ...updates, updated_at: new Date().toISOString() })
    .eq("id", id)
    .eq("user_id", user.id)
    .select("*, scenario:scenarios(*, category:categories(*))")
    .single();

  if (error) throw error;
  return data;
}

export async function deletePlan(id: string): Promise<void> {
  const user = await getCurrentUser();

  const { error } = await supabase
    .from("plans")
    .delete()
    .eq("id", id)
    .eq("user_id", user.id);

  if (error) throw error;
}

// ==========================================
// CHECKLIST (columns: id, plan_id, title, is_completed, sort_order, created_at)
// ==========================================

export async function toggleChecklistItem(
  itemId: string,
  isCompleted: boolean,
): Promise<ChecklistItem> {
  try {
    const { data, error } = await supabase
      .from("plan_checklist_items")
      .update({ is_completed: isCompleted })
      .eq("id", itemId)
      .select()
      .single();

    if (error) throw error;
    return data;
  } catch (err) {
    // Queue for offline retry if network error
    try {
      const { enqueueOperation } = await import("../utils/offlineQueue");
      await enqueueOperation("update", "plan_checklist_items", {
        id: itemId,
        is_completed: isCompleted,
      });
    } catch {
      // offline queue not available, ignore
    }
    throw err;
  }
}

export async function addChecklistItem(
  planId: string,
  item: { title: string },
): Promise<ChecklistItem> {
  // Get max sort_order
  const { data: existing } = await supabase
    .from("plan_checklist_items")
    .select("sort_order")
    .eq("plan_id", planId)
    .order("sort_order", { ascending: false })
    .limit(1);

  const nextOrder = (existing?.[0]?.sort_order ?? -1) + 1;

  const { data, error } = await supabase
    .from("plan_checklist_items")
    .insert({ title: item.title, plan_id: planId, sort_order: nextOrder })
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function deleteChecklistItem(itemId: string): Promise<void> {
  const { error } = await supabase
    .from("plan_checklist_items")
    .delete()
    .eq("id", itemId);
  if (error) throw error;
}

// ==========================================
// PLAN COMPLETION
// ==========================================

export async function completePlan(
  id: string,
  completionData: CompletionData,
): Promise<Plan> {
  const updatePayload: Record<string, unknown> = {
    status: "completed",
    updated_at: new Date().toISOString(),
  };

  // Only set columns that exist in the DB
  if (completionData.rating != null)
    updatePayload.completion_rating = completionData.rating;
  if (completionData.notes)
    updatePayload.completion_notes = completionData.notes;
  if (completionData.photos?.length)
    updatePayload.completion_photos = completionData.photos;
  updatePayload.completed_at = new Date().toISOString();

  updatePayload.completion_data = {
    reactionType: completionData.reactionType,
    memoryEntry: completionData.memoryEntry,
    shareToGallery: completionData.shareToGallery,
  };

  const { data: plan, error } = await supabase
    .from("plans")
    .update(updatePayload)
    .eq("id", id)
    .select("*, scenario:scenarios(*, category:categories(*))")
    .single();

  if (error) throw error;
  return plan;
}
