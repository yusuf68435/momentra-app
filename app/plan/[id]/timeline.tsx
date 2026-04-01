import React, { useState, useCallback, useEffect, useMemo } from "react";
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  TextInput,
  Modal,
  KeyboardAvoidingView,
  Platform,
  Alert,
  ActivityIndicator,
} from "react-native";
import { useLocalSearchParams } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon } from "../../../src/components/ui/Icon";
import type { IconName } from "../../../src/constants/icons";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../../src/constants/theme";
import { useTheme } from "../../../src/contexts/ThemeContext";
import { usePlanStore } from "../../../src/stores/planStore";
import { useTimelineStore } from "../../../src/stores/timelineStore";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";
import { EmptyState } from "../../../src/components/common/EmptyState";

type Priority = "high" | "medium" | "low";

// Local display type — fields mapped from store's snake_case to camelCase
interface TimelineItem {
  id: string;
  title: string;
  description: string;
  dueDate: string;
  priority: Priority;
  isCompleted: boolean;
}

const PRIORITY_CONFIG: Record<Priority, { icon: string }> = {
  high: { icon: "arrow-up-bold" },
  medium: { icon: "minus" },
  low: { icon: "arrow-down-bold" },
};

// Store priority includes "urgent" — map it to "high" for display
function toDisplayPriority(
  priority: "low" | "medium" | "high" | "urgent",
): Priority {
  return priority === "urgent" ? "high" : priority;
}

