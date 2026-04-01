-- ============================================
-- 038: Story Reports table for abuse prevention
-- ============================================
-- Instead of allowing any user to directly flag a story,
-- reports are collected in a separate table with a unique
-- constraint per user/story. Stories are only flagged when
-- the report count reaches a threshold.

CREATE TABLE IF NOT EXISTS story_reports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  story_id UUID NOT NULL REFERENCES community_stories(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(story_id, user_id)
);

-- Enable RLS
ALTER TABLE story_reports ENABLE ROW LEVEL SECURITY;

-- Users can only insert their own reports (one per story)
DO $$ BEGIN
  CREATE POLICY story_reports_insert ON story_reports
    FOR INSERT WITH CHECK (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Users can read their own reports
DO $$ BEGIN
  CREATE POLICY story_reports_select ON story_reports
    FOR SELECT USING (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Performance index
CREATE INDEX IF NOT EXISTS idx_story_reports_story ON story_reports(story_id);
CREATE INDEX IF NOT EXISTS idx_story_reports_user ON story_reports(user_id);
