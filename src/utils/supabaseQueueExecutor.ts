import { supabase } from "../services/supabase";
import { startQueueListener, stopQueueListener } from "./offlineQueue";

type QueuedOperation = {
  id: string;
  type: "create" | "update" | "delete";
  table: string;
  payload: Record<string, unknown>;
  timestamp: number;
  retryCount: number;
};

// Tables that are safe to replay offline operations on
const ALLOWED_TABLES = new Set([
  "plan_checklist_items",
  "plan_expenses",
  "plan_photos",
  "guest_invitations",
  "music_playlist_songs",
  "voice_notes",
  "emoji_reactions",
  "important_dates",
]);

/**
 * Executes a queued offline operation against Supabase.
 * Returns true on success, false on retriable failure.
 */
async function executeOperation(op: QueuedOperation): Promise<boolean> {
  if (!ALLOWED_TABLES.has(op.table)) return false;

  try {
    if (op.type === "create") {
      const { error } = await supabase.from(op.table).insert(op.payload);
      if (error) {
        // Conflict (already inserted) — treat as success to drop from queue
        if (error.code === "23505") return true;
        return false;
      }
      return true;
    }

    if (op.type === "update") {
      const { id, ...updates } = op.payload;
      if (!id) return false;
      const { error } = await supabase
        .from(op.table)
        .update(updates)
        .eq("id", id as string);
      if (error) return false;
      return true;
    }

    if (op.type === "delete") {
      const { id } = op.payload;
      if (!id) return false;
      const { error } = await supabase
        .from(op.table)
        .delete()
        .eq("id", id as string);
      if (error) return false;
      return true;
    }

    return false;
  } catch {
    return false;
  }
}

let listenerStarted = false;

/**
 * Starts the offline queue listener. Call once when the authenticated
 * user session is established. The listener auto-processes queued operations
 * whenever the app comes back online.
 */
export function initOfflineQueueSync(
  onProcessed?: (result: { succeeded: number; failed: number }) => void,
): void {
  if (listenerStarted) return;
  listenerStarted = true;
  startQueueListener(executeOperation, onProcessed);
}

/**
 * Stops the offline queue listener. Call on logout.
 */
export function teardownOfflineQueueSync(): void {
  stopQueueListener();
  listenerStarted = false;
}
