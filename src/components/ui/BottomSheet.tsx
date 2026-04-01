/**
 * Reusable Bottom Sheet with spring animation
 * - Gesture-driven drag to dismiss
 * - Configurable snap points
 * - Backdrop tap to close
 * - Handle indicator
 * - Spring physics from theme system
 */

import React, { useCallback, useEffect, useMemo } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Dimensions,
  TouchableWithoutFeedback,
  Platform,
  BackHandler,
  KeyboardAvoidingView,
} from 'react-native';
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withSpring,
  withTiming,
  runOnJS,
  interpolate,
  Extrapolation,
} from 'react-native-reanimated';
import { Gesture, GestureDetector, GestureHandlerRootView } from 'react-native-gesture-handler';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useTheme } from '../../contexts/ThemeContext';
import {
  BorderRadius,
  Spacing,
  Typography,
  BottomSheet as BottomSheetConfig,
  DarkElevation,
} from '../../constants/theme';
import { SpringPresets } from '../../utils/animations';

const { height: SCREEN_HEIGHT } = Dimensions.get('window');

type SnapPoint = number | `${number}%`;

interface BottomSheetProps {
  visible: boolean;
  onClose: () => void;
  children: React.ReactNode;
  /** Title shown in the handle area */
  title?: string;
  /** Snap points as px or percentage of screen. Default: ['50%'] */
  snapPoints?: SnapPoint[];
  /** Initial snap point index. Default: 0 */
  initialSnap?: number;
  /** Enable backdrop tap to close. Default: true */
  backdropClose?: boolean;
  /** Show handle indicator. Default: true */
  showHandle?: boolean;
}

function resolveSnapPoint(sp: SnapPoint): number {
  if (typeof sp === 'number') return sp;
  const pct = parseInt(sp, 10) / 100;
  return SCREEN_HEIGHT * pct;
}

