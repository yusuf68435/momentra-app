import { supabase } from "./supabase";
import { getCurrentUser, getCurrentUserId } from "./helpers";
import {
  sanitizeInput,
  sanitizeQueryParam,
  stripHtmlTags,
} from "../utils/crypto";

// ==========================================
// TYPES
// ==========================================

export interface Story {
  id: string;
  user_id: string;
  title: string;
  content: string;
  photos: string[];
  category: StoryCategory;
  likes_count: number;
  comments_count: number;
  is_anonymous: boolean;
  is_reported: boolean;
  author_name: string | null;
  author_avatar: string | null;
  created_at: string;
  updated_at: string;
  is_liked_by_me?: boolean;
}

export type StoryCategory =
  | "birthday"
  | "anniversary"
  | "proposal"
  | "graduation"
  | "baby_shower"
  | "holiday"
  | "just_because"
  | "other";

export interface StoryComment {
  id: string;
  story_id: string;
  user_id: string;
  content: string;
  author_name: string | null;
  author_avatar: string | null;
  created_at: string;
}

export interface StoryLike {
  id: string;
  story_id: string;
  user_id: string;
  created_at: string;
}

export interface StoryFilters {
  category?: StoryCategory;
  search?: string;
}

// ==========================================
// STORY FUNCTIONS
// ==========================================

export async function getStories(
  page: number = 1,
  filters?: StoryFilters,
  pageSize: number = 20,
): Promise<Story[]> {
  const userId = await getCurrentUserId();
  const from = (page - 1) * pageSize;
  const to = from + pageSize - 1;

  let query = supabase
    .from("community_stories")
    .select("*")
    .eq("is_reported", false)
    .order("created_at", { ascending: false })
    .range(from, to);

  if (filters?.category) {
    query = query.eq("category", filters.category);
  }

  if (filters?.search) {
    // Sanitize search input to prevent query injection
    const sanitized = sanitizeQueryParam(filters.search);
    if (sanitized) {
      query = query.or(
        `title.ilike.%${sanitized}%,content.ilike.%${sanitized}%`,
      );
    }
  }

  const { data, error } = await query;

  if (error) throw error;

  // Check which stories the user has liked
  if (userId && data && data.length > 0) {
    const storyIds = data.map((s) => s.id);
    const { data: likes } = await supabase
      .from("story_likes")
      .select("story_id")
      .eq("user_id", userId)
      .in("story_id", storyIds);

    const likedIds = new Set(likes?.map((l) => l.story_id) || []);
    return data.map((story) => ({
      ...story,
      is_liked_by_me: likedIds.has(story.id),
    }));
  }

  return data || [];
}

export async function getStoryById(id: string): Promise<Story | null> {
  const { data, error } = await supabase
    .from("community_stories")
    .select("*")
    .eq("id", id)
    .maybeSingle();

  if (error) {
    if (__DEV__) {
      console.warn("Failed to fetch story:", error);
    }
    return null;
  }
  return data;
}

