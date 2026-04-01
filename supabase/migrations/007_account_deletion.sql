-- ============================================
-- 007: Account Deletion Support (Apple App Store Requirement)
-- ============================================

-- Function to handle user account deletion
-- This deletes all user data and then the auth user
CREATE OR REPLACE FUNCTION delete_user_account(p_user_id UUID)
RETURNS void AS $$
BEGIN
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

-- Edge function will call this, so grant execute
GRANT EXECUTE ON FUNCTION delete_user_account TO authenticated;

-- RPC policy: users can only delete their own account
CREATE OR REPLACE FUNCTION rpc_delete_my_account()
RETURNS void AS $$
BEGIN
  PERFORM delete_user_account(auth.uid());
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
