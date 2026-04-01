import React, { useMemo, useState } from "react";
import { View, Text, StyleSheet, TouchableOpacity } from "react-native";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import { LinearGradient } from "expo-linear-gradient";
import { PaywallModal } from "../subscription/PaywallModal";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";
import { useSettingsStore } from "../../stores/settingsStore";
import {
  type SubscriptionPlan,
  isPlanAtLeast,
  isFirstSurpriseFreeActive,
} from "../../services/subscription";

interface PremiumGateProps {
  /** The minimum plan required to access the gated content */
  requiredPlan: SubscriptionPlan;
  /** Human-readable feature name shown in the upgrade prompt */
  feature: string;
  /** Content rendered when the user meets the plan requirement */
  children: React.ReactNode;
  /** Optional custom fallback; overrides the default upgrade card */
  fallback?: React.ReactNode;
}

/**
 * Wraps content behind a subscription check.
 *
 * If the user's current plan is equal to or higher than `requiredPlan`,
 * the children are rendered normally. Otherwise an upgrade prompt card
 * is shown (or a custom fallback if provided).
 */
export function PremiumGate({
  requiredPlan,
  feature,
  children,
  fallback,
}: PremiumGateProps) {
  const { subscriptionPlan, firstSurpriseCompleted } = useSettingsStore();
  const { colors } = useTheme();
  const { t } = useTranslation();
  const [showPaywall, setShowPaywall] = useState(false);

  // Bypass premium gate for the first surprise
  if (isFirstSurpriseFreeActive(subscriptionPlan, firstSurpriseCompleted)) {
    return <>{children}</>;
  }

  if (isPlanAtLeast(subscriptionPlan, requiredPlan)) {
    return <>{children}</>;
  }

  if (fallback) {
    return <>{fallback}</>;
  }

  const planLabel = requiredPlan === "plus" ? "Plus" : "Pro";
  const gradientColors: [string, string] =
    requiredPlan === "plus"
      ? [colors.primary, colors.primaryDark]
      : [colors.accent, "#7B1FA2"];

  const iconName = requiredPlan === "plus" ? "star-four-points" : "crown";

  return (
    <View style={styles.container}>
      <LinearGradient
        colors={gradientColors}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 1 }}
        style={styles.gradient}
      >
        <View style={styles.iconCircle}>
          <Icon
            name={iconName as IconName}
            size={28}
            color={colors.textOnPrimary}
          />
        </View>

        <Text style={[styles.title, { color: colors.textOnPrimary }]}>
          {t("premium_gate.feature_label", { plan: planLabel })}
        </Text>

        <Text style={styles.description}>
          {t("premium_gate.upgrade_desc", { plan: planLabel, feature })}
        </Text>

        <TouchableOpacity
          activeOpacity={0.85}
          style={[
            styles.upgradeButton,
            { backgroundColor: colors.textOnPrimary },
          ]}
          onPress={() => setShowPaywall(true)}
        >
          <Icon name="rocket-launch" size={18} color={gradientColors[0]} />
          <Text
            style={[styles.upgradeButtonText, { color: gradientColors[0] }]}
          >
            {t("premium_gate.upgrade_button")}
          </Text>
        </TouchableOpacity>
      </LinearGradient>
      <PaywallModal
        visible={showPaywall}
        onClose={() => setShowPaywall(false)}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    marginHorizontal: Spacing.lg,
    marginVertical: Spacing.md,
    borderRadius: BorderRadius.lg,
    overflow: "hidden",
    ...Shadows.md,
  },
  gradient: {
    padding: Spacing.lg,
    alignItems: "center",
  },
  iconCircle: {
    width: 56,
    height: 56,
    borderRadius: 28,
    backgroundColor: "rgba(255,255,255,0.2)",
    alignItems: "center",
    justifyContent: "center",
    marginBottom: Spacing.md,
  },
  title: {
    ...Typography.h4,
    textAlign: "center",
    marginBottom: Spacing.sm,
  },
  description: {
    ...Typography.bodySmall,
    color: "rgba(255,255,255,0.85)",
    textAlign: "center",
    marginBottom: Spacing.lg,
    lineHeight: 20,
    paddingHorizontal: Spacing.md,
  },
  upgradeButton: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    paddingHorizontal: Spacing.lg,
    paddingVertical: Spacing.sm + 2,
    borderRadius: BorderRadius.full,
  },
  upgradeButtonText: {
    ...Typography.button,
    fontWeight: "700",
  },
});
