import React, { useState, useRef, useCallback } from "react";
import { useTranslation } from "react-i18next";
import { PaywallModal } from "../src/components/subscription/PaywallModal";
import {
  View,
  Text,
  StyleSheet,
  Dimensions,
  FlatList,
  TouchableOpacity,
  ViewToken,
  ScrollView,
  StatusBar,
  Platform,
  Alert,
} from "react-native";
import { useRouter } from "expo-router";
import { LinearGradient } from "expo-linear-gradient";
import { SafeAreaView } from "react-native-safe-area-context";
import Animated, {
  FadeIn,
  FadeInDown,
  FadeInUp,
  FadeInRight,
  useSharedValue,
  useAnimatedStyle,
  withTiming,
  withSpring,
} from "react-native-reanimated";
import {
  getColors,
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  Gradients,
} from "../src/constants/theme";
import { useSettingsStore } from "../src/stores/settingsStore";
import { requestNotificationPermission } from "../src/utils/notifications";
import { ScreenErrorBoundary } from "../src/components/common/ScreenErrorBoundary";

const { width: SCREEN_WIDTH } = Dimensions.get("window");
const TOTAL_PAGES = 4;

// ── All 15 categories with emojis and translations ───────────────────

interface OnboardingCategory {
  slug: string;
  emoji: string;
  name_tr: string;
  name_en: string;
}

const ALL_CATEGORIES: OnboardingCategory[] = [
  {
    slug: "proposal",
    emoji: "💍",
    name_tr: "Evlilik Teklifi",
    name_en: "Proposal",
  },
  { slug: "birthday", emoji: "🎂", name_tr: "Doğum Günü", name_en: "Birthday" },
  {
    slug: "anniversary",
    emoji: "❤️",
    name_tr: "Yıldönümü",
    name_en: "Anniversary",
  },
  {
    slug: "graduation",
    emoji: "🎓",
    name_tr: "Mezuniyet",
    name_en: "Graduation",
  },
  { slug: "baby", emoji: "👶", name_tr: "Bebek", name_en: "Baby Shower" },
  { slug: "romantic", emoji: "🌹", name_tr: "Romantik", name_en: "Romantic" },
  {
    slug: "friendship",
    emoji: "👫",
    name_tr: "Arkadaşlık",
    name_en: "Friendship",
  },
  { slug: "apology", emoji: "🤝", name_tr: "Özür", name_en: "Apology" },
  {
    slug: "achievement",
    emoji: "🏆",
    name_tr: "Başarı",
    name_en: "Achievement",
  },
  { slug: "holiday", emoji: "🎄", name_tr: "Tatil", name_en: "Holiday" },
  { slug: "wedding", emoji: "💒", name_tr: "Düğün", name_en: "Wedding" },
  {
    slug: "housewarming",
    emoji: "🏠",
    name_tr: "Ev Hediyesi",
    name_en: "Housewarming",
  },
  {
    slug: "retirement",
    emoji: "🎊",
    name_tr: "Emeklilik",
    name_en: "Retirement",
  },
  { slug: "thankyou", emoji: "🙏", name_tr: "Teşekkür", name_en: "Thank You" },
  {
    slug: "getwell",
    emoji: "💐",
    name_tr: "Geçmiş Olsun",
    name_en: "Get Well",
  },
];

const MIN_CATEGORIES = 3;

// ── Translations ─────────────────────────────────────────────────────

