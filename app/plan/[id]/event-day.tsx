import React, { useState, useMemo, useEffect, useCallback } from "react";
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  Alert,
  Modal,
  TextInput,
  KeyboardAvoidingView,
  Platform,
  ActivityIndicator,
} from "react-native";
import { useLocalSearchParams, useRouter } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon } from "../../../src/components/ui/Icon";
import Animated, { FadeInDown } from "react-native-reanimated";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../../src/constants/theme";
import { useTheme } from "../../../src/contexts/ThemeContext";
import { usePlanStore } from "../../../src/stores/planStore";
import { useCoOrganizerStore } from "../../../src/stores/coOrganizerStore";
import type { ChecklistItem } from "../../../src/types/database";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";

// ─────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────

function getCountdown(
  eventDate: string | null,
  eventTime: string | null,
): {
  isToday: boolean;
  isPast: boolean;
  hours: number;
  minutes: number;
} {
  if (!eventDate) {
    return { isToday: false, isPast: false, hours: 0, minutes: 0 };
  }

  const today = new Date();
  const todayStr = today.toISOString().slice(0, 10);
  const isToday = eventDate === todayStr;

  const timePart = eventTime || "00:00:00";
  const eventDateTime = new Date(`${eventDate}T${timePart}`);
  const diff = eventDateTime.getTime() - today.getTime();
  const isPast = diff <= 0;

  const totalMinutes = Math.max(0, Math.floor(diff / 60000));
  const hours = Math.floor(totalMinutes / 60);
  const minutes = totalMinutes % 60;

  return { isToday, isPast, hours, minutes };
}

function isTodayDate(dateStr: string | null): boolean {
  if (!dateStr) return false;
  const today = new Date().toISOString().slice(0, 10);
  return dateStr === today;
}

// ─────────────────────────────────────────────────────────
// Component
// ─────────────────────────────────────────────────────────

