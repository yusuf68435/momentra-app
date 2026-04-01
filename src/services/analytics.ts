/**
 * Analytics Service
 *
 * Typed event tracking layer with dynamic SDK import, event queuing,
 * and __DEV__ console logging. Supports future integration with
 * Mixpanel, Amplitude, or PostHog.
 *
 * Uses dynamic import pattern (like purchases.ts) to gracefully handle
 * the case where an analytics SDK is not yet installed.
 *
 * Usage:
 *   import { trackEvent, trackScreen, AnalyticsEvents } from '../services/analytics';
 *   trackEvent(AnalyticsEvents.PLAN_CREATED, { category: 'birthday' });
 */

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------

export type EventProperties = Record<string, string | number | boolean>;

export type UserTraits = Record<string, string | number | boolean>;

/** Queued event stored before SDK initialization */
interface QueuedEvent {
  type: "event" | "screen" | "identify";
  name: string;
  properties?: EventProperties;
  userId?: string;
  traits?: UserTraits;
  timestamp: number;
}

/**
 * Analytics provider interface. Implement this to plug in a concrete
 * analytics SDK (Mixpanel, Amplitude, PostHog, etc.).
 */
interface AnalyticsProvider {
  initialize: () => Promise<void>;
  track: (name: string, properties?: EventProperties) => void;
  screen: (screenName: string) => void;
  identify: (userId: string, traits?: UserTraits) => void;
  reset: () => void;
}

// ---------------------------------------------------------------------------
// Standard event name constants
// ---------------------------------------------------------------------------

export const AnalyticsEvents = {
  // Plans
  PLAN_CREATED: "plan_created",
  PLAN_COMPLETED: "plan_completed",
  PLAN_DELETED: "plan_deleted",

  // Scenarios
  SCENARIO_VIEWED: "scenario_viewed",
  SCENARIO_FAVORITED: "scenario_favorited",

  // AI
  AI_CHAT_SENT: "ai_chat_sent",
  AI_RECOMMENDATION_VIEWED: "ai_recommendation_viewed",

  // Subscription
  SUBSCRIPTION_STARTED: "subscription_started",
  SUBSCRIPTION_CANCELLED: "subscription_cancelled",

  // Social
  SHARE_SENT: "share_sent",
  INVITE_ACCEPTED: "invite_accepted",

  // Checklist
  CHECKLIST_ITEM_COMPLETED: "checklist_item_completed",

  // Community
  COMMUNITY_STORY_POSTED: "community_story_posted",

  // Auth
  LOGIN: "login",
  REGISTER: "register",
  LOGOUT: "logout",

  // Navigation
  SCREEN_VIEWED: "screen_viewed",
  TAB_CHANGED: "tab_changed",

  // Onboarding
  ONBOARDING_COMPLETED: "onboarding_completed",
  ONBOARDING_SKIPPED: "onboarding_skipped",

  // Notifications
  NOTIFICATION_PERMISSION_GRANTED: "notification_permission_granted",
  NOTIFICATION_PERMISSION_DENIED: "notification_permission_denied",

  // Paywall
  PAYWALL_VIEWED: "paywall_viewed",
  SUBSCRIPTION_RESTORED: "subscription_restored",
} as const;

export type AnalyticsEventName =
  (typeof AnalyticsEvents)[keyof typeof AnalyticsEvents];

// ---------------------------------------------------------------------------
// Dynamic import – PostHog SDK (optional, graceful fallback)
// ---------------------------------------------------------------------------

let analyticsSDK: unknown = null;

try {
  analyticsSDK = require("posthog-react-native");
} catch {
  if (__DEV__) {
    // eslint-disable-next-line no-console
    console.log(
      "[Analytics] PostHog SDK not available – running in log-only mode",
    );
  }
}

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

let isInitialized = false;
let currentUserId: string | null = null;
let provider: AnalyticsProvider | null = null;

/** Event queue – stores events fired before initialization */
const eventQueue: QueuedEvent[] = [];
const MAX_QUEUE_SIZE = 100;

// ---------------------------------------------------------------------------
// Provider factory (extend when integrating a real SDK)
// ---------------------------------------------------------------------------

function createProvider(): AnalyticsProvider | null {
  if (!analyticsSDK) return null;

  const apiKey = process.env.EXPO_PUBLIC_POSTHOG_API_KEY;
  if (!apiKey) {
    if (__DEV__) {
      // eslint-disable-next-line no-console
      console.log(
        "[Analytics] EXPO_PUBLIC_POSTHOG_API_KEY not set – running in log-only mode",
      );
    }
    return null;
  }

  const PostHog = (
    analyticsSDK as {
      PostHog: new (
        apiKey: string,
        options: Record<string, unknown>,
      ) => unknown;
    }
  ).PostHog;

  let client: {
    capture: (event: string, properties?: EventProperties) => void;
    screen: (screenName: string, properties?: EventProperties) => void;
    identify: (distinctId: string, properties?: UserTraits) => void;
    reset: () => void;
  } | null = null;

  return {
    initialize: async () => {
      client = new PostHog(apiKey, {
        host: "https://eu.i.posthog.com",
        captureMode: "json",
        disabled: false,
      }) as typeof client;
    },
    track: (name, properties) => {
      client?.capture(name, properties);
    },
    screen: (screenName) => {
      client?.screen(screenName);
    },
    identify: (userId, traits) => {
      client?.identify(userId, traits);
    },
    reset: () => {
      client?.reset();
    },
  };
}

