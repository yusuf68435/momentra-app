-- =============================================
-- 011: World-Class Features Migration
-- Enable pgcrypto for gen_random_bytes()
CREATE EXTENSION IF NOT EXISTS pgcrypto;
-- Weather, Timelines, Mood Boards, RSVP, Recurring Events,
-- Gift Suggestions, Backup Plans, Music Playlists,
-- Community Stories, Vendor Directory, Voice Notes,
-- Secret Messages, Emoji Reactions, Time Capsules,
-- Smart Notifications
-- =============================================

-- ==========================================
-- ENUM TYPES
-- ==========================================

DO $$ BEGIN CREATE TYPE rsvp_status AS ENUM ('pending', 'accepted', 'declined', 'maybe'); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TYPE vendor_type AS ENUM ('florist', 'restaurant', 'photographer', 'baker', 'decorator', 'musician', 'caterer', 'venue', 'entertainer', 'other'); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TYPE story_status AS ENUM ('draft', 'pending_review', 'published', 'rejected', 'archived'); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TYPE recurrence_type AS ENUM ('yearly', 'monthly', 'custom'); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TYPE notification_channel AS ENUM ('push', 'email', 'sms', 'in_app'); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TYPE timeline_item_status AS ENUM ('pending', 'in_progress', 'completed', 'skipped'); EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- ==========================================
-- 1. WEATHER CACHE
-- ==========================================

CREATE TABLE IF NOT EXISTS weather_cache (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
  location_lat NUMERIC(10,7),
  location_lng NUMERIC(10,7),
  location_name TEXT,
  forecast_date DATE NOT NULL,
  temperature_high NUMERIC(5,1),
  temperature_low NUMERIC(5,1),
  condition TEXT,
  condition_icon TEXT,
  precipitation_chance INT CHECK (precipitation_chance BETWEEN 0 AND 100),
  humidity INT CHECK (humidity BETWEEN 0 AND 100),
  wind_speed NUMERIC(6,1),
  raw_data JSONB DEFAULT '{}',
  fetched_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_weather_cache_plan ON weather_cache(plan_id);
CREATE INDEX IF NOT EXISTS idx_weather_cache_date ON weather_cache(forecast_date);
CREATE UNIQUE INDEX IF NOT EXISTS idx_weather_cache_plan_date ON weather_cache(plan_id, forecast_date);

ALTER TABLE weather_cache ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
CREATE POLICY "Users can view weather for own plans"
  ON weather_cache FOR SELECT
  USING (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()));
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can insert weather for own plans"
  ON weather_cache FOR INSERT
  WITH CHECK (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()));
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can update weather for own plans"
  ON weather_cache FOR UPDATE
  USING (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()));
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can delete weather for own plans"
  ON weather_cache FOR DELETE
  USING (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()));
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ==========================================
-- 2. SMART TIMELINES
-- ==========================================

CREATE TABLE IF NOT EXISTS smart_timeline_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  due_at TIMESTAMPTZ NOT NULL,
  status timeline_item_status NOT NULL DEFAULT 'pending',
  is_auto_generated BOOLEAN NOT NULL DEFAULT TRUE,
  category TEXT DEFAULT 'general',
  priority INT NOT NULL DEFAULT 0 CHECK (priority BETWEEN 0 AND 5),
  depends_on UUID REFERENCES smart_timeline_items(id) ON DELETE SET NULL,
  assigned_to UUID REFERENCES profiles(id) ON DELETE SET NULL,
  completed_at TIMESTAMPTZ,
  reminder_sent BOOLEAN NOT NULL DEFAULT FALSE,
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_timeline_plan ON smart_timeline_items(plan_id);
CREATE INDEX IF NOT EXISTS idx_timeline_due ON smart_timeline_items(due_at);
CREATE INDEX IF NOT EXISTS idx_timeline_status ON smart_timeline_items(plan_id, status);
CREATE INDEX IF NOT EXISTS idx_timeline_assigned ON smart_timeline_items(assigned_to) WHERE assigned_to IS NOT NULL;

ALTER TABLE smart_timeline_items ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
CREATE POLICY "Plan members can view timeline"
  ON smart_timeline_items FOR SELECT
  USING (
    plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
    OR plan_id IN (SELECT plan_id FROM co_organizers WHERE user_id = auth.uid() AND status = 'accepted')
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan owner can manage timeline"
  ON smart_timeline_items FOR INSERT
  WITH CHECK (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()));
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan owner can update timeline"
  ON smart_timeline_items FOR UPDATE
  USING (
    plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
    OR plan_id IN (SELECT plan_id FROM co_organizers WHERE user_id = auth.uid() AND status = 'accepted')
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan owner can delete timeline"
  ON smart_timeline_items FOR DELETE
  USING (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()));
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ==========================================
-- 3. MOOD BOARDS
-- ==========================================

CREATE TABLE IF NOT EXISTS mood_boards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
  title TEXT NOT NULL DEFAULT 'Inspiration Board',
  description TEXT,
  is_default BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_mood_boards_plan ON mood_boards(plan_id);

