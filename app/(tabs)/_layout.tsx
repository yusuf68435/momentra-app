import React from "react";
import { TouchableOpacity } from "react-native";
import { Tabs, useRouter } from "expo-router";
import { useTranslation } from "react-i18next";
import { useTheme } from "../../src/contexts/ThemeContext";
import { CustomTabBar } from "../../src/components/navigation/CustomTabBar";
import { Icon } from "../../src/components/ui/Icon";
import { hapticMedium } from "../../src/utils/haptics";

export default function TabLayout() {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const router = useRouter();

  return (
    <Tabs
      tabBar={(props) => <CustomTabBar {...props} />}
      screenOptions={{
        headerStyle: { backgroundColor: colors.surface },
        headerTintColor: colors.text,
        headerShadowVisible: false,
      }}
    >
      <Tabs.Screen
        name="index"
        options={{
          title: t("tabs.home"),
          headerTitle: "Momentra",
          headerTitleStyle: {
            fontWeight: "700",
            fontSize: 20,
            color: colors.text,
            letterSpacing: -0.4,
          },
        }}
      />
      <Tabs.Screen
        name="explore"
        options={{
          title: t("tabs.explore"),
        }}
      />
      <Tabs.Screen
        name="plans"
        options={{
          title: t("tabs.plans"),
          headerRight: () => (
            <TouchableOpacity
              onPress={() => {
                hapticMedium();
                router.push("/plan/create" as never);
              }}
              style={{ marginRight: 16, padding: 4 }}
              activeOpacity={0.7}
            >
              <Icon name="plus" size={22} color={colors.primary} />
            </TouchableOpacity>
          ),
        }}
      />
      <Tabs.Screen
        name="ai"
        options={{
          title: t("tabs.ai"),
        }}
      />
      <Tabs.Screen
        name="community"
        options={{
          title: t("tabs.community"),
        }}
      />
      <Tabs.Screen
        name="profile"
        options={{
          title: t("tabs.profile"),
        }}
      />
    </Tabs>
  );
}
