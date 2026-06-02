import {
  DarkTheme,
  DefaultTheme,
  ThemeProvider,
} from "@react-navigation/native";
import { useFonts } from "expo-font";
import { Stack, useRouter, useSegments } from "expo-router";
import * as SplashScreen from "expo-splash-screen";
import * as Notifications from "expo-notifications";
import { StatusBar } from "expo-status-bar";
import React, { useEffect, useRef } from "react";
import { View, Text, TouchableOpacity, StyleSheet } from "react-native";
import { useTranslation } from "react-i18next";
import { GestureHandlerRootView } from "react-native-gesture-handler";
import "react-native-reanimated";
import "../src/i18n";

import { AppThemeProvider, useTheme } from "../src/contexts/ThemeContext";
import { ToastProvider } from "../src/contexts/ToastContext";
import { useAuthStore } from "../src/stores/authStore";
import { useSettingsStore } from "../src/stores/settingsStore";
import { registerForPushNotifications } from "../src/utils/notifications";
import { initializePurchases } from "../src/services/purchases";
import { supabase } from "../src/services/supabase";
import { getCurrentUserId } from "../src/services/helpers";
import { useNetworkStatus } from "../src/hooks/useNetworkStatus";
import { OfflineBanner } from "../src/components/common/OfflineBanner";
import { setupNotificationHandler } from "../src/services/notifications";
import {
  initAnalytics,
  identifyUser,
  resetAnalytics,
  trackScreen,
} from "../src/services/analytics";
import {
  initErrorTracking,
  setUser as setErrorTrackingUser,
  clearUser as clearErrorTrackingUser,
} from "../src/utils/errorTracking";
import * as Linking from "expo-linking";
import {
  initOfflineQueueSync,
  teardownOfflineQueueSync,
} from "../src/utils/supabaseQueueExecutor";
import { syncFeatureFlagsFromRemote } from "../src/stores/featureFlagsStore";
import { UUID_RE, INVITE_CODE_RE, SLUG_RE } from "../src/constants/validation";

// Custom ErrorBoundary with user-friendly UI
export function ErrorBoundary({
  error,
  retry,
}: {
  error: Error;
  retry: () => void;
}) {
  return <ErrorFallback error={error} retry={retry} />;
}

function ErrorFallback({ error, retry }: { error: Error; retry: () => void }) {
  const { t } = useTranslation();
  const { colors } = useTheme();

  return (
    <View
      style={[errorStyles.container, { backgroundColor: colors.background }]}
    >
      <Text style={errorStyles.emoji}>😕</Text>
      <Text style={[errorStyles.title, { color: colors.text }]}>
        {t("errors.somethingWentWrong")}
      </Text>
      <Text style={[errorStyles.message, { color: colors.textSecondary }]}>
        {error.message}
      </Text>
      <TouchableOpacity
        style={[errorStyles.button, { backgroundColor: colors.primary }]}
        onPress={retry}
      >
        <Text style={errorStyles.buttonText}>{t("errors.tryAgain")}</Text>
      </TouchableOpacity>
    </View>
  );
}

const errorStyles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
    padding: 24,
  },
  emoji: { fontSize: 64, marginBottom: 16 },
  title: { fontSize: 22, fontWeight: "700", marginBottom: 16 },
  message: {
    fontSize: 13,
    textAlign: "center",
    marginBottom: 24,
    paddingHorizontal: 32,
  },
  button: {
    paddingHorizontal: 32,
    paddingVertical: 14,
    borderRadius: 12,
  },
  buttonText: { fontSize: 16, fontWeight: "600", color: "#FFFFFF" },
});

export const unstable_settings = {
  initialRouteName: "(tabs)",
};

// Module-load side effects — defensively wrapped so a native module that
// throws during initialization (e.g. expo-notifications on a newer iOS where
// the API contract changed) cannot crash the JS bundle before any UI renders.
SplashScreen.preventAutoHideAsync().catch(() => {});
try {
  setupNotificationHandler();
} catch (error) {
  if (__DEV__) {
    // eslint-disable-next-line no-console
    console.warn("[Layout] setupNotificationHandler failed:", error);
  }
}

