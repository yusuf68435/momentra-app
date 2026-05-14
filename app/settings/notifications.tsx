import React, { useState, useCallback, useMemo } from "react";
import { ScreenErrorBoundary } from "../../src/components/common/ScreenErrorBoundary";
import {
  View,
  Text,
  Alert,
  Platform,
  ScrollView,
  TouchableOpacity,
  StyleSheet,
} from "react-native";
import { Switch as ThemedSwitch } from "../../src/components/ui/Switch";
import { Icon } from "../../src/components/ui/Icon";
import type { IconName } from "../../src/constants/icons";
import { useTranslation } from "react-i18next";
import { useRouter } from "expo-router";
import * as Notifications from "expo-notifications";
import Animated, { FadeInDown, FadeInRight } from "react-native-reanimated";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";
import { useSettingsStore } from "../../src/stores/settingsStore";
import {
  registerForPushNotifications,
  cancelAllNotifications,
} from "../../src/utils/notifications";

type NotificationKey =
  | "planReminders"
  | "countdownAlerts"
  | "aiSuggestions"
  | "newScenarios"
  | "promotions"
  | "proactiveSuggestions";

interface NotificationOption {
  key: NotificationKey;
  icon: string;
  titleKey: string;
  descKey: string;
  colorKey: string;
}

const NOTIFICATION_OPTIONS: NotificationOption[] = [
  {
    key: "planReminders",
    icon: "bell-ring-outline",
    titleKey: "notifications_screen.options.planReminders.title",
    descKey: "notifications_screen.options.planReminders.desc",
    colorKey: "primary",
  },
  {
    key: "countdownAlerts",
    icon: "timer-sand",
    titleKey: "notifications_screen.options.countdownAlerts.title",
    descKey: "notifications_screen.options.countdownAlerts.desc",
    colorKey: "secondary",
  },
  {
    key: "aiSuggestions",
    icon: "robot-outline",
    titleKey: "notifications_screen.options.aiSuggestions.title",
    descKey: "notifications_screen.options.aiSuggestions.desc",
    colorKey: "accent",
  },
  {
    key: "newScenarios",
    icon: "sparkles",
    titleKey: "notifications_screen.options.newScenarios.title",
    descKey: "notifications_screen.options.newScenarios.desc",
    colorKey: "info",
  },
  {
    key: "proactiveSuggestions",
    icon: "calendar-star",
    titleKey: "notifications_screen.options.proactiveSuggestions.title",
    descKey: "notifications_screen.options.proactiveSuggestions.desc",
    colorKey: "secondary",
  },
  {
    key: "promotions",
    icon: "tag-outline",
    titleKey: "notifications_screen.options.promotions.title",
    descKey: "notifications_screen.options.promotions.desc",
    colorKey: "success",
  },
];

