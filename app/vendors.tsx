import React, { useState, useCallback, useMemo, useEffect } from "react";
import {
  View,
  Text,
  FlatList,
  StyleSheet,
  TouchableOpacity,
  TextInput,
  Modal,
  Linking,
  ScrollView,
  ActivityIndicator,
} from "react-native";
import { useTranslation } from "react-i18next";
import { Icon } from "../src/components/ui/Icon";
import type { IconName } from "../src/constants/icons";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../src/constants/theme";
import { useTheme } from "../src/contexts/ThemeContext";
import { CachedImage } from "../src/components/common/CachedImage";
import {
  searchVendors,
  getFeaturedVendors,
  saveVendorToFavorites,
  removeVendorFromFavorites,
  getFavoriteVendors,
  type Vendor,
  type VendorType,
} from "../src/services/vendors";
import { ScreenErrorBoundary } from "../src/components/common/ScreenErrorBoundary";

type CategoryFilter = "all" | VendorType;
type SortOption = "rating" | "price";

const CATEGORY_CONFIG: Record<
  Exclude<CategoryFilter, "all">,
  { icon: string; labelEn: string; labelTr: string }
> = {
  florist: { icon: "flower", labelEn: "Florist", labelTr: "Çiçekçi" },
  restaurant: {
    icon: "silverware-fork-knife",
    labelEn: "Restaurant",
    labelTr: "Restoran",
  },
  photographer: {
    icon: "camera",
    labelEn: "Photographer",
    labelTr: "Fotoğrafçı",
  },
  decorator: { icon: "palette", labelEn: "Decorator", labelTr: "Dekoratör" },
  baker: { icon: "cake-variant", labelEn: "Baker", labelTr: "Pastacı" },
  musician: { icon: "music", labelEn: "Musician", labelTr: "Müzisyen" },
  venue: { icon: "home-city", labelEn: "Venue", labelTr: "Mekân" },
  caterer: { icon: "food", labelEn: "Caterer", labelTr: "Yemek" },
  event_planner: {
    icon: "clipboard-list",
    labelEn: "Event Planner",
    labelTr: "Organizatör",
  },
  other: { icon: "store", labelEn: "Other", labelTr: "Diğer" },
};

