import { supabase } from './supabase';
import type { User } from '@supabase/supabase-js';

/**
 * Get the currently authenticated user.
 * Throws if no user is logged in.
 */
export async function getCurrentUser(): Promise<User> {
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) throw new Error('Not authenticated');
  return user;
}

/**
 * Get the current user ID, or null if not authenticated.
 * Use this for non-critical operations that should silently skip
 * when no user is logged in.
 */
export async function getCurrentUserId(): Promise<string | null> {
  try {
    const { data: { user } } = await supabase.auth.getUser();
    return user?.id ?? null;
  } catch {
    return null;
  }
}
