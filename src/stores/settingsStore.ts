import { create } from "zustand";
import { persist, createJSONStorage } from "zustand/middleware";
import AsyncStorage from "@react-native-async-storage/async-storage";
import type { SupportedLanguage } from "../constants/config";
import type { Profile } from "../types/database";

export type ThemeMode = "system" | "light" | "dark";

export type SubscriptionPlan = "free" | "plus" | "pro";

interface NotificationPreferences {
  planReminders: boolean;
  countdownAlerts: boolean;
  aiSuggestions: boolean;
  newScenarios: boolean;
  promotions: boolean;
  proactiveSuggestions: boolean;
}

interface SettingsState {
  language: SupportedLanguage;
  isDarkMode: boolean;
  themeMode: ThemeMode;
  notificationsEnabled: boolean;
  notificationPreferences: NotificationPreferences;
  currency: "TRY" | "USD" | "EUR";
  subscriptionPlan: SubscriptionPlan;
  hasSeenOnboarding: boolean;
  favoriteCategories: string[];
  firstSurpriseCompleted: boolean;
  setLanguage: (language: SupportedLanguage) => void;
  setDarkMode: (isDark: boolean) => void;
  setThemeMode: (mode: ThemeMode) => void;
  setNotificationsEnabled: (enabled: boolean) => void;
  setNotificationPreference: (
    key: keyof NotificationPreferences,
    value: boolean,
  ) => void;
  setCurrency: (currency: "TRY" | "USD" | "EUR") => void;
  setSubscriptionPlan: (plan: SubscriptionPlan) => void;
  setHasSeenOnboarding: (seen: boolean) => void;
  setFavoriteCategories: (categories: string[]) => void;
  setFirstSurpriseCompleted: (completed: boolean) => void;
  hydrateFromProfile: (profile: Profile) => void;
  syncToProfile: () => {
    language: SupportedLanguage;
    currency: "TRY" | "USD" | "EUR";
  };
  syncSubscriptionFromRevenueCat: () => Promise<void>;
}

export const useSettingsStore = create<SettingsState>()(
  persist(
    (set, get) => ({
      language: "tr",
      isDarkMode: false,
      themeMode: "system" as ThemeMode,
      notificationsEnabled: true,
      notificationPreferences: {
        planReminders: true,
        countdownAlerts: true,
        aiSuggestions: true,
        newScenarios: false,
        promotions: false,
        proactiveSuggestions: true,
      },
      currency: "TRY",
      subscriptionPlan: "free",
      hasSeenOnboarding: false,
      favoriteCategories: [],
      firstSurpriseCompleted: false,
      setLanguage: (language) => set({ language }),
      setDarkMode: (isDarkMode) => set({ isDarkMode }),
      setThemeMode: (themeMode) => set({ themeMode }),
      setNotificationsEnabled: (notificationsEnabled) =>
        set({ notificationsEnabled }),
      setNotificationPreference: (key, value) =>
        set((state) => ({
          notificationPreferences: {
            ...state.notificationPreferences,
            [key]: value,
          },
        })),
      setCurrency: (currency) => set({ currency }),
      setSubscriptionPlan: (subscriptionPlan) => set({ subscriptionPlan }),
      setHasSeenOnboarding: (hasSeenOnboarding) => set({ hasSeenOnboarding }),
      setFavoriteCategories: (favoriteCategories) =>
        set({ favoriteCategories }),
      setFirstSurpriseCompleted: (firstSurpriseCompleted) =>
        set({ firstSurpriseCompleted }),
      hydrateFromProfile: (profile) => {
        const updates: Partial<SettingsState> = {};
        if (profile.language) {
          updates.language = profile.language as SupportedLanguage;
        }
        if (profile.currency) {
          updates.currency = profile.currency as "TRY" | "USD" | "EUR";
        }
        if (Object.keys(updates).length > 0) {
          set(updates);
        }
      },
      syncToProfile: () => {
        const state = get();
        return {
          language: state.language,
          currency: state.currency,
        };
      },
      syncSubscriptionFromRevenueCat: async () => {
        // DEV: Force pro for testing
        if (__DEV__) {
          set({ subscriptionPlan: "pro" });
          return;
        }
        try {
          const { checkSubscriptionStatus, isPurchasesConfigured } =
            await import("../services/purchases");
          if (!isPurchasesConfigured()) return;
          const status = await checkSubscriptionStatus();
          if (status.isActive) {
            set({ subscriptionPlan: status.plan });
          } else {
            set({ subscriptionPlan: "free" });
          }
        } catch (error) {
          if (__DEV__) {
            console.error(
              "[SettingsStore] Failed to sync subscription from RevenueCat:",
              error,
            );
          }
        }
      },
    }),
    {
      name: "momentra-settings",
      storage: createJSONStorage(() => AsyncStorage),
      partialize: (state) => ({
        language: state.language,
        isDarkMode: state.isDarkMode,
        themeMode: state.themeMode,
        notificationsEnabled: state.notificationsEnabled,
        notificationPreferences: state.notificationPreferences,
        currency: state.currency,
        subscriptionPlan: state.subscriptionPlan,
        hasSeenOnboarding: state.hasSeenOnboarding,
        favoriteCategories: state.favoriteCategories,
        firstSurpriseCompleted: state.firstSurpriseCompleted,
      }),
    },
  ),
);
