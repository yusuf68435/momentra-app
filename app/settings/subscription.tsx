import React, {
  useState,
  useCallback,
  useMemo,
  useEffect,
  useRef,
} from "react";
import { useTranslation } from "react-i18next";
import { ScreenErrorBoundary } from "../../src/components/common/ScreenErrorBoundary";
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Alert,
  Linking,
  ActivityIndicator,
} from "react-native";
import { Icon } from "../../src/components/ui/Icon";
import type { IconName } from "../../src/constants/icons";
import { useRouter } from "expo-router";
import { LinearGradient } from "expo-linear-gradient";
import Animated, {
  FadeInDown,
  FadeInUp,
  ZoomIn,
} from "react-native-reanimated";
import type {
  PurchasesPackage,
  PurchasesOfferings,
} from "../../src/services/purchases";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";
import {
  useSettingsStore,
  SubscriptionPlan,
} from "../../src/stores/settingsStore";
import { Button } from "../../src/components/ui/Button";
import {
  PLAN_FEATURES,
  PLAN_PRICES,
  isPlanAtLeast,
  formatLimit,
  isFirstSurpriseFreeActive,
} from "../../src/services/subscription";
import {
  initializePurchases,
  getOfferings,
  purchasePackage,
  restorePurchases,
  deriveStatusFromCustomerInfo,
  isPurchasesConfigured,
} from "../../src/services/purchases";

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------

type BillingPeriod = "monthly" | "yearly";

interface PlanDef {
  id: SubscriptionPlan;
  gradient: [string, string];
  icon: string;
  popular?: boolean;
  featuresKey: string;
}

interface FeatureRow {
  icon: string;
  labelKey: string;
  feature: keyof typeof PLAN_FEATURES.free;
}

// ---------------------------------------------------------------------------
// Static data
// ---------------------------------------------------------------------------

const PLANS: PlanDef[] = [
  {
    id: "free",
    gradient: ["#E0E0E0", "#BDBDBD"],
    icon: "gift-outline",
    featuresKey: "subscription_screen.plan_free_features",
  },
  {
    id: "plus",
    gradient: ["#E91E63", "#C2185B"],
    icon: "star-four-points",
    popular: true,
    featuresKey: "subscription_screen.plan_plus_features",
  },
  {
    id: "pro",
    gradient: ["#9C27B0", "#7B1FA2"],
    icon: "crown",
    featuresKey: "subscription_screen.plan_pro_features",
  },
];

const COMPARISON: FeatureRow[] = [
  {
    icon: "calendar-check",
    labelKey: "subscription_screen.comparison_monthly_plans",
    feature: "maxPlans",
  },
  {
    icon: "robot",
    labelKey: "subscription_screen.comparison_ai_queries",
    feature: "maxAiChats",
  },
  {
    icon: "palette-swatch",
    labelKey: "subscription_screen.comparison_premium_scenarios",
    feature: "premiumScenarios",
  },
  {
    icon: "account-group",
    labelKey: "subscription_screen.comparison_co_organizers",
    feature: "coOrganizers",
  },
  {
    icon: "image-multiple",
    labelKey: "subscription_screen.comparison_photo_storage",
    feature: "photoStorage",
  },
  {
    icon: "file-pdf-box",
    labelKey: "subscription_screen.comparison_pdf_export",
    feature: "exportPDF",
  },
  {
    icon: "headset",
    labelKey: "subscription_screen.comparison_priority_support",
    feature: "prioritySupport",
  },
  {
    icon: "palette",
    labelKey: "subscription_screen.comparison_custom_themes",
    feature: "customThemes",
  },
];

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

function getPlanPrice(planId: SubscriptionPlan, period: BillingPeriod): string {
  if (planId === "free") return "\u20BA0";
  const prices = PLAN_PRICES[planId];
  return period === "monthly" ? prices.monthly : prices.yearlyMonthly;
}

function getPlanTotalYearly(planId: SubscriptionPlan): string | null {
  if (planId === "free") return null;
  return PLAN_PRICES[planId].yearly;
}

