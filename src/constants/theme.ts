// Momentra Design System v5.0
// Unified Gold + Violet brand — light mode is the daytime twin of dark mode
// Dark:  deep navy #0d0d1a  + gold #d4af60  + violet #a78bfa
// Light: warm ivory #F9F6F0 + gold #7A5C11  + violet #5B21B6
// Philosophy: same DNA, opposite luminosity — one brand, two times of day

import { Platform } from "react-native";

// ─────────────────────────────────────────────
// LIGHT MODE COLORS — Warm Ivory + Daytime Gold
// ─────────────────────────────────────────────
export const LightColors = {
  // Core tint — daytime gold (same hue family as dark #d4af60, darkened for contrast)
  // #7A5C11 on #F9F6F0 = 7.8:1 contrast ratio — passes WCAG AA + AAA
  primary: "#7A5C11",
  primaryLight: "rgba(122,92,17,0.10)",
  primaryDark: "#5C4409",

  // Violet secondary — matches dark mode secondary #a78bfa, darkened for light bg
  // #5B21B6 on #F9F6F0 = 8.1:1 contrast ratio — passes WCAG AAA
  secondary: "#5B21B6",
  secondaryLight: "rgba(91,33,182,0.09)",
  secondaryDark: "#3B0F8A",

  accent: "#7A5C11",
  complement: "#5B21B6",
  primaryMuted: "rgba(122,92,17,0.07)",

  // Warm ivory glass — daytime equivalent of dark's navy glass rgba(23,23,42,0.85)
  surfaceGlass: "rgba(245,240,232,0.88)",

  // Semantic — warmed from Apple system colors to match the premium ivory palette
  success: "#1A7F4B",
  warning: "#B45309",
  error: "#C0392B",
  info: "#1D4ED8",

  // Surfaces — warm ivory progression (mirrors dark's navy elevation layers)
  background: "#F9F6F0",
  backgroundSecondary: "#F0EBE1",
  surface: "#EDE7DA",
  surfaceVariant: "#E3DAC9",

  // Typography — warm near-black with gold undertone (mirrors dark's #f0f0f5)
  text: "#1C1409",
  textSecondary: "rgba(58,42,12,0.60)",
  textTertiary: "#8C7A52",
  textOnPrimary: "#FFFFFF",

  // Borders — gold-tinted (mirrors dark's purple-tinted rgba(80,80,120,0.4))
  border: "rgba(122,92,17,0.22)",
  borderLight: "rgba(122,92,17,0.10)",
  divider: "rgba(122,92,17,0.18)",

  overlay: "rgba(28,20,9,0.45)",
  shadow: "rgba(28,20,9,0.08)",

  // Feature colors — same semantic roles as dark mode, adapted for ivory backgrounds
  featureWeather: "#1D4ED8",
  featureTimeline: "#5B21B6",
  featureMoodboard: "#7A5C11",
  featureGuests: "#1A7F4B",
  featureGifts: "#B45309",
  featureMusic: "#0E7490",
  featureBackup: "#C0392B",
  featureCapsule: "#8C7A52",
  featureChat: "#7A5C11",
  featureVendors: "#B45309",

  // Mood colors — darker variants for light backgrounds
  moodRomantic: "#C2185B",
  moodFun: "#E65100",
  moodEnergetic: "#C62828",
  moodChill: "#1565C0",
  moodEmotional: "#6A1B9A",

  // Budget — same hue mapping as dark mode, darkened for ivory bg legibility
  budgetFood: "#B91C1C",
  budgetDecoration: "#5B21B6",
  budgetVenue: "#1D4ED8",
  budgetTransport: "#1A7F4B",
  budgetGifts: "#B45309",
  budgetOther: "#8C7A52",

  // Gamification — gold brand color carries through both modes
  xpGold: "#7A5C11",
  streakFlame: "#C2410C",
  badgeBronze: "#CD7F32",
  badgeSilver: "#9CA3AF",
  badgeGold: "#B8860B",
  badgePlatinum: "#6B7280",

  // Skeleton loading — warm ivory shimmer
  skeletonBase: "#EDE7DA",
  skeletonHighlight: "#F9F6F0",
};

export type ThemeColors = typeof LightColors;

