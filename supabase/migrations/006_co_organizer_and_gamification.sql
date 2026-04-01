-- ============================================
-- 006: Co-Organizer System + Gamification
-- ============================================

-- Co-organizers table
CREATE TABLE IF NOT EXISTS co_organizers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  email TEXT NOT NULL,
  display_name TEXT NOT NULL DEFAULT '',
  role TEXT NOT NULL DEFAULT 'helper' CHECK (role IN ('organizer', 'helper')),
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'declined')),
  invited_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  accepted_at TIMESTAMPTZ
);

-- Add missing columns to pre-existing co_organizers table
ALTER TABLE co_organizers ADD COLUMN IF NOT EXISTS email TEXT NOT NULL DEFAULT '';
ALTER TABLE co_organizers ADD COLUMN IF NOT EXISTS display_name TEXT NOT NULL DEFAULT '';
ALTER TABLE co_organizers ADD COLUMN IF NOT EXISTS role TEXT NOT NULL DEFAULT 'helper';
ALTER TABLE co_organizers ADD COLUMN IF NOT EXISTS status TEXT NOT NULL DEFAULT 'pending';
ALTER TABLE co_organizers ADD COLUMN IF NOT EXISTS invited_at TIMESTAMPTZ NOT NULL DEFAULT NOW();
ALTER TABLE co_organizers ADD COLUMN IF NOT EXISTS accepted_at TIMESTAMPTZ;

CREATE INDEX IF NOT EXISTS idx_co_organizers_plan ON co_organizers(plan_id);
CREATE INDEX IF NOT EXISTS idx_co_organizers_user ON co_organizers(user_id);
CREATE INDEX IF NOT EXISTS idx_co_organizers_email ON co_organizers(email);

-- Plan messages (private chat for co-organizers)
CREATE TABLE IF NOT EXISTS plan_messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
  sender_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  message TEXT NOT NULL,
  message_type TEXT NOT NULL DEFAULT 'text' CHECK (message_type IN ('text', 'image', 'system')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_plan_messages_plan ON plan_messages(plan_id);
CREATE INDEX IF NOT EXISTS idx_plan_messages_created ON plan_messages(plan_id, created_at DESC);

-- Task assignments
CREATE TABLE IF NOT EXISTS task_assignments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
  checklist_item_id UUID NOT NULL REFERENCES plan_checklist_items(id) ON DELETE CASCADE,
  assigned_to UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  assigned_by UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'completed')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_task_assignments_plan ON task_assignments(plan_id);
CREATE INDEX IF NOT EXISTS idx_task_assignments_user ON task_assignments(assigned_to);