export function BottomSheet({
  visible,
  onClose,
  children,
  title,
  snapPoints = ['50%'],
  initialSnap = 0,
  backdropClose = true,
  showHandle = true,
}: BottomSheetProps) {
  const { colors, isDark } = useTheme();
  const insets = useSafeAreaInsets();

  const resolvedSnaps = useMemo(
    () => snapPoints.map(resolveSnapPoint).sort((a, b) => a - b),
    [snapPoints]
  );

  const sheetHeight = resolvedSnaps[resolvedSnaps.length - 1] + insets.bottom + Spacing.md;
  const initialOffset = SCREEN_HEIGHT - resolvedSnaps[initialSnap];

  const translateY = useSharedValue(SCREEN_HEIGHT);
  const backdropOpacity = useSharedValue(0);
  const context = useSharedValue({ y: 0 });

  // Open/close
  useEffect(() => {
    if (visible) {
      translateY.value = withSpring(initialOffset, SpringPresets.sheet);
      backdropOpacity.value = withTiming(1, { duration: 250 });
    } else {
      translateY.value = withSpring(SCREEN_HEIGHT, SpringPresets.sheet);
      backdropOpacity.value = withTiming(0, { duration: 200 });
    }
  }, [visible, initialOffset, translateY, backdropOpacity]);

  // Android back button
  useEffect(() => {
    if (!visible) return;
    const handler = BackHandler.addEventListener('hardwareBackPress', () => {
      onClose();
      return true;
    });
    return () => handler.remove();
  }, [visible, onClose]);

  const closeSheet = useCallback(() => {
    onClose();
  }, [onClose]);

  // Pan gesture for drag
  const panGesture = Gesture.Pan()
    .onStart(() => {
      context.value = { y: translateY.value };
    })
    .onUpdate((event) => {
      // Only allow dragging down (or up to max snap)
      const maxUp = SCREEN_HEIGHT - resolvedSnaps[resolvedSnaps.length - 1];
      translateY.value = Math.max(maxUp, context.value.y + event.translationY);
    })
    .onEnd((event) => {
      // If dragged down past threshold, close
      const velocity = event.velocityY;
      const currentPos = translateY.value;
      const dismissThreshold = SCREEN_HEIGHT - resolvedSnaps[0] * 0.5;

      if (currentPos > dismissThreshold || velocity > 500) {
        translateY.value = withSpring(SCREEN_HEIGHT, SpringPresets.sheet);
        backdropOpacity.value = withTiming(0, { duration: 200 });
        runOnJS(closeSheet)();
      } else {
        // Snap to nearest
        let nearest = resolvedSnaps[0];
        let minDist = Infinity;
        for (const snap of resolvedSnaps) {
          const snapPos = SCREEN_HEIGHT - snap;
          const dist = Math.abs(currentPos - snapPos);
          if (dist < minDist) {
            minDist = dist;
            nearest = snap;
          }
        }
        translateY.value = withSpring(SCREEN_HEIGHT - nearest, SpringPresets.sheet);
      }
    });

  const sheetAnimatedStyle = useAnimatedStyle(() => ({
    transform: [{ translateY: translateY.value }],
  }));

  const backdropAnimatedStyle = useAnimatedStyle(() => ({
    opacity: interpolate(
      backdropOpacity.value,
      [0, 1],
      [0, 1],
      Extrapolation.CLAMP
    ),
    pointerEvents: backdropOpacity.value > 0 ? 'auto' as const : 'none' as const,
  }));

  const surfaceBg = isDark ? DarkElevation.level2 : colors.surface;

  if (!visible) return null;

  return (
    <View style={StyleSheet.absoluteFill} pointerEvents="box-none" accessibilityRole="none" accessibilityLabel={title}>
      {/* Backdrop */}
      <TouchableWithoutFeedback onPress={backdropClose ? closeSheet : undefined}>
        <Animated.View
          style={[
            styles.backdrop,
            { backgroundColor: colors.overlay },
            backdropAnimatedStyle,
          ]}
        />
      </TouchableWithoutFeedback>

      {/* Sheet */}
      <GestureDetector gesture={panGesture}>
        <Animated.View
          style={[
            styles.sheet,
            {
              height: sheetHeight,
              backgroundColor: surfaceBg,
              paddingBottom: insets.bottom + Spacing.md,
            },
            sheetAnimatedStyle,
          ]}
        >
          {/* Handle */}
          {showHandle && (
            <View style={styles.handleContainer}>
              <View
                style={[
                  styles.handle,
                  { backgroundColor: isDark ? colors.textTertiary : BottomSheetConfig.handleColor },
                ]}
              />
            </View>
          )}

          {/* Title */}
          {title && (
            <View style={styles.titleContainer}>
              <Text style={[Typography.h3, { color: colors.text }]}>{title}</Text>
            </View>
          )}

          {/* Content */}
          <KeyboardAvoidingView
            behavior={Platform.OS === 'ios' ? 'padding' : undefined}
            style={styles.content}
          >
            {children}
          </KeyboardAvoidingView>
        </Animated.View>
      </GestureDetector>
    </View>
  );
}

const styles = StyleSheet.create({
  backdrop: {
    ...StyleSheet.absoluteFillObject,
  },
  sheet: {
    position: 'absolute',
    left: 0,
    right: 0,
    borderTopLeftRadius: BorderRadius.xl,
    borderTopRightRadius: BorderRadius.xl,
    overflow: 'hidden',
  },
  handleContainer: {
    alignItems: 'center',
    paddingTop: Spacing.sm + 2,
    paddingBottom: Spacing.xs,
  },
  handle: {
    width: BottomSheetConfig.handleWidth,
    height: BottomSheetConfig.handleHeight,
    borderRadius: BottomSheetConfig.handleRadius,
  },
  titleContainer: {
    paddingHorizontal: Spacing.lg,
    paddingTop: Spacing.sm,
    paddingBottom: Spacing.md,
  },
  content: {
    flex: 1,
    paddingHorizontal: Spacing.lg,
  },
});
