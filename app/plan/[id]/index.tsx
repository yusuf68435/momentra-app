import React, { useMemo, useEffect, useState } from "react";
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  Linking,
  Platform,
  Dimensions,
} from "react-native";
import { LoadingScreen } from "../../../src/components/common/LoadingScreen";
import Animated, {
  FadeInUp,
  useSharedValue,
  useAnimatedStyle,
  withSpring,
} from "react-native-reanimated";
import { LinearGradient } from "expo-linear-gradient";
import { useLocalSearchParams, useRouter } from "expo-router";
import { useTranslation } from "react-i18next";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import { Icon } from "../../../src/components/ui/Icon";
import type { IconName } from "../../../src/constants/icons";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  Springs,
  FontFamily,
  type ThemeColors,
} from "../../../src/constants/theme";
import { useTheme } from "../../../src/contexts/ThemeContext";
import { Button } from "../../../src/components/ui/Button";
import { CountdownTimer } from "../../../src/components/plans/CountdownTimer";
import { SmartBanner } from "../../../src/components/plans/SmartBanner";
import { GettingStartedCard } from "../../../src/components/plans/GettingStartedCard";
import { usePlanStore } from "../../../src/stores/planStore";
import { staggerDelay } from "../../../src/utils/animations";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";

const { width: SCREEN_WIDTH } = Dimensions.get("window");
const HERO_HEIGHT = 180;

function getCategoryGradientColors(
  colors: ThemeColors,
): Record<string, [string, string]> {
  return {
    birthday: [colors.secondary, colors.featureMoodboard],
    anniversary: [colors.featureGifts, colors.featureVendors],
    proposal: [colors.featureMoodboard, colors.secondary],
    graduation: [colors.featureTimeline, colors.featureChat],
    holiday: [colors.featureWeather, colors.info],
    default: [colors.secondary, colors.featureTimeline],
  };
}

function getHeroGradient(
  scenario: ({ category_id?: string } | null) | undefined,
  colors: ThemeColors,
): [string, string] {
  const map = getCategoryGradientColors(colors);
  if (!scenario?.category_id) return map.default;
  return map[scenario.category_id] ?? map.default;
}

