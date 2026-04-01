import { Linking } from "react-native";
import { supabase } from "./supabase";
import { getCurrentUser } from "./helpers";

// ==========================================
// TYPES
// ==========================================

export interface Song {
  id: string;
  playlist_id: string;
  title: string;
  artist: string;
  album: string | null;
  duration_seconds: number | null;
  preview_url: string | null;
  image_url: string | null;
  external_id: string | null;
  external_source: string | null;
  sort_order: number;
  created_at: string;
}

export interface Playlist {
  id: string;
  plan_id: string;
  user_id: string;
  name: string;
  mood: PlaylistMood;
  description: string | null;
  songs: Song[];
  created_at: string;
  updated_at: string;
}

export type PlaylistMood =
  | "romantic"
  | "fun"
  | "energetic"
  | "chill"
  | "nostalgic"
  | "celebratory"
  | "emotional"
  | "upbeat";

export interface SuggestedPlaylist {
  name: string;
  mood: PlaylistMood;
  description: string;
  songs: { title: string; artist: string }[];
}

// ==========================================
// PLAYLIST FUNCTIONS
// ==========================================

export async function getPlaylistForPlan(
  planId: string,
): Promise<Playlist | null> {
  const { data, error } = await supabase
    .from("music_playlists")
    .select("*, songs:music_playlist_songs(*)")
    .eq("plan_id", planId)
    .order("sort_order", { foreignTable: "music_playlist_songs" })
    .maybeSingle();

  if (error) {
    if (__DEV__) {
      console.warn("Failed to fetch playlist:", error);
    }
    return null;
  }
  return data;
}

export async function createPlaylist(
  planId: string,
  playlist: {
    name: string;
    mood: PlaylistMood;
    description?: string;
  },
): Promise<Playlist> {
  const user = await getCurrentUser();

  const { data, error } = await supabase
    .from("music_playlists")
    .insert({
      plan_id: planId,
      user_id: user.id,
      name: playlist.name,
      mood: playlist.mood,
      description: playlist.description || null,
    })
    .select("*, songs:music_playlist_songs(*)")
    .single();

  if (error) throw error;
  return data;
}

export async function updatePlaylist(
  id: string,
  updates: Partial<Pick<Playlist, "name" | "mood" | "description">>,
): Promise<Playlist> {
  const { data, error } = await supabase
    .from("music_playlists")
    .update({ ...updates, updated_at: new Date().toISOString() })
    .eq("id", id)
    .select("*, songs:music_playlist_songs(*)")
    .single();

  if (error) throw error;
  return data;
}

export async function deletePlaylist(id: string): Promise<void> {
  const { error } = await supabase
    .from("music_playlists")
    .delete()
    .eq("id", id);

  if (error) throw error;
}

// ==========================================
// SONG FUNCTIONS
// ==========================================

export async function addSong(
  playlistId: string,
  song: {
    title: string;
    artist: string;
    album?: string;
    duration_seconds?: number;
    preview_url?: string;
    image_url?: string;
    external_id?: string;
    external_source?: string;
  },
): Promise<Song> {
  // Get max sort_order
  const { data: existing } = await supabase
    .from("music_playlist_songs")
    .select("sort_order")
    .eq("playlist_id", playlistId)
    .order("sort_order", { ascending: false })
    .limit(1);

  const nextOrder = (existing?.[0]?.sort_order ?? -1) + 1;

  const { data, error } = await supabase
    .from("music_playlist_songs")
    .insert({
      playlist_id: playlistId,
      title: song.title,
      artist: song.artist,
      album: song.album || null,
      duration_seconds: song.duration_seconds || null,
      preview_url: song.preview_url || null,
      image_url: song.image_url || null,
      external_id: song.external_id || null,
      external_source: song.external_source || null,
      sort_order: nextOrder,
    })
    .select()
    .single();

  if (error) throw error;
  return data;
}

export async function removeSong(id: string): Promise<void> {
  const { error } = await supabase
    .from("music_playlist_songs")
    .delete()
    .eq("id", id);

  if (error) throw error;
}

export async function reorderSongs(
  items: { id: string; sort_order: number }[],
): Promise<void> {
  const updates = items.map((item) =>
    supabase
      .from("music_playlist_songs")
      .update({ sort_order: item.sort_order })
      .eq("id", item.id),
  );

  await Promise.all(updates);
}

// ==========================================
// SUGGESTIONS
// ==========================================

