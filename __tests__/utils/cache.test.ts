import AsyncStorage from '@react-native-async-storage/async-storage';
import { cacheGet, cacheSet, cacheClear, cacheDelete } from '../../src/utils/cache';
import { withCache } from '../../src/utils/cache';

const CACHE_PREFIX = 'momentra-cache:';

beforeEach(() => {
  (AsyncStorage as any).__resetStore();
  jest.restoreAllMocks();
});

// ── cacheSet / cacheGet ──────────────────────────────────────────────

describe('cache – cacheSet / cacheGet', () => {
  it('stores and retrieves a value', async () => {
    await cacheSet('test-key', { name: 'test' });
    const result = await cacheGet<{ name: string }>('test-key');

    expect(result).toEqual({ name: 'test' });
  });

  it('returns null for a key that does not exist', async () => {
    const result = await cacheGet('missing-key');
    expect(result).toBeNull();
  });

  it('stores primitive values', async () => {
    await cacheSet('number', 42);
    await cacheSet('string', 'hello');
    await cacheSet('bool', true);

    expect(await cacheGet<number>('number')).toBe(42);
    expect(await cacheGet<string>('string')).toBe('hello');
    expect(await cacheGet<boolean>('bool')).toBe(true);
  });

  it('stores arrays', async () => {
    const arr = [1, 2, 3];
    await cacheSet('array', arr);
    expect(await cacheGet<number[]>('array')).toEqual([1, 2, 3]);
  });

  it('uses the cache prefix for storage keys', async () => {
    await cacheSet('my-key', 'value');
    expect(AsyncStorage.setItem).toHaveBeenCalledWith(
      `${CACHE_PREFIX}my-key`,
      expect.any(String),
    );
  });

  it('stores entry with correct structure (data, timestamp, ttl)', async () => {
    const now = Date.now();
    jest.spyOn(Date, 'now').mockReturnValue(now);

    await cacheSet('structured', 'data', 60000);

    const raw = await AsyncStorage.getItem(`${CACHE_PREFIX}structured`);
    const entry = JSON.parse(raw!);

    expect(entry.data).toBe('data');
    expect(entry.timestamp).toBe(now);
    expect(entry.ttl).toBe(60000);
  });
});

// ── TTL expiration ───────────────────────────────────────────────────

describe('cache – TTL expiration', () => {
  it('returns null when the entry has expired', async () => {
    const pastTime = Date.now() - 10000; // 10 seconds ago
    jest.spyOn(Date, 'now').mockReturnValueOnce(pastTime);
    await cacheSet('expired', 'old-data', 5000); // TTL of 5 seconds

    // Now Date.now() returns the real (current) time, so the entry is expired
    jest.spyOn(Date, 'now').mockReturnValueOnce(pastTime + 6000);
    const result = await cacheGet('expired');
    expect(result).toBeNull();
  });

  it('returns the value when TTL has not yet expired', async () => {
    const now = Date.now();
    jest.spyOn(Date, 'now').mockReturnValue(now);

    await cacheSet('fresh', 'fresh-data', 60000);

    // Advance time by 30 seconds (still within 60s TTL)
    jest.spyOn(Date, 'now').mockReturnValue(now + 30000);
    const result = await cacheGet('fresh');
    expect(result).toBe('fresh-data');
  });

  it('respects maxAge override in cacheGet', async () => {
    const now = Date.now();
    jest.spyOn(Date, 'now').mockReturnValue(now);

    await cacheSet('override', 'data', 60000); // stored with 60s TTL

    // Advance time by 10 seconds
    jest.spyOn(Date, 'now').mockReturnValue(now + 10000);

    // With default TTL (60s), should still be valid
    expect(await cacheGet('override')).toBe('data');

    // With maxAge of 5 seconds, should be expired
    expect(await cacheGet('override', 5000)).toBeNull();
  });
});

// ── cacheDelete ──────────────────────────────────────────────────────

