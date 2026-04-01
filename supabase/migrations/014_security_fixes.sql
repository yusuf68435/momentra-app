-- ============================================================
-- Migration 014: Security Fixes
-- Addresses critical and high-severity vulnerabilities found
-- during security audit.
-- ============================================================

-- ============================================================
-- 1. FIX: delete_user_account() - Add auth check (CRITICAL)
-- Previously any authenticated user could delete any account.
-- ============================================================

CREATE OR REPLACE FUNCTION delete_user_account(p_user_id UUID)
RETURNS void AS $$
BEGIN
  -- Security: only allow deleting own account
  IF p_user_id != auth.uid() THEN
    RAISE EXCEPTION 'Not authorized to delete this account';
  END IF;

  -- Delete gamification data
  DELETE FROM xp_history WHERE user_id = p_user_id;
  DELETE FROM user_badges WHERE user_id = p_user_id;
  DELETE FROM user_gamification WHERE user_id = p_user_id;

  -- Delete important dates
  DELETE FROM important_dates WHERE user_id = p_user_id;

  -- Delete co-organizer records
  DELETE FROM co_organizers WHERE user_id = p_user_id;

  -- Delete task assignments
  DELETE FROM task_assignments WHERE assigned_to = p_user_id OR assigned_by = p_user_id;

  -- Delete messages
  DELETE FROM plan_messages WHERE sender_id = p_user_id;

  -- Delete photos
  DELETE FROM plan_photos WHERE uploaded_by = p_user_id;

  -- Delete expenses paid by user
  UPDATE plan_expenses SET paid_by = NULL WHERE paid_by = p_user_id;

  -- Delete invite links created by user
  DELETE FROM invite_links WHERE created_by = p_user_id;

  -- Delete user's plans (cascades to checklist items, expenses, etc.)
  DELETE FROM plans WHERE user_id = p_user_id;

  -- Delete profile
  DELETE FROM profiles WHERE id = p_user_id;

  -- Note: The auth.users deletion should be handled via Supabase Admin API
  -- from an Edge Function for security
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Revoke direct access - users should call rpc_delete_my_account() instead
REVOKE EXECUTE ON FUNCTION delete_user_account(UUID) FROM authenticated;

-- ============================================================
-- 2. FIX: add_user_xp() - Add auth check (HIGH)
-- Previously any user could add XP to any other user.
-- ============================================================

CREATE OR REPLACE FUNCTION add_user_xp(p_user_id UUID, p_amount INT, p_reason TEXT)
RETURNS void AS $$
BEGIN
  -- Security: only allow adding XP to own account
  IF p_user_id != auth.uid() THEN
    RAISE EXCEPTION 'Not authorized';
  END IF;

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

-- ============================================================
-- 3. FIX: compute_unique_recipients() - Add auth check (HIGH)
-- Previously any user could enumerate other users' data.
-- ============================================================

CREATE OR REPLACE FUNCTION compute_unique_recipients(p_user_id UUID)
RETURNS INT
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_count INT;
BEGIN
  -- Security: only allow querying own data
  IF p_user_id != auth.uid() THEN
    RAISE EXCEPTION 'Not authorized';
  END IF;

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

-- ============================================================
-- 4. FIX: invite_links - Add missing RLS policies (HIGH)
-- RLS was enabled but zero policies existed, making the table
-- functionally broken (deny-all).
-- ============================================================

-- Owner/plan-owner can view their invite links
DO $$ BEGIN
  CREATE POLICY invite_links_owner_select ON invite_links FOR SELECT
    USING (
      created_by = auth.uid()
      OR plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
    );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Public: anyone can view active invite links (for joining via code)
DO $$ BEGIN
  CREATE POLICY invite_links_public_join ON invite_links FOR SELECT
    USING (is_active = TRUE AND expires_at > NOW());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Only creator can insert
DO $$ BEGIN
  CREATE POLICY invite_links_insert ON invite_links FOR INSERT
    WITH CHECK (created_by = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Only creator can update
DO $$ BEGIN
  CREATE POLICY invite_links_update ON invite_links FOR UPDATE
    USING (created_by = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Only creator can delete
DO $$ BEGIN
  CREATE POLICY invite_links_delete ON invite_links FOR DELETE
    USING (created_by = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ============================================================
-- 5. FIX: time_capsules SELECT policy - Check is_unlocked (HIGH)
-- Previously all plan members could see locked capsule contents.
-- ============================================================

DROP POLICY IF EXISTS "Plan members can view unlocked capsules" ON time_capsules;

DO $$ BEGIN
  CREATE POLICY "Plan members can view capsules securely"
    ON time_capsules FOR SELECT
    USING (
      -- Creator can always see their capsules
      created_by = auth.uid()
      OR (
        -- Others can only see UNLOCKED capsules for plans they belong to
        is_unlocked = TRUE
        AND (
          plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
          OR plan_id IN (SELECT plan_id FROM co_organizers WHERE user_id = auth.uid() AND status = 'accepted')
        )
      )
    );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ============================================================
-- 6. FIX: secret_messages SELECT policy - Filter expired messages
-- Messages with self_destruct or expires_at should not be visible
-- after their expiration.
-- ============================================================

DROP POLICY IF EXISTS "Sender and recipient can view messages" ON secret_messages;

DO $$ BEGIN
  CREATE POLICY "Sender and recipient can view non-expired messages"
    ON secret_messages FOR SELECT
    USING (
      (sender_id = auth.uid() OR recipient_id = auth.uid())
      -- Exclude expired messages
      AND (expires_at IS NULL OR expires_at > NOW())
      -- Exclude self-destructed messages
      AND NOT (
        self_destruct = TRUE
        AND is_read = TRUE
        AND read_at IS NOT NULL
        AND self_destruct_after IS NOT NULL
        AND read_at + self_destruct_after < NOW()
      )
    );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Cleanup function for expired/self-destructed messages (call via cron)
CREATE OR REPLACE FUNCTION cleanup_expired_secret_messages()
RETURNS void AS $$
BEGIN
  DELETE FROM secret_messages
  WHERE
    -- Time-expired messages
    (expires_at IS NOT NULL AND expires_at < NOW())
    -- Self-destructed messages
    OR (
      self_destruct = TRUE
      AND is_read = TRUE
      AND read_at IS NOT NULL
      AND self_destruct_after IS NOT NULL
      AND read_at + self_destruct_after < NOW()
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================
-- 7. FIX: vendors INSERT policy - Restrict self-verification
-- Previously any authenticated user could add verified vendors.
-- ============================================================

DROP POLICY IF EXISTS "Authenticated users can add vendors" ON vendors;

DO $$ BEGIN
  CREATE POLICY "Authenticated users can add unverified vendors"
    ON vendors FOR INSERT
    WITH CHECK (
      auth.uid() IS NOT NULL
      AND added_by = auth.uid()
      AND is_verified = FALSE
    );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
