import React, { useMemo } from "react";
import {
  View,
  Text,
  Image,
  TouchableOpacity,
  StyleSheet,
  Linking,
} from "react-native";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";
import { Card } from "../ui/Card";

export interface Vendor {
  id: string;
  name: string;
  type: string;
  rating: number;
  review_count: number;
  price_range: 1 | 2 | 3;
  image_url: string | null;
  distance: number | null;
  phone: string | null;
  address: string;
}

interface VendorCardProps {
  vendor: Vendor;
  onPress: () => void;
  onFavorite: () => void;
  isFavorite: boolean;
}

const VENDOR_TYPE_ICONS: Record<string, string> = {
  florist: "flower",
  restaurant: "silverware-fork-knife",
  photographer: "camera",
  musician: "music",
  decorator: "palette",
  bakery: "cake-variant",
  venue: "map-marker",
  caterer: "food",
  jeweler: "diamond-stone",
  planner: "calendar-star",
};

const VENDOR_TYPE_LABELS: Record<string, { tr: string; en: string }> = {
  florist: { tr: "Cicekci", en: "Florist" },
  restaurant: { tr: "Restoran", en: "Restaurant" },
  photographer: { tr: "Fotoğrafçı", en: "Photographer" },
  musician: { tr: "Muzisyen", en: "Musician" },
  decorator: { tr: "Dekorator", en: "Decorator" },
  bakery: { tr: "Pastane", en: "Bakery" },
  venue: { tr: "Mekan", en: "Venue" },
  caterer: { tr: "Yemek", en: "Caterer" },
  jeweler: { tr: "Kuyumcu", en: "Jeweler" },
  planner: { tr: "Organizator", en: "Planner" },
};

export function VendorCard({
  vendor,
  onPress,
  onFavorite,
  isFavorite,
}: VendorCardProps) {
  const { t, i18n } = useTranslation();
  const { colors } = useTheme();
  const lang = i18n.language as "tr" | "en";

  const typeIcon = VENDOR_TYPE_ICONS[vendor.type] || "store";
  const typeLabel = VENDOR_TYPE_LABELS[vendor.type]?.[lang] || vendor.type;

  const styles = useMemo(() => createStyles(colors), [colors]);

  const handleCall = () => {
    if (vendor.phone) {
      Linking.openURL(`tel:${vendor.phone}`);
    }
  };

  const formatDistance = (km: number): string => {
    if (km < 1) {
      return `${Math.round(km * 1000)} m`;
    }
    return `${km.toFixed(1)} km`;
  };

  const renderStars = (rating: number): React.ReactNode[] => {
    const stars: React.ReactNode[] = [];
    const fullStars = Math.floor(rating);
    const hasHalfStar = rating - fullStars >= 0.5;

    for (let i = 0; i < 5; i++) {
      if (i < fullStars) {
        stars.push(
          <Icon key={i} name="star" size={14} color={colors.warning} />,
        );
      } else if (i === fullStars && hasHalfStar) {
        stars.push(
          <Icon
            key={i}
            name="star-half-full"
            size={14}
            color={colors.warning}
          />,
        );
      } else {
        stars.push(
          <Icon
            key={i}
            name="star-outline"
            size={14}
            color={colors.textTertiary}
          />,
        );
      }
    }
    return stars;
  };

  const renderPriceRange = (range: 1 | 2 | 3): React.ReactNode => {
    const active = range;
    const symbols: React.ReactNode[] = [];
    for (let i = 1; i <= 3; i++) {
      symbols.push(
        <Text
          key={i}
          style={[
            styles.priceSymbol,
            i <= active ? styles.priceActive : styles.priceInactive,
          ]}
        >
          {"\u20BA"}
        </Text>,
      );
    }
    return <View style={styles.priceRow}>{symbols}</View>;
  };

  return (
    <Card onPress={onPress} padding={false} style={styles.card}>
      {/* Image */}
      <View style={styles.imageContainer}>
        {vendor.image_url ? (
          <Image
            source={{ uri: vendor.image_url }}
            style={styles.image}
            resizeMode="cover"
          />
        ) : (
          <View style={[styles.image, styles.imagePlaceholder]}>
            <Icon
              name={typeIcon as IconName}
              size={40}
              color={colors.textTertiary}
            />
          </View>
        )}

        {/* Type badge overlay */}
        <View style={styles.typeBadge}>
          <Icon
            name={typeIcon as IconName}
            size={14}
            color={colors.textOnPrimary}
          />
          <Text style={styles.typeBadgeText}>{typeLabel}</Text>
        </View>

        {/* Distance badge */}
        {vendor.distance != null && (
          <View style={styles.distanceBadge}>
            <Icon name="map-marker-distance" size={12} color={colors.info} />
            <Text style={styles.distanceText}>
              {formatDistance(vendor.distance)}
            </Text>
          </View>
        )}

        {/* Favorite button */}
        <TouchableOpacity
          style={styles.favoriteButton}
          onPress={onFavorite}
          activeOpacity={0.7}
          hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}
        >
          <Icon
            name={isFavorite ? "heart" : "heart-outline"}
            size={22}
            color={isFavorite ? colors.error : colors.textOnPrimary}
          />
        </TouchableOpacity>
      </View>

      {/* Content */}
      <View style={styles.content}>
        <Text style={styles.name} numberOfLines={1}>
          {vendor.name}
        </Text>

        {/* Star rating row */}
        <View style={styles.ratingRow}>
          <View style={styles.starsRow}>{renderStars(vendor.rating)}</View>
          <Text style={styles.ratingText}>
            {(vendor.rating ?? 0).toFixed(1)}
          </Text>
          <Text style={styles.reviewCount}>({vendor.review_count})</Text>
        </View>

        {/* Price and address row */}
        <View style={styles.detailsRow}>
          {renderPriceRange(vendor.price_range)}
          <View style={styles.dot} />
          <Text style={styles.address} numberOfLines={1}>
            {vendor.address}
          </Text>
        </View>

        {/* Call button */}
        {vendor.phone && (
          <TouchableOpacity
            style={styles.callButton}
            onPress={handleCall}
            activeOpacity={0.7}
          >
            <Icon name="phone" size={16} color={colors.success} />
            <Text style={styles.callText}>{t("vendors.call")}</Text>
          </TouchableOpacity>
        )}
      </View>
    </Card>
  );
}