export default function VendorsScreen() {
  const { t, i18n } = useTranslation();
  const lang = i18n.language as "tr" | "en";
  const { colors } = useTheme();

  const [vendors, setVendors] = useState<Vendor[]>([]);
  const [favoriteIds, setFavoriteIds] = useState<Set<string>>(new Set());
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedCategory, setSelectedCategory] =
    useState<CategoryFilter>("all");
  const [sortBy, setSortBy] = useState<SortOption>("rating");
  const [showDetailModal, setShowDetailModal] = useState(false);
  const [selectedVendor, setSelectedVendor] = useState<Vendor | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [page, setPage] = useState(1);
  const [hasMore, setHasMore] = useState(true);

  const PAGE_SIZE = 20;

  const loadVendors = useCallback(
    async (reset = false, pageOverride?: number) => {
      try {
        setIsLoading(true);
        setError(null);
        const currentPage = reset ? 1 : (pageOverride ?? page);
        const data = await searchVendors(
          searchQuery || undefined,
          selectedCategory !== "all" ? selectedCategory : undefined,
          undefined,
          currentPage,
          PAGE_SIZE,
        );
        if (reset) {
          setVendors(data);
          setPage(1);
        } else {
          setVendors((prev) => [...prev, ...data]);
        }
        setHasMore(data.length === PAGE_SIZE);
      } catch (err) {
        setError(err instanceof Error ? err.message : "Failed to load vendors");
      } finally {
        setIsLoading(false);
      }
    },
    [searchQuery, selectedCategory, page],
  );

  const loadFavorites = useCallback(async () => {
    try {
      const favVendors = await getFavoriteVendors();
      setFavoriteIds(new Set(favVendors.map((v) => v.id)));
    } catch {
      // Favorites are non-critical — ignore errors
    }
  }, []);

  useEffect(() => {
    loadVendors(true);
    loadFavorites();
  }, [selectedCategory, loadVendors, loadFavorites]);

  // Debounce search
  useEffect(() => {
    const timer = setTimeout(() => {
      loadVendors(true);
    }, 400);
    return () => clearTimeout(timer);
  }, [searchQuery]);

  const filteredAndSorted = useMemo(() => {
    const sorted = [...vendors];
    if (sortBy === "rating") {
      sorted.sort((a, b) => b.average_rating - a.average_rating);
    } else if (sortBy === "price") {
      sorted.sort((a, b) => a.price_range.length - b.price_range.length);
    }
    return sorted;
  }, [vendors, sortBy]);

  const handleToggleFavorite = useCallback(
    async (vendorId: string) => {
      const isFav = favoriteIds.has(vendorId);
      // Optimistic update
      setFavoriteIds((prev) => {
        const next = new Set(prev);
        if (isFav) next.delete(vendorId);
        else next.add(vendorId);
        return next;
      });
      try {
        if (isFav) {
          await removeVendorFromFavorites(vendorId);
        } else {
          await saveVendorToFavorites(vendorId);
        }
      } catch {
        // Revert on failure
        setFavoriteIds((prev) => {
          const next = new Set(prev);
          if (isFav) next.add(vendorId);
          else next.delete(vendorId);
          return next;
        });
      }
    },
    [favoriteIds],
  );

  const handleCall = useCallback((phone: string) => {
    Linking.openURL(`tel:${phone}`).catch(() => {});
  }, []);

  const handleNavigate = useCallback((address: string) => {
    Linking.openURL(
      `https://maps.google.com/?q=${encodeURIComponent(address)}`,
    ).catch(() => {});
  }, []);

  const handleWebsite = useCallback((website: string) => {
    Linking.openURL(website).catch(() => {});
  }, []);

  const renderStars = (rating: number) => {
    return Array.from({ length: 5 }, (_, i) => (
      <Icon
        key={i}
        name={
          i < Math.floor(rating)
            ? "star"
            : i < rating
              ? "star-half-full"
              : "star-outline"
        }
        size={14}
        color={colors.warning}
      />
    ));
  };

  const styles = useMemo(() => createStyles(colors), [colors]);

  const categories: { key: CategoryFilter; label: string; icon: string }[] = [
    { key: "all", label: t("vendors.all"), icon: "apps" },
    ...Object.entries(CATEGORY_CONFIG).map(([key, val]) => ({
      key: key as CategoryFilter,
      label: t(`vendors.types.${key}`),
      icon: val.icon,
    })),
  ];

  const sortOptions: { key: SortOption; label: string }[] = [
    { key: "rating", label: t("vendors.rating") },
    { key: "price", label: t("vendors.price") },
  ];

  const renderVendor = useCallback(
    ({ item }: { item: Vendor }) => {
      const catCfg =
        CATEGORY_CONFIG[item.type as Exclude<CategoryFilter, "all">];
      const isFav = favoriteIds.has(item.id);
      return (
        <TouchableOpacity
          style={styles.vendorCard}
          onPress={() => {
            setSelectedVendor(item);
            setShowDetailModal(true);
          }}
          activeOpacity={0.8}
        >
          {item.image_url ? (
            <CachedImage
              uri={item.image_url}
              style={styles.vendorImageArea}
              contentFit="cover"
            />
          ) : (
            <View
              style={[
                styles.vendorImageArea,
                {
                  backgroundColor: colors.primary + "10",
                  alignItems: "center",
                  justifyContent: "center",
                },
              ]}
            >
              <Icon
                name={(catCfg?.icon || "store") as IconName}
                size={32}
                color={colors.primary}
              />
            </View>
          )}
          <View style={styles.vendorContent}>
            <View style={styles.vendorHeader}>
              <Text
                style={[styles.vendorName, { color: colors.text }]}
                numberOfLines={1}
              >
                {item.name}
              </Text>
              <TouchableOpacity onPress={() => handleToggleFavorite(item.id)}>
                <Icon
                  name={isFav ? "heart" : "heart-outline"}
                  size={22}
                  color={isFav ? colors.error : colors.textTertiary}
                />
              </TouchableOpacity>
            </View>
            <View style={styles.vendorMeta}>
              {catCfg && (
                <View
                  style={[
                    styles.typeBadge,
                    { backgroundColor: colors.accent + "15" },
                  ]}
                >
                  <Text style={[styles.typeText, { color: colors.accent }]}>
                    {t(`vendors.types.${item.type}`)}
                  </Text>
                </View>
              )}
              <Text style={[styles.priceText, { color: colors.success }]}>
                {item.price_range}
              </Text>
              {item.is_verified && (
                <Icon name="check-circle" size={14} color={colors.info} />
              )}
            </View>
            <View style={styles.ratingRow}>
              <View style={styles.stars}>
                {renderStars(item.average_rating)}
              </View>
              <Text
                style={[styles.ratingText, { color: colors.textSecondary }]}
              >
                {item.average_rating.toFixed(1)} ({item.review_count})
              </Text>
            </View>
          </View>
        </TouchableOpacity>
      );
    },
    [styles, colors, t, favoriteIds, handleToggleFavorite],
  );

  return (
    <ScreenErrorBoundary>
      <View style={styles.container}>
        {/* Header */}
        <View style={styles.header}>
          <Text style={[styles.headerTitle, { color: colors.text }]}>
            {t("vendors.title")}
          </Text>
          <View
            style={[
              styles.searchContainer,
              { backgroundColor: colors.surfaceVariant },
            ]}
          >
            <Icon name="magnify" size={20} color={colors.textTertiary} />
            <TextInput
              style={[styles.searchInput, { color: colors.text }]}
              placeholder={t("vendors.search_services")}
              placeholderTextColor={colors.textTertiary}
              value={searchQuery}
              onChangeText={setSearchQuery}
            />
            {searchQuery.length > 0 && (
              <TouchableOpacity onPress={() => setSearchQuery("")}>
                <Icon name="close" size={18} color={colors.textTertiary} />
              </TouchableOpacity>
            )}
          </View>
        </View>

        {/* Category Filter */}
        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
          style={styles.categoryRow}
          contentContainerStyle={styles.categoryContent}
        >
          {categories.map((cat) => (
            <TouchableOpacity
              key={cat.key}
              style={[
                styles.categoryChip,
                {
                  backgroundColor:
                    selectedCategory === cat.key
                      ? colors.primary
                      : colors.surfaceVariant,
                },
              ]}
              onPress={() => setSelectedCategory(cat.key)}
            >
              <Icon
                name={cat.icon as IconName}
                size={16}
                color={
                  selectedCategory === cat.key
                    ? colors.textOnPrimary
                    : colors.textSecondary
                }
              />
              <Text
                style={[
                  styles.categoryChipText,
                  {
                    color:
                      selectedCategory === cat.key
                        ? colors.textOnPrimary
                        : colors.textSecondary,
                  },
                ]}
              >
                {cat.label}
              </Text>
            </TouchableOpacity>
          ))}
        </ScrollView>

        {/* Sort Options */}
        <View style={styles.sortRow}>
          <Text style={[styles.resultCount, { color: colors.textTertiary }]}>
            {filteredAndSorted.length} {t("vendors.results")}
          </Text>
          <View style={styles.sortOptions}>
            {sortOptions.map((opt) => (
              <TouchableOpacity
                key={opt.key}
                style={[
                  styles.sortChip,
                  {
                    backgroundColor:
                      sortBy === opt.key
                        ? colors.primary
                        : colors.surfaceVariant,
                  },
                ]}
                onPress={() => setSortBy(opt.key)}
              >
                <Text
                  style={[
                    styles.sortChipText,
                    {
                      color:
                        sortBy === opt.key
                          ? colors.textOnPrimary
                          : colors.textSecondary,
                    },
                  ]}
                >
                  {opt.label}
                </Text>
              </TouchableOpacity>
            ))}
          </View>
        </View>

        {/* Vendor List */}
        {error ? (
          <View style={styles.emptyState}>
            <Icon name="alert-circle-outline" size={48} color={colors.error} />
            <Text style={[styles.emptyTitle, { color: colors.text }]}>
              {error}
            </Text>
            <TouchableOpacity onPress={() => loadVendors(true)}>
              <Text style={[styles.retryText, { color: colors.primary }]}>
                {t("vendors.retry")}
              </Text>
            </TouchableOpacity>
          </View>
        ) : (
          <FlatList
            data={filteredAndSorted}
            keyExtractor={(item) => item.id}
            renderItem={renderVendor}
            contentContainerStyle={styles.list}
            showsVerticalScrollIndicator={false}
            onEndReached={() => {
              if (hasMore && !isLoading) {
                const nextPage = page + 1;
                setPage(nextPage);
                loadVendors(false, nextPage);
              }
            }}
            onEndReachedThreshold={0.3}
            ListFooterComponent={
              isLoading ? (
                <ActivityIndicator
                  color={colors.primary}
                  style={{ paddingVertical: Spacing.lg }}
                />
              ) : null
            }
            ListEmptyComponent={
              !isLoading ? (
                <View style={styles.emptyState}>
                  <Icon
                    name="store-search"
                    size={64}
                    color={colors.textTertiary}
                  />
                  <Text style={[styles.emptyTitle, { color: colors.text }]}>
                    {t("vendors.no_services")}
                  </Text>
                </View>
              ) : null
            }
          />
        )}

        {/* Vendor Detail Modal */}
        <Modal visible={showDetailModal} animationType="slide" transparent>
          <View style={styles.modalOverlay}>
            <View
              style={[styles.modalContent, { backgroundColor: colors.surface }]}
            >
              {selectedVendor && (
                <>
                  <View style={styles.modalHeader}>
                    <Text
                      style={[styles.modalTitle, { color: colors.text }]}
                      numberOfLines={1}
                    >
                      {selectedVendor.name}
                    </Text>
                    <TouchableOpacity onPress={() => setShowDetailModal(false)}>
                      <Icon name="close" size={24} color={colors.text} />
                    </TouchableOpacity>
                  </View>

                  <ScrollView showsVerticalScrollIndicator={false}>
                    {selectedVendor.image_url && (
                      <CachedImage
                        uri={selectedVendor.image_url}
                        style={styles.detailImage}
                        contentFit="cover"
                      />
                    )}

                    <View style={styles.detailRating}>
                      <View style={styles.stars}>
                        {renderStars(selectedVendor.average_rating)}
                      </View>
                      <Text
                        style={[
                          styles.detailRatingText,
                          { color: colors.text },
                        ]}
                      >
                        {selectedVendor.average_rating.toFixed(1)} (
                        {selectedVendor.review_count} {t("vendors.reviews")})
                      </Text>
                      {selectedVendor.is_verified && (
                        <View
                          style={[
                            styles.verifiedBadge,
                            { backgroundColor: colors.info + "15" },
                          ]}
                        >
                          <Icon
                            name="check-circle"
                            size={12}
                            color={colors.info}
                          />
                          <Text
                            style={[
                              styles.verifiedText,
                              { color: colors.info },
                            ]}
                          >
                            {t("vendors.verified")}
                          </Text>
                        </View>
                      )}
                    </View>

                    <View style={styles.detailInfoRow}>
                      <View style={styles.detailInfoItem}>
                        <Icon name="cash" size={18} color={colors.success} />
                        <Text
                          style={[
                            styles.detailInfoText,
                            { color: colors.text },
                          ]}
                        >
                          {selectedVendor.price_range}
                        </Text>
                      </View>
                      {selectedVendor.city && (
                        <View style={styles.detailInfoItem}>
                          <Icon
                            name="map-marker"
                            size={18}
                            color={colors.info}
                          />
                          <Text
                            style={[
                              styles.detailInfoText,
                              { color: colors.text },
                            ]}
                          >
                            {selectedVendor.city}
                          </Text>
                        </View>
                      )}
                    </View>

                    {selectedVendor.description && (
                      <Text
                        style={[
                          styles.detailDesc,
                          { color: colors.textSecondary },
                        ]}
                      >
                        {selectedVendor.description}
                      </Text>
                    )}

                    {selectedVendor.address && (
                      <View style={styles.detailAddress}>
                        <Icon
                          name="map-marker-outline"
                          size={18}
                          color={colors.textTertiary}
                        />
                        <Text
                          style={[
                            styles.detailAddressText,
                            { color: colors.textSecondary },
                          ]}
                        >
                          {selectedVendor.address}
                        </Text>
                      </View>
                    )}

                    {selectedVendor.tags && selectedVendor.tags.length > 0 && (
                      <View style={styles.tagsRow}>
                        {selectedVendor.tags.slice(0, 5).map((tag) => (
                          <View
                            key={tag}
                            style={[
                              styles.tagChip,
                              { backgroundColor: colors.surfaceVariant },
                            ]}
                          >
                            <Text
                              style={[
                                styles.tagText,
                                { color: colors.textSecondary },
                              ]}
                            >
                              {tag}
                            </Text>
                          </View>
                        ))}
                      </View>
                    )}

                    <View style={styles.detailActions}>
                      {selectedVendor.phone && (
                        <TouchableOpacity
                          style={[
                            styles.detailActionBtn,
                            { backgroundColor: colors.success },
                          ]}
                          onPress={() => handleCall(selectedVendor.phone!)}
                        >
                          <Icon
                            name="phone"
                            size={20}
                            color={colors.textOnPrimary}
                          />
                          <Text style={styles.detailActionText}>
                            {t("vendors.call")}
                          </Text>
                        </TouchableOpacity>
                      )}
                      {selectedVendor.address && (
                        <TouchableOpacity
                          style={[
                            styles.detailActionBtn,
                            { backgroundColor: colors.info },
                          ]}
                          onPress={() =>
                            handleNavigate(selectedVendor.address!)
                          }
                        >
                          <Icon
                            name="navigation-variant"
                            size={20}
                            color={colors.textOnPrimary}
                          />
                          <Text style={styles.detailActionText}>
                            {t("vendors.navigate")}
                          </Text>
                        </TouchableOpacity>
                      )}
                      {selectedVendor.website && (
                        <TouchableOpacity
                          style={[
                            styles.detailActionBtn,
                            { backgroundColor: colors.accent },
                          ]}
                          onPress={() => handleWebsite(selectedVendor.website!)}
                        >
                          <Icon
                            name="web"
                            size={20}
                            color={colors.textOnPrimary}
                          />
                          <Text style={styles.detailActionText}>
                            {t("vendors.website")}
                          </Text>
                        </TouchableOpacity>
                      )}
                      <TouchableOpacity
                        style={[
                          styles.detailActionBtn,
                          {
                            backgroundColor: favoriteIds.has(selectedVendor.id)
                              ? colors.error
                              : colors.surfaceVariant,
                          },
                        ]}
                        onPress={() => handleToggleFavorite(selectedVendor.id)}
                      >
                        <Icon
                          name={
                            favoriteIds.has(selectedVendor.id)
                              ? "heart"
                              : "heart-outline"
                          }
                          size={20}
                          color={
                            favoriteIds.has(selectedVendor.id)
                              ? colors.textOnPrimary
                              : colors.textSecondary
                          }
                        />
                        <Text
                          style={[
                            styles.detailActionText,
                            {
                              color: favoriteIds.has(selectedVendor.id)
                                ? colors.textOnPrimary
                                : colors.textSecondary,
                            },
                          ]}
                        >
                          {favoriteIds.has(selectedVendor.id)
                            ? t("vendors.saved")
                            : t("vendors.save")}
                        </Text>
                      </TouchableOpacity>
                    </View>
                  </ScrollView>
                </>
              )}
            </View>
          </View>
        </Modal>
      </View>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: { flex: 1, backgroundColor: colors.background },
    header: { padding: Spacing.lg, gap: Spacing.md },
    headerTitle: { ...Typography.h2 },
    searchContainer: {
      flexDirection: "row",
      alignItems: "center",
      borderRadius: BorderRadius.full,
      paddingHorizontal: Spacing.md,
      gap: Spacing.sm,
    },
    searchInput: {
      flex: 1,
      ...Typography.body,
      paddingVertical: Spacing.sm + 2,
    },
    categoryRow: { maxHeight: 48 },
    categoryContent: { paddingHorizontal: Spacing.lg, gap: Spacing.sm },
    categoryChip: {
      flexDirection: "row",
      alignItems: "center",
      gap: 6,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      borderRadius: BorderRadius.full,
    },
    categoryChipText: { ...Typography.caption, fontWeight: "600" },
    sortRow: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "space-between",
      paddingHorizontal: Spacing.lg,
      paddingVertical: Spacing.md,
    },
    resultCount: { ...Typography.caption, fontWeight: "600" },
    sortOptions: { flexDirection: "row", gap: Spacing.sm },
    sortChip: {
      paddingHorizontal: Spacing.sm + 2,
      paddingVertical: Spacing.xs + 1,
      borderRadius: BorderRadius.full,
    },
    sortChipText: { ...Typography.caption, fontWeight: "600" },
    list: { paddingHorizontal: Spacing.lg, paddingBottom: 100 },
    vendorCard: {
      flexDirection: "row",
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      overflow: "hidden",
      marginBottom: Spacing.md,
      borderWidth: 1,
      borderColor: colors.borderLight,
      ...Shadows.sm,
    },
    vendorImageArea: { width: 90, minHeight: 90 },
    vendorContent: { flex: 1, padding: Spacing.md },
    vendorHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
    },
    vendorName: {
      ...Typography.body,
      fontWeight: "600",
      flex: 1,
      marginRight: Spacing.sm,
    },
    vendorMeta: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginTop: Spacing.xs,
    },
    typeBadge: {
      paddingHorizontal: Spacing.sm,
      paddingVertical: 2,
      borderRadius: BorderRadius.full,
    },
    typeText: { ...Typography.caption, fontWeight: "600", fontSize: 10 },
    priceText: { ...Typography.caption, fontWeight: "700" },
    ratingRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginTop: Spacing.xs,
    },
    stars: { flexDirection: "row" },
    ratingText: { ...Typography.caption },
    emptyState: {
      alignItems: "center",
      paddingTop: Spacing.xxl * 2,
      gap: Spacing.sm,
    },
    emptyTitle: { ...Typography.h4 },
    retryText: { ...Typography.body, fontWeight: "600", marginTop: Spacing.sm },
    modalOverlay: {
      flex: 1,
      backgroundColor: "rgba(0,0,0,0.5)",
      justifyContent: "flex-end",
    },
    modalContent: {
      borderTopLeftRadius: BorderRadius.xl,
      borderTopRightRadius: BorderRadius.xl,
      padding: Spacing.lg,
      maxHeight: "80%",
    },
    modalHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      marginBottom: Spacing.md,
    },
    modalTitle: { ...Typography.h3, flex: 1, marginRight: Spacing.sm },
    detailImage: {
      width: "100%",
      height: 180,
      borderRadius: BorderRadius.md,
      marginBottom: Spacing.md,
    },
    detailRating: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginBottom: Spacing.md,
    },
    detailRatingText: { ...Typography.bodySmall },
    verifiedBadge: {
      flexDirection: "row",
      alignItems: "center",
      gap: 3,
      paddingHorizontal: 6,
      paddingVertical: 2,
      borderRadius: BorderRadius.full,
    },
    verifiedText: { ...Typography.caption, fontWeight: "600", fontSize: 10 },
    detailInfoRow: {
      flexDirection: "row",
      gap: Spacing.xl,
      marginBottom: Spacing.md,
    },
    detailInfoItem: { flexDirection: "row", alignItems: "center", gap: 6 },
    detailInfoText: { ...Typography.body },
    detailDesc: {
      ...Typography.bodySmall,
      lineHeight: 22,
      marginBottom: Spacing.md,
    },
    detailAddress: {
      flexDirection: "row",
      alignItems: "center",
      gap: 6,
      marginBottom: Spacing.md,
    },
    detailAddressText: { ...Typography.bodySmall, flex: 1 },
    tagsRow: {
      flexDirection: "row",
      flexWrap: "wrap",
      gap: Spacing.xs,
      marginBottom: Spacing.md,
    },
    tagChip: {
      paddingHorizontal: Spacing.sm,
      paddingVertical: 3,
      borderRadius: BorderRadius.full,
    },
    tagText: { ...Typography.caption, fontSize: 11 },
    detailActions: {
      flexDirection: "row",
      gap: Spacing.sm,
      flexWrap: "wrap",
      marginBottom: Spacing.lg,
    },
    detailActionBtn: {
      flex: 1,
      minWidth: 70,
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: 5,
      paddingVertical: Spacing.sm + 2,
      borderRadius: BorderRadius.md,
    },
    detailActionText: { ...Typography.caption, fontWeight: "600" },
  });
