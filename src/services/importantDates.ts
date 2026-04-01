import { supabase } from "./supabase";
import { getCurrentUser, getCurrentUserId } from "./helpers";
import { DEFAULT_NOTIFY_DAYS, MS_PER_DAY } from "../constants/defaults";

export interface ImportantDate {
  id: string;
  user_id: string;
  person_name: string;
  date_month: number;
  date_day: number;
  date_type: "birthday" | "anniversary" | "graduation" | "other";
  notes: string | null;
  notify_days_before: number;
  created_at: string;
}

export async function fetchImportantDates(): Promise<ImportantDate[]> {
  const userId = await getCurrentUserId();
  if (!userId) return [];

  const { data, error } = await supabase
    .from("important_dates")
    .select("*")
    .eq("user_id", userId)
    .order("date_month")
    .order("date_day");

  if (error) {
    if (__DEV__) {
      console.warn("Failed to fetch important dates:", error);
    }
    return [];
  }
  return data || [];
}

export async function addImportantDate(date: {
  person_name: string;
  date_month: number;
  date_day: number;
  date_type: ImportantDate["date_type"];
  notes?: string;
  notify_days_before?: number;
}): Promise<ImportantDate> {
  const user = await getCurrentUser();

  const { data, error } = await supabase
    .from("important_dates")
    .insert({
      user_id: user.id,
      person_name: date.person_name,
      date_month: date.date_month,
      date_day: date.date_day,
      date_type: date.date_type,
      notes: date.notes || null,
      notify_days_before: date.notify_days_before ?? DEFAULT_NOTIFY_DAYS,
    })
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function updateImportantDate(
  id: string,
  updates: Partial<
    Pick<
      ImportantDate,
      | "person_name"
      | "date_month"
      | "date_day"
      | "date_type"
      | "notes"
      | "notify_days_before"
    >
  >,
): Promise<ImportantDate> {
  const user = await getCurrentUser();
  const { data, error } = await supabase
    .from("important_dates")
    .update(updates)
    .eq("id", id)
    .eq("user_id", user.id)
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function deleteImportantDate(id: string): Promise<void> {
  const user = await getCurrentUser();
  const { error } = await supabase
    .from("important_dates")
    .delete()
    .eq("id", id)
    .eq("user_id", user.id);

  if (error) throw error;
}

/** Maps date types to scenario categories for proactive suggestions. */
const DATE_TYPE_TO_CATEGORIES: Record<ImportantDate["date_type"], string[]> = {
  birthday: ["birthday", "romantic"],
  anniversary: ["anniversary", "romantic"],
  graduation: ["graduation", "achievement"],
  other: ["holiday", "achievement", "romantic"],
};

export interface UpcomingDateWithSuggestion extends ImportantDate {
  daysUntil: number;
  suggestedCategories: string[];
}

/**
 * Returns upcoming dates enriched with suggested scenario categories
 * based on the date type. Used for proactive notifications.
 */
export function getUpcomingDatesWithSuggestions(
  dates: ImportantDate[],
  daysAhead: number = 30,
): UpcomingDateWithSuggestion[] {
  return getUpcomingDates(dates, daysAhead).map((date) => ({
    ...date,
    suggestedCategories: DATE_TYPE_TO_CATEGORIES[date.date_type] || ["other"],
  }));
}

export function getUpcomingDates(
  dates: ImportantDate[],
  daysAhead: number = 30,
): (ImportantDate & { daysUntil: number })[] {
  const today = new Date();

  return dates
    .map((date) => {
      let daysUntil: number;
      const thisYear = today.getFullYear();
      const dateThisYear = new Date(
        thisYear,
        date.date_month - 1,
        date.date_day,
      );

      if (dateThisYear >= today) {
        daysUntil = Math.ceil(
          (dateThisYear.getTime() - today.getTime()) / MS_PER_DAY,
        );
      } else {
        const dateNextYear = new Date(
          thisYear + 1,
          date.date_month - 1,
          date.date_day,
        );
        daysUntil = Math.ceil(
          (dateNextYear.getTime() - today.getTime()) / MS_PER_DAY,
        );
      }

      return { ...date, daysUntil };
    })
    .filter((date) => date.daysUntil <= daysAhead)
    .sort((a, b) => a.daysUntil - b.daysUntil);
}
