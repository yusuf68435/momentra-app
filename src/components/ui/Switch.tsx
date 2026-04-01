import React from "react";
import {
  Switch as RNSwitch,
  View,
  Text,
  StyleSheet,
  Platform,
} from "react-native";
import { useTheme } from "../../contexts/ThemeContext";
import { Spacing, Typography, TouchTargets } from "../../constants/theme";
import type { ThemeColors } from "../../constants/theme";

interface SwitchProps {
  value: boolean;
  onValueChange: (value: boolean) => void;
  disabled?: boolean;
  color?: string;
  label?: string;
}

export function Switch({
  value,
  onValueChange,
  disabled = false,
  color,
  label,
}: SwitchProps) {
  const { colors } = useTheme();
  const activeColor = color ?? colors.primary;

  return (
    <View style={[styles.row, disabled && styles.disabled]}>
      {label != null && (
        <Text style={[createLabelStyle(colors), styles.label]}>{label}</Text>
      )}
      <RNSwitch
        value={value}
        onValueChange={onValueChange}
        disabled={disabled}
        trackColor={{ false: colors.border, true: activeColor + "40" }}
        thumbColor={value ? activeColor : colors.textTertiary}
        ios_backgroundColor={colors.border}
      />
    </View>
  );
}

const createLabelStyle = (colors: ThemeColors) =>
  StyleSheet.create({
    text: {
      ...Typography.body,
      color: colors.text,
    },
  }).text;

const styles = StyleSheet.create({
  row: {
    flexDirection: "row",
    alignItems: "center",
    minHeight: TouchTargets.minimum,
    gap: Spacing.md,
  },
  label: {
    flex: 1,
  },
  disabled: {
    opacity: 0.5,
  },
});
