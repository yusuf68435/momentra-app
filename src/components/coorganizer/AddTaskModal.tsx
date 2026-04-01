import React, { useState, useEffect } from "react";
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  StyleSheet,
  ActivityIndicator,
} from "react-native";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import { useTheme } from "../../contexts/ThemeContext";
import { Spacing, Typography, BorderRadius } from "../../constants/theme";
import { Button } from "../ui/Button";
import { Modal } from "../ui/Modal";
import { hapticSelection, hapticSuccess } from "../../utils/haptics";
import { useCoOrganizerStore } from "../../stores/coOrganizerStore";
import type { CoOrganizer } from "../../types/coOrganizer";

interface ChecklistItem {
  id: string;
  title: string;
}

interface AddTaskModalProps {
  visible: boolean;
  onClose: () => void;
  onSave: (data: { checklistItemId: string; assignedTo: string }) => void;
  coOrganizers: CoOrganizer[];
  planId: string;
}

export function AddTaskModal({
  visible,
  onClose,
  onSave,
  coOrganizers,
  planId,
}: AddTaskModalProps) {
  const { colors } = useTheme();
  const { t } = useTranslation();
  const { fetchChecklistItems, createChecklistItem } = useCoOrganizerStore();

  const [checklistItems, setChecklistItems] = useState<ChecklistItem[]>([]);
  const [selectedItemId, setSelectedItemId] = useState<string | undefined>(
    undefined,
  );
  const [assignedTo, setAssignedTo] = useState<string | undefined>(undefined);
  const [newTaskTitle, setNewTaskTitle] = useState("");
  const [isCreating, setIsCreating] = useState(false);
  const [isLoadingItems, setIsLoadingItems] = useState(false);

  useEffect(() => {
    if (!visible || !planId) return;
    setIsLoadingItems(true);
    fetchChecklistItems(planId)
      .then((items) => setChecklistItems(items))
      .finally(() => setIsLoadingItems(false));
  }, [visible, planId, fetchChecklistItems]);

  const handleCreateNewItem = async () => {
    if (!newTaskTitle.trim() || !planId) return;
    setIsCreating(true);
    try {
      const item = await createChecklistItem(
        planId,
        newTaskTitle.trim(),
        checklistItems.length,
      );
      if (item) {
        setChecklistItems((prev) => [...prev, item]);
        setSelectedItemId(item.id);
        setNewTaskTitle("");
      }
    } finally {
      setIsCreating(false);
    }
  };

  const handleSave = () => {
    if (!selectedItemId) return;
    hapticSuccess();
    onSave({
      checklistItemId: selectedItemId,
      assignedTo: assignedTo ?? "",
    });
    resetState();
  };

  const handleClose = () => {
    resetState();
    onClose();
  };

  const resetState = () => {
    setSelectedItemId(undefined);
    setAssignedTo(undefined);
    setNewTaskTitle("");
  };

  const isValid = !!selectedItemId;
  const acceptedOrganizers = coOrganizers.filter(
    (co) => co.status === "accepted",
  );

  return (
    <Modal
      visible={visible}
      onClose={handleClose}
      title={t("coOrganizers.addTaskTitle")}
      scrollable
    >
      <Text style={[styles.label, { color: colors.textSecondary }]}>
        {t("coOrganizers.checklistItemLabel")} *
      </Text>

      {/* New task input */}
      <View style={styles.newTaskRow}>
        <TextInput
          style={[
            styles.newTaskInput,
            {
              backgroundColor: colors.surfaceVariant,
              color: colors.text,
              borderColor: colors.border,
            },
          ]}
          value={newTaskTitle}
          onChangeText={setNewTaskTitle}
          placeholder={t("coOrganizers.newTaskPlaceholder")}
          placeholderTextColor={colors.textTertiary}
        />
        <TouchableOpacity
          style={[
            styles.newTaskButton,
            {
              backgroundColor:
                newTaskTitle.trim() && !isCreating
                  ? colors.primary
                  : colors.border,
            },
          ]}
          onPress={handleCreateNewItem}
          disabled={!newTaskTitle.trim() || isCreating}
        >
          {isCreating ? (
            <ActivityIndicator size="small" color={colors.textOnPrimary} />
          ) : (
            <Icon name="plus" size={20} color={colors.textOnPrimary} />
          )}
        </TouchableOpacity>
      </View>

      {isLoadingItems ? (
        <ActivityIndicator
          size="small"
          color={colors.primary}
          style={{ marginVertical: Spacing.md }}
        />
      ) : checklistItems.length === 0 ? (
        <View
          style={[
            styles.emptyState,
            { backgroundColor: colors.surfaceVariant },
          ]}
        >
          <Text style={[styles.emptyStateText, { color: colors.textTertiary }]}>
            {t("coOrganizers.checklistEmptyHint")}
          </Text>
        </View>
      ) : (
        <View style={styles.itemList}>
          {checklistItems.map((item) => {
            const isSelected = selectedItemId === item.id;
            return (
              <TouchableOpacity
                key={item.id}
                style={[
                  styles.itemRow,
                  {
                    borderColor: isSelected ? colors.info : colors.border,
                  },
                  isSelected && { backgroundColor: colors.info + "10" },
                ]}
                onPress={() => {
                  hapticSelection();
                  setSelectedItemId(item.id);
                }}
              >
                <View
                  style={[
                    styles.radioOuter,
                    {
                      borderColor: isSelected ? colors.info : colors.border,
                    },
                  ]}
                >
                  {isSelected && (
                    <View
                      style={[
                        styles.radioInner,
                        { backgroundColor: colors.info },
                      ]}
                    />
                  )}
                </View>
                <Text
                  style={[
                    styles.itemRowText,
                    { color: isSelected ? colors.info : colors.text },
                  ]}
                  numberOfLines={2}
                >
                  {item.title}
                </Text>
              </TouchableOpacity>
            );
          })}
        </View>
      )}

      {acceptedOrganizers.length > 0 && (
        <>
          <Text style={[styles.label, { color: colors.textSecondary }]}>
            {t("coOrganizers.assignToLabel")}
          </Text>
          <View style={styles.assigneeGrid}>
            <TouchableOpacity
              style={[
                styles.assigneeChip,
                {
                  borderColor: !assignedTo ? colors.info : colors.border,
                },
                !assignedTo && { backgroundColor: colors.info + "10" },
              ]}
              onPress={() => {
                hapticSelection();
                setAssignedTo(undefined);
              }}
            >
              <Text
                style={[
                  styles.assigneeChipText,
                  {
                    color: !assignedTo ? colors.info : colors.textSecondary,
                  },
                ]}
              >
                {t("coOrganizers.assignNone")}
              </Text>
            </TouchableOpacity>
            {acceptedOrganizers.map((co) => {
              const isSelected = assignedTo === co.user_id;
              const displayName =
                co.profile?.display_name || co.display_name || co.email;
              const initial = displayName.charAt(0).toUpperCase();
              return (
                <TouchableOpacity
                  key={co.id}
                  style={[
                    styles.assigneeChip,
                    {
                      borderColor: isSelected ? colors.info : colors.border,
                    },
                    isSelected && { backgroundColor: colors.info + "10" },
                  ]}
                  onPress={() => {
                    hapticSelection();
                    setAssignedTo(co.user_id ?? undefined);
                  }}
                >
                  <View
                    style={[
                      styles.chipAvatar,
                      { backgroundColor: colors.info + "20" },
                    ]}
                  >
                    <Text
                      style={[styles.chipAvatarText, { color: colors.info }]}
                    >
                      {initial}
                    </Text>
                  </View>
                  <Text
                    style={[
                      styles.assigneeChipText,
                      {
                        color: isSelected ? colors.info : colors.textSecondary,
                      },
                    ]}
                    numberOfLines={1}
                  >
                    {displayName}
                  </Text>
                </TouchableOpacity>
              );
            })}
          </View>
        </>
      )}

      <Button
        title={t("coOrganizers.saveTask")}
        onPress={handleSave}
        disabled={!isValid}
        style={{ marginTop: Spacing.md }}
      />
    </Modal>
  );
}

