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
import type { ImportantDate } from "../../services/importantDates";
import { DATE_TYPE_OPTIONS } from "../../constants/dateTypes";

const NOTIFY_OPTIONS = [1, 3, 7, 14, 30];

interface Props {
  visible: boolean;
  onClose: () => void;
  onSave: (data: {
    person_name: string;
    date_month: number;
    date_day: number;
    date_type: ImportantDate["date_type"];
    notes?: string;
    notify_days_before?: number;
  }) => void;
}

export function AddDateModal({ visible, onClose, onSave }: Props) {
  const { colors } = useTheme();
  const { t } = useTranslation();
  const [personName, setPersonName] = useState("");
  const [month, setMonth] = useState("");
  const [day, setDay] = useState("");
  const [dateType, setDateType] =
    useState<ImportantDate["date_type"]>("birthday");
  const [notes, setNotes] = useState("");
  const [notifyDays, setNotifyDays] = useState(7);

  const handleSave = () => {
    const m = parseInt(month);
    const d = parseInt(day);
    if (
      !personName.trim() ||
      isNaN(m) ||
      m < 1 ||
      m > 12 ||
      isNaN(d) ||
      d < 1 ||
      d > 31
    )
      return;

    hapticSuccess();
    onSave({
      person_name: personName.trim(),
      date_month: m,
      date_day: d,
      date_type: dateType,
      notes: notes.trim() || undefined,
      notify_days_before: notifyDays,
    });

    setPersonName("");
    setMonth("");
    setDay("");
    setDateType("birthday");
    setNotes("");
    setNotifyDays(7);
  };

  const isValid =
    personName.trim().length > 0 &&
    parseInt(month) >= 1 &&
    parseInt(month) <= 12 &&
    parseInt(day) >= 1 &&
    parseInt(day) <= 31;

  return (
    <Modal
      visible={visible}
      onClose={onClose}
      title={t("dates.addTitle")}
      maxHeight="90%"
      scrollable
    >
      <Text style={[styles.label, { color: colors.textSecondary }]}>
        {t("dates.personName")}
      </Text>
      <TextInput
        style={[
          styles.input,
          { backgroundColor: colors.surfaceVariant, color: colors.text },
        ]}
        value={personName}
        onChangeText={setPersonName}
        placeholder={t("dates.personNamePlaceholder")}
        placeholderTextColor={colors.textTertiary}
      />

      <Text style={[styles.label, { color: colors.textSecondary }]}>
        {t("dates.date")}
      </Text>
      <View style={styles.dateRow}>
        <TextInput
          style={[
            styles.dateInput,
            {
              backgroundColor: colors.surfaceVariant,
              color: colors.text,
            },
          ]}
          value={day}
          onChangeText={setDay}
          placeholder={t("dates.day")}
          placeholderTextColor={colors.textTertiary}
          keyboardType="number-pad"
          maxLength={2}
        />
        <Text style={[styles.dateSeparator, { color: colors.textSecondary }]}>
          /
        </Text>
        <TextInput
          style={[
            styles.dateInput,
            {
              backgroundColor: colors.surfaceVariant,
              color: colors.text,
            },
          ]}
          value={month}
          onChangeText={setMonth}
          placeholder={t("dates.month")}
          placeholderTextColor={colors.textTertiary}
          keyboardType="number-pad"
          maxLength={2}
        />
      </View>

      <Text style={[styles.label, { color: colors.textSecondary }]}>
        {t("dates.type")}
      </Text>
      <View style={styles.typeGrid}>
        {DATE_TYPE_OPTIONS.map((option) => (
          <TouchableOpacity
            key={option.key}
            style={[
              styles.typeChip,
              {
                borderColor:
                  dateType === option.key ? option.color : colors.border,
              },
              dateType === option.key && {
                backgroundColor: option.color + "15",
              },
            ]}
            onPress={() => {
              hapticSelection();
              setDateType(option.key as ImportantDate["date_type"]);
            }}
          >
            <Icon
              name={option.icon as IconName}
              size={16}
              color={option.color}
            />
            <Text
              style={[
                styles.typeText,
                {
                  color:
                    dateType === option.key
                      ? option.color
                      : colors.textSecondary,
                },
              ]}
            >
              {t(option.labelKey)}
            </Text>
          </TouchableOpacity>
        ))}
      </View>

      <Text style={[styles.label, { color: colors.textSecondary }]}>
        {t("dates.reminder")}
      </Text>
      <View style={styles.notifyRow}>
        {NOTIFY_OPTIONS.map((d) => (
          <TouchableOpacity
            key={d}
            style={[
              styles.notifyChip,
              {
                borderColor: notifyDays === d ? colors.primary : colors.border,
              },
              notifyDays === d && {
                backgroundColor: colors.primary + "15",
              },
            ]}
            onPress={() => {
              hapticSelection();
              setNotifyDays(d);
            }}
          >
            <Text
              style={[
                styles.notifyText,
                {
                  color:
                    notifyDays === d ? colors.primary : colors.textSecondary,
                },
              ]}
            >
              {d} {t("dates.days")}
            </Text>
          </TouchableOpacity>
        ))}
      </View>

      <Text style={[styles.label, { color: colors.textSecondary }]}>
        {t("dates.noteOptional")}
      </Text>
      <TextInput
        style={[
          styles.input,
          { backgroundColor: colors.surfaceVariant, color: colors.text },
        ]}
        value={notes}
        onChangeText={setNotes}
        placeholder={t("dates.notePlaceholder")}
        placeholderTextColor={colors.textTertiary}
        multiline
      />

      <Button
        title={t("dates.save")}
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
  dateRow: { flexDirection: "row", alignItems: "center", gap: Spacing.sm },
  dateInput: {
    flex: 1,
    borderRadius: BorderRadius.md,
    padding: Spacing.md,
    ...Typography.body,
    textAlign: "center",
  },
  dateSeparator: { ...Typography.h3 },
  typeGrid: { flexDirection: "row", flexWrap: "wrap", gap: Spacing.sm },
  typeChip: {
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.full,
    borderWidth: 1.5,
  },
  typeText: { ...Typography.caption, fontWeight: "600" },
  notifyRow: { flexDirection: "row", flexWrap: "wrap", gap: Spacing.sm },
  notifyChip: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.full,
    borderWidth: 1.5,
  },
  notifyText: { ...Typography.caption, fontWeight: "600" },
});
