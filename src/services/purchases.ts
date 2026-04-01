/**
 * RevenueCat Purchases Service
 *
 * Wraps the RevenueCat SDK (react-native-purchases) to provide a clean
 * interface for in-app purchases and subscription management.
 *
 * Falls back to mock/demo mode when running in Expo Go (where native
 * modules are not available).
 *
 * Prerequisites (for production builds):
 *   npm install react-native-purchases
 *   Set EXPO_PUBLIC_REVENUECAT_IOS_KEY and/or EXPO_PUBLIC_REVENUECAT_ANDROID_KEY in .env
 */

import { Platform } from "react-native";
import { APP_CONFIG } from "../constants/config";
import type { SubscriptionPlan } from "../stores/settingsStore";

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------

interface RevenueCatEntitlement {
  expirationDate?: string;
  isActive: boolean;
}

interface RevenueCatCustomerInfo {
  entitlements: {
    active: Record<string, RevenueCatEntitlement>;
  };
}

interface RevenueCatProduct {
  identifier: string;
  priceString: string;
  [key: string]: unknown;
}

interface RevenueCatPackage {
  identifier: string;
  product: RevenueCatProduct;
}

interface RevenueCatOfferings {
  current: {
    availablePackages: RevenueCatPackage[];
  } | null;
  all: Record<string, unknown>;
}

interface RevenueCatSDK {
  configure(options: { apiKey: string }): void;
  getOfferings(): Promise<RevenueCatOfferings>;
  purchasePackage(
    pkg: RevenueCatPackage,
  ): Promise<{ customerInfo: RevenueCatCustomerInfo }>;
  restorePurchases(): Promise<RevenueCatCustomerInfo>;
  getCustomerInfo(): Promise<RevenueCatCustomerInfo>;
  addCustomerInfoUpdateListener(
    callback: (info: RevenueCatCustomerInfo) => void,
  ): void;
}

interface PurchaseCancelledError extends Error {
  userCancelled: boolean;
}

// ---------------------------------------------------------------------------
// Dynamic import – react-native-purchases is unavailable in Expo Go
// ---------------------------------------------------------------------------

let Purchases: RevenueCatSDK | null = null;

try {
  // eslint-disable-next-line @typescript-eslint/no-require-imports
  Purchases = require("react-native-purchases").default as RevenueCatSDK;
} catch {
  if (__DEV__) {
    console.log(
      "[Purchases] react-native-purchases not available (Expo Go mode)",
    );
  }
}

// ---------------------------------------------------------------------------
// Public Types
// ---------------------------------------------------------------------------

export interface SubscriptionStatus {
  plan: SubscriptionPlan;
  isActive: boolean;
  expiresAt: string | null;
}

// Re-export compatible types for consumers
export type PurchasesOfferings = RevenueCatOfferings;
export type PurchasesPackage = RevenueCatPackage;
export type CustomerInfo = RevenueCatCustomerInfo;

// ---------------------------------------------------------------------------
// RevenueCat entitlement identifiers (must match your RevenueCat dashboard)
// ---------------------------------------------------------------------------

const ENTITLEMENT_PRO = "pro";
const ENTITLEMENT_PLUS = "plus";

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

let isInitialized = false;

// ---------------------------------------------------------------------------
// Initialization
// ---------------------------------------------------------------------------

/**
 * Initialize the RevenueCat SDK. Should be called once at app startup.
 * Returns `true` if initialization succeeded, `false` if API keys are missing
 * or the native module is not available (Expo Go).
 */
export async function initializePurchases(): Promise<boolean> {
  if (isInitialized) return true;

  if (!Purchases) {
    if (__DEV__) {
      console.warn(
        "[Purchases] Native module not available – running in demo mode",
      );
    }
    return false;
  }

  const apiKey =
    Platform.OS === "ios"
      ? APP_CONFIG.revenueCatIosKey
      : APP_CONFIG.revenueCatAndroidKey;

  if (!apiKey) {
    if (__DEV__) {
      console.warn(
        "[Purchases] RevenueCat API key not configured. " +
          "Set EXPO_PUBLIC_REVENUECAT_IOS_KEY or EXPO_PUBLIC_REVENUECAT_ANDROID_KEY in .env",
      );
    }
    return false;
  }

  try {
    Purchases.configure({ apiKey });
    isInitialized = true;
    if (__DEV__) {
      console.log("[Purchases] RevenueCat initialized successfully");
    }
    return true;
  } catch (error) {
    if (__DEV__) {
      console.error("[Purchases] Failed to initialize RevenueCat:", error);
    }
    return false;
  }
}

// ---------------------------------------------------------------------------
// Offerings
// ---------------------------------------------------------------------------

/**
 * Fetch available offerings (packages / products) from RevenueCat.
 * Returns `null` if RevenueCat is not initialised or the fetch fails.
 */
export async function getOfferings(): Promise<PurchasesOfferings | null> {
  if (!isInitialized || !Purchases) {
    if (__DEV__)
      console.warn(
        "[Purchases] SDK not initialized – call initializePurchases() first",
      );
    return null;
  }

  try {
    const offerings = await Purchases.getOfferings();
    return offerings;
  } catch (error) {
    if (__DEV__) {
      console.error("[Purchases] Failed to get offerings:", error);
    }
    return null;
  }
}

// ---------------------------------------------------------------------------
// Purchase
// ---------------------------------------------------------------------------

