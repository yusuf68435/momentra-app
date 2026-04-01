import { useEffect, useRef } from 'react';
import { AppState, AppStateStatus } from 'react-native';
import { useNetworkStore } from '../stores/networkStore';

// Ping the Supabase health endpoint — same domain we already talk to
const PING_URL = process.env.EXPO_PUBLIC_SUPABASE_URL
  ? `${process.env.EXPO_PUBLIC_SUPABASE_URL}/health`
  : 'https://httpbin.org/status/200';

const POLL_INTERVAL_MS = 30_000; // 30 s while in foreground
const TIMEOUT_MS = 5_000;

async function checkConnectivity(): Promise<boolean> {
  try {
    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), TIMEOUT_MS);
    const res = await fetch(PING_URL, {
      method: 'HEAD',
      signal: controller.signal,
      cache: 'no-store',
    });
    clearTimeout(timer);
    // Any HTTP response (even 4xx from Supabase) means we have a connection
    return true;
  } catch {
    return false;
  }
}

/**
 * Starts network connectivity polling and updates `useNetworkStore`.
 * Call once at the root layout level — returns nothing.
 */
export function useNetworkStatus(): void {
  const setOnline = useNetworkStore((s) => s.setOnline);
  const appState = useRef<AppStateStatus>(AppState.currentState);
  const intervalRef = useRef<ReturnType<typeof setInterval> | null>(null);

  const runCheck = async () => {
    const online = await checkConnectivity();
    setOnline(online);
  };

  const startPolling = () => {
    runCheck();
    if (intervalRef.current) clearInterval(intervalRef.current);
    intervalRef.current = setInterval(runCheck, POLL_INTERVAL_MS);
  };

  const stopPolling = () => {
    if (intervalRef.current) {
      clearInterval(intervalRef.current);
      intervalRef.current = null;
    }
  };

  useEffect(() => {
    // Start polling immediately
    startPolling();

    const subscription = AppState.addEventListener('change', (nextState: AppStateStatus) => {
      const wasBackground = appState.current.match(/inactive|background/);
      const isNowActive = nextState === 'active';

      if (wasBackground && isNowActive) {
        // Re-check immediately when app comes to foreground
        startPolling();
      } else if (nextState.match(/inactive|background/)) {
        stopPolling();
      }

      appState.current = nextState;
    });

    return () => {
      stopPolling();
      subscription.remove();
    };
  }, []);
}
