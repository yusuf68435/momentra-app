import React from "react";
import {
  Modal as RNModal,
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  Platform,
  KeyboardAvoidingView,
  ScrollView,
  type DimensionValue,
} from "react-native";
import { useTheme } from "../../contexts/ThemeContext";
import { Icon } from "./Icon";
import { Spacing, BorderRadius, Typography } from "../../constants/theme";
import type { ThemeColors } from "../../constants/theme";

interface ModalProps {
  visible: boolean;
  onClose: () => void;
  title?: string;
  children: React.ReactNode;
  maxHeight?: DimensionValue;
  scrollable?: boolean;
}

export function Modal({
  visible,
  onClose,
  title,
  children,
  maxHeight,
  scrollable = false,
}: ModalProps) {
  const { colors } = useTheme();
  const styles = createStyles(colors);

  return (
    <RNModal
      visible={visible}
      transparent
      animationType="slide"
      onRequestClose={onClose}
    >
      <KeyboardAvoidingView
        behavior={Platform.OS === "ios" ? "padding" : "height"}
        style={styles.keyboardView}
      >
        <TouchableOpacity
          style={styles.backdrop}
          activeOpacity={1}
          onPress={onClose}
        />

        <View style={[styles.container, { maxHeight: maxHeight ?? "85%" }]}>
          {title !== undefined && (
            <View style={styles.header}>
              <Text style={styles.title}>{title}</Text>
              <TouchableOpacity
                onPress={onClose}
                hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}
              >
                <Icon name="close" size={24} color={colors.textSecondary} />
              </TouchableOpacity>
            </View>
          )}

          {scrollable ? (
            <ScrollView showsVerticalScrollIndicator={false}>
              {children}
            </ScrollView>
          ) : (
            children
          )}
        </View>
      </KeyboardAvoidingView>
    </RNModal>
  );
}

function createStyles(colors: ThemeColors) {
  return StyleSheet.create({
    keyboardView: {
      flex: 1,
      justifyContent: "flex-end",
    },
    backdrop: {
      ...StyleSheet.absoluteFillObject,
      backgroundColor: colors.overlay,
    },
    container: {
      backgroundColor: colors.surface,
      borderTopLeftRadius: BorderRadius.xl,
      borderTopRightRadius: BorderRadius.xl,
      padding: Spacing.lg,
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
  });
}
