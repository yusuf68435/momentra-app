-- ============================================================
-- Migration 012: Milestone Metrics
-- Replace streak-based gamification with milestone-based metrics
-- ============================================================

-- Add unique_recipients column to user_gamification
ALTER TABLE user_gamification
  ADD COLUMN IF NOT EXISTS unique_recipients INT DEFAULT 0;

-- RPC function to compute unique recipients from completed plans
CREATE OR REPLACE FUNCTION compute_unique_recipients(p_user_id UUID)
RETURNS INT
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_count INT;
BEGIN
  SELECT COUNT(DISTINCT recipient_name)
  INTO v_count
  FROM plans
  WHERE user_id = p_user_id
    AND status = 'completed'
    AND recipient_name IS NOT NULL
    AND recipient_name != '';

  -- Update the gamification record
  UPDATE user_gamification
  SET unique_recipients = v_count
  WHERE user_id = p_user_id;

  RETURN v_count;
END;
$$;

-- Backfill unique_recipients for all existing users
DO $$
DECLARE
  r RECORD;
BEGIN
  FOR r IN SELECT DISTINCT user_id FROM user_gamification LOOP
    PERFORM compute_unique_recipients(r.user_id);
  END LOOP;
END;
$$;
