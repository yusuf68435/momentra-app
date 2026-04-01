import React, {
  useState,
  useMemo,
  useRef,
  useEffect,
  useCallback,
} from "react";
import {
  View,
  Text,
  ScrollView,
  FlatList,
  StyleSheet,
  TouchableOpacity,
  TextInput,
  KeyboardAvoidingView,
  Platform,
  Alert,
  Pressable,
} from "react-native";
import { useRouter } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon } from "../../src/components/ui/Icon";
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withSpring,
} from "react-native-reanimated";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  Springs,
} from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";
import { a11yButton, a11yTab } from "../../src/utils/accessibility";
import { Button } from "../../src/components/ui/Button";
import { Input } from "../../src/components/ui/Input";
import { CATEGORIES } from "../../src/constants/categories";
import { CategoryChip } from "../../src/components/common/CategoryChip";
import { useScenarioStore } from "../../src/stores/scenarioStore";
import { useAuthStore } from "../../src/stores/authStore";
import { useSettingsStore } from "../../src/stores/settingsStore";
import type { Scenario } from "../../src/types/database";
import * as aiService from "../../src/services/ai";
import {
  getRemainingCredits,
  consumeAICredit,
} from "../../src/services/credits";
import {
  getActiveConversation,
  createConversation,
  appendMessage,
} from "../../src/services/aiConversations";
import type { ConversationMessage } from "../../src/services/aiConversations";
import { ScreenErrorBoundary } from "../../src/components/common/ScreenErrorBoundary";
import { ChatBubble } from "../../src/components/ai/ChatBubble";
import { TypingIndicator } from "../../src/components/ai/TypingIndicator";

type TabMode = "recommend" | "chat";

const TAB_COUNT = 2;

interface ChatMessage {
  id: string;
  role: "user" | "assistant";
  content: string;
  timestamp: Date;
  actions?: Array<{
    type: string;
    label: string;
    data: Record<string, string>;
  }>;
}

