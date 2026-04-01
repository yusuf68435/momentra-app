import React from "react";
import { View, StyleSheet } from "react-native";
import { useTheme } from "../../contexts/ThemeContext";
import { Spacing } from "../../constants/theme";

interface DividerProps {
  spacing?: number;
  color?: string;
}

export function Divider({ spacing, color }: DividerProps) {
  const { colors } = useTheme();

  return (
    <View
      style={[
        styles.divider,
        {
          backgroundColor: color ?? colors.divider,
          marginVertical: spacing ?? Spacing.md,
        },
      ]}
    />
  );
}

const styles = StyleSheet.create({
  divider: {
    height: StyleSheet.hairlineWidth,
    width: "100%",
  },
});
