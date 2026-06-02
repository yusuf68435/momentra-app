import * as Notifications from "expo-notifications";
import Constants from "expo-constants";
import { Platform } from "react-native";

// Note: Notification handler is configured once in src/services/notifications.ts
// via setupNotificationHandler() called from app/_layout.tsx. We removed the
// duplicate module-load side effect here to avoid double-registration and
// to drop the deprecated `shouldShowAlert` flag (iOS 26 / expo-notifications
// ~0.32.17 prefer shouldShowBanner/shouldShowList only).

/**
 * Request push notification permissions
 */
export async function requestNotificationPermission(): Promise<boolean> {
  const { status: existingStatus } = await Notifications.getPermissionsAsync();
  let finalStatus = existingStatus;

  if (existingStatus !== "granted") {
    const { status } = await Notifications.requestPermissionsAsync();
    finalStatus = status;
  }

  if (finalStatus !== "granted") {
    return false;
  }

  // Android channel setup
  if (Platform.OS === "android") {
    await Notifications.setNotificationChannelAsync("surprises", {
      name: "Surprise Reminders",
      importance: Notifications.AndroidImportance.HIGH,
      vibrationPattern: [0, 250, 250, 250],
      lightColor: "#E91E63",
      sound: "default",
    });

    await Notifications.setNotificationChannelAsync("countdown", {
      name: "Countdown Alerts",
      importance: Notifications.AndroidImportance.DEFAULT,
      sound: "default",
    });

    await Notifications.setNotificationChannelAsync("tips", {
      name: "Tips & Suggestions",
      importance: Notifications.AndroidImportance.LOW,
    });
  }

  return true;
}

/**
 * Register for push notifications: request permissions, set up Android channels,
 * and return the Expo push token. Returns null if permissions are denied.
 */
export async function registerForPushNotifications(): Promise<string | null> {
  const granted = await requestNotificationPermission();
  if (!granted) return null;

  try {
    const projectId = Constants.expoConfig?.extra?.eas?.projectId;
    const { data: token } = await Notifications.getExpoPushTokenAsync({
      ...(projectId ? { projectId } : {}),
    });
    return token;
  } catch (error) {
    if (__DEV__)
      console.warn("[Notifications] Failed to get push token:", error);
    return null;
  }
}

/**
 * Schedule a local plan reminder notification at a specific date/time.
 */