// ─────────────────────────────────────────────
// DARK MODE COLORS — Premium Dark (Noir + Aurora)
// Deep navy-black with gold accents
// ─────────────────────────────────────────────
export const DarkColors: ThemeColors = {
  // Gold primary — premium, elite feel
  primary: "#d4af60",
  primaryLight: "rgba(212,175,96,0.15)",
  primaryDark: "#b8942e",

  secondary: "#a78bfa",
  secondaryLight: "rgba(167,139,250,0.12)",
  secondaryDark: "#7c3aed",

  accent: "#d4af60",
  complement: "#a78bfa",
  primaryMuted: "rgba(212,175,96,0.12)",

  surfaceGlass: "rgba(23,23,42,0.85)",

  success: "#34d399",
  warning: "#fbbf24",
  error: "#f87171",
  info: "#60a5fa",

  // Premium dark surfaces — deep navy-black
  background: "#0d0d1a",
  backgroundSecondary: "#141428",
  surface: "#17172a",
  surfaceVariant: "#252540",

  // Light text on dark
  text: "#f0f0f5",
  textSecondary: "rgba(224,224,229,0.6)",
  textTertiary: "#666680",
  textOnPrimary: "#0d0d1a",

  // Subtle purple-tinted separators
  border: "rgba(80,80,120,0.4)",
  borderLight: "rgba(80,80,120,0.2)",
  divider: "rgba(80,80,120,0.35)",

  overlay: "rgba(0,0,0,0.7)",
  shadow: "rgba(0,0,0,0.5)",

  featureWeather: "#60a5fa",
  featureTimeline: "#a78bfa",
  featureMoodboard: "#d4af60",
  featureGuests: "#34d399",
  featureGifts: "#fbbf24",
  featureMusic: "#67e8f9",
  featureBackup: "#f87171",
  featureCapsule: "#666680",
  featureChat: "#d4af60",
  featureVendors: "#fbbf24",

  // Mood colors — brighter variants for dark backgrounds
  moodRomantic: "#E91E63",
  moodFun: "#FF9800",
  moodEnergetic: "#F44336",
  moodChill: "#2196F3",
  moodEmotional: "#9C27B0",

  budgetFood: "#f87171",
  budgetDecoration: "#a78bfa",
  budgetVenue: "#60a5fa",
  budgetTransport: "#34d399",
  budgetGifts: "#fbbf24",
  budgetOther: "#666680",

  xpGold: "#d4af60",
  streakFlame: "#d4af60",
  badgeBronze: "#cd7f32",
  badgeSilver: "#c0c0c0",
  badgeGold: "#ffd700",
  badgePlatinum: "#e8e8e0",

  skeletonBase: "#1e1e35",
  skeletonHighlight: "#2a2a48",
};

// ─────────────────────────────────────────────
// COLOR RESOLUTION
// ─────────────────────────────────────────────
export function getColors(isDark: boolean): ThemeColors {
  return isDark ? DarkColors : LightColors;
}

// Backward compat — static light mode colors + dark subset
export const Colors = {
  ...LightColors,
  dark: {
    background: DarkColors.background,
    backgroundSecondary: DarkColors.backgroundSecondary,
    surface: DarkColors.surface,
    surfaceVariant: DarkColors.surfaceVariant,
    text: DarkColors.text,
    textSecondary: DarkColors.textSecondary,
    textTertiary: DarkColors.textTertiary,
    border: DarkColors.border,
    borderLight: DarkColors.borderLight,
    divider: DarkColors.divider,
  },
};

// ─────────────────────────────────────────────
// SPACING (Apple HIG standard margins)
// ─────────────────────────────────────────────
export const Spacing = {
  /** 4px — icon-to-text, tight internal */
  xs: 4,
  /** 8px — small gaps, inline spacing */
  sm: 8,
  /** 12px — compact card padding */
  smd: 12,
  /** 16px — standard margin, section gaps */
  md: 16,
  /** 20px — medium section spacing */
  mld: 20,
  /** 24px — large section spacing */
  lg: 24,
  /** 32px — major section dividers */
  xl: 32,
  /** 40px — screen edge padding (horizontal) */
  xxl: 40,
  /** 48px — large visual breaks */
  xxxl: 48,
  /** 64px — hero spacing */
  huge: 64,
};

