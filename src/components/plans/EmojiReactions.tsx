import React, { useCallback, useMemo } from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
} from 'react-native';
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withSequence,
  withSpring,
} from 'react-native-reanimated';
import { useTranslation } from 'react-i18next';
import { Spacing, Typography, BorderRadius, Shadows, type ThemeColors } from '../../constants/theme';
import { useTheme } from '../../contexts/ThemeContext';

interface EmojiReactionsProps {
  planId: string;
  reactions: Record<string, number>;
  userReaction?: string;
  onReact?: (emoji: string) => void;
}

const AVAILABLE_EMOJIS = [
  { key: 'heart', emoji: '\u2764\uFE0F' },
  { key: 'party', emoji: '\uD83C\uDF89' },
  { key: 'love_eyes', emoji: '\uD83D\uDE0D' },
  { key: 'fire', emoji: '\uD83D\uDD25' },
  { key: 'clap', emoji: '\uD83D\uDC4F' },
  { key: 'wow', emoji: '\uD83D\uDE2E' },
];

function EmojiButton({
  emojiKey,
  emoji,
  count,
  isSelected,
  onPress,
  colors,
}: {
  emojiKey: string;
  emoji: string;
  count: number;
  isSelected: boolean;
  onPress: (key: string) => void;
  colors: ThemeColors;
}) {
  const scale = useSharedValue(1);

  const styles = useMemo(() => createStyles(colors), [colors]);

  const handlePress = useCallback(() => {
    scale.value = withSequence(
      withSpring(1.4, { damping: 6, stiffness: 300 }),
      withSpring(1, { damping: 10, stiffness: 200 })
    );
    onPress(emojiKey);
  }, [emojiKey, onPress, scale]);

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ scale: scale.value }],
  }));

  return (
    <TouchableOpacity
      activeOpacity={0.7}
      onPress={handlePress}
    >
      <Animated.View
        style={[
          styles.emojiButton,
          isSelected && styles.emojiButtonSelected,
          animatedStyle,
        ]}
      >
        <Text style={styles.emojiText}>{emoji}</Text>
        {count > 0 && (
          <Text
            style={[
              styles.emojiCount,
              isSelected && styles.emojiCountSelected,
            ]}
          >
            {count}
          </Text>
        )}
      </Animated.View>
    </TouchableOpacity>
  );
}

export function EmojiReactions({
  planId,
  reactions,
  userReaction,
  onReact,
}: EmojiReactionsProps) {
  const { t } = useTranslation();
  const { colors } = useTheme();

  const styles = useMemo(() => createStyles(colors), [colors]);

  const totalReactions = Object.values(reactions).reduce((sum, c) => sum + c, 0);

  const handleReact = useCallback(
    (key: string) => {
      onReact?.(key);
    },
    [onReact]
  );

  return (
    <View style={styles.container}>
      <View style={styles.emojiRow}>
        {AVAILABLE_EMOJIS.map(({ key, emoji }) => (
          <EmojiButton
            key={key}
            emojiKey={key}
            emoji={emoji}
            count={reactions[key] || 0}
            isSelected={userReaction === key}
            onPress={handleReact}
            colors={colors}
          />
        ))}
      </View>

      {totalReactions > 0 && (
        <Text style={styles.totalText}>
          {t('reactions.total', { count: totalReactions })}
        </Text>
      )}
    </View>
  );
}

const createStyles = (colors: ThemeColors) => StyleSheet.create({
  container: {
    alignItems: 'center',
    marginBottom: Spacing.md,
  },
  emojiRow: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'center',
    gap: Spacing.sm,
  },
  emojiButton: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.backgroundSecondary,
    borderRadius: BorderRadius.full,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderWidth: 1.5,
    borderColor: 'transparent',
    gap: Spacing.xs,
    ...Shadows.sm,
  },
  emojiButtonSelected: {
    backgroundColor: colors.primary + '15',
    borderColor: colors.primary,
  },
  emojiText: {
    fontSize: 20,
  },
  emojiCount: {
    ...Typography.bodySmall,
    color: colors.textSecondary,
    fontWeight: '600',
    minWidth: 16,
    textAlign: 'center',
  },
  emojiCountSelected: {
    color: colors.primary,
  },
  totalText: {
    ...Typography.caption,
    color: colors.textTertiary,
    marginTop: Spacing.sm,
  },
});
