import React, { useState, useCallback, useMemo, useEffect } from "react";
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  TextInput,
  Modal,
  ActivityIndicator,
} from "react-native";
import { LoadingScreen } from "../../../src/components/common/LoadingScreen";
import { useLocalSearchParams } from "expo-router";
import { useTranslation } from "react-i18next";
import * as Location from "expo-location";
import { Icon } from "../../../src/components/ui/Icon";
import type { IconName } from "../../../src/constants/icons";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
  type ThemeColors,
} from "../../../src/constants/theme";
import { useTheme } from "../../../src/contexts/ThemeContext";
import { usePlanStore } from "../../../src/stores/planStore";
import { ScreenErrorBoundary } from "../../../src/components/common/ScreenErrorBoundary";

interface WeatherData {
  temperature: number;
  condition: string;
  icon: string;
  humidity: number;
  windSpeed: number;
  uvIndex: number;
  rainProbability: number;
}

interface DailyForecast {
  day: string;
  high: number;
  low: number;
  icon: string;
  condition: string;
}

const WEATHER_ICONS: Record<string, string> = {
  sunny: "weather-sunny",
  cloudy: "weather-cloudy",
  partly_cloudy: "weather-partly-cloudy",
  rainy: "weather-rainy",
  stormy: "weather-lightning-rainy",
  snowy: "weather-snowy",
  windy: "weather-windy",
};

const DAY_KEYS = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"] as const;

async function reverseGeocodeCoords(
  lat: number,
  lon: number,
): Promise<string | null> {
  try {
    const response = await fetch(
      `https://nominatim.openstreetmap.org/reverse?lat=${lat}&lon=${lon}&format=json`,
      { headers: { "User-Agent": "Momentra/1.0" } },
    );
    const data = await response.json();
    const city =
      data.address?.city ||
      data.address?.town ||
      data.address?.village ||
      data.address?.county;
    const countryCode = data.address?.country_code?.toUpperCase();
    if (city && countryCode) return `${city}, ${countryCode}`;
    return null;
  } catch {
    return null;
  }
}

// Open-Meteo free geocoding API — no API key needed
async function geocodeCity(
  cityName: string,
): Promise<{ lat: number; lon: number; displayName: string } | null> {
  try {
    const encoded = encodeURIComponent(cityName.trim());
    const response = await fetch(
      `https://geocoding-api.open-meteo.com/v1/search?name=${encoded}&count=1&language=en&format=json`,
    );
    const data = await response.json();
    if (data.results?.length > 0) {
      const { latitude, longitude, name, country_code } = data.results[0];
      return {
        lat: latitude,
        lon: longitude,
        displayName: `${name}, ${country_code}`,
      };
    }
    return null;
  } catch {
    return null;
  }
}

function getWeatherAdvice(
  data: WeatherData,
  t: (key: string) => string,
): { message: string; type: "good" | "warning" | "danger" } {
  if (data.rainProbability > 60) {
    return {
      message: t("weather.highRain"),
      type: "danger",
    };
  }
  if (data.temperature > 35) {
    return {
      message: t("weather.veryHot"),
      type: "warning",
    };
  }
  if (data.windSpeed > 40) {
    return {
      message: t("weather.strongWind"),
      type: "warning",
    };
  }
  return {
    message: t("weather.goodWeather"),
    type: "good",
  };
}

