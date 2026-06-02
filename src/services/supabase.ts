import "react-native-url-polyfill/auto";
import { createClient, type SupabaseClient } from "@supabase/supabase-js";
import { Platform } from "react-native";
import { APP_CONFIG } from "../constants/config";

// Platform-safe storage: AsyncStorage on native, localStorage wrapper on web/SSR
interface AuthStorage {
  getItem: (key: string) => Promise<string | null>;
  setItem: (key: string, value: string) => Promise<void>;
  removeItem: (key: string) => Promise<void>;
}

let authStorage: AuthStorage;

if (Platform.OS === "web") {
  // Web/SSR-safe storage — guards against "window is not defined" during SSR
  authStorage = {
    getItem: (key: string) => {
      try {
        if (typeof window !== "undefined" && window.localStorage) {
          return Promise.resolve(window.localStorage.getItem(key));
        }
        return Promise.resolve(null);
      } catch {
        return Promise.resolve(null);
      }
    },
    setItem: (key: string, value: string) => {
      try {
        if (typeof window !== "undefined" && window.localStorage) {
          window.localStorage.setItem(key, value);
        }
        return Promise.resolve();
      } catch {
        return Promise.resolve();
      }
    },
    removeItem: (key: string) => {
      try {
        if (typeof window !== "undefined" && window.localStorage) {
          window.localStorage.removeItem(key);
        }
        return Promise.resolve();
      } catch {
        return Promise.resolve();
      }
    },
  };
} else {
  // Native: use AsyncStorage
  const AsyncStorage =
    require("@react-native-async-storage/async-storage").default;
  authStorage = AsyncStorage;
}

// `createClient` internally calls `new URL(supabaseUrl)`. If the env vars
// are missing at runtime (empty strings), that constructor throws and
// crashes the JS bundle at module-load time before any ErrorBoundary can
// render. To keep the bundle loadable in that edge case we substitute a
// syntactically-valid placeholder URL/key — subsequent network calls will
// fail gracefully and the UI can surface a connectivity / config error
// instead of a hard launch crash.
function createSupabaseClient(): SupabaseClient {
  const url = APP_CONFIG.supabaseUrl;
  const key = APP_CONFIG.supabaseAnonKey;

  const hasValidConfig = Boolean(url) && Boolean(key);
  if (!hasValidConfig) {
    if (__DEV__) {
      // eslint-disable-next-line no-console
      console.error(
        "[Supabase] Missing EXPO_PUBLIC_SUPABASE_URL or _ANON_KEY — " +
          "returning a stub client. Network calls will fail but the bundle will load.",
      );
    }
    return createClient(
      "https://placeholder.invalid",
      "placeholder-anon-key-not-used-for-real-requests",
      {
        auth: {
          storage: authStorage,
          autoRefreshToken: false,
          persistSession: false,
          detectSessionInUrl: false,
        },
      },
    );
  }

  try {
    return createClient(url, key, {
      auth: {
        storage: authStorage,
        autoRefreshToken: true,
        persistSession: true,
        detectSessionInUrl: false,
      },
    });
  } catch (error) {
    if (__DEV__) {
      // eslint-disable-next-line no-console
      console.error(
        "[Supabase] createClient threw — falling back to stub client:",
        error,
      );
    }
    return createClient(
      "https://placeholder.invalid",
      "placeholder-anon-key-not-used-for-real-requests",
      {
        auth: {
          storage: authStorage,
          autoRefreshToken: false,
          persistSession: false,
          detectSessionInUrl: false,
        },
      },
    );
  }
}

export const supabase = createSupabaseClient();
