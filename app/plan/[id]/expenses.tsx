import React, {
  useState,
  useEffect,
  useRef,
  useMemo,
  useCallback,
} from "react";
import { View, Text, FlatList, StyleSheet, Alert } from "react-native";
import { useLocalSearchParams } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon } from "../../../src/components/ui/Icon";
import Animated, { FadeInDown } from "react-native-reanimated";
import { useTheme } from "../../../src/contexts/ThemeContext";
import { usePlanStore } from "../../../src/stores/planStore";
import { ExpenseItem } from "../../../src/components/plans/ExpenseItem";
import { AddExpenseModal } from "../../../src/components/plans/AddExpenseModal";
import { Button } from "../../../src/components/ui/Button";
import { EmptyState } from "../../../src/components/common/EmptyState";
import * as expenseService from "../../../src/services/expenses";
import type { Expense } from "../../../src/services/expenses";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../../src/constants/theme";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";

export default function ExpensesScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const { t, i18n } = useTranslation();
  const lang = i18n.language as "tr" | "en";
  const { colors } = useTheme();
  const { activePlan } = usePlanStore();

  const [expenses, setExpenses] = useState<Expense[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [showAddModal, setShowAddModal] = useState(false);

  const loadExpenses = useCallback(async () => {
    if (!id) return;
    setIsLoading(true);
    try {
      const data = await expenseService.fetchExpenses(id);
      setExpenses(data);
    } catch (err) {
      if (__DEV__) console.warn("Failed to load expenses:", err);
    } finally {
      setIsLoading(false);
    }
  }, [id]);

  useEffect(() => {
    loadExpenses();
  }, [loadExpenses]);

  const summary = useMemo(
    () => expenseService.getExpenseSummary(expenses),
    [expenses],
  );
  const budget = activePlan?.budget || 0;
  const budgetPercent =
    budget > 0 ? Math.min(100, Math.round((summary.total / budget) * 100)) : 0;

  const budgetAlertShown = useRef(false);

  // Reset alert flag when language changes so the alert fires again in the new language
  useEffect(() => {
    budgetAlertShown.current = false;
  }, [lang]);

  useEffect(() => {
    if (budget > 0 && summary.total > budget && !budgetAlertShown.current) {
      budgetAlertShown.current = true;
      Alert.alert(
        t("expenses.budget_exceeded_title"),
        t("expenses.budget_exceeded_body", {
          amount: `₺${(summary.total - budget).toLocaleString()}`,
        }),
      );
    }
    if (summary.total <= budget) {
      budgetAlertShown.current = false;
    }
  }, [summary.total, budget]);

  const handleAddExpense = async (data: {
    name: string;
    amount: number;
    category: Expense["category"];
    notes?: string;
  }) => {
    if (!id) return;
    try {
      const newExpense = await expenseService.addExpense(id, data);
      setExpenses((prev) => [newExpense, ...prev]);
      setShowAddModal(false);
    } catch (err) {
      if (__DEV__) console.warn("Failed to add expense:", err);
    }
  };

  const handleTogglePaid = async (expenseId: string, isPaid: boolean) => {
    try {
      await expenseService.updateExpense(expenseId, { is_paid: isPaid });
      setExpenses((prev) =>
        prev.map((e) => (e.id === expenseId ? { ...e, is_paid: isPaid } : e)),
      );
    } catch (err) {
      if (__DEV__) console.warn("Failed to update expense:", err);
    }
  };

  const handleDelete = (expenseId: string) => {
    Alert.alert(t("expenses.delete_title"), t("expenses.delete_confirm"), [
      { text: t("expenses.cancel"), style: "cancel" },
      {
        text: t("expenses.delete_title"),
        style: "destructive",
        onPress: async () => {
          try {
            await expenseService.deleteExpense(expenseId);
            setExpenses((prev) => prev.filter((e) => e.id !== expenseId));
          } catch (err) {
            if (__DEV__) console.warn("Failed to delete expense:", err);
          }
        },
      },
    ]);
  };

  const styles = useMemo(() => createStyles(colors), [colors]);

  return (
    <ScreenErrorBoundary>
      <View style={styles.container}>
        {/* Budget Summary */}
        <Animated.View
          entering={FadeInDown.duration(400)}
          style={styles.summaryCard}
        >
          <View style={styles.summaryRow}>
            <View>
              <Text style={styles.summaryLabel}>
                {t("expenses.total_spent")}
              </Text>
              <Text style={styles.summaryAmount}>
                ₺{summary.total.toLocaleString()}
              </Text>
            </View>
            {budget > 0 && (
              <View style={styles.summaryRight}>
                <Text style={styles.summaryLabel}>
                  {t("expenses.budget_label")}
                </Text>
                <Text style={styles.budgetAmount}>
                  ₺{budget.toLocaleString()}
                </Text>
              </View>
            )}
          </View>
          {budget > 0 && (
            <View style={styles.progressContainer}>
              <View
                style={[
                  styles.progressBg,
                  { backgroundColor: colors.borderLight },
                ]}
              >
                <View
                  style={[
                    styles.progressFill,
                    {
                      width: `${budgetPercent}%`,
                      backgroundColor:
                        budgetPercent > 90
                          ? colors.error
                          : budgetPercent > 70
                            ? colors.warning
                            : colors.success,
                    },
                  ]}
                />
              </View>
              <Text style={styles.progressText}>{budgetPercent}%</Text>
            </View>
          )}
          <View style={styles.paidRow}>
            <View style={styles.paidItem}>
              <Icon name="check-circle" size={16} color={colors.success} />
              <Text style={[styles.paidText, { color: colors.success }]}>
                {t("expenses.paid_label")}: ₺{summary.paid.toLocaleString()}
              </Text>
            </View>
            <View style={styles.paidItem}>
              <Icon name="clock-outline" size={16} color={colors.warning} />
              <Text style={[styles.paidText, { color: colors.warning }]}>
                {t("expenses.pending_label")}: ₺
                {summary.unpaid.toLocaleString()}
              </Text>
            </View>
          </View>
        </Animated.View>

        {budgetPercent >= 100 && (
          <Animated.View
            entering={FadeInDown.duration(300)}
            style={[
              styles.overrunBanner,
              {
                backgroundColor: colors.error + "15",
                borderColor: colors.error + "40",
              },
            ]}
          >
            <Icon name="alert-circle" size={20} color={colors.error} />
            <Text style={[styles.overrunText, { color: colors.error }]}>
              {t("expenses.overrun_banner", {
                amount: `₺${(summary.total - budget).toLocaleString()}`,
              })}
            </Text>
          </Animated.View>
        )}

        {/* Expense List */}
        {expenses.length === 0 && !isLoading ? (
          <EmptyState
            emoji="💸"
            title={t("expenses.empty_title")}
            description={t("expenses.empty_desc")}
          />
        ) : (
          <FlatList
            data={expenses}
            keyExtractor={(item) => item.id}
            contentContainerStyle={styles.list}
            renderItem={({ item }) => (
              <ExpenseItem
                expense={item}
                onTogglePaid={handleTogglePaid}
                onDelete={handleDelete}
              />
            )}
          />
        )}

        {/* Add Button */}
        <View style={styles.addButtonContainer}>
          <Button
            title={t("expenses.add_expense_btn")}
            onPress={() => setShowAddModal(true)}
          />
        </View>

        <AddExpenseModal
          visible={showAddModal}
          onClose={() => setShowAddModal(false)}
          onSave={handleAddExpense}
          lang={lang}
        />
      </View>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: { flex: 1, backgroundColor: colors.background },
    summaryCard: {
      margin: Spacing.lg,
      padding: Spacing.lg,
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      ...Shadows.md,
    },
    summaryRow: { flexDirection: "row", justifyContent: "space-between" },
    summaryLabel: { ...Typography.caption, color: colors.textSecondary },
    summaryAmount: { ...Typography.h2, color: colors.text, fontWeight: "700" },
    summaryRight: { alignItems: "flex-end" },
    budgetAmount: { ...Typography.h4, color: colors.textSecondary },
    progressContainer: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginTop: Spacing.md,
    },
    progressBg: { flex: 1, height: 8, borderRadius: 4, overflow: "hidden" },
    progressFill: { height: "100%", borderRadius: 4 },
    progressText: {
      ...Typography.caption,
      color: colors.textSecondary,
      fontWeight: "600",
      width: 36,
      textAlign: "right",
    },
    paidRow: {
      flexDirection: "row",
      justifyContent: "space-between",
      marginTop: Spacing.md,
    },
    paidItem: { flexDirection: "row", alignItems: "center", gap: 4 },
    paidText: { ...Typography.caption, fontWeight: "600" },
    list: { paddingHorizontal: Spacing.lg },
    addButtonContainer: { padding: Spacing.lg },
    overrunBanner: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginHorizontal: Spacing.lg,
      marginBottom: Spacing.md,
      padding: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1,
    },
    overrunText: { ...Typography.bodySmall, fontWeight: "600", flex: 1 },
  });