export default function EventDayScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const router = useRouter();
  const { t } = useTranslation();
  const { colors } = useTheme();
  const { plans, activePlan, toggleChecklistItem } = usePlanStore();
  const { sendMessage } = useCoOrganizerStore();

  // Prefer activePlan if it matches, otherwise search plans array
  const plan =
    (activePlan?.id === id ? activePlan : plans.find((p) => p.id === id)) ??
    null;

  const [countdown, setCountdown] = useState(() =>
    getCountdown(plan?.event_date ?? null, plan?.event_time ?? null),
  );
  const [showBroadcastModal, setShowBroadcastModal] = useState(false);
  const [broadcastText, setBroadcastText] = useState("");
  const [isSending, setIsSending] = useState(false);

  // Live countdown ticker
  useEffect(() => {
    const tick = () => {
      setCountdown(
        getCountdown(plan?.event_date ?? null, plan?.event_time ?? null),
      );
    };
    tick();
    const interval = setInterval(tick, 30000); // refresh every 30 s
    return () => clearInterval(interval);
  }, [plan?.event_date, plan?.event_time]);

  // Today's checklist items: items whose due_date is today OR incomplete items with no due_date
  const todayChecklist: ChecklistItem[] = useMemo(() => {
    if (!plan?.checklist) return [];
    return plan.checklist.filter((item) => {
      if (item.is_completed) return false;
      if (item.due_date) return isTodayDate(item.due_date);
      return true; // show all incomplete items without a due_date
    });
  }, [plan?.checklist]);

  const handleToggle = useCallback(
    (itemId: string, current: boolean) => {
      if (!plan) return;
      toggleChecklistItem(plan.id, itemId, !current).catch(() => {});
    },
    [plan, toggleChecklistItem],
  );

  const handleSendBroadcast = useCallback(
    async (message: string) => {
      if (!message.trim() || !id) return;
      setIsSending(true);
      try {
        await sendMessage(id, message.trim());
        setShowBroadcastModal(false);
        setBroadcastText("");
        Alert.alert(t("eventDay.messageSent"), t("eventDay.broadcastSentDesc"));
      } catch {
        Alert.alert(t("common.error"), t("eventDay.broadcastFailed"));
      } finally {
        setIsSending(false);
      }
    },
    [id, sendMessage, t],
  );

  const handleBroadcast = useCallback(() => {
    if (Platform.OS === "ios" && typeof Alert.prompt === "function") {
      Alert.prompt(
        t("eventDay.broadcastTitle"),
        t("eventDay.broadcastPrompt"),
        [
          { text: t("common.cancel"), style: "cancel" },
          {
            text: t("common.send"),
            onPress: (message?: string) => {
              if (message) handleSendBroadcast(message);
            },
          },
        ],
        "plain-text",
      );
    } else {
      setShowBroadcastModal(true);
    }
  }, [t, handleSendBroadcast]);

  const styles = useMemo(() => createStyles(colors), [colors]);

  if (!plan) {
    return (
      <View style={[styles.container, styles.center]}>
        <Text style={[styles.notFoundText, { color: colors.textSecondary }]}>
          {t("eventDay.notFound")}
        </Text>
      </View>
    );
  }

  const completedCount =
    plan.checklist?.filter((i) => i.is_completed).length ?? 0;
  const totalCount = plan.checklist?.length ?? 0;
  const progressPct =
    totalCount > 0 ? Math.round((completedCount / totalCount) * 100) : 0;

  return (
    <ScreenErrorBoundary>
      <ScrollView
        style={styles.container}
        contentContainerStyle={styles.content}
        showsVerticalScrollIndicator={false}
      >
        {/* ── Header ── */}
        <Animated.View
          entering={FadeInDown.delay(0).duration(500)}
          style={styles.header}
        >
          <Text style={[styles.headerTitle, { color: colors.text }]}>
            {t("eventDay.title")}
          </Text>
          <Text
            style={[styles.planName, { color: colors.textSecondary }]}
            numberOfLines={1}
          >
            {plan.title}
          </Text>
        </Animated.View>

        {/* ── Big Countdown ── */}
        <Animated.View entering={FadeInDown.delay(80).duration(500)}>
          <View
            style={[
              styles.countdownCard,
              {
                backgroundColor: colors.primary + "12",
                borderColor: colors.primary + "30",
              },
            ]}
          >
            <Icon name="clock-fast" size={32} color={colors.primary} />
            {countdown.isToday && !countdown.isPast ? (
              <>
                <Text style={[styles.countdownBig, { color: colors.primary }]}>
                  {String(countdown.hours).padStart(2, "0")}:
                  {String(countdown.minutes).padStart(2, "0")}
                </Text>
                <Text
                  style={[
                    styles.countdownLabel,
                    { color: colors.textSecondary },
                  ]}
                >
                  {t("eventDay.countdownLabel")}
                </Text>
              </>
            ) : countdown.isPast ? (
              <>
                <Text
                  style={[styles.countdownBigAlt, { color: colors.success }]}
                >
                  {t("eventDay.started")}
                </Text>
                <Text
                  style={[
                    styles.countdownLabel,
                    { color: colors.textSecondary },
                  ]}
                >
                  {t("eventDay.startedDesc")}
                </Text>
              </>
            ) : (
              <>
                <Text
                  style={[styles.countdownBigAlt, { color: colors.primary }]}
                >
                  {t("eventDay.today")}
                </Text>
                <Text
                  style={[
                    styles.countdownLabel,
                    { color: colors.textSecondary },
                  ]}
                >
                  {plan.event_date || ""}
                </Text>
              </>
            )}

            {/* Progress bar */}
            {totalCount > 0 && (
              <View style={styles.progressContainer}>
                <View
                  style={[
                    styles.progressTrack,
                    { backgroundColor: colors.borderLight },
                  ]}
                >
                  <View
                    style={[
                      styles.progressFill,
                      {
                        backgroundColor: colors.primary,
                        width: `${progressPct}%`,
                      },
                    ]}
                  />
                </View>
                <Text
                  style={[styles.progressLabel, { color: colors.textTertiary }]}
                >
                  {t("eventDay.taskProgress", {
                    completed: completedCount,
                    total: totalCount,
                  })}
                </Text>
              </View>
            )}
          </View>
        </Animated.View>

        {/* ── Today's Checklist ── */}
        <Animated.View
          entering={FadeInDown.delay(160).duration(500)}
          style={styles.section}
        >
          <View style={styles.sectionHeader}>
            <Icon
              name="checkbox-multiple-marked-outline"
              size={20}
              color={colors.info}
            />
            <Text style={[styles.sectionTitle, { color: colors.text }]}>
              {t("eventDay.todayTasks")}
            </Text>
          </View>

          {todayChecklist.length === 0 ? (
            <View
              style={[
                styles.emptyCard,
                {
                  backgroundColor: colors.surface,
                  borderColor: colors.borderLight,
                },
              ]}
            >
              <Icon name="check-all" size={28} color={colors.success} />
              <Text
                style={[styles.emptyCardText, { color: colors.textSecondary }]}
              >
                {t("eventDay.allCompleted")}
              </Text>
            </View>
          ) : (
            todayChecklist.map((item, index) => (
              <Animated.View
                key={item.id}
                entering={FadeInDown.delay(200 + index * 60).duration(400)}
              >
                <TouchableOpacity
                  style={[
                    styles.checklistCard,
                    {
                      backgroundColor: item.is_completed
                        ? colors.success + "10"
                        : colors.surface,
                      borderColor: item.is_completed
                        ? colors.success + "30"
                        : colors.borderLight,
                    },
                  ]}
                  onPress={() => handleToggle(item.id, item.is_completed)}
                  activeOpacity={0.7}
                >
                  <Icon
                    name={
                      item.is_completed
                        ? "checkbox-marked-circle"
                        : "checkbox-blank-circle-outline"
                    }
                    size={24}
                    color={
                      item.is_completed ? colors.success : colors.textTertiary
                    }
                  />
                  <View style={styles.checklistContent}>
                    <Text
                      style={[
                        styles.checklistTitle,
                        {
                          color: item.is_completed
                            ? colors.textSecondary
                            : colors.text,
                          textDecorationLine: item.is_completed
                            ? "line-through"
                            : "none",
                        },
                      ]}
                    >
                      {item.title}
                    </Text>
                    {!!item.description && (
                      <Text
                        style={[
                          styles.checklistDesc,
                          { color: colors.textTertiary },
                        ]}
                        numberOfLines={1}
                      >
                        {item.description}
                      </Text>
                    )}
                    {!!item.due_date && (
                      <Text
                        style={[
                          styles.checklistDue,
                          { color: colors.textTertiary },
                        ]}
                      >
                        {item.due_date}
                      </Text>
                    )}
                  </View>
                </TouchableOpacity>
              </Animated.View>
            ))
          )}
        </Animated.View>

        {/* ── Co-organizer Broadcast ── */}
        <Animated.View
          entering={FadeInDown.delay(300).duration(500)}
          style={styles.section}
        >
          <View style={styles.sectionHeader}>
            <Icon name="account-multiple" size={20} color={colors.accent} />
            <Text style={[styles.sectionTitle, { color: colors.text }]}>
              {t("eventDay.organizers")}
            </Text>
          </View>
          <TouchableOpacity
            style={[
              styles.broadcastButton,
              {
                backgroundColor: colors.accent + "12",
                borderColor: colors.accent + "30",
              },
            ]}
            onPress={handleBroadcast}
            activeOpacity={0.7}
          >
            <Icon name="bullhorn" size={22} color={colors.accent} />
            <View style={styles.broadcastContent}>
              <Text style={[styles.broadcastTitle, { color: colors.text }]}>
                {t("eventDay.broadcastTitle")}
              </Text>
              <Text
                style={[styles.broadcastDesc, { color: colors.textSecondary }]}
              >
                {t("eventDay.broadcastDesc")}
              </Text>
            </View>
            <Icon name="chevron-right" size={20} color={colors.textTertiary} />
          </TouchableOpacity>
        </Animated.View>

        {/* ── Weather Check ── */}
        <Animated.View
          entering={FadeInDown.delay(380).duration(500)}
          style={styles.section}
        >
          <View style={styles.sectionHeader}>
            <Icon name="weather-partly-cloudy" size={20} color={colors.info} />
            <Text style={[styles.sectionTitle, { color: colors.text }]}>
              {t("eventDay.weather")}
            </Text>
          </View>
          <TouchableOpacity
            style={[
              styles.featureCard,
              {
                backgroundColor: colors.surface,
                borderColor: colors.borderLight,
              },
            ]}
            onPress={() => router.push(`/plan/${id}/weather`)}
            activeOpacity={0.7}
          >
            <View
              style={[
                styles.featureIconBox,
                { backgroundColor: colors.info + "15" },
              ]}
            >
              <Icon name="weather-sunny" size={28} color={colors.info} />
            </View>
            <View style={styles.featureCardContent}>
              <Text style={[styles.featureCardTitle, { color: colors.text }]}>
                {t("eventDay.checkWeather")}
              </Text>
              <Text
                style={[
                  styles.featureCardDesc,
                  { color: colors.textSecondary },
                ]}
              >
                {t("eventDay.forecastDay")}
              </Text>
            </View>
            <Icon name="chevron-right" size={20} color={colors.textTertiary} />
          </TouchableOpacity>
        </Animated.View>

        {/* ── Plan B Quick Access ── */}
        <Animated.View
          entering={FadeInDown.delay(460).duration(500)}
          style={styles.section}
        >
          <View style={styles.sectionHeader}>
            <Icon name="shield-check" size={20} color={colors.error} />
            <Text style={[styles.sectionTitle, { color: colors.text }]}>
              {t("eventDay.backupPlan")}
            </Text>
          </View>
          <TouchableOpacity
            style={[
              styles.featureCard,
              {
                backgroundColor: colors.surface,
                borderColor: colors.borderLight,
              },
            ]}
            onPress={() => router.push(`/plan/${id}/backup`)}
            activeOpacity={0.7}
          >
            <View
              style={[
                styles.featureIconBox,
                { backgroundColor: colors.error + "15" },
              ]}
            >
              <Icon name="shield-alert" size={28} color={colors.error} />
            </View>
            <View style={styles.featureCardContent}>
              <View style={styles.featureCardTitleRow}>
                <Text style={[styles.featureCardTitle, { color: colors.text }]}>
                  {t("eventDay.planBReady")}
                </Text>
                <View
                  style={[
                    styles.readyBadge,
                    { backgroundColor: colors.success + "20" },
                  ]}
                >
                  <Text
                    style={[styles.readyBadgeText, { color: colors.success }]}
                  >
                    {t("eventDay.ready")}
                  </Text>
                </View>
              </View>
              <Text
                style={[
                  styles.featureCardDesc,
                  { color: colors.textSecondary },
                ]}
              >
                {t("eventDay.planBDescription")}
              </Text>
            </View>
            <Icon name="chevron-right" size={20} color={colors.textTertiary} />
          </TouchableOpacity>
        </Animated.View>

        {/* ── Sürprizi Başlat ── */}
        <Animated.View
          entering={FadeInDown.delay(540).duration(500)}
          style={styles.revealSection}
        >
          <TouchableOpacity
            style={[styles.revealButton, { backgroundColor: colors.primary }]}
            onPress={() => router.push(`/plan/${id}/reveal`)}
            activeOpacity={0.85}
          >
            <Icon name="party-popper" size={28} color={colors.textOnPrimary} />
            <Text style={styles.revealButtonText}>
              {t("eventDay.startSurprise")}
            </Text>
            <Icon name="chevron-right" size={24} color={colors.textOnPrimary} />
          </TouchableOpacity>
          <Text style={[styles.revealHint, { color: colors.textTertiary }]}>
            {t("eventDay.startSurpriseHint")}
          </Text>
        </Animated.View>

        {/* ── Broadcast Modal (Android) ── */}
        <Modal
          visible={showBroadcastModal}
          transparent
          animationType="slide"
          onRequestClose={() => setShowBroadcastModal(false)}
        >
          <KeyboardAvoidingView
            behavior={Platform.OS === "ios" ? "padding" : "height"}
            style={styles.modalOverlay}
          >
            <View
              style={[styles.modalContent, { backgroundColor: colors.surface }]}
            >
              <View style={styles.modalHeader}>
                <Text style={[styles.modalTitle, { color: colors.text }]}>
                  {t("eventDay.broadcastTitle")}
                </Text>
                <TouchableOpacity onPress={() => setShowBroadcastModal(false)}>
                  <Icon name="close" size={24} color={colors.text} />
                </TouchableOpacity>
              </View>
              <Text style={[styles.modalDesc, { color: colors.textSecondary }]}>
                {t("eventDay.broadcastPrompt")}
              </Text>
              <TextInput
                style={[
                  styles.modalInput,
                  {
                    color: colors.text,
                    backgroundColor: colors.backgroundSecondary,
                    borderColor: colors.borderLight,
                  },
                ]}
                value={broadcastText}
                onChangeText={setBroadcastText}
                placeholder={t("eventDay.broadcastPlaceholder")}
                placeholderTextColor={colors.textTertiary}
                multiline
                maxLength={1000}
                autoFocus
              />
              <TouchableOpacity
                style={[
                  styles.modalSendButton,
                  {
                    backgroundColor:
                      broadcastText.trim() && !isSending
                        ? colors.primary
                        : colors.borderLight,
                  },
                ]}
                onPress={() => handleSendBroadcast(broadcastText)}
                disabled={!broadcastText.trim() || isSending}
              >
                {isSending ? (
                  <ActivityIndicator
                    size="small"
                    color={colors.textOnPrimary}
                  />
                ) : (
                  <Text
                    style={[
                      styles.modalSendText,
                      { color: colors.textOnPrimary },
                    ]}
                  >
                    {t("common.send")}
                  </Text>
                )}
              </TouchableOpacity>
            </View>
          </KeyboardAvoidingView>
        </Modal>
      </ScrollView>
    </ScreenErrorBoundary>
  );
}

