function getEnvVar(key: string, fallback?: string): string {
  const value = process.env[key];
  if (!value || value === "") {
    if (fallback !== undefined) return fallback;
    if (__DEV__) {
      console.warn(
        `⚠️ Environment variable ${key} is not set. ` +
          `Create a .env file with ${key}=your-value`,
      );
    } else {
      // Production: don't throw at module-load time (crashes the JS bundle).
      // Log via Sentry/console; downstream code can render an error UI.
      // eslint-disable-next-line no-console
      console.error(`[config] Missing required environment variable: ${key}`);
    }
    return "";
  }
  return value;
}

export const APP_CONFIG = {
  name: "Momentra",
  version: "1.0.0",
  supabaseUrl: getEnvVar("EXPO_PUBLIC_SUPABASE_URL"),
  supabaseAnonKey: getEnvVar("EXPO_PUBLIC_SUPABASE_ANON_KEY"),
  defaultLanguage: "tr" as const,
  supportedLanguages: [
    "tr",
    "en",
    "de",
    "fr",
    "es",
    "it",
    "pt",
    "ru",
    "ar",
    "ja",
    "ko",
    "zh",
    "hi",
    "nl",
    "pl",
    "sv",
    "uk",
  ] as const,
  defaultCurrency: "TRY" as const,
  defaultTimezone: "Europe/Istanbul",
  revenueCatIosKey: getEnvVar("EXPO_PUBLIC_REVENUECAT_IOS_KEY", ""),
  revenueCatAndroidKey: getEnvVar("EXPO_PUBLIC_REVENUECAT_ANDROID_KEY", ""),
  appStoreId: "6741427283",
};

export type SupportedLanguage = (typeof APP_CONFIG.supportedLanguages)[number];
