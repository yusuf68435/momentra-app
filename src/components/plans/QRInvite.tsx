import React from "react";
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Share,
  Alert,
} from "react-native";
import * as Clipboard from "expo-clipboard";
import QRCode from "react-native-qrcode-svg";
import { Icon } from "../ui/Icon";
import { useTranslation } from "react-i18next";
import {
  type ThemeColors,
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";
import { Card } from "../ui/Card";

interface QRInviteProps {
  inviteCode: string;
  planTitle: string;
}

export function QRInvite({ inviteCode, planTitle }: QRInviteProps) {
  const { colors, isDark } = useTheme();
  const { t } = useTranslation();
  const styles = createStyles(colors);
  const inviteLink = `momentra://invite/${inviteCode}`;

  const handleShare = async () => {
    try {
      await Share.share({
        message: t("qrInvite.shareMessage", {
          title: planTitle,
          link: inviteLink,
        }),
        title: planTitle,
      });
    } catch {
      // User cancelled or share failed silently
    }
  };

  const handleCopyLink = async () => {
    try {
      await Clipboard.setStringAsync(inviteLink);
      Alert.alert(t("qrInvite.copied"), t("qrInvite.copiedMessage"));
    } catch {
      Alert.alert(t("common.error"), t("qrInvite.copyFailed"));
    }
  };

  return (
    <Card style={styles.container}>
      {/* App Branding */}
      <View style={styles.branding}>
        <Icon name="party-popper" size={24} color={colors.primary} />
        <Text style={styles.brandingText}>{t("qrInvite.appName")}</Text>
      </View>

      <Text style={styles.planTitle}>{planTitle}</Text>

      {/* QR Code */}
      <View style={styles.qrContainer}>
        <QRCode
          value={inviteLink}
          size={180}
          color="#000000"
          backgroundColor="#FFFFFF"
          quietZone={8}
        />
      </View>

      <Text style={styles.scanText}>{t("qrInvite.scanToJoin")}</Text>
      <Text style={styles.inviteCode}>{inviteCode}</Text>

      {/* Actions */}
      <View style={styles.actions}>
        <TouchableOpacity
          style={styles.shareButton}
          onPress={handleShare}
          activeOpacity={0.8}
        >
          <Icon name="share-variant" size={20} color={colors.textOnPrimary} />
          <Text style={styles.shareButtonText}>{t("qrInvite.share")}</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.copyButton}
          onPress={handleCopyLink}
          activeOpacity={0.8}
        >
          <Icon name="content-copy" size={20} color={colors.primary} />
          <Text style={styles.copyButtonText}>{t("qrInvite.copyLink")}</Text>
        </TouchableOpacity>
      </View>
    </Card>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      alignItems: "center",
      padding: Spacing.lg,
      marginBottom: Spacing.md,
    },
    branding: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginBottom: Spacing.xs,
    },
    brandingText: {
      ...Typography.h4,
      color: colors.primary,
    },
    planTitle: {
      ...Typography.h3,
      color: colors.text,
      textAlign: "center",
      marginBottom: Spacing.lg,
    },
    qrContainer: {
      padding: Spacing.sm,
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.md,
      ...Shadows.sm,
      marginBottom: Spacing.md,
    },
    scanText: {
      ...Typography.body,
      color: colors.textSecondary,
      fontWeight: "600",
    },
    inviteCode: {
      ...Typography.caption,
      color: colors.textTertiary,
      letterSpacing: 2,
      marginTop: Spacing.xs,
      marginBottom: Spacing.lg,
    },
    actions: {
      flexDirection: "row",
      gap: Spacing.sm,
      width: "100%",
    },
    shareButton: {
      flex: 1,
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      backgroundColor: colors.primary,
      borderRadius: BorderRadius.md,
      paddingVertical: Spacing.sm + 2,
      gap: Spacing.sm,
      ...Shadows.md,
    },
    shareButtonText: {
      ...Typography.button,
      color: colors.textOnPrimary,
    },
    copyButton: {
      flex: 1,
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      borderWidth: 2,
      borderColor: colors.primary,
      borderRadius: BorderRadius.md,
      paddingVertical: Spacing.sm + 2,
      gap: Spacing.sm,
    },
    copyButtonText: {
      ...Typography.button,
      color: colors.primary,
    },
  });
