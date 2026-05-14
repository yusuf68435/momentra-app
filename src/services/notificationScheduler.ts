import * as Notifications from "expo-notifications";
import { Platform } from "react-native";

import {
  saveNotificationId,
  getNotificationIds,
  removeNotificationIds,
} from "../utils/notificationStore";
import { requestNotificationPermission } from "../utils/notifications";
import { useSettingsStore } from "../stores/settingsStore";

// ──────────────────────────────────────────────
// Types
// ──────────────────────────────────────────────

interface CountdownMilestone {
  days: number;
  titleTr: string;
  titleEn: string;
  bodyTr: (planTitle: string) => string;
  bodyEn: (planTitle: string) => string;
  emoji: string;
  channel: string;
}

type NotificationType = "countdown_reminder" | "checklist_reminder";

interface NotificationData {
  planId: string;
  type: NotificationType;
  milestoneDays?: number;
  itemTitle?: string;
  [key: string]: unknown;
}

// ──────────────────────────────────────────────
// Constants
// ──────────────────────────────────────────────

const COUNTDOWN_MILESTONES: CountdownMilestone[] = [
  {
    days: 14,
    titleTr: "2 hafta kaldı!",
    titleEn: "2 weeks to go!",
    bodyTr: (t) => `"${t}" için 14 gün kaldı. Her şey yolunda mı?`,
    bodyEn: (t) => `14 days until "${t}". Are you on track?`,
    emoji: "\u{1F4C5}",
    channel: "countdown",
  },
  {
    days: 7,
    titleTr: "1 hafta kaldı!",
    titleEn: "1 week to go!",
    bodyTr: (t) => `"${t}" için 7 gün kaldı. Hazırlıkları kontrol et!`,
    bodyEn: (t) => `7 days until "${t}". Are you on track?`,
    emoji: "\u{1F514}",
    channel: "countdown",
  },
  {
    days: 3,
    titleTr: "3 gün kaldı!",
    titleEn: "3 days to go!",
    bodyTr: (t) => `"${t}" için sadece 3 gün kaldı. Son hazırlıkları yap!`,
    bodyEn: (t) => `3 days until "${t}". Are you on track?`,
    emoji: "\u{26A1}",
    channel: "countdown",
  },
  {
    days: 1,
    titleTr: "Yarın büyük gün!",
    titleEn: "Tomorrow is the big day!",
    bodyTr: (t) => `"${t}" için yarın! Her şeyin hazır olduğundan emin ol.`,
    bodyEn: (t) =>
      `Tomorrow is the day for "${t}"! Make sure everything is ready.`,
    emoji: "\u{1F389}",
    channel: "surprises",
  },
];

const REMINDER_HOUR = 9;
const REMINDER_MINUTE = 0;

const MS_PER_DAY = 86_400_000;

// ──────────────────────────────────────────────
// Storage key helpers
// ──────────────────────────────────────────────

function countdownStoreKey(planId: string): string {
  return `scheduler:countdown:${planId}`;
}

function checklistStoreKey(planId: string, itemTitle: string): string {
  return `scheduler:checklist:${planId}:${itemTitle}`;
}

// ──────────────────────────────────────────────
// Internal helpers
// ──────────────────────────────────────────────

/**
 * Compute the trigger date for a milestone: `milestoneDays` days before `eventDate`, at 09:00.
 * Returns null if the resulting date is in the past.
 */
function computeTriggerDate(eventDate: Date, daysBefore: number): Date | null {
  const trigger = new Date(eventDate.getTime() - daysBefore * MS_PER_DAY);
  trigger.setHours(REMINDER_HOUR, REMINDER_MINUTE, 0, 0);

  if (trigger <= new Date()) {
    return null;
  }
  return trigger;
}

/**
 * Cancel all notifications stored under a given key and remove the persisted IDs.
 */
async function cancelStoredNotifications(storeKey: string): Promise<void> {
  const ids = await getNotificationIds(storeKey);

  for (const id of ids) {
    try {
      await Notifications.cancelScheduledNotificationAsync(id);
    } catch {
      // Notification may have already fired or been dismissed
    }
  }

  await removeNotificationIds(storeKey);
}

/**
 * Schedule a single local notification and persist its ID.
 */
async function scheduleAndPersist(
  storeKey: string,
  title: string,
  body: string,
  data: NotificationData,
  triggerDate: Date,
  channelId: string,
): Promise<string> {
  const notificationId = await Notifications.scheduleNotificationAsync({
    content: {
      title,
      body,
      data,
      sound: "default",
      ...(Platform.OS === "android" ? { channelId } : {}),
    },
    trigger: {
      type: Notifications.SchedulableTriggerInputTypes.DATE,
      date: triggerDate,
    },
  });

  await saveNotificationId(storeKey, notificationId);
  return notificationId;
}

// ──────────────────────────────────────────────
// Public API
// ──────────────────────────────────────────────

