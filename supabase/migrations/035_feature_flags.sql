-- Migration 035: Global feature flags table
-- Allows remote A/B testing and gradual feature rollouts.

CREATE TABLE IF NOT EXISTS feature_flags (
  key         TEXT PRIMARY KEY,
  enabled     BOOLEAN NOT NULL DEFAULT false,
  description TEXT,
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Seed default flags (all production features enabled, A/B tests off)
INSERT INTO feature_flags (key, enabled, description) VALUES
  ('new_onboarding_flow',      false, 'A/B test: new onboarding flow'),
  ('ai_scenario_suggestions',  true,  'AI-powered home screen suggestions'),
  ('community_stories',        true,  'Community stories tab'),
  ('vendor_directory',         true,  'Vendor directory'),
  ('countdown_notifications',  true,  'Countdown push reminders'),
  ('gamification_badges',      true,  'Gamification badges in profile'),
  ('budget_analytics',         true,  'Budget pie chart analytics'),
  ('time_capsule',             true,  'Time capsule feature'),
  ('qr_invites',               true,  'QR invite codes'),
  ('mood_board',               true,  'Mood board / inspiration board')
ON CONFLICT (key) DO NOTHING;

-- RLS: public read (feature flags are global, not user-specific)
ALTER TABLE feature_flags ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  CREATE POLICY "feature_flags_read_all" ON feature_flags
    FOR SELECT USING (true);
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Only service_role can mutate flags
DO $$ BEGIN
  CREATE POLICY "feature_flags_service_write" ON feature_flags
    FOR ALL USING (auth.role() = 'service_role');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
