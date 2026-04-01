/**
 * Feature Flags Store
 *
 * Centralized feature flag system for A/B testing and gradual rollouts.
 *
 * Flags can be:
 *   1. Static defaults (compile-time off/on)
 *   2. Overridden remotely via Supabase `feature_flags` table (future)
 *   3. Overridden locally for testing via setFlag()
 *
 * Usage:
 *   const { flags } = useFeatureFlagsStore();
 *   if (flags.newOnboardingFlow) { ... }
 */

import { create } from "zustand";
import { persist, createJSONStorage } from "zustand/middleware";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { supabase } from "../services/supabase";

// ── Flag definitions ─────────────────────────────────────────────────────────

export interface FeatureFlags {
  /** Use new onboarding flow (A/B test) */
  newOnboardingFlow: boolean;
  /** Show AI-powered scenario suggestions on home screen */
  aiScenarioSuggestions: boolean;
  /** Enable community stories feature */
  communityStories: boolean;
  /** Show vendor directory */
  vendorDirectory: boolean;
  /** Enable push notification countdown reminders */
  countdownNotifications: boolean;
  /** Show gamification badges in profile */
  gamificationBadges: boolean;
  /** Enable budget analytics pie chart */
  budgetAnalytics: boolean;
  /** Show time capsule feature */
  timeCapsule: boolean;
  /** Enable QR invite codes */
  qrInvites: boolean;
  /** Show mood board / inspiration board */
  moodBoard: boolean;
}

// Default flag values (all features enabled by default)
const DEFAULT_FLAGS: FeatureFlags = {
  newOnboardingFlow: false, // A/B test — off by default
  aiScenarioSuggestions: true,
  communityStories: true,
  vendorDirectory: true,
  countdownNotifications: true,
  gamificationBadges: true,
  budgetAnalytics: true,
  timeCapsule: true,
  qrInvites: true,
  moodBoard: true,
};

// ── Store ────────────────────────────────────────────────────────────────────

interface FeatureFlagsState {
  flags: FeatureFlags;
  /** Override a single flag (for testing / remote config) */
  setFlag: (key: keyof FeatureFlags, value: boolean) => void;
  /** Override multiple flags at once (from remote config) */
  setFlags: (overrides: Partial<FeatureFlags>) => void;
  /** Reset all flags to defaults */
  resetFlags: () => void;
}

export const useFeatureFlagsStore = create<FeatureFlagsState>()(
  persist(
    (set) => ({
      flags: DEFAULT_FLAGS,

      setFlag: (key, value) =>
        set((state) => ({
          flags: { ...state.flags, [key]: value },
        })),

      setFlags: (overrides) =>
        set((state) => ({
          flags: { ...state.flags, ...overrides },
        })),

      resetFlags: () => set({ flags: DEFAULT_FLAGS }),
    }),
    {
      name: "momentra-feature-flags",
      storage: createJSONStorage(() => AsyncStorage),
    },
  ),
);

// ── Remote config helper ──────────────────────────────────────────────────────

/** snake_case → camelCase  (e.g. "new_onboarding_flow" → "newOnboardingFlow") */
function snakeToCamel(str: string): string {
  return str.replace(/_([a-z])/g, (_, letter: string) => letter.toUpperCase());
}

/**
 * Fetch global feature flags from Supabase and apply them on top of defaults.
 * Call this once after the user is authenticated.
 * Silently ignores network errors — local defaults remain in effect.
 */
export async function syncFeatureFlagsFromRemote(): Promise<void> {
  try {
    const { data, error } = await supabase
      .from("feature_flags")
      .select("key, enabled");

    if (error || !data) return;

    const overrides: Partial<FeatureFlags> = {};
    for (const row of data) {
      const camelKey = snakeToCamel(row.key) as keyof FeatureFlags;
      if (camelKey in DEFAULT_FLAGS) {
        overrides[camelKey] = row.enabled as boolean;
      }
    }

    if (Object.keys(overrides).length > 0) {
      useFeatureFlagsStore.getState().setFlags(overrides);
    }
  } catch {
    // Silently fall back to locally-persisted / default flags
  }
}
