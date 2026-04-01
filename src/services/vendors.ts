import { supabase } from "./supabase";
import { getCurrentUser } from "./helpers";
import {
  sanitizeQueryParam,
  sanitizeInput,
  stripHtmlTags,
} from "../utils/crypto";

// ==========================================
// TYPES
// ==========================================

export interface Vendor {
  id: string;
  name: string;
  type: VendorType;
  description: string | null;
  address: string | null;
  city: string | null;
  latitude: number | null;
  longitude: number | null;
  phone: string | null;
  email: string | null;
  website: string | null;
  image_url: string | null;
  photos: string[];
  price_range: PriceRange;
  average_rating: number;
  review_count: number;
  is_featured: boolean;
  is_verified: boolean;
  opening_hours: Record<string, string> | null;
  tags: string[];
  created_at: string;
}

export type VendorType =
  | "florist"
  | "restaurant"
  | "photographer"
  | "decorator"
  | "baker"
  | "musician"
  | "venue"
  | "caterer"
  | "event_planner"
  | "other";

export type PriceRange = "$" | "$$" | "$$$" | "$$$$";

export interface VendorReview {
  id: string;
  vendor_id: string;
  user_id: string;
  rating: number;
  review: string | null;
  author_name: string | null;
  created_at: string;
}

export interface VendorFavorite {
  id: string;
  vendor_id: string;
  user_id: string;
  created_at: string;
}

// ==========================================
// SEARCH & BROWSE
// ==========================================

export async function searchVendors(
  query?: string,
  type?: VendorType,
  city?: string,
  page: number = 1,
  pageSize: number = 20,
): Promise<Vendor[]> {
  const from = (page - 1) * pageSize;
  const to = from + pageSize - 1;

  let dbQuery = supabase
    .from("vendors")
    .select("*")
    .order("is_featured", { ascending: false })
    .order("average_rating", { ascending: false })
    .range(from, to);

  if (query) {
    const safeQuery = sanitizeQueryParam(query);
    dbQuery = dbQuery.or(
      `name.ilike.%${safeQuery}%,description.ilike.%${safeQuery}%`,
    );
  }

  if (type) {
    dbQuery = dbQuery.eq("type", type);
  }

  if (city) {
    const safeCity = sanitizeQueryParam(city);
    dbQuery = dbQuery.ilike("city", `%${safeCity}%`);
  }

  const { data, error } = await dbQuery;

  if (error) throw error;
  return data || [];
}

export async function getVendorDetails(id: string): Promise<Vendor | null> {
  const { data, error } = await supabase
    .from("vendors")
    .select("*")
    .eq("id", id)
    .maybeSingle();

  if (error) {
    if (__DEV__) {
      console.warn("Failed to fetch vendor details:", error);
    }
    return null;
  }
  return data;
}

export async function getVendorsByType(type: VendorType): Promise<Vendor[]> {
  const { data, error } = await supabase
    .from("vendors")
    .select("*")
    .eq("type", type)
    .order("average_rating", { ascending: false });

  if (error) throw error;
  return data || [];
}

export async function getFeaturedVendors(
  limit: number = 10,
): Promise<Vendor[]> {
  const { data, error } = await supabase
    .from("vendors")
    .select("*")
    .eq("is_featured", true)
    .order("average_rating", { ascending: false })
    .limit(limit);

  if (error) throw error;
  return data || [];
}

// ==========================================
// REVIEWS
// ==========================================

export async function getVendorReviews(
  vendorId: string,
): Promise<VendorReview[]> {
  const { data, error } = await supabase
    .from("vendor_reviews")
    .select("*")
    .eq("vendor_id", vendorId)
    .order("created_at", { ascending: false });

  if (error) throw error;
  return data || [];
}

export async function rateVendor(
  vendorId: string,
  rating: number,
  review?: string,
): Promise<VendorReview> {
  const user = await getCurrentUser();

  // Get user profile for author name
  const { data: profile } = await supabase
    .from("profiles")
    .select("display_name")
    .eq("id", user.id)
    .maybeSingle();

  const safeReview = review ? stripHtmlTags(sanitizeInput(review, 1000)) : null;

  // Check if user already reviewed this vendor
  const { data: existing } = await supabase
    .from("vendor_reviews")
    .select("id")
    .eq("vendor_id", vendorId)
    .eq("user_id", user.id)
    .maybeSingle();

  if (existing) {
    // Update existing review
    const { data, error } = await supabase
      .from("vendor_reviews")
      .update({
        rating,
        review: safeReview,
      })
      .eq("id", existing.id)
      .select()
      .single();

    if (error) throw error;
    await updateVendorRating(vendorId);
    return data;
  }

  // Create new review
  const { data, error } = await supabase
    .from("vendor_reviews")
    .insert({
      vendor_id: vendorId,
      user_id: user.id,
      rating,
      review: safeReview,
      author_name: profile?.display_name || null,
    })
    .select()
    .single();

  if (error) throw error;
  await updateVendorRating(vendorId);
  return data;
}

// ==========================================
// FAVORITES
// ==========================================

export async function saveVendorToFavorites(vendorId: string): Promise<void> {
  const user = await getCurrentUser();

  const { error } = await supabase
    .from("vendor_favorites")
    .insert({ vendor_id: vendorId, user_id: user.id });

  if (error) {
    // Ignore unique constraint violation (already favorited)
    if (error.code === "23505") return;
    throw error;
  }
}

export async function removeVendorFromFavorites(
  vendorId: string,
): Promise<void> {
  const user = await getCurrentUser();

  const { error } = await supabase
    .from("vendor_favorites")
    .delete()
    .eq("vendor_id", vendorId)
    .eq("user_id", user.id);

  if (error) throw error;
}

export async function getFavoriteVendors(): Promise<Vendor[]> {
  const user = await getCurrentUser();

  const { data, error } = await supabase
    .from("vendor_favorites")
    .select("vendor:vendors(*)")
    .eq("user_id", user.id)
    .order("created_at", { ascending: false });

  if (error) throw error;
  return (data || [])
    .map((item) => (item as Record<string, unknown>).vendor as Vendor)
    .filter(Boolean);
}

// ==========================================
// HELPERS
// ==========================================

async function updateVendorRating(vendorId: string): Promise<void> {
  try {
    const { data: reviews } = await supabase
      .from("vendor_reviews")
      .select("rating")
      .eq("vendor_id", vendorId);

    if (!reviews || reviews.length === 0) return;

    const avgRating =
      reviews.reduce((sum, r) => sum + r.rating, 0) / reviews.length;

    await supabase
      .from("vendors")
      .update({
        average_rating: Math.round(avgRating * 10) / 10,
        review_count: reviews.length,
      })
      .eq("id", vendorId);
  } catch (err) {
    if (__DEV__) {
      console.warn("Failed to update vendor rating:", err);
    }
  }
}
