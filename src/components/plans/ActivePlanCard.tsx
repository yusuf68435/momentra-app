import React, { useMemo } from "react";
import { View, Text, TouchableOpacity, StyleSheet } from "react-native";
import { useTranslation } from "react-i18next";
import { useTheme } from "../../contexts/ThemeContext";
import { Icon } from "../ui/Icon";
import {
  type ThemeColors,
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../constants/theme";
import type { Plan } from "../../types/database";

interface Props {
  plan: Plan;
  lang: "tr" | "en";
  onPress: () => void;
}

export function ActivePlanCard({ plan, lang: _lang, onPress }: Props) {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const styles = useMemo(() => createStyles(colors), [colors]);

  const daysRemaining = useMemo(() => {
    if (!plan.event_date) return null;
    return Math.ceil(
      (new Date(plan.event_date).getTime() - Date.now()) / 86400000,
    );
  }, [plan.event_date]);

  const completedItems = useMemo(
    () => plan.checklist?.filter((item) => item.is_completed).length ?? 0,
    [plan.checklist],
  );
  const totalItems = plan.checklist?.length ?? 0;
  const progressRatio = totalItems > 0 ? completedItems / totalItems : 0;

  return (
    <TouchableOpacity
      style={styles.card}
      onPress={onPress}
      activeOpacity={0.85}
      accessibilityRole="button"
      accessibilityLabel={plan.title}
    >
      {/* Top row: icon + title */}
      <View style={styles.topRow}>
        <Icon name="calendar-star" size={18} color={colors.primary} />
        <Text style={styles.title} numberOfLines={1}>
          {plan.title}
        </Text>
      </View>

      {/* Recipient row */}
      {plan.recipient_name ? (
        <View style={styles.recipientRow}>
          <Icon name="account-heart" size={14} color={colors.textTertiary} />
          <Text style={styles.recipientText} numberOfLines={1}>
            {plan.recipient_name}
          </Text>
        </View>
      ) : null}

      {/* Countdown */}
      {daysRemaining !== null ? (
        daysRemaining >= 0 ? (
          <View style={styles.countdownRow}>
            <Text style={styles.countdownNumber}>{daysRemaining}</Text>
            <Text style={styles.countdownLabel}>{t("activePlan.days")}</Text>
          </View>
        ) : (
          <Text style={styles.eventPassedText}>
            {t("activePlan.eventPassed")}
          </Text>
        )
      ) : null}

      {/* Progress bar */}
      {totalItems > 0 ? (
        <View style={styles.progressSection}>
          <View style={styles.progressTrack}>
            <View
              style={[
                styles.progressFill,
                { width: `${progressRatio * 100}%` },
              ]}
            />
          </View>
          <Text style={styles.progressLabel}>
            {t("activePlan.progress", {
              completed: completedItems,
              total: totalItems,
            })}
          </Text>
        </View>
      ) : null}
    </TouchableOpacity>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    card: {
      width: 260,
      backgroundColor: colors.surface,
      borderColor: colors.borderLight,
      borderWidth: 0.5,
      borderRadius: BorderRadius.xl,
      padding: Spacing.md,
      marginRight: Spacing.md,
      ...Shadows.md,
    },
    topRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginBottom: Spacing.xs,
    },
    title: {
      ...Typography.body,
      fontWeight: "600",
      color: colors.text,
      flex: 1,
    },
    recipientRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.xs,
      marginBottom: Spacing.sm,
    },
    recipientText: {
      ...Typography.caption,
      color: colors.textSecondary,
      flex: 1,
    },
    countdownRow: {
      flexDirection: "row",
      alignItems: "baseline",
      gap: Spacing.xs,
      marginBottom: Spacing.sm,
    },
    countdownNumber: {
      ...Typography.h2,
      fontWeight: "700",
      color: colors.primary,
    },
    countdownLabel: {
      ...Typography.caption,
      color: colors.textSecondary,
    },
    eventPassedText: {
      ...Typography.caption,
      color: colors.textTertiary,
      marginBottom: Spacing.sm,
    },
    progressSection: {
      gap: Spacing.xs,
    },
    progressTrack: {
      height: 4,
      backgroundColor: colors.borderLight,
      borderRadius: 2,
      overflow: "hidden",
    },
    progressFill: {
      height: 4,
      backgroundColor: colors.success,
      borderRadius: 2,
    },
    progressLabel: {
      ...Typography.caption,
      color: colors.textSecondary,
    },
  });
