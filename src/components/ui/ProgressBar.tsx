import React, { useEffect } from "react";
import { View, StyleSheet } from "react-native";
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
} from "react-native-reanimated";
import { useTheme } from "../../contexts/ThemeContext";

const DEFAULT_HEIGHT = 4;
const ANIMATION_DURATION_MS = 300;

interface ProgressBarProps {
  progress: number;
  color?: string;
  trackColor?: string;
  height?: number;
  animated?: boolean;
}

export function ProgressBar({
  progress,
  color,
  trackColor,
  height = DEFAULT_HEIGHT,
  animated = false,
}: ProgressBarProps) {
  const { colors } = useTheme();
  const clampedProgress = Math.min(Math.max(progress, 0), 1);
  const animatedWidth = useSharedValue(clampedProgress * 100);

  useEffect(() => {
    if (animated) {
      animatedWidth.value = withTiming(clampedProgress * 100, {
        duration: ANIMATION_DURATION_MS,
      });
    } else {
      animatedWidth.value = clampedProgress * 100;
    }
  }, [clampedProgress, animated, animatedWidth]);

  const animatedStyle = useAnimatedStyle(() => ({
    width: `${animatedWidth.value}%`,
  }));

  const borderRadius = height / 2;
  const fillColor = color ?? colors.primary;
  const track = trackColor ?? colors.surfaceVariant;

  return (
    <View
      style={[styles.track, { backgroundColor: track, borderRadius, height }]}
    >
      <Animated.View
        style={[
          styles.fill,
          animatedStyle,
          { backgroundColor: fillColor, borderRadius },
        ]}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  track: {
    overflow: "hidden",
    width: "100%",
  },
  fill: {
    height: "100%",
  },
});
