import * as Notifications from "expo-notifications";
import { Platform } from "react-native";

import {
  saveNotificationId,
  getNotificationIds,
  removeNotificationIds,
} from "../utils/notificationStore";
import {
  requestNotificationPermission,
  cancelPlanNotifications,
} from "../utils/notifications";

// ──────────────────────────────────────────────
// Types
// ──────────────────────────────────────────────

import type { SupportedLanguage } from "../constants/config";
type Language = SupportedLanguage;

interface DateTypeLabels {
  birthday: { tr: string; en: string };
  anniversary: { tr: string; en: string };
  graduation: { tr: string; en: string };
  other: { tr: string; en: string };
}

const DATE_TYPE_LABELS: DateTypeLabels = {
  birthday: { tr: "doğum günü", en: "birthday" },
  anniversary: { tr: "yıl dönümü", en: "anniversary" },
  graduation: { tr: "mezuniyet", en: "graduation" },
  other: { tr: "özel günü", en: "special day" },
};

const DATE_TYPE_EMOJI: Record<string, string> = {
  birthday: "🎂",
  anniversary: "💍",
  graduation: "🎓",
  other: "📅",
};

// Android notification channel for important-date reminders
const IMPORTANT_DATES_CHANNEL = "important_dates";

// ──────────────────────────────────────────────
// Helpers
// ──────────────────────────────────────────────

/**
 * Compute the next occurrence of a month/day combination.
 * If the date has already passed this year, returns next year's occurrence.
 * The returned Date is set to 09:00 local time.
 */
function getNextOccurrence(month: number, day: number): Date {
  const now = new Date();
  const thisYear = now.getFullYear();

  let target = new Date(thisYear, month - 1, day, 9, 0, 0, 0);

  // If the date already passed (or is right now), push to next year
  if (target <= now) {
    target = new Date(thisYear + 1, month - 1, day, 9, 0, 0, 0);
  }

  return target;
}

/**
 * Subtract `days` from a Date and clamp to 09:00.
 * If the resulting date is in the past, returns null.
 */
function subtractDays(date: Date, days: number): Date | null {
  const result = new Date(date);
  result.setDate(result.getDate() - days);
  result.setHours(9, 0, 0, 0);

  if (result <= new Date()) {
    return null;
  }
  return result;
}

// ──────────────────────────────────────────────
// Setup
// ──────────────────────────────────────────────

/**
 * Configure the foreground notification handler and create the
 * Android notification channel for important-date reminders.
 *
 * Call once in the app entry point (e.g. _layout.tsx).
 */
export function setupNotificationHandler(): void {
  try {
    Notifications.setNotificationHandler({
      handleNotification: async () => ({
        // Deprecated `shouldShowAlert` removed — iOS 26 / SDK 54 expo-notifications
        // prefer the new shouldShowBanner + shouldShowList split.
        shouldPlaySound: true,
        shouldSetBadge: true,
        shouldShowBanner: true,
        shouldShowList: true,
      }),
    });
  } catch (error) {
    if (__DEV__) {
      console.warn("[Notifications] setNotificationHandler failed:", error);
    }
  }

  if (Platform.OS === "android") {
    // Each channel call is best-effort — a single channel failure must not
    // prevent the others from being registered or crash app startup.
    Notifications.setNotificationChannelAsync(IMPORTANT_DATES_CHANNEL, {
      name: "Important Date Reminders",
      importance: Notifications.AndroidImportance.HIGH,
      vibrationPattern: [0, 250, 250, 250],
      lightColor: "#E91E63",
      sound: "default",
    }).catch(() => {});
    Notifications.setNotificationChannelAsync("countdown", {
      name: "Plan Countdown Reminders",
      importance: Notifications.AndroidImportance.DEFAULT,
      lightColor: "#FF6B8A",
      sound: "default",
    }).catch(() => {});
    Notifications.setNotificationChannelAsync("surprises", {
      name: "Surprise Reminders",
      importance: Notifications.AndroidImportance.HIGH,
      vibrationPattern: [0, 250, 250, 250],
      lightColor: "#FFAA5C",
      sound: "default",
    }).catch(() => {});
  }
}

// ──────────────────────────────────────────────
// Important Date Reminders
// ──────────────────────────────────────────────

/**
 * Schedule a local notification reminding the user about an important date.
 *
 * The notification fires `notifyDaysBefore` days before the next occurrence
 * of the given month/day, at 09:00 local time.
 *
 * @returns The scheduled notification identifier, or null if the trigger
 *          date is in the past or permissions were denied.
 */