export default function WeatherScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();
  const { t } = useTranslation();
  const { colors } = useTheme();
  const plans = usePlanStore((s) => s.plans);
  const plan = plans.find((p) => p.id === id) ?? null;

  const [isLoading, setIsLoading] = useState(true);
  const [loadError, setLoadError] = useState(false);
  const [isGeocoding, setIsGeocoding] = useState(false);
  const [isGettingGPS, setIsGettingGPS] = useState(false);
  const [geocodeError, setGeocodeError] = useState(false);
  const [showLocationModal, setShowLocationModal] = useState(false);
  const [locationInput, setLocationInput] = useState("");
  const [currentLocation, setCurrentLocation] = useState(
    plan?.location_text ?? "Istanbul, TR",
  );

  const [weather, setWeather] = useState<WeatherData>({
    temperature: 22,
    condition: t("weather.partlyCloudy"),
    icon: "partly_cloudy",
    humidity: 55,
    windSpeed: 15,
    uvIndex: 6,
    rainProbability: 20,
  });

  const [forecast, setForecast] = useState<DailyForecast[]>([]);

  const fetchWeather = useCallback(
    async (lat = 41.01, lon = 28.97) => {
      setIsLoading(true);
      setLoadError(false);
      try {
        const response = await fetch(
          `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current=temperature_2m,relative_humidity_2m,wind_speed_10m,uv_index,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_probability_max&timezone=auto&forecast_days=7`,
        );
        const data = await response.json();

        if (data.current) {
          const code = data.current.weather_code || 0;
          let condition = "sunny";
          let conditionLabel = t("weather.sunny");
          if (code >= 61) {
            condition = "rainy";
            conditionLabel = t("weather.rainy");
          } else if (code >= 45) {
            condition = "cloudy";
            conditionLabel = t("weather.cloudy");
          } else if (code >= 2) {
            condition = "partly_cloudy";
            conditionLabel = t("weather.partlyCloudy");
          }

          setWeather({
            temperature: Math.round(data.current.temperature_2m || 22),
            condition: conditionLabel,
            icon: condition,
            humidity: Math.round(data.current.relative_humidity_2m || 50),
            windSpeed: Math.round(data.current.wind_speed_10m || 10),
            uvIndex: Math.round(data.current.uv_index || 5),
            rainProbability:
              data.daily?.precipitation_probability_max?.[0] || 20,
          });
        }

        if (data.daily) {
          const days: DailyForecast[] = [];
          for (let i = 0; i < 7 && i < (data.daily.time?.length || 0); i++) {
            const date = new Date(data.daily.time[i]);
            const dayIndex = date.getDay();
            const adjustedIndex = dayIndex === 0 ? 6 : dayIndex - 1;
            const code = data.daily.weather_code?.[i] || 0;
            let icon = "sunny";
            let cond = t("weather.sunny");
            if (code >= 61) {
              icon = "rainy";
              cond = t("weather.rainy");
            } else if (code >= 45) {
              icon = "cloudy";
              cond = t("weather.cloudy");
            } else if (code >= 2) {
              icon = "partly_cloudy";
              cond = t("weather.partlyCloudy");
            }

            days.push({
              day: t(`weather.${DAY_KEYS[adjustedIndex]}`),
              high: Math.round(data.daily.temperature_2m_max?.[i] || 25),
              low: Math.round(data.daily.temperature_2m_min?.[i] || 15),
              icon,
              condition: cond,
            });
          }
          setForecast(days);
        }
      } catch (err) {
        if (__DEV__) console.warn("Failed to fetch weather:", err);
        setLoadError(true);
      } finally {
        setIsLoading(false);
      }
    },
    [t],
  );

  // On mount: use plan's stored coordinates if available, otherwise geocode location_text
  useEffect(() => {
    if (plan?.location_lat && plan?.location_lng) {
      fetchWeather(plan.location_lat, plan.location_lng);
    } else if (plan?.location_text) {
      geocodeCity(plan.location_text).then((result) => {
        if (result) {
          fetchWeather(result.lat, result.lon);
        } else {
          fetchWeather();
        }
      });
    } else {
      fetchWeather();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleGetGPSLocation = useCallback(async () => {
    setIsGettingGPS(true);
    setShowLocationModal(false);
    try {
      const { status } = await Location.requestForegroundPermissionsAsync();
      if (status !== "granted") {
        setIsGettingGPS(false);
        setGeocodeError(true);
        setShowLocationModal(true);
        return;
      }
      const loc = await Location.getCurrentPositionAsync({
        accuracy: Location.Accuracy.Balanced,
      });
      const { latitude, longitude } = loc.coords;
      const cityName = await reverseGeocodeCoords(latitude, longitude);
      setCurrentLocation(
        cityName ?? `${latitude.toFixed(2)}, ${longitude.toFixed(2)}`,
      );
      fetchWeather(latitude, longitude);
    } catch {
      setGeocodeError(true);
      setShowLocationModal(true);
    } finally {
      setIsGettingGPS(false);
    }
  }, [fetchWeather]);

  const handleUpdateLocation = useCallback(async () => {
    if (!locationInput.trim()) return;
    setGeocodeError(false);
    setIsGeocoding(true);
    setShowLocationModal(false);

    const result = await geocodeCity(locationInput.trim());
    setIsGeocoding(false);

    if (result) {
      setCurrentLocation(result.displayName);
      setLocationInput("");
      fetchWeather(result.lat, result.lon);
    } else {
      setGeocodeError(true);
      setShowLocationModal(true);
    }
  }, [locationInput, fetchWeather]);

  const advice = useMemo(() => getWeatherAdvice(weather, t), [weather, t]);

  const styles = useMemo(() => createStyles(colors), [colors]);

  if (isLoading) {
    return <LoadingScreen message={t("weather.loading")} />;
  }

  if (loadError) {
    return (
      <View style={[styles.container, styles.loadingContainer]}>
        <Icon name="cloud-off-outline" size={64} color={colors.textTertiary} />
        <Text
          style={[
            styles.loadingText,
            { color: colors.textSecondary, marginTop: Spacing.md },
          ]}
        >
          {t("weather.loadError")}
        </Text>
        <TouchableOpacity
          style={[
            styles.updateButton,
            { borderColor: colors.primary, marginTop: Spacing.lg },
          ]}
          onPress={() => fetchWeather()}
        >
          <Text style={[styles.updateButtonText, { color: colors.primary }]}>
            {t("weather.tryAgain")}
          </Text>
        </TouchableOpacity>
      </View>
    );
  }

  const adviceColor =
    advice.type === "good"
      ? colors.success
      : advice.type === "warning"
        ? colors.warning
        : colors.error;
  const adviceIcon =
    advice.type === "good"
      ? "check-circle"
      : advice.type === "warning"
        ? "alert"
        : "alert-circle";

  return (
    <ScreenErrorBoundary>
      <ScrollView
        style={styles.container}
        contentContainerStyle={styles.content}
        showsVerticalScrollIndicator={false}
      >
        {/* Header */}
        <View style={styles.header}>
          <Text style={[styles.headerTitle, { color: colors.text }]}>
            {t("weather.title")}
          </Text>
          <TouchableOpacity onPress={() => setShowLocationModal(true)}>
            <View style={styles.locationRow}>
              <Icon name="map-marker" size={16} color={colors.primary} />
              <Text style={[styles.locationText, { color: colors.primary }]}>
                {currentLocation}
              </Text>
            </View>
          </TouchableOpacity>
        </View>

        {/* Main Weather Card */}
        <View style={[styles.mainCard, { backgroundColor: colors.surface }]}>
          <Icon
            name={(WEATHER_ICONS[weather.icon] || "weather-sunny") as IconName}
            size={72}
            color={colors.primary}
          />
          <Text style={[styles.temperature, { color: colors.text }]}>
            {weather.temperature}°C
          </Text>
          <Text style={[styles.condition, { color: colors.textSecondary }]}>
            {weather.condition}
          </Text>
        </View>

        {/* Details Grid */}
        <View style={styles.detailsGrid}>
          {[
            {
              icon: "water-percent",
              label: t("weather.humidity"),
              value: `${weather.humidity}%`,
              color: colors.info,
            },
            {
              icon: "weather-windy",
              label: t("weather.wind"),
              value: `${weather.windSpeed} km/h`,
              color: colors.accent,
            },
            {
              icon: "white-balance-sunny",
              label: "UV",
              value: `${weather.uvIndex}`,
              color: colors.warning,
            },
            {
              icon: "weather-rainy",
              label: t("weather.rain"),
              value: `${weather.rainProbability}%`,
              color: colors.error,
            },
          ].map((detail) => (
            <View
              key={detail.label}
              style={[styles.detailCard, { backgroundColor: colors.surface }]}
            >
              <Icon
                name={detail.icon as IconName}
                size={24}
                color={detail.color}
              />
              <Text style={[styles.detailValue, { color: colors.text }]}>
                {detail.value}
              </Text>
              <Text
                style={[styles.detailLabel, { color: colors.textTertiary }]}
              >
                {detail.label}
              </Text>
            </View>
          ))}
        </View>

        {/* Advice Banner */}
        <View
          style={[
            styles.adviceBanner,
            {
              backgroundColor: adviceColor + "12",
              borderColor: adviceColor + "30",
            },
          ]}
        >
          <Icon name={adviceIcon as IconName} size={22} color={adviceColor} />
          <Text style={[styles.adviceText, { color: adviceColor }]}>
            {advice.message}
          </Text>
        </View>

        {/* 7-Day Forecast */}
        <View style={styles.forecastSection}>
          <Text style={[styles.forecastTitle, { color: colors.text }]}>
            {t("weather.forecast7Day")}
          </Text>
          <ScrollView
            horizontal
            showsHorizontalScrollIndicator={false}
            contentContainerStyle={styles.forecastRow}
          >
            {forecast.map((day, index) => (
              <View
                key={index}
                style={[
                  styles.forecastCard,
                  { backgroundColor: colors.surface },
                ]}
              >
                <Text
                  style={[styles.forecastDay, { color: colors.textSecondary }]}
                >
                  {day.day}
                </Text>
                <Icon
                  name={
                    (WEATHER_ICONS[day.icon] || "weather-sunny") as IconName
                  }
                  size={28}
                  color={colors.primary}
                />
                <Text style={[styles.forecastHigh, { color: colors.text }]}>
                  {day.high}°
                </Text>
                <Text
                  style={[styles.forecastLow, { color: colors.textTertiary }]}
                >
                  {day.low}°
                </Text>
              </View>
            ))}
          </ScrollView>
        </View>

        {/* Update Location Button */}
        <TouchableOpacity
          style={[styles.updateButton, { borderColor: colors.primary }]}
          onPress={() => {
            setGeocodeError(false);
            setShowLocationModal(true);
          }}
          disabled={isGettingGPS}
        >
          {isGettingGPS ? (
            <ActivityIndicator size="small" color={colors.primary} />
          ) : isGeocoding ? (
            <ActivityIndicator size="small" color={colors.primary} />
          ) : (
            <Icon name="crosshairs-gps" size={20} color={colors.primary} />
          )}
          <Text style={[styles.updateButtonText, { color: colors.primary }]}>
            {isGettingGPS
              ? t("weather.gpsLoading")
              : t("weather.updateLocation")}
          </Text>
        </TouchableOpacity>

        {/* Location Modal */}
        <Modal visible={showLocationModal} animationType="slide" transparent>
          <View style={styles.modalOverlay}>
            <View
              style={[styles.modalContent, { backgroundColor: colors.surface }]}
            >
              <View style={styles.modalHeader}>
                <Text style={[styles.modalTitle, { color: colors.text }]}>
                  {t("weather.updateLocation")}
                </Text>
                <TouchableOpacity onPress={() => setShowLocationModal(false)}>
                  <Icon name="close" size={24} color={colors.text} />
                </TouchableOpacity>
              </View>
              <TouchableOpacity
                style={[
                  styles.gpsButton,
                  {
                    backgroundColor: colors.primary + "14",
                    borderColor: colors.primary + "40",
                  },
                ]}
                onPress={() => {
                  setShowLocationModal(false);
                  handleGetGPSLocation();
                }}
              >
                <Icon name="crosshairs-gps" size={20} color={colors.primary} />
                <Text style={[styles.gpsButtonText, { color: colors.primary }]}>
                  {t("weather.useGPS")}
                </Text>
              </TouchableOpacity>
              <View style={styles.dividerRow}>
                <View
                  style={[
                    styles.dividerLine,
                    { backgroundColor: colors.borderLight },
                  ]}
                />
                <Text
                  style={[styles.dividerText, { color: colors.textTertiary }]}
                >
                  {t("weather.or")}
                </Text>
                <View
                  style={[
                    styles.dividerLine,
                    { backgroundColor: colors.borderLight },
                  ]}
                />
              </View>
              <TextInput
                style={[
                  styles.input,
                  {
                    color: colors.text,
                    backgroundColor: colors.backgroundSecondary,
                    borderColor: geocodeError
                      ? colors.error
                      : colors.borderLight,
                  },
                ]}
                value={locationInput}
                onChangeText={(v) => {
                  setLocationInput(v);
                  setGeocodeError(false);
                }}
                placeholder={t("weather.cityPlaceholder")}
                placeholderTextColor={colors.textTertiary}
                autoFocus
              />
              {geocodeError && (
                <Text
                  style={[styles.geocodeErrorText, { color: colors.error }]}
                >
                  {t("weather.cityNotFound")}
                </Text>
              )}
              <TouchableOpacity
                style={[
                  styles.saveButton,
                  {
                    backgroundColor: locationInput.trim()
                      ? colors.primary
                      : colors.borderLight,
                  },
                ]}
                onPress={handleUpdateLocation}
                disabled={!locationInput.trim()}
              >
                <Text
                  style={[
                    styles.saveButtonText,
                    { color: colors.textOnPrimary },
                  ]}
                >
                  {t("weather.update")}
                </Text>
              </TouchableOpacity>
            </View>
          </View>
        </Modal>
      </ScrollView>
    </ScreenErrorBoundary>
  );
}

const createStyles = (colors: ThemeColors) =>
  StyleSheet.create({
    container: { flex: 1, backgroundColor: colors.background },
    content: { paddingBottom: Spacing.xxl },
    loadingContainer: { justifyContent: "center", alignItems: "center" },
    loadingText: { ...Typography.bodySmall, marginTop: Spacing.md },
    header: { padding: Spacing.lg },
    headerTitle: { ...Typography.h3 },
    locationRow: {
      flexDirection: "row",
      alignItems: "center",
      gap: 4,
      marginTop: Spacing.xs,
    },
    locationText: { ...Typography.bodySmall, fontWeight: "500" },
    mainCard: {
      alignItems: "center",
      marginHorizontal: Spacing.lg,
      padding: Spacing.xl,
      borderRadius: BorderRadius.xl,
      ...Shadows.md,
    },
    temperature: { ...Typography.h1, fontSize: 56, marginTop: Spacing.sm },
    condition: { ...Typography.body, marginTop: Spacing.xs },
    detailsGrid: {
      flexDirection: "row",
      flexWrap: "wrap",
      paddingHorizontal: Spacing.lg,
      marginTop: Spacing.lg,
      gap: Spacing.sm,
    },
    detailCard: {
      width: "47%",
      flexGrow: 1,
      alignItems: "center",
      padding: Spacing.md,
      borderRadius: BorderRadius.lg,
      ...Shadows.sm,
    },
    detailValue: { ...Typography.h4, marginTop: Spacing.xs },
    detailLabel: { ...Typography.caption, marginTop: 2 },
    adviceBanner: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
      marginHorizontal: Spacing.lg,
      marginTop: Spacing.lg,
      padding: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1,
    },
    adviceText: { ...Typography.bodySmall, fontWeight: "500", flex: 1 },
    forecastSection: { marginTop: Spacing.xl, paddingHorizontal: Spacing.lg },
    forecastTitle: { ...Typography.h4, marginBottom: Spacing.md },
    forecastRow: { gap: Spacing.sm },
    forecastCard: {
      alignItems: "center",
      padding: Spacing.md,
      borderRadius: BorderRadius.lg,
      width: 80,
      ...Shadows.sm,
    },
    forecastDay: {
      ...Typography.caption,
      fontWeight: "600",
      marginBottom: Spacing.xs,
    },
    forecastHigh: {
      ...Typography.bodySmall,
      fontWeight: "700",
      marginTop: Spacing.xs,
    },
    forecastLow: { ...Typography.caption },
    updateButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      marginHorizontal: Spacing.lg,
      marginTop: Spacing.xl,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1.5,
    },
    updateButtonText: { ...Typography.button },
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
    geocodeErrorText: {
      ...Typography.caption,
      marginBottom: Spacing.sm,
      marginTop: -Spacing.xs,
    },
    gpsButton: {
      flexDirection: "row",
      alignItems: "center",
      justifyContent: "center",
      gap: Spacing.sm,
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
      borderWidth: 1,
      marginBottom: Spacing.md,
    },
    gpsButtonText: { ...Typography.button },
    dividerRow: {
      flexDirection: "row",
      alignItems: "center",
      marginBottom: Spacing.md,
      gap: Spacing.sm,
    },
    dividerLine: {
      flex: 1,
      height: 1,
    },
    dividerText: {
      ...Typography.caption,
    },
    saveButton: {
      alignItems: "center",
      paddingVertical: Spacing.md,
      borderRadius: BorderRadius.md,
    },
    saveButtonText: { ...Typography.button },
  });
