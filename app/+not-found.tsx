import { Link, Stack } from "expo-router";
import { View, Text, StyleSheet } from "react-native";
import { useTranslation } from "react-i18next";
import { useTheme } from "../src/contexts/ThemeContext";
import { Spacing, Typography, BorderRadius } from "../src/constants/theme";

export default function NotFoundScreen() {
  const { colors } = useTheme();
  const { t } = useTranslation();

  return (
    <>
      <Stack.Screen options={{ title: "Oops!" }} />
      <View style={[styles.container, { backgroundColor: colors.background }]}>
        <Text style={[styles.title, { color: colors.text }]}>
          {t("not_found_screen.message")}
        </Text>

        <Link
          href="/"
          style={[styles.link, { backgroundColor: colors.primary + "14" }]}
        >
          <Text style={[styles.linkText, { color: colors.primary }]}>
            {t("not_found_screen.go_home")}
          </Text>
        </Link>
      </View>
    </>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.lg,
  },
  title: {
    ...Typography.h3,
  },
  link: {
    marginTop: Spacing.lg,
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.md,
    borderRadius: BorderRadius.md,
  },
  linkText: {
    ...Typography.button,
  },
});
