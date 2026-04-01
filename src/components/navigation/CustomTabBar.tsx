/**
 * Standard iOS-style Bottom Tab Bar
 * - iOS: BlurView background (system chrome)
 * - Android: Solid surface background
 * - All tabs show icon + label at all times
 */

import React from "react";
import {
  View,
  TouchableOpacity,
  Text,
  StyleSheet,
  Platform,
} from "react-native";
import { BlurView } from "expo-blur";
// BlurView is only rendered on iOS so the import is safe on all platforms.
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";
import type { BottomTabBarProps } from "@react-navigation/bottom-tabs";
import { useTheme } from "../../contexts/ThemeContext";
import { hapticLight } from "../../utils/haptics";
import { a11yTab } from "../../utils/accessibility";

// Tab icons mapping (route name → icon)
const TAB_ICONS: Record<string, string> = {
  index: "home",
  explore: "compass-outline",
  plans: "clipboard-check-outline",
  ai: "robot-outline",
  community: "account-group-outline",
  profile: "account-circle-outline",
};

// Active icons (filled variants)
const TAB_ICONS_ACTIVE: Record<string, string> = {
  index: "home",
  explore: "compass",
  plans: "clipboard-check",
  ai: "robot",
  community: "account-group",
  profile: "account-circle",
};

export function CustomTabBar({
  state,
  descriptors,
  navigation,
}: BottomTabBarProps) {
  const { colors, isDark } = useTheme();

  const renderTab = (route: (typeof state.routes)[0], index: number) => {
    const { options } = descriptors[route.key];
    const label =
      typeof options.tabBarLabel === "string"
        ? options.tabBarLabel
        : typeof options.title === "string"
          ? options.title
          : route.name;

    const isFocused = state.index === index;
    const iconName =
      (isFocused ? TAB_ICONS_ACTIVE[route.name] : TAB_ICONS[route.name]) ||
      "circle";
    const tintColor = isFocused ? colors.primary : colors.textTertiary;

    return (
      <TouchableOpacity
        key={route.key}
        onPress={() => {
          hapticLight();
          const event = navigation.emit({
            type: "tabPress",
            target: route.key,
            canPreventDefault: true,
          });
          if (!isFocused && !event.defaultPrevented) {
            navigation.navigate(route.name, route.params);
          }
        }}
        onLongPress={() => {
          navigation.emit({ type: "tabLongPress", target: route.key });
        }}
        style={styles.tabItem}
        activeOpacity={0.7}
        {...a11yTab(label, isFocused)}
      >
        {isFocused && (
          <View
            style={[
              styles.activeIndicator,
              { backgroundColor: colors.primary },
            ]}
          />
        )}
        <Icon name={iconName as IconName} size={24} color={tintColor} />
        <Text style={[styles.tabLabel, { color: tintColor }]} numberOfLines={1}>
          {label}
        </Text>
      </TouchableOpacity>
    );
  };

  const tabContent = (
    <View style={styles.tabBarInner}>{state.routes.map(renderTab)}</View>
  );

  return (
    <View style={[styles.container, { borderTopColor: colors.border }]}>
      {Platform.OS === "ios" ? (
        <BlurView
          tint={isDark ? "dark" : "light"}
          intensity={80}
          style={styles.blurContainer}
        >
          {tabContent}
        </BlurView>
      ) : Platform.OS === "android" ? (
        <View
          style={[styles.solidContainer, { backgroundColor: colors.surface }]}
        >
          {tabContent}
        </View>
      ) : (
        // Web fallback — expo-blur is not available on web
        <View
          style={[
            styles.solidContainer,
            {
              backgroundColor: isDark
                ? `${colors.surface}F0`
                : `${colors.surface}F2`,
            },
          ]}
        >
          {tabContent}
        </View>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    position: "absolute",
    bottom: 0,
    left: 0,
    right: 0,
    borderTopWidth: 0.5,
  },
  blurContainer: {
    flex: 1,
    overflow: "hidden",
  },
  solidContainer: {
    flex: 1,
  },
  tabBarInner: {
    flexDirection: "row",
    paddingTop: 8,
    paddingBottom: Platform.select({ ios: 28, default: 8 }),
  },
  tabItem: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
    minHeight: 44,
    gap: 4,
    position: "relative",
  },
  tabLabel: {
    fontSize: 10,
    fontWeight: "500",
    letterSpacing: 0,
  },
  activeIndicator: {
    position: "absolute",
    top: 0,
    width: 20,
    height: 3,
    borderRadius: 2,
  },
});
