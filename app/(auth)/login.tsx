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
import { Icon } from "../../src/components/ui/Icon";
import { SafeAreaView } from "react-native-safe-area-context";
import { Spacing, Typography, BorderRadius } from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";
import { Button } from "../../src/components/ui/Button";
import { Input } from "../../src/components/ui/Input";
import { validateEmail, getMsg } from "../../src/utils/validation";
import { useAuthStore } from "../../src/stores/authStore";
import * as authService from "../../src/services/auth";
import { supabase } from "../../src/services/supabase";
import { MomentraLogo } from "../../src/components/ui/MomentraLogo";

const MAX_LOGIN_ATTEMPTS = 5;
const LOCKOUT_DURATION_MS = 15 * 60 * 1000; // 15 minutes
const loginAttemptTracker = { count: 0, lockedUntil: 0 };

export default function LoginScreen() {
  const router = useRouter();
  const { t, i18n } = useTranslation();
  const lang = i18n.language;
  const { signIn } = useAuthStore();
  const { colors } = useTheme();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [emailError, setEmailError] = useState<string | null>(null);
  const [passwordError, setPasswordError] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);
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

  const handleEmailChange = (text: string) => {
    setEmail(text);
    if (emailError) setEmailError(null);
  };

  const handlePasswordChange = (text: string) => {
    setPassword(text);
    if (passwordError) setPasswordError(null);
  };

  const handleLogin = async () => {
    if (loginAttemptTracker.lockedUntil > Date.now()) {
      const remainingMin = Math.ceil(
        (loginAttemptTracker.lockedUntil - Date.now()) / 60000,
      );
      Alert.alert(
        t("auth.too_many_attempts_title"),
        t("auth.too_many_attempts_body", { count: remainingMin }),
      );
      return;
    }

    const eErr = getMsg(validateEmail(email), lang);
    const pErr = password ? null : t("auth.password_required");

    setEmailError(eErr);
    setPasswordError(pErr);

    if (eErr || pErr) {
      triggerShake();
      return;
    }

    setIsSubmitting(true);
    try {
      await signIn(email, password);
      loginAttemptTracker.count = 0;
      loginAttemptTracker.lockedUntil = 0;
      router.replace("/(tabs)");
    } catch (error) {
      triggerShake();
      const msg = error instanceof Error ? error.message : "";
      if (msg.includes("Invalid login credentials")) {
        loginAttemptTracker.count += 1;
        if (loginAttemptTracker.count >= MAX_LOGIN_ATTEMPTS) {
          loginAttemptTracker.lockedUntil = Date.now() + LOCKOUT_DURATION_MS;
          loginAttemptTracker.count = 0;
          Alert.alert(
            t("auth.account_locked_title"),
            t("auth.account_locked_body"),
          );
        } else {
          Alert.alert(t("auth.login_error_title"), t("auth.login_error_body"));
        }
      } else if (msg.includes("Email not confirmed")) {
        Alert.alert(
          t("auth.email_confirmation_title"),
          t("auth.email_confirmation_body"),
        );
      } else {
        if (__DEV__) {
          console.error("Login error:", msg, error);
        }
        Alert.alert(
          t("auth.error_title"),
          t("auth.login_failed_body", {
            msg: msg || t("auth.check_connection"),
          }),
        );
      }
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleForgotPassword = async () => {
    const eErr = getMsg(validateEmail(email), lang);
    if (eErr) {
      Alert.alert(
        t("auth.email_required_title"),
        t("auth.email_required_body"),
      );
      return;
    }

    try {
      await authService.resetPassword(email);
      Alert.alert(t("auth.email_sent_title"), t("auth.email_sent_body"));
    } catch {
      Alert.alert(t("auth.error_title"), t("auth.reset_failed_body"));
    }
  };

  const handleGoogleLogin = async () => {
    try {
      const { error } = await supabase.auth.signInWithOAuth({
        provider: "google",
        options: { redirectTo: "momentra://auth/callback" },
      });
      if (error) throw error;
    } catch {
      Alert.alert(t("auth.error_title"), t("auth.google_login_failed"));
    }
  };

  const handleAppleLogin = async () => {
    try {
      const { error } = await supabase.auth.signInWithOAuth({
        provider: "apple",
        options: { redirectTo: "momentra://auth/callback" },
      });
      if (error) throw error;
    } catch {
      Alert.alert(t("auth.error_title"), t("auth.apple_login_failed"));
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
        <Text style={styles.title}>{t("auth.login")}</Text>

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
          placeholder="••••••"
          value={password}
          onChangeText={handlePasswordChange}
          secureTextEntry
          error={passwordError || undefined}
        />

        <TouchableOpacity
          style={styles.forgotLink}
          onPress={handleForgotPassword}
        >
          <Text style={styles.forgotText}>{t("auth.forgot_password")}</Text>
        </TouchableOpacity>

        <Button
          title={t("auth.login")}
          onPress={handleLogin}
          fullWidth
          size="lg"
          disabled={isSubmitting}
          loading={isSubmitting}
        />

        <Text style={styles.divider}>{t("auth.or_continue_with")}</Text>

        <Button
          title={t("auth.google")}
          onPress={handleGoogleLogin}
          variant="outline"
          fullWidth
          icon={<Icon name="google" size={20} color={colors.primary} />}
          style={{ marginBottom: Spacing.md }}
        />
        <Button
          title={t("auth.apple")}
          onPress={handleAppleLogin}
          variant="outline"
          fullWidth
          icon={<Icon name="apple" size={20} color={colors.primary} />}
        />

        <TouchableOpacity
          style={styles.registerLink}
          onPress={() => router.push("/(auth)/register" as any)}
        >
          <Text style={styles.registerText}>
            {t("auth.no_account")}
            <Text style={styles.registerBold}>{t("auth.register")}</Text>
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
    forgotLink: {
      alignSelf: "flex-end",
      marginBottom: Spacing.lg,
    },
    forgotText: {
      ...Typography.bodySmall,
      color: colors.primary,
    },
    divider: {
      ...Typography.bodySmall,
      color: colors.textTertiary,
      textAlign: "center",
      marginVertical: Spacing.lg,
    },
    registerLink: {
      marginTop: Spacing.xl,
      alignItems: "center",
    },
    registerText: {
      ...Typography.body,
      color: colors.textSecondary,
    },
    registerBold: {
      color: colors.primary,
      fontWeight: "600",
    },
  });
