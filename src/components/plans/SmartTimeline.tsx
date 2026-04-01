import React, { useCallback, useEffect } from "react";
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  FlatList,
} from "react-native";
import Animated, {
  useAnimatedStyle,
  useSharedValue,
  withSequence,
  withSpring,
  withTiming,
} from "react-native-reanimated";
import { Icon } from "../ui/Icon";
import { useTranslation } from "react-i18next";
import {
  type ThemeColors,
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";
import { Card } from "../ui/Card";

export interface TimelineItem {
  id: string;
  title: string;
  description: string;
  dueDate: string;
  priority: "low" | "medium" | "high";
  completed: boolean;
}

interface SmartTimelineProps {
  planId: string;
  items: TimelineItem[];
  onToggleComplete?: (id: string) => void;
  onGenerateAI?: () => void;
}

const getPriorityConfig = (colors: ThemeColors) => ({
  low: { label: "Low", color: colors.info, icon: "arrow-down" as const },
  medium: {
    label: "Medium",
    color: colors.warning,
    icon: "arrow-right" as const,
  },
  high: { label: "High", color: colors.error, icon: "arrow-up" as const },
});

function TimelineItemRow({
  item,
  isLast,
  onToggle,
}: {
  item: TimelineItem;
  isLast: boolean;
  onToggle?: (id: string) => void;
}) {
  const { colors } = useTheme();
  const { t } = useTranslation();
  const styles = createStyles(colors);
  const priorityConfig = getPriorityConfig(colors);
  const scale = useSharedValue(1);
  const opacity = useSharedValue(item.completed ? 0.7 : 1);

  useEffect(() => {
    opacity.value = withTiming(item.completed ? 0.7 : 1, { duration: 300 });
  }, [item.completed, opacity]);

  const handleToggle = useCallback(() => {
    scale.value = withSequence(
      withTiming(0.95, { duration: 100 }),
      withSpring(1, { damping: 15, stiffness: 200 }),
    );
    onToggle?.(item.id);
  }, [item.id, onToggle, scale]);

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ scale: scale.value }],
    opacity: opacity.value,
  }));

  const dotColor = item.completed ? colors.success : colors.primary;
  const dotColorFuture = colors.textTertiary;
  const finalDotColor = item.completed
    ? dotColor
    : !item.completed
      ? dotColorFuture
      : dotColor;
  const priority = priorityConfig[item.priority];

  return (
    <View style={styles.itemRow}>
      <View style={styles.timelineTrack}>
        <View
          style={[
            styles.dot,
            {
              backgroundColor: item.completed ? colors.success : colors.primary,
              borderColor: item.completed ? colors.success : colors.primary,
            },
          ]}
        >
          {item.completed && (
            <Icon name="check" size={12} color={colors.textOnPrimary} />
          )}
        </View>
        {!isLast && <View style={styles.line} />}
      </View>

      <Animated.View style={[styles.contentCard, animatedStyle]}>
        <Card style={styles.card}>
          <View style={styles.cardHeader}>
            <Text
              style={[styles.itemTitle, item.completed && styles.completedText]}
            >
              {item.title}
            </Text>
            <View
              style={[
                styles.priorityBadge,
                { backgroundColor: priority.color + "20" },
              ]}
            >
              <Icon name={priority.icon} size={12} color={priority.color} />
              <Text style={[styles.priorityText, { color: priority.color }]}>
                {t(`timeline.priority.${item.priority}`)}
              </Text>
            </View>
          </View>

          {item.description ? (
            <Text
              style={[
                styles.itemDescription,
                item.completed && styles.completedText,
              ]}
            >
              {item.description}
            </Text>
          ) : null}

          <View style={styles.cardFooter}>
            <View style={styles.dueDateRow}>
              <Icon
                name="calendar-clock"
                size={14}
                color={colors.textTertiary}
              />
              <Text style={styles.dueDate}>{item.dueDate}</Text>
            </View>

            <TouchableOpacity
              onPress={handleToggle}
              style={styles.checkbox}
              activeOpacity={0.7}
            >
              <Icon
                name={
                  item.completed
                    ? "checkbox-marked-circle"
                    : "checkbox-blank-circle-outline"
                }
                size={24}
                color={item.completed ? colors.success : colors.textTertiary}
              />
            </TouchableOpacity>
          </View>
        </Card>
      </Animated.View>
    </View>
  );
}

