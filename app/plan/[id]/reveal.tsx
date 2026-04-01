import React, { useEffect, useMemo } from "react";
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Dimensions,
} from "react-native";
import { useLocalSearchParams, useRouter } from "expo-router";
import { useTranslation } from "react-i18next";
import { LinearGradient } from "expo-linear-gradient";
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
  withRepeat,
  withSequence,
  withDelay,
  withSpring,
  FadeIn,
  FadeInDown,
} from "react-native-reanimated";
import { Icon } from "../../../src/components/ui/Icon";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
  getGradient,
} from "../../../src/constants/theme";
import { useTheme } from "../../../src/contexts/ThemeContext";
import { usePlanStore } from "../../../src/stores/planStore";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";

const { width: SCREEN_WIDTH, height: SCREEN_HEIGHT } = Dimensions.get("window");

// ─────────────────────────────────────────────
// CONFETTI PARTICLE COLORS
// ─────────────────────────────────────────────
const CONFETTI_COLORS = [
  "#FF6B8A", // Rose Coral
  "#FFB347", // Golden Amber
  "#B8A9E8", // Soft Lavender
  "#34D399", // Mint Green
  "#5AC8FA", // Sky Blue
  "#FF85A0", // Soft Pink
  "#FFD700", // Gold
  "#FF4500", // Orange Red
  "#00CED1", // Dark Turquoise
  "#DA70D6", // Orchid
];

// ─────────────────────────────────────────────
// CONFETTI PARTICLE COMPONENT
// ─────────────────────────────────────────────
interface ConfettiParticleProps {
  x: number;
  color: string;
  size: number;
  delay: number;
  duration: number;
}

function ConfettiParticle({
  x,
  color,
  size,
  delay,
  duration,
}: ConfettiParticleProps) {
  const translateY = useSharedValue(-20);
  const opacity = useSharedValue(0);
  const rotate = useSharedValue(0);
  const translateX = useSharedValue(0);

  useEffect(() => {
    const drift = (Math.random() - 0.5) * 80;
    translateY.value = withDelay(
      delay,
      withRepeat(
        withSequence(
          withTiming(-20, { duration: 0 }),
          withTiming(SCREEN_HEIGHT + 40, { duration }),
        ),
        -1,
        false,
      ),
    );
    opacity.value = withDelay(
      delay,
      withRepeat(
        withSequence(
          withTiming(0, { duration: 0 }),
          withTiming(1, { duration: 200 }),
          withTiming(1, { duration: duration - 400 }),
          withTiming(0, { duration: 200 }),
        ),
        -1,
        false,
      ),
    );
    rotate.value = withDelay(
      delay,
      withRepeat(withTiming(360, { duration: duration * 0.7 }), -1, false),
    );
    translateX.value = withDelay(
      delay,
      withRepeat(
        withSequence(
          withTiming(0, { duration: 0 }),
          withTiming(drift, { duration }),
        ),
        -1,
        false,
      ),
    );
  }, []);

  const animStyle = useAnimatedStyle(() => ({
    opacity: opacity.value,
    transform: [
      { translateY: translateY.value },
      { translateX: translateX.value },
      { rotate: `${rotate.value}deg` },
    ],
  }));

  const isCircle = size % 2 === 0;

  return (
    <Animated.View
      style={[
        {
          position: "absolute",
          left: x,
          top: 0,
          width: size,
          height: isCircle ? size : size * 1.6,
          backgroundColor: color,
          borderRadius: isCircle ? size / 2 : 2,
        },
        animStyle,
      ]}
    />
  );
}

// ─────────────────────────────────────────────
// CONFETTI FIELD — generates N particles
// ─────────────────────────────────────────────
function ConfettiField() {
  const particles = useMemo(() => {
    return Array.from({ length: 28 }, (_, i) => ({
      id: i,
      x: Math.random() * SCREEN_WIDTH,
      color: CONFETTI_COLORS[i % CONFETTI_COLORS.length],
      size: Math.floor(Math.random() * 8) + 6, // 6–13px
      delay: Math.floor(Math.random() * 2000),
      duration: Math.floor(Math.random() * 1500) + 2500, // 2500–4000ms
    }));
  }, []);

  return (
    <View style={StyleSheet.absoluteFillObject} pointerEvents="none">
      {particles.map((p) => (
        <ConfettiParticle
          key={p.id}
          x={p.x}
          color={p.color}
          size={p.size}
          delay={p.delay}
          duration={p.duration}
        />
      ))}
    </View>
  );
}

