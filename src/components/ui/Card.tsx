/**
 * Card Component System
 * Variants: primary (full), secondary (medium emphasis), compact (list item)
 * All variants support press animation, theme-aware styling, and accessibility
 */

import React, { useCallback } from 'react';
import { View, StyleSheet, TouchableOpacity, ViewStyle } from 'react-native';
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withSpring,
} from 'react-native-reanimated';
import { BorderRadius, Spacing, Shadows } from '../../constants/theme';
import { useTheme } from '../../contexts/ThemeContext';
import { SpringPresets } from '../../utils/animations';
import type { ThemeColors } from '../../constants/theme';

type CardVariant = 'primary' | 'secondary' | 'compact';
type CardElevation = 'sm' | 'md' | 'lg';

interface CardProps {
  children: React.ReactNode;
  onPress?: () => void;
  style?: ViewStyle;
  variant?: CardVariant;
  elevation?: CardElevation;
  padding?: boolean;
  /** Disable press scale animation */
  noAnimation?: boolean;
  accessibilityLabel?: string;
}

const AnimatedTouchable = Animated.createAnimatedComponent(TouchableOpacity);

export function Card({
  children,
  onPress,
  style,
  variant = 'primary',
  elevation = 'sm',
  padding = true,
  noAnimation = false,
  accessibilityLabel,
}: CardProps) {
  const { colors, isDark } = useTheme();
  const scale = useSharedValue(1);

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ scale: scale.value }],
  }));

  const handlePressIn = useCallback(() => {
    if (!noAnimation) {
      scale.value = withSpring(0.97, SpringPresets.snappy);
    }
  }, [scale, noAnimation]);

  const handlePressOut = useCallback(() => {
    if (!noAnimation) {
      scale.value = withSpring(1, SpringPresets.standard);
    }
  }, [scale, noAnimation]);

  const variantStyles = getVariantStyles(variant, colors);

  const cardStyle = [
    variantStyles.container,
    !isDark && Shadows[elevation],
    padding && variantStyles.padding,
    style,
  ];

  if (onPress) {
    return (
      <AnimatedTouchable
        style={[cardStyle, animatedStyle]}
        onPress={onPress}
        onPressIn={handlePressIn}
        onPressOut={handlePressOut}
        activeOpacity={1}
        accessible
        accessibilityRole="button"
        accessibilityLabel={accessibilityLabel}
      >
        {children}
      </AnimatedTouchable>
    );
  }

  return (
    <View
      style={cardStyle}
      accessible={!!accessibilityLabel}
      accessibilityLabel={accessibilityLabel}
    >
      {children}
    </View>
  );
}

function getVariantStyles(variant: CardVariant, colors: ThemeColors) {
  switch (variant) {
    case 'primary':
      return {
        container: {
          backgroundColor: colors.surface,
          borderRadius: BorderRadius.lg,
          borderWidth: 0.5,
          borderColor: colors.border + '50',
          overflow: 'hidden' as const,
        },
        padding: { padding: Spacing.md },
      };
    case 'secondary':
      return {
        container: {
          backgroundColor: colors.surfaceVariant,
          borderRadius: BorderRadius.md,
          borderWidth: 0.5,
          borderColor: colors.border + '30',
          overflow: 'hidden' as const,
        },
        padding: { padding: Spacing.smd },
      };
    case 'compact':
      return {
        container: {
          backgroundColor: colors.surface,
          borderRadius: BorderRadius.md,
          borderWidth: 0.5,
          borderColor: colors.border + '40',
          overflow: 'hidden' as const,
          flexDirection: 'row' as const,
          alignItems: 'center' as const,
        },
        padding: { paddingHorizontal: Spacing.md, paddingVertical: Spacing.smd },
      };
  }
}

/** Optional header section for primary cards */
export function CardHeader({ children, style }: { children: React.ReactNode; style?: ViewStyle }) {
  const { colors } = useTheme();
  return (
    <View style={[headerFooterStyles.header, { borderBottomColor: colors.border + '30' }, style]}>
      {children}
    </View>
  );
}

/** Optional footer section for primary cards */
export function CardFooter({ children, style }: { children: React.ReactNode; style?: ViewStyle }) {
  const { colors } = useTheme();
  return (
    <View style={[headerFooterStyles.footer, { borderTopColor: colors.border + '30' }, style]}>
      {children}
    </View>
  );
}

const headerFooterStyles = StyleSheet.create({
  header: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.smd,
    borderBottomWidth: 0.5,
  },
  footer: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.smd,
    borderTopWidth: 0.5,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
});
