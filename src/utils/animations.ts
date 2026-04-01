/**
 * Momentra Animation System
 * Centralized animation presets, entrance animations, and surprise reveal sequences
 * Uses react-native-reanimated v4
 */

import {
  withSpring,
  withTiming,
  withSequence,
  withDelay,
  withRepeat,
  Easing,
  type SharedValue,
  type WithSpringConfig,
  type WithTimingConfig,
} from "react-native-reanimated";
import { Springs } from "../constants/theme";

// ─────────────────────────────────────────────
// SPRING PRESETS (re-exported from theme for convenience)
// ─────────────────────────────────────────────

export const SpringPresets = {
  /** Standard — buttons, cards (damping: 15, stiffness: 150) */
  standard: Springs.standard,
  /** Bouncy — celebration moments, reveals (damping: 10, stiffness: 180) */
  bouncy: Springs.bouncy,
  /** Gentle — page transitions, modals (damping: 20, stiffness: 120) */
  gentle: Springs.gentle,
  /** Snappy — toggles, quick feedback (damping: 18, stiffness: 250) */
  snappy: Springs.snappy,
  /** Sheet — bottom sheet open/close */
  sheet: { damping: 28, stiffness: 300, mass: 0.8 },
  /** FAB — floating action button press/release */
  fab: { damping: 12, stiffness: 200, mass: 0.6 },
  /** Reveal — surprise content reveal */
  reveal: { damping: 14, stiffness: 100, mass: 1.2 },
} as const;

// ─────────────────────────────────────────────
// TIMING PRESETS
// ─────────────────────────────────────────────

export const TimingPresets = {
  /** Fast fade — 150ms, quick micro-interactions */
  fast: { duration: 150, easing: Easing.out(Easing.ease) } as WithTimingConfig,
  /** Normal — 250ms, standard transitions */
  normal: {
    duration: 250,
    easing: Easing.out(Easing.ease),
  } as WithTimingConfig,
  /** Slow — 400ms, page transitions, reveals */
  slow: {
    duration: 400,
    easing: Easing.bezier(0.4, 0, 0.2, 1),
  } as WithTimingConfig,
  /** Emphasis — 600ms, celebration, dramatic moments */
  emphasis: {
    duration: 600,
    easing: Easing.bezier(0.34, 1.56, 0.64, 1),
  } as WithTimingConfig,
} as const;

// ─────────────────────────────────────────────
// ENTRANCE ANIMATION FACTORIES
// ─────────────────────────────────────────────

/** Stagger delay calculator for list items */
export function staggerDelay(
  index: number,
  baseDelay = 50,
  maxDelay = 400,
): number {
  return Math.min(index * baseDelay, maxDelay);
}

// ─────────────────────────────────────────────
// PRESS ANIMATION HELPERS
// ─────────────────────────────────────────────

/** Scale down on press, spring back on release */
export function pressIn(scale: SharedValue<number>, toValue = 0.96) {
  "worklet";
  scale.value = withSpring(toValue, SpringPresets.snappy);
}

export function pressOut(scale: SharedValue<number>) {
  "worklet";
  scale.value = withSpring(1, SpringPresets.standard);
}

// ─────────────────────────────────────────────
// SURPRISE REVEAL SEQUENCE
// ─────────────────────────────────────────────

/**
 * Surprise reveal sequence for gift/surprise cards
 * Phase 1: Gentle shake (anticipation)
 * Phase 2: Scale up with bounce (reveal)
 * Phase 3: Settle to final state
 */
export function surpriseRevealScale(scale: SharedValue<number>) {
  "worklet";
  scale.value = withSequence(
    // Phase 1: Quick squeeze (anticipation)
    withTiming(0.92, { duration: 150 }),
    // Phase 2: Overshoot reveal
    withSpring(1.08, { damping: 8, stiffness: 200 }),
    // Phase 3: Settle
    withSpring(1, SpringPresets.standard),
  );
}

export function surpriseRevealRotation(rotation: SharedValue<number>) {
  "worklet";
  rotation.value = withSequence(
    withTiming(-3, { duration: 60 }),
    withTiming(3, { duration: 60 }),
    withTiming(-2, { duration: 50 }),
    withTiming(2, { duration: 50 }),
    withTiming(0, { duration: 80 }),
  );
}

export function surpriseRevealOpacity(opacity: SharedValue<number>) {
  "worklet";
  opacity.value = withSequence(
    withTiming(0, { duration: 0 }),
    withDelay(200, withTiming(1, { duration: 300 })),
  );
}

// ─────────────────────────────────────────────
// FLOATING ANIMATION (for hero elements)
// ─────────────────────────────────────────────

export function startFloat(translateY: SharedValue<number>, amplitude = 8) {
  "worklet";
  translateY.value = withRepeat(
    withSequence(
      withTiming(-amplitude, {
        duration: 1500,
        easing: Easing.inOut(Easing.ease),
      }),
      withTiming(amplitude, {
        duration: 1500,
        easing: Easing.inOut(Easing.ease),
      }),
    ),
    -1,
    true,
  );
}

// ─────────────────────────────────────────────
// PULSE ANIMATION (for notifications, badges)
// ─────────────────────────────────────────────

export function startPulse(scale: SharedValue<number>, intensity = 1.15) {
  "worklet";
  scale.value = withRepeat(
    withSequence(
      withTiming(intensity, {
        duration: 600,
        easing: Easing.inOut(Easing.ease),
      }),
      withTiming(1, { duration: 600, easing: Easing.inOut(Easing.ease) }),
    ),
    -1,
    true,
  );
}

// ─────────────────────────────────────────────
// SHEET ANIMATION HELPERS
// ─────────────────────────────────────────────

export function sheetOpen(translateY: SharedValue<number>, targetY: number) {
  "worklet";
  translateY.value = withSpring(targetY, SpringPresets.sheet);
}

export function sheetClose(
  translateY: SharedValue<number>,
  screenHeight: number,
) {
  "worklet";
  translateY.value = withSpring(screenHeight, SpringPresets.sheet);
}

// ─────────────────────────────────────────────
// REDUCED MOTION WRAPPER
// ─────────────────────────────────────────────

/**
 * Returns immediate value if reduced motion is enabled,
 * otherwise returns the animated value
 */
export function maybeAnimate(
  reducedMotion: boolean,
  animatedValue: number,
  immediateValue: number,
): number {
  return reducedMotion ? immediateValue : animatedValue;
}

// ─────────────────────────────────────────────
// SHIMMER ANIMATION (for gradient sweep effects)
// ─────────────────────────────────────────────

export function startShimmer(translateX: SharedValue<number>, duration = 1500) {
  "worklet";
  translateX.value = withRepeat(
    withTiming(1, { duration, easing: Easing.inOut(Easing.ease) }),
    -1,
    false,
  );
}

// ─────────────────────────────────────────────
// BREATHING ANIMATION (for idle elements like FABs)
// ─────────────────────────────────────────────

export function startBreathing(
  scale: SharedValue<number>,
  intensity = 1.03,
  duration = 3000,
) {
  "worklet";
  scale.value = withRepeat(
    withSequence(
      withTiming(intensity, {
        duration: duration / 2,
        easing: Easing.inOut(Easing.ease),
      }),
      withTiming(1, {
        duration: duration / 2,
        easing: Easing.inOut(Easing.ease),
      }),
    ),
    -1,
    true,
  );
}
