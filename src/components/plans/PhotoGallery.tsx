import React, { useState, useEffect, useCallback, useMemo } from "react";
// Modal is used as a fullscreen image lightbox — not a bottom-sheet
import {
  View,
  Text,
  Image,
  TouchableOpacity,
  FlatList,
  Modal,
  StyleSheet,
  Dimensions,
  Alert,
} from "react-native";
import { useTranslation } from "react-i18next";
import { Icon } from "../ui/Icon";
import Animated, { FadeIn } from "react-native-reanimated";
import { useTheme } from "../../contexts/ThemeContext";
import {
  Spacing,
  Typography,
  BorderRadius,
  type ThemeColors,
} from "../../constants/theme";
import { hapticLight } from "../../utils/haptics";
import * as photoService from "../../services/photos";
import type { PlanPhoto } from "../../services/photos";

const { width: SCREEN_WIDTH } = Dimensions.get("window");
const PHOTO_SIZE = (SCREEN_WIDTH - Spacing.lg * 2 - Spacing.sm * 2) / 3;

interface PhotoGalleryProps {
  planId: string;
}

export function PhotoGallery({ planId }: PhotoGalleryProps) {
  const { colors } = useTheme();
  const { t } = useTranslation();
  const [photos, setPhotos] = useState<PlanPhoto[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [selectedPhoto, setSelectedPhoto] = useState<PlanPhoto | null>(null);

  const loadPhotos = useCallback(async () => {
    setIsLoading(true);
    try {
      const data = await photoService.fetchPhotos(planId);
      setPhotos(data);
    } catch (err) {
      if (__DEV__) console.warn("Failed to load photos:", err);
    } finally {
      setIsLoading(false);
    }
  }, [planId]);

  useEffect(() => {
    loadPhotos();
  }, [loadPhotos]);

  const handleAddPhoto = async () => {
    hapticLight();
    const uri = await photoService.pickImage();
    if (!uri) return;

    const photo = await photoService.uploadPhoto(planId, uri);
    if (photo) {
      setPhotos((prev) => [photo, ...prev]);
    }
  };

  const handleDeletePhoto = (photoId: string) => {
    Alert.alert(t("common.delete"), t("photos.delete_confirm"), [
      { text: t("common.cancel"), style: "cancel" },
      {
        text: t("common.delete"),
        style: "destructive",
        onPress: async () => {
          try {
            await photoService.deletePhoto(photoId);
            setPhotos((prev) => prev.filter((p) => p.id !== photoId));
            setSelectedPhoto(null);
          } catch (err) {
            if (__DEV__) console.warn("Failed to delete photo:", err);
          }
        },
      },
    ]);
  };

  const styles = useMemo(() => createStyles(colors), [colors]);

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>
          {t("photos.title")} ({photos.length})
        </Text>
        <TouchableOpacity onPress={handleAddPhoto} style={styles.addBtn}>
          <Icon name="camera-plus" size={22} color={colors.primary} />
        </TouchableOpacity>
      </View>

      {photos.length === 0 ? (
        <TouchableOpacity style={styles.emptyState} onPress={handleAddPhoto}>
          <Icon name="image-plus" size={32} color={colors.textTertiary} />
          <Text style={styles.emptyText}>{t("photos.add_photos")}</Text>
        </TouchableOpacity>
      ) : (
        <View style={styles.grid}>
          {photos.slice(0, 6).map((photo, index) => (
            <Animated.View
              key={photo.id}
              entering={FadeIn.duration(300).delay(index * 50)}
            >
              <TouchableOpacity onPress={() => setSelectedPhoto(photo)}>
                <Image
                  source={{ uri: photo.image_url }}
                  style={styles.thumbnail}
                />
              </TouchableOpacity>
            </Animated.View>
          ))}
          {photos.length > 6 && (
            <View style={[styles.thumbnail, styles.moreOverlay]}>
              <Text style={styles.moreText}>+{photos.length - 6}</Text>
            </View>
          )}
        </View>
      )}

      {/* Lightbox */}
      <Modal
        visible={!!selectedPhoto}
        transparent
        animationType="fade"
        onRequestClose={() => setSelectedPhoto(null)}
      >
        <View style={styles.lightbox}>
          <TouchableOpacity
            style={styles.lightboxClose}
            onPress={() => setSelectedPhoto(null)}
          >
            <Icon name="close" size={28} color={colors.textOnPrimary} />
          </TouchableOpacity>
          {selectedPhoto && (
            <>
              <Image
                source={{ uri: selectedPhoto.image_url }}
                style={styles.lightboxImage}
                resizeMode="contain"
              />
              {selectedPhoto.caption && (
                <Text style={styles.lightboxCaption}>
                  {selectedPhoto.caption}
                </Text>
              )}
              <TouchableOpacity
                style={styles.lightboxDelete}
                onPress={() => handleDeletePhoto(selectedPhoto.id)}
              >
                <Icon name="trash-can-outline" size={22} color={colors.error} />
              </TouchableOpacity>
            </>
          )}
        </View>
      </Modal>
    </View>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: { marginTop: Spacing.lg },
    header: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      marginBottom: Spacing.md,
    },
    title: { ...Typography.h4, color: colors.text },
    addBtn: { padding: 4 },
    emptyState: {
      alignItems: "center",
      padding: Spacing.xl,
      backgroundColor: colors.surfaceVariant,
      borderRadius: BorderRadius.lg,
      borderWidth: 1,
      borderColor: colors.borderLight,
      borderStyle: "dashed",
    },
    emptyText: {
      ...Typography.caption,
      color: colors.textTertiary,
      marginTop: Spacing.xs,
    },
    grid: { flexDirection: "row", flexWrap: "wrap", gap: Spacing.sm },
    thumbnail: {
      width: PHOTO_SIZE,
      height: PHOTO_SIZE,
      borderRadius: BorderRadius.md,
    },
    moreOverlay: {
      backgroundColor: "rgba(0,0,0,0.5)",
      alignItems: "center",
      justifyContent: "center",
    },
    moreText: { color: colors.textOnPrimary, fontSize: 18, fontWeight: "700" },
    lightbox: {
      flex: 1,
      backgroundColor: "rgba(0,0,0,0.95)",
      justifyContent: "center",
      alignItems: "center",
    },
    lightboxClose: {
      position: "absolute",
      top: 60,
      right: 20,
      zIndex: 10,
      padding: 8,
    },
    lightboxImage: { width: "100%", height: "70%" },
    lightboxCaption: {
      color: colors.textOnPrimary,
      ...Typography.body,
      marginTop: Spacing.md,
      textAlign: "center",
    },
    lightboxDelete: {
      position: "absolute",
      bottom: 60,
      padding: 12,
      backgroundColor: "rgba(255,255,255,0.1)",
      borderRadius: 30,
    },
  });
