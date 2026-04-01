import { supabase } from './supabase';
import { getCurrentUserId } from './helpers';

export async function fetchFavorites(): Promise<string[]> {
  const userId = await getCurrentUserId();
  if (!userId) return [];

  const { data, error } = await supabase
    .from('favorites')
    .select('scenario_id')
    .eq('user_id', userId);

  if (error) {
    if (__DEV__) {
      console.warn('Failed to fetch favorites:', error);
    }
    return [];
  }
  return data.map(f => f.scenario_id);
}

export async function toggleFavorite(scenarioId: string): Promise<boolean> {
  const userId = await getCurrentUserId();
  if (!userId) return false;

  // Check if already favorited
  const { data: existing } = await supabase
    .from('favorites')
    .select('id')
    .eq('user_id', userId)
    .eq('scenario_id', scenarioId)
    .maybeSingle();

  if (existing) {
    // Remove
    await supabase.from('favorites').delete().eq('id', existing.id);
    return false;
  } else {
    // Add
    await supabase.from('favorites').insert({ user_id: userId, scenario_id: scenarioId });
    return true;
  }
}

export async function isFavorited(scenarioId: string): Promise<boolean> {
  const userId = await getCurrentUserId();
  if (!userId) return false;

  const { data } = await supabase
    .from('favorites')
    .select('id')
    .eq('user_id', userId)
    .eq('scenario_id', scenarioId)
    .maybeSingle();

  return !!data;
}
