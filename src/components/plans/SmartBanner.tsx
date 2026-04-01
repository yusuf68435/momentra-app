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
} from "../../constants/theme";
import type { Plan } from "../../types/database";

interface Props {
  plan: Plan;
  lang: "tr" | "en";
  onPress: () => void;
}

export function SmartBanner({ plan, lang: _lang, onPress }: Props) {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const styles = useMemo(() => createStyles(colors), [colors]);

  const nextItem = useMemo(() => {
    if (!plan.checklist) return null;
    const pending = plan.checklist
      .filter((item) => !item.is_completed && item.due_date)
      .sort(
        (a, b) =>
          new Date(a.due_date!).getTime() - new Date(b.due_date!).getTime(),
      );
    return pending[0] ?? null;
  }, [plan.checklist]);

  if (!nextItem) return null;

  const daysLeft = Math.ceil(
    (new Date(nextItem.due_date!).getTime() - Date.now()) /
      (1000 * 60 * 60 * 24),
  );

  if (daysLeft > 7 || daysLeft < -1) return null;

  const isUrgent = daysLeft <= 1;

  const urgencyLabel =
    daysLeft < 0
      ? t("smartBanner.overdue")
      : daysLeft === 0
        ? t("smartBanner.today")
        : t("smartBanner.daysLeft", { days: daysLeft });

  return (
    <TouchableOpacity
      style={styles.banner}
      onPress={onPress}
      activeOpacity={0.8}
      accessibilityRole="button"
      accessibilityLabel={urgencyLabel}
    >
      <Icon
        name={isUrgent ? "alert-circle" : "clock-outline"}
        size={20}
        color={colors.warning}
      />
      <View style={styles.content}>
        <Text style={styles.urgencyText}>{urgencyLabel}</Text>
        <Text style={styles.itemTitle} numberOfLines={1}>
          {nextItem.title}
        </Text>
      </View>
      <Icon name="chevron-right" size={20} color={colors.warning} />
    </TouchableOpacity>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    banner: {
      flexDirection: "row",
      alignItems: "center",
      backgroundColor: colors.warning + "15",
      borderColor: colors.warning + "30",
      borderWidth: 1,
      borderRadius: BorderRadius.lg,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.md,
      marginHorizontal: Spacing.lg,
      marginBottom: Spacing.sm,
      gap: Spacing.sm,
    },
    content: {
      flex: 1,
      gap: 2,
    },
    urgencyText: {
      ...Typography.caption,
      color: colors.warning,
      fontWeight: "600",
    },
    itemTitle: {
      ...Typography.bodySmall,
      color: colors.text,
    },
  });
