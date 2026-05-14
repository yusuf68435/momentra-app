import React, { useState, useMemo, useEffect } from "react";
import { ScreenErrorBoundary } from "../../src/components/common/ScreenErrorBoundary";
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  Dimensions,
  TouchableOpacity,
  Platform,
  Image,
} from "react-native";
import { LoadingScreen } from "../../src/components/common/LoadingScreen";
import { useLocalSearchParams, useRouter } from "expo-router";
import { useTranslation } from "react-i18next";
import { Icon, type IconName } from "../../src/components/ui/Icon";
import { LinearGradient } from "expo-linear-gradient";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import Animated, { FadeInDown, FadeInUp } from "react-native-reanimated";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../src/constants/theme";
import { useTheme } from "../../src/contexts/ThemeContext";
import { Button } from "../../src/components/ui/Button";
import { Badge } from "../../src/components/ui/Badge";
import { StarRating } from "../../src/components/reviews/StarRating";
import { WriteReviewModal } from "../../src/components/reviews/WriteReviewModal";
import { ShareButton } from "../../src/components/common/ShareButton";
import { shareScenario, getScenarioLink } from "../../src/utils/sharing";
import { createReview } from "../../src/services/reviews";
import { CATEGORIES } from "../../src/constants/categories";
import { useScenarioStore } from "../../src/stores/scenarioStore";
import {
  hapticLight,
  hapticMedium,
  hapticSuccess,
} from "../../src/utils/haptics";
import {
  a11yButton,
  a11yHeader,
  a11yProgressBar,
} from "../../src/utils/accessibility";
import { useSettingsStore } from "../../src/stores/settingsStore";
import { isPlanAtLeast } from "../../src/services/subscription";

const { width: SCREEN_WIDTH } = Dimensions.get("window");

function parseDescriptionToSteps(text: string): string[] {
  const sentences: string[] = [];
  let current = "";
  for (let i = 0; i < text.length; i++) {
    current += text[i];
    if (
      text[i] === "." &&
      i + 1 < text.length &&
      text[i + 1] === " " &&
      i + 2 < text.length &&
      text[i + 2] !== " " &&
      text[i + 2] === text[i + 2].toUpperCase()
    ) {
      sentences.push(current.trim());
      current = "";
      i++;
    }
  }
  if (current.trim().length > 0) sentences.push(current.trim());

  const filtered = sentences.filter((s) => s.length > 25);
  if (filtered.length <= 1) return text.trim().length > 0 ? [text] : [];

  const steps: string[] = [];
  for (let i = 0; i < filtered.length; i += 2) {
    steps.push([filtered[i], filtered[i + 1]].filter(Boolean).join(" "));
  }
  return steps.slice(0, 6);
}

