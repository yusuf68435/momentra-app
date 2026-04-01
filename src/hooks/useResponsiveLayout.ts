/**
 * useResponsiveLayout
 *
 * Provides breakpoint-based layout helpers for tablet/iPad support.
 * Uses useWindowDimensions so it reacts to orientation changes.
 *
 * Breakpoints:
 *   phone:  < 768px wide
 *   tablet: >= 768px wide
 *   desktop: >= 1024px wide (web only)
 *
 * Usage:
 *   const { isTablet, numColumns, contentWidth } = useResponsiveLayout();
 */

import { useWindowDimensions } from 'react-native';

const TABLET_BREAKPOINT = 768;
const DESKTOP_BREAKPOINT = 1024;

/** Max content width on tablets/desktop (centered layout) */
const MAX_CONTENT_WIDTH = 680;

export interface ResponsiveLayout {
  width: number;
  height: number;
  isPhone: boolean;
  isTablet: boolean;
  isDesktop: boolean;
  /** Number of columns for grid layouts */
  numColumns: number;
  /** Padded content width (respects max width on tablets) */
  contentWidth: number;
  /** Horizontal padding for page-level containers */
  horizontalPadding: number;
}

export function useResponsiveLayout(): ResponsiveLayout {
  const { width, height } = useWindowDimensions();

  const isPhone = width < TABLET_BREAKPOINT;
  const isTablet = width >= TABLET_BREAKPOINT && width < DESKTOP_BREAKPOINT;
  const isDesktop = width >= DESKTOP_BREAKPOINT;

  const numColumns = isDesktop ? 3 : isTablet ? 2 : 1;

  // On tablet/desktop, center content with max width
  const contentWidth = isPhone
    ? width
    : Math.min(width, MAX_CONTENT_WIDTH);

  const horizontalPadding = isPhone
    ? 16
    : isTablet
    ? Math.max(24, (width - MAX_CONTENT_WIDTH) / 2)
    : Math.max(32, (width - MAX_CONTENT_WIDTH) / 2);

  return {
    width,
    height,
    isPhone,
    isTablet,
    isDesktop,
    numColumns,
    contentWidth,
    horizontalPadding,
  };
}