const t = {
  tr: {
    skip: "Atla",
    next: "İleri",
    back: "Geri",
    getStarted: "Başla",
    // Welcome slide
    welcomeTitle: "Momentra'ya Hoşgeldin!",
    welcomeSubtitle: "Sevdiklerin için unutulmaz sürprizler planla",
    welcomeDesc:
      "Yapay zeka destekli öneriler, adım adım planlar ve hatırlatmalarla mükemmel sürprizler hazırla.",
    welcomeButton: "Hadi Başlayalım",
    welcomeFeature1: "30+ hazır sürpriz senaryosu",
    welcomeFeature2: "AI destekli kişisel öneriler",
    welcomeFeature3: "Geri sayım ve hatırlatmalar",
    // Category slide
    categoryTitle: "İlgi Alanlarını Seç",
    categoryDesc: "En az 3 kategori seç, sana özel sürpriz önerileri sunalım!",
    categorySelected: "kategori seçildi",
    categoryMinWarning: "En az 3 kategori seçmelisin",
    // Notification slide
    notifTitle: "Bildirimleri Aç",
    notifDesc:
      "Sürpriz planlarının ve geri sayımların hakkında zamanında bildirim al. Hiçbir özel anı kaçırma!",
    notifFeature1: "Plan hatırlatmaları",
    notifFeature2: "Geri sayım bildirimleri",
    notifFeature3: "Özel gün uyarıları",
    notifAllow: "Bildirimlere İzin Ver",
    notifSkip: "Daha Sonra",
    // Complete slide
    completeTitle: "Hazırız!",
    completeDesc:
      "Tercihlerini kaydettik. Şimdi ilk sürprizini planlamaya başlayabilirsin!",
    completeCategories: "Seçilen kategoriler:",
    completeNotif: "Bildirimler:",
    completeNotifOn: "Açık",
    completeNotifOff: "Kapalı",
    completeButton: "Keşfe Başla",
  },
  en: {
    skip: "Skip",
    next: "Next",
    back: "Back",
    getStarted: "Get Started",
    // Welcome slide
    welcomeTitle: "Welcome to Momentra!",
    welcomeSubtitle: "Plan unforgettable surprises for your loved ones",
    welcomeDesc:
      "Create perfect surprises with AI-powered recommendations, step-by-step plans, and timely reminders.",
    welcomeButton: "Let's Get Started",
    welcomeFeature1: "30+ ready surprise scenarios",
    welcomeFeature2: "AI-powered personal suggestions",
    welcomeFeature3: "Countdowns & reminders",
    // Category slide
    categoryTitle: "Pick Your Interests",
    categoryDesc:
      "Select at least 3 categories to get personalized surprise suggestions!",
    categorySelected: "categories selected",
    categoryMinWarning: "Please select at least 3 categories",
    // Notification slide
    notifTitle: "Stay in the Loop",
    notifDesc:
      "Get timely reminders about your surprise plans and countdowns. Never miss a special moment!",
    notifFeature1: "Plan reminders",
    notifFeature2: "Countdown alerts",
    notifFeature3: "Special date warnings",
    notifAllow: "Allow Notifications",
    notifSkip: "Maybe Later",
    // Complete slide
    completeTitle: "You're All Set!",
    completeDesc:
      "We've saved your preferences. You can now start planning your first surprise!",
    completeCategories: "Selected categories:",
    completeNotif: "Notifications:",
    completeNotifOn: "Enabled",
    completeNotifOff: "Disabled",
    completeButton: "Start Exploring",
  },
};

// ── Icon Circle Component ────────────────────────────────────────

function IconCircle({ emoji }: { emoji: string }) {
  return (
    <View style={iconCircleStyles.container}>
      <Text style={iconCircleStyles.emoji}>{emoji}</Text>
    </View>
  );
}

const iconCircleStyles = StyleSheet.create({
  container: {
    width: 100,
    height: 100,
    borderRadius: 50,
    backgroundColor: "rgba(255,255,255,0.2)",
    alignItems: "center",
    justifyContent: "center",
    marginBottom: Spacing.lg,
  },
  emoji: {
    fontSize: 48,
  },
});

// ── Feature Row Component ───────────────────────────────────────────

function FeatureRow({
  features,
  delay = 600,
}: {
  features: string[];
  delay?: number;
}) {
  return (
    <View style={featureStyles.container}>
      {features.map((feature, i) => (
        <Animated.View
          key={i}
          entering={FadeInRight.delay(delay + i * 150).duration(400)}
          style={featureStyles.row}
        >
          <View style={featureStyles.bullet}>
            <Text style={featureStyles.checkmark}>✓</Text>
          </View>
          <Text style={featureStyles.text}>{feature}</Text>
        </Animated.View>
      ))}
    </View>
  );
}

const featureStyles = StyleSheet.create({
  container: {
    marginTop: Spacing.lg,
    alignSelf: "stretch",
    paddingHorizontal: Spacing.xl,
  },
  row: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: Spacing.sm,
  },
  bullet: {
    width: 24,
    height: 24,
    borderRadius: 12,
    backgroundColor: "rgba(255,255,255,0.2)",
    alignItems: "center",
    justifyContent: "center",
    marginRight: Spacing.sm,
  },
  checkmark: {
    color: "#FFFFFF",
    fontSize: 14,
    fontWeight: "700",
  },
  text: {
    ...Typography.bodySmall,
    color: "rgba(255,255,255,0.9)",
    flex: 1,
  },
});

// ── Progress Bar Component (spring-animated) ──────────────────────────

