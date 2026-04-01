import { supabase } from "./supabase";
import type { Review } from "../types/database";
import { getCurrentUser } from "./helpers";
import { sanitizeInput, stripHtmlTags } from "../utils/crypto";

export async function fetchReviewsByScenario(
  scenarioId: string,
): Promise<Review[]> {
  const { data, error } = await supabase
    .from("reviews")
    .select("*, profile:profiles(display_name, avatar_url)")
    .eq("scenario_id", scenarioId)
    .order("created_at", { ascending: false });

  if (error) throw error;
  return data;
}

export async function createReview(review: {
  scenario_id: string;
  plan_id?: string;
  rating: number;
  comment?: string;
  photos?: string[];
}): Promise<Review> {
  const user = await getCurrentUser();

  const safeComment = review.comment
    ? stripHtmlTags(sanitizeInput(review.comment, 2000))
    : undefined;

  const { data, error } = await supabase
    .from("reviews")
    .insert({ ...review, comment: safeComment, user_id: user.id })
    .select()
    .single();

  if (error) throw error;

  // Update scenario rating avg
  await supabase.rpc("update_scenario_rating", {
    p_scenario_id: review.scenario_id,
  });

  return data;
}

export async function deleteReview(reviewId: string): Promise<void> {
  const user = await getCurrentUser();
  const { error } = await supabase
    .from("reviews")
    .delete()
    .eq("id", reviewId)
    .eq("user_id", user.id);
  if (error) throw error;
}
