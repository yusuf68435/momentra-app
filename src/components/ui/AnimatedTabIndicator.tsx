import React, { useEffect } from "react";
import { View, StyleSheet } from "react-native";
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withSpring,
} from "react-native-reanimated";
import { Springs } from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";

interface AnimatedTabIndicatorProps {
  tabCount: number;
  activeIndex: number;
  tabWidth: number;
  height?: number;
  color?: string;
}

export function AnimatedTabIndicator({
  tabCount,
  activeIndex,
  tabWidth,
  height = 3,
  color,
}: AnimatedTabIndicatorProps) {
  const { colors } = useTheme();
  const indicatorColor = color || colors.primary;
  const translateX = useSharedValue(activeIndex * tabWidth);

  useEffect(() => {
    translateX.value = withSpring(activeIndex * tabWidth, Springs.snappy);
  }, [activeIndex, tabWidth]);

  const indicatorStyle = useAnimatedStyle(() => ({
    transform: [{ translateX: translateX.value }],
  }));

  return (
    <View style={[styles.track, { height }]}>
      <Animated.View
        style={[
          styles.indicator,
          {
            width: tabWidth * 0.6,
            marginLeft: tabWidth * 0.2,
            height,
            backgroundColor: indicatorColor,
            borderRadius: height / 2,
          },
          indicatorStyle,
        ]}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  track: {
    position: "relative",
    width: "100%",
  },
  indicator: {
    position: "absolute",
    bottom: 0,
  },
});
