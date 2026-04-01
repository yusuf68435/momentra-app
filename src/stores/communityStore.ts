import { create } from "zustand";
import * as communityApi from "../services/community";

// ── Types ────────────────────────────────────────────────────────────

export interface Story {
  id: string;
  user_id: string;
  author_name: string;
  author_avatar: string | null;
  title: string;
  content: string;
  images: string[];
  category: string;
  tags: string[];
  like_count: number;
  comment_count: number;
  is_liked: boolean;
  is_featured: boolean;
  created_at: string;
  updated_at: string;
}

export interface Comment {
  id: string;
  story_id: string;
  user_id: string;
  author_name: string;
  author_avatar: string | null;
  text: string;
  created_at: string;
}

export interface CreateStoryData {
  title: string;
  content: string;
  images?: string[];
  category?: string;
  tags?: string[];
  is_anonymous?: boolean;
}

// ── Category fallback images ─────────────────────────────────────────

const CATEGORY_FALLBACK_IMAGES: Record<string, string> = {
  birthday:
    "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&h=600&fit=crop",
  anniversary:
    "https://images.unsplash.com/photo-1518895949257-7621c3c786d7?w=800&h=600&fit=crop",
  proposal:
    "https://images.unsplash.com/photo-1518199266791-5375a83190b7?w=800&h=600&fit=crop",
  graduation:
    "https://images.unsplash.com/photo-1523580846011-d3a5bc25702b?w=800&h=600&fit=crop",
  baby_shower:
    "https://images.unsplash.com/photo-1555252333-9f8e92e65df9?w=800&h=600&fit=crop",
  holiday:
    "https://images.unsplash.com/photo-1543872084-c7bd3822856f?w=800&h=600&fit=crop",
  just_because:
    "https://images.unsplash.com/photo-1547212371-69addf5b2b73?w=800&h=600&fit=crop",
  other:
    "https://images.unsplash.com/photo-1527529482837-4698179dc6ce?w=800&h=600&fit=crop",
};

// ── Mappers: normalize service types → store types ──────────────────

function mapServiceStory(s: communityApi.Story): Story {
  const photos = s.photos ?? [];
  const images =
    photos.length > 0
      ? photos
      : [
          CATEGORY_FALLBACK_IMAGES[s.category] ??
            CATEGORY_FALLBACK_IMAGES.other,
        ];
  return {
    id: s.id,
    user_id: s.user_id,
    author_name: s.author_name ?? "",
    author_avatar: s.author_avatar,
    title: s.title,
    content: s.content,
    images,
    category: s.category,
    tags: [],
    like_count: s.likes_count,
    comment_count: s.comments_count,
    is_liked: s.is_liked_by_me ?? false,
    is_featured: false,
    created_at: s.created_at,
    updated_at: s.updated_at,
  };
}

function mapServiceComment(c: communityApi.StoryComment): Comment {
  return {
    id: c.id,
    story_id: c.story_id,
    user_id: c.user_id,
    author_name: c.author_name ?? "",
    author_avatar: c.author_avatar,
    text: c.content,
    created_at: c.created_at,
  };
}

// ── Store ────────────────────────────────────────────────────────────

interface CommunityState {
  stories: Story[];
  trendingStories: Story[];
  myStories: Story[];
  isLoading: boolean;
  error: string | null;
  page: number;
  hasMore: boolean;

  // Actions
  fetchStories: () => Promise<void>;
  fetchTrending: () => Promise<void>;
  fetchMyStories: () => Promise<void>;
  createStory: (data: CreateStoryData) => Promise<Story>;
  deleteStory: (id: string) => Promise<void>;
  likeStory: (id: string) => Promise<void>;
  commentOnStory: (id: string, text: string) => Promise<Comment>;
  loadMore: () => Promise<void>;
  refreshStories: () => Promise<void>;
}

