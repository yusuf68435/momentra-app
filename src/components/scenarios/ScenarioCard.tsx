import React from "react";
import { View, Text, StyleSheet } from "react-native";
import { useTranslation } from "react-i18next";
import { Card } from "../ui/Card";
import { CachedImage } from "../common/CachedImage";
import { Badge } from "../ui/Badge";
import { Spacing, Typography, BorderRadius } from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";
import type { Scenario } from "../../types/database";

interface ScenarioCardProps {
  scenario: Scenario;
  onPress: () => void;
  compact?: boolean;
}

export function ScenarioCard({
  scenario,
  onPress,
  compact = false,
}: ScenarioCardProps) {
  const { i18n } = useTranslation();
  const { colors } = useTheme();
  const lang = i18n.language as "tr" | "en";
  const title = lang === "tr" ? scenario.title_tr : scenario.title_en;
  const shortDesc =
    lang === "tr" ? scenario.short_desc_tr : scenario.short_desc_en;

  const formatBudget = (min: number | null, max: number | null) => {
    if (!min && !max) return "";
    if (min && max)
      return `${min.toLocaleString()} - ${max.toLocaleString()} TL`;
    if (min) return `${min.toLocaleString()}+ TL`;
    return `${max?.toLocaleString()} TL`;
  };

  return (
    <Card
      onPress={onPress}
      padding={false}
      style={compact ? styles.compactCard : styles.card}
    >
      <CachedImage
        uri={scenario.cover_image_url}
        style={compact ? styles.compactImage : styles.image}
        contentFit="cover"
        fallbackIcon="image-off-outline"
      />
      <View style={styles.content}>
        <View style={styles.header}>
          <Text
            style={[
              compact ? styles.compactTitle : styles.title,
              { color: colors.text },
            ]}
            numberOfLines={compact ? 1 : 2}
          >
            {title}
          </Text>
          {scenario.is_premium && (
            <Badge text="PRO" backgroundColor={colors.accent} size="sm" />
          )}
        </View>
        {!compact && shortDesc && (
          <Text
            style={[styles.description, { color: colors.textSecondary }]}
            numberOfLines={2}
          >
            {shortDesc}
          </Text>
        )}
        <View style={styles.meta}>
          {scenario.min_budget != null && (
            <Text style={[styles.metaText, { color: colors.textTertiary }]}>
              {formatBudget(scenario.min_budget, scenario.max_budget)}
            </Text>
          )}
          <Text style={[styles.metaText, { color: colors.textTertiary }]}>
            {scenario.prep_days} gün
          </Text>
          {(scenario.rating_avg ?? 0) > 0 && (
            <Text style={[styles.ratingText, { color: colors.warning }]}>
              {"\u2605"} {(scenario.rating_avg ?? 0).toFixed(1)}
            </Text>
          )}
        </View>
      </View>
    </Card>
  );
}

const styles = StyleSheet.create({
  card: {
    width: 280,
    marginRight: Spacing.md,
  },
  compactCard: {
    flexDirection: "row",
    marginBottom: Spacing.md,
  },
  image: {
    width: "100%",
    height: 150,
  },
  compactImage: {
    width: 96,
    height: 96,
    borderRadius: BorderRadius.md,
  },
  placeholderEmoji: {
    fontSize: 38,
  },
  content: {
    padding: Spacing.md,
    flex: 1,
  },
  header: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    gap: Spacing.sm,
  },
  title: {
    ...Typography.h4,
    flex: 1,
  },
  compactTitle: {
    ...Typography.body,
    fontWeight: "600",
    flex: 1,
  },
  description: {
    ...Typography.bodySmall,
    marginTop: Spacing.xs,
  },
  meta: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
    marginTop: Spacing.sm,
  },
  metaText: {
    ...Typography.caption,
  },
  ratingText: {
    ...Typography.caption,
    fontWeight: "600",
  },
});
