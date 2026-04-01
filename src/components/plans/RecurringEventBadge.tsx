import React, { useEffect, useRef } from "react";
import { View, Text, Animated, StyleSheet } from "react-native";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import {
  type ThemeColors,
  Spacing,
  Typography,
  BorderRadius,
} from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";

interface RecurringEventBadgeProps {
  isRecurring: boolean;
  frequency: "yearly" | "monthly";
  nextDate?: string;
}

export function RecurringEventBadge({
  isRecurring,
  frequency,
  nextDate,
}: RecurringEventBadgeProps) {
  const { colors } = useTheme();
  const { t, i18n } = useTranslation();
  const styles = createStyles(colors);
  const lang = i18n.language as "tr" | "en";
  const pulseAnim = useRef(new Animated.Value(1)).current;

  useEffect(() => {
    if (!isRecurring) return;

    const animation = Animated.loop(
      Animated.sequence([
        Animated.timing(pulseAnim, {
          toValue: 1.08,
          duration: 1200,
          useNativeDriver: true,
        }),
        Animated.timing(pulseAnim, {
          toValue: 1,
          duration: 1200,
          useNativeDriver: true,
        }),
      ]),
    );
    animation.start();
    return () => animation.stop();
  }, [isRecurring, pulseAnim]);

  if (!isRecurring) return null;

  const frequencyLabel =
    frequency === "yearly" ? t("recurring.yearly") : t("recurring.monthly");

  const formatNextDate = (dateStr: string): string => {
    const date = new Date(dateStr);
    return date.toLocaleDateString(lang === "tr" ? "tr-TR" : "en-US", {
      month: "long",
      day: "numeric",
    });
  };

  return (
    <Animated.View
      style={[styles.badge, { transform: [{ scale: pulseAnim }] }]}
    >
      <Icon
        name={frequency === "yearly" ? "calendar-refresh" : "calendar-sync"}
        size={14}
        color={colors.accent}
      />
      <Text style={styles.frequencyLabel}>{frequencyLabel}</Text>
      {nextDate && (
        <>
          <View style={styles.dot} />
          <Text style={styles.nextDateText}>
            {t("recurring.next", { date: formatNextDate(nextDate) })}
          </Text>
        </>
      )}
    </Animated.View>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    badge: {
      flexDirection: "row",
      alignItems: "center",
      alignSelf: "flex-start",
      backgroundColor: colors.accent + "15",
      paddingHorizontal: Spacing.sm,
      paddingVertical: Spacing.xs,
      borderRadius: BorderRadius.full,
      gap: 4,
    },
    frequencyLabel: {
      ...Typography.caption,
      fontWeight: "600",
      color: colors.accent,
    },
    dot: {
      width: 3,
      height: 3,
      borderRadius: 1.5,
      backgroundColor: colors.accent,
    },
    nextDateText: {
      ...Typography.caption,
      color: colors.accent,
    },
  });
