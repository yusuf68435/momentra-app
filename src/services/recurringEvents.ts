import { supabase } from "./supabase";
import { getCurrentUser, getCurrentUserId } from "./helpers";

// ==========================================
// TYPES
// ==========================================

export interface RecurringEvent {
  id: string;
  user_id: string;
  person_name: string;
  date_month: number;
  date_day: number;
  date_type: RecurringDateType;
  year_started: number | null;
  is_recurring: boolean;
  notify_days_before: number;
  notes: string | null;
  last_celebrated_year: number | null;
  auto_create_plan: boolean;
  created_at: string;
  updated_at: string;
}

export type RecurringDateType =
  | "birthday"
  | "anniversary"
  | "graduation"
  | "valentines"
  | "mothers_day"
  | "fathers_day"
  | "holiday"
  | "other";

export interface UpcomingRecurringEvent extends RecurringEvent {
  days_until: number;
  next_date: string;
  years_since: number | null;
}

// ==========================================
// RECURRING EVENT FUNCTIONS
// ==========================================

export async function createRecurring(data: {
  person_name: string;
  date_month: number;
  date_day: number;
  date_type: RecurringDateType;
  year_started?: number;
  notify_days_before?: number;
  notes?: string;
  auto_create_plan?: boolean;
}): Promise<RecurringEvent> {
  const user = await getCurrentUser();

  const { data: result, error } = await supabase
    .from("important_dates")
    .insert({
      user_id: user.id,
      person_name: data.person_name,
      date_month: data.date_month,
      date_day: data.date_day,
      date_type: data.date_type,
      year_started: data.year_started || null,
      is_recurring: true,
      notify_days_before: data.notify_days_before ?? 7,
      notes: data.notes || null,
      auto_create_plan: data.auto_create_plan ?? false,
    })
    .select()
    .single();

  if (error) throw error;
  return result;
}

export async function getRecurringEvents(): Promise<RecurringEvent[]> {
  const userId = await getCurrentUserId();
  if (!userId) return [];

  const { data, error } = await supabase
    .from("important_dates")
    .select("*")
    .eq("user_id", userId)
    .eq("is_recurring", true)
    .order("date_month")
    .order("date_day");

  if (error) {
    if (__DEV__) {
      console.warn("Failed to fetch recurring events:", error);
    }
    return [];
  }
  return data || [];
}

export async function updateRecurring(
  id: string,
  updates: Partial<
    Pick<
      RecurringEvent,
      | "person_name"
      | "date_month"
      | "date_day"
      | "date_type"
      | "year_started"
      | "notify_days_before"
      | "notes"
      | "auto_create_plan"
      | "last_celebrated_year"
    >
  >,
): Promise<RecurringEvent> {
  const user = await getCurrentUser();

  const { data, error } = await supabase
    .from("important_dates")
    .update({ ...updates, updated_at: new Date().toISOString() })
    .eq("id", id)
    .eq("user_id", user.id)
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function deleteRecurring(id: string): Promise<void> {
  const user = await getCurrentUser();

  const { error } = await supabase
    .from("important_dates")
    .delete()
    .eq("id", id)
    .eq("user_id", user.id);

  if (error) throw error;
}

export async function getUpcomingRecurring(
  daysAhead: number = 30,
): Promise<UpcomingRecurringEvent[]> {
  const events = await getRecurringEvents();
  const today = new Date();
  const currentYear = today.getFullYear();

  return events
    .map((event) => {
      const dateThisYear = new Date(
        currentYear,
        event.date_month - 1,
        event.date_day,
      );
      let nextDate: Date;
      let daysUntil: number;

      if (dateThisYear >= today) {
        nextDate = dateThisYear;
      } else {
        nextDate = new Date(
          currentYear + 1,
          event.date_month - 1,
          event.date_day,
        );
      }

      daysUntil = Math.ceil(
        (nextDate.getTime() - today.getTime()) / (1000 * 60 * 60 * 24),
      );

      const yearsSince = event.year_started
        ? nextDate.getFullYear() - event.year_started
        : null;

      return {
        ...event,
        days_until: daysUntil,
        next_date: nextDate.toISOString().split("T")[0],
        years_since: yearsSince,
      };
    })
    .filter((event) => event.days_until <= daysAhead)
    .sort((a, b) => a.days_until - b.days_until);
}

export async function markAsCelebrated(
  id: string,
  year?: number,
): Promise<RecurringEvent> {
  const celebratedYear = year || new Date().getFullYear();

  const { data, error } = await supabase
    .from("important_dates")
    .update({
      last_celebrated_year: celebratedYear,
      updated_at: new Date().toISOString(),
    })
    .eq("id", id)
    .select()
    .single();

  if (error) throw error;
  return data;
}

// ==========================================
// NOTIFICATION HELPERS
// ==========================================

export function getEventsNeedingReminder(
  events: UpcomingRecurringEvent[],
): UpcomingRecurringEvent[] {
  return events.filter(
    (event) =>
      event.days_until <= event.notify_days_before && event.days_until >= 0,
  );
}

export function formatEventLabel(event: RecurringEvent): string {
  const typeLabels: Record<RecurringDateType, string> = {
    birthday: "Birthday",
    anniversary: "Anniversary",
    graduation: "Graduation",
    valentines: "Valentine's Day",
    mothers_day: "Mother's Day",
    fathers_day: "Father's Day",
    holiday: "Holiday",
    other: "Special Day",
  };

  return `${event.person_name}'s ${typeLabels[event.date_type] || "Special Day"}`;
}
