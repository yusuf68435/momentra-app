import React, { useEffect } from "react";
import { View, StyleSheet } from "react-native";
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withRepeat,
  withSequence,
  withTiming,
  withDelay,
} from "react-native-reanimated";
import { useTheme } from "../../contexts/ThemeContext";

interface TypingIndicatorProps {
  color?: string;
}

const DOT_SIZE = 8;
const DOT_GAP = 6;
const BOUNCE_HEIGHT = -6;
const ANIMATION_DURATION = 300;
const COMPONENT_HEIGHT = 30;

function Dot({ delay, color }: { delay: number; color: string }) {
  const translateY = useSharedValue(0);

  useEffect(() => {
    translateY.value = withDelay(
      delay,
      withRepeat(
        withSequence(
          withTiming(BOUNCE_HEIGHT, { duration: ANIMATION_DURATION }),
          withTiming(0, { duration: ANIMATION_DURATION }),
        ),
        -1,
      ),
    );
  }, [delay, translateY]);

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ translateY: translateY.value }],
  }));

  return (
    <Animated.View
      style={[styles.dot, { backgroundColor: color }, animatedStyle]}
    />
  );
}

export function TypingIndicator({ color }: TypingIndicatorProps) {
  const { colors } = useTheme();
  const dotColor = color ?? colors.primary;

  return (
    <View style={styles.container}>
      <Dot delay={0} color={dotColor} />
      <Dot delay={200} color={dotColor} />
      <Dot delay={400} color={dotColor} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    height: COMPONENT_HEIGHT,
    gap: DOT_GAP,
  },
  dot: {
    width: DOT_SIZE,
    height: DOT_SIZE,
    borderRadius: DOT_SIZE / 2,
  },
});
