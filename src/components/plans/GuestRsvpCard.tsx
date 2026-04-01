import React from "react";
import {
  View,
  Text,
  FlatList,
  TouchableOpacity,
  StyleSheet,
} from "react-native";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import {
  type ThemeColors,
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";
import { Card } from "../ui/Card";

export interface Guest {
  id: string;
  name: string;
  email: string;
  phone: string | null;
  rsvp_status: "pending" | "accepted" | "declined" | "maybe";
  invited_at: string;
}

interface GuestRsvpCardProps {
  planId: string;
  guests: Guest[];
  onInvite: () => void;
  onRemind: (id: string) => void;
}

const getStatusConfig = (
  colors: ThemeColors,
): Record<
  Guest["rsvp_status"],
  { icon: string; color: string; labelTr: string; labelEn: string }
> => ({
  accepted: {
    icon: "check-circle",
    color: colors.success,
    labelTr: "Kabul",
    labelEn: "Accepted",
  },
  declined: {
    icon: "close-circle",
    color: colors.error,
    labelTr: "Red",
    labelEn: "Declined",
  },
  maybe: {
    icon: "help-circle",
    color: colors.warning,
    labelTr: "Belki",
    labelEn: "Maybe",
  },
  pending: {
    icon: "clock-outline",
    color: colors.textTertiary,
    labelTr: "Bekliyor",
    labelEn: "Pending",
  },
});

export function GuestRsvpCard({
  planId,
  guests,
  onInvite,
  onRemind,
}: GuestRsvpCardProps) {
  const { colors } = useTheme();
  const { t, i18n } = useTranslation();
  const lang = i18n.language as "tr" | "en";
  const STATUS_CONFIG = getStatusConfig(colors);
  const styles = createStyles(colors);

  const total = guests.length;
  const accepted = guests.filter((g) => g.rsvp_status === "accepted").length;
  const declined = guests.filter((g) => g.rsvp_status === "declined").length;
  const pending = guests.filter((g) => g.rsvp_status === "pending").length;
  const maybe = guests.filter((g) => g.rsvp_status === "maybe").length;

  const renderStatItem = (count: number, label: string, color: string) => (
    <View style={styles.statItem}>
      <View style={[styles.statDot, { backgroundColor: color }]} />
      <Text style={styles.statCount}>{count}</Text>
      <Text style={styles.statLabel}>{label}</Text>
    </View>
  );

  const renderGuestItem = ({ item }: { item: Guest }) => {
    const config = STATUS_CONFIG[item.rsvp_status];
    const canRemind =
      item.rsvp_status === "pending" || item.rsvp_status === "maybe";

    return (
      <View style={styles.guestItem}>
        <View style={styles.guestLeft}>
          <Icon name={config.icon as IconName} size={20} color={config.color} />
          <View style={styles.guestInfo}>
            <Text style={styles.guestName}>{item.name}</Text>
            <Text style={styles.guestEmail}>{item.email}</Text>
          </View>
        </View>

        <View style={styles.guestRight}>
          <Text style={[styles.statusLabel, { color: config.color }]}>
            {lang === "tr" ? config.labelTr : config.labelEn}
          </Text>
          {canRemind && (
            <TouchableOpacity
              style={styles.remindButton}
              onPress={() => onRemind(item.id)}
              activeOpacity={0.7}
              hitSlop={{ top: 6, bottom: 6, left: 6, right: 6 }}
            >
              <Icon name="bell-ring-outline" size={16} color={colors.primary} />
            </TouchableOpacity>
          )}
        </View>
      </View>
    );
  };

  const renderEmptyState = () => (
    <View style={styles.emptyContainer}>
      <Icon
        name="account-group-outline"
        size={48}
        color={colors.textTertiary}
      />
      <Text style={styles.emptyTitle}>{t("guests.no_guests_yet")}</Text>
      <Text style={styles.emptyDescription}>
        {t("guests.empty_surprise_desc")}
      </Text>
    </View>
  );

  return (
    <Card padding={false} style={styles.card}>
      {/* Header */}
      <View style={styles.header}>
        <View style={styles.headerLeft}>
          <Icon name="account-group" size={22} color={colors.primary} />
          <Text style={styles.headerTitle}>{t("guests.guest_list_title")}</Text>
          <View style={styles.countBadge}>
            <Text style={styles.countBadgeText}>{total}</Text>
          </View>
        </View>
        <TouchableOpacity
          style={styles.inviteButton}
          onPress={onInvite}
          activeOpacity={0.7}
        >
          <Icon name="account-plus" size={18} color={colors.textOnPrimary} />
          <Text style={styles.inviteButtonText}>
            {t("guests.invite_action")}
          </Text>
        </TouchableOpacity>
      </View>

      {/* Stats bar */}
      {total > 0 && (
        <View style={styles.statsBar}>
          {renderStatItem(accepted, t("guests.accepted"), colors.success)}
          {renderStatItem(declined, t("guests.declined_short"), colors.error)}
          {renderStatItem(maybe, t("guests.maybe"), colors.warning)}
          {renderStatItem(pending, t("guests.pending"), colors.textTertiary)}
        </View>
      )}

      {/* Guest list */}
      {total > 0 ? (
        <FlatList
          data={guests}
          renderItem={renderGuestItem}
          keyExtractor={(item) => item.id}
          scrollEnabled={false}
          ItemSeparatorComponent={() => <View style={styles.separator} />}
          contentContainerStyle={styles.listContent}
        />
      ) : (
        renderEmptyState()
      )}
    </Card>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    card: {
      marginBottom: Spacing.md,
    },
    header: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "space-between",
      padding: Spacing.md,
      borderBottomWidth: 1,
      borderBottomColor: colors.borderLight,
    },
    headerLeft: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
    },
    headerTitle: {
      ...Typography.h4,
      color: colors.text,
    },
    countBadge: {
      backgroundColor: colors.primary + "20",
      paddingHorizontal: Spacing.sm,
      paddingVertical: 2,
      borderRadius: BorderRadius.full,
    },
    countBadgeText: {
      ...Typography.caption,
      fontWeight: "700",
      color: colors.primary,
    },
    inviteButton: {
      flexDirection: "row",
      alignItems: "center",
      backgroundColor: colors.primary,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      borderRadius: BorderRadius.full,
      gap: Spacing.xs,
    },
    inviteButtonText: {
      ...Typography.buttonSmall,
      color: colors.textOnPrimary,
    },
    statsBar: {
      flexDirection: "row",
      justifyContent: "space-around",
      paddingVertical: Spacing.md,
      paddingHorizontal: Spacing.sm,
      borderBottomWidth: 1,
      borderBottomColor: colors.borderLight,
    },
    statItem: {
      alignItems: "center",
      gap: 2,
    },
    statDot: {
      width: 8,
      height: 8,
      borderRadius: 4,
      marginBottom: 2,
    },
    statCount: {
      ...Typography.h4,
      color: colors.text,
    },
    statLabel: {
      ...Typography.caption,
      color: colors.textTertiary,
    },
    listContent: {
      paddingVertical: Spacing.sm,
    },
    guestItem: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "space-between",
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
    },
    guestLeft: {
      flexDirection: "row",
      alignItems: "center",
      flex: 1,
      gap: Spacing.sm,
    },
    guestInfo: {
      flex: 1,
    },
    guestName: {
      ...Typography.bodySmall,
      fontWeight: "600",
      color: colors.text,
    },
    guestEmail: {
      ...Typography.caption,
      color: colors.textTertiary,
      marginTop: 1,
    },
    guestRight: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
    },
    statusLabel: {
      ...Typography.caption,
      fontWeight: "600",
    },
    remindButton: {
      width: 32,
      height: 32,
      borderRadius: 16,
      backgroundColor: colors.primary + "15",
      alignItems: "center",
      justifyContent: "center",
    },
    separator: {
      height: 1,
      backgroundColor: colors.borderLight,
      marginHorizontal: Spacing.md,
    },
    emptyContainer: {
      alignItems: "center",
      paddingVertical: Spacing.xl,
      paddingHorizontal: Spacing.md,
    },
    emptyTitle: {
      ...Typography.h4,
      color: colors.text,
      marginTop: Spacing.md,
      marginBottom: Spacing.xs,
    },
    emptyDescription: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
      textAlign: "center",
    },
  });
