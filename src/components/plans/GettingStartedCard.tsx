import React, { useState, useEffect, useMemo } from "react";
import { View, Text, TouchableOpacity, StyleSheet } from "react-native";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { useTranslation } from "react-i18next";
import { useTheme } from "../../contexts/ThemeContext";
import { Icon } from "../ui/Icon";
import {
  type ThemeColors,
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../constants/theme";

interface Props {
  planId: string;
  onChecklist: () => void;
  onCoOrganizer: () => void;
  onWeather: () => void;
}

export function GettingStartedCard({
  planId,
  onChecklist,
  onCoOrganizer,
  onWeather,
}: Props) {
  const { colors } = useTheme();
  const { t } = useTranslation();
  const styles = useMemo(() => createStyles(colors), [colors]);
  const [dismissed, setDismissed] = useState<boolean | null>(null);

  const storageKey = `getting_started_dismissed_${planId}`;

  useEffect(() => {
    AsyncStorage.getItem(storageKey).then((value) => {
      setDismissed(value === "true");
    });
  }, [storageKey]);

  const handleDismiss = async () => {
    await AsyncStorage.setItem(storageKey, "true");
    setDismissed(true);
  };

  if (dismissed === null || dismissed) return null;

  const steps: {
    icon: "checkbox-marked" | "account-multiple-plus" | "weather-partly-cloudy";
    color: string;
    label: string;
    onPress: () => void;
  }[] = [
    {
      icon: "checkbox-marked",
      color: colors.success,
      label: t("plans.gettingStarted.stepChecklist"),
      onPress: onChecklist,
    },
    {
      icon: "account-multiple-plus",
      color: colors.accent,
      label: t("plans.gettingStarted.stepCoOrganizer"),
      onPress: onCoOrganizer,
    },
    {
      icon: "weather-partly-cloudy",
      color: colors.info,
      label: t("plans.gettingStarted.stepWeather"),
      onPress: onWeather,
    },
  ];

  return (
    <View style={styles.card}>
      <View style={styles.headerRow}>
        <Icon name="rocket-launch" size={20} color={colors.primary} />
        <Text style={styles.title}>{t("plans.gettingStarted.title")}</Text>
        <TouchableOpacity
          onPress={handleDismiss}
          hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}
          accessibilityRole="button"
          accessibilityLabel={t("plans.gettingStarted.dismiss")}
        >
          <Icon name="close" size={18} color={colors.textTertiary} />
        </TouchableOpacity>
      </View>

      <Text style={styles.subtitle}>{t("plans.gettingStarted.subtitle")}</Text>

      {steps.map((step, index) => (
        <TouchableOpacity
          key={index}
          style={styles.stepRow}
          onPress={step.onPress}
          activeOpacity={0.7}
          accessibilityRole="button"
        >
          <Icon name={step.icon} size={18} color={step.color} />
          <Text style={styles.stepLabel}>{step.label}</Text>
        </TouchableOpacity>
      ))}
    </View>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    card: {
      backgroundColor: colors.surface,
      borderColor: colors.borderLight,
      borderWidth: 1,
      borderRadius: BorderRadius.lg,
      padding: Spacing.md,
      marginHorizontal: Spacing.lg,
      marginBottom: Spacing.sm,
      ...Shadows.sm,
    },
    headerRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginBottom: Spacing.xs,
    },
    title: {
      ...Typography.h4,
      color: colors.text,
      flex: 1,
    },
    subtitle: {
      ...Typography.caption,
      color: colors.textSecondary,
      marginBottom: Spacing.sm,
    },
    stepRow: {
      flexDirection: "row",
      alignItems: "center",
      paddingVertical: Spacing.sm,
      gap: Spacing.sm,
    },
    stepLabel: {
      ...Typography.bodySmall,
      color: colors.text,
      flex: 1,
    },
  });
