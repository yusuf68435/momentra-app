import React, {
  useState,
  useMemo,
  useCallback,
  useEffect,
  memo,
  useRef,
} from "react";
import {
  View,
  Text,
  TextInput,
  ScrollView,
  FlatList,
  StyleSheet,
  TouchableOpacity,
  Platform,
} from "react-native";
import { useRouter } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon } from "../../src/components/ui/Icon";
import type { IconName } from "../../src/constants/icons";
import { CachedImage } from "../../src/components/common/CachedImage";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";
import { CATEGORIES } from "../../src/constants/categories";
import { EmptyState } from "../../src/components/common/EmptyState";
import { SkeletonCard } from "../../src/components/ui/Skeleton";
import { useScenarioStore } from "../../src/stores/scenarioStore";
import type { Scenario } from "../../src/types/database";
import {
  FilterModal,
  DEFAULT_FILTERS,
  type ScenarioFilterState,
} from "../../src/components/scenarios/FilterModal";
import { QuickPathStrip } from "../../src/components/scenarios/QuickPathStrip";
import { hapticLight, hapticSelection } from "../../src/utils/haptics";
import { a11yButton, a11yHeader } from "../../src/utils/accessibility";
import { ScreenErrorBoundary } from "../../src/components/common/ScreenErrorBoundary";
import { useToastContext } from "../../src/contexts/ToastContext";

type SortOption = "popular" | "rating" | "budget_low" | "budget_high";

let persistedCategoryId: string | null = null;

const ScenarioCard = memo(
  ({
    item,
    lang,
    colors,
    onPress,
  }: {
    item: Scenario & { emoji?: string };
    lang: "tr" | "en";
    colors: ThemeColors;
    onPress: () => void;
  }) => {
    const title = lang === "tr" ? item.title_tr : item.title_en;
    const desc =
      lang === "tr" ? item.short_desc_tr || "" : item.short_desc_en || "";
    const catDef = CATEGORIES.find((c) => c.slug === item.category?.slug);

    return (
      <TouchableOpacity
        style={[cardStyles.card, { backgroundColor: colors.surface }]}
        onPress={() => {
          hapticLight();
          onPress();
        }}
        activeOpacity={0.7}
        {...a11yButton(title, desc)}
      >
        {/* Thumbnail area */}
        <View style={cardStyles.iconArea}>
          {item.cover_image_url ? (
            <View
              style={[
                cardStyles.iconSquare,
                { backgroundColor: (catDef?.color || colors.primary) + "14" },
              ]}
            >
              <CachedImage
                uri={item.cover_image_url}
                style={cardStyles.thumbnail}
                contentFit="cover"
                fallbackIcon="gift"
              />
            </View>
          ) : (
            <View
              style={[
                cardStyles.iconSquare,
                { backgroundColor: (catDef?.color || colors.primary) + "14" },
              ]}
            >
              <Icon
                name={(catDef?.icon || "gift") as IconName}
                size={24}
                color={catDef?.color || colors.primary}
              />
            </View>
          )}
        </View>

        {/* Content */}
        <View style={cardStyles.content}>
          <Text
            style={[cardStyles.title, { color: colors.text }]}
            numberOfLines={1}
            maxFontSizeMultiplier={1.3}
          >
            {title}
          </Text>
          <Text
            style={[cardStyles.desc, { color: colors.textSecondary }]}
            numberOfLines={2}
            maxFontSizeMultiplier={1.2}
          >
            {desc}
          </Text>
          <View style={cardStyles.metaRow}>
            <Text
              style={[cardStyles.metaText, { color: colors.textTertiary }]}
              maxFontSizeMultiplier={1.1}
            >
              {"\u2605"} {(item.rating_avg ?? 0).toFixed(1)}
            </Text>
            <Text
              style={[cardStyles.metaText, { color: colors.textTertiary }]}
              maxFontSizeMultiplier={1.1}
            >
              {"\u20BA"}
              {(item.min_budget ?? 0).toLocaleString()}
            </Text>
          </View>
        </View>

        {/* PRO badge */}
        {item.is_premium && (
          <View
            style={[cardStyles.proBadge, { backgroundColor: colors.primary }]}
          >
            <Text
              style={[cardStyles.proText, { color: colors.textOnPrimary }]}
              maxFontSizeMultiplier={1.0}
            >
              PRO
            </Text>
          </View>
        )}
      </TouchableOpacity>
    );
  },
);

