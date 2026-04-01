import React, { useState, useEffect, useMemo } from "react";
import {
  View,
  Text,
  ScrollView,
  TouchableOpacity,
  StyleSheet,
  Alert,
  TextInput,
} from "react-native";
import { ScreenErrorBoundary } from "../../src/components/common/ScreenErrorBoundary";
import { useRouter } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon } from "../../src/components/ui/Icon";
import type { IconName } from "../../src/constants/icons";
import Animated, { FadeInDown } from "react-native-reanimated";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";
import {
  getStealthConfig,
  setStealthConfig,
  isBiometricAvailable,
  setPinCode,
  hasPinCode,
  removePinCode,
} from "../../src/utils/stealthMode";

export default function StealthModeScreen() {
  const router = useRouter();
  const { t } = useTranslation();
  const { colors } = useTheme();

  const styles = useMemo(() => createStyles(colors), [colors]);

  const [isEnabled, setIsEnabled] = useState(false);
  const [requireAuth, setRequireAuth] = useState(false);
  const [hideNotifications, setHideNotifications] = useState(false);
  const [biometricType, setBiometricType] = useState<string>("none");
  const [hasPIN, setHasPIN] = useState(false);
  const [showPinSetup, setShowPinSetup] = useState(false);
  const [pin, setPin] = useState("");
  const [confirmPin, setConfirmPin] = useState("");

  useEffect(() => {
    loadConfig();
  }, []);

  const loadConfig = async () => {
    const config = await getStealthConfig();
    setIsEnabled(config.isEnabled);
    setRequireAuth(config.requireAuth);
    setHideNotifications(config.hideNotificationContent);

    const bio = await isBiometricAvailable();
    setBiometricType(bio.type);

    const pinSet = await hasPinCode();
    setHasPIN(pinSet);
  };

  const toggleStealth = async (value: boolean) => {
    setIsEnabled(value);
    await setStealthConfig({ isEnabled: value });
  };

  const toggleAuth = async (value: boolean) => {
    if (value && !hasPIN && biometricType === "none") {
      setShowPinSetup(true);
      return;
    }
    setRequireAuth(value);
    await setStealthConfig({ requireAuth: value });
  };

  const toggleHideNotifications = async (value: boolean) => {
    setHideNotifications(value);
    await setStealthConfig({ hideNotificationContent: value });
  };

  const handleSetPin = async () => {
    if (pin.length < 4) {
      Alert.alert(t("common.error"), t("stealth.pin_min_length"));
      return;
    }
    if (pin !== confirmPin) {
      Alert.alert(t("common.error"), t("stealth.pin_mismatch"));
      return;
    }

    await setPinCode(pin);
    setHasPIN(true);
    setShowPinSetup(false);
    setRequireAuth(true);
    await setStealthConfig({ requireAuth: true });
    setPin("");
    setConfirmPin("");
  };

  const handleRemovePin = async () => {
    Alert.alert(
      t("stealth.remove_pin_title"),
      t("stealth.remove_pin_confirm"),
      [
        { text: t("common.cancel"), style: "cancel" },
        {
          text: t("stealth.remove"),
          style: "destructive",
          onPress: async () => {
            await removePinCode();
            setHasPIN(false);
            if (biometricType === "none") {
              setRequireAuth(false);
              await setStealthConfig({ requireAuth: false });
            }
          },
        },
      ],
    );
  };

  const renderToggle = (value: boolean, onToggle: (v: boolean) => void) => (
    <TouchableOpacity
      style={[styles.toggle, value && styles.toggleActive]}
      onPress={() => onToggle(!value)}
    >
      <View style={[styles.toggleCircle, value && styles.toggleCircleActive]} />
    </TouchableOpacity>
  );

  return (
    <ScreenErrorBoundary>
      <ScrollView
        style={styles.container}
        contentContainerStyle={styles.content}
      >
        {/* Hero Banner */}
        <Animated.View
          entering={FadeInDown.duration(300)}
          style={styles.heroBanner}
        >
          <Text style={styles.heroEmoji}>🕵️</Text>
          <Text style={styles.heroTitle}>{t("stealth.title")}</Text>
          <Text style={styles.heroDesc}>{t("stealth.hero_desc")}</Text>
        </Animated.View>

        {/* Enable Stealth */}
        <Animated.View
          entering={FadeInDown.duration(300).delay(50)}
          style={styles.settingCard}
        >
          <View style={styles.settingRow}>
            <View style={styles.settingLeft}>
              <View
                style={[
                  styles.settingIcon,
                  { backgroundColor: colors.primary + "15" },
                ]}
              >
                <Icon name="shield-lock" size={22} color={colors.primary} />
              </View>
              <View style={styles.settingTextGroup}>
                <Text style={styles.settingTitle}>
                  {t("stealth.enable_title")}
                </Text>
                <Text style={styles.settingDesc}>
                  {t("stealth.enable_desc")}
                </Text>
              </View>
            </View>
            {renderToggle(isEnabled, toggleStealth)}
          </View>
        </Animated.View>

        {isEnabled && (
          <>
            {/* App Lock */}
            <Animated.View
              entering={FadeInDown.duration(300).delay(100)}
              style={styles.settingCard}
            >
              <View style={styles.settingRow}>
                <View style={styles.settingLeft}>
                  <View
                    style={[
                      styles.settingIcon,
                      { backgroundColor: colors.info + "15" },
                    ]}
                  >
                    <Icon
                      name={
                        (biometricType === "facial"
                          ? "face-recognition"
                          : biometricType === "fingerprint"
                            ? "fingerprint"
                            : "lock") as IconName
                      }
                      size={22}
                      color={colors.info}
                    />
                  </View>
                  <View style={styles.settingTextGroup}>
                    <Text style={styles.settingTitle}>
                      {t("stealth.app_lock_title")}
                    </Text>
                    <Text style={styles.settingDesc}>
                      {biometricType !== "none"
                        ? t("stealth.bio_or_pin_lock", {
                            bio:
                              biometricType === "facial"
                                ? t("stealth.face_id")
                                : t("stealth.fingerprint"),
                          })
                        : t("stealth.pin_lock")}
                    </Text>
                  </View>
                </View>
                {renderToggle(requireAuth, toggleAuth)}
              </View>

              {/* PIN Status */}
              {requireAuth && (
                <View style={styles.pinStatus}>
                  {hasPIN ? (
                    <View style={styles.pinRow}>
                      <View style={styles.pinBadge}>
                        <Icon
                          name="check-circle"
                          size={16}
                          color={colors.success}
                        />
                        <Text style={styles.pinBadgeText}>
                          {t("stealth.pin_set")}
                        </Text>
                      </View>
                      <TouchableOpacity onPress={() => setShowPinSetup(true)}>
                        <Text style={styles.changePinText}>
                          {t("stealth.change")}
                        </Text>
                      </TouchableOpacity>
                      <TouchableOpacity onPress={handleRemovePin}>
                        <Text style={styles.removePinText}>
                          {t("stealth.remove")}
                        </Text>
                      </TouchableOpacity>
                    </View>
                  ) : (
                    <TouchableOpacity
                      style={styles.setPinBtn}
                      onPress={() => setShowPinSetup(true)}
                    >
                      <Icon name="plus" size={18} color={colors.primary} />
                      <Text style={styles.setPinText}>
                        {t("stealth.set_pin")}
                      </Text>
                    </TouchableOpacity>
                  )}
                </View>
              )}
            </Animated.View>

            {/* PIN Setup Modal Inline */}
            {showPinSetup && (
              <Animated.View
                entering={FadeInDown.duration(200)}
                style={styles.pinSetupCard}
              >
                <Text style={styles.pinSetupTitle}>
                  {t("stealth.set_pin_title")}
                </Text>
                <TextInput
                  style={styles.pinInput}
                  value={pin}
                  onChangeText={setPin}
                  placeholder={t("stealth.pin_placeholder")}
                  placeholderTextColor={colors.textTertiary}
                  keyboardType="numeric"
                  secureTextEntry
                  maxLength={6}
                />
                <TextInput
                  style={styles.pinInput}
                  value={confirmPin}
                  onChangeText={setConfirmPin}
                  placeholder={t("stealth.confirm_pin_placeholder")}
                  placeholderTextColor={colors.textTertiary}
                  keyboardType="numeric"
                  secureTextEntry
                  maxLength={6}
                />
                <View style={styles.pinActions}>
                  <TouchableOpacity
                    style={styles.pinCancelBtn}
                    onPress={() => {
                      setShowPinSetup(false);
                      setPin("");
                      setConfirmPin("");
                    }}
                  >
                    <Text style={styles.pinCancelText}>
                      {t("common.cancel")}
                    </Text>
                  </TouchableOpacity>
                  <TouchableOpacity
                    style={styles.pinSaveBtn}
                    onPress={handleSetPin}
                  >
                    <Text style={styles.pinSaveText}>{t("common.save")}</Text>
                  </TouchableOpacity>
                </View>
              </Animated.View>
            )}

            {/* Hide Notifications */}
            <Animated.View
              entering={FadeInDown.duration(300).delay(150)}
              style={styles.settingCard}
            >
              <View style={styles.settingRow}>
                <View style={styles.settingLeft}>
                  <View
                    style={[
                      styles.settingIcon,
                      { backgroundColor: colors.warning + "15" },
                    ]}
                  >
                    <Icon name="bell-off" size={22} color={colors.warning} />
                  </View>
                  <View style={styles.settingTextGroup}>
                    <Text style={styles.settingTitle}>
                      {t("stealth.hide_notif_title")}
                    </Text>
                    <Text style={styles.settingDesc}>
                      {t("stealth.hide_notif_desc")}
                    </Text>
                  </View>
                </View>
                {renderToggle(hideNotifications, toggleHideNotifications)}
              </View>
            </Animated.View>

            {/* Tips */}
            <Animated.View
              entering={FadeInDown.duration(300).delay(200)}
              style={styles.tipsCard}
            >
              <Text style={styles.tipsTitle}>{t("stealth.tips_title")}</Text>
              {[
                t("stealth.tip1"),
                t("stealth.tip2"),
                t("stealth.tip3"),
                t("stealth.tip4"),
              ].map((tip, i) => (
                <View key={i} style={styles.tipRow}>
                  <Text style={styles.tipBullet}>•</Text>
                  <Text style={styles.tipText}>{tip}</Text>
                </View>
              ))}
            </Animated.View>
          </>
        )}
      </ScrollView>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: { flex: 1, backgroundColor: colors.background },
    content: { padding: Spacing.lg, paddingBottom: Spacing.xxl },
    heroBanner: {
      alignItems: "center",
      paddingVertical: Spacing.xl,
      marginBottom: Spacing.lg,
    },
    heroEmoji: { fontSize: 48, marginBottom: Spacing.sm },
    heroTitle: {
      ...Typography.h2,
      color: colors.text,
      marginBottom: Spacing.xs,
    },
    heroDesc: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
      textAlign: "center",
      lineHeight: 20,
    },
    settingCard: {
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      padding: Spacing.md,
      marginBottom: Spacing.md,
      borderWidth: 1,
      borderColor: colors.borderLight,
      ...Shadows.sm,
    },
    settingRow: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "space-between",
    },
    settingLeft: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.md,
      flex: 1,
    },
    settingIcon: {
      width: 40,
      height: 40,
      borderRadius: 12,
      alignItems: "center",
      justifyContent: "center",
    },
    settingTextGroup: { flex: 1 },
    settingTitle: {
      ...Typography.bodySmall,
      fontWeight: "600",
      color: colors.text,
    },
    settingDesc: {
      ...Typography.caption,
      color: colors.textTertiary,
      marginTop: 2,
    },
    toggle: {
      width: 52,
      height: 30,
      borderRadius: 15,
      backgroundColor: colors.surfaceVariant,
      padding: 3,
      justifyContent: "center",
    },
    toggleActive: { backgroundColor: colors.primary },
    toggleCircle: {
      width: 24,
      height: 24,
      borderRadius: 12,
      backgroundColor: "#FFF",
      ...Shadows.sm,
    },
    toggleCircleActive: { alignSelf: "flex-end" },
    pinStatus: {
      marginTop: Spacing.md,
      paddingTop: Spacing.sm,
      borderTopWidth: 1,
      borderTopColor: colors.borderLight,
    },
    pinRow: { flexDirection: "row", alignItems: "center", gap: Spacing.md },
    pinBadge: { flexDirection: "row", alignItems: "center", gap: 4, flex: 1 },
    pinBadgeText: {
      ...Typography.caption,
      color: colors.success,
      fontWeight: "500",
    },
    changePinText: {
      ...Typography.caption,
      color: colors.primary,
      fontWeight: "600",
    },
    removePinText: {
      ...Typography.caption,
      color: colors.error,
      fontWeight: "600",
    },
    setPinBtn: { flexDirection: "row", alignItems: "center", gap: Spacing.sm },
    setPinText: {
      ...Typography.bodySmall,
      color: colors.primary,
      fontWeight: "600",
    },
    pinSetupCard: {
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      padding: Spacing.lg,
      marginBottom: Spacing.md,
      borderWidth: 2,
      borderColor: colors.primary + "30",
    },
    pinSetupTitle: {
      ...Typography.h4,
      color: colors.text,
      marginBottom: Spacing.md,
    },
    pinInput: {
      ...Typography.body,
      backgroundColor: colors.surfaceVariant,
      borderRadius: BorderRadius.md,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.md - 2,
      color: colors.text,
      borderWidth: 1,
      borderColor: colors.borderLight,
      marginBottom: Spacing.sm,
      textAlign: "center",
      fontSize: 20,
      letterSpacing: 8,
    },
    pinActions: {
      flexDirection: "row",
      gap: Spacing.md,
      marginTop: Spacing.sm,
    },
    pinCancelBtn: {
      flex: 1,
      paddingVertical: Spacing.md - 2,
      borderRadius: BorderRadius.md,
      alignItems: "center",
      backgroundColor: colors.surfaceVariant,
    },
    pinCancelText: { ...Typography.buttonSmall, color: colors.textSecondary },
    pinSaveBtn: {
      flex: 1,
      paddingVertical: Spacing.md - 2,
      borderRadius: BorderRadius.md,
      alignItems: "center",
      backgroundColor: colors.primary,
    },
    pinSaveText: { ...Typography.buttonSmall, color: colors.textOnPrimary },
    tipsCard: {
      backgroundColor: colors.info + "08",
      borderRadius: BorderRadius.lg,
      padding: Spacing.md,
      borderWidth: 1,
      borderColor: colors.info + "20",
    },
    tipsTitle: {
      ...Typography.bodySmall,
      fontWeight: "600",
      color: colors.info,
      marginBottom: Spacing.sm,
    },
    tipRow: { flexDirection: "row", gap: Spacing.sm, marginBottom: 4 },
    tipBullet: { ...Typography.bodySmall, color: colors.info },
    tipText: { ...Typography.caption, color: colors.textSecondary, flex: 1 },
  });
