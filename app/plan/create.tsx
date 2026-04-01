import React, { useState, useMemo } from "react";
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  Platform,
  KeyboardAvoidingView,
  TouchableOpacity,
  Alert,
} from "react-native";
import { useLocalSearchParams, useRouter } from "expo-router";
import { useTranslation } from "react-i18next";
import DateTimePicker, {
  DateTimePickerEvent,
} from "@react-native-community/datetimepicker";
import { Icon } from "../../src/components/ui/Icon";
import type { IconName } from "../../src/constants/icons";
import { Spacing, Typography, BorderRadius } from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";
import { Button } from "../../src/components/ui/Button";
import { Input } from "../../src/components/ui/Input";
import { usePlanStore } from "../../src/stores/planStore";
import {
  hapticSuccess,
  hapticError,
  hapticLight,
} from "../../src/utils/haptics";
import { a11yButton, a11yHeader } from "../../src/utils/accessibility";
import { validateRequired, getMsg } from "../../src/utils/validation";
import { useToastContext } from "../../src/contexts/ToastContext";
import { ScreenErrorBoundary } from "../../src/components/common/ScreenErrorBoundary";

export default function CreatePlanScreen() {
  const { scenarioId } = useLocalSearchParams();
  const router = useRouter();
  const { t, i18n } = useTranslation("plans");
  const lang = i18n.language;
  const { createPlan } = usePlanStore();
  const { colors, isDark } = useTheme();
  const { showToast } = useToastContext();

  const [title, setTitle] = useState("");
  const [recipientName, setRecipientName] = useState("");
  const [eventDate, setEventDate] = useState<Date | null>(null);
  const [showDatePicker, setShowDatePicker] = useState(false);
  const [budget, setBudget] = useState("");
  const [guestCount, setGuestCount] = useState("");
  const [location, setLocation] = useState("");
  const [notes, setNotes] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);

  const [titleError, setTitleError] = useState<string | null>(null);
  const [budgetError, setBudgetError] = useState<string | null>(null);

  const handleTitleChange = (text: string) => {
    setTitle(text);
    if (titleError) setTitleError(null);
  };
  const handleBudgetChange = (text: string) => {
    setBudget(text);
    if (budgetError) setBudgetError(null);
  };

  const handleDateChange = (
    _event: DateTimePickerEvent,
    selectedDate?: Date,
  ) => {
    if (Platform.OS === "android") {
      setShowDatePicker(false);
    }
    if (selectedDate) {
      setEventDate(selectedDate);
      hapticLight();
    }
  };

  const formatDate = (date: Date) => {
    return date.toLocaleDateString(lang === "tr" ? "tr-TR" : "en-US", {
      year: "numeric",
      month: "long",
      day: "numeric",
    });
  };

  const handleCreate = async () => {
    const tErr = getMsg(
      validateRequired(title, { tr: "Sürpriz adı", en: "Surprise title" }),
      lang,
    );

    let bErr: string | null = null;
    if (budget.trim()) {
      const budgetNum = parseFloat(budget);
      if (isNaN(budgetNum) || budgetNum < 0) {
        bErr = t("planCreate.invalidBudget");
      }
    }

    setTitleError(tErr);
    setBudgetError(bErr);

    if (tErr || bErr) {
      hapticError();
      return;
    }

    setIsSubmitting(true);
    try {
      const plan = await createPlan({
        title: title || t("planCreate.defaultTitle"),
        scenario_id: (scenarioId as string) || undefined,
        event_date: eventDate
          ? eventDate.toISOString().split("T")[0]
          : undefined,
        recipient_name: recipientName || undefined,
        location_text: location || undefined,
        budget: budget ? parseFloat(budget) : undefined,
        guest_count: guestCount ? parseInt(guestCount, 10) : undefined,
        notes: notes || undefined,
        language: lang === "tr" || lang === "en" ? lang : "tr",
      });
      hapticSuccess();
      router.replace(`/plan/${plan.id}` as any);
    } catch (err) {
      hapticError();
      setIsSubmitting(false);
      const message = err instanceof Error ? err.message : JSON.stringify(err);
      if (__DEV__) {
        console.error("[CreatePlan] Failed:", JSON.stringify(err, null, 2));
      }
      showToast(t("planCreate.saveFailed"), "error");
    }
  };

  const styles = useMemo(() => createStyles(colors), [colors]);

  return (
    <ScreenErrorBoundary>
      <KeyboardAvoidingView
        style={styles.flex}
        behavior={Platform.OS === "ios" ? "padding" : "height"}
        keyboardVerticalOffset={Platform.OS === "ios" ? 90 : 0}
      >
        <ScrollView
          style={styles.container}
          showsVerticalScrollIndicator={false}
          keyboardShouldPersistTaps="handled"
          contentContainerStyle={{ paddingBottom: Spacing.xxl }}
        >
          <View style={styles.content}>
            <Text
              style={styles.header}
              maxFontSizeMultiplier={1.4}
              {...a11yHeader(t("create_plan"))}
            >
              {t("create_plan")}
            </Text>

            <Input
              label={t("planCreate.titleLabel")}
              placeholder={t("planCreate.titlePlaceholder")}
              value={title}
              onChangeText={handleTitleChange}
              error={titleError || undefined}
            />
            <Input
              label={t("recipient_name")}
              placeholder={t("planCreate.recipientPlaceholder")}
              value={recipientName}
              onChangeText={setRecipientName}
            />

            {/* Native Date Picker */}
            <View style={styles.dateSection}>
              <Text style={styles.dateLabel} maxFontSizeMultiplier={1.3}>
                {t("event_date")}
              </Text>
              <TouchableOpacity
                style={styles.dateButton}
                onPress={() => {
                  hapticLight();
                  setShowDatePicker(!showDatePicker);
                }}
                activeOpacity={0.7}
                {...a11yButton(t("planCreate.selectDateA11y"))}
              >
                <Icon name="calendar" size={22} color={colors.primary} />
                <Text
                  style={[
                    styles.dateButtonText,
                    !eventDate && { color: colors.textTertiary },
                  ]}
                  maxFontSizeMultiplier={1.2}
                >
                  {eventDate
                    ? formatDate(eventDate)
                    : t("planCreate.selectDatePlaceholder")}
                </Text>
                <Icon
                  name={
                    (showDatePicker ? "chevron-up" : "chevron-down") as IconName
                  }
                  size={20}
                  color={colors.textTertiary}
                />
              </TouchableOpacity>

              {showDatePicker && (
                <View style={styles.datePickerContainer}>
                  <DateTimePicker
                    value={eventDate || new Date()}
                    mode="date"
                    display={Platform.OS === "ios" ? "spinner" : "default"}
                    onChange={handleDateChange}
                    minimumDate={new Date()}
                    locale={lang === "tr" ? "tr" : "en"}
                    themeVariant={isDark ? "dark" : "light"}
                    style={Platform.OS === "ios" ? { height: 180 } : undefined}
                  />
                  {Platform.OS === "ios" && (
                    <TouchableOpacity
                      style={styles.dateDoneButton}
                      onPress={() => setShowDatePicker(false)}
                    >
                      <Text style={styles.dateDoneText}>
                        {t("planCreate.done")}
                      </Text>
                    </TouchableOpacity>
                  )}
                </View>
              )}
            </View>

            <Input
              label={t("budget") + " (TL)"}
              placeholder="1000"
              value={budget}
              onChangeText={handleBudgetChange}
              keyboardType="numeric"
              error={budgetError || undefined}
            />
            <Input
              label={t("guest_count")}
              placeholder="2"
              value={guestCount}
              onChangeText={setGuestCount}
              keyboardType="numeric"
            />
            <Input
              label={t("location")}
              placeholder={t("planCreate.locationPlaceholder")}
              value={location}
              onChangeText={setLocation}
            />
            <Input
              label={t("notes")}
              placeholder={t("planCreate.notesPlaceholder")}
              value={notes}
              onChangeText={setNotes}
              multiline
              numberOfLines={3}
            />

            <Button
              title={t("common:common.save")}
              onPress={handleCreate}
              fullWidth
              size="lg"
              disabled={isSubmitting}
              loading={isSubmitting}
              style={{ marginTop: Spacing.md }}
            />
          </View>
        </ScrollView>
      </KeyboardAvoidingView>
    </ScreenErrorBoundary>
  );
}

const createStyles = (
  colors: ReturnType<typeof import("../../src/constants/theme").getColors>,
) =>
  StyleSheet.create({
    flex: { flex: 1 },
    container: { flex: 1, backgroundColor: colors.background },
    content: { padding: Spacing.lg },
    header: { ...Typography.h2, color: colors.text, marginBottom: Spacing.lg },
    dateSection: { marginBottom: Spacing.md },
    dateLabel: {
      ...Typography.bodySmall,
      fontWeight: "600",
      color: colors.text,
      marginBottom: Spacing.xs,
    },
    dateButton: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      backgroundColor: colors.surfaceVariant,
      borderRadius: BorderRadius.md,
      padding: Spacing.md,
      borderWidth: 1,
      borderColor: colors.borderLight,
    },
    dateButtonText: { flex: 1, ...Typography.body, color: colors.text },
    datePickerContainer: {
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.md,
      marginTop: Spacing.xs,
      borderWidth: 1,
      borderColor: colors.borderLight,
      overflow: "hidden",
    },
    dateDoneButton: {
      alignItems: "center",
      paddingVertical: Spacing.sm,
      borderTopWidth: 1,
      borderTopColor: colors.borderLight,
    },
    dateDoneText: { ...Typography.button, color: colors.primary },
  });