export default function PlanDetailScreen() {
  const { id } = useLocalSearchParams();
  const router = useRouter();
  const { t, i18n } = useTranslation("plans");
  const lang = i18n.language as "tr" | "en";
  const { colors, isDark } = useTheme();
  const { plans, loadPlanById, updatePlan } = usePlanStore();
  const [loading, setLoading] = useState(false);
  const [surpriseMode, setSurpriseMode] = useState(false);
  const [surpriseUpdating, setSurpriseUpdating] = useState(false);
  const insets = useSafeAreaInsets();

  const plan = plans.find((p) => p.id === id);

  useEffect(() => {
    if (!plan && id) {
      setLoading(true);
      loadPlanById(id as string).finally(() => setLoading(false));
    }
  }, [id]);

  // Sync surprise mode from plan data
  useEffect(() => {
    if (plan) {
      setSurpriseMode(
        (plan as unknown as Record<string, unknown>).surprise_protection ===
          true,
      );
    }
  }, [plan?.id]);

  const styles = useMemo(() => createStyles(colors), [colors]);

  if (loading) {
    return <LoadingScreen />;
  }

  if (!plan) {
    return (
      <View style={styles.container}>
        <Text style={styles.notFound}>{t("not_found")}</Text>
      </View>
    );
  }

  const openLocationInMaps = () => {
    if (!plan.location_text) return;
    const query = encodeURIComponent(plan.location_text);
    const url =
      Platform.OS === "ios" ? `maps:0,0?q=${query}` : `geo:0,0?q=${query}`;
    Linking.openURL(url).catch(() => {
      Linking.openURL(
        `https://www.google.com/maps/search/?api=1&query=${query}`,
      );
    });
  };

  const completedItems =
    plan.checklist?.filter((c) => c.is_completed).length || 0;
  const totalItems = plan.checklist?.length || 0;
  const progress = totalItems > 0 ? completedItems / totalItems : 0;
  const isNewPlan = progress === 0 && (plan.checklist?.length ?? 0) > 0;

  const isCompleted = plan.status === "completed";

  const heroGradient = getHeroGradient(plan.scenario, colors);

  // Uniform 3-column feature grid
  const features: {
    icon: string;
    label: string;
    color: string;
    route: string;
    locked?: boolean;
  }[] = [
    {
      icon: "timeline-clock",
      label: t("features.timeline"),
      color: colors.featureTimeline,
      route: `/plan/${id}/timeline`,
    },
    {
      icon: "weather-partly-cloudy",
      label: t("features.weather"),
      color: colors.featureWeather,
      route: `/plan/${id}/weather`,
    },
    {
      icon: "image-multiple",
      label: t("features.moodboard"),
      color: colors.featureMoodboard,
      route: `/plan/${id}/moodboard`,
    },
    {
      icon: "account-multiple",
      label: t("features.guests"),
      color: colors.featureGuests,
      route: `/plan/${id}/guests`,
    },
    {
      icon: "gift",
      label: t("features.gifts"),
      color: colors.featureGifts,
      route: `/plan/${id}/gifts`,
    },
    {
      icon: "party-popper",
      label: t("features.reveal"),
      color: colors.warning,
      route: `/plan/${id}/reveal`,
      locked: !isCompleted,
    },
    {
      icon: "calendar-star",
      label: t("features.event_day"),
      color: colors.secondary,
      route: `/plan/${id}/event-day`,
      locked: !isCompleted,
    },
    {
      icon: "music-note",
      label: t("features.music"),
      color: colors.featureMusic,
      route: `/plan/${id}/music`,
    },
    {
      icon: "lock",
      label: t("features.secret_chat"),
      color: colors.featureChat,
      route: `/plan/${id}/secret-chat`,
    },
    {
      icon: "shield-check",
      label: t("features.backup_plan"),
      color: colors.featureBackup,
      route: `/plan/${id}/backup`,
    },
    {
      icon: "treasure-chest",
      label: t("features.time_capsule"),
      color: colors.featureCapsule,
      route: `/plan/${id}/capsule`,
    },
    {
      icon: "store",
      label: t("features.vendors"),
      color: colors.featureVendors,
      route: "/vendors",
    },
    {
      icon: "image-album",
      label: t("features.memories"),
      color: colors.info,
      route: `/plan/${id}/memories`,
      locked: !isCompleted,
    },
  ];

  return (
    <ScreenErrorBoundary>
      <ScrollView style={styles.container} showsVerticalScrollIndicator={false}>
        {/* Hero Section */}
        <LinearGradient
          colors={heroGradient}
          start={{ x: 0, y: 0 }}
          end={{ x: 1, y: 1 }}
          style={[styles.hero, { paddingTop: insets.top }]}
        >
          {/* Back button */}
          <TouchableOpacity
            style={styles.heroBackButton}
            onPress={() => router.back()}
            activeOpacity={0.7}
          >
            <Icon
              name="arrow-left"
              size={24}
              color={colors.textOnPrimary} /* on gradient */
            />
          </TouchableOpacity>

          {/* Countdown top-right */}
          {plan.event_date && (
            <View style={styles.heroCountdown}>
              <CountdownTimer
                targetDate={plan.event_date}
                targetTime={plan.event_time}
              />
            </View>
          )}

          {/* Title bottom-left */}
          <View style={styles.heroTitleArea}>
            <Text style={styles.heroTitle} numberOfLines={2}>
              {plan.title}
            </Text>
            {plan.recipient_name && (
              <View style={styles.heroRecipientRow}>
                <Icon
                  name="account-heart"
                  size={14}
                  color="rgba(255,255,255,0.8)"
                />
                <Text style={styles.heroRecipient}>{plan.recipient_name}</Text>
              </View>
            )}
          </View>
        </LinearGradient>

        <View style={styles.content}>
          {/* Progress Section */}
          {totalItems > 0 && (
            <Animated.View
              entering={FadeInUp.delay(100).duration(400)}
              style={styles.progressSection}
            >
              <TouchableOpacity
                activeOpacity={0.7}
                onPress={() => router.push(`/plan/${id}/checklist` as never)}
              >
                <Text style={styles.progressPercent}>
                  {Math.round(progress * 100)}%
                </Text>
                <View style={styles.progressBar}>
                  <View
                    style={[
                      styles.progressFill,
                      { width: `${progress * 100}%` },
                    ]}
                  />
                </View>
                <Text style={styles.progressCaption}>
                  {completedItems} / {totalItems} {t("tasks_completed")}
                </Text>
              </TouchableOpacity>
            </Animated.View>
          )}

          {/* Smart Banner */}
          <SmartBanner
            plan={plan}
            lang={lang}
            onPress={() => router.push(`/plan/${id}/checklist` as never)}
          />

          {/* Getting Started Card */}
          {isNewPlan && (
            <GettingStartedCard
              planId={id as string}
              onChecklist={() => router.push(`/plan/${id}/checklist` as never)}
              onCoOrganizer={() =>
                router.push(`/plan/${id}/co-organizers` as never)
              }
              onWeather={() => router.push(`/plan/${id}/weather` as never)}
            />
          )}

          {/* Info Cards */}
          <View style={styles.infoGrid}>
            {plan.budget && (
              <View style={styles.infoCard}>
                <View
                  style={[
                    styles.infoCardIcon,
                    { backgroundColor: colors.success + "12" },
                  ]}
                >
                  <Icon name="cash" size={22} color={colors.success} />
                </View>
                <Text style={styles.infoCardValue}>
                  {"\u20BA"}
                  {plan.budget.toLocaleString()}
                </Text>
                <Text style={styles.infoCardLabel}>{t("budget")}</Text>
              </View>
            )}
            {plan.guest_count && (
              <View style={styles.infoCard}>
                <View
                  style={[
                    styles.infoCardIcon,
                    { backgroundColor: colors.info + "12" },
                  ]}
                >
                  <Icon name="account-group" size={22} color={colors.info} />
                </View>
                <Text style={styles.infoCardValue}>{plan.guest_count}</Text>
                <Text style={styles.infoCardLabel}>{t("guest_count")}</Text>
              </View>
            )}
            {plan.location_text && (
              <TouchableOpacity
                style={styles.infoCard}
                onPress={openLocationInMaps}
                activeOpacity={0.7}
              >
                <View
                  style={[
                    styles.infoCardIcon,
                    { backgroundColor: colors.error + "12" },
                  ]}
                >
                  <Icon name="map-marker" size={22} color={colors.error} />
                </View>
                <Text style={styles.infoCardValue} numberOfLines={1}>
                  {plan.location_text}
                </Text>
                <View style={styles.locationHint}>
                  <Icon name="open-in-new" size={12} color={colors.primary} />
                  <Text style={styles.infoCardLabel}>{t("location")}</Text>
                </View>
              </TouchableOpacity>
            )}
          </View>

          {plan.notes && (
            <View style={styles.notesSection}>
              <Text style={styles.sectionTitle}>{t("notes")}</Text>
              <Text style={styles.notesText}>{plan.notes}</Text>
            </View>
          )}

          {/* Surprise Mode Toggle */}
          <View
            style={[
              styles.surpriseModeRow,
              {
                backgroundColor: surpriseMode
                  ? colors.accent + "12"
                  : colors.surfaceVariant,
                borderColor: surpriseMode
                  ? colors.accent + "40"
                  : colors.borderLight,
              },
            ]}
          >
            <View
              style={[
                styles.surpriseModeIcon,
                {
                  backgroundColor: surpriseMode
                    ? colors.accent + "20"
                    : colors.borderLight,
                },
              ]}
            >
              <Icon
                name="incognito"
                size={20}
                color={surpriseMode ? colors.accent : colors.textTertiary}
              />
            </View>
            <View style={{ flex: 1 }}>
              <Text style={[styles.surpriseModeLabel, { color: colors.text }]}>
                {t("surprise_protection")}
              </Text>
              <Text
                style={[
                  styles.surpriseModeDesc,
                  { color: colors.textTertiary },
                ]}
              >
                {surpriseMode
                  ? t("surprise_protected_desc")
                  : t("surprise_visible_desc")}
              </Text>
            </View>
            <TouchableOpacity
              style={[
                styles.surpriseToggle,
                {
                  backgroundColor: surpriseMode
                    ? colors.accent
                    : colors.borderLight,
                },
              ]}
              onPress={async () => {
                if (surpriseUpdating || !plan) return;
                const newVal = !surpriseMode;
                setSurpriseMode(newVal);
                setSurpriseUpdating(true);
                try {
                  await updatePlan(plan.id, {
                    surprise_protection: newVal,
                  } as Record<string, unknown>);
                } catch {
                  setSurpriseMode(!newVal); // rollback
                } finally {
                  setSurpriseUpdating(false);
                }
              }}
              activeOpacity={0.8}
            >
              <View
                style={[
                  styles.surpriseToggleThumb,
                  { transform: [{ translateX: surpriseMode ? 20 : 2 }] },
                ]}
              />
            </TouchableOpacity>
          </View>

          {/* Feature Hub — Uniform 3-column grid */}
          <View style={styles.featureSection}>
            <Text style={styles.sectionTitle}>{t("features_title")}</Text>
            <View style={styles.featureGrid}>
              {features.map((feature, idx) => (
                <FeatureCard
                  key={feature.route}
                  feature={feature}
                  index={idx}
                  colors={colors}
                  onPress={() =>
                    !feature.locked && router.push(feature.route as never)
                  }
                />
              ))}
            </View>
          </View>

          {/* Complete Surprise Button */}
          {plan.status !== "completed" && plan.status !== "cancelled" && (
            <TouchableOpacity
              style={styles.completeButton}
              onPress={() => router.push(`/plan/${id}/complete` as never)}
              activeOpacity={0.8}
            >
              <Icon
                name="party-popper"
                size={22}
                color={colors.textOnPrimary}
              />
              <Text style={styles.completeButtonText}>
                {t("complete_surprise")}
              </Text>
            </TouchableOpacity>
          )}

          {/* Completed Badge */}
          {plan.status === "completed" && (
            <View style={styles.completedBadge}>
              <Icon name="check-decagram" size={20} color={colors.success} />
              <Text style={styles.completedText}>
                {t("completed")}
                {plan.completion_rating
                  ? ` ${"\u2B50".repeat(plan.completion_rating)}`
                  : ""}
              </Text>
            </View>
          )}

          {/* Memories Button */}
          {plan.status === "completed" && (
            <TouchableOpacity
              style={[
                styles.memoriesButton,
                {
                  backgroundColor: colors.info + "15",
                  borderColor: colors.info + "30",
                },
              ]}
              onPress={() => router.push(`/plan/${id}/memories` as never)}
              activeOpacity={0.8}
            >
              <Icon name="image-album" size={20} color={colors.info} />
              <Text style={[styles.memoriesButtonText, { color: colors.info }]}>
                {t("view_memories")}
              </Text>
            </TouchableOpacity>
          )}

          {/* Quick Actions */}
          <View style={styles.quickActions}>
            <TouchableOpacity
              style={styles.actionRow}
              onPress={() => router.push(`/plan/${id}/expenses` as never)}
              activeOpacity={0.65}
            >
              <View
                style={[
                  styles.actionIcon,
                  { backgroundColor: colors.success + "10" },
                ]}
              >
                <Icon name="receipt" size={20} color={colors.success} />
              </View>
              <Text style={styles.actionLabel}>{t("expenses")}</Text>
              <Icon
                name="chevron-right"
                size={18}
                color={colors.textTertiary}
              />
            </TouchableOpacity>

            <View style={styles.actionDivider} />

            <TouchableOpacity
              style={styles.actionRow}
              onPress={() => router.push(`/plan/${id}/moodboard` as never)}
              activeOpacity={0.65}
            >
              <View
                style={[
                  styles.actionIcon,
                  { backgroundColor: colors.info + "10" },
                ]}
              >
                <Icon name="image-multiple" size={20} color={colors.info} />
              </View>
              <Text style={styles.actionLabel}>{t("photos")}</Text>
              <Icon
                name="chevron-right"
                size={18}
                color={colors.textTertiary}
              />
            </TouchableOpacity>

            <View style={styles.actionDivider} />

            <TouchableOpacity
              style={styles.actionRow}
              onPress={() => router.push(`/plan/${id}/co-organizers` as never)}
              activeOpacity={0.65}
            >
              <View
                style={[
                  styles.actionIcon,
                  { backgroundColor: colors.accent + "10" },
                ]}
              >
                <Icon
                  name="account-multiple-plus"
                  size={20}
                  color={colors.accent}
                />
              </View>
              <Text style={styles.actionLabel}>{t("co_organizers")}</Text>
              <Icon
                name="chevron-right"
                size={18}
                color={colors.textTertiary}
              />
            </TouchableOpacity>
          </View>
        </View>
      </ScrollView>
    </ScreenErrorBoundary>
  );
}