function getSavingsPercent(planId: "plus" | "pro"): number {
  const monthlyNum = parseFloat(
    PLAN_PRICES[planId].monthly.replace("\u20BA", "").replace(",", "."),
  );
  const yearlyMonthlyNum = parseFloat(
    PLAN_PRICES[planId].yearlyMonthly.replace("\u20BA", "").replace(",", "."),
  );
  return Math.round((1 - yearlyMonthlyNum / monthlyNum) * 100);
}

// ---------------------------------------------------------------------------
// Component
// ---------------------------------------------------------------------------

export default function SubscriptionScreen() {
  const router = useRouter();
  const { t } = useTranslation("settings");
  const {
    language,
    subscriptionPlan,
    setSubscriptionPlan,
    firstSurpriseCompleted,
  } = useSettingsStore();
  const { colors, isDark } = useTheme();

  const [selectedPlan, setSelectedPlan] =
    useState<SubscriptionPlan>(subscriptionPlan);
  const [billingPeriod, setBillingPeriod] = useState<BillingPeriod>("monthly");
  const [offerings, setOfferings] = useState<PurchasesOfferings | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [rcConfigured, setRcConfigured] = useState(false);
  const hasInitialized = useRef(false);

  // Initialize RevenueCat and load offerings on mount
  useEffect(() => {
    if (hasInitialized.current) return;
    hasInitialized.current = true;

    (async () => {
      const ok = await initializePurchases();
      setRcConfigured(ok);
      if (ok) {
        const off = await getOfferings();
        setOfferings(off);
      }
    })();
  }, []);

  /**
   * Try to find a RevenueCat package for the selected plan + billing period.
   * Returns null if offerings are not loaded or no matching package exists.
   */
  const findPackageForPlan = useCallback(
    (
      planId: SubscriptionPlan,
      period: BillingPeriod,
    ): PurchasesPackage | null => {
      if (!offerings?.current?.availablePackages) return null;

      const packages = offerings.current.availablePackages;
      // Match by product identifier convention: e.g. "plus_monthly", "pro_yearly"
      const targetId = `${planId}_${period}`;

      // Try matching by identifier substring
      const pkg = packages.find(
        (p: PurchasesPackage) =>
          p.identifier.toLowerCase().includes(targetId) ||
          p.product.identifier.toLowerCase().includes(targetId),
      );

      return pkg ?? null;
    },
    [offerings],
  );

  /**
   * Get the real price string from RevenueCat offerings, if available.
   * Falls back to the hardcoded PLAN_PRICES.
   */
  const getRealPrice = useCallback(
    (planId: SubscriptionPlan, period: BillingPeriod): string | null => {
      const pkg = findPackageForPlan(planId, period);
      return pkg?.product.priceString ?? null;
    },
    [findPackageForPlan],
  );

  // Memoize dynamic styles that depend on dark mode
  const dynamicStyles = useMemo(
    () =>
      StyleSheet.create({
        container: { flex: 1, backgroundColor: colors.background },
        headerTitle: { ...Typography.h3, color: colors.text },
        headerSubtitle: {
          ...Typography.bodySmall,
          color: colors.textSecondary,
          marginTop: 2,
        },
        backButton: {
          width: 40,
          height: 40,
          borderRadius: BorderRadius.full,
          backgroundColor: colors.surfaceVariant,
          alignItems: "center",
          justifyContent: "center",
        },
        currentPlanBadge: {
          flexDirection: "row" as const,
          alignItems: "center" as const,
          alignSelf: "center" as const,
          gap: Spacing.sm,
          paddingHorizontal: Spacing.md,
          paddingVertical: Spacing.sm,
          borderRadius: BorderRadius.full,
          backgroundColor: colors.primary + "15",
          marginBottom: Spacing.md,
        },
        currentPlanText: {
          ...Typography.bodySmall,
          color: colors.textSecondary,
        },
        currentPlanName: { fontWeight: "700" as const, color: colors.primary },
        toggleContainer: {
          flexDirection: "row" as const,
          alignSelf: "center" as const,
          backgroundColor: colors.surfaceVariant,
          borderRadius: BorderRadius.full,
          padding: 3,
          marginBottom: Spacing.lg,
        },
        toggleOption: {
          paddingHorizontal: Spacing.lg,
          paddingVertical: Spacing.sm,
          borderRadius: BorderRadius.full,
        },
        toggleOptionActive: { backgroundColor: colors.primary },
        toggleText: { ...Typography.buttonSmall, color: colors.textSecondary },
        toggleTextActive: { color: colors.textOnPrimary },
        savingsBadge: {
          backgroundColor: colors.success + "20",
          paddingHorizontal: Spacing.sm,
          paddingVertical: 2,
          borderRadius: BorderRadius.full,
          marginLeft: Spacing.sm,
        },
        savingsText: {
          ...Typography.caption,
          color: colors.success,
          fontWeight: "700" as const,
        },
        planCardWrapper: {
          marginHorizontal: Spacing.lg,
          marginBottom: Spacing.md,
          borderRadius: BorderRadius.lg,
          borderWidth: 2,
          borderColor: colors.border,
          backgroundColor: colors.surface,
          overflow: "hidden" as const,
          ...Shadows.sm,
        },
        planCardWrapperSelected: { borderColor: colors.primary, ...Shadows.lg },
        featureText: { ...Typography.bodySmall, color: colors.text, flex: 1 },
        selectText: {
          ...Typography.bodySmall,
          fontWeight: "600" as const,
          color: colors.textTertiary,
        },
        selectTextActive: { color: colors.primary },
        radioOuter: {
          width: 22,
          height: 22,
          borderRadius: 11,
          borderWidth: 2,
          borderColor: colors.border,
          alignItems: "center" as const,
          justifyContent: "center" as const,
        },
        radioOuterSelected: { borderColor: colors.primary },
        radioInner: {
          width: 12,
          height: 12,
          borderRadius: 6,
          backgroundColor: colors.primary,
        },
        comparisonSection: {
          marginHorizontal: Spacing.lg,
          marginTop: Spacing.lg,
          borderRadius: BorderRadius.lg,
          backgroundColor: colors.surface,
          overflow: "hidden" as const,
          ...Shadows.sm,
        },
        comparisonTitle: {
          ...Typography.h4,
          color: colors.text,
          padding: Spacing.md,
          textAlign: "center" as const,
        },
        tableHeader: {
          flexDirection: "row" as const,
          backgroundColor: colors.surfaceVariant,
          paddingVertical: Spacing.sm,
          paddingHorizontal: Spacing.sm,
        },
        tableHeaderCell: {
          ...Typography.caption,
          fontWeight: "700" as const,
          color: colors.textSecondary,
          flex: 1,
          textAlign: "center" as const,
        },
        tableRowAlt: { backgroundColor: colors.backgroundSecondary },
        tableCellText: { ...Typography.caption, color: colors.text },
        yearlyTotal: {
          ...Typography.caption,
          color: colors.textTertiary,
          textAlign: "center" as const,
          marginTop: 2,
        },
        disclaimer: {
          ...Typography.caption,
          color: colors.textTertiary,
          textAlign: "center" as const,
          marginTop: Spacing.md,
          marginHorizontal: Spacing.xl,
          lineHeight: 18,
        },
        termsText: {
          ...Typography.caption,
          color: colors.textTertiary,
          textDecorationLine: "underline" as const,
        },
        footerButtonText: {
          ...Typography.bodySmall,
          fontWeight: "600" as const,
          color: colors.primary,
        },
        popularBadgeBackground: { backgroundColor: colors.warning },
        popularBadgeColor: { color: colors.textOnPrimary },
        planNameColor: { color: colors.textOnPrimary },
        activeBadgeTextColor: { color: colors.textOnPrimary },
        planPriceColor: { color: colors.textOnPrimary },
        firstSurpriseTitleColor: { color: colors.textOnPrimary },
      }),
    [isDark, colors],
  );

  // -----------------------------------------------------------------------
  // Handlers
  // -----------------------------------------------------------------------

  const handleSubscribe = useCallback(async () => {
    if (selectedPlan === "free") {
      setSubscriptionPlan("free");
      Alert.alert(
        t("subscription_screen.alert_plan_changed_title"),
        t("subscription_screen.alert_plan_changed_msg"),
      );
      return;
    }

    // If RevenueCat is configured, attempt a real purchase
    if (rcConfigured) {
      const pkg = findPackageForPlan(selectedPlan, billingPeriod);
      if (!pkg) {
        Alert.alert(
          t("subscription_screen.alert_package_not_found_title"),
          t("subscription_screen.alert_package_not_found_msg"),
        );
        return;
      }

      setIsLoading(true);
      try {
        const customerInfo = await purchasePackage(pkg);
        if (customerInfo) {
          const status = deriveStatusFromCustomerInfo(customerInfo);
          setSubscriptionPlan(status.plan);
          Alert.alert(
            t("subscription_screen.alert_success_title"),
            selectedPlan === "plus"
              ? t("subscription_screen.alert_subscribed_plus")
              : t("subscription_screen.alert_subscribed_pro"),
          );
        }
        // null = user cancelled, no alert needed
      } catch (error: unknown) {
        Alert.alert(
          t("subscription_screen.alert_error_title"),
          t("subscription_screen.alert_purchase_error_msg"),
        );
      } finally {
        setIsLoading(false);
      }
      return;
    }

    // Fallback demo mode when RevenueCat is not configured
    Alert.alert(
      t("subscription_screen.alert_coming_soon_title"),
      t("subscription_screen.alert_coming_soon_msg"),
      [
        {
          text: t("subscription_screen.alert_ok"),
          onPress: () => setSubscriptionPlan(selectedPlan),
        },
      ],
    );
  }, [
    selectedPlan,
    t,
    setSubscriptionPlan,
    rcConfigured,
    billingPeriod,
    findPackageForPlan,
  ]);

  const handleRestore = useCallback(async () => {
    if (rcConfigured) {
      setIsLoading(true);
      try {
        const customerInfo = await restorePurchases();
        if (customerInfo) {
          const status = deriveStatusFromCustomerInfo(customerInfo);
          setSubscriptionPlan(status.plan);
          if (status.isActive) {
            Alert.alert(
              t("subscription_screen.alert_restored_title"),
              status.plan === "plus"
                ? t("subscription_screen.alert_restored_plus")
                : t("subscription_screen.alert_restored_pro"),
            );
          } else {
            Alert.alert(
              t("subscription_screen.alert_no_purchases_title"),
              t("subscription_screen.alert_no_purchases_msg"),
            );
          }
        }
      } catch (error: unknown) {
        Alert.alert(
          t("subscription_screen.alert_error_title"),
          t("subscription_screen.alert_restore_error_msg"),
        );
      } finally {
        setIsLoading(false);
      }
      return;
    }

    // Fallback when RevenueCat is not configured
    Alert.alert(
      t("subscription_screen.alert_restored_title"),
      t("subscription_screen.alert_restored_fallback_msg"),
    );
  }, [t, rcConfigured, setSubscriptionPlan]);

  // -----------------------------------------------------------------------
  // Render
  // -----------------------------------------------------------------------

  return (
    <ScreenErrorBoundary>
      <ScrollView
        style={dynamicStyles.container}
        contentContainerStyle={staticStyles.content}
      >
        {/* Header */}
        <Animated.View
          entering={FadeInDown.delay(100).duration(400)}
          style={staticStyles.header}
        >
          <TouchableOpacity
            onPress={() => router.back()}
            style={dynamicStyles.backButton}
          >
            <Icon name="arrow-left" size={24} color={colors.text} />
          </TouchableOpacity>
          <View style={staticStyles.headerTextContainer}>
            <Text style={dynamicStyles.headerTitle}>
              {t("subscription_screen.title")}
            </Text>
            <Text style={dynamicStyles.headerSubtitle}>
              {t("subscription_screen.subtitle")}
            </Text>
          </View>
        </Animated.View>

        {/* First Surprise Free Banner */}
        {isFirstSurpriseFreeActive(
          subscriptionPlan,
          firstSurpriseCompleted,
        ) && (
          <Animated.View entering={ZoomIn.delay(150).duration(400)}>
            <LinearGradient
              colors={["#4CAF50", "#2E7D32"]}
              start={{ x: 0, y: 0 }}
              end={{ x: 1, y: 1 }}
              style={staticStyles.firstSurpriseBanner}
            >
              <Icon name="gift" size={28} color={colors.textOnPrimary} />
              <View style={{ flex: 1 }}>
                <Text
                  style={[
                    staticStyles.firstSurpriseTitle,
                    dynamicStyles.firstSurpriseTitleColor,
                  ]}
                >
                  {t("subscription_screen.first_surprise_title")}
                </Text>
                <Text style={staticStyles.firstSurpriseDesc}>
                  {t("subscription_screen.first_surprise_desc")}
                </Text>
              </View>
            </LinearGradient>
          </Animated.View>
        )}

        {/* Current Plan Badge */}
        <Animated.View
          entering={ZoomIn.delay(200).duration(400)}
          style={dynamicStyles.currentPlanBadge}
        >
          <Icon
            name={
              (subscriptionPlan === "free"
                ? "gift-outline"
                : subscriptionPlan === "plus"
                  ? "star-four-points"
                  : "crown") as IconName
            }
            size={20}
            color={colors.primary}
          />
          <Text style={dynamicStyles.currentPlanText}>
            {t("subscription_screen.current_plan_label")}
            <Text style={dynamicStyles.currentPlanName}>
              {subscriptionPlan === "free"
                ? t("subscription_screen.plan_free")
                : subscriptionPlan === "plus"
                  ? "Plus"
                  : "Pro"}
            </Text>
          </Text>
        </Animated.View>

        {/* Billing Period Toggle */}
        <Animated.View
          entering={FadeInDown.delay(250).duration(400)}
          style={dynamicStyles.toggleContainer}
        >
          <TouchableOpacity
            activeOpacity={0.8}
            onPress={() => setBillingPeriod("monthly")}
            style={[
              dynamicStyles.toggleOption,
              billingPeriod === "monthly" && dynamicStyles.toggleOptionActive,
            ]}
          >
            <Text
              style={[
                dynamicStyles.toggleText,
                billingPeriod === "monthly" && dynamicStyles.toggleTextActive,
              ]}
            >
              {t("subscription_screen.billing_monthly")}
            </Text>
          </TouchableOpacity>
          <TouchableOpacity
            activeOpacity={0.8}
            onPress={() => setBillingPeriod("yearly")}
            style={[
              dynamicStyles.toggleOption,
              billingPeriod === "yearly" && dynamicStyles.toggleOptionActive,
              { flexDirection: "row", alignItems: "center" },
            ]}
          >
            <Text
              style={[
                dynamicStyles.toggleText,
                billingPeriod === "yearly" && dynamicStyles.toggleTextActive,
              ]}
            >
              {t("subscription_screen.billing_yearly")}
            </Text>
            <View style={dynamicStyles.savingsBadge}>
              <Text style={dynamicStyles.savingsText}>
                -{getSavingsPercent("plus")}%
              </Text>
            </View>
          </TouchableOpacity>
        </Animated.View>

        {/* Plan Cards */}
        {PLANS.map((plan, index) => {
          const isSelected = selectedPlan === plan.id;
          const isCurrent = subscriptionPlan === plan.id;
          const features = t(plan.featuresKey, {
            returnObjects: true,
          }) as string[];
          const realPrice = getRealPrice(plan.id, billingPeriod);
          const price = realPrice ?? getPlanPrice(plan.id, billingPeriod);
          const yearlyTotal =
            billingPeriod === "yearly" ? getPlanTotalYearly(plan.id) : null;

          return (
            <Animated.View
              key={plan.id}
              entering={FadeInUp.delay(300 + index * 150)
                .duration(500)
                .springify()}
            >
              <TouchableOpacity
                activeOpacity={0.85}
                onPress={() => setSelectedPlan(plan.id)}
                style={[
                  dynamicStyles.planCardWrapper,
                  isSelected && dynamicStyles.planCardWrapperSelected,
                ]}
              >
                {/* Popular Badge */}
                {plan.popular && (
                  <View
                    style={[
                      staticStyles.popularBadge,
                      dynamicStyles.popularBadgeBackground,
                    ]}
                  >
                    <Text
                      style={[
                        staticStyles.popularBadgeText,
                        dynamicStyles.popularBadgeColor,
                      ]}
                    >
                      {t("subscription_screen.most_popular")}
                    </Text>
                  </View>
                )}

                <LinearGradient
                  colors={
                    plan.id === "free"
                      ? [colors.surfaceVariant, colors.border]
                      : plan.gradient
                  }
                  start={{ x: 0, y: 0 }}
                  end={{ x: 1, y: 1 }}
                  style={staticStyles.planCardGradient}
                >
                  <View style={staticStyles.planCardHeader}>
                    <View style={staticStyles.planIconCircle}>
                      <Icon
                        name={plan.icon as IconName}
                        size={24}
                        color={
                          plan.id === "free"
                            ? colors.text
                            : colors.textOnPrimary
                        }
                      />
                    </View>
                    <View style={staticStyles.planNameContainer}>
                      <Text
                        style={[
                          staticStyles.planName,
                          plan.id === "free"
                            ? { color: colors.text }
                            : dynamicStyles.planNameColor,
                        ]}
                      >
                        {plan.id === "free"
                          ? t("subscription_screen.plan_free")
                          : plan.id === "plus"
                            ? "Plus"
                            : "Pro"}
                      </Text>
                      {isCurrent && (
                        <View style={staticStyles.activeBadge}>
                          <Text
                            style={[
                              staticStyles.activeBadgeText,
                              dynamicStyles.activeBadgeTextColor,
                            ]}
                          >
                            {t("subscription_screen.active_badge")}
                          </Text>
                        </View>
                      )}
                    </View>
                    <View style={staticStyles.priceContainer}>
                      <Text
                        style={[
                          staticStyles.planPrice,
                          plan.id === "free"
                            ? { color: colors.text }
                            : dynamicStyles.planPriceColor,
                        ]}
                      >
                        {price}
                      </Text>
                      {plan.id !== "free" && (
                        <Text style={staticStyles.planPeriod}>
                          {t("subscription_screen.per_month")}
                        </Text>
                      )}
                      {yearlyTotal && (
                        <Text style={dynamicStyles.yearlyTotal}>
                          {yearlyTotal}
                          {t("subscription_screen.per_year")}
                        </Text>
                      )}
                    </View>
                  </View>
                </LinearGradient>

                {/* Features */}
                <View style={staticStyles.planFeatures}>
                  {features.map((feature, i) => (
                    <View key={i} style={staticStyles.featureRow}>
                      <Icon
                        name="check-circle"
                        size={18}
                        color={
                          plan.id === "free"
                            ? colors.success
                            : plan.id === "plus"
                              ? colors.primary
                              : colors.accent
                        }
                      />
                      <Text style={dynamicStyles.featureText}>{feature}</Text>
                    </View>
                  ))}
                </View>

                {/* Selection Indicator */}
                <View style={staticStyles.selectionIndicator}>
                  <View
                    style={[
                      dynamicStyles.radioOuter,
                      isSelected && dynamicStyles.radioOuterSelected,
                    ]}
                  >
                    {isSelected && <View style={dynamicStyles.radioInner} />}
                  </View>
                  <Text
                    style={[
                      dynamicStyles.selectText,
                      isSelected && dynamicStyles.selectTextActive,
                    ]}
                  >
                    {isSelected
                      ? t("subscription_screen.selected")
                      : t("subscription_screen.select")}
                  </Text>
                </View>
              </TouchableOpacity>
            </Animated.View>
          );
        })}

        {/* Feature Comparison Table */}
        <Animated.View
          entering={FadeInDown.delay(800).duration(400)}
          style={dynamicStyles.comparisonSection}
        >
          <Text style={dynamicStyles.comparisonTitle}>
            {t("subscription_screen.comparison_title")}
          </Text>

          {/* Table Header */}
          <View style={dynamicStyles.tableHeader}>
            <Text
              style={[
                dynamicStyles.tableHeaderCell,
                staticStyles.tableFeatureCol,
              ]}
            >
              {t("subscription_screen.comparison_col_feature")}
            </Text>
            <Text style={dynamicStyles.tableHeaderCell}>
              {t("subscription_screen.comparison_col_free")}
            </Text>
            <Text style={dynamicStyles.tableHeaderCell}>Plus</Text>
            <Text style={dynamicStyles.tableHeaderCell}>Pro</Text>
          </View>

          {/* Table Rows */}
          {COMPARISON.map((row, i) => {
            const locale = language === "tr" ? "tr" : "en";
            return (
              <View
                key={i}
                style={[
                  staticStyles.tableRow,
                  i % 2 === 0 && dynamicStyles.tableRowAlt,
                ]}
              >
                <View
                  style={[
                    staticStyles.tableCell,
                    staticStyles.tableFeatureCol,
                    { flexDirection: "row", alignItems: "center", gap: 6 },
                  ]}
                >
                  <Icon
                    name={row.icon as IconName}
                    size={16}
                    color={colors.textSecondary}
                  />
                  <Text style={dynamicStyles.tableCellText} numberOfLines={1}>
                    {t(row.labelKey)}
                  </Text>
                </View>
                <Text
                  style={[
                    staticStyles.tableCell,
                    dynamicStyles.tableCellText,
                    staticStyles.tableCellCenter,
                  ]}
                >
                  {formatLimit("free", row.feature, locale)}
                </Text>
                <Text
                  style={[
                    staticStyles.tableCell,
                    dynamicStyles.tableCellText,
                    staticStyles.tableCellCenter,
                    { color: colors.primary },
                  ]}
                >
                  {formatLimit("plus", row.feature, locale)}
                </Text>
                <Text
                  style={[
                    staticStyles.tableCell,
                    dynamicStyles.tableCellText,
                    staticStyles.tableCellCenter,
                    { color: colors.accent },
                  ]}
                >
                  {formatLimit("pro", row.feature, locale)}
                </Text>
              </View>
            );
          })}
        </Animated.View>

        {/* CTA Button */}
        <Animated.View
          entering={FadeInDown.delay(900).duration(400)}
          style={staticStyles.ctaContainer}
        >
          {isLoading ? (
            <ActivityIndicator
              size="large"
              color={colors.primary}
              style={{ paddingVertical: Spacing.md }}
            />
          ) : (
            <Button
              title={
                selectedPlan === subscriptionPlan
                  ? t("subscription_screen.cta_current")
                  : selectedPlan === "free"
                    ? t("subscription_screen.cta_switch_free")
                    : selectedPlan === "plus"
                      ? t("subscription_screen.cta_upgrade_plus")
                      : t("subscription_screen.cta_upgrade_pro")
              }
              onPress={handleSubscribe}
              fullWidth
              size="lg"
              disabled={selectedPlan === subscriptionPlan}
              style={{
                backgroundColor:
                  selectedPlan === subscriptionPlan
                    ? colors.border
                    : selectedPlan === "plus"
                      ? colors.primary
                      : selectedPlan === "pro"
                        ? colors.accent
                        : colors.success,
              }}
            />
          )}
        </Animated.View>

        {/* Restore & Terms */}
        <Animated.View
          entering={FadeInDown.delay(1000).duration(400)}
          style={staticStyles.footerActions}
        >
          <TouchableOpacity
            onPress={handleRestore}
            style={staticStyles.footerButton}
          >
            <Icon name="restore" size={18} color={colors.primary} />
            <Text style={dynamicStyles.footerButtonText}>
              {t("subscription_screen.restore_purchases")}
            </Text>
          </TouchableOpacity>

          <TouchableOpacity
            onPress={() => router.push("/settings/terms")}
            style={staticStyles.footerButton}
          >
            <Icon
              name="file-document-outline"
              size={18}
              color={colors.textTertiary}
            />
            <Text style={dynamicStyles.termsText}>
              {t("subscription_screen.terms_privacy")}
            </Text>
          </TouchableOpacity>
        </Animated.View>

        {/* Disclaimer */}
        <Text style={dynamicStyles.disclaimer}>
          {t("subscription_screen.disclaimer")}
        </Text>
      </ScrollView>
    </ScreenErrorBoundary>
  );
}

