import React, { useEffect, useCallback } from "react";
import { StyleSheet, Text, View, Platform } from "react-native";
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
  withSpring,
  runOnJS,
  Easing,
} from "react-native-reanimated";
import { Gesture, GestureDetector } from "react-native-gesture-handler";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import {
  Spacing,
  BorderRadius,
  Typography,
  Shadows,
} from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";
import type { ThemeColors } from "../../constants/theme";

export type ToastType = "success" | "error" | "warning" | "info";

export interface ToastData {
  id: string;
  message: string;
  type: ToastType;
  duration: number;
}

interface ToastProps {
  toast: ToastData;
  onDismiss: (id: string) => void;
}

const ICON_MAP: Record<ToastType, IconName> = {
  success: "check-circle",
  error: "alert-circle",
  warning: "alert",
  info: "information",
};

function getColorMap(
  colors: ThemeColors,
): Record<ToastType, { background: string; border: string; icon: string }> {
  return {
    success: {
      background: colors.success + "15",
      border: colors.success,
      icon: colors.success,
    },
    error: {
      background: colors.error + "15",
      border: colors.error,
      icon: colors.error,
    },
    warning: {
      background: colors.warning + "15",
      border: colors.warning,
      icon: colors.warning,
    },
    info: {
      background: colors.info + "15",
      border: colors.info,
      icon: colors.info,
    },
  };
}

const DISMISS_THRESHOLD = -80;
const ANIMATION_DURATION = 300;

export function Toast({ toast, onDismiss }: ToastProps) {
  const insets = useSafeAreaInsets();
  const { colors } = useTheme();
  const translateY = useSharedValue(-100);
  const translateX = useSharedValue(0);
  const opacity = useSharedValue(0);
  const toastColors = getColorMap(colors)[toast.type];
  const iconName = ICON_MAP[toast.type];

  const dismiss = useCallback(() => {
    translateY.value = withTiming(-100, {
      duration: ANIMATION_DURATION,
      easing: Easing.inOut(Easing.ease),
    });
    opacity.value = withTiming(0, { duration: ANIMATION_DURATION }, () => {
      runOnJS(onDismiss)(toast.id);
    });
  }, [toast.id, onDismiss]);

  useEffect(() => {
    // Enter animation
    translateY.value = withSpring(0, { damping: 18, stiffness: 140 });
    opacity.value = withTiming(1, { duration: ANIMATION_DURATION });

    // Auto-dismiss timer
    const timer = setTimeout(() => {
      dismiss();
    }, toast.duration);

    return () => clearTimeout(timer);
  }, [toast.duration, dismiss]);

  const panGesture = Gesture.Pan()
    .onUpdate((event) => {
      // Allow upward swipe and horizontal swipe
      if (event.translationY < 0) {
        translateY.value = event.translationY;
      }
      translateX.value = event.translationX;
    })
    .onEnd((event) => {
      if (
        event.translationY < DISMISS_THRESHOLD ||
        Math.abs(event.translationX) > 120
      ) {
        // Dismiss via swipe
        translateY.value = withTiming(-200, { duration: 200 });
        opacity.value = withTiming(0, { duration: 200 }, () => {
          runOnJS(onDismiss)(toast.id);
        });
      } else {
        // Snap back
        translateY.value = withSpring(0, { damping: 18, stiffness: 140 });
        translateX.value = withSpring(0, { damping: 18, stiffness: 140 });
      }
    });

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [
      { translateY: translateY.value },
      { translateX: translateX.value },
    ],
    opacity: opacity.value,
  }));

  return (
    <GestureDetector gesture={panGesture}>
      <Animated.View
        style={[
          styles.container,
          {
            top: insets.top + Spacing.sm,
            backgroundColor: toastColors.background,
            borderLeftColor: toastColors.border,
          },
          Shadows.lg,
          animatedStyle,
        ]}
      >
        <View style={styles.iconContainer}>
          <Icon name={iconName} size={22} color={toastColors.icon} />
        </View>
        <Text
          style={[styles.message, { color: colors.text }]}
          numberOfLines={3}
        >
          {toast.message}
        </Text>
      </Animated.View>
    </GestureDetector>
  );
}

const styles = StyleSheet.create({
  container: {
    position: "absolute",
    left: Spacing.md,
    right: Spacing.md,
    flexDirection: "row",
    alignItems: "center",
    paddingVertical: Spacing.md,
    paddingHorizontal: Spacing.md,
    borderRadius: BorderRadius.md,
    borderLeftWidth: 4,
    zIndex: 9999,
    ...Platform.select({
      android: {
        elevation: 8,
      },
    }),
  },
  iconContainer: {
    marginRight: Spacing.sm + 4,
  },
  message: {
    flex: 1,
    fontSize: Typography.bodySmall.fontSize,
    fontWeight: Typography.bodySmall.fontWeight,
    lineHeight: Typography.bodySmall.lineHeight,
  },
});
