import React, { useMemo } from "react";
import { View, Text, TouchableOpacity, StyleSheet } from "react-native";
import Animated, {
  FadeInUp,
  useSharedValue,
  useAnimatedStyle,
  withSpring,
} from "react-native-reanimated";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import { CachedImage } from "../common/CachedImage";
import type { IconName } from "../../constants/icons";
import { useTheme } from "../../contexts/ThemeContext";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  Springs,
  type ThemeColors,
} from "../../constants/theme";
import { LinearGradient } from "expo-linear-gradient";
import type { Story } from "../../stores/communityStore";

const EMOJI_LIST = [
  "\u2764\uFE0F",
  "\uD83C\uDF89",
  "\uD83D\uDE2E",
  "\uD83D\uDE22",
  "\uD83D\uDC4F",
  "\uD83D\uDD25",
];

import { getCategoryColor } from "../../constants/categories";

const CATEGORY_EMOJIS: Record<string, string> = {
  birthday: "\uD83C\uDF82",
  anniversary: "\uD83D\uDC96",
  proposal: "\uD83D\uDC8D",
  graduation: "\uD83C\uDF93",
  holiday: "\u2708\uFE0F",
  other: "\u2728",
};

interface StoryCardProps {
  story: Story;
  onPress: (story: Story) => void;
  onLongPress?: (story: Story) => void;
  index: number;
}

function formatTimeAgo(
  dateString: string,
  t: (key: string, opts?: Record<string, unknown>) => string,
  locale: string,
): string {
  const date = new Date(dateString);
  const now = new Date();
  const diffMs = now.getTime() - date.getTime();
  const diffMinutes = Math.floor(diffMs / (1000 * 60));
  const diffHours = Math.floor(diffMs / (1000 * 60 * 60));
  const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));

  if (diffMinutes < 1) return t("time.justNow");
  if (diffMinutes < 60) return t("time.minutesAgo", { count: diffMinutes });
  if (diffHours < 24) return t("time.hoursAgo", { count: diffHours });
  if (diffDays < 7) return t("time.daysAgo", { count: diffDays });
  if (diffDays < 30) {
    const weeks = Math.floor(diffDays / 7);
    return t("time.weeksAgo", { count: weeks });
  }

  return date.toLocaleDateString(locale, {
    month: "short",
    day: "numeric",
  });
}

