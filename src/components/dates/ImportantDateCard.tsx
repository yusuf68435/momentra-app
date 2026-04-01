import React from "react";
import { View, Text, TouchableOpacity, StyleSheet } from "react-native";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import { useTheme } from "../../contexts/ThemeContext";
import { Spacing, Typography, BorderRadius } from "../../constants/theme";
import type { ImportantDate } from "../../services/importantDates";
import { DATE_TYPE_CONFIG } from "../../constants/dateTypes";

interface Props {
  date: ImportantDate & { daysUntil?: number };
  onDelete?: (id: string) => void;
}

export function ImportantDateCard({ date, onDelete }: Props) {
  const { colors } = useTheme();
  const { t, i18n } = useTranslation();
  const config = DATE_TYPE_CONFIG[date.date_type] || DATE_TYPE_CONFIG.other;

  return (
    <View
      style={[
        styles.container,
        { backgroundColor: colors.surface, borderColor: colors.borderLight },
      ]}
    >
      <View style={[styles.dateBox, { backgroundColor: config.color + "15" }]}>
        <Text style={[styles.dateDay, { color: config.color }]}>
          {date.date_day}
        </Text>
        <Text style={[styles.dateMonth, { color: config.color }]}>
          {new Date(2000, date.date_month - 1, 1).toLocaleDateString(
            i18n.language,
            { month: "short" },
          )}
        </Text>
      </View>
      <View style={styles.content}>
        <Text style={[styles.name, { color: colors.text }]}>
          {date.person_name}
        </Text>
        <View style={styles.meta}>
          <Icon name={config.icon as IconName} size={14} color={config.color} />
          <Text style={[styles.type, { color: config.color }]}>
            {t(config.labelKey)}
          </Text>
          {date.daysUntil !== undefined && (
            <Text
              style={[
                styles.countdown,
                {
                  color:
                    date.daysUntil <= 7 ? colors.error : colors.textTertiary,
                },
              ]}
            >
              {date.daysUntil === 0
                ? t("dates.todayLabel")
                : `${date.daysUntil} ${t("dates.daysLabel")}`}
            </Text>
          )}
        </View>
        {date.notes && (
          <Text
            style={[styles.notes, { color: colors.textTertiary }]}
            numberOfLines={1}
          >
            {date.notes}
          </Text>
        )}
      </View>
      {onDelete && (
        <TouchableOpacity
          onPress={() => onDelete(date.id)}
          style={styles.deleteBtn}
        >
          <Icon name="close" size={18} color={colors.textTertiary} />
        </TouchableOpacity>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: "row",
    alignItems: "center",
    borderRadius: BorderRadius.md,
    borderWidth: 1,
    marginBottom: Spacing.sm,
    overflow: "hidden",
  },
  dateBox: {
    width: 56,
    height: 64,
    alignItems: "center",
    justifyContent: "center",
  },
  dateDay: { fontSize: 22, fontWeight: "700" },
  dateMonth: { fontSize: 11, fontWeight: "600", marginTop: -2 },
  content: { flex: 1, padding: Spacing.md },
  name: { ...Typography.body, fontWeight: "600" },
  meta: { flexDirection: "row", alignItems: "center", gap: 4, marginTop: 2 },
  type: { ...Typography.caption, fontWeight: "500" },
  countdown: { ...Typography.caption, fontWeight: "700", marginLeft: "auto" },
  notes: { ...Typography.caption, marginTop: 2 },
  deleteBtn: { padding: Spacing.md },
});
