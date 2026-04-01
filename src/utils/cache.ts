/**
 * Offline Cache Layer
 *
 * Generic AsyncStorage-based cache with TTL support.
 * Provides a cache-first strategy with graceful degradation:
 * on network failure, stale cached data is returned rather than throwing.
 *
 * When the device is offline (useNetworkStore.isOnline === false),
 * `withCache` skips the network attempt entirely and returns stale data,
 * avoiding unnecessary timeout waits.
 */

import AsyncStorage from "@react-native-async-storage/async-storage";
import { useNetworkStore } from "../stores/networkStore";

const CACHE_PREFIX = "momentra-cache:";

interface CacheEntry<T> {
  data: T;
  timestamp: number;
  ttl: number;
}

/**
 * Default TTL: 5 minutes.
 */
const DEFAULT_TTL = 5 * 60 * 1000;

/**
 * Long TTL for rarely-changing data (categories, scenarios): 24 hours.
 */
export const LONG_TTL = 24 * 60 * 60 * 1000;

/**
 * TTL for active plan data: 1 hour.
 */
export const ACTIVE_PLAN_TTL = 60 * 60 * 1000;

// ── Core Operations ──────────────────────────────────────────────────

/**
 * Retrieve a cached value if it exists and has not expired.
 *
 * @param key     Cache key (without prefix).
 * @param maxAge  Maximum age in ms. Defaults to the TTL stored with the entry,
 *                but can be overridden here to enforce a stricter freshness check.
 * @returns       The cached data, or `null` if missing / expired / corrupt.
 */
export async function cacheGet<T>(
  key: string,
  maxAge?: number,
): Promise<T | null> {
  try {
    const raw = await AsyncStorage.getItem(CACHE_PREFIX + key);
    if (raw === null) return null;

    const entry: CacheEntry<T> = JSON.parse(raw);
    const effectiveTtl = maxAge ?? entry.ttl;
    const age = Date.now() - entry.timestamp;

    if (age > effectiveTtl) {
      return null;
    }

    return entry.data;
  } catch (err) {
    if (__DEV__) console.warn(`[cache] cacheGet failed for key "${key}":`, err);
    return null;
  }
}

/**
 * Store a value in the cache.
 *
 * @param key   Cache key (without prefix).
 * @param data  The value to cache (must be JSON-serialisable).
 * @param ttl   Time-to-live in ms. Defaults to 5 minutes.
 */
export async function cacheSet<T>(
  key: string,
  data: T,
  ttl: number = DEFAULT_TTL,
): Promise<void> {
  try {
    const entry: CacheEntry<T> = {
      data,
      timestamp: Date.now(),
      ttl,
    };
    await AsyncStorage.setItem(CACHE_PREFIX + key, JSON.stringify(entry));
  } catch {
    // Silently ignore storage errors — caching is best-effort.
  }
}

/**
 * Remove a single cache entry.
 */
export async function cacheDelete(key: string): Promise<void> {
  try {
    await AsyncStorage.removeItem(CACHE_PREFIX + key);
  } catch {
    // Best-effort removal.
  }
}

/**
 * Clear all entries created by this cache layer.
 * Other AsyncStorage keys are left untouched.
 */
export async function cacheClear(): Promise<void> {
  try {
    const allKeys = await AsyncStorage.getAllKeys();
    const cacheKeys = allKeys.filter((k) => k.startsWith(CACHE_PREFIX));
    if (cacheKeys.length > 0) {
      await Promise.all(cacheKeys.map((k) => AsyncStorage.removeItem(k)));
    }
  } catch {
    // Best-effort clear.
  }
}

// ── Higher-Order Cache Wrapper ───────────────────────────────────────

/**
 * Returns a function that implements a cache-first fetching strategy:
 *
 * 1. Check the cache for a valid (non-expired) entry.
 * 2. If found, return it immediately.
 * 3. If the device is offline, skip the network and return stale data if available.
 * 4. If not found or expired, call the `fetcher`.
 * 5. On success, store the result in the cache and return it.
 * 6. On network/fetcher error, fall back to stale cache data if available
 *    (graceful degradation). If no stale data exists either, re-throw.
 *
 * @param key      Cache key.
 * @param fetcher  Async function that produces fresh data.
 * @param ttl      Time-to-live in ms. Defaults to 5 minutes.
 */
export function withCache<T>(
  key: string,
  fetcher: () => Promise<T>,
  ttl: number = DEFAULT_TTL,
): () => Promise<T> {
  return async (): Promise<T> => {
    // 1. Try cache first
    const cached = await cacheGet<T>(key, ttl);
    if (cached !== null) {
      return cached;
    }

    // 2. If offline, skip network and return stale data immediately
    const isOnline = useNetworkStore.getState().isOnline;
    if (!isOnline) {
      const stale = await getStaleEntry<T>(key);
      if (stale !== null) {
        return stale;
      }
      throw new Error("offline");
    }

    // 3. Cache miss or expired — fetch fresh data
    try {
      const fresh = await fetcher();
      await cacheSet(key, fresh, ttl);
      return fresh;
    } catch (error) {
      // 4. Fetcher failed — attempt graceful degradation with stale cache
      const stale = await getStaleEntry<T>(key);
      if (stale !== null) {
        return stale;
      }
      throw error;
    }
  };
}

/**
 * Store multiple values in the cache in parallel.
 */
export async function cacheBulkSet<T>(
  entries: { key: string; data: T }[],
  ttl: number = DEFAULT_TTL,
): Promise<void> {
  await Promise.all(
    entries.map((entry) => cacheSet(entry.key, entry.data, ttl)),
  );
}

// ── Internal Helpers ─────────────────────────────────────────────────

/**
 * Retrieve a cache entry regardless of expiration (for graceful degradation).
 * Exported for stores that need stale data when offline.
 */
export async function cacheGetStale<T>(key: string): Promise<T | null> {
  return getStaleEntry<T>(key);
}

async function getStaleEntry<T>(key: string): Promise<T | null> {
  try {
    const raw = await AsyncStorage.getItem(CACHE_PREFIX + key);
    if (raw === null) return null;

    const entry: CacheEntry<T> = JSON.parse(raw);
    return entry.data;
  } catch (err) {
    if (__DEV__)
      console.warn(`[cache] getStaleEntry failed for key "${key}":`, err);
    return null;
  }
}
