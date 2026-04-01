import React, { useCallback } from "react";
import { View, Text, Pressable, StyleSheet } from "react-native";
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withSpring,
  FadeInUp,
} from "react-native-reanimated";
import { LinearGradient } from "expo-linear-gradient";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import { useTheme } from "../../contexts/ThemeContext";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  Springs,
  FontFamily,
} from "../../constants/theme";
import { CATEGORIES } from "../../constants/categories";
import { staggerDelay } from "../../utils/animations";
import { hapticLight } from "../../utils/haptics";
import type { Scenario } from "../../types/database";

const CARD_HEIGHTS = {
  tall: 280,
  short: 200,
} as const;

const ICON_CIRCLE_SIZE = 56;

interface ScenarioGridCardProps {
  scenario: Scenario;
  height: "tall" | "short";
  onPress: (scenario: Scenario) => void;
  index: number;
}

const AnimatedPressable = Animated.createAnimatedComponent(Pressable);

function getCategoryInfo(scenario: Scenario): { color: string; icon: string } {
  if (scenario.category) {
    return {
      color: scenario.category.color,
      icon: scenario.category.icon,
    };
  }

  const matched = CATEGORIES.find((c) => c.slug === scenario.category_id);
  if (matched) {
    return { color: matched.color, icon: matched.icon };
  }

  return { color: "#A78BFA", icon: "star" };
}

function darkenColor(hex: string, amount: number): string {
  const cleaned = hex.replace("#", "");
  const r = Math.max(0, parseInt(cleaned.substring(0, 2), 16) - amount);
  const g = Math.max(0, parseInt(cleaned.substring(2, 4), 16) - amount);
  const b = Math.max(0, parseInt(cleaned.substring(4, 6), 16) - amount);
  return `#${r.toString(16).padStart(2, "0")}${g.toString(16).padStart(2, "0")}${b.toString(16).padStart(2, "0")}`;
}

function ScenarioGridCardComponent({
  scenario,
  height,
  onPress,
  index,
}: ScenarioGridCardProps) {
  const { i18n, t } = useTranslation();
  const { colors } = useTheme();
  const scale = useSharedValue(1);

  const lang = i18n.language as "tr" | "en";
  const title = lang === "tr" ? scenario.title_tr : scenario.title_en;
  const { color: categoryColor, icon: categoryIcon } =
    getCategoryInfo(scenario);
  const cardHeight = CARD_HEIGHTS[height];

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ scale: scale.value }],
  }));

  const handlePressIn = useCallback(() => {
    scale.value = withSpring(0.97, Springs.snappy);
  }, [scale]);

  const handlePressOut = useCallback(() => {
    scale.value = withSpring(1, Springs.snappy);
  }, [scale]);

  const handlePress = useCallback(() => {
    hapticLight();
    onPress(scenario);
  }, [onPress, scenario]);

  const formatBudget = (min: number | null, max: number | null): string => {
    if (min == null && max == null) return "";
    if (min != null && max != null)
      return `₺${min.toLocaleString()} - ${max.toLocaleString()}`;
    if (min != null) return `₺${min.toLocaleString()}+`;
    return `₺${max?.toLocaleString() ?? ""}`;
  };

  const budgetText = formatBudget(scenario.min_budget, scenario.max_budget);
  const hasRating = (scenario.rating_avg ?? 0) > 0;
  const peopleText =
    scenario.max_people != null
      ? `${scenario.min_people}-${scenario.max_people}`
      : `${scenario.min_people}+`;

  return (
    <AnimatedPressable
      onPressIn={handlePressIn}
      onPressOut={handlePressOut}
      onPress={handlePress}
      entering={FadeInUp.delay(staggerDelay(index, 50, 400)).springify()}
      style={[animatedStyle, styles.container, { height: cardHeight }]}
      accessibilityRole="button"
      accessibilityLabel={title}
    >
      <LinearGradient
        colors={[categoryColor, darkenColor(categoryColor, 50)]}
        start={{ x: 0.5, y: 0 }}
        end={{ x: 0.5, y: 1 }}
        style={[styles.gradient, { height: cardHeight }]}
      >
        {/* Top-right badges */}
        <View style={styles.topRight}>
          {scenario.is_premium && (
            <View style={styles.proBadge}>
              <Icon
                name={"crown" as IconName}
                size={12}
                color={colors.textOnPrimary}
              />
              <Text style={[styles.proText, { color: colors.textOnPrimary }]}>
                PRO
              </Text>
            </View>
          )}
          {hasRating && (
            <View style={styles.ratingPill}>
              <Icon
                name={"star" as IconName}
                size={12}
                color={colors.warning}
              />
              <Text
                style={[styles.ratingText, { color: colors.textOnPrimary }]}
              >
                {(scenario.rating_avg ?? 0).toFixed(1)}
              </Text>
            </View>
          )}
        </View>

        {/* Centered category icon */}
        <View style={styles.iconArea}>
          <View style={styles.iconCircle}>
            <Icon
              name={categoryIcon as IconName}
              size={28}
              color={colors.textOnPrimary}
            />
          </View>
        </View>

        {/* Bottom frosted glass overlay */}
        <View style={styles.bottomOverlay}>
          <Text
            style={[styles.title, { color: colors.textOnPrimary }]}
            numberOfLines={2}
          >
            {title}
          </Text>
          <View style={styles.metaRow}>
            {budgetText !== "" && (
              <Text style={styles.metaText} numberOfLines={1}>
                {budgetText}
              </Text>
            )}
            <Text style={styles.metaText}>
              {scenario.prep_days} {t("common.days", { defaultValue: "gün" })}
            </Text>
            <View style={styles.metaItem}>
              <Icon
                name={"account-group" as IconName}
                size={12}
                color="rgba(255,255,255,0.7)"
              />
              <Text style={styles.metaText}>{peopleText}</Text>
            </View>
          </View>
        </View>
      </LinearGradient>
    </AnimatedPressable>
  );
}

