import { supabase } from "./supabase";
import { getCurrentUser } from "./helpers";

// ==========================================
// TYPES
// ==========================================

export interface VoiceNote {
  id: string;
  plan_id: string;
  user_id: string;
  audio_url: string;
  storage_path: string;
  duration_seconds: number;
  transcript: string | null;
  title: string | null;
  created_at: string;
}

// ==========================================
// VOICE NOTE FUNCTIONS
// ==========================================

export async function saveVoiceNote(
  planId: string,
  uri: string,
  durationSeconds: number,
  title?: string,
): Promise<VoiceNote | null> {
  try {
    const user = await getCurrentUser();

    // Upload audio file to Supabase Storage
    const fileName = `${user.id}/${planId}/${Date.now()}.m4a`;
    const response = await fetch(uri);
    const blob = await response.blob();

    const { error: uploadError } = await supabase.storage
      .from("voice-notes")
      .upload(fileName, blob, { contentType: "audio/m4a" });

    if (uploadError) {
      if (__DEV__) {
        console.warn("Voice note upload error:", uploadError);
      }
      return null;
    }

    // Get public URL
    const { data: urlData } = supabase.storage
      .from("voice-notes")
      .getPublicUrl(fileName);

    if (!urlData?.publicUrl) {
      if (__DEV__) {
        console.warn("Failed to get public URL for voice note");
      }
      return null;
    }

    // Save to voice_notes table
    const { data, error } = await supabase
      .from("voice_notes")
      .insert({
        plan_id: planId,
        user_id: user.id,
        audio_url: urlData.publicUrl,
        storage_path: fileName,
        duration_seconds: durationSeconds,
        title: title || null,
      })
      .select()
      .single();

    if (error) {
      if (__DEV__) {
        console.warn("Failed to save voice note record:", error);
      }
      return null;
    }
    return data;
  } catch (err) {
    if (__DEV__) {
      console.warn("saveVoiceNote error:", err);
    }
    return null;
  }
}

export async function getVoiceNotes(planId: string): Promise<VoiceNote[]> {
  const { data, error } = await supabase
    .from("voice_notes")
    .select("*")
    .eq("plan_id", planId)
    .order("created_at", { ascending: false });

  if (error) {
    if (__DEV__) {
      console.warn("Failed to fetch voice notes:", error);
    }
    return [];
  }
  return data || [];
}

export async function deleteVoiceNote(id: string): Promise<void> {
  const user = await getCurrentUser();

  // Get the note first to delete the storage file
  const { data: note } = await supabase
    .from("voice_notes")
    .select("storage_path, user_id")
    .eq("id", id)
    .maybeSingle();

  if (note && note.user_id !== user.id) {
    throw new Error("Not authorized to delete this voice note");
  }

  if (note?.storage_path) {
    const { error: storageError } = await supabase.storage
      .from("voice-notes")
      .remove([note.storage_path]);

    if (storageError) {
      if (__DEV__) {
        console.warn("Failed to delete voice note file:", storageError);
      }
    }
  }

  const { error } = await supabase.from("voice_notes").delete().eq("id", id);

  if (error) throw error;
}

export async function transcribeNote(id: string): Promise<string | null> {
  try {
    const { data, error } = await supabase.functions.invoke(
      "transcribe-voice-note",
      {
        body: { voice_note_id: id },
      },
    );

    if (error) {
      if (__DEV__) {
        console.warn("Transcription edge function error:", error);
      }
      return null;
    }

    const transcript = data?.transcript || null;

    if (transcript) {
      // Save transcript to the voice_notes record
      await supabase.from("voice_notes").update({ transcript }).eq("id", id);
    }

    return transcript;
  } catch (err) {
    if (__DEV__) {
      console.warn("transcribeNote error:", err);
    }
    return null;
  }
}

export async function updateVoiceNoteTitle(
  id: string,
  title: string,
): Promise<VoiceNote> {
  const { data, error } = await supabase
    .from("voice_notes")
    .update({ title })
    .eq("id", id)
    .select()
    .single();

  if (error) throw error;
  return data;
}

// ==========================================
// HELPERS
// ==========================================

export function formatDuration(seconds: number): string {
  const mins = Math.floor(seconds / 60);
  const secs = seconds % 60;
  return `${mins}:${secs.toString().padStart(2, "0")}`;
}
