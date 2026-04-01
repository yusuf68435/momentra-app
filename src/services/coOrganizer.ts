import { supabase } from "./supabase";
import { notifyPlanOwner, notifyCoOrganizers } from "./pushNotifications";
import type {
  CoOrganizer,
  PlanMessage,
  TaskAssignment,
  InviteLink,
} from "../types/coOrganizer";
import {
  sanitizeInput,
  sanitizeDisplayName,
  generateSecureToken,
} from "../utils/crypto";

/**
 * Verify the current user is the plan owner.
 * Throws if not authorized.
 */
async function requirePlanOwner(planId: string): Promise<string> {
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) throw new Error("Not authenticated");

  const { data: plan } = await supabase
    .from("plans")
    .select("user_id")
    .eq("id", planId)
    .single();

  if (!plan || plan.user_id !== user.id) {
    throw new Error("Only the plan owner can perform this action");
  }
  return user.id;
}

// ── Co-Organizers ────────────────────────────────────────────────────

export async function fetchCoOrganizers(
  planId: string,
): Promise<CoOrganizer[]> {
  const { data, error } = await supabase
    .from("co_organizers")
    .select("*, profile:profiles(display_name, avatar_url)")
    .eq("plan_id", planId);

  if (error) {
    if (__DEV__) {
      console.warn("Failed to fetch co-organizers:", error);
    }
    return [];
  }
  return data || [];
}

export async function inviteCoOrganizer(
  planId: string,
  email: string,
  role: "organizer" | "helper" = "helper",
): Promise<CoOrganizer | null> {
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return null;

  const { data, error } = await supabase
    .from("co_organizers")
    .insert({
      plan_id: planId,
      email,
      display_name: email.split("@")[0],
      role,
      status: "pending",
    })
    .select()
    .single();

  if (error) {
    if (__DEV__) {
      console.warn("Failed to invite co-organizer:", error);
    }
    return null;
  }
  return data;
}

export async function acceptInvite(inviteCode: string): Promise<boolean> {
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return false;

  try {
    // Find the invite link by code
    const { data: invite, error: findError } = await supabase
      .from("invite_links")
      .select("*")
      .eq("code", inviteCode)
      .eq("is_active", true)
      .single();

    if (findError || !invite) {
      if (__DEV__) {
        console.warn("Invite not found or inactive:", findError);
      }
      return false;
    }

    // Check expiry
    if (new Date(invite.expires_at) < new Date()) {
      if (__DEV__) {
        console.warn("Invite has expired");
      }
      return false;
    }

    // Check max uses
    if (invite.use_count >= invite.max_uses) {
      if (__DEV__) {
        console.warn("Invite has reached max uses");
      }
      return false;
    }

    // Add user as co-organizer
    const { error: insertError } = await supabase.from("co_organizers").insert({
      plan_id: invite.plan_id,
      user_id: user.id,
      email: user.email || "",
      display_name:
        user.user_metadata?.display_name || user.email?.split("@")[0] || "",
      role: "helper",
      status: "accepted",
      accepted_at: new Date().toISOString(),
    });

    if (insertError) {
      if (__DEV__) {
        console.warn("Failed to add co-organizer:", insertError);
      }
      return false;
    }

    // Increment use_count on invite link — if this fails, roll back the co-organizer insert
    const { error: updateError } = await supabase
      .from("invite_links")
      .update({ use_count: invite.use_count + 1 })
      .eq("id", invite.id);

    if (updateError) {
      // Rollback: remove the co-organizer record we just inserted
      await supabase
        .from("co_organizers")
        .delete()
        .eq("plan_id", invite.plan_id)
        .eq("user_id", user.id);
      if (__DEV__) {
        console.warn(
          "Failed to increment use_count, rolled back co-organizer insert:",
          updateError,
        );
      }
      return false;
    }

    // Notify plan owner that someone joined
    const displayName =
      user.user_metadata?.display_name || user.email?.split("@")[0] || "";
    notifyPlanOwner(
      invite.plan_id,
      "New Co-Organizer",
      `${displayName} joined your plan as a co-organizer`,
    ).catch(() => {});

    return true;
  } catch (err) {
    if (__DEV__) {
      console.warn("Failed to accept invite:", err);
    }
    return false;
  }
}

