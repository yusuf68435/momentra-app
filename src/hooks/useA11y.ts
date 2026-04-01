/**
 * useA11y – Accessibility helpers
 *
 * Provides common accessibility props for interactive elements.
 * Complements the existing `a11yButton` and `a11yTab` helpers in utils/accessibility.ts
 *
 * Usage:
 *   const { a11yProps, announce } = useA11y();
 *   <TouchableOpacity {...a11yProps('Delete plan', 'button')}>
 */

import { useCallback } from 'react';
import { AccessibilityInfo, Platform } from 'react-native';

type AccessibilityRole =
  | 'none'
  | 'button'
  | 'link'
  | 'search'
  | 'image'
  | 'keyboardkey'
  | 'text'
  | 'adjustable'
  | 'imagebutton'
  | 'header'
  | 'summary'
  | 'alert'
  | 'checkbox'
  | 'combobox'
  | 'menu'
  | 'menubar'
  | 'menuitem'
  | 'progressbar'
  | 'radio'
  | 'radiogroup'
  | 'scrollbar'
  | 'spinbutton'
  | 'switch'
  | 'tab'
  | 'tablist'
  | 'timer'
  | 'toolbar';

export interface A11yProps {
  accessible: boolean;
  accessibilityLabel: string;
  accessibilityRole: AccessibilityRole;
  accessibilityHint?: string;
}

export function useA11y() {
  /**
   * Generate accessibility props for an interactive element.
   */
  const a11yProps = useCallback(
    (
      label: string,
      role: AccessibilityRole = 'button',
      hint?: string,
    ): A11yProps => ({
      accessible: true,
      accessibilityLabel: label,
      accessibilityRole: role,
      ...(hint ? { accessibilityHint: hint } : {}),
    }),
    [],
  );

  /**
   * Announce a message to screen readers (VoiceOver / TalkBack).
   */
  const announce = useCallback((message: string): void => {
    AccessibilityInfo.announceForAccessibility(message);
  }, []);

  /**
   * Check if a screen reader is currently active.
   * Returns a promise that resolves to a boolean.
   */
  const isScreenReaderEnabled = useCallback((): Promise<boolean> => {
    return AccessibilityInfo.isScreenReaderEnabled();
  }, []);

  return { a11yProps, announce, isScreenReaderEnabled };
}
