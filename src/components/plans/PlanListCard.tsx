import React, { memo, useMemo } from "react";
import { View, Text, StyleSheet, Pressable } from "react-native";
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withSpring,
} from "react-native-reanimated";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  Springs,
} from "../../constants/theme";
import { useTranslation } from "react-i18next";
import { useTheme } from "../../contexts/ThemeContext";
import { CATEGORIES } from "../../constants/categories";
import { hapticLight } from "../../utils/haptics";
import { a11yButton } from "../../utils/accessibility";
import type { Plan } from "../../types/database";

interface PlanListCardProps {
  plan: Plan;
  onPress: (plan: Plan) => void;
  index: number;
}

const STATUS_COLOR_MAP = {
  planning: "secondary",
  ready: "info",
  completed: "success",
  cancelled: "textTertiary",
} as const;

function getStatusColor(
  status: Plan["status"],
  colors: Record<string, string>,
): string {
  const key = STATUS_COLOR_MAP[status] ?? "secondary";
  return colors[key] ?? colors.secondary;
}

function getCategoryInfo(plan: Plan): { icon: IconName; color: string } {
  const categorySlug = plan.scenario?.category?.slug;
  if (categorySlug) {
    const cat = CATEGORIES.find((c) => c.slug === categorySlug);
    if (cat) {
      return { icon: cat.icon as IconName, color: cat.color };
    }
  }
  return { icon: "party-popper", color: "#C2587A" };
}

function PlanListCardComponent({ plan, onPress, index }: PlanListCardProps) {
  const { colors } = useTheme();
  const { t } = useTranslation("plans");
  const styles = useMemo(() => createStyles(colors), [colors]);

  const translateX = useSharedValue(0);
  const scale = useSharedValue(1);

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ translateX: translateX.value }, { scale: scale.value }],
  }));

  const isCompleted = plan.status === "completed";
  const statusColor = getStatusColor(plan.status, colors);
  const { icon: categoryIcon, color: categoryColor } = getCategoryInfo(plan);

  const daysLeft = plan.event_date
    ? Math.ceil(
        (new Date(plan.event_date).getTime() - Date.now()) /
          (1000 * 60 * 60 * 24),
      )
    : null;

  const completedItems =
    plan.checklist?.filter((c) => c.is_completed).length ?? 0;
  const totalItems = plan.checklist?.length ?? 0;
  const progress = totalItems > 0 ? completedItems / totalItems : 0;

  const handlePressIn = () => {
    translateX.value = withSpring(4, Springs.snappy);
    scale.value = withSpring(0.98, Springs.snappy);
  };

  const handlePressOut = () => {
    translateX.value = withSpring(0, Springs.standard);
    scale.value = withSpring(1, Springs.standard);
  };

  const handlePress = () => {
    hapticLight();
    onPress(plan);
  };

  return (
    <Pressable
      onPressIn={handlePressIn}
      onPressOut={handlePressOut}
      onPress={handlePress}
      {...a11yButton(plan.title)}
    >
      <Animated.View
        style={[
          styles.container,
          isCompleted && styles.completedContainer,
          animatedStyle,
        ]}
      >
        {/* Left status stripe */}
        <View style={[styles.stripe, { backgroundColor: statusColor }]} />

        {/* Icon area */}
        <View style={styles.iconArea}>
          <View
            style={[
              styles.iconCircle,
              { backgroundColor: categoryColor + "18" },
            ]}
          >
            <Icon name={categoryIcon} size={24} color={categoryColor} />
          </View>
        </View>

        {/* Content area */}
        <View style={styles.content}>
          <Text style={styles.title} numberOfLines={1}>
            {plan.title}
          </Text>

          {plan.recipient_name ? (
            <View style={styles.recipientRow}>
              <Icon name="heart" size={12} color={colors.textSecondary} />
              <Text style={styles.recipientText} numberOfLines={1}>
                {plan.recipient_name}
              </Text>
            </View>
          ) : null}

          {totalItems > 0 ? (
            <View style={styles.progressContainer}>
              <View style={styles.progressTrack}>
                <View
                  style={[
                    styles.progressFill,
                    {
                      width: `${Math.round(progress * 100)}%`,
                      backgroundColor: colors.primary,
                    },
                  ]}
                />
              </View>
            </View>
          ) : null}
        </View>

        {/* Right area */}
        <View style={styles.rightArea}>
          {isCompleted ? (
            <View
              style={[
                styles.checkCircle,
                { backgroundColor: colors.success + "20" },
              ]}
            >
              <Icon name="check-bold" size={18} color={colors.success} />
            </View>
          ) : daysLeft !== null && daysLeft >= 0 ? (
            <View style={styles.countdownArea}>
              <Text style={[styles.countdownNumber, { color: colors.primary }]}>
                {daysLeft}
              </Text>
              <Text
                style={[styles.countdownLabel, { color: colors.textSecondary }]}
              >
                {t("countdown_labels.days")}
              </Text>
            </View>
          ) : null}
        </View>
      </Animated.View>
    </Pressable>
  );
}

export const PlanListCard = memo(PlanListCardComponent);

const createStyles = (colors: Record<string, string>) =>
  StyleSheet.create({
    container: {
      height: 120,
      borderRadius: BorderRadius.xlg,
      backgroundColor: colors.surface,
      flexDirection: "row",
      alignItems: "center",
      overflow: "hidden",
      borderWidth: 1,
      borderColor: colors.borderLight,
      ...Shadows.sm,
    },
    completedContainer: {
      opacity: 0.7,
    },
    stripe: {
      width: 4,
      height: "100%",
    },
    iconArea: {
      width: 60,
      alignItems: "center",
      justifyContent: "center",
    },
    iconCircle: {
      width: 44,
      height: 44,
      borderRadius: 22,
      alignItems: "center",
      justifyContent: "center",
    },
    content: {
      flex: 1,
      paddingVertical: Spacing.smd,
      justifyContent: "center",
      gap: Spacing.xs,
    },
    title: {
      ...Typography.h4,
      color: colors.text,
    },
    recipientRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.xs,
    },
    recipientText: {
      ...Typography.caption,
      color: colors.textSecondary,
    },
    progressContainer: {
      marginTop: 2,
      paddingRight: Spacing.sm,
    },
    progressTrack: {
      height: 3,
      borderRadius: 1.5,
      backgroundColor: colors.borderLight,
      overflow: "hidden",
    },
    progressFill: {
      height: "100%",
      borderRadius: 1.5,
    },
    rightArea: {
      width: 64,
      alignItems: "center",
      justifyContent: "center",
      paddingRight: Spacing.smd,
    },
    countdownArea: {
      alignItems: "center",
    },
    countdownNumber: {
      ...Typography.display,
      lineHeight: 36,
    },
    countdownLabel: {
      ...Typography.caption,
      marginTop: -2,
    },
    checkCircle: {
      width: 36,
      height: 36,
      borderRadius: 18,
      alignItems: "center",
      justifyContent: "center",
    },
  });
