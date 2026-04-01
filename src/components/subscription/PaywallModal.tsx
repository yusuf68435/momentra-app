/**
 * PaywallModal — Day 0 Free Trial Paywall
 * Triggered on first open / premium feature gate
 * RevenueCat integration with monthly & annual packages
 */
// TODO: migrate to design-system Modal when fullscreen variant is available

import React, { useState, useCallback, useMemo, useEffect } from "react";
import {
  View,
  Text,
  Modal,
  TouchableOpacity,
  StyleSheet,
  ActivityIndicator,
  Alert,
  ScrollView,
  Platform,
} from "react-native";
import { LinearGradient } from "expo-linear-gradient";
import Animated, { FadeInUp, FadeInDown } from "react-native-reanimated";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import { useTheme } from "../../contexts/ThemeContext";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  Gradients,
  type ThemeColors,
} from "../../constants/theme";
import { useTranslation } from "react-i18next";
import {
  initializePurchases,
  getOfferings,
  purchasePackage,
  restorePurchases,
  isPurchasesConfigured,
} from "../../services/purchases";
import { PLAN_PRICES } from "../../services/subscription";

// ─── Types ────────────────────────────────────────────────────────────────────

interface PricingOption {
  id: "monthly" | "annual";
  labelKey: string;
  price: string;
  perMonthKey: string;
  badgeKey?: string;
}

interface FeatureItem {
  icon: IconName;
  titleKey: string;
  descKey: string;
}

interface PaywallModalProps {
  visible: boolean;
  onClose: () => void;
  onPurchaseSuccess?: () => void;
}

// ─── Constants ────────────────────────────────────────────────────────────────

const PRICING_OPTIONS: PricingOption[] = [
  {
    id: "annual",
    labelKey: "paywall.annualLabel",
    price: PLAN_PRICES.plus.yearly,
    perMonthKey: "paywall.annualPerMonth",
    badgeKey: "paywall.annualBadge",
  },
  {
    id: "monthly",
    labelKey: "paywall.monthlyLabel",
    price: PLAN_PRICES.plus.monthly,
    perMonthKey: "paywall.monthlyPerMonth",
  },
];

const FEATURES: FeatureItem[] = [
  {
    icon: "robot-outline",
    titleKey: "paywall.feature1Title",
    descKey: "paywall.feature1Desc",
  },
  {
    icon: "incognito",
    titleKey: "paywall.feature2Title",
    descKey: "paywall.feature2Desc",
  },
  {
    icon: "account-group-outline",
    titleKey: "paywall.feature3Title",
    descKey: "paywall.feature3Desc",
  },
  {
    icon: "lock-outline",
    titleKey: "paywall.feature4Title",
    descKey: "paywall.feature4Desc",
  },
];

// ─── Component ────────────────────────────────────────────────────────────────