const cardStyles = StyleSheet.create({
  card: {
    flexDirection: "row",
    alignItems: "center",
    borderRadius: BorderRadius.md,
    marginHorizontal: 16,
    marginBottom: 12,
    padding: 12,
    ...Shadows.sm,
  },
  iconArea: {
    width: 60,
    alignItems: "center",
    justifyContent: "center",
  },
  thumbnail: {
    width: 56,
    height: 56,
    borderRadius: 12,
    position: "absolute" as const,
    top: 0,
    left: 0,
  },
  iconSquare: {
    width: 56,
    height: 56,
    borderRadius: 12,
    alignItems: "center",
    justifyContent: "center",
    overflow: "hidden" as const,
  },
  content: {
    flex: 1,
    paddingLeft: 12,
  },
  title: {
    ...Typography.h4,
    fontWeight: "600",
  },
  desc: {
    ...Typography.caption,
    marginTop: 2,
  },
  metaRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: 12,
    marginTop: 4,
  },
  metaText: {
    ...Typography.caption,
  },
  proBadge: {
    position: "absolute",
    top: 8,
    right: 8,
    paddingHorizontal: 6,
    paddingVertical: 2,
    borderRadius: BorderRadius.full,
  },
  proText: {
    ...Typography.label,
    color: "#FFFFFF",
    fontSize: 10,
    fontWeight: "700",
  },
});

