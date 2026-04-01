-- Migration 017: Add push_token to profiles for remote push notifications
-- Depends on: 001_initial_schema.sql (profiles table)

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS push_token TEXT;

-- Index for looking up users by push token (e.g. for bulk sends)
CREATE INDEX IF NOT EXISTS idx_profiles_push_token
  ON public.profiles (push_token)
  WHERE push_token IS NOT NULL;
