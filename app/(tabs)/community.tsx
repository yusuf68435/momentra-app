import React, { useState, useCallback, useMemo, useEffect } from "react";
import Animated, { FadeInDown, ZoomIn } from "react-native-reanimated";
import {
  View,
  Text,
  FlatList,
  StyleSheet,
  TouchableOpacity,
  TextInput,
  RefreshControl,
  ActivityIndicator,
  ScrollView,
  Platform,
  Alert,
} from "react-native";
import { Switch as ThemedSwitch } from "../../src/components/ui/Switch";
import * as ImagePicker from "expo-image-picker";
import { useRouter } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon } from "../../src/components/ui/Icon";
import { SkeletonCard } from "../../src/components/ui/Skeleton";
import { BottomSheet } from "../../src/components/ui/BottomSheet";
import { StoryCard } from "../../src/components/community/StoryCard";
import type { IconName } from "../../src/constants/icons";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";
import { useCommunityStore, type Story } from "../../src/stores/communityStore";
import { useAuthStore } from "../../src/stores/authStore";
import { ScreenErrorBoundary } from "../../src/components/common/ScreenErrorBoundary";
import { EmptyState } from "../../src/components/common/EmptyState";
import { useToastContext } from "../../src/contexts/ToastContext";
import { a11yButton, a11yTab } from "../../src/utils/accessibility";

type FilterTab = "all" | "trending" | "my_stories";

const CATEGORIES = [
  "birthday",
  "anniversary",
  "proposal",
  "graduation",
  "baby_shower",
  "holiday",
  "just_because",
  "other",
];

const CATEGORY_KEYS: Record<string, string> = {
  birthday: "categories.birthday",
  anniversary: "categories.anniversary",
  proposal: "categories.proposal",
  graduation: "categories.graduation",
  baby_shower: "community.category_baby_shower",
  holiday: "categories.holiday",
  just_because: "community.category_just_because",
  other: "community.category_other",
};

