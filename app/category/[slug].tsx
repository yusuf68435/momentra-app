import React, { useMemo } from "react";
import { ScreenErrorBoundary } from "../../src/components/common/ScreenErrorBoundary";
import { View, Text, StyleSheet } from "react-native";
import { useLocalSearchParams } from "expo-router";
import { useTranslation } from "react-i18next";
import { Spacing, Typography } from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";
import { EmptyState } from "../../src/components/common/EmptyState";

export default function CategoryScreen() {
  const { slug } = useLocalSearchParams();
  const { t } = useTranslation();
  const { colors } = useTheme();

  const styles = useMemo(() => createStyles(colors), [colors]);

  return (
    <ScreenErrorBoundary>
      <View style={styles.container}>
        <EmptyState
          emoji="🔍"
          title={t(`categories.${slug}`)}
          description={t("categories.comingSoon")}
        />
      </View>
    </ScreenErrorBoundary>
  );
}

const createStyles = (
  colors: ReturnType<
    typeof import("../../src/contexts/ThemeContext").useTheme
  >["colors"],
) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },
  });
