import React, { useCallback, useEffect, useState } from "react";
import {
  View,
  Text,
  FlatList,
  StyleSheet,
  TouchableOpacity,
  TextInput,
  ActivityIndicator,
  Alert,
  KeyboardAvoidingView,
  Platform,
} from "react-native";
import { LoadingScreen } from "../../../src/components/common/LoadingScreen";
import { useLocalSearchParams } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon } from "../../../src/components/ui/Icon";
import Animated, {
  FadeInDown,
  FadeOut,
  LinearTransition,
} from "react-native-reanimated";
import {
  Spacing,
  Typography,
  BorderRadius,
} from "../../../src/constants/theme";
import { useTheme } from "../../../src/contexts/ThemeContext";
import { ChecklistItem } from "../../../src/components/plans/ChecklistItem";
import { EmptyState } from "../../../src/components/common/EmptyState";
import { usePlanStore } from "../../../src/stores/planStore";
import type { ChecklistItem as ChecklistItemType } from "../../../src/types/database";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";

export default function ChecklistScreen() {
  const { id } = useLocalSearchParams();
  const planId = id as string;
  const { t, i18n } = useTranslation("plans");
  const lang = i18n.language as "tr" | "en";
  const { colors } = useTheme();
  const {
    activePlan,
    loadPlanById,
    toggleChecklistItem,
    addChecklistItem,
    deleteChecklistItem,
  } = usePlanStore();

  const [loading, setLoading] = useState(true);
  const [addingItem, setAddingItem] = useState(false);
  const [newItemTitle, setNewItemTitle] = useState("");
  const [submitting, setSubmitting] = useState(false);
  const [undoState, setUndoState] = useState<{
    item: ChecklistItemType;
    timeoutId: ReturnType<typeof setTimeout>;
  } | null>(null);
  const [deletedItemId, setDeletedItemId] = useState<string | null>(null);

  useEffect(() => {
    let mounted = true;
    (async () => {
      try {
        await loadPlanById(planId);
      } finally {
        if (mounted) setLoading(false);
      }
    })();
    return () => {
      mounted = false;
    };
  }, [planId, loadPlanById]);

  // Cleanup timeout on unmount
  useEffect(() => {
    return () => {
      if (undoState) {
        clearTimeout(undoState.timeoutId);
      }
    };
  }, [undoState]);

  const rawChecklist = activePlan?.checklist || [];
  const checklist = deletedItemId
    ? rawChecklist.filter((c) => c.id !== deletedItemId)
    : rawChecklist;
  const completedCount = checklist.filter((c) => c.is_completed).length;
  const progress =
    checklist.length > 0 ? (completedCount / checklist.length) * 100 : 0;

  const handleAddItem = useCallback(async () => {
    const title = newItemTitle.trim();
    if (!title) return;
    setSubmitting(true);
    try {
      await addChecklistItem(planId, { title });
      setNewItemTitle("");
      setAddingItem(false);
    } catch {
      Alert.alert(
        t("common:common.error"),
        t("checklist_add_error", { defaultValue: "Madde eklenemedi." }),
      );
    } finally {
      setSubmitting(false);
    }
  }, [planId, newItemTitle, addChecklistItem]);

  const handleDeleteItem = useCallback(
    (item: ChecklistItemType) => {
      // If there's already a pending undo, flush it immediately
      if (undoState) {
        clearTimeout(undoState.timeoutId);
        deleteChecklistItem(planId, undoState.item.id).catch(() => {
          Alert.alert(
            t("common:common.error"),
            t("checklist_delete_error", { defaultValue: "Madde silinemedi." }),
          );
        });
        setUndoState(null);
        setDeletedItemId(null);
      }

      // Optimistically remove from list
      setDeletedItemId(item.id);

      // Start 3s countdown to actually delete
      const timeoutId = setTimeout(() => {
        deleteChecklistItem(planId, item.id)
          .catch(() => {
            Alert.alert(
              t("common:common.error"),
              t("checklist_delete_error", { defaultValue: "Madde silinemedi." }),
            );
          })
          .finally(() => {
            setUndoState(null);
            setDeletedItemId(null);
          });
      }, 3000);

      setUndoState({ item, timeoutId });
    },
    [planId, deleteChecklistItem, undoState],
  );

  const handleUndoDelete = useCallback(() => {
    if (!undoState) return;
    clearTimeout(undoState.timeoutId);
    setUndoState(null);
    setDeletedItemId(null);
  }, [undoState]);

  const dynamicStyles = getDynamicStyles(colors);

  // Loading state
  if (loading) {
    return <LoadingScreen message={t("checklist")} />;
  }

  // Empty state
  if (checklist.length === 0 && !addingItem) {
    return (
      <View style={[styles.container, { backgroundColor: colors.background }]}>
        <EmptyState
          emoji="📝"
          title={t("checklist")}
          description={t("checklist_empty_desc", {
            defaultValue:
              "Henüz yapılacak madde yok. Aşağıdaki butonla yeni madde ekleyebilirsiniz.",
          })}
        />
        <View
          style={[
            styles.addButtonWrapper,
            { backgroundColor: colors.background },
          ]}
        >
          <TouchableOpacity
            style={[styles.addButton, { backgroundColor: colors.primary }]}
            onPress={() => setAddingItem(true)}
            activeOpacity={0.8}
          >
            <Icon name="plus" size={22} color={colors.textOnPrimary} />
            <Text
              style={[styles.addButtonText, { color: colors.textOnPrimary }]}
            >
              {t("add_item")}
            </Text>
          </TouchableOpacity>
        </View>
        {addingItem && (
          <Animated.View
            entering={FadeInDown.duration(250)}
            style={[styles.inlineInput, dynamicStyles.inlineInput]}
          >
            <TextInput
              style={[styles.textInput, dynamicStyles.textInput]}
              placeholder={t("add_item")}
              placeholderTextColor={colors.textTertiary}
              value={newItemTitle}
              onChangeText={setNewItemTitle}
              autoFocus
              onSubmitEditing={handleAddItem}
              returnKeyType="done"
            />
            <TouchableOpacity
              onPress={handleAddItem}
              disabled={submitting || !newItemTitle.trim()}
              style={[
                styles.submitButton,
                {
                  backgroundColor: newItemTitle.trim()
                    ? colors.primary
                    : colors.borderLight,
                },
              ]}
            >
              {submitting ? (
                <ActivityIndicator size="small" color={colors.textOnPrimary} />
              ) : (
                <Icon name="check" size={20} color={colors.textOnPrimary} />
              )}
            </TouchableOpacity>
            <TouchableOpacity
              onPress={() => {
                setAddingItem(false);
                setNewItemTitle("");
              }}
              style={styles.cancelButton}
            >
              <Icon name="close" size={20} color={colors.textTertiary} />
            </TouchableOpacity>
          </Animated.View>
        )}
      </View>
    );
  }

  return (
    <ScreenErrorBoundary>
      <KeyboardAvoidingView
        style={[styles.container, { backgroundColor: colors.background }]}
        behavior={Platform.OS === "ios" ? "padding" : undefined}
      >
        {/* Progress Header */}
        <View
          style={[styles.header, { borderBottomColor: colors.borderLight }]}
        >
          <View style={styles.headerRow}>
            <Text style={[styles.headerTitle, { color: colors.text }]}>
              {t("checklist")}
            </Text>
            <View
              style={[styles.badge, { backgroundColor: colors.primaryLight }]}
            >
              <Text style={[styles.badgeText, { color: colors.primaryDark }]}>
                {completedCount}/{checklist.length}
              </Text>
            </View>
          </View>
          <View
            style={[
              styles.progressBar,
              { backgroundColor: colors.borderLight },
            ]}
          >
            <Animated.View
              style={[
                styles.progressFill,
                {
                  width: `${progress}%`,
                  backgroundColor:
                    progress === 100 ? colors.success : colors.primary,
                },
              ]}
            />
          </View>
          <Text style={[styles.progressLabel, { color: colors.textSecondary }]}>
            {progress === 100
              ? "🎉 " + t("status.completed") + "!"
              : `${Math.round(progress)}% ${t("status.completed").toLowerCase()}`}
          </Text>
        </View>

        {/* Checklist Items */}
        <FlatList
          data={checklist}
          keyExtractor={(item) => item.id}
          contentContainerStyle={styles.list}
          renderItem={({ item, index }) => {
            const dependsOnItem = checklist.find(
              (c) => c.id === item.depends_on,
            );
            const isBlocked = item.depends_on
              ? !dependsOnItem?.is_completed
              : false;

            return (
              <Animated.View
                entering={FadeInDown.delay(index * 50).duration(300)}
                exiting={FadeOut.duration(200)}
                layout={LinearTransition.springify()}
              >
                <View style={styles.itemRow}>
                  <View
                    style={[
                      styles.itemContent,
                      { opacity: isBlocked ? 0.5 : 1 },
                    ]}
                  >
                    <ChecklistItem
                      item={item}
                      onToggle={() =>
                        toggleChecklistItem(planId, item.id, !item.is_completed)
                      }
                    />
                  </View>
                  {item.depends_on && (
                    <View
                      style={[
                        styles.depBadge,
                        {
                          backgroundColor: isBlocked
                            ? colors.warning + "20"
                            : colors.success + "20",
                        },
                      ]}
                    >
                      <Icon
                        name="link-variant"
                        size={12}
                        color={isBlocked ? colors.warning : colors.success}
                      />
                      <Text
                        style={[
                          styles.depText,
                          {
                            color: isBlocked ? colors.warning : colors.success,
                          },
                        ]}
                      >
                        {isBlocked
                          ? t("checklist_blocked")
                          : t("checklist_ready")}
                      </Text>
                    </View>
                  )}
                  <TouchableOpacity
                    onPress={() => handleDeleteItem(item)}
                    style={styles.deleteButton}
                    hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}
                  >
                    <Icon
                      name="trash-can-outline"
                      size={20}
                      color={colors.error}
                    />
                  </TouchableOpacity>
                </View>
              </Animated.View>
            );
          }}
          ListFooterComponent={<View style={{ height: 80 }} />}
        />

        {/* Add Item Inline Input */}
        {addingItem && (
          <Animated.View
            entering={FadeInDown.duration(250)}
            style={[styles.inlineInput, dynamicStyles.inlineInput]}
          >
            <TextInput
              style={[styles.textInput, dynamicStyles.textInput]}
              placeholder={t("add_item")}
              placeholderTextColor={colors.textTertiary}
              value={newItemTitle}
              onChangeText={setNewItemTitle}
              autoFocus
              onSubmitEditing={handleAddItem}
              returnKeyType="done"
            />
            <TouchableOpacity
              onPress={handleAddItem}
              disabled={submitting || !newItemTitle.trim()}
              style={[
                styles.submitButton,
                {
                  backgroundColor: newItemTitle.trim()
                    ? colors.primary
                    : colors.borderLight,
                },
              ]}
            >
              {submitting ? (
                <ActivityIndicator size="small" color={colors.textOnPrimary} />
              ) : (
                <Icon name="check" size={20} color={colors.textOnPrimary} />
              )}
            </TouchableOpacity>
            <TouchableOpacity
              onPress={() => {
                setAddingItem(false);
                setNewItemTitle("");
              }}
              style={styles.cancelButton}
            >
              <Icon name="close" size={20} color={colors.textTertiary} />
            </TouchableOpacity>
          </Animated.View>
        )}

        {/* Floating Add Button */}
        {!addingItem && (
          <TouchableOpacity
            style={[styles.fab, { backgroundColor: colors.primary }]}
            onPress={() => setAddingItem(true)}
            activeOpacity={0.8}
          >
            <Icon name="plus" size={26} color={colors.textOnPrimary} />
          </TouchableOpacity>
        )}

        {/* Undo Snackbar */}
        {undoState && (
          <View style={[styles.snackbar, { backgroundColor: colors.text }]}>
            <Text style={[styles.snackbarText, { color: colors.background }]}>
              {t("checklist_item_deleted")}
            </Text>
            <TouchableOpacity onPress={handleUndoDelete}>
              <Text style={[styles.snackbarAction, { color: colors.primary }]}>
                {t("checklist_undo")}
              </Text>
            </TouchableOpacity>
          </View>
        )}
      </KeyboardAvoidingView>
    </ScreenErrorBoundary>
  );
}

