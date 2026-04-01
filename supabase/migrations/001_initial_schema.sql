-- Enable extensions
-- pgvector removed: not available on free tier (used only for scenario embeddings)

-- ==========================================
-- USERS & AUTH
-- ==========================================
create table if not exists public.profiles (
  id            uuid primary key references auth.users(id) on delete cascade,
  display_name  text,
  avatar_url    text,
  language      text default 'tr' check (language in ('tr', 'en')),
  currency      text default 'TRY' check (currency in ('TRY', 'USD', 'EUR')),
  timezone      text default 'Europe/Istanbul',
  onboarding_completed boolean default false,
  preferences   jsonb default '{}',
  created_at    timestamptz default now(),
  updated_at    timestamptz default now()
);

alter table public.profiles enable row level security;
do $$ begin
  create policy "Users read own profile" on public.profiles for select using (auth.uid() = id);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Users update own profile" on public.profiles for update using (auth.uid() = id);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Users insert own profile" on public.profiles for insert with check (auth.uid() = id);
exception when duplicate_object then null; end $$;

-- Auto-create profile on signup
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, display_name)
  values (new.id, new.raw_user_meta_data->>'display_name')
  on conflict (id) do nothing;
  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ==========================================
-- SCENARIO CATALOG
-- ==========================================
create table if not exists public.categories (
  id            uuid primary key default gen_random_uuid(),
  slug          text unique not null,
  name_tr       text not null,
  name_en       text not null,
  description_tr text,
  description_en text,
  icon          text not null,
  color         text not null,
  sort_order    int default 0,
  is_active     boolean default true,
  created_at    timestamptz default now()
);

alter table public.categories enable row level security;
do $$ begin
  create policy "Anyone can read active categories" on public.categories for select using (is_active = true);
exception when duplicate_object then null; end $$;

create table if not exists public.scenarios (
  id               uuid primary key default gen_random_uuid(),
  category_id      uuid not null references public.categories(id),
  slug             text unique not null,
  title_tr         text not null,
  title_en         text not null,
  description_tr   text not null,
  description_en   text not null,
  short_desc_tr    text,
  short_desc_en    text,
  difficulty       int default 1 check (difficulty between 1 and 5),
  min_budget       numeric(10,2),
  max_budget       numeric(10,2),
  min_people       int default 1,
  max_people       int,
  prep_days        int default 7,
  indoor_outdoor   text check (indoor_outdoor in ('indoor', 'outdoor', 'both')),
  season           text[] default '{}',
  tags             text[] default '{}',
  cover_image_url  text,
  is_premium       boolean default false,
  is_featured      boolean default false,
  is_active        boolean default true,
  rating_avg       numeric(3,2) default 0,
  rating_count     int default 0,
  view_count       int default 0,
  -- embedding     vector(1536), -- requires pgvector (pro tier)
  created_at       timestamptz default now(),
  updated_at       timestamptz default now()
);

create index if not exists idx_scenarios_category on public.scenarios(category_id);
create index if not exists idx_scenarios_budget on public.scenarios(min_budget, max_budget);
create index if not exists idx_scenarios_tags on public.scenarios using gin(tags);
create index if not exists idx_scenarios_featured on public.scenarios(is_featured) where is_featured = true;

alter table public.scenarios enable row level security;
do $$ begin
  create policy "Anyone can read active scenarios" on public.scenarios for select using (is_active = true);
exception when duplicate_object then null; end $$;

create table if not exists public.scenario_images (
  id            uuid primary key default gen_random_uuid(),
  scenario_id   uuid not null references public.scenarios(id) on delete cascade,
  image_url     text not null,
  caption_tr    text,
  caption_en    text,
  sort_order    int default 0,
  created_at    timestamptz default now()
);

alter table public.scenario_images enable row level security;
do $$ begin
  create policy "Anyone can read scenario images" on public.scenario_images for select using (true);
exception when duplicate_object then null; end $$;

create table if not exists public.scenario_steps (
  id             uuid primary key default gen_random_uuid(),
  scenario_id    uuid not null references public.scenarios(id) on delete cascade,
  step_number    int not null,
  title_tr       text not null,
  title_en       text not null,
  description_tr text not null,
  description_en text not null,
  is_optional    boolean default false,
  days_before    int,
  estimated_cost numeric(10,2),
  created_at     timestamptz default now()
);

