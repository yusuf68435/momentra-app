import { supabase } from "./supabase";
import { getCurrentUserId } from "./helpers";

// ==========================================
// AI Conversation Persistence
// Stores chat history in DB for cross-session continuity
// ==========================================

export interface AIConversation {
  id: string;
  user_id: string;
  title: string;
  context_plan_id: string | null;
  context_scenario_id: string | null;
  messages: ConversationMessage[];
  is_active: boolean;
  created_at: string;
  updated_at: string;
}

export interface ConversationMessage {
  role: "user" | "assistant";
  content: string;
  timestamp: string;
  actions?: Array<{
    type: string;
    label: string;
    data: Record<string, string>;
  }>;
}

/**
 * Get or create the active conversation for the current user.
 * Each user has one active conversation at a time.
 */
export async function getActiveConversation(): Promise<AIConversation | null> {
  const userId = await getCurrentUserId();
  if (!userId) return null;

  const { data, error } = await supabase
    .from("ai_conversations")
    .select("*")
    .eq("user_id", userId)
    .eq("is_active", true)
    .order("updated_at", { ascending: false })
    .limit(1)
    .maybeSingle();

  if (error) {
    if (__DEV__) console.warn("Failed to get active conversation:", error);
    return null;
  }

  return data as AIConversation | null;
}

/**
 * Create a new conversation, deactivating any existing active one.
 */
export async function createConversation(context?: {
  planId?: string;
  scenarioId?: string;
  title?: string;
}): Promise<AIConversation | null> {
  const userId = await getCurrentUserId();
  if (!userId) return null;

  // Deactivate existing active conversations
  await supabase
    .from("ai_conversations")
    .update({ is_active: false, updated_at: new Date().toISOString() })
    .eq("user_id", userId)
    .eq("is_active", true);

  const { data, error } = await supabase
    .from("ai_conversations")
    .insert({
      user_id: userId,
      title: context?.title || new Date().toLocaleDateString(),
      context_plan_id: context?.planId || null,
      context_scenario_id: context?.scenarioId || null,
      messages: [],
      is_active: true,
    })
    .select()
    .single();

  if (error) {
    if (__DEV__) {
      console.warn("Failed to create conversation:", error);
    }
    return null;
  }

  return data as AIConversation;
}

/**
 * Append a message to the active conversation.
 */
export async function appendMessage(
  conversationId: string,
  message: ConversationMessage,
): Promise<void> {
  // Fetch current messages
  const { data } = await supabase
    .from("ai_conversations")
    .select("messages")
    .eq("id", conversationId)
    .single();

  if (!data) return;

  const messages = [
    ...((data.messages as ConversationMessage[]) || []),
    message,
  ];

  // Keep last 50 messages to prevent bloat
  const trimmedMessages = messages.slice(-50);

  // Auto-generate title from first user message
  const updates: Record<string, unknown> = {
    messages: trimmedMessages,
    updated_at: new Date().toISOString(),
  };

  if (trimmedMessages.length === 1 && message.role === "user") {
    updates.title =
      message.content.substring(0, 60) +
      (message.content.length > 60 ? "..." : "");
  }

  await supabase
    .from("ai_conversations")
    .update(updates)
    .eq("id", conversationId);
}

/**
 * Get conversation history for the current user.
 */
export async function getConversationHistory(
  limit = 10,
): Promise<AIConversation[]> {
  const userId = await getCurrentUserId();
  if (!userId) return [];

  const { data } = await supabase
    .from("ai_conversations")
    .select("id, title, is_active, created_at, updated_at")
    .eq("user_id", userId)
    .order("updated_at", { ascending: false })
    .limit(limit);

  return (data || []) as AIConversation[];
}

/**
 * Load a specific conversation with all messages.
 */
export async function loadConversation(
  conversationId: string,
): Promise<AIConversation | null> {
  const { data } = await supabase
    .from("ai_conversations")
    .select("*")
    .eq("id", conversationId)
    .single();

  return data as AIConversation | null;
}

/**
 * Delete a conversation.
 */
export async function deleteConversation(
  conversationId: string,
): Promise<void> {
  const userId = await getCurrentUserId();
  if (!userId) return;

  await supabase
    .from("ai_conversations")
    .delete()
    .eq("id", conversationId)
    .eq("user_id", userId);
}