function getDynamicStyles(colors: ReturnType<typeof useTheme>["colors"]) {
  return {
    inlineInput: {
      backgroundColor: colors.surface,
      borderTopColor: colors.borderLight,
    },
    textInput: {
      color: colors.text,
      backgroundColor: colors.backgroundSecondary,
      borderColor: colors.borderLight,
    },
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  header: {
    padding: Spacing.lg,
    borderBottomWidth: 1,
  },
  headerRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.sm,
  },
  headerTitle: {
    ...Typography.body,
    fontWeight: "600",
    fontSize: 18,
  },
  badge: {
    paddingHorizontal: Spacing.sm + 2,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.full,
  },
  badgeText: {
    ...Typography.caption,
    fontWeight: "700",
  },
  progressBar: {
    height: 8,
    borderRadius: 4,
    overflow: "hidden",
  },
  progressFill: {
    height: "100%",
    borderRadius: 4,
  },
  progressLabel: {
    ...Typography.caption,
    marginTop: Spacing.xs + 2,
  },
  list: {
    padding: Spacing.lg,
  },
  itemRow: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: Spacing.xs,
  },
  itemContent: {
    flex: 1,
  },
  depBadge: {
    flexDirection: "row",
    alignItems: "center",
    gap: 2,
    paddingHorizontal: 4,
    paddingVertical: 2,
    borderRadius: 4,
    marginLeft: Spacing.sm,
  },
  depText: {
    fontSize: 10,
    fontWeight: "600",
  },
  deleteButton: {
    padding: Spacing.sm,
    marginLeft: Spacing.xs,
  },
  addButtonWrapper: {
    paddingHorizontal: Spacing.lg,
    paddingBottom: Spacing.lg,
  },
  addButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.sm,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.md,
  },
  addButtonText: {
    ...Typography.body,
    fontWeight: "600",
  },
  inlineInput: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderTopWidth: 1,
    gap: Spacing.sm,
  },
  textInput: {
    flex: 1,
    ...Typography.body,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm + 2,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
  },
  submitButton: {
    width: 36,
    height: 36,
    borderRadius: 18,
    justifyContent: "center",
    alignItems: "center",
  },
  cancelButton: {
    width: 36,
    height: 36,
    justifyContent: "center",
    alignItems: "center",
  },
  fab: {
    position: "absolute",
    right: Spacing.lg,
    bottom: Spacing.lg,
    width: 56,
    height: 56,
    borderRadius: 28,
    justifyContent: "center",
    alignItems: "center",
    elevation: 6,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 3 },
    shadowOpacity: 0.25,
    shadowRadius: 4,
  },
  snackbar: {
    position: "absolute",
    bottom: 80,
    left: Spacing.lg,
    right: Spacing.lg,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    paddingHorizontal: Spacing.lg,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.md,
    elevation: 6,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 4,
  },
  snackbarText: {
    ...Typography.bodySmall,
  },
  snackbarAction: {
    ...Typography.bodySmall,
    fontWeight: "700",
  },
});
