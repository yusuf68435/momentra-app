import { supabase } from './supabase';
import { getCurrentUser } from './helpers';
import { generateSecureToken, sanitizeInput } from '../utils/crypto';

// ==========================================
// TYPES
// ==========================================

export interface TimeCapsule {
  id: string;
  plan_id: string;
  user_id: string;
  title: string;
  description: string | null;
  state: CapsuleState;
  sealed_at: string | null;
  opened_at: string | null;
  open_date: string | null;
  share_token: string | null;
  memories: CapsuleMemory[];
  created_at: string;
  updated_at: string;
}

export type CapsuleState = 'collecting' | 'sealed' | 'opened';

export interface CapsuleMemory {
  id: string;
  capsule_id: string;
  user_id: string;
  type: MemoryType;
  content: string | null;
  media_url: string | null;
  storage_path: string | null;
  caption: string | null;
  sort_order: number;
  created_at: string;
}

export type MemoryType = 'photo' | 'video' | 'text' | 'voice';

// ==========================================
// CAPSULE FUNCTIONS
// ==========================================

export async function createCapsule(
  planId: string,
  capsule: {
    title: string;
    description?: string;
    open_date?: string;
  }
): Promise<TimeCapsule> {
  const user = await getCurrentUser();

  const { data, error } = await supabase
    .from('time_capsules')
    .insert({
      plan_id: planId,
      user_id: user.id,
      title: capsule.title,
      description: capsule.description || null,
      state: 'collecting' as CapsuleState,
      open_date: capsule.open_date || null,
    })
    .select('*, memories:capsule_memories(*)')
    .single();

  if (error) throw error;
  return data;
}

export async function getCapsule(planId: string): Promise<TimeCapsule | null> {
  const { data, error } = await supabase
    .from('time_capsules')
    .select('*, memories:capsule_memories(*)')
    .eq('plan_id', planId)
    .order('sort_order', { foreignTable: 'capsule_memories' })
    .maybeSingle();

  if (error) {
    if (__DEV__) {
      console.warn('Failed to fetch time capsule:', error);
    }
    return null;
  }
  return data;
}

export async function getCapsuleById(id: string): Promise<TimeCapsule | null> {
  const { data, error } = await supabase
    .from('time_capsules')
    .select('*, memories:capsule_memories(*)')
    .eq('id', id)
    .order('sort_order', { foreignTable: 'capsule_memories' })
    .maybeSingle();

  if (error) {
    if (__DEV__) {
      console.warn('Failed to fetch time capsule:', error);
    }
    return null;
  }
  return data;
}

export async function getUserCapsules(): Promise<TimeCapsule[]> {
  const user = await getCurrentUser();

  const { data, error } = await supabase
    .from('time_capsules')
    .select('*, memories:capsule_memories(*)')
    .eq('user_id', user.id)
    .order('created_at', { ascending: false });

  if (error) throw error;
  return data || [];
}

// ==========================================
// MEMORY FUNCTIONS
// ==========================================