export async function declineInvite(coOrganizerId: string): Promise<boolean> {
  try {
    const { error } = await supabase
      .from("co_organizers")
      .update({ status: "declined" })
      .eq("id", coOrganizerId);

    if (error) {
      if (__DEV__) {
        console.warn("Failed to decline invite:", error);
      }
      return false;
    }
    return true;
  } catch (err) {
    if (__DEV__) {
      console.warn("Failed to decline invite:", err);
    }
    return false;
  }
}

export async function removeCoOrganizer(
  planId: string,
  userId: string,
): Promise<void> {
  // Only plan owner can remove co-organizers
  await requirePlanOwner(planId);

  const { error } = await supabase
    .from("co_organizers")
    .delete()
    .eq("plan_id", planId)
    .eq("user_id", userId);

  if (error) {
    if (__DEV__) {
      console.warn("Failed to remove co-organizer:", error);
    }
  }
}

export async function updateRole(
  planId: string,
  userId: string,
  newRole: "organizer" | "helper",
): Promise<void> {
  // Only plan owner can change roles
  await requirePlanOwner(planId);

  const { error } = await supabase
    .from("co_organizers")
    .update({ role: newRole })
    .eq("plan_id", planId)
    .eq("user_id", userId);

  if (error) {
    if (__DEV__) {
      console.warn("Failed to update role:", error);
    }
  }
}

// ── Task Assignments ─────────────────────────────────────────────────

export async function fetchTasks(planId: string): Promise<TaskAssignment[]> {
  const { data, error } = await supabase
    .from("task_assignments")
    .select(
      "*, assignee:profiles!assigned_to(display_name, avatar_url), checklist_item:plan_checklist_items(title, is_completed)",
    )
    .eq("plan_id", planId)
    .order("created_at", { ascending: false });

  if (error) {
    if (__DEV__) {
      console.warn("Failed to fetch tasks:", error);
    }
    return [];
  }
  return data || [];
}

export async function createTask(
  planId: string,
  task: {
    checklistItemId: string;
    assignedTo: string;
  },
): Promise<TaskAssignment | null> {
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return null;

  const { data, error } = await supabase
    .from("task_assignments")
    .insert({
      plan_id: planId,
      checklist_item_id: task.checklistItemId,
      assigned_to: task.assignedTo,
      assigned_by: user.id,
      status: "pending",
    })
    .select()
    .single();

  if (error) {
    if (__DEV__) {
      console.warn("Failed to create task:", error);
    }
    return null;
  }
  return data;
}

export async function updateTask(
  taskId: string,
  updates: Partial<Pick<TaskAssignment, "status">>,
): Promise<TaskAssignment | null> {
  const { data, error } = await supabase
    .from("task_assignments")
    .update(updates)
    .eq("id", taskId)
    .select()
    .single();

  if (error) {
    if (__DEV__) {
      console.warn("Failed to update task:", error);
    }
    return null;
  }
  return data;
}

export async function deleteTask(taskId: string): Promise<void> {
  // Verify user is plan owner or the task assigner
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) throw new Error("Not authenticated");

  const { data: task } = await supabase
    .from("task_assignments")
    .select("plan_id, assigned_by")
    .eq("id", taskId)
    .single();

  if (!task) throw new Error("Task not found");

  // Allow deletion by task creator or plan owner
  if (task.assigned_by !== user.id) {
    const { data: plan } = await supabase
      .from("plans")
      .select("user_id")
      .eq("id", task.plan_id)
      .single();

    if (!plan || plan.user_id !== user.id) {
      throw new Error("Only the plan owner or task creator can delete tasks");
    }
  }

  const { error } = await supabase
    .from("task_assignments")
    .delete()
    .eq("id", taskId);

  if (error) {
    if (__DEV__) {
      console.warn("Failed to delete task:", error);
    }
  }
}

