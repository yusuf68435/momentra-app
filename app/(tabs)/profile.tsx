import React, { useMemo, useState, useEffect } from "react";
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  Alert,
  Platform,
  Linking,
} from "react-native";
import { useRouter } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon, type IconName } from "../../src/components/ui/Icon";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";
import { useAuthStore } from "../../src/stores/authStore";
import { useSettingsStore } from "../../src/stores/settingsStore";
import Constants from "expo-constants";
import { usePlanStore } from "../../src/stores/planStore";
import { getRemainingCredits } from "../../src/services/credits";
import { deleteAccount } from "../../src/services/auth";
import {
  hapticLight,
  hapticMedium,
  hapticWarning,
  hapticError,
} from "../../src/utils/haptics";
import { APP_CONFIG } from "../../src/constants/config";
import { a11yButton, a11ySwitch } from "../../src/utils/accessibility";
import { ScreenErrorBoundary } from "../../src/components/common/ScreenErrorBoundary";

interface SettingsRowProps {
  icon: string;
  label: string;
  value?: string;
  onPress: () => void;
  color?: string;
  colors: ThemeColors;
  destructive?: boolean;
  isLast?: boolean;
}

function SettingsRow({
  icon,
  label,
  value,
  onPress,
  color,
  colors,
  destructive,
  isLast,
}: SettingsRowProps) {
  const rowColor = destructive ? colors.error : color || colors.text;
  const iconBgColor = destructive
    ? colors.error + "12"
    : color
      ? colors.primaryLight
      : colors.backgroundSecondary;

  return (
    <>
      <TouchableOpacity
        style={rowStyles.row}
        onPress={() => {
          hapticLight();
          onPress();
        }}
        activeOpacity={0.65}
        {...a11yButton(label)}
      >
        <View
          style={[rowStyles.rowIconCircle, { backgroundColor: iconBgColor }]}
        >
          <Icon name={icon as IconName} size={18} color={rowColor} />
        </View>
        <Text
          style={[rowStyles.rowLabel, { color: rowColor }]}
          maxFontSizeMultiplier={1.3}
        >
          {label}
        </Text>
        <View style={rowStyles.rowRight}>
          {value && (
            <Text
              style={[rowStyles.rowValue, { color: colors.textTertiary }]}
              maxFontSizeMultiplier={1.2}
            >
              {value}
            </Text>
          )}
          {!destructive && (
            <Icon name="chevron-right" size={18} color={colors.textTertiary} />
          )}
        </View>
      </TouchableOpacity>
      {!isLast && (
        <View
          style={[rowStyles.divider, { backgroundColor: colors.border + "60" }]}
        />
      )}
    </>
  );
}

const rowStyles = StyleSheet.create({
  row: {
    flexDirection: "row",
    alignItems: "center",
    paddingVertical: Spacing.md - 2,
    paddingHorizontal: Spacing.md,
    gap: Spacing.md,
  },
  rowIconCircle: {
    width: 32,
    height: 32,
    borderRadius: 8,
    alignItems: "center",
    justifyContent: "center",
  },
  rowLabel: { ...Typography.body, flex: 1 },
  rowRight: { flexDirection: "row", alignItems: "center", gap: Spacing.xs },
  rowValue: { ...Typography.bodySmall },
  divider: { height: 0.5, marginLeft: 60 },
});

