import React, { useState, useCallback, useMemo } from "react";
import { ScreenErrorBoundary } from "../../src/components/common/ScreenErrorBoundary";
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  TextInput,
  KeyboardAvoidingView,
  Platform,
  Image,
  ActivityIndicator,
  Alert,
} from "react-native";
import { LoadingScreen } from "../../src/components/common/LoadingScreen";
import { useLocalSearchParams, useRouter } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon } from "../../src/components/ui/Icon";
import type { IconName } from "../../src/constants/icons";
import {
  Spacing,
  Typography,
  BorderRadius,
  type ThemeColors,
} from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";
import {
  useCommunityStore,
  type Story,
  type Comment,
} from "../../src/stores/communityStore";
import { getCurrentUserId } from "../../src/services/helpers";
import * as communityApi from "../../src/services/community";

const CATEGORY_LABELS: Record<string, { tr: string; en: string }> = {
  birthday: { tr: "Doğum Günü", en: "Birthday" },
  anniversary: { tr: "Yıldönümü", en: "Anniversary" },
  proposal: { tr: "Evlilik Teklifi", en: "Proposal" },
  graduation: { tr: "Mezuniyet", en: "Graduation" },
  baby_shower: { tr: "Bebek Partisi", en: "Baby Shower" },
  holiday: { tr: "Tatil", en: "Holiday" },
  just_because: { tr: "Sürpriz", en: "Just Because" },
  other: { tr: "Diğer", en: "Other" },
};

