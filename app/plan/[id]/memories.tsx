import React, { useMemo, useState, useEffect } from "react";
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  FlatList,
  Image,
  TouchableOpacity,
  Alert,
  ActivityIndicator,
  Dimensions,
} from "react-native";
import { useLocalSearchParams, useRouter } from "expo-router";
import Animated, { FadeInDown } from "react-native-reanimated";
import { useTranslation } from "react-i18next";
import { Icon } from "../../../src/components/ui/Icon";
import { StarRating } from "../../../src/components/ui/StarRating";
import * as ImagePicker from "expo-image-picker";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../../src/constants/theme";
import { useTheme } from "../../../src/contexts/ThemeContext";
import { usePlanStore } from "../../../src/stores/planStore";
import { useSettingsStore } from "../../../src/stores/settingsStore";
import * as photosService from "../../../src/services/photos";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";
import { EmptyState } from "../../../src/components/common/EmptyState";

const { width: SCREEN_WIDTH } = Dimensions.get("window");
const PHOTO_SIZE = (SCREEN_WIDTH - Spacing.lg * 2 - Spacing.sm) / 2;

// ─────────────────────────────────────────────
// PHOTO GRID ITEM
// ─────────────────────────────────────────────
function PhotoItem({ uri, index }: { uri: string; index: number }) {
  const [failed, setFailed] = useState(false);
  const { colors } = useTheme();

  return (
    <Animated.View
      entering={FadeInDown.delay(index * 80).duration(400)}
      style={{ width: PHOTO_SIZE, aspectRatio: 1 }}
    >
      {failed ? (
        <View
          style={{
            flex: 1,
            backgroundColor: colors.surfaceVariant,
            borderRadius: BorderRadius.md,
            alignItems: "center",
            justifyContent: "center",
          }}
        >
          <Icon name="image-broken" size={28} color={colors.textTertiary} />
        </View>
      ) : (
        <Image
          source={{ uri }}
          style={{
            width: "100%",
            height: "100%",
            borderRadius: BorderRadius.md,
          }}
          resizeMode="cover"
          onError={() => setFailed(true)}
        />
      )}
    </Animated.View>
  );
}

