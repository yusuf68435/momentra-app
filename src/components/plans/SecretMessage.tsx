import React, { useState, useRef } from "react";
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  TextInput,
  FlatList,
  KeyboardAvoidingView,
  Platform,
} from "react-native";
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

export interface Message {
  id: string;
  text: string;
  senderId: string;
  timestamp: string;
  isMine: boolean;
}

interface SecretMessageProps {
  planId: string;
  messages: Message[];
  onSend?: (text: string) => void;
}

function MessageBubble({ message }: { message: Message }) {
  const { colors } = useTheme();
  const styles = createStyles(colors);
  return (
    <View
      style={[
        styles.bubbleContainer,
        message.isMine
          ? styles.bubbleContainerRight
          : styles.bubbleContainerLeft,
      ]}
    >
      <View
        style={[
          styles.bubble,
          message.isMine ? styles.bubbleMine : styles.bubbleTheirs,
        ]}
      >
        <Text
          style={[
            styles.bubbleText,
            message.isMine ? styles.bubbleTextMine : styles.bubbleTextTheirs,
          ]}
        >
          {message.text}
        </Text>
        <View style={styles.timestampRow}>
          <Icon
            name="lock"
            size={10}
            color={
              message.isMine ? "rgba(255,255,255,0.6)" : colors.textTertiary
            }
          />
          <Text
            style={[
              styles.timestamp,
              message.isMine ? styles.timestampMine : styles.timestampTheirs,
            ]}
          >
            {message.timestamp}
          </Text>
        </View>
      </View>
    </View>
  );
}

export function SecretMessage({
  planId,
  messages,
  onSend,
}: SecretMessageProps) {
  const { colors } = useTheme();
  const { t } = useTranslation();
  const styles = createStyles(colors);
  const [inputText, setInputText] = useState("");
  const flatListRef = useRef<FlatList>(null);

  const handleSend = () => {
    const trimmed = inputText.trim();
    if (!trimmed) return;
    onSend?.(trimmed);
    setInputText("");
  };

  return (
    <KeyboardAvoidingView
      behavior={Platform.OS === "ios" ? "padding" : undefined}
      style={styles.container}
    >
      {/* Header */}
      <View style={styles.header}>
        <Icon name="lock" size={20} color={colors.primary} />
        <Text style={styles.headerTitle}>{t("secretMessage.title")}</Text>
      </View>

      {/* Disclaimer */}
      <View style={styles.disclaimer}>
        <Icon name="shield-lock-outline" size={14} color={colors.info} />
        <Text style={styles.disclaimerText}>
          {t("secretMessage.disclaimer")}
        </Text>
      </View>

      {/* Messages */}
      {messages.length === 0 ? (
        <View style={styles.emptyState}>
          <Icon
            name="message-lock-outline"
            size={48}
            color={colors.textTertiary}
          />
          <Text style={styles.emptyText}>{t("secretMessage.noMessages")}</Text>
        </View>
      ) : (
        <FlatList
          ref={flatListRef}
          data={messages}
          keyExtractor={(item) => item.id}
          renderItem={({ item }) => <MessageBubble message={item} />}
          contentContainerStyle={styles.messagesList}
          onContentSizeChange={() =>
            flatListRef.current?.scrollToEnd({ animated: true })
          }
          showsVerticalScrollIndicator={false}
          style={styles.messagesContainer}
        />
      )}

      {/* Input */}
      <View style={styles.inputContainer}>
        <TextInput
          style={styles.textInput}
          value={inputText}
          onChangeText={setInputText}
          placeholder={t("secretMessage.placeholder")}
          placeholderTextColor={colors.textTertiary}
          multiline
          maxLength={500}
        />
        <TouchableOpacity
          style={[
            styles.sendButton,
            !inputText.trim() && styles.sendButtonDisabled,
          ]}
          onPress={handleSend}
          activeOpacity={0.7}
          disabled={!inputText.trim()}
        >
          <Icon
            name="send"
            size={20}
            color={
              inputText.trim() ? colors.textOnPrimary : colors.textTertiary
            }
          />
        </TouchableOpacity>
      </View>
    </KeyboardAvoidingView>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      overflow: "hidden",
      marginBottom: Spacing.md,
      ...Shadows.md,
    },
    header: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      padding: Spacing.md,
      borderBottomWidth: 1,
      borderBottomColor: colors.borderLight,
    },
    headerTitle: {
      ...Typography.h4,
      color: colors.text,
    },
    disclaimer: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.xs,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      backgroundColor: colors.info + "10",
    },
    disclaimerText: {
      ...Typography.caption,
      color: colors.info,
      flex: 1,
    },
    messagesContainer: {
      maxHeight: 400,
    },
    messagesList: {
      padding: Spacing.md,
    },
    emptyState: {
      alignItems: "center",
      paddingVertical: Spacing.xxl,
    },
    emptyText: {
      ...Typography.body,
      color: colors.textSecondary,
      marginTop: Spacing.sm,
    },
    bubbleContainer: {
      marginBottom: Spacing.sm,
      maxWidth: "80%",
    },
    bubbleContainerRight: {
      alignSelf: "flex-end",
    },
    bubbleContainerLeft: {
      alignSelf: "flex-start",
    },
    bubble: {
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      borderRadius: BorderRadius.lg,
    },
    bubbleMine: {
      backgroundColor: colors.primary,
      borderBottomRightRadius: BorderRadius.sm,
    },
    bubbleTheirs: {
      backgroundColor: colors.backgroundSecondary,
      borderBottomLeftRadius: BorderRadius.sm,
    },
    bubbleText: {
      ...Typography.body,
    },
    bubbleTextMine: {
      color: colors.textOnPrimary,
    },
    bubbleTextTheirs: {
      color: colors.text,
    },
    timestampRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: 4,
      marginTop: 4,
      alignSelf: "flex-end",
    },
    timestamp: {
      ...Typography.caption,
      fontSize: 10,
    },
    timestampMine: {
      color: "rgba(255,255,255,0.6)",
    },
    timestampTheirs: {
      color: colors.textTertiary,
    },
    inputContainer: {
      flexDirection: "row",
      alignItems: "flex-end",
      padding: Spacing.sm,
      borderTopWidth: 1,
      borderTopColor: colors.borderLight,
      gap: Spacing.sm,
    },
    textInput: {
      flex: 1,
      backgroundColor: colors.backgroundSecondary,
      borderRadius: BorderRadius.xl,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      ...Typography.body,
      color: colors.text,
      maxHeight: 100,
    },
    sendButton: {
      width: 40,
      height: 40,
      borderRadius: 20,
      backgroundColor: colors.primary,
      alignItems: "center",
      justifyContent: "center",
    },
    sendButtonDisabled: {
      backgroundColor: colors.backgroundSecondary,
    },
  });
