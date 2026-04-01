import React, { useState, useCallback, useMemo, useEffect } from "react";
import {
  View,
  Text,
  FlatList,
  StyleSheet,
  TouchableOpacity,
  TextInput,
  Modal,
  Alert,
  KeyboardAvoidingView,
  Platform,
  ScrollView,
  Share,
  ActivityIndicator,
} from "react-native";
import { LoadingScreen } from "../../../src/components/common/LoadingScreen";
import QRCode from "react-native-qrcode-svg";
import * as Clipboard from "expo-clipboard";
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
import {
  getGuests,
  inviteGuest,
  removeGuest,
  sendReminder,
  generateInviteLink,
  getGuestStats,
  type Guest,
  type RsvpStatus,
} from "../../../src/services/guestRsvp";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";
import { EmptyState } from "../../../src/components/common/EmptyState";

type FilterStatus = "all" | RsvpStatus;

const STATUS_CONFIG: Record<RsvpStatus, { icon: string }> = {
  pending: { icon: "clock-outline" },
  accepted: { icon: "check-circle" },
  declined: { icon: "close-circle" },
  maybe: { icon: "help-circle-outline" },
};

export default function GuestsScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const { t } = useTranslation();
  const { colors } = useTheme();

  const [guests, setGuests] = useState<Guest[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [filterStatus, setFilterStatus] = useState<FilterStatus>("all");
  const [showInviteModal, setShowInviteModal] = useState(false);
  const [newName, setNewName] = useState("");
  const [newEmail, setNewEmail] = useState("");
  const [newPhone, setNewPhone] = useState("");
  const [isSaving, setIsSaving] = useState(false);
  const [showLinkModal, setShowLinkModal] = useState(false);
  const [inviteLink, setInviteLink] = useState<string | null>(null);
  const [isGeneratingLink, setIsGeneratingLink] = useState(false);
  const [remindingGuestIds, setRemindingGuestIds] = useState<Set<string>>(new Set());

  useEffect(() => {
    if (!id) return;
    setIsLoading(true);
    getGuests(id)
      .then(setGuests)
      .catch((err) => {
        if (__DEV__) console.warn("Failed to load guests:", err);
      })
      .finally(() => setIsLoading(false));
  }, [id]);

  const stats = useMemo(() => getGuestStats(guests), [guests]);

  const filteredGuests = useMemo(() => {
    if (filterStatus === "all") return guests;
    return guests.filter((g) => g.rsvp_status === filterStatus);
  }, [guests, filterStatus]);

  const getStatusColor = useCallback(
    (status: RsvpStatus) => {
      switch (status) {
        case "accepted":
          return colors.success;
        case "declined":
          return colors.error;
        case "maybe":
          return colors.accent ?? colors.primary;
        case "pending":
          return colors.warning;
      }
    },
    [colors],
  );

  const handleInvite = useCallback(async () => {
    if (!id || !newName.trim()) return;
    setIsSaving(true);
    try {
      const guest = await inviteGuest(id, {
        name: newName.trim(),
        email: newEmail.trim() || undefined,
        phone: newPhone.trim() || undefined,
      });
      setGuests((prev) => [...prev, guest]);
      setShowInviteModal(false);
      setNewName("");
      setNewEmail("");
      setNewPhone("");
    } catch (err) {
      if (__DEV__) console.warn("Failed to invite guest:", err);
      Alert.alert(t("guests.error_title"), t("guests.add_guest_error"));
    } finally {
      setIsSaving(false);
    }
  }, [id, newName, newEmail, newPhone, t]);

  const handleDelete = useCallback(
    (guestId: string, guestName: string) => {
      Alert.alert(
        t("guests.remove_guest_title"),
        t("guests.remove_guest_confirm", { name: guestName }),
        [
          { text: t("common.cancel"), style: "cancel" },
          {
            text: t("guests.remove"),
            style: "destructive",
            onPress: async () => {
              try {
                await removeGuest(guestId);
                setGuests((prev) => prev.filter((g) => g.id !== guestId));
              } catch (err) {
                if (__DEV__) console.warn("Failed to remove guest:", err);
                Alert.alert(
                  t("guests.error_title"),
                  t("guests.remove_guest_error"),
                );
              }
            },
          },
        ],
      );
    },
    [t],
  );

  const handleRemind = useCallback(
    async (guestId: string, guestName: string) => {
      if (remindingGuestIds.has(guestId)) return;
      setRemindingGuestIds((prev) => new Set(prev).add(guestId));
      try {
        await sendReminder(guestId);
        Alert.alert(
          t("guests.reminder_sent_title"),
          t("guests.reminder_sent_message", { name: guestName }),
        );
      } catch (err) {
        if (__DEV__) console.warn("Failed to send reminder:", err);
        Alert.alert(t("guests.error_title"), t("guests.reminder_error"));
      } finally {
        setRemindingGuestIds((prev) => {
          const next = new Set(prev);
          next.delete(guestId);
          return next;
        });
      }
    },
    [t, remindingGuestIds],
  );

  const handleGenerateLink = useCallback(async () => {
    if (!id) return;
    setIsGeneratingLink(true);
    setShowLinkModal(true);
    try {
      const link = await generateInviteLink(id);
      setInviteLink(
        link ?? `momentra://invite/${id.slice(0, 8).toUpperCase()}`,
      );
    } catch {
      setInviteLink(`momentra://invite/${id.slice(0, 8).toUpperCase()}`);
    } finally {
      setIsGeneratingLink(false);
    }
  }, [id]);

  const handleCopyLink = useCallback(async () => {
    if (!inviteLink) return;
    await Clipboard.setStringAsync(inviteLink);
    Alert.alert(t("guests.copied_title"), t("guests.copied_message"));
  }, [inviteLink, t]);

  const handleShareLink = useCallback(async () => {
    if (!inviteLink) return;
    await Share.share({
      message: t("guests.share_message", { link: inviteLink }),
      title: t("guests.share_title"),
    });
  }, [inviteLink, t]);

  const styles = useMemo(() => createStyles(colors), [colors]);

  const filterTabs: { key: FilterStatus; label: string }[] = [
    { key: "all", label: t("guests.filter_all") },
    { key: "accepted", label: t("guests.filter_accepted") },
    { key: "declined", label: t("guests.filter_declined") },
    { key: "maybe", label: t("guests.filter_maybe") },
    { key: "pending", label: t("guests.filter_pending") },
  ];

  const renderGuest = useCallback(
    ({ item }: { item: Guest }) => {
      const statusColor = getStatusColor(item.rsvp_status);
      const cfg = STATUS_CONFIG[item.rsvp_status];
      const invitedDate = item.created_at.split("T")[0];
      return (
        <View style={styles.guestCard}>
          <View style={styles.guestInfo}>
            <View
              style={[
                styles.guestAvatar,
                { backgroundColor: statusColor + "20" },
              ]}
            >
              <Text style={[styles.guestAvatarText, { color: statusColor }]}>
                {item.name.charAt(0).toUpperCase()}
              </Text>
            </View>
            <View style={styles.guestDetails}>
              <Text style={[styles.guestName, { color: colors.text }]}>
                {item.name}
              </Text>
              <Text style={[styles.guestDate, { color: colors.textTertiary }]}>
                {t("guests.invited_label")}
                {invitedDate}
              </Text>
            </View>
          </View>
          <View style={styles.guestActions}>
            <View
              style={[
                styles.statusBadge,
                { backgroundColor: statusColor + "15" },
              ]}
            >
              <Icon name={cfg.icon as IconName} size={14} color={statusColor} />
              <Text style={[styles.statusText, { color: statusColor }]}>
                {t(`guests.status_${item.rsvp_status}`)}
              </Text>
            </View>
            <View style={styles.actionButtons}>
              {item.rsvp_status === "pending" && (
                <TouchableOpacity
                  style={[
                    styles.actionBtn,
                    {
                      backgroundColor: remindingGuestIds.has(item.id)
                        ? colors.borderLight
                        : colors.info + "15",
                    },
                  ]}
                  onPress={() => handleRemind(item.id, item.name)}
                  disabled={remindingGuestIds.has(item.id)}
                >
                  {remindingGuestIds.has(item.id) ? (
                    <ActivityIndicator size="small" color={colors.info} />
                  ) : (
                    <Icon
                      name="bell-ring-outline"
                      size={18}
                      color={colors.info}
                    />
                  )}
                </TouchableOpacity>
              )}
              <TouchableOpacity
                style={[
                  styles.actionBtn,
                  { backgroundColor: colors.error + "15" },
                ]}
                onPress={() => handleDelete(item.id, item.name)}
              >
                <Icon name="trash-can-outline" size={18} color={colors.error} />
              </TouchableOpacity>
            </View>
          </View>
        </View>
      );
    },
    [styles, colors, t, getStatusColor, handleDelete, handleRemind],
  );

  if (isLoading) {
    return <LoadingScreen />;
  }

  return (
    <ScreenErrorBoundary>
      <View style={styles.container}>
        {/* Stats Row */}
        <View style={styles.statsRow}>
          {[
            {
              label: t("guests.total"),
              value: stats.total,
              color: colors.primary,
            },
            {
              label: t("guests.accepted"),
              value: stats.accepted,
              color: colors.success,
            },
            {
              label: t("guests.declined_short"),
              value: stats.declined,
              color: colors.error,
            },
            {
              label: t("guests.pending"),
              value: stats.pending,
              color: colors.warning,
            },
          ].map((stat) => (
            <View
              key={stat.label}
              style={[styles.statCard, { backgroundColor: stat.color + "10" }]}
            >
              <Text style={[styles.statValue, { color: stat.color }]}>
                {stat.value}
              </Text>
              <Text style={[styles.statLabel, { color: stat.color }]}>
                {stat.label}
              </Text>
            </View>
          ))}
        </View>

        {/* Invite Button */}
        <TouchableOpacity
          style={[styles.inviteButton, { backgroundColor: colors.primary }]}
          onPress={() => setShowInviteModal(true)}
          activeOpacity={0.8}
        >
          <Icon name="account-plus" size={20} color={colors.textOnPrimary} />
          <Text
            style={[styles.inviteButtonText, { color: colors.textOnPrimary }]}
          >
            {t("guests.invite")}
          </Text>
        </TouchableOpacity>

        {/* Invite Link Button */}
        <TouchableOpacity
          style={[
            styles.linkButton,
            {
              borderColor: colors.primary + "40",
              backgroundColor: colors.primary + "08",
            },
          ]}
          onPress={handleGenerateLink}
          activeOpacity={0.8}
        >
          <Icon name="link-variant" size={18} color={colors.primary} />
          <Text style={[styles.linkButtonText, { color: colors.primary }]}>
            {t("guests.create_qr_link")}
          </Text>
        </TouchableOpacity>

        {/* Filter Tabs */}
        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
          style={styles.filterRow}
          contentContainerStyle={styles.filterContent}
        >
          {filterTabs.map((tab) => (
            <TouchableOpacity
              key={tab.key}
              style={[
                styles.filterTab,
                {
                  backgroundColor:
                    filterStatus === tab.key
                      ? colors.primary
                      : colors.surfaceVariant,
                },
              ]}
              onPress={() => setFilterStatus(tab.key)}
            >
              <Text
                style={[
                  styles.filterTabText,
                  {
                    color:
                      filterStatus === tab.key
                        ? colors.textOnPrimary
                        : colors.textSecondary,
                  },
                ]}
              >
                {tab.label}
              </Text>
            </TouchableOpacity>
          ))}
        </ScrollView>

        {/* Guest List */}
        <FlatList
          data={filteredGuests}
          keyExtractor={(item) => item.id}
          renderItem={renderGuest}
          contentContainerStyle={styles.list}
          showsVerticalScrollIndicator={false}
          ListEmptyComponent={
            <EmptyState
              emoji="👥"
              title={t("guests.empty_title")}
              description={t("guests.empty_desc")}
              compact
            />
          }
        />

        {/* QR Invite Link Modal */}
        <Modal visible={showLinkModal} animationType="slide" transparent>
          <View style={styles.modalOverlay}>
            <View
              style={[styles.modalContent, { backgroundColor: colors.surface }]}
            >
              <View style={styles.modalHeader}>
                <Text style={[styles.modalTitle, { color: colors.text }]}>
                  {t("guests.invite_link_title")}
                </Text>
                <TouchableOpacity onPress={() => setShowLinkModal(false)}>
                  <Icon name="close" size={24} color={colors.text} />
                </TouchableOpacity>
              </View>

              <View style={styles.qrSection}>
                {isGeneratingLink ? (
                  <View style={styles.qrPlaceholderLoading}>
                    <Text style={{ color: colors.textTertiary, fontSize: 13 }}>
                      {t("guests.generating")}
                    </Text>
                  </View>
                ) : (
                  <View
                    style={{
                      backgroundColor: "#FFFFFF",
                      padding: Spacing.sm,
                      borderRadius: BorderRadius.md,
                    }}
                  >
                    <QRCode
                      value={inviteLink || "momentra://invite"}
                      size={120}
                      backgroundColor="white"
                      color="#000000"
                    />
                  </View>
                )}
                <Text style={[styles.qrHint, { color: colors.textTertiary }]}>
                  {t("guests.qr_hint")}
                </Text>
              </View>

              {inviteLink && (
                <View
                  style={[
                    styles.linkBox,
                    {
                      backgroundColor: colors.surfaceVariant,
                      borderColor: colors.borderLight,
                    },
                  ]}
                >
                  <Text
                    style={[styles.linkText, { color: colors.text }]}
                    numberOfLines={2}
                    selectable
                  >
                    {inviteLink}
                  </Text>
                </View>
              )}

              <View style={styles.linkActions}>
                <TouchableOpacity
                  style={[
                    styles.linkActionBtn,
                    {
                      backgroundColor: colors.primary + "15",
                      borderColor: colors.primary + "30",
                    },
                  ]}
                  onPress={handleCopyLink}
                  disabled={!inviteLink}
                >
                  <Icon name="content-copy" size={18} color={colors.primary} />
                  <Text
                    style={[styles.linkActionText, { color: colors.primary }]}
                  >
                    {t("guests.copy")}
                  </Text>
                </TouchableOpacity>
                <TouchableOpacity
                  style={[
                    styles.linkActionBtn,
                    {
                      backgroundColor: colors.success + "15",
                      borderColor: colors.success + "30",
                    },
                  ]}
                  onPress={handleShareLink}
                  disabled={!inviteLink}
                >
                  <Icon name="share-variant" size={18} color={colors.success} />
                  <Text
                    style={[styles.linkActionText, { color: colors.success }]}
                  >
                    {t("common.share")}
                  </Text>
                </TouchableOpacity>
              </View>
            </View>
          </View>
        </Modal>

        {/* Invite Modal */}
        <Modal visible={showInviteModal} animationType="slide" transparent>
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
                    {t("guests.invite")}
                  </Text>
                  <TouchableOpacity onPress={() => setShowInviteModal(false)}>
                    <Icon name="close" size={24} color={colors.text} />
                  </TouchableOpacity>
                </View>

                <View style={styles.inputGroup}>
                  <Text
                    style={[styles.inputLabel, { color: colors.textSecondary }]}
                  >
                    {t("guests.name_label")}
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
                    value={newName}
                    onChangeText={setNewName}
                    placeholder={t("guests.name_placeholder")}
                    placeholderTextColor={colors.textTertiary}
                  />
                </View>

                <View style={styles.inputGroup}>
                  <Text
                    style={[styles.inputLabel, { color: colors.textSecondary }]}
                  >
                    {t("guests.email")}
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
                    value={newEmail}
                    onChangeText={setNewEmail}
                    placeholder="email@example.com"
                    placeholderTextColor={colors.textTertiary}
                    keyboardType="email-address"
                    autoCapitalize="none"
                  />
                </View>

                <View style={styles.inputGroup}>
                  <Text
                    style={[styles.inputLabel, { color: colors.textSecondary }]}
                  >
                    {t("guests.phone")}
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
                    value={newPhone}
                    onChangeText={setNewPhone}
                    placeholder="+90 555 123 4567"
                    placeholderTextColor={colors.textTertiary}
                    keyboardType="phone-pad"
                  />
                </View>

                <TouchableOpacity
                  style={[
                    styles.saveButton,
                    {
                      backgroundColor:
                        newName.trim() && !isSaving
                          ? colors.primary
                          : colors.borderLight,
                    },
                  ]}
                  onPress={handleInvite}
                  disabled={!newName.trim() || isSaving}
                >
                  {isSaving ? (
                    <ActivityIndicator color={colors.textOnPrimary} />
                  ) : (
                    <Text
                      style={[
                        styles.saveButtonText,
                        { color: colors.textOnPrimary },
                      ]}
                    >
                      {t("guests.send_invite")}
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
    statsRow: {
      flexDirection: "row",
      paddingHorizontal: Spacing.lg,
      paddingTop: Spacing.lg,
      gap: Spacing.sm,
    },
    statCard: {
      flex: 1,
      alignItems: "center",
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
    },
    statValue: { ...Typography.h3, fontWeight: "700" },
    statLabel: { ...Typography.caption, fontWeight: "500", marginTop: 2 },
    inviteButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      marginHorizontal: Spacing.lg,
      marginTop: Spacing.lg,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
    },
    inviteButtonText: { ...Typography.button },
    filterRow: { marginTop: Spacing.md, maxHeight: 48 },
    filterContent: { paddingHorizontal: Spacing.lg, gap: Spacing.sm },
    filterTab: {
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      borderRadius: BorderRadius.full,
    },
    filterTabText: { ...Typography.buttonSmall },
    list: {
      paddingHorizontal: Spacing.lg,
      paddingTop: Spacing.md,
      paddingBottom: Spacing.xxl,
    },
    guestCard: {
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      padding: Spacing.md,
      marginBottom: Spacing.sm,
      borderWidth: 1,
      borderColor: colors.borderLight,
    },
    guestInfo: { flexDirection: "row", alignItems: "center", gap: Spacing.md },
    guestAvatar: {
      width: 42,
      height: 42,
      borderRadius: 21,
      alignItems: "center",
      justifyContent: "center",
    },
    guestAvatarText: { ...Typography.body, fontWeight: "700" },
    guestDetails: { flex: 1 },
    guestName: { ...Typography.body, fontWeight: "600" },
    guestDate: { ...Typography.caption, marginTop: 2 },
    guestActions: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      marginTop: Spacing.sm,
    },
    statusBadge: {
      flexDirection: "row",
      alignItems: "center",
      gap: 4,
      paddingHorizontal: Spacing.sm,
      paddingVertical: Spacing.xs,
      borderRadius: BorderRadius.full,
    },
    statusText: { ...Typography.caption, fontWeight: "600" },
    actionButtons: { flexDirection: "row", gap: Spacing.sm },
    actionBtn: {
      width: 36,
      height: 36,
      borderRadius: 18,
      alignItems: "center",
      justifyContent: "center",
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
    saveButton: {
      alignItems: "center",
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
      marginTop: Spacing.sm,
    },
    saveButtonText: { ...Typography.button },
    linkButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      marginHorizontal: Spacing.lg,
      marginTop: Spacing.sm,
      paddingVertical: Spacing.md - 2,
      borderRadius: BorderRadius.md,
      borderWidth: 1,
    },
    linkButtonText: { ...Typography.buttonSmall, fontWeight: "600" },
    qrSection: {
      alignItems: "center",
      paddingVertical: Spacing.lg,
      gap: Spacing.sm,
    },
    qrPlaceholderLoading: {
      width: 120,
      height: 120,
      borderRadius: 8,
      backgroundColor: colors.surfaceVariant,
      alignItems: "center",
      justifyContent: "center",
    },
    qrHint: { ...Typography.caption, textAlign: "center" },
    linkBox: {
      borderRadius: BorderRadius.md,
      borderWidth: 1,
      padding: Spacing.md,
      marginBottom: Spacing.md,
    },
    linkText: { ...Typography.bodySmall, fontFamily: "monospace" },
    linkActions: { flexDirection: "row", gap: Spacing.md },
    linkActionBtn: {
      flex: 1,
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      paddingVertical: Spacing.md - 2,
      borderRadius: BorderRadius.md,
      borderWidth: 1,
    },
    linkActionText: { ...Typography.buttonSmall, fontWeight: "600" },
  });
