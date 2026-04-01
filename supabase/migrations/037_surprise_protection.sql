-- Add surprise_protection column to plans table
-- When enabled, the plan is hidden from guest view

ALTER TABLE public.plans
  ADD COLUMN IF NOT EXISTS surprise_protection BOOLEAN NOT NULL DEFAULT FALSE;
