import React, { useCallback, useMemo } from "react";
import { View, TouchableOpacity, StyleSheet } from "react-native";
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withSpring,
  withSequence,
  withTiming,
} from "react-native-reanimated";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import { useTheme } from "../../contexts/ThemeContext";

const SIZE_MAP = {
  sm: 16,
  md: 24,
  lg: 32,
};

interface StarRatingProps {
  rating: number;
  maxStars?: number;
  size?: "sm" | "md" | "lg";
  interactive?: boolean;
  onRate?: (rating: number) => void;
  showHalfStars?: boolean;
  style?: object;
}

function AnimatedStar({
  filled,
  half,
  size,
  index,
  interactive,
  onPress,
  starColor,
  starEmptyColor,
}: {
  filled: boolean;
  half: boolean;
  size: number;
  index: number;
  interactive: boolean;
  onPress?: () => void;
  starColor: string;
  starEmptyColor: string;
}) {
  const scale = useSharedValue(1);

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ scale: scale.value }],
  }));

  const handlePress = useCallback(() => {
    if (!interactive || !onPress) return;
    scale.value = withSequence(
      withSpring(1.4, { damping: 4, stiffness: 300 }),
      withSpring(1, { damping: 6, stiffness: 200 }),
    );
    onPress();
  }, [interactive, onPress]);

  const iconName = filled ? "star" : half ? "star-half-full" : "star-outline";

  const color = filled || half ? starColor : starEmptyColor;

  const star = (
    <Animated.View style={[animatedStyle, { marginHorizontal: 1 }]}>
      <Icon name={iconName as IconName} size={size} color={color} />
    </Animated.View>
  );

  if (interactive) {
    return (
      <TouchableOpacity
        onPress={handlePress}
        activeOpacity={0.7}
        hitSlop={{ top: 8, bottom: 8, left: 4, right: 4 }}
      >
        {star}
      </TouchableOpacity>
    );
  }

  return star;
}

export function StarRating({
  rating,
  maxStars = 5,
  size = "md",
  interactive = false,
  onRate,
  showHalfStars = false,
  style,
}: StarRatingProps) {
  const { colors } = useTheme();
  const starSize = SIZE_MAP[size];

  const starColor = colors.warning;
  const starEmptyColor = colors.textTertiary;

  return (
    <View style={[styles.container, style]}>
      {Array.from({ length: maxStars }, (_, i) => {
        const starIndex = i + 1;
        const filled = starIndex <= Math.floor(rating);
        const half =
          showHalfStars &&
          !filled &&
          starIndex === Math.floor(rating) + 1 &&
          rating % 1 >= 0.25 &&
          rating % 1 < 0.75;

        return (
          <AnimatedStar
            key={i}
            filled={filled || (showHalfStars && starIndex <= rating)}
            half={half}
            size={starSize}
            index={i}
            interactive={interactive}
            onPress={() => onRate?.(starIndex)}
            starColor={starColor}
            starEmptyColor={starEmptyColor}
          />
        );
      })}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: "row",
    alignItems: "center",
  },
});