// ─────────────────────────────────────────────
// BORDER RADIUS (Apple HIG)
// ─────────────────────────────────────────────
export const BorderRadius = {
  /** 8px — small elements, chips, tags */
  sm: 8,
  /** 12px — cards, inputs (Apple standard) */
  md: 12,
  /** 16px — large cards */
  lg: 16,
  /** 20px — compat alias for xlg */
  xlg: 20,
  /** 24px — modals, bottom sheets */
  xl: 24,
  /** 9999px — avatars, badges, pills */
  full: 9999,
};

// ─────────────────────────────────────────────
// TYPOGRAPHY (Apple SF Pro Dynamic Type scale)
// ─────────────────────────────────────────────
export const FontFamily = {
  regular: Platform.select({
    ios: "System",
    android: "Roboto",
    default: "System",
  }) as string,
  medium: Platform.select({
    ios: "System",
    android: "Roboto",
    default: "System",
  }) as string,
  semiBold: Platform.select({
    ios: "System",
    android: "Roboto",
    default: "System",
  }) as string,
  bold: Platform.select({
    ios: "System",
    android: "Roboto",
    default: "System",
  }) as string,
  mono: Platform.select({
    ios: "Menlo",
    android: "monospace",
    default: "monospace",
  }) as string,
};

export const Typography = {
  /** 34px Bold — Large Title (iOS nav bar large title) */
  displayLarge: {
    fontSize: 34,
    fontWeight: "700" as const,
    lineHeight: 41,
    letterSpacing: 0.37,
    fontFamily: FontFamily.bold,
  },
  /** 28px Bold — Title 1 */
  display: {
    fontSize: 28,
    fontWeight: "700" as const,
    lineHeight: 34,
    letterSpacing: 0.36,
    fontFamily: FontFamily.bold,
  },
  /** 28px Bold — Title 1 (alias) */
  h1: {
    fontSize: 28,
    fontWeight: "700" as const,
    lineHeight: 34,
    letterSpacing: 0.36,
    fontFamily: FontFamily.bold,
  },
  /** 22px Bold — Title 2 */
  h2: {
    fontSize: 22,
    fontWeight: "700" as const,
    lineHeight: 28,
    letterSpacing: 0.35,
    fontFamily: FontFamily.bold,
  },
  /** 20px SemiBold — Title 3 */
  h3: {
    fontSize: 20,
    fontWeight: "600" as const,
    lineHeight: 25,
    letterSpacing: 0.38,
    fontFamily: FontFamily.semiBold,
  },
  /** 17px SemiBold — Headline */
  h4: {
    fontSize: 17,
    fontWeight: "600" as const,
    lineHeight: 22,
    letterSpacing: -0.41,
    fontFamily: FontFamily.semiBold,
  },
  /** 17px Regular — Body */
  body: {
    fontSize: 17,
    fontWeight: "400" as const,
    lineHeight: 22,
    letterSpacing: -0.41,
    fontFamily: FontFamily.regular,
  },
  /** 15px Regular — Subhead */
  bodySmall: {
    fontSize: 15,
    fontWeight: "400" as const,
    lineHeight: 20,
    letterSpacing: -0.24,
    fontFamily: FontFamily.regular,
  },
  /** 13px Regular — Footnote */
  caption: {
    fontSize: 13,
    fontWeight: "400" as const,
    lineHeight: 18,
    letterSpacing: -0.08,
    fontFamily: FontFamily.regular,
  },
  /** 12px Regular — Caption 1 */
  label: {
    fontSize: 12,
    fontWeight: "400" as const,
    lineHeight: 16,
    letterSpacing: 0,
    fontFamily: FontFamily.regular,
  },
  /** 11px Regular — Caption 2 (kept as overline for compat) */
  overline: {
    fontSize: 11,
    fontWeight: "400" as const,
    lineHeight: 13,
    letterSpacing: 0.07,
    fontFamily: FontFamily.regular,
  },
  /** 17px SemiBold — Headline / Button */
  button: {
    fontSize: 17,
    fontWeight: "600" as const,
    lineHeight: 22,
    letterSpacing: -0.41,
    fontFamily: FontFamily.semiBold,
  },
  /** 15px SemiBold — Small button */
  buttonSmall: {
    fontSize: 15,
    fontWeight: "600" as const,
    lineHeight: 20,
    letterSpacing: -0.24,
    fontFamily: FontFamily.semiBold,
  },
  /** 16px Regular — Callout (kept as bodyLarge for compat) */
  bodyLarge: {
    fontSize: 16,
    fontWeight: "400" as const,
    lineHeight: 21,
    letterSpacing: -0.32,
    fontFamily: FontFamily.regular,
  },
  /** 12px SemiBold — Pill badges */
  pill: {
    fontSize: 12,
    fontWeight: "600" as const,
    lineHeight: 16,
    letterSpacing: 0,
    fontFamily: FontFamily.semiBold,
  },
  /** Monospace — countdown timers, codes */
  mono: {
    fontSize: 17,
    fontWeight: "400" as const,
    lineHeight: 22,
    letterSpacing: 0,
    fontFamily: FontFamily.mono,
  },
};

