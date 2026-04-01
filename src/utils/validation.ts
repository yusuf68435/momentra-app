import {
  sanitizeInput,
  sanitizeDisplayName,
  sanitizeHtml,
  stripHtmlTags,
  sanitizeQueryParam,
} from './crypto';

export interface ValidationMessage {
  tr: string;
  en: string;
}

// Re-export sanitization functions for convenience
export {
  sanitizeInput,
  sanitizeDisplayName,
  sanitizeHtml,
  stripHtmlTags,
  sanitizeQueryParam,
};

export function validateEmail(email: string): ValidationMessage | null {
  if (!email.trim()) {
    return {
      tr: 'E-posta adresi gereklidir',
      en: 'Email address is required',
    };
  }
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailRegex.test(email.trim())) {
    return {
      tr: 'Geçerli bir e-posta adresi girin',
      en: 'Please enter a valid email address',
    };
  }
  return null;
}

const COMMON_PASSWORDS = new Set([
  'password', '12345678', '123456789', '1234567890', 'qwerty123',
  'abc12345', 'password1', 'iloveyou', 'sunshine1', 'princess1',
  'football1', 'charlie1', 'shadow12', 'monkey123', 'dragon12',
  'master12', 'letmein12', 'mustang1', 'access14', 'michael1',
]);

export function validatePassword(password: string): ValidationMessage | null {
  if (!password) {
    return {
      tr: 'Şifre gereklidir',
      en: 'Password is required',
    };
  }
  if (password.length < 8) {
    return {
      tr: 'Şifre en az 8 karakter olmalıdır',
      en: 'Password must be at least 8 characters',
    };
  }
  if (!/[A-Z]/.test(password)) {
    return {
      tr: 'Şifre en az 1 büyük harf içermelidir',
      en: 'Password must contain at least 1 uppercase letter',
    };
  }
  if (!/[0-9]/.test(password)) {
    return {
      tr: 'Şifre en az 1 rakam içermelidir',
      en: 'Password must contain at least 1 number',
    };
  }
  if (!/[^A-Za-z0-9]/.test(password)) {
    return {
      tr: 'Şifre en az 1 özel karakter içermelidir (!@#$%^&*)',
      en: 'Password must contain at least 1 special character (!@#$%^&*)',
    };
  }
  if (COMMON_PASSWORDS.has(password.toLowerCase())) {
    return {
      tr: 'Bu şifre çok yaygın, lütfen daha güçlü bir şifre seçin',
      en: 'This password is too common, please choose a stronger one',
    };
  }
  if (/(.)\1{2,}/.test(password)) {
    return {
      tr: 'Şifre ardışık tekrar eden karakterler içeremez',
      en: 'Password cannot contain consecutively repeating characters',
    };
  }
  return null;
}

export function validatePasswordMatch(
  password: string,
  confirm: string
): ValidationMessage | null {
  if (!confirm) {
    return {
      tr: 'Şifre tekrarı gereklidir',
      en: 'Password confirmation is required',
    };
  }
  if (password !== confirm) {
    return {
      tr: 'Şifreler eşleşmiyor',
      en: 'Passwords do not match',
    };
  }
  return null;
}

export function validateRequired(
  value: string,
  fieldName: { tr: string; en: string }
): ValidationMessage | null {
  if (!value.trim()) {
    return {
      tr: `${fieldName.tr} gereklidir`,
      en: `${fieldName.en} is required`,
    };
  }
  return null;
}

export function validateMinLength(
  value: string,
  min: number,
  fieldName: { tr: string; en: string }
): ValidationMessage | null {
  if (value.trim().length < min) {
    return {
      tr: `${fieldName.tr} en az ${min} karakter olmalıdır`,
      en: `${fieldName.en} must be at least ${min} characters`,
    };
  }
  return null;
}

export function validateBudget(
  min: number | undefined,
  max: number | undefined
): ValidationMessage | null {
  if (min !== undefined && min < 0) {
    return {
      tr: 'Bütçe negatif olamaz',
      en: 'Budget cannot be negative',
    };
  }
  if (max !== undefined && max < 0) {
    return {
      tr: 'Bütçe negatif olamaz',
      en: 'Budget cannot be negative',
    };
  }
  if (min !== undefined && max !== undefined && min > max) {
    return {
      tr: 'Minimum bütçe maksimumdan büyük olamaz',
      en: 'Minimum budget cannot be greater than maximum',
    };
  }
  return null;
}