export default function ScenarioDetailScreen() {
  const { id } = useLocalSearchParams();
  const router = useRouter();
  const { t, i18n } = useTranslation();
  const lang = i18n.language as "tr" | "en";
  const { colors } = useTheme();
  const insets = useSafeAreaInsets();

  const {
    currentScenario: scenario,
    isLoading,
    loadScenarioById,
  } = useScenarioStore();
  const { subscriptionPlan } = useSettingsStore();
  const [showWriteReview, setShowWriteReview] = useState(false);
  const [reviewSubmitting, setReviewSubmitting] = useState(false);

  useEffect(() => {
    if (id) {
      loadScenarioById(id as string);
    }
  }, [id]);

  const styles = useMemo(() => createStyles(colors), [colors]);

  if (isLoading) {
    return <LoadingScreen />;
  }

  if (!scenario) {
    return (
      <View style={styles_static.container}>
        <Text
          style={{ textAlign: "center", marginTop: 100, color: colors.text }}
        >
          {t("scenario.not_found")}
        </Text>
      </View>
    );
  }

  const title = lang === "tr" ? scenario.title_tr : scenario.title_en;
  const description =
    lang === "tr" ? scenario.description_tr : scenario.description_en;
  const catSlug = scenario.category?.slug;
  const catDef = CATEGORIES.find((c) => c.slug === catSlug);
  const catColor = catDef?.color || colors.primary;
  const catName = catDef
    ? lang === "tr"
      ? scenario.category?.name_tr
      : scenario.category?.name_en
    : "";
  const steps = scenario.steps || [];

  const isLocked =
    scenario.is_premium && !isPlanAtLeast(subscriptionPlan, "plus");

  const difficultyLabel =
    scenario.difficulty <= 1
      ? t("scenario.difficulty_easy")
      : scenario.difficulty <= 2
        ? t("scenario.difficulty_medium")
        : t("scenario.difficulty_hard");

  const handleShareScenario = () => {
    hapticLight();
    shareScenario(scenario, lang);
  };

  const handleSubmitReview = async (data: {
    rating: number;
    comment: string;
    photos: string[];
  }) => {
    try {
      setReviewSubmitting(true);
      await createReview({
        scenario_id: scenario.id,
        rating: data.rating,
        comment: data.comment || undefined,
        photos: data.photos.length > 0 ? data.photos : undefined,
      });
      hapticSuccess();
      setShowWriteReview(false);
    } catch (_err) {
      // Error handled in modal
    } finally {
      setReviewSubmitting(false);
    }
  };

  return (
    <ScreenErrorBoundary>
      <View
        style={[
          styles_static.container,
          { backgroundColor: colors.background },
        ]}
      >
        <ScrollView showsVerticalScrollIndicator={false}>
          {/* Cover Image with Gradient */}
          <Animated.View entering={FadeInUp.duration(500)}>
            <View
              style={[styles_static.coverImage, { paddingTop: insets.top }]}
            >
              {scenario.cover_image_url ? (
                <Image
                  source={{ uri: scenario.cover_image_url }}
                  style={StyleSheet.absoluteFillObject}
                  resizeMode="cover"
                />
              ) : null}
              <LinearGradient
                colors={
                  scenario.cover_image_url
                    ? ["rgba(0,0,0,0.05)", "rgba(0,0,0,0.3)", colors.background]
                    : [catColor + "30", catColor + "10", colors.background]
                }
                style={StyleSheet.absoluteFillObject}
              />
              {!scenario.cover_image_url && (
                <Icon
                  name={(catDef?.icon || "gift") as IconName}
                  size={80}
                  color={catColor}
                />
              )}
              {scenario.is_premium && (
                <View
                  style={[
                    styles_static.premiumBadge,
                    { backgroundColor: colors.accent, top: insets.top + 10 },
                  ]}
                >
                  <Icon name="crown" size={14} color={colors.textOnPrimary} />
                  <Text
                    style={[
                      styles_static.premiumText,
                      { color: colors.textOnPrimary },
                    ]}
                    maxFontSizeMultiplier={1.0}
                  >
                    PREMIUM
                  </Text>
                </View>
              )}
              {/* Share button in header */}
              <View
                style={[
                  styles_static.headerShareButton,
                  { top: insets.top + 10 },
                ]}
              >
                <ShareButton
                  onShare={handleShareScenario}
                  getLink={() => getScenarioLink(scenario.id)}
                  lang={lang}
                  size="md"
                />
              </View>
            </View>
          </Animated.View>

          <View style={styles_static.content}>
            {/* Category Badge */}
            <Animated.View entering={FadeInDown.duration(400).delay(100)}>
              <View
                style={[
                  styles_static.categoryBadge,
                  { backgroundColor: catColor + "15" },
                ]}
              >
                <Icon
                  name={(catDef?.icon || "tag") as IconName}
                  size={14}
                  color={catColor}
                />
                <Text
                  style={[styles_static.categoryText, { color: catColor }]}
                  maxFontSizeMultiplier={1.2}
                >
                  {catName}
                </Text>
              </View>
            </Animated.View>

            {/* Title & Tags */}
            <Animated.View entering={FadeInDown.duration(400).delay(200)}>
              <Text
                style={[styles.title, { color: colors.text }]}
                maxFontSizeMultiplier={1.4}
                {...a11yHeader(title)}
              >
                {title}
              </Text>
              <View style={styles_static.tagRow}>
                {scenario.tags.map((tag) => (
                  <Badge
                    key={tag}
                    text={tag}
                    backgroundColor={colors.surfaceVariant}
                    color={colors.textSecondary}
                  />
                ))}
              </View>
            </Animated.View>

            {/* Quick Stats */}
            <Animated.View entering={FadeInDown.duration(400).delay(300)}>
              <View
                style={[
                  styles.statsRow,
                  {
                    backgroundColor: colors.surface,
                    borderColor: colors.borderLight,
                  },
                ]}
              >
                <View style={styles_static.statItem}>
                  <View
                    style={[
                      styles_static.statIcon,
                      { backgroundColor: colors.success + "15" },
                    ]}
                  >
                    <Icon name="cash" size={20} color={colors.success} />
                  </View>
                  <Text
                    style={[styles_static.statValue, { color: colors.text }]}
                    maxFontSizeMultiplier={1.2}
                  >
                    ₺{scenario.min_budget?.toLocaleString()} - ₺
                    {scenario.max_budget?.toLocaleString()}
                  </Text>
                  <Text
                    style={[
                      styles_static.statLabel,
                      { color: colors.textTertiary },
                    ]}
                    maxFontSizeMultiplier={1.1}
                  >
                    {t("common.budget")}
                  </Text>
                </View>
                <View style={styles_static.statItem}>
                  <View
                    style={[
                      styles_static.statIcon,
                      { backgroundColor: colors.info + "15" },
                    ]}
                  >
                    <Icon name="calendar-clock" size={20} color={colors.info} />
                  </View>
                  <Text
                    style={[styles_static.statValue, { color: colors.text }]}
                    maxFontSizeMultiplier={1.2}
                  >
                    {scenario.prep_days} {t("common.days")}
                  </Text>
                  <Text
                    style={[
                      styles_static.statLabel,
                      { color: colors.textTertiary },
                    ]}
                    maxFontSizeMultiplier={1.1}
                  >
                    {t("scenario.prep")}
                  </Text>
                </View>
                <View style={styles_static.statItem}>
                  <View
                    style={[
                      styles_static.statIcon,
                      { backgroundColor: colors.accent + "15" },
                    ]}
                  >
                    <Icon
                      name="account-group"
                      size={20}
                      color={colors.accent}
                    />
                  </View>
                  <Text
                    style={[styles_static.statValue, { color: colors.text }]}
                    maxFontSizeMultiplier={1.2}
                  >
                    {scenario.min_people}-{scenario.max_people}
                  </Text>
                  <Text
                    style={[
                      styles_static.statLabel,
                      { color: colors.textTertiary },
                    ]}
                    maxFontSizeMultiplier={1.1}
                  >
                    {t("common.people")}
                  </Text>
                </View>
                <View style={styles_static.statItem}>
                  <View
                    style={[
                      styles_static.statIcon,
                      { backgroundColor: colors.secondary + "15" },
                    ]}
                  >
                    <Icon
                      name="signal-cellular-2"
                      size={20}
                      color={colors.secondary}
                    />
                  </View>
                  <Text
                    style={[styles_static.statValue, { color: colors.text }]}
                    maxFontSizeMultiplier={1.2}
                  >
                    {difficultyLabel}
                  </Text>
                  <Text
                    style={[
                      styles_static.statLabel,
                      { color: colors.textTertiary },
                    ]}
                    maxFontSizeMultiplier={1.1}
                  >
                    {t("scenario.difficulty")}
                  </Text>
                </View>
              </View>
            </Animated.View>

            {/* Rating */}
            <Animated.View entering={FadeInDown.duration(400).delay(350)}>
              <View style={styles_static.ratingRow}>
                <View style={styles_static.ratingStars}>
                  {[1, 2, 3, 4, 5].map((n) => (
                    <Icon
                      key={n}
                      name={
                        (n <= Math.round(scenario.rating_avg)
                          ? "star"
                          : "star-outline") as IconName
                      }
                      size={20}
                      color={colors.warning}
                    />
                  ))}
                </View>
                <Text
                  style={[styles_static.ratingValue, { color: colors.warning }]}
                  maxFontSizeMultiplier={1.2}
                >
                  {(scenario.rating_avg ?? 0).toFixed(1)}
                </Text>
                <Text
                  style={[
                    styles_static.ratingCount,
                    { color: colors.textTertiary },
                  ]}
                  maxFontSizeMultiplier={1.2}
                >
                  ({scenario.rating_count ?? 0} {t("scenario.reviews")})
                </Text>
              </View>
            </Animated.View>

            {/* Description or Parsed Steps */}
            <Animated.View entering={FadeInDown.duration(400).delay(400)}>
              {steps.length === 0 && description ? (
                <View>
                  <Text
                    style={[styles.stepsTitle, { color: colors.text }]}
                    maxFontSizeMultiplier={1.3}
                  >
                    {t("scenario.how_to_do")}
                  </Text>
                  {parseDescriptionToSteps(description).map((step, i) => (
                    <View
                      key={i}
                      style={[
                        styles_static.stepCard,
                        {
                          backgroundColor: colors.surface,
                          borderColor: colors.borderLight,
                          marginBottom: Spacing.sm,
                          ...Shadows.sm,
                        },
                      ]}
                    >
                      <LinearGradient
                        colors={[catColor, catColor + "CC"]}
                        style={styles_static.stepNumber}
                      >
                        <Text
                          style={[
                            styles_static.stepNumberText,
                            { color: colors.textOnPrimary },
                          ]}
                          maxFontSizeMultiplier={1.0}
                        >
                          {i + 1}
                        </Text>
                      </LinearGradient>
                      <Text
                        style={[
                          styles_static.stepTitle,
                          { color: colors.text, flex: 1 },
                        ]}
                        maxFontSizeMultiplier={1.3}
                      >
                        {step}
                      </Text>
                    </View>
                  ))}
                </View>
              ) : (
                <Text
                  style={[styles.description, { color: colors.textSecondary }]}
                  maxFontSizeMultiplier={1.4}
                >
                  {description}
                </Text>
              )}
            </Animated.View>

            {/* Premium Lock Overlay */}
            {isLocked && (
              <Animated.View entering={FadeInDown.duration(400).delay(420)}>
                <LinearGradient
                  colors={[colors.accent + "18", colors.accent + "08"]}
                  style={styles.lockOverlay}
                >
                  <View style={styles.lockIconCircle}>
                    <Icon name="lock" size={32} color={colors.accent} />
                  </View>
                  <Text
                    style={[styles.lockTitle, { color: colors.text }]}
                    maxFontSizeMultiplier={1.3}
                  >
                    {t("scenario.premium_scenario")}
                  </Text>
                  <Text
                    style={[styles.lockDesc, { color: colors.textSecondary }]}
                    maxFontSizeMultiplier={1.3}
                  >
                    {t("scenario.premium_desc")}
                  </Text>
                  <TouchableOpacity
                    style={[
                      styles.lockUpgradeButton,
                      { backgroundColor: colors.accent },
                    ]}
                    onPress={() => {
                      hapticMedium();
                      router.push("/settings/subscription");
                    }}
                    activeOpacity={0.8}
                    {...a11yButton(t("scenario.upgrade_premium"))}
                  >
                    <Icon name="crown" size={18} color={colors.textOnPrimary} />
                    <Text
                      style={styles.lockUpgradeText}
                      maxFontSizeMultiplier={1.2}
                    >
                      {t("scenario.upgrade_premium")}
                    </Text>
                  </TouchableOpacity>
                </LinearGradient>
              </Animated.View>
            )}

            {/* Review Summary Section */}
            <Animated.View entering={FadeInDown.duration(400).delay(450)}>
              <View
                style={[
                  styles.reviewSummaryCard,
                  {
                    backgroundColor: colors.surface,
                    borderColor: colors.borderLight,
                  },
                ]}
              >
                <View style={styles_static.reviewSummaryHeader}>
                  <Text
                    style={[
                      styles_static.reviewSummaryTitle,
                      { color: colors.text },
                    ]}
                    maxFontSizeMultiplier={1.3}
                  >
                    {t("scenario.reviews_title")}
                  </Text>
                  <TouchableOpacity
                    onPress={() => {
                      hapticLight();
                      router.push({
                        pathname: "/scenario/[id]/reviews",
                        params: { id: id as string },
                      });
                    }}
                    activeOpacity={0.7}
                    {...a11yButton(t("scenario.see_all_reviews"))}
                  >
                    <Text
                      style={[
                        styles_static.seeAllLink,
                        { color: colors.primary },
                      ]}
                      maxFontSizeMultiplier={1.2}
                    >
                      {t("common.see_all")} ({scenario.rating_count})
                    </Text>
                  </TouchableOpacity>
                </View>

                <View style={styles_static.reviewSummaryBody}>
                  <Text
                    style={[
                      styles_static.reviewAvgBig,
                      { color: colors.secondary },
                    ]}
                  >
                    {(scenario.rating_avg ?? 0).toFixed(1)}
                  </Text>
                  <View style={styles_static.reviewSummaryRight}>
                    <StarRating
                      rating={scenario.rating_avg ?? 0}
                      size="md"
                      showHalfStars
                    />
                    <Text
                      style={[
                        styles_static.reviewCountText,
                        { color: colors.textTertiary },
                      ]}
                      maxFontSizeMultiplier={1.2}
                    >
                      {scenario.rating_count} {t("scenario.reviews")}
                    </Text>
                  </View>
                </View>

                <TouchableOpacity
                  style={[
                    styles_static.writeReviewButton,
                    {
                      borderColor: colors.primary + "40",
                      backgroundColor: colors.primary + "08",
                    },
                  ]}
                  onPress={() => {
                    hapticLight();
                    setShowWriteReview(true);
                  }}
                  activeOpacity={0.7}
                  {...a11yButton(t("scenario.write_review"))}
                >
                  <Icon
                    name="pencil-outline"
                    size={16}
                    color={colors.primary}
                  />
                  <Text
                    style={[
                      styles_static.writeReviewText,
                      { color: colors.primary },
                    ]}
                    maxFontSizeMultiplier={1.2}
                  >
                    {t("scenario.write_review")}
                  </Text>
                </TouchableOpacity>
              </View>
            </Animated.View>

            {/* Steps */}
            {steps.length > 0 && (
              <Animated.View entering={FadeInDown.duration(400).delay(500)}>
                <Text
                  style={[styles.stepsTitle, { color: colors.text }]}
                  maxFontSizeMultiplier={1.3}
                  {...a11yHeader(t("scenario.steps"), 2)}
                >
                  {t("scenario.steps")}
                </Text>
                {steps.map((step, index) => {
                  const proTip =
                    lang === "tr" ? step.pro_tip_tr : step.pro_tip_en;
                  const stepTitle =
                    lang === "tr" ? step.title_tr : step.title_en;
                  const stepDesc =
                    lang === "tr" ? step.description_tr : step.description_en;
                  return (
                    <Animated.View
                      key={step.id || index}
                      entering={FadeInDown.duration(300).delay(
                        550 + index * 50,
                      )}
                      style={{ marginBottom: Spacing.sm }}
                    >
                      <View
                        style={[
                          styles_static.stepCard,
                          {
                            backgroundColor: colors.surface,
                            borderColor: colors.borderLight,
                            ...Shadows.sm,
                          },
                        ]}
                      >
                        {/* Card Header Row */}
                        <View style={styles_static.stepCardHeader}>
                          <LinearGradient
                            colors={[catColor, catColor + "CC"]}
                            style={styles_static.stepNumber}
                          >
                            <Text
                              style={[
                                styles_static.stepNumberText,
                                { color: colors.textOnPrimary },
                              ]}
                              maxFontSizeMultiplier={1.0}
                            >
                              {step.step_number}
                            </Text>
                          </LinearGradient>
                          <Text
                            style={[
                              styles_static.stepTitle,
                              { color: colors.text, flex: 1 },
                            ]}
                            maxFontSizeMultiplier={1.3}
                          >
                            {stepTitle}
                          </Text>
                          {step.days_before != null && step.days_before > 0 && (
                            <View
                              style={[
                                styles_static.daysBadge,
                                { backgroundColor: colors.info + "15" },
                              ]}
                            >
                              <Text
                                style={[
                                  styles_static.daysBadgeText,
                                  { color: colors.info },
                                ]}
                                maxFontSizeMultiplier={1.0}
                              >
                                {step.days_before} {t("scenario.days_before")}
                              </Text>
                            </View>
                          )}
                        </View>

                        {/* Step Content - always visible */}
                        {(stepDesc || proTip) && (
                          <View
                            style={[
                              styles_static.stepExpandedContent,
                              { borderTopColor: colors.borderLight },
                            ]}
                          >
                            {stepDesc ? (
                              <Text
                                style={[
                                  styles_static.stepDesc,
                                  { color: colors.textSecondary },
                                ]}
                                maxFontSizeMultiplier={1.3}
                              >
                                {stepDesc}
                              </Text>
                            ) : null}

                            {/* Pro Tip Callout */}
                            {proTip ? (
                              <View
                                style={[
                                  styles_static.proTipBox,
                                  {
                                    backgroundColor: colors.warning + "15",
                                    borderColor: colors.warning + "30",
                                  },
                                ]}
                              >
                                <View style={styles_static.proTipHeader}>
                                  <Icon
                                    name="lightbulb-on"
                                    size={16}
                                    color={colors.warning}
                                  />
                                  <Text
                                    style={[
                                      styles_static.proTipLabel,
                                      { color: colors.warning },
                                    ]}
                                    maxFontSizeMultiplier={1.1}
                                  >
                                    {t("scenario.pro_tip")}
                                  </Text>
                                </View>
                                <Text
                                  style={[
                                    styles_static.proTipText,
                                    { color: colors.text },
                                  ]}
                                  maxFontSizeMultiplier={1.3}
                                >
                                  {proTip}
                                </Text>
                              </View>
                            ) : null}

                            {/* Estimated cost in expanded */}
                            {step.estimated_cost != null &&
                              step.estimated_cost > 0 && (
                                <View style={styles_static.stepMetaItem}>
                                  <Icon
                                    name="cash"
                                    size={12}
                                    color={colors.textTertiary}
                                  />
                                  <Text
                                    style={[
                                      styles_static.stepDays,
                                      { color: colors.textTertiary },
                                    ]}
                                    maxFontSizeMultiplier={1.1}
                                  >
                                    ~₺{step.estimated_cost.toLocaleString()}
                                  </Text>
                                </View>
                              )}
                          </View>
                        )}
                      </View>
                    </Animated.View>
                  );
                })}
              </Animated.View>
            )}
          </View>
        </ScrollView>

        {/* Bottom CTA */}
        <Animated.View
          entering={FadeInUp.duration(400).delay(300)}
          style={[
            styles.bottomBar,
            { paddingBottom: insets.bottom + Spacing.md },
          ]}
        >
          <Button
            title={
              isLocked
                ? t("scenario.premium_required")
                : t("scenario.plan_this")
            }
            onPress={() => {
              if (isLocked) {
                hapticLight();
                router.push("/settings/subscription");
              } else {
                hapticMedium();
                router.push({
                  pathname: "/plan/create",
                  params: { scenarioId: id as string },
                });
              }
            }}
            fullWidth
            size="lg"
            disabled={isLocked}
            icon={
              <Icon
                name={(isLocked ? "lock" : "clipboard-plus") as IconName}
                size={22}
                color={isLocked ? colors.textTertiary : colors.textOnPrimary}
              />
            }
          />
        </Animated.View>

        {/* Write Review Modal */}
        <WriteReviewModal
          visible={showWriteReview}
          onClose={() => setShowWriteReview(false)}
          onSubmit={handleSubmitReview}
          lang={lang}
          loading={reviewSubmitting}
        />
      </View>
    </ScreenErrorBoundary>
  );
}

