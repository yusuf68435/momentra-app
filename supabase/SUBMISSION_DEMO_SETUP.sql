-- =============================================================================
-- Momentra — Apple/Google Review Demo Account Setup
-- =============================================================================
-- Apple ve Google review ekiplerinin kullanması için premium aktif test hesabı.
-- App Store Connect "App Review Information > Sign-In Required" alanına
-- doldurulacak demo credentials.
--
-- USAGE:
-- 1) Önce Supabase Dashboard > Authentication > Users > "Add user" ile
--    aşağıdaki hesabı oluştur (auth.users insert RLS bypass gerektirir):
--      Email: review@momentra.com
--      Password: MomentraReview2026!
--      ✅ Auto Confirm User
--
-- 2) İkinci review hesabı (co-organizer test'i için):
--      Email: review2@momentra.com
--      Password: MomentraReview2026!
--      ✅ Auto Confirm User
--
-- 3) Bu SQL'i Supabase SQL Editor'da çalıştır.
-- =============================================================================

-- Demo account 1: review@momentra.com (premium aktif)
do $$
declare
  v_user_id uuid;
begin
  select id into v_user_id from auth.users where email = 'review@momentra.com';
  if v_user_id is null then
    raise exception 'review@momentra.com user not found. Create via Supabase Dashboard first.';
  end if;

  -- Profile (upsert)
  insert into public.profiles (id, email, full_name, is_premium, created_at, updated_at)
  values (v_user_id, 'review@momentra.com', 'App Review', true, now(), now())
  on conflict (id) do update
    set is_premium = true,
        full_name = 'App Review',
        updated_at = now();

  -- Active premium subscription
  insert into public.subscriptions (user_id, revenucat_id, plan_type, is_active, started_at, expires_at)
  values (
    v_user_id,
    'review_demo_subscription',
    'premium_yearly',
    true,
    now(),
    now() + interval '1 year'
  )
  on conflict do nothing;

  raise notice 'Demo account 1 (review@momentra.com) configured with premium.';
end $$;

-- Demo account 2: review2@momentra.com (co-organizer test'i için)
do $$
declare
  v_user_id uuid;
begin
  select id into v_user_id from auth.users where email = 'review2@momentra.com';
  if v_user_id is null then
    raise warning 'review2@momentra.com user not found. Optional account — create via Dashboard if co-organizer testing needed.';
    return;
  end if;

  insert into public.profiles (id, email, full_name, is_premium, created_at, updated_at)
  values (v_user_id, 'review2@momentra.com', 'App Review (Co)', true, now(), now())
  on conflict (id) do update
    set is_premium = true,
        full_name = 'App Review (Co)',
        updated_at = now();

  insert into public.subscriptions (user_id, revenucat_id, plan_type, is_active, started_at, expires_at)
  values (
    v_user_id,
    'review2_demo_subscription',
    'premium_yearly',
    true,
    now(),
    now() + interval '1 year'
  )
  on conflict do nothing;

  raise notice 'Demo account 2 (review2@momentra.com) configured with premium.';
end $$;

-- Doğrulama
select
  p.email,
  p.full_name,
  p.is_premium,
  s.plan_type,
  s.is_active as subscription_active,
  s.expires_at
from public.profiles p
left join public.subscriptions s on s.user_id = p.id and s.is_active = true
where p.email in ('review@momentra.com', 'review2@momentra.com');