export default function RootLayout() {
  const [loaded, error] = useFonts({
    SpaceMono: require("../assets/fonts/SpaceMono-Regular.ttf"),
    // Plus Jakarta Sans — primary typeface
    "PlusJakartaSans-Regular": require("@expo-google-fonts/plus-jakarta-sans/400Regular/PlusJakartaSans_400Regular.ttf"),
    "PlusJakartaSans-Medium": require("@expo-google-fonts/plus-jakarta-sans/500Medium/PlusJakartaSans_500Medium.ttf"),
    "PlusJakartaSans-SemiBold": require("@expo-google-fonts/plus-jakarta-sans/600SemiBold/PlusJakartaSans_600SemiBold.ttf"),
    "PlusJakartaSans-Bold": require("@expo-google-fonts/plus-jakarta-sans/700Bold/PlusJakartaSans_700Bold.ttf"),
    // JetBrains Mono — countdown timers, codes
    "JetBrainsMono-Regular": require("@expo-google-fonts/jetbrains-mono/400Regular/JetBrainsMono_400Regular.ttf"),
  });

  useEffect(() => {
    if (error) {
      if (__DEV__) {
        console.warn("Font loading error:", error);
      }
      SplashScreen.hideAsync();
    }
  }, [error]);

  useEffect(() => {
    if (loaded) {
      SplashScreen.hideAsync();
    }
  }, [loaded]);

  if (!loaded && !error) {
    return null;
  }

  return (
    <GestureHandlerRootView style={{ flex: 1 }}>
      <AppThemeProvider>
        <RootLayoutNav />
      </AppThemeProvider>
    </GestureHandlerRootView>
  );
}

