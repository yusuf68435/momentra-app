import React from "react";
import { TouchableOpacity, Text, View, StyleSheet } from "react-native";
import { Icon } from "./Icon";
import { useTheme } from "../../contexts/ThemeContext";
import { Spacing, Typography, TouchTargets } from "../../constants/theme";
import type { ThemeColors } from "../../constants/theme";

interface CheckboxProps {
  checked: boolean;
  onToggle: () => void;
  disabled?: boolean;
  color?: string;
  label?: string;
  size?: number;
}

export function Checkbox({
  checked,
  onToggle,
  disabled = false,
  color,
  label,
  size = 24,
}: CheckboxProps) {
  const { colors } = useTheme();
  const activeColor = color ?? colors.success;
  const iconColor = checked ? activeColor : colors.textTertiary;
  const dynamicStyles = createDynamicStyles(colors);

  return (
    <TouchableOpacity
      style={[styles.row, disabled && styles.disabled]}
      onPress={onToggle}
      disabled={disabled}
      activeOpacity={0.7}
      accessible
      accessibilityRole="checkbox"
      accessibilityState={{ checked, disabled }}
    >
      <Icon
        name={
          checked ? "checkbox-marked-circle" : "checkbox-blank-circle-outline"
        }
        size={size}
        color={iconColor}
      />
      {label != null && (
        <Text
          style={[dynamicStyles.label, checked && dynamicStyles.labelChecked]}
        >
          {label}
        </Text>
      )}
    </TouchableOpacity>
  );
}

const createDynamicStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    label: {
      ...Typography.body,
      color: colors.text,
      flex: 1,
    },
    labelChecked: {
      textDecorationLine: "line-through",
      color: colors.textTertiary,
    },
  });

const styles = StyleSheet.create({
  row: {
    flexDirection: "row",
    alignItems: "center",
    minHeight: TouchTargets.minimum,
    gap: Spacing.md,
  },
  disabled: {
    opacity: 0.5,
  },
});