-- Invite links for co-organizer access
CREATE TABLE IF NOT EXISTS invite_links (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
  code TEXT NOT NULL UNIQUE,
  created_by UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  max_uses INT NOT NULL DEFAULT 5,
  use_count INT NOT NULL DEFAULT 0,
  expires_at TIMESTAMPTZ NOT NULL DEFAULT (NOW() + INTERVAL '7 days'),
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_invite_links_code ON invite_links(code);

-- ============================================
-- Gamification tables
-- ============================================

-- User gamification progress
CREATE TABLE IF NOT EXISTS user_gamification (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE REFERENCES profiles(id) ON DELETE CASCADE,
  level INT NOT NULL DEFAULT 1,
  xp INT NOT NULL DEFAULT 0,
  total_xp INT NOT NULL DEFAULT 0,
  streak INT NOT NULL DEFAULT 0,
  longest_streak INT NOT NULL DEFAULT 0,
  last_active_date DATE,
  total_plans INT NOT NULL DEFAULT 0,
  completed_plans INT NOT NULL DEFAULT 0,
  total_surprises INT NOT NULL DEFAULT 0,
  ai_used INT NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_user_gamification_user ON user_gamification(user_id);
CREATE INDEX IF NOT EXISTS idx_user_gamification_xp ON user_gamification(total_xp DESC);

-- User badges
CREATE TABLE IF NOT EXISTS user_badges (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  badge_slug TEXT NOT NULL,
  unlocked_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (user_id, badge_slug)
);

CREATE INDEX IF NOT EXISTS idx_user_badges_user ON user_badges(user_id);

-- XP history (for activity feed)
CREATE TABLE IF NOT EXISTS xp_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  amount INT NOT NULL,
  reason TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_xp_history_user ON xp_history(user_id);

-- ============================================
-- Budget tracking table
-- ============================================

CREATE TABLE IF NOT EXISTS plan_expenses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  amount DECIMAL(10,2) NOT NULL DEFAULT 0,
  category TEXT NOT NULL DEFAULT 'other' CHECK (category IN ('gift', 'food', 'decoration', 'venue', 'entertainment', 'transport', 'other')),
  is_paid BOOLEAN NOT NULL DEFAULT FALSE,
  paid_by UUID REFERENCES profiles(id),
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_plan_expenses_plan ON plan_expenses(plan_id);

-- ============================================
-- Important dates table
-- ============================================

CREATE TABLE IF NOT EXISTS important_dates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  person_name TEXT NOT NULL,
  date_month INT NOT NULL CHECK (date_month BETWEEN 1 AND 12),
  date_day INT NOT NULL CHECK (date_day BETWEEN 1 AND 31),
  date_type TEXT NOT NULL DEFAULT 'birthday' CHECK (date_type IN ('birthday', 'anniversary', 'graduation', 'other')),
  notes TEXT,
  notify_days_before INT NOT NULL DEFAULT 7,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_important_dates_user ON important_dates(user_id);
CREATE INDEX IF NOT EXISTS idx_important_dates_month ON important_dates(date_month, date_day);

-- ============================================
-- Photo album table
-- ============================================

CREATE TABLE IF NOT EXISTS plan_photos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
  uploaded_by UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  image_url TEXT NOT NULL,
  caption TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_plan_photos_plan ON plan_photos(plan_id);

-- ============================================
-- RLS Policies
-- ============================================

ALTER TABLE co_organizers ENABLE ROW LEVEL SECURITY;
ALTER TABLE plan_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE task_assignments ENABLE ROW LEVEL SECURITY;
ALTER TABLE invite_links ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_gamification ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_badges ENABLE ROW LEVEL SECURITY;
ALTER TABLE xp_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE plan_expenses ENABLE ROW LEVEL SECURITY;
ALTER TABLE important_dates ENABLE ROW LEVEL SECURITY;
ALTER TABLE plan_photos ENABLE ROW LEVEL SECURITY;

-- Users can see co-organizers for plans they're part of
DO $$ BEGIN CREATE POLICY co_organizers_select ON co_organizers FOR SELECT USING (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()) OR user_id = auth.uid()); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE POLICY co_organizers_insert ON co_organizers FOR INSERT WITH CHECK (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())); EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- Messages visible to plan members
DO $$ BEGIN CREATE POLICY plan_messages_select ON plan_messages FOR SELECT USING (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()) OR plan_id IN (SELECT plan_id FROM co_organizers WHERE user_id = auth.uid() AND status = 'accepted')); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE POLICY plan_messages_insert ON plan_messages FOR INSERT WITH CHECK (sender_id = auth.uid()); EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- Gamification: users can only see/edit their own
DO $$ BEGIN CREATE POLICY user_gamification_select ON user_gamification FOR SELECT USING (user_id = auth.uid()); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE POLICY user_gamification_all ON user_gamification FOR ALL USING (user_id = auth.uid()); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE POLICY user_badges_select ON user_badges FOR SELECT USING (user_id = auth.uid()); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE POLICY xp_history_select ON xp_history FOR SELECT USING (user_id = auth.uid()); EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- Expenses visible to plan owner + co-organizers
DO $$ BEGIN CREATE POLICY plan_expenses_select ON plan_expenses FOR SELECT USING (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()) OR plan_id IN (SELECT plan_id FROM co_organizers WHERE user_id = auth.uid() AND status = 'accepted')); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE POLICY plan_expenses_insert ON plan_expenses FOR INSERT WITH CHECK (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()) OR plan_id IN (SELECT plan_id FROM co_organizers WHERE user_id = auth.uid() AND status = 'accepted')); EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- Important dates: user own data
DO $$ BEGIN CREATE POLICY important_dates_all ON important_dates FOR ALL USING (user_id = auth.uid()); EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- Photos: plan members
DO $$ BEGIN CREATE POLICY plan_photos_select ON plan_photos FOR SELECT USING (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()) OR plan_id IN (SELECT plan_id FROM co_organizers WHERE user_id = auth.uid() AND status = 'accepted')); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE POLICY plan_photos_insert ON plan_photos FOR INSERT WITH CHECK (uploaded_by = auth.uid()); EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- ============================================
-- Functions
-- ============================================

-- Add XP to user
CREATE OR REPLACE FUNCTION add_user_xp(p_user_id UUID, p_amount INT, p_reason TEXT)
RETURNS void AS $$
BEGIN
  INSERT INTO user_gamification (user_id, xp, total_xp)
  VALUES (p_user_id, p_amount, p_amount)
  ON CONFLICT (user_id) DO UPDATE SET
    xp = user_gamification.xp + p_amount,
    total_xp = user_gamification.total_xp + p_amount,
    updated_at = NOW();

  INSERT INTO xp_history (user_id, amount, reason)
  VALUES (p_user_id, p_amount, p_reason);

  -- Update level based on total XP
  UPDATE user_gamification SET level = CASE
    WHEN total_xp >= 9000 THEN 10
    WHEN total_xp >= 6000 THEN 9
    WHEN total_xp >= 4000 THEN 8
    WHEN total_xp >= 2500 THEN 7
    WHEN total_xp >= 1500 THEN 6
    WHEN total_xp >= 1000 THEN 5
    WHEN total_xp >= 600 THEN 4
    WHEN total_xp >= 300 THEN 3
    WHEN total_xp >= 100 THEN 2
    ELSE 1
  END
  WHERE user_id = p_user_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