function CommunityScreenContent() {
  const router = useRouter();
  const { t } = useTranslation();
  const { colors } = useTheme();
  const { showToast } = useToastContext();

  const {
    stories: allStories,
    trendingStories,
    myStories,
    isLoading,
    fetchStories,
    fetchTrending,
    fetchMyStories,
    createStory,
    deleteStory,
    likeStory,
    loadMore,
    refreshStories,
  } = useCommunityStore();

  const currentUserId = useAuthStore((state) => state.user?.id);

  const [activeTab, setActiveTab] = useState<FilterTab>("all");
  const [searchQuery, setSearchQuery] = useState("");
  const [showSearch, setShowSearch] = useState(false);
  const [refreshing, setRefreshing] = useState(false);
  const [loadError, setLoadError] = useState(false);

  // Create story state
  const [showCreateSheet, setShowCreateSheet] = useState(false);
  const [newTitle, setNewTitle] = useState("");
  const [newContent, setNewContent] = useState("");
  const [newCategory, setNewCategory] = useState("");
  const [newIsAnonymous, setNewIsAnonymous] = useState(false);
  const [selectedPhotos, setSelectedPhotos] = useState<string[]>([]);

  const loadStories = useCallback(() => {
    setLoadError(false);
    Promise.all([fetchStories(), fetchTrending()]).catch((err: unknown) => {
      if (__DEV__) console.warn("[Community] Failed to load stories:", err);
      setLoadError(true);
      showToast(t("errors.loadFailed"), "error");
    });
  }, [fetchStories, fetchTrending, showToast, t]);

  useEffect(() => {
    loadStories();
  }, []);

  const displayStories = useMemo(() => {
    let result: Story[];
    if (activeTab === "trending") result = trendingStories;
    else if (activeTab === "my_stories") result = myStories;
    else result = allStories;

    if (searchQuery.trim()) {
      const q = searchQuery.toLowerCase();
      result = result.filter(
        (s) =>
          s.title.toLowerCase().includes(q) ||
          s.content.toLowerCase().includes(q),
      );
    }
    return result;
  }, [allStories, trendingStories, myStories, activeTab, searchQuery]);

  const handleTabChange = useCallback(
    (tab: FilterTab) => {
      setActiveTab(tab);
      if (tab === "my_stories" && myStories.length === 0) {
        fetchMyStories();
      }
    },
    [myStories.length, fetchMyStories],
  );

  const handleRefresh = useCallback(async () => {
    setRefreshing(true);
    await refreshStories();
    if (activeTab === "trending") await fetchTrending();
    if (activeTab === "my_stories") await fetchMyStories();
    setRefreshing(false);
  }, [activeTab, refreshStories, fetchTrending, fetchMyStories]);

  const handleCreateStory = useCallback(async () => {
    if (!newTitle.trim() || !newContent.trim()) return;
    try {
      await createStory({
        title: newTitle.trim(),
        content: newContent.trim(),
        images: selectedPhotos.length > 0 ? selectedPhotos : undefined,
        category: newCategory || "other",
        is_anonymous: newIsAnonymous,
      });
      setShowCreateSheet(false);
      setNewTitle("");
      setNewContent("");
      setNewCategory("");
      setNewIsAnonymous(false);
      setSelectedPhotos([]);
    } catch {
      Alert.alert(t("common.error"), t("community.create_failed"));
    }
  }, [
    newTitle,
    newContent,
    newCategory,
    newIsAnonymous,
    selectedPhotos,
    createStory,
    t,
  ]);

  const handleAddPhoto = useCallback(async () => {
    if (selectedPhotos.length >= 5) return;
    try {
      const permission =
        await ImagePicker.requestMediaLibraryPermissionsAsync();
      if (!permission.granted) {
        Alert.alert(
          t("community.permission_required"),
          t("community.gallery_permission"),
        );
        return;
      }
      const result = await ImagePicker.launchImageLibraryAsync({
        mediaTypes: ImagePicker.MediaTypeOptions.Images,
        allowsEditing: true,
        quality: 0.8,
      });
      if (!result.canceled && result.assets[0]?.uri) {
        setSelectedPhotos((prev) => [...prev, result.assets[0].uri]);
      }
    } catch {
      Alert.alert(t("common.error"), t("community.photo_pick_failed"));
    }
  }, [selectedPhotos, t]);

  const handleStoryPress = useCallback(
    (story: Story) => {
      router.push(`/community/${story.id}` as never);
    },
    [router],
  );

  const handleStoryLongPress = useCallback(
    (story: Story) => {
      if (story.user_id !== currentUserId) return;

      Alert.alert(
        t("community.deleteStoryTitle"),
        t("community.deleteStoryConfirm"),
        [
          { text: t("common.cancel"), style: "cancel" },
          {
            text: t("common.delete"),
            style: "destructive",
            onPress: async () => {
              try {
                await deleteStory(story.id);
                showToast(t("community.deleteStorySuccess"), "success");
              } catch {
                showToast(t("community.deleteStoryError"), "error");
              }
            },
          },
        ],
      );
    },
    [currentUserId, deleteStory, showToast, t],
  );

  const styles = useMemo(() => createStyles(colors), [colors]);

  const tabs: { key: FilterTab; label: string; icon: IconName }[] = [
    { key: "all", label: t("community.all"), icon: "apps" },
    {
      key: "trending",
      label: t("community.trending"),
      icon: "fire",
    },
    {
      key: "my_stories",
      label: t("community.my_stories"),
      icon: "account",
    },
  ];

  const renderStoryItem = useCallback(
    ({ item, index }: { item: Story; index: number }) => {
      return (
        <StoryCard
          story={item}
          onPress={handleStoryPress}
          onLongPress={
            item.user_id === currentUserId ? handleStoryLongPress : undefined
          }
          index={index}
        />
      );
    },
    [handleStoryPress, handleStoryLongPress, currentUserId],
  );

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={[styles.headerTitle, { color: colors.text }]}>
          {t("community.title")}
        </Text>
        <View style={styles.headerActions}>
          <TouchableOpacity
            onPress={() => setShowCreateSheet(true)}
            style={styles.headerButton}
            {...a11yButton(t("community.share_story_btn"))}
          >
            <Icon name="plus" size={22} color={colors.primary} />
          </TouchableOpacity>
          <TouchableOpacity
            onPress={() => setShowSearch(!showSearch)}
            style={styles.headerButton}
            {...a11yButton(
              showSearch
                ? t("community.close_search")
                : t("community.search_btn"),
            )}
          >
            <Icon
              name={(showSearch ? "close" : "magnify") as IconName}
              size={22}
              color={colors.text}
            />
          </TouchableOpacity>
        </View>
      </View>

      {/* Search Bar */}
      {showSearch && (
        <View style={styles.searchRow}>
          <View
            style={[
              styles.searchContainer,
              { backgroundColor: colors.surfaceVariant },
            ]}
          >
            <Icon name="magnify" size={20} color={colors.textTertiary} />
            <TextInput
              style={[styles.searchInput, { color: colors.text }]}
              placeholder={t("community.search_placeholder")}
              accessibilityLabel={t("community.search_label")}
              placeholderTextColor={colors.textTertiary}
              value={searchQuery}
              onChangeText={setSearchQuery}
              autoFocus
            />
          </View>
        </View>
      )}

      {/* Filter Tabs */}
      <View style={styles.tabRow}>
        {tabs.map((tab) => {
          const isActive = activeTab === tab.key;
          return (
            <TouchableOpacity
              key={tab.key}
              style={[
                styles.tabPill,
                {
                  backgroundColor: isActive
                    ? colors.primary
                    : colors.backgroundSecondary,
                },
              ]}
              onPress={() => handleTabChange(tab.key)}
              activeOpacity={0.7}
              {...a11yTab(tab.label, isActive)}
            >
              <Text
                style={[
                  styles.tabPillText,
                  { color: isActive ? colors.textOnPrimary : colors.text },
                ]}
              >
                {tab.label}
              </Text>
            </TouchableOpacity>
          );
        })}
      </View>

      {/* Story List */}
      <FlatList
        data={displayStories}
        keyExtractor={(item) => item.id}
        renderItem={renderStoryItem}
        contentContainerStyle={styles.list}
        showsVerticalScrollIndicator={false}
        maxToRenderPerBatch={6}
        windowSize={5}
        initialNumToRender={4}
        updateCellsBatchingPeriod={50}
        removeClippedSubviews={Platform.OS !== "web"}
        refreshControl={
          <RefreshControl
            refreshing={refreshing}
            onRefresh={handleRefresh}
            tintColor={colors.primary}
          />
        }
        onEndReached={activeTab === "all" ? loadMore : undefined}
        onEndReachedThreshold={0.3}
        ListFooterComponent={
          isLoading ? (
            <View style={styles.loadingMore}>
              <ActivityIndicator size="small" color={colors.primary} />
            </View>
          ) : null
        }
        ListEmptyComponent={
          isLoading ? (
            <View style={{ paddingHorizontal: Spacing.lg, gap: Spacing.md }}>
              {[...Array(3)].map((_, i) => (
                <SkeletonCard key={i} />
              ))}
            </View>
          ) : loadError ? (
            <EmptyState
              emoji="⚠️"
              title={t("errors.loadFailedTitle")}
              description={t("errors.loadFailedDesc")}
              actionLabel={t("errors.retry")}
              onAction={loadStories}
            />
          ) : (
            <Animated.View
              entering={FadeInDown.duration(500).springify()}
              style={styles.emptyState}
            >
              <Animated.View
                entering={ZoomIn.delay(150).duration(600).springify()}
                style={[
                  styles.emptyIconWrap,
                  { backgroundColor: colors.primary + "14" },
                ]}
              >
                <Icon
                  name="book-open-variant"
                  size={48}
                  color={colors.primary}
                />
              </Animated.View>
              <Animated.Text
                entering={FadeInDown.delay(250).duration(400)}
                style={[styles.emptyTitle, { color: colors.text }]}
              >
                {t("community.no_stories_title")}
              </Animated.Text>
              <Animated.Text
                entering={FadeInDown.delay(350).duration(400)}
                style={[styles.emptyDesc, { color: colors.textSecondary }]}
              >
                {t("community.no_stories_desc")}
              </Animated.Text>
              <Animated.View entering={FadeInDown.delay(450).duration(400)}>
                <TouchableOpacity
                  style={[
                    styles.emptyCtaBtn,
                    { backgroundColor: colors.primary },
                  ]}
                  onPress={() => setShowCreateSheet(true)}
                  activeOpacity={0.85}
                >
                  <Icon
                    name="pencil-plus"
                    size={18}
                    color={colors.textOnPrimary}
                  />
                  <Text style={styles.emptyCtaText}>
                    {t("community.write_story_cta")}
                  </Text>
                </TouchableOpacity>
              </Animated.View>
            </Animated.View>
          )
        }
      />

      {/* FAB — visible when there are stories */}
      {displayStories.length > 0 && !isLoading && (
        <TouchableOpacity
          style={[styles.fab, { backgroundColor: colors.primary }]}
          onPress={() => setShowCreateSheet(true)}
          activeOpacity={0.85}
        >
          <Icon name="pencil-plus" size={20} color={colors.textOnPrimary} />
          <Text style={styles.fabText}>{t("community.write_story_fab")}</Text>
        </TouchableOpacity>
      )}

      {/* Create Story BottomSheet */}
      <BottomSheet
        visible={showCreateSheet}
        onClose={() => setShowCreateSheet(false)}
        title={t("community.create_story")}
        snapPoints={["90%"]}
      >
        <ScrollView
          showsVerticalScrollIndicator={false}
          contentContainerStyle={styles.sheetContent}
        >
          {/* Post button */}
          <TouchableOpacity
            onPress={handleCreateStory}
            disabled={!newTitle.trim() || !newContent.trim()}
            style={[
              styles.postButtonContainer,
              {
                backgroundColor:
                  newTitle.trim() && newContent.trim()
                    ? colors.primary
                    : colors.borderLight,
              },
            ]}
          >
            <Text
              style={[
                styles.postButton,
                {
                  color:
                    newTitle.trim() && newContent.trim()
                      ? colors.textOnPrimary
                      : colors.textTertiary,
                },
              ]}
            >
              {t("community.post")}
            </Text>
          </TouchableOpacity>

          <TextInput
            style={[
              styles.titleInput,
              { color: colors.text, borderBottomColor: colors.borderLight },
            ]}
            placeholder={t("community.story_title_placeholder")}
            placeholderTextColor={colors.textTertiary}
            value={newTitle}
            onChangeText={setNewTitle}
            maxLength={100}
          />

          <TextInput
            style={[
              styles.contentInput,
              { color: colors.text, backgroundColor: colors.surfaceVariant },
            ]}
            placeholder={t("community.story_content_placeholder")}
            placeholderTextColor={colors.textTertiary}
            value={newContent}
            onChangeText={setNewContent}
            multiline
            textAlignVertical="top"
            maxLength={5000}
          />

          {/* Photo Picker */}
          <View style={styles.photoSection}>
            <Text style={[styles.sectionLabel, { color: colors.text }]}>
              {t("community.photos")} ({selectedPhotos.length}/5)
            </Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false}>
              {selectedPhotos.map((photo, index) => (
                <View
                  key={photo}
                  style={[
                    styles.photoThumb,
                    { backgroundColor: colors.surfaceVariant },
                  ]}
                >
                  <Icon name="image" size={24} color={colors.primary} />
                  <TouchableOpacity
                    style={[
                      styles.photoRemove,
                      { backgroundColor: colors.error },
                    ]}
                    onPress={() =>
                      setSelectedPhotos((prev) =>
                        prev.filter((_, i) => i !== index),
                      )
                    }
                  >
                    <Icon name="close" size={12} color={colors.textOnPrimary} />
                  </TouchableOpacity>
                </View>
              ))}
              {selectedPhotos.length < 5 && (
                <TouchableOpacity
                  style={[styles.addPhotoBtn, { borderColor: colors.border }]}
                  onPress={handleAddPhoto}
                >
                  <Icon
                    name="camera-plus"
                    size={24}
                    color={colors.textTertiary}
                  />
                </TouchableOpacity>
              )}
            </ScrollView>
          </View>

          {/* Category Selector */}
          <View style={styles.categorySection}>
            <Text style={[styles.sectionLabel, { color: colors.text }]}>
              {t("community.category")}
            </Text>
            <View style={styles.categoryChips}>
              {CATEGORIES.map((cat) => (
                <TouchableOpacity
                  key={cat}
                  style={[
                    styles.categoryChip,
                    {
                      backgroundColor:
                        newCategory === cat
                          ? colors.primary
                          : colors.surfaceVariant,
                    },
                  ]}
                  onPress={() => setNewCategory(cat)}
                >
                  <Text
                    style={[
                      styles.categoryChipText,
                      {
                        color:
                          newCategory === cat
                            ? colors.textOnPrimary
                            : colors.textSecondary,
                      },
                    ]}
                  >
                    {t(CATEGORY_KEYS[cat] ?? cat)}
                  </Text>
                </TouchableOpacity>
              ))}
            </View>
          </View>

          {/* Anonymous Toggle */}
          <View
            style={[
              styles.anonymousRow,
              { borderTopColor: colors.borderLight },
            ]}
          >
            <View style={styles.anonymousInfo}>
              <Icon name="incognito" size={22} color={colors.textSecondary} />
              <View>
                <Text style={[styles.anonymousLabel, { color: colors.text }]}>
                  {t("community.post_anonymously_label")}
                </Text>
                <Text
                  style={[styles.anonymousDesc, { color: colors.textTertiary }]}
                >
                  {t("community.name_hidden")}
                </Text>
              </View>
            </View>
            <ThemedSwitch
              value={newIsAnonymous}
              onValueChange={setNewIsAnonymous}
            />
          </View>
        </ScrollView>
      </BottomSheet>
    </View>
  );
}

