import React, { useEffect, useMemo, useCallback, useState } from "react";
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  ScrollView,
  FlatList,
  RefreshControl,
  useWindowDimensions,
} from "react-native";
import { useRouter } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon } from "../../src/components/ui/Icon";
import type { IconName } from "../../src/constants/icons";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  FontFamily,
} from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";
import { CATEGORIES } from "../../src/constants/categories";
import { SkeletonCard } from "../../src/components/ui/Skeleton";
import { CachedImage } from "../../src/components/common/CachedImage";
import { useScenarioStore } from "../../src/stores/scenarioStore";
import { usePlanStore } from "../../src/stores/planStore";
import { useAuthStore } from "../../src/stores/authStore";
import { hapticLight, hapticMedium } from "../../src/utils/haptics";
import { a11yButton, a11yHeader } from "../../src/utils/accessibility";
import { ScreenErrorBoundary } from "../../src/components/common/ScreenErrorBoundary";
import { EmptyState } from "../../src/components/common/EmptyState";
import { useToastContext } from "../../src/contexts/ToastContext";
import type { ThemeColors } from "../../src/constants/theme";

const FOR_YOU_CARD_WIDTH = 180;

// Stock images for scenario cards by category slug
const CATEGORY_STOCK_IMAGES: Record<string, string> = {
  proposal:
    "https://images.unsplash.com/photo-1515934751635-c81c6bc9a2d8?w=400&h=300&fit=crop",
  birthday:
    "https://images.unsplash.com/photo-1558636508-e0db3814bd1d?w=400&h=300&fit=crop",
  anniversary:
    "https://images.unsplash.com/photo-1522673607200-164d1b6ce486?w=400&h=300&fit=crop",
  graduation:
    "https://images.unsplash.com/photo-1523050854058-8df90110c476?w=400&h=300&fit=crop",
  baby: "https://images.unsplash.com/photo-1519689680058-324335c77eba?w=400&h=300&fit=crop",
  romantic:
    "https://images.unsplash.com/photo-1518199266791-5375a83190b7?w=400&h=300&fit=crop",
  friendship:
    "https://images.unsplash.com/photo-1529156069898-49953e39b3ac?w=400&h=300&fit=crop",
  apology:
    "https://images.unsplash.com/photo-1490750967868-88aa4f44baee?w=400&h=300&fit=crop",
  achievement:
    "https://images.unsplash.com/photo-1513151233558-d860c5398176?w=400&h=300&fit=crop",
  holiday:
    "https://images.unsplash.com/photo-1482517967863-00e15c9b44be?w=400&h=300&fit=crop",
};

// ── Time-of-day greeting helper ──
function getGreetingKey(): string {
  const hour = new Date().getHours();
  if (hour >= 6 && hour < 12) return "home.greeting.morning";
  if (hour >= 12 && hour < 17) return "home.greeting.afternoon";
  if (hour >= 17 && hour < 22) return "home.greeting.evening";
  return "home.greeting.night";
}

