import React from "react";
import { View, Text, TouchableOpacity, StyleSheet } from "react-native";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import { useTheme } from "../../contexts/ThemeContext";
import { Spacing, Typography, BorderRadius } from "../../constants/theme";
import { hapticLight } from "../../utils/haptics";
import type { TaskAssignment } from "../../types/coOrganizer";

interface TaskCardProps {
  task: TaskAssignment;
  onToggleComplete: (id: string) => void;
  onDelete: (id: string) => void;
}

function formatDate(dateStr: string): string {
  const date = new Date(dateStr);
  if (isNaN(date.getTime())) return "";
  return date.toLocaleDateString(undefined, { day: "numeric", month: "short" });
}

export function TaskCard({ task, onToggleComplete, onDelete }: TaskCardProps) {
  const { colors } = useTheme();
  const { t } = useTranslation();
  const isCompleted = task.status === "completed";
  const title = task.checklist_item?.title ?? t("coOrganizers.taskFallback");
  const assigneeInitial = task.assignee?.display_name
    ? task.assignee.display_name.charAt(0).toUpperCase()
    : null;

  return (
    <View
      style={[
        styles.container,
        { backgroundColor: colors.surface, borderColor: colors.borderLight },
      ]}
    >
      <TouchableOpacity
        style={[
          styles.checkbox,
          { borderColor: isCompleted ? colors.success : colors.border },
        ]}
        onPress={() => {
          hapticLight();
          onToggleComplete(task.id);
        }}
      >
        {isCompleted && <Icon name="check" size={16} color={colors.success} />}
      </TouchableOpacity>

      <View style={styles.content}>
        <Text
          style={[
            styles.title,
            { color: colors.text },
            isCompleted && styles.completedText,
            isCompleted && { color: colors.textTertiary },
          ]}
          numberOfLines={1}
        >
          {title}
        </Text>
        <View style={styles.meta}>
          {task.created_at ? (
            <View style={styles.metaItem}>
              <Icon
                name="calendar-outline"
                size={12}
                color={colors.textTertiary}
              />
              <Text style={[styles.metaText, { color: colors.textTertiary }]}>
                {formatDate(task.created_at)}
              </Text>
            </View>
          ) : null}
          {assigneeInitial ? (
            <View
              style={[
                styles.assigneeAvatar,
                { backgroundColor: colors.info + "20" },
              ]}
            >
              <Text style={[styles.assigneeText, { color: colors.info }]}>
                {assigneeInitial}
              </Text>
            </View>
          ) : null}
        </View>
      </View>

      <TouchableOpacity
        onPress={() => {
          hapticLight();
          onDelete(task.id);
        }}
        style={styles.deleteBtn}
      >
        <Icon name="trash-can-outline" size={18} color={colors.error} />
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
    marginBottom: Spacing.sm,
    gap: Spacing.sm,
  },
  checkbox: {
    width: 24,
    height: 24,
    borderRadius: 12,
    borderWidth: 2,
    alignItems: "center",
    justifyContent: "center",
  },
  content: {
    flex: 1,
  },
  title: {
    ...Typography.body,
    fontWeight: "500",
  },
  completedText: {
    textDecorationLine: "line-through",
  },
  meta: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    marginTop: 4,
  },
  metaItem: {
    flexDirection: "row",
    alignItems: "center",
    gap: 3,
  },
  metaText: {
    fontSize: 10,
    fontWeight: "500",
  },
  assigneeAvatar: {
    width: 20,
    height: 20,
    borderRadius: 10,
    alignItems: "center",
    justifyContent: "center",
  },
  assigneeText: {
    fontSize: 10,
    fontWeight: "700",
  },
  deleteBtn: {
    padding: 4,
  },
});
