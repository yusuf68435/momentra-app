-- 019: Performance indexes for foreign key columns and common query patterns
-- These indexes improve JOIN and WHERE clause performance on FK columns
-- that PostgreSQL does not automatically index.

-- AI conversations FK indexes
CREATE INDEX IF NOT EXISTS idx_ai_conversations_context_plan ON public.ai_conversations(context_plan_id);
CREATE INDEX IF NOT EXISTS idx_ai_conversations_context_scenario ON public.ai_conversations(context_scenario_id);

-- Plan messages FK index
CREATE INDEX IF NOT EXISTS idx_plan_messages_sender ON public.plan_messages(sender_id);

-- Task assignments FK index
CREATE INDEX IF NOT EXISTS idx_task_assignments_checklist ON public.task_assignments(checklist_item_id);

-- Invite links FK index
CREATE INDEX IF NOT EXISTS idx_invite_links_created_by ON public.invite_links(created_by);

-- Smart timeline composite index for common query pattern (plan + status + due_at)
CREATE INDEX IF NOT EXISTS idx_timeline_plan_status_due ON public.smart_timeline_items(plan_id, status, due_at);
