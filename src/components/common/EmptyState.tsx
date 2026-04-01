/**
 * EmptyState — visually rich empty states with floating animation,
 * decorative ring, and optional secondary action
 */

import React, { useEffect } from "react";
import { View, Text, StyleSheet } from "react-native";
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withRepeat,
  withSequence,
  withTiming,
  FadeIn,
  FadeInDown,
  Easing,
} from "react-native-reanimated";
import { Spacing, Typography, BorderRadius } from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";
import { Button } from "../ui/Button";

interface EmptyStateProps {
  emoji: string;
  title: string;
  description: string;
  actionLabel?: string;
  onAction?: () => void;
  /** Optional secondary text-only action */
  secondaryLabel?: string;
  onSecondary?: () => void;
  /** Compact variant for inline use */
  compact?: boolean;
}

export function EmptyState({
  emoji,
  title,
  description,
  actionLabel,
  onAction,
  secondaryLabel,
  onSecondary,
  compact = false,
}: EmptyStateProps) {
  const { colors } = useTheme();

  // Floating animation for the emoji
  const floatY = useSharedValue(0);
  const ringScale = useSharedValue(1);

  useEffect(() => {
    floatY.value = withRepeat(
      withSequence(
        withTiming(-6, { duration: 1400, easing: Easing.inOut(Easing.ease) }),
        withTiming(6, { duration: 1400, easing: Easing.inOut(Easing.ease) }),
      ),
      -1,
      true,
    );
    ringScale.value = withRepeat(
      withSequence(
        withTiming(1.06, { duration: 1800, easing: Easing.inOut(Easing.ease) }),
        withTiming(1, { duration: 1800, easing: Easing.inOut(Easing.ease) }),
      ),
      -1,
      true,
    );

    return () => {
      floatY.value = 0;
      ringScale.value = 1;
    };
  }, [floatY, ringScale]);

  const floatStyle = useAnimatedStyle(() => ({
    transform: [{ translateY: floatY.value }],
  }));

  const ringStyle = useAnimatedStyle(() => ({
    transform: [{ scale: ringScale.value }],
  }));

  const emojiSize = compact ? 48 : 64;
  const ringSize = emojiSize + 32;

  return (
    <View style={[styles.container, compact && styles.containerCompact]}>
      {/* Emoji with decorative ring */}
      <Animated.View
        entering={FadeIn.duration(600)}
        style={styles.emojiWrapper}
      >
        <Animated.View
          style={[
            styles.ring,
            {
              width: ringSize,
              height: ringSize,
              borderRadius: ringSize / 2,
              borderColor: colors.primary + "20",
              backgroundColor: colors.primary + "08",
            },
            ringStyle,
          ]}
        />
        <Animated.Text
          style={[styles.emoji, { fontSize: emojiSize }, floatStyle]}
        >
          {emoji}
        </Animated.Text>
      </Animated.View>

      <Animated.Text
        entering={FadeInDown.delay(150).duration(400)}
        style={[
          compact ? styles.titleCompact : styles.title,
          { color: colors.text },
        ]}
      >
        {title}
      </Animated.Text>

      <Animated.Text
        entering={FadeInDown.delay(250).duration(400)}
        style={[
          compact ? styles.descCompact : styles.description,
          { color: colors.textSecondary },
        ]}
      >
        {description}
      </Animated.Text>

      {actionLabel && onAction && (
        <Animated.View entering={FadeInDown.delay(350).duration(400)}>
          <Button
            title={actionLabel}
            onPress={onAction}
            style={styles.button}
          />
        </Animated.View>
      )}

      {secondaryLabel && onSecondary && (
        <Animated.View entering={FadeInDown.delay(450).duration(400)}>
          <Button
            title={secondaryLabel}
            onPress={onSecondary}
            variant="ghost"
            size="sm"
            style={styles.secondaryButton}
          />
        </Animated.View>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    alignItems: "center",
    justifyContent: "center",
    paddingHorizontal: Spacing.xl,
    paddingVertical: Spacing.xxl,
  },
  containerCompact: {
    paddingVertical: Spacing.lg,
  },
  emojiWrapper: {
    alignItems: "center",
    justifyContent: "center",
    marginBottom: Spacing.md,
  },
  ring: {
    position: "absolute",
    borderWidth: 2,
  },
  emoji: {
    fontSize: 64,
  },
  title: {
    ...Typography.h3,
    textAlign: "center",
    marginBottom: Spacing.sm,
  },
  titleCompact: {
    ...Typography.h4,
    textAlign: "center",
    marginBottom: Spacing.xs,
  },
  description: {
    ...Typography.body,
    textAlign: "center",
    marginBottom: Spacing.lg,
    lineHeight: 24,
  },
  descCompact: {
    ...Typography.bodySmall,
    textAlign: "center",
    marginBottom: Spacing.md,
  },
  button: {
    minWidth: 200,
  },
  secondaryButton: {
    marginTop: Spacing.sm,
  },
});
