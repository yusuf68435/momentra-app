import React from 'react';
import {
  TouchableOpacity,
  Text,
  StyleSheet,
  ActivityIndicator,
  ViewStyle,
  TextStyle,
} from 'react-native';
import { BorderRadius, Spacing, Typography, TouchTargets } from '../../constants/theme';
import { useTheme } from '../../contexts/ThemeContext';
import type { ThemeColors } from '../../constants/theme';

interface ButtonProps {
  title: string;
  onPress: () => void;
  variant?: 'primary' | 'secondary' | 'outline' | 'ghost';
  size?: 'sm' | 'md' | 'lg';
  disabled?: boolean;
  loading?: boolean;
  icon?: React.ReactNode;
  style?: ViewStyle;
  textStyle?: TextStyle;
  fullWidth?: boolean;
}

export function Button({
  title,
  onPress,
  variant = 'primary',
  size = 'md',
  disabled = false,
  loading = false,
  icon,
  style,
  textStyle,
  fullWidth = false,
}: ButtonProps) {
  const { colors } = useTheme();
  const dynamicStyles = createStyles(colors);

  const buttonStyle = [
    styles.base,
    dynamicStyles[variant],
    styles[`size_${size}`],
    fullWidth && styles.fullWidth,
    disabled && styles.disabled,
    style,
  ];

  const labelStyle = [
    styles.label,
    dynamicStyles[`label_${variant}`],
    styles[`labelSize_${size}`],
    disabled && styles.labelDisabled,
    textStyle,
  ];

  return (
    <TouchableOpacity
      style={buttonStyle}
      onPress={onPress}
      disabled={disabled || loading}
      activeOpacity={0.7}
      accessible
      accessibilityRole="button"
      accessibilityLabel={loading ? `${title}, loading` : title}
      accessibilityState={{ disabled: disabled || loading, busy: loading }}
    >
      {loading ? (
        <ActivityIndicator
          color={variant === 'outline' || variant === 'ghost' ? colors.primary : colors.textOnPrimary}
          size="small"
        />
      ) : (
        <>
          {icon}
          <Text style={labelStyle}>{title}</Text>
        </>
      )}
    </TouchableOpacity>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    primary: {
      backgroundColor: colors.primary,
    },
    secondary: {
      backgroundColor: colors.secondary,
    },
    outline: {
      backgroundColor: 'transparent',
      borderWidth: 1.5,
      borderColor: colors.primary,
    },
    ghost: {
      backgroundColor: colors.primary + '12',
    },
    label_primary: {
      color: colors.textOnPrimary,
    },
    label_secondary: {
      color: colors.textOnPrimary,
    },
    label_outline: {
      color: colors.primary,
    },
    label_ghost: {
      color: colors.primary,
    },
  });

const styles = StyleSheet.create({
  base: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    borderRadius: BorderRadius.md,
    gap: Spacing.sm,
    minHeight: TouchTargets.minimum,
  },
  size_sm: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm + 2,
  },
  size_md: {
    paddingHorizontal: Spacing.lg,
    paddingVertical: Spacing.md - 1,
  },
  size_lg: {
    paddingHorizontal: Spacing.xl,
    paddingVertical: Spacing.md + 2,
  },
  fullWidth: {
    width: '100%',
  },
  disabled: {
    opacity: 0.4,
  },
  label: {
    ...Typography.button,
  },
  labelSize_sm: {
    ...Typography.buttonSmall,
  },
  labelSize_md: {
    ...Typography.button,
  },
  labelSize_lg: {
    ...Typography.button,
    fontSize: 18,
  },
  labelDisabled: {
    opacity: 0.7,
  },
});
