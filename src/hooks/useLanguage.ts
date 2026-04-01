import { useCallback } from 'react';
import { useTranslation } from 'react-i18next';
import { useSettingsStore } from '../stores/settingsStore';
import type { SupportedLanguage } from '../constants/config';

export function useLanguage() {
  const { i18n } = useTranslation();
  const { language, setLanguage } = useSettingsStore();

  const changeLanguage = useCallback(
    async (lang: SupportedLanguage) => {
      await i18n.changeLanguage(lang);
      setLanguage(lang);
    },
    [i18n, setLanguage]
  );

  const getLocalizedField = useCallback(
    <T extends Record<string, unknown>>(
      obj: T,
      fieldBase: string
    ): string => {
      const key = `${fieldBase}_${language}` as keyof T;
      return (obj[key] as string) || '';
    },
    [language]
  );

  return {
    language,
    changeLanguage,
    getLocalizedField,
    isRTL: false,
  };
}
