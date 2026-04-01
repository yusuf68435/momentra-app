import React, { useState, useRef, useMemo } from "react";
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Animated,
  Alert,
} from "react-native";
import { useRouter } from "expo-router";
import { useTranslation } from "react-i18next";
import { SafeAreaView } from "react-native-safe-area-context";
import { Icon } from "../../src/components/ui/Icon";
import type { IconName } from "../../src/constants/icons";
import { Spacing, Typography, BorderRadius } from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";
import { Button } from "../../src/components/ui/Button";
import { Input } from "../../src/components/ui/Input";
import {
  validateEmail,
  validatePassword,
  validatePasswordMatch,
  validateRequired,
  getPasswordStrength,
  getPasswordStrengthColor,
  getMsg,
} from "../../src/utils/validation";
import { useAuthStore } from "../../src/stores/authStore";
import { MomentraLogo } from "../../src/components/ui/MomentraLogo";

export default function RegisterScreen() {
  const router = useRouter();
  const { t, i18n } = useTranslation();
  const lang = i18n.language;
  const { signUp } = useAuthStore();
  const { colors } = useTheme();

  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [termsAccepted, setTermsAccepted] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const [nameError, setNameError] = useState<string | null>(null);
  const [emailError, setEmailError] = useState<string | null>(null);
  const [passwordError, setPasswordError] = useState<string | null>(null);
  const [confirmError, setConfirmError] = useState<string | null>(null);
  const [termsError, setTermsError] = useState<string | null>(null);

  const shakeAnim = useRef(new Animated.Value(0)).current;

  const triggerShake = () => {
    Animated.sequence([
      Animated.timing(shakeAnim, {
        toValue: 10,
        duration: 50,
        useNativeDriver: true,
      }),
      Animated.timing(shakeAnim, {
        toValue: -10,
        duration: 50,
        useNativeDriver: true,
      }),
      Animated.timing(shakeAnim, {
        toValue: 10,
        duration: 50,
        useNativeDriver: true,
      }),
      Animated.timing(shakeAnim, {
        toValue: -10,
        duration: 50,
        useNativeDriver: true,
      }),
      Animated.timing(shakeAnim, {
        toValue: 0,
        duration: 50,
        useNativeDriver: true,
      }),
    ]).start();
  };

  const STRENGTH_I18N_KEYS: Record<string, string> = {
    weak: "auth.strength_weak",
    medium: "auth.strength_medium",
    strong: "auth.strength_strong",
  };

  const strength = getPasswordStrength(password);
  const strengthColor = getPasswordStrengthColor(strength);
  const strengthWidths: Record<string, string> = {
    weak: "33%",
    medium: "66%",
    strong: "100%",
  };

  const handleNameChange = (text: string) => {
    setName(text);
    if (nameError) setNameError(null);
  };
  const handleEmailChange = (text: string) => {
    setEmail(text);
    if (emailError) setEmailError(null);
  };
  const handlePasswordChange = (text: string) => {
    setPassword(text);
    if (passwordError) setPasswordError(null);
  };
  const handleConfirmChange = (text: string) => {
    setConfirmPassword(text);
    if (confirmError) setConfirmError(null);
  };

  const handleRegister = async () => {
    const nErr = getMsg(
      validateRequired(name, { tr: "Ad Soyad", en: "Full name" }),
      lang,
    );
    const eErr = getMsg(validateEmail(email), lang);
    const pErr = getMsg(validatePassword(password), lang);
    const cErr = getMsg(validatePasswordMatch(password, confirmPassword), lang);
    const tErr = !termsAccepted ? t("auth.terms_required") : null;

    setNameError(nErr);
    setEmailError(eErr);
    setPasswordError(pErr);
    setConfirmError(cErr);
    setTermsError(tErr);

    if (nErr || eErr || pErr || cErr || tErr) {
      triggerShake();
      return;
    }

    setIsSubmitting(true);
    try {
      await signUp(email, password, name);
      Alert.alert(
        t("auth.register_success_title"),
        t("auth.register_success_body"),
        [
          {
            text: t("auth.ok"),
            onPress: () => router.replace("/(auth)/login" as any),
          },
        ],
      );
    } catch (error: any) {
      triggerShake();
      const msg = error?.message || "";
      if (
        msg.includes("already registered") ||
        msg.includes("already exists")
      ) {
        Alert.alert(t("auth.error_title"), t("auth.email_already_registered"));
      } else {
        if (__DEV__) {
          console.error("Registration error:", msg, error);
        }
        Alert.alert(
          t("auth.error_title"),
          t("auth.register_failed_body", {
            msg: msg || t("auth.check_connection"),
          }),
        );
      }
    } finally {
      setIsSubmitting(false);
    }
  };

  const styles = useMemo(() => createStyles(colors), [colors]);

  return (
    <SafeAreaView style={styles.container}>
      <Animated.View
        style={[styles.content, { transform: [{ translateX: shakeAnim }] }]}
      >
        <View style={styles.logoContainer}>
          <MomentraLogo size={72} />
        </View>
        <Text style={styles.title}>{t("auth.register")}</Text>

        <Input
          label={t("auth.full_name_label")}
          placeholder={t("auth.full_name_placeholder")}
          value={name}
          onChangeText={handleNameChange}
          error={nameError || undefined}
        />
        <Input
          label={t("auth.email")}
          placeholder="ornek@email.com"
          value={email}
          onChangeText={handleEmailChange}
          keyboardType="email-address"
          autoCapitalize="none"
          error={emailError || undefined}
        />
        <Input
          label={t("auth.password")}
          placeholder={t("auth.password_placeholder")}
          value={password}
          onChangeText={handlePasswordChange}
          secureTextEntry
          error={passwordError || undefined}
        />

        {/* Password strength indicator */}
        {password.length > 0 && (
          <View style={styles.strengthContainer}>
            <View style={styles.strengthBarBg}>
              <View
                style={[
                  styles.strengthBarFill,
                  {
                    width: strengthWidths[strength] as any,
                    backgroundColor: strengthColor,
                  },
                ]}
              />
            </View>
            <Text style={[styles.strengthText, { color: strengthColor }]}>
              {t(STRENGTH_I18N_KEYS[strength])}
            </Text>
          </View>
        )}

        <Input
          label={t("auth.confirm_password")}
          placeholder={t("auth.confirm_password_placeholder")}
          value={confirmPassword}
          onChangeText={handleConfirmChange}
          secureTextEntry
          error={confirmError || undefined}
        />

        {/* Terms checkbox */}
        <TouchableOpacity
          style={styles.termsRow}
          onPress={() => {
            setTermsAccepted(!termsAccepted);
            if (termsError) setTermsError(null);
          }}
          activeOpacity={0.7}
        >
          <Icon
            name={
              (termsAccepted
                ? "checkbox-marked"
                : "checkbox-blank-outline") as IconName
            }
            size={24}
            color={
              termsError
                ? colors.error
                : termsAccepted
                  ? colors.primary
                  : colors.textTertiary
            }
          />
          <Text style={styles.termsText}>{t("auth.terms_accept")}</Text>
        </TouchableOpacity>
        {termsError && (
          <Text
            style={styles.errorText}
            accessibilityRole="alert"
            accessibilityLiveRegion="assertive"
          >
            {termsError}
          </Text>
        )}

        <Button
          title={t("auth.register")}
          onPress={handleRegister}
          fullWidth
          size="lg"
          disabled={isSubmitting}
          loading={isSubmitting}
          style={{ marginTop: Spacing.md }}
        />

        <TouchableOpacity
          style={styles.loginLink}
          onPress={() => router.back()}
        >
          <Text style={styles.loginText}>
            {t("auth.already_have_account")}
            <Text style={styles.loginBold}>{t("auth.login")}</Text>
          </Text>
        </TouchableOpacity>
      </Animated.View>
    </SafeAreaView>
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
      flex: 1,
      paddingHorizontal: Spacing.lg,
      justifyContent: "center",
    },
    logoContainer: {
      alignItems: "center",
      marginBottom: Spacing.md,
    },
    title: {
      ...Typography.h3,
      color: colors.text,
      textAlign: "center",
      marginBottom: Spacing.xl,
    },
    strengthContainer: {
      flexDirection: "row",
      alignItems: "center",
      marginTop: -Spacing.sm,
      marginBottom: Spacing.md,
      gap: Spacing.sm,
    },
    strengthBarBg: {
      flex: 1,
      height: 6,
      backgroundColor: colors.borderLight,
      borderRadius: 3,
      overflow: "hidden",
    },
    strengthBarFill: {
      height: "100%",
      borderRadius: 3,
    },
    strengthText: {
      ...Typography.caption,
      fontWeight: "600",
      minWidth: 40,
    },
    termsRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginBottom: Spacing.xs,
    },
    termsText: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
      flex: 1,
    },
    errorText: {
      ...Typography.caption,
      color: colors.error,
      marginBottom: Spacing.sm,
    },
    loginLink: {
      marginTop: Spacing.xl,
      alignItems: "center",
    },
    loginText: {
      ...Typography.body,
      color: colors.textSecondary,
    },
    loginBold: {
      color: colors.primary,
      fontWeight: "600",
    },
  });
