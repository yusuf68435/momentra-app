import * as Calendar from "expo-calendar";
import { Platform, Alert } from "react-native";

interface CalendarEvent {
  title: string;
  startDate: Date;
  endDate: Date;
  location?: string;
  notes?: string;
  allDay?: boolean;
}

/**
 * Request calendar permissions
 */
export async function requestCalendarPermission(): Promise<boolean> {
  const { status } = await Calendar.requestCalendarPermissionsAsync();
  return status === "granted";
}

/**
 * Get the default calendar ID for the platform
 */
async function getDefaultCalendarId(): Promise<string | null> {
  const calendars = await Calendar.getCalendarsAsync(
    Calendar.EntityTypes.EVENT,
  );

  if (Platform.OS === "ios") {
    const defaultCal = calendars.find(
      (cal) => cal.allowsModifications && cal.source?.name === "Default",
    );
    return (
      defaultCal?.id ||
      calendars.find((cal) => cal.allowsModifications)?.id ||
      null
    );
  }

  // Android
  const defaultCal = calendars.find(
    (cal) => cal.isPrimary && cal.allowsModifications,
  );
  return (
    defaultCal?.id ||
    calendars.find((cal) => cal.allowsModifications)?.id ||
    null
  );
}

/**
 * Add a surprise plan event to the device calendar
 */
export async function addPlanToCalendar(
  event: CalendarEvent,
  lang: "tr" | "en",
): Promise<{ success: boolean; eventId?: string; error?: string }> {
  try {
    const hasPermission = await requestCalendarPermission();
    if (!hasPermission) {
      return {
        success: false,
        error:
          lang === "tr"
            ? "Takvim izni gerekli"
            : "Calendar permission required",
      };
    }

    const calendarId = await getDefaultCalendarId();
    if (!calendarId) {
      return {
        success: false,
        error: lang === "tr" ? "Takvim bulunamadı" : "No calendar found",
      };
    }

    const eventId = await Calendar.createEventAsync(calendarId, {
      title: `🎉 ${event.title}`,
      startDate: event.startDate,
      endDate: event.endDate,
      location: event.location || undefined,
      notes: event.notes || undefined,
      allDay: event.allDay ?? false,
      alarms: [
        { relativeOffset: -60 * 24 * 7 }, // 1 week before
        { relativeOffset: -60 * 24 }, // 1 day before
        { relativeOffset: -60 * 2 }, // 2 hours before
      ],
    });

    return { success: true, eventId };
  } catch (error: unknown) {
    const message = error instanceof Error ? error.message : String(error);
    return { success: false, error: message };
  }
}

/**
 * Add reminder for preparation steps
 */
export async function addPrepReminder(
  planTitle: string,
  stepTitle: string,
  reminderDate: Date,
  lang: "tr" | "en",
): Promise<{ success: boolean; eventId?: string; error?: string }> {
  const title = `📋 ${planTitle}: ${stepTitle}`;

  return addPlanToCalendar(
    {
      title,
      startDate: reminderDate,
      endDate: new Date(reminderDate.getTime() + 60 * 60 * 1000), // 1 hour
      notes:
        lang === "tr"
          ? `Momentra - Hazırlık adımı hatırlatması`
          : `Momentra - Preparation step reminder`,
    },
    lang,
  );
}

/**
 * Get upcoming birthdays/anniversaries from device calendar
 */
export async function getUpcomingEvents(
  daysAhead: number = 30,
  lang: "tr" | "en",
): Promise<{ events: CalendarEvent[]; error?: string }> {
  try {
    const hasPermission = await requestCalendarPermission();
    if (!hasPermission) {
      return {
        events: [],
        error:
          lang === "tr"
            ? "Takvim izni gerekli"
            : "Calendar permission required",
      };
    }

    const calendars = await Calendar.getCalendarsAsync(
      Calendar.EntityTypes.EVENT,
    );
    const calendarIds = calendars
      .filter((c) => c.allowsModifications)
      .map((c) => c.id);

    const now = new Date();
    const endDate = new Date(now.getTime() + daysAhead * 24 * 60 * 60 * 1000);

    const events = await Calendar.getEventsAsync(calendarIds, now, endDate);

    // Filter for birthday/anniversary keywords
    const keywords = [
      "birthday",
      "doğum günü",
      "anniversary",
      "yıl dönümü",
      "yıldönümü",
      "nişan",
      "düğün",
      "mezuniyet",
      "graduation",
    ];

    const relevant = events
      .filter((e) =>
        keywords.some(
          (kw) =>
            e.title?.toLowerCase().includes(kw) ||
            e.notes?.toLowerCase().includes(kw),
        ),
      )
      .map((e) => ({
        title: e.title,
        startDate: new Date(e.startDate),
        endDate: new Date(e.endDate),
        location: e.location || undefined,
        notes: e.notes || undefined,
        allDay: e.allDay,
      }));

    return { events: relevant };
  } catch (error: unknown) {
    const message = error instanceof Error ? error.message : String(error);
    return { events: [], error: message };
  }
}

/**
 * Calculate days until an event
 */
export function daysUntil(date: string | Date): number {
  const target = typeof date === "string" ? new Date(date) : date;
  const now = new Date();
  now.setHours(0, 0, 0, 0);
  target.setHours(0, 0, 0, 0);
  return Math.ceil((target.getTime() - now.getTime()) / (1000 * 60 * 60 * 24));
}

/**
 * Format a date relative to now
 */
export function formatRelativeDate(
  date: string | Date,
  lang: "tr" | "en",
): string {
  const days = daysUntil(date);

  if (days < 0) return lang === "tr" ? "Geçmiş" : "Past";
  if (days === 0) return lang === "tr" ? "Bugün!" : "Today!";
  if (days === 1) return lang === "tr" ? "Yarın!" : "Tomorrow!";
  if (days < 7) return lang === "tr" ? `${days} gün sonra` : `In ${days} days`;
  if (days < 30) {
    const weeks = Math.floor(days / 7);
    return lang === "tr"
      ? `${weeks} hafta sonra`
      : `In ${weeks} week${weeks > 1 ? "s" : ""}`;
  }
  const months = Math.floor(days / 30);
  return lang === "tr"
    ? `${months} ay sonra`
    : `In ${months} month${months > 1 ? "s" : ""}`;
}