// ---------------------------------------------------------------------------
// Static styles (theme-independent)
// ---------------------------------------------------------------------------

const staticStyles = StyleSheet.create({
  content: {
    paddingBottom: Spacing.xxl + Spacing.lg,
  },
  header: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.lg,
    paddingTop: Spacing.xxl + Spacing.md,
    paddingBottom: Spacing.md,
    gap: Spacing.md,
  },
  headerTextContainer: {
    flex: 1,
  },
  popularBadge: {
    position: "absolute",
    top: -1,
    right: 16,
    zIndex: 10,
    paddingHorizontal: Spacing.md,
    paddingVertical: 4,
    borderBottomLeftRadius: BorderRadius.sm,
    borderBottomRightRadius: BorderRadius.sm,
  },
  popularBadgeText: {
    ...Typography.caption,
    fontWeight: "700",
  },
  planCardGradient: {
    padding: Spacing.md,
  },
  planCardHeader: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
  },
  planIconCircle: {
    width: 44,
    height: 44,
    borderRadius: 22,
    backgroundColor: "rgba(255,255,255,0.2)",
    alignItems: "center",
    justifyContent: "center",
  },
  planNameContainer: {
    flex: 1,
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  planName: {
    ...Typography.h3,
  },
  activeBadge: {
    backgroundColor: "rgba(255,255,255,0.3)",
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: BorderRadius.full,
  },
  activeBadgeText: {
    ...Typography.caption,
    fontWeight: "600",
  },
  priceContainer: {
    alignItems: "flex-end",
  },
  planPrice: {
    ...Typography.h2,
  },
  planPeriod: {
    ...Typography.caption,
    color: "rgba(255,255,255,0.8)",
  },
  planFeatures: {
    padding: Spacing.md,
    gap: Spacing.sm,
  },
  featureRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  selectionIndicator: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.sm,
    paddingBottom: Spacing.md,
    paddingTop: Spacing.xs,
  },
  // Comparison Table
  tableFeatureCol: {
    flex: 2,
    textAlign: "left",
    paddingLeft: Spacing.xs,
  },
  tableRow: {
    flexDirection: "row",
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.sm,
    alignItems: "center",
  },
  tableCell: {
    flex: 1,
  },
  tableCellCenter: {
    textAlign: "center",
  },
  // CTA
  ctaContainer: {
    paddingHorizontal: Spacing.lg,
    marginTop: Spacing.lg,
  },
  // Footer
  footerActions: {
    alignItems: "center",
    marginTop: Spacing.lg,
    gap: Spacing.md,
  },
  footerButton: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  firstSurpriseBanner: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
    marginHorizontal: Spacing.lg,
    marginBottom: Spacing.md,
    padding: Spacing.md,
    borderRadius: BorderRadius.lg,
  },
  firstSurpriseTitle: {
    ...Typography.h4,
  },
  firstSurpriseDesc: {
    ...Typography.caption,
    color: "rgba(255,255,255,0.9)",
    marginTop: 2,
  },
});