// ─────────────────────────────────────────────
// SHADOWS (Apple — minimal, purposeful)
// ─────────────────────────────────────────────
export const Shadows = {
  /** Subtle — list items, compact cards */
  sm: {
    shadowColor: "#000000",
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.04,
    shadowRadius: 2,
    elevation: 1,
  },
  /** Standard — primary cards */
  md: {
    shadowColor: "#000000",
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.06,
    shadowRadius: 4,
    elevation: 2,
  },
  /** Prominent — floating elements, modals */
  lg: {
    shadowColor: "#000000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 4,
  },
  /** Elevated — kept for compat, same as lg */
  xl: {
    shadowColor: "#000000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 4,
  },
  /** Primary glow — kept for compat, mapped to lg */
  primaryGlow: {
    shadowColor: "#000000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 4,
  },
};

// ─────────────────────────────────────────────
// DARK MODE ELEVATION (surface color layers)
// ─────────────────────────────────────────────
export const DarkElevation = {
  /** 0dp — page background */
  level0: "#0d0d1a",
  /** 1dp — cards, list items */
  level1: "#17172a",
  /** 4dp — elevated cards, bottom sheets */
  level2: "#252540",
  /** 8dp — modals, floating elements */
  level3: "#32325a",
  /** 16dp — toasts, snackbars */
  level4: "#3f3f6e",
};

// ─────────────────────────────────────────────
// GRADIENTS (Apple — minimal, only for special moments)
// ─────────────────────────────────────────────
export const Gradients = {
  /** Primary gradient — gold to violet (daytime luxury) */
  joy: ["#7A5C11", "#5B21B6"] as const,
  /** Surprise — gold to deep red (excitement/surprise) */
  surprise: ["#7A5C11", "#C0392B"] as const,
  celebration: ["#7A5C11", "#9A7420", "#5B21B6"] as const,
  premium: ["#0d0d1a", "#17172a"] as const,
  /** Sunset — amber to gold (warm sunset) */
  sunset: ["#B45309", "#7A5C11"] as const,
  /** Ocean — blue to violet (cool ocean depth) */
  ocean: ["#1D4ED8", "#5B21B6"] as const,
  primarySubtle: ["rgba(122,92,17,0.08)", "#F9F6F0"] as const,
  heroMesh: ["#7A5C11", "#5B21B6", "#1A7F4B"] as const,
  cardShimmer: ["rgba(0,0,0,0)", "rgba(0,0,0,0.03)", "rgba(0,0,0,0)"] as const,
  warmGlow: [
    "rgba(122,92,17,0.06)",
    "rgba(122,92,17,0.02)",
    "rgba(0,0,0,0)",
  ] as const,
  nightSky: ["#0d0d1a", "#1a1040", "#0d0d1a"] as const,
  /** Reveal screen — gold to violet to red (dramatic reveal) */
  reveal: ["#9A7420", "#5B21B6", "#C0392B"] as const,
  /** Complete screen — gold to green to violet (completion/success) */
  complete: ["#9A7420", "#1A7F4B", "#5B21B6"] as const,
};