// ─────────────────────────────────────────────
// MAIN SCREEN
// ─────────────────────────────────────────────
export default function MemoriesScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const router = useRouter();
  const { colors } = useTheme();
  const { t, i18n } = useTranslation();
  const { language } = useSettingsStore();
  const { plans } = usePlanStore();

  const locale = i18n.language === "tr" ? "tr-TR" : "en-US";
  const plan = plans.find((p) => p.id === id);

  const [planPhotos, setPlanPhotos] = useState<photosService.PlanPhoto[]>([]);
  const [uploading, setUploading] = useState(false);

  useEffect(() => {
    if (id) {
      photosService
        .fetchPhotos(id)
        .then(setPlanPhotos)
        .catch(() => {});
    }
  }, [id]);

  const styles = useMemo(() => createStyles(colors), [colors]);

  // Derive extra completion fields from completion_data (stored by completePlan)
  const completionData = plan?.completion_data as
    | Record<string, unknown>
    | undefined;
  const completionReaction = completionData?.reactionType as string | undefined;
  const completionMemory = completionData?.memoryEntry as string | undefined;
  const completionRating = plan?.completion_rating ?? 0;
  const completionNotes = plan?.completion_notes ?? "";
  const completionPhotos: string[] = plan?.completion_photos ?? [];

  const formattedEventDate = useMemo(() => {
    if (!plan?.event_date) return null;
    try {
      const d = new Date(plan.event_date);
      return d.toLocaleDateString(locale, {
        day: "numeric",
        month: "long",
        year: "numeric",
      });
    } catch {
      return plan.event_date;
    }
  }, [plan?.event_date, locale]);

  const formattedCompletedAt = useMemo(() => {
    if (!plan?.completed_at) return null;
    try {
      const d = new Date(plan.completed_at);
      return d.toLocaleDateString(locale, {
        day: "numeric",
        month: "long",
        year: "numeric",
      });
    } catch {
      return plan.completed_at;
    }
  }, [plan?.completed_at, locale]);

  const handleShare = () => {
    Alert.alert(t("memories.shared_title"), t("memories.shared_message"));
  };

  const handleAddPhoto = async () => {
    const permissionResult =
      await ImagePicker.requestMediaLibraryPermissionsAsync();
    if (!permissionResult.granted) {
      Alert.alert(
        t("memories.permission_required"),
        t("memories.gallery_permission"),
      );
      return;
    }

    const result = await ImagePicker.launchImageLibraryAsync({
      mediaTypes: "images",
      allowsMultipleSelection: true,
      quality: 0.8,
      selectionLimit: 10,
    });

    if (result.canceled || !result.assets?.length) return;

    setUploading(true);
    try {
      const uploaded = await Promise.all(
        result.assets.map((asset) =>
          photosService.uploadPhoto(id as string, asset.uri),
        ),
      );
      const successful = uploaded.filter(
        (p): p is photosService.PlanPhoto => p !== null,
      );
      if (successful.length > 0) {
        setPlanPhotos((prev) => [...successful, ...prev]);
      }
      if (successful.length < result.assets.length) {
        Alert.alert(
          t("memories.partially_uploaded_title"),
          t("memories.partially_uploaded_message"),
        );
      }
    } catch {
      Alert.alert(
        t("memories.upload_error_title"),
        t("memories.upload_error_message"),
      );
    } finally {
      setUploading(false);
    }
  };

  if (!plan) {
    return (
      <View
        style={[
          styles.container,
          { alignItems: "center", justifyContent: "center" },
        ]}
      >
        <Icon name="image-off" size={48} color={colors.textTertiary} />
        <Text style={styles.notFound}>{t("memories.plan_not_found")}</Text>
      </View>
    );
  }

  const isCompleted = plan.status === "completed";

  return (
    <ScreenErrorBoundary>
      <View style={styles.container}>
        <ScrollView
          showsVerticalScrollIndicator={false}
          contentContainerStyle={styles.scrollContent}
        >
          {/* ── HEADER ── */}
          <View style={styles.header}>
            <TouchableOpacity
              style={styles.backButton}
              onPress={() => router.back()}
              activeOpacity={0.7}
            >
              <Icon name="arrow-left" size={24} color={colors.text} />
            </TouchableOpacity>
            <View style={styles.headerTextContainer}>
              <Text style={styles.headerTitle}>{t("memories.title")}</Text>
              {formattedEventDate && (
                <Text style={styles.headerSubtitle}>{formattedEventDate}</Text>
              )}
            </View>
          </View>

          {/* ── PLAN TITLE BANNER ── */}
          <Animated.View
            entering={FadeInDown.delay(100).duration(400)}
            style={styles.bannerCard}
          >
            <Text style={styles.bannerEmoji}>📸</Text>
            <View style={{ flex: 1 }}>
              <Text style={styles.bannerTitle}>{plan.title}</Text>
              {plan.recipient_name && (
                <Text style={styles.bannerSubtitle}>
                  {t("memories.for_recipient", { name: plan.recipient_name })}
                </Text>
              )}
            </View>
          </Animated.View>

          {/* ── COMPLETION STATS (only if completed) ── */}
          {isCompleted && (
            <Animated.View
              entering={FadeInDown.delay(200).duration(400)}
              style={styles.section}
            >
              <Text style={styles.sectionTitle}>
                {t("memories.how_did_it_go")}
              </Text>
              <View style={styles.statsCard}>
                {completionRating > 0 && (
                  <View style={styles.statsRow}>
                    <Text style={styles.statsLabel}>
                      {t("memories.rating")}
                    </Text>
                    <StarRating
                      rating={completionRating}
                      size={22}
                      color={colors.xpGold}
                      emptyColor={colors.textTertiary}
                      readOnly
                    />
                  </View>
                )}

                {completionReaction && (
                  <View style={styles.statsRow}>
                    <Text style={styles.statsLabel}>
                      {t("memories.reaction")}
                    </Text>
                    <Text style={styles.reactionEmoji}>
                      {completionReaction === "happy" && "😊"}
                      {completionReaction === "surprised" && "😲"}
                      {completionReaction === "emotional" && "🥹"}
                      {completionReaction === "laughing" && "😂"}
                      {![
                        "happy",
                        "surprised",
                        "emotional",
                        "laughing",
                      ].includes(completionReaction) && completionReaction}
                    </Text>
                  </View>
                )}

                {formattedCompletedAt && (
                  <View style={styles.statsRow}>
                    <Text style={styles.statsLabel}>
                      {t("memories.completed_on")}
                    </Text>
                    <Text style={styles.statsValue}>
                      {formattedCompletedAt}
                    </Text>
                  </View>
                )}
              </View>
            </Animated.View>
          )}

          {/* ── PHOTO GALLERY ── */}
          <Animated.View
            entering={FadeInDown.delay(300).duration(400)}
            style={styles.section}
          >
            <View style={styles.sectionHeaderRow}>
              <Text style={styles.sectionTitle}>{t("memories.photos")}</Text>
              <TouchableOpacity
                onPress={handleAddPhoto}
                style={styles.addPhotoChip}
                activeOpacity={0.7}
              >
                <Icon name="camera-plus" size={16} color={colors.primary} />
                <Text style={styles.addPhotoChipText}>
                  {t("memories.add_photo")}
                </Text>
              </TouchableOpacity>
            </View>

            {uploading && (
              <View
                style={{ alignItems: "center", paddingVertical: Spacing.md }}
              >
                <ActivityIndicator size="small" color={colors.primary} />
                <Text style={[styles.emptyText, { marginTop: Spacing.xs }]}>
                  {t("memories.uploading")}
                </Text>
              </View>
            )}
            {(() => {
              const allPhotos = [
                ...planPhotos.map((p) => p.image_url),
                ...completionPhotos,
              ];
              return allPhotos.length > 0 ? (
                <FlatList
                  data={allPhotos}
                  keyExtractor={(item, index) => `${item}_${index}`}
                  numColumns={2}
                  scrollEnabled={false}
                  columnWrapperStyle={{ gap: Spacing.sm }}
                  contentContainerStyle={{ gap: Spacing.sm }}
                  renderItem={({ item, index }) => (
                    <PhotoItem uri={item} index={index} />
                  )}
                />
              ) : (
                <View style={styles.emptyPhotos}>
                  <Icon
                    name="camera-outline"
                    size={48}
                    color={colors.textTertiary}
                  />
                  <Text style={styles.emptyText}>
                    {t("memories.no_photos")}
                  </Text>
                  <TouchableOpacity
                    style={styles.emptyAddButton}
                    onPress={handleAddPhoto}
                    activeOpacity={0.7}
                  >
                    <Icon name="camera-plus" size={18} color={colors.primary} />
                    <Text style={styles.emptyAddButtonText}>
                      {t("memories.add_photo_btn")}
                    </Text>
                  </TouchableOpacity>
                </View>
              );
            })()}
          </Animated.View>

          {/* ── NOTES / JOURNAL ── */}
          {completionNotes ? (
            <Animated.View
              entering={FadeInDown.delay(400).duration(400)}
              style={styles.section}
            >
              <Text style={styles.sectionTitle}>{t("memories.notes")}</Text>
              <View style={styles.textCard}>
                <View style={{ marginBottom: Spacing.xs }}>
                  <Icon
                    name="note-text-outline"
                    size={20}
                    color={colors.textSecondary}
                  />
                </View>
                <Text style={styles.textCardContent}>{completionNotes}</Text>
              </View>
            </Animated.View>
          ) : null}

          {/* ── MEMORY JOURNAL ENTRY ── */}
          {completionMemory ? (
            <Animated.View
              entering={FadeInDown.delay(500).duration(400)}
              style={styles.section}
            >
              <Text style={styles.sectionTitle}>
                {t("memories.memory_journal")}
              </Text>
              <View style={[styles.textCard, styles.memoryCard]}>
                <View style={{ marginBottom: Spacing.xs }}>
                  <Icon
                    name="book-heart-outline"
                    size={20}
                    color={colors.primary}
                  />
                </View>
                <Text style={[styles.textCardContent, { fontStyle: "italic" }]}>
                  "{completionMemory}"
                </Text>
              </View>
            </Animated.View>
          ) : null}

          {/* ── EMPTY STATE (no data at all) ── */}
          {!isCompleted &&
            completionPhotos.length === 0 &&
            !completionNotes &&
            !completionMemory && (
              <Animated.View entering={FadeInDown.delay(400).duration(400)}>
                <EmptyState
                  emoji="📸"
                  title={t("memories.empty_title")}
                  description={t("memories.empty_subtitle")}
                  compact
                />
              </Animated.View>
            )}

          {/* ── ACTION BUTTONS ── */}
          <Animated.View
            entering={FadeInDown.delay(600).duration(400)}
            style={styles.actionsContainer}
          >
            {isCompleted && (
              <TouchableOpacity
                style={[styles.actionButton, styles.shareButton]}
                onPress={handleShare}
                activeOpacity={0.8}
              >
                <Icon
                  name="share-variant"
                  size={20}
                  color={colors.textOnPrimary}
                />
                <Text style={styles.shareButtonText}>
                  {t("memories.share_community")}
                </Text>
              </TouchableOpacity>
            )}

            <TouchableOpacity
              style={[styles.actionButton, styles.addMoreButton]}
              onPress={handleAddPhoto}
              activeOpacity={0.8}
            >
              <Icon name="image-plus" size={20} color={colors.primary} />
              <Text style={styles.addMoreButtonText}>
                {t("memories.add_photo_btn")}
              </Text>
            </TouchableOpacity>
          </Animated.View>
        </ScrollView>
      </View>
    </ScreenErrorBoundary>
  );
}

