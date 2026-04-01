import { supabase } from "./supabase";
import type { Profile } from "../types/database";
import { getCurrentUser, getCurrentUserId } from "./helpers";
import { NO_ROWS_ERROR_CODE } from "../constants/defaults";

// ==========================================
// AUTH
// ==========================================

export async function signUp(
  email: string,
  password: string,
  displayName: string,
) {
  const { data, error } = await supabase.auth.signUp({
    email,
    password,
    options: {
      data: { display_name: displayName },
    },
  });

  if (error) throw error;
  return data;
}

export async function signIn(email: string, password: string) {
  const { data, error } = await supabase.auth.signInWithPassword({
    email,
    password,
  });

  if (error) throw error;
  return data;
}

export async function signOut() {
  const { error } = await supabase.auth.signOut();
  if (error) throw error;
}

export async function resetPassword(email: string) {
  // Always silently succeed — never reveal whether the email exists (prevents enumeration)
  await supabase.auth.resetPasswordForEmail(email);
}

export async function getCurrentSession() {
  const { data, error } = await supabase.auth.getSession();
  if (error) throw error;
  return data.session;
}

// ==========================================
// PROFILE
// ==========================================

export async function fetchProfile(): Promise<Profile | null> {
  const userId = await getCurrentUserId();
  if (!userId) return null;

  const { data, error } = await supabase
    .from("profiles")
    .select("*")
    .eq("id", userId)
    .single();

  if (error) throw error;
  return data;
}

export async function updateProfile(
  updates: Partial<
    Pick<
      Profile,
      | "display_name"
      | "avatar_url"
      | "language"
      | "currency"
      | "timezone"
      | "onboarding_completed"
      | "preferences"
    >
  >,
): Promise<Profile> {
  const user = await getCurrentUser();

  const { data, error } = await supabase
    .from("profiles")
    .update({ ...updates, updated_at: new Date().toISOString() })
    .eq("id", user.id)
    .select()
    .single();

  if (error) throw error;
  return data;
}

// ==========================================
// ACCOUNT DELETION (KVKK/GDPR)
// ==========================================

export async function deleteAccount(): Promise<void> {
  const { data, error } = await supabase.functions.invoke("delete-account");

  if (error) throw error;
  if (data?.error) throw new Error(data.error);

  // Sign out locally after successful deletion
  await supabase.auth.signOut();
}

// ==========================================
// SUBSCRIPTION
// ==========================================

export async function fetchSubscription() {
  const userId = await getCurrentUserId();
  if (!userId) return null;

  const { data, error } = await supabase
    .from("subscriptions")
    .select("*")
    .eq("user_id", userId)
    .eq("is_active", true)
    .single();

  if (error && error.code !== NO_ROWS_ERROR_CODE) throw error;
  return data;
}