function AIScreenContent() {
  const router = useRouter();
  const { t } = useTranslation("ai");
  const { t: tCommon } = useTranslation("common");
  const { i18n } = useTranslation();
  const lang = i18n.language as "tr" | "en";
  const { colors } = useTheme();
  const scrollRef = useRef<FlatList<ChatMessage>>(null);
  const { scenarios, loadScenarios } = useScenarioStore();
  const { user } = useAuthStore();
  const { subscriptionPlan } = useSettingsStore();

  const [remainingCredits, setRemainingCredits] = useState<number | null>(null);

  const refreshCredits = useCallback(async () => {
    if (!user?.id) return;
    try {
      const remaining = await getRemainingCredits(user.id, subscriptionPlan);
      setRemainingCredits(remaining);
    } catch (err) {
      if (__DEV__) {
        console.warn("[AI] Credits refresh failed:", err);
      }
    }
  }, [user?.id, subscriptionPlan]);

  useEffect(() => {
    refreshCredits();
  }, [refreshCredits]);

  useEffect(() => {
    if (scenarios.length === 0) {
      loadScenarios();
    }
  }, []);

  useEffect(() => {
    if (!user?.id) return;

    const loadChatHistory = async () => {
      setIsChatHistoryLoading(true);
      try {
        const conversation = await getActiveConversation();
        if (conversation && conversation.messages.length > 0) {
          const mapped: ChatMessage[] = conversation.messages.map(
            (msg: ConversationMessage, index: number) => ({
              id: `${conversation.id}-${index}`,
              role: msg.role,
              content: msg.content,
              timestamp: new Date(msg.timestamp),
              actions: msg.actions,
            }),
          );
          setChatMessages(mapped);
          setActiveConversationId(conversation.id);
        }
      } catch (err) {
        if (__DEV__) {
          console.warn("[AI] Failed to load chat history:", err);
        }
      } finally {
        setIsChatHistoryLoading(false);
      }
    };

    loadChatHistory();
  }, [user?.id]);

  const [activeTab, setActiveTab] = useState<TabMode>("recommend");

  // Animated underline for tab switcher
  const tabUnderlineX = useSharedValue(0);
  const tabContainerWidth = useSharedValue(0);

  const handleTabChange = useCallback(
    (tab: TabMode) => {
      setActiveTab(tab);
      const tabIndex = tab === "recommend" ? 0 : 1;
      tabUnderlineX.value = withSpring(tabIndex, Springs.snappy);
    },
    [tabUnderlineX],
  );

  const underlineStyle = useAnimatedStyle(() => {
    const tabWidth = tabContainerWidth.value / TAB_COUNT;
    return {
      width: tabWidth * 0.5,
      transform: [
        { translateX: tabUnderlineX.value * tabWidth + tabWidth * 0.25 },
      ],
    };
  });

  // Recommend state
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null);
  const [budget, setBudget] = useState("");
  const [whoFor, setWhoFor] = useState("");
  const [interests, setInterests] = useState("");
  const [guestCount, setGuestCount] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [recommendations, setRecommendations] = useState<Scenario[]>([]);
  const [aiReasons, setAiReasons] = useState<Record<string, string>>({});

  // Chat state
  const [chatMessages, setChatMessages] = useState<ChatMessage[]>([]);
  const [chatInput, setChatInput] = useState("");
  const [isChatLoading, setIsChatLoading] = useState(false);
  const [isChatHistoryLoading, setIsChatHistoryLoading] = useState(false);
  const [activeConversationId, setActiveConversationId] = useState<
    string | null
  >(null);

  const checkCreditsOrAlert = useCallback((): boolean => {
    if (remainingCredits !== null && remainingCredits <= 0) {
      Alert.alert(t("no_credits_title"), t("no_credits_message"), [
        { text: t("cancel"), style: "cancel" },
        {
          text: t("upgrade_plan"),
          onPress: () => router.push("/settings/subscription"),
        },
      ]);
      return false;
    }
    return true;
  }, [remainingCredits, t, router]);

  const handleSurpriseMe = async () => {
    if (!checkCreditsOrAlert()) return;

    setIsLoading(true);
    setRecommendations([]);
    setAiReasons({});

    try {
      const response = await aiService.getAIRecommendations({
        occasion: selectedCategory || "",
        recipient: whoFor,
        budget_min: 0,
        budget_max: budget ? parseInt(budget) : undefined,
        guest_count: guestCount ? parseInt(guestCount) : undefined,
        preferences: interests,
        language: lang,
      });

      if (response.recommendations?.length > 0) {
        const matchedScenarios = response.recommendations
          .map((rec) => {
            const scenario = scenarios.find((s) => s.id === rec.scenario_id);
            if (scenario) {
              setAiReasons((prev) => ({
                ...prev,
                [scenario.id]: lang === "tr" ? rec.reason_tr : rec.reason_en,
              }));
            }
            return scenario;
          })
          .filter((s): s is Scenario => s != null);

        if (matchedScenarios.length > 0) {
          setRecommendations(matchedScenarios);
          if (user?.id) {
            consumeAICredit(user.id, "recommend").then(() => refreshCredits());
          }
          setIsLoading(false);
          return;
        }
      }
    } catch (err) {
      if (__DEV__) {
        console.warn("[AI] Service unavailable, falling back to local:", err);
      }
    }

    // Fallback to local filtering
    let results = [...scenarios];
    if (selectedCategory) {
      results = results.filter((s) => s.category?.slug === selectedCategory);
    }
    if (budget) {
      const b = parseInt(budget);
      if (!isNaN(b)) results = results.filter((s) => (s.min_budget || 0) <= b);
    }
    if (guestCount) {
      const g = parseInt(guestCount);
      if (!isNaN(g))
        results = results.filter(
          (s) => s.min_people <= g && (s.max_people || 999) >= g,
        );
    }

    results.sort((a, b) => {
      if (a.is_featured && !b.is_featured) return -1;
      if (!a.is_featured && b.is_featured) return 1;
      return b.rating_avg - a.rating_avg;
    });

    setRecommendations(results.slice(0, 5));
    setIsLoading(false);
  };

  const handleSendChat = async (directMessage?: string) => {
    const messageText = (directMessage ?? chatInput).trim();
    if (!messageText) return;
    if (!checkCreditsOrAlert()) return;

    const userTimestamp = new Date();
    const userMessage: ChatMessage = {
      id: Date.now().toString(),
      role: "user",
      content: messageText,
      timestamp: userTimestamp,
    };

    setChatMessages((prev) => [...prev, userMessage]);
    setChatInput("");
    setIsChatLoading(true);

    try {
      const response = await aiService.sendAIChatMessage({
        message: userMessage.content,
        conversation_history: chatMessages.map((m) => ({
          role: m.role,
          content: m.content,
        })),
        language: lang,
      });

      const assistantTimestamp = new Date();
      const assistantMessage: ChatMessage = {
        id: (Date.now() + 1).toString(),
        role: "assistant",
        content: response.reply,
        timestamp: assistantTimestamp,
        actions: response.suggested_actions,
      };

      setChatMessages((prev) => [...prev, assistantMessage]);

      if (user?.id) {
        consumeAICredit(user.id, "chat").then(() => refreshCredits());

        // Persist both messages to DB after successful AI response
        try {
          let conversationId = activeConversationId;

          if (!conversationId) {
            const newConversation = await createConversation();
            if (newConversation) {
              conversationId = newConversation.id;
              setActiveConversationId(conversationId);
            }
          }

          if (conversationId) {
            const userDbMessage: ConversationMessage = {
              role: "user",
              content: userMessage.content,
              timestamp: userTimestamp.toISOString(),
            };
            const assistantDbMessage: ConversationMessage = {
              role: "assistant",
              content: assistantMessage.content,
              timestamp: assistantTimestamp.toISOString(),
              actions: assistantMessage.actions,
            };
            await appendMessage(conversationId, userDbMessage);
            await appendMessage(conversationId, assistantDbMessage);
          }
        } catch (persistErr) {
          if (__DEV__) {
            console.warn("[AI] Failed to persist conversation:", persistErr);
          }
        }
      }
    } catch {
      const fallbackMessage: ChatMessage = {
        id: (Date.now() + 1).toString(),
        role: "assistant",
        content: t("ai_unavailable"),
        timestamp: new Date(),
      };
      setChatMessages((prev) => [...prev, fallbackMessage]);
    } finally {
      setIsChatLoading(false);
      setTimeout(() => scrollRef.current?.scrollToEnd({ animated: true }), 100);
    }
  };

  const handleAction = (action: {
    type: string;
    label: string;
    data: Record<string, string>;
  }) => {
    switch (action.type) {
      case "view_scenario":
        if (action.data.id) router.push(`/scenario/${action.data.id}`);
        break;
      case "create_plan":
        router.push("/plan/create");
        break;
    }
  };

  const formatTimestamp = (date: Date): string => {
    return date.toLocaleTimeString(lang === "tr" ? "tr-TR" : "en-US", {
      hour: "2-digit",
      minute: "2-digit",
    });
  };

  const QUICK_PROMPTS = [
    { emoji: "\uD83C\uDF82", text: t("quick_birthday") },
    { emoji: "\uD83D\uDC9D", text: t("quick_romantic") },
    { emoji: "\uD83C\uDF93", text: t("quick_graduation") },
    { emoji: "\uD83D\uDCB0", text: t("quick_budget") },
    {
      emoji:
        "\uD83D\uDC68\u200D\uD83D\uDC69\u200D\uD83D\uDC67\u200D\uD83D\uDC66",
      text: t("quick_family"),
    },
  ];

  const styles = useMemo(() => createStyles(colors), [colors]);

  return (
    <KeyboardAvoidingView
      style={styles.container}
      behavior={Platform.OS === "ios" ? "padding" : undefined}
      keyboardVerticalOffset={90}
    >
      {/* Credits Badge */}
      {remainingCredits !== null && (
        <View style={styles.creditsBadgeRow}>
          <View style={styles.creditsBadge}>
            <Icon
              name="lightning-bolt"
              size={14}
              color={remainingCredits > 0 ? colors.primary : colors.error}
            />
            <Text
              style={[
                styles.creditsBadgeText,
                { color: remainingCredits > 0 ? colors.primary : colors.error },
              ]}
            >
              {remainingCredits === Infinity
                ? t("unlimited")
                : `${remainingCredits} ${t("ai_credits")}`}
            </Text>
          </View>
        </View>
      )}

      {/* Tab Switcher */}
      <View style={styles.tabBar}>
        <View
          style={styles.tabRow}
          onLayout={(e) => {
            tabContainerWidth.value = e.nativeEvent.layout.width;
          }}
        >
          <TouchableOpacity
            style={styles.tab}
            onPress={() => handleTabChange("recommend")}
            activeOpacity={0.7}
            {...a11yTab(t("tab_recommend"), activeTab === "recommend")}
          >
            <Text
              style={[
                styles.tabText,
                activeTab === "recommend" && styles.tabTextActive,
              ]}
            >
              {t("tab_recommend")}
            </Text>
          </TouchableOpacity>
          <TouchableOpacity
            style={styles.tab}
            onPress={() => handleTabChange("chat")}
            activeOpacity={0.7}
            {...a11yTab(t("tab_chat"), activeTab === "chat")}
          >
            <Text
              style={[
                styles.tabText,
                activeTab === "chat" && styles.tabTextActive,
              ]}
            >
              {t("tab_chat")}
            </Text>
          </TouchableOpacity>
        </View>
        <Animated.View
          style={[
            styles.tabUnderline,
            { backgroundColor: colors.primary },
            underlineStyle,
          ]}
        />
        <View
          style={[styles.tabDivider, { backgroundColor: colors.borderLight }]}
        />
      </View>

      {activeTab === "recommend" ? (
        <ScrollView showsVerticalScrollIndicator={false}>
          {/* Hero */}
          <View style={styles.hero}>
            <View style={styles.robotCircle}>
              <Icon name="robot-happy" size={28} color={colors.primary} />
            </View>
            <Text style={styles.heroTitle}>{t("surprise_me")}</Text>
            <Text style={styles.heroSubtitle}>{t("surprise_me_desc")}</Text>
          </View>

          {/* Card 1: Category chips */}
          <View style={styles.formSection}>
            <View style={styles.formCard}>
              <Text style={styles.fieldLabel}>{t("occasion")}</Text>
              <FlatList
                horizontal
                showsHorizontalScrollIndicator={false}
                data={CATEGORIES}
                keyExtractor={(item) => item.slug}
                style={styles.categoryRow}
                renderItem={({ item: cat }) => (
                  <View style={{ marginRight: Spacing.sm }}>
                    <CategoryChip
                      label={tCommon(`categories.${cat.slug}`)}
                      icon={cat.icon}
                      color={cat.color}
                      selected={selectedCategory === cat.slug}
                      onPress={() =>
                        setSelectedCategory(
                          selectedCategory === cat.slug ? null : cat.slug,
                        )
                      }
                    />
                  </View>
                )}
              />
            </View>
          </View>

          {/* Card 2: Who For + Interests */}
          <View style={styles.formSection}>
            <View style={styles.formCard}>
              <Input
                label={t("who_for")}
                placeholder={t("who_for_placeholder")}
                value={whoFor}
                onChangeText={setWhoFor}
              />
              <Input
                label={t("their_interests")}
                placeholder={t("interests_placeholder")}
                value={interests}
                onChangeText={setInterests}
                multiline
                numberOfLines={2}
              />
            </View>
          </View>

          {/* Card 3: Budget + Guest Count */}
          <View style={styles.formSection}>
            <View style={styles.formCard}>
              <View style={styles.twoColumns}>
                <View style={{ flex: 1 }}>
                  <Input
                    label={t("your_budget")}
                    placeholder="1000"
                    value={budget}
                    onChangeText={setBudget}
                    keyboardType="numeric"
                  />
                </View>
                <View style={{ flex: 1 }}>
                  <Input
                    label={t("guest_count")}
                    placeholder="4"
                    value={guestCount}
                    onChangeText={setGuestCount}
                    keyboardType="numeric"
                  />
                </View>
              </View>
            </View>
          </View>

          {/* CTA Button */}
          <View style={styles.ctaSection}>
            <Pressable
              onPress={handleSurpriseMe}
              disabled={isLoading}
              style={[styles.ctaButton, { opacity: isLoading ? 0.6 : 1 }]}
            >
              {!isLoading && (
                <Icon name="auto-fix" size={22} color={colors.textOnPrimary} />
              )}
              <Text style={styles.ctaButtonText}>
                {isLoading ? t("generating") : t("find_surprises")}
              </Text>
            </Pressable>
          </View>

          {/* AI Recommendations */}
          {recommendations.length > 0 && (
            <View style={styles.recommendationsSection}>
              <View style={styles.aiResultHeader}>
                <Icon name="auto-fix" size={20} color={colors.primary} />
                <Text style={styles.aiResultTitle}>
                  {t("ai_recommendations")}
                </Text>
              </View>
              {recommendations.map((item) => {
                const reason = aiReasons[item.id];
                return (
                  <TouchableOpacity
                    key={item.id}
                    style={styles.recommendationCard}
                    onPress={() => router.push(`/scenario/${item.id}`)}
                    activeOpacity={0.85}
                    {...a11yButton(
                      lang === "tr" ? item.title_tr : item.title_en,
                    )}
                  >
                    <View style={styles.recLeft}>
                      <Text style={{ fontSize: 28 }}>
                        {item.category?.icon || "\uD83C\uDF89"}
                      </Text>
                    </View>
                    <View style={styles.recContent}>
                      <Text style={styles.recTitle} numberOfLines={2}>
                        {lang === "tr" ? item.title_tr : item.title_en}
                      </Text>
                      {reason ? (
                        <Text style={styles.recReason} numberOfLines={2}>
                          {reason}
                        </Text>
                      ) : (
                        <Text style={styles.recDesc} numberOfLines={1}>
                          {lang === "tr"
                            ? item.short_desc_tr
                            : item.short_desc_en}
                        </Text>
                      )}
                      <View style={styles.recMeta}>
                        <Text style={styles.recBudget}>
                          {"\u20BA"}
                          {item.min_budget?.toLocaleString()}-
                          {item.max_budget?.toLocaleString()}
                        </Text>
                        <Text style={styles.recRating}>
                          {"\u2605"} {(item.rating_avg ?? 0).toFixed(1)}
                        </Text>
                        <Text style={styles.recPeople}>
                          {item.min_people}-{item.max_people} {t("people")}
                        </Text>
                      </View>
                    </View>
                    <Icon
                      name="chevron-right"
                      size={20}
                      color={colors.textTertiary}
                    />
                  </TouchableOpacity>
                );
              })}
            </View>
          )}

          {/* Tips */}
          <View style={styles.tipsCard}>
            <View style={styles.tipIcon}>
              <Icon name="lightbulb" size={22} color={colors.primary} />
            </View>
            <Text style={styles.tipsTitle}>{t("tip")}</Text>
            <Text style={styles.tipsText}>{t("tip_text")}</Text>
          </View>

          <View style={{ height: Spacing.xxl }} />
        </ScrollView>
      ) : (
        /* Chat Mode */
        <>
          <FlatList
            ref={scrollRef}
            data={chatMessages}
            keyExtractor={(item) => item.id}
            style={styles.chatContainer}
            contentContainerStyle={[
              styles.chatContent,
              chatMessages.length === 0 && { flexGrow: 1 },
            ]}
            showsVerticalScrollIndicator={false}
            onContentSizeChange={() =>
              scrollRef.current?.scrollToEnd({ animated: true })
            }
            ListEmptyComponent={
              isChatHistoryLoading ? (
                <View style={styles.chatEmpty}>
                  <View style={styles.typingRow}>
                    <View style={styles.typingAvatar}>
                      <Icon
                        name="robot-happy"
                        size={14}
                        color={colors.primary}
                      />
                    </View>
                    <View style={styles.typingBubble}>
                      <TypingIndicator />
                    </View>
                  </View>
                </View>
              ) : (
                <View style={styles.chatEmpty}>
                  <View style={styles.chatEmptyIcon}>
                    <Icon
                      name="chat-processing-outline"
                      size={48}
                      color={colors.primary}
                    />
                  </View>
                  <Text style={styles.chatEmptyTitle}>{t("ask_ai")}</Text>
                  <Text style={styles.chatEmptyDesc}>{t("ask_ai_desc")}</Text>

                  {/* Quick Prompts as pills */}
                  <View style={styles.quickPromptsContainer}>
                    {QUICK_PROMPTS.map((prompt, i) => (
                      <Pressable
                        key={i}
                        style={styles.quickPromptPill}
                        onPress={() =>
                          handleSendChat(`${prompt.emoji} ${prompt.text}`)
                        }
                        accessibilityLabel={prompt.text}
                        accessibilityRole="button"
                      >
                        <Text style={styles.quickPromptText}>
                          {prompt.emoji} {prompt.text}
                        </Text>
                      </Pressable>
                    ))}
                  </View>
                </View>
              )
            }
            ListFooterComponent={
              isChatLoading ? (
                <View style={styles.typingRow}>
                  <View style={styles.typingAvatar}>
                    <Icon name="robot-happy" size={14} color={colors.primary} />
                  </View>
                  <View style={styles.typingBubble}>
                    <TypingIndicator />
                  </View>
                </View>
              ) : null
            }
            renderItem={({ item: msg }) => (
              <ChatBubble
                role={msg.role}
                content={msg.content}
                timestamp={formatTimestamp(msg.timestamp)}
                actions={msg.actions?.map((action) => ({
                  label: action.label,
                  onPress: () => handleAction(action),
                }))}
              />
            )}
          />

          {/* Chat Input */}
          <View style={styles.chatInputContainer}>
            <TextInput
              style={styles.chatInput}
              value={chatInput}
              onChangeText={setChatInput}
              placeholder={t("chat_input_placeholder")}
              placeholderTextColor={colors.textTertiary}
              multiline
              maxLength={500}
              returnKeyType="send"
              onSubmitEditing={() => handleSendChat()}
              accessibilityLabel={t("chat_input_placeholder")}
            />
            <Pressable
              onPress={() => handleSendChat()}
              disabled={!chatInput.trim() || isChatLoading}
              {...a11yButton(t("send") || "Send")}
              style={[
                styles.sendButton,
                {
                  backgroundColor:
                    chatInput.trim() && !isChatLoading
                      ? colors.primary
                      : colors.backgroundSecondary,
                },
              ]}
            >
              <Icon
                name="send"
                size={20}
                color={
                  chatInput.trim() && !isChatLoading
                    ? colors.textOnPrimary
                    : colors.textTertiary
                }
              />
            </Pressable>
          </View>
        </>
      )}
    </KeyboardAvoidingView>
  );
}

