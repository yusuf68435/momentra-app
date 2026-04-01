-- ==========================================
-- DB Helper Functions
-- ==========================================

-- Increment scenario view count
CREATE OR REPLACE FUNCTION public.increment_view_count(scenario_id uuid)
RETURNS void AS $$
BEGIN
  UPDATE public.scenarios
  SET view_count = view_count + 1
  WHERE id = scenario_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Update scenario rating average after a new review
CREATE OR REPLACE FUNCTION public.update_scenario_rating(p_scenario_id uuid)
RETURNS void AS $$
DECLARE
  avg_rating numeric(3,2);
  total_count int;
BEGIN
  SELECT COALESCE(AVG(rating), 0), COUNT(*)
  INTO avg_rating, total_count
  FROM public.reviews
  WHERE scenario_id = p_scenario_id;

  UPDATE public.scenarios
  SET rating_avg = avg_rating, rating_count = total_count
  WHERE id = p_scenario_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Auto-update updated_at timestamp
CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS trigger AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DO $$ BEGIN
  CREATE TRIGGER set_updated_at_profiles
    BEFORE UPDATE ON public.profiles
    FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  CREATE TRIGGER set_updated_at_scenarios
    BEFORE UPDATE ON public.scenarios
    FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  CREATE TRIGGER set_updated_at_plans
    BEFORE UPDATE ON public.plans
    FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ==========================================
-- Additional indexes for performance
-- ==========================================

CREATE INDEX IF NOT EXISTS idx_scenarios_slug ON public.scenarios(slug);
CREATE INDEX IF NOT EXISTS idx_scenarios_active_featured ON public.scenarios(is_active, is_featured);
CREATE INDEX IF NOT EXISTS idx_reviews_scenario ON public.reviews(scenario_id);
CREATE INDEX IF NOT EXISTS idx_ai_interactions_user ON public.ai_interactions(user_id);
CREATE INDEX IF NOT EXISTS idx_subscriptions_user_active ON public.subscriptions(user_id, is_active);

-- ==========================================
-- Storage bucket for scenario images
-- ==========================================

INSERT INTO storage.buckets (id, name, public)
VALUES ('scenario-images', 'scenario-images', true)
ON CONFLICT (id) DO NOTHING;

INSERT INTO storage.buckets (id, name, public)
VALUES ('user-uploads', 'user-uploads', false)
ON CONFLICT (id) DO NOTHING;

-- Public read for scenario images
DO $$ BEGIN
  CREATE POLICY "Public read scenario images" ON storage.objects
    FOR SELECT USING (bucket_id = 'scenario-images');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Users can upload to their own folder
DO $$ BEGIN
  CREATE POLICY "Users upload own files" ON storage.objects
    FOR INSERT WITH CHECK (
      bucket_id = 'user-uploads'
      AND (storage.foldername(name))[1] = auth.uid()::text
    );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  CREATE POLICY "Users read own uploads" ON storage.objects
    FOR SELECT USING (
      bucket_id = 'user-uploads'
      AND (storage.foldername(name))[1] = auth.uid()::text
    );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
  CREATE POLICY "Users delete own uploads" ON storage.objects
    FOR DELETE USING (
      bucket_id = 'user-uploads'
      AND (storage.foldername(name))[1] = auth.uid()::text
    );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;
