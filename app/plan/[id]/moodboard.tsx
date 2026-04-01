import React, { useState, useCallback, useMemo, useEffect } from "react";
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  Image,
  Modal,
  TextInput,
  Alert,
  Dimensions,
  ActionSheetIOS,
  Platform,
  ActivityIndicator,
} from "react-native";
import * as ImagePicker from "expo-image-picker";
import { useLocalSearchParams } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon } from "../../../src/components/ui/Icon";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../../src/constants/theme";
import { useTheme } from "../../../src/contexts/ThemeContext";
import {
  fetchPhotos,
  uploadPhoto,
  deletePhoto,
  type PlanPhoto,
} from "../../../src/services/photos";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";
import { EmptyState } from "../../../src/components/common/EmptyState";

const SCREEN_WIDTH = Dimensions.get("window").width;
const COLUMN_GAP = Spacing.sm;
const COLUMN_WIDTH = (SCREEN_WIDTH - Spacing.lg * 2 - COLUMN_GAP) / 2;

interface MoodboardImage {
  id: string;
  uri: string;
  height: number;
  addedAt: string;
}

// Generate random heights for masonry effect
const randomHeight = () => Math.floor(Math.random() * 100) + 140;

const mapPhoto = (photo: PlanPhoto): MoodboardImage => ({
  id: photo.id,
  uri: photo.image_url,
  height: randomHeight(),
  addedAt: photo.created_at,
});