export function PaywallModal({
  visible,
  onClose,
  onPurchaseSuccess,
}: PaywallModalProps) {
  const { colors, isDark } = useTheme();
  const { t, i18n } = useTranslation();
  const lang = i18n.language as "tr" | "en";

  const [selectedPlan, setSelectedPlan] = useState<"monthly" | "annual">(
    "annual",
  );
  const [loading, setLoading] = useState(false);
  const [offerings, setOfferings] = useState<Awaited<
    ReturnType<typeof getOfferings>
  > | null>(null);

  const styles = useMemo(() => createStyles(colors), [colors]);

  useEffect(() => {
    if (!visible) return;
    (async () => {
      const ok = await initializePurchases();
      if (ok) {
        const off = await getOfferings();
        setOfferings(off);
      }
    })();
  }, [visible]);

  const handleStartTrial = useCallback(async () => {
    setLoading(true);
    try {
      if (
        isPurchasesConfigured() &&
        (offerings?.current?.availablePackages?.length ?? 0) > 0
      ) {
        // Find matching package: annual → yearly, monthly → monthly
        const packages = offerings!.current!.availablePackages;
        const period = selectedPlan === "annual" ? "yearly" : "monthly";
        const pkg =
          packages.find(
            (p: { identifier: string; product: { identifier: string } }) =>
              p.identifier.toLowerCase().includes(period) ||
              p.product.identifier.toLowerCase().includes(period),
          ) ?? packages[0];

        if (pkg) {
          const customerInfo = await purchasePackage(pkg);
          if (customerInfo) {
            onPurchaseSuccess?.();
            onClose();
            return;
          }
          // null = user cancelled
          return;
        }
      }
      // Fallback demo mode
      await new Promise((r) => setTimeout(r, 1200));
      onPurchaseSuccess?.();
      onClose();
    } catch (e: unknown) {
      if (
        e &&
        typeof e === "object" &&
        "userCancelled" in e &&
        (e as { userCancelled?: boolean }).userCancelled
      )
        return;
      Alert.alert(t("paywall.errorTitle"), t("paywall.errorBody"));
    } finally {
      setLoading(false);
    }
  }, [selectedPlan, lang, onClose, onPurchaseSuccess, offerings, t]);

  const handleRestore = useCallback(async () => {
    setLoading(true);
    try {
      if (isPurchasesConfigured()) {
        const customerInfo = await restorePurchases();
        if (customerInfo) {
          Alert.alert(t("paywall.successTitle"), t("paywall.successBody"));
          return;
        }
      }
      // Fallback
      await new Promise((r) => setTimeout(r, 800));
      Alert.alert(t("paywall.successTitle"), t("paywall.successBody"));
    } catch {
      // ignore
    } finally {
      setLoading(false);
    }
  }, [t]);

  return (
    <Modal
      visible={visible}
      animationType="slide"
      presentationStyle="pageSheet"
      onRequestClose={onClose}
    >
      <View style={styles.root}>
        <LinearGradient
          colors={[
            Gradients.surprise[0],
            Gradients.surprise[1],
            colors.background,
          ]}
          locations={[0, 0.35, 0.65]}
          style={styles.heroGradient}
        />

        {/* Close button */}
        <TouchableOpacity
          style={styles.closeBtn}
          onPress={onClose}
          hitSlop={{ top: 12, bottom: 12, left: 12, right: 12 }}
        >
          <Icon name="close" size={22} color={colors.textTertiary} />
        </TouchableOpacity>

        <ScrollView
          showsVerticalScrollIndicator={false}
          contentContainerStyle={styles.scrollContent}
          bounces={false}
        >
          {/* Hero */}
          <Animated.View
            entering={FadeInDown.duration(500)}
            style={styles.hero}
          >
            <View
              style={[
                styles.heroIcon,
                { backgroundColor: colors.primary + "20" },
              ]}
            >
              <Icon name="star-outline" size={40} color={colors.primary} />
            </View>
            <Text style={[styles.heroTitle, { color: colors.text }]}>
              {t("paywall.heroTitle")}
            </Text>
            <Text
              style={[styles.heroSubtitle, { color: colors.textSecondary }]}
            >
              {t("paywall.heroSubtitle")}
            </Text>
          </Animated.View>

          {/* Features */}
          <View style={styles.featuresSection}>
            {FEATURES.map((f, i) => (
              <Animated.View
                key={f.icon}
                entering={FadeInUp.duration(400).delay(i * 80)}
              >
                <View
                  style={[
                    styles.featureRow,
                    { borderBottomColor: colors.borderLight },
                  ]}
                >
                  <View
                    style={[
                      styles.featureIconBg,
                      { backgroundColor: colors.primary + "15" },
                    ]}
                  >
                    <Icon name={f.icon} size={20} color={colors.primary} />
                  </View>
                  <View style={styles.featureText}>
                    <Text style={[styles.featureTitle, { color: colors.text }]}>
                      {t(f.titleKey)}
                    </Text>
                    <Text
                      style={[
                        styles.featureDesc,
                        { color: colors.textSecondary },
                      ]}
                    >
                      {t(f.descKey)}
                    </Text>
                  </View>
                  <Icon name="check-circle" size={18} color={colors.success} />
                </View>
              </Animated.View>
            ))}
          </View>

          {/* Pricing toggle */}
          <View style={styles.pricingSection}>
            {PRICING_OPTIONS.map((opt) => (
              <TouchableOpacity
                key={opt.id}
                style={[
                  styles.pricingCard,
                  {
                    backgroundColor:
                      selectedPlan === opt.id
                        ? colors.primary + "12"
                        : colors.surfaceVariant,
                    borderColor:
                      selectedPlan === opt.id
                        ? colors.primary
                        : colors.borderLight,
                  },
                ]}
                onPress={() => setSelectedPlan(opt.id)}
                activeOpacity={0.8}
              >
                <View style={styles.pricingLeft}>
                  <View
                    style={[
                      styles.radioOuter,
                      {
                        borderColor:
                          selectedPlan === opt.id
                            ? colors.primary
                            : colors.textTertiary,
                      },
                    ]}
                  >
                    {selectedPlan === opt.id && (
                      <View
                        style={[
                          styles.radioInner,
                          { backgroundColor: colors.primary },
                        ]}
                      />
                    )}
                  </View>
                  <View>
                    <Text style={[styles.pricingLabel, { color: colors.text }]}>
                      {t(opt.labelKey)}
                    </Text>
                    <Text
                      style={[
                        styles.pricingPerMonth,
                        { color: colors.textTertiary },
                      ]}
                    >
                      {t(opt.perMonthKey)}
                    </Text>
                  </View>
                </View>
                <View style={styles.pricingRight}>
                  <Text style={[styles.pricingPrice, { color: colors.text }]}>
                    {opt.price}
                  </Text>
                  {opt.badgeKey && (
                    <View
                      style={[
                        styles.pricingBadge,
                        { backgroundColor: colors.success + "20" },
                      ]}
                    >
                      <Text
                        style={[
                          styles.pricingBadgeText,
                          { color: colors.success },
                        ]}
                      >
                        {t(opt.badgeKey)}
                      </Text>
                    </View>
                  )}
                </View>
              </TouchableOpacity>
            ))}
          </View>

          {/* CTA */}
          <View style={styles.ctaSection}>
            <TouchableOpacity
              style={[styles.ctaBtn, { opacity: loading ? 0.7 : 1 }]}
              onPress={handleStartTrial}
              disabled={loading}
              activeOpacity={0.85}
            >
              <LinearGradient
                colors={Gradients.joy}
                start={{ x: 0, y: 0 }}
                end={{ x: 1, y: 0 }}
                style={styles.ctaGradient}
              >
                {loading ? (
                  <ActivityIndicator
                    color={colors.textOnPrimary}
                    size="small"
                  />
                ) : (
                  <Text style={styles.ctaBtnText}>
                    {t("paywall.ctaButton")}
                  </Text>
                )}
              </LinearGradient>
            </TouchableOpacity>

            <Text style={[styles.trialNote, { color: colors.textTertiary }]}>
              {t("paywall.trialNote")}
            </Text>

            <TouchableOpacity onPress={handleRestore} style={styles.restoreBtn}>
              <Text
                style={[styles.restoreText, { color: colors.textTertiary }]}
              >
                {t("paywall.restoreButton")}
              </Text>
            </TouchableOpacity>
          </View>
        </ScrollView>
      </View>
    </Modal>
  );
}

