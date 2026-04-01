/**
 * Sentry error tracking wrapper.
 *
 * Gracefully handles the case where @sentry/react-native is not yet installed.
 * In __DEV__ mode, logs to console instead of sending to Sentry.
 */

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------

interface SentryModule {
  init: (options: Record<string, unknown>) => void;
  captureException: (error: Error, context?: Record<string, unknown>) => void;
  captureMessage: (message: string, level: string) => void;
  setUser: (user: { id: string; email?: string } | null) => void;
  withScope: (callback: (scope: SentryScope) => void) => void;
}

interface SentryScope {
  setExtras: (extras: Record<string, unknown>) => void;
}

type MessageLevel = 'info' | 'warning' | 'error';

// ---------------------------------------------------------------------------
// Lazy Sentry reference
// ---------------------------------------------------------------------------

let _sentry: SentryModule | null = null;
let _sentryLoaded = false;

function getSentry(): SentryModule | null {
  if (_sentryLoaded) return _sentry;
  _sentryLoaded = true;

  try {
    // Dynamic require - only succeeds when the package is installed.
    // eslint-disable-next-line @typescript-eslint/no-require-imports
    _sentry = require('@sentry/react-native') as SentryModule;
  } catch {
    _sentry = null;
  }

  return _sentry;
}

// ---------------------------------------------------------------------------
// Public API
// ---------------------------------------------------------------------------

/**
 * Initialize Sentry with DSN from EXPO_PUBLIC_SENTRY_DSN environment variable.
 * No-ops in __DEV__ or when the package is not installed.
 */
export function initErrorTracking(): void {
  if (__DEV__) {
    console.warn('[ErrorTracking] Skipping Sentry init in __DEV__ mode');
    return;
  }

  const sentry = getSentry();
  if (!sentry) return;

  const dsn = process.env.EXPO_PUBLIC_SENTRY_DSN;
  if (!dsn) return;

  sentry.init({
    dsn,
    enableAutoSessionTracking: true,
    tracesSampleRate: 0.2,
  });
}

/**
 * Capture an error with optional context metadata.
 */
export function captureError(
  error: Error,
  context?: Record<string, unknown>,
): void {
  if (__DEV__) {
    console.error('[ErrorTracking] captureError:', error, context);
    return;
  }

  const sentry = getSentry();
  if (!sentry) return;

  if (context) {
    sentry.withScope((scope) => {
      scope.setExtras(context);
      sentry.captureException(error);
    });
  } else {
    sentry.captureException(error);
  }
}

/**
 * Capture a message at the given severity level.
 */
export function captureMessage(
  message: string,
  level: MessageLevel = 'info',
): void {
  if (__DEV__) {
    const logFn = level === 'error' ? console.error : console.warn;
    logFn(`[ErrorTracking] captureMessage (${level}): ${message}`);
    return;
  }

  const sentry = getSentry();
  if (!sentry) return;

  sentry.captureMessage(message, level);
}

/**
 * Set user context for subsequent error reports.
 */
export function setUser(userId: string, email?: string): void {
  if (__DEV__) {
    console.warn(`[ErrorTracking] setUser: ${userId}`);
    return;
  }

  const sentry = getSentry();
  if (!sentry) return;

  sentry.setUser({ id: userId, email });
}

/**
 * Clear user context (e.g. on sign-out).
 */
export function clearUser(): void {
  if (__DEV__) {
    console.warn('[ErrorTracking] clearUser');
    return;
  }

  const sentry = getSentry();
  if (!sentry) return;

  sentry.setUser(null);
}
