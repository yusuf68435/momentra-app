import { supabase } from './supabase';

// ==========================================
// TYPES
// ==========================================

export interface WeatherForecast {
  date: string;
  temperature: number;
  temperature_max: number;
  temperature_min: number;
  condition: string;
  condition_code: number;
  wind_speed: number;
  humidity: number;
  rain_probability: number;
  icon: string;
}

export interface WeatherAdvice {
  summary: string;
  is_outdoor_friendly: boolean;
  suggestions: string[];
}

// ==========================================
// WEATHER CODE MAPPINGS
// ==========================================

const WEATHER_CONDITIONS: Record<number, string> = {
  0: 'Clear sky',
  1: 'Mainly clear',
  2: 'Partly cloudy',
  3: 'Overcast',
  45: 'Foggy',
  48: 'Depositing rime fog',
  51: 'Light drizzle',
  53: 'Moderate drizzle',
  55: 'Dense drizzle',
  61: 'Slight rain',
  63: 'Moderate rain',
  65: 'Heavy rain',
  71: 'Slight snow',
  73: 'Moderate snow',
  75: 'Heavy snow',
  77: 'Snow grains',
  80: 'Slight rain showers',
  81: 'Moderate rain showers',
  82: 'Violent rain showers',
  85: 'Slight snow showers',
  86: 'Heavy snow showers',
  95: 'Thunderstorm',
  96: 'Thunderstorm with slight hail',
  99: 'Thunderstorm with heavy hail',
};

const WEATHER_ICONS: Record<number, string> = {
  0: '☀️',
  1: '🌤️',
  2: '⛅',
  3: '☁️',
  45: '🌫️',
  48: '🌫️',
  51: '🌦️',
  53: '🌧️',
  55: '🌧️',
  61: '🌧️',
  63: '🌧️',
  65: '🌧️',
  71: '🌨️',
  73: '🌨️',
  75: '❄️',
  77: '❄️',
  80: '🌦️',
  81: '🌧️',
  82: '⛈️',
  85: '🌨️',
  86: '❄️',
  95: '⛈️',
  96: '⛈️',
  99: '⛈️',
};

// ==========================================
// WEATHER FUNCTIONS
// ==========================================

export async function getWeatherForecast(
  lat: number,
  lon: number,
  date: string
): Promise<WeatherForecast | null> {
  try {
    const url = `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max,weathercode,windspeed_10m_max,relative_humidity_2m_mean&start_date=${date}&end_date=${date}&timezone=auto`;

    const response = await fetch(url);
    if (!response.ok) {
      if (__DEV__) {
        console.warn('Weather API error:', response.status);
      }
      return null;
    }

    const json = await response.json();
    const daily = json.daily;

    if (!daily || !daily.time || daily.time.length === 0) {
      return null;
    }

    const code = daily.weathercode[0] ?? 0;

    return {
      date,
      temperature: Math.round((daily.temperature_2m_max[0] + daily.temperature_2m_min[0]) / 2),
      temperature_max: daily.temperature_2m_max[0],
      temperature_min: daily.temperature_2m_min[0],
      condition: WEATHER_CONDITIONS[code] || 'Unknown',
      condition_code: code,
      wind_speed: daily.windspeed_10m_max[0],
      humidity: daily.relative_humidity_2m_mean?.[0] ?? 0,
      rain_probability: daily.precipitation_probability_max[0] ?? 0,
      icon: getWeatherIcon(code),
    };
  } catch (err) {
    if (__DEV__) {
      console.warn('getWeatherForecast error:', err);
    }
    return null;
  }
}

export function getWeatherIcon(code: number): string {
  return WEATHER_ICONS[code] || '🌡️';
}

export function getWeatherAdvice(weather: WeatherForecast): WeatherAdvice {
  const suggestions: string[] = [];
  let isOutdoorFriendly = true;
  let summary = '';

  // Rain check
  if (weather.rain_probability > 60) {
    isOutdoorFriendly = false;
    suggestions.push('High chance of rain — consider an indoor backup plan');
    suggestions.push('Keep umbrellas ready for guests');
  } else if (weather.rain_probability > 30) {
    suggestions.push('Some chance of rain — have a backup plan just in case');
  }

  // Temperature check
  if (weather.temperature_max > 35) {
    suggestions.push('Very hot — provide shade, cold drinks, and fans');
    suggestions.push('Schedule outdoor activities for early morning or evening');
  } else if (weather.temperature_max > 30) {
    suggestions.push('Warm weather — ensure there is shade and hydration available');
  } else if (weather.temperature_min < 5) {
    suggestions.push('Cold weather — consider indoor venue or provide heaters');
    isOutdoorFriendly = false;
  } else if (weather.temperature_min < 15) {
    suggestions.push('Cool weather — remind guests to bring warm layers');
  }

  // Wind check
  if (weather.wind_speed > 40) {
    isOutdoorFriendly = false;
    suggestions.push('Strong winds expected — avoid candles and lightweight decorations outdoors');
  } else if (weather.wind_speed > 25) {
    suggestions.push('Windy conditions — secure decorations and avoid paper items outdoors');
  }

  // Snow/storm check
  if (weather.condition_code >= 71 && weather.condition_code <= 77) {
    isOutdoorFriendly = false;
    suggestions.push('Snow expected — plan for indoor activities');
  }
  if (weather.condition_code >= 95) {
    isOutdoorFriendly = false;
    suggestions.push('Thunderstorms expected — strongly recommend indoor venue');
  }

  if (isOutdoorFriendly && suggestions.length === 0) {
    summary = 'Perfect weather for an outdoor surprise!';
    suggestions.push('Great conditions for outdoor decorations and activities');
  } else if (isOutdoorFriendly) {
    summary = 'Outdoor is possible, but check the suggestions below';
  } else {
    summary = 'Consider an indoor backup plan';
  }

  return { summary, is_outdoor_friendly: isOutdoorFriendly, suggestions };
}
