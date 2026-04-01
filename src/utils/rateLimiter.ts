/**
 * Creates a debounced version of a function.
 * The function will only be called after `delay` ms have passed
 * since the last invocation.
 */
export function debounce<T extends (...args: unknown[]) => unknown>(
  fn: T,
  delay: number,
): T & { cancel: () => void } {
  let timeoutId: ReturnType<typeof setTimeout> | null = null;

  const debounced = ((...args: unknown[]) => {
    if (timeoutId) clearTimeout(timeoutId);
    timeoutId = setTimeout(() => {
      fn(...args);
      timeoutId = null;
    }, delay);
  }) as T & { cancel: () => void };

  debounced.cancel = () => {
    if (timeoutId) {
      clearTimeout(timeoutId);
      timeoutId = null;
    }
  };

  return debounced;
}

/**
 * Creates a throttled version of a function.
 * The function will be called at most once every `limit` ms.
 */
export function throttle<T extends (...args: unknown[]) => unknown>(
  fn: T,
  limit: number,
): T {
  let inThrottle = false;
  let lastArgs: unknown[] | null = null;

  return ((...args: unknown[]) => {
    if (!inThrottle) {
      fn(...args);
      inThrottle = true;
      setTimeout(() => {
        inThrottle = false;
        if (lastArgs) {
          fn(...lastArgs);
          lastArgs = null;
        }
      }, limit);
    } else {
      lastArgs = args;
    }
  }) as T;
}

/**
 * Request coalescer - combines multiple rapid calls into one.
 * Returns a cached promise if called again before the first resolves.
 */
export function coalesce<T>(
  fn: () => Promise<T>,
  ttlMs: number = 1000,
): () => Promise<T> {
  let cached: Promise<T> | null = null;
  let cacheTime = 0;

  return () => {
    const now = Date.now();
    if (cached && now - cacheTime < ttlMs) {
      return cached;
    }
    cacheTime = now;
    cached = fn().finally(() => {
      setTimeout(() => {
        cached = null;
      }, ttlMs);
    });
    return cached;
  };
}
