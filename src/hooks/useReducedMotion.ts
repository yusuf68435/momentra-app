import { useState, useEffect } from 'react';
import { AccessibilityInfo } from 'react-native';

/**
 * Hook that checks if the user has enabled "Reduce Motion" in their device settings.
 * Returns true if reduced motion is preferred.
 * Useful for disabling animations when the user has accessibility needs.
 */
export function useReducedMotion(): boolean {
  const [reduceMotionEnabled, setReduceMotionEnabled] = useState(false);

  useEffect(() => {
    // Check initial value
    AccessibilityInfo.isReduceMotionEnabled()
      .then(setReduceMotionEnabled)
      .catch(() => { /* Not available on this platform */ });

    // Listen for changes
    const subscription = AccessibilityInfo.addEventListener(
      'reduceMotionChanged',
      setReduceMotionEnabled,
    );

    return () => {
      subscription.remove();
    };
  }, []);

  return reduceMotionEnabled;
}
