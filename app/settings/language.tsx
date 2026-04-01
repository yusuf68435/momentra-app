import React, { useCallback, useMemo } from "react";
import { ScreenErrorBoundary } from "../../src/components/common/ScreenErrorBoundary";
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  FlatList,
} from "react-native";
import { Icon } from "../../src/components/ui/Icon";
import { useTranslation } from "react-i18next";
import { useRouter } from "expo-router";
import Animated, { FadeInDown, FadeInLeft } from "react-native-reanimated";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";
import { useLanguage } from "../../src/hooks/useLanguage";
import type { SupportedLanguage } from "../../src/constants/config";

const LANGUAGES: Array<{
  code: SupportedLanguage;
  nativeLabel: string;
  flag: string;
  rtl?: boolean;
}> = [
  { code: "tr", nativeLabel: "Türkçe", flag: "\u{1F1F9}\u{1F1F7}" },
  { code: "en", nativeLabel: "English", flag: "\u{1F1EC}\u{1F1E7}" },
  { code: "de", nativeLabel: "Deutsch", flag: "\u{1F1E9}\u{1F1EA}" },
  { code: "fr", nativeLabel: "Français", flag: "\u{1F1EB}\u{1F1F7}" },
  { code: "es", nativeLabel: "Español", flag: "\u{1F1EA}\u{1F1F8}" },
  { code: "it", nativeLabel: "Italiano", flag: "\u{1F1EE}\u{1F1F9}" },
  { code: "pt", nativeLabel: "Português", flag: "\u{1F1F5}\u{1F1F9}" },
  { code: "ru", nativeLabel: "Русский", flag: "\u{1F1F7}\u{1F1FA}" },
  { code: "ar", nativeLabel: "العربية", flag: "\u{1F1F8}\u{1F1E6}", rtl: true },
  { code: "ja", nativeLabel: "日本語", flag: "\u{1F1EF}\u{1F1F5}" },
  { code: "ko", nativeLabel: "한국어", flag: "\u{1F1F0}\u{1F1F7}" },
  { code: "zh", nativeLabel: "中文", flag: "\u{1F1E8}\u{1F1F3}" },
  { code: "hi", nativeLabel: "हिन्दी", flag: "\u{1F1EE}\u{1F1F3}" },
  { code: "nl", nativeLabel: "Nederlands", flag: "\u{1F1F3}\u{1F1F1}" },
  { code: "pl", nativeLabel: "Polski", flag: "\u{1F1F5}\u{1F1F1}" },
  { code: "sv", nativeLabel: "Svenska", flag: "\u{1F1F8}\u{1F1EA}" },
  { code: "uk", nativeLabel: "Українська", flag: "\u{1F1FA}\u{1F1E6}" },
];

export default function LanguageScreen() {
  const { t } = useTranslation("settings");
  const { language, changeLanguage } = useLanguage();
  const router = useRouter();
  const { colors } = useTheme();

  const styles = useMemo(() => createStyles(colors), [colors]);

  const handleSelect = useCallback(
    async (code: SupportedLanguage) => {
      await changeLanguage(code);
    },
    [changeLanguage],
  );

  const renderItem = useCallback(
    ({ item, index }: { item: (typeof LANGUAGES)[0]; index: number }) => {
      const isSelected = language === item.code;
      return (
        <Animated.View
          entering={FadeInLeft.delay(300 + index * 60)
            .duration(350)
            .springify()}
        >
          <TouchableOpacity
            style={[styles.option, isSelected && styles.optionSelected]}
            onPress={() => handleSelect(item.code)}
            activeOpacity={0.7}
          >
            <View
              style={[
                styles.flagContainer,
                isSelected && styles.flagContainerSelected,
              ]}
            >
              <Text style={styles.flag}>{item.flag}</Text>
            </View>
            <Text
              style={[
                styles.optionLabel,
                isSelected && styles.optionLabelSelected,
              ]}
            >
              {item.nativeLabel}
            </Text>
            <View style={[styles.radio, isSelected && styles.radioSelected]}>
              {isSelected && <View style={styles.radioInner} />}
            </View>
          </TouchableOpacity>
        </Animated.View>
      );
    },
    [language, handleSelect, styles],
  );

  return (
    <ScreenErrorBoundary>
      <View style={styles.container}>
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
            <Text style={styles.headerTitle}>{t("language")}</Text>
          </View>
        </Animated.View>

        <Animated.View
          entering={FadeInDown.delay(200).duration(500)}
          style={styles.iconContainer}
        >
          <View style={styles.globeCircle}>
            <Icon name="translate" size={40} color={colors.primary} />
          </View>
        </Animated.View>

        <FlatList
          data={LANGUAGES}
          renderItem={renderItem}
          keyExtractor={(item) => item.code}
          contentContainerStyle={styles.listContent}
          showsVerticalScrollIndicator={false}
        />

        <Animated.View
          entering={FadeInDown.delay(600).duration(400)}
          style={styles.infoContainer}
        >
          <Icon
            name="information-outline"
            size={18}
            color={colors.textTertiary}
          />
          <Text style={styles.infoText}>
            {t(
              "language_change_instant",
              "Language change is applied immediately.",
            )}
          </Text>
        </Animated.View>
      </View>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
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
    iconContainer: {
      alignItems: "center",
      marginVertical: Spacing.md,
    },
    globeCircle: {
      width: 72,
      height: 72,
      borderRadius: 36,
      backgroundColor: colors.primary + "12",
      alignItems: "center",
      justifyContent: "center",
    },
    listContent: {
      paddingHorizontal: Spacing.lg,
      paddingBottom: Spacing.lg,
      gap: Spacing.sm,
    },
    option: {
      flexDirection: "row",
      alignItems: "center",
      padding: Spacing.md,
      borderRadius: BorderRadius.lg,
      borderWidth: 1.5,
      borderColor: colors.border,
      backgroundColor: colors.surface,
      gap: Spacing.md,
      ...Shadows.sm,
      marginBottom: Spacing.sm,
    },
    optionSelected: {
      borderColor: colors.primary,
      backgroundColor: colors.primary + "08",
      ...Shadows.md,
    },
    flagContainer: {
      width: 44,
      height: 44,
      borderRadius: BorderRadius.md,
      backgroundColor: colors.surfaceVariant,
      alignItems: "center",
      justifyContent: "center",
    },
    flagContainerSelected: {
      backgroundColor: colors.primary + "15",
    },
    flag: {
      fontSize: 26,
    },
    optionLabel: {
      ...Typography.body,
      color: colors.text,
      flex: 1,
    },
    optionLabelSelected: {
      color: colors.primary,
      fontWeight: "600",
    },
    radio: {
      width: 22,
      height: 22,
      borderRadius: 11,
      borderWidth: 2,
      borderColor: colors.border,
      alignItems: "center",
      justifyContent: "center",
    },
    radioSelected: {
      borderColor: colors.primary,
    },
    radioInner: {
      width: 10,
      height: 10,
      borderRadius: 5,
      backgroundColor: colors.primary,
    },
    infoContainer: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      paddingHorizontal: Spacing.lg,
      paddingVertical: Spacing.md,
      borderTopWidth: 0.5,
      borderTopColor: colors.border + "40",
    },
    infoText: {
      ...Typography.caption,
      color: colors.textTertiary,
      flex: 1,
    },
  });
