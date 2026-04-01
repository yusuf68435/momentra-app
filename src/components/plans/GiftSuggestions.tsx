import React, { useMemo } from "react";
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Image,
  FlatList,
} from "react-native";
import { Icon } from "../ui/Icon";
import { useTranslation } from "react-i18next";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";
import { Card } from "../ui/Card";

export interface Gift {
  id: string;
  name: string;
  description: string;
  priceRange: string;
  imageUri?: string;
  purchased: boolean;
}

interface GiftSuggestionsProps {
  planId: string;
  gifts: Gift[];
  onAddGift: () => void;
  onTogglePurchased?: (id: string) => void;
  onGetAISuggestions?: () => void;
}

function GiftCard({
  gift,
  onToggle,
  colors,
}: {
  gift: Gift;
  onToggle?: (id: string) => void;
  colors: ThemeColors;
}) {
  const { t } = useTranslation();

  const styles = useMemo(() => createStyles(colors), [colors]);

  return (
    <Card style={styles.giftCard}>
      {gift.imageUri ? (
        <Image
          source={{ uri: gift.imageUri }}
          style={styles.giftImage}
          resizeMode="cover"
        />
      ) : (
        <View style={styles.giftImagePlaceholder}>
          <Icon name="gift-outline" size={40} color={colors.textTertiary} />
        </View>
      )}

      <View style={styles.giftContent}>
        <View style={styles.giftHeader}>
          <Text
            style={[styles.giftName, gift.purchased && styles.purchasedText]}
            numberOfLines={1}
          >
            {gift.name}
          </Text>
          <View style={styles.priceBadge}>
            <Icon name="tag" size={12} color={colors.primary} />
            <Text style={styles.priceText}>{gift.priceRange}</Text>
          </View>
        </View>

        <Text
          style={[
            styles.giftDescription,
            gift.purchased && styles.purchasedText,
          ]}
          numberOfLines={2}
        >
          {gift.description}
        </Text>

        <TouchableOpacity
          style={styles.purchaseRow}
          onPress={() => onToggle?.(gift.id)}
          activeOpacity={0.7}
        >
          <Icon
            name={gift.purchased ? "checkbox-marked" : "checkbox-blank-outline"}
            size={22}
            color={gift.purchased ? colors.success : colors.textTertiary}
          />
          <Text
            style={[
              styles.purchaseLabel,
              gift.purchased && { color: colors.success },
            ]}
          >
            {gift.purchased ? t("gifts.purchased") : t("gifts.markPurchased")}
          </Text>
        </TouchableOpacity>
      </View>
    </Card>
  );
}

export function GiftSuggestions({
  planId,
  gifts,
  onAddGift,
  onTogglePurchased,
  onGetAISuggestions,
}: GiftSuggestionsProps) {
  const { t } = useTranslation();
  const { colors } = useTheme();

  const styles = useMemo(() => createStyles(colors), [colors]);

  if (gifts.length === 0) {
    return (
      <Card style={styles.emptyContainer}>
        <Icon name="gift-outline" size={64} color={colors.textTertiary} />
        <Text style={styles.emptyTitle}>{t("gifts.emptyTitle")}</Text>
        <Text style={styles.emptySubtitle}>{t("gifts.emptySubtitle")}</Text>

        <View style={styles.emptyActions}>
          <TouchableOpacity
            style={styles.aiButton}
            onPress={onGetAISuggestions}
            activeOpacity={0.8}
          >
            <Icon name="creation" size={20} color={colors.textOnPrimary} />
            <Text style={styles.aiButtonText}>
              {t("gifts.getAISuggestions")}
            </Text>
          </TouchableOpacity>

          <TouchableOpacity
            style={styles.addButtonOutline}
            onPress={onAddGift}
            activeOpacity={0.8}
          >
            <Icon name="plus" size={20} color={colors.primary} />
            <Text style={styles.addButtonOutlineText}>
              {t("gifts.addGift")}
            </Text>
          </TouchableOpacity>
        </View>
      </Card>
    );
  }

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.sectionTitle}>{t("gifts.title")}</Text>
        <TouchableOpacity onPress={onAddGift} activeOpacity={0.7}>
          <Icon name="plus-circle" size={28} color={colors.primary} />
        </TouchableOpacity>
      </View>

      <TouchableOpacity
        style={styles.aiButton}
        onPress={onGetAISuggestions}
        activeOpacity={0.8}
      >
        <Icon name="creation" size={20} color={colors.textOnPrimary} />
        <Text style={styles.aiButtonText}>{t("gifts.getAISuggestions")}</Text>
      </TouchableOpacity>

      <FlatList
        data={gifts}
        keyExtractor={(item) => item.id}
        scrollEnabled={false}
        renderItem={({ item }) => (
          <GiftCard gift={item} onToggle={onTogglePurchased} colors={colors} />
        )}
        ItemSeparatorComponent={() => <View style={{ height: Spacing.sm }} />}
      />
    </View>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      marginBottom: Spacing.md,
    },
    header: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      marginBottom: Spacing.md,
    },
    sectionTitle: {
      ...Typography.h3,
      color: colors.text,
    },
    aiButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      backgroundColor: colors.accent,
      borderRadius: BorderRadius.md,
      paddingVertical: Spacing.sm + 2,
      paddingHorizontal: Spacing.lg,
      gap: Spacing.sm,
      marginBottom: Spacing.md,
      ...Shadows.md,
    },
    aiButtonText: {
      ...Typography.button,
      color: colors.textOnPrimary,
    },
    giftCard: {
      flexDirection: "row",
      overflow: "hidden",
    },
    giftImage: {
      width: 100,
      height: 120,
    },
    giftImagePlaceholder: {
      width: 100,
      height: 120,
      backgroundColor: colors.backgroundSecondary,
      alignItems: "center",
      justifyContent: "center",
    },
    giftContent: {
      flex: 1,
      padding: Spacing.md,
    },
    giftHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      marginBottom: Spacing.xs,
    },
    giftName: {
      ...Typography.h4,
      color: colors.text,
      flex: 1,
      marginRight: Spacing.sm,
    },
    priceBadge: {
      flexDirection: "row",
      alignItems: "center",
      backgroundColor: colors.primary + "15",
      paddingHorizontal: Spacing.sm,
      paddingVertical: 2,
      borderRadius: BorderRadius.sm,
      gap: 4,
    },
    priceText: {
      ...Typography.caption,
      color: colors.primary,
      fontWeight: "600",
    },
    giftDescription: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
      marginBottom: Spacing.sm,
    },
    purchasedText: {
      textDecorationLine: "line-through",
      color: colors.textTertiary,
    },
    purchaseRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.xs,
    },
    purchaseLabel: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
    },
    emptyContainer: {
      alignItems: "center",
      paddingVertical: Spacing.xxl,
      paddingHorizontal: Spacing.lg,
    },
    emptyTitle: {
      ...Typography.h3,
      color: colors.text,
      marginTop: Spacing.md,
    },
    emptySubtitle: {
      ...Typography.body,
      color: colors.textSecondary,
      textAlign: "center",
      marginTop: Spacing.xs,
      marginBottom: Spacing.lg,
    },
    emptyActions: {
      gap: Spacing.sm,
      width: "100%",
    },
    addButtonOutline: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      borderWidth: 2,
      borderColor: colors.primary,
      borderRadius: BorderRadius.md,
      paddingVertical: Spacing.sm + 2,
      paddingHorizontal: Spacing.lg,
      gap: Spacing.sm,
    },
    addButtonOutlineText: {
      ...Typography.button,
      color: colors.primary,
    },
  });