// ─────────────────────────────────────────────
// PULSING EMOJI COMPONENT
// ─────────────────────────────────────────────
function PulsingEmoji() {
  const scale = useSharedValue(0);

  useEffect(() => {
    scale.value = withSequence(
      withSpring(1.2, { damping: 8, stiffness: 200 }),
      withSpring(1.0, { damping: 12, stiffness: 150 }),
      withDelay(
        1200,
        withRepeat(
          withSequence(
            withTiming(1.08, { duration: 700 }),
            withTiming(1.0, { duration: 700 }),
          ),
          -1,
          true,
        ),
      ),
    );
  }, []);

  const animStyle = useAnimatedStyle(() => ({
    transform: [{ scale: scale.value }],
  }));

  return (
    <Animated.Text style={[{ fontSize: 80, textAlign: "center" }, animStyle]}>
      🎉
    </Animated.Text>
  );
}

// ─────────────────────────────────────────────
// MAIN SCREEN
// ─────────────────────────────────────────────
export default function RevealScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const router = useRouter();
  const { colors, isDark } = useTheme();
  const { t } = useTranslation();
  const { plans } = usePlanStore();

  const plan = plans.find((p) => p.id === id);

  const styles = useMemo(() => createStyles(colors), [colors]);

  if (!plan) {
    return (
      <LinearGradient
        colors={getGradient(isDark, "joy") as [string, string]}
        style={styles.container}
      >
        <Text style={styles.notFound}>{t("planReveal.notFound")}</Text>
      </LinearGradient>
    );
  }

  const handleAddMemory = () => {
    router.push(`/plan/${id}/memories` as any);
  };

  const handleComplete = () => {
    router.push(`/plan/${id}/complete` as any);
  };

  return (
    <ScreenErrorBoundary>
      <LinearGradient
        colors={getGradient(isDark, "reveal") as [string, string, string]}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 1 }}
        style={styles.container}
      >
        {/* Confetti Layer */}
        <ConfettiField />

        {/* Overlay for depth */}
        <View style={styles.overlay} />

        {/* Back button */}
        <TouchableOpacity
          style={styles.backButton}
          onPress={() => router.back()}
          activeOpacity={0.7}
        >
          <Icon name="arrow-left" size={24} color="rgba(255,255,255,0.9)" />
        </TouchableOpacity>

        {/* Main content */}
        <View style={styles.content}>
          {/* Big pulsing emoji */}
          <Animated.View entering={FadeIn.delay(100).duration(400)}>
            <PulsingEmoji />
          </Animated.View>

          {/* SÜRPRIZ! / SURPRISE! */}
          <Animated.View
            entering={FadeInDown.delay(300).duration(500).springify()}
          >
            <Text style={styles.surpriseTitle}>
              {t("planReveal.surpriseTitle")}
            </Text>
            <Text style={styles.surpriseSubtitle}>
              {t("planReveal.surpriseSubtitle")}
            </Text>
          </Animated.View>

          {/* Recipient greeting */}
          {plan.recipient_name ? (
            <Animated.View
              entering={FadeInDown.delay(500).duration(500)}
              style={styles.recipientCard}
            >
              <Text style={styles.recipientText}>
                ❤️{"  "}
                {t("planReveal.congratulations", { name: plan.recipient_name })}
              </Text>
            </Animated.View>
          ) : (
            <Animated.View
              entering={FadeInDown.delay(500).duration(500)}
              style={styles.recipientCard}
            >
              <Text style={styles.recipientText}>
                ❤️{"  "}
                {t("planReveal.enjoyMoment")}
              </Text>
            </Animated.View>
          )}

          {/* Plan title */}
          <Animated.Text
            entering={FadeInDown.delay(650).duration(400)}
            style={styles.planTitle}
          >
            {plan.title}
          </Animated.Text>

          {/* Tip card */}
          <Animated.View
            entering={FadeInDown.delay(800).duration(400)}
            style={styles.tipCard}
          >
            <Icon name="camera" size={22} color="rgba(255,255,255,0.9)" />
            <Text style={styles.tipText}>{t("planReveal.takePhotos")}</Text>
          </Animated.View>
        </View>

        {/* Action buttons */}
        <Animated.View
          entering={FadeInDown.delay(1000).duration(500).springify()}
          style={styles.buttonsContainer}
        >
          <TouchableOpacity
            style={styles.primaryButton}
            onPress={handleAddMemory}
            activeOpacity={0.85}
          >
            <Icon name="camera-plus" size={20} color={colors.primary} />
            <Text style={styles.primaryButtonText}>
              {t("planReveal.addMemoryButton")}
            </Text>
          </TouchableOpacity>

          <TouchableOpacity
            style={styles.secondaryButton}
            onPress={handleComplete}
            activeOpacity={0.85}
          >
            <Icon
              name="check-circle-outline"
              size={20}
              color="rgba(255,255,255,0.9)"
            />
            <Text style={styles.secondaryButtonText}>
              {t("planReveal.completePlanButton")}
            </Text>
          </TouchableOpacity>
        </Animated.View>
      </LinearGradient>
    </ScreenErrorBoundary>
  );
}

