-- Add tsvector column for full-text search on scenarios
ALTER TABLE scenarios ADD COLUMN IF NOT EXISTS search_vector tsvector;

-- Create GIN index for fast full-text search
CREATE INDEX IF NOT EXISTS idx_scenarios_search_vector ON scenarios USING GIN (search_vector);

-- Function to update search_vector
CREATE OR REPLACE FUNCTION update_scenario_search_vector()
RETURNS trigger AS $$
BEGIN
  NEW.search_vector :=
    setweight(to_tsvector('simple', COALESCE(NEW.title_tr, '')), 'A') ||
    setweight(to_tsvector('simple', COALESCE(NEW.title_en, '')), 'A') ||
    setweight(to_tsvector('simple', COALESCE(NEW.description_tr, '')), 'B') ||
    setweight(to_tsvector('simple', COALESCE(NEW.description_en, '')), 'B') ||
    setweight(to_tsvector('simple', COALESCE(NEW.tags::text, '')), 'C');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to auto-update search_vector
DO $$ BEGIN
  CREATE TRIGGER trg_update_scenario_search
    BEFORE INSERT OR UPDATE ON scenarios
    FOR EACH ROW
    EXECUTE FUNCTION update_scenario_search_vector();
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Backfill existing rows
UPDATE scenarios SET search_vector =
  setweight(to_tsvector('simple', COALESCE(title_tr, '')), 'A') ||
  setweight(to_tsvector('simple', COALESCE(title_en, '')), 'A') ||
  setweight(to_tsvector('simple', COALESCE(description_tr, '')), 'B') ||
  setweight(to_tsvector('simple', COALESCE(description_en, '')), 'B') ||
  setweight(to_tsvector('simple', COALESCE(tags::text, '')), 'C');

-- RPC function for full-text search
CREATE OR REPLACE FUNCTION search_scenarios(
  search_query text,
  result_limit int DEFAULT 20,
  result_offset int DEFAULT 0
)
RETURNS TABLE (
  id uuid,
  title_tr text,
  title_en text,
  description_tr text,
  description_en text,
  category_id uuid,
  difficulty text,
  min_budget numeric,
  max_budget numeric,
  image_url text,
  tags text[],
  rank real
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    s.id, s.title_tr, s.title_en, s.description_tr, s.description_en,
    s.category_id, s.difficulty, s.min_budget, s.max_budget,
    s.image_url, s.tags,
    ts_rank(s.search_vector, plainto_tsquery('simple', search_query)) AS rank
  FROM scenarios s
  WHERE s.search_vector @@ plainto_tsquery('simple', search_query)
  ORDER BY rank DESC
  LIMIT result_limit
  OFFSET result_offset;
END;
$$ LANGUAGE plpgsql;