CREATE TABLE IF NOT EXISTS mood_board_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  board_id UUID NOT NULL REFERENCES mood_boards(id) ON DELETE CASCADE,
  image_url TEXT NOT NULL,
  thumbnail_url TEXT,
  caption TEXT,
  source_url TEXT,
  color_palette JSONB DEFAULT '[]',
  tags TEXT[] DEFAULT '{}',
  position_x NUMERIC(6,2) DEFAULT 0,
  position_y NUMERIC(6,2) DEFAULT 0,
  width NUMERIC(6,2) DEFAULT 200,
  height NUMERIC(6,2) DEFAULT 200,
  sort_order INT DEFAULT 0,
  added_by UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_mood_board_items_board ON mood_board_items(board_id);
CREATE INDEX IF NOT EXISTS idx_mood_board_items_tags ON mood_board_items USING GIN(tags);

ALTER TABLE mood_boards ENABLE ROW LEVEL SECURITY;
ALTER TABLE mood_board_items ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
CREATE POLICY "Plan members can view mood boards"
  ON mood_boards FOR SELECT
  USING (
    plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
    OR plan_id IN (SELECT plan_id FROM co_organizers WHERE user_id = auth.uid() AND status = 'accepted')
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan owner can manage mood boards"
  ON mood_boards FOR ALL
  USING (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()));
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan members can view mood board items"
  ON mood_board_items FOR SELECT
  USING (
    board_id IN (
      SELECT mb.id FROM mood_boards mb
      JOIN plans p ON p.id = mb.plan_id
      WHERE p.user_id = auth.uid()
    )
    OR board_id IN (
      SELECT mb.id FROM mood_boards mb
      JOIN co_organizers co ON co.plan_id = mb.plan_id
      WHERE co.user_id = auth.uid() AND co.status = 'accepted'
    )
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan members can add mood board items"
  ON mood_board_items FOR INSERT
  WITH CHECK (added_by = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can delete own mood board items"
  ON mood_board_items FOR DELETE
  USING (added_by = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ==========================================
-- 4. GUEST RSVP
-- ==========================================

CREATE TABLE IF NOT EXISTS guest_invitations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
  guest_name TEXT NOT NULL,
  guest_email TEXT,
  guest_phone TEXT,
  rsvp_status rsvp_status NOT NULL DEFAULT 'pending',
  rsvp_token TEXT UNIQUE DEFAULT encode(extensions.gen_random_bytes(32), 'hex'),
  plus_one BOOLEAN NOT NULL DEFAULT FALSE,
  plus_one_name TEXT,
  dietary_restrictions TEXT,
  notes TEXT,
  group_name TEXT,
  table_number INT,
  invited_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  responded_at TIMESTAMPTZ,
  reminder_sent_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_guest_invitations_plan ON guest_invitations(plan_id);
CREATE INDEX IF NOT EXISTS idx_guest_invitations_rsvp ON guest_invitations(plan_id, rsvp_status);
CREATE INDEX IF NOT EXISTS idx_guest_invitations_token ON guest_invitations(rsvp_token);
CREATE INDEX IF NOT EXISTS idx_guest_invitations_email ON guest_invitations(guest_email) WHERE guest_email IS NOT NULL;

ALTER TABLE guest_invitations ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
CREATE POLICY "Plan members can view guests"
  ON guest_invitations FOR SELECT
  USING (
    plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
    OR plan_id IN (SELECT plan_id FROM co_organizers WHERE user_id = auth.uid() AND status = 'accepted')
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan owner can manage guests"
  ON guest_invitations FOR INSERT
  WITH CHECK (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()));
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan owner can update guests"
  ON guest_invitations FOR UPDATE
  USING (
    plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
    OR plan_id IN (SELECT plan_id FROM co_organizers WHERE user_id = auth.uid() AND status = 'accepted')
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan owner can delete guests"
  ON guest_invitations FOR DELETE
  USING (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()));
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ==========================================
-- 5. RECURRING EVENTS
-- ==========================================

CREATE TABLE IF NOT EXISTS recurring_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  recurrence recurrence_type NOT NULL DEFAULT 'yearly',
  month INT CHECK (month BETWEEN 1 AND 12),
  day INT CHECK (day BETWEEN 1 AND 31),
  original_year INT,
  recipient_name TEXT,
  recipient_relation TEXT,
  category TEXT DEFAULT 'birthday' CHECK (category IN ('birthday', 'anniversary', 'holiday', 'graduation', 'memorial', 'other')),
  auto_create_plan BOOLEAN NOT NULL DEFAULT FALSE,
  default_scenario_id UUID REFERENCES scenarios(id) ON DELETE SET NULL,
  default_budget NUMERIC(10,2),
  notify_days_before INT[] DEFAULT '{30, 14, 7, 1}',
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  last_triggered_at TIMESTAMPTZ,
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_recurring_events_user ON recurring_events(user_id);
CREATE INDEX IF NOT EXISTS idx_recurring_events_month_day ON recurring_events(month, day);
CREATE INDEX IF NOT EXISTS idx_recurring_events_active ON recurring_events(user_id, is_active) WHERE is_active = TRUE;

ALTER TABLE recurring_events ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
CREATE POLICY "Users manage own recurring events"
  ON recurring_events FOR ALL
  USING (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ==========================================
-- 6. GIFT SUGGESTIONS
-- ==========================================

CREATE TABLE IF NOT EXISTS gift_suggestions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  price_min NUMERIC(10,2),
  price_max NUMERIC(10,2),
  currency TEXT DEFAULT 'TRY',
  purchase_url TEXT,
  image_url TEXT,
  category TEXT DEFAULT 'general',
  tags TEXT[] DEFAULT '{}',
  is_ai_generated BOOLEAN NOT NULL DEFAULT TRUE,
  is_selected BOOLEAN NOT NULL DEFAULT FALSE,
  is_purchased BOOLEAN NOT NULL DEFAULT FALSE,
  purchased_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
  rating INT CHECK (rating BETWEEN 1 AND 5),
  relevance_score NUMERIC(3,2) DEFAULT 0,
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_gift_suggestions_plan ON gift_suggestions(plan_id);
CREATE INDEX IF NOT EXISTS idx_gift_suggestions_selected ON gift_suggestions(plan_id, is_selected) WHERE is_selected = TRUE;
CREATE INDEX IF NOT EXISTS idx_gift_suggestions_tags ON gift_suggestions USING GIN(tags);
CREATE INDEX IF NOT EXISTS idx_gift_suggestions_price ON gift_suggestions(price_min, price_max);

ALTER TABLE gift_suggestions ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
CREATE POLICY "Plan members can view gifts"
  ON gift_suggestions FOR SELECT
  USING (
    plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
    OR plan_id IN (SELECT plan_id FROM co_organizers WHERE user_id = auth.uid() AND status = 'accepted')
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan owner can manage gifts"
  ON gift_suggestions FOR INSERT
  WITH CHECK (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()));
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan members can update gifts"
  ON gift_suggestions FOR UPDATE
  USING (
    plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
    OR plan_id IN (SELECT plan_id FROM co_organizers WHERE user_id = auth.uid() AND status = 'accepted')
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan owner can delete gifts"
  ON gift_suggestions FOR DELETE
  USING (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()));
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ==========================================
-- 7. BACKUP PLANS
-- ==========================================

CREATE TABLE IF NOT EXISTS backup_plans (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  trigger_condition TEXT NOT NULL,
  alternative_location TEXT,
  alternative_date DATE,
  alternative_time TIME,
  alternative_budget NUMERIC(10,2),
  priority INT NOT NULL DEFAULT 1 CHECK (priority BETWEEN 1 AND 5),
  is_activated BOOLEAN NOT NULL DEFAULT FALSE,
  activated_at TIMESTAMPTZ,
  notes TEXT,
  checklist JSONB DEFAULT '[]',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_backup_plans_plan ON backup_plans(plan_id);
CREATE INDEX IF NOT EXISTS idx_backup_plans_priority ON backup_plans(plan_id, priority);

ALTER TABLE backup_plans ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
CREATE POLICY "Plan members can view backup plans"
  ON backup_plans FOR SELECT
  USING (
    plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
    OR plan_id IN (SELECT plan_id FROM co_organizers WHERE user_id = auth.uid() AND status = 'accepted')
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan owner can manage backup plans"
  ON backup_plans FOR ALL
  USING (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()));
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ==========================================
-- 8. MUSIC PLAYLISTS
-- ==========================================

CREATE TABLE IF NOT EXISTS music_playlists (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
  title TEXT NOT NULL DEFAULT 'Event Playlist',
  description TEXT,
  external_playlist_url TEXT,
  total_duration_seconds INT DEFAULT 0,
  is_default BOOLEAN NOT NULL DEFAULT FALSE,
  created_by UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_music_playlists_plan ON music_playlists(plan_id);

CREATE TABLE IF NOT EXISTS playlist_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  playlist_id UUID NOT NULL REFERENCES music_playlists(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  artist TEXT,
  album TEXT,
  duration_seconds INT,
  external_url TEXT,
  preview_url TEXT,
  cover_image_url TEXT,
  sort_order INT DEFAULT 0,
  added_by UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_playlist_items_playlist ON playlist_items(playlist_id);
CREATE INDEX IF NOT EXISTS idx_playlist_items_order ON playlist_items(playlist_id, sort_order);

ALTER TABLE music_playlists ENABLE ROW LEVEL SECURITY;
ALTER TABLE playlist_items ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
CREATE POLICY "Plan members can view playlists"
  ON music_playlists FOR SELECT
  USING (
    plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
    OR plan_id IN (SELECT plan_id FROM co_organizers WHERE user_id = auth.uid() AND status = 'accepted')
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan owner can manage playlists"
  ON music_playlists FOR ALL
  USING (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()));
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan members can view playlist items"
  ON playlist_items FOR SELECT
  USING (
    playlist_id IN (
      SELECT mp.id FROM music_playlists mp
      JOIN plans p ON p.id = mp.plan_id
      WHERE p.user_id = auth.uid()
    )
    OR playlist_id IN (
      SELECT mp.id FROM music_playlists mp
      JOIN co_organizers co ON co.plan_id = mp.plan_id
      WHERE co.user_id = auth.uid() AND co.status = 'accepted'
    )
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan members can add playlist items"
  ON playlist_items FOR INSERT
  WITH CHECK (added_by = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can delete own playlist items"
  ON playlist_items FOR DELETE
  USING (added_by = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ==========================================
-- 9. COMMUNITY STORIES
-- ==========================================

CREATE TABLE IF NOT EXISTS community_stories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  author_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  plan_id UUID REFERENCES plans(id) ON DELETE SET NULL,
  scenario_id UUID REFERENCES scenarios(id) ON DELETE SET NULL,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  cover_image_url TEXT,
  photos TEXT[] DEFAULT '{}',
  tags TEXT[] DEFAULT '{}',
  status story_status NOT NULL DEFAULT 'draft',
  is_anonymous BOOLEAN NOT NULL DEFAULT FALSE,
  is_featured BOOLEAN NOT NULL DEFAULT FALSE,
  like_count INT NOT NULL DEFAULT 0,
  comment_count INT NOT NULL DEFAULT 0,
  view_count INT NOT NULL DEFAULT 0,
  language TEXT DEFAULT 'tr' CHECK (language IN ('tr', 'en')),
  published_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Add missing columns to pre-existing community_stories table
ALTER TABLE community_stories ADD COLUMN IF NOT EXISTS author_id UUID REFERENCES profiles(id) ON DELETE CASCADE;
ALTER TABLE community_stories ADD COLUMN IF NOT EXISTS plan_id UUID REFERENCES plans(id) ON DELETE SET NULL;
ALTER TABLE community_stories ADD COLUMN IF NOT EXISTS scenario_id UUID REFERENCES scenarios(id) ON DELETE SET NULL;
ALTER TABLE community_stories ADD COLUMN IF NOT EXISTS cover_image_url TEXT;
ALTER TABLE community_stories ADD COLUMN IF NOT EXISTS photos TEXT[] DEFAULT '{}';
ALTER TABLE community_stories ADD COLUMN IF NOT EXISTS tags TEXT[] DEFAULT '{}';
ALTER TABLE community_stories ADD COLUMN IF NOT EXISTS status TEXT NOT NULL DEFAULT 'draft';
ALTER TABLE community_stories ADD COLUMN IF NOT EXISTS is_anonymous BOOLEAN NOT NULL DEFAULT FALSE;
ALTER TABLE community_stories ADD COLUMN IF NOT EXISTS is_featured BOOLEAN NOT NULL DEFAULT FALSE;
ALTER TABLE community_stories ADD COLUMN IF NOT EXISTS like_count INT NOT NULL DEFAULT 0;
ALTER TABLE community_stories ADD COLUMN IF NOT EXISTS comment_count INT NOT NULL DEFAULT 0;
ALTER TABLE community_stories ADD COLUMN IF NOT EXISTS view_count INT NOT NULL DEFAULT 0;
ALTER TABLE community_stories ADD COLUMN IF NOT EXISTS language TEXT DEFAULT 'tr';
ALTER TABLE community_stories ADD COLUMN IF NOT EXISTS published_at TIMESTAMPTZ;
ALTER TABLE community_stories ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW();
-- Backfill author_id from user_id if that column exists
DO $$ BEGIN
  UPDATE community_stories SET author_id = user_id WHERE author_id IS NULL;
EXCEPTION WHEN undefined_column THEN NULL;
END $$;

CREATE INDEX IF NOT EXISTS idx_community_stories_author ON community_stories(author_id);
CREATE INDEX IF NOT EXISTS idx_community_stories_status ON community_stories(status);
CREATE INDEX IF NOT EXISTS idx_community_stories_published ON community_stories(published_at DESC) WHERE status = 'published';
CREATE INDEX IF NOT EXISTS idx_community_stories_featured ON community_stories(is_featured) WHERE is_featured = TRUE;
CREATE INDEX IF NOT EXISTS idx_community_stories_tags ON community_stories USING GIN(tags);
CREATE INDEX IF NOT EXISTS idx_community_stories_scenario ON community_stories(scenario_id) WHERE scenario_id IS NOT NULL;

CREATE TABLE IF NOT EXISTS story_likes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  story_id UUID NOT NULL REFERENCES community_stories(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(story_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_story_likes_story ON story_likes(story_id);
CREATE INDEX IF NOT EXISTS idx_story_likes_user ON story_likes(user_id);

CREATE TABLE IF NOT EXISTS story_comments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  story_id UUID NOT NULL REFERENCES community_stories(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  parent_comment_id UUID REFERENCES story_comments(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  is_edited BOOLEAN NOT NULL DEFAULT FALSE,
  like_count INT NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Add missing columns to pre-existing story_comments table
ALTER TABLE story_comments ADD COLUMN IF NOT EXISTS parent_comment_id UUID REFERENCES story_comments(id) ON DELETE CASCADE;
ALTER TABLE story_comments ADD COLUMN IF NOT EXISTS is_edited BOOLEAN NOT NULL DEFAULT FALSE;
ALTER TABLE story_comments ADD COLUMN IF NOT EXISTS like_count INT NOT NULL DEFAULT 0;
ALTER TABLE story_comments ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW();

CREATE INDEX IF NOT EXISTS idx_story_comments_story ON story_comments(story_id);
CREATE INDEX IF NOT EXISTS idx_story_comments_parent ON story_comments(parent_comment_id) WHERE parent_comment_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_story_comments_user ON story_comments(user_id);

ALTER TABLE community_stories ENABLE ROW LEVEL SECURITY;
ALTER TABLE story_likes ENABLE ROW LEVEL SECURITY;
ALTER TABLE story_comments ENABLE ROW LEVEL SECURITY;

-- Anyone can read published stories
DO $$ BEGIN
CREATE POLICY "Anyone can view published stories"
  ON community_stories FOR SELECT
  USING (status = 'published' OR author_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can insert own stories"
  ON community_stories FOR INSERT
  WITH CHECK (author_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can update own stories"
  ON community_stories FOR UPDATE
  USING (author_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can delete own stories"
  ON community_stories FOR DELETE
  USING (author_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Likes
DO $$ BEGIN
CREATE POLICY "Anyone can view story likes"
  ON story_likes FOR SELECT
  USING (TRUE);
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can manage own likes"
  ON story_likes FOR INSERT
  WITH CHECK (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can remove own likes"
  ON story_likes FOR DELETE
  USING (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Comments
DO $$ BEGIN
CREATE POLICY "Anyone can view story comments"
  ON story_comments FOR SELECT
  USING (TRUE);
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can add comments"
  ON story_comments FOR INSERT
  WITH CHECK (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can update own comments"
  ON story_comments FOR UPDATE
  USING (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can delete own comments"
  ON story_comments FOR DELETE
  USING (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ==========================================
-- 10. VENDOR DIRECTORY
-- ==========================================

CREATE TABLE IF NOT EXISTS vendors (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  vendor_type vendor_type NOT NULL,
  description TEXT,
  phone TEXT,
  email TEXT,
  website_url TEXT,
  instagram_url TEXT,
  address TEXT,
  city TEXT NOT NULL,
  district TEXT,
  location_lat NUMERIC(10,7),
  location_lng NUMERIC(10,7),
  price_range INT CHECK (price_range BETWEEN 1 AND 4),
  rating_avg NUMERIC(3,2) DEFAULT 0,
  rating_count INT DEFAULT 0,
  cover_image_url TEXT,
  photos TEXT[] DEFAULT '{}',
  tags TEXT[] DEFAULT '{}',
  working_hours JSONB DEFAULT '{}',
  is_verified BOOLEAN NOT NULL DEFAULT FALSE,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  added_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_vendors_type ON vendors(vendor_type);
CREATE INDEX IF NOT EXISTS idx_vendors_city ON vendors(city);
CREATE INDEX IF NOT EXISTS idx_vendors_city_type ON vendors(city, vendor_type);
CREATE INDEX IF NOT EXISTS idx_vendors_rating ON vendors(rating_avg DESC);
CREATE INDEX IF NOT EXISTS idx_vendors_tags ON vendors USING GIN(tags);
CREATE INDEX IF NOT EXISTS idx_vendors_active ON vendors(is_active) WHERE is_active = TRUE;

CREATE TABLE IF NOT EXISTS vendor_reviews (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  vendor_id UUID NOT NULL REFERENCES vendors(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  plan_id UUID REFERENCES plans(id) ON DELETE SET NULL,
  rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment TEXT,
  photos TEXT[] DEFAULT '{}',
  is_verified_purchase BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(vendor_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_vendor_reviews_vendor ON vendor_reviews(vendor_id);
CREATE INDEX IF NOT EXISTS idx_vendor_reviews_user ON vendor_reviews(user_id);

-- Plan-vendor bookings
CREATE TABLE IF NOT EXISTS plan_vendor_bookings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
  vendor_id UUID NOT NULL REFERENCES vendors(id) ON DELETE CASCADE,
  status TEXT NOT NULL DEFAULT 'inquiry' CHECK (status IN ('inquiry', 'quoted', 'booked', 'completed', 'cancelled')),
  quoted_price NUMERIC(10,2),
  notes TEXT,
  booked_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_plan_vendor_bookings_plan ON plan_vendor_bookings(plan_id);
CREATE INDEX IF NOT EXISTS idx_plan_vendor_bookings_vendor ON plan_vendor_bookings(vendor_id);

ALTER TABLE vendors ENABLE ROW LEVEL SECURITY;
ALTER TABLE vendor_reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE plan_vendor_bookings ENABLE ROW LEVEL SECURITY;

-- Anyone can view active vendors
DO $$ BEGIN
CREATE POLICY "Anyone can view active vendors"
  ON vendors FOR SELECT
  USING (is_active = TRUE);
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Authenticated users can add vendors"
  ON vendors FOR INSERT
  WITH CHECK (auth.uid() IS NOT NULL);
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Vendor reviews
DO $$ BEGIN
CREATE POLICY "Anyone can view vendor reviews"
  ON vendor_reviews FOR SELECT
  USING (TRUE);
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can manage own vendor reviews"
  ON vendor_reviews FOR INSERT
  WITH CHECK (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can update own vendor reviews"
  ON vendor_reviews FOR UPDATE
  USING (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can delete own vendor reviews"
  ON vendor_reviews FOR DELETE
  USING (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Vendor bookings
DO $$ BEGIN
CREATE POLICY "Plan owner can view bookings"
  ON plan_vendor_bookings FOR SELECT
  USING (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()));
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan owner can manage bookings"
  ON plan_vendor_bookings FOR ALL
  USING (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()));
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ==========================================
-- 11. VOICE NOTES
-- ==========================================

CREATE TABLE IF NOT EXISTS voice_notes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  audio_url TEXT NOT NULL,
  duration_seconds INT NOT NULL DEFAULT 0,
  transcript TEXT,
  is_transcribed BOOLEAN NOT NULL DEFAULT FALSE,
  file_size_bytes INT,
  mime_type TEXT DEFAULT 'audio/m4a',
  title TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_voice_notes_plan ON voice_notes(plan_id);
CREATE INDEX IF NOT EXISTS idx_voice_notes_user ON voice_notes(user_id);

ALTER TABLE voice_notes ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
CREATE POLICY "Plan members can view voice notes"
  ON voice_notes FOR SELECT
  USING (
    plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
    OR plan_id IN (SELECT plan_id FROM co_organizers WHERE user_id = auth.uid() AND status = 'accepted')
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can add own voice notes"
  ON voice_notes FOR INSERT
  WITH CHECK (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can update own voice notes"
  ON voice_notes FOR UPDATE
  USING (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can delete own voice notes"
  ON voice_notes FOR DELETE
  USING (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ==========================================
-- 12. SECRET MESSAGES
-- ==========================================

CREATE TABLE IF NOT EXISTS secret_messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
  sender_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  recipient_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  encrypted_content TEXT NOT NULL,
  encryption_iv TEXT,
  is_read BOOLEAN NOT NULL DEFAULT FALSE,
  read_at TIMESTAMPTZ,
  self_destruct BOOLEAN NOT NULL DEFAULT FALSE,
  self_destruct_after INTERVAL,
  expires_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_secret_messages_plan ON secret_messages(plan_id);
CREATE INDEX IF NOT EXISTS idx_secret_messages_sender ON secret_messages(sender_id);
CREATE INDEX IF NOT EXISTS idx_secret_messages_recipient ON secret_messages(recipient_id);
CREATE INDEX IF NOT EXISTS idx_secret_messages_unread ON secret_messages(recipient_id, is_read) WHERE is_read = FALSE;

ALTER TABLE secret_messages ENABLE ROW LEVEL SECURITY;

-- Only sender and recipient can see messages
DO $$ BEGIN
CREATE POLICY "Sender and recipient can view messages"
  ON secret_messages FOR SELECT
  USING (sender_id = auth.uid() OR recipient_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can send secret messages"
  ON secret_messages FOR INSERT
  WITH CHECK (sender_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Recipient can mark as read"
  ON secret_messages FOR UPDATE
  USING (recipient_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Sender can delete own messages"
  ON secret_messages FOR DELETE
  USING (sender_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ==========================================
-- 13. EMOJI REACTIONS
-- ==========================================

CREATE TABLE IF NOT EXISTS emoji_reactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  emoji TEXT NOT NULL,
  target_type TEXT NOT NULL CHECK (target_type IN ('plan', 'checklist_item', 'photo', 'timeline_item', 'message')),
  target_id UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(plan_id, user_id, emoji, target_type, target_id)
);

CREATE INDEX IF NOT EXISTS idx_emoji_reactions_plan ON emoji_reactions(plan_id);
CREATE INDEX IF NOT EXISTS idx_emoji_reactions_target ON emoji_reactions(target_type, target_id);
CREATE INDEX IF NOT EXISTS idx_emoji_reactions_user ON emoji_reactions(user_id);

ALTER TABLE emoji_reactions ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
CREATE POLICY "Plan members can view reactions"
  ON emoji_reactions FOR SELECT
  USING (
    plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
    OR plan_id IN (SELECT plan_id FROM co_organizers WHERE user_id = auth.uid() AND status = 'accepted')
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can add reactions"
  ON emoji_reactions FOR INSERT
  WITH CHECK (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can remove own reactions"
  ON emoji_reactions FOR DELETE
  USING (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ==========================================
-- 14. TIME CAPSULES
-- ==========================================

CREATE TABLE IF NOT EXISTS time_capsules (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_id UUID NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
  created_by UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  title TEXT NOT NULL DEFAULT 'Time Capsule',
  description TEXT,
  unlock_at TIMESTAMPTZ NOT NULL,
  is_unlocked BOOLEAN NOT NULL DEFAULT FALSE,
  unlocked_at TIMESTAMPTZ,
  is_sealed BOOLEAN NOT NULL DEFAULT FALSE,
  sealed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_time_capsules_plan ON time_capsules(plan_id);
CREATE INDEX IF NOT EXISTS idx_time_capsules_unlock ON time_capsules(unlock_at) WHERE is_unlocked = FALSE;
CREATE INDEX IF NOT EXISTS idx_time_capsules_creator ON time_capsules(created_by);

CREATE TABLE IF NOT EXISTS time_capsule_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  capsule_id UUID NOT NULL REFERENCES time_capsules(id) ON DELETE CASCADE,
  added_by UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  item_type TEXT NOT NULL CHECK (item_type IN ('text', 'image', 'video', 'audio', 'link')),
  content TEXT NOT NULL,
  media_url TEXT,
  caption TEXT,
  sort_order INT DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_time_capsule_items_capsule ON time_capsule_items(capsule_id);

ALTER TABLE time_capsules ENABLE ROW LEVEL SECURITY;
ALTER TABLE time_capsule_items ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
CREATE POLICY "Plan members can view unlocked capsules"
  ON time_capsules FOR SELECT
  USING (
    (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
     OR plan_id IN (SELECT plan_id FROM co_organizers WHERE user_id = auth.uid() AND status = 'accepted'))
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan owner can create capsules"
  ON time_capsules FOR INSERT
  WITH CHECK (created_by = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan owner can update capsules"
  ON time_capsules FOR UPDATE
  USING (created_by = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan owner can delete capsules"
  ON time_capsules FOR DELETE
  USING (created_by = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Capsule items: only visible when capsule is unlocked (or for the creator)
DO $$ BEGIN
CREATE POLICY "View capsule items when unlocked or own"
  ON time_capsule_items FOR SELECT
  USING (
    capsule_id IN (
      SELECT tc.id FROM time_capsules tc
      WHERE (tc.is_unlocked = TRUE OR tc.created_by = auth.uid())
      AND (
        tc.plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
        OR tc.plan_id IN (SELECT plan_id FROM co_organizers WHERE user_id = auth.uid() AND status = 'accepted')
      )
    )
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Plan members can add capsule items"
  ON time_capsule_items FOR INSERT
  WITH CHECK (added_by = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can delete own capsule items"
  ON time_capsule_items FOR DELETE
  USING (added_by = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ==========================================
-- 15. SMART NOTIFICATIONS LOG
-- ==========================================

CREATE TABLE IF NOT EXISTS smart_notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  plan_id UUID REFERENCES plans(id) ON DELETE SET NULL,
  channel notification_channel NOT NULL DEFAULT 'in_app',
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  data JSONB DEFAULT '{}',
  notification_type TEXT NOT NULL DEFAULT 'general',
  priority INT NOT NULL DEFAULT 0 CHECK (priority BETWEEN 0 AND 3),
  is_read BOOLEAN NOT NULL DEFAULT FALSE,
  read_at TIMESTAMPTZ,
  is_sent BOOLEAN NOT NULL DEFAULT FALSE,
  sent_at TIMESTAMPTZ,
  scheduled_for TIMESTAMPTZ,
  context_type TEXT,
  context_id UUID,
  group_key TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_smart_notifications_user ON smart_notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_smart_notifications_unread ON smart_notifications(user_id, is_read) WHERE is_read = FALSE;
CREATE INDEX IF NOT EXISTS idx_smart_notifications_plan ON smart_notifications(plan_id) WHERE plan_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_smart_notifications_scheduled ON smart_notifications(scheduled_for) WHERE is_sent = FALSE AND scheduled_for IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_smart_notifications_type ON smart_notifications(user_id, notification_type);
CREATE INDEX IF NOT EXISTS idx_smart_notifications_group ON smart_notifications(user_id, group_key) WHERE group_key IS NOT NULL;

ALTER TABLE smart_notifications ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
CREATE POLICY "Users can view own notifications"
  ON smart_notifications FOR SELECT
  USING (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can update own notifications"
  ON smart_notifications FOR UPDATE
  USING (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "System can insert notifications"
  ON smart_notifications FOR INSERT
  WITH CHECK (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
CREATE POLICY "Users can delete own notifications"
  ON smart_notifications FOR DELETE
  USING (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ==========================================
-- HELPER FUNCTIONS
-- ==========================================

-- Function to update story like count
CREATE OR REPLACE FUNCTION update_story_like_count()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE community_stories SET like_count = like_count + 1 WHERE id = NEW.story_id;
    RETURN NEW;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE community_stories SET like_count = GREATEST(like_count - 1, 0) WHERE id = OLD.story_id;
    RETURN OLD;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER trg_story_like_count
  AFTER INSERT OR DELETE ON story_likes
  FOR EACH ROW EXECUTE FUNCTION update_story_like_count();

-- Function to update story comment count
CREATE OR REPLACE FUNCTION update_story_comment_count()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE community_stories SET comment_count = comment_count + 1 WHERE id = NEW.story_id;
    RETURN NEW;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE community_stories SET comment_count = GREATEST(comment_count - 1, 0) WHERE id = OLD.story_id;
    RETURN OLD;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER trg_story_comment_count
  AFTER INSERT OR DELETE ON story_comments
  FOR EACH ROW EXECUTE FUNCTION update_story_comment_count();

-- Function to update vendor rating average
CREATE OR REPLACE FUNCTION update_vendor_rating()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    UPDATE vendors SET
      rating_avg = (SELECT COALESCE(AVG(rating), 0) FROM vendor_reviews WHERE vendor_id = NEW.vendor_id),
      rating_count = (SELECT COUNT(*) FROM vendor_reviews WHERE vendor_id = NEW.vendor_id),
      updated_at = NOW()
    WHERE id = NEW.vendor_id;
    RETURN NEW;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE vendors SET
      rating_avg = (SELECT COALESCE(AVG(rating), 0) FROM vendor_reviews WHERE vendor_id = OLD.vendor_id),
      rating_count = (SELECT COUNT(*) FROM vendor_reviews WHERE vendor_id = OLD.vendor_id),
      updated_at = NOW()
    WHERE id = OLD.vendor_id;
    RETURN OLD;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER trg_vendor_rating
  AFTER INSERT OR UPDATE OR DELETE ON vendor_reviews
  FOR EACH ROW EXECUTE FUNCTION update_vendor_rating();

-- Function to update playlist total duration
CREATE OR REPLACE FUNCTION update_playlist_duration()
RETURNS TRIGGER AS $$
DECLARE
  target_playlist_id UUID;
BEGIN
  IF TG_OP = 'DELETE' THEN
    target_playlist_id := OLD.playlist_id;
  ELSE
    target_playlist_id := NEW.playlist_id;
  END IF;

  UPDATE music_playlists SET
    total_duration_seconds = (
      SELECT COALESCE(SUM(duration_seconds), 0)
      FROM playlist_items
      WHERE playlist_id = target_playlist_id
    ),
    updated_at = NOW()
  WHERE id = target_playlist_id;

  IF TG_OP = 'DELETE' THEN
    RETURN OLD;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER trg_playlist_duration
  AFTER INSERT OR UPDATE OR DELETE ON playlist_items
  FOR EACH ROW EXECUTE FUNCTION update_playlist_duration();

-- Generic updated_at trigger function
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply updated_at triggers to all new tables that have updated_at
DO $$ BEGIN CREATE TRIGGER set_updated_at BEFORE UPDATE ON weather_cache FOR EACH ROW EXECUTE FUNCTION set_updated_at(); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TRIGGER set_updated_at BEFORE UPDATE ON smart_timeline_items FOR EACH ROW EXECUTE FUNCTION set_updated_at(); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TRIGGER set_updated_at BEFORE UPDATE ON mood_boards FOR EACH ROW EXECUTE FUNCTION set_updated_at(); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TRIGGER set_updated_at BEFORE UPDATE ON guest_invitations FOR EACH ROW EXECUTE FUNCTION set_updated_at(); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TRIGGER set_updated_at BEFORE UPDATE ON recurring_events FOR EACH ROW EXECUTE FUNCTION set_updated_at(); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TRIGGER set_updated_at BEFORE UPDATE ON gift_suggestions FOR EACH ROW EXECUTE FUNCTION set_updated_at(); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TRIGGER set_updated_at BEFORE UPDATE ON backup_plans FOR EACH ROW EXECUTE FUNCTION set_updated_at(); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TRIGGER set_updated_at BEFORE UPDATE ON music_playlists FOR EACH ROW EXECUTE FUNCTION set_updated_at(); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TRIGGER set_updated_at BEFORE UPDATE ON community_stories FOR EACH ROW EXECUTE FUNCTION set_updated_at(); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TRIGGER set_updated_at BEFORE UPDATE ON vendors FOR EACH ROW EXECUTE FUNCTION set_updated_at(); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TRIGGER set_updated_at BEFORE UPDATE ON vendor_reviews FOR EACH ROW EXECUTE FUNCTION set_updated_at(); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TRIGGER set_updated_at BEFORE UPDATE ON plan_vendor_bookings FOR EACH ROW EXECUTE FUNCTION set_updated_at(); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TRIGGER set_updated_at BEFORE UPDATE ON voice_notes FOR EACH ROW EXECUTE FUNCTION set_updated_at(); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TRIGGER set_updated_at BEFORE UPDATE ON time_capsules FOR EACH ROW EXECUTE FUNCTION set_updated_at(); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE TRIGGER set_updated_at BEFORE UPDATE ON story_comments FOR EACH ROW EXECUTE FUNCTION set_updated_at(); EXCEPTION WHEN duplicate_object THEN NULL; END $$;
