import React, { useEffect, useMemo, useState } from "react";
import {
  View,
  Text,
  FlatList,
  TouchableOpacity,
  StyleSheet,
} from "react-native";
import { useRouter } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon, type IconName } from "../src/components/ui/Icon";
import { LinearGradient } from "expo-linear-gradient";
import Animated, { FadeInDown } from "react-native-reanimated";
import { useFavoriteStore } from "../src/stores/favoriteStore";
import { useScenarioStore } from "../src/stores/scenarioStore";
import { useTheme } from "../src/contexts/ThemeContext";
import { CATEGORIES } from "../src/constants/categories";
import { EmptyState } from "../src/components/common/EmptyState";
import { SkeletonListItem } from "../src/components/ui/Skeleton";
import { FavoriteButton } from "../src/components/common/FavoriteButton";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../src/constants/theme";
import { hapticLight } from "../src/utils/haptics";
import { ScreenErrorBoundary } from "../src/components/common/ScreenErrorBoundary";

export default function FavoritesScreen() {
  const router = useRouter();
  const { t, i18n } = useTranslation();
  const lang = i18n.language as "tr" | "en";
  const { colors } = useTheme();
  const { favoriteIds, loadFavorites } = useFavoriteStore();
  const { scenarios, loadScenarios } = useScenarioStore();
  const [initialLoading, setInitialLoading] = useState(true);

  useEffect(() => {
    Promise.all([
      loadFavorites(),
      scenarios.length === 0 ? loadScenarios() : Promise.resolve(),
    ]).finally(() => setInitialLoading(false));
  }, []);

  const favoriteScenarios = useMemo(
    () => scenarios.filter((s) => favoriteIds.includes(s.id)),
    [scenarios, favoriteIds],
  );

  const styles = useMemo(() => createStyles(colors), [colors]);

  if (initialLoading) {
    return (
      <View style={styles.container}>
        {[...Array(5)].map((_, i) => (
          <SkeletonListItem key={i} />
        ))}
      </View>
    );
  }

  if (favoriteScenarios.length === 0) {
    return (
      <View style={styles.container}>
        <EmptyState
          emoji="💜"
          title={t("favorites.emptyTitle")}
          description={t("favorites.emptyDesc")}
        />
      </View>
    );
  }

  return (
    <ScreenErrorBoundary>
      <View style={styles.container}>
        <FlatList
          data={favoriteScenarios}
          keyExtractor={(item) => item.id}
          contentContainerStyle={styles.list}
          renderItem={({ item, index }) => {
            const catDef = CATEGORIES.find(
              (c) => c.slug === item.category?.slug,
            );
            const catColor = catDef?.color || colors.primary;
            return (
              <Animated.View
                entering={FadeInDown.duration(400).delay(index * 60)}
              >
                <TouchableOpacity
                  style={styles.card}
                  onPress={() => {
                    hapticLight();
                    router.push(`/scenario/${item.id}`);
                  }}
                  activeOpacity={0.8}
                >
                  <LinearGradient
                    colors={[catColor + "18", catColor + "08"]}
                    style={styles.cardImage}
                  >
                    <Icon
                      name={(catDef?.icon || "gift") as IconName}
                      size={32}
                      color={catColor}
                    />
                  </LinearGradient>
                  <View style={styles.cardContent}>
                    <Text style={styles.cardTitle} numberOfLines={2}>
                      {lang === "tr" ? item.title_tr : item.title_en}
                    </Text>
                    <Text style={styles.cardDesc} numberOfLines={1}>
                      {lang === "tr"
                        ? item.short_desc_tr || ""
                        : item.short_desc_en || ""}
                    </Text>
                    <View style={styles.cardMeta}>
                      <Text style={styles.cardBudget}>
                        ₺{item.min_budget?.toLocaleString()}+
                      </Text>
                      <Text style={styles.cardRating}>
                        ★ {item.rating_avg?.toFixed(1)}
                      </Text>
                    </View>
                  </View>
                  <FavoriteButton scenarioId={item.id} size={22} />
                </TouchableOpacity>
              </Animated.View>
            );
          }}
        />
      </View>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: { flex: 1, backgroundColor: colors.background },
    list: { padding: Spacing.lg },
    card: {
      flexDirection: "row",
      alignItems: "center",
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      marginBottom: Spacing.md,
      overflow: "hidden",
      borderWidth: 1,
      borderColor: colors.borderLight,
      ...Shadows.sm,
    },
    cardImage: {
      width: 80,
      height: 90,
      alignItems: "center",
      justifyContent: "center",
    },
    cardContent: { flex: 1, padding: Spacing.md },
    cardTitle: { ...Typography.body, fontWeight: "600", color: colors.text },
    cardDesc: {
      ...Typography.caption,
      color: colors.textSecondary,
      marginTop: 2,
    },
    cardMeta: { flexDirection: "row", gap: Spacing.md, marginTop: Spacing.xs },
    cardBudget: {
      ...Typography.caption,
      color: colors.success,
      fontWeight: "600",
    },
    cardRating: {
      ...Typography.caption,
      color: colors.secondary,
      fontWeight: "600",
    },
  });
