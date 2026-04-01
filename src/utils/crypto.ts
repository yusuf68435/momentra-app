import * as ExpoCrypto from "expo-crypto";
import nacl from "tweetnacl";
import {
  decodeUTF8,
  encodeUTF8,
  encodeBase64,
  decodeBase64,
} from "tweetnacl-util";

// ==========================================
// PIN HASHING (SHA-256 + per-device salt)
// ==========================================

const PIN_SALT_PREFIX = "momentra_pin_v2_";

/**
 * Hash a PIN using SHA-256 with a unique salt.
 * Much stronger than the old djb2-style hash.
 */
export async function hashPinSecure(
  pin: string,
  deviceId: string,
): Promise<string> {
  const salt = PIN_SALT_PREFIX + deviceId;
  const salted = salt + ":" + pin;
  const hash = await ExpoCrypto.digestStringAsync(
    ExpoCrypto.CryptoDigestAlgorithm.SHA256,
    salted,
  );
  // Double hash for extra cost (poor-man's key stretching)
  const doubleHash = await ExpoCrypto.digestStringAsync(
    ExpoCrypto.CryptoDigestAlgorithm.SHA256,
    hash + salt,
  );
  return doubleHash;
}

// ==========================================
// MESSAGE ENCRYPTION (NaCl secretbox)
// ==========================================

/**
 * Derive a shared encryption key from a plan ID + user pair.
 * Uses SHA-256 to produce a 32-byte key from the shared secret.
 */
export async function deriveMessageKey(
  planId: string,
  sharedSecret: string,
): Promise<Uint8Array> {
  const material = `momentra_msg_key:${planId}:${sharedSecret}`;
  const hash = await ExpoCrypto.digestStringAsync(
    ExpoCrypto.CryptoDigestAlgorithm.SHA256,
    material,
  );
  // SHA-256 hex string → 32 bytes
  return decodeBase64(encodeBase64(hexToBytes(hash)));
}

/**
 * Encrypt a plaintext message using NaCl secretbox.
 * Returns base64-encoded string: nonce + ciphertext.
 */
export function encryptMessage(plaintext: string, key: Uint8Array): string {
  const nonce = nacl.randomBytes(nacl.secretbox.nonceLength);
  const messageBytes = decodeUTF8(plaintext);
  const encrypted = nacl.secretbox(messageBytes, nonce, key);

  if (!encrypted) {
    throw new Error("Encryption failed");
  }

  // Concatenate nonce + ciphertext and encode as base64
  const combined = new Uint8Array(nonce.length + encrypted.length);
  combined.set(nonce);
  combined.set(encrypted, nonce.length);
  return encodeBase64(combined);
}

/**
 * Decrypt a base64-encoded message (nonce + ciphertext) using NaCl secretbox.
 * Returns the plaintext string or null if decryption fails.
 */
export function decryptMessage(
  cipherBase64: string,
  key: Uint8Array,
): string | null {
  try {
    const combined = decodeBase64(cipherBase64);
    const nonceLen = nacl.secretbox.nonceLength;

    if (combined.length < nonceLen + 1) {
      return null;
    }

    const nonce = combined.slice(0, nonceLen);
    const ciphertext = combined.slice(nonceLen);
    const decrypted = nacl.secretbox.open(ciphertext, nonce, key);

    if (!decrypted) {
      return null;
    }

    return encodeUTF8(decrypted);
  } catch {
    return null;
  }
}

// ==========================================
// SECURE TOKEN GENERATION (no modulo bias)
// ==========================================

const TOKEN_CHARS =
  "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

/**
 * Generate a cryptographically secure random token without modulo bias.
 * Uses rejection sampling to ensure uniform distribution.
 */
export function generateSecureToken(length: number = 32): string {
  const charsLen = TOKEN_CHARS.length; // 62
  // Largest multiple of charsLen that fits in 32 bits
  const maxValid = Math.floor(0xffffffff / charsLen) * charsLen;

  let token = "";
  while (token.length < length) {
    const randomValues = new Uint32Array(length - token.length);
    crypto.getRandomValues(randomValues);

    for (let i = 0; i < randomValues.length && token.length < length; i++) {
      // Rejection sampling: discard values that would cause bias
      if (randomValues[i] < maxValid) {
        token += TOKEN_CHARS.charAt(randomValues[i] % charsLen);
      }
    }
  }
  return token;
}

// ==========================================
// INPUT SANITIZATION
// ==========================================

/**
 * Strip HTML tags to prevent XSS in rendered text.
 * For React Native, this prevents injection if content is used in WebView or dangerouslySetInnerHTML.
 */
export function sanitizeHtml(input: string): string {
  return input
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#x27;");
}

/**
 * Strip all HTML tags (for plain text extraction).
 */
export function stripHtmlTags(input: string): string {
  return input.replace(/<[^>]*>/g, "");
}

/**
 * Sanitize user input: trim, limit length, strip control characters.
 */
export function sanitizeInput(input: string, maxLength: number = 1000): string {
  return (
    input
      // Remove null bytes and other control chars (keep newlines and tabs)
      .replace(/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]/g, "")
      .trim()
      .slice(0, maxLength)
  );
}

/**
 * Sanitize a display name: strip HTML, limit length, remove dangerous chars.
 */
export function sanitizeDisplayName(name: string): string {
  return stripHtmlTags(name)
    .replace(/[<>"'&;\\]/g, "")
    .replace(/[\x00-\x1F\x7F]/g, "")
    .trim()
    .slice(0, 100);
}

/**
 * Sanitize SQL-like input to prevent injection via Supabase text filters.
 * Escapes characters that could break .or() / .filter() queries.
 */
export function sanitizeQueryParam(input: string): string {
  return input
    .replace(/[\\'"%;()]/g, "")
    .trim()
    .slice(0, 200);
}

// ==========================================
// VALIDATION HELPERS
// ==========================================

const UUID_REGEX =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

/**
 * Validate that a string is a valid UUID v4 format.
 * Use this before inserting user-supplied IDs into Supabase queries.
 */
export function isValidUUID(value: string): boolean {
  return UUID_REGEX.test(value);
}

// ==========================================
// HELPERS
// ==========================================

function hexToBytes(hex: string): Uint8Array {
  const bytes = new Uint8Array(hex.length / 2);
  for (let i = 0; i < hex.length; i += 2) {
    bytes[i / 2] = parseInt(hex.substring(i, i + 2), 16);
  }
  return bytes;
}
