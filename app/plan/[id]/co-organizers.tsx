import React, { useState, useEffect, useMemo, useCallback } from "react";
import { View, Text, ScrollView, StyleSheet, Alert, Share } from "react-native";
import { useLocalSearchParams } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon } from "../../../src/components/ui/Icon";
import Animated, { FadeInDown } from "react-native-reanimated";
import { useTheme } from "../../../src/contexts/ThemeContext";
import { useCoOrganizerStore } from "../../../src/stores/coOrganizerStore";
import { useAuthStore } from "../../../src/stores/authStore";
import { usePlanStore } from "../../../src/stores/planStore";
import { CoOrganizerCard } from "../../../src/components/coorganizer/CoOrganizerCard";
import { InviteModal } from "../../../src/components/coorganizer/InviteModal";
import { TaskCard } from "../../../src/components/coorganizer/TaskCard";
import { AddTaskModal } from "../../../src/components/coorganizer/AddTaskModal";
import { Button } from "../../../src/components/ui/Button";
import { EmptyState } from "../../../src/components/common/EmptyState";
import { useToast } from "../../../src/hooks/useToast";
import {
  Spacing,
  Typography,
  BorderRadius,
  type ThemeColors,
} from "../../../src/constants/theme";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";

export default function CoOrganizersScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const { t } = useTranslation();
  const { colors } = useTheme();
  const { showError, showSuccess } = useToast();

  const { user } = useAuthStore();
  const { plans } = usePlanStore();

  const {
    coOrganizers,
    tasks,
    loadingCoOrganizers,
    loadingTasks,
    loadCoOrganizers,
    invite,
    removeCoOrganizer,
    updateRole,
    loadTasks,
    createTask,
    toggleTask,
    deleteTask,
    createInviteLink,
  } = useCoOrganizerStore();

  const [showInviteModal, setShowInviteModal] = useState(false);
  const [showAddTaskModal, setShowAddTaskModal] = useState(false);

  const loading = loadingCoOrganizers || loadingTasks;

  const loadData = useCallback(async () => {
    if (!id) return;
    try {
      await Promise.all([loadCoOrganizers(id), loadTasks(id)]);
    } catch {
      showError(t("coOrganizers.loadError"));
    }
  }, [id, loadCoOrganizers, loadTasks, showError, t]);

  useEffect(() => {
    loadData();
  }, [loadData]);

  const isOwner = useMemo(() => {
    const plan = plans.find((p) => p.id === id);
    return plan?.user_id === user?.id;
  }, [plans, id, user?.id]);

  const handleInvite = async (data: {
    email: string;
    role: "editor" | "viewer";
  }) => {
    if (!id) return;
    setShowInviteModal(false);

    const roleMap: Record<string, "organizer" | "helper"> = {
      editor: "organizer",
      viewer: "helper",
    };

    try {
      await invite(id, data.email, roleMap[data.role] ?? "helper");
    } catch {
      // ignore — we'll still create the link
    }

    try {
      const link = await createInviteLink(id);
      if (link) {
        const inviteUrl = `momentra://invite?code=${link.code}`;
        Alert.alert(
          t("coOrganizers.inviteShareTitle"),
          t("coOrganizers.inviteLinkCreated"),
          [
            {
              text: t("coOrganizers.shareLink"),
              onPress: () => {
                Share.share({
                  title: t("coOrganizers.inviteShareTitle"),
                  message: t("coOrganizers.inviteShareMessage", {
                    url: inviteUrl,
                  }),
                  url: inviteUrl,
                }).catch(() => {});
              },
            },
            { text: t("coOrganizers.cancel"), style: "cancel" },
          ],
        );
      } else {
        showError(t("coOrganizers.inviteErrorMessage"));
      }
    } catch {
      showError(t("coOrganizers.inviteErrorMessage"));
    }
  };

  const handleRemove = (planId: string, userId: string) => {
    Alert.alert(t("coOrganizers.remove"), t("coOrganizers.removeConfirm"), [
      { text: t("coOrganizers.cancel"), style: "cancel" },
      {
        text: t("coOrganizers.remove"),
        style: "destructive",
        onPress: async () => {
          try {
            await removeCoOrganizer(planId, userId);
            showSuccess(t("coOrganizers.removeSuccess"));
          } catch {
            showError(t("coOrganizers.removeFailed"));
          }
        },
      },
    ]);
  };

  const handleChangeRole = async (
    planId: string,
    userId: string,
    role: "organizer" | "helper",
  ) => {
    try {
      await updateRole(planId, userId, role);
      showSuccess(t("coOrganizers.roleUpdated"));
    } catch {
      showError(t("coOrganizers.roleUpdateFailed"));
    }
  };

  const handleAddTask = async (data: {
    checklistItemId: string;
    assignedTo: string;
  }) => {
    if (!id) return;
    try {
      await createTask(id, data);
      setShowAddTaskModal(false);
      showSuccess(t("coOrganizers.taskCreated"));
    } catch {
      showError(t("coOrganizers.taskCreateFailed"));
    }
  };

  const handleToggleTask = async (taskId: string) => {
    try {
      await toggleTask(taskId);
    } catch {
      showError(t("coOrganizers.taskToggleFailed"));
    }
  };

  const handleDeleteTask = (taskId: string) => {
    Alert.alert(t("coOrganizers.delete"), t("coOrganizers.deleteTaskConfirm"), [
      { text: t("coOrganizers.cancel"), style: "cancel" },
      {
        text: t("coOrganizers.delete"),
        style: "destructive",
        onPress: async () => {
          try {
            await deleteTask(taskId);
            showSuccess(t("coOrganizers.taskDeleted"));
          } catch {
            showError(t("coOrganizers.taskDeleteFailed"));
          }
        },
      },
    ]);
  };

  const pendingInvites = useMemo(
    () => coOrganizers.filter((co) => co.status === "pending"),
    [coOrganizers],
  );

  const acceptedMembers = useMemo(
    () => coOrganizers.filter((co) => co.status !== "pending"),
    [coOrganizers],
  );

  const incompleteTasks = useMemo(
    () => tasks.filter((task) => task.status !== "completed"),
    [tasks],
  );

  const completedTasks = useMemo(
    () => tasks.filter((task) => task.status === "completed"),
    [tasks],
  );

  const styles = useMemo(() => createStyles(colors), [colors]);

  return (
    <ScreenErrorBoundary>
      <View style={styles.container}>
        <ScrollView contentContainerStyle={styles.scrollContent}>
          {/* Co-Organizers Section */}
          <Animated.View
            entering={FadeInDown.duration(400)}
            style={styles.section}
          >
            <View style={styles.sectionHeader}>
              <View style={styles.sectionTitleRow}>
                <Icon name="account-group" size={20} color={colors.info} />
                <Text style={styles.sectionTitle}>
                  {t("coOrganizers.title")}
                </Text>
                <View
                  style={[
                    styles.countBadge,
                    { backgroundColor: colors.info + "15" },
                  ]}
                >
                  <Text style={[styles.countText, { color: colors.info }]}>
                    {acceptedMembers.length}
                  </Text>
                </View>
              </View>
            </View>

            {acceptedMembers.length === 0 && !loading ? (
              <EmptyState
                emoji="👥"
                title={t("coOrganizers.emptyTitle")}
                description={t("coOrganizers.emptyDescription")}
              />
            ) : (
              acceptedMembers.map((co) => (
                <CoOrganizerCard
                  key={co.id}
                  coOrganizer={co}
                  isOwner={isOwner}
                  onRemove={handleRemove}
                  onChangeRole={handleChangeRole}
                />
              ))
            )}
          </Animated.View>

          {/* Pending Invites */}
          {pendingInvites.length > 0 && (
            <Animated.View
              entering={FadeInDown.duration(400).delay(100)}
              style={styles.section}
            >
              <View style={styles.sectionHeader}>
                <View style={styles.sectionTitleRow}>
                  <Icon name="clock-outline" size={20} color={colors.warning} />
                  <Text style={styles.sectionTitle}>
                    {t("coOrganizers.pendingInvites")}
                  </Text>
                  <View
                    style={[
                      styles.countBadge,
                      { backgroundColor: colors.warning + "15" },
                    ]}
                  >
                    <Text style={[styles.countText, { color: colors.warning }]}>
                      {pendingInvites.length}
                    </Text>
                  </View>
                </View>
              </View>
              {pendingInvites.map((co) => (
                <CoOrganizerCard
                  key={co.id}
                  coOrganizer={co}
                  isOwner={isOwner}
                  onRemove={handleRemove}
                  onChangeRole={handleChangeRole}
                />
              ))}
            </Animated.View>
          )}

          {/* Invite Button */}
          <View style={styles.buttonContainer}>
            <Button
              title={t("coOrganizers.inviteButton")}
              onPress={() => setShowInviteModal(true)}
            />
          </View>

          {/* Tasks Section */}
          <Animated.View
            entering={FadeInDown.duration(400).delay(200)}
            style={styles.section}
          >
            <View style={styles.sectionHeader}>
              <View style={styles.sectionTitleRow}>
                <Icon
                  name="checkbox-marked-outline"
                  size={20}
                  color={colors.success}
                />
                <Text style={styles.sectionTitle}>
                  {t("coOrganizers.tasks")}
                </Text>
                <View
                  style={[
                    styles.countBadge,
                    { backgroundColor: colors.success + "15" },
                  ]}
                >
                  <Text style={[styles.countText, { color: colors.success }]}>
                    {completedTasks.length}/{tasks.length}
                  </Text>
                </View>
              </View>
            </View>

            {tasks.length === 0 && !loading ? (
              <EmptyState
                emoji="📋"
                title={t("coOrganizers.tasksEmptyTitle")}
                description={t("coOrganizers.tasksEmptyDescription")}
              />
            ) : (
              <>
                {incompleteTasks.map((task) => (
                  <TaskCard
                    key={task.id}
                    task={task}
                    onToggleComplete={handleToggleTask}
                    onDelete={handleDeleteTask}
                  />
                ))}
                {completedTasks.length > 0 && (
                  <>
                    <Text style={styles.completedLabel}>
                      {t("coOrganizers.completed")} ({completedTasks.length})
                    </Text>
                    {completedTasks.map((task) => (
                      <TaskCard
                        key={task.id}
                        task={task}
                        onToggleComplete={handleToggleTask}
                        onDelete={handleDeleteTask}
                      />
                    ))}
                  </>
                )}
              </>
            )}
          </Animated.View>

          {/* Add Task Button */}
          <View style={styles.buttonContainer}>
            <Button
              title={t("coOrganizers.addTaskButton")}
              onPress={() => setShowAddTaskModal(true)}
              variant="outline"
            />
          </View>
        </ScrollView>

        <InviteModal
          visible={showInviteModal}
          onClose={() => setShowInviteModal(false)}
          onSend={handleInvite}
        />

        <AddTaskModal
          visible={showAddTaskModal}
          onClose={() => setShowAddTaskModal(false)}
          onSave={handleAddTask}
          coOrganizers={coOrganizers}
          planId={id ?? ""}
        />
      </View>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },
    scrollContent: {
      paddingBottom: Spacing.xxl,
    },
    section: {
      marginHorizontal: Spacing.lg,
      marginTop: Spacing.lg,
    },
    sectionHeader: {
      marginBottom: Spacing.md,
    },
    sectionTitleRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
    },
    sectionTitle: {
      ...Typography.h4,
      color: colors.text,
    },
    countBadge: {
      paddingHorizontal: Spacing.sm,
      paddingVertical: 2,
      borderRadius: BorderRadius.full,
    },
    countText: {
      ...Typography.caption,
      fontWeight: "700",
    },
    buttonContainer: {
      paddingHorizontal: Spacing.lg,
      marginTop: Spacing.md,
    },
    completedLabel: {
      ...Typography.caption,
      color: colors.textTertiary,
      fontWeight: "600",
      marginTop: Spacing.md,
      marginBottom: Spacing.sm,
    },
  });
