// ==========================================
// App-wide default values and constants
// ==========================================

/** Default page size for paginated queries */
export const DEFAULT_PAGE_LIMIT = 20;

/** Default number of days before an event to send notification */
export const DEFAULT_NOTIFY_DAYS = 7;

/** Milliseconds in a day */
export const MS_PER_DAY = 86_400_000;

/** Supabase storage bucket for user uploads */
export const STORAGE_BUCKET = 'user-uploads';

/** Default image quality for photo picker (0-1) */
export const IMAGE_QUALITY = 0.8;

/** Default aspect ratio for photo picker */
export const IMAGE_ASPECT_RATIO: [number, number] = [4, 3];

/** Supabase error code for "no rows found" */
export const NO_ROWS_ERROR_CODE = 'PGRST116';