export default function MoodboardScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const { t } = useTranslation();
  const { colors } = useTheme();

  const [images, setImages] = useState<MoodboardImage[]>([]);
  const [showUrlModal, setShowUrlModal] = useState(false);
  const [urlInput, setUrlInput] = useState("");
  const [viewingImage, setViewingImage] = useState<MoodboardImage | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [uploadingCount, setUploadingCount] = useState(0);

  useEffect(() => {
    if (!id) return;
    setIsLoading(true);
    fetchPhotos(id)
      .then((photos) => {
        setImages(photos.map(mapPhoto));
      })
      .catch(() => {})
      .finally(() => setIsLoading(false));
  }, [id]);

  const leftColumn = useMemo(
    () => images.filter((_, i) => i % 2 === 0),
    [images],
  );
  const rightColumn = useMemo(
    () => images.filter((_, i) => i % 2 !== 0),
    [images],
  );

  const handleAddOptions = useCallback(() => {
    if (Platform.OS === "ios") {
      ActionSheetIOS.showActionSheetWithOptions(
        {
          options: [
            t("common.cancel"),
            t("moodboard.camera"),
            t("moodboard.gallery"),
            t("moodboard.addFromUrl"),
          ],
          cancelButtonIndex: 0,
        },
        (buttonIndex) => {
          if (buttonIndex === 1) handlePickFromCamera();
          else if (buttonIndex === 2) handlePickFromGallery();
          else if (buttonIndex === 3) setShowUrlModal(true);
        },
      );
    } else {
      Alert.alert(t("moodboard.addImage"), t("moodboard.chooseSource"), [
        {
          text: t("moodboard.camera"),
          onPress: handlePickFromCamera,
        },
        {
          text: t("moodboard.gallery"),
          onPress: handlePickFromGallery,
        },
        {
          text: t("moodboard.addFromUrl"),
          onPress: () => setShowUrlModal(true),
        },
        { text: t("common.cancel"), style: "cancel" },
      ]);
    }
  }, [t]);

  const handlePickFromCamera = useCallback(async () => {
    const permission = await ImagePicker.requestCameraPermissionsAsync();
    if (!permission.granted) {
      Alert.alert(
        t("moodboard.permissionRequired"),
        t("moodboard.cameraPermission"),
      );
      return;
    }
    const result = await ImagePicker.launchCameraAsync({
      allowsEditing: true,
      quality: 0.8,
    });
    if (!result.canceled && result.assets[0]?.uri) {
      const uri = result.assets[0].uri;
      setUploadingCount((c) => c + 1);
      const uploaded = await uploadPhoto(id as string, uri);
      setUploadingCount((c) => c - 1);
      if (uploaded) {
        setImages((prev) => [mapPhoto(uploaded), ...prev]);
      }
    }
  }, [t, id]);

  const handlePickFromGallery = useCallback(async () => {
    const permission = await ImagePicker.requestMediaLibraryPermissionsAsync();
    if (!permission.granted) {
      Alert.alert(
        t("moodboard.permissionRequired"),
        t("moodboard.galleryPermission"),
      );
      return;
    }
    const result = await ImagePicker.launchImageLibraryAsync({
      allowsEditing: true,
      quality: 0.8,
    });
    if (!result.canceled && result.assets[0]?.uri) {
      const uri = result.assets[0].uri;
      setUploadingCount((c) => c + 1);
      const uploaded = await uploadPhoto(id as string, uri);
      setUploadingCount((c) => c - 1);
      if (uploaded) {
        setImages((prev) => [mapPhoto(uploaded), ...prev]);
      }
    }
  }, [t, id]);

  const handleAddFromUrl = useCallback(() => {
    if (!urlInput.trim()) return;
    const newImage: MoodboardImage = {
      id: Date.now().toString(),
      uri: urlInput.trim(),
      height: randomHeight(),
      addedAt: new Date().toISOString(),
    };
    setImages((prev) => [newImage, ...prev]);
    setShowUrlModal(false);
    setUrlInput("");
  }, [urlInput]);

  const handleDeleteImage = useCallback(
    (imageId: string) => {
      Alert.alert(t("moodboard.deleteImage"), t("moodboard.deleteConfirm"), [
        { text: t("common.cancel"), style: "cancel" },
        {
          text: t("common.delete"),
          style: "destructive",
          onPress: async () => {
            setImages((prev) => prev.filter((i) => i.id !== imageId));
            setViewingImage(null);
            try {
              await deletePhoto(imageId);
            } catch {
              // image already removed from state, that's fine
            }
          },
        },
      ]);
    },
    [t],
  );

  const handleLongPress = useCallback(
    (image: MoodboardImage) => {
      Alert.alert(t("moodboard.options"), "", [
        {
          text: t("common.delete"),
          style: "destructive",
          onPress: () => handleDeleteImage(image.id),
        },
        { text: t("common.cancel"), style: "cancel" },
      ]);
    },
    [t, handleDeleteImage],
  );

  const styles = useMemo(() => createStyles(colors), [colors]);

  const renderColumn = (columnImages: MoodboardImage[]) => (
    <View style={styles.column}>
      {columnImages.map((image) => (
        <TouchableOpacity
          key={image.id}
          style={[styles.imageCard, { height: image.height }]}
          onPress={() => setViewingImage(image)}
          onLongPress={() => handleLongPress(image)}
          activeOpacity={0.8}
        >
          <Image source={{ uri: image.uri }} style={styles.image} />
        </TouchableOpacity>
      ))}
    </View>
  );

  return (
    <ScreenErrorBoundary>
      <View style={styles.container}>
        {/* Header */}
        <View style={styles.header}>
          <View>
            <Text style={[styles.headerTitle, { color: colors.text }]}>
              {t("moodboard.title")}
            </Text>
            <View style={styles.imageCountRow}>
              <Text
                style={[styles.imageCount, { color: colors.textSecondary }]}
              >
                {images.length} {t("moodboard.imageCount")}
              </Text>
              {uploadingCount > 0 && (
                <ActivityIndicator
                  size="small"
                  color={colors.primary}
                  style={styles.uploadingIndicator}
                />
              )}
            </View>
          </View>
          <TouchableOpacity
            style={[styles.addButton, { backgroundColor: colors.primary }]}
            onPress={handleAddOptions}
          >
            <Icon name="plus" size={22} color={colors.textOnPrimary} />
          </TouchableOpacity>
        </View>

        {/* Content */}
        {isLoading ? (
          <View style={styles.loadingState}>
            <ActivityIndicator size="large" color={colors.primary} />
          </View>
        ) : images.length === 0 ? (
          <EmptyState
            emoji="🎨"
            title={t("moodboard.emptyTitle")}
            description={t("moodboard.emptyDescription")}
            actionLabel={t("moodboard.addImage")}
            onAction={handleAddOptions}
            compact
          />
        ) : (
          <ScrollView
            contentContainerStyle={styles.masonryContainer}
            showsVerticalScrollIndicator={false}
          >
            <View style={styles.masonry}>
              {renderColumn(leftColumn)}
              {renderColumn(rightColumn)}
            </View>
          </ScrollView>
        )}

        {/* Full Image Viewer */}
        <Modal visible={!!viewingImage} animationType="fade" transparent>
          <View style={styles.viewerOverlay}>
            <TouchableOpacity
              style={styles.viewerClose}
              onPress={() => setViewingImage(null)}
            >
              <Icon name="close" size={28} color="#FFF" />
            </TouchableOpacity>
            <TouchableOpacity
              style={styles.viewerDelete}
              onPress={() => viewingImage && handleDeleteImage(viewingImage.id)}
            >
              <Icon name="trash-can-outline" size={24} color="#FFF" />
            </TouchableOpacity>
            {viewingImage && (
              <Image
                source={{ uri: viewingImage.uri }}
                style={styles.viewerImage}
                resizeMode="contain"
              />
            )}
          </View>
        </Modal>

        {/* URL Modal */}
        <Modal visible={showUrlModal} animationType="slide" transparent>
          <View style={styles.modalOverlay}>
            <View
              style={[styles.modalContent, { backgroundColor: colors.surface }]}
            >
              <View style={styles.modalHeader}>
                <Text style={[styles.modalTitle, { color: colors.text }]}>
                  {t("moodboard.addFromUrl")}
                </Text>
                <TouchableOpacity onPress={() => setShowUrlModal(false)}>
                  <Icon name="close" size={24} color={colors.text} />
                </TouchableOpacity>
              </View>
              <TextInput
                style={[
                  styles.input,
                  {
                    color: colors.text,
                    backgroundColor: colors.backgroundSecondary,
                    borderColor: colors.borderLight,
                  },
                ]}
                value={urlInput}
                onChangeText={setUrlInput}
                placeholder="https://example.com/image.jpg"
                placeholderTextColor={colors.textTertiary}
                autoCapitalize="none"
                autoCorrect={false}
                keyboardType="url"
              />
              <TouchableOpacity
                style={[
                  styles.saveButton,
                  {
                    backgroundColor: urlInput.trim()
                      ? colors.primary
                      : colors.borderLight,
                  },
                ]}
                onPress={handleAddFromUrl}
                disabled={!urlInput.trim()}
              >
                <Text
                  style={[
                    styles.saveButtonText,
                    { color: colors.textOnPrimary },
                  ]}
                >
                  {t("moodboard.add")}
                </Text>
              </TouchableOpacity>
            </View>
          </View>
        </Modal>
      </View>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: { flex: 1, backgroundColor: colors.background },
    header: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      padding: Spacing.lg,
      borderBottomWidth: 1,
      borderBottomColor: colors.borderLight,
    },
    headerTitle: { ...Typography.h3 },
    imageCount: { ...Typography.caption, marginTop: 2 },
    imageCountRow: { flexDirection: "row", alignItems: "center", marginTop: 2 },
    uploadingIndicator: { marginLeft: Spacing.xs },
    loadingState: { flex: 1, alignItems: "center", justifyContent: "center" },
    addButton: {
      width: 42,
      height: 42,
      borderRadius: 21,
      alignItems: "center",
      justifyContent: "center",
    },
    masonryContainer: { padding: Spacing.lg, paddingBottom: Spacing.xxl },
    masonry: { flexDirection: "row", gap: COLUMN_GAP },
    column: { flex: 1, gap: COLUMN_GAP },
    imageCard: {
      borderRadius: BorderRadius.md,
      overflow: "hidden",
      ...Shadows.sm,
    },
    image: {
      width: "100%",
      height: "100%",
      backgroundColor: colors.surfaceVariant,
    },
    viewerOverlay: {
      flex: 1,
      backgroundColor: "rgba(0,0,0,0.92)",
      justifyContent: "center",
      alignItems: "center",
    },
    viewerClose: {
      position: "absolute",
      top: 50,
      right: Spacing.lg,
      zIndex: 10,
      padding: Spacing.sm,
    },
    viewerDelete: {
      position: "absolute",
      top: 50,
      left: Spacing.lg,
      zIndex: 10,
      padding: Spacing.sm,
    },
    viewerImage: { width: SCREEN_WIDTH - Spacing.lg * 2, height: "70%" },
    modalOverlay: {
      flex: 1,
      backgroundColor: "rgba(0,0,0,0.5)",
      justifyContent: "flex-end",
    },
    modalContent: {
      borderTopLeftRadius: BorderRadius.xl,
      borderTopRightRadius: BorderRadius.xl,
      padding: Spacing.lg,
    },
    modalHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      marginBottom: Spacing.lg,
    },
    modalTitle: { ...Typography.h4 },
    input: {
      ...Typography.body,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1,
      marginBottom: Spacing.md,
    },
    saveButton: {
      alignItems: "center",
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
    },
    saveButtonText: { ...Typography.button },
  });
