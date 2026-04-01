import React, { useState, useRef } from "react";
import {
  View,
  Text,
  TouchableOpacity,
  Modal,
  StyleSheet,
  Alert,
  Linking,
  Platform,
} from "react-native";
import * as ExpoClipboard from "expo-clipboard";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";
import { useTranslation } from "react-i18next";

interface ShareButtonProps {
  onShare: () => void;
  getLink: () => string;
  lang?: "tr" | "en";
  size?: "sm" | "md";
  variant?: "icon" | "button";
  style?: object;
}

interface ShareOption {
  id: string;
  icon: string;
  labelKey: string;
  color: string;
}

const SHARE_OPTIONS: ShareOption[] = [
  {
    id: "whatsapp",
    icon: "whatsapp",
    labelKey: "share.whatsapp",
    color: "#25D366",
  },
  {
    id: "instagram",
    icon: "instagram",
    labelKey: "share.instagram",
    color: "#E4405F",
  },
  {
    id: "copy",
    icon: "content-copy",
    labelKey: "share.copy_link",
    color: "#007AFF",
  },
  {
    id: "more",
    icon: "dots-horizontal",
    labelKey: "share.more",
    color: "#8E8E93",
  },
];

export function ShareButton({
  onShare,
  getLink,
  lang,
  size = "md",
  variant = "icon",
  style,
}: ShareButtonProps) {
  const [showDropdown, setShowDropdown] = useState(false);
  const { colors } = useTheme();
  const { t } = useTranslation("common");

  const handleOption = async (optionId: string) => {
    setShowDropdown(false);
    const link = getLink();

    switch (optionId) {
      case "whatsapp": {
        const whatsappUrl = `whatsapp://send?text=${encodeURIComponent(link)}`;
        const canOpen = await Linking.canOpenURL(whatsappUrl);
        if (canOpen) {
          await Linking.openURL(whatsappUrl);
        } else {
          Alert.alert("", t("share.not_installed", { app: "WhatsApp" }));
        }
        break;
      }
      case "instagram": {
        const canOpen = await Linking.canOpenURL("instagram://");
        if (canOpen) {
          await Linking.openURL("instagram://");
        } else {
          Alert.alert("", t("share.not_installed", { app: "Instagram" }));
        }
        break;
      }
      case "copy": {
        await ExpoClipboard.setStringAsync(link);
        Alert.alert("", t("share.link_copied"));
        break;
      }
      case "more":
        onShare();
        break;
    }
  };

  const iconSize = size === "sm" ? 18 : 22;
  const buttonSize = size === "sm" ? 32 : 40;

  return (
    <>
      {variant === "icon" ? (
        <TouchableOpacity
          style={[
            styles.iconButton,
            {
              width: buttonSize,
              height: buttonSize,
              borderRadius: buttonSize / 2,
              backgroundColor: colors.primary + "12",
            },
            style,
          ]}
          onPress={() => setShowDropdown(true)}
          activeOpacity={0.7}
          accessibilityRole="button"
          accessibilityLabel={t("share.share")}
        >
          <Icon name="share-variant" size={iconSize} color={colors.primary} />
        </TouchableOpacity>
      ) : (
        <TouchableOpacity
          style={[
            styles.textButton,
            { backgroundColor: colors.primary + "12" },
            style,
          ]}
          onPress={() => setShowDropdown(true)}
          activeOpacity={0.7}
          accessibilityRole="button"
          accessibilityLabel={t("share.share")}
        >
          <Icon name="share-variant" size={18} color={colors.primary} />
          <Text style={[styles.textButtonLabel, { color: colors.primary }]}>
            {t("share.share")}
          </Text>
        </TouchableOpacity>
      )}

      {/* Dropdown Modal */}
      <Modal
        visible={showDropdown}
        transparent
        animationType="fade"
        onRequestClose={() => setShowDropdown(false)}
      >
        <TouchableOpacity
          style={styles.overlay}
          activeOpacity={1}
          onPress={() => setShowDropdown(false)}
        >
          <View style={[styles.dropdown, { backgroundColor: colors.surface }]}>
            <Text style={[styles.dropdownTitle, { color: colors.text }]}>
              {t("share.share")}
            </Text>
            <View style={styles.optionsRow}>
              {SHARE_OPTIONS.map((opt) => (
                <TouchableOpacity
                  key={opt.id}
                  style={styles.optionItem}
                  onPress={() => handleOption(opt.id)}
                  activeOpacity={0.7}
                  accessibilityRole="button"
                  accessibilityLabel={t(opt.labelKey)}
                >
                  <View
                    style={[
                      styles.optionIcon,
                      { backgroundColor: opt.color + "15" },
                    ]}
                  >
                    <Icon
                      name={opt.icon as IconName}
                      size={24}
                      color={opt.color}
                    />
                  </View>
                  <Text
                    style={[
                      styles.optionLabel,
                      { color: colors.textSecondary },
                    ]}
                  >
                    {t(opt.labelKey)}
                  </Text>
                </TouchableOpacity>
              ))}
            </View>
          </View>
        </TouchableOpacity>
      </Modal>
    </>
  );
}

const styles = StyleSheet.create({
  iconButton: {
    alignItems: "center",
    justifyContent: "center",
  },
  textButton: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.full,
  },
  textButtonLabel: {
    ...Typography.buttonSmall,
  },
  overlay: {
    flex: 1,
    backgroundColor: "rgba(0,0,0,0.4)",
    justifyContent: "flex-end",
  },
  dropdown: {
    borderTopLeftRadius: BorderRadius.xl,
    borderTopRightRadius: BorderRadius.xl,
    padding: Spacing.lg,
    paddingBottom: Spacing.xxl,
    ...Shadows.lg,
  },
  dropdownTitle: {
    ...Typography.h4,
    textAlign: "center",
    marginBottom: Spacing.lg,
  },
  optionsRow: {
    flexDirection: "row",
    justifyContent: "space-around",
  },
  optionItem: {
    alignItems: "center",
    gap: Spacing.sm,
    minWidth: 72,
  },
  optionIcon: {
    width: 52,
    height: 52,
    borderRadius: 26,
    alignItems: "center",
    justifyContent: "center",
  },
  optionLabel: {
    ...Typography.caption,
    fontWeight: "500",
  },
});