function ExploreScreenContent() {
  const router = useRouter();
  const { t, i18n } = useTranslation("scenarios");
  const lang = i18n.language as "tr" | "en";
  const { colors } = useTheme();
  const { showToast } = useToastContext();
  const {
    scenarios: storeScenarios,
    isLoading,
    loadScenarios,
  } = useScenarioStore();

  const [loadError, setLoadError] = useState(false);
  const hasFetched = useRef(false);

  const fetchScenarios = useCallback(() => {
    setLoadError(false);
    loadScenarios().catch((err: unknown) => {
      if (__DEV__) console.warn("[Explore] Failed to load scenarios:", err);
      setLoadError(true);
      showToast(t("common:errors.loadFailed"), "error");
    });
  }, [loadScenarios, showToast, t]);

  useEffect(() => {
    if (!hasFetched.current) {
      hasFetched.current = true;
      fetchScenarios();
    }
  }, [fetchScenarios]);

  const [searchQuery, setSearchQuery] = useState("");
  const [selectedCategory, setSelectedCategory] = useState<string | null>(
    persistedCategoryId,
  );
  const [sortBy, setSortBy] = useState<SortOption>("popular");
  const [showFilterModal, setShowFilterModal] = useState(false);
  const [filters, setFilters] = useState<ScenarioFilterState>(DEFAULT_FILTERS);

  const activeFilterCount = useMemo(() => {
    let count = 0;
    if (filters.budgetRange[0] !== 0 || filters.budgetRange[1] !== 50000)
      count++;
    if (filters.difficulty.length > 0) count++;
    if (filters.peopleCount[0] !== 1 || filters.peopleCount[1] !== 50) count++;
    if (filters.indoorOutdoor.length > 0) count++;
    if (filters.seasons.length > 0) count++;
    if (filters.prepDays[0] !== 0 || filters.prepDays[1] !== 30) count++;
    if (filters.showPremiumOnly) count++;
    return count;
  }, [filters]);

  const filteredScenarios = useMemo(() => {
    let scenarios = [...storeScenarios];

    if (selectedCategory) {
      scenarios = scenarios.filter(
        (s) => s.category?.slug === selectedCategory,
      );
    }

    if (searchQuery.trim()) {
      const q = searchQuery.toLowerCase();
      scenarios = scenarios.filter((s) => {
        const title = lang === "tr" ? s.title_tr : s.title_en;
        const desc =
          lang === "tr" ? s.short_desc_tr || "" : s.short_desc_en || "";
        const tags = s.tags.join(" ").toLowerCase();
        return (
          title.toLowerCase().includes(q) ||
          desc.toLowerCase().includes(q) ||
          tags.includes(q)
        );
      });
    }

    if (filters.budgetRange[0] !== 0 || filters.budgetRange[1] !== 50000) {
      scenarios = scenarios.filter((s) => {
        const minB = s.min_budget || 0;
        return minB >= filters.budgetRange[0] && minB <= filters.budgetRange[1];
      });
    }

    if (filters.difficulty.length > 0) {
      scenarios = scenarios.filter((s) =>
        filters.difficulty.includes(s.difficulty),
      );
    }

    if (filters.peopleCount[0] !== 1 || filters.peopleCount[1] !== 50) {
      scenarios = scenarios.filter((s) => {
        const minP = s.min_people;
        const maxP = s.max_people || 50;
        return minP <= filters.peopleCount[1] && maxP >= filters.peopleCount[0];
      });
    }

    if (filters.indoorOutdoor.length > 0) {
      scenarios = scenarios.filter(
        (s) =>
          filters.indoorOutdoor.includes(s.indoor_outdoor) ||
          s.indoor_outdoor === "both",
      );
    }

    if (filters.seasons.length > 0) {
      scenarios = scenarios.filter((s) =>
        filters.seasons.some((season) => s.season.includes(season)),
      );
    }

    if (filters.prepDays[0] !== 0 || filters.prepDays[1] !== 30) {
      scenarios = scenarios.filter(
        (s) =>
          s.prep_days >= filters.prepDays[0] &&
          s.prep_days <= filters.prepDays[1],
      );
    }

    if (filters.showPremiumOnly) {
      scenarios = scenarios.filter((s) => s.is_premium);
    }

    switch (sortBy) {
      case "popular":
        scenarios.sort((a, b) => b.view_count - a.view_count);
        break;
      case "rating":
        scenarios.sort((a, b) => b.rating_avg - a.rating_avg);
        break;
      case "budget_low":
        scenarios.sort((a, b) => (a.min_budget || 0) - (b.min_budget || 0));
        break;
      case "budget_high":
        scenarios.sort((a, b) => (b.max_budget || 0) - (a.max_budget || 0));
        break;
    }

    return scenarios;
  }, [selectedCategory, searchQuery, sortBy, lang, filters, storeScenarios]);

  const resultCount = filteredScenarios.length;

  const handleApplyFilters = useCallback((newFilters: ScenarioFilterState) => {
    setFilters(newFilters);
    setShowFilterModal(false);
    hapticSelection();
  }, []);

  const handleQuickPath = useCallback(
    (pathFilters: Partial<ScenarioFilterState>) => {
      hapticSelection();
      setFilters({ ...DEFAULT_FILTERS, ...pathFilters });
    },
    [setFilters],
  );

  const clearAllFilters = useCallback(() => {
    setFilters(DEFAULT_FILTERS);
    persistedCategoryId = null;
    setSelectedCategory(null);
    setSearchQuery("");
    setSortBy("popular");
    hapticLight();
  }, []);

  const handleScenarioPress = useCallback(
    (id: string) => {
      router.push(`/scenario/${id}`);
    },
    [router],
  );

  const styles = useMemo(() => createStyles(colors), [colors]);

  const renderScenarioCard = useCallback(
    ({ item }: { item: Scenario & { emoji?: string } }) => (
      <ScenarioCard
        item={item}
        lang={lang}
        colors={colors}
        onPress={() => handleScenarioPress(item.id)}
      />
    ),
    [lang, colors, handleScenarioPress],
  );

  const keyExtractor = useCallback(
    (item: Scenario & { emoji?: string }) => item.id,
    [],
  );

  const sortOptions: { key: SortOption; label: string }[] = [
    {
      key: "popular",
      label: t("common:explore.sort_popular"),
    },
    {
      key: "rating",
      label: t("common:explore.sort_rating"),
    },
    {
      key: "budget_low",
      label: t("common:explore.sort_budget"),
    },
  ];

  return (
    <View style={styles.container}>
      {/* Search Bar */}
      <View style={styles.searchContainer}>
        <Icon name="magnify" size={18} color={colors.textTertiary} />
        <TextInput
          style={styles.searchInput}
          placeholder={t("common:explore.search_placeholder")}
          placeholderTextColor={colors.textTertiary}
          value={searchQuery}
          onChangeText={setSearchQuery}
          maxFontSizeMultiplier={1.2}
          returnKeyType="search"
          clearButtonMode="while-editing"
        />
        {searchQuery.length > 0 && Platform.OS !== "ios" && (
          <TouchableOpacity
            onPress={() => setSearchQuery("")}
            {...a11yButton("Clear search")}
          >
            <Icon name="close-circle" size={18} color={colors.textTertiary} />
          </TouchableOpacity>
        )}
      </View>

      {/* Category Filter Chips */}
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        style={styles.chipRow}
        contentContainerStyle={styles.chipRowContent}
      >
        <TouchableOpacity
          style={[
            styles.chip,
            {
              backgroundColor: !selectedCategory
                ? colors.primary
                : colors.backgroundSecondary,
            },
          ]}
          onPress={() => {
            hapticSelection();
            persistedCategoryId = null;
            setSelectedCategory(null);
          }}
          activeOpacity={0.7}
        >
          <Text
            style={[
              styles.chipText,
              { color: !selectedCategory ? colors.textOnPrimary : colors.text },
            ]}
            numberOfLines={1}
            maxFontSizeMultiplier={1.1}
          >
            {t("common:explore.all_categories")}
          </Text>
        </TouchableOpacity>
        {CATEGORIES.map((cat) => {
          const isSelected = selectedCategory === cat.slug;
          return (
            <TouchableOpacity
              key={cat.slug}
              style={[
                styles.chip,
                {
                  backgroundColor: isSelected
                    ? colors.primary
                    : colors.backgroundSecondary,
                },
              ]}
              onPress={() => {
                hapticSelection();
                const next = isSelected ? null : cat.slug;
                persistedCategoryId = next;
                setSelectedCategory(next);
              }}
              activeOpacity={0.7}
            >
              <Text
                style={[
                  styles.chipText,
                  { color: isSelected ? colors.textOnPrimary : colors.text },
                ]}
                numberOfLines={1}
                maxFontSizeMultiplier={1.1}
              >
                {t(`common:categories.${cat.slug}`)}
              </Text>
            </TouchableOpacity>
          );
        })}
      </ScrollView>

      {/* Sort Row */}
      <View style={styles.sortRow}>
        <Text
          style={[styles.resultCount, { color: colors.textTertiary }]}
          maxFontSizeMultiplier={1.2}
          {...a11yHeader(
            t("common:explore.scenarios_count", { count: resultCount }),
            2,
          )}
        >
          {t("common:explore.scenarios_count", { count: resultCount })}
        </Text>
        <View style={styles.sortOptions}>
          {sortOptions.map((opt, index) => {
            const isActive = sortBy === opt.key;
            return (
              <React.Fragment key={opt.key}>
                {index > 0 && (
                  <Text
                    style={[
                      styles.sortSeparator,
                      { color: colors.textTertiary },
                    ]}
                  >
                    |
                  </Text>
                )}
                <TouchableOpacity
                  onPress={() => {
                    hapticSelection();
                    setSortBy(opt.key);
                  }}
                  {...a11yButton(opt.label)}
                >
                  <Text
                    style={[
                      styles.sortText,
                      {
                        color: isActive ? colors.primary : colors.textTertiary,
                        fontWeight: isActive ? "600" : "400",
                      },
                    ]}
                    maxFontSizeMultiplier={1.1}
                  >
                    {opt.label}
                  </Text>
                </TouchableOpacity>
              </React.Fragment>
            );
          })}
        </View>

        {/* Filter button */}
        <TouchableOpacity
          style={styles.filterButton}
          onPress={() => {
            hapticLight();
            setShowFilterModal(true);
          }}
          {...a11yButton(
            t("common:explore.filters"),
            `${activeFilterCount} active`,
          )}
        >
          <Icon
            name="tune-variant"
            size={18}
            color={activeFilterCount > 0 ? colors.primary : colors.textTertiary}
          />
          {activeFilterCount > 0 && (
            <View
              style={[styles.filterDot, { backgroundColor: colors.primary }]}
            />
          )}
        </TouchableOpacity>
      </View>

      {/* Active Filter Tags */}
      {activeFilterCount > 0 && (
        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
          style={styles.activeFiltersRow}
          contentContainerStyle={styles.activeFiltersContent}
        >
          {(filters.budgetRange[0] !== 0 ||
            filters.budgetRange[1] !== 50000) && (
            <View
              style={[
                styles.activeTag,
                { backgroundColor: colors.backgroundSecondary },
              ]}
            >
              <Text style={[styles.activeTagText, { color: colors.text }]}>
                {"\u20BA"}
                {filters.budgetRange[0].toLocaleString()}-
                {filters.budgetRange[1].toLocaleString()}
              </Text>
              <TouchableOpacity
                onPress={() =>
                  setFilters((f) => ({ ...f, budgetRange: [0, 50000] }))
                }
              >
                <Icon
                  name="close-circle"
                  size={14}
                  color={colors.textTertiary}
                />
              </TouchableOpacity>
            </View>
          )}
          {filters.difficulty.length > 0 && (
            <View
              style={[
                styles.activeTag,
                { backgroundColor: colors.backgroundSecondary },
              ]}
            >
              <Text style={[styles.activeTagText, { color: colors.text }]}>
                {t("common:comparison.difficulty")}:{" "}
                {filters.difficulty.join(", ")}
              </Text>
              <TouchableOpacity
                onPress={() => setFilters((f) => ({ ...f, difficulty: [] }))}
              >
                <Icon
                  name="close-circle"
                  size={14}
                  color={colors.textTertiary}
                />
              </TouchableOpacity>
            </View>
          )}
          {(filters.peopleCount[0] !== 1 || filters.peopleCount[1] !== 50) && (
            <View
              style={[
                styles.activeTag,
                { backgroundColor: colors.backgroundSecondary },
              ]}
            >
              <Text style={[styles.activeTagText, { color: colors.text }]}>
                {filters.peopleCount[0]}-{filters.peopleCount[1]}{" "}
                {t("common:common.people")}
              </Text>
              <TouchableOpacity
                onPress={() =>
                  setFilters((f) => ({ ...f, peopleCount: [1, 50] }))
                }
              >
                <Icon
                  name="close-circle"
                  size={14}
                  color={colors.textTertiary}
                />
              </TouchableOpacity>
            </View>
          )}
          <TouchableOpacity onPress={clearAllFilters}>
            <Text
              style={[styles.clearAllText, { color: colors.primary }]}
              maxFontSizeMultiplier={1.1}
            >
              {t("common:explore.clear")}
            </Text>
          </TouchableOpacity>
        </ScrollView>
      )}

      {/* Quick Path Strip */}
      <QuickPathStrip lang={lang} onSelectPath={handleQuickPath} />

      {/* Scenario List */}
      {loadError && storeScenarios.length === 0 ? (
        <EmptyState
          emoji="⚠️"
          title={t("common:errors.loadFailedTitle")}
          description={t("common:errors.loadFailedDesc")}
          actionLabel={t("common:errors.retry")}
          onAction={fetchScenarios}
        />
      ) : storeScenarios.length === 0 && isLoading ? (
        <View style={styles.loadingContainer}>
          {[...Array(4)].map((_, i) => (
            <SkeletonCard key={i} />
          ))}
        </View>
      ) : filteredScenarios.length === 0 ? (
        <EmptyState
          emoji={"🔍"}
          title={t("common:common.no_results")}
          description={t("common:explore.no_results_desc")}
        />
      ) : (
        <FlatList
          data={filteredScenarios}
          keyExtractor={keyExtractor}
          contentContainerStyle={{ paddingBottom: 100 }}
          renderItem={renderScenarioCard}
          showsVerticalScrollIndicator={false}
          removeClippedSubviews={Platform.OS !== "web"}
          maxToRenderPerBatch={10}
          initialNumToRender={8}
          windowSize={5}
          updateCellsBatchingPeriod={50}
        />
      )}

      {/* Filter Modal */}
      <FilterModal
        visible={showFilterModal}
        onClose={() => setShowFilterModal(false)}
        onApply={handleApplyFilters}
        currentFilters={filters}
        lang={lang}
      />
    </View>
  );
}

