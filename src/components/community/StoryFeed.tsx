import React, { useState, useCallback, useMemo } from "react";
import {
  View,
  Text,
  FlatList,
  TouchableOpacity,
  StyleSheet,
  ActivityIndicator,
  RefreshControl,
} from "react-native";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import { useTheme } from "../../contexts/ThemeContext";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../constants/theme";
import { Skeleton } from "../ui/Skeleton";
import { StoryCard } from "./StoryCard";
import type { Story } from "../../stores/communityStore";

type FilterType = "all" | "trending" | "recent" | "my_stories";

interface StoryFeedProps {
  stories: Story[];
  onLoadMore: () => void;
  loading: boolean;
  onRefresh: () => void;
  onStoryPress?: (story: Story) => void;
  onLike?: (storyId: string) => void;
  onComment?: (storyId: string) => void;
  onWriteStory?: () => void;
}

const FILTERS: { key: FilterType; labelKey: string }[] = [
  { key: "all", labelKey: "community.all" },
  { key: "trending", labelKey: "community.trending" },
  { key: "recent", labelKey: "community.recent" },
  { key: "my_stories", labelKey: "community.my_stories" },
];

export function StoryFeed({
  stories,
  onLoadMore,
  loading,
  onRefresh,
  onStoryPress,
  onLike,
  onComment,
  onWriteStory,
}: StoryFeedProps) {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const [activeFilter, setActiveFilter] = useState<FilterType>("all");
  const [refreshing, setRefreshing] = useState(false);
  const styles = useMemo(() => createStyles(colors), [colors]);

  const handleRefresh = useCallback(async () => {
    setRefreshing(true);
    onRefresh();
    setRefreshing(false);
  }, [onRefresh]);

  const renderFilterChips = () => (
    <View style={styles.filtersContainer}>
      {FILTERS.map((filter) => {
        const isActive = activeFilter === filter.key;
        return (
          <TouchableOpacity
            key={filter.key}
            style={[styles.filterChip, isActive && styles.filterChipActive]}
            onPress={() => setActiveFilter(filter.key)}
            activeOpacity={0.7}
          >
            <Text
              style={[styles.filterText, isActive && styles.filterTextActive]}
            >
              {t(filter.labelKey)}
            </Text>
          </TouchableOpacity>
        );
      })}
    </View>
  );

  const renderEmptyState = () => (
    <View style={styles.emptyContainer}>
      <Icon name="book-open-variant" size={64} color={colors.textTertiary} />
      <Text style={styles.emptyTitle}>{t("community.no_stories_title")}</Text>
      <Text style={styles.emptyDescription}>
        {t("community.no_stories_desc")}
      </Text>
    </View>
  );

  const renderFooter = () => {
    if (!loading) return null;
    return (
      <View style={styles.loadingFooter}>
        <LoadingSkeleton colors={colors} />
      </View>
    );
  };

  const renderItem = useCallback(
    ({ item, index }: { item: Story; index: number }) => (
      <StoryCard
        story={item}
        onPress={(s) => onStoryPress?.(s)}
        index={index}
      />
    ),
    [onStoryPress],
  );

  const keyExtractor = useCallback((item: Story) => item.id, []);

  return (
    <View style={styles.container}>
      <FlatList
        data={stories}
        renderItem={renderItem}
        keyExtractor={keyExtractor}
        ListHeaderComponent={renderFilterChips}
        ListEmptyComponent={!loading ? renderEmptyState : null}
        ListFooterComponent={renderFooter}
        onEndReached={onLoadMore}
        onEndReachedThreshold={0.5}
        contentContainerStyle={styles.listContent}
        showsVerticalScrollIndicator={false}
        refreshControl={
          <RefreshControl
            refreshing={refreshing}
            onRefresh={handleRefresh}
            colors={[colors.primary]}
            tintColor={colors.primary}
          />
        }
      />

      {/* Floating Action Button */}
      <TouchableOpacity
        style={styles.fab}
        onPress={onWriteStory}
        activeOpacity={0.8}
      >
        <Icon name="pencil-plus" size={24} color={colors.textOnPrimary} />
        <Text style={styles.fabText}>{t("community.write_story_fab")}</Text>
      </TouchableOpacity>
    </View>
  );
}

function LoadingSkeleton({ colors }: { colors: ThemeColors }) {
  const styles = useMemo(() => createStyles(colors), [colors]);
  return (
    <View style={styles.skeletonContainer}>
      <Skeleton width="100%" height={200} borderRadius={BorderRadius.lg} />
      <View style={styles.skeletonRow}>
        <Skeleton width={36} height={36} borderRadius={18} />
        <View style={styles.skeletonTextGroup}>
          <Skeleton width={120} height={14} />
          <Skeleton width={80} height={10} style={styles.skeletonSpacing} />
        </View>
      </View>
      <Skeleton width="80%" height={16} style={styles.skeletonSpacing} />
      <Skeleton width="100%" height={12} style={styles.skeletonSpacing} />
      <Skeleton width="60%" height={12} style={styles.skeletonSpacing} />
    </View>
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
      paddingBottom: Spacing.xxl + 60,
    },
    filtersContainer: {
      flexDirection: "row",
      gap: Spacing.sm,
      marginBottom: Spacing.md,
    },
    filterChip: {
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      borderRadius: BorderRadius.full,
      backgroundColor: colors.surfaceVariant,
    },
    filterChipActive: {
      backgroundColor: colors.primary,
    },
    filterText: {
      ...Typography.caption,
      fontWeight: "600",
      color: colors.textSecondary,
    },
    filterTextActive: {
      color: colors.textOnPrimary,
    },
    emptyContainer: {
      alignItems: "center",
      justifyContent: "center",
      paddingVertical: Spacing.xxl,
      paddingHorizontal: Spacing.xl,
    },
    emptyTitle: {
      ...Typography.h3,
      color: colors.text,
      textAlign: "center",
      marginTop: Spacing.md,
      marginBottom: Spacing.sm,
    },
    emptyDescription: {
      ...Typography.body,
      color: colors.textSecondary,
      textAlign: "center",
    },
    loadingFooter: {
      paddingVertical: Spacing.md,
    },
    skeletonContainer: {
      padding: Spacing.md,
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      ...Shadows.sm,
    },
    skeletonRow: {
      flexDirection: "row",
      alignItems: "center",
      marginTop: Spacing.md,
      gap: Spacing.sm,
    },
    skeletonTextGroup: {
      flex: 1,
    },
    skeletonSpacing: {
      marginTop: Spacing.sm,
    },
    fab: {
      position: "absolute",
      bottom: Spacing.lg,
      right: Spacing.md,
      flexDirection: "row",
      alignItems: "center",
      backgroundColor: colors.primary,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm + 2,
      borderRadius: BorderRadius.full,
      gap: Spacing.sm,
      ...Shadows.lg,
    },
    fabText: {
      ...Typography.buttonSmall,
      color: colors.textOnPrimary,
    },
  });