export const ScenarioGridCard = React.memo(ScenarioGridCardComponent);

const styles = StyleSheet.create({
  container: {
    borderRadius: BorderRadius.lg,
    overflow: "hidden",
    ...Shadows.md,
  },
  gradient: {
    flex: 1,
    borderRadius: BorderRadius.lg,
    overflow: "hidden",
    position: "relative",
  },
  topRight: {
    position: "absolute",
    top: Spacing.sm,
    right: Spacing.sm,
    flexDirection: "column",
    alignItems: "flex-end",
    gap: Spacing.xs,
    zIndex: 2,
  },
  proBadge: {
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
    backgroundColor: "rgba(0,0,0,0.35)",
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.full,
    borderWidth: 0.5,
    borderColor: "rgba(255,255,255,0.2)",
  },
  proText: {
    ...Typography.label,
    fontFamily: FontFamily.bold,
    fontWeight: "700",
  },
  ratingPill: {
    flexDirection: "row",
    alignItems: "center",
    gap: 3,
    backgroundColor: "rgba(0,0,0,0.35)",
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.full,
    borderWidth: 0.5,
    borderColor: "rgba(255,255,255,0.2)",
  },
  ratingText: {
    ...Typography.label,
    fontFamily: FontFamily.semiBold,
    fontWeight: "600",
  },
  iconArea: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
  },
  iconCircle: {
    width: ICON_CIRCLE_SIZE,
    height: ICON_CIRCLE_SIZE,
    borderRadius: ICON_CIRCLE_SIZE / 2,
    backgroundColor: "rgba(255,255,255,0.2)",
    alignItems: "center",
    justifyContent: "center",
  },
  bottomOverlay: {
    backgroundColor: "rgba(0,0,0,0.35)",
    paddingHorizontal: Spacing.smd,
    paddingVertical: Spacing.sm,
    borderTopWidth: 0.5,
    borderTopColor: "rgba(255,255,255,0.1)",
  },
  title: {
    ...Typography.h4,
    marginBottom: Spacing.xs,
  },
  metaRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    flexWrap: "wrap",
  },
  metaItem: {
    flexDirection: "row",
    alignItems: "center",
    gap: 3,
  },
  metaText: {
    ...Typography.caption,
    color: "rgba(255,255,255,0.7)",
  },
});