function ProgressBar({ current, total }: { current: number; total: number }) {
  const animatedWidth = useSharedValue(((current + 1) / total) * 100);

  React.useEffect(() => {
    animatedWidth.value = withSpring(((current + 1) / total) * 100, {
      damping: 20,
      stiffness: 120,
    });
  }, [current, total]);

  const fillStyle = useAnimatedStyle(() => ({
    width: `${animatedWidth.value}%`,
  }));

  return (
    <View
      style={[
        progressStyles.track,
        { backgroundColor: "rgba(255,255,255,0.15)" },
      ]}
    >
      <Animated.View
        style={[progressStyles.fill, { backgroundColor: "#FFFFFF" }, fillStyle]}
      />
    </View>
  );
}

const progressStyles = StyleSheet.create({
  track: {
    height: 4,
    borderRadius: 2,
    marginHorizontal: Spacing.lg,
    marginTop: Spacing.sm,
    overflow: "hidden",
  },
  fill: {
    height: "100%",
    borderRadius: 2,
  },
});

// ── Animated Dot Indicator ─────────────────────────────────────────

function AnimatedDot({
  active,
  activeColor,
  inactiveColor,
}: {
  active: boolean;
  activeColor: string;
  inactiveColor: string;
}) {
  const width = useSharedValue(active ? 28 : 8);
  const bgOpacity = useSharedValue(active ? 1 : 0.4);

  React.useEffect(() => {
    width.value = withSpring(active ? 28 : 8, { damping: 15, stiffness: 150 });
    bgOpacity.value = withTiming(active ? 1 : 0.4, { duration: 200 });
  }, [active]);

  const dotStyle = useAnimatedStyle(() => ({
    width: width.value,
    opacity: bgOpacity.value,
    backgroundColor: active ? activeColor : inactiveColor,
  }));

  return <Animated.View style={[{ height: 8, borderRadius: 4 }, dotStyle]} />;
}

// ── Main Onboarding Screen ──────────────────────────────────────────