export async function createStory(story: {
  title: string;
  content: string;
  photos?: string[];
  category: StoryCategory;
  is_anonymous?: boolean;
}): Promise<Story> {
  const user = await getCurrentUser();

  // Get user profile for author info
  const { data: profile } = await supabase
    .from("profiles")
    .select("display_name, avatar_url")
    .eq("id", user.id)
    .maybeSingle();

  // Sanitize user-generated content
  const safeTitle = stripHtmlTags(sanitizeInput(story.title, 200));
  const safeContent = stripHtmlTags(sanitizeInput(story.content, 5000));

  const { data, error } = await supabase
    .from("community_stories")
    .insert({
      user_id: user.id,
      title: safeTitle,
      content: safeContent,
      photos: story.photos || [],
      category: story.category,
      is_anonymous: story.is_anonymous ?? false,
      author_name: story.is_anonymous ? null : profile?.display_name || null,
      author_avatar: story.is_anonymous ? null : profile?.avatar_url || null,
      likes_count: 0,
      comments_count: 0,
    })
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function updateStory(
  id: string,
  updates: Partial<Pick<Story, "title" | "content" | "photos" | "category">>,
): Promise<Story> {
  const user = await getCurrentUser();
  const { data, error } = await supabase
    .from("community_stories")
    .update({ ...updates, updated_at: new Date().toISOString() })
    .eq("id", id)
    .eq("user_id", user.id)
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function deleteStory(id: string): Promise<void> {
  const user = await getCurrentUser();
  const { error } = await supabase
    .from("community_stories")
    .delete()
    .eq("id", id)
    .eq("user_id", user.id);

  if (error) throw error;
}

// ==========================================
// LIKES
// ==========================================

export async function likeStory(storyId: string): Promise<void> {
  const user = await getCurrentUser();

  const { error } = await supabase
    .from("story_likes")
    .insert({ story_id: storyId, user_id: user.id });

  if (error) {
    // Ignore unique constraint violation (already liked)
    if (error.code === "23505") return;
    throw error;
  }

  // Increment likes_count
  await supabase.rpc("increment_story_likes", { story_id: storyId });
}

export async function unlikeStory(storyId: string): Promise<void> {
  const user = await getCurrentUser();

  const { error } = await supabase
    .from("story_likes")
    .delete()
    .eq("story_id", storyId)
    .eq("user_id", user.id);

  if (error) throw error;

  // Decrement likes_count
  await supabase.rpc("decrement_story_likes", { story_id: storyId });
}

// ==========================================
// COMMENTS
// ==========================================

export async function commentOnStory(
  storyId: string,
  text: string,
): Promise<StoryComment> {
  const user = await getCurrentUser();

  const { data: profile } = await supabase
    .from("profiles")
    .select("display_name, avatar_url")
    .eq("id", user.id)
    .maybeSingle();

  // Sanitize comment content
  const safeText = stripHtmlTags(sanitizeInput(text, 1000));

  const { data, error } = await supabase
    .from("story_comments")
    .insert({
      story_id: storyId,
      user_id: user.id,
      content: safeText,
      author_name: profile?.display_name || null,
      author_avatar: profile?.avatar_url || null,
    })
    .select()
    .single();

  if (error) throw error;

  // Increment comments_count
  await supabase.rpc("increment_story_comments", { story_id: storyId });

  return data;
}

export async function getComments(storyId: string): Promise<StoryComment[]> {
  const { data, error } = await supabase
    .from("story_comments")
    .select("*")
    .eq("story_id", storyId)
    .order("created_at", { ascending: true });

  if (error) throw error;
  return data || [];
}

export async function deleteComment(
  id: string,
  storyId: string,
): Promise<void> {
  const user = await getCurrentUser();
  const { error } = await supabase
    .from("story_comments")
    .delete()
    .eq("id", id)
    .eq("user_id", user.id)
    .eq("story_id", storyId);

  if (error) throw error;

  // Decrement comments_count
  await supabase.rpc("decrement_story_comments", { story_id: storyId });
}

// ==========================================
// REPORTING
// ==========================================

const REPORT_THRESHOLD = 3;

export async function reportStory(id: string): Promise<void> {
  const user = await getCurrentUser();

  // Check if user already reported this story
  const { data: existing } = await supabase
    .from("story_reports")
    .select("id")
    .eq("story_id", id)
    .eq("user_id", user.id)
    .maybeSingle();

  if (existing) return; // already reported, silently ignore

  // Insert report record
  const { error: insertError } = await supabase
    .from("story_reports")
    .insert({ story_id: id, user_id: user.id });

  if (insertError) throw insertError;

  // Count total unique reports for this story
  const { count } = await supabase
    .from("story_reports")
    .select("id", { count: "exact", head: true })
    .eq("story_id", id);

  // Only flag story when threshold is reached
  if (count && count >= REPORT_THRESHOLD) {
    await supabase
      .from("community_stories")
      .update({ is_reported: true })
      .eq("id", id);
  }
}

// ==========================================
// TRENDING & USER STORIES
// ==========================================

export async function getTrendingStories(limit: number = 10): Promise<Story[]> {
  const { data, error } = await supabase
    .from("community_stories")
    .select("*")
    .eq("is_reported", false)
    .order("likes_count", { ascending: false })
    .order("comments_count", { ascending: false })
    .limit(limit);

  if (error) throw error;
  return data || [];
}

export async function getMyStories(): Promise<Story[]> {
  const user = await getCurrentUser();

  const { data, error } = await supabase
    .from("community_stories")
    .select("*")
    .eq("user_id", user.id)
    .order("created_at", { ascending: false });

  if (error) throw error;
  return data || [];
}
