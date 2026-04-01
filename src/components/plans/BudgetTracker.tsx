import React, { useMemo } from "react";
import { View, Text, StyleSheet } from "react-native";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import { EXPENSE_CATEGORIES } from "../../constants/expenseCategories";
import Animated, { FadeInDown } from "react-native-reanimated";
import { useTheme } from "../../contexts/ThemeContext";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../constants/theme";

interface BudgetItem {
  id: string;
  name: string;
  amount: number;
  category:
    | "gift"
    | "food"
    | "decoration"
    | "venue"
    | "entertainment"
    | "transport"
    | "other";
  isPaid: boolean;
}

interface BudgetTrackerProps {
  totalBudget: number;
  items: BudgetItem[];
  currency?: string;
}

export function BudgetTracker({
  totalBudget,
  items,
  currency = "\u20BA",
}: BudgetTrackerProps) {
  const { colors } = useTheme();
  const { t } = useTranslation();
  const styles = useMemo(() => createStyles(colors), [colors]);

  const totalSpent = items.reduce((sum, item) => sum + item.amount, 0);
  const totalPaid = items
    .filter((i) => i.isPaid)
    .reduce((sum, item) => sum + item.amount, 0);
  const remaining = totalBudget - totalSpent;
  const percentage =
    totalBudget > 0 ? Math.min((totalSpent / totalBudget) * 100, 100) : 0;

  const isOverBudget = totalSpent > totalBudget;
  const barColor = isOverBudget
    ? colors.error
    : percentage > 80
      ? colors.warning
      : colors.success;

  // Group by category
  const categoryTotals = items.reduce<Record<string, number>>((acc, item) => {
    acc[item.category] = (acc[item.category] || 0) + item.amount;
    return acc;
  }, {});

  return (
    <Animated.View entering={FadeInDown.duration(400)} style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <View style={styles.headerLeft}>
          <Icon name="wallet" size={20} color={colors.primary} />
          <Text style={styles.headerTitle}>{t("budget.tracker_title")}</Text>
        </View>
        <Text
          style={[styles.headerAmount, isOverBudget && { color: colors.error }]}
        >
          {currency}
          {totalSpent.toLocaleString()} / {currency}
          {totalBudget.toLocaleString()}
        </Text>
      </View>

      {/* Progress Bar */}
      <View style={styles.progressBarBg}>
        <View
          style={[
            styles.progressBarFill,
            {
              width: `${Math.min(percentage, 100)}%`,
              backgroundColor: barColor,
            },
          ]}
        />
      </View>

      {/* Stats Row */}
      <View style={styles.statsRow}>
        <View style={styles.statItem}>
          <Text style={styles.statLabel}>{t("budget.spent")}</Text>
          <Text style={[styles.statValue, { color: colors.primary }]}>
            {currency}
            {totalSpent.toLocaleString()}
          </Text>
        </View>
        <View style={styles.statDivider} />
        <View style={styles.statItem}>
          <Text style={styles.statLabel}>{t("budget.paid")}</Text>
          <Text style={[styles.statValue, { color: colors.success }]}>
            {currency}
            {totalPaid.toLocaleString()}
          </Text>
        </View>
        <View style={styles.statDivider} />
        <View style={styles.statItem}>
          <Text style={styles.statLabel}>{t("budget.remaining")}</Text>
          <Text
            style={[
              styles.statValue,
              { color: isOverBudget ? colors.error : colors.info },
            ]}
          >
            {isOverBudget ? "-" : ""}
            {currency}
            {Math.abs(remaining).toLocaleString()}
          </Text>
        </View>
      </View>

      {/* Category Breakdown */}
      {Object.keys(categoryTotals).length > 0 && (
        <View style={styles.breakdownSection}>
          <Text style={styles.breakdownTitle}>
            {t("budget.category_breakdown")}
          </Text>
          {Object.entries(categoryTotals)
            .sort(([, a], [, b]) => b - a)
            .map(([category, amount]) => {
              const config =
                EXPENSE_CATEGORIES[category] || EXPENSE_CATEGORIES.other;
              const catPercentage =
                totalSpent > 0 ? (amount / totalSpent) * 100 : 0;

              return (
                <View key={category} style={styles.breakdownRow}>
                  <View
                    style={[
                      styles.breakdownIcon,
                      { backgroundColor: config.color + "15" },
                    ]}
                  >
                    <Icon
                      name={config.icon as IconName}
                      size={16}
                      color={config.color}
                    />
                  </View>
                  <Text style={styles.breakdownLabel}>
                    {t(config.labelKey)}
                  </Text>
                  <View style={styles.breakdownBarContainer}>
                    <View
                      style={[
                        styles.breakdownBar,
                        {
                          width: `${catPercentage}%`,
                          backgroundColor: config.color,
                        },
                      ]}
                    />
                  </View>
                  <Text style={styles.breakdownAmount}>
                    {currency}
                    {amount.toLocaleString()}
                  </Text>
                </View>
              );
            })}
        </View>
      )}

      {/* Over Budget Warning */}
      {isOverBudget && (
        <View style={styles.warningBanner}>
          <Icon name="alert" size={18} color={colors.error} />
          <Text style={styles.warningText}>
            {t("budget.over_budget_warning", {
              currency,
              amount: (totalSpent - totalBudget).toLocaleString(),
            })}
          </Text>
        </View>
      )}
    </Animated.View>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      padding: Spacing.md,
      borderWidth: 1,
      borderColor: colors.border,
      ...Shadows.sm,
    },
    header: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      marginBottom: Spacing.md,
    },
    headerLeft: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
    },
    headerTitle: {
      ...Typography.h4,
      color: colors.text,
    },
    headerAmount: {
      ...Typography.bodySmall,
      fontWeight: "600",
      color: colors.textSecondary,
    },
    progressBarBg: {
      height: 8,
      backgroundColor: colors.surfaceVariant,
      borderRadius: 4,
      overflow: "hidden",
      marginBottom: Spacing.md,
    },
    progressBarFill: {
      height: "100%",
      borderRadius: 4,
    },
    statsRow: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "space-around",
      paddingVertical: Spacing.sm,
      marginBottom: Spacing.sm,
    },
    statItem: {
      alignItems: "center",
      flex: 1,
    },
    statLabel: {
      ...Typography.caption,
      color: colors.textTertiary,
      marginBottom: 2,
    },
    statValue: {
      ...Typography.body,
      fontWeight: "700",
    },
    statDivider: {
      width: 1,
      height: 30,
      backgroundColor: colors.border,
    },
    breakdownSection: {
      borderTopWidth: 1,
      borderTopColor: colors.border,
      paddingTop: Spacing.md,
      marginTop: Spacing.sm,
    },
    breakdownTitle: {
      ...Typography.bodySmall,
      fontWeight: "600",
      color: colors.text,
      marginBottom: Spacing.sm,
    },
    breakdownRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginBottom: Spacing.sm,
    },
    breakdownIcon: {
      width: 28,
      height: 28,
      borderRadius: 14,
      alignItems: "center",
      justifyContent: "center",
    },
    breakdownLabel: {
      ...Typography.caption,
      color: colors.textSecondary,
      width: 75,
    },
    breakdownBarContainer: {
      flex: 1,
      height: 6,
      backgroundColor: colors.surfaceVariant,
      borderRadius: 3,
      overflow: "hidden",
    },
    breakdownBar: {
      height: "100%",
      borderRadius: 3,
    },
    breakdownAmount: {
      ...Typography.caption,
      fontWeight: "600",
      color: colors.text,
      width: 65,
      textAlign: "right",
    },
    warningBanner: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      backgroundColor: colors.error + "10",
      borderRadius: BorderRadius.md,
      padding: Spacing.sm,
      marginTop: Spacing.sm,
    },
    warningText: {
      ...Typography.caption,
      color: colors.error,
      fontWeight: "600",
    },
  });
