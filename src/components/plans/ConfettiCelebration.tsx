import React, { useEffect, useMemo } from 'react';
import { View, StyleSheet, Dimensions } from 'react-native';
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
  withDelay,
  Easing,
  runOnJS,
} from 'react-native-reanimated';
import { useTheme } from '../../contexts/ThemeContext';

interface ConfettiCelebrationProps {
  visible: boolean;
  onComplete?: () => void;
}

interface ParticleConfig {
  id: number;
  x: number;
  delay: number;
  duration: number;
  color: string;
  size: number;
  shape: 'circle' | 'square' | 'ribbon';
  rotation: number;
  swayAmount: number;
}

const { width: SCREEN_WIDTH, height: SCREEN_HEIGHT } = Dimensions.get('window');
const PARTICLE_COUNT = 60;
const DURATION = 3000;

function generateParticles(confettiColors: string[]): ParticleConfig[] {
  const particles: ParticleConfig[] = [];
  for (let i = 0; i < PARTICLE_COUNT; i++) {
    const shapes: ParticleConfig['shape'][] = ['circle', 'square', 'ribbon'];
    particles.push({
      id: i,
      x: Math.random() * SCREEN_WIDTH,
      delay: Math.random() * 800,
      duration: 2000 + Math.random() * 1500,
      color: confettiColors[Math.floor(Math.random() * confettiColors.length)],
      size: 6 + Math.random() * 10,
      shape: shapes[Math.floor(Math.random() * shapes.length)],
      rotation: Math.random() * 360,
      swayAmount: 20 + Math.random() * 60,
    });
  }
  return particles;
}

function ConfettiParticle({ config, visible }: { config: ParticleConfig; visible: boolean }) {
  const translateY = useSharedValue(-config.size);
  const translateX = useSharedValue(0);
  const rotate = useSharedValue(0);
  const opacity = useSharedValue(1);

  useEffect(() => {
    if (visible) {
      translateY.value = -config.size;
      translateX.value = 0;
      rotate.value = 0;
      opacity.value = 1;

      translateY.value = withDelay(
        config.delay,
        withTiming(SCREEN_HEIGHT + config.size, {
          duration: config.duration,
          easing: Easing.in(Easing.quad),
        })
      );

      translateX.value = withDelay(
        config.delay,
        withTiming(
          (Math.random() > 0.5 ? 1 : -1) * config.swayAmount,
          { duration: config.duration, easing: Easing.inOut(Easing.sin) }
        )
      );

      rotate.value = withDelay(
        config.delay,
        withTiming(config.rotation + 720, {
          duration: config.duration,
          easing: Easing.linear,
        })
      );

      opacity.value = withDelay(
        config.delay + config.duration * 0.7,
        withTiming(0, { duration: config.duration * 0.3 })
      );
    }
  }, [visible]);

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [
      { translateY: translateY.value },
      { translateX: translateX.value },
      { rotate: `${rotate.value}deg` },
    ],
    opacity: opacity.value,
  }));

  const shapeStyle = useMemo(() => {
    const base = {
      width: config.size,
      height: config.shape === 'ribbon' ? config.size * 2.5 : config.size,
      backgroundColor: config.color,
    };

    switch (config.shape) {
      case 'circle':
        return { ...base, borderRadius: config.size / 2 };
      case 'square':
        return { ...base, borderRadius: 2 };
      case 'ribbon':
        return { ...base, borderRadius: config.size / 4 };
    }
  }, [config]);

  return (
    <Animated.View
      style={[
        styles.particle,
        { left: config.x },
        animatedStyle,
      ]}
    >
      <View style={shapeStyle} />
    </Animated.View>
  );
}

export function ConfettiCelebration({ visible, onComplete }: ConfettiCelebrationProps) {
  const { colors } = useTheme();

  const confettiColors = useMemo(() => [
    colors.primary,
    colors.secondary,
    colors.accent,
    colors.success,
    colors.warning,
    colors.info,
    '#FF6B6B',
    '#4ECDC4',
    '#FFE66D',
    '#A8E6CF',
  ], [colors]);

  const particles = useMemo(() => generateParticles(confettiColors), [confettiColors]);

  useEffect(() => {
    if (visible && onComplete) {
      const timer = setTimeout(() => {
        onComplete();
      }, DURATION);
      return () => clearTimeout(timer);
    }
  }, [visible, onComplete]);

  if (!visible) {
    return null;
  }

  return (
    <View style={styles.container} pointerEvents="none">
      {particles.map((particle) => (
        <ConfettiParticle
          key={particle.id}
          config={particle}
          visible={visible}
        />
      ))}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    ...StyleSheet.absoluteFillObject,
    zIndex: 9999,
  },
  particle: {
    position: 'absolute',
    top: 0,
  },
});