alter table public.scenario_steps enable row level security;
do $$ begin
  create policy "Anyone can read scenario steps" on public.scenario_steps for select using (true);
exception when duplicate_object then null; end $$;

-- ==========================================
-- USER PLANS
-- ==========================================
create table if not exists public.plans (
  id               uuid primary key default gen_random_uuid(),
  user_id          uuid not null references public.profiles(id) on delete cascade,
  scenario_id      uuid references public.scenarios(id),
  title            text not null,
  event_date       date,
  event_time       time,
  recipient_name   text,
  recipient_relation text,
  location_text    text,
  location_lat     numeric(10,7),
  location_lng     numeric(10,7),
  budget           numeric(10,2),
  guest_count      int,
  notes            text,
  status           text default 'planning' check (status in ('planning', 'ready', 'completed', 'cancelled')),
  customizations   jsonb default '{}',
  ai_suggestions   jsonb default '{}',
  created_at       timestamptz default now(),
  updated_at       timestamptz default now()
);

create index if not exists idx_plans_user on public.plans(user_id);
create index if not exists idx_plans_date on public.plans(event_date);

alter table public.plans enable row level security;
do $$ begin
  create policy "Users manage own plans" on public.plans for all using (auth.uid() = user_id);
exception when duplicate_object then null; end $$;

create table if not exists public.plan_checklist_items (
  id            uuid primary key default gen_random_uuid(),
  plan_id       uuid not null references public.plans(id) on delete cascade,
  step_id       uuid references public.scenario_steps(id),
  title         text not null,
  description   text,
  is_completed  boolean default false,
  due_date      date,
  sort_order    int default 0,
  completed_at  timestamptz,
  created_at    timestamptz default now()
);

create index if not exists idx_checklist_plan on public.plan_checklist_items(plan_id);

alter table public.plan_checklist_items enable row level security;
do $$ begin
  create policy "Users manage own checklist" on public.plan_checklist_items for all
    using (plan_id in (select id from public.plans where user_id = auth.uid()));
exception when duplicate_object then null; end $$;

-- ==========================================
-- REVIEWS
-- ==========================================
create table if not exists public.reviews (
  id            uuid primary key default gen_random_uuid(),
  user_id       uuid not null references public.profiles(id),
  scenario_id   uuid not null references public.scenarios(id),
  plan_id       uuid references public.plans(id),
  rating        int not null check (rating between 1 and 5),
  comment       text,
  photos        text[] default '{}',
  is_public     boolean default true,
  created_at    timestamptz default now(),
  unique(user_id, scenario_id)
);

alter table public.reviews add column if not exists is_public boolean default true;

alter table public.reviews enable row level security;
do $$ begin
  create policy "Anyone can read public reviews" on public.reviews for select using (is_public = true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Users manage own reviews" on public.reviews for all using (auth.uid() = user_id);
exception when duplicate_object then null; end $$;

-- ==========================================
-- AI INTERACTIONS
-- ==========================================
create table if not exists public.ai_interactions (
  id            uuid primary key default gen_random_uuid(),
  user_id       uuid not null references public.profiles(id),
  prompt_type   text not null,
  input_data    jsonb not null,
  response_data jsonb not null,
  model_used    text,
  tokens_used   int,
  rating        int,
  created_at    timestamptz default now()
);

alter table public.ai_interactions enable row level security;
do $$ begin
  create policy "Users read own ai interactions" on public.ai_interactions for select using (auth.uid() = user_id);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Users insert own ai interactions" on public.ai_interactions for insert with check (auth.uid() = user_id);
exception when duplicate_object then null; end $$;

-- ==========================================
-- SUBSCRIPTIONS
-- ==========================================
create table if not exists public.subscriptions (
  id                uuid primary key default gen_random_uuid(),
  user_id           uuid not null references public.profiles(id),
  revenucat_id      text,
  plan_type         text not null check (plan_type in ('free', 'premium_monthly', 'premium_yearly')),
  is_active         boolean default true,
  started_at        timestamptz,
  expires_at        timestamptz,
  created_at        timestamptz default now()
);

alter table public.subscriptions enable row level security;
do $$ begin
  create policy "Users read own subscription" on public.subscriptions for select using (auth.uid() = user_id);
exception when duplicate_object then null; end $$;
