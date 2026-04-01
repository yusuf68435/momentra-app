import { supabase } from "./supabase";
import { getCurrentUser } from "./helpers";

// ==========================================
// TYPES
// ==========================================

export interface TimelineItem {
  id: string;
  plan_id: string;
  user_id: string;
  title: string;
  description: string | null;
  due_date: string | null;
  is_completed: boolean;
  completed_at: string | null;
  priority: "low" | "medium" | "high" | "urgent";
  category:
    | "preparation"
    | "shopping"
    | "decoration"
    | "coordination"
    | "logistics"
    | "other";
  sort_order: number;
  created_at: string;
  updated_at: string;
}

export interface TimelineSuggestion {
  title: string;
  description: string;
  days_before: number;
  priority: TimelineItem["priority"];
  category: TimelineItem["category"];
}

// ==========================================
// TIMELINE FUNCTIONS
// ==========================================

export async function generateTimeline(plan: {
  id: string;
  title: string;
  event_date?: string | null;
  recipient_name?: string | null;
  recipient_relation?: string | null;
  budget?: number | null;
  guest_count?: number | null;
  notes?: string | null;
}): Promise<TimelineItem[]> {
  const user = await getCurrentUser();

  try {
    // Call edge function for AI-powered timeline suggestions
    const { data: suggestions, error: fnError } =
      await supabase.functions.invoke("generate-timeline", {
        body: {
          plan_title: plan.title,
          event_date: plan.event_date,
          recipient_name: plan.recipient_name,
          recipient_relation: plan.recipient_relation,
          budget: plan.budget,
          guest_count: plan.guest_count,
          notes: plan.notes,
        },
      });

    if (fnError) {
      if (__DEV__) {
        console.warn("Edge function error, using default timeline:", fnError);
      }
      return createDefaultTimeline(plan.id, user.id, plan.event_date);
    }

    const items: TimelineSuggestion[] = suggestions?.items || [];

    if (items.length === 0) {
      return createDefaultTimeline(plan.id, user.id, plan.event_date);
    }

    const timelineItems = items.map((item, idx) => ({
      plan_id: plan.id,
      user_id: user.id,
      title: item.title,
      description: item.description,
      due_date:
        plan.event_date && item.days_before != null
          ? subtractDays(plan.event_date, item.days_before)
          : null,
      is_completed: false,
      priority: item.priority,
      category: item.category,
      sort_order: idx,
    }));

    const { data, error } = await supabase
      .from("smart_timelines")
      .insert(timelineItems)
      .select();

    if (error) throw error;
    return data || [];
  } catch (err) {
    if (__DEV__) {
      console.warn("generateTimeline error:", err);
    }
    return createDefaultTimeline(plan.id, user.id, plan.event_date);
  }
}

export async function getTimeline(planId: string): Promise<TimelineItem[]> {
  const { data, error } = await supabase
    .from("smart_timelines")
    .select("*")
    .eq("plan_id", planId)
    .order("sort_order");

  if (error) throw error;
  return data || [];
}

export async function updateTimelineItem(
  id: string,
  updates: Partial<
    Pick<
      TimelineItem,
      | "title"
      | "description"
      | "due_date"
      | "is_completed"
      | "priority"
      | "category"
    >
  >,
): Promise<TimelineItem> {
  const updateData: Record<string, unknown> = {
    ...updates,
    updated_at: new Date().toISOString(),
  };

  if (updates.is_completed !== undefined) {
    updateData.completed_at = updates.is_completed
      ? new Date().toISOString()
      : null;
  }

  const { data, error } = await supabase
    .from("smart_timelines")
    .update(updateData)
    .eq("id", id)
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function addTimelineItem(
  planId: string,
  item: {
    title: string;
    description?: string;
    due_date?: string;
    priority?: TimelineItem["priority"];
    category?: TimelineItem["category"];
  },
): Promise<TimelineItem | null> {
  const user = await getCurrentUser();

  const { data: existing } = await supabase
    .from("smart_timelines")
    .select("sort_order")
    .eq("plan_id", planId)
    .order("sort_order", { ascending: false })
    .limit(1)
    .maybeSingle();

  const nextSortOrder = existing ? (existing.sort_order as number) + 1 : 0;

  const { data, error } = await supabase
    .from("smart_timelines")
    .insert({
      plan_id: planId,
      user_id: user.id,
      title: item.title,
      description: item.description ?? null,
      due_date: item.due_date ?? null,
      is_completed: false,
      priority: item.priority ?? "medium",
      category: item.category ?? "other",
      sort_order: nextSortOrder,
    })
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function deleteTimelineItem(id: string): Promise<void> {
  const { error } = await supabase
    .from("smart_timelines")
    .delete()
    .eq("id", id);

  if (error) throw error;
}

export async function reorderTimeline(
  items: { id: string; sort_order: number }[],
): Promise<void> {
  const updates = items.map((item) =>
    supabase
      .from("smart_timelines")
      .update({
        sort_order: item.sort_order,
        updated_at: new Date().toISOString(),
      })
      .eq("id", item.id),
  );

  await Promise.all(updates);
}

// ==========================================
// HELPERS
// ==========================================

async function createDefaultTimeline(
  planId: string,
  userId: string,
  eventDate?: string | null,
): Promise<TimelineItem[]> {
  const defaults: TimelineSuggestion[] = [
    {
      title: "Set budget and plan outline",
      description: "Decide on budget, theme, and general plan",
      days_before: 30,
      priority: "high",
      category: "preparation",
    },
    {
      title: "Book venue or location",
      description: "Reserve the venue or confirm location details",
      days_before: 21,
      priority: "high",
      category: "logistics",
    },
    {
      title: "Send invitations",
      description: "Invite guests and track RSVPs",
      days_before: 14,
      priority: "high",
      category: "coordination",
    },
    {
      title: "Order decorations",
      description: "Purchase or order decorations and supplies",
      days_before: 10,
      priority: "medium",
      category: "shopping",
    },
    {
      title: "Finalize menu and catering",
      description: "Confirm food, drinks, and catering arrangements",
      days_before: 7,
      priority: "medium",
      category: "logistics",
    },
    {
      title: "Buy gifts",
      description: "Purchase and wrap gifts",
      days_before: 5,
      priority: "medium",
      category: "shopping",
    },
    {
      title: "Confirm guest count",
      description: "Follow up on pending RSVPs and finalize count",
      days_before: 3,
      priority: "high",
      category: "coordination",
    },
    {
      title: "Set up decorations",
      description: "Decorate the venue or location",
      days_before: 1,
      priority: "urgent",
      category: "decoration",
    },
    {
      title: "Final rehearsal",
      description: "Run through the plan one last time",
      days_before: 0,
      priority: "urgent",
      category: "coordination",
    },
  ];

  const items = defaults.map((item, idx) => ({
    plan_id: planId,
    user_id: userId,
    title: item.title,
    description: item.description,
    due_date: eventDate ? subtractDays(eventDate, item.days_before) : null,
    is_completed: false,
    priority: item.priority,
    category: item.category,
    sort_order: idx,
  }));

  const { data, error } = await supabase
    .from("smart_timelines")
    .insert(items)
    .select();

  if (error) {
    if (__DEV__) {
      console.warn("Failed to create default timeline:", error);
    }
    return [];
  }
  return data || [];
}

function subtractDays(dateStr: string, days: number): string {
  const date = new Date(dateStr);
  date.setDate(date.getDate() - days);
  return date.toISOString().split("T")[0];
}
