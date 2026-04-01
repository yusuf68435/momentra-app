import React, { useState, useEffect, useMemo } from "react";
import {
  View,
  Text,
  TextInput,
  ScrollView,
  TouchableOpacity,
  StyleSheet,
  Image,
  Alert,
  KeyboardAvoidingView,
  Platform,
} from "react-native";
import { ScreenErrorBoundary } from "../../src/components/common/ScreenErrorBoundary";
import { useRouter } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon } from "../../src/components/ui/Icon";
import { LinearGradient } from "expo-linear-gradient";
import Animated, { FadeInDown } from "react-native-reanimated";
import * as ImagePicker from "expo-image-picker";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";
import { useAuthStore } from "../../src/stores/authStore";

export default function ProfileEditScreen() {
  const router = useRouter();
  const { t, i18n } = useTranslation();
  const lang = i18n.language as "tr" | "en";
  const { profile, updateProfile } = useAuthStore();
  const { colors } = useTheme();

  const styles = useMemo(() => createStyles(colors), [colors]);

  const [displayName, setDisplayName] = useState(profile?.display_name || "");
  const [avatarUrl, setAvatarUrl] = useState(profile?.avatar_url || "");
  const [isSaving, setIsSaving] = useState(false);

  // Important dates — load from profile preferences if available
  const [importantDates, setImportantDates] = useState<
    Array<{ label: string; date: string; type: string }>
  >(() => {
    const saved = (profile?.preferences as any)?.importantDates;
    return Array.isArray(saved) && saved.length > 0
      ? saved
      : [{ label: "", date: "", type: "birthday" }];
  });

  // Interests
  const INTEREST_OPTIONS = [
    { id: "cooking", emoji: "🍳", label_tr: "Yemek", label_en: "Cooking" },
    { id: "travel", emoji: "✈️", label_tr: "Seyahat", label_en: "Travel" },
    { id: "music", emoji: "🎵", label_tr: "Müzik", label_en: "Music" },
    { id: "sports", emoji: "⚽", label_tr: "Spor", label_en: "Sports" },
    { id: "art", emoji: "🎨", label_tr: "Sanat", label_en: "Art" },
    { id: "tech", emoji: "💻", label_tr: "Teknoloji", label_en: "Technology" },
    { id: "nature", emoji: "🌿", label_tr: "Doğa", label_en: "Nature" },
    { id: "reading", emoji: "📚", label_tr: "Okuma", label_en: "Reading" },
    { id: "gaming", emoji: "🎮", label_tr: "Oyun", label_en: "Gaming" },
    {
      id: "photography",
      emoji: "📸",
      label_tr: "Fotoğraf",
      label_en: "Photography",
    },
    { id: "fashion", emoji: "👗", label_tr: "Moda", label_en: "Fashion" },
    { id: "wellness", emoji: "🧘", label_tr: "Sağlık", label_en: "Wellness" },
    { id: "movies", emoji: "🎬", label_tr: "Film", label_en: "Movies" },
    { id: "pets", emoji: "🐾", label_tr: "Evcil Hayvan", label_en: "Pets" },
    { id: "diy", emoji: "🔨", label_tr: "Kendin Yap", label_en: "DIY" },
  ];

  const [selectedInterests, setSelectedInterests] = useState<string[]>(
    (profile?.preferences as any)?.interests || [],
  );

  const toggleInterest = (id: string) => {
    setSelectedInterests((prev) =>
      prev.includes(id) ? prev.filter((i) => i !== id) : [...prev, id],
    );
  };

  const pickImage = async () => {
    const { status } = await ImagePicker.requestMediaLibraryPermissionsAsync();
    if (status !== "granted") {
      Alert.alert(
        t("profileEdit.permissionRequired"),
        t("profileEdit.galleryPermission"),
      );
      return;
    }

    const result = await ImagePicker.launchImageLibraryAsync({
      mediaTypes: ["images"],
      allowsEditing: true,
      aspect: [1, 1],
      quality: 0.8,
    });

    if (
      !result.canceled &&
      result.assets &&
      result.assets.length > 0 &&
      result.assets[0]?.uri
    ) {
      setAvatarUrl(result.assets[0].uri);
    }
  };

  const addImportantDate = () => {
    setImportantDates((prev) => [
      ...prev,
      { label: "", date: "", type: "birthday" },
    ]);
  };

  const removeImportantDate = (index: number) => {
    setImportantDates((prev) => prev.filter((_, i) => i !== index));
  };

  const updateImportantDate = (index: number, field: string, value: string) => {
    setImportantDates((prev) =>
      prev.map((item, i) => (i === index ? { ...item, [field]: value } : item)),
    );
  };

  const DATE_TYPES = [
    {
      value: "birthday",
      label_tr: "Doğum Günü",
      label_en: "Birthday",
      emoji: "🎂",
    },
    {
      value: "anniversary",
      label_tr: "Yıl Dönümü",
      label_en: "Anniversary",
      emoji: "💍",
    },
    {
      value: "graduation",
      label_tr: "Mezuniyet",
      label_en: "Graduation",
      emoji: "🎓",
    },
    { value: "other", label_tr: "Diğer", label_en: "Other", emoji: "📅" },
  ];

  const handleSave = async () => {
    if (!displayName.trim()) {
      Alert.alert(t("profileEdit.errorTitle"), t("profileEdit.nameRequired"));
      return;
    }

    setIsSaving(true);
    try {
      await updateProfile({
        display_name: displayName.trim(),
        avatar_url: avatarUrl || null,
        preferences: {
          ...((profile?.preferences as object) || {}),
          interests: selectedInterests,
          importantDates: importantDates.filter((d) => d.label && d.date),
        },
      });
      router.back();
    } catch (error: unknown) {
      Alert.alert(
        t("profileEdit.errorTitle"),
        (error as Error).message || t("profileEdit.updateFailed"),
      );
    } finally {
      setIsSaving(false);
    }
  };

  const completionPercentage = () => {
    let total = 0;
    if (displayName) total += 25;
    if (avatarUrl) total += 25;
    if (selectedInterests.length > 0) total += 25;
    if (importantDates.some((d) => d.label && d.date)) total += 25;
    return total;
  };

  return (
    <ScreenErrorBoundary>
      <KeyboardAvoidingView
        style={styles.container}
        behavior={Platform.OS === "ios" ? "padding" : undefined}
      >
        <ScrollView
          showsVerticalScrollIndicator={false}
          contentContainerStyle={styles.scrollContent}
        >
          {/* Completion Bar */}
          <Animated.View
            entering={FadeInDown.duration(300)}
            style={styles.completionSection}
          >
            <View style={styles.completionHeader}>
              <Text style={styles.completionTitle}>
                {t("profileEdit.profileCompletion")}
              </Text>
              <Text style={styles.completionPercent}>
                {completionPercentage()}%
              </Text>
            </View>
            <View style={styles.completionBarBg}>
              <View
                style={[
                  styles.completionBarFill,
                  { width: `${completionPercentage()}%` },
                ]}
              />
            </View>
          </Animated.View>

          {/* Avatar */}
          <Animated.View
            entering={FadeInDown.duration(300).delay(50)}
            style={styles.avatarSection}
          >
            <TouchableOpacity onPress={pickImage} style={styles.avatarButton}>
              {avatarUrl ? (
                <Image source={{ uri: avatarUrl }} style={styles.avatarImage} />
              ) : (
                <LinearGradient
                  colors={[colors.primaryLight, colors.primary]}
                  style={styles.avatarPlaceholder}
                >
                  <Text style={styles.avatarInitial}>
                    {displayName ? displayName[0].toUpperCase() : "?"}
                  </Text>
                </LinearGradient>
              )}
              <View style={styles.avatarEditBadge}>
                <Icon name="camera" size={16} color="#FFF" />
              </View>
            </TouchableOpacity>
            <Text style={styles.avatarHint}>
              {t("profileEdit.tapToChangePhoto")}
            </Text>
          </Animated.View>

          {/* Name */}
          <Animated.View
            entering={FadeInDown.duration(300).delay(100)}
            style={styles.section}
          >
            <Text style={styles.sectionTitle}>
              {t("profileEdit.nameLabel")}
            </Text>
            <TextInput
              style={styles.textInput}
              value={displayName}
              onChangeText={setDisplayName}
              placeholder={t("profileEdit.namePlaceholder")}
              placeholderTextColor={colors.textTertiary}
            />
          </Animated.View>

          {/* Interests */}
          <Animated.View
            entering={FadeInDown.duration(300).delay(150)}
            style={styles.section}
          >
            <Text style={styles.sectionTitle}>
              {t("profileEdit.interestsLabel")}
            </Text>
            <Text style={styles.sectionSubtitle}>
              {t("profileEdit.interestsSubtitle")}
            </Text>
            <View style={styles.interestGrid}>
              {INTEREST_OPTIONS.map((opt) => {
                const selected = selectedInterests.includes(opt.id);
                return (
                  <TouchableOpacity
                    key={opt.id}
                    style={[
                      styles.interestChip,
                      selected && styles.interestChipActive,
                    ]}
                    onPress={() => toggleInterest(opt.id)}
                  >
                    <Text style={styles.interestEmoji}>{opt.emoji}</Text>
                    <Text
                      style={[
                        styles.interestLabel,
                        selected && styles.interestLabelActive,
                      ]}
                    >
                      {lang === "tr" ? opt.label_tr : opt.label_en}
                    </Text>
                  </TouchableOpacity>
                );
              })}
            </View>
          </Animated.View>

          {/* Important Dates */}
          <Animated.View
            entering={FadeInDown.duration(300).delay(200)}
            style={styles.section}
          >
            <Text style={styles.sectionTitle}>
              {t("profileEdit.importantDatesLabel")}
            </Text>
            <Text style={styles.sectionSubtitle}>
              {t("profileEdit.importantDatesSubtitle")}
            </Text>

            {importantDates.map((item, index) => (
              <View key={index} style={styles.dateRow}>
                <View style={styles.dateInputs}>
                  <TextInput
                    style={[styles.textInput, { flex: 1, marginBottom: 0 }]}
                    value={item.label}
                    onChangeText={(v) => updateImportantDate(index, "label", v)}
                    placeholder={t("profileEdit.personNamePlaceholder")}
                    placeholderTextColor={colors.textTertiary}
                  />
                  <TextInput
                    style={[styles.textInput, { width: 120, marginBottom: 0 }]}
                    value={item.date}
                    onChangeText={(v) => updateImportantDate(index, "date", v)}
                    placeholder="GG/AA"
                    placeholderTextColor={colors.textTertiary}
                    keyboardType="numeric"
                    maxLength={5}
                  />
                </View>

                {/* Date Type Selector */}
                <View style={styles.dateTypeRow}>
                  {DATE_TYPES.map((dt) => (
                    <TouchableOpacity
                      key={dt.value}
                      style={[
                        styles.dateTypeChip,
                        item.type === dt.value && styles.dateTypeChipActive,
                      ]}
                      onPress={() =>
                        updateImportantDate(index, "type", dt.value)
                      }
                    >
                      <Text style={styles.dateTypeEmoji}>{dt.emoji}</Text>
                      <Text
                        style={[
                          styles.dateTypeLabel,
                          item.type === dt.value && styles.dateTypeLabelActive,
                        ]}
                      >
                        {lang === "tr" ? dt.label_tr : dt.label_en}
                      </Text>
                    </TouchableOpacity>
                  ))}
                  {importantDates.length > 1 && (
                    <TouchableOpacity
                      onPress={() => removeImportantDate(index)}
                      style={styles.removeDateBtn}
                    >
                      <Icon name="close" size={18} color={colors.error} />
                    </TouchableOpacity>
                  )}
                </View>
              </View>
            ))}

            <TouchableOpacity
              style={styles.addDateBtn}
              onPress={addImportantDate}
            >
              <Icon
                name="plus-circle-outline"
                size={20}
                color={colors.primary}
              />
              <Text style={styles.addDateText}>{t("profileEdit.addDate")}</Text>
            </TouchableOpacity>
          </Animated.View>

          <View style={{ height: 100 }} />
        </ScrollView>

        {/* Save Button */}
        <View style={styles.footer}>
          <TouchableOpacity
            style={[styles.saveButton, isSaving && styles.saveButtonDisabled]}
            onPress={handleSave}
            disabled={isSaving}
          >
            <Text style={styles.saveButtonText}>
              {isSaving ? t("profileEdit.saving") : t("profileEdit.save")}
            </Text>
          </TouchableOpacity>
        </View>
      </KeyboardAvoidingView>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },
    scrollContent: {
      padding: Spacing.lg,
    },
    completionSection: {
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      padding: Spacing.md,
      marginBottom: Spacing.lg,
      borderWidth: 1,
      borderColor: colors.borderLight,
    },
    completionHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      marginBottom: Spacing.sm,
    },
    completionTitle: {
      ...Typography.bodySmall,
      fontWeight: "600",
      color: colors.text,
    },
    completionPercent: {
      ...Typography.bodySmall,
      fontWeight: "700",
      color: colors.primary,
    },
    completionBarBg: {
      height: 6,
      backgroundColor: colors.surfaceVariant,
      borderRadius: 3,
      overflow: "hidden",
    },
    completionBarFill: {
      height: "100%",
      backgroundColor: colors.primary,
      borderRadius: 3,
    },
    avatarSection: {
      alignItems: "center",
      marginBottom: Spacing.lg,
    },
    avatarButton: {
      position: "relative",
    },
    avatarImage: {
      width: 100,
      height: 100,
      borderRadius: 50,
      borderWidth: 3,
      borderColor: colors.primary,
    },
    avatarPlaceholder: {
      width: 100,
      height: 100,
      borderRadius: 50,
      alignItems: "center",
      justifyContent: "center",
    },
    avatarInitial: {
      fontSize: 40,
      fontWeight: "700",
      color: "#FFF",
    },
    avatarEditBadge: {
      position: "absolute",
      bottom: 0,
      right: 0,
      width: 32,
      height: 32,
      borderRadius: 16,
      backgroundColor: colors.primary,
      alignItems: "center",
      justifyContent: "center",
      borderWidth: 2,
      borderColor: colors.background,
    },
    avatarHint: {
      ...Typography.caption,
      color: colors.textTertiary,
      marginTop: Spacing.sm,
    },
    section: {
      marginBottom: Spacing.lg,
    },
    sectionTitle: {
      ...Typography.body,
      fontWeight: "600",
      color: colors.text,
      marginBottom: Spacing.xs,
    },
    sectionSubtitle: {
      ...Typography.caption,
      color: colors.textTertiary,
      marginBottom: Spacing.md,
    },
    textInput: {
      ...Typography.body,
      backgroundColor: colors.surfaceVariant,
      borderRadius: BorderRadius.md,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.md - 2,
      color: colors.text,
      borderWidth: 1,
      borderColor: colors.borderLight,
      marginBottom: Spacing.sm,
    },
    interestGrid: {
      flexDirection: "row",
      flexWrap: "wrap",
      gap: Spacing.sm,
    },
    interestChip: {
      flexDirection: "row",
      alignItems: "center",
      gap: 4,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      borderRadius: BorderRadius.full,
      backgroundColor: colors.surfaceVariant,
      borderWidth: 1,
      borderColor: colors.borderLight,
    },
    interestChipActive: {
      backgroundColor: colors.primary + "15",
      borderColor: colors.primary,
    },
    interestEmoji: {
      fontSize: 16,
    },
    interestLabel: {
      ...Typography.caption,
      color: colors.textSecondary,
      fontWeight: "500",
    },
    interestLabelActive: {
      color: colors.primary,
      fontWeight: "600",
    },
    dateRow: {
      backgroundColor: colors.surfaceVariant,
      borderRadius: BorderRadius.md,
      padding: Spacing.md,
      marginBottom: Spacing.sm,
    },
    dateInputs: {
      flexDirection: "row",
      gap: Spacing.sm,
      marginBottom: Spacing.sm,
    },
    dateTypeRow: {
      flexDirection: "row",
      flexWrap: "wrap",
      gap: Spacing.xs,
      alignItems: "center",
    },
    dateTypeChip: {
      flexDirection: "row",
      alignItems: "center",
      gap: 2,
      paddingHorizontal: Spacing.sm,
      paddingVertical: Spacing.xs,
      borderRadius: BorderRadius.full,
      backgroundColor: colors.background,
    },
    dateTypeChipActive: {
      backgroundColor: colors.primary + "15",
    },
    dateTypeEmoji: {
      fontSize: 12,
    },
    dateTypeLabel: {
      ...Typography.caption,
      color: colors.textTertiary,
      fontSize: 10,
    },
    dateTypeLabelActive: {
      color: colors.primary,
      fontWeight: "600",
    },
    removeDateBtn: {
      marginLeft: "auto",
      padding: Spacing.xs,
    },
    addDateBtn: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      paddingVertical: Spacing.sm,
    },
    addDateText: {
      ...Typography.bodySmall,
      color: colors.primary,
      fontWeight: "600",
    },
    footer: {
      position: "absolute",
      bottom: 0,
      left: 0,
      right: 0,
      padding: Spacing.lg,
      paddingBottom: Spacing.xl,
      backgroundColor: colors.background,
      borderTopWidth: 1,
      borderTopColor: colors.borderLight,
      ...Shadows.md,
    },
    saveButton: {
      backgroundColor: colors.primary,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.lg,
      alignItems: "center",
    },
    saveButtonDisabled: {
      opacity: 0.6,
    },
    saveButtonText: {
      ...Typography.button,
      color: colors.textOnPrimary,
    },
  });
