import React, { useState, useEffect, useMemo } from "react";
import { View, Text, StyleSheet } from "react-native";
import { useTranslation } from "react-i18next";
import { useTheme } from "../../contexts/ThemeContext";
import {
  Spacing,
  Typography,
  BorderRadius,
  type ThemeColors,
} from "../../constants/theme";

interface CountdownTimerProps {
  targetDate: string;
  targetTime?: string | null;
}

interface TimeLeft {
  days: number;
  hours: number;
  minutes: number;
  seconds: number;
}

function calculateTimeLeft(
  targetDate: string,
  targetTime?: string | null,
): TimeLeft {
  const target = targetTime
    ? new Date(`${targetDate}T${targetTime}`)
    : new Date(`${targetDate}T00:00:00`);
  const now = new Date();
  const diff = target.getTime() - now.getTime();

  if (isNaN(diff) || diff <= 0)
    return { days: 0, hours: 0, minutes: 0, seconds: 0 };

  return {
    days: Math.floor(diff / (1000 * 60 * 60 * 24)),
    hours: Math.floor((diff / (1000 * 60 * 60)) % 24),
    minutes: Math.floor((diff / (1000 * 60)) % 60),
    seconds: Math.floor((diff / 1000) % 60),
  };
}

export function CountdownTimer({
  targetDate,
  targetTime,
}: CountdownTimerProps) {
  const { t } = useTranslation("plans");
  const { colors } = useTheme();
  const [timeLeft, setTimeLeft] = useState<TimeLeft>(() =>
    calculateTimeLeft(targetDate, targetTime),
  );
  const styles = useMemo(() => createStyles(colors), [colors]);

  useEffect(() => {
    const interval = setInterval(() => {
      setTimeLeft(calculateTimeLeft(targetDate, targetTime));
    }, 1000);
    return () => clearInterval(interval);
  }, [targetDate, targetTime]);

  const blocks = [
    { value: timeLeft.days, label: t("countdown_labels.days") },
    { value: timeLeft.hours, label: t("countdown_labels.hours") },
    { value: timeLeft.minutes, label: t("countdown_labels.minutes") },
    { value: timeLeft.seconds, label: t("countdown_labels.seconds") },
  ];

  return (
    <View style={styles.container}>
      {blocks.map((block, index) => (
        <React.Fragment key={block.label}>
          <View style={styles.block}>
            <Text style={styles.value}>
              {String(block.value).padStart(2, "0")}
            </Text>
            <Text style={styles.label}>{block.label}</Text>
          </View>
          {index < blocks.length - 1 && <Text style={styles.separator}>:</Text>}
        </React.Fragment>
      ))}
    </View>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
    },
    block: {
      alignItems: "center",
      backgroundColor: colors.primary,
      borderRadius: BorderRadius.md,
      paddingHorizontal: Spacing.md + 2,
      paddingVertical: Spacing.sm + 2,
      minWidth: 66,
    },
    value: {
      fontSize: 26,
      fontWeight: "700",
      color: colors.textOnPrimary,
      letterSpacing: 1,
      fontVariant: ["tabular-nums"],
    },
    label: {
      ...Typography.caption,
      color: colors.textOnPrimary,
      opacity: 0.75,
      marginTop: 2,
      fontWeight: "500",
    },
    separator: {
      fontSize: 24,
      fontWeight: "600",
      color: colors.primary,
    },
  });