export async function addMemory(
  capsuleId: string,
  memory: {
    type: MemoryType;
    content?: string;
    media_uri?: string;
    caption?: string;
  }
): Promise<CapsuleMemory | null> {
  try {
    const user = await getCurrentUser();

    // Check if capsule is still in collecting state
    const { data: capsule } = await supabase
      .from('time_capsules')
      .select('state')
      .eq('id', capsuleId)
      .single();

    if (capsule?.state !== 'collecting') {
      throw new Error('Cannot add memories to a sealed or opened capsule');
    }

    let mediaUrl: string | null = null;
    let storagePath: string | null = null;

    // Upload media if provided
    if (memory.media_uri && (memory.type === 'photo' || memory.type === 'video' || memory.type === 'voice')) {
      const ext = memory.type === 'photo' ? 'jpg' : memory.type === 'video' ? 'mp4' : 'm4a';
      const contentType = memory.type === 'photo' ? 'image/jpeg' : memory.type === 'video' ? 'video/mp4' : 'audio/m4a';
      const fileName = `capsules/${capsuleId}/${Date.now()}.${ext}`;

      const response = await fetch(memory.media_uri);
      const blob = await response.blob();

      const { error: uploadError } = await supabase.storage
        .from('time-capsules')
        .upload(fileName, blob, { contentType });

      if (uploadError) {
        if (__DEV__) {
          console.warn('Capsule media upload error:', uploadError);
        }
        return null;
      }

      const { data: urlData } = supabase.storage
        .from('time-capsules')
        .getPublicUrl(fileName);

      mediaUrl = urlData?.publicUrl || null;
      storagePath = fileName;
    }

    // Get max sort_order
    const { data: existing } = await supabase
      .from('capsule_memories')
      .select('sort_order')
      .eq('capsule_id', capsuleId)
      .order('sort_order', { ascending: false })
      .limit(1);

    const nextOrder = (existing?.[0]?.sort_order ?? -1) + 1;

    const { data, error } = await supabase
      .from('capsule_memories')
      .insert({
        capsule_id: capsuleId,
        user_id: user.id,
        type: memory.type,
        content: memory.content || null,
        media_url: mediaUrl,
        storage_path: storagePath,
        caption: memory.caption || null,
        sort_order: nextOrder,
      })
      .select()
      .single();

    if (error) throw error;
    return data;
  } catch (err) {
    if (__DEV__) {
      console.warn('addMemory error:', err);
    }
    return null;
  }
}

export async function removeMemory(id: string): Promise<void> {
  const user = await getCurrentUser();

  // Get the memory to delete storage file, scoped to current user
  const { data: memory } = await supabase
    .from('capsule_memories')
    .select('storage_path')
    .eq('id', id)
    .eq('user_id', user.id)
    .maybeSingle();

  if (memory?.storage_path) {
    await supabase.storage
      .from('time-capsules')
      .remove([memory.storage_path]);
  }

  const { error } = await supabase
    .from('capsule_memories')
    .delete()
    .eq('id', id)
    .eq('user_id', user.id);

  if (error) throw error;
}

// ==========================================
// CAPSULE STATE MANAGEMENT
// ==========================================

export async function sealCapsule(id: string): Promise<TimeCapsule> {
  const { data, error } = await supabase
    .from('time_capsules')
    .update({
      state: 'sealed' as CapsuleState,
      sealed_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
    })
    .eq('id', id)
    .select('*, memories:capsule_memories(*)')
    .single();

  if (error) throw error;
  return data;
}

export async function openCapsule(id: string): Promise<TimeCapsule> {
  const { data, error } = await supabase
    .from('time_capsules')
    .update({
      state: 'opened' as CapsuleState,
      opened_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
    })
    .eq('id', id)
    .select('*, memories:capsule_memories(*)')
    .single();

  if (error) throw error;
  return data;
}

export async function shareCapsule(id: string): Promise<string> {
  const token = generateShareToken();

  const { error } = await supabase
    .from('time_capsules')
    .update({
      share_token: token,
      updated_at: new Date().toISOString(),
    })
    .eq('id', id);

  if (error) throw error;

  return `momentra://capsule/${id}?token=${encodeURIComponent(token)}`;
}

export async function getCapsuleByShareToken(token: string): Promise<TimeCapsule | null> {
  const { data, error } = await supabase
    .from('time_capsules')
    .select('*, memories:capsule_memories(*)')
    .eq('share_token', token)
    .eq('state', 'opened')
    .order('sort_order', { foreignTable: 'capsule_memories' })
    .maybeSingle();

  if (error) {
    if (__DEV__) {
      console.warn('Failed to fetch shared capsule:', error);
    }
    return null;
  }
  return data;
}

// ==========================================
// HELPERS
// ==========================================

function generateShareToken(): string {
  return generateSecureToken(24);
}