export function SmartTimeline({
  planId,
  items,
  onToggleComplete,
  onGenerateAI,
}: SmartTimelineProps) {
  const { colors } = useTheme();
  const { t } = useTranslation();
  const styles = createStyles(colors);

  return (
    <View style={styles.container}>
      <TouchableOpacity
        style={styles.aiButton}
        onPress={onGenerateAI}
        activeOpacity={0.8}
      >
        <Icon name="auto-fix" size={20} color={colors.textOnPrimary} />
        <Text style={styles.aiButtonText}>{t("timeline.generateWithAI")}</Text>
      </TouchableOpacity>

      {items.length === 0 ? (
        <View style={styles.emptyState}>
          <Icon
            name="timeline-clock-outline"
            size={64}
            color={colors.textTertiary}
          />
          <Text style={styles.emptyTitle}>{t("timeline.emptyTitle")}</Text>
          <Text style={styles.emptySubtitle}>
            {t("timeline.emptySubtitle")}
          </Text>
        </View>
      ) : (
        <FlatList
          data={items}
          keyExtractor={(item) => item.id}
          scrollEnabled={false}
          renderItem={({ item, index }) => (
            <TimelineItemRow
              item={item}
              isLast={index === items.length - 1}
              onToggle={onToggleComplete}
            />
          )}
        />
      )}
    </View>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      marginBottom: Spacing.md,
    },
    aiButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      backgroundColor: colors.accent,
      borderRadius: BorderRadius.md,
      paddingVertical: Spacing.sm + 2,
      paddingHorizontal: Spacing.lg,
      gap: Spacing.sm,
      marginBottom: Spacing.lg,
      ...Shadows.md,
    },
    aiButtonText: {
      ...Typography.button,
      color: colors.textOnPrimary,
    },
    itemRow: {
      flexDirection: "row",
      minHeight: 80,
    },
    timelineTrack: {
      width: 32,
      alignItems: "center",
    },
    dot: {
      width: 24,
      height: 24,
      borderRadius: 12,
      borderWidth: 2,
      alignItems: "center",
      justifyContent: "center",
      zIndex: 1,
    },
    line: {
      width: 2,
      flex: 1,
      backgroundColor: colors.border,
      marginTop: -2,
    },
    contentCard: {
      flex: 1,
      marginLeft: Spacing.sm,
      marginBottom: Spacing.md,
    },
    card: {
      padding: Spacing.md,
    },
    cardHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "flex-start",
      marginBottom: Spacing.xs,
    },
    itemTitle: {
      ...Typography.h4,
      color: colors.text,
      flex: 1,
      marginRight: Spacing.sm,
    },
    itemDescription: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
      marginBottom: Spacing.sm,
    },
    completedText: {
      textDecorationLine: "line-through",
      color: colors.textTertiary,
    },
    priorityBadge: {
      flexDirection: "row",
      alignItems: "center",
      paddingHorizontal: Spacing.sm,
      paddingVertical: 2,
      borderRadius: BorderRadius.sm,
      gap: 4,
    },
    priorityText: {
      ...Typography.caption,
      fontWeight: "600",
    },
    cardFooter: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      marginTop: Spacing.xs,
    },
    dueDateRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: 4,
    },
    dueDate: {
      ...Typography.caption,
      color: colors.textTertiary,
    },
    checkbox: {
      padding: 2,
    },
    emptyState: {
      alignItems: "center",
      paddingVertical: Spacing.xxl,
    },
    emptyTitle: {
      ...Typography.h3,
      color: colors.text,
      marginTop: Spacing.md,
    },
    emptySubtitle: {
      ...Typography.body,
      color: colors.textSecondary,
      textAlign: "center",
      marginTop: Spacing.xs,
    },
  });
