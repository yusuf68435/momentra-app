import { supabase } from './supabase';
import { getCurrentUserId } from './helpers';

// ── Types ────────────────────────────────────────────────────────────

export interface GamificationData {
  user_id: string;
  level: number;
  xp: number;
  total_xp: number;
  total_plans: number;
  completed_plans: number;
  total_surprises: number;
  ai_used: number;
  unique_recipients: number;
}

// ── Fetch user's gamification data ───────────────────────────────────

export async function fetchGamification(): Promise<GamificationData | null> {
  try {
    const userId = await getCurrentUserId();
    if (!userId) return null;

    const { data, error } = await supabase
      .from('user_gamification')
      .select('*')
      .eq('user_id', userId)
      .single();

    if (error) {
      if (__DEV__) {
        console.warn('fetchGamification error:', error.message);
      }
      return null;
    }

    return data as GamificationData;
  } catch (err) {
    if (__DEV__) {
      console.warn('fetchGamification failed:', err);
    }
    return null;
  }
}

// ── Initialize gamification for new user (upsert) ────────────────────

export async function initializeGamification(): Promise<void> {
  try {
    const userId = await getCurrentUserId();
    if (!userId) return;

    const { error } = await supabase
      .from('user_gamification')
      .upsert({
        user_id: userId,
        level: 1,
        xp: 0,
        total_xp: 0,
        total_plans: 0,
        completed_plans: 0,
        total_surprises: 0,
        ai_used: 0,
        unique_recipients: 0,
      });

    if (error) {
      if (__DEV__) {
        console.warn('initializeGamification error:', error.message);
      }
    }
  } catch (err) {
    if (__DEV__) {
      console.warn('initializeGamification failed:', err);
    }
  }
}

// ── Add XP using the RPC function ────────────────────────────────────

export async function addXpRemote(amount: number, reason: string): Promise<void> {
  try {
    const userId = await getCurrentUserId();
    if (!userId) return;

    const { error } = await supabase.rpc('add_user_xp', {
      p_user_id: userId,
      p_amount: amount,
      p_reason: reason,
    });

    if (error) {
      if (__DEV__) {
        console.warn('addXpRemote error:', error.message);
      }
    }
  } catch (err) {
    if (__DEV__) {
      console.warn('addXpRemote failed:', err);
    }
  }
}

// ── Fetch user badges ────────────────────────────────────────────────

export async function fetchBadges(): Promise<{ badge_slug: string; unlocked_at: string }[]> {
  try {
    const userId = await getCurrentUserId();
    if (!userId) return [];

    const { data, error } = await supabase
      .from('user_badges')
      .select('badge_slug, unlocked_at')
      .eq('user_id', userId);

    if (error) {
      if (__DEV__) {
        console.warn('fetchBadges error:', error.message);
      }
      return [];
    }

    return data ?? [];
  } catch (err) {
    if (__DEV__) {
      console.warn('fetchBadges failed:', err);
    }
    return [];
  }
}

// ── Award a badge ────────────────────────────────────────────────────

export async function awardBadge(badgeSlug: string): Promise<boolean> {
  try {
    const userId = await getCurrentUserId();
    if (!userId) return false;

    const { error } = await supabase
      .from('user_badges')
      .insert({ user_id: userId, badge_slug: badgeSlug })
      .select()
      .single();

    if (error) {
      // Conflict means badge already exists
      if (__DEV__) {
        console.warn('awardBadge error (may be duplicate):', error.message);
      }
      return false;
    }

    return true;
  } catch (err) {
    if (__DEV__) {
      console.warn('awardBadge failed:', err);
    }
    return false;
  }
}

// ── Sync stats ───────────────────────────────────────────────────────

export async function syncStats(stats: {
  total_plans: number;
  completed_plans: number;
  total_surprises: number;
  ai_used: number;
  unique_recipients: number;
}): Promise<void> {
  try {
    const userId = await getCurrentUserId();
    if (!userId) return;

    const { error } = await supabase
      .from('user_gamification')
      .update({
        total_plans: stats.total_plans,
        completed_plans: stats.completed_plans,
        total_surprises: stats.total_surprises,
        ai_used: stats.ai_used,
        unique_recipients: stats.unique_recipients,
      })
      .eq('user_id', userId);

    if (error) {
      if (__DEV__) {
        console.warn('syncStats error:', error.message);
      }
    }
  } catch (err) {
    if (__DEV__) {
      console.warn('syncStats failed:', err);
    }
  }
}