export async function toggleTaskComplete(taskId: string): Promise<void> {
  // Fetch current status
  const { data: task, error: fetchError } = await supabase
    .from("task_assignments")
    .select("status")
    .eq("id", taskId)
    .single();

  if (fetchError || !task) {
    if (__DEV__) {
      console.warn("Failed to fetch task for toggle:", fetchError);
    }
    return;
  }

  const newStatus = task.status === "completed" ? "pending" : "completed";

  const { error } = await supabase
    .from("task_assignments")
    .update({ status: newStatus })
    .eq("id", taskId);

  if (error) {
    if (__DEV__) {
      console.warn("Failed to toggle task:", error);
    }
  }
}

// ── Messages ─────────────────────────────────────────────────────────

export async function fetchMessages(
  planId: string,
  limit = 50,
  offset = 0,
): Promise<PlanMessage[]> {
  const { data, error } = await supabase
    .from("plan_messages")
    .select("*, sender:profiles!sender_id(display_name, avatar_url)")
    .eq("plan_id", planId)
    .order("created_at", { ascending: false })
    .range(offset, offset + limit - 1);

  if (error) {
    if (__DEV__) {
      console.warn("Failed to fetch messages:", error);
    }
    return [];
  }
  return data || [];
}

export async function sendMessage(
  planId: string,
  message: string,
  messageType: "text" | "image" | "system" = "text",
): Promise<PlanMessage | null> {
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return null;

  // Sanitize message content
  const safeMessage = sanitizeInput(message, 2000);

  const { data, error } = await supabase
    .from("plan_messages")
    .insert({
      plan_id: planId,
      sender_id: user.id,
      message: safeMessage,
      message_type: messageType,
    })
    .select("*, sender:profiles!sender_id(display_name, avatar_url)")
    .single();

  if (error) {
    if (__DEV__) {
      console.warn("Failed to send message:", error);
    }
    return null;
  }
  return data;
}

// ── Invite Links ─────────────────────────────────────────────────────

export async function createInviteLink(
  planId: string,
): Promise<InviteLink | null> {
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return null;

  const code = generateInviteCode();
  const expiresAt = new Date();
  expiresAt.setDate(expiresAt.getDate() + 7);

  const { data, error } = await supabase
    .from("invite_links")
    .insert({
      plan_id: planId,
      code,
      created_by: user.id,
      max_uses: 5,
      expires_at: expiresAt.toISOString(),
      is_active: true,
    })
    .select()
    .single();

  if (error) {
    if (__DEV__) {
      console.warn("Failed to create invite link:", error);
    }
    return null;
  }
  return data;
}

export async function fetchPendingInvites(
  planId: string,
): Promise<CoOrganizer[]> {
  const { data, error } = await supabase
    .from("co_organizers")
    .select("*")
    .eq("plan_id", planId)
    .eq("status", "pending");

  if (error) {
    if (__DEV__) {
      console.warn("Failed to fetch pending invites:", error);
    }
    return [];
  }
  return data || [];
}

export async function fetchMyInvites(): Promise<CoOrganizer[]> {
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return [];

  const { data, error } = await supabase
    .from("co_organizers")
    .select("*")
    .eq("email", user.email)
    .eq("status", "pending");

  if (error) {
    if (__DEV__) {
      console.warn("Failed to fetch my invites:", error);
    }
    return [];
  }
  return data || [];
}

export async function fetchActiveInviteLinks(
  planId: string,
): Promise<InviteLink[]> {
  const { data, error } = await supabase
    .from("invite_links")
    .select("*")
    .eq("plan_id", planId)
    .eq("is_active", true)
    .order("created_at", { ascending: false });

  if (error) {
    if (__DEV__) {
      console.warn("Failed to fetch invite links:", error);
    }
    return [];
  }
  return data || [];
}