export default function OnboardingScreen() {
  const router = useRouter();
  const { t: tl } = useTranslation();
  const {
    language,
    isDarkMode,
    setHasSeenOnboarding,
    setFavoriteCategories,
    setNotificationsEnabled,
  } = useSettingsStore();
  const lang = (language || "tr") as "tr" | "en";
  const colors = getColors(isDarkMode);
  const strings = t[lang];

  const [currentIndex, setCurrentIndex] = useState(0);
  const [selectedCategories, setSelectedCategories] = useState<string[]>([]);
  const [notificationsGranted, setNotificationsGranted] = useState(false);
  const [notificationAsked, setNotificationAsked] = useState(false);
  const [showPaywall, setShowPaywall] = useState(false);
  const flatListRef = useRef<FlatList>(null);

  const onViewableItemsChanged = useRef(
    ({ viewableItems }: { viewableItems: ViewToken[] }) => {
      if (viewableItems.length > 0 && viewableItems[0].index != null) {
        setCurrentIndex(viewableItems[0].index);
      }
    },
  ).current;

  const viewabilityConfig = useRef({
    viewAreaCoveragePercentThreshold: 50,
  }).current;

  const goToPage = useCallback((index: number) => {
    flatListRef.current?.scrollToIndex({ index, animated: true });
  }, []);

  const handleNext = useCallback(() => {
    if (currentIndex === 1 && selectedCategories.length < MIN_CATEGORIES) {
      Alert.alert(tl("common.notice"), strings.categoryMinWarning);
      return;
    }
    if (currentIndex < TOTAL_PAGES - 1) {
      goToPage(currentIndex + 1);
    }
  }, [
    currentIndex,
    selectedCategories.length,
    lang,
    strings.categoryMinWarning,
    goToPage,
  ]);

  const handleBack = useCallback(() => {
    if (currentIndex > 0) {
      goToPage(currentIndex - 1);
    }
  }, [currentIndex, goToPage]);

  const handleSkip = useCallback(() => {
    setHasSeenOnboarding(true);
    router.replace("/(tabs)");
  }, [setHasSeenOnboarding, router]);

  const doNavigateToTabs = useCallback(() => {
    router.replace("/(tabs)");
  }, [router]);

  const handleComplete = useCallback(() => {
    if (selectedCategories.length > 0) {
      setFavoriteCategories(selectedCategories);
    }
    setHasSeenOnboarding(true);
    setShowPaywall(true);
  }, [selectedCategories, setFavoriteCategories, setHasSeenOnboarding]);

  const toggleCategory = useCallback((slug: string) => {
    setSelectedCategories((prev) =>
      prev.includes(slug) ? prev.filter((s) => s !== slug) : [...prev, slug],
    );
  }, []);

  const handleAllowNotifications = useCallback(async () => {
    try {
      const granted = await requestNotificationPermission();
      setNotificationsGranted(granted);
      setNotificationsEnabled(granted);
      setNotificationAsked(true);
      // Auto-advance after a brief moment
      setTimeout(() => goToPage(3), 400);
    } catch {
      setNotificationAsked(true);
      goToPage(3);
    }
  }, [setNotificationsEnabled, goToPage]);

  const handleSkipNotifications = useCallback(() => {
    setNotificationAsked(true);
    setNotificationsGranted(false);
    goToPage(3);
  }, [goToPage]);

  // ── Slide 1: Welcome ────────────────────────────────────────────

  const renderWelcomeSlide = () => (
    <View style={[styles.pageContainer, { backgroundColor: "transparent" }]}>
      <LinearGradient colors={[...Gradients.joy]} style={styles.slide}>
        <SafeAreaView style={styles.slideInner} edges={["top"]}>
          <Animated.View
            entering={FadeIn.duration(600)}
            style={styles.slideContent}
          >
            <IconCircle emoji="🎉" />

            <Animated.Text
              entering={FadeInDown.delay(200).duration(500)}
              style={styles.slideTitle}
            >
              {strings.welcomeTitle}
            </Animated.Text>

            <Animated.Text
              entering={FadeInDown.delay(350).duration(500)}
              style={styles.slideSubtitle}
            >
              {strings.welcomeSubtitle}
            </Animated.Text>

            <Animated.Text
              entering={FadeInDown.delay(450).duration(500)}
              style={styles.slideDesc}
            >
              {strings.welcomeDesc}
            </Animated.Text>

            <FeatureRow
              features={[
                strings.welcomeFeature1,
                strings.welcomeFeature2,
                strings.welcomeFeature3,
              ]}
              delay={600}
            />
          </Animated.View>
        </SafeAreaView>
      </LinearGradient>
    </View>
  );

  // ── Slide 2: Category Preferences ───────────────────────────────

  const renderCategorySlide = () => (
    <View style={[styles.pageContainer, { backgroundColor: "transparent" }]}>
      <LinearGradient colors={[...Gradients.joy]} style={styles.slide}>
        <SafeAreaView style={styles.slideInner} edges={["top"]}>
          <ScrollView
            contentContainerStyle={styles.categoryScrollContent}
            showsVerticalScrollIndicator={false}
          >
            <Animated.View
              entering={FadeIn.duration(500)}
              style={styles.slideContent}
            >
              <IconCircle emoji="🎯" />

              <Animated.Text
                entering={FadeInDown.delay(200).duration(500)}
                style={styles.slideTitle}
              >
                {strings.categoryTitle}
              </Animated.Text>

              <Animated.Text
                entering={FadeInDown.delay(350).duration(500)}
                style={styles.slideDesc}
              >
                {strings.categoryDesc}
              </Animated.Text>

              {/* Selection counter */}
              <Animated.View
                entering={FadeIn.delay(400).duration(300)}
                style={[
                  styles.selectionBadge,
                  selectedCategories.length >= MIN_CATEGORIES &&
                    styles.selectionBadgeReady,
                ]}
              >
                <Text style={styles.selectionBadgeText}>
                  {selectedCategories.length} / {MIN_CATEGORIES}+{" "}
                  {strings.categorySelected}
                  {selectedCategories.length >= MIN_CATEGORIES ? " ✓" : ""}
                </Text>
              </Animated.View>

              {/* Category Grid */}
              <Animated.View
                entering={FadeInUp.delay(500).duration(500)}
                style={styles.categoryGrid}
              >
                {ALL_CATEGORIES.map((cat) => {
                  const isSelected = selectedCategories.includes(cat.slug);
                  return (
                    <View key={cat.slug}>
                      <TouchableOpacity
                        onPress={() => toggleCategory(cat.slug)}
                        activeOpacity={0.7}
                        style={[
                          styles.categoryChip,
                          isSelected && styles.categoryChipSelected,
                        ]}
                      >
                        <Text style={styles.categoryEmoji}>{cat.emoji}</Text>
                        <Text
                          style={[
                            styles.categoryLabel,
                            isSelected && styles.categoryLabelSelected,
                          ]}
                          numberOfLines={1}
                        >
                          {lang === "tr" ? cat.name_tr : cat.name_en}
                        </Text>
                        {isSelected && (
                          <View style={styles.categoryCheckBadge}>
                            <Text
                              style={[
                                styles.categoryCheckText,
                                { color: colors.primary },
                              ]}
                            >
                              ✓
                            </Text>
                          </View>
                        )}
                      </TouchableOpacity>
                    </View>
                  );
                })}
              </Animated.View>
            </Animated.View>
          </ScrollView>
        </SafeAreaView>
      </LinearGradient>
    </View>
  );

  // ── Slide 3: Notification Permission ────────────────────────────

  const renderNotificationSlide = () => (
    <View style={[styles.pageContainer, { backgroundColor: "transparent" }]}>
      <LinearGradient colors={[...Gradients.joy]} style={styles.slide}>
        <SafeAreaView style={styles.slideInner} edges={["top"]}>
          <Animated.View
            entering={FadeIn.duration(600)}
            style={styles.slideContent}
          >
            <IconCircle emoji="🔔" />

            <Animated.Text
              entering={FadeInDown.delay(200).duration(500)}
              style={styles.slideTitle}
            >
              {strings.notifTitle}
            </Animated.Text>

            <Animated.Text
              entering={FadeInDown.delay(350).duration(500)}
              style={styles.slideDesc}
            >
              {strings.notifDesc}
            </Animated.Text>

            <FeatureRow
              features={[
                strings.notifFeature1,
                strings.notifFeature2,
                strings.notifFeature3,
              ]}
              delay={500}
            />

            {/* Notification buttons */}
            <Animated.View
              entering={FadeInUp.delay(800).duration(500)}
              style={styles.notifButtonsContainer}
            >
              {notificationAsked ? (
                <View style={styles.notifResultContainer}>
                  <Text style={styles.notifResultEmoji}>
                    {notificationsGranted ? "✅" : "⏰"}
                  </Text>
                  <Text style={styles.notifResultText}>
                    {notificationsGranted
                      ? lang === "tr"
                        ? "Bildirimler açıldı!"
                        : "Notifications enabled!"
                      : lang === "tr"
                        ? "Daha sonra ayarlardan açabilirsin"
                        : "You can enable them later in settings"}
                  </Text>
                </View>
              ) : (
                <>
                  <TouchableOpacity
                    onPress={handleAllowNotifications}
                    activeOpacity={0.8}
                    style={styles.notifAllowButton}
                  >
                    <Text
                      style={[styles.notifAllowText, { color: colors.primary }]}
                    >
                      🔔 {strings.notifAllow}
                    </Text>
                  </TouchableOpacity>

                  <TouchableOpacity
                    onPress={handleSkipNotifications}
                    activeOpacity={0.7}
                    style={styles.notifSkipButton}
                  >
                    <Text style={styles.notifSkipText}>
                      {strings.notifSkip}
                    </Text>
                  </TouchableOpacity>
                </>
              )}
            </Animated.View>
          </Animated.View>
        </SafeAreaView>
      </LinearGradient>
    </View>
  );

  // ── Slide 4: Complete ───────────────────────────────────────────

  const renderCompleteSlide = () => {
    const selectedNames = ALL_CATEGORIES.filter((c) =>
      selectedCategories.includes(c.slug),
    );

    return (
      <View style={[styles.pageContainer, { backgroundColor: "transparent" }]}>
        <LinearGradient colors={[...Gradients.joy]} style={styles.slide}>
          <SafeAreaView style={styles.slideInner} edges={["top"]}>
            <Animated.View
              entering={FadeIn.duration(600)}
              style={styles.slideContent}
            >
              <IconCircle emoji="🚀" />

              <Animated.Text
                entering={FadeInDown.delay(200).duration(500)}
                style={styles.slideTitle}
              >
                {strings.completeTitle}
              </Animated.Text>

              <Animated.Text
                entering={FadeInDown.delay(350).duration(500)}
                style={styles.slideDesc}
              >
                {strings.completeDesc}
              </Animated.Text>

              {/* Summary card */}
              <Animated.View
                entering={FadeInUp.delay(500).duration(500)}
                style={styles.summaryCard}
              >
                {/* Selected categories */}
                <Text style={styles.summaryLabel}>
                  {strings.completeCategories}
                </Text>
                <View style={styles.summaryChips}>
                  {selectedNames.map((cat) => (
                    <View key={cat.slug} style={styles.summaryChip}>
                      <Text style={styles.summaryChipText}>
                        {cat.emoji} {lang === "tr" ? cat.name_tr : cat.name_en}
                      </Text>
                    </View>
                  ))}
                </View>

                {/* Notification status */}
                <View style={styles.summaryDivider} />
                <View style={styles.summaryRow}>
                  <Text style={styles.summaryLabel}>
                    {strings.completeNotif}
                  </Text>
                  <View
                    style={[
                      styles.summaryStatusBadge,
                      notificationsGranted
                        ? styles.summaryStatusOn
                        : styles.summaryStatusOff,
                    ]}
                  >
                    <Text style={styles.summaryStatusText}>
                      {notificationsGranted
                        ? `✓ ${strings.completeNotifOn}`
                        : strings.completeNotifOff}
                    </Text>
                  </View>
                </View>
              </Animated.View>

              {/* Start button */}
              <Animated.View
                entering={FadeInUp.delay(700).duration(500)}
                style={styles.completeButtonContainer}
              >
                <TouchableOpacity
                  onPress={handleComplete}
                  activeOpacity={0.8}
                  style={styles.completeButton}
                >
                  <Text style={styles.completeButtonText}>
                    {strings.completeButton}
                  </Text>
                </TouchableOpacity>
              </Animated.View>
            </Animated.View>
          </SafeAreaView>
        </LinearGradient>
      </View>
    );
  };

  // ── FlatList rendering ────────────────────────────────────────────

  const pages = [
    { id: "welcome" },
    { id: "categories" },
    { id: "notifications" },
    { id: "complete" },
  ];

  const renderItem = ({
    item,
    index,
  }: {
    item: { id: string };
    index: number;
  }) => {
    switch (item.id) {
      case "welcome":
        return renderWelcomeSlide();
      case "categories":
        return renderCategorySlide();
      case "notifications":
        return renderNotificationSlide();
      case "complete":
        return renderCompleteSlide();
      default:
        return null;
    }
  };

  const isFirstPage = currentIndex === 0;
  const isLastPage = currentIndex === TOTAL_PAGES - 1;
  const canProceedFromCategories =
    currentIndex !== 1 || selectedCategories.length >= MIN_CATEGORIES;

  return (
    <ScreenErrorBoundary>
      <View style={[styles.container, { backgroundColor: colors.background }]}>
        <StatusBar barStyle="light-content" />

        {/* Progress bar */}
        <View
          style={[styles.progressContainer, { backgroundColor: "transparent" }]}
        >
          <SafeAreaView edges={["top"]}>
            <ProgressBar current={currentIndex} total={TOTAL_PAGES} />
          </SafeAreaView>
        </View>

        {/* Skip Button - top right */}
        {!isLastPage && (
          <TouchableOpacity onPress={handleSkip} style={styles.skipButtonTop}>
            <Text style={styles.skipButtonTopText}>{strings.skip}</Text>
          </TouchableOpacity>
        )}

        <FlatList
          ref={flatListRef}
          data={pages}
          renderItem={renderItem}
          keyExtractor={(item) => item.id}
          horizontal
          pagingEnabled
          showsHorizontalScrollIndicator={false}
          onViewableItemsChanged={onViewableItemsChanged}
          viewabilityConfig={viewabilityConfig}
          scrollEventThrottle={16}
          scrollEnabled={canProceedFromCategories || currentIndex < 1}
        />

        {/* Bottom Section */}
        <View
          style={[styles.bottomSection, { backgroundColor: colors.primary }]}
        >
          {/* Dot Indicators — animated width */}
          <View style={styles.dots}>
            {Array.from({ length: TOTAL_PAGES }).map((_, i) => (
              <AnimatedDot
                key={i}
                active={i === currentIndex}
                activeColor="#FFFFFF"
                inactiveColor="rgba(255,255,255,0.35)"
              />
            ))}
          </View>

          {/* Navigation Buttons */}
          <View style={styles.buttons}>
            {/* Back button (hidden on first page) */}
            {!isFirstPage ? (
              <TouchableOpacity onPress={handleBack} style={styles.backButton}>
                <Text style={styles.backText}>{strings.back}</Text>
              </TouchableOpacity>
            ) : (
              <View style={styles.backButton} />
            )}

            {/* Next / Complete */}
            {isLastPage ? (
              <TouchableOpacity
                onPress={handleComplete}
                style={styles.nextButton}
                activeOpacity={0.8}
              >
                <View style={styles.nextButtonInner}>
                  <Text style={styles.nextText}>{strings.completeButton}</Text>
                </View>
              </TouchableOpacity>
            ) : (
              <TouchableOpacity
                onPress={handleNext}
                style={[
                  styles.nextButton,
                  currentIndex === 1 &&
                    !canProceedFromCategories &&
                    styles.nextButtonDisabled,
                ]}
                activeOpacity={0.8}
                disabled={false}
              >
                <View style={styles.nextButtonInner}>
                  <Text style={styles.nextText}>
                    {currentIndex === 0 ? strings.welcomeButton : strings.next}
                  </Text>
                </View>
              </TouchableOpacity>
            )}
          </View>
        </View>

        <PaywallModal
          visible={showPaywall}
          onClose={doNavigateToTabs}
          onPurchaseSuccess={doNavigateToTabs}
        />
      </View>
    </ScreenErrorBoundary>
  );
}