export async function scheduleImportantDateReminder(
  dateId: string,
  personName: string,
  dateType: string,
  month: number,
  day: number,
  notifyDaysBefore: number,
  language: Language,
): Promise<string | null> {
  const hasPermission = await requestNotificationPermission();
  if (!hasPermission) return null;

  const nextOccurrence = getNextOccurrence(month, day);
  const triggerDate = subtractDays(nextOccurrence, notifyDaysBefore);

  if (!triggerDate) return null;

  const emoji = DATE_TYPE_EMOJI[dateType] ?? "📅";
  const typeLabel =
    (DATE_TYPE_LABELS as unknown as Record<string, Record<string, string>>)[
      dateType
    ]?.[language] ?? (language === "tr" ? "özel günü" : "special day");

  const daysText =
    notifyDaysBefore === 1
      ? language === "tr"
        ? "yarın"
        : "tomorrow"
      : language === "tr"
        ? `${notifyDaysBefore} gün sonra`
        : `in ${notifyDaysBefore} days`;

  const title =
    language === "tr"
      ? `${emoji} Yaklaşan özel gün!`
      : `${emoji} Upcoming special day!`;

  const body =
    language === "tr"
      ? `${personName}'${getApostrophe(personName)}${typeLabel} ${daysText}!`
      : `${personName}'s ${typeLabel} is ${daysText}!`;

  const notificationId = await Notifications.scheduleNotificationAsync({
    content: {
      title,
      body,
      data: { dateId, type: "important_date_reminder" },
      sound: "default",
      ...(Platform.OS === "android"
        ? { channelId: IMPORTANT_DATES_CHANNEL }
        : {}),
    },
    trigger: {
      type: Notifications.SchedulableTriggerInputTypes.DATE,
      date: triggerDate,
    },
  });

  await saveNotificationId(dateId, notificationId);
  return notificationId;
}

/**
 * Cancel all scheduled notifications associated with a specific important date
 * and clean up the persisted mapping.
 */
export async function cancelDateNotifications(dateId: string): Promise<void> {
  const ids = await getNotificationIds(dateId);

  for (const id of ids) {
    try {
      await Notifications.cancelScheduledNotificationAsync(id);
    } catch {
      // Notification may have already fired or been dismissed
    }
  }

  await removeNotificationIds(dateId);
}

// ──────────────────────────────────────────────
// Plan Reminders
// ──────────────────────────────────────────────

/**
 * Schedule a reminder notification for a plan, firing `hoursBefore` hours
 * before the plan date.
 *
 * @returns The notification identifier, or null if the trigger time is in the
 *          past or permissions were denied.
 */
export async function schedulePlanReminder(
  planId: string,
  planTitle: string,
  planDate: Date,
  hoursBefore: number,
  language: Language,
): Promise<string | null> {
  const hasPermission = await requestNotificationPermission();
  if (!hasPermission) return null;

  const triggerDate = new Date(planDate.getTime() - hoursBefore * 3_600_000);

  if (triggerDate <= new Date()) return null;

  const hoursText =
    language === "tr" ? `${hoursBefore} saat sonra` : `in ${hoursBefore} hours`;

  const title = language === "tr" ? "📋 Plan hatırlatması" : "📋 Plan reminder";

  const body =
    language === "tr"
      ? `'${planTitle}' planınız ${hoursText}!`
      : `Your plan '${planTitle}' is ${hoursText}!`;

  const notificationId = await Notifications.scheduleNotificationAsync({
    content: {
      title,
      body,
      data: { planId, type: "plan_reminder" },
      sound: "default",
      ...(Platform.OS === "android" ? { channelId: "surprises" } : {}),
    },
    trigger: {
      type: Notifications.SchedulableTriggerInputTypes.DATE,
      date: triggerDate,
    },
  });

  await saveNotificationId(planId, notificationId);
  return notificationId;
}

/**
 * Cancel all plan reminder notifications (both from this service's store and
 * the existing utility that matches by data payload).
 */
export async function cancelPlanReminders(planId: string): Promise<void> {
  // Cancel via persisted IDs
  const ids = await getNotificationIds(planId);
  for (const id of ids) {
    try {
      await Notifications.cancelScheduledNotificationAsync(id);
    } catch {
      // Already fired / dismissed
    }
  }
  await removeNotificationIds(planId);

  // Also delegate to the existing utility which scans by data.planId
  await cancelPlanNotifications(planId);
}

