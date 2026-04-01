import React from "react";
import { View, StyleSheet, ViewStyle } from "react-native";
import { LinearGradient } from "expo-linear-gradient";
import { BorderRadius, Shadows, Spacing } from "../../constants/theme";

interface GradientCardProps {
  colors: readonly string[] | string[];
  children: React.ReactNode;
  style?: ViewStyle;
  onPress?: () => void;
  borderRadius?: number;
}

export function GradientCard({
  colors: gradientColors,
  children,
  style,
  borderRadius = BorderRadius.xlg,
}: GradientCardProps) {
  return (
    <View style={[styles.container, { borderRadius }, Shadows.md, style]}>
      <LinearGradient
        colors={gradientColors as unknown as [string, string, ...string[]]}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 1 }}
        style={[styles.gradient, { borderRadius }]}
      >
        {children}
      </LinearGradient>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    overflow: "hidden",
  },
  gradient: {
    padding: Spacing.md,
  },
});
