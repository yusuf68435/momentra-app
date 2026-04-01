import React, { useEffect } from "react";
import { View, Text, StyleSheet } from "react-native";
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
  withSpring,
  withSequence,
  withDelay,
  Easing,
} from "react-native-reanimated";
import { useTranslation } from "react-i18next";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../constants/theme";
import type { Badge, BadgeDefinition } from "../../stores/gamificationStore";
import { useSettingsStore } from "../../stores/settingsStore";
import { getColors } from "../../constants/theme";

interface BadgeCardProps {
  badge: BadgeDefinition;
  earned?: Badge | null;
  animateUnlock?: boolean;
}

export default function BadgeCard({
  badge,
  earned,
  animateUnlock = false,
}: BadgeCardProps) {
  const { isDarkMode } = useSettingsStore();
  const { i18n } = useTranslation();
  const colors = getColors(isDarkMode);
  const useTurkish = i18n.language.startsWith("tr");
  const isUnlocked = !!earned;

  const scale = useSharedValue(animateUnlock && isUnlocked ? 0.5 : 1);
  const opacity = useSharedValue(animateUnlock && isUnlocked ? 0 : 1);
  const rotate = useSharedValue(0);
  const glowOpacity = useSharedValue(0);

  useEffect(() => {
    if (animateUnlock && isUnlocked) {
      scale.value = withSequence(
        withTiming(0.5, { duration: 0 }),
        withDelay(200, withSpring(1.15, { damping: 6, stiffness: 150 })),
        withSpring(1, { damping: 10 }),
      );
      opacity.value = withDelay(200, withTiming(1, { duration: 400 }));
      rotate.value = withSequence(
        withDelay(200, withTiming(-5, { duration: 100 })),
        withTiming(5, { duration: 100 }),
        withTiming(0, { duration: 100 }),
      );
      glowOpacity.value = withSequence(
        withDelay(300, withTiming(0.8, { duration: 300 })),
        withTiming(0, { duration: 600, easing: Easing.out(Easing.quad) }),
      );
    }
  }, [animateUnlock, isUnlocked]);

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ scale: scale.value }, { rotate: `${rotate.value}deg` }],
    opacity: opacity.value,
  }));

  const glowStyle = useAnimatedStyle(() => ({
    opacity: glowOpacity.value,
  }));

  const unlockedDate = earned?.unlockedAt
    ? new Date(earned.unlockedAt).toLocaleDateString(i18n.language, {
        day: "numeric",
        month: "short",
        year: "numeric",
      })
    : null;

  return (
    <Animated.View
      style={[
        styles.container,
        animatedStyle,
        {
          backgroundColor: colors.surface,
          borderColor: isUnlocked ? colors.primary : colors.border,
          ...Shadows.md,
        },
      ]}
    >
      {/* Glow effect on unlock */}
      <Animated.View
        style={[styles.glow, glowStyle, { backgroundColor: colors.primary }]}
      />

      <View
        style={[
          styles.emojiContainer,
          {
            backgroundColor: isUnlocked
              ? `${colors.primary}15`
              : colors.surfaceVariant,
          },
        ]}
      >
        <Text style={[styles.emoji, !isUnlocked && styles.emojiLocked]}>
          {badge.emoji}
        </Text>
        {!isUnlocked && (
          <View
            style={[
              styles.lockOverlay,
              { backgroundColor: `${colors.background}80` },
            ]}
          >
            <Text style={styles.lockIcon}>🔒</Text>
          </View>
        )}
      </View>

      <Text
        style={[
          styles.title,
          { color: isUnlocked ? colors.text : colors.textTertiary },
        ]}
        numberOfLines={1}
      >
        {useTurkish ? badge.title_tr : badge.title_en}
      </Text>

      <Text
        style={[
          styles.description,
          { color: isUnlocked ? colors.textSecondary : colors.textTertiary },
        ]}
        numberOfLines={2}
      >
        {useTurkish ? badge.description_tr : badge.description_en}
      </Text>

      {isUnlocked && unlockedDate && (
        <Text style={[styles.date, { color: colors.primary }]}>
          {unlockedDate}
        </Text>
      )}
    </Animated.View>
  );
}

const styles = StyleSheet.create({
  container: {
    width: "47%",
    borderRadius: BorderRadius.lg,
    borderWidth: 1.5,
    padding: Spacing.md,
    alignItems: "center",
    marginBottom: Spacing.md,
    overflow: "hidden",
  },
  glow: {
    position: "absolute",
    top: -20,
    left: -20,
    right: -20,
    bottom: -20,
    borderRadius: BorderRadius.lg + 20,
    opacity: 0,
  },
  emojiContainer: {
    width: 56,
    height: 56,
    borderRadius: 28,
    alignItems: "center",
    justifyContent: "center",
    marginBottom: Spacing.sm,
    position: "relative",
  },
  emoji: {
    fontSize: 28,
  },
  emojiLocked: {
    opacity: 0.3,
  },
  lockOverlay: {
    position: "absolute",
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    borderRadius: 28,
    alignItems: "center",
    justifyContent: "center",
  },
  lockIcon: {
    fontSize: 18,
  },
  title: {
    ...Typography.buttonSmall,
    textAlign: "center",
    marginBottom: 2,
  },
  description: {
    ...Typography.caption,
    textAlign: "center",
    lineHeight: 14,
  },
  date: {
    ...Typography.caption,
    marginTop: Spacing.xs,
    fontSize: 10,
  },
});
