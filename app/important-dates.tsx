import React, { useState, useEffect, useMemo, useCallback } from "react";
import { View, Text, FlatList, StyleSheet, Alert } from "react-native";
import { useTranslation } from "react-i18next";
import Animated, { FadeInDown } from "react-native-reanimated";
import { useTheme } from "../src/contexts/ThemeContext";
import { ImportantDateCard } from "../src/components/dates/ImportantDateCard";
import { AddDateModal } from "../src/components/dates/AddDateModal";
import { Button } from "../src/components/ui/Button";
import { EmptyState } from "../src/components/common/EmptyState";
import * as dateService from "../src/services/importantDates";
import type { ImportantDate } from "../src/services/importantDates";
import { scheduleProactiveReminders } from "../src/services/notifications";
import { useSettingsStore } from "../src/stores/settingsStore";
import { Spacing, Typography, type ThemeColors } from "../src/constants/theme";
import { ScreenErrorBoundary } from "../src/components/common/ScreenErrorBoundary";

export default function ImportantDatesScreen() {
  const { t } = useTranslation();
  const { colors } = useTheme();

  const [dates, setDates] = useState<ImportantDate[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [showAddModal, setShowAddModal] = useState(false);

  const { language, notificationPreferences } = useSettingsStore();

  const loadDates = useCallback(async () => {
    setIsLoading(true);
    try {
      const data = await dateService.fetchImportantDates();
      setDates(data);

      // Schedule proactive reminders if enabled
      if (notificationPreferences.proactiveSuggestions) {
        const upcoming = dateService.getUpcomingDatesWithSuggestions(data, 35);
        scheduleProactiveReminders(upcoming, language).catch(() => {});
      }
    } catch (err) {
      if (__DEV__) console.warn("Failed to load dates:", err);
    } finally {
      setIsLoading(false);
    }
  }, [language, notificationPreferences.proactiveSuggestions]);

  useEffect(() => {
    loadDates();
  }, [loadDates]);

  const datesWithCountdown = useMemo(() => {
    return dateService.getUpcomingDates(dates, 365);
  }, [dates]);

  const handleAdd = async (
    data: Parameters<typeof dateService.addImportantDate>[0],
  ) => {
    try {
      const newDate = await dateService.addImportantDate(data);
      setDates((prev) => [...prev, newDate]);
      setShowAddModal(false);
    } catch (err) {
      if (__DEV__) console.warn("Failed to add date:", err);
    }
  };

  const handleDelete = (id: string) => {
    Alert.alert(t("dates.deleteTitle"), t("dates.deleteConfirm"), [
      { text: t("dates.cancel"), style: "cancel" },
      {
        text: t("dates.delete"),
        style: "destructive",
        onPress: async () => {
          try {
            await dateService.deleteImportantDate(id);
            setDates((prev) => prev.filter((d) => d.id !== id));
          } catch (err) {
            if (__DEV__) console.warn("Failed to delete date:", err);
          }
        },
      },
    ]);
  };

  const screenStyles = useMemo(() => createStyles(colors), [colors]);

  return (
    <ScreenErrorBoundary>
      <View style={screenStyles.container}>
        {datesWithCountdown.length === 0 && !isLoading ? (
          <EmptyState
            emoji="📅"
            title={t("dates.emptyTitle")}
            description={t("dates.emptyDesc")}
          />
        ) : (
          <FlatList
            data={datesWithCountdown}
            keyExtractor={(item) => item.id}
            contentContainerStyle={screenStyles.list}
            renderItem={({ item, index }) => (
              <Animated.View
                entering={FadeInDown.duration(400).delay(index * 50)}
              >
                <ImportantDateCard date={item} onDelete={handleDelete} />
              </Animated.View>
            )}
          />
        )}

        <View style={screenStyles.addButtonContainer}>
          <Button
            title={t("dates.addDate")}
            onPress={() => setShowAddModal(true)}
          />
        </View>

        <AddDateModal
          visible={showAddModal}
          onClose={() => setShowAddModal(false)}
          onSave={handleAdd}
        />
      </View>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: { flex: 1, backgroundColor: colors.background },
    list: { padding: Spacing.lg },
    addButtonContainer: { padding: Spacing.lg },
  });
