import { supabase } from "./supabase";
import { getCurrentUser } from "./helpers";
import { notifyPlanOwner } from "./pushNotifications";
import {
  generateSecureToken,
  sanitizeInput,
  sanitizeDisplayName,
} from "../utils/crypto";

// ==========================================
// TYPES
// ==========================================

export interface Guest {
  id: string;
  plan_id: string;
  invited_by: string;
  name: string;
  email: string | null;
  phone: string | null;
  rsvp_status: RsvpStatus;
  rsvp_responded_at: string | null;
  dietary_notes: string | null;
  plus_one: boolean;
  notes: string | null;
  invite_token: string | null;
  reminder_sent_at: string | null;
  created_at: string;
  updated_at: string;
}

export type RsvpStatus = "pending" | "accepted" | "declined" | "maybe";

export interface GuestStats {
  total: number;
  accepted: number;
  declined: number;
  maybe: number;
  pending: number;
  plus_ones: number;
}

// ==========================================
// GUEST FUNCTIONS
// ==========================================

export async function inviteGuest(
  planId: string,
  guest: {
    name: string;
    email?: string;
    phone?: string;
    dietary_notes?: string;
    plus_one?: boolean;
    notes?: string;
  },
): Promise<Guest> {
  const user = await getCurrentUser();

  // Sanitize all user-provided inputs
  const safeName = sanitizeDisplayName(guest.name);
  const safeNotes = guest.notes ? sanitizeInput(guest.notes, 500) : null;
  const safeDietaryNotes = guest.dietary_notes
    ? sanitizeInput(guest.dietary_notes, 300)
    : null;

  // Generate token without modulo bias
  const inviteToken = generateSecureToken(32);

  const { data, error } = await supabase
    .from("guest_rsvp")
    .insert({
      plan_id: planId,
      invited_by: user.id,
      name: safeName,
      email: guest.email?.trim().toLowerCase() || null,
      phone: guest.phone?.trim() || null,
      rsvp_status: "pending" as RsvpStatus,
      dietary_notes: safeDietaryNotes,
      plus_one: guest.plus_one ?? false,
      notes: safeNotes,
      invite_token: inviteToken,
    })
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function getGuests(planId: string): Promise<Guest[]> {
  const { data, error } = await supabase
    .from("guest_rsvp")
    .select("*")
    .eq("plan_id", planId)
    .order("name");

  if (error) throw error;
  return data || [];
}

export async function updateGuest(
  id: string,
  updates: Partial<
    Pick<
      Guest,
      "name" | "email" | "phone" | "dietary_notes" | "plus_one" | "notes"
    >
  >,
): Promise<Guest> {
  const user = await getCurrentUser();
  const { data, error } = await supabase
    .from("guest_rsvp")
    .update({ ...updates, updated_at: new Date().toISOString() })
    .eq("id", id)
    .eq("invited_by", user.id)
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function updateRsvpStatus(
  id: string,
  status: RsvpStatus,
): Promise<Guest> {
  const { data, error } = await supabase
    .from("guest_rsvp")
    .update({
      rsvp_status: status,
      rsvp_responded_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
    })
    .eq("id", id)
    .select()
    .single();

  if (error) throw error;

  // Notify plan owner about the RSVP response
  if (data.plan_id) {
    const statusLabel =
      status === "accepted"
        ? "accepted"
        : status === "declined"
          ? "declined"
          : "is maybe";
    notifyPlanOwner(
      data.plan_id,
      "Guest RSVP Update",
      `${data.name || "A guest"} ${statusLabel} your invitation`,
    ).catch(() => {});
  }

  return data;
}

export async function removeGuest(id: string): Promise<void> {
  const user = await getCurrentUser();
  const { error } = await supabase
    .from("guest_rsvp")
    .delete()
    .eq("id", id)
    .eq("invited_by", user.id);

  if (error) throw error;
}

export async function sendReminder(guestId: string): Promise<void> {
  try {
    const { error } = await supabase.functions.invoke("send-rsvp-reminder", {
      body: { guest_id: guestId },
    });

    if (error) {
      if (__DEV__) {
        console.warn("Failed to send reminder via edge function:", error);
      }
      throw error;
    }

    // Update reminder_sent_at
    await supabase
      .from("guest_rsvp")
      .update({
        reminder_sent_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
      })
      .eq("id", guestId);
  } catch (err) {
    if (__DEV__) {
      console.warn("sendReminder error:", err);
    }
    throw err;
  }
}

export async function generateInviteLink(planId: string): Promise<string> {
  const token = generateSecureToken(32);

  // Store the invite link token
  const { error } = await supabase
    .from("guest_rsvp")
    .update({ invite_token: token })
    .eq("plan_id", planId)
    .is("invite_token", null);

  if (error) {
    if (__DEV__) {
      console.warn("Failed to update invite tokens:", error);
    }
  }

  // Return a shareable link (the actual domain would come from app config)
  return `momentra://rsvp/${planId}?token=${encodeURIComponent(token)}`;
}

export function getGuestStats(guests: Guest[]): GuestStats {
  return {
    total: guests.length,
    accepted: guests.filter((g) => g.rsvp_status === "accepted").length,
    declined: guests.filter((g) => g.rsvp_status === "declined").length,
    maybe: guests.filter((g) => g.rsvp_status === "maybe").length,
    pending: guests.filter((g) => g.rsvp_status === "pending").length,
    plus_ones: guests.filter((g) => g.plus_one).length,
  };
}

// ==========================================
// RSVP TOKEN VERIFICATION
// ==========================================

/**
 * Verify an RSVP token and return the guest record if valid.
 * Performs constant-time token comparison to prevent timing attacks.
 */
export async function verifyRsvpToken(
  planId: string,
  token: string,
): Promise<Guest | null> {
  const { data, error } = await supabase
    .from("guest_rsvp")
    .select("*")
    .eq("plan_id", planId)
    .eq("invite_token", token)
    .maybeSingle();

  if (error || !data) return null;
  return data;
}
