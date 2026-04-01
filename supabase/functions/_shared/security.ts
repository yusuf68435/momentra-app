import { createClient } from "jsr:@supabase/supabase-js@2";

// ==========================================
// CORS Headers
// ==========================================

export const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
  "X-Content-Type-Options": "nosniff",
  "X-Frame-Options": "DENY",
  "Referrer-Policy": "no-referrer",
};

// ==========================================
// Authentication
// ==========================================

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_ANON_KEY = Deno.env.get("SUPABASE_ANON_KEY")!;

/**
 * Extracts and verifies the user from the Authorization header.
 * Returns the authenticated user or a 401 Response.
 */
export async function requireAuth(
  req: Request,
): Promise<{ id: string; email?: string } | Response> {
  const authHeader = req.headers.get("Authorization");
  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return new Response(
      JSON.stringify({ error: "Missing or invalid authorization header" }),
      {
        status: 401,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      },
    );
  }

  const token = authHeader.replace("Bearer ", "");
  const userClient = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
    global: { headers: { Authorization: authHeader } },
  });

  const {
    data: { user },
    error,
  } = await userClient.auth.getUser(token);

  if (error || !user) {
    return new Response(JSON.stringify({ error: "Invalid or expired token" }), {
      status: 401,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }

  return user;
}

// ==========================================
// Input Validation
// ==========================================

interface ValidationRule {
  type: "string" | "number" | "array" | "object";
  required?: boolean;
  maxLength?: number;
  min?: number;
  max?: number;
}

/**
 * Validates request body fields against provided rules.
 * Returns null if valid, or a 400 Response with details if invalid.
 */
export function validateInput(
  body: Record<string, unknown>,
  rules: Record<string, ValidationRule>,
): Response | null {
  const errors: string[] = [];

  for (const [field, rule] of Object.entries(rules)) {
    const value = body[field];

    // Required check
    if (
      rule.required &&
      (value === undefined || value === null || value === "")
    ) {
      errors.push(`${field} is required`);
      continue;
    }

    // Skip optional fields that are not provided
    if (value === undefined || value === null) continue;

    // Type check
    if (rule.type === "string" && typeof value !== "string") {
      errors.push(`${field} must be a string`);
      continue;
    }
    if (rule.type === "number" && typeof value !== "number") {
      errors.push(`${field} must be a number`);
      continue;
    }
    if (rule.type === "array" && !Array.isArray(value)) {
      errors.push(`${field} must be an array`);
      continue;
    }
    if (
      rule.type === "object" &&
      (typeof value !== "object" || Array.isArray(value))
    ) {
      errors.push(`${field} must be an object`);
      continue;
    }

    // String length check
    if (
      rule.type === "string" &&
      rule.maxLength &&
      typeof value === "string" &&
      value.length > rule.maxLength
    ) {
      errors.push(`${field} exceeds maximum length of ${rule.maxLength}`);
    }

    // Number range check
    if (rule.type === "number" && typeof value === "number") {
      if (rule.min !== undefined && value < rule.min) {
        errors.push(`${field} must be at least ${rule.min}`);
      }
      if (rule.max !== undefined && value > rule.max) {
        errors.push(`${field} must be at most ${rule.max}`);
      }
    }
  }

  if (errors.length > 0) {
    return new Response(
      JSON.stringify({ error: "Invalid input", details: errors }),
      {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      },
    );
  }

  return null;
}

// ==========================================
// Rate Limiting
// ==========================================

/**
 * Checks if the user has exceeded the rate limit.
 * Returns null if within limits, or a 429 Response if exceeded.
 */
export async function checkRateLimit(
  supabase: ReturnType<typeof createClient>,
  userId: string,
  limit: number = 20,
  windowMinutes: number = 5,
): Promise<Response | null> {
  const windowStart = new Date(
    Date.now() - windowMinutes * 60 * 1000,
  ).toISOString();

  const { count, error } = await supabase
    .from("ai_interactions")
    .select("*", { count: "exact", head: true })
    .eq("user_id", userId)
    .gte("created_at", windowStart);

  if (error) {
    console.warn("Rate limit check failed:", error);
    return null; // Fail open - don't block on rate limit errors
  }

  if (count !== null && count >= limit) {
    return new Response(
      JSON.stringify({
        error: "Rate limit exceeded",
        retry_after_seconds: windowMinutes * 60,
      }),
      {
        status: 429,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json",
          "Retry-After": String(windowMinutes * 60),
        },
      },
    );
  }

  return null;
}

// ==========================================
// Credit Checking
// ==========================================

const FREE_MONTHLY_CREDITS = 20;
const PREMIUM_MONTHLY_CREDITS = 200;

/**
 * Checks if the user has remaining AI credits for the current month.
 * Returns null if credits available, or a 402 Response if exhausted.
 */
export async function checkCredits(
  supabase: ReturnType<typeof createClient>,
  userId: string,
): Promise<Response | null> {
  // Get start of current month
  const now = new Date();
  const monthStart = new Date(
    now.getFullYear(),
    now.getMonth(),
    1,
  ).toISOString();

  // Check subscription tier
  const { data: subscription } = await supabase
    .from("subscriptions")
    .select("plan_type, is_active")
    .eq("user_id", userId)
    .eq("is_active", true)
    .maybeSingle();

  const maxCredits =
    subscription?.plan_type === "pro" || subscription?.plan_type === "premium"
      ? PREMIUM_MONTHLY_CREDITS
      : FREE_MONTHLY_CREDITS;

  // Count usage this month
  const { count, error } = await supabase
    .from("ai_interactions")
    .select("*", { count: "exact", head: true })
    .eq("user_id", userId)
    .gte("created_at", monthStart);

  if (error) {
    console.warn("Credit check failed:", error);
    return null; // Fail open
  }

  const used = count ?? 0;
  if (used >= maxCredits) {
    return new Response(
      JSON.stringify({
        error: "AI credits exhausted",
        used,
        limit: maxCredits,
        resets_at: new Date(
          now.getFullYear(),
          now.getMonth() + 1,
          1,
        ).toISOString(),
      }),
      {
        status: 402,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      },
    );
  }

  return null;
}
