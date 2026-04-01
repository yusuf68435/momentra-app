import React, { useState } from "react";
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  StyleSheet,
  Alert,
} from "react-native";
import { Icon } from "../ui/Icon";
import { Spacing, Typography, BorderRadius } from "../../constants/theme";
import { useTheme } from "../../contexts/ThemeContext";
import { Modal } from "../ui/Modal";
import { StarRating } from "./StarRating";
import { Button } from "../ui/Button";

interface WriteReviewModalProps {
  visible: boolean;
  onClose: () => void;
  onSubmit: (data: {
    rating: number;
    comment: string;
    photos: string[];
  }) => void;
  lang: "tr" | "en";
  loading?: boolean;
}

const labels = {
  tr: {
    title: "Değerlendirme Yaz",
    ratingPrompt: "Puan ver",
    commentPlaceholder: "Deneyiminizi paylaşın...",
    addPhoto: "Foto Ekle",
    submit: "Gönder",
    cancel: "Vazgeç",
    ratingRequired: "Lütfen bir puan seçin",
    ratingLabels: ["", "Kötü", "Fena değil", "İyi", "Çok iyi", "Harika!"],
    comingSoon: "Yakında",
    photoComingSoon: "Foto yükleme yakında eklenecek!",
  },
  en: {
    title: "Write a Review",
    ratingPrompt: "Rate your experience",
    commentPlaceholder: "Share your experience...",
    addPhoto: "Add Photo",
    submit: "Submit",
    cancel: "Cancel",
    ratingRequired: "Please select a rating",
    ratingLabels: ["", "Poor", "Fair", "Good", "Very Good", "Amazing!"],
    comingSoon: "Coming Soon",
    photoComingSoon: "Photo upload coming soon!",
  },
};

export function WriteReviewModal({
  visible,
  onClose,
  onSubmit,
  lang,
  loading = false,
}: WriteReviewModalProps) {
  const { colors } = useTheme();
  const [rating, setRating] = useState(0);
  const [comment, setComment] = useState("");
  const [photos, setPhotos] = useState<string[]>([]);
  const t = labels[lang];

  const handleSubmit = () => {
    if (rating === 0) {
      Alert.alert("", t.ratingRequired);
      return;
    }
    onSubmit({ rating, comment, photos });
  };

  const handleClose = () => {
    setRating(0);
    setComment("");
    setPhotos([]);
    onClose();
  };

  const handleAddPhoto = () => {
    // UI-only placeholder: would open image picker
    Alert.alert(t.comingSoon, t.photoComingSoon);
  };

  return (
    <Modal visible={visible} onClose={handleClose} title={t.title}>
      {/* Rating */}
      <View style={styles.ratingSection}>
        <Text style={[styles.ratingPrompt, { color: colors.textSecondary }]}>
          {t.ratingPrompt}
        </Text>
        <StarRating
          rating={rating}
          size="lg"
          interactive
          onRate={setRating}
          style={styles.starRow}
        />
        {rating > 0 && (
          <Text style={[styles.ratingLabel, { color: colors.secondary }]}>
            {t.ratingLabels[rating]}
          </Text>
        )}
      </View>

      {/* Comment */}
      <TextInput
        style={[
          styles.textInput,
          {
            backgroundColor: colors.surfaceVariant,
            color: colors.text,
            borderColor: colors.borderLight,
          },
        ]}
        placeholder={t.commentPlaceholder}
        placeholderTextColor={colors.textTertiary}
        multiline
        numberOfLines={4}
        maxLength={500}
        value={comment}
        onChangeText={setComment}
        textAlignVertical="top"
      />
      <Text style={[styles.charCount, { color: colors.textTertiary }]}>
        {comment.length}/500
      </Text>

      {/* Photo upload button */}
      <TouchableOpacity
        style={[styles.photoButton, { borderColor: colors.primary + "40" }]}
        onPress={handleAddPhoto}
        activeOpacity={0.7}
      >
        <Icon name="camera-plus-outline" size={20} color={colors.primary} />
        <Text style={[styles.photoButtonText, { color: colors.primary }]}>
          {t.addPhoto}
        </Text>
      </TouchableOpacity>

      {/* Actions */}
      <View style={styles.actions}>
        <Button
          title={t.cancel}
          onPress={handleClose}
          variant="ghost"
          size="md"
          style={{ flex: 1 }}
        />
        <Button
          title={t.submit}
          onPress={handleSubmit}
          variant="primary"
          size="md"
          loading={loading}
          disabled={rating === 0}
          style={{ flex: 1 }}
          icon={<Icon name="send" size={18} color={colors.textOnPrimary} />}
        />
      </View>
    </Modal>
  );
}

const styles = StyleSheet.create({
  ratingSection: {
    alignItems: "center",
    marginBottom: Spacing.lg,
  },
  ratingPrompt: {
    ...Typography.bodySmall,
    marginBottom: Spacing.sm,
  },
  starRow: {
    marginBottom: Spacing.xs,
  },
  ratingLabel: {
    ...Typography.bodySmall,
    fontWeight: "600",
  },
  textInput: {
    borderRadius: BorderRadius.md,
    padding: Spacing.md,
    ...Typography.body,
    minHeight: 100,
    borderWidth: 1,
  },
  charCount: {
    ...Typography.caption,
    textAlign: "right",
    marginTop: Spacing.xs,
    marginBottom: Spacing.sm,
  },
  photoButton: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.md,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
    borderStyle: "dashed",
    alignSelf: "flex-start",
    marginBottom: Spacing.lg,
  },
  photoButtonText: {
    ...Typography.bodySmall,
    fontWeight: "500",
  },
  actions: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
});