export const useCommunityStore = create<CommunityState>((set, get) => ({
  stories: [],
  trendingStories: [],
  myStories: [],
  isLoading: false,
  error: null,
  page: 1,
  hasMore: true,

  fetchStories: async () => {
    set({ isLoading: true, error: null });
    try {
      const raw = await communityApi.getStories(1);
      const stories = raw.map(mapServiceStory);
      set({ stories, page: 1, hasMore: stories.length >= 20 });
    } catch (error) {
      const message =
        error instanceof Error ? error.message : "Failed to fetch stories";
      if (__DEV__) {
        console.error("Failed to fetch stories:", error);
      }
      set({ error: message });
    } finally {
      set({ isLoading: false });
    }
  },

  fetchTrending: async () => {
    set({ isLoading: true, error: null });
    try {
      const raw = await communityApi.getTrendingStories();
      const trendingStories = raw.map(mapServiceStory);
      set({ trendingStories });
    } catch (error) {
      const message =
        error instanceof Error
          ? error.message
          : "Failed to fetch trending stories";
      if (__DEV__) {
        console.error("Failed to fetch trending:", error);
      }
      set({ error: message });
    } finally {
      set({ isLoading: false });
    }
  },

  fetchMyStories: async () => {
    set({ isLoading: true, error: null });
    try {
      const raw = await communityApi.getMyStories();
      const myStories = raw.map(mapServiceStory);
      set({ myStories });
    } catch (error) {
      const message =
        error instanceof Error ? error.message : "Failed to fetch my stories";
      if (__DEV__) {
        console.error("Failed to fetch my stories:", error);
      }
      set({ error: message });
    } finally {
      set({ isLoading: false });
    }
  },

  createStory: async (data) => {
    set({ isLoading: true, error: null });
    try {
      const raw = await communityApi.createStory({
        title: data.title,
        content: data.content,
        photos: data.images,
        category: (data.category as communityApi.StoryCategory) || "other",
        is_anonymous: data.is_anonymous,
      });
      const story = mapServiceStory(raw);
      set((state) => ({
        stories: [story, ...state.stories],
        myStories: [story, ...state.myStories],
      }));
      return story;
    } catch (error) {
      const message =
        error instanceof Error ? error.message : "Failed to create story";
      if (__DEV__) {
        console.error("Failed to create story:", error);
      }
      set({ error: message });
      throw error;
    } finally {
      set({ isLoading: false });
    }
  },

  deleteStory: async (id) => {
    const { stories, trendingStories, myStories } = get();
    const removeById = (list: Story[]) => list.filter((s) => s.id !== id);

    // Optimistic removal
    set({
      stories: removeById(stories),
      trendingStories: removeById(trendingStories),
      myStories: removeById(myStories),
    });

    try {
      await communityApi.deleteStory(id);
    } catch (error) {
      // Revert on failure
      set({ stories, trendingStories, myStories });
      throw error;
    }
  },

  likeStory: async (id) => {
    // Capture original state BEFORE optimistic update
    const story = get().stories.find((s) => s.id === id);
    const wasLiked = story?.is_liked ?? false;

    // Optimistic update
    const toggleLike = (s: Story) =>
      s.id === id
        ? {
            ...s,
            is_liked: !s.is_liked,
            like_count: s.like_count + (s.is_liked ? -1 : 1),
          }
        : s;

    set((state) => ({
      stories: state.stories.map(toggleLike),
      trendingStories: state.trendingStories.map(toggleLike),
      myStories: state.myStories.map(toggleLike),
    }));

    try {
      if (wasLiked) {
        await communityApi.unlikeStory(id);
      } else {
        await communityApi.likeStory(id);
      }
    } catch (error) {
      // Revert on failure
      set((state) => ({
        stories: state.stories.map(toggleLike),
        trendingStories: state.trendingStories.map(toggleLike),
        myStories: state.myStories.map(toggleLike),
      }));
      throw error;
    }
  },

  commentOnStory: async (id, text) => {
    try {
      const raw = await communityApi.commentOnStory(id, text);
      const comment = mapServiceComment(raw);
      set((state) => ({
        stories: state.stories.map((s) =>
          s.id === id ? { ...s, comment_count: s.comment_count + 1 } : s,
        ),
      }));
      return comment;
    } catch (error) {
      if (__DEV__) {
        console.error("Failed to comment on story:", error);
      }
      throw error;
    }
  },

  loadMore: async () => {
    const { page, hasMore, isLoading } = get();
    if (!hasMore || isLoading) return;

    set({ isLoading: true });
    try {
      const nextPage = page + 1;
      const raw = await communityApi.getStories(nextPage);
      const newStories = raw.map(mapServiceStory);
      set((state) => ({
        stories: [...state.stories, ...newStories],
        page: nextPage,
        hasMore: newStories.length >= 20,
      }));
    } catch (error) {
      const message =
        error instanceof Error ? error.message : "Failed to load more stories";
      if (__DEV__) {
        console.error("Failed to load more:", error);
      }
      set({ error: message });
    } finally {
      set({ isLoading: false });
    }
  },

  refreshStories: async () => {
    set({ page: 1, hasMore: true });
    await get().fetchStories();
  },
}));
