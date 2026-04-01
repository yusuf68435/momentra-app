import { AccessibilityInfo, Platform, ViewStyle } from "react-native";
import { TouchTargets } from "../constants/theme";

// Re-export for convenience
export { useReducedMotion } from "../hooks/useReducedMotion";

// ─────────────────────────────────────────────
// ROLE-BASED ACCESSIBILITY PROPS
// ─────────────────────────────────────────────

export function a11yButton(label: string, hint?: string) {
  return {
    accessible: true,
    accessibilityRole: "button" as const,
    accessibilityLabel: label,
    ...(hint ? { accessibilityHint: hint } : {}),
  };
}

export function a11yLink(label: string) {
  return {
    accessible: true,
    accessibilityRole: "link" as const,
    accessibilityLabel: label,
  };
}

export function a11yHeader(label: string, level: 1 | 2 | 3 = 1) {
  return {
    accessible: true,
    accessibilityRole: "header" as const,
    accessibilityLabel: label,
    // Android TalkBack reads heading level via accessibilityValue text
    ...(Platform.OS === "android"
      ? { accessibilityValue: { text: `heading level ${level}` } }
      : {}),
  };
}

export function a11yDisabled(label: string, hint?: string) {
  return {
    accessible: true,
    accessibilityRole: "button" as const,
    accessibilityLabel: label,
    accessibilityState: { disabled: true },
    ...(hint ? { accessibilityHint: hint } : {}),
  };
}

export function a11yExpanded(label: string, expanded: boolean) {
  return {
    accessible: true,
    accessibilityRole: "button" as const,
    accessibilityLabel: label,
    accessibilityState: { expanded },
  };
}

export function a11ySelected(label: string, selected: boolean) {
  return {
    accessible: true,
    accessibilityLabel: label,
    accessibilityState: { selected },
  };
}

export function a11yImage(label: string) {
  return {
    accessible: true,
    accessibilityRole: "image" as const,
    accessibilityLabel: label,
  };
}

export function a11yCheckbox(label: string, checked: boolean) {
  return {
    accessible: true,
    accessibilityRole: "checkbox" as const,
    accessibilityLabel: label,
    accessibilityState: { checked },
  };
}

export function a11ySwitch(label: string, value: boolean) {
  return {
    accessible: true,
    accessibilityRole: "switch" as const,
    accessibilityLabel: label,
    accessibilityState: { checked: value },
  };
}

export function a11yProgressBar(
  label: string,
  value: number,
  max: number = 100,
) {
  return {
    accessible: true,
    accessibilityRole: "progressbar" as const,
    accessibilityLabel: label,
    accessibilityValue: {
      min: 0,
      max,
      now: value,
      text: `${Math.round((value / max) * 100)}%`,
    },
  };
}

export function a11yTab(label: string, selected: boolean) {
  return {
    accessible: true,
    accessibilityRole: "tab" as const,
    accessibilityLabel: label,
    accessibilityState: { selected },
  };
}

export function a11yAlert(label: string) {
  return {
    accessible: true,
    accessibilityRole: "alert" as const,
    accessibilityLabel: label,
    accessibilityLiveRegion: "assertive" as const,
  };
}

export function a11yLiveRegion(
  label: string,
  priority: "polite" | "assertive" = "polite",
) {
  return {
    accessible: true,
    accessibilityLabel: label,
    accessibilityLiveRegion: priority,
  };
}

// ─────────────────────────────────────────────
// TOUCH TARGET ENFORCEMENT
// ─────────────────────────────────────────────

/**
 * Returns minimum hit slop to ensure 48dp touch target
 * even when the visual element is smaller.
 */
export function ensureTouchTarget(
  visualWidth: number,
  visualHeight: number,
): { hitSlop: { top: number; bottom: number; left: number; right: number } } {
  const minSize = TouchTargets.minimum;
  const horizontalSlop = Math.max(0, (minSize - visualWidth) / 2);
  const verticalSlop = Math.max(0, (minSize - visualHeight) / 2);
  return {
    hitSlop: {
      top: verticalSlop,
      bottom: verticalSlop,
      left: horizontalSlop,
      right: horizontalSlop,
    },
  };
}

// ─────────────────────────────────────────────
// SCREEN READER UTILITIES
// ─────────────────────────────────────────────

export async function isScreenReaderEnabled(): Promise<boolean> {
  return AccessibilityInfo.isScreenReaderEnabled();
}

export function announceForAccessibility(message: string) {
  AccessibilityInfo.announceForAccessibility(message);
}

/**
 * Post an accessibility announcement after a delay (e.g. after animation completes)
 */
export function announceDelayed(message: string, delayMs = 500) {
  setTimeout(() => {
    AccessibilityInfo.announceForAccessibility(message);
  }, delayMs);
}

// ─────────────────────────────────────────────
// FOCUS MANAGEMENT
// ─────────────────────────────────────────────

/**
 * Set accessibility focus on a ref after a delay
 * Useful after navigation or content changes
 */
export function setAccessibilityFocus(
  ref: React.RefObject<any>,
  delayMs = 300,
) {
  if (ref.current) {
    setTimeout(() => {
      AccessibilityInfo.setAccessibilityFocus(ref.current);
    }, delayMs);
  }
}

// ─────────────────────────────────────────────
// TESTING HELPERS
// ─────────────────────────────────────────────

export function testID(id: string) {
  return { testID: id, accessibilityLabel: id };
}
