import React, { useEffect } from "react";
import { View, Text, StyleSheet } from "react-native";
import { useTranslation } from "react-i18next";
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
  Easing,
  interpolate,
  Extrapolation,
} from "react-native-reanimated";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../constants/theme";
import { useGamificationStore } from "../../stores/gamificationStore";
import { useSettingsStore } from "../../stores/settingsStore";
import { getColors } from "../../constants/theme";

export default function LevelProgress() {
  const { t } = useTranslation();
  const { language, isDarkMode } = useSettingsStore();
  const colors = getColors(isDarkMode);
  const lang = language as "tr" | "en";
  const { xp, level, getLevelProgress } = useGamificationStore();
  const progress = getLevelProgress();

  const barWidth = useSharedValue(0);

  useEffect(() => {
    barWidth.value = withTiming(progress.percentage, {
      duration: 800,
      easing: Easing.out(Easing.cubic),
    });
  }, [progress.percentage]);

  const animatedBarStyle = useAnimatedStyle(() => {
    const scaleX = interpolate(
      barWidth.value,
      [0, 100],
      [0, 1],
      Extrapolation.CLAMP,
    );
    return {
      transform: [{ scaleX }],
      transformOrigin: "left",
    };
  });

  const levelTitle =
    lang === "tr" ? progress.current.title_tr : progress.current.title_en;
  const nextLevelTitle = progress.next
    ? lang === "tr"
      ? progress.next.title_tr
      : progress.next.title_en
    : null;

  return (
    <View
      style={[
        styles.container,
        { backgroundColor: colors.surface, ...Shadows.md },
      ]}
    >
      {/* Level Badge */}
      <View style={styles.headerRow}>
        <View style={styles.levelBadgeRow}>
          <View
            style={[styles.levelBadge, { backgroundColor: colors.primary }]}
          >
            <Text style={[styles.levelNumber, { color: colors.textOnPrimary }]}>
              {level}
            </Text>
          </View>
          <View style={styles.levelInfo}>
            <Text style={[styles.levelTitle, { color: colors.text }]}>
              {levelTitle}
            </Text>
            <Text style={[styles.xpText, { color: colors.textSecondary }]}>
              {xp} XP
            </Text>
          </View>
        </View>
        {nextLevelTitle && (
          <Text style={[styles.nextLevel, { color: colors.textTertiary }]}>
            {t("milestones.next")}: {nextLevelTitle}
          </Text>
        )}
      </View>

      {/* Progress Bar */}
      <View
        style={[
          styles.progressTrack,
          { backgroundColor: colors.surfaceVariant },
        ]}
      >
        <Animated.View
          style={[
            styles.progressFill,
            animatedBarStyle,
            { backgroundColor: colors.primary },
          ]}
        />
      </View>

      {/* XP Range */}
      <View style={styles.xpRange}>
        <Text style={[styles.xpRangeText, { color: colors.textTertiary }]}>
          {progress.current.minXp} XP
        </Text>
        <Text style={[styles.xpRangeText, { color: colors.textTertiary }]}>
          {progress.percentage}%
        </Text>
        <Text style={[styles.xpRangeText, { color: colors.textTertiary }]}>
          {progress.next ? `${progress.next.minXp} XP` : "MAX"}
        </Text>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    borderRadius: BorderRadius.lg,
    padding: Spacing.md,
    marginBottom: Spacing.md,
  },
  headerRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.md,
  },
  levelBadgeRow: {
    flexDirection: "row",
    alignItems: "center",
  },
  levelBadge: {
    width: 40,
    height: 40,
    borderRadius: 20,
    alignItems: "center",
    justifyContent: "center",
    marginRight: Spacing.sm,
  },
  levelNumber: {
    ...Typography.h3,
    fontWeight: "700",
  },
  levelInfo: {
    justifyContent: "center",
  },
  levelTitle: {
    ...Typography.h4,
  },
  xpText: {
    ...Typography.caption,
  },
  nextLevel: {
    ...Typography.caption,
  },
  progressTrack: {
    height: 10,
    borderRadius: 5,
    overflow: "hidden",
  },
  progressFill: {
    height: "100%",
    width: "100%",
    borderRadius: 5,
  },
  xpRange: {
    flexDirection: "row",
    justifyContent: "space-between",
    marginTop: Spacing.xs,
  },
  xpRangeText: {
    ...Typography.caption,
    fontSize: 10,
  },
});
