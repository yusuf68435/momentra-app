import React from "react";
import {
  TouchableOpacity,
  StyleSheet,
  type StyleProp,
  type ViewStyle,
} from "react-native";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import { useFavoriteStore } from "../../stores/favoriteStore";
import { useTheme } from "../../contexts/ThemeContext";
import { hapticLight } from "../../utils/haptics";

interface FavoriteButtonProps {
  scenarioId: string;
  size?: number;
  style?: StyleProp<ViewStyle>;
}

export function FavoriteButton({
  scenarioId,
  size = 24,
  style,
}: FavoriteButtonProps) {
  const { colors } = useTheme();
  const isFavorited = useFavoriteStore((state) =>
    state.favoriteIds.includes(scenarioId),
  );
  const toggle = useFavoriteStore((state) => state.toggle);

  const handlePress = () => {
    hapticLight();
    toggle(scenarioId);
  };

  return (
    <TouchableOpacity
      style={[styles.button, style]}
      onPress={handlePress}
      activeOpacity={0.7}
      accessibilityRole="button"
      accessibilityLabel={
        isFavorited ? "Remove from favorites" : "Add to favorites"
      }
    >
      <Icon
        name={isFavorited ? "heart" : "heart-outline"}
        size={size}
        color={isFavorited ? colors.error : colors.textSecondary}
      />
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  button: {
    padding: 8,
    borderRadius: 20,
  },
});
