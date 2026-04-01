import React, { useEffect } from "react";
import { View, Text, StyleSheet } from "react-native";
import { useTranslation } from "react-i18next";
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withRepeat,
  withSequence,
  withTiming,
  Easing,
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

export default function MilestoneDisplay() {
  const { t } = useTranslation();
  const { isDarkMode } = useSettingsStore();
  const colors = getColors(isDarkMode);
  const { stats } = useGamificationStore();

  const pulseScale = useSharedValue(1);

  useEffect(() => {
    if (stats.uniqueRecipients > 0 || stats.completedPlans > 0) {
      pulseScale.value = withRepeat(
        withSequence(
          withTiming(1.08, {
            duration: 800,
            easing: Easing.inOut(Easing.ease),
          }),
          withTiming(1, { duration: 800, easing: Easing.inOut(Easing.ease) }),
        ),
        -1,
        true,
      );
    }
  }, [stats.uniqueRecipients, stats.completedPlans]);

  const pulseStyle = useAnimatedStyle(() => ({
    transform: [{ scale: pulseScale.value }],
  }));

  const hasAnyMilestone =
    stats.uniqueRecipients > 0 || stats.completedPlans > 0;

  if (!hasAnyMilestone) {
    return (
      <View
        style={[
          styles.container,
          { backgroundColor: colors.surface, ...Shadows.sm },
        ]}
      >
        <Text style={[styles.inactiveText, { color: colors.textTertiary }]}>
          {t("milestones.first_surprise_cta")}
        </Text>
      </View>
    );
  }

  const recipientColor =
    stats.uniqueRecipients >= 10
      ? "#E91E63"
      : stats.uniqueRecipients >= 3
        ? "#FF5722"
        : "#FF9800";
  const surpriseColor =
    stats.completedPlans >= 10
      ? "#9C27B0"
      : stats.completedPlans >= 5
        ? "#673AB7"
        : "#3F51B5";

  return (
    <View
      style={[
        styles.container,
        { backgroundColor: colors.surface, ...Shadows.md },
      ]}
    >
      {/* People Made Happy */}
      <Animated.View
        style={[
          styles.metricCard,
          { backgroundColor: `${recipientColor}12` },
          pulseStyle,
        ]}
      >
        <Text style={styles.metricEmoji}>❤️</Text>
        <Text style={[styles.metricNumber, { color: recipientColor }]}>
          {stats.uniqueRecipients}
        </Text>
        <Text style={[styles.metricLabel, { color: colors.textSecondary }]}>
          {t("milestones.people_happy")}
        </Text>
        {/* Milestones */}
        <View style={styles.milestones}>
          {[3, 10].map((m) => (
            <View
              key={m}
              style={[
                styles.milestone,
                {
                  backgroundColor:
                    stats.uniqueRecipients >= m
                      ? `${recipientColor}20`
                      : colors.surfaceVariant,
                  borderColor:
                    stats.uniqueRecipients >= m
                      ? recipientColor
                      : colors.border,
                },
              ]}
            >
              <Text
                style={[
                  styles.milestoneText,
                  {
                    color:
                      stats.uniqueRecipients >= m
                        ? recipientColor
                        : colors.textTertiary,
                  },
                ]}
              >
                {m}
              </Text>
            </View>
          ))}
        </View>
      </Animated.View>

      {/* Completed Surprises */}
      <View
        style={[styles.metricCard, { backgroundColor: `${surpriseColor}12` }]}
      >
        <Text style={styles.metricEmoji}>🎉</Text>
        <Text style={[styles.metricNumber, { color: surpriseColor }]}>
          {stats.completedPlans}
        </Text>
        <Text style={[styles.metricLabel, { color: colors.textSecondary }]}>
          {t("milestones.surprises_completed")}
        </Text>
        {/* Milestones */}
        <View style={styles.milestones}>
          {[5, 10].map((m) => (
            <View
              key={m}
              style={[
                styles.milestone,
                {
                  backgroundColor:
                    stats.completedPlans >= m
                      ? `${surpriseColor}20`
                      : colors.surfaceVariant,
                  borderColor:
                    stats.completedPlans >= m ? surpriseColor : colors.border,
                },
              ]}
            >
              <Text
                style={[
                  styles.milestoneText,
                  {
                    color:
                      stats.completedPlans >= m
                        ? surpriseColor
                        : colors.textTertiary,
                  },
                ]}
              >
                {m}
              </Text>
            </View>
          ))}
        </View>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    borderRadius: BorderRadius.lg,
    padding: Spacing.md,
    flexDirection: "row",
    gap: Spacing.md,
    marginBottom: Spacing.md,
  },
  metricCard: {
    flex: 1,
    borderRadius: BorderRadius.md,
    padding: Spacing.md,
    alignItems: "center",
  },
  metricEmoji: {
    fontSize: 28,
    marginBottom: Spacing.xs,
  },
  metricNumber: {
    ...Typography.h1,
    fontSize: 32,
    lineHeight: 36,
  },
  metricLabel: {
    ...Typography.caption,
    marginTop: 2,
    textAlign: "center",
  },
  milestones: {
    flexDirection: "row",
    gap: Spacing.xs,
    marginTop: Spacing.sm,
  },
  milestone: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
  },
  milestoneText: {
    ...Typography.caption,
    fontWeight: "600",
    fontSize: 10,
  },
  inactiveText: {
    ...Typography.bodySmall,
    textAlign: "center",
    flex: 1,
    paddingVertical: Spacing.sm,
  },
});
