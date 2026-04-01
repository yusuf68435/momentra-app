/**
 * Validation patterns for deep links and user input.
 * Centralised here so they can be reused and tested in isolation.
 */

export const UUID_RE =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

export const INVITE_CODE_RE = /^[a-zA-Z0-9]{1,32}$/;

export const SLUG_RE = /^[a-z0-9-]{1,64}$/;
