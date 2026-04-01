import React, { useEffect, useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ActivityIndicator,
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { Icon } from '../ui/Icon';
import type { IconName } from '../../constants/icons';
import { useTranslation } from 'react-i18next';
import { type ThemeColors, Spacing, Typography, BorderRadius, Shadows } from '../../constants/theme';
import { useTheme } from '../../contexts/ThemeContext';

interface WeatherWidgetProps {
  latitude: number;
  longitude: number;
  eventDate: string;
}

interface WeatherData {
  temperatureMax: number;
  temperatureMin: number;
  precipitationProbability: number;
  weatherCode: number;
}

type AdviceLevel = 'green' | 'yellow' | 'red';

interface WeatherInfo {
  icon: IconName;
  condition: string;
  gradient: [string, string];
  adviceLevel: AdviceLevel;
  adviceText: string;
}

function getWeatherInfo(code: number, t: (key: string) => string): WeatherInfo {
  if (code <= 1) {
    return {
      icon: 'weather-sunny',
      condition: t('weather.clear'),
      gradient: ['#4FC3F7', '#0288D1'],
      adviceLevel: 'green',
      adviceText: t('weather.perfectOutdoor'),
    };
  }
  if (code <= 3) {
    return {
      icon: 'weather-partly-cloudy',
      condition: t('weather.partlyCloudy'),
      gradient: ['#90A4AE', '#546E7A'],
      adviceLevel: 'green',
      adviceText: t('weather.perfectOutdoor'),
    };
  }
  if (code <= 48) {
    return {
      icon: 'weather-fog',
      condition: t('weather.foggy'),
      gradient: ['#B0BEC5', '#78909C'],
      adviceLevel: 'yellow',
      adviceText: t('weather.considerBackup'),
    };
  }
  if (code <= 57) {
    return {
      icon: 'weather-rainy',
      condition: t('weather.drizzle'),
      gradient: ['#78909C', '#455A64'],
      adviceLevel: 'yellow',
      adviceText: t('weather.considerBackup'),
    };
  }
  if (code <= 67) {
    return {
      icon: 'weather-pouring',
      condition: t('weather.rain'),
      gradient: ['#546E7A', '#263238'],
      adviceLevel: 'red',
      adviceText: t('weather.indoorRecommended'),
    };
  }
  if (code <= 77) {
    return {
      icon: 'weather-snowy',
      condition: t('weather.snow'),
      gradient: ['#CFD8DC', '#90A4AE'],
      adviceLevel: 'red',
      adviceText: t('weather.indoorRecommended'),
    };
  }
  if (code <= 82) {
    return {
      icon: 'weather-pouring',
      condition: t('weather.heavyRain'),
      gradient: ['#455A64', '#1B2631'],
      adviceLevel: 'red',
      adviceText: t('weather.indoorRecommended'),
    };
  }
  if (code <= 86) {
    return {
      icon: 'weather-snowy-heavy',
      condition: t('weather.heavySnow'),
      gradient: ['#B0BEC5', '#607D8B'],
      adviceLevel: 'red',
      adviceText: t('weather.indoorRecommended'),
    };
  }
  return {
    icon: 'weather-lightning-rainy',
    condition: t('weather.thunderstorm'),
    gradient: ['#37474F', '#1B2631'],
    adviceLevel: 'red',
    adviceText: t('weather.indoorRecommended'),
  };
}

const adviceBannerColors: Record<AdviceLevel, { bg: string; text: string; icon: IconName }> = {
  green: { bg: '#E8F5E9', text: '#2E7D32', icon: 'check-circle' },
  yellow: { bg: '#FFF8E1', text: '#F57F17', icon: 'alert-circle' },
  red: { bg: '#FFEBEE', text: '#C62828', icon: 'close-circle' },
};

export function WeatherWidget({ latitude, longitude, eventDate }: WeatherWidgetProps) {
  const { colors } = useTheme();
  const { t } = useTranslation();
  const styles = createStyles(colors);
  const [weather, setWeather] = useState<WeatherData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetchWeather();
  }, [latitude, longitude, eventDate]);

  const fetchWeather = async () => {
    try {
      setLoading(true);
      setError(null);
      const url = `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max,weathercode&timezone=auto`;
      const response = await fetch(url);
      const data = await response.json();

      const dateIndex = data.daily.time.indexOf(eventDate);
      if (dateIndex === -1) {
        setError(t('weather.dateNotAvailable'));
        return;
      }

      setWeather({
        temperatureMax: data.daily.temperature_2m_max[dateIndex],
        temperatureMin: data.daily.temperature_2m_min[dateIndex],
        precipitationProbability: data.daily.precipitation_probability_max[dateIndex],
        weatherCode: data.daily.weathercode[dateIndex],
      });
    } catch {
      setError(t('weather.fetchError'));
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <View style={[styles.container, styles.centered]}>
        <ActivityIndicator size="large" color={colors.primary} />
        <Text style={styles.loadingText}>{t('weather.loading')}</Text>
      </View>
    );
  }

  if (error || !weather) {
    return (
      <View style={[styles.container, styles.centered]}>
        <Icon name="weather-cloudy-alert" size={48} color={colors.textSecondary} />
        <Text style={styles.errorText}>{error || t('weather.noData')}</Text>
      </View>
    );
  }

  const info = getWeatherInfo(weather.weatherCode, t);
  const advice = adviceBannerColors[info.adviceLevel];

  return (
    <View style={[styles.container, Shadows.lg]}>
      <LinearGradient
        colors={info.gradient}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 1 }}
        style={styles.gradient}
      >
        <View style={styles.header}>
          <Text style={styles.headerTitle}>{t('weather.eventDayWeather')}</Text>
          <Text style={styles.headerDate}>{eventDate}</Text>
        </View>

        <View style={styles.mainRow}>
          <View style={styles.tempSection}>
            <Text style={styles.tempLarge}>{Math.round(weather.temperatureMax)}°</Text>
            <Text style={styles.tempSmall}>
              {t('weather.low')} {Math.round(weather.temperatureMin)}°
            </Text>
          </View>
          <View style={styles.iconSection}>
            <Icon name={info.icon} size={72} color="#FFFFFF" />
            <Text style={styles.conditionText}>{info.condition}</Text>
          </View>
        </View>

        <View style={styles.detailsRow}>
          <View style={styles.detailItem}>
            <Icon name="water-percent" size={20} color="rgba(255,255,255,0.85)" />
            <Text style={styles.detailValue}>{weather.precipitationProbability}%</Text>
            <Text style={styles.detailLabel}>{t('weather.rainChance')}</Text>
          </View>
          <View style={styles.detailDivider} />
          <View style={styles.detailItem}>
            <Icon name="thermometer" size={20} color="rgba(255,255,255,0.85)" />
            <Text style={styles.detailValue}>
              {Math.round(weather.temperatureMin)}° - {Math.round(weather.temperatureMax)}°
            </Text>
            <Text style={styles.detailLabel}>{t('weather.range')}</Text>
          </View>
          <View style={styles.detailDivider} />
          <View style={styles.detailItem}>
            <Icon name="weather-windy" size={20} color="rgba(255,255,255,0.85)" />
            <Text style={styles.detailValue}>-</Text>
            <Text style={styles.detailLabel}>{t('weather.wind')}</Text>
          </View>
        </View>
      </LinearGradient>

      <View style={[styles.adviceBanner, { backgroundColor: advice.bg }]}>
        <Icon name={advice.icon} size={20} color={advice.text} />
        <Text style={[styles.adviceText, { color: advice.text }]}>{info.adviceText}</Text>
      </View>
    </View>
  );
}