export default function TimelineScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const { t } = useTranslation();
  const { colors } = useTheme();
  const { plans } = usePlanStore();
  const plan = plans.find((p) => p.id === id);

  const {
    timelines,
    isLoading,
    fetchTimeline,
    generateTimeline,
    addItem,
    toggleComplete,
    deleteItem,
  } = useTimelineStore();

  const [showAddModal, setShowAddModal] = useState(false);
  const [newTitle, setNewTitle] = useState("");
  const [newDescription, setNewDescription] = useState("");
  const [newDueDate, setNewDueDate] = useState("");
  const [newPriority, setNewPriority] = useState<Priority>("medium");
  const [isAdding, setIsAdding] = useState(false);

  // Map store items to local display type
  const items: TimelineItem[] = useMemo(() => {
    const raw = id ? (timelines[id] ?? []) : [];
    return [...raw]
      .sort((a, b) => {
        const aDate = a.due_date ?? "";
        const bDate = b.due_date ?? "";
        return aDate.localeCompare(bDate);
      })
      .map((item) => ({
        id: item.id,
        title: item.title,
        description: item.description ?? "",
        dueDate: item.due_date ?? "",
        priority: toDisplayPriority(item.priority),
        isCompleted: item.is_completed,
      }));
  }, [timelines, id]);

  useEffect(() => {
    if (id) {
      fetchTimeline(id).catch(() => {
        // error is stored in the store; no further action needed
      });
    }
  }, [id, fetchTimeline]);

  const completedCount = items.filter((i) => i.isCompleted).length;
  const progress =
    items.length > 0 ? Math.round((completedCount / items.length) * 100) : 0;

  const getPriorityColor = useCallback(
    (priority: Priority) => {
      switch (priority) {
        case "high":
          return colors.error;
        case "medium":
          return colors.warning;
        case "low":
          return colors.info;
      }
    },
    [colors],
  );

  const handleToggle = useCallback(
    async (itemId: string) => {
      try {
        await toggleComplete(itemId);
      } catch {
        Alert.alert(t("timeline.errorTitle"), t("timeline.toggleError"));
      }
    },
    [toggleComplete, t],
  );

  const handleAddItem = useCallback(async () => {
    if (!newTitle.trim() || !id) return;
    setIsAdding(true);
    try {
      await addItem(id, {
        title: newTitle.trim(),
        description: newDescription.trim() || undefined,
        due_date: newDueDate.trim() || new Date().toISOString().split("T")[0],
        priority: newPriority === "high" ? "high" : newPriority,
      });
      setShowAddModal(false);
      setNewTitle("");
      setNewDescription("");
      setNewDueDate("");
      setNewPriority("medium");
    } catch {
      Alert.alert(t("timeline.errorTitle"), t("timeline.addError"));
    } finally {
      setIsAdding(false);
    }
  }, [id, newTitle, newDescription, newDueDate, newPriority, addItem, t]);

  const handleGenerateAI = useCallback(async () => {
    if (!plan) return;
    try {
      await generateTimeline(plan);
    } catch {
      Alert.alert(t("timeline.errorTitle"), t("timeline.generateError"));
    }
  }, [plan, generateTimeline, t]);

  const handleDeleteItem = useCallback(
    async (itemId: string) => {
      try {
        await deleteItem(itemId);
      } catch {
        Alert.alert(t("timeline.errorTitle"), t("timeline.deleteError"));
      }
    },
    [deleteItem, t],
  );

  const styles = useMemo(() => createStyles(colors), [colors]);

  return (
    <ScreenErrorBoundary>
      <View style={styles.container}>
        {/* Header */}
        <View style={styles.header}>
          <Text style={[styles.headerTitle, { color: colors.text }]}>
            {t("timeline.headerTitle")}
          </Text>
          {items.length > 0 && (
            <View style={styles.progressSection}>
              <View style={styles.progressRow}>
                <Text
                  style={[styles.progressText, { color: colors.textSecondary }]}
                >
                  {completedCount}/{items.length} {t("timeline.completed")}
                </Text>
                <Text
                  style={[styles.progressPercent, { color: colors.primary }]}
                >
                  {progress}%
                </Text>
              </View>
              <View
                style={[
                  styles.progressBar,
                  { backgroundColor: colors.borderLight },
                ]}
              >
                <View
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
            </View>
          )}
        </View>

        {/* Generate AI Button */}
        <TouchableOpacity
          style={[
            styles.aiButton,
            {
              backgroundColor: colors.accent + "15",
              borderColor: colors.accent,
            },
          ]}
          onPress={handleGenerateAI}
          disabled={isLoading}
          activeOpacity={0.7}
        >
          {isLoading ? (
            <ActivityIndicator size="small" color={colors.accent} />
          ) : (
            <Icon
              name={"auto-fix" as IconName}
              size={22}
              color={colors.accent}
            />
          )}
          <Text style={[styles.aiButtonText, { color: colors.accent }]}>
            {isLoading ? t("timeline.generating") : t("timeline.generate_ai")}
          </Text>
        </TouchableOpacity>

        {/* Timeline */}
        {items.length === 0 ? (
          <EmptyState
            emoji="📅"
            title={t("timeline.emptyTitle")}
            description={t("timeline.empty")}
            compact
          />
        ) : (
          <ScrollView
            style={styles.timeline}
            contentContainerStyle={styles.timelineContent}
            showsVerticalScrollIndicator={false}
          >
            {items.map((item, index) => {
              const priorityColor = getPriorityColor(item.priority);
              const cfg = PRIORITY_CONFIG[item.priority];
              const isLast = index === items.length - 1;
              return (
                <View key={item.id} style={styles.timelineItem}>
                  {/* Dot and Line */}
                  <View style={styles.timelineDotColumn}>
                    <TouchableOpacity
                      style={[
                        styles.dot,
                        {
                          backgroundColor: item.isCompleted
                            ? colors.success
                            : colors.surface,
                          borderColor: item.isCompleted
                            ? colors.success
                            : priorityColor,
                        },
                      ]}
                      onPress={() => handleToggle(item.id)}
                    >
                      {item.isCompleted && (
                        <Icon
                          name="check"
                          size={14}
                          color={colors.textOnPrimary}
                        />
                      )}
                    </TouchableOpacity>
                    {!isLast && (
                      <View
                        style={[
                          styles.line,
                          { backgroundColor: colors.borderLight },
                        ]}
                      />
                    )}
                  </View>

                  {/* Content */}
                  <TouchableOpacity
                    activeOpacity={0.85}
                    onLongPress={() => handleDeleteItem(item.id)}
                    style={[
                      styles.timelineCard,
                      {
                        backgroundColor: colors.surface,
                        borderColor: colors.borderLight,
                        opacity: item.isCompleted ? 0.7 : 1,
                      },
                    ]}
                  >
                    <View style={styles.cardHeader}>
                      <Text
                        style={[
                          styles.cardTitle,
                          {
                            color: colors.text,
                            textDecorationLine: item.isCompleted
                              ? "line-through"
                              : "none",
                          },
                        ]}
                        numberOfLines={1}
                      >
                        {item.title}
                      </Text>
                      <View
                        style={[
                          styles.priorityBadge,
                          { backgroundColor: priorityColor + "15" },
                        ]}
                      >
                        <Icon
                          name={cfg.icon as IconName}
                          size={12}
                          color={priorityColor}
                        />
                        <Text
                          style={[
                            styles.priorityText,
                            { color: priorityColor },
                          ]}
                        >
                          {t(`timeline.priority.${item.priority}`)}
                        </Text>
                      </View>
                    </View>
                    {item.description ? (
                      <Text
                        style={[
                          styles.cardDesc,
                          { color: colors.textSecondary },
                        ]}
                        numberOfLines={2}
                      >
                        {item.description}
                      </Text>
                    ) : null}
                    <View style={styles.cardFooter}>
                      <Icon
                        name="calendar"
                        size={14}
                        color={colors.textTertiary}
                      />
                      <Text
                        style={[
                          styles.cardDate,
                          { color: colors.textTertiary },
                        ]}
                      >
                        {item.dueDate}
                      </Text>
                    </View>
                  </TouchableOpacity>
                </View>
              );
            })}
          </ScrollView>
        )}

        {/* FAB */}
        <TouchableOpacity
          style={[styles.fab, { backgroundColor: colors.primary }]}
          onPress={() => setShowAddModal(true)}
          activeOpacity={0.8}
        >
          <Icon name="plus" size={26} color={colors.textOnPrimary} />
        </TouchableOpacity>

        {/* Add Item Modal */}
        <Modal visible={showAddModal} animationType="slide" transparent>
          <View style={styles.modalOverlay}>
            <KeyboardAvoidingView
              behavior={Platform.OS === "ios" ? "padding" : undefined}
              style={styles.modalWrapper}
            >
              <View
                style={[
                  styles.modalContent,
                  { backgroundColor: colors.surface },
                ]}
              >
                <View style={styles.modalHeader}>
                  <Text style={[styles.modalTitle, { color: colors.text }]}>
                    {t("timeline.addItem")}
                  </Text>
                  <TouchableOpacity
                    onPress={() => setShowAddModal(false)}
                    disabled={isAdding}
                  >
                    <Icon name="close" size={24} color={colors.text} />
                  </TouchableOpacity>
                </View>

                <View style={styles.inputGroup}>
                  <Text
                    style={[styles.inputLabel, { color: colors.textSecondary }]}
                  >
                    {t("timeline.titleLabel")}
                  </Text>
                  <TextInput
                    style={[
                      styles.input,
                      {
                        color: colors.text,
                        backgroundColor: colors.backgroundSecondary,
                        borderColor: colors.borderLight,
                      },
                    ]}
                    value={newTitle}
                    onChangeText={setNewTitle}
                    placeholder={t("timeline.titlePlaceholder")}
                    placeholderTextColor={colors.textTertiary}
                  />
                </View>

                <View style={styles.inputGroup}>
                  <Text
                    style={[styles.inputLabel, { color: colors.textSecondary }]}
                  >
                    {t("timeline.descriptionLabel")}
                  </Text>
                  <TextInput
                    style={[
                      styles.input,
                      styles.textArea,
                      {
                        color: colors.text,
                        backgroundColor: colors.backgroundSecondary,
                        borderColor: colors.borderLight,
                      },
                    ]}
                    value={newDescription}
                    onChangeText={setNewDescription}
                    placeholder={t("timeline.detailsPlaceholder")}
                    placeholderTextColor={colors.textTertiary}
                    multiline
                    textAlignVertical="top"
                  />
                </View>

                <View style={styles.inputGroup}>
                  <Text
                    style={[styles.inputLabel, { color: colors.textSecondary }]}
                  >
                    {t("timeline.dueDateLabel")}
                  </Text>
                  <TextInput
                    style={[
                      styles.input,
                      {
                        color: colors.text,
                        backgroundColor: colors.backgroundSecondary,
                        borderColor: colors.borderLight,
                      },
                    ]}
                    value={newDueDate}
                    onChangeText={setNewDueDate}
                    placeholder="YYYY-MM-DD"
                    placeholderTextColor={colors.textTertiary}
                  />
                </View>

                <View style={styles.inputGroup}>
                  <Text
                    style={[styles.inputLabel, { color: colors.textSecondary }]}
                  >
                    {t("timeline.priorityLabel")}
                  </Text>
                  <View style={styles.priorityRow}>
                    {(["high", "medium", "low"] as Priority[]).map((p) => {
                      const pColor =
                        p === "high"
                          ? colors.error
                          : p === "medium"
                            ? colors.warning
                            : colors.info;
                      const cfg = PRIORITY_CONFIG[p];
                      return (
                        <TouchableOpacity
                          key={p}
                          style={[
                            styles.priorityOption,
                            {
                              backgroundColor:
                                newPriority === p
                                  ? pColor + "20"
                                  : colors.surfaceVariant,
                              borderColor:
                                newPriority === p ? pColor : "transparent",
                            },
                          ]}
                          onPress={() => setNewPriority(p)}
                        >
                          <Icon
                            name={cfg.icon as IconName}
                            size={16}
                            color={pColor}
                          />
                          <Text
                            style={[
                              styles.priorityOptionText,
                              {
                                color:
                                  newPriority === p
                                    ? pColor
                                    : colors.textSecondary,
                              },
                            ]}
                          >
                            {t(`timeline.priority.${p}`)}
                          </Text>
                        </TouchableOpacity>
                      );
                    })}
                  </View>
                </View>

                <TouchableOpacity
                  style={[
                    styles.saveButton,
                    {
                      backgroundColor:
                        newTitle.trim() && !isAdding
                          ? colors.primary
                          : colors.borderLight,
                    },
                  ]}
                  onPress={handleAddItem}
                  disabled={!newTitle.trim() || isAdding}
                >
                  {isAdding ? (
                    <ActivityIndicator
                      size="small"
                      color={colors.textOnPrimary}
                    />
                  ) : (
                    <Text
                      style={[
                        styles.saveButtonText,
                        { color: colors.textOnPrimary },
                      ]}
                    >
                      {t("timeline.addButton")}
                    </Text>
                  )}
                </TouchableOpacity>
              </View>
            </KeyboardAvoidingView>
          </View>
        </Modal>
      </View>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: { flex: 1, backgroundColor: colors.background },
    header: {
      padding: Spacing.lg,
      borderBottomWidth: 1,
      borderBottomColor: colors.borderLight,
    },
    headerTitle: { ...Typography.h3 },
    progressSection: { marginTop: Spacing.md },
    progressRow: {
      flexDirection: "row",
      justifyContent: "space-between",
      marginBottom: Spacing.xs,
    },
    progressText: { ...Typography.caption },
    progressPercent: { ...Typography.caption, fontWeight: "700" },
    progressBar: { height: 8, borderRadius: 4, overflow: "hidden" },
    progressFill: { height: "100%", borderRadius: 4 },
    aiButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      marginHorizontal: Spacing.lg,
      marginTop: Spacing.lg,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1.5,
    },
    aiButtonText: { ...Typography.button },
    timeline: { flex: 1 },
    timelineContent: { padding: Spacing.lg, paddingBottom: Spacing.xxl + 40 },
    timelineItem: { flexDirection: "row", gap: Spacing.md },
    timelineDotColumn: { alignItems: "center", width: 28 },
    dot: {
      width: 28,
      height: 28,
      borderRadius: 14,
      borderWidth: 2.5,
      alignItems: "center",
      justifyContent: "center",
    },
    line: { width: 2, flex: 1, marginVertical: 4 },
    timelineCard: {
      flex: 1,
      padding: Spacing.md,
      borderRadius: BorderRadius.lg,
      borderWidth: 1,
      marginBottom: Spacing.md,
      ...Shadows.sm,
    },
    cardHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      gap: Spacing.sm,
    },
    cardTitle: { ...Typography.body, fontWeight: "600", flex: 1 },
    priorityBadge: {
      flexDirection: "row",
      alignItems: "center",
      gap: 3,
      paddingHorizontal: Spacing.sm,
      paddingVertical: 2,
      borderRadius: BorderRadius.full,
    },
    priorityText: { ...Typography.caption, fontWeight: "600", fontSize: 10 },
    cardDesc: { ...Typography.bodySmall, marginTop: Spacing.xs },
    cardFooter: {
      flexDirection: "row",
      alignItems: "center",
      gap: 4,
      marginTop: Spacing.sm,
    },
    cardDate: { ...Typography.caption },
    fab: {
      position: "absolute",
      right: Spacing.lg,
      bottom: Spacing.lg,
      width: 56,
      height: 56,
      borderRadius: 28,
      justifyContent: "center",
      alignItems: "center",
      ...Shadows.lg,
    },
    modalOverlay: {
      flex: 1,
      backgroundColor: "rgba(0,0,0,0.5)",
      justifyContent: "flex-end",
    },
    modalWrapper: { width: "100%" },
    modalContent: {
      borderTopLeftRadius: BorderRadius.xl,
      borderTopRightRadius: BorderRadius.xl,
      padding: Spacing.lg,
    },
    modalHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      marginBottom: Spacing.lg,
    },
    modalTitle: { ...Typography.h4 },
    inputGroup: { marginBottom: Spacing.md },
    inputLabel: {
      ...Typography.caption,
      fontWeight: "600",
      marginBottom: Spacing.xs,
    },
    input: {
      ...Typography.body,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1,
    },
    textArea: { minHeight: 80 },
    priorityRow: { flexDirection: "row", gap: Spacing.sm },
    priorityOption: {
      flex: 1,
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: 4,
      paddingVertical: Spacing.sm,
      borderRadius: BorderRadius.md,
      borderWidth: 1.5,
    },
    priorityOptionText: { ...Typography.caption, fontWeight: "600" },
    saveButton: {
      alignItems: "center",
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
      marginTop: Spacing.sm,
    },
    saveButtonText: { ...Typography.button },
  });