// ---------------------------------------------------------------------------
// Queue management
// ---------------------------------------------------------------------------

function enqueue(event: QueuedEvent): void {
  if (eventQueue.length >= MAX_QUEUE_SIZE) {
    eventQueue.shift();
  }
  eventQueue.push(event);
}

function flushQueue(): void {
  if (!isInitialized) return;

  const events = eventQueue.splice(0, eventQueue.length);
  for (const event of events) {
    switch (event.type) {
      case "event":
        trackEvent(event.name, event.properties);
        break;
      case "screen":
        trackScreen(event.name);
        break;
      case "identify":
        if (event.userId) {
          identifyUser(event.userId, event.traits);
        }
        break;
    }
  }
}

// ---------------------------------------------------------------------------
// Public API
// ---------------------------------------------------------------------------

/**
 * Initialize the analytics service. Should be called once at app startup.
 * Returns `true` if an analytics provider was successfully initialized,
 * `false` if running in log-only mode (no SDK installed).
 */
export async function initAnalytics(): Promise<boolean> {
  if (isInitialized) return true;

  provider = createProvider();

  if (provider) {
    try {
      await provider.initialize();
      isInitialized = true;
      if (__DEV__) {
        // eslint-disable-next-line no-console
        console.log("[Analytics] SDK initialized successfully");
      }
      flushQueue();
      return true;
    } catch (error: unknown) {
      if (__DEV__) {
        const message = error instanceof Error ? error.message : String(error);
        // eslint-disable-next-line no-console
        if (__DEV__) {
          console.warn("[Analytics] Failed to initialize SDK:", message);
        }
      }
      // Fall through to log-only mode
    }
  }

  // Log-only mode (no SDK or SDK init failed)
  isInitialized = true;
  if (__DEV__) {
    // eslint-disable-next-line no-console
    console.log("[Analytics] Running in log-only mode (no SDK installed)");
  }
  flushQueue();
  return false;
}

/**
 * Track a custom event with optional properties.
 */
export function trackEvent(name: string, properties?: EventProperties): void {
  if (__DEV__) {
    // eslint-disable-next-line no-console
    console.log(`[Analytics] trackEvent: ${name}`, properties ?? {});
  }

  if (!isInitialized) {
    enqueue({ type: "event", name, properties, timestamp: Date.now() });
    return;
  }

  if (provider) {
    provider.track(name, properties);
  }
}

/**
 * Track a screen view.
 */
export function trackScreen(screenName: string): void {
  if (__DEV__) {
    // eslint-disable-next-line no-console
    console.log(`[Analytics] trackScreen: ${screenName}`);
  }

  if (!isInitialized) {
    enqueue({ type: "screen", name: screenName, timestamp: Date.now() });
    return;
  }

  if (provider) {
    provider.screen(screenName);
  }
}

/**
 * Identify the current user with optional traits.
 * Call after login or when user info changes.
 */
export function identifyUser(userId: string, traits?: UserTraits): void {
  currentUserId = userId;

  if (__DEV__) {
    // eslint-disable-next-line no-console
    console.log(`[Analytics] identifyUser: ${userId}`, traits ?? {});
  }

  if (!isInitialized) {
    enqueue({
      type: "identify",
      name: "identify",
      userId,
      traits,
      timestamp: Date.now(),
    });
    return;
  }

  if (provider) {
    provider.identify(userId, traits);
  }
}

/**
 * Reset analytics state. Call on logout.
 * Clears user identity and resets the underlying SDK.
 */
export function resetAnalytics(): void {
  currentUserId = null;

  if (__DEV__) {
    // eslint-disable-next-line no-console
    console.log("[Analytics] reset");
  }

  if (provider) {
    provider.reset();
  }
}

/**
 * Returns whether analytics has been initialized.
 */
export function isAnalyticsInitialized(): boolean {
  return isInitialized;
}

/**
 * Returns the currently identified user ID, or null.
 */
export function getAnalyticsUserId(): string | null {
  return currentUserId;
}

// ---------------------------------------------------------------------------
// Legacy compatibility – keep the old `track` export working
// ---------------------------------------------------------------------------

/**
 * @deprecated Use `trackEvent` instead for clarity.
 */
export function track(name: string, props?: EventProperties): void {
  trackEvent(name, props);
}
