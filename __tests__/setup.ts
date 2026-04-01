/**
 * Jest global setup / mocks
 *
 * Provides mocks for native modules that are unavailable in the
 * Node.js test environment.
 *
 * This file is loaded via setupFiles (before the test framework),
 * so lifecycle hooks (beforeAll, afterAll, etc.) are NOT available here.
 * Only jest.mock() calls belong in this file.
 */

// ── AsyncStorage ─────────────────────────────────────────────────────

jest.mock("@react-native-async-storage/async-storage", () => {
  const store: Record<string, string> = {};

  return {
    __esModule: true,
    default: {
      getItem: jest.fn(async (key: string) => store[key] ?? null),
      setItem: jest.fn(async (key: string, value: string) => {
        store[key] = value;
      }),
      removeItem: jest.fn(async (key: string) => {
        delete store[key];
      }),
      getAllKeys: jest.fn(async () => Object.keys(store)),
      multiGet: jest.fn(async (keys: string[]) =>
        keys.map((k) => [k, store[k] ?? null]),
      ),
      multiSet: jest.fn(async (pairs: [string, string][]) => {
        pairs.forEach(([k, v]) => {
          store[k] = v;
        });
      }),
      multiRemove: jest.fn(async (keys: string[]) => {
        keys.forEach((k) => {
          delete store[k];
        });
      }),
      clear: jest.fn(async () => {
        Object.keys(store).forEach((k) => delete store[k]);
      }),
      /**
       * Exposed for test cleanup: wipe the in-memory store directly.
       * Usage: (AsyncStorage as any).__resetStore()
       */
      __resetStore: () => {
        Object.keys(store).forEach((k) => delete store[k]);
      },
    },
  };
});

// ── expo-haptics ─────────────────────────────────────────────────────

jest.mock("expo-haptics", () => ({
  impactAsync: jest.fn(),
  notificationAsync: jest.fn(),
  selectionAsync: jest.fn(),
  ImpactFeedbackStyle: {
    Light: "light",
    Medium: "medium",
    Heavy: "heavy",
  },
  NotificationFeedbackType: {
    Success: "success",
    Warning: "warning",
    Error: "error",
  },
}));

// ── expo-router ──────────────────────────────────────────────────────

jest.mock("expo-router", () => ({
  useRouter: jest.fn(() => ({
    push: jest.fn(),
    replace: jest.fn(),
    back: jest.fn(),
    canGoBack: jest.fn(() => false),
  })),
  useLocalSearchParams: jest.fn(() => ({})),
  useSegments: jest.fn(() => []),
  Link: "Link",
  Stack: {
    Screen: "Screen",
  },
  Tabs: {
    Screen: "Screen",
  },
}));

// ── react-native-reanimated ──────────────────────────────────────────

jest.mock("react-native-reanimated", () => {
  try {
    const Reanimated = require("react-native-reanimated/mock");
    Reanimated.default.call = () => {};
    return Reanimated;
  } catch {
    // If mock module is not available, provide a minimal mock
    return {
      default: { call: () => {} },
      useSharedValue: jest.fn((v: unknown) => ({ value: v })),
      useAnimatedStyle: jest.fn(() => ({})),
      withTiming: jest.fn((v: unknown) => v),
      withSpring: jest.fn((v: unknown) => v),
      withDelay: jest.fn((_d: number, v: unknown) => v),
      FadeIn: { duration: jest.fn().mockReturnThis() },
      FadeOut: { duration: jest.fn().mockReturnThis() },
      SlideInRight: { duration: jest.fn().mockReturnThis() },
      SlideOutLeft: { duration: jest.fn().mockReturnThis() },
    };
  }
});

// ── Supabase ─────────────────────────────────────────────────────────

jest.mock("../src/services/supabase", () => ({
  supabase: {
    from: jest.fn(() => ({
      select: jest.fn().mockReturnThis(),
      insert: jest.fn().mockReturnThis(),
      update: jest.fn().mockReturnThis(),
      delete: jest.fn().mockReturnThis(),
      eq: jest.fn().mockReturnThis(),
      single: jest.fn().mockResolvedValue({ data: null, error: null }),
    })),
    auth: {
      getSession: jest
        .fn()
        .mockResolvedValue({ data: { session: null }, error: null }),
      getUser: jest
        .fn()
        .mockResolvedValue({ data: { user: null }, error: null }),
    },
    rpc: jest.fn().mockResolvedValue({ data: null, error: null }),
    functions: {
      invoke: jest.fn().mockResolvedValue({ data: null, error: null }),
    },
  },
}));

// ── Gamification service (remote calls) ──────────────────────────────

jest.mock("../src/services/gamification", () => ({
  fetchGamification: jest.fn().mockResolvedValue(null),
  fetchBadges: jest.fn().mockResolvedValue([]),
  addXpRemote: jest.fn().mockResolvedValue(undefined),
  awardBadge: jest.fn().mockResolvedValue(undefined),
  updateStreakRemote: jest.fn().mockResolvedValue(undefined),
  syncStats: jest.fn().mockResolvedValue(undefined),
}));

// ── Suppress noisy console.warn (setup-time override) ────────────────

const _originalWarn = console.warn.bind(console);
console.warn = (...args: unknown[]) => {
  const msg = typeof args[0] === "string" ? args[0] : "";
  if (msg.includes("zustand") || msg.includes("persist")) return;
  _originalWarn(...args);
};
