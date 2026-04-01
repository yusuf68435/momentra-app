import { useSettingsStore } from '../../src/stores/settingsStore';
import type { Profile } from '../../src/types/database';

/**
 * Reset the Zustand store to its initial state between tests.
 * Zustand stores are singletons so we need to manually reset.
 */
function resetStore() {
  useSettingsStore.setState({
    language: 'tr',
    isDarkMode: false,
    notificationsEnabled: true,
    notificationPreferences: {
      planReminders: true,
      countdownAlerts: true,
      aiSuggestions: true,
      newScenarios: false,
      promotions: false,
      proactiveSuggestions: true,
    },
    currency: 'TRY',
    subscriptionPlan: 'free',
    hasSeenOnboarding: false,
    favoriteCategories: [],
  });
}

beforeEach(() => {
  resetStore();
});

// ── Default state ────────────────────────────────────────────────────

describe('settingsStore – default state', () => {
  it('has Turkish as the default language', () => {
    expect(useSettingsStore.getState().language).toBe('tr');
  });

  it('has dark mode disabled by default', () => {
    expect(useSettingsStore.getState().isDarkMode).toBe(false);
  });

  it('has notifications enabled by default', () => {
    expect(useSettingsStore.getState().notificationsEnabled).toBe(true);
  });

  it('uses TRY as the default currency', () => {
    expect(useSettingsStore.getState().currency).toBe('TRY');
  });

  it('defaults to the free subscription plan', () => {
    expect(useSettingsStore.getState().subscriptionPlan).toBe('free');
  });

  it('has not seen onboarding by default', () => {
    expect(useSettingsStore.getState().hasSeenOnboarding).toBe(false);
  });

  it('starts with an empty favoriteCategories array', () => {
    expect(useSettingsStore.getState().favoriteCategories).toEqual([]);
  });

  it('has correct default notification preferences', () => {
    const prefs = useSettingsStore.getState().notificationPreferences;
    expect(prefs.planReminders).toBe(true);
    expect(prefs.countdownAlerts).toBe(true);
    expect(prefs.aiSuggestions).toBe(true);
    expect(prefs.newScenarios).toBe(false);
    expect(prefs.promotions).toBe(false);
  });
});

// ── setLanguage ──────────────────────────────────────────────────────

describe('settingsStore – setLanguage', () => {
  it('changes the language to English', () => {
    useSettingsStore.getState().setLanguage('en');
    expect(useSettingsStore.getState().language).toBe('en');
  });

  it('changes the language back to Turkish', () => {
    useSettingsStore.getState().setLanguage('en');
    useSettingsStore.getState().setLanguage('tr');
    expect(useSettingsStore.getState().language).toBe('tr');
  });
});

// ── setDarkMode ──────────────────────────────────────────────────────

describe('settingsStore – setDarkMode', () => {
  it('enables dark mode', () => {
    useSettingsStore.getState().setDarkMode(true);
    expect(useSettingsStore.getState().isDarkMode).toBe(true);
  });

  it('disables dark mode', () => {
    useSettingsStore.getState().setDarkMode(true);
    useSettingsStore.getState().setDarkMode(false);
    expect(useSettingsStore.getState().isDarkMode).toBe(false);
  });
});

// ── setNotificationPreference ────────────────────────────────────────

describe('settingsStore – setNotificationPreference', () => {
  it('toggles a single notification preference without affecting others', () => {
    useSettingsStore.getState().setNotificationPreference('promotions', true);
    const prefs = useSettingsStore.getState().notificationPreferences;

    expect(prefs.promotions).toBe(true);
    // Other preferences remain unchanged
    expect(prefs.planReminders).toBe(true);
    expect(prefs.countdownAlerts).toBe(true);
  });

  it('can disable a previously enabled preference', () => {
    useSettingsStore.getState().setNotificationPreference('planReminders', false);
    expect(useSettingsStore.getState().notificationPreferences.planReminders).toBe(false);
  });
});

// ── setCurrency / setSubscriptionPlan ────────────────────────────────

describe('settingsStore – setCurrency', () => {
  it('changes the currency to USD', () => {
    useSettingsStore.getState().setCurrency('USD');
    expect(useSettingsStore.getState().currency).toBe('USD');
  });

  it('changes the currency to EUR', () => {
    useSettingsStore.getState().setCurrency('EUR');
    expect(useSettingsStore.getState().currency).toBe('EUR');
  });
});

describe('settingsStore – setSubscriptionPlan', () => {
  it('upgrades to plus', () => {
    useSettingsStore.getState().setSubscriptionPlan('plus');
    expect(useSettingsStore.getState().subscriptionPlan).toBe('plus');
  });

  it('upgrades to pro', () => {
    useSettingsStore.getState().setSubscriptionPlan('pro');
    expect(useSettingsStore.getState().subscriptionPlan).toBe('pro');
  });
});

// ── hydrateFromProfile ───────────────────────────────────────────────

describe('settingsStore – hydrateFromProfile', () => {
  const baseProfile: Profile = {
    id: 'user-1',
    display_name: 'Test User',
    avatar_url: null,
    language: 'en',
    currency: 'USD',
    timezone: 'America/New_York',
    onboarding_completed: true,
    preferences: {},
    created_at: '2025-01-01T00:00:00Z',
    updated_at: '2025-01-01T00:00:00Z',
  };

  it('updates language from profile', () => {
    useSettingsStore.getState().hydrateFromProfile(baseProfile);
    expect(useSettingsStore.getState().language).toBe('en');
  });

  it('updates currency from profile', () => {
    useSettingsStore.getState().hydrateFromProfile(baseProfile);
    expect(useSettingsStore.getState().currency).toBe('USD');
  });

  it('does not modify state when profile has no language or currency', () => {
    const emptyProfile = {
      ...baseProfile,
      language: undefined as unknown as 'tr' | 'en',
      currency: undefined as unknown as 'TRY' | 'USD' | 'EUR',
    };

    useSettingsStore.getState().hydrateFromProfile(emptyProfile);
    // Should remain at defaults
    expect(useSettingsStore.getState().language).toBe('tr');
    expect(useSettingsStore.getState().currency).toBe('TRY');
  });

  it('does not overwrite unrelated fields', () => {
    useSettingsStore.getState().setDarkMode(true);
    useSettingsStore.getState().hydrateFromProfile(baseProfile);

    // Dark mode should still be true (hydrateFromProfile only touches language & currency)
    expect(useSettingsStore.getState().isDarkMode).toBe(true);
  });
});

// ── syncToProfile ────────────────────────────────────────────────────

describe('settingsStore – syncToProfile', () => {
  it('returns the current language and currency for syncing', () => {
    useSettingsStore.getState().setLanguage('en');
    useSettingsStore.getState().setCurrency('EUR');

    const result = useSettingsStore.getState().syncToProfile();
    expect(result).toEqual({ language: 'en', currency: 'EUR' });
  });
});