export default function NotificationsScreen() {
  const { t } = useTranslation("settings");
  const router = useRouter();
  const { colors, isDark } = useTheme();
  const {
    notificationsEnabled,
    notificationPreferences,
    setNotificationsEnabled,
    setNotificationPreference,
  } = useSettingsStore();

  const [permissionRequested, setPermissionRequested] = useState(false);

  const requestPermission = useCallback(async (): Promise<boolean> => {
    if (permissionRequested) return true;

    const token = await registerForPushNotifications();
    setPermissionRequested(true);

    if (!token) {
      // Check if permission was actually denied vs just token failure
      const { status } = await Notifications.getPermissionsAsync();
      if (status !== "granted") {
        Alert.alert(
          t("notifications_screen.permission_denied_title"),
          t("notifications_screen.permission_denied_message"),
          [{ text: t("notifications_screen.permission_denied_button") }],
        );
        return false;
      }
    }
    return true;
  }, [permissionRequested, t]);

  const handleMasterToggle = useCallback(
    async (value: boolean) => {
      if (value) {
        const granted = await requestPermission();
        if (!granted) return;
      } else {
        // When disabling, cancel all scheduled notifications
        await cancelAllNotifications();
      }
      setNotificationsEnabled(value);
    },
    [requestPermission, setNotificationsEnabled],
  );

  const handleToggle = useCallback(
    async (key: NotificationKey, value: boolean) => {
      if (value && !notificationsEnabled) {
        const granted = await requestPermission();
        if (!granted) return;
        setNotificationsEnabled(true);
      }
      setNotificationPreference(key, value);
    },
    [
      notificationsEnabled,
      requestPermission,
      setNotificationsEnabled,
      setNotificationPreference,
    ],
  );

  const styles = useMemo(() => createStyles(colors), [colors]);

  return (
    <ScreenErrorBoundary>
      <ScrollView
        style={styles.container}
        contentContainerStyle={styles.content}
      >
        {/* Header */}
        <Animated.View
          entering={FadeInDown.delay(100).duration(400)}
          style={styles.header}
        >
          <TouchableOpacity
            onPress={() => router.back()}
            style={styles.backButton}
          >
            <Icon name="arrow-left" size={24} color={colors.text} />
          </TouchableOpacity>
          <View style={styles.headerTextContainer}>
            <Text style={styles.headerTitle}>
              {t("notifications_screen.title")}
            </Text>
            <Text style={styles.headerSubtitle}>
              {t("notifications_screen.subtitle")}
            </Text>
          </View>
        </Animated.View>

        {/* Master Toggle */}
        <Animated.View
          entering={FadeInDown.delay(200).duration(400)}
          style={styles.masterToggle}
        >
          <View style={styles.masterIconContainer}>
            <Icon
              name={notificationsEnabled ? "bell" : "bell-off"}
              size={28}
              color={
                notificationsEnabled ? colors.primary : colors.textTertiary
              }
            />
          </View>
          <View style={styles.masterTextContainer}>
            <Text style={styles.masterTitle}>
              {t("notifications_screen.all_notifications")}
            </Text>
            <Text style={styles.masterDesc}>
              {notificationsEnabled
                ? t("notifications_screen.all_on")
                : t("notifications_screen.all_off")}
            </Text>
          </View>
          <ThemedSwitch
            value={notificationsEnabled}
            onValueChange={handleMasterToggle}
          />
        </Animated.View>

        {/* Divider */}
        <View style={styles.divider} />

        {/* Section Title */}
        <Animated.View entering={FadeInDown.delay(300).duration(400)}>
          <Text style={styles.sectionTitle}>
            {t("notifications_screen.section_title")}
          </Text>
        </Animated.View>

        {/* Individual Toggles */}
        {NOTIFICATION_OPTIONS.map((option, index) => {
          const isEnabled = notificationPreferences[option.key];
          const isDisabled = !notificationsEnabled;
          const optionColor = option.colorKey.startsWith("#")
            ? option.colorKey
            : (colors as Record<string, string>)[option.colorKey];

          return (
            <Animated.View
              key={option.key}
              entering={FadeInRight.delay(350 + index * 100)
                .duration(400)
                .springify()}
            >
              <View
                style={[
                  styles.optionRow,
                  isDisabled && styles.optionRowDisabled,
                ]}
              >
                <View
                  style={[
                    styles.optionIcon,
                    { backgroundColor: optionColor + "15" },
                  ]}
                >
                  <Icon
                    name={option.icon as IconName}
                    size={22}
                    color={isDisabled ? colors.textTertiary : optionColor}
                  />
                </View>
                <View style={styles.optionTextContainer}>
                  <Text
                    style={[
                      styles.optionTitle,
                      isDisabled && styles.optionTitleDisabled,
                    ]}
                  >
                    {t(option.titleKey)}
                  </Text>
                  <Text style={styles.optionDesc}>{t(option.descKey)}</Text>
                </View>
                <ThemedSwitch
                  value={isEnabled && notificationsEnabled}
                  onValueChange={(value) => handleToggle(option.key, value)}
                  disabled={isDisabled}
                  color={optionColor}
                />
              </View>
            </Animated.View>
          );
        })}

        {/* Footer Info */}
        <Animated.View
          entering={FadeInDown.delay(900).duration(400)}
          style={styles.footerInfo}
        >
          <Icon
            name="shield-check-outline"
            size={18}
            color={colors.textTertiary}
          />
          <Text style={styles.footerText}>
            {t("notifications_screen.footer")}
          </Text>
        </Animated.View>
      </ScrollView>
    </ScreenErrorBoundary>
  );
}

