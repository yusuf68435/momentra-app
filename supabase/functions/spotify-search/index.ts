import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { corsHeaders, requireAuth } from "../_shared/security.ts";

const SPOTIFY_CLIENT_ID = Deno.env.get("SPOTIFY_CLIENT_ID");
const SPOTIFY_CLIENT_SECRET = Deno.env.get("SPOTIFY_CLIENT_SECRET");

// In-memory token cache (lives for the lifetime of the edge function instance)
let cachedToken: string | null = null;
let tokenExpiry = 0;

async function getSpotifyToken(): Promise<string | null> {
  if (!SPOTIFY_CLIENT_ID || !SPOTIFY_CLIENT_SECRET) return null;

  const now = Date.now();
  if (cachedToken && now < tokenExpiry) return cachedToken;

  const credentials = btoa(`${SPOTIFY_CLIENT_ID}:${SPOTIFY_CLIENT_SECRET}`);
  const resp = await fetch("https://accounts.spotify.com/api/token", {
    method: "POST",
    headers: {
      Authorization: `Basic ${credentials}`,
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: "grant_type=client_credentials",
  });

  if (!resp.ok) return null;

  const json = await resp.json();
  cachedToken = json.access_token;
  // Expire 60 seconds early to avoid edge cases
  tokenExpiry = now + (json.expires_in - 60) * 1000;
  return cachedToken;
}

interface SpotifyTrackResult {
  spotifyId: string;
  spotifyUri: string;
  previewUrl: string | null;
  imageUrl: string | null;
  album: string | null;
  durationMs: number;
}

async function searchTrack(
  token: string,
  title: string,
  artist: string
): Promise<SpotifyTrackResult | null> {
  // Use field filters for more precise matching
  const q = encodeURIComponent(`track:${title} artist:${artist}`);
  const resp = await fetch(
    `https://api.spotify.com/v1/search?q=${q}&type=track&limit=1`,
    { headers: { Authorization: `Bearer ${token}` } }
  );

  if (!resp.ok) return null;

  const json = await resp.json();
  const track = json.tracks?.items?.[0];
  if (!track) return null;

  // Prefer 300x300 image, fall back to largest available
  const images: { url: string; width: number }[] = track.album?.images ?? [];
  const image =
    images.find((img) => img.width === 300) ??
    images.find((img) => img.width === 640) ??
    images[0];

  return {
    spotifyId: track.id,
    spotifyUri: track.uri,
    previewUrl: track.preview_url ?? null,
    imageUrl: image?.url ?? null,
    album: track.album?.name ?? null,
    durationMs: track.duration_ms,
  };
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const user = await requireAuth(req);
    if (user instanceof Response) return user;

    const body = await req.json();
    const queries: { title: string; artist: string }[] = body?.queries;

    if (!Array.isArray(queries) || queries.length === 0) {
      return new Response(
        JSON.stringify({ error: "queries must be a non-empty array" }),
        { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    const token = await getSpotifyToken();

    // If Spotify credentials are not configured, return nulls gracefully
    if (!token) {
      return new Response(
        JSON.stringify({ results: queries.map(() => null), configured: false }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Limit to 20 tracks per request to avoid long-running functions
    const results = await Promise.all(
      queries.slice(0, 20).map(({ title, artist }) =>
        searchTrack(token, title, artist).catch(() => null)
      )
    );

    return new Response(
      JSON.stringify({ results, configured: true }),
      { headers: { ...corsHeaders, "Content-Type": "application/json" } }
    );
  } catch {
    return new Response(
      JSON.stringify({ error: "Internal error" }),
      { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
    );
  }
});
