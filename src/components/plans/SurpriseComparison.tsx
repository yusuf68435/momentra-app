import React, { useState, useRef } from "react";
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Dimensions,
  Animated,
  PanResponder,
} from "react-native";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import {
  type ThemeColors,
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";
import { Card } from "../ui/Card";

export interface Plan {
  id: string;
  title: string;
  budget: number;
  guest_count: number;
  prep_days: number;
  difficulty: "easy" | "medium" | "hard";
  category: string;
}

interface SurpriseComparisonProps {
  plans: Plan[];
  onChoose?: (planId: string) => void;
}

type ComparisonField =
  | "budget"
  | "guest_count"
  | "prep_days"
  | "difficulty"
  | "category";

interface ComparisonRow {
  field: ComparisonField;
  icon: string;
  labelKey: string;
  // Values can be number (budget, guest_count, prep_days) or string (difficulty, category)
  format: (value: string | number, lang: "tr" | "en") => string;
  compare: (
    a: string | number,
    b: string | number,
  ) => "better" | "worse" | "equal";
}

const DIFFICULTY_ORDER = { easy: 1, medium: 2, hard: 3 };
const DIFFICULTY_LABELS: Record<string, { tr: string; en: string }> = {
  easy: { tr: "Kolay", en: "Easy" },
  medium: { tr: "Orta", en: "Medium" },
  hard: { tr: "Zor", en: "Hard" },
};

const COMPARISON_ROWS: ComparisonRow[] = [
  {
    field: "budget",
    icon: "cash-multiple",
    labelKey: "comparison.fieldBudget",
    format: (v) => `${(v as number).toLocaleString()} TL`,
    compare: (a, b) =>
      (a as number) < (b as number)
        ? "better"
        : (a as number) > (b as number)
          ? "worse"
          : "equal",
  },
  {
    field: "guest_count",
    icon: "account-group",
    labelKey: "comparison.fieldGuests",
    format: (v, lang) =>
      `${v} ${lang === "tr" ? "kişi" : (v as number) === 1 ? "person" : "people"}`,
    compare: () => "equal",
  },
  {
    field: "prep_days",
    icon: "calendar-clock",
    labelKey: "comparison.fieldPrepDays",
    format: (v, lang) =>
      `${v} ${lang === "tr" ? "gün" : (v as number) === 1 ? "day" : "days"}`,
    compare: (a, b) =>
      (a as number) < (b as number)
        ? "better"
        : (a as number) > (b as number)
          ? "worse"
          : "equal",
  },
  {
    field: "difficulty",
    icon: "signal-cellular-3",
    labelKey: "comparison.fieldDifficulty",
    format: (v, lang) =>
      DIFFICULTY_LABELS[v as string]?.[lang] || (v as string),
    compare: (a, b) => {
      const aVal = DIFFICULTY_ORDER[a as keyof typeof DIFFICULTY_ORDER] || 0;
      const bVal = DIFFICULTY_ORDER[b as keyof typeof DIFFICULTY_ORDER] || 0;
      return aVal < bVal ? "better" : aVal > bVal ? "worse" : "equal";
    },
  },
  {
    field: "category",
    icon: "tag",
    labelKey: "comparison.fieldCategory",
    format: (v) => v as string,
    compare: () => "equal",
  },
];

const SCREEN_WIDTH = Dimensions.get("window").width;

export function SurpriseComparison({
  plans,
  onChoose,
}: SurpriseComparisonProps) {
  const { colors } = useTheme();
  const { t, i18n } = useTranslation();
  const lang = i18n.language as "tr" | "en";
  const styles = createStyles(colors);
  const [pairIndex, setPairIndex] = useState(0);
  const translateX = useRef(new Animated.Value(0)).current;

  // Build pairs from plans array
  const pairs: [Plan, Plan][] = [];
  for (let i = 0; i < plans.length - 1; i += 2) {
    pairs.push([plans[i], plans[i + 1]]);
  }

  const currentPair = pairs[pairIndex] || [plans[0], plans[1]];
  const planA = currentPair[0];
  const planB = currentPair[1];

  const canSwipe = pairs.length > 1;

  const panResponder = useRef(
    PanResponder.create({
      onMoveShouldSetPanResponder: (_, gestureState) =>
        canSwipe && Math.abs(gestureState.dx) > 20,
      onPanResponderMove: (_, gestureState) => {
        translateX.setValue(gestureState.dx);
      },
      onPanResponderRelease: (_, gestureState) => {
        const threshold = SCREEN_WIDTH * 0.25;
        if (gestureState.dx < -threshold && pairIndex < pairs.length - 1) {
          Animated.spring(translateX, {
            toValue: -SCREEN_WIDTH,
            useNativeDriver: true,
          }).start(() => {
            setPairIndex((prev) => prev + 1);
            translateX.setValue(0);
          });
        } else if (gestureState.dx > threshold && pairIndex > 0) {
          Animated.spring(translateX, {
            toValue: SCREEN_WIDTH,
            useNativeDriver: true,
          }).start(() => {
            setPairIndex((prev) => prev - 1);
            translateX.setValue(0);
          });
        } else {
          Animated.spring(translateX, {
            toValue: 0,
            useNativeDriver: true,
          }).start();
        }
      },
    }),
  ).current;

  const getComparisonColor = (result: "better" | "worse" | "equal"): string => {
    switch (result) {
      case "better":
        return colors.success;
      case "worse":
        return colors.error;
      default:
        return colors.text;
    }
  };

  if (!planA || !planB) {
    return (
      <View style={styles.errorContainer}>
        <Icon name="compare" size={48} color={colors.textTertiary} />
        <Text style={styles.errorText}>{t("comparison.needTwoPlans")}</Text>
      </View>
    );
  }

  return (
    <Animated.View
      style={[styles.container, { transform: [{ translateX }] }]}
      {...panResponder.panHandlers}
    >
      {/* Header */}
      <View style={styles.header}>
        <Icon name="compare" size={22} color={colors.primary} />
        <Text style={styles.headerTitle}>{t("comparison.title")}</Text>
        {canSwipe && (
          <Text style={styles.pairIndicator}>
            {pairIndex + 1}/{pairs.length}
          </Text>
        )}
      </View>

      {/* Column headers */}
      <View style={styles.columnHeaders}>
        <View style={styles.labelColumn} />
        <View style={styles.valueColumn}>
          <Text style={styles.planTitle} numberOfLines={1}>
            {planA.title}
          </Text>
        </View>
        <View style={styles.valueColumn}>
          <Text style={styles.planTitle} numberOfLines={1}>
            {planB.title}
          </Text>
        </View>
      </View>

      {/* Comparison rows */}
      {COMPARISON_ROWS.map((row) => {
        const valueA = planA[row.field];
        const valueB = planB[row.field];
        const resultA = row.compare(valueA as never, valueB as never);
        const resultB = row.compare(valueB as never, valueA as never);

        return (
          <View key={row.field} style={styles.comparisonRow}>
            <View style={styles.labelColumn}>
              <Icon
                name={row.icon as IconName}
                size={16}
                color={colors.textSecondary}
              />
              <Text style={styles.rowLabel}>{t(row.labelKey)}</Text>
            </View>
            <View style={[styles.valueColumn, styles.valueCell]}>
              <Text
                style={[
                  styles.valueText,
                  { color: getComparisonColor(resultA) },
                  resultA === "better" && styles.valueBetter,
                ]}
              >
                {row.format(valueA as never, lang)}
              </Text>
            </View>
            <View style={[styles.valueColumn, styles.valueCell]}>
              <Text
                style={[
                  styles.valueText,
                  { color: getComparisonColor(resultB) },
                  resultB === "better" && styles.valueBetter,
                ]}
              >
                {row.format(valueB as never, lang)}
              </Text>
            </View>
          </View>
        );
      })}

      {/* Choose buttons */}
      <View style={styles.buttonsRow}>
        <TouchableOpacity
          style={styles.chooseButton}
          onPress={() => onChoose?.(planA.id)}
          activeOpacity={0.7}
        >
          <Icon
            name="check-circle-outline"
            size={18}
            color={colors.textOnPrimary}
          />
          <Text style={styles.chooseButtonText}>{t("comparison.choose")}</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.chooseButton}
          onPress={() => onChoose?.(planB.id)}
          activeOpacity={0.7}
        >
          <Icon
            name="check-circle-outline"
            size={18}
            color={colors.textOnPrimary}
          />
          <Text style={styles.chooseButtonText}>{t("comparison.choose")}</Text>
        </TouchableOpacity>
      </View>

      {/* Swipe hint */}
      {canSwipe && (
        <Text style={styles.swipeHint}>{t("comparison.swipeHint")}</Text>
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
      marginBottom: Spacing.md,
      ...Shadows.md,
    },
    header: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginBottom: Spacing.md,
    },
    headerTitle: {
      ...Typography.h4,
      color: colors.text,
      flex: 1,
    },
    pairIndicator: {
      ...Typography.caption,
      fontWeight: "600",
      color: colors.primary,
      backgroundColor: colors.primary + "15",
      paddingHorizontal: Spacing.sm,
      paddingVertical: 2,
      borderRadius: BorderRadius.full,
    },
    columnHeaders: {
      flexDirection: "row",
      marginBottom: Spacing.sm,
      paddingBottom: Spacing.sm,
      borderBottomWidth: 1,
      borderBottomColor: colors.borderLight,
    },
    labelColumn: {
      flex: 1,
      flexDirection: "row",
      alignItems: "center",
      gap: 4,
    },
    valueColumn: {
      flex: 1.2,
      alignItems: "center",
    },
    planTitle: {
      ...Typography.bodySmall,
      fontWeight: "700",
      color: colors.primary,
      textAlign: "center",
    },
    comparisonRow: {
      flexDirection: "row",
      alignItems: "center",
      paddingVertical: Spacing.sm,
      borderBottomWidth: 1,
      borderBottomColor: colors.borderLight,
    },
    rowLabel: {
      ...Typography.caption,
      color: colors.textSecondary,
    },
    valueCell: {
      paddingVertical: Spacing.xs,
      paddingHorizontal: Spacing.xs,
      borderRadius: BorderRadius.sm,
    },
    valueText: {
      ...Typography.bodySmall,
      fontWeight: "600",
      textAlign: "center",
    },
    valueBetter: {
      fontWeight: "700",
    },
    buttonsRow: {
      flexDirection: "row",
      gap: Spacing.sm,
      marginTop: Spacing.md,
    },
    chooseButton: {
      flex: 1,
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      backgroundColor: colors.primary,
      paddingVertical: Spacing.sm + 2,
      borderRadius: BorderRadius.md,
      gap: Spacing.xs,
    },
    chooseButtonText: {
      ...Typography.buttonSmall,
      color: colors.textOnPrimary,
    },
    swipeHint: {
      ...Typography.caption,
      color: colors.textTertiary,
      textAlign: "center",
      marginTop: Spacing.sm,
    },
    errorContainer: {
      alignItems: "center",
      paddingVertical: Spacing.xl,
      paddingHorizontal: Spacing.md,
    },
    errorText: {
      ...Typography.body,
      color: colors.textSecondary,
      textAlign: "center",
      marginTop: Spacing.md,
    },
  });
