import React, { memo } from "react";
import { View, TouchableOpacity, StyleSheet } from "react-native";
import { Icon } from "./Icon";
import { Spacing } from "../../constants/theme";

interface StarRatingProps {
  rating: number;
  maxStars?: number;
  size?: number;
  color?: string;
  emptyColor?: string;
  onRate?: (rating: number) => void;
  readOnly?: boolean;
}

function StarRatingComponent({
  rating,
  maxStars = 5,
  size = 28,
  color = "#FFD700",
  emptyColor,
  onRate,
  readOnly = false,
}: StarRatingProps) {
  const isInteractive = !readOnly && onRate !== undefined;

  return (
    <View
      style={styles.container}
      accessible={!isInteractive}
      accessibilityRole={isInteractive ? undefined : "image"}
      accessibilityLabel={`${rating} out of ${maxStars} stars`}
    >
      {Array.from({ length: maxStars }, (_, i) => i + 1).map((star) => {
        const isFilled = star <= Math.floor(rating);
        const isHalf = !isFilled && star - 0.5 <= rating;
        const iconName = isFilled
          ? "star"
          : isHalf
            ? "star-half-full"
            : "star-outline";
        const iconColor =
          isFilled || isHalf ? color : (emptyColor ?? color + "40");

        if (isInteractive) {
          return (
            <TouchableOpacity
              key={star}
              onPress={() => onRate(star)}
              activeOpacity={0.7}
              accessibilityRole="button"
              accessibilityLabel={`Rate ${star} out of ${maxStars} stars`}
              accessibilityState={{ selected: star <= rating }}
            >
              <Icon name={iconName} size={size} color={iconColor} />
            </TouchableOpacity>
          );
        }

        return (
          <Icon key={star} name={iconName} size={size} color={iconColor} />
        );
      })}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: "row",
    gap: Spacing.xs,
  },
});

export const StarRating = memo(StarRatingComponent);
