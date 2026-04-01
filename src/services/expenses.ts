import { supabase } from "./supabase";
import { getCurrentUser } from "./helpers";
import { sanitizeInput, stripHtmlTags } from "../utils/crypto";

export interface Expense {
  id: string;
  plan_id: string;
  name: string;
  amount: number;
  category:
    | "gift"
    | "food"
    | "decoration"
    | "venue"
    | "entertainment"
    | "transport"
    | "other";
  is_paid: boolean;
  paid_by: string | null;
  notes: string | null;
  created_at: string;
}

/** Verify user owns the plan (or is a co-organizer). */
async function verifyPlanAccess(planId: string, userId: string): Promise<void> {
  const { data: plan } = await supabase
    .from("plans")
    .select("user_id")
    .eq("id", planId)
    .single();

  if (plan?.user_id === userId) return;

  // Check co-organizer access
  const { data: coOrg } = await supabase
    .from("co_organizers")
    .select("id")
    .eq("plan_id", planId)
    .eq("user_id", userId)
    .eq("status", "accepted")
    .maybeSingle();

  if (!coOrg) throw new Error("Not authorized to access this plan's expenses");
}

export async function fetchExpenses(planId: string): Promise<Expense[]> {
  const user = await getCurrentUser();
  await verifyPlanAccess(planId, user.id);

  const { data, error } = await supabase
    .from("plan_expenses")
    .select("*")
    .eq("plan_id", planId)
    .order("created_at", { ascending: false });

  if (error) throw error;
  return data || [];
}

export async function addExpense(
  planId: string,
  expense: {
    name: string;
    amount: number;
    category: Expense["category"];
    is_paid?: boolean;
    notes?: string;
  },
): Promise<Expense> {
  const user = await getCurrentUser();
  await verifyPlanAccess(planId, user.id);

  const safeName = stripHtmlTags(sanitizeInput(expense.name, 200));
  const safeNotes = expense.notes
    ? stripHtmlTags(sanitizeInput(expense.notes, 500))
    : null;

  const { data, error } = await supabase
    .from("plan_expenses")
    .insert({
      plan_id: planId,
      name: safeName,
      amount: expense.amount,
      category: expense.category,
      is_paid: expense.is_paid ?? false,
      paid_by: user.id,
      notes: safeNotes,
    })
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function updateExpense(
  id: string,
  updates: Partial<
    Pick<Expense, "name" | "amount" | "category" | "is_paid" | "notes">
  >,
): Promise<Expense> {
  const user = await getCurrentUser();

  // Verify ownership through plan
  const { data: expense } = await supabase
    .from("plan_expenses")
    .select("plan_id")
    .eq("id", id)
    .single();

  if (expense) await verifyPlanAccess(expense.plan_id, user.id);

  const sanitized: Record<string, unknown> = { ...updates };
  if (updates.name)
    sanitized.name = stripHtmlTags(sanitizeInput(updates.name, 200));
  if (updates.notes)
    sanitized.notes = stripHtmlTags(sanitizeInput(updates.notes, 500));

  const { data, error } = await supabase
    .from("plan_expenses")
    .update(sanitized)
    .eq("id", id)
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function deleteExpense(id: string): Promise<void> {
  const user = await getCurrentUser();

  // Verify ownership through plan
  const { data: expense } = await supabase
    .from("plan_expenses")
    .select("plan_id")
    .eq("id", id)
    .single();

  if (expense) await verifyPlanAccess(expense.plan_id, user.id);

  const { error } = await supabase.from("plan_expenses").delete().eq("id", id);

  if (error) throw error;
}

export function getExpenseSummary(expenses: Expense[]) {
  const total = expenses.reduce((sum, e) => sum + e.amount, 0);
  const paid = expenses
    .filter((e) => e.is_paid)
    .reduce((sum, e) => sum + e.amount, 0);
  const unpaid = total - paid;

  const byCategory = expenses.reduce(
    (acc, e) => {
      acc[e.category] = (acc[e.category] || 0) + e.amount;
      return acc;
    },
    {} as Record<string, number>,
  );

  return { total, paid, unpaid, byCategory };
}
