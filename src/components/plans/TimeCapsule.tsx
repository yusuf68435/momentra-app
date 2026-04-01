import React, { useState } from "react";
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Image,
  FlatList,
  Alert,
} from "react-native";
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withSpring,
  withSequence,
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

export interface CapsuleMemory {
  id: string;
  type: "photo" | "text";
  content: string; // URI for photo, text content for text
  addedAt: string;
}

export interface CapsuleData {
  id: string;
  status: "collecting" | "sealed" | "opened";
  memories: CapsuleMemory[];
  openDate?: string;
  sealedAt?: string;
}

interface TimeCapsuleProps {
  planId: string;
  capsule?: CapsuleData;
  onAddMemory?: (type: "photo" | "text") => void;
  onSeal?: () => void;
  onOpen?: () => void;
  onSetOpenDate?: (date: string) => void;
}

export function TimeCapsule({
  planId,
  capsule,
  onAddMemory,
  onSeal,
  onOpen,
  onSetOpenDate,
}: TimeCapsuleProps) {
  const { colors } = useTheme();
  const { t } = useTranslation();
  const styles = createStyles(colors);
  const lockScale = useSharedValue(1);
  const revealOpacity = useSharedValue(0);
  const revealScale = useSharedValue(0.8);

  const handleSeal = () => {
    Alert.alert(t("timeCapsule.sealTitle"), t("timeCapsule.sealConfirm"), [
      { text: t("common.cancel"), style: "cancel" },
      {
        text: t("timeCapsule.seal"),
        onPress: () => {
          lockScale.value = withSequence(
            withSpring(1.3, { damping: 8 }),
            withSpring(1, { damping: 12 }),
          );
          onSeal?.();
        },
      },
    ]);
  };

  const handleOpen = () => {
    revealOpacity.value = withTiming(1, { duration: 800 });
    revealScale.value = withSpring(1, { damping: 12, stiffness: 100 });
    onOpen?.();
  };

  const lockAnimStyle = useAnimatedStyle(() => ({
    transform: [{ scale: lockScale.value }],
  }));

  const revealAnimStyle = useAnimatedStyle(() => ({
    opacity: revealOpacity.value,
    transform: [{ scale: revealScale.value }],
  }));

  if (!capsule) {
    return (
      <Card style={styles.emptyContainer}>
        <Icon name="treasure-chest" size={64} color={colors.textTertiary} />
        <Text style={styles.emptyTitle}>{t("timeCapsule.createTitle")}</Text>
        <Text style={styles.emptySubtitle}>
          {t("timeCapsule.createSubtitle")}
        </Text>
      </Card>
    );
  }

  const memoryCount = capsule.memories.length;

  // SEALED STATE
  if (capsule.status === "sealed") {
    return (
      <Card style={styles.sealedContainer}>
        <Animated.View style={[styles.sealedIconContainer, lockAnimStyle]}>
          <Icon name="lock" size={48} color={colors.secondary} />
        </Animated.View>
        <Text style={styles.sealedTitle}>{t("timeCapsule.sealed")}</Text>
        <Text style={styles.sealedSubtitle}>
          {t("timeCapsule.memoriesCount", { count: memoryCount })}
        </Text>
        {capsule.openDate && (
          <View style={styles.openDateRow}>
            <Icon name="calendar-star" size={16} color={colors.secondary} />
            <Text style={styles.openDateText}>
              {t("timeCapsule.opensOn", { date: capsule.openDate })}
            </Text>
          </View>
        )}
        <TouchableOpacity
          style={styles.openButton}
          onPress={handleOpen}
          activeOpacity={0.8}
        >
          <Icon
            name="lock-open-variant"
            size={20}
            color={colors.textOnPrimary}
          />
          <Text style={styles.openButtonText}>
            {t("timeCapsule.openCapsule")}
          </Text>
        </TouchableOpacity>
      </Card>
    );
  }

  // OPENED STATE
  if (capsule.status === "opened") {
    return (
      <View style={styles.container}>
        <View style={styles.header}>
          <Icon
            name="treasure-chest-outline"
            size={24}
            color={colors.secondary}
          />
          <Text style={styles.sectionTitle}>{t("timeCapsule.opened")}</Text>
        </View>

        <Animated.View style={revealAnimStyle}>
          <View style={styles.memoryGrid}>
            {capsule.memories.map((memory) => (
              <View key={memory.id} style={styles.memoryItem}>
                {memory.type === "photo" ? (
                  <Image
                    source={{ uri: memory.content }}
                    style={styles.memoryPhoto}
                    resizeMode="cover"
                  />
                ) : (
                  <View style={styles.memoryTextCard}>
                    <Icon
                      name="format-quote-open"
                      size={16}
                      color={colors.textTertiary}
                    />
                    <Text style={styles.memoryText} numberOfLines={4}>
                      {memory.content}
                    </Text>
                  </View>
                )}
              </View>
            ))}
          </View>
        </Animated.View>
      </View>
    );
  }

  // COLLECTING STATE
  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Icon name="treasure-chest" size={24} color={colors.secondary} />
        <Text style={styles.sectionTitle}>{t("timeCapsule.title")}</Text>
        <View style={styles.countBadge}>
          <Text style={styles.countBadgeText}>{memoryCount}</Text>
        </View>
      </View>

      {/* Open date selector hint */}
      <TouchableOpacity
        style={styles.dateSelector}
        onPress={() => onSetOpenDate?.("")}
        activeOpacity={0.7}
      >
        <Icon name="calendar-edit" size={18} color={colors.primary} />
        <Text style={styles.dateSelectorText}>
          {capsule.openDate
            ? t("timeCapsule.opensOn", { date: capsule.openDate })
            : t("timeCapsule.setOpenDate")}
        </Text>
      </TouchableOpacity>

      {/* Memory grid */}
      {memoryCount > 0 ? (
        <View style={styles.memoryGrid}>
          {capsule.memories.map((memory) => (
            <View key={memory.id} style={styles.memoryItem}>
              {memory.type === "photo" ? (
                <Image
                  source={{ uri: memory.content }}
                  style={styles.memoryPhoto}
                  resizeMode="cover"
                />
              ) : (
                <View style={styles.memoryTextCard}>
                  <Icon
                    name="format-quote-open"
                    size={16}
                    color={colors.textTertiary}
                  />
                  <Text style={styles.memoryText} numberOfLines={4}>
                    {memory.content}
                  </Text>
                </View>
              )}
            </View>
          ))}
        </View>
      ) : (
        <View style={styles.emptyMemories}>
          <Text style={styles.emptyMemoriesText}>
            {t("timeCapsule.addFirstMemory")}
          </Text>
        </View>
      )}

      {/* Actions */}
      <View style={styles.actions}>
        <View style={styles.addActions}>
          <TouchableOpacity
            style={styles.addMemoryBtn}
            onPress={() => onAddMemory?.("photo")}
            activeOpacity={0.7}
          >
            <Icon name="camera-plus" size={20} color={colors.primary} />
            <Text style={styles.addMemoryText}>
              {t("timeCapsule.addPhoto")}
            </Text>
          </TouchableOpacity>

          <TouchableOpacity
            style={styles.addMemoryBtn}
            onPress={() => onAddMemory?.("text")}
            activeOpacity={0.7}
          >
            <Icon name="text-box-plus" size={20} color={colors.primary} />
            <Text style={styles.addMemoryText}>{t("timeCapsule.addText")}</Text>
          </TouchableOpacity>
        </View>

        {memoryCount > 0 && (
          <TouchableOpacity
            style={styles.sealButton}
            onPress={handleSeal}
            activeOpacity={0.8}
          >
            <Icon name="lock" size={20} color={colors.textOnPrimary} />
            <Text style={styles.sealButtonText}>
              {t("timeCapsule.sealCapsule")}
            </Text>
          </TouchableOpacity>
        )}
      </View>
    </View>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      marginBottom: Spacing.md,
    },
    header: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginBottom: Spacing.md,
    },
    sectionTitle: {
      ...Typography.h3,
      color: colors.text,
      flex: 1,
    },
    countBadge: {
      backgroundColor: colors.secondary,
      borderRadius: BorderRadius.full,
      width: 24,
      height: 24,
      alignItems: "center",
      justifyContent: "center",
    },
    countBadgeText: {
      ...Typography.caption,
      color: colors.textOnPrimary,
      fontWeight: "700",
    },
    dateSelector: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.xs,
      paddingVertical: Spacing.sm,
      paddingHorizontal: Spacing.md,
      backgroundColor: colors.primary + "10",
      borderRadius: BorderRadius.md,
      marginBottom: Spacing.md,
    },
    dateSelectorText: {
      ...Typography.bodySmall,
      color: colors.primary,
      fontWeight: "600",
    },
    memoryGrid: {
      flexDirection: "row",
      flexWrap: "wrap",
      gap: Spacing.sm,
      marginBottom: Spacing.md,
    },
    memoryItem: {
      width: "48%",
      borderRadius: BorderRadius.md,
      overflow: "hidden",
      ...Shadows.sm,
    },
    memoryPhoto: {
      width: "100%",
      height: 120,
    },
    memoryTextCard: {
      backgroundColor: colors.backgroundSecondary,
      padding: Spacing.sm,
      height: 120,
      justifyContent: "center",
    },
    memoryText: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
      fontStyle: "italic",
      marginTop: 4,
    },
    emptyMemories: {
      alignItems: "center",
      paddingVertical: Spacing.xl,
    },
    emptyMemoriesText: {
      ...Typography.body,
      color: colors.textSecondary,
    },
    actions: {
      gap: Spacing.sm,
    },
    addActions: {
      flexDirection: "row",
      gap: Spacing.sm,
    },
    addMemoryBtn: {
      flex: 1,
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      borderWidth: 1.5,
      borderColor: colors.primary,
      borderRadius: BorderRadius.md,
      paddingVertical: Spacing.sm,
      gap: Spacing.xs,
      borderStyle: "dashed",
    },
    addMemoryText: {
      ...Typography.buttonSmall,
      color: colors.primary,
    },
    sealButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      backgroundColor: colors.secondary,
      borderRadius: BorderRadius.md,
      paddingVertical: Spacing.sm + 2,
      gap: Spacing.sm,
      ...Shadows.md,
    },
    sealButtonText: {
      ...Typography.button,
      color: colors.textOnPrimary,
    },
    // Sealed state
    sealedContainer: {
      alignItems: "center",
      paddingVertical: Spacing.xxl,
      paddingHorizontal: Spacing.lg,
    },
    sealedIconContainer: {
      width: 80,
      height: 80,
      borderRadius: 40,
      backgroundColor: colors.secondary + "15",
      alignItems: "center",
      justifyContent: "center",
      marginBottom: Spacing.md,
    },
    sealedTitle: {
      ...Typography.h2,
      color: colors.text,
    },
    sealedSubtitle: {
      ...Typography.body,
      color: colors.textSecondary,
      marginTop: Spacing.xs,
    },
    openDateRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.xs,
      marginTop: Spacing.md,
    },
    openDateText: {
      ...Typography.bodySmall,
      color: colors.secondary,
      fontWeight: "600",
    },
    openButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      backgroundColor: colors.secondary,
      borderRadius: BorderRadius.md,
      paddingVertical: Spacing.sm + 2,
      paddingHorizontal: Spacing.xl,
      gap: Spacing.sm,
      marginTop: Spacing.lg,
      ...Shadows.md,
    },
    openButtonText: {
      ...Typography.button,
      color: colors.textOnPrimary,
    },
    // Empty state
    emptyContainer: {
      alignItems: "center",
      paddingVertical: Spacing.xxl,
      paddingHorizontal: Spacing.lg,
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