function StoryCardInner({
  story,
  onPress,
  onLongPress,
  index,
}: StoryCardProps) {
  const { t, i18n } = useTranslation();
  const { colors } = useTheme();
  const styles = useMemo(() => createStyles(colors), [colors]);

  const scale = useSharedValue(1);
  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ scale: scale.value }],
  }));

  const handlePressIn = () => {
    scale.value = withSpring(0.98, Springs.snappy);
  };

  const handlePressOut = () => {
    scale.value = withSpring(1, Springs.standard);
  };

  const coverImage = story.images?.[0] ?? null;
  const isAnonymous = !story.author_name;
  const authorDisplay = isAnonymous
    ? t("reviews.anonymous")
    : story.author_name;
  const categoryColor = getCategoryColor(story.category);
  const categoryEmoji =
    CATEGORY_EMOJIS[story.category] || CATEGORY_EMOJIS.other;

  const staggerDelay = Math.min(index * 60, 400);

  if (coverImage) {
    // Card WITH cover image — 240px total
    return (
      <Animated.View
        entering={FadeInUp.delay(staggerDelay).duration(400).springify()}
        style={animatedStyle}
      >
        <TouchableOpacity
          style={styles.card}
          activeOpacity={1}
          onPressIn={handlePressIn}
          onPressOut={handlePressOut}
          onPress={() => onPress(story)}
          onLongPress={onLongPress ? () => onLongPress(story) : undefined}
          delayLongPress={400}
        >
          {/* Cover image area — 160px */}
          <View style={styles.coverContainer}>
            <CachedImage
              uri={coverImage}
              style={styles.coverImage}
              contentFit="cover"
            />
            <LinearGradient
              colors={["transparent", "rgba(0,0,0,0.6)"]}
              style={styles.coverGradient}
            />
            <Text style={styles.coverTitle} numberOfLines={2}>
              {story.title}
            </Text>
          </View>

          {/* Below image content */}
          <View style={styles.belowImageContent}>
            {/* Author row */}
            <View style={styles.authorRow}>
              {isAnonymous ? (
                <View
                  style={[
                    styles.avatar,
                    { backgroundColor: colors.textTertiary + "30" },
                  ]}
                >
                  <Icon
                    name="incognito"
                    size={14}
                    color={colors.textTertiary}
                  />
                </View>
              ) : (
                <View
                  style={[
                    styles.avatar,
                    { backgroundColor: colors.primary + "20" },
                  ]}
                >
                  <Text style={[styles.avatarText, { color: colors.primary }]}>
                    {authorDisplay.charAt(0).toUpperCase()}
                  </Text>
                </View>
              )}
              <Text
                style={[styles.authorName, { color: colors.textSecondary }]}
                numberOfLines={1}
              >
                {authorDisplay}
              </Text>
              <Text style={[styles.dateText, { color: colors.textTertiary }]}>
                {formatTimeAgo(story.created_at, t, i18n.language)}
              </Text>
            </View>

            {/* Engagement row */}
            <View style={styles.engagementRow}>
              <View style={styles.statItem}>
                <Icon
                  name={
                    (story.is_liked ? "heart" : "heart-outline") as IconName
                  }
                  size={15}
                  color={colors.error}
                />
                <Text style={[styles.statText, { color: colors.textTertiary }]}>
                  {story.like_count}
                </Text>
              </View>
              <View style={styles.statItem}>
                <Icon name="comment-outline" size={15} color={colors.info} />
                <Text style={[styles.statText, { color: colors.textTertiary }]}>
                  {story.comment_count}
                </Text>
              </View>
            </View>

            {/* Emoji reactions */}
            <View style={styles.emojiRow}>
              {EMOJI_LIST.map((emoji) => (
                <View
                  key={emoji}
                  style={[
                    styles.emojiPill,
                    { backgroundColor: colors.surfaceVariant },
                  ]}
                >
                  <Text style={styles.emojiText}>{emoji}</Text>
                  <Text
                    style={[styles.emojiCount, { color: colors.textTertiary }]}
                  >
                    0
                  </Text>
                </View>
              ))}
            </View>
          </View>
        </TouchableOpacity>
      </Animated.View>
    );
  }

  // Card WITHOUT image — 140px with gradient + emoji
  return (
    <Animated.View
      entering={FadeInUp.delay(staggerDelay).duration(400).springify()}
      style={animatedStyle}
    >
      <TouchableOpacity
        style={styles.card}
        activeOpacity={1}
        onPressIn={handlePressIn}
        onPressOut={handlePressOut}
        onPress={() => onPress(story)}
        onLongPress={onLongPress ? () => onLongPress(story) : undefined}
        delayLongPress={400}
      >
        {/* Category gradient with emoji */}
        <LinearGradient
          colors={[categoryColor, categoryColor + "80"]}
          start={{ x: 0, y: 0 }}
          end={{ x: 1, y: 1 }}
          style={styles.noImageGradient}
        >
          <Text style={styles.categoryEmoji}>{categoryEmoji}</Text>
        </LinearGradient>

        {/* Below gradient content */}
        <View style={styles.belowImageContent}>
          <Text
            style={[styles.noImageTitle, { color: colors.text }]}
            numberOfLines={2}
          >
            {story.title}
          </Text>

          {/* Author row */}
          <View style={styles.authorRow}>
            {isAnonymous ? (
              <View
                style={[
                  styles.avatar,
                  { backgroundColor: colors.textTertiary + "30" },
                ]}
              >
                <Icon name="incognito" size={14} color={colors.textTertiary} />
              </View>
            ) : (
              <View
                style={[
                  styles.avatar,
                  { backgroundColor: colors.primary + "20" },
                ]}
              >
                <Text style={[styles.avatarText, { color: colors.primary }]}>
                  {authorDisplay.charAt(0).toUpperCase()}
                </Text>
              </View>
            )}
            <Text
              style={[styles.authorName, { color: colors.textSecondary }]}
              numberOfLines={1}
            >
              {authorDisplay}
            </Text>
            <Text style={[styles.dateText, { color: colors.textTertiary }]}>
              {formatTimeAgo(story.created_at, t, i18n.language)}
            </Text>
          </View>

          {/* Engagement row */}
          <View style={styles.engagementRow}>
            <View style={styles.statItem}>
              <Icon
                name={(story.is_liked ? "heart" : "heart-outline") as IconName}
                size={15}
                color={colors.error}
              />
              <Text style={[styles.statText, { color: colors.textTertiary }]}>
                {story.like_count}
              </Text>
            </View>
            <View style={styles.statItem}>
              <Icon name="comment-outline" size={15} color={colors.info} />
              <Text style={[styles.statText, { color: colors.textTertiary }]}>
                {story.comment_count}
              </Text>
            </View>
          </View>

          {/* Emoji reactions */}
          <View style={styles.emojiRow}>
            {EMOJI_LIST.map((emoji) => (
              <View
                key={emoji}
                style={[
                  styles.emojiPill,
                  { backgroundColor: colors.surfaceVariant },
                ]}
              >
                <Text style={styles.emojiText}>{emoji}</Text>
                <Text
                  style={[styles.emojiCount, { color: colors.textTertiary }]}
                >
                  0
                </Text>
              </View>
            ))}
          </View>
        </View>
      </TouchableOpacity>
    </Animated.View>
  );
}