export function validateDate(date: string): ValidationMessage | null {
  if (!date.trim()) {
    return null; // date may be optional, let validateRequired handle if needed
  }
  const dateRegex = /^\d{4}-\d{2}-\d{2}$/;
  if (!dateRegex.test(date.trim())) {
    return {
      tr: 'Geçerli bir tarih girin (YYYY-MM-DD)',
      en: 'Please enter a valid date (YYYY-MM-DD)',
    };
  }
  const parsed = new Date(date.trim());
  if (isNaN(parsed.getTime())) {
    return {
      tr: 'Geçerli bir tarih girin',
      en: 'Please enter a valid date',
    };
  }
  const now = new Date();
  now.setHours(0, 0, 0, 0);
  if (parsed < now) {
    return {
      tr: 'Tarih gelecekte olmalıdır',
      en: 'Date must be in the future',
    };
  }
  return null;
}

export type PasswordStrength = 'weak' | 'medium' | 'strong';

export function getPasswordStrength(password: string): PasswordStrength {
  if (!password) return 'weak';
  let score = 0;
  if (password.length >= 8) score++;
  if (password.length >= 12) score++;
  if (/[A-Z]/.test(password)) score++;
  if (/[0-9]/.test(password)) score++;
  if (/[^A-Za-z0-9]/.test(password)) score++;

  if (score <= 2) return 'weak';
  if (score <= 3) return 'medium';
  return 'strong';
}

export function getPasswordStrengthLabel(strength: PasswordStrength): ValidationMessage {
  switch (strength) {
    case 'weak':
      return { tr: 'Zayıf', en: 'Weak' };
    case 'medium':
      return { tr: 'Orta', en: 'Medium' };
    case 'strong':
      return { tr: 'Güçlü', en: 'Strong' };
  }
}

export function getPasswordStrengthColor(strength: PasswordStrength): string {
  switch (strength) {
    case 'weak':
      return '#F44336';
    case 'medium':
      return '#FFC107';
    case 'strong':
      return '#4CAF50';
  }
}

/** Helper to get localized message based on current language */
export function getMsg(msg: ValidationMessage | null, lang: string): string | null {
  if (!msg) return null;
  return lang === 'tr' ? msg.tr : msg.en;
}

// ==========================================
// SANITIZED VALIDATORS
// ==========================================

/**
 * Validate and sanitize a user display name.
 * Returns the sanitized name or a validation error.
 */
export function validateAndSanitizeName(
  name: string,
): { value: string; error: ValidationMessage | null } {
  const sanitized = sanitizeDisplayName(name);
  if (!sanitized) {
    return {
      value: '',
      error: { tr: 'İsim gereklidir', en: 'Name is required' },
    };
  }
  if (sanitized.length < 2) {
    return {
      value: sanitized,
      error: { tr: 'İsim en az 2 karakter olmalıdır', en: 'Name must be at least 2 characters' },
    };
  }
  return { value: sanitized, error: null };
}

/**
 * Validate and sanitize a message/comment/note.
 * Strips HTML, limits length, removes control characters.
 */
export function validateAndSanitizeText(
  text: string,
  maxLength: number = 1000,
  fieldName: { tr: string; en: string } = { tr: 'Metin', en: 'Text' },
): { value: string; error: ValidationMessage | null } {
  const sanitized = sanitizeInput(text, maxLength);
  if (!sanitized) {
    return {
      value: '',
      error: { tr: `${fieldName.tr} gereklidir`, en: `${fieldName.en} is required` },
    };
  }
  return { value: sanitized, error: null };
}

/**
 * Validate a PIN code format (4-6 digits only).
 */
export function validatePin(pin: string): ValidationMessage | null {
  if (!pin) {
    return { tr: 'PIN gereklidir', en: 'PIN is required' };
  }
  if (!/^\d{4,6}$/.test(pin)) {
    return { tr: 'PIN 4-6 haneli bir sayı olmalıdır', en: 'PIN must be a 4-6 digit number' };
  }
  // Reject sequential/repeated PINs
  if (/^(\d)\1+$/.test(pin)) {
    return { tr: 'PIN tekrarlayan rakamlardan oluşamaz', en: 'PIN cannot be all repeating digits' };
  }
  const sequential = '0123456789';
  const reverseSeq = '9876543210';
  if (sequential.includes(pin) || reverseSeq.includes(pin)) {
    return { tr: 'PIN ardışık rakamlardan oluşamaz', en: 'PIN cannot be sequential digits' };
  }
  return null;
}