function ProfileScreenContent() {
  const router = useRouter();
  const { t } = useTranslation("settings");
  const { user, profile, signOut } = useAuthStore();
  const { language, subscriptionPlan } = useSettingsStore();
  const { plans, loadPlans } = usePlanStore();
  const { colors, toggleDarkMode, isDark } = useTheme();

  const [remainingCredits, setRemainingCredits] = useState<number | null>(null);

  useEffect(() => {
    if (user?.id) {
      loadPlans();
      getRemainingCredits(user.id, subscriptionPlan)
        .then(setRemainingCredits)
        .catch(() => setRemainingCredits(null));
    }
  }, [user?.id, subscriptionPlan]);

  const completedPlans = useMemo(
    () => plans.filter((p) => p.status === "completed").length,
    [plans],
  );

  const styles = useMemo(() => createStyles(colors), [colors]);

  const handleRateApp = () => {
    const iosUrl = `itms-apps://apps.apple.com/app/id${APP_CONFIG.appStoreId}?action=write-review`;
    const androidUrl = "market://details?id=com.momentra.app";
    const url = Platform.OS === "ios" ? iosUrl : androidUrl;
    Linking.openURL(url).catch(() => {
      const webUrl =
        Platform.OS === "ios"
          ? `https://apps.apple.com/app/id${APP_CONFIG.appStoreId}`
          : "https://play.google.com/store/apps/details?id=com.momentra.app";
      Linking.openURL(webUrl);
    });
  };

  const handleContactUs = () => {
    Linking.openURL("mailto:support@momentra.com?subject=Momentra%20Feedback");
  };

  const handleDeleteAccount = () => {
    hapticWarning();
    Alert.alert(
      t("common:profile.deleteAccount"),
      t("common:profile.deleteConfirm"),
      [
        { text: t("common:common.cancel"), style: "cancel" },
        {
          text: t("common:profile.deleteAccount"),
          style: "destructive",
          onPress: () => {
            Alert.alert(
              t("common:profile.finalConfirm"),
              t("common:profile.deleteWarning"),
              [
                {
                  text: t("common:common.cancel"),
                  style: "cancel",
                },
                {
                  text: t("common:profile.yesDelete"),
                  style: "destructive",
                  onPress: async () => {
                    try {
                      await deleteAccount();
                      hapticError();
                      signOut?.();
                    } catch {
                      Alert.alert(
                        t("common:common.error"),
                        t("common:profile.deleteFailed"),
                      );
                    }
                  },
                },
              ],
            );
          },
        },
      ],
    );
  };

  const handleSignOut = () => {
    hapticMedium();
    Alert.alert(
      t("common:profile.signOut"),
      t("common:profile.signOutConfirm"),
      [
        { text: t("common:common.cancel"), style: "cancel" },
        {
          text: t("common:profile.signOut"),
          onPress: () => signOut?.(),
        },
      ],
    );
  };

  const tierLabel =
    subscriptionPlan === "free"
      ? "Free"
      : subscriptionPlan === "plus"
        ? "Plus"
        : "Pro";

  return (
    <ScrollView style={styles.container} showsVerticalScrollIndicator={false}>
      {/* Profile Header — clean, flat background */}
      <View style={styles.profileHeader}>
        <View style={styles.avatarContainer}>
          <TouchableOpacity
            style={[styles.avatar, { backgroundColor: colors.surface }]}
            onPress={() => {
              hapticLight();
              router.push("/settings/profile-edit");
            }}
            activeOpacity={0.8}
            {...a11yButton(t("common:profile.editProfile"))}
          >
            <Icon name="account" size={38} color={colors.primary} />
          </TouchableOpacity>
        </View>
        <Text
          style={[styles.displayName, { color: colors.text }]}
          maxFontSizeMultiplier={1.3}
        >
          {profile?.display_name || t("common:profile.guestUser")}
        </Text>
        <Text
          style={[styles.email, { color: colors.textSecondary }]}
          maxFontSizeMultiplier={1.2}
        >
          {user?.email || t("common:profile.notSignedIn")}
        </Text>
        {!user && (
          <TouchableOpacity
            style={[styles.loginButton, { backgroundColor: colors.primary }]}
            onPress={() => {
              hapticMedium();
              router.push("/(auth)/login" as never);
            }}
            activeOpacity={0.8}
            {...a11yButton(t("common:auth.login"))}
          >
            <Text style={styles.loginText} maxFontSizeMultiplier={1.2}>
              {t("common:auth.login")}
            </Text>
          </TouchableOpacity>
        )}
      </View>

      {/* Stats Row */}
      <View style={styles.statsRow}>
        <View style={styles.statItem}>
          <Text
            style={[styles.statValue, { color: colors.text }]}
            maxFontSizeMultiplier={1.2}
          >
            {plans.length}
          </Text>
          <Text
            style={[styles.statLabel, { color: colors.textTertiary }]}
            maxFontSizeMultiplier={1.1}
          >
            {t("common:profile.plans")}
          </Text>
        </View>
        <View
          style={[styles.statDivider, { backgroundColor: colors.border }]}
        />
        <View style={styles.statItem}>
          <Text
            style={[styles.statValue, { color: colors.text }]}
            maxFontSizeMultiplier={1.2}
          >
            {completedPlans}
          </Text>
          <Text
            style={[styles.statLabel, { color: colors.textTertiary }]}
            maxFontSizeMultiplier={1.1}
          >
            {t("common:profile.completed")}
          </Text>
        </View>
        <View
          style={[styles.statDivider, { backgroundColor: colors.border }]}
        />
        <View style={styles.statItem}>
          <Text
            style={[styles.statValue, { color: colors.text }]}
            maxFontSizeMultiplier={1.2}
          >
            {remainingCredits === null
              ? "-"
              : remainingCredits === Infinity
                ? "\u221E"
                : remainingCredits}
          </Text>
          <Text
            style={[styles.statLabel, { color: colors.textTertiary }]}
            maxFontSizeMultiplier={1.1}
          >
            {t("common:profile.aiCredits")}
          </Text>
        </View>
        <View
          style={[styles.statDivider, { backgroundColor: colors.border }]}
        />
        <View style={styles.statItem}>
          <Text
            style={[styles.statValue, { color: colors.text }]}
            maxFontSizeMultiplier={1.2}
          >
            {tierLabel}
          </Text>
          <Text
            style={[styles.statLabel, { color: colors.textTertiary }]}
            maxFontSizeMultiplier={1.1}
          >
            {t("common:profile.tier")}
          </Text>
        </View>
      </View>

      {/* Upgrade Row (free users) */}
      {subscriptionPlan === "free" && (
        <View style={styles.section}>
          <View style={styles.sectionCard}>
            <SettingsRow
              icon="crown"
              label={t("common:profile.upgradeToPro")}
              onPress={() => router.push("/settings/subscription")}
              color={colors.primary}
              colors={colors}
              isLast
            />
          </View>
        </View>
      )}

      {/* Settings */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle} maxFontSizeMultiplier={1.1}>
          {t("title")}
        </Text>
        <View style={styles.sectionCard}>
          {user && (
            <SettingsRow
              icon="account-edit"
              label={t("common:profile.editProfile")}
              onPress={() => router.push("/settings/profile-edit")}
              colors={colors}
            />
          )}
          <SettingsRow
            icon="translate"
            label={t("language")}
            value={language === "tr" ? "T\u00FCrk\u00E7e" : "English"}
            onPress={() => router.push("/settings/language")}
            colors={colors}
          />
          <SettingsRow
            icon="bell-outline"
            label={t("notifications")}
            onPress={() => router.push("/settings/notifications")}
            colors={colors}
          />

          {/* Dark mode toggle */}
          <TouchableOpacity
            style={rowStyles.row}
            onPress={() => {
              hapticLight();
              toggleDarkMode();
            }}
            activeOpacity={0.65}
            {...a11ySwitch(t("common:profile.darkMode"), isDark)}
          >
            <View
              style={[
                rowStyles.rowIconCircle,
                { backgroundColor: colors.backgroundSecondary },
              ]}
            >
              <Icon
                name={
                  (isDark ? "weather-night" : "white-balance-sunny") as IconName
                }
                size={18}
                color={colors.text}
              />
            </View>
            <Text
              style={[rowStyles.rowLabel, { color: colors.text }]}
              maxFontSizeMultiplier={1.3}
            >
              {t("common:profile.darkMode")}
            </Text>
            <Icon
              name={
                (isDark
                  ? "toggle-switch"
                  : "toggle-switch-off-outline") as IconName
              }
              size={36}
              color={isDark ? colors.primary : colors.textTertiary}
            />
          </TouchableOpacity>
          <View
            style={[
              rowStyles.divider,
              { backgroundColor: colors.border + "60" },
            ]}
          />

          <SettingsRow
            icon="incognito"
            label={t("common:profile.stealthMode")}
            onPress={() => router.push("/settings/stealth")}
            colors={colors}
          />
          <SettingsRow
            icon="crown"
            label={t("subscription")}
            value={tierLabel}
            onPress={() => router.push("/settings/subscription")}
            color={colors.accent}
            colors={colors}
            isLast
          />
        </View>
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle} maxFontSizeMultiplier={1.1}>
          {t("about")}
        </Text>
        <View style={styles.sectionCard}>
          <SettingsRow
            icon="shield-check"
            label={t("privacy_policy")}
            onPress={() => router.push("/settings/privacy")}
            colors={colors}
          />
          <SettingsRow
            icon="file-document-outline"
            label={t("terms")}
            onPress={() => router.push("/settings/terms")}
            colors={colors}
          />
          <SettingsRow
            icon="star-outline"
            label={t("rate_app")}
            onPress={handleRateApp}
            colors={colors}
          />
          <SettingsRow
            icon="email-outline"
            label={t("contact_us")}
            onPress={handleContactUs}
            colors={colors}
            isLast
          />
        </View>
      </View>

      {user && (
        <View style={styles.section}>
          <Text style={styles.sectionTitle} maxFontSizeMultiplier={1.1}>
            {t("common:profile.account")}
          </Text>
          <View style={styles.sectionCard}>
            <SettingsRow
              icon="logout"
              label={t("common:profile.signOut")}
              onPress={handleSignOut}
              colors={colors}
            />
            <SettingsRow
              icon="delete-forever"
              label={t("common:profile.deleteAccount")}
              onPress={handleDeleteAccount}
              colors={colors}
              destructive
              isLast
            />
          </View>
        </View>
      )}

      <Text
        style={[styles.version, { color: colors.textTertiary }]}
        maxFontSizeMultiplier={1.1}
      >
        {t("version")} {Constants.expoConfig?.version ?? "1.0.0"}
      </Text>
      <View style={{ height: Spacing.xxl + 20 }} />
    </ScrollView>
  );
}