/**
 * Purchase a specific package. Returns the resulting CustomerInfo on success,
 * or `null` if the purchase was cancelled / failed.
 */
export async function purchasePackage(
  pkg: PurchasesPackage,
): Promise<CustomerInfo | null> {
  if (!isInitialized || !Purchases) {
    if (__DEV__) console.warn("[Purchases] SDK not initialized");
    return null;
  }

  try {
    const { customerInfo } = await Purchases.purchasePackage(pkg);
    return customerInfo;
  } catch (error: unknown) {
    // User cancelled – not a real error
    if (
      error instanceof Error &&
      (error as PurchaseCancelledError).userCancelled
    ) {
      if (__DEV__) console.log("[Purchases] User cancelled purchase");
      return null;
    }
    if (__DEV__) {
      console.error("[Purchases] Purchase failed:", error);
    }
    throw error;
  }
}

// ---------------------------------------------------------------------------
// Restore
// ---------------------------------------------------------------------------

/**
 * Restore previously purchased subscriptions / products.
 * Returns the latest CustomerInfo on success, or `null` on failure.
 */
export async function restorePurchases(): Promise<CustomerInfo | null> {
  if (!isInitialized || !Purchases) {
    if (__DEV__) console.warn("[Purchases] SDK not initialized");
    return null;
  }

  try {
    const customerInfo = await Purchases.restorePurchases();
    return customerInfo;
  } catch (error) {
    if (__DEV__) {
      console.error("[Purchases] Restore failed:", error);
    }
    throw error;
  }
}

// ---------------------------------------------------------------------------
// Customer Info
// ---------------------------------------------------------------------------

/**
 * Fetch the current customer info from RevenueCat.
 */
export async function getCustomerInfo(): Promise<CustomerInfo | null> {
  if (!isInitialized || !Purchases) {
    if (__DEV__) console.warn("[Purchases] SDK not initialized");
    return null;
  }

  try {
    const customerInfo = await Purchases.getCustomerInfo();
    return customerInfo;
  } catch (error) {
    if (__DEV__) {
      console.error("[Purchases] Failed to get customer info:", error);
    }
    return null;
  }
}

// ---------------------------------------------------------------------------
// Subscription Status
// ---------------------------------------------------------------------------

/**
 * Derive the user's current subscription status from RevenueCat entitlements.
 *
 * Checks for 'pro' and 'plus' entitlements (in that order of priority).
 * Falls back to the free plan when RevenueCat is not configured or no
 * active entitlements exist.
 */
export async function checkSubscriptionStatus(): Promise<SubscriptionStatus> {
  const fallback: SubscriptionStatus = {
    plan: "free",
    isActive: false,
    expiresAt: null,
  };

  if (!isInitialized || !Purchases) return fallback;

  try {
    const customerInfo = await Purchases.getCustomerInfo();
    return deriveStatusFromCustomerInfo(customerInfo);
  } catch (error) {
    if (__DEV__) {
      console.error("[Purchases] Failed to check subscription status:", error);
    }
    return fallback;
  }
}

/**
 * Derive a SubscriptionStatus from a CustomerInfo object.
 * Useful after a purchase or restore so you don't need an extra network call.
 */
export function deriveStatusFromCustomerInfo(
  customerInfo: CustomerInfo,
): SubscriptionStatus {
  const entitlements = customerInfo.entitlements.active;

  // Check Pro first (higher tier)
  if (entitlements[ENTITLEMENT_PRO]) {
    const ent = entitlements[ENTITLEMENT_PRO];
    return {
      plan: "pro",
      isActive: true,
      expiresAt: ent.expirationDate ?? null,
    };
  }

  // Then Plus
  if (entitlements[ENTITLEMENT_PLUS]) {
    const ent = entitlements[ENTITLEMENT_PLUS];
    return {
      plan: "plus",
      isActive: true,
      expiresAt: ent.expirationDate ?? null,
    };
  }

  return {
    plan: "free",
    isActive: false,
    expiresAt: null,
  };
}

// ---------------------------------------------------------------------------
// Subscription Change Listener
// ---------------------------------------------------------------------------

type SubscriptionChangeCallback = (status: SubscriptionStatus) => void;
let subscriptionListener: SubscriptionChangeCallback | null = null;

/**
 * Register a listener for subscription changes.
 * Called when entitlements change (purchase, expiry, restore).
 */
export function addSubscriptionChangeListener(
  callback: SubscriptionChangeCallback,
): () => void {
  if (!Purchases) return () => {};

  subscriptionListener = callback;

  try {
    Purchases.addCustomerInfoUpdateListener((info: CustomerInfo) => {
      const status = deriveStatusFromCustomerInfo(info);
      if (subscriptionListener) {
        subscriptionListener(status);
      }
    });
  } catch (error) {
    if (__DEV__) {
      console.error("[Purchases] Failed to add listener:", error);
    }
  }

  return () => {
    subscriptionListener = null;
  };
}

/**
 * Sync subscription status from RevenueCat to local store.
 * Should be called on app startup after initialization.
 */
export async function syncSubscriptionToStore(): Promise<SubscriptionStatus> {
  const status = await checkSubscriptionStatus();
  return status;
}

/**
 * Returns whether RevenueCat has been successfully initialized.
 */
export function isPurchasesConfigured(): boolean {
  return isInitialized;
}