// ─── Styles ───────────────────────────────────────────────────────────────────

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    root: {
      flex: 1,
      backgroundColor: colors.background,
    },
    heroGradient: {
      position: "absolute",
      top: 0,
      left: 0,
      right: 0,
      height: 320,
    },
    closeBtn: {
      position: "absolute",
      top: Platform.select({ ios: 16, default: 12 }),
      right: Spacing.md,
      zIndex: 10,
      width: 36,
      height: 36,
      borderRadius: 18,
      backgroundColor: colors.surfaceVariant + "CC",
      alignItems: "center",
      justifyContent: "center",
    },
    scrollContent: {
      paddingBottom: 40,
    },
    hero: {
      alignItems: "center",
      paddingTop: 56,
      paddingBottom: Spacing.lg,
      paddingHorizontal: Spacing.lg,
    },
    heroIcon: {
      width: 80,
      height: 80,
      borderRadius: 40,
      alignItems: "center",
      justifyContent: "center",
      marginBottom: Spacing.md,
    },
    heroTitle: {
      ...Typography.h1,
      textAlign: "center",
      marginBottom: Spacing.sm,
    },
    heroSubtitle: {
      ...Typography.body,
      textAlign: "center",
      lineHeight: 24,
    },
    featuresSection: {
      marginHorizontal: Spacing.lg,
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.xl,
      borderWidth: 1,
      borderColor: colors.borderLight,
      marginBottom: Spacing.lg,
      overflow: "hidden",
      ...Shadows.sm,
    },
    featureRow: {
      flexDirection: "row",
      alignItems: "center",
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.smd,
      gap: Spacing.md,
      borderBottomWidth: 0.5,
    },
    featureIconBg: {
      width: 36,
      height: 36,
      borderRadius: 10,
      alignItems: "center",
      justifyContent: "center",
    },
    featureText: {
      flex: 1,
    },
    featureTitle: {
      ...Typography.bodySmall,
      fontWeight: "600",
    },
    featureDesc: {
      ...Typography.caption,
      marginTop: 1,
    },
    pricingSection: {
      marginHorizontal: Spacing.lg,
      gap: Spacing.sm,
      marginBottom: Spacing.lg,
    },
    pricingCard: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "space-between",
      padding: Spacing.md,
      borderRadius: BorderRadius.lg,
      borderWidth: 1.5,
    },
    pricingLeft: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.md,
    },
    radioOuter: {
      width: 20,
      height: 20,
      borderRadius: 10,
      borderWidth: 2,
      alignItems: "center",
      justifyContent: "center",
    },
    radioInner: {
      width: 10,
      height: 10,
      borderRadius: 5,
    },
    pricingLabel: {
      ...Typography.body,
      fontWeight: "600",
    },
    pricingPerMonth: {
      ...Typography.caption,
    },
    pricingRight: {
      alignItems: "flex-end",
      gap: 4,
    },
    pricingPrice: {
      ...Typography.h3,
      fontWeight: "700",
    },
    pricingBadge: {
      paddingHorizontal: 8,
      paddingVertical: 2,
      borderRadius: BorderRadius.full,
    },
    pricingBadgeText: {
      ...Typography.label,
      fontWeight: "700",
    },
    ctaSection: {
      paddingHorizontal: Spacing.lg,
      alignItems: "center",
      gap: Spacing.sm,
    },
    ctaBtn: {
      width: "100%",
      borderRadius: BorderRadius.xl,
      overflow: "hidden",
      ...Shadows.primaryGlow,
    },
    ctaGradient: {
      paddingVertical: 16,
      alignItems: "center",
      justifyContent: "center",
    },
    ctaBtnText: {
      ...Typography.button,
      color: colors.textOnPrimary,
      fontWeight: "700",
    },
    trialNote: {
      ...Typography.caption,
      textAlign: "center",
      lineHeight: 18,
    },
    restoreBtn: {
      paddingVertical: Spacing.sm,
    },
    restoreText: {
      ...Typography.caption,
      textDecorationLine: "underline",
    },
  });
