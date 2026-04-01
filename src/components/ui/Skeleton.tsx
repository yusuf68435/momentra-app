/**
 * Skeleton Loading Components
 * Base Skeleton + preset compositions for cards, lists, profiles
 */

import React, { useEffect } from "react";
import { View, StyleSheet, ViewStyle } from "react-native";
import { LinearGradient } from "expo-linear-gradient";
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withRepeat,
  withTiming,
  Easing,
  interpolate,
  Extrapolation,
} from "react-native-reanimated";
import { BorderRadius, Spacing } from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";

// ─────────────────────────────────────────────
// BASE SKELETON
// ─────────────────────────────────────────────

interface SkeletonProps {
  width: number | string;
  height: number;
  borderRadius?: number;
  style?: ViewStyle;
}

export function Skeleton({
  width,
  height,
  borderRadius = BorderRadius.md,
  style,
}: SkeletonProps) {
  const { colors } = useTheme();
  const translateX = useSharedValue(-1);

  useEffect(() => {
    translateX.value = withRepeat(
      withTiming(1, { duration: 1200, easing: Easing.inOut(Easing.ease) }),
      -1,
      false,
    );

    return () => {
      translateX.value = -1;
    };
  }, [translateX]);

  const shimmerStyle = useAnimatedStyle(() => ({
    transform: [
      {
        translateX: interpolate(
          translateX.value,
          [-1, 1],
          [-200, 200],
          Extrapolation.CLAMP,
        ),
      },
    ],
  }));

  return (
    <View
      style={[
        {
          backgroundColor: colors.skeletonBase,
          width: width as number | undefined,
          height,
          borderRadius,
          overflow: "hidden",
        },
        style,
      ]}
    >
      <Animated.View style={[StyleSheet.absoluteFill, shimmerStyle]}>
        <LinearGradient
          colors={["transparent", colors.skeletonHighlight, "transparent"]}
          start={{ x: 0, y: 0 }}
          end={{ x: 1, y: 0 }}
          style={{ flex: 1, width: 200 }}
        />
      </Animated.View>
    </View>
  );
}

// ─────────────────────────────────────────────
// SKELETON CARD — mimics a primary Card layout
// ─────────────────────────────────────────────

interface SkeletonCardProps {
  /** Show image placeholder at top */
  showImage?: boolean;
  style?: ViewStyle;
}

export function SkeletonCard({ showImage = true, style }: SkeletonCardProps) {
  const { colors } = useTheme();
  return (
    <View
      style={[
        presetStyles.card,
        { backgroundColor: colors.surface, borderColor: colors.border + "50" },
        style,
      ]}
    >
      {showImage && <Skeleton width="100%" height={120} borderRadius={0} />}
      <View style={presetStyles.cardBody}>
        <Skeleton width="70%" height={18} borderRadius={BorderRadius.sm} />
        <Skeleton
          width="100%"
          height={14}
          borderRadius={BorderRadius.sm}
          style={{ marginTop: Spacing.sm }}
        />
        <Skeleton
          width="50%"
          height={14}
          borderRadius={BorderRadius.sm}
          style={{ marginTop: Spacing.xs }}
        />
        <View style={presetStyles.cardFooter}>
          <Skeleton width={60} height={12} borderRadius={BorderRadius.full} />
          <Skeleton width={40} height={12} borderRadius={BorderRadius.full} />
        </View>
      </View>
    </View>
  );
}

// ─────────────────────────────────────────────
// SKELETON LIST ITEM — mimics a compact Card / list row
// ─────────────────────────────────────────────

interface SkeletonListItemProps {
  /** Show circular avatar */
  showAvatar?: boolean;
  style?: ViewStyle;
}

export function SkeletonListItem({
  showAvatar = true,
  style,
}: SkeletonListItemProps) {
  return (
    <View style={[presetStyles.listItem, style]}>
      {showAvatar && (
        <Skeleton width={48} height={48} borderRadius={BorderRadius.md} />
      )}
      <View style={presetStyles.listContent}>
        <Skeleton width="60%" height={16} borderRadius={BorderRadius.sm} />
        <Skeleton
          width="85%"
          height={12}
          borderRadius={BorderRadius.sm}
          style={{ marginTop: Spacing.sm }}
        />
      </View>
      <Skeleton width={18} height={18} borderRadius={BorderRadius.sm} />
    </View>
  );
}

// ─────────────────────────────────────────────
// SKELETON PROFILE — mimics a profile header
// ─────────────────────────────────────────────

export function SkeletonProfile({ style }: { style?: ViewStyle }) {
  return (
    <View style={[presetStyles.profile, style]}>
      <Skeleton width={80} height={80} borderRadius={40} />
      <Skeleton
        width={140}
        height={20}
        borderRadius={BorderRadius.sm}
        style={{ marginTop: Spacing.md }}
      />
      <Skeleton
        width={100}
        height={14}
        borderRadius={BorderRadius.sm}
        style={{ marginTop: Spacing.sm }}
      />
      <View style={presetStyles.profileStats}>
        {[1, 2, 3].map((i) => (
          <View key={i} style={presetStyles.profileStat}>
            <Skeleton width={30} height={18} borderRadius={BorderRadius.sm} />
            <Skeleton
              width={50}
              height={12}
              borderRadius={BorderRadius.sm}
              style={{ marginTop: Spacing.xs }}
            />
          </View>
        ))}
      </View>
    </View>
  );
}

// ─────────────────────────────────────────────
// SKELETON BENTO — mimics a bento grid cell
// ─────────────────────────────────────────────

export function SkeletonBento({ style }: { style?: ViewStyle }) {
  const { colors } = useTheme();
  return (
    <View
      style={[
        presetStyles.bento,
        { backgroundColor: colors.surface, borderColor: colors.border + "40" },
        style,
      ]}
    >
      <Skeleton width={36} height={36} borderRadius={BorderRadius.md} />
      <Skeleton
        width="70%"
        height={14}
        borderRadius={BorderRadius.sm}
        style={{ marginTop: Spacing.sm }}
      />
      <Skeleton
        width="45%"
        height={11}
        borderRadius={BorderRadius.sm}
        style={{ marginTop: Spacing.xs }}
      />
    </View>
  );
}

// ─────────────────────────────────────────────
// STYLES
// ─────────────────────────────────────────────

const presetStyles = StyleSheet.create({
  card: {
    borderRadius: BorderRadius.lg,
    borderWidth: 0.5,
    overflow: "hidden",
  },
  cardBody: {
    padding: Spacing.md,
  },
  cardFooter: {
    flexDirection: "row",
    justifyContent: "space-between",
    marginTop: Spacing.md,
  },
  listItem: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
    paddingVertical: Spacing.smd,
    paddingHorizontal: Spacing.md,
  },
  listContent: {
    flex: 1,
  },
  profile: {
    alignItems: "center",
    paddingVertical: Spacing.lg,
  },
  profileStats: {
    flexDirection: "row",
    gap: Spacing.xl,
    marginTop: Spacing.lg,
  },
  profileStat: {
    alignItems: "center",
  },
  bento: {
    borderRadius: BorderRadius.lg,
    borderWidth: 0.5,
    padding: Spacing.md,
  },
});
