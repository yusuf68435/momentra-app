-- =============================================
-- AI Conversations table for chat persistence
-- + Surprise DNA fields in profiles
-- =============================================

-- AI Conversations: stores chat history across sessions
CREATE TABLE IF NOT EXISTS ai_conversations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  title TEXT NOT NULL DEFAULT '',
  context_plan_id UUID REFERENCES plans(id) ON DELETE SET NULL,
  context_scenario_id UUID REFERENCES scenarios(id) ON DELETE SET NULL,
  messages JSONB NOT NULL DEFAULT '[]'::jsonb,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Add missing columns to pre-existing ai_conversations table
ALTER TABLE ai_conversations ADD COLUMN IF NOT EXISTS title TEXT NOT NULL DEFAULT '';
ALTER TABLE ai_conversations ADD COLUMN IF NOT EXISTS context_plan_id UUID REFERENCES plans(id) ON DELETE SET NULL;
ALTER TABLE ai_conversations ADD COLUMN IF NOT EXISTS context_scenario_id UUID REFERENCES scenarios(id) ON DELETE SET NULL;
ALTER TABLE ai_conversations ADD COLUMN IF NOT EXISTS messages JSONB NOT NULL DEFAULT '[]'::jsonb;
ALTER TABLE ai_conversations ADD COLUMN IF NOT EXISTS is_active BOOLEAN NOT NULL DEFAULT true;
ALTER TABLE ai_conversations ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ NOT NULL DEFAULT now();

-- Indexes for efficient queries
CREATE INDEX IF NOT EXISTS idx_ai_conversations_user_active ON ai_conversations(user_id, is_active);
CREATE INDEX IF NOT EXISTS idx_ai_conversations_updated ON ai_conversations(user_id, updated_at DESC);

-- RLS policies
ALTER TABLE ai_conversations ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  CREATE POLICY "Users can view own conversations"
    ON ai_conversations FOR SELECT
    USING (auth.uid() = user_id);
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  CREATE POLICY "Users can insert own conversations"
    ON ai_conversations FOR INSERT
    WITH CHECK (auth.uid() = user_id);
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  CREATE POLICY "Users can update own conversations"
    ON ai_conversations FOR UPDATE
    USING (auth.uid() = user_id);
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  CREATE POLICY "Users can delete own conversations"
    ON ai_conversations FOR DELETE
    USING (auth.uid() = user_id);
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Add surprise_dna JSONB field to profiles if not exists
-- (preferences JSONB already exists, we'll use preferences.surpriseDna)
-- No schema change needed - we store in existing preferences JSONB

-- Smart Countdown Coach: add reminder_context to plans for AI-driven reminders
ALTER TABLE plans ADD COLUMN IF NOT EXISTS ai_reminder_context JSONB DEFAULT NULL;

-- Add emotion/personality tags for recipients
ALTER TABLE plans ADD COLUMN IF NOT EXISTS recipient_personality JSONB DEFAULT NULL;
-- Example: { "traits": ["romantic", "adventurous"], "tone": "warm", "interests": ["music", "travel"] }
