import React, { useState, useCallback, useMemo, useEffect } from "react";
import {
  View,
  Text,
  FlatList,
  StyleSheet,
  TouchableOpacity,
  TextInput,
  Modal,
  Linking,
  KeyboardAvoidingView,
  Platform,
  ScrollView,
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
import { useGiftStore, type Gift } from "../../../src/stores/giftStore";
import { usePlanStore } from "../../../src/stores/planStore";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";
import { EmptyState } from "../../../src/components/common/EmptyState";

type GiftFilter = "all" | "purchased" | "not_purchased";

export default function GiftsScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const { t, i18n } = useTranslation();
  const lang = i18n.language as "tr" | "en";
  const { colors } = useTheme();

  const {
    gifts: allGifts,
    suggestions,
    isLoading,
    fetchGifts,
    fetchSuggestions,
    saveGift,
    markPurchased,
    removeGift,
  } = useGiftStore();
  const { plans } = usePlanStore();
  const plan = plans.find((p) => p.id === id);

  const gifts: Gift[] = allGifts[id] ?? [];

  const [filter, setFilter] = useState<GiftFilter>("all");
  const [showAddModal, setShowAddModal] = useState(false);
  const [showSuggestionsModal, setShowSuggestionsModal] = useState(false);
  const [newName, setNewName] = useState("");
  const [newDescription, setNewDescription] = useState("");
  const [newPrice, setNewPrice] = useState("");
  const [newUrl, setNewUrl] = useState("");
  const [isSaving, setIsSaving] = useState(false);

  useEffect(() => {
    if (id) fetchGifts(id);
  }, [id]);

  const filteredGifts = useMemo(() => {
    if (filter === "purchased") return gifts.filter((g) => g.is_purchased);
    if (filter === "not_purchased") return gifts.filter((g) => !g.is_purchased);
    return gifts;
  }, [gifts, filter]);

  const totalEstimated = useMemo(() => {
    return gifts.reduce((sum, g) => {
      if (!g.price_range) return sum;
      const match = g.price_range.match(/[\d.]+/);
      return sum + (match ? parseFloat(match[0]) : 0);
    }, 0);
  }, [gifts]);

  const purchasedCount = gifts.filter((g) => g.is_purchased).length;

  const handleTogglePurchased = useCallback(
    async (giftId: string) => {
      try {
        await markPurchased(giftId);
      } catch {
        Alert.alert(t("common.error"), t("gifts.update_failed"));
      }
    },
    [markPurchased, lang],
  );

  const handleDeleteGift = useCallback(
    (giftId: string) => {
      Alert.alert(t("gifts.delete_gift"), t("gifts.delete_confirm"), [
        { text: t("common.cancel"), style: "cancel" },
        {
          text: t("common.delete"),
          style: "destructive",
          onPress: async () => {
            try {
              await removeGift(giftId);
            } catch {
              Alert.alert(t("common.error"), t("gifts.delete_failed"));
            }
          },
        },
      ]);
    },
    [removeGift, lang],
  );

  const handleAddGift = useCallback(async () => {
    if (!newName.trim() || !id) return;
    setIsSaving(true);
    try {
      const price = parseFloat(newPrice) || 0;
      await saveGift(id, {
        name: newName.trim(),
        description: newDescription.trim() || undefined,
        price_range: price > 0 ? `${price} TL` : undefined,
        purchase_url: newUrl.trim() || undefined,
      });
      setShowAddModal(false);
      setNewName("");
      setNewDescription("");
      setNewPrice("");
      setNewUrl("");
    } catch {
      Alert.alert(t("common.error"), t("gifts.add_failed"));
    } finally {
      setIsSaving(false);
    }
  }, [id, newName, newDescription, newPrice, newUrl, saveGift, lang]);

  const handleAISuggestions = useCallback(async () => {
    if (!id) return;
    setShowSuggestionsModal(true);
    if (suggestions.length === 0) {
      await fetchSuggestions({
        name: plan?.recipient_name ?? undefined,
        budget: plan?.budget ?? undefined,
        occasion: plan?.title,
        language: lang,
      });
    }
  }, [id, plan, suggestions.length, fetchSuggestions]);

  const handleSaveSuggestion = useCallback(
    async (suggestion: (typeof suggestions)[0]) => {
      if (!id) return;
      try {
        await saveGift(id, {
          name: suggestion.name,
          description: suggestion.description,
          price_range: suggestion.price_range,
          category: suggestion.category,
        });
      } catch {
        Alert.alert(t("common.error"), t("gifts.save_failed"));
      }
    },
    [id, saveGift, lang],
  );

  const handleOpenLink = useCallback((url: string) => {
    if (url) Linking.openURL(url).catch(() => {});
  }, []);

  const styles = useMemo(() => createStyles(colors), [colors]);

  const filterTabs: { key: GiftFilter; label: string }[] = [
    { key: "all", label: t("gifts.filter_all") },
    { key: "purchased", label: t("gifts.filter_purchased") },
    { key: "not_purchased", label: t("gifts.filter_not_purchased") },
  ];

  const renderGift = useCallback(
    ({ item }: { item: Gift }) => (
      <View style={styles.giftCard}>
        <View
          style={[
            styles.giftImagePlaceholder,
            { backgroundColor: colors.primary + "12" },
          ]}
        >
          <Icon name="gift-outline" size={28} color={colors.primary} />
        </View>
        <View style={styles.giftContent}>
          <View style={styles.giftHeader}>
            <Text
              style={[styles.giftName, { color: colors.text }]}
              numberOfLines={1}
            >
              {item.name}
            </Text>
            <TouchableOpacity onPress={() => handleTogglePurchased(item.id)}>
              <Icon
                name={
                  item.is_purchased
                    ? "checkbox-marked-circle"
                    : "checkbox-blank-circle-outline"
                }
                size={24}
                color={item.is_purchased ? colors.success : colors.textTertiary}
              />
            </TouchableOpacity>
          </View>
          {item.description ? (
            <Text
              style={[styles.giftDesc, { color: colors.textSecondary }]}
              numberOfLines={2}
            >
              {item.description}
            </Text>
          ) : null}
          <View style={styles.giftFooter}>
            {item.price_range ? (
              <View
                style={[
                  styles.priceBadge,
                  { backgroundColor: colors.success + "15" },
                ]}
              >
                <Icon name="cash" size={14} color={colors.success} />
                <Text style={[styles.priceText, { color: colors.success }]}>
                  {item.price_range}
                </Text>
              </View>
            ) : null}
            {item.purchase_url ? (
              <TouchableOpacity
                style={[
                  styles.linkButton,
                  { backgroundColor: colors.info + "15" },
                ]}
                onPress={() => handleOpenLink(item.purchase_url!)}
              >
                <Icon name="open-in-new" size={14} color={colors.info} />
                <Text style={[styles.linkText, { color: colors.info }]}>
                  {t("gifts.buy")}
                </Text>
              </TouchableOpacity>
            ) : null}
            <TouchableOpacity
              style={[
                styles.deleteBtn,
                { backgroundColor: colors.error + "15" },
              ]}
              onPress={() => handleDeleteGift(item.id)}
            >
              <Icon name="trash-can-outline" size={14} color={colors.error} />
            </TouchableOpacity>
          </View>
        </View>
      </View>
    ),
    [
      styles,
      colors,
      lang,
      handleTogglePurchased,
      handleOpenLink,
      handleDeleteGift,
    ],
  );

  return (
    <ScreenErrorBoundary>
      <View style={styles.container}>
        <View style={styles.header}>
          <Text style={[styles.headerTitle, { color: colors.text }]}>
            {t("gifts.title")}
          </Text>
          {gifts.length > 0 && (
            <View style={styles.headerStats}>
              <Text style={[styles.statsText, { color: colors.textSecondary }]}>
                {purchasedCount}/{gifts.length} {t("gifts.purchased")}
              </Text>
              {totalEstimated > 0 && (
                <Text style={[styles.totalCost, { color: colors.primary }]}>
                  ~{totalEstimated.toLocaleString()} TL
                </Text>
              )}
            </View>
          )}
        </View>

        <TouchableOpacity
          style={[
            styles.aiButton,
            {
              backgroundColor: colors.accent + "15",
              borderColor: colors.accent,
            },
          ]}
          onPress={handleAISuggestions}
          disabled={isLoading}
          activeOpacity={0.7}
        >
          <Icon name="creation" size={22} color={colors.accent} />
          <Text style={[styles.aiButtonText, { color: colors.accent }]}>
            {t("gifts.ai_suggest")}
          </Text>
        </TouchableOpacity>

        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
          style={styles.filterRow}
          contentContainerStyle={styles.filterContent}
        >
          {filterTabs.map((tab) => (
            <TouchableOpacity
              key={tab.key}
              style={[
                styles.filterTab,
                {
                  backgroundColor:
                    filter === tab.key ? colors.primary : colors.surfaceVariant,
                },
              ]}
              onPress={() => setFilter(tab.key)}
            >
              <Text
                style={[
                  styles.filterTabText,
                  {
                    color:
                      filter === tab.key
                        ? colors.textOnPrimary
                        : colors.textSecondary,
                  },
                ]}
              >
                {tab.label}
              </Text>
            </TouchableOpacity>
          ))}
        </ScrollView>

        {isLoading && gifts.length === 0 ? (
          <View style={styles.loadingState}>
            <ActivityIndicator size="large" color={colors.primary} />
          </View>
        ) : (
          <FlatList
            data={filteredGifts}
            keyExtractor={(item) => item.id}
            renderItem={renderGift}
            contentContainerStyle={styles.list}
            showsVerticalScrollIndicator={false}
            ListEmptyComponent={
              <EmptyState
                emoji="🎁"
                title={t("gifts.empty_title")}
                description={t("gifts.empty_desc")}
                compact
              />
            }
          />
        )}

        <TouchableOpacity
          style={[styles.fab, { backgroundColor: colors.primary }]}
          onPress={() => setShowAddModal(true)}
          activeOpacity={0.8}
        >
          <Icon name="plus" size={26} color={colors.textOnPrimary} />
        </TouchableOpacity>

        {/* Add Gift Modal */}
        <Modal visible={showAddModal} animationType="slide" transparent>
          <View style={styles.modalOverlay}>
            <KeyboardAvoidingView
              behavior={Platform.OS === "ios" ? "padding" : undefined}
              style={styles.modalWrapper}
            >
              <View
                style={[
                  styles.modalContent,
                  { backgroundColor: colors.surface },
                ]}
              >
                <View style={styles.modalHeader}>
                  <Text style={[styles.modalTitle, { color: colors.text }]}>
                    {t("gifts.add_gift")}
                  </Text>
                  <TouchableOpacity onPress={() => setShowAddModal(false)}>
                    <Icon name="close" size={24} color={colors.text} />
                  </TouchableOpacity>
                </View>
                <ScrollView showsVerticalScrollIndicator={false}>
                  <View style={styles.inputGroup}>
                    <Text
                      style={[
                        styles.inputLabel,
                        { color: colors.textSecondary },
                      ]}
                    >
                      {t("gifts.name_label")}
                    </Text>
                    <TextInput
                      style={[
                        styles.input,
                        {
                          color: colors.text,
                          backgroundColor: colors.backgroundSecondary,
                          borderColor: colors.borderLight,
                        },
                      ]}
                      value={newName}
                      onChangeText={setNewName}
                      placeholder={t("gifts.name_placeholder")}
                      placeholderTextColor={colors.textTertiary}
                    />
                  </View>
                  <View style={styles.inputGroup}>
                    <Text
                      style={[
                        styles.inputLabel,
                        { color: colors.textSecondary },
                      ]}
                    >
                      {t("gifts.description_label")}
                    </Text>
                    <TextInput
                      style={[
                        styles.input,
                        styles.textArea,
                        {
                          color: colors.text,
                          backgroundColor: colors.backgroundSecondary,
                          borderColor: colors.borderLight,
                        },
                      ]}
                      value={newDescription}
                      onChangeText={setNewDescription}
                      placeholder={t("gifts.description_placeholder")}
                      placeholderTextColor={colors.textTertiary}
                      multiline
                      textAlignVertical="top"
                    />
                  </View>
                  <View style={styles.inputGroup}>
                    <Text
                      style={[
                        styles.inputLabel,
                        { color: colors.textSecondary },
                      ]}
                    >
                      {t("gifts.price_label")}
                    </Text>
                    <TextInput
                      style={[
                        styles.input,
                        {
                          color: colors.text,
                          backgroundColor: colors.backgroundSecondary,
                          borderColor: colors.borderLight,
                        },
                      ]}
                      value={newPrice}
                      onChangeText={setNewPrice}
                      placeholder="0"
                      placeholderTextColor={colors.textTertiary}
                      keyboardType="numeric"
                    />
                  </View>
                  <View style={styles.inputGroup}>
                    <Text
                      style={[
                        styles.inputLabel,
                        { color: colors.textSecondary },
                      ]}
                    >
                      {t("gifts.url_label")}
                    </Text>
                    <TextInput
                      style={[
                        styles.input,
                        {
                          color: colors.text,
                          backgroundColor: colors.backgroundSecondary,
                          borderColor: colors.borderLight,
                        },
                      ]}
                      value={newUrl}
                      onChangeText={setNewUrl}
                      placeholder="https://..."
                      placeholderTextColor={colors.textTertiary}
                      autoCapitalize="none"
                      keyboardType="url"
                    />
                  </View>
                  <TouchableOpacity
                    style={[
                      styles.saveButton,
                      {
                        backgroundColor:
                          newName.trim() && !isSaving
                            ? colors.primary
                            : colors.borderLight,
                      },
                    ]}
                    onPress={handleAddGift}
                    disabled={!newName.trim() || isSaving}
                  >
                    {isSaving ? (
                      <ActivityIndicator
                        size="small"
                        color={colors.textOnPrimary}
                      />
                    ) : (
                      <Text
                        style={[
                          styles.saveButtonText,
                          { color: colors.textOnPrimary },
                        ]}
                      >
                        {t("gifts.add_button")}
                      </Text>
                    )}
                  </TouchableOpacity>
                </ScrollView>
              </View>
            </KeyboardAvoidingView>
          </View>
        </Modal>

        {/* AI Suggestions Modal */}
        <Modal
          visible={showSuggestionsModal}
          animationType="slide"
          presentationStyle="pageSheet"
        >
          <View
            style={[
              styles.suggestionsContainer,
              { backgroundColor: colors.background },
            ]}
          >
            <View
              style={[
                styles.suggestionsHeader,
                { borderBottomColor: colors.borderLight },
              ]}
            >
              <Text style={[styles.modalTitle, { color: colors.text }]}>
                {t("gifts.ai_suggestions_title")}
              </Text>
              <TouchableOpacity onPress={() => setShowSuggestionsModal(false)}>
                <Icon name="close" size={24} color={colors.text} />
              </TouchableOpacity>
            </View>
            {isLoading ? (
              <View style={styles.loadingState}>
                <ActivityIndicator size="large" color={colors.primary} />
                <Text
                  style={[
                    styles.emptyDesc,
                    { color: colors.textSecondary, marginTop: Spacing.md },
                  ]}
                >
                  {t("gifts.ai_loading")}
                </Text>
              </View>
            ) : (
              <ScrollView contentContainerStyle={styles.suggestionsList}>
                {suggestions.map((s, i) => (
                  <View
                    key={i}
                    style={[
                      styles.suggestionCard,
                      {
                        backgroundColor: colors.surface,
                        borderColor: colors.borderLight,
                      },
                    ]}
                  >
                    <View style={styles.suggestionTopRow}>
                      <Text
                        style={[
                          styles.giftName,
                          { color: colors.text, flex: 1 },
                        ]}
                      >
                        {s.name}
                      </Text>
                      <View
                        style={[
                          styles.priceBadge,
                          { backgroundColor: colors.success + "15" },
                        ]}
                      >
                        <Text
                          style={[styles.priceText, { color: colors.success }]}
                        >
                          {s.price_range}
                        </Text>
                      </View>
                    </View>
                    <Text
                      style={[styles.giftDesc, { color: colors.textSecondary }]}
                    >
                      {s.description}
                    </Text>
                    {s.why_its_great ? (
                      <Text style={[styles.whyText, { color: colors.primary }]}>
                        ✨ {s.why_its_great}
                      </Text>
                    ) : null}
                    <TouchableOpacity
                      style={[
                        styles.addSuggestionBtn,
                        { backgroundColor: colors.primary },
                      ]}
                      onPress={() => handleSaveSuggestion(s)}
                    >
                      <Text
                        style={[
                          styles.saveButtonText,
                          { color: colors.textOnPrimary },
                        ]}
                      >
                        {t("gifts.add_to_list")}
                      </Text>
                    </TouchableOpacity>
                  </View>
                ))}
              </ScrollView>
            )}
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
      padding: Spacing.lg,
      borderBottomWidth: 1,
      borderBottomColor: colors.borderLight,
    },
    headerTitle: { ...Typography.h3 },
    headerStats: {
      flexDirection: "row",
      justifyContent: "space-between",
      marginTop: Spacing.xs,
    },
    statsText: { ...Typography.caption },
    totalCost: { ...Typography.bodySmall, fontWeight: "700" },
    aiButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      marginHorizontal: Spacing.lg,
      marginTop: Spacing.lg,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1.5,
    },
    aiButtonText: { ...Typography.button },
    filterRow: { marginTop: Spacing.md, maxHeight: 48 },
    filterContent: { paddingHorizontal: Spacing.lg, gap: Spacing.sm },
    filterTab: {
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      borderRadius: BorderRadius.full,
    },
    filterTabText: { ...Typography.buttonSmall },
    list: {
      paddingHorizontal: Spacing.lg,
      paddingTop: Spacing.md,
      paddingBottom: Spacing.xxl + 40,
    },
    loadingState: {
      flex: 1,
      justifyContent: "center",
      alignItems: "center",
      paddingTop: Spacing.xxl,
    },
    giftCard: {
      flexDirection: "row",
      backgroundColor: colors.surface,
      borderRadius: BorderRadius.lg,
      overflow: "hidden",
      marginBottom: Spacing.md,
      borderWidth: 1,
      borderColor: colors.borderLight,
      ...Shadows.sm,
    },
    giftImagePlaceholder: {
      width: 90,
      alignItems: "center",
      justifyContent: "center",
      minHeight: 100,
    },
    giftContent: { flex: 1, padding: Spacing.md },
    giftHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      gap: Spacing.sm,
    },
    giftName: { ...Typography.body, fontWeight: "600", flex: 1 },
    giftDesc: { ...Typography.caption, marginTop: Spacing.xs },
    giftFooter: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginTop: Spacing.sm,
    },
    priceBadge: {
      flexDirection: "row",
      alignItems: "center",
      gap: 3,
      paddingHorizontal: Spacing.sm,
      paddingVertical: 3,
      borderRadius: BorderRadius.full,
    },
    priceText: { ...Typography.caption, fontWeight: "600" },
    linkButton: {
      flexDirection: "row",
      alignItems: "center",
      gap: 3,
      paddingHorizontal: Spacing.sm,
      paddingVertical: 3,
      borderRadius: BorderRadius.full,
    },
    linkText: { ...Typography.caption, fontWeight: "600" },
    deleteBtn: {
      width: 28,
      height: 28,
      borderRadius: 14,
      alignItems: "center",
      justifyContent: "center",
      marginLeft: "auto",
    },
    emptyDesc: { ...Typography.bodySmall, textAlign: "center" },
    fab: {
      position: "absolute",
      right: Spacing.lg,
      bottom: Spacing.lg,
      width: 56,
      height: 56,
      borderRadius: 28,
      justifyContent: "center",
      alignItems: "center",
      ...Shadows.lg,
    },
    modalOverlay: {
      flex: 1,
      backgroundColor: "rgba(0,0,0,0.5)",
      justifyContent: "flex-end",
    },
    modalWrapper: { width: "100%" },
    modalContent: {
      borderTopLeftRadius: BorderRadius.xl,
      borderTopRightRadius: BorderRadius.xl,
      padding: Spacing.lg,
      maxHeight: "80%",
    },
    modalHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      marginBottom: Spacing.lg,
    },
    modalTitle: { ...Typography.h4 },
    inputGroup: { marginBottom: Spacing.md },
    inputLabel: {
      ...Typography.caption,
      fontWeight: "600",
      marginBottom: Spacing.xs,
    },
    input: {
      ...Typography.body,
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1,
    },
    textArea: { minHeight: 80 },
    saveButton: {
      alignItems: "center",
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
      marginTop: Spacing.sm,
      marginBottom: Spacing.lg,
    },
    saveButtonText: { ...Typography.button },
    suggestionsContainer: { flex: 1 },
    suggestionsHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      paddingHorizontal: Spacing.lg,
      paddingVertical: Spacing.md,
      borderBottomWidth: 1,
    },
    suggestionsList: { padding: Spacing.lg, gap: Spacing.md },
    suggestionCard: {
      borderRadius: BorderRadius.lg,
      padding: Spacing.md,
      borderWidth: 1,
      ...Shadows.sm,
    },
    suggestionTopRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginBottom: Spacing.xs,
    },
    whyText: {
      ...Typography.caption,
      fontStyle: "italic",
      marginTop: Spacing.xs,
    },
    addSuggestionBtn: {
      alignItems: "center",
      paddingVertical: Spacing.sm,
      borderRadius: BorderRadius.md,
      marginTop: Spacing.sm,
    },
  });