export default function ExploreScreen() {
  return (
    <ScreenErrorBoundary>
      <ExploreScreenContent />
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

    // Search
    searchContainer: {
      flexDirection: "row",
      alignItems: "center",
      backgroundColor: colors.backgroundSecondary,
      borderRadius: BorderRadius.md,
      height: 36,
      paddingHorizontal: 12,
      marginHorizontal: 16,
      marginTop: Spacing.md,
      marginBottom: 12,
      gap: 8,
    },
    searchInput: {
      flex: 1,
      ...Typography.body,
      fontSize: 15,
      color: colors.text,
      paddingVertical: 0,
    },

    // Category chips
    chipRow: {
      marginBottom: 12,
      height: 40,
    },
    chipRowContent: {
      paddingHorizontal: 16,
      gap: 8,
      alignItems: "center",
    },
    chip: {
      height: 32,
      paddingHorizontal: 12,
      borderRadius: BorderRadius.full,
      alignItems: "center",
      justifyContent: "center",
    },
    chipText: {
      fontSize: 12,
      fontWeight: "500" as const,
    },

    // Sort
    sortRow: {
      flexDirection: "row",
      alignItems: "center",
      paddingHorizontal: 16,
      marginBottom: 12,
      marginTop: 4,
    },
    resultCount: {
      ...Typography.caption,
      fontWeight: "600",
    },
    sortOptions: {
      flexDirection: "row",
      alignItems: "center",
      marginLeft: "auto",
      gap: 8,
    },
    sortText: {
      ...Typography.caption,
    },
    sortSeparator: {
      ...Typography.caption,
    },
    filterButton: {
      marginLeft: 12,
      position: "relative",
    },
    filterDot: {
      position: "absolute",
      top: -2,
      right: -2,
      width: 6,
      height: 6,
      borderRadius: 3,
    },

    // Active filters
    activeFiltersRow: {
      marginBottom: 8,
      maxHeight: 36,
    },
    activeFiltersContent: {
      paddingHorizontal: 16,
      gap: 8,
      alignItems: "center",
    },
    activeTag: {
      flexDirection: "row",
      alignItems: "center",
      gap: 4,
      paddingHorizontal: 10,
      paddingVertical: 4,
      borderRadius: BorderRadius.full,
    },
    activeTagText: {
      ...Typography.caption,
      fontWeight: "500",
    },
    clearAllText: {
      ...Typography.caption,
      fontWeight: "600",
    },

    // Loading
    loadingContainer: {
      paddingHorizontal: 16,
    },
  });
