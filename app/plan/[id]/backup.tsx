import React, { useState, useCallback, useMemo, useEffect } from "react";
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  Alert,
  ActivityIndicator,
} from "react-native";
import Animated, { FadeInDown } from "react-native-reanimated";
import { useLocalSearchParams } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon } from "../../../src/components/ui/Icon";
import type { IconName } from "../../../src/constants/icons";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../../src/constants/theme";
import { useTheme } from "../../../src/contexts/ThemeContext";
import { usePlanStore } from "../../../src/stores/planStore";
import { supabase } from "../../../src/services/supabase";
import {
  getWeatherForecast,
  getWeatherAdvice,
} from "../../../src/services/weather";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";
import { EmptyState } from "../../../src/components/common/EmptyState";

interface TriggerCondition {
  id: string;
  label: string;
  labelTr: string;
  icon: string;
  isChecked: boolean;
}

interface BackupStep {
  order: number;
  title: string;
  description: string;
  time_needed: string;
}

interface BackupPlan {
  title: string;
  description: string;
  steps: BackupStep[];
  estimated_cost: number;
  advantages: string[];
}

const DEFAULT_TRIGGERS: TriggerCondition[] = [
  {
    id: "weather",
    label: "Bad weather",
    labelTr: "Kötü hava koşulları",
    icon: "weather-lightning-rainy",
    isChecked: false,
  },
  {
    id: "venue",
    label: "Venue unavailable",
    labelTr: "Mekân müsait değil",
    icon: "home-remove",
    isChecked: false,
  },
  {
    id: "person",
    label: "Key person can't attend",
    labelTr: "Önemli kişi katılmıyor",
    icon: "account-cancel",
    isChecked: false,
  },
  {
    id: "budget",
    label: "Budget exceeded",
    labelTr: "Bütçe aşıldı",
    icon: "cash-remove",
    isChecked: false,
  },
];