// ─────────────────────────────────────────────
// STYLES
// ─────────────────────────────────────────────
const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      flex: 1,
    },
    overlay: {
      ...StyleSheet.absoluteFillObject,
      backgroundColor: "rgba(0,0,0,0.08)",
    },
    backButton: {
      position: "absolute",
      top: Spacing.xxl + Spacing.sm,
      left: Spacing.lg,
      zIndex: 10,
      width: 44,
      height: 44,
      borderRadius: 22,
      backgroundColor: "rgba(255,255,255,0.2)",
      alignItems: "center",
      justifyContent: "center",
    },
    content: {
      flex: 1,
      alignItems: "center",
      justifyContent: "center",
      paddingHorizontal: Spacing.xl,
      paddingTop: Spacing.xxl,
      gap: Spacing.md,
    },
    surpriseTitle: {
      fontSize: 52,
      fontWeight: "800",
      color: "#FFFFFF",
      textAlign: "center",
      letterSpacing: 3,
      textShadowColor: "rgba(0,0,0,0.25)",
      textShadowOffset: { width: 0, height: 2 },
      textShadowRadius: 8,
    },
    surpriseSubtitle: {
      ...Typography.h3,
      color: "rgba(255,255,255,0.85)",
      textAlign: "center",
      letterSpacing: 2,
      marginTop: Spacing.xs,
    },
    recipientCard: {
      backgroundColor: "rgba(255,255,255,0.18)",
      borderRadius: BorderRadius.xl,
      paddingVertical: Spacing.md,
      paddingHorizontal: Spacing.lg,
      borderWidth: 1,
      borderColor: "rgba(255,255,255,0.3)",
      marginTop: Spacing.sm,
    },
    recipientText: {
      ...Typography.h4,
      color: "#FFFFFF",
      textAlign: "center",
    },
    planTitle: {
      ...Typography.body,
      color: "rgba(255,255,255,0.8)",
      textAlign: "center",
      fontStyle: "italic",
    },
    tipCard: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      backgroundColor: "rgba(255,255,255,0.15)",
      borderRadius: BorderRadius.lg,
      paddingVertical: Spacing.smd,
      paddingHorizontal: Spacing.md,
      borderWidth: 1,
      borderColor: "rgba(255,255,255,0.25)",
      marginTop: Spacing.sm,
    },
    tipText: {
      ...Typography.bodySmall,
      color: "rgba(255,255,255,0.9)",
      flex: 1,
    },
    buttonsContainer: {
      paddingHorizontal: Spacing.lg,
      paddingBottom: Spacing.xxl + Spacing.md,
      gap: Spacing.md,
    },
    primaryButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.xl,
      paddingVertical: Spacing.md + 2,
      paddingHorizontal: Spacing.lg,
      ...Shadows.lg,
    },
    primaryButtonText: {
      ...Typography.button,
      color: colors.primary,
    },
    secondaryButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      backgroundColor: "rgba(255,255,255,0.18)",
      borderRadius: BorderRadius.xl,
      paddingVertical: Spacing.md + 2,
      paddingHorizontal: Spacing.lg,
      borderWidth: 1.5,
      borderColor: "rgba(255,255,255,0.5)",
    },
    secondaryButtonText: {
      ...Typography.button,
      color: "#FFFFFF",
    },
    notFound: {
      ...Typography.body,
      color: "#FFFFFF",
      textAlign: "center",
      marginTop: Spacing.xxl,
    },
  });