export function getSuggestedPlaylists(
  category?: string,
  mood?: PlaylistMood,
): SuggestedPlaylist[] {
  const allSuggestions: SuggestedPlaylist[] = [
    {
      name: "Romantic Evening",
      mood: "romantic",
      description: "Perfect songs for a romantic surprise dinner",
      songs: [
        { title: "At Last", artist: "Etta James" },
        { title: "Thinking Out Loud", artist: "Ed Sheeran" },
        { title: "All of Me", artist: "John Legend" },
        { title: "Perfect", artist: "Ed Sheeran" },
        { title: "La Vie en Rose", artist: "Edith Piaf" },
      ],
    },
    {
      name: "Party Time",
      mood: "energetic",
      description: "High-energy tracks to get the party started",
      songs: [
        { title: "Happy", artist: "Pharrell Williams" },
        { title: "Uptown Funk", artist: "Bruno Mars" },
        { title: "Don't Stop Me Now", artist: "Queen" },
        { title: "Shake It Off", artist: "Taylor Swift" },
        { title: "I Gotta Feeling", artist: "Black Eyed Peas" },
      ],
    },
    {
      name: "Fun & Games",
      mood: "fun",
      description: "Lighthearted and fun playlist for casual surprises",
      songs: [
        { title: "Walking on Sunshine", artist: "Katrina & the Waves" },
        { title: "Best Day of My Life", artist: "American Authors" },
        { title: "Celebration", artist: "Kool & The Gang" },
        { title: "Good as Hell", artist: "Lizzo" },
        { title: "On Top of the World", artist: "Imagine Dragons" },
      ],
    },
    {
      name: "Chill Vibes",
      mood: "chill",
      description: "Relaxed ambient music for intimate gatherings",
      songs: [
        { title: "Weightless", artist: "Marconi Union" },
        { title: "Banana Pancakes", artist: "Jack Johnson" },
        { title: "Better Together", artist: "Jack Johnson" },
        { title: "Electric Feel", artist: "MGMT" },
        { title: "Budapest", artist: "George Ezra" },
      ],
    },
    {
      name: "Nostalgic Throwbacks",
      mood: "nostalgic",
      description: "Classic hits that bring back memories",
      songs: [
        { title: "Bohemian Rhapsody", artist: "Queen" },
        { title: "Sweet Caroline", artist: "Neil Diamond" },
        { title: "Dancing Queen", artist: "ABBA" },
        { title: "Ain't No Mountain High Enough", artist: "Marvin Gaye" },
        { title: "Mr. Brightside", artist: "The Killers" },
      ],
    },
    {
      name: "Celebration Anthems",
      mood: "celebratory",
      description: "Songs to mark a special occasion",
      songs: [
        { title: "Celebrate", artist: "Anderson .Paak" },
        { title: "Birthday", artist: "The Beatles" },
        { title: "Beautiful Day", artist: "U2" },
        { title: "Firework", artist: "Katy Perry" },
        { title: "Here Comes the Sun", artist: "The Beatles" },
      ],
    },
    {
      name: "Emotional Moments",
      mood: "emotional",
      description: "Heartfelt songs for touching surprise reveals",
      songs: [
        { title: "You Are the Best Thing", artist: "Ray LaMontagne" },
        { title: "A Thousand Years", artist: "Christina Perri" },
        { title: "Count on Me", artist: "Bruno Mars" },
        { title: "Wind Beneath My Wings", artist: "Bette Midler" },
        { title: "You've Got a Friend", artist: "Carole King" },
      ],
    },
    {
      name: "Upbeat Surprise",
      mood: "upbeat",
      description: "Feel-good tracks for an upbeat surprise",
      songs: [
        { title: "Levitating", artist: "Dua Lipa" },
        { title: "Blinding Lights", artist: "The Weeknd" },
        { title: "Good 4 U", artist: "Olivia Rodrigo" },
        { title: "Dynamite", artist: "BTS" },
        { title: "As It Was", artist: "Harry Styles" },
      ],
    },
  ];

  return allSuggestions.filter((playlist) => {
    if (mood && playlist.mood !== mood) return false;
    return true;
  });
}

// ==========================================
// SPOTIFY INTEGRATION
// ==========================================

export interface SpotifyTrackData {
  spotifyId: string;
  spotifyUri: string;
  previewUrl: string | null;
  imageUrl: string | null;
  album: string | null;
  durationMs: number;
}

/**
 * Search Spotify for multiple tracks via the spotify-search edge function.
 * Returns null for each track that couldn't be found or when not configured.
 */
export async function searchSpotifyTracks(
  queries: { title: string; artist: string }[],
): Promise<(SpotifyTrackData | null)[]> {
  if (queries.length === 0) return [];
  try {
    const { data, error } = await supabase.functions.invoke("spotify-search", {
      body: { queries },
    });
    if (error || !data?.results) return queries.map(() => null);
    return data.results as (SpotifyTrackData | null)[];
  } catch {
    return queries.map(() => null);
  }
}

/**
 * Generate a Spotify search URL for a song.
 */
export function getSpotifySearchUrl(title: string, artist: string): string {
  const query = encodeURIComponent(`${title} ${artist}`);
  return `https://open.spotify.com/search/${query}`;
}

/**
 * Generate a Spotify search URL for a playlist name.
 */
export function getSpotifyPlaylistSearchUrl(playlistName: string): string {
  const query = encodeURIComponent(playlistName);
  return `https://open.spotify.com/search/${query}`;
}

/**
 * Open a song in Spotify. Uses direct track URI when available, otherwise falls back to search.
 */
export async function openInSpotify(
  title: string,
  artist: string,
  spotifyUri?: string,
): Promise<void> {
  if (spotifyUri) {
    const canOpenApp = await Linking.canOpenURL(spotifyUri);
    if (canOpenApp) {
      await Linking.openURL(spotifyUri);
      return;
    }
    // Fall back to web player using track ID
    const trackId = spotifyUri.split(":").pop();
    if (trackId) {
      await Linking.openURL(`https://open.spotify.com/track/${trackId}`);
      return;
    }
  }

  // No URI — fall back to search
  const webUrl = getSpotifySearchUrl(title, artist);
  const query = encodeURIComponent(`${title} ${artist}`);
  const spotifyAppUrl = `spotify:search:${query}`;

  const canOpenApp = await Linking.canOpenURL(spotifyAppUrl);
  if (canOpenApp) {
    await Linking.openURL(spotifyAppUrl);
  } else {
    await Linking.openURL(webUrl);
  }
}

/**
 * Open a playlist search in Spotify app or browser.
 */
export async function openPlaylistInSpotify(
  playlistName: string,
): Promise<void> {
  const webUrl = getSpotifyPlaylistSearchUrl(playlistName);
  const query = encodeURIComponent(playlistName);
  const spotifyAppUrl = `spotify:search:${query}`;

  const canOpenApp = await Linking.canOpenURL(spotifyAppUrl);
  if (canOpenApp) {
    await Linking.openURL(spotifyAppUrl);
  } else {
    await Linking.openURL(webUrl);
  }
}