function HomeScreenContent() {
  const router = useRouter();
  const { t, i18n } = useTranslation();
  const lang = i18n.language as "tr" | "en";
  const { colors, isDark } = useTheme();
  const { showToast } = useToastContext();
  const [refreshing, setRefreshing] = useState(false);
  const {
    featuredScenarios,
    loadFeaturedScenarios,
    loadScenarios,
    loadCategories,
  } = useScenarioStore();
  const { profile, isAuthenticated } = useAuthStore();

  const [isLoading, setIsLoading] = useState(true);
  const [loadError, setLoadError] = useState(false);

  const loadData = useCallback(() => {
    setIsLoading(true);
    setLoadError(false);
    Promise.all([loadCategories(), loadFeaturedScenarios(), loadScenarios()])
      .catch((err) => {
        if (__DEV__) console.warn("[Home] Failed to load data:", err);
        setLoadError(true);
        showToast(t("errors.loadFailed"), "error");
      })
      .finally(() => setIsLoading(false));
  }, [loadCategories, loadFeaturedScenarios, loadScenarios, showToast, t]);

  useEffect(() => {
    loadData();
  }, []);

  const { plans, loadPlans } = usePlanStore();
  useEffect(() => {
    loadPlans().catch((err) => {
      if (__DEV__) console.warn("[Home] Failed to load plans:", err);
    });
  }, []);

  const onRefresh = useCallback(async () => {
    setRefreshing(true);
    try {
      await Promise.all([loadData(), loadPlans()]);
    } catch {
      // errors handled in loadData
    } finally {
      setRefreshing(false);
    }
  }, [loadData, loadPlans]);
  const activePlans = useMemo(
    () => plans.filter((p) => p.status === "planning" || p.status === "ready"),
    [plans],
  );

  // Most urgent active plan (closest event_date)
  const urgentPlan = useMemo(() => {
    if (activePlans.length === 0) return null;
    const sorted = [...activePlans]
      .filter((p) => p.event_date)
      .sort(
        (a, b) =>
          new Date(a.event_date!).getTime() - new Date(b.event_date!).getTime(),
      );
    return sorted[0] ?? activePlans[0];
  }, [activePlans]);

  const urgentPlanDays = useMemo(() => {
    if (!urgentPlan?.event_date) return null;
    return Math.ceil(
      (new Date(urgentPlan.event_date).getTime() - Date.now()) / 86400000,
    );
  }, [urgentPlan]);

  // "For You" cards — max 8 from featured
  const forYouCards = useMemo(
    () => featuredScenarios.slice(0, 8),
    [featuredScenarios],
  );

  const s = useMemo(() => createStyles(colors, isDark), [colors, isDark]);

  // ── Greeting text ──
  const greetingKey = getGreetingKey();
  const greetingText = t(greetingKey);
  const displayName =
    isAuthenticated && profile?.display_name ? `, ${profile.display_name}` : "";

  // Hero CTA logic
  const hasActivePlan = activePlans.length > 0;
  const heroSubtitle = hasActivePlan
    ? t("home.daysToSurprise", { count: urgentPlanDays ?? 0 })
    : t("home.planFirstSurprise");

  // Daily inspiration
  const dailyInspirations = useMemo(
    () => [
      { emoji: "💡", textKey: "home.inspirations.notes" },
      { emoji: "🌹", textKey: "home.inspirations.rose" },
      { emoji: "🎵", textKey: "home.inspirations.playlist" },
      { emoji: "📸", textKey: "home.inspirations.album" },
      { emoji: "🌙", textKey: "home.inspirations.stars" },
      { emoji: "✉️", textKey: "home.inspirations.letter" },
      { emoji: "🎂", textKey: "home.inspirations.dessert" },
    ],
    [],
  );

  const todayInspiration =
    dailyInspirations[new Date().getDay() % dailyInspirations.length];

  const forYouContentStyle = useMemo(() => ({ paddingRight: Spacing.lg }), []);

  const renderForYouCard = useCallback(
    ({ item }: { item: (typeof forYouCards)[0] }) => {
      const catSlug = (item.category as { slug?: string })?.slug ?? "";
      const imageUrl = item.cover_image_url ?? CATEGORY_STOCK_IMAGES[catSlug];
      return (
        <TouchableOpacity
          onPress={() => {
            hapticLight();
            router.push(`/scenario/${item.id}`);
          }}
          activeOpacity={0.88}
          style={s.forYouCard}
          accessibilityLabel={lang === "tr" ? item.title_tr : item.title_en}
        >
          <View style={s.forYouCardTop}>
            <CachedImage
              uri={imageUrl}
              style={s.forYouCardImage}
              contentFit="cover"
              fallbackIcon="gift"
            />
            {item.is_premium && (
              <View style={s.forYouPremiumBadge}>
                <Text style={s.forYouPremiumText}>PRO</Text>
              </View>
            )}
          </View>
          <View style={s.forYouCardBottom}>
            <Text style={s.forYouTitle} numberOfLines={2}>
              {lang === "tr" ? item.title_tr : item.title_en}
            </Text>
            <View style={s.forYouFooter}>
              <Text style={s.forYouRatingText}>
                {"\u2605"} {(item.rating_avg ?? 0).toFixed(1)}
              </Text>
              <Text style={s.forYouBudget}>
                {"\u20BA"}
                {item.min_budget != null
                  ? item.min_budget.toLocaleString()
                  : "?"}
                +
              </Text>
            </View>
          </View>
        </TouchableOpacity>
      );
    },
    [s, lang, router],
  );

  return (
    <ScrollView
      style={s.container}
      showsVerticalScrollIndicator={false}
      refreshControl={
        <RefreshControl
          refreshing={refreshing}
          onRefresh={onRefresh}
          tintColor={colors.primary}
          colors={[colors.primary]}
        />
      }
    >
      {/* ═══════════════════════════════════════════════
          Section 1 — Greeting
          ═══════════════════════════════════════════════ */}
      <View style={s.greetingSection}>
        <Text
          style={s.greetingTitle}
          {...a11yHeader(`${greetingText}${displayName}`)}
        >
          {greetingText}
          {displayName}
        </Text>
        <Text style={s.greetingSubtitle}>{heroSubtitle}</Text>
        <TouchableOpacity
          style={s.ctaButton}
          onPress={() => {
            hapticMedium();
            if (hasActivePlan && urgentPlan) {
              router.push(`/plan/${urgentPlan.id}` as never);
            } else {
              router.push("/(tabs)/ai");
            }
          }}
          activeOpacity={0.85}
          {...a11yButton(heroSubtitle)}
        >
          <Text style={s.ctaButtonText}>
            {hasActivePlan ? t("home.goToPlan") : t("home.planFirstSurprise")}
          </Text>
        </TouchableOpacity>
      </View>

      {/* ═══════════════════════════════════════════════
          Section 2 — Active Plan Spotlight
          ═══════════════════════════════════════════════ */}
      {urgentPlan && (
        <View style={s.spotlightSection}>
          <TouchableOpacity
            style={s.spotlightCard}
            onPress={() => {
              hapticLight();
              router.push(`/plan/${urgentPlan.id}` as never);
            }}
            activeOpacity={0.88}
            {...a11yButton(urgentPlan.title)}
          >
            <View style={s.spotlightContent}>
              <View style={s.spotlightLeft}>
                <Text style={s.spotlightTitle} numberOfLines={1}>
                  {urgentPlan.title}
                </Text>
                {urgentPlan.recipient_name && (
                  <Text style={s.spotlightRecipient} numberOfLines={1}>
                    {urgentPlan.recipient_name}
                  </Text>
                )}
              </View>
              <View style={s.spotlightRight}>
                <Text style={s.spotlightCountdownNumber}>
                  {urgentPlanDays !== null ? Math.max(0, urgentPlanDays) : "--"}
                </Text>
                <Text style={s.spotlightCountdownLabel}>
                  {t("common.days").toLowerCase()}
                </Text>
              </View>
            </View>
          </TouchableOpacity>

          <TouchableOpacity
            onPress={() => router.push("/(tabs)/plans")}
            style={s.seeAllPlansLink}
            {...a11yButton(t("home.seeAllPlans"))}
          >
            <Text style={[s.seeAllPlansText, { color: colors.primary }]}>
              {t("home.seeAllPlans")}
            </Text>
          </TouchableOpacity>
        </View>
      )}

      {/* ═══════════════════════════════════════════════
          Section 3 — Daily Inspiration
          ═══════════════════════════════════════════════ */}
      <View style={s.section}>
        <Text
          style={s.sectionTitle}
          {...a11yHeader(t("home.dailyInspiration"), 2)}
        >
          {t("home.dailyInspiration")}
        </Text>
        <View style={s.inspirationCard}>
          <Text style={s.inspirationEmoji}>{todayInspiration.emoji}</Text>
          <Text style={s.inspirationText}>{t(todayInspiration.textKey)}</Text>
          <TouchableOpacity
            style={s.inspirationBtn}
            onPress={() => {
              hapticLight();
              router.push("/(tabs)/explore");
            }}
            activeOpacity={0.8}
          >
            <Text style={s.inspirationBtnText}>
              {t("home.browseScenarios")}
            </Text>
            <Icon name="arrow-right" size={16} color={colors.textOnPrimary} />
          </TouchableOpacity>
        </View>
      </View>

      {/* ═══════════════════════════════════════════════
          Section 4 — Categories
          ═══════════════════════════════════════════════ */}
      <View style={s.section}>
        <View style={s.sectionHeader}>
          <Text style={s.sectionTitle} {...a11yHeader(t("home.categories"), 2)}>
            {t("home.categories")}
          </Text>
          <TouchableOpacity
            onPress={() => router.push("/(tabs)/explore")}
            {...a11yButton(t("common.see_all"))}
          >
            <Text style={s.seeAll}>{t("common.see_all")}</Text>
          </TouchableOpacity>
        </View>
        <FlatList
          horizontal
          showsHorizontalScrollIndicator={false}
          data={CATEGORIES}
          keyExtractor={(item) => item.slug}
          contentContainerStyle={s.categoriesRow}
          renderItem={({ item: cat }) => (
            <TouchableOpacity
              style={s.categoryChip}
              onPress={() => {
                hapticLight();
                router.push(`/category/${cat.slug}` as never);
              }}
              activeOpacity={0.7}
              {...a11yButton(t(cat.nameKey))}
            >
              <Icon
                name={cat.icon as IconName}
                size={20}
                color={colors.textTertiary}
              />
              <Text style={s.categoryChipLabel}>{t(cat.nameKey)}</Text>
            </TouchableOpacity>
          )}
        />
      </View>

      {/* ═══════════════════════════════════════════════
          Section 5 — "For You" Scenarios
          ═══════════════════════════════════════════════ */}
      <View style={s.section}>
        <View style={s.sectionHeader}>
          <Text style={s.sectionTitle} {...a11yHeader(t("home.forYou"), 2)}>
            {t("home.forYou")}
          </Text>
          <TouchableOpacity
            onPress={() => router.push("/(tabs)/explore")}
            {...a11yButton(t("common.see_all"))}
          >
            <Text style={s.seeAll}>{t("common.see_all")}</Text>
          </TouchableOpacity>
        </View>

        {loadError && forYouCards.length === 0 ? (
          <EmptyState
            emoji="⚠️"
            title={t("errors.loadFailedTitle")}
            description={t("errors.loadFailedDesc")}
            actionLabel={t("errors.retry")}
            onAction={loadData}
          />
        ) : isLoading && forYouCards.length === 0 ? (
          <FlatList
            horizontal
            showsHorizontalScrollIndicator={false}
            data={[1, 2, 3]}
            keyExtractor={(item) => String(item)}
            contentContainerStyle={{ paddingRight: Spacing.lg }}
            renderItem={() => (
              <SkeletonCard
                style={{
                  width: FOR_YOU_CARD_WIDTH,
                  height: 220,
                  marginRight: Spacing.sm,
                }}
              />
            )}
          />
        ) : (
          <FlatList
            horizontal
            showsHorizontalScrollIndicator={false}
            data={forYouCards}
            keyExtractor={(item) => item.id}
            contentContainerStyle={forYouContentStyle}
            snapToInterval={FOR_YOU_CARD_WIDTH + Spacing.sm}
            decelerationRate="fast"
            renderItem={renderForYouCard}
          />
        )}
      </View>

      {/* Bottom spacer for tab bar */}
      <View style={{ height: 100 }} />
    </ScrollView>
  );
}