export const StoryCard = React.memo(StoryCardInner);

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    card: {
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      overflow: "hidden",
      marginBottom: Spacing.md,
      borderWidth: 1,
      borderColor: colors.borderLight,
      ...Shadows.sm,
    },
    // With image card
    coverContainer: {
      height: 160,
      position: "relative",
    },
    coverImage: {
      width: "100%",
      height: "100%",
      borderTopLeftRadius: BorderRadius.lg,
      borderTopRightRadius: BorderRadius.lg,
    },
    coverGradient: {
      position: "absolute",
      left: 0,
      right: 0,
      bottom: 0,
      height: 80,
    },
    coverTitle: {
      ...Typography.h4,
      color: colors.textOnPrimary,
      position: "absolute",
      bottom: Spacing.smd,
      left: Spacing.md,
      right: Spacing.md,
      textShadowColor: "rgba(0,0,0,0.5)",
      textShadowOffset: { width: 0, height: 1 },
      textShadowRadius: 4,
    },
    // Without image card
    noImageGradient: {
      height: 80,
      alignItems: "center",
      justifyContent: "center",
    },
    categoryEmoji: {
      fontSize: 32,
    },
    noImageTitle: {
      ...Typography.h4,
      marginBottom: Spacing.sm,
    },
    // Shared content below image/gradient
    belowImageContent: {
      padding: Spacing.md,
      gap: Spacing.sm,
    },
    // Author
    authorRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
    },
    avatar: {
      width: 28,
      height: 28,
      borderRadius: 14,
      alignItems: "center",
      justifyContent: "center",
    },
    avatarText: {
      ...Typography.caption,
      fontWeight: "700",
      fontSize: 12,
    },
    authorName: {
      ...Typography.caption,
      fontWeight: "500",
      flex: 1,
    },
    dateText: {
      ...Typography.caption,
      fontSize: 11,
    },
    // Engagement
    engagementRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.md,
    },
    statItem: {
      flexDirection: "row",
      alignItems: "center",
      gap: 4,
    },
    statText: {
      ...Typography.caption,
      fontWeight: "500",
    },
    // Emoji pills
    emojiRow: {
      flexDirection: "row",
      flexWrap: "wrap",
      gap: 4,
    },
    emojiPill: {
      flexDirection: "row",
      alignItems: "center",
      gap: 2,
      paddingHorizontal: 6,
      paddingVertical: 3,
      borderRadius: 12,
    },
    emojiText: {
      fontSize: 12,
    },
    emojiCount: {
      fontSize: 10,
    },
  });