export default function BackupScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const { t, i18n } = useTranslation();
  const lang = i18n.language;
  const { colors } = useTheme();
  const { plans } = usePlanStore();
  const plan = plans.find((p) => p.id === id);

  const [triggers, setTriggers] =
    useState<TriggerCondition[]>(DEFAULT_TRIGGERS);
  const [backupPlan, setBackupPlan] = useState<BackupPlan | null>(null);
  const [isGenerating, setIsGenerating] = useState(false);
  const [isActivated, setIsActivated] = useState(false);
  const [weatherWarning, setWeatherWarning] = useState<string | null>(null);

  // Auto-check weather on mount if event is within the next 3 days
  useEffect(() => {
    const checkWeather = async () => {
      if (!plan?.event_date || !plan.location_text) return;

      const eventDate = new Date(plan.event_date);
      const now = new Date();
      const diffMs = eventDate.getTime() - now.getTime();
      const diffDays = diffMs / (1000 * 60 * 60 * 24);
      if (diffDays < 0 || diffDays > 3) return;

      try {
        // Geocode the location text using Open-Meteo geocoding API (no key required)
        const geoUrl = `https://geocoding-api.open-meteo.com/v1/search?name=${encodeURIComponent(plan.location_text)}&count=1&language=en&format=json`;
        const geoRes = await fetch(geoUrl);
        if (!geoRes.ok) return;
        const geoData = await geoRes.json();
        const geoResult = geoData?.results?.[0];
        if (!geoResult) return;

        const dateStr = plan.event_date.split("T")[0];
        const forecast = await getWeatherForecast(
          geoResult.latitude,
          geoResult.longitude,
          dateStr,
        );
        if (!forecast) return;

        const advice = getWeatherAdvice(forecast);
        const condDesc = forecast.condition.toLowerCase();
        const isBad =
          !advice.is_outdoor_friendly ||
          condDesc.includes("rain") ||
          condDesc.includes("storm") ||
          condDesc.includes("snow") ||
          condDesc.includes("thunder") ||
          condDesc.includes("drizzle") ||
          forecast.condition_code >= 51;

        if (isBad) {
          const icon = forecast.icon;
          setWeatherWarning(
            `${icon} ${forecast.condition} — ${forecast.rain_probability}% rain probability, ${forecast.temperature_max}°C`,
          );
        }
      } catch {
        // Silent fail — weather check is best-effort
      }
    };

    checkWeather();
  }, [plan?.event_date, plan?.location_text]);

  const checkedTriggers = triggers.filter((t) => t.isChecked);

  const handleToggleTrigger = useCallback((triggerId: string) => {
    setTriggers((prev) =>
      prev.map((t) =>
        t.id === triggerId ? { ...t, isChecked: !t.isChecked } : t,
      ),
    );
  }, []);

  const handleGenerateBackup = useCallback(async () => {
    if (checkedTriggers.length === 0) {
      Alert.alert(
        t("backup.select_conditions_title"),
        t("backup.select_conditions_desc"),
      );
      return;
    }
    if (!plan) {
      Alert.alert(t("backup.error_title"), t("backup.plan_not_found"));
      return;
    }
    setIsGenerating(true);
    try {
      const { data, error } = await supabase.functions.invoke("ai-backup", {
        body: {
          title: plan.title,
          description: plan.notes || "",
          event_date: plan.event_date || "",
          category:
            lang === "tr"
              ? plan.scenario?.category?.name_tr || ""
              : plan.scenario?.category?.name_en || "",
          budget: plan.budget || 0,
          guest_count: plan.guest_count || 0,
          venue: plan.location_text || "",
          trigger_conditions: checkedTriggers.map((t) =>
            lang === "tr" ? t.labelTr : t.label,
          ),
          language: lang,
        },
      });
      if (error) throw error;
      const backup = data?.backup_plan;
      if (!backup) throw new Error(t("backup.invalid_response"));
      setBackupPlan(backup);
    } catch (err) {
      const message = err instanceof Error ? err.message : String(err);
      Alert.alert(
        t("backup.error_title"),
        t("backup.generate_failed", { message }),
      );
    } finally {
      setIsGenerating(false);
    }
  }, [checkedTriggers, lang, plan]);

  const handleActivatePlanB = useCallback(() => {
    Alert.alert(t("backup.activate_title"), t("backup.activate_confirm"), [
      { text: t("common.cancel"), style: "cancel" },
      {
        text: t("backup.activate"),
        style: "destructive",
        onPress: () => setIsActivated(true),
      },
    ]);
  }, [t]);

  const styles = useMemo(() => createStyles(colors), [colors]);

  return (
    <ScreenErrorBoundary>
      <ScrollView
        style={styles.container}
        contentContainerStyle={styles.content}
        showsVerticalScrollIndicator={false}
      >
        {/* Header */}
        <View style={styles.header}>
          <View style={styles.headerRow}>
            <Text style={[styles.headerTitle, { color: colors.text }]}>
              {t("backup.title")}
            </Text>
            {isActivated && (
              <View
                style={[styles.activeBadge, { backgroundColor: colors.error }]}
              >
                <Text style={styles.activeBadgeText}>
                  {t("backup.active_badge")}
                </Text>
              </View>
            )}
          </View>
        </View>

        {/* Weather Warning Banner */}
        {weatherWarning && (
          <Animated.View
            entering={FadeInDown.duration(300)}
            style={[
              styles.weatherWarning,
              {
                backgroundColor: colors.warning + "15",
                borderColor: colors.warning + "40",
              },
            ]}
          >
            <Icon
              name="weather-lightning-rainy"
              size={20}
              color={colors.warning}
            />
            <View style={styles.weatherWarningContent}>
              <Text
                style={[styles.weatherWarningTitle, { color: colors.warning }]}
              >
                {t("backup.weather_warning_title")}
              </Text>
              <Text
                style={[
                  styles.weatherWarningDesc,
                  { color: colors.textSecondary },
                ]}
              >
                {weatherWarning}
              </Text>
              <Text
                style={[styles.weatherWarningCta, { color: colors.warning }]}
              >
                {t("backup.weather_warning_cta")}
              </Text>
            </View>
          </Animated.View>
        )}

        {/* Generate AI Button */}
        <TouchableOpacity
          style={[
            styles.aiButton,
            {
              backgroundColor: colors.accent + "15",
              borderColor: colors.accent,
            },
          ]}
          onPress={handleGenerateBackup}
          disabled={isGenerating}
          activeOpacity={0.7}
        >
          {isGenerating ? (
            <ActivityIndicator size="small" color={colors.accent} />
          ) : (
            <Icon name="shield-refresh" size={22} color={colors.accent} />
          )}
          <Text style={[styles.aiButtonText, { color: colors.accent }]}>
            {isGenerating
              ? t("backup.generating")
              : t("backup.generate_button")}
          </Text>
        </TouchableOpacity>

        {/* Trigger Conditions */}
        <View style={styles.section}>
          <Text style={[styles.sectionTitle, { color: colors.text }]}>
            {t("backup.trigger_conditions_title")}
          </Text>
          <Text style={[styles.sectionDesc, { color: colors.textSecondary }]}>
            {t("backup.trigger_conditions_desc")}
          </Text>
          {triggers.map((trigger) => (
            <TouchableOpacity
              key={trigger.id}
              style={[
                styles.triggerCard,
                {
                  backgroundColor: trigger.isChecked
                    ? colors.warning + "10"
                    : colors.surface,
                  borderColor: trigger.isChecked
                    ? colors.warning + "40"
                    : colors.borderLight,
                },
              ]}
              onPress={() => handleToggleTrigger(trigger.id)}
              activeOpacity={0.7}
            >
              <Icon
                name={
                  trigger.isChecked
                    ? "checkbox-marked"
                    : "checkbox-blank-outline"
                }
                size={24}
                color={trigger.isChecked ? colors.warning : colors.textTertiary}
              />
              <Icon
                name={trigger.icon as IconName}
                size={22}
                color={
                  trigger.isChecked ? colors.warning : colors.textSecondary
                }
              />
              <Text
                style={[
                  styles.triggerLabel,
                  {
                    color: trigger.isChecked
                      ? colors.text
                      : colors.textSecondary,
                  },
                ]}
              >
                {t(`backup.trigger_${trigger.id}`)}
              </Text>
            </TouchableOpacity>
          ))}
        </View>

        {/* Backup Plan Details */}
        {backupPlan ? (
          <View style={styles.section}>
            <Text style={[styles.sectionTitle, { color: colors.text }]}>
              {t("backup.alternative_plan")}
            </Text>

            {/* Title & Description */}
            <View
              style={[styles.planCard, { backgroundColor: colors.surface }]}
            >
              <View style={styles.planRow}>
                <Icon name="shield-check" size={20} color={colors.primary} />
                <View style={styles.planContent}>
                  <Text
                    style={[styles.planLabel, { color: colors.textSecondary }]}
                  >
                    {t("backup.plan_b_title_label")}
                  </Text>
                  <Text
                    style={[
                      styles.planText,
                      { color: colors.text, fontWeight: "600" },
                    ]}
                  >
                    {backupPlan.title}
                  </Text>
                  {!!backupPlan.description && (
                    <Text
                      style={[
                        styles.planText,
                        { color: colors.textSecondary, marginTop: Spacing.xs },
                      ]}
                    >
                      {backupPlan.description}
                    </Text>
                  )}
                </View>
              </View>
            </View>

            {/* Steps */}
            {backupPlan.steps?.length > 0 && (
              <View
                style={[styles.planCard, { backgroundColor: colors.surface }]}
              >
                <View style={styles.planRow}>
                  <Icon
                    name="format-list-checks"
                    size={20}
                    color={colors.info}
                  />
                  <View style={styles.planContent}>
                    <Text
                      style={[
                        styles.planLabel,
                        { color: colors.textSecondary },
                      ]}
                    >
                      {t("backup.action_steps")}
                    </Text>
                    {backupPlan.steps.map((step) => (
                      <View key={step.order} style={styles.stepRow}>
                        <View
                          style={[
                            styles.stepBadge,
                            { backgroundColor: colors.info + "20" },
                          ]}
                        >
                          <Text
                            style={[
                              styles.stepBadgeText,
                              { color: colors.info },
                            ]}
                          >
                            {step.order}
                          </Text>
                        </View>
                        <View style={styles.stepContent}>
                          <Text
                            style={[styles.stepTitle, { color: colors.text }]}
                          >
                            {step.title}
                          </Text>
                          {!!step.description && (
                            <Text
                              style={[
                                styles.planText,
                                { color: colors.textSecondary },
                              ]}
                            >
                              {step.description}
                            </Text>
                          )}
                          {!!step.time_needed && (
                            <Text
                              style={[
                                styles.stepTime,
                                { color: colors.textTertiary },
                              ]}
                            >
                              {step.time_needed}
                            </Text>
                          )}
                        </View>
                      </View>
                    ))}
                  </View>
                </View>
              </View>
            )}

            {/* Estimated Cost */}
            {backupPlan.estimated_cost > 0 && (
              <View
                style={[styles.planCard, { backgroundColor: colors.surface }]}
              >
                <View style={styles.planRow}>
                  <Icon name="cash" size={20} color={colors.success} />
                  <View style={styles.planContent}>
                    <Text
                      style={[
                        styles.planLabel,
                        { color: colors.textSecondary },
                      ]}
                    >
                      {t("backup.estimated_cost")}
                    </Text>
                    <Text style={[styles.planText, { color: colors.text }]}>
                      {backupPlan.estimated_cost.toLocaleString(
                        lang === "tr" ? "tr-TR" : "en-US",
                      )}
                      {lang === "tr" ? " ₺" : " $"}
                    </Text>
                  </View>
                </View>
              </View>
            )}

            {/* Advantages */}
            {backupPlan.advantages?.length > 0 && (
              <View
                style={[styles.planCard, { backgroundColor: colors.surface }]}
              >
                <View style={styles.planRow}>
                  <Icon name="star-circle" size={20} color={colors.warning} />
                  <View style={styles.planContent}>
                    <Text
                      style={[
                        styles.planLabel,
                        { color: colors.textSecondary },
                      ]}
                    >
                      {t("backup.advantages")}
                    </Text>
                    {backupPlan.advantages.map((adv, idx) => (
                      <View key={idx} style={styles.advantageRow}>
                        <Icon
                          name="check-circle"
                          size={14}
                          color={colors.success}
                        />
                        <Text
                          style={[
                            styles.planText,
                            { color: colors.text, flex: 1 },
                          ]}
                        >
                          {adv}
                        </Text>
                      </View>
                    ))}
                  </View>
                </View>
              </View>
            )}

            {/* Quick Comparison */}
            <View
              style={[
                styles.comparisonCard,
                { backgroundColor: colors.surfaceVariant },
              ]}
            >
              <Text style={[styles.comparisonTitle, { color: colors.text }]}>
                {t("backup.quick_comparison")}
              </Text>
              <View style={styles.comparisonRow}>
                <View style={styles.comparisonCol}>
                  <Text
                    style={[styles.comparisonLabel, { color: colors.success }]}
                  >
                    {"Plan A"}
                  </Text>
                  <Text
                    style={[
                      styles.comparisonItem,
                      { color: colors.textSecondary },
                    ]}
                  >
                    {t("backup.outdoor_venue")}
                  </Text>
                  <Text
                    style={[
                      styles.comparisonItem,
                      { color: colors.textSecondary },
                    ]}
                  >
                    {t("backup.original_decorations")}
                  </Text>
                </View>
                <View
                  style={[
                    styles.comparisonDivider,
                    { backgroundColor: colors.border },
                  ]}
                />
                <View style={styles.comparisonCol}>
                  <Text
                    style={[styles.comparisonLabel, { color: colors.warning }]}
                  >
                    {"Plan B"}
                  </Text>
                  <Text
                    style={[
                      styles.comparisonItem,
                      { color: colors.textSecondary },
                    ]}
                  >
                    {t("backup.indoor_venue")}
                  </Text>
                  <Text
                    style={[
                      styles.comparisonItem,
                      { color: colors.textSecondary },
                    ]}
                  >
                    {t("backup.portable_decorations")}
                  </Text>
                </View>
              </View>
            </View>

            {/* Activate Button */}
            {!isActivated ? (
              <TouchableOpacity
                style={[
                  styles.activateButton,
                  { backgroundColor: colors.error },
                ]}
                onPress={handleActivatePlanB}
                activeOpacity={0.8}
              >
                <Icon name="shield-alert" size={22} color="#FFF" />
                <Text style={styles.activateButtonText}>
                  {t("backup.activate_plan_b")}
                </Text>
              </TouchableOpacity>
            ) : (
              <View
                style={[
                  styles.activatedBanner,
                  {
                    backgroundColor: colors.error + "12",
                    borderColor: colors.error + "30",
                  },
                ]}
              >
                <Icon name="shield-check" size={22} color={colors.error} />
                <Text style={[styles.activatedText, { color: colors.error }]}>
                  {t("backup.activated_message")}
                </Text>
              </View>
            )}
          </View>
        ) : (
          <EmptyState
            emoji="🛡️"
            title={t("backup.empty_title")}
            description={t("backup.empty_desc")}
            compact
          />
        )}
      </ScrollView>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: { flex: 1, backgroundColor: colors.background },
    content: { paddingBottom: Spacing.xxl },
    header: { padding: Spacing.lg },
    headerRow: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "space-between",
    },
    headerTitle: { ...Typography.h3 },
    activeBadge: {
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.xs,
      borderRadius: BorderRadius.full,
    },
    activeBadgeText: {
      ...Typography.caption,
      fontWeight: "700",
      color: "#FFF",
    },
    aiButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      marginHorizontal: Spacing.lg,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1.5,
    },
    aiButtonText: { ...Typography.button },
    section: { paddingHorizontal: Spacing.lg, marginTop: Spacing.xl },
    sectionTitle: { ...Typography.h4, marginBottom: Spacing.xs },
    sectionDesc: { ...Typography.bodySmall, marginBottom: Spacing.md },
    triggerCard: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      padding: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1,
      marginBottom: Spacing.sm,
    },
    triggerLabel: { ...Typography.body, flex: 1 },
    planCard: {
      padding: Spacing.md,
      borderRadius: BorderRadius.lg,
      marginBottom: Spacing.md,
      ...Shadows.sm,
    },
    planRow: { flexDirection: "row", gap: Spacing.sm },
    planContent: { flex: 1 },
    planLabel: {
      ...Typography.caption,
      fontWeight: "600",
      marginBottom: Spacing.xs,
    },
    planText: { ...Typography.bodySmall, lineHeight: 22 },
    comparisonCard: {
      padding: Spacing.md,
      borderRadius: BorderRadius.lg,
      marginBottom: Spacing.lg,
    },
    comparisonTitle: {
      ...Typography.bodySmall,
      fontWeight: "600",
      marginBottom: Spacing.md,
      textAlign: "center",
    },
    comparisonRow: { flexDirection: "row" },
    comparisonCol: { flex: 1, alignItems: "center", gap: Spacing.xs },
    comparisonDivider: { width: 1, alignSelf: "stretch" },
    comparisonLabel: {
      ...Typography.bodySmall,
      fontWeight: "700",
      marginBottom: Spacing.xs,
    },
    comparisonItem: { ...Typography.caption, textAlign: "center" },
    activateButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
    },
    activateButtonText: { ...Typography.button, color: "#FFF" },
    activatedBanner: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      padding: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1,
    },
    activatedText: { ...Typography.bodySmall, fontWeight: "500", flex: 1 },
    stepRow: {
      flexDirection: "row",
      gap: Spacing.sm,
      marginBottom: Spacing.sm,
      alignItems: "flex-start",
    },
    stepBadge: {
      width: 24,
      height: 24,
      borderRadius: 12,
      alignItems: "center",
      justifyContent: "center",
      marginTop: 2,
    },
    stepBadgeText: { ...Typography.caption, fontWeight: "700", fontSize: 11 },
    stepContent: { flex: 1 },
    stepTitle: { ...Typography.bodySmall, fontWeight: "600", marginBottom: 2 },
    stepTime: { ...Typography.caption, marginTop: 2 },
    advantageRow: {
      flexDirection: "row",
      gap: Spacing.xs,
      marginBottom: 4,
      alignItems: "flex-start",
    },
    weatherWarning: {
      flexDirection: "row",
      alignItems: "flex-start",
      gap: Spacing.sm,
      marginHorizontal: Spacing.lg,
      marginBottom: Spacing.md,
      padding: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1,
    },
    weatherWarningContent: { flex: 1 },
    weatherWarningTitle: {
      ...Typography.bodySmall,
      fontWeight: "700",
      marginBottom: 2,
    },
    weatherWarningDesc: { ...Typography.caption, marginBottom: 2 },
    weatherWarningCta: { ...Typography.caption, fontWeight: "600" },
  });
