import React, { useState, useEffect, useMemo } from "react";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";
import {
  View,
  Text,
  FlatList,
  TouchableOpacity,
  StyleSheet,
  Alert,
} from "react-native";
import { LoadingScreen } from "../../../src/components/common/LoadingScreen";
import { useLocalSearchParams } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon } from "../../../src/components/ui/Icon";
import Animated, { FadeInDown } from "react-native-reanimated";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../../src/constants/theme";
import { useTheme } from "../../../src/contexts/ThemeContext";
import { StarRating } from "../../../src/components/reviews/StarRating";
import { ReviewCard } from "../../../src/components/reviews/ReviewCard";
import { WriteReviewModal } from "../../../src/components/reviews/WriteReviewModal";
import { Button } from "../../../src/components/ui/Button";
import {
  fetchReviewsByScenario,
  createReview,
} from "../../../src/services/reviews";
import type { Review } from "../../../src/types/database";

type SortOption = "newest" | "highest" | "lowest";

interface ReviewWithProfile extends Review {
  profile?: { display_name: string | null; avatar_url: string | null };
}

export default function ReviewsScreen() {
  const { id } = useLocalSearchParams();
  const { t, i18n } = useTranslation();
  const lang = i18n.language as "tr" | "en";
  const { colors } = useTheme();
  const styles = useMemo(() => createStyles(colors), [colors]);

  const [reviews, setReviews] = useState<ReviewWithProfile[]>([]);
  const [loading, setLoading] = useState(true);
  const [sortBy, setSortBy] = useState<SortOption>("newest");
  const [showWriteModal, setShowWriteModal] = useState(false);
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    loadReviews();
  }, [id]);

  const loadReviews = async () => {
    try {
      setLoading(true);
      const data = await fetchReviewsByScenario(id as string);
      setReviews(data as ReviewWithProfile[]);
    } catch (err) {
      // Silently handle - show empty state
    } finally {
      setLoading(false);
    }
  };

  const sortedReviews = useMemo(() => {
    const sorted = [...reviews];
    switch (sortBy) {
      case "newest":
        return sorted.sort(
          (a, b) =>
            new Date(b.created_at).getTime() - new Date(a.created_at).getTime(),
        );
      case "highest":
        return sorted.sort((a, b) => b.rating - a.rating);
      case "lowest":
        return sorted.sort((a, b) => a.rating - b.rating);
      default:
        return sorted;
    }
  }, [reviews, sortBy]);

  // Rating breakdown
  const ratingBreakdown = useMemo(() => {
    const counts = [0, 0, 0, 0, 0]; // 1-5
    reviews.forEach((r) => {
      const idx = Math.min(Math.max(Math.round(r.rating) - 1, 0), 4);
      counts[idx]++;
    });
    return counts;
  }, [reviews]);

  const averageRating = useMemo(() => {
    if (reviews.length === 0) return 0;
    return reviews.reduce((sum, r) => sum + r.rating, 0) / reviews.length;
  }, [reviews]);

  const handleSubmitReview = async (data: {
    rating: number;
    comment: string;
    photos: string[];
  }) => {
    try {
      setSubmitting(true);
      await createReview({
        scenario_id: id as string,
        rating: data.rating,
        comment: data.comment || undefined,
        photos: data.photos.length > 0 ? data.photos : undefined,
      });
      setShowWriteModal(false);
      loadReviews();
    } catch (err: any) {
      Alert.alert(
        t("reviews.errorTitle"),
        err?.message || t("reviews.submitError"),
      );
    } finally {
      setSubmitting(false);
    }
  };

  const renderHeader = () => (
    <Animated.View entering={FadeInDown.duration(400)}>
      {/* Rating Summary */}
      <View style={styles.summaryCard}>
        <View style={styles.summaryLeft}>
          <Text style={styles.avgRating}>{averageRating.toFixed(1)}</Text>
          <StarRating rating={averageRating} size="md" showHalfStars />
          <Text style={styles.totalCount}>
            {reviews.length} {t("reviews.reviewsLabel")}
          </Text>
        </View>

        <View style={styles.summaryRight}>
          {[5, 4, 3, 2, 1].map((star) => {
            const count = ratingBreakdown[star - 1];
            const pct = reviews.length > 0 ? (count / reviews.length) * 100 : 0;
            return (
              <View key={star} style={styles.breakdownRow}>
                <Text style={styles.breakdownStar}>{star}</Text>
                <Icon name="star" size={12} color={colors.secondary} />
                <View style={styles.barContainer}>
                  <View style={[styles.barFill, { width: `${pct}%` }]} />
                </View>
                <Text style={styles.breakdownCount}>{count}</Text>
              </View>
            );
          })}
        </View>
      </View>

      {/* Sort controls */}
      <View style={styles.sortRow}>
        <Text style={styles.sortLabel}>{t("reviews.sortLabel")}</Text>
        {(["newest", "highest", "lowest"] as SortOption[]).map((option) => (
          <TouchableOpacity
            key={option}
            style={[
              styles.sortChip,
              sortBy === option && styles.sortChipActive,
            ]}
            onPress={() => setSortBy(option)}
            activeOpacity={0.7}
          >
            <Text
              style={[
                styles.sortChipText,
                sortBy === option && styles.sortChipTextActive,
              ]}
            >
              {option === "newest"
                ? t("reviews.sortNewest")
                : option === "highest"
                  ? t("reviews.sortHighest")
                  : t("reviews.sortLowest")}
            </Text>
          </TouchableOpacity>
        ))}
      </View>
    </Animated.View>
  );

  if (loading) {
    return <LoadingScreen />;
  }

  return (
    <ScreenErrorBoundary>
      <View style={styles.container}>
        <FlatList
          data={sortedReviews}
          keyExtractor={(item) => item.id}
          renderItem={({ item }) => <ReviewCard review={item} />}
          ListHeaderComponent={renderHeader}
          ListEmptyComponent={
            <View style={styles.emptyState}>
              <Icon
                name="message-text-outline"
                size={48}
                color={colors.textTertiary}
              />
              <Text style={styles.emptyText}>{t("reviews.emptyState")}</Text>
            </View>
          }
          contentContainerStyle={styles.listContent}
          showsVerticalScrollIndicator={false}
        />

        {/* Write Review FAB */}
        <TouchableOpacity
          style={styles.fab}
          onPress={() => setShowWriteModal(true)}
          activeOpacity={0.8}
        >
          <Icon name="pencil" size={24} color={colors.textOnPrimary} />
        </TouchableOpacity>

        <WriteReviewModal
          visible={showWriteModal}
          onClose={() => setShowWriteModal(false)}
          onSubmit={handleSubmitReview}
          lang={lang}
          loading={submitting}
        />
      </View>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },
    listContent: {
      padding: Spacing.md,
      paddingBottom: 100,
    },
    summaryCard: {
      flexDirection: "row",
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      padding: Spacing.lg,
      marginBottom: Spacing.md,
      borderWidth: 1,
      borderColor: colors.borderLight,
      ...Shadows.md,
    },
    summaryLeft: {
      alignItems: "center",
      justifyContent: "center",
      paddingRight: Spacing.lg,
      borderRightWidth: 1,
      borderRightColor: colors.borderLight,
      minWidth: 100,
    },
    avgRating: {
      ...Typography.h1,
      color: colors.text,
      fontSize: 40,
      lineHeight: 48,
    },
    totalCount: {
      ...Typography.caption,
      color: colors.textTertiary,
      marginTop: Spacing.xs,
    },
    summaryRight: {
      flex: 1,
      paddingLeft: Spacing.lg,
      justifyContent: "center",
      gap: 4,
    },
    breakdownRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: 4,
    },
    breakdownStar: {
      ...Typography.caption,
      fontWeight: "600",
      color: colors.textSecondary,
      width: 12,
      textAlign: "center",
    },
    barContainer: {
      flex: 1,
      height: 6,
      backgroundColor: colors.surfaceVariant,
      borderRadius: 3,
      overflow: "hidden",
    },
    barFill: {
      height: "100%",
      backgroundColor: colors.secondary,
      borderRadius: 3,
    },
    breakdownCount: {
      ...Typography.caption,
      color: colors.textTertiary,
      width: 24,
      textAlign: "right",
    },
    sortRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginBottom: Spacing.md,
    },
    sortLabel: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
      fontWeight: "500",
    },
    sortChip: {
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.xs,
      borderRadius: BorderRadius.full,
      backgroundColor: colors.surfaceVariant,
    },
    sortChipActive: {
      backgroundColor: colors.primary,
    },
    sortChipText: {
      ...Typography.caption,
      color: colors.textSecondary,
      fontWeight: "500",
    },
    sortChipTextActive: {
      color: colors.textOnPrimary,
    },
    emptyState: {
      alignItems: "center",
      paddingVertical: Spacing.xxl,
      gap: Spacing.md,
    },
    emptyText: {
      ...Typography.body,
      color: colors.textTertiary,
      textAlign: "center",
    },
    fab: {
      position: "absolute",
      right: Spacing.lg,
      bottom: Spacing.xl,
      width: 56,
      height: 56,
      borderRadius: 28,
      backgroundColor: colors.primary,
      alignItems: "center",
      justifyContent: "center",
      ...Shadows.lg,
    },
  });
