import React, { useState, useMemo, useEffect } from "react";
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Alert,
} from "react-native";
import { useLocalSearchParams, useRouter } from "expo-router";
import { useTranslation } from "react-i18next";
import { LinearGradient } from "expo-linear-gradient";
import Animated, {
  FadeInDown,
  FadeInUp,
  useSharedValue,
  withSpring,
  useAnimatedStyle,
} from "react-native-reanimated";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import { Icon } from "../../../src/components/ui/Icon";
import { StarRating } from "../../../src/components/ui/StarRating";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
  getGradient,
} from "../../../src/constants/theme";
import { useTheme } from "../../../src/contexts/ThemeContext";
import { usePlanStore } from "../../../src/stores/planStore";
import { hapticSuccess, hapticLight } from "../../../src/utils/haptics";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";

const REACTIONS = ["😊", "😲", "🥹", "😂"] as const;
type Reaction = (typeof REACTIONS)[number];
const REACTION_MAP: Record<
  Reaction,
  "happy" | "surprised" | "emotional" | "laughing"
> = {
  "😊": "happy",
  "😲": "surprised",
  "🥹": "emotional",
  "😂": "laughing",
};

export default function CompleteSurpriseScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const router = useRouter();
  const { t, i18n } = useTranslation();
  const lang = i18n.language as "tr" | "en";
  const { colors, isDark } = useTheme();
  const insets = useSafeAreaInsets();
  const { plans, activePlan, completePlan } = usePlanStore();

  const plan = plans.find((p) => p.id === id) ?? activePlan;

  const [selectedReaction, setSelectedReaction] = useState<Reaction | null>(
    null,
  );
  const [rating, setRating] = useState(0);
  const [isCompleting, setIsCompleting] = useState(false);

  // Spring animation for the check icon
  const iconScale = useSharedValue(0);
  useEffect(() => {
    iconScale.value = withSpring(1, { damping: 12, stiffness: 180 });
  }, []);

  const iconAnimStyle = useAnimatedStyle(() => ({
    transform: [{ scale: iconScale.value }],
  }));

  const styles = useMemo(() => createStyles(colors), [colors]);

  // Stats
  const completedItems =
    plan?.checklist?.filter((c) => c.is_completed).length ?? 0;
  const daysCount = plan?.created_at
    ? Math.max(
        1,
        Math.round(
          (Date.now() - new Date(plan.created_at).getTime()) /
            (1000 * 60 * 60 * 24),
        ),
      )
    : 1;
  const guestCount = plan?.guest_count ?? 0;

  const handleComplete = async (destination: "memories" | "community") => {
    if (isCompleting) return;
    setIsCompleting(true);
    try {
      await completePlan(id!, {
        rating: rating > 0 ? rating : undefined,
        reactionType: selectedReaction
          ? REACTION_MAP[selectedReaction]
          : undefined,
        shareToGallery: destination === "community",
      });
      hapticSuccess();
      if (destination === "memories") {
        router.replace(`/plan/${id}/memories` as any);
      } else {
        router.replace("/(tabs)/community" as any);
      }
    } catch (_err) {
      Alert.alert(t("planComplete.errorTitle"), t("planComplete.errorBody"));
    } finally {
      setIsCompleting(false);
    }
  };

  if (!plan) {
    return (
      <View style={[styles.container, styles.centered]}>
        <Text style={styles.notFound}>{t("planComplete.notFound")}</Text>
      </View>
    );
  }

  return (
    <ScreenErrorBoundary>
      <View style={styles.container}>
        {/* Full-screen gradient hero */}
        <LinearGradient
          colors={getGradient(isDark, "complete") as [string, string, string]}
          start={{ x: 0, y: 0 }}
          end={{ x: 1, y: 1 }}
          style={styles.heroBg}
        />

        <ScrollView
          style={styles.scroll}
          contentContainerStyle={[
            styles.scrollContent,
            { paddingBottom: insets.bottom + Spacing.xxl },
          ]}
          showsVerticalScrollIndicator={false}
        >
          {/* Hero Section */}
          <View style={[styles.heroContent, { paddingTop: insets.top + 40 }]}>
            <Animated.View
              entering={FadeInUp.duration(600).springify()}
              style={iconAnimStyle}
            >
              <Icon
                name="check-circle"
                size={72}
                color="#FFFFFF" /* always white on gradient */
              />
            </Animated.View>

            <Animated.Text
              entering={FadeInUp.duration(600).delay(100)}
              style={styles.heroTitle}
            >
              {t("planComplete.heroTitle")}
            </Animated.Text>

            <Animated.Text
              entering={FadeInUp.duration(600).delay(200)}
              style={styles.heroPlanTitle}
            >
              {plan.title}
            </Animated.Text>
          </View>

          {/* Stats Card */}
          <Animated.View
            entering={FadeInDown.duration(600).delay(300)}
            style={styles.statsCard}
          >
            <View style={styles.statItem}>
              <View
                style={[
                  styles.statIconBg,
                  { backgroundColor: colors.success + "18" },
                ]}
              >
                <Icon name="checkbox-marked" size={22} color={colors.success} />
              </View>
              <Text style={styles.statValue}>{completedItems}</Text>
              <Text style={styles.statLabel}>
                {t("planComplete.statTasksLabel")}
              </Text>
            </View>

            <View style={styles.statDivider} />

            <View style={styles.statItem}>
              <View
                style={[
                  styles.statIconBg,
                  { backgroundColor: colors.info + "18" },
                ]}
              >
                <Icon name="calendar-clock" size={22} color={colors.info} />
              </View>
              <Text style={styles.statValue}>{daysCount}</Text>
              <Text style={styles.statLabel}>
                {t("planComplete.statDaysLabel")}
              </Text>
            </View>

            <View style={styles.statDivider} />

            <View style={styles.statItem}>
              <View
                style={[
                  styles.statIconBg,
                  { backgroundColor: colors.accent + "18" },
                ]}
              >
                <Icon name="account-group" size={22} color={colors.accent} />
              </View>
              <Text style={styles.statValue}>{guestCount}</Text>
              <Text style={styles.statLabel}>
                {t("planComplete.statGuestsLabel")}
              </Text>
            </View>
          </Animated.View>

          {/* Rating Section */}
          <Animated.View
            entering={FadeInDown.duration(600).delay(400)}
            style={styles.section}
          >
            <Text style={styles.sectionTitle}>
              {t("planComplete.ratingTitle")}
            </Text>
            <StarRating
              rating={rating}
              size={44}
              color={colors.secondary}
              emptyColor={colors.border}
              onRate={(star) => {
                hapticLight();
                setRating(star);
              }}
            />
          </Animated.View>

          {/* Reaction Section */}
          <Animated.View
            entering={FadeInDown.duration(600).delay(500)}
            style={styles.section}
          >
            <Text style={styles.sectionTitle}>
              {t("planComplete.reactionTitle")}
            </Text>
            <View style={styles.reactionsRow}>
              {REACTIONS.map((emoji) => {
                const isSelected = selectedReaction === emoji;
                return (
                  <TouchableOpacity
                    key={emoji}
                    onPress={() => {
                      hapticLight();
                      setSelectedReaction(isSelected ? null : emoji);
                    }}
                    activeOpacity={0.75}
                    style={[
                      styles.reactionBtn,
                      isSelected && {
                        backgroundColor: colors.primary,
                        borderColor: colors.primary,
                      },
                    ]}
                  >
                    <Text style={styles.reactionEmoji}>{emoji}</Text>
                  </TouchableOpacity>
                );
              })}
            </View>
          </Animated.View>

          {/* Action Buttons */}
          <Animated.View
            entering={FadeInDown.duration(600).delay(600)}
            style={styles.actionsSection}
          >
            {/* Primary: View Memories */}
            <TouchableOpacity
              style={[
                styles.primaryBtn,
                { backgroundColor: colors.primary },
                isCompleting && styles.btnDisabled,
              ]}
              onPress={() => handleComplete("memories")}
              disabled={isCompleting}
              activeOpacity={0.85}
            >
              <Icon name="image-album" size={22} color={colors.textOnPrimary} />
              <Text style={styles.primaryBtnText}>
                {t("planComplete.viewMemories")}
              </Text>
            </TouchableOpacity>

            {/* Secondary: Share to Community */}
            <TouchableOpacity
              style={[
                styles.secondaryBtn,
                { borderColor: colors.primary },
                isCompleting && styles.btnDisabled,
              ]}
              onPress={() => handleComplete("community")}
              disabled={isCompleting}
              activeOpacity={0.8}
            >
              <Icon name="account-group" size={22} color={colors.primary} />
              <Text
                style={[styles.secondaryBtnText, { color: colors.primary }]}
              >
                {t("planComplete.shareToCommunity")}
              </Text>
            </TouchableOpacity>
          </Animated.View>
        </ScrollView>
      </View>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },
    centered: {
      justifyContent: "center",
      alignItems: "center",
    },
    notFound: {
      ...Typography.body,
      color: colors.textSecondary,
      textAlign: "center",
    },
    heroBg: {
      position: "absolute",
      top: 0,
      left: 0,
      right: 0,
      height: 280,
    },
    scroll: {
      flex: 1,
    },
    scrollContent: {
      paddingHorizontal: 0,
    },
    // ── Hero ──
    heroContent: {
      height: 280,
      alignItems: "center",
      justifyContent: "center",
      paddingHorizontal: Spacing.lg,
      gap: Spacing.sm,
    },
    heroTitle: {
      ...Typography.h1,
      fontSize: 36,
      fontWeight: "900",
      color: "#FFFFFF",
      textAlign: "center",
      marginTop: Spacing.sm,
    },
    heroPlanTitle: {
      ...Typography.body,
      color: "rgba(255,255,255,0.8)",
      textAlign: "center",
      fontStyle: "italic",
    },
    // ── Stats Card ──
    statsCard: {
      flexDirection: "row",
      justifyContent: "space-around",
      alignItems: "center",
      marginHorizontal: Spacing.lg,
      marginTop: -20,
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.xl,
      padding: Spacing.lg,
      borderWidth: 0.5,
      borderColor: colors.border + "40",
      ...Shadows.md,
    },
    statItem: {
      alignItems: "center",
      gap: Spacing.xs,
      flex: 1,
    },
    statIconBg: {
      width: 44,
      height: 44,
      borderRadius: BorderRadius.md,
      alignItems: "center",
      justifyContent: "center",
      marginBottom: 2,
    },
    statValue: {
      ...Typography.h3,
      color: colors.text,
      fontWeight: "700",
    },
    statLabel: {
      ...Typography.caption,
      color: colors.textTertiary,
      textAlign: "center",
      lineHeight: 16,
    },
    statDivider: {
      width: 1,
      height: 48,
      backgroundColor: colors.borderLight,
    },
    // ── Sections ──
    section: {
      paddingHorizontal: Spacing.lg,
      marginTop: Spacing.xl,
    },
    sectionTitle: {
      ...Typography.h4,
      color: colors.text,
      marginBottom: Spacing.md,
    },
    // ── Rating ──
    starsRow: {
      flexDirection: "row",
      justifyContent: "center",
      gap: Spacing.sm,
    },
    // ── Reactions ──
    reactionsRow: {
      flexDirection: "row",
      justifyContent: "space-between",
      gap: Spacing.sm,
    },
    reactionBtn: {
      flex: 1,
      aspectRatio: 1,
      borderRadius: BorderRadius.full,
      borderWidth: 2,
      borderColor: colors.border,
      backgroundColor: colors.surface,
      alignItems: "center",
      justifyContent: "center",
    },
    reactionEmoji: {
      fontSize: 28,
    },
    // ── Action Buttons ──
    actionsSection: {
      paddingHorizontal: Spacing.lg,
      marginTop: Spacing.xl,
      gap: Spacing.md,
    },
    primaryBtn: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      borderRadius: BorderRadius.lg,
      paddingVertical: Spacing.md + 2,
      ...Shadows.md,
    },
    primaryBtnText: {
      ...Typography.button,
      color: colors.textOnPrimary,
      fontWeight: "700",
    },
    secondaryBtn: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      borderRadius: BorderRadius.lg,
      paddingVertical: Spacing.md + 2,
      borderWidth: 1.5,
      backgroundColor: "transparent",
    },
    secondaryBtnText: {
      ...Typography.button,
      fontWeight: "600",
    },
    btnDisabled: {
      opacity: 0.55,
    },
  });
