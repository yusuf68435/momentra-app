import { supabase } from "./supabase";
import * as ImagePicker from "expo-image-picker";
import * as ImageManipulator from "expo-image-manipulator";
import { getCurrentUserId } from "./helpers";
import {
  STORAGE_BUCKET,
  IMAGE_QUALITY,
  IMAGE_ASPECT_RATIO,
} from "../constants/defaults";
import { sanitizeInput } from "../utils/crypto";

const MAX_PHOTO_SIZE_BYTES = 10 * 1024 * 1024; // 10 MB

export interface PlanPhoto {
  id: string;
  plan_id: string;
  uploaded_by: string;
  image_url: string;
  caption: string | null;
  created_at: string;
}

export async function fetchPhotos(planId: string): Promise<PlanPhoto[]> {
  const { data, error } = await supabase
    .from("plan_photos")
    .select("*")
    .eq("plan_id", planId)
    .order("created_at", { ascending: false });

  if (error) {
    if (__DEV__) {
      console.warn("Failed to fetch photos:", error);
    }
    return [];
  }
  return data || [];
}

export async function uploadPhoto(
  planId: string,
  uri: string,
  caption?: string,
): Promise<PlanPhoto | null> {
  try {
    const userId = await getCurrentUserId();
    if (!userId) return null;

    // Strip EXIF/GPS metadata by re-encoding through ImageManipulator
    // Re-encoding reconstructs pixel data without preserving metadata tags
    const stripped = await ImageManipulator.manipulateAsync(uri, [], {
      compress: IMAGE_QUALITY,
      format: ImageManipulator.SaveFormat.JPEG,
    });

    // Upload image to Supabase Storage
    const fileName = `${userId}/${planId}/${Date.now()}.jpg`;
    const response = await fetch(stripped.uri);
    const blob = await response.blob();

    if (blob.size > MAX_PHOTO_SIZE_BYTES) {
      if (__DEV__) {
        console.warn("Upload rejected: file exceeds 10 MB");
      }
      return null;
    }

    const { error: uploadError } = await supabase.storage
      .from(STORAGE_BUCKET)
      .upload(fileName, blob, { contentType: "image/jpeg" });

    if (uploadError) {
      if (__DEV__) {
        console.warn("Upload error:", uploadError);
      }
      return null;
    }

    // Get public URL
    const { data: urlData } = supabase.storage
      .from(STORAGE_BUCKET)
      .getPublicUrl(fileName);

    if (!urlData?.publicUrl) {
      if (__DEV__) {
        console.warn("Failed to get public URL for uploaded photo");
      }
      return null;
    }

    // Save to plan_photos table
    const { data, error } = await supabase
      .from("plan_photos")
      .insert({
        plan_id: planId,
        uploaded_by: userId,
        image_url: urlData.publicUrl,
        caption: caption ? sanitizeInput(caption, 500) : null,
      })
      .select()
      .single();

    if (error) {
      if (__DEV__) {
        console.warn("Failed to save photo record:", error);
      }
      return null;
    }
    return data;
  } catch (err) {
    if (__DEV__) {
      console.warn("uploadPhoto error:", err);
    }
    return null;
  }
}

export async function deletePhoto(id: string): Promise<void> {
  const userId = await getCurrentUserId();
  if (!userId) throw new Error("Not authenticated");

  const { error } = await supabase
    .from("plan_photos")
    .delete()
    .eq("id", id)
    .eq("uploaded_by", userId);

  if (error) throw error;
}

export async function pickImage(): Promise<string | null> {
  const result = await ImagePicker.launchImageLibraryAsync({
    mediaTypes: ["images"],
    allowsEditing: true,
    quality: IMAGE_QUALITY,
    aspect: IMAGE_ASPECT_RATIO,
  });

  if (
    !result.canceled &&
    result.assets &&
    result.assets.length > 0 &&
    result.assets[0]?.uri
  ) {
    return result.assets[0].uri;
  }
  return null;
}
