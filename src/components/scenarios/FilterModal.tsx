import React, { useState, useMemo } from "react";
import {
  View,
  Text,
  ScrollView,
  TouchableOpacity,
  StyleSheet,
  Dimensions,
} from "react-native";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";
import { Modal } from "../ui/Modal";

const { height: SCREEN_HEIGHT } = Dimensions.get("window");

export interface ScenarioFilterState {
  budgetRange: [number, number];
  difficulty: number[];
  peopleCount: [number, number];
  indoorOutdoor: ("indoor" | "outdoor" | "both")[];
  seasons: string[];
  prepDays: [number, number];
  showPremiumOnly: boolean;
}

export const DEFAULT_FILTERS: ScenarioFilterState = {
  budgetRange: [0, 50000],
  difficulty: [],
  peopleCount: [1, 50],
  indoorOutdoor: [],
  seasons: [],
  prepDays: [0, 30],
  showPremiumOnly: false,
};

interface FilterModalProps {
  visible: boolean;
  onClose: () => void;
  onApply: (filters: ScenarioFilterState) => void;
  currentFilters: ScenarioFilterState;
  lang: "tr" | "en";
}

const BUDGET_PRESETS = [
  { min: 0, max: 500, label_tr: "₺0-500", label_en: "₺0-500" },
  { min: 500, max: 2000, label_tr: "₺500-2K", label_en: "₺500-2K" },
  { min: 2000, max: 5000, label_tr: "₺2K-5K", label_en: "₺2K-5K" },
  { min: 5000, max: 15000, label_tr: "₺5K-15K", label_en: "₺5K-15K" },
  { min: 15000, max: 50000, label_tr: "₺15K+", label_en: "₺15K+" },
];

const DIFFICULTY_OPTIONS = [
  { value: 1, label_tr: "Kolay", label_en: "Easy", emoji: "😊" },
  { value: 2, label_tr: "Orta", label_en: "Medium", emoji: "🙂" },
  { value: 3, label_tr: "Zor", label_en: "Hard", emoji: "💪" },
  { value: 4, label_tr: "Uzman", label_en: "Expert", emoji: "🔥" },
];

const LOCATION_OPTIONS = [
  {
    value: "indoor" as const,
    label_tr: "İç Mekan",
    label_en: "Indoor",
    icon: "home" as const,
  },
  {
    value: "outdoor" as const,
    label_tr: "Dış Mekan",
    label_en: "Outdoor",
    icon: "tree" as const,
  },
  {
    value: "both" as const,
    label_tr: "Her İkisi",
    label_en: "Both",
    icon: "swap-horizontal" as const,
  },
];

const SEASON_OPTIONS = [
  { value: "spring", label_tr: "İlkbahar", label_en: "Spring", emoji: "🌸" },
  { value: "summer", label_tr: "Yaz", label_en: "Summer", emoji: "☀️" },
  { value: "fall", label_tr: "Sonbahar", label_en: "Fall", emoji: "🍂" },
  { value: "winter", label_tr: "Kış", label_en: "Winter", emoji: "❄️" },
];

const PEOPLE_PRESETS = [
  { min: 1, max: 2, label_tr: "1-2 kişi", label_en: "1-2 people", emoji: "👤" },
  { min: 3, max: 6, label_tr: "3-6 kişi", label_en: "3-6 people", emoji: "👥" },
  {
    min: 7,
    max: 15,
    label_tr: "7-15 kişi",
    label_en: "7-15 people",
    emoji: "👨‍👩‍👧‍👦",
  },
  {
    min: 16,
    max: 50,
    label_tr: "16+ kişi",
    label_en: "16+ people",
    emoji: "🎉",
  },
];

const PREP_PRESETS = [
  { min: 0, max: 1, label_tr: "1 gün", label_en: "1 day", emoji: "⚡" },
  { min: 2, max: 5, label_tr: "2-5 gün", label_en: "2-5 days", emoji: "📅" },
  {
    min: 6,
    max: 14,
    label_tr: "1-2 hafta",
    label_en: "1-2 weeks",
    emoji: "📆",
  },
  { min: 15, max: 30, label_tr: "2+ hafta", label_en: "2+ weeks", emoji: "🗓️" },
];

