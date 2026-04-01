/**
 * Zustand Selector Hooks
 *
 * Optimized selectors that subscribe to individual state slices,
 * preventing unnecessary re-renders when unrelated state changes.
 *
 * Usage:
 *   // Instead of:
 *   const { language } = useSettingsStore();        // re-renders on ANY settings change
 *
 *   // Use:
 *   const language = useLanguage();                 // re-renders ONLY when language changes
 */

import { useSettingsStore } from './settingsStore';
import { useAuthStore } from './authStore';
import { useGamificationStore } from './gamificationStore';
import { useScenarioStore } from './scenarioStore';
import { useFavoriteStore } from './favoriteStore';

// ── Settings Selectors ───────────────────────────────────────────────

export const useLanguage = () => useSettingsStore((s) => s.language);
export const useIsDarkMode = () => useSettingsStore((s) => s.isDarkMode);
export const useCurrency = () => useSettingsStore((s) => s.currency);
export const useSubscriptionPlan = () => useSettingsStore((s) => s.subscriptionPlan);
export const useNotificationsEnabled = () => useSettingsStore((s) => s.notificationsEnabled);
export const useNotificationPreferences = () => useSettingsStore((s) => s.notificationPreferences);
export const useHasSeenOnboarding = () => useSettingsStore((s) => s.hasSeenOnboarding);
export const useFavoriteCategories = () => useSettingsStore((s) => s.favoriteCategories);

// ── Auth Selectors ───────────────────────────────────────────────────

export const useUser = () => useAuthStore((s) => s.user);
export const useIsAuthenticated = () => useAuthStore((s) => s.isAuthenticated);
export const useProfile = () => useAuthStore((s) => s.profile);
export const useAuthLoading = () => useAuthStore((s) => s.isLoading);
export const useAuthError = () => useAuthStore((s) => s.error);

// ── Gamification Selectors ───────────────────────────────────────────

export const useLevel = () => useGamificationStore((s) => s.level);
export const useXp = () => useGamificationStore((s) => s.xp);
export const useTotalXp = () => useGamificationStore((s) => s.totalXp);
export const useBadges = () => useGamificationStore((s) => s.badges);
export const useGamificationStats = () => useGamificationStore((s) => s.stats);

// ── Scenario Selectors ───────────────────────────────────────────────

export const useScenarios = () => useScenarioStore((s) => s.scenarios);
export const useCategories = () => useScenarioStore((s) => s.categories);
export const useFeaturedScenarios = () => useScenarioStore((s) => s.featuredScenarios);
export const useCurrentScenario = () => useScenarioStore((s) => s.currentScenario);
export const useScenarioFilters = () => useScenarioStore((s) => s.filters);
export const useScenarioLoading = () => useScenarioStore((s) => s.isLoading);

// ── Favorite Selectors ───────────────────────────────────────────────

export const useFavoriteIds = () => useFavoriteStore((s) => s.favoriteIds);
export const useFavoriteLoading = () => useFavoriteStore((s) => s.isLoading);
