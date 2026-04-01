import "react-native-url-polyfill/auto";
import { createClient } from "@supabase/supabase-js";
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

export const supabase = createClient(
  APP_CONFIG.supabaseUrl,
  APP_CONFIG.supabaseAnonKey,
  {
    auth: {
      storage: authStorage,
      autoRefreshToken: true,
      persistSession: true,
      detectSessionInUrl: false,
    },
  },
);
