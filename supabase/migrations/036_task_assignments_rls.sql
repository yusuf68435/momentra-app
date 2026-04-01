-- Migration 036: Add missing RLS policies for task_assignments
-- Bug: task_assignments had RLS enabled but no policies defined,
-- causing all INSERT and SELECT operations to fail silently.

-- Plan owner and co-organizers can view tasks
DO $$ BEGIN
CREATE POLICY task_assignments_select ON task_assignments FOR SELECT
  USING (
    plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
    OR plan_id IN (
      SELECT plan_id FROM co_organizers
      WHERE user_id = auth.uid() AND status = 'accepted'
    )
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Plan owner and co-organizers can assign tasks
DO $$ BEGIN
CREATE POLICY task_assignments_insert ON task_assignments FOR INSERT
  WITH CHECK (
    assigned_by = auth.uid()
    AND (
      plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
      OR plan_id IN (
        SELECT plan_id FROM co_organizers
        WHERE user_id = auth.uid() AND status = 'accepted'
      )
    )
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- The assignee can update their own task status; plan owner can update any
DO $$ BEGIN
CREATE POLICY task_assignments_update ON task_assignments FOR UPDATE
  USING (
    assigned_to = auth.uid()
    OR plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Plan owner can delete tasks
DO $$ BEGIN
CREATE POLICY task_assignments_delete ON task_assignments FOR DELETE
  USING (
    plan_id IN (SELECT id FROM plans WHERE user_id = auth.uid())
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
