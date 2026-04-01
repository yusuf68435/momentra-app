import AsyncStorage from '@react-native-async-storage/async-storage';
import * as LocalAuthentication from 'expo-local-authentication';
import * as Notifications from 'expo-notifications';
import { Platform } from 'react-native';
import * as ExpoCrypto from 'expo-crypto';
import { hashPinSecure } from './crypto';

const STEALTH_KEY = '@momentra_stealth';
const PIN_KEY = '@momentra_pin';
const DEVICE_ID_KEY = '@momentra_device_id';

interface StealthConfig {
  isEnabled: boolean;
  requireAuth: boolean;  // Require PIN/biometric to open
  hideNotificationContent: boolean;  // Show generic notification text
  fakeAppName: string;  // Display name in recent apps
  autoLockMinutes: number;  // Auto lock after X minutes
}

const DEFAULT_CONFIG: StealthConfig = {
  isEnabled: false,
  requireAuth: false,
  hideNotificationContent: false,
  fakeAppName: 'Momentra',
  autoLockMinutes: 5,
};

/**
 * Get stealth mode configuration
 */
export async function getStealthConfig(): Promise<StealthConfig> {
  try {
    const stored = await AsyncStorage.getItem(STEALTH_KEY);
    return stored ? { ...DEFAULT_CONFIG, ...JSON.parse(stored) } : DEFAULT_CONFIG;
  } catch {
    return DEFAULT_CONFIG;
  }
}

/**
 * Save stealth mode configuration
 */
export async function setStealthConfig(config: Partial<StealthConfig>): Promise<void> {
  const current = await getStealthConfig();
  const updated = { ...current, ...config };
  await AsyncStorage.setItem(STEALTH_KEY, JSON.stringify(updated));
}

/**
 * Check if biometric authentication is available
 */
export async function isBiometricAvailable(): Promise<{
  available: boolean;
  type: 'fingerprint' | 'facial' | 'iris' | 'none';
}> {
  const hasHardware = await LocalAuthentication.hasHardwareAsync();
  const isEnrolled = await LocalAuthentication.isEnrolledAsync();

  if (!hasHardware || !isEnrolled) {
    return { available: false, type: 'none' };
  }

  const types = await LocalAuthentication.supportedAuthenticationTypesAsync();

  if (types.includes(LocalAuthentication.AuthenticationType.FACIAL_RECOGNITION)) {
    return { available: true, type: 'facial' };
  }
  if (types.includes(LocalAuthentication.AuthenticationType.FINGERPRINT)) {
    return { available: true, type: 'fingerprint' };
  }
  if (types.includes(LocalAuthentication.AuthenticationType.IRIS)) {
    return { available: true, type: 'iris' };
  }

  return { available: false, type: 'none' };
}

/**
 * Authenticate user with biometric or PIN
 */
export async function authenticateUser(lang: 'tr' | 'en'): Promise<boolean> {
  const config = await getStealthConfig();
  if (!config.requireAuth) return true;

  const biometric = await isBiometricAvailable();

  if (biometric.available) {
    const result = await LocalAuthentication.authenticateAsync({
      promptMessage: lang === 'tr' ? 'Uygulamayı açmak için doğrulama gerekli' : 'Authentication required to open app',
      cancelLabel: lang === 'tr' ? 'PIN Kullan' : 'Use PIN',
      disableDeviceFallback: false,
      fallbackLabel: lang === 'tr' ? 'PIN Gir' : 'Enter PIN',
    });

    return result.success;
  }

  // Fallback to PIN (handled by the calling component)
  return false;
}

/**
 * Get or create a persistent device ID for PIN salt.
 * Ensures each device produces unique hashes even for the same PIN.
 */
async function getDeviceId(): Promise<string> {
  let deviceId = await AsyncStorage.getItem(DEVICE_ID_KEY);
  if (!deviceId) {
    deviceId = ExpoCrypto.getRandomBytes(16)
      .reduce((s, b) => s + b.toString(16).padStart(2, '0'), '');
    await AsyncStorage.setItem(DEVICE_ID_KEY, deviceId);
  }
  return deviceId;
}

/**
 * Set or update the PIN code using SHA-256 with per-device salt.
 */
export async function setPinCode(pin: string): Promise<void> {
  const deviceId = await getDeviceId();
  const hash = await hashPinSecure(pin, deviceId);
  await AsyncStorage.setItem(PIN_KEY, hash);
}

/**
 * Verify a PIN code against the stored SHA-256 hash.
 */
export async function verifyPinCode(pin: string): Promise<boolean> {
  const stored = await AsyncStorage.getItem(PIN_KEY);
  if (!stored) return false;
  const deviceId = await getDeviceId();
  const hash = await hashPinSecure(pin, deviceId);
  // Constant-time comparison to prevent timing attacks
  if (stored.length !== hash.length) return false;
  let diff = 0;
  for (let i = 0; i < stored.length; i++) {
    diff |= stored.charCodeAt(i) ^ hash.charCodeAt(i);
  }
  return diff === 0;
}

/**
 * Check if a PIN is set
 */
export async function hasPinCode(): Promise<boolean> {
  const stored = await AsyncStorage.getItem(PIN_KEY);
  return stored !== null && stored.length > 0;
}

/**
 * Remove the PIN code
 */
export async function removePinCode(): Promise<void> {
  await AsyncStorage.removeItem(PIN_KEY);
}

/**
 * Get discreet notification content (for stealth mode)
 */
export function getDiscreetNotificationContent(
  originalTitle: string,
  originalBody: string,
  hideContent: boolean,
  lang: 'tr' | 'en'
): { title: string; body: string } {
  if (!hideContent) {
    return { title: originalTitle, body: originalBody };
  }

  return {
    title: lang === 'tr' ? 'Yeni hatırlatma' : 'New reminder',
    body: lang === 'tr' ? 'Detaylar için uygulamayı açın' : 'Open app for details',
  };
}
