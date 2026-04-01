-- 039_feature_flags.sql
-- Global feature flags table for A/B testing and gradual rollouts.
-- Read by featureFlagsStore.syncFeatureFlagsFromRemote() via: select("key, enabled")

CREATE TABLE IF NOT EXISTS public.feature_flags (
  id         UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  key        TEXT NOT NULL UNIQUE,           -- snake_case flag name (e.g. "new_onboarding_flow")
  enabled    BOOLEAN NOT NULL DEFAULT true,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- RLS: authenticated users can read, only service_role can write
ALTER TABLE public.feature_flags ENABLE ROW LEVEL SECURITY;

CREATE POLICY "feature_flags_read"
  ON public.feature_flags
  FOR SELECT
  TO authenticated
  USING (true);

-- Auto-update updated_at on changes
CREATE OR REPLACE FUNCTION update_feature_flags_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_feature_flags_updated_at
  BEFORE UPDATE ON public.feature_flags
  FOR EACH ROW
  EXECUTE FUNCTION update_feature_flags_updated_at();

-- Seed default flags (matching featureFlagsStore DEFAULT_FLAGS)
INSERT INTO public.feature_flags (key, enabled, description) VALUES
  ('new_onboarding_flow',    false, 'A/B test: new onboarding flow'),
  ('ai_scenario_suggestions', true,  'AI-powered scenario suggestions on home screen'),
  ('community_stories',      true,  'Community stories feature'),
  ('vendor_directory',       true,  'Vendor directory'),
  ('countdown_notifications', true,  'Push notification countdown reminders'),
  ('gamification_badges',    true,  'Gamification badges in profile'),
  ('budget_analytics',       true,  'Budget analytics pie chart'),
  ('time_capsule',           true,  'Time capsule feature'),
  ('qr_invites',             true,  'QR invite codes'),
  ('mood_board',             true,  'Mood board / inspiration board')
ON CONFLICT (key) DO NOTHING;
