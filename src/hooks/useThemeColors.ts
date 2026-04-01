import { useMemo } from 'react';
import { useSettingsStore } from '../stores/settingsStore';
import { getColors, type ThemeColors } from '../constants/theme';

/**
 * Hook that reads isDarkMode from settingsStore and returns
 * the correct color set (light or dark).
 */
export function useThemeColors(): ThemeColors {
  const isDarkMode = useSettingsStore((state) => state.isDarkMode);
  const colors = useMemo(() => getColors(isDarkMode), [isDarkMode]);
  return colors;
}