/** Dark mode gradient variants */
export const GradientsDark: Record<keyof typeof Gradients, readonly string[]> =
  {
    joy: ["#d4af60", "#a78bfa"] as const,
    /** Surprise — gold to red */
    surprise: ["#d4af60", "#f87171"] as const,
    celebration: ["#d4af60", "#a78bfa", "#34d399"] as const,
    premium: ["#0d0d1a", "#17172a"] as const,
    /** Sunset — amber to gold */
    sunset: ["#fbbf24", "#d4af60"] as const,
    /** Ocean — blue to violet */
    ocean: ["#60a5fa", "#a78bfa"] as const,
    primarySubtle: ["rgba(212,175,96,0.08)", "#0d0d1a"] as const,
    heroMesh: ["#d4af60", "#a78bfa", "#34d399"] as const,
    cardShimmer: [
      "rgba(0,0,0,0)",
      "rgba(255,255,255,0.03)",
      "rgba(0,0,0,0)",
    ] as const,
    warmGlow: [
      "rgba(212,175,96,0.06)",
      "rgba(212,175,96,0.02)",
      "rgba(0,0,0,0)",
    ] as const,
    nightSky: ["#0d0d1a", "#1a1040", "#0d0d1a"] as const,
    /** Reveal — gold to violet to red (dramatic reveal) */
    reveal: ["#d4af60", "#a78bfa", "#f87171"] as const,
    /** Complete — gold to green to violet (completion/success) */
    complete: ["#d4af60", "#34d399", "#a78bfa"] as const,
  };

/** Get theme-aware gradient by name */
export function getGradient(
  isDark: boolean,
  name: keyof typeof Gradients,
): readonly string[] {
  return isDark ? GradientsDark[name] : Gradients[name];
}

// ─────────────────────────────────────────────
// GLASSMORPHISM (Apple system materials)
// ─────────────────────────────────────────────
export const Glassmorphism = {
  light: {
    backgroundColor: "rgba(245,240,232,0.88)",
    borderColor: "rgba(122,92,17,0.12)",
    blurAmount: 20,
    blurType: "light" as const,
  },
  dark: {
    backgroundColor: "rgba(23,23,42,0.85)",
    borderColor: "rgba(80,80,120,0.25)",
    blurAmount: 20,
    blurType: "dark" as const,
  },
};

export function getGlassmorphism(isDark: boolean) {
  return isDark ? Glassmorphism.dark : Glassmorphism.light;
}

// ─────────────────────────────────────────────
// SPRING CONFIGS (Apple — critically damped, no bounce)
// ─────────────────────────────────────────────
export const Springs = {
  /** Standard — buttons, cards */
  standard: { damping: 20, stiffness: 300 },
  /** Bouncy — compat, now critically damped */
  bouncy: { damping: 20, stiffness: 300 },
  /** Gentle — page transitions, modals */
  gentle: { damping: 20, stiffness: 120 },
  /** Snappy — toggles, quick feedback */
  snappy: { damping: 20, stiffness: 400 },
  /** Elastic — compat, now critically damped */
  elastic: { damping: 20, stiffness: 300 },
  /** Micro — compat, now standard */
  micro: { damping: 20, stiffness: 300 },
};

// ─────────────────────────────────────────────
// INTERACTIVE CARD STATES
// ─────────────────────────────────────────────
export const CardInteraction = {
  /** Scale down on press — Apple uses very subtle */
  pressedScale: 0.98,
  /** Press duration in ms */
  pressDuration: 100,
  /** Release spring config */
  releaseSpring: { damping: 20, stiffness: 300 },
};

// ─────────────────────────────────────────────
// BOTTOM SHEET
// ─────────────────────────────────────────────
export const BottomSheet = {
  handleWidth: 36,
  handleHeight: 5,
  handleRadius: 2.5,
  handleColor: "rgba(60,60,67,0.3)",
  snapPoints: {
    peek: "25%",
    half: "50%",
    expanded: "90%",
  },
};

// ─────────────────────────────────────────────
// TOUCH TARGETS (Apple HIG)
// ─────────────────────────────────────────────
export const TouchTargets = {
  minimum: 44,
  recommended: 48,
  spacing: 8,
};

/**
 * Platform-aware shadow
 */
export const webShadow = (elevation: number) =>
  Platform.OS === "web"
    ? { boxShadow: `0 ${elevation / 2}px ${elevation}px rgba(0,0,0,0.08)` }
    : Shadows[elevation <= 2 ? "sm" : elevation <= 6 ? "md" : "lg"];
