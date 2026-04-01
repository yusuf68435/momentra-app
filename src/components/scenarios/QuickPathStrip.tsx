import React, { useMemo } from "react";
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
} from "react-native";
import { useTranslation } from "react-i18next";
import { useTheme } from "../../contexts/ThemeContext";
import {
  type ThemeColors,
  Spacing,
  Typography,
  BorderRadius,
} from "../../constants/theme";
import { hapticLight } from "../../utils/haptics";
import type { ScenarioFilterState } from "./FilterModal";

interface Props {
  lang: "tr" | "en";
  onSelectPath: (filters: Partial<ScenarioFilterState>) => void;
}

interface QuickPath {
  emoji: string;
  label_tr: string;
  label_en: string;
  sub_tr: string;
  sub_en: string;
  color: string;
  filters: Partial<ScenarioFilterState>;
}

const QUICK_PATHS: QuickPath[] = [
  {
    emoji: "🌟",
    label_tr: "İlk Sürprizim",
    label_en: "My First Surprise",
    sub_tr: "Kolay & düşük bütçe",
    sub_en: "Easy & low budget",
    color: "#34C759",
    filters: { difficulty: [1], budgetRange: [0, 500] },
  },
  {
    emoji: "💕",
    label_tr: "Romantik An",
    label_en: "Romantic Moment",
    sub_tr: "Teklif & yıldönümü",
    sub_en: "Proposal & anniversary",
    color: "#FF6B8A",
    filters: { difficulty: [2, 3], budgetRange: [500, 5000] },
  },
  {
    emoji: "🎉",
    label_tr: "Büyük Kutlama",
    label_en: "Big Celebration",
    sub_tr: "Doğum günü & mezuniyet",
    sub_en: "Birthday & graduation",
    color: "#FFAA5C",
    filters: { peopleCount: [5, 50], difficulty: [2, 3] },
  },
  {
    emoji: "🗺️",
    label_tr: "Macera",
    label_en: "Adventure",
    sub_tr: "Premium & özel deneyim",
    sub_en: "Premium & unique experience",
    color: "#A78BFA",
    filters: { difficulty: [3, 4], showPremiumOnly: true },
  },
];

export function QuickPathStrip({ lang, onSelectPath }: Props) {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const styles = useMemo(() => createStyles(colors), [colors]);

  return (
    <View style={styles.container}>
      <Text style={styles.header}>{t("explore.quickStart")}</Text>
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={styles.scrollContent}
      >
        {QUICK_PATHS.map((path, index) => (
          <TouchableOpacity
            key={index}
            style={[
              styles.card,
              {
                backgroundColor: path.color + "12",
                borderColor: path.color + "25",
              },
            ]}
            onPress={() => {
              hapticLight();
              onSelectPath(path.filters);
            }}
            activeOpacity={0.8}
            accessibilityRole="button"
            accessibilityLabel={lang === "tr" ? path.label_tr : path.label_en}
          >
            <Text style={styles.emoji}>{path.emoji}</Text>
            <Text style={styles.label}>
              {lang === "tr" ? path.label_tr : path.label_en}
            </Text>
            <Text style={[styles.sub, { color: path.color }]}>
              {lang === "tr" ? path.sub_tr : path.sub_en}
            </Text>
          </TouchableOpacity>
        ))}
      </ScrollView>
    </View>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      marginTop: 4,
      marginBottom: Spacing.md,
    },
    header: {
      ...Typography.h4,
      color: colors.text,
      marginBottom: Spacing.sm,
      paddingHorizontal: Spacing.lg,
    },
    scrollContent: {
      paddingHorizontal: Spacing.lg,
    },
    card: {
      width: 150,
      borderWidth: 1,
      borderRadius: BorderRadius.xl,
      padding: Spacing.md,
      marginRight: Spacing.sm,
    },
    emoji: {
      fontSize: 32,
      lineHeight: 40,
      marginBottom: Spacing.xs,
    },
    label: {
      ...Typography.bodySmall,
      fontWeight: "700",
      color: colors.text,
      marginBottom: 2,
    },
    sub: {
      ...Typography.caption,
    },
  });
