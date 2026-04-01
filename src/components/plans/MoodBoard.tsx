import React, { useState, useMemo } from "react";
import {
  View,
  Text,
  StyleSheet,
  Image,
  TouchableOpacity,
  Alert,
  Dimensions,
} from "react-native";
import { Icon } from "../ui/Icon";
import { useTranslation } from "react-i18next";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";
import { Card } from "../ui/Card";

export interface MoodBoardImage {
  id: string;
  uri: string;
  width: number;
  height: number;
}

interface MoodBoardProps {
  planId: string;
  images: MoodBoardImage[];
  onAddImage?: (source: "camera" | "gallery") => void;
  onDeleteImage?: (id: string) => void;
  onReorder?: (images: MoodBoardImage[]) => void;
}

const SCREEN_WIDTH = Dimensions.get("window").width;
const COLUMN_GAP = Spacing.sm;
const PADDING = Spacing.md;
const COLUMN_WIDTH = (SCREEN_WIDTH - PADDING * 2 - COLUMN_GAP) / 2;

export function MoodBoard({
  planId,
  images,
  onAddImage,
  onDeleteImage,
  onReorder,
}: MoodBoardProps) {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const [pressedId, setPressedId] = useState<string | null>(null);

  const styles = useMemo(() => createStyles(colors), [colors]);

  const handleAddPress = () => {
    Alert.alert(t("moodBoard.addImage"), t("moodBoard.chooseSource"), [
      { text: t("moodBoard.camera"), onPress: () => onAddImage?.("camera") },
      { text: t("moodBoard.gallery"), onPress: () => onAddImage?.("gallery") },
      { text: t("common.cancel"), style: "cancel" },
    ]);
  };

  const handleDelete = (id: string) => {
    Alert.alert(t("moodBoard.deleteTitle"), t("moodBoard.deleteMessage"), [
      { text: t("common.cancel"), style: "cancel" },
      {
        text: t("common.delete"),
        style: "destructive",
        onPress: () => onDeleteImage?.(id),
      },
    ]);
  };

  const handleLongPress = (id: string) => {
    setPressedId(id);
    // Long press hints at rearrange - in a full implementation this
    // would activate a drag-and-drop mode.
  };

  // Split images into two columns for masonry layout
  const leftColumn: MoodBoardImage[] = [];
  const rightColumn: MoodBoardImage[] = [];
  let leftHeight = 0;
  let rightHeight = 0;

  images.forEach((img) => {
    const aspectRatio = img.height / img.width;
    const renderedHeight = COLUMN_WIDTH * aspectRatio;
    if (leftHeight <= rightHeight) {
      leftColumn.push(img);
      leftHeight += renderedHeight;
    } else {
      rightColumn.push(img);
      rightHeight += renderedHeight;
    }
  });

  const renderImage = (img: MoodBoardImage) => {
    const aspectRatio = img.height / img.width;
    const renderedHeight = COLUMN_WIDTH * aspectRatio;

    return (
      <TouchableOpacity
        key={img.id}
        activeOpacity={0.9}
        onLongPress={() => handleLongPress(img.id)}
        style={[styles.imageWrapper, { height: renderedHeight }]}
      >
        <Image
          source={{ uri: img.uri }}
          style={[styles.image, { height: renderedHeight }]}
          resizeMode="cover"
        />
        <TouchableOpacity
          style={styles.deleteButton}
          onPress={() => handleDelete(img.id)}
          activeOpacity={0.7}
        >
          <Icon name="close-circle" size={24} color={colors.textOnPrimary} />
        </TouchableOpacity>
      </TouchableOpacity>
    );
  };

  if (images.length === 0) {
    return (
      <Card style={styles.emptyContainer}>
        <Icon
          name="image-multiple-outline"
          size={64}
          color={colors.textTertiary}
        />
        <Text style={styles.emptyTitle}>{t("moodBoard.emptyTitle")}</Text>
        <Text style={styles.emptySubtitle}>{t("moodBoard.emptySubtitle")}</Text>
        <TouchableOpacity
          style={styles.addButton}
          onPress={handleAddPress}
          activeOpacity={0.8}
        >
          <Icon name="plus" size={20} color={colors.textOnPrimary} />
          <Text style={styles.addButtonText}>{t("moodBoard.addImage")}</Text>
        </TouchableOpacity>
      </Card>
    );
  }

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>{t("moodBoard.title")}</Text>
        <Text style={styles.count}>
          {images.length} {t("moodBoard.images")}
        </Text>
      </View>

      <View style={styles.masonry}>
        <View style={styles.column}>{leftColumn.map(renderImage)}</View>
        <View style={styles.column}>{rightColumn.map(renderImage)}</View>
      </View>

      <TouchableOpacity
        style={styles.addButton}
        onPress={handleAddPress}
        activeOpacity={0.8}
      >
        <Icon name="plus" size={20} color={colors.textOnPrimary} />
        <Text style={styles.addButtonText}>{t("moodBoard.addImage")}</Text>
      </TouchableOpacity>
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
      justifyContent: "space-between",
      alignItems: "center",
      marginBottom: Spacing.md,
    },
    title: {
      ...Typography.h3,
      color: colors.text,
    },
    count: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
    },
    masonry: {
      flexDirection: "row",
      gap: COLUMN_GAP,
    },
    column: {
      flex: 1,
      gap: COLUMN_GAP,
    },
    imageWrapper: {
      borderRadius: BorderRadius.md,
      overflow: "hidden",
      ...Shadows.sm,
    },
    image: {
      width: "100%",
      borderRadius: BorderRadius.md,
    },
    deleteButton: {
      position: "absolute",
      top: Spacing.xs,
      right: Spacing.xs,
      backgroundColor: "rgba(0,0,0,0.5)",
      borderRadius: BorderRadius.full,
      padding: 2,
    },
    addButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      backgroundColor: colors.primary,
      borderRadius: BorderRadius.md,
      paddingVertical: Spacing.sm + 2,
      paddingHorizontal: Spacing.lg,
      gap: Spacing.sm,
      marginTop: Spacing.md,
      ...Shadows.md,
    },
    addButtonText: {
      ...Typography.button,
      color: colors.textOnPrimary,
    },
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
      marginBottom: Spacing.lg,
    },
  });
