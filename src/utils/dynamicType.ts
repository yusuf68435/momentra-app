import { Platform, PixelRatio } from 'react-native';

/**
 * Maximum font size multiplier for Dynamic Type.
 * Prevents text from becoming too large on screens.
 * Apple recommends supporting up to ~1.5x for most UI.
 */
export const MAX_FONT_SIZE_MULTIPLIER = 1.4;

/**
 * Get text props that support Dynamic Type with a max scale.
 * Apply these to all Text components.
 */
export function dynamicTypeProps(maxMultiplier: number = MAX_FONT_SIZE_MULTIPLIER) {
  return {
    maxFontSizeMultiplier: maxMultiplier,
    allowFontScaling: true,
  };
}

/**
 * For input fields - slightly lower max to prevent layout issues.
 */
export function dynamicTypeInputProps() {
  return {
    maxFontSizeMultiplier: 1.2,
    allowFontScaling: true,
  };
}

/**
 * For header text - allow slightly larger scaling.
 */
export function dynamicTypeHeaderProps() {
  return {
    maxFontSizeMultiplier: 1.5,
    allowFontScaling: true,
  };
}

/**
 * For compact UI elements like badges/chips - limit scaling more.
 */
export function dynamicTypeCompactProps() {
  return {
    maxFontSizeMultiplier: 1.1,
    allowFontScaling: true,
  };
}

/**
 * Get the current font scale factor.
 */
export function getFontScale(): number {
  return PixelRatio.getFontScale();
}

/**
 * Check if the user has increased their font size.
 */
export function isLargerTextEnabled(): boolean {
  return PixelRatio.getFontScale() > 1.0;
}
