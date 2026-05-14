import React, { useEffect, useState, useCallback } from "react";
import { ScreenErrorBoundary } from "../../src/components/common/ScreenErrorBoundary";
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  ActivityIndicator,
} from "react-native";
import { useRouter, useLocalSearchParams } from "expo-router";
import { Icon, type IconName } from "../../src/components/ui/Icon";
import Animated, { FadeInDown, FadeInUp } from "react-native-reanimated";

import { useCoOrganizerStore } from "../../src/stores/coOrganizerStore";
import { useAuthStore } from "../../src/stores/authStore";
import { useSettingsStore } from "../../src/stores/settingsStore";
import { useTheme } from "../../src/contexts/ThemeContext";
import {
  Spacing,
  BorderRadius,
  Typography,
  Shadows,
} from "../../src/constants/theme";
import type {
  InviteLinkDetails,
  InviteErrorCode,
} from "../../src/services/coOrganizer";
import * as coOrganizerService from "../../src/services/coOrganizer";

type ScreenState = "loading" | "preview" | "accepting" | "success" | "error";

const TEXTS = {
  tr: {
    loading: "Davet kontrol ediliyor...",
    inviteTitle: "Plana Davet Edildiniz",
    invitedBy: "Davet eden",
    role: "Rol",
    roleOrganizer: "Organizatör",
    roleHelper: "Yardımcı",
    expiresAt: "Son geçerlilik",
    accept: "Daveti Kabul Et",
    decline: "Reddet",
    accepting: "Kabul ediliyor...",
    successTitle: "Katıldınız!",
    successMessage: "plana başarıyla katıldınız.",
    goToPlan: "Plana Git",
    errorExpired: "Bu davet linkinin süresi dolmuş.",
    errorInvalid: "Bu davet kodu geçerli değil.",
    errorAlreadyUsed: "Bu davet linki artık aktif değil.",
    errorAlreadyMember: "Zaten bu planın bir üyesisiniz.",
    errorNetwork: "Bağlantı hatası. Lütfen internet bağlantınızı kontrol edin.",
    errorUnknown: "Bir hata oluştu. Lütfen tekrar deneyin.",
    retry: "Tekrar Dene",
    goBack: "Geri Dön",
    loginRequired: "Daveti kabul etmek için giriş yapmanız gerekiyor.",
    loginButton: "Giriş Yap",
  },
  en: {
    loading: "Checking invite...",
    inviteTitle: "You're Invited to a Plan",
    invitedBy: "Invited by",
    role: "Role",
    roleOrganizer: "Organizer",
    roleHelper: "Helper",
    expiresAt: "Expires",
    accept: "Accept Invite",
    decline: "Decline",
    accepting: "Accepting...",
    successTitle: "You Joined!",
    successMessage: "You successfully joined the plan.",
    goToPlan: "Go to Plan",
    errorExpired: "This invite link has expired.",
    errorInvalid: "This invite code is not valid.",
    errorAlreadyUsed: "This invite link is no longer active.",
    errorAlreadyMember: "You are already a member of this plan.",
    errorNetwork: "Connection error. Please check your internet.",
    errorUnknown: "Something went wrong. Please try again.",
    retry: "Try Again",
    goBack: "Go Back",
    loginRequired: "You need to sign in to accept this invite.",
    loginButton: "Sign In",
  },
} as const;

function getErrorMessage(
  code: InviteErrorCode,
  t: (typeof TEXTS)["tr"] | (typeof TEXTS)["en"],
): string {
  switch (code) {
    case "expired":
      return t.errorExpired;
    case "invalid":
      return t.errorInvalid;
    case "already_used":
      return t.errorAlreadyUsed;
    case "already_member":
      return t.errorAlreadyMember;
    case "network":
      return t.errorNetwork;
    default:
      return t.errorUnknown;
  }
}

function getErrorIcon(code: InviteErrorCode): IconName {
  switch (code) {
    case "expired":
      return "clock-alert-outline";
    case "invalid":
      return "link-off";
    case "already_used":
      return "check-circle-outline";
    case "already_member":
      return "account-check-outline";
    case "network":
      return "wifi-off";
    default:
      return "alert-circle-outline";
  }
}

