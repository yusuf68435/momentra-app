import React, { useState } from "react";
import { View, StyleSheet } from "react-native";
import { Image, ImageProps } from "expo-image";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import { useTheme } from "../../contexts/ThemeContext";

export interface CachedImageProps extends Omit<ImageProps, "source"> {
  uri: string | null | undefined;
  blurhash?: string;
  fallbackIcon?: string;
  size?: number;
}

const DEFAULT_TRANSITION_MS = 300;
const DEFAULT_FALLBACK_ICON = "image-off-outline";

export function CachedImage({
  uri,
  blurhash,
  fallbackIcon = DEFAULT_FALLBACK_ICON,
  size,
  style,
  contentFit = "cover",
  transition,
  placeholder,
  ...rest
}: CachedImageProps) {
  const [hasError, setHasError] = useState(false);
  const { colors } = useTheme();

  const sizeStyle = size ? { width: size, height: size } : undefined;

  // Show fallback when uri is missing or image failed to load
  if (!uri || hasError) {
    return (
      <View
        style={[
          styles.fallbackContainer,
          { backgroundColor: colors.surfaceVariant },
          sizeStyle,
          style,
        ]}
      >
        <Icon
          name={fallbackIcon as IconName}
          size={size ? size * 0.4 : 32}
          color={colors.textTertiary}
        />
      </View>
    );
  }

  return (
    <Image
      source={{ uri }}
      style={[sizeStyle, style]}
      contentFit={contentFit}
      cachePolicy="memory-disk"
      transition={transition ?? DEFAULT_TRANSITION_MS}
      placeholder={blurhash ? { blurhash } : placeholder}
      onError={() => setHasError(true)}
      recyclingKey={uri}
      {...rest}
    />
  );
}

const styles = StyleSheet.create({
  fallbackContainer: {
    alignItems: "center",
    justifyContent: "center",
    borderRadius: 8,
    overflow: "hidden",
  },
});

export default CachedImage;