// ─────────────────────────────────────────────────────────
// Styles
// ─────────────────────────────────────────────────────────

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },
    content: {
      paddingBottom: Spacing.xxl * 2,
    },
    center: {
      alignItems: "center",
      justifyContent: "center",
    },
    notFoundText: {
      ...Typography.body,
    },

    // Header
    header: {
      paddingHorizontal: Spacing.lg,
      paddingTop: Spacing.lg,
      paddingBottom: Spacing.md,
    },
    headerTitle: {
      ...Typography.h3,
      marginBottom: 2,
    },
    planName: {
      ...Typography.bodySmall,
    },

    // Countdown card
    countdownCard: {
      marginHorizontal: Spacing.lg,
      borderRadius: BorderRadius.xl,
      borderWidth: 1,
      padding: Spacing.xl,
      alignItems: "center",
      gap: Spacing.sm,
      ...Shadows.md,
    },
    countdownBig: {
      fontSize: 56,
      fontWeight: "700",
      letterSpacing: -2,
      lineHeight: 64,
    },
    countdownBigAlt: {
      ...Typography.h1,
      textAlign: "center",
    },
    countdownLabel: {
      ...Typography.bodySmall,
      textAlign: "center",
    },
    progressContainer: {
      width: "100%",
      marginTop: Spacing.md,
      gap: Spacing.xs,
    },
    progressTrack: {
      height: 6,
      borderRadius: 3,
      overflow: "hidden",
    },
    progressFill: {
      height: "100%",
      borderRadius: 3,
    },
    progressLabel: {
      ...Typography.caption,
      textAlign: "center",
    },

    // Section
    section: {
      paddingHorizontal: Spacing.lg,
      marginTop: Spacing.xl,
    },
    sectionHeader: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginBottom: Spacing.md,
    },
    sectionTitle: {
      ...Typography.h4,
    },

    // Empty card
    emptyCard: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.md,
      padding: Spacing.md,
      borderRadius: BorderRadius.lg,
      borderWidth: 1,
    },
    emptyCardText: {
      ...Typography.bodySmall,
    },

    // Checklist
    checklistCard: {
      flexDirection: "row",
      alignItems: "flex-start",
      gap: Spacing.sm,
      padding: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1,
      marginBottom: Spacing.sm,
      ...Shadows.sm,
    },
    checklistContent: {
      flex: 1,
    },
    checklistTitle: {
      ...Typography.body,
    },
    checklistDesc: {
      ...Typography.caption,
      marginTop: 2,
    },
    checklistDue: {
      ...Typography.caption,
      marginTop: 2,
    },

    // Broadcast button
    broadcastButton: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.md,
      padding: Spacing.md,
      borderRadius: BorderRadius.lg,
      borderWidth: 1,
      ...Shadows.sm,
    },
    broadcastContent: {
      flex: 1,
    },
    broadcastTitle: {
      ...Typography.bodySmall,
      fontWeight: "600",
    },
    broadcastDesc: {
      ...Typography.caption,
      marginTop: 2,
    },

    // Feature cards (weather, backup)
    featureCard: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.md,
      padding: Spacing.md,
      borderRadius: BorderRadius.lg,
      borderWidth: 1,
      ...Shadows.sm,
    },
    featureIconBox: {
      width: 52,
      height: 52,
      borderRadius: BorderRadius.md,
      alignItems: "center",
      justifyContent: "center",
    },
    featureCardContent: {
      flex: 1,
    },
    featureCardTitleRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
    },
    featureCardTitle: {
      ...Typography.bodySmall,
      fontWeight: "600",
    },
    featureCardDesc: {
      ...Typography.caption,
      marginTop: 2,
    },
    readyBadge: {
      paddingHorizontal: Spacing.sm,
      paddingVertical: 2,
      borderRadius: BorderRadius.full,
    },
    readyBadgeText: {
      ...Typography.caption,
      fontWeight: "700",
      fontSize: 10,
    },

    // Reveal button
    revealSection: {
      paddingHorizontal: Spacing.lg,
      marginTop: Spacing.xxl,
      alignItems: "center",
      gap: Spacing.md,
    },
    revealButton: {
      width: "100%",
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.md,
      paddingVertical: Spacing.lg,
      borderRadius: BorderRadius.xl,
      ...Shadows.lg,
    },
    revealButtonText: {
      ...Typography.h4,
      color: colors.textOnPrimary,
      flex: 1,
      textAlign: "center",
    },
    revealHint: {
      ...Typography.caption,
      textAlign: "center",
    },

    // Broadcast Modal
    modalOverlay: {
      flex: 1,
      backgroundColor: "rgba(0,0,0,0.5)",
      justifyContent: "flex-end",
    },
    modalContent: {
      borderTopLeftRadius: BorderRadius.xl,
      borderTopRightRadius: BorderRadius.xl,
      padding: Spacing.lg,
    },
    modalHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      marginBottom: Spacing.md,
    },
    modalTitle: {
      ...Typography.h4,
    },
    modalDesc: {
      ...Typography.bodySmall,
      marginBottom: Spacing.md,
    },
    modalInput: {
      ...Typography.body,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1,
      marginBottom: Spacing.md,
      minHeight: 80,
      textAlignVertical: "top",
    },
    modalSendButton: {
      alignItems: "center",
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
    },
    modalSendText: {
      ...Typography.button,
    },
  });
