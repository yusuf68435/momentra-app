import React, { useState } from "react";
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  StyleSheet,
} from "react-native";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import { useTheme } from "../../contexts/ThemeContext";
import { Spacing, Typography, BorderRadius } from "../../constants/theme";
import { Button } from "../ui/Button";
import { Modal } from "../ui/Modal";
import { hapticSelection, hapticSuccess } from "../../utils/haptics";
import { EXPENSE_CATEGORIES as CATEGORY_CONFIG } from "./ExpenseItem";
import type { Expense } from "../../services/expenses";

interface AddExpenseModalProps {
  visible: boolean;
  onClose: () => void;
  onSave: (data: {
    name: string;
    amount: number;
    category: Expense["category"];
    notes?: string;
  }) => void;
  lang: "tr" | "en";
}

export function AddExpenseModal({
  visible,
  onClose,
  onSave,
  lang,
}: AddExpenseModalProps) {
  const { colors } = useTheme();
  const { t } = useTranslation();
  const [name, setName] = useState("");
  const [amount, setAmount] = useState("");
  const [category, setCategory] = useState<Expense["category"]>("other");
  const [notes, setNotes] = useState("");

  const handleSave = () => {
    const parsedAmount = parseFloat(amount.replace(",", "."));
    if (!name.trim() || isNaN(parsedAmount) || parsedAmount <= 0) return;

    hapticSuccess();
    onSave({
      name: name.trim(),
      amount: parsedAmount,
      category,
      notes: notes.trim() || undefined,
    });

    // Reset
    setName("");
    setAmount("");
    setCategory("other");
    setNotes("");
  };

  const isValid =
    name.trim().length > 0 && parseFloat(amount.replace(",", ".")) > 0;

  return (
    <Modal
      visible={visible}
      onClose={onClose}
      title={t("expenses.addExpense")}
      scrollable
    >
      <Text style={[styles.label, { color: colors.textSecondary }]}>
        {t("expenses.expenseName")}
      </Text>
      <TextInput
        style={[
          styles.input,
          { backgroundColor: colors.surfaceVariant, color: colors.text },
        ]}
        value={name}
        onChangeText={setName}
        placeholder={t("expenses.expenseNamePlaceholder")}
        placeholderTextColor={colors.textTertiary}
      />

      <Text style={[styles.label, { color: colors.textSecondary }]}>
        {t("expenses.amount")}
      </Text>
      <TextInput
        style={[
          styles.input,
          { backgroundColor: colors.surfaceVariant, color: colors.text },
        ]}
        value={amount}
        onChangeText={setAmount}
        placeholder="0"
        placeholderTextColor={colors.textTertiary}
        keyboardType="decimal-pad"
      />

      <Text style={[styles.label, { color: colors.textSecondary }]}>
        {t("expenses.category")}
      </Text>
      <View style={styles.categoryGrid}>
        {Object.entries(CATEGORY_CONFIG).map(([key, config]) => (
          <TouchableOpacity
            key={key}
            style={[
              styles.categoryChip,
              {
                borderColor: category === key ? config.color : colors.border,
              },
              category === key && {
                backgroundColor: config.color + "15",
              },
            ]}
            onPress={() => {
              hapticSelection();
              setCategory(key as Expense["category"]);
            }}
          >
            <Icon
              name={config.icon as IconName}
              size={16}
              color={config.color}
            />
            <Text
              style={[
                styles.categoryChipText,
                {
                  color: category === key ? config.color : colors.textSecondary,
                },
              ]}
            >
              {t(config.labelKey)}
            </Text>
          </TouchableOpacity>
        ))}
      </View>

      <Text style={[styles.label, { color: colors.textSecondary }]}>
        {t("expenses.noteOptional")}
      </Text>
      <TextInput
        style={[
          styles.input,
          { backgroundColor: colors.surfaceVariant, color: colors.text },
        ]}
        value={notes}
        onChangeText={setNotes}
        placeholder={t("expenses.notePlaceholder")}
        placeholderTextColor={colors.textTertiary}
        multiline
      />

      <Button
        title={t("expenses.save")}
        onPress={handleSave}
        disabled={!isValid}
        style={{ marginTop: Spacing.md }}
      />
    </Modal>
  );
}

const styles = StyleSheet.create({
  label: {
    ...Typography.caption,
    fontWeight: "600",
    marginBottom: Spacing.xs,
    marginTop: Spacing.md,
  },
  input: {
    borderRadius: BorderRadius.md,
    padding: Spacing.md,
    ...Typography.body,
  },
  categoryGrid: { flexDirection: "row", flexWrap: "wrap", gap: Spacing.sm },
  categoryChip: {
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.full,
    borderWidth: 1.5,
  },
  categoryChipText: { ...Typography.caption, fontWeight: "600" },
});
