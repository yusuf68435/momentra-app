-- Migration 015: Add pro_tip columns to scenario_steps for richer scenario content
ALTER TABLE public.scenario_steps
  ADD COLUMN IF NOT EXISTS pro_tip_tr text,
  ADD COLUMN IF NOT EXISTS pro_tip_en text;
