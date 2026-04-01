import React from "react";
import { TouchableOpacity, Text, StyleSheet } from "react-native";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import { Spacing, Typography, BorderRadius } from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";

interface CategoryChipProps {
  label: string;
  icon: string;
  color: string;
  selected?: boolean;
  onPress: () => void;
}

export function CategoryChip({
  label,
  icon,
  color,
  selected = false,
  onPress,
}: CategoryChipProps) {
  const { colors } = useTheme();

  return (
    <TouchableOpacity
      style={[
        styles.chip,
        { borderColor: colors.border, backgroundColor: colors.surface },
        selected && { backgroundColor: color, borderColor: color },
      ]}
      onPress={onPress}
      activeOpacity={0.7}
      accessibilityRole="button"
      accessibilityLabel={label}
      accessibilityState={{ selected }}
    >
      <Icon
        name={icon as IconName}
        size={18}
        color={selected ? colors.textOnPrimary : color}
      />
      <Text
        style={[
          styles.label,
          { color: colors.text },
          selected && { color: colors.textOnPrimary },
        ]}
        numberOfLines={1}
      >
        {label}
      </Text>
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  chip: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.full,
    borderWidth: 1.5,
  },
  label: {
    ...Typography.bodySmall,
    fontWeight: "500",
  },
});
