import AsyncStorage from '@react-native-async-storage/async-storage';

const NOTIFICATION_STORE_KEY = '@notification_ids';

interface NotificationMap {
  [entityId: string]: string[];
}

/**
 * Load the full notification ID map from AsyncStorage.
 */
async function loadMap(): Promise<NotificationMap> {
  try {
    const raw = await AsyncStorage.getItem(NOTIFICATION_STORE_KEY);
    return raw ? JSON.parse(raw) : {};
  } catch {
    return {};
  }
}

/**
 * Persist the notification ID map to AsyncStorage.
 */
async function persistMap(map: NotificationMap): Promise<void> {
  await AsyncStorage.setItem(NOTIFICATION_STORE_KEY, JSON.stringify(map));
}

/**
 * Save a notification ID associated with an entity (important date or plan).
 * Appends to existing IDs for the same entity.
 */
export async function saveNotificationId(
  entityId: string,
  notificationId: string,
): Promise<void> {
  const map = await loadMap();
  const existing = map[entityId] ?? [];
  if (!existing.includes(notificationId)) {
    existing.push(notificationId);
  }
  map[entityId] = existing;
  await persistMap(map);
}

/**
 * Get all notification IDs associated with an entity.
 */
export async function getNotificationIds(
  entityId: string,
): Promise<string[]> {
  const map = await loadMap();
  return map[entityId] ?? [];
}

/**
 * Remove all stored notification IDs for an entity.
 */
export async function removeNotificationIds(
  entityId: string,
): Promise<void> {
  const map = await loadMap();
  delete map[entityId];
  await persistMap(map);
}
