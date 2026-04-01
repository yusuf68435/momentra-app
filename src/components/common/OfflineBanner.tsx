import React, { useEffect, useRef } from "react";
import { Text, StyleSheet } from "react-native";
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
  interpolateColor,
} from "react-native-reanimated";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import { useNetworkStore } from "../../stores/networkStore";
import { Typography, Spacing } from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";

type BannerState = "hidden" | "offline" | "reconnected";

const RECONNECTED_VISIBLE_MS = 2500;
const ANIM_DURATION = 300;

export function OfflineBanner() {
  const isOnline = useNetworkStore((s) => s.isOnline);
  const lastChecked = useNetworkStore((s) => s.lastChecked);
  const { t } = useTranslation("common");
  const insets = useSafeAreaInsets();
  const { colors } = useTheme();

  const bannerState = useRef<BannerState>("hidden");
  const translateY = useSharedValue(-200);
  const opacity = useSharedValue(0);
  const bgColorProgress = useSharedValue(0); // 0 = offline red, 1 = reconnected green
  const reconnectTimer = useRef<ReturnType<typeof setTimeout> | null>(null);

  const show = (state: BannerState) => {
    bannerState.current = state;
    bgColorProgress.value = state === "offline" ? 0 : 1;
    opacity.value = withTiming(1, { duration: ANIM_DURATION });
    translateY.value = withTiming(0, { duration: ANIM_DURATION });
  };

  const hide = () => {
    translateY.value = withTiming(-200, { duration: ANIM_DURATION });
    opacity.value = withTiming(0, { duration: ANIM_DURATION });
    bannerState.current = "hidden";
  };

  useEffect(() => {
    // Skip the very first check (lastChecked null = not yet checked)
    if (lastChecked === null) return;

    if (reconnectTimer.current) {
      clearTimeout(reconnectTimer.current);
      reconnectTimer.current = null;
    }

    if (!isOnline) {
      show("offline");
    } else if (bannerState.current === "offline") {
      // Was offline, now back online — show green flash
      show("reconnected");
      reconnectTimer.current = setTimeout(() => {
        hide();
      }, RECONNECTED_VISIBLE_MS);
    }
    // If already online and was never offline, don't show anything
  }, [isOnline, lastChecked]);

  const errorColor = colors.error;
  const successColor = colors.success;

  const animStyle = useAnimatedStyle(() => ({
    transform: [{ translateY: translateY.value }],
    opacity: opacity.value,
    backgroundColor: interpolateColor(
      bgColorProgress.value,
      [0, 1],
      [errorColor, successColor],
    ),
  }));

  return (
    <Animated.View
      style={[
        styles.banner,
        animStyle,
        {
          paddingTop: insets.top + Spacing.xs,
        },
      ]}
      pointerEvents="none"
    >
      <Icon
        name={isOnline ? "check-circle" : "wifi-off"}
        size={16}
        color={colors.textOnPrimary}
      />
      <Text style={[styles.text, { color: colors.textOnPrimary }]}>
        {isOnline ? t("common.back_online") : t("common.offline")}
      </Text>
    </Animated.View>
  );
}

const styles = StyleSheet.create({
  banner: {
    position: "absolute",
    top: 0,
    left: 0,
    right: 0,
    zIndex: 9999,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.xs,
    paddingBottom: Spacing.sm,
    paddingHorizontal: Spacing.lg,
  },
  text: {
    ...Typography.caption,
    fontWeight: "600",
  },
});
