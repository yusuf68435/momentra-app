import React, {
  useState,
  useRef,
  useCallback,
  useMemo,
  useEffect,
} from "react";
import {
  View,
  Text,
  FlatList,
  StyleSheet,
  TouchableOpacity,
  TextInput,
  KeyboardAvoidingView,
  Platform,
  ActivityIndicator,
  Alert,
} from "react-native";
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
import { useAuthStore } from "../../../src/stores/authStore";
import { getMessages, sendMessage } from "../../../src/services/secretMessages";
import { fetchCoOrganizers } from "../../../src/services/coOrganizer";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";
import { EmptyState } from "../../../src/components/common/EmptyState";

interface Message {
  id: string;
  text: string;
  senderId: string;
  senderName: string;
  timestamp: string;
  isMine: boolean;
}

function formatTime(iso: string): string {
  const date = new Date(iso);
  if (isNaN(date.getTime())) return "";
  const hours = date.getHours().toString().padStart(2, "0");
  const minutes = date.getMinutes().toString().padStart(2, "0");
  return `${hours}:${minutes}`;
}

export default function SecretChatScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const { t } = useTranslation();
  const { colors } = useTheme();
  const { user } = useAuthStore();

  const [messages, setMessages] = useState<Message[]>([]);
  const [inputText, setInputText] = useState("");
  const [loading, setLoading] = useState(true);
  const [sending, setSending] = useState(false);
  const [coOrganizerIds, setCoOrganizerIds] = useState<string[]>([]);
  const flatListRef = useRef<FlatList<Message>>(null);

  useEffect(() => {
    let cancelled = false;
    async function loadData() {
      try {
        setLoading(true);
        // Load co-organizers
        const coOrgs = await fetchCoOrganizers(id as string);
        const ids = coOrgs
          .map((c) => c.user_id)
          .filter((uid): uid is string => Boolean(uid));
        if (!cancelled) setCoOrganizerIds(ids);

        // Load existing messages
        const msgs = await getMessages(id as string);
        if (!cancelled) {
          setMessages(
            msgs.map((m) => ({
              id: m.id,
              text: m.content,
              senderId: m.sender_id,
              senderName:
                m.sender_id === user?.id
                  ? t("secret_chat.me")
                  : m.sender_name || "Co-organizer",
              timestamp: m.sent_at,
              isMine: m.sender_id === user?.id,
            })),
          );
        }
      } catch (err) {
        if (__DEV__) console.warn("SecretChat load error:", err);
      } finally {
        if (!cancelled) setLoading(false);
      }
    }
    loadData();
    return () => {
      cancelled = true;
    };
  }, [id, user?.id, t]);

  const handleSend = useCallback(async () => {
    const text = inputText.trim();
    if (!text || sending) return;

    if (coOrganizerIds.length === 0) {
      Alert.alert(t("secret_chat.noCoOrgTitle"), t("secret_chat.noCoOrgBody"));
      return;
    }

    setSending(true);
    setInputText("");

    try {
      // Send a copy to each co-organizer
      for (const recipientId of coOrganizerIds) {
        await sendMessage(id as string, recipientId, text);
      }

      // Optimistically add to local state (use first send result timestamp)
      const optimistic: Message = {
        id: Date.now().toString(),
        text,
        senderId: user?.id ?? "",
        senderName: t("secret_chat.me"),
        timestamp: new Date().toISOString(),
        isMine: true,
      };
      setMessages((prev) => [...prev, optimistic]);
      setTimeout(() => {
        flatListRef.current?.scrollToEnd({ animated: true });
      }, 100);
    } catch (err) {
      if (__DEV__) console.warn("SecretChat send error:", err);
      Alert.alert(
        t("secret_chat.sendErrorTitle"),
        t("secret_chat.sendErrorBody"),
      );
      // Restore input text so the user can retry
      setInputText(text);
    } finally {
      setSending(false);
    }
  }, [inputText, sending, coOrganizerIds, id, user?.id, t]);

  const styles = useMemo(() => createStyles(colors), [colors]);

  const renderMessage = useCallback(
    ({ item }: { item: Message }) => (
      <View
        style={[
          styles.messageRow,
          item.isMine ? styles.messageRowRight : styles.messageRowLeft,
        ]}
      >
        {!item.isMine && (
          <View
            style={[styles.avatar, { backgroundColor: colors.accent + "20" }]}
          >
            <Text style={[styles.avatarText, { color: colors.accent }]}>
              {item.senderName.charAt(0).toUpperCase()}
            </Text>
          </View>
        )}
        <View style={styles.messageContainer}>
          {!item.isMine && (
            <Text style={[styles.senderName, { color: colors.textTertiary }]}>
              {item.senderName}
            </Text>
          )}
          <View
            style={[
              styles.bubble,
              item.isMine
                ? [styles.bubbleMine, { backgroundColor: colors.primary }]
                : [
                    styles.bubbleOther,
                    {
                      backgroundColor: colors.surface,
                      borderColor: colors.borderLight,
                    },
                  ],
            ]}
          >
            <Text
              style={[
                styles.messageText,
                { color: item.isMine ? colors.textOnPrimary : colors.text },
              ]}
            >
              {item.text}
            </Text>
          </View>
          <Text
            style={[
              styles.timestamp,
              { color: colors.textTertiary },
              item.isMine ? styles.timestampRight : styles.timestampLeft,
            ]}
          >
            {formatTime(item.timestamp)}
          </Text>
        </View>
      </View>
    ),
    [styles, colors],
  );

  return (
    <ScreenErrorBoundary>
      <KeyboardAvoidingView
        style={styles.container}
        behavior={Platform.OS === "ios" ? "padding" : undefined}
        keyboardVerticalOffset={Platform.OS === "ios" ? 90 : 0}
      >
        {/* Header */}
        <View
          style={[styles.header, { borderBottomColor: colors.borderLight }]}
        >
          <Icon name="lock" size={20} color={colors.primary} />
          <Text style={[styles.headerTitle, { color: colors.text }]}>
            {t("secret_chat.title")}
          </Text>
        </View>

        {/* Disclaimer */}
        <View
          style={[
            styles.disclaimer,
            { backgroundColor: colors.warning + "12" },
          ]}
        >
          <Icon name="shield-lock-outline" size={16} color={colors.warning} />
          <Text style={[styles.disclaimerText, { color: colors.warning }]}>
            {t("secret_chat.disclaimerChat")}
          </Text>
        </View>

        {/* Loading indicator */}
        {loading && (
          <View style={styles.loadingContainer}>
            <ActivityIndicator size="large" color={colors.primary} />
          </View>
        )}

        {/* No co-organizers notice */}
        {!loading && coOrganizerIds.length === 0 && (
          <View
            style={[
              styles.noCoOrgBanner,
              {
                backgroundColor: colors.warning + "14",
                borderColor: colors.warning + "40",
              },
            ]}
          >
            <Icon
              name="account-multiple-outline"
              size={16}
              color={colors.warning}
            />
            <Text style={[styles.noCoOrgText, { color: colors.warning }]}>
              {t("secret_chat.noCoOrgBanner")}
            </Text>
          </View>
        )}

        {/* Messages */}
        {!loading && (
          <FlatList
            ref={flatListRef}
            data={messages}
            keyExtractor={(item) => item.id}
            renderItem={renderMessage}
            contentContainerStyle={[
              styles.messageList,
              messages.length === 0 && styles.messageListEmpty,
            ]}
            showsVerticalScrollIndicator={false}
            onContentSizeChange={() => {
              if (messages.length > 0) {
                flatListRef.current?.scrollToEnd({ animated: false });
              }
            }}
            ListEmptyComponent={
              <EmptyState
                emoji="🔒"
                title={t("secret_chat.emptyTitle")}
                description={t("secret_chat.emptyDesc")}
                compact
              />
            }
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
              {
                color: colors.text,
                backgroundColor: colors.backgroundSecondary,
              },
            ]}
            value={inputText}
            onChangeText={setInputText}
            placeholder={t("secret_chat.inputPlaceholder")}
            placeholderTextColor={colors.textTertiary}
            multiline
            maxLength={1000}
            returnKeyType="default"
            editable={!sending}
          />
          <TouchableOpacity
            style={[
              styles.sendButton,
              {
                backgroundColor:
                  inputText.trim() && !sending
                    ? colors.primary
                    : colors.borderLight,
              },
            ]}
            onPress={handleSend}
            disabled={!inputText.trim() || sending}
          >
            {sending ? (
              <ActivityIndicator size="small" color={colors.textTertiary} />
            ) : (
              <Icon
                name="send"
                size={20}
                color={
                  inputText.trim() ? colors.textOnPrimary : colors.textTertiary
                }
              />
            )}
          </TouchableOpacity>
        </View>
      </KeyboardAvoidingView>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: { flex: 1, backgroundColor: colors.background },
    header: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      paddingHorizontal: Spacing.lg,
      paddingVertical: Spacing.md,
      borderBottomWidth: 1,
    },
    headerTitle: { ...Typography.h4 },
    disclaimer: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginHorizontal: Spacing.lg,
      marginTop: Spacing.sm,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      borderRadius: BorderRadius.md,
    },
    disclaimerText: { ...Typography.caption, fontWeight: "500", flex: 1 },
    messageList: {
      paddingHorizontal: Spacing.lg,
      paddingVertical: Spacing.md,
    },
    messageListEmpty: {
      flex: 1,
      justifyContent: "center",
    },
    messageRow: {
      flexDirection: "row",
      marginBottom: Spacing.md,
      maxWidth: "80%",
    },
    messageRowRight: { alignSelf: "flex-end" },
    messageRowLeft: { alignSelf: "flex-start" },
    avatar: {
      width: 32,
      height: 32,
      borderRadius: 16,
      alignItems: "center",
      justifyContent: "center",
      marginRight: Spacing.sm,
      marginTop: Spacing.sm + 4,
    },
    avatarText: { ...Typography.caption, fontWeight: "700" },
    messageContainer: {},
    senderName: {
      ...Typography.caption,
      fontWeight: "500",
      marginBottom: 2,
      marginLeft: 4,
    },
    bubble: {
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm + 2,
      maxWidth: "100%",
    },
    bubbleMine: {
      borderRadius: BorderRadius.lg,
      borderBottomRightRadius: BorderRadius.sm,
    },
    bubbleOther: {
      borderRadius: BorderRadius.lg,
      borderBottomLeftRadius: BorderRadius.sm,
      borderWidth: 1,
    },
    messageText: { ...Typography.body },
    timestamp: { ...Typography.caption, fontSize: 10, marginTop: 4 },
    timestampRight: { textAlign: "right", marginRight: 4 },
    timestampLeft: { textAlign: "left", marginLeft: 4 },
    loadingContainer: {
      flex: 1,
      alignItems: "center",
      justifyContent: "center",
    },
    noCoOrgBanner: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginHorizontal: Spacing.lg,
      marginTop: Spacing.sm,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      borderRadius: BorderRadius.md,
      borderWidth: 1,
    },
    noCoOrgText: { ...Typography.caption, fontWeight: "500", flex: 1 },
    inputBar: {
      flexDirection: "row",
      alignItems: "flex-end",
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      borderTopWidth: 1,
      gap: Spacing.sm,
    },
    textInput: {
      flex: 1,
      ...Typography.body,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm + 2,
      borderRadius: BorderRadius.lg,
      maxHeight: 100,
    },
    sendButton: {
      width: 42,
      height: 42,
      borderRadius: 21,
      alignItems: "center",
      justifyContent: "center",
    },
  });