export default function HomeScreen() {
  return (
    <ScreenErrorBoundary>
      <HomeScreenContent />
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors, _isDark: boolean) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },

    // ═══════════════════════════════════════════
    // Section 1 — Greeting
    // ═══════════════════════════════════════════
    greetingSection: {
      paddingHorizontal: Spacing.md,
      paddingTop: Spacing.xxl,
      paddingBottom: Spacing.lg,
    },
    greetingTitle: {
      ...Typography.displayLarge,
      color: colors.text,
    },
    greetingSubtitle: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
      marginTop: Spacing.xs,
    },
    ctaButton: {
      alignSelf: "flex-start",
      backgroundColor: colors.primary,
      borderRadius: BorderRadius.md,
      paddingHorizontal: Spacing.mld,
      paddingVertical: Spacing.smd,
      marginTop: Spacing.md,
    },
    ctaButtonText: {
      ...Typography.button,
      color: colors.textOnPrimary,
    },

    // ═══════════════════════════════════════════
    // Section 2 — Active Plan Spotlight
    // ═══════════════════════════════════════════
    spotlightSection: {
      paddingHorizontal: Spacing.md,
      paddingBottom: Spacing.sm,
    },
    spotlightCard: {
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.md,
      ...Shadows.sm,
      overflow: "hidden",
    },
    spotlightContent: {
      flexDirection: "row",
      alignItems: "center",
      padding: Spacing.md,
    },
    spotlightLeft: {
      flex: 1,
      gap: Spacing.xs,
    },
    spotlightTitle: {
      ...Typography.h4,
      color: colors.text,
    },
    spotlightRecipient: {
      ...Typography.caption,
      color: colors.textSecondary,
    },
    spotlightRight: {
      alignItems: "center",
      marginLeft: Spacing.md,
    },
    spotlightCountdownNumber: {
      fontSize: 28,
      fontWeight: "700",
      fontFamily: FontFamily.bold,
      color: colors.primary,
      lineHeight: 34,
    },
    spotlightCountdownLabel: {
      ...Typography.caption,
      color: colors.textSecondary,
    },
    seeAllPlansLink: {
      alignItems: "center",
      marginTop: Spacing.sm,
      paddingVertical: Spacing.xs,
    },
    seeAllPlansText: {
      ...Typography.bodySmall,
      fontWeight: "600",
    },

    // ═══════════════════════════════════════════
    // Sections shared
    // ═══════════════════════════════════════════
    section: {
      paddingTop: Spacing.lg,
      paddingLeft: Spacing.md,
    },
    sectionHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      paddingRight: Spacing.md,
      marginBottom: Spacing.md,
    },
    sectionTitle: {
      ...Typography.h2,
      color: colors.text,
    },
    seeAll: {
      ...Typography.bodySmall,
      color: colors.primary,
      fontWeight: "600",
    },

    // ═══════════════════════════════════════════
    // Section 3 — Daily Inspiration
    // ═══════════════════════════════════════════
    inspirationCard: {
      marginHorizontal: Spacing.lg,
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.xl,
      borderWidth: 1,
      borderColor: colors.primary + "25",
      padding: Spacing.lg,
      alignItems: "center",
      gap: Spacing.smd,
    },
    inspirationEmoji: {
      fontSize: 36,
    },
    inspirationText: {
      ...Typography.body,
      color: colors.textSecondary,
      textAlign: "center",
      lineHeight: 24,
    },
    inspirationBtn: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.xs,
      backgroundColor: colors.primary,
      paddingHorizontal: Spacing.mld,
      paddingVertical: Spacing.smd,
      borderRadius: BorderRadius.full,
      marginTop: Spacing.xs,
    },
    inspirationBtnText: {
      ...Typography.buttonSmall,
      color: colors.textOnPrimary,
    },

    // ═══════════════════════════════════════════
    // Section 4 — For You cards
    // ═══════════════════════════════════════════
    forYouCard: {
      width: FOR_YOU_CARD_WIDTH,
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.md,
      marginRight: Spacing.sm,
      overflow: "hidden",
      ...Shadows.sm,
    },
    forYouCardTop: {
      height: 120,
      backgroundColor: colors.backgroundSecondary,
      position: "relative",
      overflow: "hidden",
    },
    forYouCardImage: {
      width: "100%",
      height: "100%",
    },
    forYouCardImageFallback: {
      width: "100%",
      height: "100%",
      alignItems: "center",
      justifyContent: "center",
    },
    forYouCardBottom: {
      padding: Spacing.smd,
      gap: Spacing.sm,
    },
    forYouTitle: {
      ...Typography.bodySmall,
      color: colors.text,
      lineHeight: 20,
    },
    forYouFooter: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "space-between",
    },
    forYouRatingText: {
      ...Typography.caption,
      color: colors.textSecondary,
      fontWeight: "600",
    },
    forYouBudget: {
      ...Typography.caption,
      color: colors.textTertiary,
    },
    forYouPremiumBadge: {
      position: "absolute",
      top: Spacing.sm,
      right: Spacing.sm,
      paddingHorizontal: Spacing.sm,
      paddingVertical: 2,
      borderRadius: BorderRadius.full,
      backgroundColor: colors.primaryLight,
    },
    forYouPremiumText: {
      fontSize: 10,
      color: colors.primary,
      fontWeight: "700",
      letterSpacing: 0.5,
      fontFamily: FontFamily.bold,
    },

    // ═══════════════════════════════════════════
    // Section 5 — Categories
    // ═══════════════════════════════════════════
    categoriesRow: {
      paddingRight: Spacing.md,
      gap: Spacing.sm,
    },
    categoryChip: {
      flexDirection: "row",
      alignItems: "center",
      backgroundColor: colors.backgroundSecondary,
      borderRadius: BorderRadius.full,
      paddingVertical: 10,
      paddingHorizontal: Spacing.md,
      gap: Spacing.sm,
    },
    categoryChipLabel: {
      ...Typography.caption,
      color: colors.text,
    },
  });
