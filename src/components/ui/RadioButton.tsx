import React from "react";
import { TouchableOpacity, View, Text, StyleSheet } from "react-native";
import { useTheme } from "../../contexts/ThemeContext";
import { Spacing, Typography, TouchTargets } from "../../constants/theme";
import type { ThemeColors } from "../../constants/theme";

interface RadioButtonProps {
  selected: boolean;
  onSelect: () => void;
  disabled?: boolean;
  color?: string;
  label?: string;
  description?: string;
}

export function RadioButton({
  selected,
  onSelect,
  disabled = false,
  color,
  label,
  description,
}: RadioButtonProps) {
  const { colors } = useTheme();
  const activeColor = color ?? colors.primary;
  const dynamicStyles = createDynamicStyles(colors, activeColor, selected);

  return (
    <TouchableOpacity
      style={[styles.row, disabled && styles.disabled]}
      onPress={onSelect}
      disabled={disabled}
      activeOpacity={0.7}
      accessible
      accessibilityRole="radio"
      accessibilityState={{ checked: selected, disabled }}
    >
      <View style={dynamicStyles.radioOuter}>
        {selected && <View style={dynamicStyles.radioInner} />}
      </View>
      {(label != null || description != null) && (
        <View style={styles.textContainer}>
          {label != null && <Text style={dynamicStyles.label}>{label}</Text>}
          {description != null && (
            <Text style={dynamicStyles.description}>{description}</Text>
          )}
        </View>
      )}
    </TouchableOpacity>
  );
}

const createDynamicStyles = (
  colors: ThemeColors,
  activeColor: string,
  selected: boolean,
) =>
  StyleSheet.create({
    radioOuter: {
      width: 22,
      height: 22,
      borderRadius: 11,
      borderWidth: 2,
      borderColor: selected ? activeColor : colors.border,
      alignItems: "center",
      justifyContent: "center",
    },
    radioInner: {
      width: 12,
      height: 12,
      borderRadius: 6,
      backgroundColor: activeColor,
    },
    label: {
      ...Typography.body,
      color: colors.text,
    },
    description: {
      ...Typography.caption,
      color: colors.textSecondary,
      marginTop: 2,
    },
  });

const styles = StyleSheet.create({
  row: {
    flexDirection: "row",
    alignItems: "center",
    minHeight: TouchTargets.minimum,
    gap: Spacing.md,
  },
  textContainer: {
    flex: 1,
  },
  disabled: {
    opacity: 0.5,
  },
});
