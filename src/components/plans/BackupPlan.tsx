import React, { useMemo } from "react";
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  ScrollView,
} from "react-native";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import { useTranslation } from "react-i18next";
import { useTheme } from "../../contexts/ThemeContext";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../constants/theme";
import { Card } from "../ui/Card";

export interface BackupPlanData {
  id: string;
  title: string;
  description: string;
  venue: string;
  date: string;
  triggerConditions: TriggerCondition[];
  isActive: boolean;
}

export interface TriggerCondition {
  id: string;
  type:
    | "weather"
    | "venue_cancellation"
    | "low_attendance"
    | "budget_exceeded"
    | "other";
  label: string;
  met: boolean;
}

interface BackupPlanProps {
  planId: string;
  backupPlan?: BackupPlanData;
  originalVenue?: string;
  originalDate?: string;
  onGenerateBackup?: () => void;
  onActivateBackup?: () => void;
}

const triggerIcons: Record<string, IconName> = {
  weather: "weather-pouring",
  venue_cancellation: "home-off",
  low_attendance: "account-group-outline",
  budget_exceeded: "cash-remove",
  other: "alert-outline",
};

export function BackupPlan({
  planId,
  backupPlan,
  originalVenue,
  originalDate,
  onGenerateBackup,
  onActivateBackup,
}: BackupPlanProps) {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const styles = useMemo(() => createStyles(colors), [colors]);

  if (!backupPlan) {
    return (
      <Card style={styles.emptyContainer}>
        <View style={styles.emptyIcon}>
          <Icon name="shield-outline" size={48} color={colors.textTertiary} />
        </View>
        <Text style={styles.emptyTitle}>{t("backupPlan.noBackupTitle")}</Text>
        <Text style={styles.emptySubtitle}>
          {t("backupPlan.noBackupSubtitle")}
        </Text>

        <TouchableOpacity
          style={styles.generateButton}
          onPress={onGenerateBackup}
          activeOpacity={0.8}
        >
          <Icon name="auto-fix" size={20} color={colors.textOnPrimary} />
          <Text style={styles.generateButtonText}>
            {t("backupPlan.generateWithAI")}
          </Text>
        </TouchableOpacity>
      </Card>
    );
  }

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <View style={styles.headerLeft}>
          <Icon name="shield-check" size={24} color={colors.info} />
          <Text style={styles.sectionTitle}>{t("backupPlan.title")}</Text>
        </View>
        {backupPlan.isActive && (
          <View style={styles.activeBadge}>
            <Text style={styles.activeBadgeText}>{t("backupPlan.active")}</Text>
          </View>
        )}
      </View>

      {/* Trigger Conditions */}
      <Card style={styles.triggersCard}>
        <Text style={styles.triggersTitle}>
          {t("backupPlan.triggerConditions")}
        </Text>
        {backupPlan.triggerConditions.map((condition) => (
          <View key={condition.id} style={styles.triggerRow}>
            <Icon
              name={triggerIcons[condition.type] || "alert-outline"}
              size={20}
              color={condition.met ? colors.warning : colors.textTertiary}
            />
            <Text
              style={[styles.triggerLabel, condition.met && styles.triggerMet]}
            >
              {condition.label}
            </Text>
            <Icon
              name={condition.met ? "alert-circle" : "check-circle-outline"}
              size={18}
              color={condition.met ? colors.warning : colors.success}
            />
          </View>
        ))}
      </Card>

      {/* Side-by-side Comparison */}
      <Text style={styles.comparisonTitle}>{t("backupPlan.comparison")}</Text>
      <ScrollView horizontal showsHorizontalScrollIndicator={false}>
        <View style={styles.comparisonRow}>
          {/* Original Plan */}
          <Card style={styles.comparisonCard}>
            <View
              style={[
                styles.comparisonHeader,
                { backgroundColor: colors.primary + "15" },
              ]}
            >
              <Icon name="alpha-a-circle" size={20} color={colors.primary} />
              <Text
                style={[styles.comparisonHeaderText, { color: colors.primary }]}
              >
                {t("backupPlan.originalPlan")}
              </Text>
            </View>
            <View style={styles.comparisonContent}>
              <View style={styles.comparisonItem}>
                <Icon
                  name="map-marker"
                  size={16}
                  color={colors.textSecondary}
                />
                <Text style={styles.comparisonValue}>
                  {originalVenue || "-"}
                </Text>
              </View>
              <View style={styles.comparisonItem}>
                <Icon name="calendar" size={16} color={colors.textSecondary} />
                <Text style={styles.comparisonValue}>
                  {originalDate || "-"}
                </Text>
              </View>
            </View>
          </Card>

          {/* Backup Plan */}
          <Card style={styles.comparisonCard}>
            <View
              style={[
                styles.comparisonHeader,
                { backgroundColor: colors.info + "15" },
              ]}
            >
              <Icon name="alpha-b-circle" size={20} color={colors.info} />
              <Text
                style={[styles.comparisonHeaderText, { color: colors.info }]}
              >
                {t("backupPlan.planB")}
              </Text>
            </View>
            <View style={styles.comparisonContent}>
              <View style={styles.comparisonItem}>
                <Icon
                  name="map-marker"
                  size={16}
                  color={colors.textSecondary}
                />
                <Text style={styles.comparisonValue}>{backupPlan.venue}</Text>
              </View>
              <View style={styles.comparisonItem}>
                <Icon name="calendar" size={16} color={colors.textSecondary} />
                <Text style={styles.comparisonValue}>{backupPlan.date}</Text>
              </View>
            </View>
          </Card>
        </View>
      </ScrollView>

      {/* Description */}
      <Card style={styles.descriptionCard}>
        <Text style={styles.descriptionText}>{backupPlan.description}</Text>
      </Card>

      {/* Actions */}
      <View style={styles.actions}>
        {!backupPlan.isActive && (
          <TouchableOpacity
            style={styles.activateButton}
            onPress={onActivateBackup}
            activeOpacity={0.8}
          >
            <Icon
              name="swap-horizontal"
              size={20}
              color={colors.textOnPrimary}
            />
            <Text style={styles.activateButtonText}>
              {t("backupPlan.switchToBackup")}
            </Text>
          </TouchableOpacity>
        )}

        <TouchableOpacity
          style={styles.regenerateButton}
          onPress={onGenerateBackup}
          activeOpacity={0.8}
        >
          <Icon name="refresh" size={20} color={colors.accent} />
          <Text style={styles.regenerateButtonText}>
            {t("backupPlan.regenerate")}
          </Text>
        </TouchableOpacity>
      </View>
    </View>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      marginBottom: Spacing.md,
    },
    header: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      marginBottom: Spacing.md,
    },
    headerLeft: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
    },
    sectionTitle: {
      ...Typography.h3,
      color: colors.text,
    },
    activeBadge: {
      backgroundColor: colors.success + "20",
      paddingHorizontal: Spacing.sm,
      paddingVertical: 4,
      borderRadius: BorderRadius.sm,
    },
    activeBadgeText: {
      ...Typography.caption,
      color: colors.success,
      fontWeight: "700",
    },
    triggersCard: {
      padding: Spacing.md,
      marginBottom: Spacing.md,
    },
    triggersTitle: {
      ...Typography.h4,
      color: colors.text,
      marginBottom: Spacing.sm,
    },
    triggerRow: {
      flexDirection: "row",
      alignItems: "center",
      paddingVertical: Spacing.sm,
      gap: Spacing.sm,
      borderBottomWidth: 1,
      borderBottomColor: colors.border,
    },
    triggerLabel: {
      ...Typography.body,
      color: colors.text,
      flex: 1,
    },
    triggerMet: {
      color: colors.warning,
      fontWeight: "600",
    },
    comparisonTitle: {
      ...Typography.h4,
      color: colors.text,
      marginBottom: Spacing.sm,
    },
    comparisonRow: {
      flexDirection: "row",
      gap: Spacing.sm,
      paddingBottom: Spacing.md,
    },
    comparisonCard: {
      width: 200,
      overflow: "hidden",
    },
    comparisonHeader: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.xs,
      padding: Spacing.sm,
    },
    comparisonHeaderText: {
      ...Typography.bodySmall,
      fontWeight: "700",
    },
    comparisonContent: {
      padding: Spacing.sm,
      gap: Spacing.xs,
    },
    comparisonItem: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.xs,
    },
    comparisonValue: {
      ...Typography.bodySmall,
      color: colors.text,
      flex: 1,
    },
    descriptionCard: {
      padding: Spacing.md,
      marginBottom: Spacing.md,
    },
    descriptionText: {
      ...Typography.body,
      color: colors.textSecondary,
    },
    actions: {
      gap: Spacing.sm,
    },
    activateButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      backgroundColor: colors.warning,
      borderRadius: BorderRadius.md,
      paddingVertical: Spacing.sm + 2,
      paddingHorizontal: Spacing.lg,
      gap: Spacing.sm,
      ...Shadows.md,
    },
    activateButtonText: {
      ...Typography.button,
      color: colors.textOnPrimary,
    },
    regenerateButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      borderWidth: 2,
      borderColor: colors.accent,
      borderRadius: BorderRadius.md,
      paddingVertical: Spacing.sm + 2,
      paddingHorizontal: Spacing.lg,
      gap: Spacing.sm,
    },
    regenerateButtonText: {
      ...Typography.button,
      color: colors.accent,
    },
    emptyContainer: {
      alignItems: "center",
      paddingVertical: Spacing.xxl,
      paddingHorizontal: Spacing.lg,
    },
    emptyIcon: {
      width: 80,
      height: 80,
      borderRadius: 40,
      backgroundColor: colors.backgroundSecondary,
      alignItems: "center",
      justifyContent: "center",
      marginBottom: Spacing.md,
    },
    emptyTitle: {
      ...Typography.h3,
      color: colors.text,
    },
    emptySubtitle: {
      ...Typography.body,
      color: colors.textSecondary,
      textAlign: "center",
      marginTop: Spacing.xs,
      marginBottom: Spacing.lg,
    },
    generateButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      backgroundColor: colors.accent,
      borderRadius: BorderRadius.md,
      paddingVertical: Spacing.sm + 2,
      paddingHorizontal: Spacing.lg,
      gap: Spacing.sm,
      ...Shadows.md,
    },
    generateButtonText: {
      ...Typography.button,
      color: colors.textOnPrimary,
    },
  });
