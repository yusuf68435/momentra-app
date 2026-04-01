-- ============================================================
-- Migration 013: Post-Surprise Experience
-- Add completion data fields to plans table
-- ============================================================

ALTER TABLE plans
  ADD COLUMN IF NOT EXISTS completion_rating INT CHECK (completion_rating BETWEEN 1 AND 5),
  ADD COLUMN IF NOT EXISTS completion_notes TEXT,
  ADD COLUMN IF NOT EXISTS completion_photos TEXT[] DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS completion_data JSONB DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS completed_at TIMESTAMPTZ;