function formatDate(isoDate: string, lang: "tr" | "en"): string {
  const date = new Date(isoDate);
  return date.toLocaleDateString(lang === "tr" ? "tr-TR" : "en-US", {
    day: "numeric",
    month: "long",
    year: "numeric",
  });
}

export default function InviteScreen() {
  const { code } = useLocalSearchParams<{ code: string }>();
  const router = useRouter();
  const { colors, isDark } = useTheme();
  const language = useSettingsStore((s) => s.language);
  const isAuthenticated = useAuthStore((s) => s.isAuthenticated);
  const isAuthLoading = useAuthStore((s) => s.isLoading);
  const { acceptInvite } = useCoOrganizerStore();

  const t = TEXTS[language === "tr" ? "tr" : "en"];

  const [screenState, setScreenState] = useState<ScreenState>("loading");
  const [inviteDetails, setInviteDetails] = useState<InviteLinkDetails | null>(
    null,
  );
  const [errorCode, setErrorCode] = useState<InviteErrorCode | null>(null);
  const [acceptedPlanId, setAcceptedPlanId] = useState<string | null>(null);

  const validateInvite = useCallback(async () => {
    if (!code) {
      setErrorCode("invalid");
      setScreenState("error");
      return;
    }

    setScreenState("loading");
    setErrorCode(null);

    try {
      const details = await coOrganizerService.validateInviteLink(code);
      setInviteDetails(details);
      setScreenState("preview");
    } catch (err) {
      setErrorCode((err as { code?: InviteErrorCode })?.code ?? "unknown");
      setScreenState("error");
    }
  }, [code]);

  useEffect(() => {
    if (!isAuthLoading) {
      validateInvite();
    }
  }, [isAuthLoading, validateInvite]);

  const handleAccept = useCallback(async () => {
    if (!code || !isAuthenticated) return;

    setScreenState("accepting");
    try {
      const success = await acceptInvite(code);
      if (success) {
        setAcceptedPlanId(inviteDetails?.planId || null);
        setScreenState("success");
      } else {
        setErrorCode("unknown");
        setScreenState("error");
      }
    } catch {
      setErrorCode("unknown");
      setScreenState("error");
    }
  }, [code, isAuthenticated, acceptInvite, inviteDetails]);

  const handleDecline = useCallback(() => {
    if (router.canGoBack()) {
      router.back();
    } else {
      router.replace("/(tabs)");
    }
  }, [router]);

  const handleGoToPlan = useCallback(() => {
    if (acceptedPlanId) {
      router.replace(`/plan/${acceptedPlanId}`);
    } else {
      router.replace("/(tabs)");
    }
  }, [acceptedPlanId, router]);

  const handleLogin = useCallback(() => {
    router.push("/(auth)/login" as any);
  }, [router]);

  const handleRetry = useCallback(() => {
    validateInvite();
  }, [validateInvite]);

  const handleGoBack = useCallback(() => {
    if (router.canGoBack()) {
      router.back();
    } else {
      router.replace("/(tabs)");
    }
  }, [router]);

  // -- Loading State --
  if (screenState === "loading") {
    return (
      <View style={[styles.container, { backgroundColor: colors.background }]}>
        <Animated.View
          entering={FadeInDown.duration(400)}
          style={[
            styles.card,
            { backgroundColor: colors.surface },
            isDark && styles.cardDark,
          ]}
        >
          <ActivityIndicator size="large" color={colors.primary} />
          <Text style={[styles.loadingText, { color: colors.textSecondary }]}>
            {t.loading}
          </Text>
        </Animated.View>
      </View>
    );
  }

  // -- Login Required --
  if (!isAuthenticated && screenState === "preview") {
    return (
      <View style={[styles.container, { backgroundColor: colors.background }]}>
        <Animated.View
          entering={FadeInDown.duration(400)}
          style={[
            styles.card,
            { backgroundColor: colors.surface },
            isDark && styles.cardDark,
          ]}
        >
          <View
            style={[
              styles.iconCircle,
              { backgroundColor: colors.primary + "15" },
            ]}
          >
            <Icon name="login" size={40} color={colors.primary} />
          </View>
          <Text style={[styles.title, { color: colors.text }]}>
            {t.loginRequired}
          </Text>
          {inviteDetails && (
            <View
              style={[
                styles.planBadge,
                { backgroundColor: colors.primary + "10" },
              ]}
            >
              <Icon name="party-popper" size={16} color={colors.primary} />
              <Text style={[styles.planBadgeText, { color: colors.primary }]}>
                {inviteDetails.planName}
              </Text>
            </View>
          )}
          <TouchableOpacity
            style={[styles.primaryButton, { backgroundColor: colors.primary }]}
            onPress={handleLogin}
            activeOpacity={0.8}
          >
            <Icon name="login" size={20} color={colors.textOnPrimary} />
            <Text
              style={[
                styles.primaryButtonText,
                { color: colors.textOnPrimary },
              ]}
            >
              {t.loginButton}
            </Text>
          </TouchableOpacity>
          <TouchableOpacity
            style={[styles.secondaryButton, { borderColor: colors.border }]}
            onPress={handleGoBack}
            activeOpacity={0.7}
          >
            <Text
              style={[
                styles.secondaryButtonText,
                { color: colors.textSecondary },
              ]}
            >
              {t.goBack}
            </Text>
          </TouchableOpacity>
        </Animated.View>
      </View>
    );
  }

  // -- Error State --
  if (screenState === "error" && errorCode) {
    const canRetry = errorCode === "network" || errorCode === "unknown";
    return (
      <View style={[styles.container, { backgroundColor: colors.background }]}>
        <Animated.View
          entering={FadeInDown.duration(400)}
          style={[
            styles.card,
            { backgroundColor: colors.surface },
            isDark && styles.cardDark,
          ]}
        >
          <View
            style={[
              styles.iconCircle,
              { backgroundColor: colors.error + "15" },
            ]}
          >
            <Icon
              name={getErrorIcon(errorCode)}
              size={40}
              color={colors.error}
            />
          </View>
          <Text style={[styles.title, { color: colors.text }]}>
            {getErrorMessage(errorCode, t)}
          </Text>
          {canRetry ? (
            <TouchableOpacity
              style={[
                styles.primaryButton,
                { backgroundColor: colors.primary },
              ]}
              onPress={handleRetry}
              activeOpacity={0.8}
            >
              <Icon name="refresh" size={20} color={colors.textOnPrimary} />
              <Text
                style={[
                  styles.primaryButtonText,
                  { color: colors.textOnPrimary },
                ]}
              >
                {t.retry}
              </Text>
            </TouchableOpacity>
          ) : null}
          <TouchableOpacity
            style={[styles.secondaryButton, { borderColor: colors.border }]}
            onPress={handleGoBack}
            activeOpacity={0.7}
          >
            <Text
              style={[
                styles.secondaryButtonText,
                { color: colors.textSecondary },
              ]}
            >
              {t.goBack}
            </Text>
          </TouchableOpacity>
        </Animated.View>
      </View>
    );
  }

  // -- Success State --
  if (screenState === "success") {
    return (
      <View style={[styles.container, { backgroundColor: colors.background }]}>
        <Animated.View
          entering={FadeInDown.duration(500)}
          style={[
            styles.card,
            { backgroundColor: colors.surface },
            isDark && styles.cardDark,
          ]}
        >
          <View
            style={[
              styles.iconCircle,
              { backgroundColor: colors.success + "15" },
            ]}
          >
            <Icon name="check-circle" size={48} color={colors.success} />
          </View>
          <Text style={[styles.title, { color: colors.text }]}>
            {t.successTitle}
          </Text>
          <Text style={[styles.subtitle, { color: colors.textSecondary }]}>
            {inviteDetails?.planName
              ? `"${inviteDetails.planName}" ${t.successMessage}`
              : t.successMessage}
          </Text>
          <TouchableOpacity
            style={[styles.primaryButton, { backgroundColor: colors.primary }]}
            onPress={handleGoToPlan}
            activeOpacity={0.8}
          >
            <Icon name="arrow-right" size={20} color={colors.textOnPrimary} />
            <Text
              style={[
                styles.primaryButtonText,
                { color: colors.textOnPrimary },
              ]}
            >
              {t.goToPlan}
            </Text>
          </TouchableOpacity>
        </Animated.View>
      </View>
    );
  }

  // -- Preview / Accept State --
  return (
    <ScreenErrorBoundary>
      <View style={[styles.container, { backgroundColor: colors.background }]}>
        <Animated.View
          entering={FadeInDown.duration(500)}
          style={[
            styles.card,
            { backgroundColor: colors.surface },
            isDark && styles.cardDark,
          ]}
        >
          {/* Invite Icon */}
          <Animated.View entering={FadeInUp.delay(100).duration(400)}>
            <View
              style={[
                styles.iconCircle,
                { backgroundColor: colors.primary + "15" },
              ]}
            >
              <Text style={styles.inviteEmoji}>{"✉️"}</Text>
            </View>
          </Animated.View>

          {/* Title */}
          <Text style={[styles.title, { color: colors.text }]}>
            {t.inviteTitle}
          </Text>

          {/* Plan Name Badge */}
          {inviteDetails && (
            <Animated.View entering={FadeInDown.delay(200).duration(400)}>
              <View
                style={[
                  styles.planBadge,
                  { backgroundColor: colors.primary + "10" },
                ]}
              >
                <Icon name="party-popper" size={18} color={colors.primary} />
                <Text
                  style={[styles.planName, { color: colors.text }]}
                  numberOfLines={2}
                >
                  {inviteDetails.planName}
                </Text>
              </View>
            </Animated.View>
          )}

          {/* Details */}
          {inviteDetails && (
            <Animated.View
              entering={FadeInDown.delay(300).duration(400)}
              style={[styles.detailsContainer, { borderColor: colors.border }]}
            >
              {/* Inviter */}
              <View style={styles.detailRow}>
                <Icon
                  name="account-outline"
                  size={20}
                  color={colors.textSecondary}
                />
                <Text
                  style={[styles.detailLabel, { color: colors.textSecondary }]}
                >
                  {t.invitedBy}
                </Text>
                <Text style={[styles.detailValue, { color: colors.text }]}>
                  {inviteDetails.inviterName}
                </Text>
              </View>

              {/* Role */}
              <View
                style={[
                  styles.detailDivider,
                  { backgroundColor: colors.border },
                ]}
              />
              <View style={styles.detailRow}>
                <Icon
                  name="shield-account-outline"
                  size={20}
                  color={colors.textSecondary}
                />
                <Text
                  style={[styles.detailLabel, { color: colors.textSecondary }]}
                >
                  {t.role}
                </Text>
                <View
                  style={[
                    styles.roleBadge,
                    { backgroundColor: colors.info + "15" },
                  ]}
                >
                  <Text style={[styles.roleBadgeText, { color: colors.info }]}>
                    {inviteDetails.role === "organizer"
                      ? t.roleOrganizer
                      : t.roleHelper}
                  </Text>
                </View>
              </View>

              {/* Expiry */}
              <View
                style={[
                  styles.detailDivider,
                  { backgroundColor: colors.border },
                ]}
              />
              <View style={styles.detailRow}>
                <Icon
                  name="calendar-clock"
                  size={20}
                  color={colors.textSecondary}
                />
                <Text
                  style={[styles.detailLabel, { color: colors.textSecondary }]}
                >
                  {t.expiresAt}
                </Text>
                <Text style={[styles.detailValue, { color: colors.text }]}>
                  {formatDate(
                    inviteDetails.expiresAt,
                    language === "tr" ? "tr" : "en",
                  )}
                </Text>
              </View>
            </Animated.View>
          )}

          {/* Action Buttons */}
          <Animated.View
            entering={FadeInDown.delay(400).duration(400)}
            style={styles.buttonContainer}
          >
            <TouchableOpacity
              style={[
                styles.primaryButton,
                { backgroundColor: colors.primary },
                screenState === "accepting" && styles.buttonDisabled,
              ]}
              onPress={handleAccept}
              disabled={screenState === "accepting"}
              activeOpacity={0.8}
            >
              {screenState === "accepting" ? (
                <>
                  <ActivityIndicator
                    size="small"
                    color={colors.textOnPrimary}
                  />
                  <Text
                    style={[
                      styles.primaryButtonText,
                      { color: colors.textOnPrimary },
                    ]}
                  >
                    {t.accepting}
                  </Text>
                </>
              ) : (
                <>
                  <Icon
                    name="check-bold"
                    size={20}
                    color={colors.textOnPrimary}
                  />
                  <Text
                    style={[
                      styles.primaryButtonText,
                      { color: colors.textOnPrimary },
                    ]}
                  >
                    {t.accept}
                  </Text>
                </>
              )}
            </TouchableOpacity>

            <TouchableOpacity
              style={[styles.secondaryButton, { borderColor: colors.border }]}
              onPress={handleDecline}
              disabled={screenState === "accepting"}
              activeOpacity={0.7}
            >
              <Text
                style={[
                  styles.secondaryButtonText,
                  { color: colors.textSecondary },
                ]}
              >
                {t.decline}
              </Text>
            </TouchableOpacity>
          </Animated.View>
        </Animated.View>
      </View>
    </ScreenErrorBoundary>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.lg,
  },
  card: {
    width: "100%",
    maxWidth: 400,
    borderRadius: BorderRadius.xl,
    padding: Spacing.lg,
    alignItems: "center",
    ...Shadows.lg,
  },
  cardDark: {
    shadowColor: "#000",
    shadowOpacity: 0.4,
  },
  iconCircle: {
    width: 88,
    height: 88,
    borderRadius: 44,
    alignItems: "center",
    justifyContent: "center",
    marginBottom: Spacing.md,
  },
  inviteEmoji: {
    fontSize: 40,
  },
  title: {
    ...Typography.h3,
    textAlign: "center",
    marginBottom: Spacing.sm,
  },
  subtitle: {
    ...Typography.body,
    textAlign: "center",
    marginBottom: Spacing.lg,
    paddingHorizontal: Spacing.md,
  },
  loadingText: {
    ...Typography.body,
    marginTop: Spacing.md,
  },
  planBadge: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.lg,
    marginBottom: Spacing.lg,
  },
  planBadgeText: {
    ...Typography.buttonSmall,
  },
  planName: {
    ...Typography.h4,
    flexShrink: 1,
  },
  detailsContainer: {
    width: "100%",
    borderWidth: 1,
    borderRadius: BorderRadius.lg,
    padding: Spacing.md,
    marginBottom: Spacing.lg,
  },
  detailRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    paddingVertical: Spacing.xs,
  },
  detailLabel: {
    ...Typography.bodySmall,
    flex: 1,
  },
  detailValue: {
    ...Typography.buttonSmall,
  },
  detailDivider: {
    height: 1,
    width: "100%",
    marginVertical: Spacing.xs,
  },
  roleBadge: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: BorderRadius.sm,
  },
  roleBadgeText: {
    ...Typography.caption,
    fontWeight: "600",
  },
  buttonContainer: {
    width: "100%",
    gap: Spacing.sm,
  },
  primaryButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.sm,
    paddingVertical: 14,
    borderRadius: BorderRadius.lg,
    width: "100%",
    ...Shadows.sm,
  },
  primaryButtonText: {
    ...Typography.button,
  },
  secondaryButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    paddingVertical: 14,
    borderRadius: BorderRadius.lg,
    borderWidth: 1,
    width: "100%",
  },
  secondaryButtonText: {
    ...Typography.button,
  },
  buttonDisabled: {
    opacity: 0.7,
  },
});
