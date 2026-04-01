import React, { createContext, useCallback, useContext, useMemo } from 'react';
import { useColorScheme } from 'react-native';
import { useSettingsStore, type ThemeMode } from '../stores/settingsStore';
import {
  getColors,
  getGlassmorphism,
  type ThemeColors,
  DarkElevation,
  Gradients,
  Springs,
} from '../constants/theme';

export type { ThemeMode };

interface GlassmorphismConfig {
  backgroundColor: string;
  borderColor: string;
  blurAmount: number;
  blurType: 'light' | 'dark';
}

interface ThemeContextValue {
  colors: ThemeColors;
  isDark: boolean;
  themeMode: ThemeMode;
  toggleDarkMode: () => void;
  setThemeMode: (mode: ThemeMode) => void;
  glass: GlassmorphismConfig;
  elevation: typeof DarkElevation;
  gradients: typeof Gradients;
  springs: typeof Springs;
}

const ThemeContext = createContext<ThemeContextValue | undefined>(undefined);

interface ThemeProviderProps {
  children: React.ReactNode;
}

export function AppThemeProvider({ children }: ThemeProviderProps) {
  const systemScheme = useColorScheme();
  const { isDarkMode, themeMode, setDarkMode, setThemeMode: storeSetThemeMode } = useSettingsStore();

  // Resolve the effective dark mode value based on themeMode
  const isDark = themeMode === 'system' ? systemScheme === 'dark' : isDarkMode;

  const colors = useMemo(() => getColors(isDark), [isDark]);
  const glass = useMemo(() => getGlassmorphism(isDark), [isDark]);

  const toggleDarkMode = useCallback(() => {
    const newIsDark = !isDark;
    setDarkMode(newIsDark);
    storeSetThemeMode(newIsDark ? 'dark' : 'light');
  }, [isDark, setDarkMode, storeSetThemeMode]);

  const setThemeMode = useCallback((mode: ThemeMode) => {
    storeSetThemeMode(mode);
    switch (mode) {
      case 'system':
        setDarkMode(systemScheme === 'dark');
        break;
      case 'dark':
        setDarkMode(true);
        break;
      case 'light':
        setDarkMode(false);
        break;
    }
  }, [systemScheme, setDarkMode, storeSetThemeMode]);

  const value = useMemo<ThemeContextValue>(
    () => ({
      colors,
      isDark,
      themeMode,
      toggleDarkMode,
      setThemeMode,
      glass,
      elevation: DarkElevation,
      gradients: Gradients,
      springs: Springs,
    }),
    [colors, isDark, themeMode, toggleDarkMode, setThemeMode, glass]
  );

  return (
    <ThemeContext.Provider value={value}>
      {children}
    </ThemeContext.Provider>
  );
}

/**
 * Hook to access theme colors and dark mode controls.
 * Returns { colors, isDark, toggleDarkMode, themeMode, setThemeMode }
 */
export function useTheme(): ThemeContextValue {
  const context = useContext(ThemeContext);
  if (!context) {
    throw new Error('useTheme must be used within an AppThemeProvider');
  }
  return context;
}
