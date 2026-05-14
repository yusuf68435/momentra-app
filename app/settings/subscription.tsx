import React, { useMemo } from "react";
import { useTranslation } from "react-i18next";
import { View, Text, StyleSheet, ScrollView } from "react-native";
import Animated, { FadeInDown } from "react-native-reanimated";
import { ScreenErrorBoundary } from "../../src/components/common/ScreenErrorBoundary";
import { Icon } from "../../src/components/ui/Icon";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";

/**
 * Subscription screen — v1.0.
 *
 * IAP / RevenueCat integration deferred to v1.1+. For initial App Store
 * release, all features are available for free. This screen is kept on the
 * route so existing navigation links don't break, but renders a simple
 * "all features unlocked" message rather than a paywall.
 */
export default function SubscriptionScreen() {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const styles = useMemo(() => createStyles(colors), [colors]);

  const features: { icon: string; key: string }[] = [
    { icon: "robot", key: "ai_assistant" },
    { icon: "account-group", key: "co_organizer" },
    { icon: "calendar-clock", key: "smart_countdown" },
    { icon: "lock", key: "encrypted_messaging" },
    { icon: "earth", key: "languages" },
    { icon: "image-multiple", key: "unlimited_plans" },
  ];

  return (
    <ScreenErrorBoundary>
      <ScrollView
        style={styles.container}
        contentContainerStyle={styles.content}
        showsVerticalScrollIndicator={false}
      >
        <Animated.View entering={FadeInDown.duration(400)} style={styles.hero}>
          <View style={styles.iconCircle}>
            <Icon name="gift" size={40} color={colors.primary} />
          </View>
          <Text style={styles.title}>
            {t("subscription_v1.heroTitle", "Tüm özellikler senin")}
          </Text>
          <Text style={styles.subtitle}>
            {t(
              "subscription_v1.heroSubtitle",
              "Momentra'nın bu sürümünde tüm özellikler ücretsiz. İlk sürpriz seninle başlasın.",
            )}
          </Text>
        </Animated.View>

        <View style={styles.featuresCard}>
          {features.map((f, idx) => (
            <Animated.View
              key={f.key}
              entering={FadeInDown.delay(100 + idx * 60).duration(300)}
              style={[
                styles.featureRow,
                idx === features.length - 1 && styles.featureRowLast,
              ]}
            >
              <View style={styles.featureIcon}>
                <Icon name={f.icon as never} size={22} color={colors.primary} />
              </View>
              <Text style={styles.featureText}>
                {t(
                  `subscription_v1.feature_${f.key}`,
                  defaultFeatureText(f.key),
                )}
              </Text>
              <Icon name="check" size={20} color={colors.success} />
            </Animated.View>
          ))}
        </View>

        <Animated.View
          entering={FadeInDown.delay(600).duration(400)}
          style={styles.thankYou}
        >
          <Text style={styles.thankYouText}>
            {t(
              "subscription_v1.thanks",
              "Momentra'yı kullandığın için teşekkürler 💜",
            )}
          </Text>
        </Animated.View>
      </ScrollView>
    </ScreenErrorBoundary>
  );
}

function defaultFeatureText(key: string): string {
  switch (key) {
    case "ai_assistant":
      return "AI asistan — sınırsız";
    case "co_organizer":
      return "Co-organizer ile ortak planlama";
    case "smart_countdown":
      return "Akıllı geri sayım & hatırlatmalar";
    case "encrypted_messaging":
      return "Uçtan uca şifreli mesajlaşma";
    case "languages":
      return "17 dil desteği";
    case "unlimited_plans":
      return "Sınırsız sürpriz planı";
    default:
      return key;
  }
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: { flex: 1, backgroundColor: colors.background },
    content: { padding: Spacing.lg, paddingBottom: Spacing.xxl * 2 },
    hero: {
      alignItems: "center",
      paddingVertical: Spacing.xl,
      marginBottom: Spacing.lg,
    },
    iconCircle: {
      width: 88,
      height: 88,
      borderRadius: 44,
      backgroundColor: colors.primary + "15",
      alignItems: "center",
      justifyContent: "center",
      marginBottom: Spacing.lg,
    },
    title: {
      ...Typography.h2,
      color: colors.text,
      textAlign: "center",
      marginBottom: Spacing.sm,
    },
    subtitle: {
      ...Typography.body,
      color: colors.textSecondary,
      textAlign: "center",
      paddingHorizontal: Spacing.md,
      lineHeight: 22,
    },
    featuresCard: {
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      borderWidth: 0.5,
      borderColor: colors.border + "40",
      padding: Spacing.md,
      ...Shadows.sm,
    },
    featureRow: {
      flexDirection: "row",
      alignItems: "center",
      paddingVertical: Spacing.md,
      borderBottomWidth: 0.5,
      borderBottomColor: colors.border + "40",
      gap: Spacing.md,
    },
    featureRowLast: { borderBottomWidth: 0 },
    featureIcon: {
      width: 40,
      height: 40,
      borderRadius: 20,
      backgroundColor: colors.primary + "12",
      alignItems: "center",
      justifyContent: "center",
    },
    featureText: {
      ...Typography.body,
      color: colors.text,
      flex: 1,
    },
    thankYou: {
      marginTop: Spacing.xl,
      padding: Spacing.lg,
      alignItems: "center",
    },
    thankYouText: {
      ...Typography.body,
      color: colors.textSecondary,
      textAlign: "center",
    },
  });
