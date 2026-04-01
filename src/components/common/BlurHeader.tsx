import React from 'react';
import { View, Text, StyleSheet, TouchableOpacity, Platform } from 'react-native';
import { BlurView } from 'expo-blur';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { Icon } from '../ui/Icon';
import type { IconName } from '../../constants/icons';
import { useRouter } from 'expo-router';
import { useTheme } from '../../contexts/ThemeContext';
import { Typography, Spacing, BorderRadius } from '../../constants/theme';
import { hapticLight } from '../../utils/haptics';

interface BlurHeaderProps {
  title: string;
  showBack?: boolean;
  rightAction?: {
    icon: string;
    onPress: () => void;
  };
  transparent?: boolean;
}

export function BlurHeader({ title, showBack = true, rightAction, transparent = false }: BlurHeaderProps) {
  const insets = useSafeAreaInsets();
  const router = useRouter();
  const { colors, isDark } = useTheme();

  const headerContent = (
    <View style={[styles.headerContent, { paddingTop: insets.top + 8 }]}>
      <View style={styles.leftSection}>
        {showBack && (
          <TouchableOpacity
            onPress={() => { hapticLight(); router.back(); }}
            style={styles.backButton}
            hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
          >
            <Icon
              name="chevron-left"
              size={28}
              color={transparent ? '#FFFFFF' : colors.text}
            />
          </TouchableOpacity>
        )}
      </View>

      <Text
        style={[
          styles.title,
          { color: transparent ? '#FFFFFF' : colors.text }
        ]}
        numberOfLines={1}
        maxFontSizeMultiplier={1.3}
      >
        {title}
      </Text>

      <View style={styles.rightSection}>
        {rightAction && (
          <TouchableOpacity
            onPress={() => { hapticLight(); rightAction.onPress(); }}
            style={styles.actionButton}
            hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
          >
            <Icon
              name={rightAction.icon as IconName}
              size={24}
              color={transparent ? '#FFFFFF' : colors.text}
            />
          </TouchableOpacity>
        )}
      </View>
    </View>
  );

  if (Platform.OS === 'ios' && !transparent) {
    return (
      <BlurView
        tint={isDark ? 'dark' : 'light'}
        intensity={90}
        style={styles.container}
      >
        {headerContent}
      </BlurView>
    );
  }

  return (
    <View style={[
      styles.container,
      { backgroundColor: transparent ? 'transparent' : colors.surface }
    ]}>
      {headerContent}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    zIndex: 100,
  },
  headerContent: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: Spacing.md,
    paddingBottom: Spacing.sm,
  },
  leftSection: {
    width: 44,
    alignItems: 'flex-start',
  },
  rightSection: {
    width: 44,
    alignItems: 'flex-end',
  },
  backButton: {
    padding: 4,
  },
  actionButton: {
    padding: 4,
  },
  title: {
    ...Typography.h4,
    flex: 1,
    textAlign: 'center',
  },
});
