import React, { useMemo, useCallback, useEffect, useState } from "react";
import {
  View,
  Text,
  TextInput,
  FlatList,
  StyleSheet,
  ScrollView,
  Pressable,
  Platform,
} from "react-native";
import { useRouter } from "expo-router";
import { useTranslation } from "react-i18next";
import { Spacing, Typography, BorderRadius } from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";
import { EmptyState } from "../../src/components/common/EmptyState";
import { PlanListCard } from "../../src/components/plans/PlanListCard";
import { usePlanStore } from "../../src/stores/planStore";
import { hapticLight } from "../../src/utils/haptics";
import { a11yButton } from "../../src/utils/accessibility";
import { ScreenErrorBoundary } from "../../src/components/common/ScreenErrorBoundary";
import { useToastContext } from "../../src/contexts/ToastContext";
import type { Plan } from "../../src/types/database";

type StatusFilter = "all" | "planning" | "ready" | "completed";

const STATUS_FILTERS: StatusFilter[] = [
  "all",
  "planning",
  "ready",
  "completed",
];

function PlansScreenContent() {
  const router = useRouter();
  const { t } = useTranslation("plans");
  const { plans, loadPlans, isLoading, error } = usePlanStore();
  const { colors } = useTheme();
  const { showToast } = useToastContext();
  const [activeFilter, setActiveFilter] = useState<StatusFilter>("all");
  const [searchQuery, setSearchQuery] = useState("");
  const [loadError, setLoadError] = useState(false);

  const fetchPlans = useCallback(() => {
    setLoadError(false);
    loadPlans().catch((err: unknown) => {
      if (__DEV__) console.warn("[Plans] Failed to load plans:", err);
      setLoadError(true);
      showToast(t("common:errors.loadFailed"), "error");
    });
  }, [loadPlans, showToast, t]);

  useEffect(() => {
    fetchPlans();
  }, []);

  const styles = useMemo(() => createStyles(colors), [colors]);

  const statusCounts = useMemo(() => {
    const counts: Record<StatusFilter, number> = {
      all: plans.length,
      planning: 0,
      ready: 0,
      completed: 0,
    };
    for (const plan of plans) {
      if (plan.status === "planning") counts.planning++;
      else if (plan.status === "ready") counts.ready++;
      else if (plan.status === "completed") counts.completed++;
    }
    return counts;
  }, [plans]);

  const filteredPlans = useMemo(() => {
    let result =
      activeFilter === "all"
        ? plans
        : plans.filter((p) => p.status === activeFilter);
    if (searchQuery.trim()) {
      const q = searchQuery.toLowerCase();
      result = result.filter((p) => p.title.toLowerCase().includes(q));
    }
    return result;
  }, [plans, activeFilter, searchQuery]);

  const handleFilterPress = useCallback((filter: StatusFilter) => {
    hapticLight();
    setActiveFilter(filter);
  }, []);

  const handlePlanPress = useCallback(
    (plan: Plan) => {
      router.push(`/plan/${plan.id}`);
    },
    [router],
  );

  const keyExtractor = useCallback((item: Plan) => item.id, []);

  const getFilterLabel = useCallback(
    (filter: StatusFilter): string => {
      if (filter === "all") return t("filter_all");
      return t(`status.${filter}`);
    },
    [t],
  );

  const renderItem = useCallback(
    ({ item, index }: { item: Plan; index: number }) => (
      <View style={styles.cardWrapper}>
        <PlanListCard plan={item} onPress={handlePlanPress} index={index} />
      </View>
    ),
    [handlePlanPress, styles.cardWrapper],
  );

  const listHeader = useMemo(
    () => (
      <View>
        <TextInput
          style={styles.searchInput}
          placeholder={t("searchPlaceholder")}
          placeholderTextColor={colors.textTertiary}
          value={searchQuery}
          onChangeText={setSearchQuery}
          returnKeyType="search"
          clearButtonMode="while-editing"
          maxFontSizeMultiplier={1.2}
        />
        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
          contentContainerStyle={styles.filterContainer}
          style={styles.filterScroll}
        >
          {STATUS_FILTERS.map((filter) => {
            const isActive = activeFilter === filter;
            const count = statusCounts[filter];
            return (
              <Pressable
                key={filter}
                onPress={() => handleFilterPress(filter)}
                style={[
                  styles.filterPill,
                  isActive
                    ? { backgroundColor: colors.primary }
                    : { backgroundColor: colors.backgroundSecondary },
                ]}
                {...a11yButton(getFilterLabel(filter))}
              >
                <Text
                  style={[
                    styles.filterText,
                    isActive
                      ? { color: colors.textOnPrimary }
                      : { color: colors.text },
                  ]}
                >
                  {getFilterLabel(filter)} ({count})
                </Text>
              </Pressable>
            );
          })}
        </ScrollView>
      </View>
    ),
    [
      activeFilter,
      statusCounts,
      colors,
      styles,
      handleFilterPress,
      getFilterLabel,
      searchQuery,
      t,
    ],
  );

  if ((loadError || error) && plans.length === 0 && !isLoading) {
    return (
      <View style={styles.container}>
        <EmptyState
          emoji="⚠️"
          title={t("common:errors.loadFailedTitle")}
          description={t("common:errors.loadFailedDesc")}
          actionLabel={t("common:errors.retry")}
          onAction={fetchPlans}
        />
      </View>
    );
  }

  if (plans.length === 0) {
    return (
      <View style={styles.container}>
        <EmptyState
          emoji={"\uD83D\uDCCB"}
          title={t("my_plans")}
          description={t("empty")}
          actionLabel={t("common:tabs.explore")}
          onAction={() => router.push("/(tabs)/explore")}
        />
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <FlatList
        data={filteredPlans}
        keyExtractor={keyExtractor}
        renderItem={renderItem}
        contentContainerStyle={styles.listContent}
        removeClippedSubviews={Platform.OS !== "web"}
        showsVerticalScrollIndicator={false}
        maxToRenderPerBatch={8}
        windowSize={5}
        initialNumToRender={6}
        updateCellsBatchingPeriod={50}
        ListHeaderComponent={listHeader}
      />
    </View>
  );
}

export default function PlansScreen() {
  return (
    <ScreenErrorBoundary>
      <PlansScreenContent />
    </ScreenErrorBoundary>
  );
}

const createStyles = (
  colors: ReturnType<typeof import("../../src/constants/theme").getColors>,
) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },
    listContent: {
      paddingBottom: 100,
      paddingHorizontal: 16,
    },
    cardWrapper: {
      marginBottom: 12,
    },
    // Search
    searchInput: {
      backgroundColor: colors.surfaceVariant ?? colors.backgroundSecondary,
      borderRadius: BorderRadius.md,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      ...Typography.body,
      color: colors.text,
      marginTop: Spacing.sm,
      marginBottom: Spacing.sm,
    },
    // Filter pills
    filterScroll: {
      flexGrow: 0,
      marginBottom: Spacing.md,
      marginTop: Spacing.sm,
    },
    filterContainer: {
      gap: Spacing.sm,
    },
    filterPill: {
      flexDirection: "row",
      alignItems: "center",
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      borderRadius: BorderRadius.full,
    },
    filterText: {
      ...Typography.bodySmall,
    },
  });