const createStyles = (colors: ThemeColors) => StyleSheet.create({
  container: {
    borderRadius: BorderRadius.lg,
    overflow: 'hidden',
    backgroundColor: colors.surface,
    marginBottom: Spacing.md,
  },
  centered: {
    padding: Spacing.xl,
    alignItems: 'center',
    justifyContent: 'center',
  },
  gradient: {
    padding: Spacing.lg,
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: Spacing.md,
  },
  headerTitle: {
    ...Typography.bodySmall,
    color: 'rgba(255,255,255,0.9)',
    fontWeight: '600',
    textTransform: 'uppercase',
    letterSpacing: 1,
  },
  headerDate: {
    ...Typography.bodySmall,
    color: 'rgba(255,255,255,0.75)',
  },
  mainRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: Spacing.lg,
  },
  tempSection: {
    flex: 1,
  },
  tempLarge: {
    fontSize: 64,
    fontWeight: '700',
    color: '#FFFFFF',
    lineHeight: 72,
  },
  tempSmall: {
    ...Typography.body,
    color: 'rgba(255,255,255,0.8)',
  },
  iconSection: {
    alignItems: 'center',
  },
  conditionText: {
    ...Typography.bodySmall,
    color: '#FFFFFF',
    fontWeight: '600',
    marginTop: Spacing.xs,
  },
  detailsRow: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: 'rgba(255,255,255,0.15)',
    borderRadius: BorderRadius.md,
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.md,
  },
  detailItem: {
    flex: 1,
    alignItems: 'center',
  },
  detailValue: {
    ...Typography.bodySmall,
    color: '#FFFFFF',
    fontWeight: '700',
    marginTop: 2,
  },
  detailLabel: {
    ...Typography.caption,
    color: 'rgba(255,255,255,0.7)',
  },
  detailDivider: {
    width: 1,
    height: 32,
    backgroundColor: 'rgba(255,255,255,0.25)',
  },
  adviceBanner: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: Spacing.md,
    gap: Spacing.sm,
  },
  adviceText: {
    ...Typography.bodySmall,
    fontWeight: '600',
    flex: 1,
  },
  loadingText: {
    ...Typography.body,
    color: colors.textSecondary,
    marginTop: Spacing.sm,
  },
  errorText: {
    ...Typography.body,
    color: colors.textSecondary,
    marginTop: Spacing.sm,
    textAlign: 'center',
  },
});