const styles = StyleSheet.create({
  label: {
    ...Typography.caption,
    fontWeight: "600",
    marginBottom: Spacing.xs,
    marginTop: Spacing.md,
  },
  newTaskRow: {
    flexDirection: "row",
    gap: Spacing.sm,
    marginBottom: Spacing.md,
  },
  newTaskInput: {
    flex: 1,
    borderRadius: BorderRadius.md,
    padding: Spacing.md,
    borderWidth: 1,
    ...Typography.body,
  },
  newTaskButton: {
    width: 44,
    height: 44,
    borderRadius: BorderRadius.md,
    alignItems: "center",
    justifyContent: "center",
  },
  emptyState: {
    borderRadius: BorderRadius.md,
    padding: Spacing.md,
  },
  emptyStateText: {
    ...Typography.body,
    textAlign: "center",
  },
  itemList: {
    gap: Spacing.sm,
  },
  itemRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    borderWidth: 1.5,
  },
  radioOuter: {
    width: 18,
    height: 18,
    borderRadius: 9,
    borderWidth: 2,
    alignItems: "center",
    justifyContent: "center",
    flexShrink: 0,
  },
  radioInner: {
    width: 8,
    height: 8,
    borderRadius: 4,
  },
  itemRowText: {
    ...Typography.body,
    flex: 1,
  },
  assigneeGrid: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.sm,
  },
  assigneeChip: {
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.full,
    borderWidth: 1.5,
  },
  assigneeChipText: {
    ...Typography.caption,
    fontWeight: "600",
    maxWidth: 100,
  },
  chipAvatar: {
    width: 20,
    height: 20,
    borderRadius: 10,
    alignItems: "center",
    justifyContent: "center",
  },
  chipAvatarText: {
    fontSize: 10,
    fontWeight: "700",
  },
});