// ─────────────────────────────────────────────
// STYLES
// ─────────────────────────────────────────────
const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },
    scrollContent: {
      paddingBottom: Spacing.xxl + Spacing.md,
    },

    // Header
    header: {
      flexDirection: "row",
      alignItems: "center",
      paddingHorizontal: Spacing.lg,
      paddingTop: Spacing.xxl + Spacing.md,
      paddingBottom: Spacing.md,
      gap: Spacing.md,
    },
    backButton: {
      width: 40,
      height: 40,
      borderRadius: 20,
      backgroundColor: colors.surfaceVariant,
      alignItems: "center",
      justifyContent: "center",
    },
    headerTextContainer: {
      flex: 1,
    },
    headerTitle: {
      ...Typography.h2,
      color: colors.text,
    },
    headerSubtitle: {
      ...Typography.caption,
      color: colors.textSecondary,
      marginTop: 2,
    },

    // Banner
    bannerCard: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.md,
      marginHorizontal: Spacing.lg,
      marginBottom: Spacing.lg,
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      padding: Spacing.md,
      borderWidth: 1,
      borderColor: colors.border,
      ...Shadows.sm,
    },
    bannerEmoji: {
      fontSize: 36,
    },
    bannerTitle: {
      ...Typography.h4,
      color: colors.text,
    },
    bannerSubtitle: {
      ...Typography.caption,
      color: colors.textSecondary,
      marginTop: 2,
    },

    // Sections
    section: {
      paddingHorizontal: Spacing.lg,
      marginBottom: Spacing.lg,
    },
    sectionHeaderRow: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "space-between",
      marginBottom: Spacing.md,
    },
    sectionTitle: {
      ...Typography.h4,
      color: colors.text,
      marginBottom: Spacing.md,
    },

    // Stats card
    statsCard: {
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      padding: Spacing.md,
      borderWidth: 1,
      borderColor: colors.border,
      gap: Spacing.md,
      ...Shadows.sm,
    },
    statsRow: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "space-between",
    },
    statsLabel: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
      fontWeight: "600",
    },
    statsValue: {
      ...Typography.bodySmall,
      color: colors.text,
    },
    reactionEmoji: {
      fontSize: 26,
    },

    // Add photo chip
    addPhotoChip: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.xs,
      paddingHorizontal: Spacing.sm,
      paddingVertical: Spacing.xs,
      backgroundColor: colors.primaryLight,
      borderRadius: BorderRadius.full,
    },
    addPhotoChipText: {
      ...Typography.caption,
      color: colors.primary,
      fontWeight: "600",
    },

    // Empty photos
    emptyPhotos: {
      alignItems: "center",
      justifyContent: "center",
      paddingVertical: Spacing.xxl,
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      borderWidth: 1.5,
      borderColor: colors.border,
      borderStyle: "dashed",
      gap: Spacing.sm,
    },
    emptyText: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
      textAlign: "center",
      lineHeight: 22,
    },
    emptyAddButton: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.xs,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      backgroundColor: colors.primaryLight,
      borderRadius: BorderRadius.full,
      marginTop: Spacing.xs,
    },
    emptyAddButtonText: {
      ...Typography.buttonSmall,
      color: colors.primary,
    },

    // Text cards
    textCard: {
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      padding: Spacing.md,
      borderWidth: 1,
      borderColor: colors.border,
      ...Shadows.sm,
    },
    memoryCard: {
      backgroundColor: colors.primaryLight,
      borderColor: colors.primary + "30",
    },
    textCardContent: {
      ...Typography.body,
      color: colors.text,
      lineHeight: 26,
    },

    // Action buttons
    actionsContainer: {
      paddingHorizontal: Spacing.lg,
      gap: Spacing.md,
    },
    actionButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      borderRadius: BorderRadius.xl,
      paddingVertical: Spacing.md + 2,
      paddingHorizontal: Spacing.lg,
    },
    shareButton: {
      backgroundColor: colors.primary,
      ...Shadows.md,
    },
    shareButtonText: {
      ...Typography.button,
      color: colors.textOnPrimary,
    },
    addMoreButton: {
      backgroundColor: colors.surface,
      borderWidth: 1.5,
      borderColor: colors.primary,
    },
    addMoreButtonText: {
      ...Typography.button,
      color: colors.primary,
    },

    notFound: {
      ...Typography.body,
      color: colors.textSecondary,
      textAlign: "center",
      marginTop: Spacing.md,
    },
  });