// ──────────────────────────────────────────────
// Proactive Reminders (30d & 14d before)
// ──────────────────────────────────────────────

interface ProactiveDate {
  id: string;
  person_name: string;
  date_type: string;
  date_month: number;
  date_day: number;
  daysUntil: number;
  suggestedCategories: string[];
}

/**
 * Schedule proactive reminders at 30 days and 14 days before
 * upcoming important dates, with scenario suggestions.
 *
 * Cancels previously scheduled proactive reminders for each date
 * before scheduling new ones to avoid duplicates.
 */
export async function scheduleProactiveReminders(
  dates: ProactiveDate[],
  language: Language,
): Promise<void> {
  const hasPermission = await requestNotificationPermission();
  if (!hasPermission) return;

  for (const date of dates) {
    const proactiveKey = `proactive:${date.id}`;

    // Cancel previous proactive notifications for this date
    const existingIds = await getNotificationIds(proactiveKey);
    for (const id of existingIds) {
      try {
        await Notifications.cancelScheduledNotificationAsync(id);
      } catch {
        /* already fired */
      }
    }
    await removeNotificationIds(proactiveKey);

    const nextOccurrence = getNextOccurrence(date.date_month, date.date_day);

    for (const daysBefore of [30, 14]) {
      if (date.daysUntil > daysBefore) continue; // already past this window
      if (date.daysUntil < daysBefore - 1) continue; // too far in the future for this trigger

      const triggerDate = subtractDays(nextOccurrence, daysBefore);
      if (!triggerDate) continue;

      const emoji = DATE_TYPE_EMOJI[date.date_type] ?? "📅";
      const typeLabel =
        (DATE_TYPE_LABELS as unknown as Record<string, Record<string, string>>)[
          date.date_type
        ]?.[language] ?? (language === "tr" ? "özel günü" : "special day");

      const daysText =
        language === "tr" ? `${daysBefore} gün sonra` : `in ${daysBefore} days`;

      const title =
        language === "tr"
          ? `${emoji} Sürpriz planlamaya başla!`
          : `${emoji} Start planning a surprise!`;

      const body =
        language === "tr"
          ? `${date.person_name}'${getApostrophe(date.person_name)}${typeLabel} ${daysText}. Senaryolara göz at!`
          : `${date.person_name}'s ${typeLabel} is ${daysText}. Browse scenarios!`;

      const notificationId = await Notifications.scheduleNotificationAsync({
        content: {
          title,
          body,
          data: {
            dateId: date.id,
            type: "proactive_suggestion",
            suggestedCategories: date.suggestedCategories,
          },
          sound: "default",
          ...(Platform.OS === "android"
            ? { channelId: IMPORTANT_DATES_CHANNEL }
            : {}),
        },
        trigger: {
          type: Notifications.SchedulableTriggerInputTypes.DATE,
          date: triggerDate,
        },
      });

      await saveNotificationId(proactiveKey, notificationId);
    }
  }
}

// ──────────────────────────────────────────────
// Cancel a single notification
// ──────────────────────────────────────────────

/**
 * Cancel a single scheduled notification by its identifier.
 */
export async function cancelNotification(
  notificationId: string,
): Promise<void> {
  try {
    await Notifications.cancelScheduledNotificationAsync(notificationId);
  } catch {
    // Notification may have already fired
  }
}

// ──────────────────────────────────────────────
// Query helpers
// ──────────────────────────────────────────────

/**
 * Return all currently scheduled local notifications.
 */
export async function getScheduledNotifications(): Promise<
  Notifications.NotificationRequest[]
> {
  return Notifications.getAllScheduledNotificationsAsync();
}

// ──────────────────────────────────────────────
// Turkish grammar helper
// ──────────────────────────────────────────────

/**
 * Returns the appropriate Turkish possessive suffix connector
 * ("nın", "nin", "nun", "nün" etc.) after an apostrophe,
 * based on the last vowel of the name (vowel harmony).
 */
function getApostrophe(name: string): string {
  const lower = name.toLocaleLowerCase("tr");
  const lastVowel = [...lower].reverse().find((c) => "aeıioöuü".includes(c));

  switch (lastVowel) {
    case "a":
    case "ı":
      return "nın ";
    case "e":
    case "i":
      return "nin ";
    case "o":
    case "u":
      return "nun ";
    case "ö":
    case "ü":
      return "nün ";
    default:
      return "nin ";
  }
}