export function FilterModal({
  visible,
  onClose,
  onApply,
  currentFilters,
  lang,
}: FilterModalProps) {
  const [filters, setFilters] = useState<ScenarioFilterState>(currentFilters);
  const { colors } = useTheme();
  const { t } = useTranslation();

  const styles = useMemo(() => createStyles(colors), [colors]);

  const toggleArrayItem = <T,>(arr: T[], item: T): T[] => {
    return arr.includes(item) ? arr.filter((i) => i !== item) : [...arr, item];
  };

  const isBudgetSelected = (min: number, max: number) =>
    filters.budgetRange[0] === min && filters.budgetRange[1] === max;

  const isPeopleSelected = (min: number, max: number) =>
    filters.peopleCount[0] === min && filters.peopleCount[1] === max;

  const isPrepSelected = (min: number, max: number) =>
    filters.prepDays[0] === min && filters.prepDays[1] === max;

  const activeFilterCount = () => {
    let count = 0;
    if (filters.budgetRange[0] !== 0 || filters.budgetRange[1] !== 50000)
      count++;
    if (filters.difficulty.length > 0) count++;
    if (filters.peopleCount[0] !== 1 || filters.peopleCount[1] !== 50) count++;
    if (filters.indoorOutdoor.length > 0) count++;
    if (filters.seasons.length > 0) count++;
    if (filters.prepDays[0] !== 0 || filters.prepDays[1] !== 30) count++;
    if (filters.showPremiumOnly) count++;
    return count;
  };

  const resetFilters = () => setFilters(DEFAULT_FILTERS);

  return (
    <Modal visible={visible} onClose={onClose} maxHeight={SCREEN_HEIGHT * 0.85}>
      {/* Custom header — three-column layout with reset button cannot be expressed
          via the title prop alone, so it is rendered as content instead */}
      <View style={styles.header}>
        <TouchableOpacity
          onPress={onClose}
          style={styles.closeBtn}
          accessibilityLabel="Filtreleri kapat"
          accessibilityRole="button"
        >
          <Icon name="close" size={24} color={colors.text} />
        </TouchableOpacity>
        <Text style={styles.headerTitle}>{t("filterModal.title")}</Text>
        <TouchableOpacity
          onPress={resetFilters}
          accessibilityLabel="Tüm filtreleri temizle"
          accessibilityRole="button"
        >
          <Text style={styles.resetText}>{t("filterModal.reset")}</Text>
        </TouchableOpacity>
      </View>

      <ScrollView style={styles.content} showsVerticalScrollIndicator={false}>
        {/* Budget */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>💰 {t("filterModal.budget")}</Text>
          <View style={styles.chipRow}>
            <TouchableOpacity
              style={[
                styles.chip,
                isBudgetSelected(0, 50000) && styles.chipActive,
              ]}
              onPress={() =>
                setFilters((f) => ({ ...f, budgetRange: [0, 50000] }))
              }
            >
              <Text
                style={[
                  styles.chipText,
                  isBudgetSelected(0, 50000) && styles.chipTextActive,
                ]}
              >
                {t("filterModal.all")}
              </Text>
            </TouchableOpacity>
            {BUDGET_PRESETS.map((preset) => (
              <TouchableOpacity
                key={preset.min}
                style={[
                  styles.chip,
                  isBudgetSelected(preset.min, preset.max) && styles.chipActive,
                ]}
                onPress={() =>
                  setFilters((f) => ({
                    ...f,
                    budgetRange: [preset.min, preset.max],
                  }))
                }
              >
                <Text
                  style={[
                    styles.chipText,
                    isBudgetSelected(preset.min, preset.max) &&
                      styles.chipTextActive,
                  ]}
                >
                  {lang === "tr" ? preset.label_tr : preset.label_en}
                </Text>
              </TouchableOpacity>
            ))}
          </View>
        </View>

        {/* Difficulty */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>
            ⚡ {t("filterModal.difficultyLevel")}
          </Text>
          <View style={styles.chipRow}>
            {DIFFICULTY_OPTIONS.map((opt) => {
              const selected = filters.difficulty.includes(opt.value);
              return (
                <TouchableOpacity
                  key={opt.value}
                  style={[styles.chip, selected && styles.chipActive]}
                  onPress={() =>
                    setFilters((f) => ({
                      ...f,
                      difficulty: toggleArrayItem(f.difficulty, opt.value),
                    }))
                  }
                >
                  <Text
                    style={[styles.chipText, selected && styles.chipTextActive]}
                  >
                    {opt.emoji} {lang === "tr" ? opt.label_tr : opt.label_en}
                  </Text>
                </TouchableOpacity>
              );
            })}
          </View>
        </View>

        {/* People Count */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>
            👥 {t("filterModal.numberOfPeople")}
          </Text>
          <View style={styles.chipRow}>
            <TouchableOpacity
              style={[
                styles.chip,
                isPeopleSelected(1, 50) && styles.chipActive,
              ]}
              onPress={() =>
                setFilters((f) => ({ ...f, peopleCount: [1, 50] }))
              }
            >
              <Text
                style={[
                  styles.chipText,
                  isPeopleSelected(1, 50) && styles.chipTextActive,
                ]}
              >
                {t("filterModal.all")}
              </Text>
            </TouchableOpacity>
            {PEOPLE_PRESETS.map((preset) => (
              <TouchableOpacity
                key={preset.min}
                style={[
                  styles.chip,
                  isPeopleSelected(preset.min, preset.max) && styles.chipActive,
                ]}
                onPress={() =>
                  setFilters((f) => ({
                    ...f,
                    peopleCount: [preset.min, preset.max],
                  }))
                }
              >
                <Text
                  style={[
                    styles.chipText,
                    isPeopleSelected(preset.min, preset.max) &&
                      styles.chipTextActive,
                  ]}
                >
                  {preset.emoji}{" "}
                  {lang === "tr" ? preset.label_tr : preset.label_en}
                </Text>
              </TouchableOpacity>
            ))}
          </View>
        </View>

        {/* Location */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>
            📍 {t("filterModal.locationType")}
          </Text>
          <View style={styles.chipRow}>
            {LOCATION_OPTIONS.map((opt) => {
              const selected = filters.indoorOutdoor.includes(opt.value);
              return (
                <TouchableOpacity
                  key={opt.value}
                  style={[styles.chip, selected && styles.chipActive]}
                  onPress={() =>
                    setFilters((f) => ({
                      ...f,
                      indoorOutdoor: toggleArrayItem(
                        f.indoorOutdoor,
                        opt.value,
                      ),
                    }))
                  }
                >
                  <Icon
                    name={opt.icon}
                    size={16}
                    color={
                      selected ? colors.textOnPrimary : colors.textSecondary
                    }
                  />
                  <Text
                    style={[styles.chipText, selected && styles.chipTextActive]}
                  >
                    {lang === "tr" ? opt.label_tr : opt.label_en}
                  </Text>
                </TouchableOpacity>
              );
            })}
          </View>
        </View>

        {/* Season */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>🗓️ {t("filterModal.season")}</Text>
          <View style={styles.chipRow}>
            {SEASON_OPTIONS.map((opt) => {
              const selected = filters.seasons.includes(opt.value);
              return (
                <TouchableOpacity
                  key={opt.value}
                  style={[styles.chip, selected && styles.chipActive]}
                  onPress={() =>
                    setFilters((f) => ({
                      ...f,
                      seasons: toggleArrayItem(f.seasons, opt.value),
                    }))
                  }
                >
                  <Text
                    style={[styles.chipText, selected && styles.chipTextActive]}
                  >
                    {opt.emoji} {lang === "tr" ? opt.label_tr : opt.label_en}
                  </Text>
                </TouchableOpacity>
              );
            })}
          </View>
        </View>

        {/* Prep Time */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>
            ⏱️ {t("filterModal.preparationTime")}
          </Text>
          <View style={styles.chipRow}>
            <TouchableOpacity
              style={[styles.chip, isPrepSelected(0, 30) && styles.chipActive]}
              onPress={() => setFilters((f) => ({ ...f, prepDays: [0, 30] }))}
            >
              <Text
                style={[
                  styles.chipText,
                  isPrepSelected(0, 30) && styles.chipTextActive,
                ]}
              >
                {t("filterModal.all")}
              </Text>
            </TouchableOpacity>
            {PREP_PRESETS.map((preset) => (
              <TouchableOpacity
                key={preset.min}
                style={[
                  styles.chip,
                  isPrepSelected(preset.min, preset.max) && styles.chipActive,
                ]}
                onPress={() =>
                  setFilters((f) => ({
                    ...f,
                    prepDays: [preset.min, preset.max],
                  }))
                }
              >
                <Text
                  style={[
                    styles.chipText,
                    isPrepSelected(preset.min, preset.max) &&
                      styles.chipTextActive,
                  ]}
                >
                  {preset.emoji}{" "}
                  {lang === "tr" ? preset.label_tr : preset.label_en}
                </Text>
              </TouchableOpacity>
            ))}
          </View>
        </View>

        {/* Premium Only */}
        <View style={styles.section}>
          <TouchableOpacity
            style={styles.premiumRow}
            onPress={() =>
              setFilters((f) => ({
                ...f,
                showPremiumOnly: !f.showPremiumOnly,
              }))
            }
          >
            <View style={styles.premiumLeft}>
              <Icon name="crown" size={20} color={colors.accent} />
              <Text style={styles.premiumLabel}>
                {t("filterModal.premiumOnly")}
              </Text>
            </View>
            <View
              style={[
                styles.toggle,
                filters.showPremiumOnly && styles.toggleActive,
              ]}
            >
              <View
                style={[
                  styles.toggleCircle,
                  filters.showPremiumOnly && styles.toggleCircleActive,
                ]}
              />
            </View>
          </TouchableOpacity>
        </View>

        <View style={{ height: 100 }} />
      </ScrollView>

      {/* Apply Button */}
      <View style={styles.footer}>
        <TouchableOpacity
          style={styles.applyButton}
          onPress={() => onApply(filters)}
          accessibilityRole="button"
        >
          <Text style={styles.applyButtonText}>
            {activeFilterCount() > 0
              ? t("filterModal.applyWithCount", {
                  count: activeFilterCount(),
                })
              : t("filterModal.apply")}
          </Text>
        </TouchableOpacity>
      </View>
    </Modal>
  );
}

const createStyles = (
  colors: ReturnType<
    typeof import("../../contexts/ThemeContext").useTheme
  >["colors"],
) =>
  StyleSheet.create({
    header: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "space-between",
      paddingBottom: Spacing.md,
      borderBottomWidth: 1,
      borderBottomColor: colors.border,
      marginBottom: Spacing.md,
    },
    closeBtn: {
      padding: Spacing.xs,
    },
    headerTitle: {
      ...Typography.h4,
      color: colors.text,
    },
    resetText: {
      ...Typography.bodySmall,
      color: colors.primary,
      fontWeight: "600",
    },
    content: {
      flex: 1,
    },
    section: {
      paddingVertical: Spacing.md,
      borderBottomWidth: 1,
      borderBottomColor: colors.border,
    },
    sectionTitle: {
      ...Typography.body,
      fontWeight: "600",
      color: colors.text,
      marginBottom: Spacing.md,
    },
    chipRow: {
      flexDirection: "row",
      flexWrap: "wrap",
      gap: Spacing.sm,
    },
    chip: {
      flexDirection: "row",
      alignItems: "center",
      gap: 4,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm + 2,
      borderRadius: BorderRadius.full,
      backgroundColor: colors.surfaceVariant,
      borderWidth: 1,
      borderColor: colors.border,
    },
    chipActive: {
      backgroundColor: colors.primary,
      borderColor: colors.primary,
    },
    chipText: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
      fontWeight: "500",
    },
    chipTextActive: {
      color: colors.textOnPrimary,
    },
    premiumRow: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "space-between",
      paddingVertical: Spacing.sm,
    },
    premiumLeft: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
    },
    premiumLabel: {
      ...Typography.body,
      fontWeight: "600",
      color: colors.text,
    },
    toggle: {
      width: 48,
      height: 28,
      borderRadius: 14,
      backgroundColor: colors.surfaceVariant,
      padding: 2,
      justifyContent: "center",
    },
    toggleActive: {
      backgroundColor: colors.primary,
    },
    toggleCircle: {
      width: 24,
      height: 24,
      borderRadius: 12,
      backgroundColor: colors.background,
      ...Shadows.sm,
    },
    toggleCircleActive: {
      alignSelf: "flex-end",
    },
    footer: {
      paddingTop: Spacing.md,
      paddingBottom: Spacing.xl,
      borderTopWidth: 1,
      borderTopColor: colors.border,
      ...Shadows.md,
    },
    applyButton: {
      backgroundColor: colors.primary,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.lg,
      alignItems: "center",
    },
    applyButtonText: {
      ...Typography.button,
      color: colors.textOnPrimary,
    },
  });
