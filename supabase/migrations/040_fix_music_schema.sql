-- 040_fix_music_schema.sql
-- Fix music schema mismatches between code and DB:
--   1. Rename playlist_items → music_playlist_songs (code expects this name)
--   2. Rename cover_image_url → image_url (code expects this name)
--   3. Add external_id, external_source columns for Spotify metadata
--   4. Add user_id alias column to music_playlists (code sends user_id, DB has created_by)
--   5. Update trigger + function references
--   6. Recreate RLS policies with new table name

-- ═══════════════════════════════════════════════════════════════════════
-- 1. Rename table: playlist_items → music_playlist_songs
-- ═══════════════════════════════════════════════════════════════════════

ALTER TABLE IF EXISTS playlist_items RENAME TO music_playlist_songs;

-- Rename indexes
ALTER INDEX IF EXISTS idx_playlist_items_playlist RENAME TO idx_music_playlist_songs_playlist;
ALTER INDEX IF EXISTS idx_playlist_items_order RENAME TO idx_music_playlist_songs_order;

-- ═══════════════════════════════════════════════════════════════════════
-- 2. Rename column: cover_image_url → image_url
-- ═══════════════════════════════════════════════════════════════════════

ALTER TABLE music_playlist_songs RENAME COLUMN cover_image_url TO image_url;

-- ═══════════════════════════════════════════════════════════════════════
-- 3. Add Spotify metadata columns
-- ═══════════════════════════════════════════════════════════════════════

ALTER TABLE music_playlist_songs
  ADD COLUMN IF NOT EXISTS external_id TEXT,
  ADD COLUMN IF NOT EXISTS external_source TEXT;

-- ═══════════════════════════════════════════════════════════════════════
-- 4. Add user_id alias to music_playlists (code sends user_id, DB has created_by)
-- ═══════════════════════════════════════════════════════════════════════

-- Drop existing NOT NULL on created_by temporarily to allow migration
-- Then add a trigger to sync user_id → created_by
DO $$
BEGIN
  -- Add user_id column that defaults to created_by
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'music_playlists' AND column_name = 'user_id'
  ) THEN
    ALTER TABLE music_playlists ADD COLUMN user_id UUID REFERENCES profiles(id) ON DELETE CASCADE;
    -- Backfill existing rows
    UPDATE music_playlists SET user_id = created_by WHERE user_id IS NULL;
  END IF;
END $$;

-- Keep created_by in sync: trigger to copy user_id → created_by on INSERT
CREATE OR REPLACE FUNCTION sync_playlist_user_id()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.user_id IS NOT NULL AND NEW.created_by IS NULL THEN
    NEW.created_by = NEW.user_id;
  END IF;
  IF NEW.created_by IS NOT NULL AND NEW.user_id IS NULL THEN
    NEW.user_id = NEW.created_by;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_sync_playlist_user_id ON music_playlists;
CREATE TRIGGER trg_sync_playlist_user_id
  BEFORE INSERT OR UPDATE ON music_playlists
  FOR EACH ROW
  EXECUTE FUNCTION sync_playlist_user_id();

-- ═══════════════════════════════════════════════════════════════════════
-- 5. Update duration trigger to reference new table name
-- ═══════════════════════════════════════════════════════════════════════

-- Drop old trigger (references playlist_items)
DROP TRIGGER IF EXISTS trg_playlist_duration ON music_playlist_songs;

-- Recreate the function to reference new table name
CREATE OR REPLACE FUNCTION update_playlist_duration()
RETURNS TRIGGER AS $$
DECLARE
  target_playlist_id UUID;
BEGIN
  target_playlist_id := COALESCE(NEW.playlist_id, OLD.playlist_id);
  UPDATE music_playlists SET
    total_duration_seconds = (
      SELECT COALESCE(SUM(duration_seconds), 0)
      FROM music_playlist_songs
      WHERE playlist_id = target_playlist_id
    ),
    updated_at = NOW()
  WHERE id = target_playlist_id;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_playlist_duration
  AFTER INSERT OR UPDATE OR DELETE ON music_playlist_songs
  FOR EACH ROW EXECUTE FUNCTION update_playlist_duration();

-- ═══════════════════════════════════════════════════════════════════════
-- 6. RLS policies are automatically renamed with the table
--    No action needed — PostgreSQL renames them with ALTER TABLE RENAME
-- ═══════════════════════════════════════════════════════════════════════
