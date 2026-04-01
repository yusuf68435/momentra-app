import i18n from "i18next";
import { initReactI18next } from "react-i18next";
import * as Localization from "expo-localization";

import trCommon from "./tr/common.json";
import trScenarios from "./tr/scenarios.json";
import trPlans from "./tr/plans.json";
import trAi from "./tr/ai.json";
import trSettings from "./tr/settings.json";

import enCommon from "./en/common.json";
import enScenarios from "./en/scenarios.json";
import enPlans from "./en/plans.json";
import enAi from "./en/ai.json";
import enSettings from "./en/settings.json";

import deCommon from "./de/common.json";
import deScenarios from "./de/scenarios.json";
import dePlans from "./de/plans.json";
import deAi from "./de/ai.json";
import deSettings from "./de/settings.json";

import frCommon from "./fr/common.json";
import frScenarios from "./fr/scenarios.json";
import frPlans from "./fr/plans.json";
import frAi from "./fr/ai.json";
import frSettings from "./fr/settings.json";

import esCommon from "./es/common.json";
import esScenarios from "./es/scenarios.json";
import esPlans from "./es/plans.json";
import esAi from "./es/ai.json";
import esSettings from "./es/settings.json";

import itCommon from "./it/common.json";
import itScenarios from "./it/scenarios.json";
import itPlans from "./it/plans.json";
import itAi from "./it/ai.json";
import itSettings from "./it/settings.json";

import ptCommon from "./pt/common.json";
import ptScenarios from "./pt/scenarios.json";
import ptPlans from "./pt/plans.json";
import ptAi from "./pt/ai.json";
import ptSettings from "./pt/settings.json";

import ruCommon from "./ru/common.json";
import ruScenarios from "./ru/scenarios.json";
import ruPlans from "./ru/plans.json";
import ruAi from "./ru/ai.json";
import ruSettings from "./ru/settings.json";

import arCommon from "./ar/common.json";
import arScenarios from "./ar/scenarios.json";
import arPlans from "./ar/plans.json";
import arAi from "./ar/ai.json";
import arSettings from "./ar/settings.json";

import jaCommon from "./ja/common.json";
import jaScenarios from "./ja/scenarios.json";
import jaPlans from "./ja/plans.json";
import jaAi from "./ja/ai.json";
import jaSettings from "./ja/settings.json";

import koCommon from "./ko/common.json";
import koScenarios from "./ko/scenarios.json";
import koPlans from "./ko/plans.json";
import koAi from "./ko/ai.json";
import koSettings from "./ko/settings.json";

import zhCommon from "./zh/common.json";
import zhScenarios from "./zh/scenarios.json";
import zhPlans from "./zh/plans.json";
import zhAi from "./zh/ai.json";
import zhSettings from "./zh/settings.json";

import hiCommon from "./hi/common.json";
import hiScenarios from "./hi/scenarios.json";
import hiPlans from "./hi/plans.json";
import hiAi from "./hi/ai.json";
import hiSettings from "./hi/settings.json";

import nlCommon from "./nl/common.json";
import nlScenarios from "./nl/scenarios.json";
import nlPlans from "./nl/plans.json";
import nlAi from "./nl/ai.json";
import nlSettings from "./nl/settings.json";

import plCommon from "./pl/common.json";
import plScenarios from "./pl/scenarios.json";
import plPlans from "./pl/plans.json";
import plAi from "./pl/ai.json";
import plSettings from "./pl/settings.json";

import svCommon from "./sv/common.json";
import svScenarios from "./sv/scenarios.json";
import svPlans from "./sv/plans.json";
import svAi from "./sv/ai.json";
import svSettings from "./sv/settings.json";

import ukCommon from "./uk/common.json";
import ukScenarios from "./uk/scenarios.json";
import ukPlans from "./uk/plans.json";
import ukAi from "./uk/ai.json";
import ukSettings from "./uk/settings.json";

const SUPPORTED_LANGUAGES = [
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
] as const;

const deviceLanguage = Localization.getLocales()[0]?.languageCode ?? "en";
const initialLanguage = SUPPORTED_LANGUAGES.includes(
  deviceLanguage as (typeof SUPPORTED_LANGUAGES)[number],
)
  ? deviceLanguage
  : "en";

i18n.use(initReactI18next).init({
  resources: {
    tr: {
      common: trCommon,
      scenarios: trScenarios,
      plans: trPlans,
      ai: trAi,
      settings: trSettings,
    },
    en: {
      common: enCommon,
      scenarios: enScenarios,
      plans: enPlans,
      ai: enAi,
      settings: enSettings,
    },
    de: {
      common: deCommon,
      scenarios: deScenarios,
      plans: dePlans,
      ai: deAi,
      settings: deSettings,
    },
    fr: {
      common: frCommon,
      scenarios: frScenarios,
      plans: frPlans,
      ai: frAi,
      settings: frSettings,
    },
    es: {
      common: esCommon,
      scenarios: esScenarios,
      plans: esPlans,
      ai: esAi,
      settings: esSettings,
    },
    it: {
      common: itCommon,
      scenarios: itScenarios,
      plans: itPlans,
      ai: itAi,
      settings: itSettings,
    },
    pt: {
      common: ptCommon,
      scenarios: ptScenarios,
      plans: ptPlans,
      ai: ptAi,
      settings: ptSettings,
    },
    ru: {
      common: ruCommon,
      scenarios: ruScenarios,
      plans: ruPlans,
      ai: ruAi,
      settings: ruSettings,
    },
    ar: {
      common: arCommon,
      scenarios: arScenarios,
      plans: arPlans,
      ai: arAi,
      settings: arSettings,
    },
    ja: {
      common: jaCommon,
      scenarios: jaScenarios,
      plans: jaPlans,
      ai: jaAi,
      settings: jaSettings,
    },
    ko: {
      common: koCommon,
      scenarios: koScenarios,
      plans: koPlans,
      ai: koAi,
      settings: koSettings,
    },
    zh: {
      common: zhCommon,
      scenarios: zhScenarios,
      plans: zhPlans,
      ai: zhAi,
      settings: zhSettings,
    },
    hi: {
      common: hiCommon,
      scenarios: hiScenarios,
      plans: hiPlans,
      ai: hiAi,
      settings: hiSettings,
    },
    nl: {
      common: nlCommon,
      scenarios: nlScenarios,
      plans: nlPlans,
      ai: nlAi,
      settings: nlSettings,
    },
    pl: {
      common: plCommon,
      scenarios: plScenarios,
      plans: plPlans,
      ai: plAi,
      settings: plSettings,
    },
    sv: {
      common: svCommon,
      scenarios: svScenarios,
      plans: svPlans,
      ai: svAi,
      settings: svSettings,
    },
    uk: {
      common: ukCommon,
      scenarios: ukScenarios,
      plans: ukPlans,
      ai: ukAi,
      settings: ukSettings,
    },
  },
  lng: initialLanguage,
  fallbackLng: "en",
  defaultNS: "common",
  ns: ["common", "scenarios", "plans", "ai", "settings"],
  interpolation: {
    escapeValue: false,
  },
});

export default i18n;
export { SUPPORTED_LANGUAGES };