// Feature card with stagger animation and press scale
interface FeatureCardProps {
  feature: {
    icon: string;
    label: string;
    color: string;
    route: string;
    locked?: boolean;
  };
  index: number;
  colors: ThemeColors;
  onPress: () => void;
}

function FeatureCard({ feature, index, colors, onPress }: FeatureCardProps) {
  const scale = useSharedValue(1);
  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ scale: scale.value }],
  }));

  const handlePressIn = () => {
    scale.value = withSpring(0.97, Springs.snappy);
  };
  const handlePressOut = () => {
    scale.value = withSpring(1, Springs.standard);
  };

  const delay = staggerDelay(index, 40, 400);

  return (
    <Animated.View
      entering={FadeInUp.delay(200 + delay)
        .duration(350)
        .springify()}
      style={[styles_static.featureCard, animatedStyle]}
    >
      <TouchableOpacity
        style={[
          styles_static.featureCardInner,
          {
            backgroundColor: feature.color + "15",
            borderColor: feature.color + "20",
          },
          feature.locked && { opacity: 0.5 },
        ]}
        onPress={onPress}
        onPressIn={handlePressIn}
        onPressOut={handlePressOut}
        activeOpacity={feature.locked ? 1 : 0.65}
      >
        <View
          style={[
            styles_static.featureIconCircle,
            { backgroundColor: feature.color + "20" },
          ]}
        >
          <Icon
            name={feature.icon as IconName}
            size={24}
            color={feature.color}
          />
        </View>
        <Text
          style={[
            styles_static.featureLabelText,
            { color: feature.locked ? colors.textTertiary : colors.text },
          ]}
          numberOfLines={2}
        >
          {feature.label}
        </Text>
        {feature.locked && (
          <View
            style={[
              styles_static.featureLockBadge,
              { backgroundColor: colors.surfaceVariant },
            ]}
          >
            <Icon name="lock" size={10} color={colors.textTertiary} />
          </View>
        )}
      </TouchableOpacity>
    </Animated.View>
  );
}