export async function deactivateInviteLink(linkId: string): Promise<void> {
  const { error } = await supabase
    .from("invite_links")
    .update({ is_active: false })
    .eq("id", linkId);

  if (error) {
    if (__DEV__) {
      console.warn("Failed to deactivate invite link:", error);
    }
  }
}

// ── Invite Validation ────────────────────────────────────────────────

export interface InviteLinkDetails {
  planId: string;
  planName: string;
  inviterName: string;
  inviterAvatar: string | null;
  role: "organizer" | "helper";
  expiresAt: string;
  code: string;
}

export type InviteErrorCode =
  | "expired"
  | "invalid"
  | "already_used"
  | "already_member"
  | "network"
  | "unknown";

export class InviteError extends Error {
  code: InviteErrorCode;
  constructor(code: InviteErrorCode, message: string) {
    super(message);
    this.code = code;
    this.name = "InviteError";
  }
}

export async function validateInviteLink(
  code: string,
): Promise<InviteLinkDetails> {
  try {
    const { data: invite, error } = await supabase
      .from("invite_links")
      .select(
        "*, plan:plans(id, title), creator:profiles!created_by(display_name, avatar_url)",
      )
      .eq("code", code)
      .single();

    if (error || !invite) {
      throw new InviteError("invalid", "This invite code is not valid.");
    }

    if (!invite.is_active) {
      throw new InviteError(
        "already_used",
        "This invite link is no longer active.",
      );
    }

    if (new Date(invite.expires_at) < new Date()) {
      throw new InviteError("expired", "This invite link has expired.");
    }

    if (invite.use_count >= invite.max_uses) {
      throw new InviteError(
        "already_used",
        "This invite link has reached its maximum number of uses.",
      );
    }

    // Check if the current user is already a member
    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (user) {
      const { data: existing } = await supabase
        .from("co_organizers")
        .select("id")
        .eq("plan_id", invite.plan_id)
        .eq("user_id", user.id)
        .maybeSingle();

      if (existing) {
        throw new InviteError(
          "already_member",
          "You are already a member of this plan.",
        );
      }
    }

    return {
      planId: invite.plan_id,
      planName: invite.plan?.title || "Untitled Plan",
      inviterName: invite.creator?.display_name || "Someone",
      inviterAvatar: invite.creator?.avatar_url || null,
      role: "helper",
      expiresAt: invite.expires_at,
      code: invite.code,
    };
  } catch (err) {
    if (err instanceof InviteError) throw err;
    throw new InviteError(
      "network",
      "Unable to validate invite. Please check your connection.",
    );
  }
}

// ── Checklist Items (for AddTaskModal) ───────────────────────────────

export async function fetchChecklistItems(
  planId: string,
): Promise<{ id: string; title: string }[]> {
  const { data, error } = await supabase
    .from("plan_checklist_items")
    .select("id, title")
    .eq("plan_id", planId)
    .eq("is_completed", false)
    .order("sort_order", { ascending: true });

  if (error) {
    if (__DEV__) console.warn("Failed to fetch checklist items:", error);
    return [];
  }
  return data ?? [];
}

export async function createChecklistItem(
  planId: string,
  title: string,
  sortOrder: number,
): Promise<{ id: string; title: string } | null> {
  const safeTitle = sanitizeInput(title, 200);

  const { data, error } = await supabase
    .from("plan_checklist_items")
    .insert({
      plan_id: planId,
      title: safeTitle,
      sort_order: sortOrder,
    })
    .select("id, title")
    .single();

  if (error) {
    if (__DEV__) console.warn("Failed to create checklist item:", error);
    return null;
  }
  return data;
}

// ── Helpers ──────────────────────────────────────────────────────────

function generateInviteCode(): string {
  // Use secure token generator (no modulo bias), 16 chars = ~95-bit entropy
  return generateSecureToken(16);
}
