import React, {
  useState,
  useRef,
  useEffect,
  useMemo,
  useCallback,
} from "react";
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  FlatList,
  StyleSheet,
  KeyboardAvoidingView,
  Platform,
} from "react-native";
import { useLocalSearchParams } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon } from "../../../src/components/ui/Icon";
import { useTheme } from "../../../src/contexts/ThemeContext";
import { useCoOrganizerStore } from "../../../src/stores/coOrganizerStore";
import { useAuthStore } from "../../../src/stores/authStore";
import {
  Spacing,
  Typography,
  BorderRadius,
  type ThemeColors,
} from "../../../src/constants/theme";
import { hapticLight } from "../../../src/utils/haptics";
import type { PlanMessage } from "../../../src/types/coOrganizer";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";
import { EmptyState } from "../../../src/components/common/EmptyState";

function formatTime(dateStr: string): string {
  const date = new Date(dateStr);
  if (isNaN(date.getTime())) return "";
  const hours = date.getHours().toString().padStart(2, "0");
  const minutes = date.getMinutes().toString().padStart(2, "0");
  return `${hours}:${minutes}`;
}

export default function ChatScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const { t, i18n } = useTranslation();
  const lang = i18n.language as "tr" | "en";
  const { colors } = useTheme();

  const { messages, loadMessages, sendMessage } = useCoOrganizerStore();
  const user = useAuthStore((s) => s.user);
  const currentUserId = user?.id;

  const [inputText, setInputText] = useState("");
  const flatListRef = useRef<FlatList<PlanMessage>>(null);

  const handleLoadMessages = useCallback(async () => {
    if (!id) return;
    await loadMessages(id);
  }, [id, loadMessages]);

  useEffect(() => {
    handleLoadMessages();
  }, [handleLoadMessages]);

  // Poll for new messages every 10 seconds
  useEffect(() => {
    if (!id) return;
    const interval = setInterval(() => {
      loadMessages(id);
    }, 10000);
    return () => clearInterval(interval);
  }, [id, loadMessages]);

  const handleSend = async () => {
    const trimmed = inputText.trim();
    if (!trimmed || !id) return;

    hapticLight();
    setInputText("");
    try {
      await sendMessage(id, trimmed);
    } catch (err) {
      if (__DEV__) console.warn("Failed to send message:", err);
    }
  };

  const renderMessage = useCallback(
    ({ item }: { item: PlanMessage }) => {
      const isOwn = item.sender_id === currentUserId;
      const senderName = item.sender?.display_name || t("chat.unknownSender");

      return (
        <View
          style={[
            messageStyles.messageRow,
            isOwn
              ? messageStyles.messageRowRight
              : messageStyles.messageRowLeft,
          ]}
        >
          {!isOwn && (
            <View
              style={[
                messageStyles.senderAvatar,
                { backgroundColor: colors.info + "20" },
              ]}
            >
              <Text
                style={[messageStyles.senderAvatarText, { color: colors.info }]}
              >
                {senderName.charAt(0).toUpperCase()}
              </Text>
            </View>
          )}
          <View
            style={[
              messageStyles.messageBubble,
              isOwn
                ? [messageStyles.bubbleRight, { backgroundColor: colors.info }]
                : [
                    messageStyles.bubbleLeft,
                    { backgroundColor: colors.surfaceVariant },
                  ],
            ]}
          >
            {!isOwn && (
              <Text style={[messageStyles.senderName, { color: colors.info }]}>
                {senderName}
              </Text>
            )}
            <Text
              style={[
                messageStyles.messageText,
                { color: isOwn ? colors.textOnPrimary : colors.text },
              ]}
            >
              {item.message}
            </Text>
            <Text
              style={[
                messageStyles.messageTime,
                {
                  color: isOwn ? "rgba(255,255,255,0.7)" : colors.textTertiary,
                },
              ]}
            >
              {formatTime(item.created_at)}
            </Text>
          </View>
        </View>
      );
    },
    [currentUserId, colors, lang],
  );

  const styles = useMemo(() => createStyles(colors), [colors]);

  return (
    <ScreenErrorBoundary>
      <KeyboardAvoidingView
        style={styles.container}
        behavior={Platform.OS === "ios" ? "padding" : undefined}
        keyboardVerticalOffset={Platform.OS === "ios" ? 90 : 0}
      >
        {messages.length === 0 ? (
          <EmptyState
            emoji="💬"
            title={t("chat.noMessages")}
            description={t("chat.startChatting")}
            compact
          />
        ) : (
          <FlatList
            ref={flatListRef}
            data={messages}
            keyExtractor={(item) => item.id}
            renderItem={renderMessage}
            inverted
            contentContainerStyle={styles.messageList}
            showsVerticalScrollIndicator={false}
          />
        )}

        {/* Input Bar */}
        <View
          style={[
            styles.inputBar,
            {
              backgroundColor: colors.surface,
              borderTopColor: colors.borderLight,
            },
          ]}
        >
          <TextInput
            style={[
              styles.textInput,
              { backgroundColor: colors.surfaceVariant, color: colors.text },
            ]}
            value={inputText}
            onChangeText={setInputText}
            placeholder={t("chat.messagePlaceholder")}
            placeholderTextColor={colors.textTertiary}
            multiline
            maxLength={1000}
          />
          <TouchableOpacity
            style={[
              styles.sendButton,
              {
                backgroundColor: inputText.trim()
                  ? colors.info
                  : colors.surfaceVariant,
              },
            ]}
            onPress={handleSend}
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
    </ScreenErrorBoundary>
  );
}

const messageStyles = StyleSheet.create({
  messageRow: {
    flexDirection: "row",
    marginBottom: Spacing.sm,
    alignItems: "flex-end",
    gap: Spacing.xs,
  },
  messageRowLeft: {
    justifyContent: "flex-start",
    marginRight: Spacing.xxl,
  },
  messageRowRight: {
    justifyContent: "flex-end",
    marginLeft: Spacing.xxl,
  },
  senderAvatar: {
    width: 28,
    height: 28,
    borderRadius: 14,
    alignItems: "center",
    justifyContent: "center",
  },
  senderAvatarText: {
    fontSize: 12,
    fontWeight: "700",
  },
  messageBubble: {
    maxWidth: "85%",
    padding: Spacing.sm,
    paddingHorizontal: Spacing.md,
  },
  bubbleLeft: {
    borderRadius: BorderRadius.lg,
    borderBottomLeftRadius: BorderRadius.sm,
  },
  bubbleRight: {
    borderRadius: BorderRadius.lg,
    borderBottomRightRadius: BorderRadius.sm,
  },
  senderName: {
    ...Typography.caption,
    fontWeight: "600",
    marginBottom: 2,
  },
  messageText: {
    ...Typography.body,
  },
  messageTime: {
    ...Typography.caption,
    fontSize: 10,
    textAlign: "right",
    marginTop: 2,
  },
});

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: colors.background,
    },
    messageList: {
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
    },
    inputBar: {
      flexDirection: "row",
      alignItems: "flex-end",
      padding: Spacing.sm,
      paddingHorizontal: Spacing.md,
      borderTopWidth: 1,
      gap: Spacing.sm,
    },
    textInput: {
      flex: 1,
      borderRadius: BorderRadius.xl,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      maxHeight: 100,
      ...Typography.body,
    },
    sendButton: {
      width: 40,
      height: 40,
      borderRadius: 20,
      alignItems: "center",
      justifyContent: "center",
    },
  });
