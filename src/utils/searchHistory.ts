import AsyncStorage from '@react-native-async-storage/async-storage';

const SEARCH_HISTORY_KEY = 'momentra-search-history';
const MAX_HISTORY = 10;

export async function getSearchHistory(): Promise<string[]> {
  try {
    const raw = await AsyncStorage.getItem(SEARCH_HISTORY_KEY);
    if (!raw) return [];
    const parsed = JSON.parse(raw);
    return Array.isArray(parsed) ? parsed : [];
  } catch {
    return [];
  }
}

export async function addToSearchHistory(query: string): Promise<void> {
  const trimmed = query.trim();
  if (!trimmed) return;

  try {
    const history = await getSearchHistory();
    // Remove duplicate if exists, then prepend
    const filtered = history.filter(
      (item) => item.toLowerCase() !== trimmed.toLowerCase()
    );
    const updated = [trimmed, ...filtered].slice(0, MAX_HISTORY);
    await AsyncStorage.setItem(SEARCH_HISTORY_KEY, JSON.stringify(updated));
  } catch {
    // Silently fail – search history is non-critical
  }
}

export async function clearSearchHistory(): Promise<void> {
  try {
    await AsyncStorage.removeItem(SEARCH_HISTORY_KEY);
  } catch {
    // Silently fail
  }
}