function RootLayoutNav() {
  const { colors, isDark } = useTheme();
  const { t } = useTranslation();
  const router = useRouter();
  const segments = useSegments();
  const { isAuthenticated, isLoading, initialize } = useAuthStore();
  const { hasSeenOnboarding, notificationsEnabled, language } =
    useSettingsStore();

  // Start network monitoring — updates useNetworkStore globally
  useNetworkStatus();
  const notificationListener = useRef<Notifications.EventSubscription>(null);
  const responseListener = useRef<Notifications.EventSubscription>(null);

  // Initialize analytics and error tracking once on mount
  useEffect(() => {
    initAnalytics().catch(() => {});
    try {
      initErrorTracking();
    } catch {
      // No-op if Sentry package is not installed or DSN is missing
    }
  }, []);

  // Identify / de-identify user when auth state changes
  useEffect(() => {
    if (isLoading) return;
    if (isAuthenticated) {
      getCurrentUserId()
        .then((userId) => {
          if (userId) {
            identifyUser(userId, { language });
            try {
              setErrorTrackingUser(userId);
            } catch {
              // No-op if Sentry is unavailable
            }
          }
        })
        .catch(() => {});
    } else {
      resetAnalytics();
      try {
        clearErrorTrackingUser();
      } catch {
        // No-op if Sentry is unavailable
      }
    }
  }, [isAuthenticated, isLoading]);

  // Track screen changes
  useEffect(() => {
    const screen = segments.join("/") || "home";
    trackScreen(screen);
  }, [segments]);

  // Initialize auth on mount
  useEffect(() => {
    initialize();
  }, []);

  // Start offline queue sync when authenticated, tear down on logout
  useEffect(() => {
    if (isLoading) return;
    if (isAuthenticated) {
      initOfflineQueueSync();
      syncFeatureFlagsFromRemote().catch(() => {});
    } else {
      teardownOfflineQueueSync();
    }
  }, [isAuthenticated, isLoading]);

  // Register for push notifications after auth initializes
  useEffect(() => {
    if (isLoading || !isAuthenticated) return;
    if (!notificationsEnabled) return;

    registerForPushNotifications().then(async (token) => {
      if (token) {
        const userId = await getCurrentUserId().catch(() => null);
        if (userId) {
          supabase
            .from("profiles")
            .update({ push_token: token })
            .eq("id", userId)
            .then(({ error }) => {
              if (error && __DEV__) {
                console.warn(
                  "[Notifications] Failed to save push token:",
                  error.message,
                );
              }
            });
        }
      }
    });

    // Foreground notification handler
    notificationListener.current =
      Notifications.addNotificationReceivedListener((notification) => {
        if (__DEV__) {
          console.log(
            "[Notifications] Received in foreground:",
            notification.request.content.title,
          );
        }
      });

    // User tapped on notification handler
    responseListener.current =
      Notifications.addNotificationResponseReceivedListener((response) => {
        const data = response.notification.request.content.data;
        if (data?.type === "proactive_suggestion" && data.suggestedCategories) {
          // Navigate to explore screen with suggested category
          const category = Array.isArray(data.suggestedCategories)
            ? data.suggestedCategories[0]
            : data.suggestedCategories;
          router.push(`/(tabs)/explore?category=${category}` as any);
        } else if (data?.planId) {
          router.push(`/plan/${data.planId}` as any);
        }
      });

    return () => {
      if (notificationListener.current) {
        notificationListener.current.remove();
      }
      if (responseListener.current) {
        responseListener.current.remove();
      }
    };
  }, [isAuthenticated, isLoading, notificationsEnabled]);

  // Initialize RevenueCat on startup and sync subscription
  useEffect(() => {
    let cleanupListener: (() => void) | undefined;

    (async () => {
      const initialized = await initializePurchases();
      if (initialized) {
        // Sync subscription status on startup
        const { syncSubscriptionToStore, addSubscriptionChangeListener } =
          await import("../src/services/purchases");
        const status = await syncSubscriptionToStore();
        useSettingsStore.getState().setSubscriptionPlan(status.plan);

        // Listen for subscription changes
        cleanupListener = addSubscriptionChangeListener((newStatus) => {
          useSettingsStore.getState().setSubscriptionPlan(newStatus.plan);
        });
      }
    })();

    return () => {
      if (cleanupListener) cleanupListener();
    };
  }, []);

  // Auth guard: redirect based on auth state
  useEffect(() => {
    if (isLoading) return;

    const inAuthGroup = segments[0] === "(auth)";
    const inOnboarding = segments[0] === "onboarding";

    if (!isAuthenticated && !inAuthGroup && !inOnboarding) {
      // Not authenticated and not on auth/onboarding screens -> redirect to login
      router.replace("/(auth)/login" as any);
    } else if (isAuthenticated && inAuthGroup) {
      // Authenticated but on auth screen -> redirect to tabs
      if (!hasSeenOnboarding) {
        router.replace("/onboarding" as any);
      } else {
        router.replace("/(tabs)");
      }
    }
  }, [isAuthenticated, isLoading, segments]);

  // Handle deep links (momentra://invite/CODE, momentra://plan/ID, momentra://scenario/ID)
  useEffect(() => {
    const handleUrl = ({ url }: { url: string }) => {
      try {
        const parsed = Linking.parse(url);
        const path = parsed.path || "";

        if (path.startsWith("invite/")) {
          const code = path.replace("invite/", "");
          if (INVITE_CODE_RE.test(code)) router.push(`/invite/${code}` as any);
        } else if (path.startsWith("plan/")) {
          const planId = path.replace("plan/", "");
          if (UUID_RE.test(planId)) router.push(`/plan/${planId}` as any);
        } else if (path.startsWith("scenario/")) {
          const scenarioId = path.replace("scenario/", "");
          if (UUID_RE.test(scenarioId))
            router.push(`/scenario/${scenarioId}` as any);
        } else if (path.startsWith("category/")) {
          const slug = path.replace("category/", "");
          if (SLUG_RE.test(slug)) router.push(`/category/${slug}` as any);
        }
      } catch (error) {
        if (__DEV__) {
          console.warn("[DeepLink] Failed to handle URL:", url, error);
        }
      }
    };

    // Handle app opened from a deep link
    Linking.getInitialURL().then((url) => {
      if (url) handleUrl({ url });
    });

    const subscription = Linking.addEventListener("url", handleUrl);
    return () => subscription.remove();
  }, [router]);

  const navTheme = isDark
    ? {
        ...DarkTheme,
        colors: {
          ...DarkTheme.colors,
          primary: colors.primary,
          background: colors.background,
          card: colors.surface,
          text: colors.text,
          border: colors.border,
        },
      }
    : {
        ...DefaultTheme,
        colors: {
          ...DefaultTheme.colors,
          primary: colors.primary,
          background: colors.background,
          card: colors.surface,
          text: colors.text,
          border: colors.border,
        },
      };

  return (
    <ToastProvider>
      <OfflineBanner />
      <ThemeProvider value={navTheme}>
        <StatusBar style={isDark ? "light" : "dark"} animated />
        <Stack>
          <Stack.Screen
            name="(tabs)"
            options={{ headerShown: false, title: "" }}
          />
          <Stack.Screen name="(auth)" options={{ headerShown: false }} />
          <Stack.Screen
            name="scenario/[id]"
            options={{
              title: "",
              headerTransparent: true,
              headerBackTitle: "",

              headerBackButtonDisplayMode: "minimal",
            }}
          />
          <Stack.Screen
            name="plan/create"
            options={{
              title: t("navigation.newPlan"),
              presentation: "modal",
            }}
          />
          <Stack.Screen
            name="plan/[id]/index"
            options={{ title: t("navigation.planDetail") }}
          />
          <Stack.Screen
            name="plan/[id]/checklist"
            options={{ title: t("navigation.checklist") }}
          />
          <Stack.Screen
            name="plan/[id]/expenses"
            options={{ title: t("navigation.expenses") }}
          />
          <Stack.Screen name="category/[slug]" options={{ title: "" }} />
          <Stack.Screen
            name="settings/language"
            options={{ title: t("navigation.language") }}
          />
          <Stack.Screen
            name="settings/notifications"
            options={{ title: t("navigation.notifications") }}
          />
          <Stack.Screen
            name="settings/subscription"
            options={{ title: "Premium" }}
          />
          <Stack.Screen
            name="settings/profile-edit"
            options={{
              title: t("navigation.profile"),
              presentation: "modal",
            }}
          />
          <Stack.Screen
            name="settings/stealth"
            options={{ title: t("navigation.stealthMode") }}
          />
          <Stack.Screen
            name="settings/privacy"
            options={{ title: t("navigation.privacyPolicy") }}
          />
          <Stack.Screen
            name="settings/terms"
            options={{ title: t("navigation.termsOfUse") }}
          />
          <Stack.Screen
            name="favorites"
            options={{ title: t("navigation.favorites") }}
          />
          <Stack.Screen
            name="important-dates"
            options={{ title: t("navigation.importantDates") }}
          />
          <Stack.Screen
            name="plan/[id]/co-organizers"
            options={{ title: t("navigation.coOrganizers") }}
          />
          <Stack.Screen
            name="plan/[id]/chat"
            options={{ title: t("navigation.chat") }}
          />
          <Stack.Screen
            name="plan/[id]/memories"
            options={{ headerShown: false }}
          />
          <Stack.Screen
            name="plan/[id]/weather"
            options={{ title: t("navigation.weather") }}
          />
          <Stack.Screen
            name="plan/[id]/timeline"
            options={{ title: t("navigation.timeline") }}
          />
          <Stack.Screen
            name="plan/[id]/gifts"
            options={{ title: t("navigation.gifts") }}
          />
          <Stack.Screen
            name="plan/[id]/music"
            options={{ title: t("navigation.playlist") }}
          />
          <Stack.Screen
            name="plan/[id]/moodboard"
            options={{ title: t("navigation.moodboard") }}
          />
          <Stack.Screen
            name="plan/[id]/guests"
            options={{ title: t("navigation.guests") }}
          />
          <Stack.Screen
            name="plan/[id]/backup"
            options={{ title: t("navigation.backupPlan") }}
          />
          <Stack.Screen
            name="plan/[id]/capsule"
            options={{ title: t("navigation.timeCapsule") }}
          />
          <Stack.Screen
            name="plan/[id]/secret-chat"
            options={{ title: t("navigation.secretChat") }}
          />
          <Stack.Screen
            name="plan/[id]/event-day"
            options={{ title: t("navigation.eventDay") }}
          />
          <Stack.Screen
            name="plan/[id]/complete"
            options={{ title: t("navigation.completeSurprise") }}
          />
          <Stack.Screen
            name="plan/[id]/reveal"
            options={{ headerShown: false }}
          />
          <Stack.Screen
            name="invite/[code]"
            options={{
              title: t("navigation.invite"),
              presentation: "modal",
            }}
          />
          <Stack.Screen
            name="community/[id]"
            options={{
              title: t("navigation.story"),
              headerTransparent: true,
              headerBackTitle: "",

              headerBackButtonDisplayMode: "minimal",
            }}
          />
          <Stack.Screen name="vendors" options={{ headerShown: false }} />
          <Stack.Screen name="onboarding" options={{ headerShown: false }} />
          <Stack.Screen name="modal" options={{ presentation: "modal" }} />
        </Stack>
      </ThemeProvider>
    </ToastProvider>
  );
}