/**
 * Schedule countdown reminder notifications at key intervals before the event:
 * 14 days, 7 days, 3 days, and 1 day before.
 *
 * Skips any milestone whose trigger date is already in the past.
 * Persists notification IDs in AsyncStorage keyed by planId for later cleanup.
 *
 * @returns Array of scheduled notification identifiers.
 */
export async function scheduleCountdownReminders(
  planId: string,
  eventDate: Date,
  title: string,
): Promise<string[]> {
  const hasPermission = await requestNotificationPermission();
  if (!hasPermission) return [];

  const storeKey = countdownStoreKey(planId);
  const scheduledIds: string[] = [];
  const isTurkish = useSettingsStore.getState().language === "tr";

  for (const milestone of COUNTDOWN_MILESTONES) {
    const triggerDate = computeTriggerDate(eventDate, milestone.days);
    if (!triggerDate) continue;

    const milestoneTitle = isTurkish ? milestone.titleTr : milestone.titleEn;
    const notifTitle = `${milestone.emoji} ${milestoneTitle}`;
    const notifBody = isTurkish
      ? milestone.bodyTr(title)
      : milestone.bodyEn(title);

    const data: NotificationData = {
      planId,
      type: "countdown_reminder",
      milestoneDays: milestone.days,
    };

    const id = await scheduleAndPersist(
      storeKey,
      notifTitle,
      notifBody,
      data,
      triggerDate,
      milestone.channel,
    );

    scheduledIds.push(id);
  }

  if (__DEV__) {
    // eslint-disable-next-line no-console
    console.log(
      `[NotificationScheduler] Scheduled ${scheduledIds.length} countdown reminders for plan ${planId}`,
    );
  }

  return scheduledIds;
}

/**
 * Schedule a reminder notification for a specific checklist item.
 *
 * The notification fires at 09:00 on the due date. If the due date is in the
 * past, nothing is scheduled.
 *
 * @returns The notification identifier, or null if the date is in the past
 *          or permissions were denied.
 */
export async function scheduleChecklistReminder(
  planId: string,
  itemTitle: string,
  dueDate: Date,
): Promise<string | null> {
  const hasPermission = await requestNotificationPermission();
  if (!hasPermission) return null;

  const triggerDate = new Date(dueDate);
  triggerDate.setHours(REMINDER_HOUR, REMINDER_MINUTE, 0, 0);

  if (triggerDate <= new Date()) return null;

  const storeKey = checklistStoreKey(planId, itemTitle);

  // Cancel any existing reminder for this checklist item
  await cancelStoredNotifications(storeKey);

  const data: NotificationData = {
    planId,
    type: "checklist_reminder",
    itemTitle,
  };

  const isTurkish = useSettingsStore.getState().language === "tr";
  const checklistTitle = isTurkish
    ? "\u{1F4CB} Görev Hatırlatıcı"
    : "\u{1F4CB} Task Reminder";
  const checklistBody = isTurkish
    ? `"${itemTitle}" görevini tamamlamayı unutma!`
    : `Don't forget to complete "${itemTitle}"!`;

  const id = await scheduleAndPersist(
    storeKey,
    checklistTitle,
    checklistBody,
    data,
    triggerDate,
    "surprises",
  );

  if (__DEV__) {
    // eslint-disable-next-line no-console
    console.log(
      `[NotificationScheduler] Scheduled checklist reminder for "${itemTitle}" (plan ${planId})`,
    );
  }

  return id;
}

/**
 * Cancel all scheduled notifications associated with a plan.
 *
 * This scans all scheduled notifications by their data payload and also
 * cleans up persisted notification IDs from AsyncStorage.
 */
export async function cancelPlanNotifications(planId: string): Promise<void> {
  // 1. Cancel via persisted countdown IDs
  await cancelStoredNotifications(countdownStoreKey(planId));

  // 2. Scan all scheduled notifications for any with matching planId
  //    (covers checklist reminders and any other notifications for this plan)
  const allScheduled = await Notifications.getAllScheduledNotificationsAsync();
  const matching = allScheduled.filter((n) => {
    const data = n.content.data as Record<string, unknown> | undefined;
    return data?.planId === planId;
  });

  for (const n of matching) {
    try {
      await Notifications.cancelScheduledNotificationAsync(n.identifier);
    } catch {
      // Already fired or dismissed
    }
  }

  if (__DEV__) {
    // eslint-disable-next-line no-console
    console.log(
      `[NotificationScheduler] Cancelled ${matching.length} notifications for plan ${planId}`,
    );
  }
}

/**
 * Reschedule all countdown reminders when the event date changes.
 *
 * Cancels existing countdown notifications for the plan, then schedules
 * new ones based on the updated date.
 *
 * @returns Array of newly scheduled notification identifiers.
 */
export async function rescheduleAllReminders(
  planId: string,
  newDate: Date,
  title: string,
): Promise<string[]> {
  // Cancel existing countdown reminders
  await cancelStoredNotifications(countdownStoreKey(planId));

  // Schedule fresh countdown reminders with the new date
  return scheduleCountdownReminders(planId, newDate, title);
}
