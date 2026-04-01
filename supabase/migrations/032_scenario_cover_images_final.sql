-- Migration: 032_scenario_cover_images_final
-- Description: Assign cover images to the 38 scenarios that still have NULL cover_image_url.
-- These were missed by migrations 023-026 due to slug mismatches.
-- Each Unsplash photo ID is unique — no duplicates within this file or across 023-026.

-- =============================================
-- PROPOSAL SCENARIOS
-- =============================================

-- Beach proposal: sandy shore with ocean waves
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1515003197210-e0cd71810b5f?w=800&h=600&fit=crop' WHERE slug = 'beach-proposal';

-- Restaurant proposal: elegant fine dining setting
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=800&h=600&fit=crop' WHERE slug = 'restaurant-proposal';

-- Rooftop proposal: city skyline at twilight
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=800&h=600&fit=crop' WHERE slug = 'rooftop-proposal';

-- Drone light show proposal: night sky with light trails
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1518021964703-4b2030f03085?w=800&h=600&fit=crop' WHERE slug = 'drone-light-show-proposal';

-- =============================================
-- BIRTHDAY SCENARIOS
-- =============================================

-- Birthday treasure hunt: wrapped gifts and clues
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1464349153159-4e9bf6e52be9?w=800&h=600&fit=crop' WHERE slug = 'birthday-treasure-hunt';

-- Midnight birthday surprise: dark room with candles
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1519751138087-5bf79df62d5b?w=800&h=600&fit=crop' WHERE slug = 'midnight-birthday-surprise';

-- Outdoor BBQ birthday: backyard barbecue party
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?w=800&h=600&fit=crop' WHERE slug = 'outdoor-bbq-birthday';

-- Birthday jar 365: glass jar with colorful notes
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1549298222-1c31e8915347?w=800&h=600&fit=crop' WHERE slug = 'birthday-jar-365';

-- Balloon memory ceiling: room filled with balloons
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1527274927966-a01b9085a9f8?w=800&h=600&fit=crop' WHERE slug = 'balloon-memory-ceiling';

-- Retro 90s party: vintage neon and retro vibes
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1504257432389-52343af06ae3?w=800&h=600&fit=crop' WHERE slug = 'retro-90s-party';

-- =============================================
-- ANNIVERSARY / ROMANTIC SCENARIOS
-- =============================================

-- Memory lane anniversary: couple walking path with photos
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1522199710521-72d69614c702?w=800&h=600&fit=crop' WHERE slug = 'memory-lane-anniversary';

-- Candlelight dinner: intimate dinner with candles
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1543007630-9710e4a00a20?w=800&h=600&fit=crop' WHERE slug = 'candlelight-dinner';

-- Love jar 365: jar filled with love notes
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800&h=600&fit=crop' WHERE slug = 'love-jar-365';

-- Korean 100 days: romantic couple celebration
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1522098543979-ffc7f79a56c4?w=800&h=600&fit=crop' WHERE slug = 'korean-100-days';

-- Korean 100 day box: beautiful gift box
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?w=800&h=600&fit=crop' WHERE slug = 'korean-100-day-box';

-- Valentine's scavenger hunt: hearts and clues
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1518709594023-6eab9bab7b23?w=800&h=600&fit=crop' WHERE slug = 'valentines-scavenger-hunt';

-- Home spa date: candles, bath products, relaxation
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1596178065887-1198b6148b2b?w=800&h=600&fit=crop' WHERE slug = 'home-spa-date';

-- Surprise weekend getaway: scenic travel destination
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1500835556837-99ac94a94552?w=800&h=600&fit=crop' WHERE slug = 'surprise-weekend-getaway';

-- Stargazing night: clear night sky with stars
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1475274047050-1d0c55b7b10c?w=800&h=600&fit=crop' WHERE slug = 'stargazing-night';

-- Surprise road trip: open road adventure
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=800&h=600&fit=crop' WHERE slug = 'surprise-road-trip';

-- Hot air balloon ride: colorful balloons in sky
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1507699622108-4be3abd695ad?w=800&h=600&fit=crop' WHERE slug = 'hot-air-balloon-ride';

-- Afternoon tea party: elegant tea service
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1445116572660-236099ec97a0?w=800&h=600&fit=crop' WHERE slug = 'afternoon-tea-party';

-- Picnic in the park: blanket with food in green park
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&h=600&fit=crop' WHERE slug = 'picnic-in-the-park';

-- Bonsai growth journey: beautiful bonsai tree
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1567331711402-509c12c41959?w=800&h=600&fit=crop' WHERE slug = 'bonsai-growth-journey';

-- Thai street food night: vibrant Thai food market
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=800&h=600&fit=crop' WHERE slug = 'thai-street-food-night';

-- Watercolor love letter: artistic watercolor painting
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1578926288207-a90a5366759d?w=800&h=600&fit=crop' WHERE slug = 'watercolor-love-letter';

-- =============================================
-- BABY / GENDER REVEAL SCENARIOS
-- =============================================

-- Classic baby shower: baby shower decorations
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=800&h=600&fit=crop' WHERE slug = 'classic-baby-shower';

-- =============================================
-- GRADUATION SCENARIOS
-- =============================================

-- Graduation surprise party: graduation caps and celebration
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1523580846011-d3a5bc25702b?w=800&h=600&fit=crop' WHERE slug = 'graduation-surprise-party';

-- =============================================
-- FRIENDSHIP SCENARIOS
-- =============================================

-- Friendship appreciation day: group of friends together
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1506869640319-fe1a24fd76cb?w=800&h=600&fit=crop' WHERE slug = 'friendship-appreciation-day';

-- Playlist exchange surprise: headphones and music
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1494232410401-ad00d5433cfa?w=800&h=600&fit=crop' WHERE slug = 'playlist-exchange-surprise';

-- Escape room adventure: mysterious puzzle room
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1510511459019-5dda7724fd87?w=800&h=600&fit=crop' WHERE slug = 'escape-room-adventure';

-- =============================================
-- APOLOGY SCENARIOS
-- =============================================

-- Heartfelt apology: flowers and heartfelt gesture
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1490806843957-31f4c9a91c65?w=800&h=600&fit=crop' WHERE slug = 'heartfelt-apology';

-- Treasure hunt apology: treasure map and clues
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1553481187-be93c21490a9?w=800&h=600&fit=crop' WHERE slug = 'treasure-hunt-apology';

-- 365 reasons jar: mason jar with colorful paper notes
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1586281380117-5a60ae2050cc?w=800&h=600&fit=crop' WHERE slug = '365-reasons-jar';

-- =============================================
-- HOLIDAY SCENARIOS
-- =============================================

-- New year surprise: fireworks and new year celebration
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1546271876-af6caec5fae5?w=800&h=600&fit=crop' WHERE slug = 'new-year-surprise';

-- Random act of kindness: helping hands and community
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1546032996-6dfacbacbf3f?w=800&h=600&fit=crop' WHERE slug = 'random-act-of-kindness';

-- Bridal bath hamam: Turkish hamam spa setting
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1517502884422-41eaead166d4?w=800&h=600&fit=crop' WHERE slug = 'bridal-bath-hamam';

-- Beach day surprise: sunny beach with umbrellas
UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1473116763249-2faaef81ccda?w=800&h=600&fit=crop' WHERE slug = 'beach-day-surprise';
