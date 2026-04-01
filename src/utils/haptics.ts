import * as Haptics from 'expo-haptics';
import { Platform } from 'react-native';

// Only run haptics on iOS (Android support is limited)
const isHapticSupported = Platform.OS === 'ios';

/** Light tap - for selections, toggles, tab switches */
export function hapticLight() {
  if (isHapticSupported) {
    Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
  }
}

/** Medium tap - for button presses, card selections */
export function hapticMedium() {
  if (isHapticSupported) {
    Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
  }
}

/** Heavy tap - for important actions, confirmations */
export function hapticHeavy() {
  if (isHapticSupported) {
    Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Heavy);
  }
}

/** Selection changed - for picker/scroll selections */
export function hapticSelection() {
  if (isHapticSupported) {
    Haptics.selectionAsync();
  }
}

/** Success notification - for completed actions */
export function hapticSuccess() {
  if (isHapticSupported) {
    Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);
  }
}

/** Warning notification */
export function hapticWarning() {
  if (isHapticSupported) {
    Haptics.notificationAsync(Haptics.NotificationFeedbackType.Warning);
  }
}

/** Error notification - for failed actions */
export function hapticError() {
  if (isHapticSupported) {
    Haptics.notificationAsync(Haptics.NotificationFeedbackType.Error);
  }
}