describe('cache – cacheDelete', () => {
  it('removes a single cache entry', async () => {
    await cacheSet('to-delete', 'value');
    await cacheDelete('to-delete');

    const result = await cacheGet('to-delete');
    expect(result).toBeNull();
  });

  it('does not throw when deleting a nonexistent key', async () => {
    await expect(cacheDelete('nonexistent')).resolves.toBeUndefined();
  });
});

// ── cacheClear ───────────────────────────────────────────────────────

describe('cache – cacheClear', () => {
  it('removes all cache entries', async () => {
    await cacheSet('key1', 'value1');
    await cacheSet('key2', 'value2');
    await cacheSet('key3', 'value3');

    await cacheClear();

    expect(await cacheGet('key1')).toBeNull();
    expect(await cacheGet('key2')).toBeNull();
    expect(await cacheGet('key3')).toBeNull();
  });

  it('does not remove non-cache keys from AsyncStorage', async () => {
    await AsyncStorage.setItem('other-app-key', 'important');
    await cacheSet('cache-key', 'cached');

    await cacheClear();

    // The cache entry should be gone
    expect(await cacheGet('cache-key')).toBeNull();
    // The non-cache key should remain
    const otherValue = await AsyncStorage.getItem('other-app-key');
    expect(otherValue).toBe('important');
  });
});

// ── withCache ────────────────────────────────────────────────────────

describe('cache – withCache', () => {
  it('calls the fetcher on cache miss and caches the result', async () => {
    const fetcher = jest.fn().mockResolvedValue({ items: [1, 2, 3] });
    const cachedFetch = withCache('api-data', fetcher, 60000);

    const result = await cachedFetch();

    expect(result).toEqual({ items: [1, 2, 3] });
    expect(fetcher).toHaveBeenCalledTimes(1);

    // Second call should use cache, not the fetcher
    const result2 = await cachedFetch();
    expect(result2).toEqual({ items: [1, 2, 3] });
    expect(fetcher).toHaveBeenCalledTimes(1);
  });

  it('returns cached data without calling the fetcher on cache hit', async () => {
    const now = Date.now();
    jest.spyOn(Date, 'now').mockReturnValue(now);

    await cacheSet('pre-cached', 'existing-data', 60000);

    const fetcher = jest.fn().mockResolvedValue('new-data');
    const cachedFetch = withCache('pre-cached', fetcher, 60000);

    const result = await cachedFetch();
    expect(result).toBe('existing-data');
    expect(fetcher).not.toHaveBeenCalled();
  });

  it('falls back to stale cache when fetcher throws', async () => {
    const now = Date.now();
    jest.spyOn(Date, 'now').mockReturnValue(now);

    // Store data with a short TTL
    await cacheSet('stale-test', 'stale-data', 1000);

    // Advance time past TTL
    jest.spyOn(Date, 'now').mockReturnValue(now + 2000);

    // Fetcher fails
    const fetcher = jest.fn().mockRejectedValue(new Error('Network error'));
    const cachedFetch = withCache('stale-test', fetcher, 1000);

    const result = await cachedFetch();
    // Should return stale data as graceful degradation
    expect(result).toBe('stale-data');
  });

  it('throws when fetcher fails and no stale cache exists', async () => {
    const fetcher = jest.fn().mockRejectedValue(new Error('Network error'));
    const cachedFetch = withCache('no-cache', fetcher, 60000);

    await expect(cachedFetch()).rejects.toThrow('Network error');
  });

  it('refreshes the cache when data expires and fetcher succeeds', async () => {
    const now = Date.now();
    jest.spyOn(Date, 'now').mockReturnValue(now);

    // First call populates cache
    const fetcher = jest.fn()
      .mockResolvedValueOnce('first')
      .mockResolvedValueOnce('second');

    const cachedFetch = withCache('refresh-test', fetcher, 5000);

    const result1 = await cachedFetch();
    expect(result1).toBe('first');

    // Advance time past TTL
    jest.spyOn(Date, 'now').mockReturnValue(now + 6000);

    const result2 = await cachedFetch();
    expect(result2).toBe('second');
    expect(fetcher).toHaveBeenCalledTimes(2);
  });
});
