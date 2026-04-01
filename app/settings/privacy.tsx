import React, { useMemo } from "react";
import { ScrollView, Text, StyleSheet } from "react-native";
import { ScreenErrorBoundary } from "../../src/components/common/ScreenErrorBoundary";
import { useTranslation } from "react-i18next";
import {
  Spacing,
  Typography,
  type ThemeColors,
} from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";

export default function PrivacyPolicyScreen() {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const styles = useMemo(() => createStyles(colors), [colors]);

  return (
    <ScreenErrorBoundary>
      <ScrollView
        style={styles.container}
        contentContainerStyle={styles.content}
      >
        <Text style={styles.title}>{t("privacy.title")}</Text>
        <Text style={styles.date}>{t("privacy.date")}</Text>

        <Text style={styles.heading}>{t("privacy.section1Title")}</Text>
        <Text style={styles.body}>{t("privacy.section1Body")}</Text>

        <Text style={styles.heading}>{t("privacy.section2Title")}</Text>
        <Text style={styles.body}>{t("privacy.section2Body")}</Text>

        <Text style={styles.heading}>{t("privacy.section3Title")}</Text>
        <Text style={styles.body}>{t("privacy.section3Body")}</Text>

        <Text style={styles.heading}>{t("privacy.section4Title")}</Text>
        <Text style={styles.body}>{t("privacy.section4Body")}</Text>

        <Text style={styles.heading}>{t("privacy.section5Title")}</Text>
        <Text style={styles.body}>{t("privacy.section5Body")}</Text>

        <Text style={styles.heading}>{t("privacy.section6Title")}</Text>
        <Text style={styles.body}>{t("privacy.section6Body")}</Text>
      </ScrollView>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: { flex: 1, backgroundColor: colors.background },
    content: { padding: Spacing.lg, paddingBottom: Spacing.xxl },
    title: { ...Typography.h2, color: colors.text, marginBottom: Spacing.xs },
    date: {
      ...Typography.caption,
      color: colors.textTertiary,
      marginBottom: Spacing.xl,
    },
    heading: {
      ...Typography.h4,
      color: colors.text,
      marginTop: Spacing.lg,
      marginBottom: Spacing.sm,
    },
    body: { ...Typography.body, color: colors.textSecondary, lineHeight: 24 },
  });
