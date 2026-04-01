/**
 * Push Notification Client Service
 *
 * Calls the send-push edge function to deliver push notifications
 * to specific users via Expo Push API.
 */

import { supabase } from "./supabase";
import { getCurrentUserId } from "./helpers";

// ── Types ────────────────────────────────────────────────────────────

interface SendPushResult {
  sent: number;
  failed: number;
  total: number;
}

interface PushData {
  type?: string;
  planId?: string;
  [key: string]: unknown;
}

// ── Core ─────────────────────────────────────────────────────────────

/**
 * Send push notification to specific users via send-push edge function.
 * Silently fails in dev mode to avoid blocking UI.
 */
export async function sendPushToUsers(
  targetUserIds: string[],
  title: string,
  messageBody: string,
  data?: PushData,
  channelId?: string,
): Promise<SendPushResult | null> {
  if (targetUserIds.length === 0) return null;

  try {
    const { data: result, error } = await supabase.functions.invoke(
      "send-push",
      {
        body: {
          targetUserIds,
          title,
          messageBody,
          data: data ?? {},
          channelId: channelId ?? "surprises",
        },
      },
    );

    if (error) {
      if (__DEV__) {
        console.warn("[Push] Failed to send push notification:", error);
      }
      return null;
    }

    return result as SendPushResult;
  } catch (error) {
    if (__DEV__) {
      console.warn("[Push] Edge function call failed:", error);
    }
    return null;
  }
}

// ── Convenience helpers ──────────────────────────────────────────────

/**
 * Notify all co-organizers of a plan (excluding the current user).
 */
export async function notifyCoOrganizers(
  planId: string,
  title: string,
  messageBody: string,
  extraData?: PushData,
): Promise<void> {
  try {
    const currentUserId = await getCurrentUserId();

    const { data: coOrgs, error } = await supabase
      .from("co_organizers")
      .select("user_id")
      .eq("plan_id", planId)
      .eq("status", "accepted")
      .not("user_id", "is", null);

    if (error || !coOrgs) return;

    const userIds = coOrgs
      .map((c: { user_id: string | null }) => c.user_id)
      .filter((id): id is string => id !== null && id !== currentUserId);

    if (userIds.length === 0) return;

    await sendPushToUsers(userIds, title, messageBody, {
      type: "co_organizer",
      planId,
      ...extraData,
    });
  } catch {
    // Push is best-effort — never block the main operation
  }
}

/**
 * Notify the owner of a plan (e.g., when a guest RSVPs).
 */
export async function notifyPlanOwner(
  planId: string,
  title: string,
  messageBody: string,
  extraData?: PushData,
): Promise<void> {
  try {
    const currentUserId = await getCurrentUserId();

    const { data: plan, error } = await supabase
      .from("plans")
      .select("user_id")
      .eq("id", planId)
      .single();

    if (error || !plan) return;

    // Don't notify yourself
    if (plan.user_id === currentUserId) return;

    await sendPushToUsers([plan.user_id], title, messageBody, {
      type: "plan_update",
      planId,
      ...extraData,
    });
  } catch {
    // Push is best-effort
  }
}