export default function CommunityScreen() {
  return (
    <ScreenErrorBoundary>
      <CommunityScreenContent />
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: { flex: 1, backgroundColor: colors.background },
    header: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      paddingHorizontal: Spacing.lg,
      paddingTop: Spacing.md,
      paddingBottom: Spacing.sm,
    },
    headerTitle: { ...Typography.h2 },
    headerActions: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.md,
    },
    headerButton: {
      width: 36,
      height: 36,
      alignItems: "center",
      justifyContent: "center",
    },
    searchRow: { paddingHorizontal: Spacing.lg, marginBottom: Spacing.sm },
    searchContainer: {
      flexDirection: "row",
      alignItems: "center",
      borderRadius: BorderRadius.full,
      paddingHorizontal: Spacing.md,
      gap: Spacing.sm,
    },
    searchInput: { flex: 1, ...Typography.body, paddingVertical: Spacing.sm },
    // Filter pills
    tabRow: {
      flexDirection: "row",
      paddingHorizontal: Spacing.lg,
      gap: Spacing.sm,
      paddingBottom: Spacing.md,
    },
    tabPill: {
      flex: 1,
      alignItems: "center",
      justifyContent: "center",
      paddingVertical: 10,
      borderRadius: BorderRadius.full,
    },
    tabPillText: {
      ...Typography.caption,
      fontWeight: "700",
    },
    list: { paddingHorizontal: Spacing.lg, paddingBottom: Spacing.xxl + 80 },
    loadingMore: { paddingVertical: Spacing.lg, alignItems: "center" },
    emptyState: {
      alignItems: "center",
      paddingTop: Spacing.xxl * 2,
      paddingHorizontal: Spacing.xl,
      gap: Spacing.md,
    },
    emptyIconWrap: {
      width: 96,
      height: 96,
      borderRadius: 48,
      alignItems: "center",
      justifyContent: "center",
      marginBottom: Spacing.sm,
    },
    emptyTitle: { ...Typography.h3, textAlign: "center" },
    emptyDesc: { ...Typography.body, textAlign: "center" },
    emptyCtaBtn: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      paddingHorizontal: Spacing.xl,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.full,
      marginTop: Spacing.sm,
    },
    emptyCtaText: {
      ...Typography.button,
      color: colors.textOnPrimary,
    },
    fab: {
      position: "absolute",
      bottom: 100,
      right: Spacing.lg,
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      paddingHorizontal: Spacing.lg,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.full,
      ...Shadows.lg,
    },
    fabText: {
      ...Typography.buttonSmall,
      fontWeight: "700",
      color: colors.textOnPrimary,
    },
    // BottomSheet content
    sheetContent: {
      paddingBottom: Spacing.xxl,
    },
    postButtonContainer: {
      alignSelf: "flex-end",
      paddingHorizontal: Spacing.lg,
      paddingVertical: Spacing.sm,
      borderRadius: BorderRadius.full,
      marginBottom: Spacing.md,
    },
    postButton: {
      ...Typography.buttonSmall,
      fontWeight: "700",
    },
    titleInput: {
      ...Typography.h4,
      paddingVertical: Spacing.md,
      borderBottomWidth: 1,
      marginBottom: Spacing.md,
    },
    contentInput: {
      ...Typography.body,
      minHeight: 150,
      padding: Spacing.md,
      borderRadius: BorderRadius.md,
      marginBottom: Spacing.lg,
    },
    photoSection: { marginBottom: Spacing.lg },
    sectionLabel: {
      ...Typography.bodySmall,
      fontWeight: "600",
      marginBottom: Spacing.sm,
    },
    photoThumb: {
      width: 100,
      height: 100,
      borderRadius: BorderRadius.md,
      alignItems: "center",
      justifyContent: "center",
      marginRight: Spacing.sm,
    },
    photoRemove: {
      position: "absolute",
      top: -4,
      right: -4,
      width: 20,
      height: 20,
      borderRadius: 10,
      alignItems: "center",
      justifyContent: "center",
    },
    addPhotoBtn: {
      width: 100,
      height: 100,
      borderRadius: BorderRadius.md,
      borderWidth: 1.5,
      borderStyle: "dashed",
      alignItems: "center",
      justifyContent: "center",
    },
    categorySection: { marginBottom: Spacing.lg },
    categoryChips: { flexDirection: "row", flexWrap: "wrap", gap: Spacing.sm },
    categoryChip: {
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      borderRadius: BorderRadius.full,
    },
    categoryChipText: { ...Typography.caption, fontWeight: "600" },
    anonymousRow: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      paddingTop: Spacing.lg,
      borderTopWidth: 1,
    },
    anonymousInfo: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
    },
    anonymousLabel: { ...Typography.bodySmall, fontWeight: "600" },
    anonymousDesc: { ...Typography.caption },
  });