// Static styles that never change
const styles_static = StyleSheet.create({
  container: { flex: 1 },
  coverImage: { height: 260, alignItems: "center", justifyContent: "center" },
  coverEmoji: { fontSize: 80 },
  premiumBadge: {
    position: "absolute",
    right: Spacing.lg,
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.full,
  },
  premiumText: { ...Typography.caption, fontWeight: "700" },
  content: { padding: Spacing.lg, marginTop: -Spacing.lg },
  categoryBadge: {
    flexDirection: "row",
    alignItems: "center",
    alignSelf: "flex-start",
    gap: 4,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.full,
    marginBottom: Spacing.sm,
  },
  categoryText: { ...Typography.caption, fontWeight: "600" },
  tagRow: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.sm,
    marginBottom: Spacing.lg,
  },
  statItem: { alignItems: "center", gap: 4, flex: 1 },
  statIcon: {
    width: 36,
    height: 36,
    borderRadius: 18,
    alignItems: "center",
    justifyContent: "center",
  },
  statValue: { ...Typography.caption, fontWeight: "700", textAlign: "center" },
  statLabel: { ...Typography.caption, fontSize: 10 },
  ratingRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    marginBottom: Spacing.lg,
  },
  ratingStars: { flexDirection: "row" },
  ratingValue: { ...Typography.body, fontWeight: "700" },
  ratingCount: { ...Typography.caption },
  stepCard: {
    borderWidth: 1,
    borderRadius: BorderRadius.md,
    padding: Spacing.md,
  },
  stepCardHeader: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  stepNumber: {
    width: 32,
    height: 32,
    borderRadius: 16,
    alignItems: "center",
    justifyContent: "center",
  },
  stepNumberText: {
    ...Typography.bodySmall,
    fontWeight: "700",
  },
  stepTitle: { ...Typography.body, fontWeight: "500" },
  stepExpandedContent: {
    marginTop: Spacing.md,
    paddingTop: Spacing.md,
    borderTopWidth: StyleSheet.hairlineWidth,
  },
  stepDesc: {
    ...Typography.bodySmall,
    lineHeight: 22,
    marginBottom: Spacing.sm,
  },
  stepMetaItem: {
    flexDirection: "row",
    alignItems: "center",
    gap: 3,
    marginTop: Spacing.xs,
  },
  stepDays: { ...Typography.caption, fontSize: 11 },
  daysBadge: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 3,
    borderRadius: BorderRadius.full,
  },
  daysBadgeText: { ...Typography.caption, fontSize: 10, fontWeight: "600" },
  proTipBox: {
    borderWidth: 1,
    borderRadius: BorderRadius.sm,
    padding: Spacing.sm,
    marginBottom: Spacing.xs,
  },
  proTipHeader: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    marginBottom: 4,
  },
  proTipLabel: { ...Typography.caption, fontWeight: "700" },
  proTipText: { ...Typography.caption, lineHeight: 20 },
  headerShareButton: { position: "absolute", left: Spacing.lg },
  reviewSummaryHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.sm,
  },
  reviewSummaryTitle: { ...Typography.h4 },
  seeAllLink: { ...Typography.bodySmall, fontWeight: "600" },
  reviewSummaryBody: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
    marginBottom: Spacing.md,
  },
  reviewAvgBig: { ...Typography.h1, fontSize: 36, lineHeight: 42 },
  reviewSummaryRight: { gap: Spacing.xs },
  reviewCountText: { ...Typography.caption },
  writeReviewButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.xs,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
  },
  writeReviewText: { ...Typography.buttonSmall },
});

