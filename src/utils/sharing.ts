import { Share, Platform } from "react-native";
import { APP_CONFIG } from "../constants/config";

const APP_URL = "https://momentra.app";

/** Append UTM attribution parameters to a URL for analytics tracking. */
function withUtm(url: string, campaign: string): string {
  const sep = url.includes("?") ? "&" : "?";
  return `${url}${sep}utm_source=momentra&utm_medium=share&utm_campaign=${campaign}`;
}

interface ShareResult {
  success: boolean;
  error?: string;
}

export async function shareScenario(
  scenario: {
    id: string;
    title_tr: string;
    title_en: string;
    emoji?: string;
    short_desc_tr?: string | null;
    short_desc_en?: string | null;
  },
  lang: "tr" | "en",
): Promise<ShareResult> {
  const title = lang === "tr" ? scenario.title_tr : scenario.title_en;
  const desc =
    lang === "tr" ? scenario.short_desc_tr || "" : scenario.short_desc_en || "";
  const deepLink = withUtm(
    `${APP_URL}/scenario/${scenario.id}`,
    "scenario_share",
  );

  const message =
    lang === "tr"
      ? `${scenario.emoji || "🎉"} ${title}\n\n${desc}\n\nMomentra'da keşfet: ${deepLink}`
      : `${scenario.emoji || "🎉"} ${title}\n\n${desc}\n\nDiscover on Momentra: ${deepLink}`;

  try {
    const result = await Share.share({
      message,
      title: `${scenario.emoji || "🎉"} ${title}`,
      ...(Platform.OS === "ios" ? { url: deepLink } : {}),
    });

    return { success: result.action === Share.sharedAction };
  } catch (error: unknown) {
    const message = error instanceof Error ? error.message : String(error);
    return { success: false, error: message };
  }
}

export async function sharePlan(
  plan: {
    title: string;
    event_date?: string | null;
    recipient_name?: string | null;
  },
  lang: "tr" | "en",
): Promise<ShareResult> {
  const dateStr = plan.event_date
    ? new Date(plan.event_date).toLocaleDateString(
        lang === "tr" ? "tr-TR" : "en-US",
      )
    : "";

  const appLink = withUtm(APP_URL, "plan_share");
  const message =
    lang === "tr"
      ? `🎉 "${plan.title}" sürprizimi planlıyorum!${plan.recipient_name ? `\n👤 ${plan.recipient_name} için` : ""}${dateStr ? `\n📅 ${dateStr}` : ""}\n\nSen de Momentra ile harika sürprizler planla: ${appLink}`
      : `🎉 Planning my "${plan.title}" surprise!${plan.recipient_name ? `\n👤 For ${plan.recipient_name}` : ""}${dateStr ? `\n📅 ${dateStr}` : ""}\n\nPlan amazing surprises with Momentra: ${appLink}`;

  try {
    const result = await Share.share({ message, title: `🎉 ${plan.title}` });
    return { success: result.action === Share.sharedAction };
  } catch (error: unknown) {
    const message = error instanceof Error ? error.message : String(error);
    return { success: false, error: message };
  }
}

export async function shareApp(lang: "tr" | "en"): Promise<ShareResult> {
  const appLink = withUtm(APP_URL, "app_share");
  const message =
    lang === "tr"
      ? `🎉 Momentra - AI destekli sürpriz planlama uygulaması!\n\n225+ sürpriz senaryosu, akıllı öneriler ve adım adım planlama.\n\nHemen indir: ${appLink}`
      : `🎉 Momentra - AI-powered surprise planning app!\n\n225+ surprise scenarios, smart recommendations and step-by-step planning.\n\nDownload now: ${appLink}`;

  try {
    const result = await Share.share({ message, title: "🎉 Momentra" });
    return { success: result.action === Share.sharedAction };
  } catch (error: unknown) {
    const message = error instanceof Error ? error.message : String(error);
    return { success: false, error: message };
  }
}

/**
 * Get a shareable link for a scenario (includes UTM attribution).
 */
export function getScenarioLink(scenarioId: string): string {
  return withUtm(`${APP_URL}/scenario/${scenarioId}`, "scenario_share");
}

/**
 * Get a shareable link for a plan (includes UTM attribution).
 */
export function getPlanLink(planId: string): string {
  return withUtm(`${APP_URL}/plan/${planId}`, "plan_share");
}

export async function shareInvite(
  eventTitle: string,
  eventDate: string,
  message: string,
  inviteLink: string,
  lang: "tr" | "en",
): Promise<ShareResult> {
  const dateStr = new Date(eventDate).toLocaleDateString(
    lang === "tr" ? "tr-TR" : "en-US",
    { weekday: "long", year: "numeric", month: "long", day: "numeric" },
  );

  const shareText =
    lang === "tr"
      ? `🎉 Davetlisiniz!\n\n${eventTitle}\n📅 ${dateStr}\n\n${message}\n\nKatılmak için: ${inviteLink}`
      : `🎉 You're Invited!\n\n${eventTitle}\n📅 ${dateStr}\n\n${message}\n\nRSVP here: ${inviteLink}`;

  try {
    const result = await Share.share({
      message: shareText,
      title: `🎉 ${eventTitle}`,
    });
    return { success: result.action === Share.sharedAction };
  } catch (error: unknown) {
    const message = error instanceof Error ? error.message : String(error);
    return { success: false, error: message };
  }
}
