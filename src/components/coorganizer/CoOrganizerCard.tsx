import React from "react";
import { View, Text, TouchableOpacity, StyleSheet, Alert } from "react-native";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import { useTheme } from "../../contexts/ThemeContext";
import { Spacing, Typography, BorderRadius } from "../../constants/theme";
import { hapticLight } from "../../utils/haptics";
import type { CoOrganizer } from "../../types/coOrganizer";

export type { CoOrganizer };

interface RoleConfig {
  colorToken: "info" | "textSecondary";
  labelKey: string;
  icon: IconName;
}

const ROLE_CONFIG: Record<string, RoleConfig> = {
  organizer: {
    colorToken: "info",
    labelKey: "coOrganizers.roleOrganizer",
    icon: "account-star",
  },
  helper: {
    colorToken: "textSecondary",
    labelKey: "coOrganizers.roleHelper",
    icon: "account-outline",
  },
};

const STATUS_KEYS: Record<string, string> = {
  accepted: "coOrganizers.statusAccepted",
  pending: "coOrganizers.statusPending",
  declined: "coOrganizers.statusDeclined",
};

interface CoOrganizerCardProps {
  coOrganizer: CoOrganizer;
  isOwner: boolean;
  onRemove?: (planId: string, userId: string) => void;
  onChangeRole?: (
    planId: string,
    userId: string,
    role: "organizer" | "helper",
  ) => void;
}

export function CoOrganizerCard({
  coOrganizer,
  isOwner,
  onRemove,
  onChangeRole,
}: CoOrganizerCardProps) {
  const { colors } = useTheme();
  const { t } = useTranslation();
  const roleConfig = ROLE_CONFIG[coOrganizer.role] ?? ROLE_CONFIG.helper;
  const roleColor = colors[roleConfig.colorToken];
  const statusKey = STATUS_KEYS[coOrganizer.status] ?? STATUS_KEYS.pending;
  const displayName =
    coOrganizer.profile?.display_name ||
    coOrganizer.display_name ||
    coOrganizer.email ||
    "?";
  const firstLetter = displayName.charAt(0).toUpperCase();

  const handleLongPress = () => {
    if (!isOwner || !coOrganizer.user_id) return;
    hapticLight();

    const options: {
      text: string;
      onPress?: () => void;
      style?: "cancel" | "destructive";
    }[] = [];

    if (coOrganizer.role === "organizer") {
      options.push({
        text: t("coOrganizers.makeHelper"),
        onPress: () =>
          onChangeRole?.(coOrganizer.plan_id, coOrganizer.user_id!, "helper"),
      });
    } else if (coOrganizer.role === "helper") {
      options.push({
        text: t("coOrganizers.makeOrganizer"),
        onPress: () =>
          onChangeRole?.(
            coOrganizer.plan_id,
            coOrganizer.user_id!,
            "organizer",
          ),
      });
    }

    options.push({
      text: t("coOrganizers.remove"),
      style: "destructive",
      onPress: () => onRemove?.(coOrganizer.plan_id, coOrganizer.user_id!),
    });

    options.push({
      text: t("coOrganizers.cancel"),
      style: "cancel",
    });

    Alert.alert(displayName, t("coOrganizers.chooseAction"), options);
  };

  return (
    <TouchableOpacity
      style={[
        styles.container,
        { backgroundColor: colors.surface, borderColor: colors.borderLight },
      ]}
      onLongPress={handleLongPress}
      activeOpacity={isOwner && coOrganizer.user_id ? 0.7 : 1}
      delayLongPress={400}
    >
      <View style={[styles.avatar, { backgroundColor: roleColor + "20" }]}>
        <Text style={[styles.avatarText, { color: roleColor }]}>
          {firstLetter}
        </Text>
      </View>

      <View style={styles.content}>
        <Text style={[styles.name, { color: colors.text }]} numberOfLines={1}>
          {displayName}
        </Text>
        <View style={styles.meta}>
          <View
            style={[styles.roleBadge, { backgroundColor: roleColor + "15" }]}
          >
            <Icon name={roleConfig.icon} size={12} color={roleColor} />
            <Text style={[styles.roleText, { color: roleColor }]}>
              {t(roleConfig.labelKey)}
            </Text>
          </View>
          {coOrganizer.status === "pending" && (
            <View
              style={[
                styles.statusBadge,
                { backgroundColor: colors.warning + "15" },
              ]}
            >
              <Text style={[styles.statusText, { color: colors.warning }]}>
                {t(statusKey)}
              </Text>
            </View>
          )}
          {coOrganizer.status === "declined" && (
            <View
              style={[
                styles.statusBadge,
                { backgroundColor: colors.error + "15" },
              ]}
            >
              <Text style={[styles.statusText, { color: colors.error }]}>
                {t(statusKey)}
              </Text>
            </View>
          )}
        </View>
      </View>

      {isOwner && coOrganizer.user_id && (
        <Icon name="dots-vertical" size={20} color={colors.textTertiary} />
      )}
    </TouchableOpacity>
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
  avatar: {
    width: 44,
    height: 44,
    borderRadius: 22,
    alignItems: "center",
    justifyContent: "center",
  },
  avatarText: {
    fontSize: 18,
    fontWeight: "700",
  },
  content: {
    flex: 1,
  },
  name: {
    ...Typography.body,
    fontWeight: "500",
  },
  meta: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    marginTop: 2,
  },
  roleBadge: {
    flexDirection: "row",
    alignItems: "center",
    gap: 3,
    paddingHorizontal: 6,
    paddingVertical: 2,
    borderRadius: BorderRadius.full,
  },
  roleText: {
    fontSize: 10,
    fontWeight: "600",
  },
  statusBadge: {
    paddingHorizontal: 6,
    paddingVertical: 2,
    borderRadius: BorderRadius.full,
  },
  statusText: {
    fontSize: 10,
    fontWeight: "600",
  },
});
