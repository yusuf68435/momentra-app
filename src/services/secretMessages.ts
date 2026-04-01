import { supabase } from "./supabase";
import { getCurrentUser } from "./helpers";
import {
  deriveMessageKey,
  encryptMessage,
  decryptMessage,
  sanitizeInput,
  isValidUUID,
} from "../utils/crypto";

// ==========================================
// TYPES
// ==========================================

export interface SecretMessage {
  id: string;
  plan_id: string;
  sender_id: string;
  recipient_id: string;
  content: string; // Decrypted plaintext (computed from encrypted_content)
  encrypted_content: string; // Raw encrypted value from DB
  is_read: boolean;
  read_at: string | null;
  sent_at: string; // Mapped from created_at in DB
  sender_name?: string | null;
  is_encrypted?: boolean; // Flag to distinguish old/new messages
}

export interface MessageThread {
  plan_id: string;
  participant_id: string;
  participant_name: string | null;
  last_message: string;
  last_message_at: string;
  unread_count: number;
}

// ==========================================
// ENCRYPTION HELPERS
// ==========================================

const ENCRYPTION_PREFIX = "enc:v1:";

/**
 * Build a shared secret from the two user IDs (sorted for consistency).
 */
function buildSharedSecret(userId1: string, userId2: string): string {
  const sorted = [userId1, userId2].sort();
  return sorted.join(":");
}

/**
 * Encrypt content for storage.
 */
async function encryptContent(
  content: string,
  planId: string,
  senderId: string,
  recipientId: string,
): Promise<string> {
  const sharedSecret = buildSharedSecret(senderId, recipientId);
  const key = await deriveMessageKey(planId, sharedSecret);
  const encrypted = encryptMessage(content, key);
  return ENCRYPTION_PREFIX + encrypted;
}

/**
 * Decrypt content from storage. Returns plaintext or the original content
 * if decryption fails (e.g., legacy unencrypted messages).
 */
async function decryptContent(
  storedContent: string,
  planId: string,
  senderId: string,
  recipientId: string,
): Promise<string> {
  if (!storedContent.startsWith(ENCRYPTION_PREFIX)) {
    // Legacy unencrypted message — return as-is
    return storedContent;
  }
  const cipherBase64 = storedContent.slice(ENCRYPTION_PREFIX.length);
  const sharedSecret = buildSharedSecret(senderId, recipientId);
  const key = await deriveMessageKey(planId, sharedSecret);
  const plaintext = decryptMessage(cipherBase64, key);
  return plaintext ?? "[Mesaj çözümlenemedi / Message could not be decrypted]";
}

/**
 * Decrypt an array of messages in-place.
 */
async function decryptMessages(
  messages: SecretMessage[],
): Promise<SecretMessage[]> {
  return Promise.all(
    messages.map(async (msg) => ({
      ...msg,
      content: await decryptContent(
        msg.encrypted_content,
        msg.plan_id,
        msg.sender_id,
        msg.recipient_id,
      ),
      is_encrypted: msg.encrypted_content.startsWith(ENCRYPTION_PREFIX),
    })),
  );
}

// ==========================================
// MESSAGE FUNCTIONS
// ==========================================

export async function sendMessage(
  planId: string,
  recipientId: string,
  content: string,
): Promise<SecretMessage> {
  const user = await getCurrentUser();

  // Sanitize input before encryption
  const sanitized = sanitizeInput(content, 500);

  // Encrypt message content
  const encryptedContent = await encryptContent(
    sanitized,
    planId,
    user.id,
    recipientId,
  );

  const { data, error } = await supabase
    .from("secret_messages")
    .insert({
      plan_id: planId,
      sender_id: user.id,
      recipient_id: recipientId,
      encrypted_content: encryptedContent,
      is_read: false,
    })
    .select()
    .single();

  if (error) throw error;

  // Return with decrypted content for immediate UI display
  return {
    ...data,
    content: sanitized,
    encrypted_content: data.encrypted_content,
    sent_at: data.created_at,
    is_encrypted: true,
  };
}

export async function getMessages(planId: string): Promise<SecretMessage[]> {
  const user = await getCurrentUser();

  const { data, error } = await supabase
    .from("secret_messages")
    .select("*")
    .eq("plan_id", planId)
    .or(`sender_id.eq.${user.id},recipient_id.eq.${user.id}`)
    .order("created_at", { ascending: true });

  if (error) throw error;
  if (!data || data.length === 0) return [];

  // Map DB columns to SecretMessage shape before decrypting
  const mapped = data.map((row) => ({
    ...row,
    content: (row as { encrypted_content?: string }).encrypted_content ?? "",
    encrypted_content:
      (row as { encrypted_content?: string }).encrypted_content ?? "",
    sent_at: row.created_at,
    sender_name: null,
  })) as SecretMessage[];

  return decryptMessages(mapped);
}

export async function getMessagesBetweenUsers(
  planId: string,
  otherUserId: string,
): Promise<SecretMessage[]> {
  if (!isValidUUID(otherUserId)) throw new Error("Invalid user ID");
  const user = await getCurrentUser();

  const { data, error } = await supabase
    .from("secret_messages")
    .select("*")
    .eq("plan_id", planId)
    .or(
      `and(sender_id.eq.${user.id},recipient_id.eq.${otherUserId}),and(sender_id.eq.${otherUserId},recipient_id.eq.${user.id})`,
    )
    .order("created_at", { ascending: true });

  if (error) throw error;
  if (!data || data.length === 0) return [];

  // Map DB columns to SecretMessage shape before decrypting
  const mapped = data.map((row) => ({
    ...row,
    content: (row as { encrypted_content?: string }).encrypted_content ?? "",
    encrypted_content:
      (row as { encrypted_content?: string }).encrypted_content ?? "",
    sent_at: row.created_at,
    sender_name: null,
  })) as SecretMessage[];

  return decryptMessages(mapped);
}

export async function markAsRead(id: string): Promise<void> {
  const user = await getCurrentUser();
  const { error } = await supabase
    .from("secret_messages")
    .update({
      is_read: true,
      read_at: new Date().toISOString(),
    })
    .eq("id", id)
    .eq("recipient_id", user.id);

  if (error) throw error;
}

export async function markAllAsRead(planId: string): Promise<void> {
  const user = await getCurrentUser();

  const { error } = await supabase
    .from("secret_messages")
    .update({
      is_read: true,
      read_at: new Date().toISOString(),
    })
    .eq("plan_id", planId)
    .eq("recipient_id", user.id)
    .eq("is_read", false);

  if (error) throw error;
}

export async function deleteMessage(id: string): Promise<void> {
  const user = await getCurrentUser();
  const { error } = await supabase
    .from("secret_messages")
    .delete()
    .eq("id", id)
    .or(`sender_id.eq.${user.id},recipient_id.eq.${user.id}`);

  if (error) throw error;
}

export async function getUnreadCount(planId: string): Promise<number> {
  const user = await getCurrentUser();

  const { count, error } = await supabase
    .from("secret_messages")
    .select("*", { count: "exact", head: true })
    .eq("plan_id", planId)
    .eq("recipient_id", user.id)
    .eq("is_read", false);

  if (error) {
    if (__DEV__) {
      console.warn("Failed to get unread count:", error);
    }
    return 0;
  }
  return count || 0;
}