export async function schedulePlanReminder(
  planId: string,
  title: string,
  body: string,
  triggerDate: Date,
): Promise<string | null> {
  if (triggerDate <= new Date()) return null;

  const id = await Notifications.scheduleNotificationAsync({
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
  return id;
}

/**
 * Cancel a specific plan's reminder by planId.
 * Cancels all notifications associated with that planId.
 */
export async function cancelPlanReminder(planId: string): Promise<void> {
  const scheduled = await Notifications.getAllScheduledNotificationsAsync();
  const matching = scheduled.filter(
    (n) =>
      (n.content.data as Record<string, unknown> | undefined)?.planId ===
      planId,
  );
  for (const n of matching) {
    await Notifications.cancelScheduledNotificationAsync(n.identifier);
  }
}

/**
 * Schedule countdown notifications at 7 days, 3 days, and 1 day before the event.
 */
export async function scheduleCountdownNotification(
  planId: string,
  title: string,
  daysRemaining: number,
): Promise<string | null> {
  const now = new Date();
  const triggerDate = new Date(
    now.getTime() + daysRemaining * 24 * 60 * 60 * 1000,
  );
  triggerDate.setHours(9, 0, 0, 0);

  if (triggerDate <= now) return null;

  const body =
    daysRemaining === 1
      ? `Tomorrow is the big day for "${title}"!`
      : `${daysRemaining} days until "${title}". Are you ready?`;

  const id = await Notifications.scheduleNotificationAsync({
    content: {
      title:
        daysRemaining === 1
          ? `🎉 1 day left!`
          : `⏰ ${daysRemaining} days left!`,
      body,
      data: { planId, type: "countdown" },
      sound: "default",
      ...(Platform.OS === "android" ? { channelId: "countdown" } : {}),
    },
    trigger: {
      type: Notifications.SchedulableTriggerInputTypes.DATE,
      date: triggerDate,
    },
  });
  return id;
}

/**
 * Schedule countdown notifications for a plan
 */
export async function scheduleCountdownNotifications(
  planId: string,
  planTitle: string,
  eventDate: string,
  lang: "tr" | "en",
): Promise<string[]> {
  const date = new Date(eventDate);
  const now = new Date();
  const notificationIds: string[] = [];

  const milestones = [
    { days: 30, emoji: "📅" },
    { days: 14, emoji: "⏰" },
    { days: 7, emoji: "🔔" },
    { days: 3, emoji: "⚡" },
    { days: 1, emoji: "🎉" },
    { days: 0, emoji: "🎊" },
  ];

  for (const milestone of milestones) {
    const triggerDate = new Date(date);
    triggerDate.setDate(triggerDate.getDate() - milestone.days);
    triggerDate.setHours(9, 0, 0, 0); // 9 AM

    if (triggerDate > now) {
      const title =
        lang === "tr"
          ? `${milestone.emoji} ${milestone.days === 0 ? "Bugün büyük gün!" : `${milestone.days} gün kaldı!`}`
          : `${milestone.emoji} ${milestone.days === 0 ? "Today is the big day!" : `${milestone.days} days left!`}`;

      const body =
        lang === "tr"
          ? `"${planTitle}" sürprizi ${milestone.days === 0 ? "bugün gerçekleşecek!" : `için ${milestone.days} gün kaldı. Hazırlıkların tamam mı?`}`
          : `${milestone.days === 0 ? `"${planTitle}" surprise is happening today!` : `${milestone.days} days until "${planTitle}" surprise. Are you ready?`}`;

      const id = await Notifications.scheduleNotificationAsync({
        content: {
          title,
          body,
          data: { planId, type: "countdown" },
          sound: "default",
          ...(Platform.OS === "android" ? { channelId: "countdown" } : {}),
        },
        trigger: {
          type: Notifications.SchedulableTriggerInputTypes.DATE,
          date: triggerDate,
        },
      });
      notificationIds.push(id);
    }
  }

  return notificationIds;
}

/**
 * Schedule a checklist step reminder
 */
export async function scheduleStepReminder(
  planId: string,
  stepTitle: string,
  reminderDate: Date,
  lang: "tr" | "en",
): Promise<string> {
  const title =
    lang === "tr" ? "📋 Yapılacak hatırlatması" : "📋 Task Reminder";
  const body =
    lang === "tr"
      ? `"${stepTitle}" görevini tamamlamayı unutma!`
      : `Don't forget to complete "${stepTitle}"!`;

  return Notifications.scheduleNotificationAsync({
    content: {
      title,
      body,
      data: { planId, type: "step_reminder" },
      sound: "default",
      ...(Platform.OS === "android" ? { channelId: "surprises" } : {}),
    },
    trigger: {
      type: Notifications.SchedulableTriggerInputTypes.DATE,
      date: reminderDate,
    },
  });
}

/**
 * Send a daily planning tip
 */
export async function scheduleDailyTip(lang: "tr" | "en"): Promise<string> {
  const tips_tr = [
    "Sürprizde en önemli şey düşüncenin kendisidir, bütçe değil! 💝",
    "Fotoğraf ve video çekmeyi unutmayın - anılar kalıcıdır! 📸",
    "Sürprizi birlikte planlamak, daha eğlenceli hale getirir! 👥",
    "Küçük detaylar büyük fark yaratır - kişiselleştirmeyi deneyin! ✨",
    "Hazırlığa erken başlamak stresi azaltır! ⏰",
  ];

  const tips_en = [
    "The thought itself matters most, not the budget! 💝",
    "Don't forget to take photos and videos - memories last forever! 📸",
    "Planning a surprise together makes it more fun! 👥",
    "Small details make a big difference - try personalizing! ✨",
    "Starting early reduces stress! ⏰",
  ];

  const tips = lang === "tr" ? tips_tr : tips_en;
  const randomTip = tips[Math.floor(Math.random() * tips.length)];

  return Notifications.scheduleNotificationAsync({
    content: {
      title: lang === "tr" ? "💡 Günün İpucu" : "💡 Tip of the Day",
      body: randomTip,
      data: { type: "daily_tip" },
      ...(Platform.OS === "android" ? { channelId: "tips" } : {}),
    },
    trigger: {
      type: Notifications.SchedulableTriggerInputTypes.DAILY,
      hour: 10,
      minute: 0,
    },
  });
}

/**
 * Cancel all notifications for a specific plan
 */
export async function cancelPlanNotifications(planId: string): Promise<void> {
  const scheduled = await Notifications.getAllScheduledNotificationsAsync();
  const planNotifications = scheduled.filter(
    (n) =>
      (n.content.data as Record<string, unknown> | undefined)?.planId ===
      planId,
  );

  for (const notification of planNotifications) {
    await Notifications.cancelScheduledNotificationAsync(
      notification.identifier,
    );
  }
}

/**
 * Cancel all scheduled notifications
 */
export async function cancelAllNotifications(): Promise<void> {
  await Notifications.cancelAllScheduledNotificationsAsync();
}

/**
 * Get count of scheduled notifications
 */
export async function getScheduledCount(): Promise<number> {
  const scheduled = await Notifications.getAllScheduledNotificationsAsync();
  return scheduled.length;
}

/**
 * Get push token for remote notifications
 */
export async function getPushToken(): Promise<string | null> {
  try {
    const { data } = await Notifications.getExpoPushTokenAsync();
    return data;
  } catch {
    return null;
  }
}