// ── Styles ───────────────────────────────────────────────────────────

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  progressContainer: {
    position: "absolute",
    top: 0,
    left: 0,
    right: 0,
    zIndex: 5,
  },
  pageContainer: {
    width: SCREEN_WIDTH,
    flex: 1,
  },
  slide: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  slideInner: {
    flex: 1,
    width: "100%",
  },
  slideContent: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
    paddingHorizontal: Spacing.lg,
    paddingTop: Spacing.xl,
    paddingBottom: Spacing.lg,
  },
  slideTitle: {
    fontSize: 34,
    fontWeight: "700" as const,
    color: "#FFFFFF",
    textAlign: "center",
    marginBottom: Spacing.sm,
  },
  slideSubtitle: {
    ...Typography.body,
    color: "rgba(255,255,255,0.85)",
    textAlign: "center",
    marginBottom: Spacing.md,
  },
  slideDesc: {
    ...Typography.body,
    color: "rgba(255,255,255,0.85)",
    textAlign: "center",
    lineHeight: 26,
    paddingHorizontal: Spacing.md,
    marginBottom: Spacing.sm,
  },

  // Skip button (top right)
  skipButtonTop: {
    position: "absolute",
    top: Platform.OS === "ios" ? 56 : 40,
    right: Spacing.lg,
    zIndex: 10,
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.md,
    backgroundColor: "rgba(255,255,255,0.2)",
    borderRadius: BorderRadius.full,
  },
  skipButtonTopText: {
    ...Typography.buttonSmall,
    color: "#FFFFFF",
  },

  // Selection badge
  selectionBadge: {
    paddingVertical: Spacing.xs + 2,
    paddingHorizontal: Spacing.md,
    borderRadius: BorderRadius.full,
    backgroundColor: "rgba(255,255,255,0.2)",
    marginTop: Spacing.sm,
    marginBottom: Spacing.sm,
  },
  selectionBadgeReady: {
    backgroundColor: "rgba(76, 175, 80, 0.6)",
  },
  selectionBadgeText: {
    ...Typography.buttonSmall,
    color: "#FFFFFF",
  },

  // Category grid
  categoryScrollContent: {
    paddingBottom: Spacing.xxl + Spacing.xl,
  },
  categoryGrid: {
    flexDirection: "row",
    flexWrap: "wrap",
    justifyContent: "center",
    gap: Spacing.sm,
    marginTop: Spacing.md,
    paddingHorizontal: Spacing.xs,
  },
  categoryChip: {
    flexDirection: "row",
    alignItems: "center",
    paddingVertical: Spacing.sm + 2,
    paddingHorizontal: Spacing.md,
    borderRadius: BorderRadius.full,
    backgroundColor: "rgba(255,255,255,0.15)",
    borderWidth: 1,
    borderColor: "rgba(255,255,255,0.25)",
    minWidth: 100,
  },
  categoryChipSelected: {
    backgroundColor: "rgba(255,255,255,0.35)",
    borderColor: "#FFFFFF",
  },
  categoryEmoji: {
    fontSize: 20,
    marginRight: Spacing.xs + 2,
  },
  categoryLabel: {
    ...Typography.buttonSmall,
    color: "rgba(255,255,255,0.85)",
  },
  categoryLabelSelected: {
    color: "#FFFFFF",
    fontWeight: "700",
  },
  categoryCheckBadge: {
    width: 20,
    height: 20,
    borderRadius: 10,
    backgroundColor: "#FFFFFF",
    alignItems: "center",
    justifyContent: "center",
    marginLeft: Spacing.xs,
  },
  categoryCheckText: {
    fontSize: 12,
    fontWeight: "700",
  },

  // Notification slide
  notifButtonsContainer: {
    marginTop: Spacing.xl,
    alignSelf: "stretch",
    paddingHorizontal: Spacing.lg,
    gap: Spacing.md,
  },
  notifAllowButton: {
    backgroundColor: "#FFFFFF",
    paddingVertical: Spacing.md + 2,
    borderRadius: BorderRadius.full,
    alignItems: "center",
    ...Shadows.md,
  },
  notifAllowText: {
    ...Typography.button,
    fontSize: 17,
  },
  notifSkipButton: {
    paddingVertical: Spacing.md,
    alignItems: "center",
  },
  notifSkipText: {
    ...Typography.button,
    color: "rgba(255,255,255,0.7)",
  },
  notifResultContainer: {
    alignItems: "center",
    paddingVertical: Spacing.md,
  },
  notifResultEmoji: {
    fontSize: 40,
    marginBottom: Spacing.sm,
  },
  notifResultText: {
    ...Typography.body,
    color: "rgba(255,255,255,0.9)",
    textAlign: "center",
  },

  // Complete slide - summary card
  summaryCard: {
    marginTop: Spacing.lg,
    backgroundColor: "rgba(255,255,255,0.12)",
    borderRadius: BorderRadius.lg,
    padding: Spacing.lg,
    alignSelf: "stretch",
    marginHorizontal: Spacing.sm,
    borderWidth: 1,
    borderColor: "rgba(255,255,255,0.25)",
  },
  summaryLabel: {
    ...Typography.buttonSmall,
    color: "rgba(255,255,255,0.7)",
    marginBottom: Spacing.sm,
  },
  summaryChips: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.xs + 2,
  },
  summaryChip: {
    backgroundColor: "rgba(255,255,255,0.2)",
    paddingVertical: Spacing.xs,
    paddingHorizontal: Spacing.sm + 2,
    borderRadius: BorderRadius.full,
  },
  summaryChipText: {
    ...Typography.caption,
    color: "#FFFFFF",
    fontWeight: "600",
  },
  summaryDivider: {
    height: 1,
    backgroundColor: "rgba(255,255,255,0.2)",
    marginVertical: Spacing.md,
  },
  summaryRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  summaryStatusBadge: {
    paddingVertical: Spacing.xs,
    paddingHorizontal: Spacing.sm + 2,
    borderRadius: BorderRadius.full,
  },
  summaryStatusOn: {
    backgroundColor: "rgba(76,175,80,0.5)",
  },
  summaryStatusOff: {
    backgroundColor: "rgba(255,255,255,0.2)",
  },
  summaryStatusText: {
    ...Typography.caption,
    color: "#FFFFFF",
    fontWeight: "600",
  },
  completeButtonContainer: {
    marginTop: Spacing.xl,
    alignSelf: "stretch",
    paddingHorizontal: Spacing.md,
  },
  completeButton: {
    backgroundColor: "#FFFFFF",
    paddingVertical: Spacing.md + 4,
    borderRadius: BorderRadius.full,
    alignItems: "center",
    ...Shadows.lg,
  },
  completeButtonText: {
    ...Typography.button,
    color: "#FF2D55",
    fontSize: 18,
  },

  // Bottom section
  bottomSection: {
    paddingVertical: Spacing.md,
    paddingHorizontal: Spacing.lg,
    paddingBottom: Spacing.xl + Spacing.md,
  },
  dots: {
    flexDirection: "row",
    justifyContent: "center",
    gap: Spacing.sm,
    marginBottom: Spacing.md,
  },
  dot: {
    height: 8,
    borderRadius: 4,
  },
  dotActive: {
    width: 28,
  },
  dotInactive: {
    width: 8,
  },

  // Buttons
  buttons: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  backButton: {
    paddingVertical: Spacing.md,
    paddingHorizontal: Spacing.md,
    minWidth: 70,
  },
  backText: {
    ...Typography.button,
    color: "rgba(255,255,255,0.6)",
  },
  nextButton: {
    borderRadius: BorderRadius.full,
    overflow: "hidden",
  },
  nextButtonInner: {
    paddingVertical: Spacing.md,
    paddingHorizontal: Spacing.xl,
    borderRadius: BorderRadius.full,
    backgroundColor: "#FFFFFF",
  },
  nextText: {
    ...Typography.button,
    color: "#FF2D55",
  },
  nextButtonDisabled: {
    opacity: 0.7,
  },
});
