import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "jsr:@supabase/supabase-js@2";
import { corsHeaders, requireAuth } from "../_shared/security.ts";

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const EXPO_PUSH_API = "https://exp.host/--/api/v2/push/send";

interface PushMessage {
  to: string;
  title: string;
  body: string;
  data?: Record<string, unknown>;
  sound?: "default" | null;
  badge?: number;
  channelId?: string;
}

interface ExpoPushTicket {
  status: "ok" | "error";
  id?: string;
  message?: string;
  details?: { error?: string };
}

async function sendExpoPushNotifications(
  messages: PushMessage[],
): Promise<ExpoPushTicket[]> {
  const resp = await fetch(EXPO_PUSH_API, {
    method: "POST",
    headers: {
      Accept: "application/json",
      "Accept-encoding": "gzip, deflate",
      "Content-Type": "application/json",
    },
    body: JSON.stringify(messages),
  });

  if (!resp.ok) {
    throw new Error(`Expo Push API returned ${resp.status}`);
  }

  const json = await resp.json();
  return json.data as ExpoPushTicket[];
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const user = await requireAuth(req);
    if (user instanceof Response) return user;

    const body = await req.json();
    const { targetUserIds, title, messageBody, data, channelId } = body as {
      targetUserIds: string[];
      title: string;
      messageBody: string;
      data?: Record<string, unknown>;
      channelId?: string;
    };

    if (
      !Array.isArray(targetUserIds) ||
      targetUserIds.length === 0 ||
      !title ||
      !messageBody
    ) {
      return new Response(
        JSON.stringify({
          error: "targetUserIds, title, and messageBody are required",
        }),
        {
          status: 400,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        },
      );
    }

    // Limit to 100 recipients per call
    const limitedIds = targetUserIds.slice(0, 100);

    const serviceClient = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

    // Fetch push tokens for target users
    const { data: profiles, error: profilesError } = await serviceClient
      .from("profiles")
      .select("id, push_token")
      .in("id", limitedIds)
      .not("push_token", "is", null);

    if (profilesError) {
      return new Response(
        JSON.stringify({ error: "Failed to fetch push tokens" }),
        {
          status: 500,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        },
      );
    }

    if (!profiles || profiles.length === 0) {
      return new Response(
        JSON.stringify({ sent: 0, message: "No registered devices found" }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" } },
      );
    }

    // Build Expo push messages (only for valid Expo tokens)
    const messages: PushMessage[] = profiles
      .filter(
        (p: { push_token: string }) =>
          p.push_token && p.push_token.startsWith("ExponentPushToken["),
      )
      .map((p: { push_token: string }) => ({
        to: p.push_token,
        title,
        body: messageBody,
        sound: "default" as const,
        data: data ?? {},
        ...(channelId ? { channelId } : {}),
      }));

    if (messages.length === 0) {
      return new Response(
        JSON.stringify({ sent: 0, message: "No valid Expo push tokens found" }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" } },
      );
    }

    const tickets = await sendExpoPushNotifications(messages);

    const succeeded = tickets.filter((t) => t.status === "ok").length;
    const failed = tickets.filter((t) => t.status === "error").length;

    return new Response(
      JSON.stringify({ sent: succeeded, failed, total: messages.length }),
      { headers: { ...corsHeaders, "Content-Type": "application/json" } },
    );
  } catch (err) {
    return new Response(JSON.stringify({ error: "Internal error" }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