const createStyles = (
  colors: ReturnType<typeof import("../../src/constants/theme").getColors>,
) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },
    content: {
      paddingBottom: Spacing.xxl,
    },
    header: {
      flexDirection: "row",
      alignItems: "center",
      paddingHorizontal: Spacing.lg,
      paddingTop: Spacing.xxl + Spacing.md,
      paddingBottom: Spacing.md,
      gap: Spacing.md,
    },
    backButton: {
      width: 40,
      height: 40,
      borderRadius: BorderRadius.full,
      backgroundColor: colors.surfaceVariant,
      alignItems: "center",
      justifyContent: "center",
    },
    headerTextContainer: {
      flex: 1,
    },
    headerTitle: {
      ...Typography.h3,
      color: colors.text,
    },
    headerSubtitle: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
      marginTop: 2,
    },
    masterToggle: {
      flexDirection: "row",
      alignItems: "center",
      marginHorizontal: Spacing.lg,
      marginTop: Spacing.md,
      padding: Spacing.md,
      borderRadius: BorderRadius.lg,
      backgroundColor: colors.surface,
      ...Shadows.md,
      gap: Spacing.md,
    },
    masterIconContainer: {
      width: 48,
      height: 48,
      borderRadius: BorderRadius.md,
      backgroundColor: colors.primary + "12",
      alignItems: "center",
      justifyContent: "center",
    },
    masterTextContainer: {
      flex: 1,
    },
    masterTitle: {
      ...Typography.h4,
      color: colors.text,
    },
    masterDesc: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
      marginTop: 2,
    },
    divider: {
      height: 1,
      backgroundColor: colors.border,
      marginHorizontal: Spacing.lg,
      marginVertical: Spacing.lg,
    },
    sectionTitle: {
      ...Typography.bodySmall,
      fontWeight: "700",
      color: colors.textSecondary,
      textTransform: "uppercase",
      letterSpacing: 1,
      marginHorizontal: Spacing.lg,
      marginBottom: Spacing.md,
    },
    optionRow: {
      flexDirection: "row",
      alignItems: "center",
      paddingHorizontal: Spacing.lg,
      paddingVertical: Spacing.sm + 2,
      gap: Spacing.md,
    },
    optionRowDisabled: {
      opacity: 0.45,
    },
    optionIcon: {
      width: 40,
      height: 40,
      borderRadius: BorderRadius.md,
      alignItems: "center",
      justifyContent: "center",
    },
    optionTextContainer: {
      flex: 1,
    },
    optionTitle: {
      ...Typography.body,
      fontWeight: "600",
      color: colors.text,
    },
    optionTitleDisabled: {
      color: colors.textTertiary,
    },
    optionDesc: {
      ...Typography.caption,
      color: colors.textSecondary,
      marginTop: 2,
    },
    footerInfo: {
      flexDirection: "row",
      alignItems: "flex-start",
      gap: Spacing.sm,
      marginHorizontal: Spacing.lg,
      marginTop: Spacing.xl,
      padding: Spacing.md,
      borderRadius: BorderRadius.md,
      backgroundColor: colors.surfaceVariant,
    },
    footerText: {
      ...Typography.caption,
      color: colors.textTertiary,
      flex: 1,
      lineHeight: 18,
    },
  });
