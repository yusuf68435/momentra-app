import { create } from "zustand";
import AsyncStorage from "@react-native-async-storage/async-storage";
import type { Profile } from "../types/database";
import * as authService from "../services/auth";
import { supabase } from "../services/supabase";
import { useSettingsStore } from "./settingsStore";
import { useGamificationStore } from "./gamificationStore";
import {
  trackEvent,
  identifyUser,
  resetAnalytics,
  AnalyticsEvents,
} from "../services/analytics";

const SESSION_TIMEOUT_MS = 30 * 60 * 1000; // 30 minutes
const LAST_ACTIVITY_KEY = "@momentra_last_activity";

interface AuthState {
  user: { id: string; email: string } | null;
  profile: Profile | null;
  isLoading: boolean;
  isAuthenticated: boolean;
  isSessionExpired: boolean;
  error: string | null;
  setUser: (user: { id: string; email: string } | null) => void;
  setProfile: (profile: Profile | null) => void;
  setLoading: (loading: boolean) => void;
  reset: () => void;
  // Session management
  updateLastActivity: () => Promise<void>;
  checkSessionValidity: () => Promise<boolean>;
  // Async actions
  initialize: () => Promise<void>;
  signUp: (
    email: string,
    password: string,
    displayName: string,
  ) => Promise<void>;
  signIn: (email: string, password: string) => Promise<void>;
  signOut: () => Promise<void>;
  loadProfile: () => Promise<void>;
  updateProfile: (
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
  ) => Promise<void>;
}

// Track auth listener subscription for cleanup
let authSubscription: { unsubscribe: () => void } | null = null;

export const useAuthStore = create<AuthState>((set, get) => ({
  user: null,
  profile: null,
  isLoading: true,
  isAuthenticated: false,
  isSessionExpired: false,
  error: null,
  setUser: (user) => set({ user, isAuthenticated: !!user }),
  setProfile: (profile) => set({ profile }),
  setLoading: (isLoading) => set({ isLoading }),
  reset: () =>
    set({
      user: null,
      profile: null,
      isAuthenticated: false,
      isLoading: false,
      isSessionExpired: false,
      error: null,
    }),

  updateLastActivity: async () => {
    try {
      await AsyncStorage.setItem(LAST_ACTIVITY_KEY, Date.now().toString());
    } catch (err) {
      if (__DEV__) {
        console.log("Failed to update last activity:", err);
      }
    }
  },

  checkSessionValidity: async () => {
    if (!get().isAuthenticated) return false;

    try {
      const lastActivityStr = await AsyncStorage.getItem(LAST_ACTIVITY_KEY);
      if (!lastActivityStr) {
        // No recorded activity — treat as valid and record now
        await get().updateLastActivity();
        return true;
      }

      const lastActivity = parseInt(lastActivityStr, 10);
      const elapsed = Date.now() - lastActivity;

      if (elapsed > SESSION_TIMEOUT_MS) {
        set({ isSessionExpired: true });
        await get().signOut();
        return false;
      }

      return true;
    } catch (err) {
      if (__DEV__) {
        console.log("Session validity check failed:", err);
      }
      return true;
    }
  },

  initialize: async () => {
    if (get().isLoading && get().user) return; // Prevent re-initialization while in progress

    // Clean up previous auth listener BEFORE setting up a new one
    if (authSubscription) {
      authSubscription.unsubscribe();
      authSubscription = null;
    }

    try {
      set({ isLoading: true, error: null });
      const session = await authService.getCurrentSession();
      if (session?.user) {
        set({
          user: { id: session.user.id, email: session.user.email ?? "" },
          isAuthenticated: true,
        });

        // Check if session has timed out due to inactivity
        const isValid = await get().checkSessionValidity();
        if (!isValid) {
          return;
        }

        await get().updateLastActivity();
        await get().loadProfile();
        useGamificationStore.getState().loadFromDB();
      }
    } catch (err) {
      if (__DEV__) {
        console.log("Auth initialization failed:", err);
      }
    } finally {
      set({ isLoading: false });
    }

    // Listen for auth changes
    const { data } = supabase.auth.onAuthStateChange((_event, session) => {
      if (session?.user) {
        set({
          user: { id: session.user.id, email: session.user.email ?? "" },
          isAuthenticated: true,
        });
        get().loadProfile();
        useGamificationStore.getState().loadFromDB();
      } else {
        get().reset();
      }
    });
    authSubscription = data.subscription;
  },

  signUp: async (email, password, displayName) => {
    set({ isLoading: true });
    try {
      await authService.signUp(email, password, displayName);
    } finally {
      set({ isLoading: false });
    }
  },

  signIn: async (email, password) => {
    set({ isLoading: true });
    try {
      const { session } = await authService.signIn(email, password);
      if (session?.user) {
        set({
          user: { id: session.user.id, email: session.user.email ?? "" },
          isAuthenticated: true,
          isSessionExpired: false,
        });
        await get().updateLastActivity();
        await get().loadProfile();
        useGamificationStore.getState().loadFromDB();
        identifyUser(session.user.id, { email: session.user.email ?? "" });
        trackEvent(AnalyticsEvents.LOGIN, { method: "email" });
      }
    } finally {
      set({ isLoading: false });
    }
  },

  signOut: async () => {
    try {
      await AsyncStorage.removeItem(LAST_ACTIVITY_KEY);
      await authService.signOut();
    } catch (err) {
      if (__DEV__) {
        console.log("Sign out error:", err);
      }
    }
    trackEvent(AnalyticsEvents.LOGOUT);
    resetAnalytics();
    get().reset();
  },

  loadProfile: async () => {
    try {
      const profile = await authService.fetchProfile();
      set({ profile });
      if (profile) {
        useSettingsStore.getState().hydrateFromProfile(profile);
      }
    } catch (err) {
      if (__DEV__) {
        console.log("Failed to load profile:", err);
      }
    }
  },

  updateProfile: async (updates) => {
    const profile = await authService.updateProfile(updates);
    if (profile) {
      set({ profile });
    }
  },
}));
