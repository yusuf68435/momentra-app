import React, { useState } from "react";
import { View, Text, TouchableOpacity, StyleSheet } from "react-native";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import { CachedImage } from "../common/CachedImage";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";
import { StarRating } from "./StarRating";
import type { Review } from "../../types/database";

interface ReviewProfile {
  display_name: string | null;
  avatar_url: string | null;
}

interface ReviewWithProfile extends Review {
  profile?: ReviewProfile;
}

interface ReviewCardProps {
  review: ReviewWithProfile;
}

function formatDate(
  dateString: string,
  t: (key: string, opts?: Record<string, unknown>) => string,
  locale: string,
): string {
  const date = new Date(dateString);
  const now = new Date();
  const diffMs = now.getTime() - date.getTime();
  const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));

  if (diffDays === 0) return t("time.today");
  if (diffDays === 1) return t("time.yesterday");
  if (diffDays < 7) return t("time.daysAgoSimple", { count: diffDays });
  if (diffDays < 30) {
    const weeks = Math.floor(diffDays / 7);
    return t("time.weeksAgo", { count: weeks });
  }

  return date.toLocaleDateString(locale, {
    year: "numeric",
    month: "short",
    day: "numeric",
  });
}

export function ReviewCard({ review }: ReviewCardProps) {
  const [helpfulCount, setHelpfulCount] = useState(0);
  const [isHelpful, setIsHelpful] = useState(false);
  const { colors } = useTheme();
  const { t, i18n } = useTranslation();

  const displayName = review.profile?.display_name || t("reviews.anonymous");
  const avatarUrl = review.profile?.avatar_url;

  const handleHelpful = () => {
    if (isHelpful) {
      setHelpfulCount((c) => c - 1);
      setIsHelpful(false);
    } else {
      setHelpfulCount((c) => c + 1);
      setIsHelpful(true);
    }
  };

  return (
    <View
      style={[
        styles.card,
        { backgroundColor: colors.surface, borderColor: colors.borderLight },
      ]}
    >
      {/* Header: avatar + name + date */}
      <View style={styles.header}>
        <View style={styles.avatarContainer}>
          <CachedImage
            uri={avatarUrl}
            style={styles.avatar}
            contentFit="cover"
            fallbackIcon="account"
          />
        </View>
        <View style={styles.headerText}>
          <Text style={[styles.userName, { color: colors.text }]}>
            {displayName}
          </Text>
          <Text style={[styles.date, { color: colors.textTertiary }]}>
            {formatDate(review.created_at, t, i18n.language)}
          </Text>
        </View>
      </View>

      {/* Star rating */}
      <StarRating
        rating={review.rating}
        size="sm"
        showHalfStars
        style={styles.stars}
      />

      {/* Comment */}
      {review.comment ? (
        <Text style={[styles.comment, { color: colors.textSecondary }]}>
          {review.comment}
        </Text>
      ) : null}

      {/* Photo thumbnails */}
      {review.photos && review.photos.length > 0 && (
        <View style={styles.photosRow}>
          {review.photos.slice(0, 4).map((uri, idx) => (
            <TouchableOpacity key={idx} activeOpacity={0.8}>
              <CachedImage
                uri={uri}
                style={styles.photoThumb}
                contentFit="cover"
              />
              {idx === 3 && review.photos.length > 4 && (
                <View style={styles.morePhotosOverlay}>
                  <Text
                    style={[
                      styles.morePhotosText,
                      { color: colors.textOnPrimary },
                    ]}
                  >
                    +{review.photos.length - 4}
                  </Text>
                </View>
              )}
            </TouchableOpacity>
          ))}
        </View>
      )}

      {/* Helpful button */}
      <TouchableOpacity
        style={[
          styles.helpfulButton,
          { backgroundColor: colors.surfaceVariant },
          isHelpful && { backgroundColor: colors.primary + "15" },
        ]}
        onPress={handleHelpful}
        activeOpacity={0.7}
      >
        <Icon
          name={isHelpful ? "thumb-up" : "thumb-up-outline"}
          size={14}
          color={isHelpful ? colors.primary : colors.textTertiary}
        />
        <Text
          style={[
            styles.helpfulText,
            { color: isHelpful ? colors.primary : colors.textTertiary },
          ]}
        >
          {t("reviews.helpful")}
          {helpfulCount > 0 ? ` (${helpfulCount})` : ""}
        </Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  card: {
    borderRadius: BorderRadius.md,
    padding: Spacing.md,
    marginBottom: Spacing.sm,
    borderWidth: 1,
    ...Shadows.sm,
  },
  header: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: Spacing.sm,
  },
  avatarContainer: {
    marginRight: Spacing.sm,
  },
  avatar: {
    width: 36,
    height: 36,
    borderRadius: 18,
  },
  avatarPlaceholder: {
    width: 36,
    height: 36,
    borderRadius: 18,
    alignItems: "center",
    justifyContent: "center",
  },
  headerText: {
    flex: 1,
  },
  userName: {
    ...Typography.bodySmall,
    fontWeight: "600",
  },
  date: {
    ...Typography.caption,
    marginTop: 1,
  },
  stars: {
    marginBottom: Spacing.sm,
  },
  comment: {
    ...Typography.bodySmall,
    lineHeight: 20,
    marginBottom: Spacing.sm,
  },
  photosRow: {
    flexDirection: "row",
    gap: Spacing.sm,
    marginBottom: Spacing.sm,
  },
  photoThumb: {
    width: 60,
    height: 60,
    borderRadius: BorderRadius.sm,
  },
  morePhotosOverlay: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: "rgba(0,0,0,0.5)",
    borderRadius: BorderRadius.sm,
    alignItems: "center",
    justifyContent: "center",
  },
  morePhotosText: {
    ...Typography.bodySmall,
    fontWeight: "700",
  },
  helpfulButton: {
    flexDirection: "row",
    alignItems: "center",
    alignSelf: "flex-start",
    gap: 4,
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.full,
  },
  helpfulText: {
    ...Typography.caption,
  },
});