// Static styles that don't depend on colors (for FeatureCard)
const styles_static = StyleSheet.create({
  featureCard: {
    width: "31%",
  },
  featureCardInner: {
    alignItems: "center",
    gap: 6,
    paddingVertical: Spacing.md,
    paddingHorizontal: Spacing.sm,
    borderRadius: BorderRadius.lg,
    borderWidth: 0.5,
    minHeight: 90,
    justifyContent: "center",
    position: "relative",
  },
  featureIconCircle: {
    width: 44,
    height: 44,
    borderRadius: 22,
    alignItems: "center",
    justifyContent: "center",
  },
  featureLockBadge: {
    position: "absolute",
    top: 6,
    right: 6,
    width: 18,
    height: 18,
    borderRadius: 9,
    alignItems: "center",
    justifyContent: "center",
  },
  featureLabelText: {
    ...Typography.caption,
    textAlign: "center",
    fontWeight: "500",
  },
});

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },
    notFound: {
      ...Typography.body,
      color: colors.textSecondary,
      textAlign: "center",
      marginTop: Spacing.xxl,
    },
    // Hero
    hero: {
      height: HERO_HEIGHT,
      position: "relative",
      justifyContent: "flex-end",
      paddingHorizontal: Spacing.lg,
      paddingBottom: Spacing.md,
    },
    heroBackButton: {
      position: "absolute",
      top: Spacing.xl + 16,
      left: Spacing.md,
      width: 40,
      height: 40,
      borderRadius: 20,
      backgroundColor: "rgba(0,0,0,0.2)",
      alignItems: "center",
      justifyContent: "center",
      zIndex: 10,
    },
    heroCountdown: {
      position: "absolute",
      top: Spacing.xl + 16,
      right: Spacing.md,
      zIndex: 10,
    },
    heroTitleArea: {
      gap: Spacing.xs,
    },
    heroTitle: {
      ...Typography.h1,
      color: colors.textOnPrimary,
      textShadowColor: "rgba(0,0,0,0.3)",
      textShadowOffset: { width: 0, height: 1 },
      textShadowRadius: 4,
    },
    heroRecipientRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.xs,
    },
    heroRecipient: {
      ...Typography.bodySmall,
      color: "rgba(255,255,255,0.8)",
    },
    // Content
    content: {
      padding: Spacing.lg,
    },
    sectionTitle: {
      ...Typography.h3,
      color: colors.text,
      marginBottom: Spacing.md,
    },
    // Progress
    progressSection: {
      marginBottom: Spacing.lg,
      alignItems: "center",
    },
    progressPercent: {
      ...Typography.display,
      color: colors.primary,
      textAlign: "center",
      marginBottom: Spacing.sm,
    },
    progressBar: {
      height: 4,
      backgroundColor: colors.borderLight,
      borderRadius: 2,
      overflow: "hidden",
      width: "100%",
    },
    progressFill: {
      height: "100%",
      backgroundColor: colors.primary,
      borderRadius: 2,
    },
    progressCaption: {
      ...Typography.caption,
      color: colors.textTertiary,
      marginTop: Spacing.xs,
      textAlign: "center",
    },
    // Info Grid
    infoGrid: {
      flexDirection: "row",
      flexWrap: "wrap",
      gap: Spacing.sm,
      marginBottom: Spacing.lg,
    },
    infoCard: {
      flex: 1,
      minWidth: "30%",
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      padding: Spacing.md,
      alignItems: "center",
      gap: Spacing.xs,
      borderWidth: 0.5,
      borderColor: colors.border + "40",
    },
    infoCardIcon: {
      width: 40,
      height: 40,
      borderRadius: BorderRadius.md,
      alignItems: "center",
      justifyContent: "center",
      marginBottom: 2,
    },
    infoCardValue: {
      ...Typography.body,
      fontWeight: "600",
      color: colors.text,
    },
    infoCardLabel: {
      ...Typography.caption,
      color: colors.textTertiary,
    },
    locationHint: {
      flexDirection: "row",
      alignItems: "center",
      gap: 3,
    },
    notesSection: {
      marginBottom: Spacing.lg,
    },
    notesText: {
      ...Typography.body,
      color: colors.textSecondary,
      lineHeight: 24,
    },
    // Surprise Mode Toggle
    surpriseModeRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.md,
      padding: Spacing.md,
      borderRadius: BorderRadius.lg,
      borderWidth: 1,
      marginBottom: Spacing.lg,
    },
    surpriseModeIcon: {
      width: 40,
      height: 40,
      borderRadius: BorderRadius.md,
      alignItems: "center",
      justifyContent: "center",
    },
    surpriseModeLabel: {
      ...Typography.bodySmall,
      fontWeight: "600",
    },
    surpriseModeDesc: {
      ...Typography.caption,
    },
    surpriseToggle: {
      width: 44,
      height: 26,
      borderRadius: 13,
      justifyContent: "center",
    },
    surpriseToggleThumb: {
      width: 20,
      height: 20,
      borderRadius: 10,
      backgroundColor: colors.surface,
      ...Shadows.sm,
    },
    // Feature Hub
    featureSection: {
      marginBottom: Spacing.lg,
    },
    featureGrid: {
      flexDirection: "row",
      flexWrap: "wrap",
      gap: Spacing.md,
    },
    // Complete Surprise
    completeButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      backgroundColor: colors.success,
      borderRadius: BorderRadius.lg,
      paddingVertical: Spacing.md,
      marginBottom: Spacing.lg,
      ...Shadows.md,
    },
    completeButtonText: {
      ...Typography.button,
      color: colors.textOnPrimary,
      fontWeight: "700",
      fontSize: 16,
    },
    completedBadge: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      backgroundColor: colors.success + "15",
      borderRadius: BorderRadius.lg,
      paddingVertical: Spacing.md,
      marginBottom: Spacing.lg,
      borderWidth: 1,
      borderColor: colors.success + "30",
    },
    completedText: {
      ...Typography.body,
      color: colors.success,
      fontWeight: "600",
    },
    memoriesButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      borderRadius: BorderRadius.lg,
      paddingVertical: Spacing.md,
      marginBottom: Spacing.lg,
      borderWidth: 1,
    },
    memoriesButtonText: {
      ...Typography.button,
      fontWeight: "600",
    },
    // Quick Actions
    quickActions: {
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      marginBottom: Spacing.xxl,
      borderWidth: 0.5,
      borderColor: colors.border + "40",
      ...Shadows.sm,
    },
    actionRow: {
      flexDirection: "row",
      alignItems: "center",
      padding: Spacing.md,
      gap: Spacing.md,
    },
    actionIcon: {
      width: 32,
      height: 32,
      borderRadius: 8,
      alignItems: "center",
      justifyContent: "center",
    },
    actionLabel: {
      ...Typography.body,
      color: colors.text,
      flex: 1,
    },
    actionDivider: {
      height: 0.5,
      backgroundColor: colors.border,
      marginLeft: 60,
    },
  });
