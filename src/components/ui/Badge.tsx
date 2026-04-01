import React from 'react';
import { View, Text, StyleSheet, ViewStyle } from 'react-native';
import { BorderRadius, Spacing, Typography } from '../../constants/theme';
import { useTheme } from '../../contexts/ThemeContext';

interface BadgeProps {
  text: string;
  color?: string;
  backgroundColor?: string;
  size?: 'sm' | 'md';
  style?: ViewStyle;
}

export function Badge({
  text,
  color,
  backgroundColor,
  size = 'sm',
  style,
}: BadgeProps) {
  const { colors } = useTheme();
  const resolvedColor = color ?? colors.textOnPrimary;
  const resolvedBg = backgroundColor ?? colors.primary;

  return (
    <View style={[styles.badge, styles[size], { backgroundColor: resolvedBg }, style]}>
      <Text style={[styles.text, styles[`text_${size}`], { color: resolvedColor }]}>{text}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  badge: {
    alignSelf: 'flex-start',
    borderRadius: BorderRadius.full,
  },
  sm: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
  },
  md: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.xs,
  },
  text: {
    fontWeight: '600',
  },
  text_sm: {
    ...Typography.caption,
    fontWeight: '600',
  },
  text_md: {
    ...Typography.bodySmall,
    fontWeight: '600',
  },
});
