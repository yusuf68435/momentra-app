import React from "react";
import { View, Text, TouchableOpacity, StyleSheet } from "react-native";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import { useTheme } from "../../contexts/ThemeContext";
import { Spacing, Typography, BorderRadius } from "../../constants/theme";
import { hapticLight } from "../../utils/haptics";
import type { Expense } from "../../services/expenses";
import { EXPENSE_CATEGORIES } from "../../constants/expenseCategories";

interface ExpenseItemProps {
  expense: Expense;
  onTogglePaid: (id: string, isPaid: boolean) => void;
  onDelete: (id: string) => void;
}

export function ExpenseItem({
  expense,
  onTogglePaid,
  onDelete,
}: ExpenseItemProps) {
  const { colors } = useTheme();
  const { t } = useTranslation();
  const config =
    EXPENSE_CATEGORIES[expense.category] || EXPENSE_CATEGORIES.other;

  return (
    <View
      style={[
        styles.container,
        { backgroundColor: colors.surface, borderColor: colors.borderLight },
      ]}
    >
      <TouchableOpacity
        style={[
          styles.checkbox,
          { borderColor: expense.is_paid ? config.color : colors.border },
        ]}
        onPress={() => {
          hapticLight();
          onTogglePaid(expense.id, !expense.is_paid);
        }}
      >
        {expense.is_paid && (
          <Icon name="check" size={16} color={config.color} />
        )}
      </TouchableOpacity>
      <View style={styles.content}>
        <Text style={[styles.name, { color: colors.text }]} numberOfLines={1}>
          {expense.name}
        </Text>
        <View style={styles.meta}>
          <View
            style={[
              styles.categoryBadge,
              { backgroundColor: config.color + "15" },
            ]}
          >
            <Icon
              name={config.icon as IconName}
              size={12}
              color={config.color}
            />
            <Text style={[styles.categoryText, { color: config.color }]}>
              {t(config.labelKey)}
            </Text>
          </View>
          {expense.notes && (
            <Text
              style={[styles.notes, { color: colors.textTertiary }]}
              numberOfLines={1}
            >
              {expense.notes}
            </Text>
          )}
        </View>
      </View>
      <Text
        style={[
          styles.amount,
          { color: expense.is_paid ? colors.success : colors.text },
        ]}
      >
        ₺{expense.amount.toLocaleString()}
      </Text>
      <TouchableOpacity
        onPress={() => {
          hapticLight();
          onDelete(expense.id);
        }}
        style={styles.deleteBtn}
      >
        <Icon name="trash-can-outline" size={18} color={colors.error} />
      </TouchableOpacity>
    </View>
  );
}

export { EXPENSE_CATEGORIES };

const styles = StyleSheet.create({
  container: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
    marginBottom: Spacing.sm,
    gap: Spacing.sm,
  },
  checkbox: {
    width: 24,
    height: 24,
    borderRadius: 12,
    borderWidth: 2,
    alignItems: "center",
    justifyContent: "center",
  },
  content: { flex: 1 },
  name: { ...Typography.body, fontWeight: "500" },
  meta: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    marginTop: 2,
  },
  categoryBadge: {
    flexDirection: "row",
    alignItems: "center",
    gap: 3,
    paddingHorizontal: 6,
    paddingVertical: 2,
    borderRadius: BorderRadius.full,
  },
  categoryText: { fontSize: 10, fontWeight: "600" },
  notes: { ...Typography.caption, flex: 1 },
  amount: { ...Typography.body, fontWeight: "700", marginRight: 4 },
  deleteBtn: { padding: 4 },
});
