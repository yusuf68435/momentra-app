import { create } from "zustand";
import * as musicApi from "../services/music";

// ── Types ────────────────────────────────────────────────────────────

export interface Song {
  id: string;
  plan_id: string;
  title: string;
  artist: string;
  album: string | null;
  duration_seconds: number | null;
  preview_url: string | null;
  cover_url: string | null;
  external_id: string | null;
  external_source: "spotify" | "apple_music" | "manual" | null;
  sort_order: number;
  added_by: string;
  created_at: string;
}

export interface AddSongData {
  title: string;
  artist: string;
  album?: string;
  duration_seconds?: number;
  preview_url?: string;
  cover_url?: string;
  external_id?: string;
  external_source?: Song["external_source"];
}

// ── Service layer ────────────────────────────────────────────────────

const musicService = {
  fetchPlaylist: async (planId: string): Promise<Song[]> => {
    const playlist = await musicApi.getPlaylistForPlan(planId);
    if (!playlist) return [];
    return (playlist.songs || []).map((s) => ({
      id: s.id,
      plan_id: planId,
      title: s.title,
      artist: s.artist,
      album: s.album,
      duration_seconds: s.duration_seconds,
      preview_url: s.preview_url,
      cover_url: s.image_url,
      external_id: s.external_id ?? null,
      external_source: (s.external_source as Song["external_source"]) ?? null,
      sort_order: s.sort_order,
      added_by: "",
      created_at: s.created_at,
    }));
  },
  addSong: async (planId: string, song: AddSongData): Promise<Song> => {
    // Ensure a playlist exists for this plan; fetch or create one
    let playlist = await musicApi.getPlaylistForPlan(planId);
    if (!playlist) {
      playlist = await musicApi.createPlaylist(planId, {
        name: "Playlist",
        mood: "fun",
      });
    }
    const s = await musicApi.addSong(playlist.id, {
      title: song.title,
      artist: song.artist,
      album: song.album,
      duration_seconds: song.duration_seconds,
      preview_url: song.preview_url,
      image_url: song.cover_url,
      external_id: song.external_id,
      external_source: song.external_source ?? undefined,
    });
    return {
      id: s.id,
      plan_id: planId,
      title: s.title,
      artist: s.artist,
      album: s.album,
      duration_seconds: s.duration_seconds,
      preview_url: s.preview_url,
      cover_url: s.image_url,
      external_id: s.external_id ?? null,
      external_source: (s.external_source as Song["external_source"]) ?? null,
      sort_order: s.sort_order,
      added_by: "",
      created_at: s.created_at,
    };
  },
  removeSong: (id: string): Promise<void> => musicApi.removeSong(id),
  fetchSuggestions: async (
    _category: string,
    mood: string,
  ): Promise<Song[]> => {
    const suggestions = musicApi.getSuggestedPlaylists(
      undefined,
      mood as musicApi.PlaylistMood,
    );
    // Flatten suggested songs into Song-like objects
    return suggestions.flatMap((pl) =>
      pl.songs.map((s, idx) => ({
        id: `suggestion-${pl.name}-${idx}`,
        plan_id: "",
        title: s.title,
        artist: s.artist,
        album: null,
        duration_seconds: null,
        preview_url: null,
        cover_url: null,
        external_id: null,
        external_source: null,
        sort_order: idx,
        added_by: "",
        created_at: "",
      })),
    );
  },
  reorder: (items: { id: string; sort_order: number }[]): Promise<void> =>
    musicApi.reorderSongs(items),
};

// ── Store ────────────────────────────────────────────────────────────

interface MusicState {
  playlists: Record<string, Song[]>;
  suggestions: Song[];
  isLoading: boolean;
  error: string | null;

  // Actions
  fetchPlaylist: (planId: string) => Promise<void>;
  addSong: (planId: string, song: AddSongData) => Promise<Song>;
  removeSong: (id: string) => Promise<void>;
  fetchSuggestions: (category: string, mood: string) => Promise<void>;
  reorder: (planId: string, items: Song[]) => Promise<void>;
}

export const useMusicStore = create<MusicState>((set, get) => ({
  playlists: {},
  suggestions: [],
  isLoading: false,
  error: null,

  fetchPlaylist: async (planId) => {
    set({ isLoading: true, error: null });
    try {
      const songs = await musicService.fetchPlaylist(planId);
      set((state) => ({
        playlists: { ...state.playlists, [planId]: songs },
      }));
    } catch (error) {
      const message =
        error instanceof Error ? error.message : "Failed to fetch playlist";
      if (__DEV__) {
        console.error("Failed to fetch playlist:", error);
      }
      set({ error: message });
    } finally {
      set({ isLoading: false });
    }
  },

  addSong: async (planId, songData) => {
    set({ isLoading: true, error: null });
    try {
      const song = await musicService.addSong(planId, songData);
      set((state) => ({
        playlists: {
          ...state.playlists,
          [planId]: [...(state.playlists[planId] ?? []), song],
        },
      }));
      return song;
    } catch (error) {
      const message =
        error instanceof Error ? error.message : "Failed to add song";
      if (__DEV__) {
        console.error("Failed to add song:", error);
      }
      set({ error: message });
      throw error;
    } finally {
      set({ isLoading: false });
    }
  },

  removeSong: async (id) => {
    const { playlists } = get();
    let targetPlanId: string | null = null;
    let previousSongs: Song[] = [];
    for (const [planId, songs] of Object.entries(playlists)) {
      if (songs.some((s) => s.id === id)) {
        targetPlanId = planId;
        previousSongs = songs;
        break;
      }
    }

    if (!targetPlanId) return;

    // Optimistic update
    set((state) => ({
      playlists: {
        ...state.playlists,
        [targetPlanId!]: (state.playlists[targetPlanId!] ?? []).filter(
          (s) => s.id !== id,
        ),
      },
    }));

    try {
      await musicService.removeSong(id);
    } catch (error) {
      // Revert on failure
      set((state) => ({
        playlists: { ...state.playlists, [targetPlanId!]: previousSongs },
      }));
      throw error;
    }
  },

  fetchSuggestions: async (category, mood) => {
    set({ isLoading: true, error: null });
    try {
      const suggestions = await musicService.fetchSuggestions(category, mood);
      set({ suggestions });
    } catch (error) {
      const message =
        error instanceof Error ? error.message : "Failed to fetch suggestions";
      if (__DEV__) {
        console.error("Failed to fetch music suggestions:", error);
      }
      set({ error: message });
    } finally {
      set({ isLoading: false });
    }
  },

  reorder: async (planId, items) => {
    // Optimistic update
    const previousItems = get().playlists[planId] ?? [];
    set((state) => ({
      playlists: { ...state.playlists, [planId]: items },
    }));

    try {
      await musicService.reorder(
        items.map((item, index) => ({ id: item.id, sort_order: index })),
      );
    } catch (error) {
      // Revert on failure
      set((state) => ({
        playlists: { ...state.playlists, [planId]: previousItems },
      }));
      if (__DEV__) {
        console.error("Failed to reorder playlist:", error);
      }
      throw error;
    }
  },
}));
