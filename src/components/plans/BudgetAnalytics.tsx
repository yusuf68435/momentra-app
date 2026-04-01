import React from "react";
import { View, Text, StyleSheet } from "react-native";
import Svg, { Circle } from "react-native-svg";
import { Icon } from "../ui/Icon";
import { useTranslation } from "react-i18next";
import { EXPENSE_CATEGORIES } from "../../constants/expenseCategories";
import {
  type ThemeColors,
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";
import { Card } from "../ui/Card";

export interface Expense {
  id: string;
  name: string;
  amount: number;
  category: ExpenseCategory;
}

export type ExpenseCategory =
  | "food"
  | "decoration"
  | "venue"
  | "transport"
  | "gift"
  | "gifts"
  | "other";

interface BudgetAnalyticsProps {
  budget: number;
  expenses: Expense[];
}

/** Normalize legacy 'gifts' key to the shared 'gift' key. */
const normalizeCategoryKey = (cat: string): string =>
  cat === "gifts" ? "gift" : cat;

const RING_SIZE = 160;
const STROKE_WIDTH = 14;
const RADIUS = (RING_SIZE - STROKE_WIDTH) / 2;
const CIRCUMFERENCE = 2 * Math.PI * RADIUS;

export function BudgetAnalytics({ budget, expenses }: BudgetAnalyticsProps) {
  const { colors } = useTheme();
  const { t } = useTranslation();
  const styles = createStyles(colors);

  const totalSpent = expenses.reduce((sum, e) => sum + e.amount, 0);
  const remaining = Math.max(0, budget - totalSpent);
  const percentage =
    budget > 0 ? Math.min((totalSpent / budget) * 100, 100) : 0;
  const isOverBudget = totalSpent > budget;
  const isWarning = percentage >= 80;

  const strokeDashoffset = CIRCUMFERENCE - (CIRCUMFERENCE * percentage) / 100;

  // Group by category
  const categoryTotals: Record<string, number> = {};
  expenses.forEach((e) => {
    categoryTotals[e.category] = (categoryTotals[e.category] || 0) + e.amount;
  });

  const ringColor = isOverBudget
    ? colors.error
    : isWarning
      ? colors.warning
      : colors.primary;

  return (
    <Card style={styles.container}>
      <Text style={styles.sectionTitle}>{t("budget.analytics")}</Text>

      {/* Circular Progress */}
      <View style={styles.ringContainer}>
        <Svg width={RING_SIZE} height={RING_SIZE}>
          <Circle
            cx={RING_SIZE / 2}
            cy={RING_SIZE / 2}
            r={RADIUS}
            stroke={colors.border}
            strokeWidth={STROKE_WIDTH}
            fill="none"
          />
          <Circle
            cx={RING_SIZE / 2}
            cy={RING_SIZE / 2}
            r={RADIUS}
            stroke={ringColor}
            strokeWidth={STROKE_WIDTH}
            fill="none"
            strokeDasharray={`${CIRCUMFERENCE} ${CIRCUMFERENCE}`}
            strokeDashoffset={strokeDashoffset}
            strokeLinecap="round"
            transform={`rotate(-90 ${RING_SIZE / 2} ${RING_SIZE / 2})`}
          />
        </Svg>
        <View style={styles.ringCenter}>
          <Text style={styles.percentageText}>{Math.round(percentage)}%</Text>
          <Text style={styles.spentLabel}>{t("budget.spent")}</Text>
        </View>
      </View>

      {/* Summary Row */}
      <View style={styles.summaryRow}>
        <View style={styles.summaryItem}>
          <Text style={styles.summaryLabel}>{t("budget.totalBudget")}</Text>
          <Text style={styles.summaryValue}>${budget.toLocaleString()}</Text>
        </View>
        <View style={styles.summaryDivider} />
        <View style={styles.summaryItem}>
          <Text style={styles.summaryLabel}>{t("budget.totalSpent")}</Text>
          <Text style={[styles.summaryValue, { color: ringColor }]}>
            ${totalSpent.toLocaleString()}
          </Text>
        </View>
        <View style={styles.summaryDivider} />
        <View style={styles.summaryItem}>
          <Text style={styles.summaryLabel}>{t("budget.remaining")}</Text>
          <Text
            style={[
              styles.summaryValue,
              { color: isOverBudget ? colors.error : colors.success },
            ]}
          >
            ${remaining.toLocaleString()}
          </Text>
        </View>
      </View>

      {/* Warning */}
      {isWarning && (
        <View
          style={[
            styles.warningBanner,
            {
              backgroundColor: isOverBudget
                ? colors.error + "15"
                : colors.warning + "15",
            },
          ]}
        >
          <Icon
            name={isOverBudget ? "alert-circle" : "alert"}
            size={20}
            color={isOverBudget ? colors.error : colors.warning}
          />
          <Text
            style={[
              styles.warningText,
              { color: isOverBudget ? colors.error : colors.warning },
            ]}
          >
            {isOverBudget
              ? t("budget.overBudgetWarning")
              : t("budget.warningThreshold")}
          </Text>
        </View>
      )}

      {/* Category Breakdown */}
      <Text style={styles.breakdownTitle}>{t("budget.categoryBreakdown")}</Text>
      {Object.keys(categoryTotals).map((cat) => {
        const configKey = normalizeCategoryKey(cat);
        const config =
          EXPENSE_CATEGORIES[configKey] || EXPENSE_CATEGORIES.other;
        const amount = categoryTotals[cat] || 0;
        if (amount === 0) return null;
        const catPercentage = budget > 0 ? (amount / budget) * 100 : 0;

        return (
          <View key={cat} style={styles.categoryRow}>
            <View style={styles.categoryIcon}>
              <Icon name={config.icon} size={20} color={config.color} />
            </View>
            <View style={styles.categoryInfo}>
              <View style={styles.categoryHeader}>
                <Text style={styles.categoryName}>{t(config.labelKey)}</Text>
                <Text style={styles.categoryAmount}>
                  ${amount.toLocaleString()}
                </Text>
              </View>
              <View style={styles.barBackground}>
                <View
                  style={[
                    styles.barFill,
                    {
                      backgroundColor: config.color,
                      width: `${Math.min(catPercentage, 100)}%`,
                    },
                  ]}
                />
              </View>
            </View>
          </View>
        );
      })}
    </Card>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      padding: Spacing.lg,
      marginBottom: Spacing.md,
    },
    sectionTitle: {
      ...Typography.h3,
      color: colors.text,
      marginBottom: Spacing.lg,
    },
    ringContainer: {
      alignItems: "center",
      justifyContent: "center",
      marginBottom: Spacing.lg,
    },
    ringCenter: {
      position: "absolute",
      alignItems: "center",
    },
    percentageText: {
      fontSize: 28,
      fontWeight: "700",
      color: colors.text,
    },
    spentLabel: {
      ...Typography.caption,
      color: colors.textSecondary,
    },
    summaryRow: {
      flexDirection: "row",
      alignItems: "center",
      backgroundColor: colors.backgroundSecondary,
      borderRadius: BorderRadius.md,
      padding: Spacing.md,
      marginBottom: Spacing.md,
    },
    summaryItem: {
      flex: 1,
      alignItems: "center",
    },
    summaryDivider: {
      width: 1,
      height: 32,
      backgroundColor: colors.border,
    },
    summaryLabel: {
      ...Typography.caption,
      color: colors.textSecondary,
      marginBottom: 2,
    },
    summaryValue: {
      ...Typography.h4,
      color: colors.text,
    },
    warningBanner: {
      flexDirection: "row",
      alignItems: "center",
      padding: Spacing.md,
      borderRadius: BorderRadius.md,
      gap: Spacing.sm,
      marginBottom: Spacing.md,
    },
    warningText: {
      ...Typography.bodySmall,
      fontWeight: "600",
      flex: 1,
    },
    breakdownTitle: {
      ...Typography.h4,
      color: colors.text,
      marginBottom: Spacing.md,
      marginTop: Spacing.sm,
    },
    categoryRow: {
      flexDirection: "row",
      alignItems: "center",
      marginBottom: Spacing.md,
    },
    categoryIcon: {
      width: 36,
      height: 36,
      borderRadius: 18,
      backgroundColor: colors.backgroundSecondary,
      alignItems: "center",
      justifyContent: "center",
      marginRight: Spacing.sm,
    },
    categoryInfo: {
      flex: 1,
    },
    categoryHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      marginBottom: 4,
    },
    categoryName: {
      ...Typography.bodySmall,
      color: colors.text,
      fontWeight: "500",
    },
    categoryAmount: {
      ...Typography.bodySmall,
      color: colors.text,
      fontWeight: "600",
    },
    barBackground: {
      height: 6,
      backgroundColor: colors.border,
      borderRadius: 3,
      overflow: "hidden",
    },
    barFill: {
      height: "100%",
      borderRadius: 3,
    },
  });