// Dynamic styles that depend on theme colors
const createStyles = (
  colors: ReturnType<typeof import("../../src/constants/theme").getColors>,
) =>
  StyleSheet.create({
    title: { ...Typography.h1, marginBottom: Spacing.sm },
    statsRow: {
      flexDirection: "row",
      justifyContent: "space-between",
      borderRadius: BorderRadius.lg,
      padding: Spacing.md,
      marginBottom: Spacing.md,
      borderWidth: 1,
    },
    description: {
      ...Typography.body,
      lineHeight: 26,
      marginBottom: Spacing.lg,
    },
    lockOverlay: {
      borderRadius: BorderRadius.lg,
      padding: Spacing.xl,
      marginBottom: Spacing.lg,
      alignItems: "center",
    },
    lockIconCircle: {
      width: 64,
      height: 64,
      borderRadius: 32,
      backgroundColor: colors.accent + "20",
      alignItems: "center",
      justifyContent: "center",
      marginBottom: Spacing.md,
    },
    lockTitle: { ...Typography.h3, marginBottom: Spacing.xs },
    lockDesc: {
      ...Typography.body,
      textAlign: "center",
      marginBottom: Spacing.md,
    },
    lockUpgradeButton: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.xs,
      paddingHorizontal: Spacing.xl,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.full,
    },
    lockUpgradeText: { ...Typography.button, color: colors.textOnPrimary },
    stepsTitle: { ...Typography.h3, marginBottom: Spacing.md },
    bottomBar: {
      padding: Spacing.lg,
      borderTopWidth: 1,
      borderTopColor: colors.borderLight,
      backgroundColor: colors.surface,
      ...Shadows.sm,
    },
    reviewSummaryCard: {
      borderRadius: BorderRadius.lg,
      padding: Spacing.md,
      marginBottom: Spacing.lg,
      borderWidth: 1,
      ...Shadows.sm,
    },
  });
