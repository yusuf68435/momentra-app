import AsyncStorage from '@react-native-async-storage/async-storage';
import { useNetworkStore } from '../stores/networkStore';

const QUEUE_KEY = 'momentra:offline_queue';
const MAX_RETRY_COUNT = 5;

interface QueuedOperation {
  id: string;
  type: 'create' | 'update' | 'delete';
  table: string;
  payload: Record<string, unknown>;
  timestamp: number;
  retryCount: number;
}

let isProcessing = false;
let unsubscribe: (() => void) | null = null;

/**
 * Add an operation to the offline queue.
 * Called when a mutation fails due to network error.
 */
export async function enqueueOperation(
  type: QueuedOperation['type'],
  table: string,
  payload: Record<string, unknown>,
): Promise<void> {
  const queue = await getQueue();
  const operation: QueuedOperation = {
    id: `${Date.now().toString(36)}-${performance.now().toString(36).replace('.', '')}`,
    type,
    table,
    payload,
    timestamp: Date.now(),
    retryCount: 0,
  };
  queue.push(operation);
  await AsyncStorage.setItem(QUEUE_KEY, JSON.stringify(queue));
}

/**
 * Get all queued operations.
 */
export async function getQueue(): Promise<QueuedOperation[]> {
  try {
    const raw = await AsyncStorage.getItem(QUEUE_KEY);
    return raw ? JSON.parse(raw) : [];
  } catch {
    return [];
  }
}

/**
 * Get count of pending operations.
 */
export async function getPendingCount(): Promise<number> {
  const queue = await getQueue();
  return queue.length;
}

/**
 * Process all queued operations when back online.
 */
export async function processQueue(
  executor: (op: QueuedOperation) => Promise<boolean>,
): Promise<{ succeeded: number; failed: number }> {
  if (isProcessing) return { succeeded: 0, failed: 0 };
  isProcessing = true;

  let succeeded = 0;
  let failed = 0;

  try {
    const queue = await getQueue();
    if (queue.length === 0) return { succeeded: 0, failed: 0 };

    const remaining: QueuedOperation[] = [];

    for (const op of queue) {
      try {
        const success = await executor(op);
        if (success) {
          succeeded++;
        } else {
          op.retryCount++;
          if (op.retryCount < MAX_RETRY_COUNT) {
            remaining.push(op);
          }
          failed++;
        }
      } catch {
        op.retryCount++;
        if (op.retryCount < MAX_RETRY_COUNT) {
          remaining.push(op);
        }
        failed++;
      }
    }

    await AsyncStorage.setItem(QUEUE_KEY, JSON.stringify(remaining));
  } finally {
    isProcessing = false;
  }

  return { succeeded, failed };
}

/**
 * Clear all queued operations.
 */
export async function clearQueue(): Promise<void> {
  await AsyncStorage.removeItem(QUEUE_KEY);
}

/**
 * Start listening for network changes to auto-process queue.
 * Uses the existing useNetworkStore (zustand subscribe) instead of NetInfo.
 */
export function startQueueListener(
  executor: (op: QueuedOperation) => Promise<boolean>,
  onProcessed?: (result: { succeeded: number; failed: number }) => void,
): void {
  if (unsubscribe) return;

  unsubscribe = useNetworkStore.subscribe(async (state, prevState) => {
    const cameOnline = state.isOnline && !prevState.isOnline;
    if (cameOnline) {
      const count = await getPendingCount();
      if (count > 0) {
        const result = await processQueue(executor);
        if (onProcessed && (result.succeeded > 0 || result.failed > 0)) {
          onProcessed(result);
        }
      }
    }
  });
}

/**
 * Stop the queue listener.
 */
export function stopQueueListener(): void {
  if (unsubscribe) {
    unsubscribe();
    unsubscribe = null;
  }
}
