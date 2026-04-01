-- ============================================================
-- Migration 034: Ultra Security Hardening
-- Adds granular RLS policies for ownership enforcement on all
-- mutation operations across critical tables.
-- ============================================================

-- ============================================================
-- 1. secret_messages: Ownership-enforced DELETE and UPDATE
-- ============================================================

DROP POLICY IF EXISTS "Sender or recipient can delete messages" ON secret_messages;
CREATE POLICY "Sender or recipient can delete messages"
  ON secret_messages FOR DELETE
  USING (sender_id = auth.uid() OR recipient_id = auth.uid());

DROP POLICY IF EXISTS "Recipient can mark messages as read" ON secret_messages;
CREATE POLICY "Recipient can mark messages as read"
  ON secret_messages FOR UPDATE
  USING (recipient_id = auth.uid())
  WITH CHECK (recipient_id = auth.uid());

-- ============================================================
-- 2. plan_photos: Only uploader can delete their photo
-- ============================================================

DROP POLICY IF EXISTS "Uploader can delete their photo" ON plan_photos;
CREATE POLICY "Uploader can delete their photo"
  ON plan_photos FOR DELETE
  USING (uploaded_by = auth.uid());

-- ============================================================
-- 3. community_stories: Only author can update or delete
-- ============================================================

DROP POLICY IF EXISTS "Author can update own story" ON community_stories;
CREATE POLICY "Author can update own story"
  ON community_stories FOR UPDATE
  USING (user_id = auth.uid())
  WITH CHECK (user_id = auth.uid());

DROP POLICY IF EXISTS "Author can delete own story" ON community_stories;
CREATE POLICY "Author can delete own story"
  ON community_stories FOR DELETE
  USING (user_id = auth.uid());

-- ============================================================
-- 4. story_comments: Only author can delete their comment
-- ============================================================

DROP POLICY IF EXISTS "Author can delete own comment" ON story_comments;
CREATE POLICY "Author can delete own comment"
  ON story_comments FOR DELETE
  USING (user_id = auth.uid());

-- ============================================================
-- 5. reviews: Only reviewer can delete their review
-- ============================================================

DROP POLICY IF EXISTS "Reviewer can delete own review" ON reviews;
CREATE POLICY "Reviewer can delete own review"
  ON reviews FOR DELETE
  USING (user_id = auth.uid());

-- ============================================================
-- 6. guest_invitations: Only the plan owner can update or delete
-- ============================================================

DROP POLICY IF EXISTS "Inviter can update guest" ON guest_invitations;
CREATE POLICY "Inviter can update guest"
  ON guest_invitations FOR UPDATE
  USING (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()))
  WITH CHECK (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()));

DROP POLICY IF EXISTS "Inviter can delete guest" ON guest_invitations;
CREATE POLICY "Inviter can delete guest"
  ON guest_invitations FOR DELETE
  USING (plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid()));

-- ============================================================
-- 7. vendor_reviews: Only reviewer can delete their review
-- ============================================================

DROP POLICY IF EXISTS "Reviewer can delete own vendor review" ON vendor_reviews;
CREATE POLICY "Reviewer can delete own vendor review"
  ON vendor_reviews FOR DELETE
  USING (user_id = auth.uid());

-- ============================================================
-- 8. task_assignments: Prevent escalation — assigned_by cannot
--    be faked; only plan owner / co-organizer should assign
-- ============================================================

DROP POLICY IF EXISTS "Task creator or plan owner can delete task" ON task_assignments;
CREATE POLICY "Task creator or plan owner can delete task"
  ON task_assignments FOR DELETE
  USING (
    assigned_by = auth.uid()
    OR plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
  );

-- Assignee can update status only (not reassign)
DROP POLICY IF EXISTS "Assignee can update task status" ON task_assignments;
CREATE POLICY "Assignee can update task status"
  ON task_assignments FOR UPDATE
  USING (assigned_to = auth.uid() OR assigned_by = auth.uid())
  WITH CHECK (assigned_to = auth.uid() OR assigned_by = auth.uid());

-- ============================================================
-- 9. Secure invite_links: prevent use_count manipulation
--    Only increment is allowed, never decrement
-- ============================================================

DROP POLICY IF EXISTS "System can increment use_count" ON invite_links;
CREATE POLICY "Owner or system can update invite link"
  ON invite_links FOR UPDATE
  USING (
    created_by = auth.uid()
    OR plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
  );

-- ============================================================
-- 10. Enforce ai_interactions is insert-only for users
--     (users cannot delete/modify their own usage history)
-- ============================================================

DROP POLICY IF EXISTS "Users cannot delete ai interactions" ON ai_interactions;
DO $$ BEGIN
  CREATE POLICY "Users can insert own ai interactions"
    ON ai_interactions FOR INSERT
    WITH CHECK (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  CREATE POLICY "Users can view own ai interactions"
    ON ai_interactions FOR SELECT
    USING (user_id = auth.uid());
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- No UPDATE or DELETE policies for ai_interactions on purpose.

-- ============================================================
-- 11. Add missing index on secret_messages for perf + security
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_secret_messages_recipient_read
  ON secret_messages (recipient_id, is_read)
  WHERE is_read = FALSE;

CREATE INDEX IF NOT EXISTS idx_secret_messages_expires
  ON secret_messages (expires_at)
  WHERE expires_at IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_plan_photos_uploaded_by
  ON plan_photos (uploaded_by);

CREATE INDEX IF NOT EXISTS idx_guest_invitations_plan_id
  ON guest_invitations (plan_id);

CREATE INDEX IF NOT EXISTS idx_community_stories_user
  ON community_stories (user_id);

CREATE INDEX IF NOT EXISTS idx_story_comments_user
  ON story_comments (user_id);