export default function StoryDetailScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const router = useRouter();
  const { t, i18n } = useTranslation();
  const lang = i18n.language as "tr" | "en";
  const { colors } = useTheme();
  const {
    stories,
    trendingStories,
    myStories,
    likeStory,
    commentOnStory,
    deleteStory,
  } = useCommunityStore();

  const story: Story | undefined = useMemo(
    () =>
      [...stories, ...trendingStories, ...myStories].find((s) => s.id === id),
    [stories, trendingStories, myStories, id],
  );

  const [comments, setComments] = useState<Comment[]>([]);
  const [commentText, setCommentText] = useState("");
  const [isSubmittingComment, setIsSubmittingComment] = useState(false);
  const [currentUserId, setCurrentUserId] = useState<string | null>(null);

  React.useEffect(() => {
    getCurrentUserId()
      .then(setCurrentUserId)
      .catch(() => {});
  }, []);

  const isOwner = currentUserId && story?.user_id === currentUserId;

  const styles = useMemo(() => createStyles(colors), [colors]);

  const handleLike = useCallback(async () => {
    if (!id) return;
    try {
      await likeStory(id);
    } catch {}
  }, [id, likeStory]);

  const handleDelete = useCallback(() => {
    if (!id) return;
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
              await deleteStory(id);
              router.back();
            } catch {
              Alert.alert(t("common.error"), t("community.deleteStoryError"));
            }
          },
        },
      ],
    );
  }, [id, deleteStory, router, t]);

  const handleDeleteComment = useCallback(
    (commentId: string) => {
      if (!id) return;
      Alert.alert(
        t("community.deleteCommentTitle"),
        t("community.deleteCommentConfirm"),
        [
          { text: t("common.cancel"), style: "cancel" },
          {
            text: t("common.delete"),
            style: "destructive",
            onPress: async () => {
              try {
                await communityApi.deleteComment(commentId, id);
                setComments((prev) => prev.filter((c) => c.id !== commentId));
              } catch {
                Alert.alert(
                  t("common.error"),
                  t("community.deleteCommentError"),
                );
              }
            },
          },
        ],
      );
    },
    [id, t],
  );

  const handleSubmitComment = useCallback(async () => {
    const text = commentText.trim();
    if (!text || !id) return;
    setIsSubmittingComment(true);
    try {
      const comment = await commentOnStory(id, text);
      setComments((prev) => [...prev, comment]);
      setCommentText("");
    } catch {
      Alert.alert(t("common.error"), t("community.submitCommentError"));
    } finally {
      setIsSubmittingComment(false);
    }
  }, [id, commentText, commentOnStory, t]);

  if (!story) {
    return <LoadingScreen />;
  }

  const isAnonymous = !story.author_name;

  return (
    <ScreenErrorBoundary>
      <View style={styles.container}>
        <ScrollView
          showsVerticalScrollIndicator={false}
          contentContainerStyle={styles.scrollContent}
        >
          {/* Cover image */}
          {story.images?.[0] ? (
            <Image
              source={{ uri: story.images[0] }}
              style={styles.coverImage}
            />
          ) : (
            <View
              style={[
                styles.coverPlaceholder,
                { backgroundColor: colors.primary + "15" },
              ]}
            >
              <Icon name="image-outline" size={48} color={colors.primary} />
            </View>
          )}

          <View style={styles.content}>
            {/* Author row + delete */}
            <View style={styles.authorRow}>
              <View
                style={[
                  styles.avatar,
                  {
                    backgroundColor: isAnonymous
                      ? colors.textTertiary + "30"
                      : colors.primary + "20",
                  },
                ]}
              >
                {isAnonymous ? (
                  <Icon
                    name="incognito"
                    size={20}
                    color={colors.textTertiary}
                  />
                ) : (
                  <Text style={[styles.avatarText, { color: colors.primary }]}>
                    {(story.author_name || "?").charAt(0).toUpperCase()}
                  </Text>
                )}
              </View>
              <View style={{ flex: 1 }}>
                <Text style={[styles.authorName, { color: colors.text }]}>
                  {isAnonymous ? t("community.anonymous") : story.author_name}
                </Text>
                <Text style={[styles.date, { color: colors.textTertiary }]}>
                  {new Date(story.created_at).toLocaleDateString()}
                </Text>
              </View>
              <View
                style={[
                  styles.categoryBadge,
                  { backgroundColor: colors.accent + "15" },
                ]}
              >
                <Text style={[styles.categoryText, { color: colors.accent }]}>
                  {CATEGORY_LABELS[story.category]?.[lang] ?? story.category}
                </Text>
              </View>
              {isOwner && (
                <TouchableOpacity
                  onPress={handleDelete}
                  style={styles.deleteBtn}
                >
                  <Icon
                    name="trash-can-outline"
                    size={20}
                    color={colors.error}
                  />
                </TouchableOpacity>
              )}
            </View>

            {/* Title */}
            <Text style={[styles.title, { color: colors.text }]}>
              {story.title}
            </Text>

            {/* Content */}
            <Text style={[styles.body, { color: colors.textSecondary }]}>
              {story.content}
            </Text>

            {/* Extra images */}
            {story.images && story.images.length > 1 && (
              <ScrollView
                horizontal
                showsHorizontalScrollIndicator={false}
                style={styles.imageScroll}
              >
                {story.images.slice(1).map((uri, i) => (
                  <Image key={i} source={{ uri }} style={styles.extraImage} />
                ))}
              </ScrollView>
            )}

            {/* Like / Comment counts */}
            <View
              style={[
                styles.statsRow,
                {
                  borderTopColor: colors.borderLight,
                  borderBottomColor: colors.borderLight,
                },
              ]}
            >
              <TouchableOpacity style={styles.statBtn} onPress={handleLike}>
                <Icon
                  name={
                    (story.is_liked ? "heart" : "heart-outline") as IconName
                  }
                  size={22}
                  color={colors.error}
                />
                <Text
                  style={[styles.statText, { color: colors.textSecondary }]}
                >
                  {story.like_count}
                </Text>
              </TouchableOpacity>
              <View style={styles.statBtn}>
                <Icon name="comment-outline" size={22} color={colors.info} />
                <Text
                  style={[styles.statText, { color: colors.textSecondary }]}
                >
                  {story.comment_count + comments.length}
                </Text>
              </View>
            </View>

            {/* Comments */}
            {comments.length > 0 && (
              <View style={styles.commentsSection}>
                <Text
                  style={[styles.commentsSectionTitle, { color: colors.text }]}
                >
                  {t("community.commentsSection")}
                </Text>
                {comments.map((c) => {
                  const isMyComment =
                    currentUserId && c.user_id === currentUserId;
                  return (
                    <View
                      key={c.id}
                      style={[
                        styles.commentCard,
                        { backgroundColor: colors.surfaceVariant },
                      ]}
                    >
                      <View style={styles.commentHeader}>
                        <View
                          style={[
                            styles.commentAvatar,
                            { backgroundColor: colors.primary + "20" },
                          ]}
                        >
                          <Text
                            style={[
                              styles.commentAvatarText,
                              { color: colors.primary },
                            ]}
                          >
                            {(c.author_name || "?").charAt(0).toUpperCase()}
                          </Text>
                        </View>
                        <View style={{ flex: 1 }}>
                          <Text
                            style={[
                              styles.commentAuthor,
                              { color: colors.text },
                            ]}
                          >
                            {c.author_name || t("community.anonymous")}
                          </Text>
                          <Text
                            style={[
                              styles.commentDate,
                              { color: colors.textTertiary },
                            ]}
                          >
                            {new Date(c.created_at).toLocaleDateString()}
                          </Text>
                        </View>
                        {isMyComment && (
                          <TouchableOpacity
                            onPress={() => handleDeleteComment(c.id)}
                            style={styles.commentDeleteBtn}
                          >
                            <Icon name="close" size={16} color={colors.error} />
                          </TouchableOpacity>
                        )}
                      </View>
                      <Text
                        style={[
                          styles.commentText,
                          { color: colors.textSecondary },
                        ]}
                      >
                        {c.text}
                      </Text>
                    </View>
                  );
                })}
              </View>
            )}
          </View>
        </ScrollView>

        {/* Comment Input — sticky bottom */}
        <KeyboardAvoidingView
          behavior={Platform.OS === "ios" ? "padding" : undefined}
          keyboardVerticalOffset={Platform.OS === "ios" ? 90 : 0}
        >
          <View
            style={[
              styles.inputBar,
              {
                backgroundColor: colors.surface,
                borderTopColor: colors.border + "30",
              },
            ]}
          >
            <View
              style={[
                styles.inputWrap,
                {
                  backgroundColor: colors.surfaceVariant,
                  borderColor: colors.border + "20",
                },
              ]}
            >
              <TextInput
                style={[styles.inputField, { color: colors.text }]}
                placeholder={t("community.commentPlaceholder")}
                placeholderTextColor={colors.textTertiary}
                value={commentText}
                onChangeText={setCommentText}
                returnKeyType="send"
                onSubmitEditing={handleSubmitComment}
                editable={!isSubmittingComment}
                multiline
                maxLength={500}
              />
              <TouchableOpacity
                style={[
                  styles.sendBtn,
                  {
                    backgroundColor: commentText.trim()
                      ? colors.primary
                      : "transparent",
                  },
                ]}
                onPress={handleSubmitComment}
                disabled={!commentText.trim() || isSubmittingComment}
              >
                {isSubmittingComment ? (
                  <ActivityIndicator
                    size="small"
                    color={colors.textOnPrimary}
                  />
                ) : (
                  <Icon
                    name="send"
                    size={18}
                    color={
                      commentText.trim()
                        ? colors.textOnPrimary
                        : colors.textTertiary
                    }
                  />
                )}
              </TouchableOpacity>
            </View>
          </View>
        </KeyboardAvoidingView>
      </View>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: { flex: 1, backgroundColor: colors.background },
    scrollContent: { paddingBottom: Spacing.sm },
    coverImage: { width: "100%", height: 240 },
    coverPlaceholder: {
      width: "100%",
      height: 160,
      alignItems: "center",
      justifyContent: "center",
    },
    content: { padding: Spacing.lg },
    authorRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginBottom: Spacing.md,
    },
    avatar: {
      width: 40,
      height: 40,
      borderRadius: 20,
      alignItems: "center",
      justifyContent: "center",
    },
    avatarText: { ...Typography.body, fontWeight: "700" },
    authorName: { ...Typography.bodySmall, fontWeight: "600" },
    date: { ...Typography.caption },
    categoryBadge: {
      paddingHorizontal: Spacing.sm,
      paddingVertical: 3,
      borderRadius: BorderRadius.full,
    },
    categoryText: { ...Typography.caption, fontWeight: "600" },
    deleteBtn: { padding: Spacing.sm, marginLeft: Spacing.xs },
    title: { ...Typography.h2, marginBottom: Spacing.md },
    body: { ...Typography.body, lineHeight: 26, marginBottom: Spacing.lg },
    imageScroll: { marginBottom: Spacing.lg },
    extraImage: {
      width: 200,
      height: 140,
      borderRadius: BorderRadius.md,
      marginRight: Spacing.sm,
    },
    statsRow: {
      flexDirection: "row",
      gap: Spacing.lg,
      paddingVertical: Spacing.md,
      borderTopWidth: 1,
      borderBottomWidth: 1,
      marginBottom: Spacing.lg,
    },
    statBtn: { flexDirection: "row", alignItems: "center", gap: Spacing.xs },
    statText: { ...Typography.bodySmall, fontWeight: "600" },

    // Comments
    commentsSection: { gap: Spacing.smd },
    commentsSectionTitle: { ...Typography.h4, marginBottom: Spacing.xs },
    commentCard: {
      padding: Spacing.md,
      borderRadius: BorderRadius.lg,
      gap: Spacing.sm,
    },
    commentHeader: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
    },
    commentAvatar: {
      width: 28,
      height: 28,
      borderRadius: 14,
      alignItems: "center",
      justifyContent: "center",
    },
    commentAvatarText: { fontSize: 12, fontWeight: "700" },
    commentAuthor: { ...Typography.caption, fontWeight: "700" },
    commentDate: { fontSize: 10, marginTop: 1 },
    commentDeleteBtn: {
      width: 28,
      height: 28,
      borderRadius: 14,
      alignItems: "center",
      justifyContent: "center",
      backgroundColor: colors.error + "12",
    },
    commentText: { ...Typography.bodySmall, lineHeight: 22 },

    // Input bar
    inputBar: {
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.smd,
      borderTopWidth: 1,
    },
    inputWrap: {
      flexDirection: "row",
      alignItems: "flex-end",
      borderRadius: BorderRadius.xl,
      borderWidth: 1,
      paddingLeft: Spacing.md,
      paddingRight: Spacing.xs,
      paddingVertical: Spacing.xs,
      minHeight: 44,
    },
    inputField: {
      flex: 1,
      ...Typography.bodySmall,
      paddingVertical: Platform.OS === "ios" ? Spacing.sm : Spacing.xs,
      maxHeight: 100,
    },
    sendBtn: {
      width: 34,
      height: 34,
      borderRadius: 17,
      alignItems: "center",
      justifyContent: "center",
      marginBottom: Platform.OS === "ios" ? 1 : 0,
    },
  });