export default function AiScreen() {
  return (
    <ScreenErrorBoundary>
      <AIScreenContent />
    </ScreenErrorBoundary>
  );
}

const createStyles = (
  colors: ReturnType<typeof import("../../src/constants/theme").getColors>,
) =>
  StyleSheet.create({
    container: { flex: 1, backgroundColor: colors.background },

    // Credits Badge
    creditsBadgeRow: {
      flexDirection: "row",
      justifyContent: "flex-end",
      paddingHorizontal: Spacing.lg,
      paddingTop: Spacing.xs,
    },
    creditsBadge: {
      flexDirection: "row",
      alignItems: "center",
      gap: 4,
      paddingHorizontal: Spacing.sm,
      paddingVertical: 3,
      borderRadius: BorderRadius.full,
      backgroundColor: colors.backgroundSecondary,
    },
    creditsBadgeText: {
      ...Typography.caption,
      fontWeight: "600",
    },

    // Tab Bar
    tabBar: {
      marginHorizontal: Spacing.lg,
      marginTop: Spacing.sm,
      marginBottom: Spacing.xs,
    },
    tabRow: {
      flexDirection: "row",
    },
    tab: {
      flex: 1,
      alignItems: "center",
      justifyContent: "center",
      paddingVertical: Spacing.smd,
    },
    tabText: {
      ...Typography.h4,
      color: colors.textTertiary,
    },
    tabTextActive: {
      color: colors.primary,
    },
    tabUnderline: {
      height: 2,
      borderRadius: 1,
      position: "absolute",
      bottom: 0,
    },
    tabDivider: {
      height: 1,
      width: "100%",
    },

    // Hero
    hero: {
      alignItems: "center",
      paddingVertical: Spacing.xl,
      paddingHorizontal: Spacing.lg,
      backgroundColor: colors.background,
    },
    robotCircle: {
      width: 56,
      height: 56,
      borderRadius: 28,
      backgroundColor: colors.primaryLight,
      alignItems: "center",
      justifyContent: "center",
    },
    heroTitle: {
      ...Typography.h2,
      color: colors.text,
      marginTop: Spacing.md,
    },
    heroSubtitle: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
      textAlign: "center",
      marginTop: Spacing.sm,
    },

    // Form
    formSection: {
      paddingHorizontal: Spacing.lg,
    },
    formCard: {
      backgroundColor: colors.surface,
      padding: 16,
      borderRadius: BorderRadius.md,
      marginBottom: Spacing.md,
      ...Shadows.sm,
    },
    fieldLabel: {
      ...Typography.caption,
      color: colors.textSecondary,
      marginBottom: Spacing.sm,
    },
    categoryRow: { maxHeight: 48 },
    twoColumns: { flexDirection: "row", gap: Spacing.md },

    // CTA
    ctaSection: {
      paddingHorizontal: Spacing.lg,
      marginBottom: Spacing.md,
    },
    ctaButton: {
      backgroundColor: colors.primary,
      borderRadius: BorderRadius.md,
      paddingVertical: 16,
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
    },
    ctaButtonText: {
      ...Typography.button,
      color: colors.textOnPrimary,
    },

    // Recommendations
    recommendationsSection: {
      paddingHorizontal: Spacing.lg,
      paddingTop: Spacing.lg,
    },
    aiResultHeader: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginBottom: Spacing.md,
    },
    aiResultTitle: { ...Typography.h3, color: colors.text },
    recommendationCard: {
      flexDirection: "row",
      alignItems: "center",
      padding: Spacing.md,
      marginBottom: Spacing.md,
      borderRadius: BorderRadius.md,
      backgroundColor: colors.surface,
      ...Shadows.sm,
    },
    recLeft: {
      width: 52,
      height: 52,
      borderRadius: BorderRadius.md,
      backgroundColor: colors.backgroundSecondary,
      alignItems: "center",
      justifyContent: "center",
      marginRight: Spacing.md,
    },
    recContent: { flex: 1 },
    recTitle: { ...Typography.body, fontWeight: "600", color: colors.text },
    recDesc: {
      ...Typography.caption,
      color: colors.textSecondary,
      marginTop: 1,
    },
    recReason: {
      ...Typography.caption,
      color: colors.primary,
      marginTop: 2,
      fontStyle: "italic",
    },
    recMeta: { flexDirection: "row", gap: Spacing.md, marginTop: 4 },
    recBudget: {
      ...Typography.caption,
      color: colors.success,
      fontWeight: "500",
    },
    recRating: {
      ...Typography.caption,
      color: colors.warning,
      fontWeight: "600",
    },
    recPeople: {
      ...Typography.caption,
      color: colors.textSecondary,
      fontWeight: "500",
    },

    // Tips
    tipsCard: {
      margin: Spacing.lg,
      padding: Spacing.lg,
      borderRadius: BorderRadius.md,
      alignItems: "center",
      backgroundColor: colors.backgroundSecondary,
    },
    tipIcon: {
      width: 44,
      height: 44,
      borderRadius: 22,
      backgroundColor: colors.primaryLight,
      alignItems: "center",
      justifyContent: "center",
    },
    tipsTitle: {
      ...Typography.h4,
      color: colors.text,
      marginTop: Spacing.xs,
    },
    tipsText: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
      textAlign: "center",
      marginTop: Spacing.xs,
    },

    // Chat tab
    chatContainer: { flex: 1 },
    chatContent: { padding: Spacing.lg, paddingBottom: Spacing.xxl },

    // Chat empty state
    chatEmpty: { alignItems: "center", paddingTop: Spacing.xl },
    chatEmptyIcon: {
      width: 80,
      height: 80,
      borderRadius: 40,
      backgroundColor: colors.primaryLight,
      alignItems: "center",
      justifyContent: "center",
    },
    chatEmptyTitle: {
      ...Typography.h3,
      color: colors.text,
      marginTop: Spacing.md,
    },
    chatEmptyDesc: {
      ...Typography.bodySmall,
      color: colors.textSecondary,
      textAlign: "center",
      marginTop: Spacing.xs,
    },

    // Quick prompts as pills
    quickPromptsContainer: {
      flexDirection: "row",
      flexWrap: "wrap",
      gap: Spacing.sm,
      marginTop: Spacing.xl,
      justifyContent: "center",
      paddingHorizontal: Spacing.md,
    },
    quickPromptPill: {
      backgroundColor: colors.backgroundSecondary,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      borderRadius: BorderRadius.full,
    },
    quickPromptText: {
      ...Typography.bodySmall,
      color: colors.text,
    },

    // Typing indicator row
    typingRow: {
      flexDirection: "row",
      alignItems: "flex-end",
      marginBottom: Spacing.md,
    },
    typingAvatar: {
      width: 24,
      height: 24,
      borderRadius: 12,
      backgroundColor: colors.primaryLight,
      alignItems: "center",
      justifyContent: "center",
      marginRight: Spacing.sm,
      marginBottom: 2,
    },
    typingBubble: {
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.xs,
      borderRadius: 16,
      backgroundColor: colors.backgroundSecondary,
    },

    // Chat input
    chatInputContainer: {
      flexDirection: "row",
      alignItems: "flex-end",
      paddingHorizontal: Spacing.lg,
      paddingVertical: Spacing.sm,
      paddingBottom: Spacing.lg,
      gap: Spacing.sm,
      backgroundColor: colors.background,
      borderTopWidth: 1,
      borderTopColor: colors.borderLight,
    },
    chatInput: {
      flex: 1,
      ...Typography.body,
      color: colors.text,
      backgroundColor: colors.backgroundSecondary,
      borderRadius: BorderRadius.full,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm + 2,
      maxHeight: 100,
    },
    sendButton: {
      width: 44,
      height: 44,
      borderRadius: 22,
      alignItems: "center",
      justifyContent: "center",
    },
  });