const createStyles = (
  colors: ReturnType<
    typeof import("../../contexts/ThemeContext").useTheme
  >["colors"],
) =>
  StyleSheet.create({
    card: {
      marginBottom: Spacing.md,
    },
    imageContainer: {
      position: "relative",
    },
    image: {
      width: "100%",
      height: 160,
    },
    imagePlaceholder: {
      backgroundColor: colors.surfaceVariant,
      alignItems: "center",
      justifyContent: "center",
    },
    typeBadge: {
      position: "absolute",
      bottom: Spacing.sm,
      left: Spacing.sm,
      flexDirection: "row",
      alignItems: "center",
      backgroundColor: colors.primary,
      paddingHorizontal: Spacing.sm,
      paddingVertical: Spacing.xs,
      borderRadius: BorderRadius.full,
      gap: 4,
    },
    typeBadgeText: {
      ...Typography.caption,
      fontWeight: "600",
      color: colors.textOnPrimary,
    },
    distanceBadge: {
      position: "absolute",
      bottom: Spacing.sm,
      right: Spacing.sm,
      flexDirection: "row",
      alignItems: "center",
      backgroundColor: colors.surface,
      paddingHorizontal: Spacing.sm,
      paddingVertical: Spacing.xs,
      borderRadius: BorderRadius.full,
      gap: 4,
      ...Shadows.sm,
    },
    distanceText: {
      ...Typography.caption,
      fontWeight: "600",
      color: colors.info,
    },
    favoriteButton: {
      position: "absolute",
      top: Spacing.sm,
      right: Spacing.sm,
      width: 36,
      height: 36,
      borderRadius: 18,
      backgroundColor: "rgba(0, 0, 0, 0.35)",
      alignItems: "center",
      justifyContent: "center",
    },
    content: {
      padding: Spacing.md,
    },
    name: {
      ...Typography.h4,
      color: colors.text,
      marginBottom: Spacing.xs,
    },
    ratingRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: 4,
      marginBottom: Spacing.sm,
    },
    starsRow: {
      flexDirection: "row",
      gap: 1,
    },
    ratingText: {
      ...Typography.bodySmall,
      fontWeight: "600",
      color: colors.text,
      marginLeft: 4,
    },
    reviewCount: {
      ...Typography.caption,
      color: colors.textTertiary,
    },
    detailsRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginBottom: Spacing.sm,
    },
    priceRow: {
      flexDirection: "row",
    },
    priceSymbol: {
      ...Typography.bodySmall,
      fontWeight: "700",
    },
    priceActive: {
      color: colors.success,
    },
    priceInactive: {
      color: colors.textTertiary,
    },
    dot: {
      width: 4,
      height: 4,
      borderRadius: 2,
      backgroundColor: colors.textTertiary,
    },
    address: {
      ...Typography.caption,
      color: colors.textSecondary,
      flex: 1,
    },
    callButton: {
      flexDirection: "row",
      alignItems: "center",
      alignSelf: "flex-start",
      gap: Spacing.xs,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      borderRadius: BorderRadius.full,
      backgroundColor: colors.success + "15",
      marginTop: Spacing.xs,
    },
    callText: {
      ...Typography.buttonSmall,
      color: colors.success,
    },
  });
