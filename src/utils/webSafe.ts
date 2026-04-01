/**
 * Web-safe style utilities
 *
 * Some React Native styles don't work on web (expo-web).
 * Use these helpers to apply platform-appropriate styles.
 */

import { Platform, StyleSheet } from 'react-native';

/**
 * Returns shadow styles that work on both native and web.
 * Native: uses iOS shadow props + Android elevation
 * Web: uses CSS box-shadow via boxShadow
 */
export function webSafeShadow(
  elevation = 4,
  color = '#000',
  opacity = 0.1,
): object {
  if (Platform.OS === 'web') {
    return {
      boxShadow: `0px ${elevation / 2}px ${elevation}px rgba(0,0,0,${opacity})`,
    };
  }

  return {
    shadowColor: color,
    shadowOffset: { width: 0, height: elevation / 2 },
    shadowOpacity: opacity,
    shadowRadius: elevation,
    elevation,
  };
}

/**
 * Clamps a value between min and max.
 * Useful for responsive sizing.
 */
export function clamp(value: number, min: number, max: number): number {
  return Math.min(Math.max(value, min), max);
}

/**
 * Returns true if running on web platform.
 */
export const isWeb = Platform.OS === 'web';

/**
 * Returns true if running on iOS.
 */
export const isIOS = Platform.OS === 'ios';

/**
 * Returns true if running on Android.
 */
export const isAndroid = Platform.OS === 'android';