export default function ProfileScreen() {
  return (
    <ScreenErrorBoundary>
      <ProfileScreenContent />
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: { flex: 1, backgroundColor: colors.backgroundSecondary },
    profileHeader: {
      alignItems: "center",
      paddingTop: Spacing.xl + 4,
      paddingBottom: Spacing.xl,
      backgroundColor: colors.backgroundSecondary,
    },
    avatarContainer: {
      width: 80,
      height: 80,
      alignItems: "center",
      justifyContent: "center",
      marginBottom: Spacing.md,
    },
    avatar: {
      width: 80,
      height: 80,
      borderRadius: 40,
      alignItems: "center",
      justifyContent: "center",
      ...Shadows.sm,
    },
    displayName: {
      ...Typography.h2,
    },
    email: {
      ...Typography.bodySmall,
      marginTop: Spacing.xs,
    },
    loginButton: {
      marginTop: Spacing.md,
      paddingHorizontal: Spacing.xl,
      paddingVertical: Spacing.sm + 2,
      borderRadius: BorderRadius.full,
    },
    loginText: {
      ...Typography.button,
      color: colors.textOnPrimary,
    },
    statsRow: {
      flexDirection: "row",
      backgroundColor: colors.surface,
      marginHorizontal: Spacing.lg,
      marginTop: Spacing.sm,
      borderRadius: BorderRadius.lg,
      padding: Spacing.md + 2,
      ...Shadows.sm,
    },
    statItem: { flex: 1, alignItems: "center" },
    statValue: { ...Typography.h3 },
    statLabel: {
      ...Typography.caption,
      marginTop: 3,
    },
    statDivider: { width: 0.5 },
    section: { paddingHorizontal: Spacing.lg, paddingTop: Spacing.lg },
    sectionTitle: {
      ...Typography.caption,
      color: colors.textTertiary,
      fontWeight: "600",
      textTransform: "uppercase",
      letterSpacing: 1,
      marginBottom: Spacing.sm,
      marginLeft: Spacing.xs,
    },
    sectionCard: {
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      overflow: "hidden",
    },
    version: {
      ...Typography.caption,
      textAlign: "center",
      marginTop: Spacing.xl,
    },
  });
