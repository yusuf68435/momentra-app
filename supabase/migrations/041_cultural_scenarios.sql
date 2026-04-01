-- ===== CULTURAL SCENARIOS =====
-- Adds cultural_locale column to scenarios and seeds locale-specific surprise ideas
-- for all 17 supported languages.

-- 1. Add column
ALTER TABLE public.scenarios
  ADD COLUMN IF NOT EXISTS cultural_locale TEXT[] DEFAULT '{}';

CREATE INDEX IF NOT EXISTS idx_scenarios_cultural_locale
  ON public.scenarios USING gin(cultural_locale);

-- ─────────────────────────────────────────────────────────────────────────────
-- 2. Seed cultural scenarios
--    Naming convention: slug = 'cultural-<locale>-<short-name>'
-- ─────────────────────────────────────────────────────────────────────────────

-- ── TURKISH (tr) ──────────────────────────────────────────────────────────────

INSERT INTO public.scenarios (
  category_id, slug, title_tr, title_en,
  description_tr, description_en, short_desc_tr, short_desc_en,
  difficulty, min_budget, max_budget, min_people, max_people,
  prep_days, indoor_outdoor, season, tags,
  cover_image_url, is_premium, is_featured, is_active,
  cultural_locale
)
SELECT
  c.id,
  s.slug, s.title_tr, s.title_en,
  s.description_tr, s.description_en, s.short_desc_tr, s.short_desc_en,
  s.difficulty, s.min_budget, s.max_budget, s.min_people, s.max_people,
  s.prep_days, s.indoor_outdoor, s.season::text[], s.tags::text[],
  s.cover_image_url, s.is_premium, s.is_featured, true,
  s.cultural_locale::text[]
FROM (VALUES

  -- TR-1: Türk Kahvesi Falı Sürprizi
  ('holiday','cultural-tr-kahve-fali',
   'Türk Kahvesi Falı Sürprizi','Turkish Coffee Fortune Surprise',
   'Sevdiğinizi geleneksel Türk kahvesi ritüeline davet edin ve fincanın içinde özel bir mesaj gizleyin. Fincan okunurken "falda görüyorum ki..." diyerek evlilik teklifini, sürprizi ya da sevgi ilanınızı yapın. Bakır cezve, el yapımı fincan ve lokum setiyle authentik bir atmosfer yaratın.',
   'Invite your loved one to a traditional Turkish coffee ritual and hide a special message inside the cup. As the fortune is read, reveal your proposal or surprise with "I see in your fortune that...". Create an authentic atmosphere with a copper cezve, handmade cups and Turkish delight.',
   'Fincan falında gizlenen sürpriz','A surprise hidden in a coffee cup fortune',
   2, 300, 1500, 2, 2, 3, 'indoor', '{"all"}', '{"türk kahvesi","fal","romantik","gelenek"}',
   'https://images.unsplash.com/photo-1578374173705-969cbe6f2d6b?w=800&h=600&fit=crop',
   false, true, ARRAY['tr']),

  -- TR-2: Hıdırellez Sürpriz Dileği
  ('holiday','cultural-tr-hidrellez',
   'Hıdırellez Sürpriz Dileği','Hıdırellez Wish Surprise',
   'Hıdırellez gecesinde (5 Mayıs) sevdiğinizle birlikte dilekler yazın ve ateşin üzerinden atlayın. Dilek kağıtlarından birini açtığınızda içinde evlilik teklifinizi veya özel mesajınızı bulacağı bir sürpriz hazırlayın. Geleneksel yiyecekler ve müzikle geceyi unutulmaz kılın.',
   'On Hıdırellez night (May 5) write wishes together and jump over the fire. Prepare a surprise where one of the wish papers reveals your proposal or special message. Make the night unforgettable with traditional foods and music.',
   'Hıdırellez geleneğiyle hayatınızın sürprizini yapın','Make your life''s surprise with the Hıdırellez tradition',
   3, 500, 2000, 2, 10, 7, 'outdoor', '{"spring"}', '{"hıdırellez","bahar","gelenek","dilek"}',
   'https://images.unsplash.com/photo-1513151233558-d860c5398176?w=800&h=600&fit=crop',
   false, false, ARRAY['tr']),

  -- TR-3: Ramazan İftar Sürprizi
  ('romantic','cultural-tr-ramazan-iftar',
   'Ramazan İftar Sürprizi','Ramadan Iftar Surprise',
   'Ramazan''ın manevi havasında sevdiğinize özel bir iftar sofrası hazırlayın. Iftarı beklerken sofrayı gizlice süsleyin, top atışından sonra özel bir mesaj okuyun ya da teklif edin. Geleneksel Ramazan lezzetleri, kandil simidi ve şerbetle dolu bu sofra kalbini fethedecek.',
   'Prepare a special iftar table for your loved one in the spiritual atmosphere of Ramadan. Decorate the table secretly while waiting for iftar, then deliver your special message or proposal after the cannon fires. Traditional Ramadan delicacies, ring-shaped pastries and sherbet will win their heart.',
   'Ramazan sofrasında kalpten gelen sürpriz','A heartfelt surprise at the Ramadan table',
   3, 800, 3000, 2, 20, 5, 'indoor', '{"all"}', '{"ramazan","iftar","gelenek","manevi"}',
   'https://images.unsplash.com/photo-1532634733-cae1395e440f?w=800&h=600&fit=crop',
   false, false, ARRAY['tr']),

  -- TR-4: Kına Gecesi Sürprizi
  ('proposal','cultural-tr-kina-gecesi',
   'Kına Gecesi Sürprizi','Henna Night Surprise',
   'Kına gecesinin duygusal atmosferinde gelinin en yakın arkadaş ve ailesiyle koordineli bir sürpriz planlayın. Kına yakılırken önceden hazırlanmış video mesajlar oynatın, yurt dışındaki yakınların canlı yayınını açın ya da damadın hazırladığı şiir/mektup seslendirilsin. Gelinin ellerindeki kınanın ortasına "Evet" yazan küçük bir not gizleyin.',
   'Plan a coordinated surprise with the bride''s closest friends and family in the emotional atmosphere of a henna night. Play pre-recorded video messages while applying henna, open a live stream of distant relatives, or read aloud a poem or letter prepared by the groom. Hide a small note saying "Yes" in the center of the henna on the bride''s hands.',
   'Kına gecesini unutulmaz kılacak özel sürpriz','A special surprise that will make the henna night unforgettable',
   4, 2000, 8000, 10, 80, 14, 'indoor', '{"all"}', '{"kına","düğün","gelenek","aile"}',
   'https://images.unsplash.com/photo-1595981267035-7b04ca84a82d?w=800&h=600&fit=crop',
   false, true, ARRAY['tr'])

) AS s(category_slug, slug, title_tr, title_en, description_tr, description_en,
       short_desc_tr, short_desc_en, difficulty, min_budget, max_budget,
       min_people, max_people, prep_days, indoor_outdoor, season, tags,
       cover_image_url, is_premium, is_featured, cultural_locale)
JOIN public.categories c ON c.slug = s.category_slug
ON CONFLICT (slug) DO UPDATE SET
  cultural_locale = EXCLUDED.cultural_locale,
  is_active = true;

-- ── ENGLISH / Global (en) ─────────────────────────────────────────────────────

INSERT INTO public.scenarios (
  category_id, slug, title_tr, title_en,
  description_tr, description_en, short_desc_tr, short_desc_en,
  difficulty, min_budget, max_budget, min_people, max_people,
  prep_days, indoor_outdoor, season, tags,
  cover_image_url, is_premium, is_featured, is_active,
  cultural_locale
)
SELECT c.id, s.slug, s.title_tr, s.title_en,
  s.description_tr, s.description_en, s.short_desc_tr, s.short_desc_en,
  s.difficulty, s.min_budget, s.max_budget, s.min_people, s.max_people,
  s.prep_days, s.indoor_outdoor, s.season::text[], s.tags::text[],
  s.cover_image_url, s.is_premium, s.is_featured, true, s.cultural_locale::text[]
FROM (VALUES

  -- EN-1: Pub Quiz Proposal
  ('proposal','cultural-en-pub-quiz-proposal',
   'Pub Yarışmasında Evlilik Teklifi','Pub Quiz Proposal',
   'Sevdiğinizin favori pub''ında özel bir quiz gecesi düzenleyin. Son soruda cevap ekranında "Benimle evlenir misin?" yazısı belirsin. Quiz hostunu önceden bilgilendirin ve arkadaşları hazır tutsun.',
   'Organise a special quiz night at your loved one''s favourite pub. Have the final question answer reveal "Will you marry me?" on screen. Brief the quiz host in advance and have friends ready with the ring.',
   'Quiz sorusunda saklanan teklif','A proposal hidden inside a quiz question',
   3, 2000, 8000, 10, 60, 14, 'indoor', '{"all"}', '{"pub","quiz","teklif","İngiltere"}',
   'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?w=800&h=600&fit=crop',
   false, false, ARRAY['en']),

  -- EN-2: Bonfire Night Surprise
  ('holiday','cultural-en-bonfire-night',
   'Bonfire Night Sürprizi','Bonfire Night Surprise',
   'Guy Fawkes Gecesi''nde (5 Kasım) havai fişeklerin altında sürprizinizi yapın. Özel bir havai fişek gösterisi sipariş edin ve gökyüzünde adını yazın ya da ateşin yanında diz çöküp teklifinizi yapın.',
   'Make your surprise under the fireworks on Guy Fawkes Night (5 November). Commission a personalised firework display spelling out their name in the sky, or drop to one knee by the bonfire to make your proposal.',
   'Havai fişekler altında unutulmaz an','An unforgettable moment under the fireworks',
   4, 5000, 20000, 2, 200, 21, 'outdoor', '{"fall"}', '{"bonfire night","havai fişek","İngiltere","romantik"}',
   'https://images.unsplash.com/photo-1533230408708-8f9f91d1235a?w=800&h=600&fit=crop',
   false, false, ARRAY['en'])

) AS s(category_slug, slug, title_tr, title_en, description_tr, description_en,
       short_desc_tr, short_desc_en, difficulty, min_budget, max_budget,
       min_people, max_people, prep_days, indoor_outdoor, season, tags,
       cover_image_url, is_premium, is_featured, cultural_locale)
JOIN public.categories c ON c.slug = s.category_slug
ON CONFLICT (slug) DO UPDATE SET cultural_locale = EXCLUDED.cultural_locale, is_active = true;

-- ── JAPANESE (ja) ─────────────────────────────────────────────────────────────

INSERT INTO public.scenarios (
  category_id, slug, title_tr, title_en,
  description_tr, description_en, short_desc_tr, short_desc_en,
  difficulty, min_budget, max_budget, min_people, max_people,
  prep_days, indoor_outdoor, season, tags,
  cover_image_url, is_premium, is_featured, is_active,
  cultural_locale
)
SELECT c.id, s.slug, s.title_tr, s.title_en,
  s.description_tr, s.description_en, s.short_desc_tr, s.short_desc_en,
  s.difficulty, s.min_budget, s.max_budget, s.min_people, s.max_people,
  s.prep_days, s.indoor_outdoor, s.season::text[], s.tags::text[],
  s.cover_image_url, s.is_premium, s.is_featured, true, s.cultural_locale::text[]
FROM (VALUES

  -- JA-1: Hanami Picnic Proposal
  ('romantic','cultural-ja-hanami-proposal',
   'Hanami Kiraz Çiçeği Teklifi','Hanami Cherry Blossom Proposal',
   'Kiraz çiçeklerinin en güzel açtığı günde (Mart-Nisan) sevdiğinizi geleneksel bir Hanami pikniğine götürün. Pembe kiraz çiçekleri altında hazırladığınız özel bento kutusunun içine yüzüğü ya da teklifinizi saklayın. Sakura ağaçları altındaki bu büyülü anı ömür boyu hatırlayacak.',
   'On the peak day of cherry blossom season (March–April), take your loved one to a traditional Hanami picnic. Hide the ring or your proposal inside a special bento box you have prepared under the pink sakura petals. They will remember this magical moment under the cherry trees for a lifetime.',
   'Kiraz çiçekleri altında romantik Japon teklifi','Romantic Japanese proposal under cherry blossoms',
   3, 3000, 10000, 2, 4, 14, 'outdoor', '{"spring"}', '{"hanami","sakura","japon","romantik","piknik"}',
   'https://images.unsplash.com/photo-1522383225653-ed111181a951?w=800&h=600&fit=crop',
   false, true, ARRAY['ja']),

  -- JA-2: Tanabata Star Festival Surprise
  ('holiday','cultural-ja-tanabata',
   'Tanabata Yıldız Festivali Sürprizi','Tanabata Star Festival Surprise',
   'Tanabata''da (7 Temmuz) birlikte dilek dilekleri yazın. Bambu dalına astığınız tanzakuların (renkli kağıt şeritler) arasına özel bir mesaj saklayın. Geleneksel yukata kıyafetleriyle festivale gidin ve yıldızların altında sürprizinizi açıklayın.',
   'On Tanabata (7 July), write wishes together. Hide a special message among the tanzaku (coloured paper strips) you hang on the bamboo branch. Visit the festival in traditional yukata and reveal your surprise under the stars.',
   'Yıldız festivalinde gizlenen dilek','A wish hidden at the star festival',
   2, 1500, 6000, 2, 2, 7, 'outdoor', '{"summer"}', '{"tanabata","yıldız","japon","gelenek","dilekler"}',
   'https://images.unsplash.com/photo-1536098561742-ca998e48cbcc?w=800&h=600&fit=crop',
   false, false, ARRAY['ja']),

  -- JA-3: Omakase Birthday Dinner
  ('birthday','cultural-ja-omakase-dinner',
   'Omakase Doğum Günü Akşam Yemeği','Omakase Birthday Dinner',
   'Sevdiğiniz için tüm detayları şefe bırakın: en iyi omakase restoranını rezerve edin ve şefe doğum gününü ve tercihlerini bildirin. Her tabak servis edilirken özel bir mesajı şef okusun. Japon estetiğinin en saf haliyle sunulan bu deneyim ömür boyu akılda kalır.',
   'Leave every detail to the chef for your loved one: reserve the finest omakase restaurant and inform the chef about the birthday and preferences. Have the chef read a special message with each course. This experience presented in the purest Japanese aesthetic will be remembered for a lifetime.',
   'Şefe bırakılan özel doğum günü deneyimi','A special birthday experience entrusted to the chef',
   4, 10000, 40000, 2, 2, 21, 'indoor', '{"all"}', '{"omakase","japon","suşi","doğum günü","gastronomi"}',
   'https://images.unsplash.com/photo-1553621042-f6e147245754?w=800&h=600&fit=crop',
   true, false, ARRAY['ja'])

) AS s(category_slug, slug, title_tr, title_en, description_tr, description_en,
       short_desc_tr, short_desc_en, difficulty, min_budget, max_budget,
       min_people, max_people, prep_days, indoor_outdoor, season, tags,
       cover_image_url, is_premium, is_featured, cultural_locale)
JOIN public.categories c ON c.slug = s.category_slug
ON CONFLICT (slug) DO UPDATE SET cultural_locale = EXCLUDED.cultural_locale, is_active = true;

-- ── KOREAN (ko) ───────────────────────────────────────────────────────────────

INSERT INTO public.scenarios (
  category_id, slug, title_tr, title_en,
  description_tr, description_en, short_desc_tr, short_desc_en,
  difficulty, min_budget, max_budget, min_people, max_people,
  prep_days, indoor_outdoor, season, tags,
  cover_image_url, is_premium, is_featured, is_active,
  cultural_locale
)
SELECT c.id, s.slug, s.title_tr, s.title_en,
  s.description_tr, s.description_en, s.short_desc_tr, s.short_desc_en,
  s.difficulty, s.min_budget, s.max_budget, s.min_people, s.max_people,
  s.prep_days, s.indoor_outdoor, s.season::text[], s.tags::text[],
  s.cover_image_url, s.is_premium, s.is_featured, true, s.cultural_locale::text[]
FROM (VALUES

  -- KO-1: 100-Day Anniversary (백일)
  ('anniversary','cultural-ko-100-day',
   '100. Gün Kutlaması (Paegil)','100-Day Anniversary Celebration (Paegil)',
   'Kore geleneğinde 백일 (paegil) ilişkinin 100. günüdür ve büyük önem taşır. Çiftin tanışma anından bugüne kadar 100 fotoğrafını hazırlayın, 100 küçük mektup yazın ve favori restoranı rezerve edin. Polaroid fotoğraf albümü ve kişiselleştirilmiş çift yüzüğü hediye edin.',
   'In Korean tradition, 백일 (paegil) marks the 100th day of a relationship and carries great significance. Prepare 100 photos from the couple''s first meeting to today, write 100 small letters, and reserve their favourite restaurant. Gift a Polaroid photo album and personalised couple rings.',
   'İlişkinizin 100. gününü Kore geleneğiyle kutlayın','Celebrate your 100th day with Korean tradition',
   4, 5000, 20000, 2, 2, 14, 'both', '{"all"}', '{"100 gün","paegil","kore","çift","gelenek"}',
   'https://images.unsplash.com/photo-1518568814500-bf0f8d125f46?w=800&h=600&fit=crop',
   false, true, ARRAY['ko']),

  -- KO-2: Chuseok Family Surprise
  ('holiday','cultural-ko-chuseok',
   'Chuseok Aile Sürprizi','Chuseok Family Surprise',
   'Kore''nin en önemli hasat festivali Chuseok''ta (Eylül-Ekim) aileyi bir araya getirin. Geleneksel songpyeon (pirinç keki) yapımını sürpriz bir aktiviteye dönüştürün. Hanbok giyin, atalar için jesa töreni yapın ve aile büyüklerini mutlu edecek bir sürpriz hediye sunun.',
   'Bring the family together for Chuseok (September–October), Korea''s most important harvest festival. Turn the making of traditional songpyeon (rice cakes) into a surprise activity. Wear hanbok, hold the jesa ceremony for ancestors, and present a surprise gift that will delight the family elders.',
   'Kore hasat bayramında aile sürprizi','Family surprise at Korea''s harvest festival',
   3, 3000, 12000, 5, 30, 10, 'both', '{"fall"}', '{"chuseok","kore","aile","hasat","hanbok"}',
   'https://images.unsplash.com/photo-1551659510-b39a6a31ad7a?w=800&h=600&fit=crop',
   false, false, ARRAY['ko']),

  -- KO-3: K-Drama Style Proposal
  ('proposal','cultural-ko-kdrama-proposal',
   'K-Drama Tarzı Evlilik Teklifi','K-Drama Style Proposal',
   'Gerçek bir K-drama sahnesini yaşatın: yağmurda dans, ışıklandırılmış çatı katı ya da gökyüzü gözlem kulesi. Sevdiğinizin favori K-drama dizisinden bir sahneyi yeniden canlandırın. Arkadaşlar çevreyi hazırlasın, kameraman her anı çeksin ve teklif anı sonrasında büyük bir kutlama partisi sürpriz olsun.',
   'Create a real K-drama scene: dancing in the rain, an illuminated rooftop or sky observation tower. Re-enact a scene from your loved one''s favourite K-drama series. Have friends prepare the setting, a cameraman capture every moment, and after the proposal a big celebration party is the surprise.',
   'Favori K-drama sahnenizi gerçeğe taşıyın','Bring your favourite K-drama scene to life',
   5, 10000, 35000, 2, 20, 21, 'both', '{"all"}', '{"k-drama","kore","teklif","sinema","romantik"}',
   'https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=800&h=600&fit=crop',
   true, true, ARRAY['ko'])

) AS s(category_slug, slug, title_tr, title_en, description_tr, description_en,
       short_desc_tr, short_desc_en, difficulty, min_budget, max_budget,
       min_people, max_people, prep_days, indoor_outdoor, season, tags,
       cover_image_url, is_premium, is_featured, cultural_locale)
JOIN public.categories c ON c.slug = s.category_slug
ON CONFLICT (slug) DO UPDATE SET cultural_locale = EXCLUDED.cultural_locale, is_active = true;

-- ── ARABIC (ar) ───────────────────────────────────────────────────────────────

INSERT INTO public.scenarios (
  category_id, slug, title_tr, title_en,
  description_tr, description_en, short_desc_tr, short_desc_en,
  difficulty, min_budget, max_budget, min_people, max_people,
  prep_days, indoor_outdoor, season, tags,
  cover_image_url, is_premium, is_featured, is_active,
  cultural_locale
)
SELECT c.id, s.slug, s.title_tr, s.title_en,
  s.description_tr, s.description_en, s.short_desc_tr, s.short_desc_en,
  s.difficulty, s.min_budget, s.max_budget, s.min_people, s.max_people,
  s.prep_days, s.indoor_outdoor, s.season::text[], s.tags::text[],
  s.cover_image_url, s.is_premium, s.is_featured, true, s.cultural_locale::text[]
FROM (VALUES

  -- AR-1: Eid Gift Surprise
  ('holiday','cultural-ar-eid-surprise',
   'Eid Sürpriz Hediyesi','Eid Gift Surprise',
   'Ramazan Bayramı ya da Kurban Bayramı''nda aile büyüklerine ya da sevdiklerinize özel bir hediye sürprizi hazırlayın. Geleneksel Eid zarfına (eidiyet) ek olarak kişiselleştirilmiş bir hediye, hatıra albümü ya da özel bir deneyim sunun. Bayram ziyareti sırasında büyük bir aile toplantısıyla sürpriz kutuyu açtırın.',
   'Prepare a special gift surprise for elders or loved ones on Eid al-Fitr or Eid al-Adha. In addition to the traditional Eid envelope (eidiyet), offer a personalised gift, a memory album or a special experience. Have the surprise box opened at a large family gathering during the Eid visit.',
   'Bayramda aile büyüklerine özel sürpriz','A special surprise for family elders at Eid',
   2, 1000, 5000, 5, 50, 7, 'indoor', '{"all"}', '{"bayram","eid","arap","aile","gelenek"}',
   'https://images.unsplash.com/photo-1532634733-cae1395e440f?w=800&h=600&fit=crop',
   false, false, ARRAY['ar']),

  -- AR-2: Desert Night Proposal
  ('proposal','cultural-ar-desert-proposal',
   'Çöl Gecesi Evlilik Teklifi','Desert Night Proposal',
   'Çöldeki Bedevi geleneğinden ilham alarak kumul üzerinde özel bir çadır kurun. Sema yıldızları altında halı serilmiş çölde tek başınıza olun. Geleneksel Arap kahvesi ve hurma ikramından sonra teklif edin. Gökyüzündeki yıldızlar ne Şehrazat masallarını hatırlatır ne de bu anı.',
   'Inspired by Bedouin tradition, set up a special tent on the sand dunes. Be alone together on a carpeted desert floor under a sky full of stars. Propose after serving traditional Arabic coffee and dates. Neither the stars in the sky nor the tales of Scheherazade will rival this moment.',
   'Yıldızlı çöl gecesinde teklif','A proposal on a starlit desert night',
   4, 8000, 30000, 2, 2, 14, 'outdoor', '{"all"}', '{"çöl","arap","teklif","romantik","yıldız"}',
   'https://images.unsplash.com/photo-1509316785289-025f5b846b35?w=800&h=600&fit=crop',
   true, true, ARRAY['ar']),

  -- AR-3: Iftar Flash Mob
  ('romantic','cultural-ar-iftar-flashmob',
   'İftar Anında Flash Mob','Iftar Flash Mob',
   'Ramazan''da sevdiğinize özel bir iftar sürprizi: şehrin en güzel restoranını veya terasını ayırtın, arkadaş ve aile üyelerini gizlice davet edin, top atışı anında bir flash mob ya da özel müzik performansıyla sürprizi ortaya çıkarın.',
   'A special Ramadan iftar surprise: book the most beautiful restaurant or terrace in the city, secretly invite friends and family, and at the moment of the cannon shot reveal the surprise with a flash mob or special music performance.',
   'İftar anında beklenmedik sürpriz','An unexpected surprise at the iftar moment',
   4, 5000, 20000, 2, 30, 14, 'both', '{"all"}', '{"ramazan","iftar","flash mob","arap","romantik"}',
   'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800&h=600&fit=crop',
   false, false, ARRAY['ar'])

) AS s(category_slug, slug, title_tr, title_en, description_tr, description_en,
       short_desc_tr, short_desc_en, difficulty, min_budget, max_budget,
       min_people, max_people, prep_days, indoor_outdoor, season, tags,
       cover_image_url, is_premium, is_featured, cultural_locale)
JOIN public.categories c ON c.slug = s.category_slug
ON CONFLICT (slug) DO UPDATE SET cultural_locale = EXCLUDED.cultural_locale, is_active = true;

-- ── GERMAN (de) ───────────────────────────────────────────────────────────────

INSERT INTO public.scenarios (
  category_id, slug, title_tr, title_en,
  description_tr, description_en, short_desc_tr, short_desc_en,
  difficulty, min_budget, max_budget, min_people, max_people,
  prep_days, indoor_outdoor, season, tags,
  cover_image_url, is_premium, is_featured, is_active,
  cultural_locale
)
SELECT c.id, s.slug, s.title_tr, s.title_en,
  s.description_tr, s.description_en, s.short_desc_tr, s.short_desc_en,
  s.difficulty, s.min_budget, s.max_budget, s.min_people, s.max_people,
  s.prep_days, s.indoor_outdoor, s.season::text[], s.tags::text[],
  s.cover_image_url, s.is_premium, s.is_featured, true, s.cultural_locale::text[]
FROM (VALUES

  -- DE-1: Oktoberfest Proposal
  ('proposal','cultural-de-oktoberfest-proposal',
   'Oktoberfest Evlilik Teklifi','Oktoberfest Proposal',
   'Münih Oktoberfest''inde geleneksel bir bira çadırı rezervasyonu yapın. Bira bardaklarını kaldırırken sevdiğinize özel yazılmış bir bardak sunun: "Ich liebe dich — Willst du mich heiraten?" Lederhosen ya da dirndl giyen bir grup arkadaş sürprizi kutlasın.',
   'Book a traditional beer tent at Munich Oktoberfest. As the steins are raised, present your loved one with a specially engraved mug reading "Ich liebe dich — Willst du mich heiraten?" Have a group of friends dressed in lederhosen or dirndl celebrate the surprise.',
   'Bira festivalinde kalpten gelen teklif','A heartfelt proposal at the beer festival',
   4, 10000, 40000, 2, 30, 30, 'indoor', '{"fall"}', '{"oktoberfest","münih","alman","teklif","bira"}',
   'https://images.unsplash.com/photo-1505935428862-770b6f24f629?w=800&h=600&fit=crop',
   false, true, ARRAY['de']),

  -- DE-2: Weihnachtsmarkt Surprise
  ('holiday','cultural-de-weihnachtsmarkt',
   'Noel Pazarı Sürprizi','Christmas Market Surprise',
   'Almanya''nın büyülü Noel pazarlarında (Weihnachtsmarkt) sevdiğinize özel bir gece planlayın. Glühwein (sıcak şarap) ve Lebkuchen (zencefilli kurabiye) eşliğinde yürürken bir noktada durun ve hazırladığınız sürprizi açıklayın. Arkadaşlar çevreyi ışıklarla süslemiş olsun.',
   'Plan a special evening for your loved one at one of Germany''s magical Christmas markets (Weihnachtsmarkt). While strolling with Glühwein (mulled wine) and Lebkuchen (gingerbread), stop at a chosen spot and reveal your surprise. Have friends decorate the surroundings with fairy lights.',
   'Noel pazarı büyüsünde sürpriz','A surprise in the magic of the Christmas market',
   3, 3000, 12000, 2, 10, 14, 'outdoor', '{"winter"}', '{"weihnachtsmarkt","noel pazarı","alman","romantik","kış"}',
   'https://images.unsplash.com/photo-1512389142860-9c449e58a543?w=800&h=600&fit=crop',
   false, false, ARRAY['de'])

) AS s(category_slug, slug, title_tr, title_en, description_tr, description_en,
       short_desc_tr, short_desc_en, difficulty, min_budget, max_budget,
       min_people, max_people, prep_days, indoor_outdoor, season, tags,
       cover_image_url, is_premium, is_featured, cultural_locale)
JOIN public.categories c ON c.slug = s.category_slug
ON CONFLICT (slug) DO UPDATE SET cultural_locale = EXCLUDED.cultural_locale, is_active = true;

-- ── FRENCH (fr) ───────────────────────────────────────────────────────────────

INSERT INTO public.scenarios (
  category_id, slug, title_tr, title_en,
  description_tr, description_en, short_desc_tr, short_desc_en,
  difficulty, min_budget, max_budget, min_people, max_people,
  prep_days, indoor_outdoor, season, tags,
  cover_image_url, is_premium, is_featured, is_active,
  cultural_locale
)
SELECT c.id, s.slug, s.title_tr, s.title_en,
  s.description_tr, s.description_en, s.short_desc_tr, s.short_desc_en,
  s.difficulty, s.min_budget, s.max_budget, s.min_people, s.max_people,
  s.prep_days, s.indoor_outdoor, s.season::text[], s.tags::text[],
  s.cover_image_url, s.is_premium, s.is_featured, true, s.cultural_locale::text[]
FROM (VALUES

  -- FR-1: Eiffel Tower Proposal
  ('proposal','cultural-fr-eiffel-proposal',
   'Eyfel Kulesi''nde Evlilik Teklifi','Eiffel Tower Proposal',
   'Paris''in kalbinde romantizmin zirvesi: Eyfel Kulesi''nin 2. katında akşam yemeği rezervasyonu yapın. Işık gösterisi sırasında (her saat başı) yüzüğü çıkarın ve teklifinizi yapın. Özel bir fotoğrafçı anı ölümsüzleştirsin. Ardından Seine nehri boyunca şampanya eşliğinde gece yürüyüşü.',
   'The pinnacle of romance at the heart of Paris: book a dinner reservation on the 2nd floor of the Eiffel Tower. During the light show (every hour on the hour) take out the ring and make your proposal. Have a private photographer immortalise the moment. Then a night stroll along the Seine with champagne.',
   'Paris''in kalbinde ölümsüz teklif','An immortal proposal at the heart of Paris',
   5, 20000, 80000, 2, 2, 30, 'outdoor', '{"all"}', '{"eyfel","paris","fransız","teklif","romantik"}',
   'https://images.unsplash.com/photo-1511739001486-6bfe10ce785f?w=800&h=600&fit=crop',
   true, true, ARRAY['fr']),

  -- FR-2: Bastille Day Surprise
  ('holiday','cultural-fr-bastille',
   'Bastille Günü Havai Fişek Sürprizi','Bastille Day Fireworks Surprise',
   '14 Temmuz Fransız Milli Bayramı''nda Eyfel Kulesi havai fişekleri eşliğinde sürprizinizi planlayın. Champ de Mars''ta özel bir piknik alanı rezerve edin. Fransız şarabı, peyniri ve taze baguette eşliğinde gökyüzü ışığa boğulurken teklifinizi yapın ya da yıllık sürprizinizi açıklayın.',
   'Plan your surprise against the Eiffel Tower fireworks on 14 July, France''s national holiday. Reserve a private picnic spot at Champ de Mars. As the sky fills with light over French wine, cheese and fresh baguette, make your proposal or reveal your annual surprise.',
   'Fransız milli bayramında gökyüzü altında sürpriz','A surprise under the sky on France''s national day',
   4, 8000, 25000, 2, 6, 14, 'outdoor', '{"summer"}', '{"bastille","14 temmuz","fransız","havai fişek","romantik"}',
   'https://images.unsplash.com/photo-1549144511-f099e773c147?w=800&h=600&fit=crop',
   false, false, ARRAY['fr'])

) AS s(category_slug, slug, title_tr, title_en, description_tr, description_en,
       short_desc_tr, short_desc_en, difficulty, min_budget, max_budget,
       min_people, max_people, prep_days, indoor_outdoor, season, tags,
       cover_image_url, is_premium, is_featured, cultural_locale)
JOIN public.categories c ON c.slug = s.category_slug
ON CONFLICT (slug) DO UPDATE SET cultural_locale = EXCLUDED.cultural_locale, is_active = true;

-- ── SPANISH (es) ──────────────────────────────────────────────────────────────

INSERT INTO public.scenarios (
  category_id, slug, title_tr, title_en,
  description_tr, description_en, short_desc_tr, short_desc_en,
  difficulty, min_budget, max_budget, min_people, max_people,
  prep_days, indoor_outdoor, season, tags,
  cover_image_url, is_premium, is_featured, is_active,
  cultural_locale
)
SELECT c.id, s.slug, s.title_tr, s.title_en,
  s.description_tr, s.description_en, s.short_desc_tr, s.short_desc_en,
  s.difficulty, s.min_budget, s.max_budget, s.min_people, s.max_people,
  s.prep_days, s.indoor_outdoor, s.season::text[], s.tags::text[],
  s.cover_image_url, s.is_premium, s.is_featured, true, s.cultural_locale::text[]
FROM (VALUES

  -- ES-1: La Tomatina Flash Mob
  ('holiday','cultural-es-tomatina-surprise',
   'La Tomatina Festivali Sürprizi','La Tomatina Festival Surprise',
   'Valencialı domates festivalinin coşkusunda, domates savaşı sonrası yıkanırken sevdiğinize sürpriz teklifinizi yapın. Temizlendikten sonra önceden hazırladığınız özel akşam yemeğine gidin. Eğer İspanya''da değilseniz evde küçük bir "domates gecesi" teması ile aynı ruhunu yaratın.',
   'In the spirit of Valencia''s tomato festival, make your surprise proposal to your loved one while washing off after the tomato fight. Then head to the special dinner you have prepared in advance. If you are not in Spain, recreate the same spirit at home with a small "tomato night" theme.',
   'Domates festivali ruhunda sürpriz teklif','A surprise proposal in the spirit of the tomato festival',
   3, 5000, 20000, 2, 100, 21, 'outdoor', '{"summer"}', '{"tomatina","ispanya","festival","romantik","eğlence"}',
   'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800&h=600&fit=crop',
   false, false, ARRAY['es']),

  -- ES-2: Flamenco Night Proposal
  ('romantic','cultural-es-flamenco-proposal',
   'Flamenko Gecesi Evlilik Teklifi','Flamenco Night Proposal',
   'Seville ya da Granada''nın en iyi flamenko tavernasını rezerve edin. Performans ortasında dans grubunu duraklatın ve sahneye çıkarak teklifinizi yapın. Flamenko müziği eşliğinde dansa kalkın ve gecenin geri kalanı kutlama olsun. Dans bilmesaniz bile bu jest yürekten geliyorsa mükemmeldir.',
   'Reserve the best flamenco tablao in Seville or Granada. Pause the dance troupe mid-performance and step on stage to make your proposal. Dance to the flamenco music and let the rest of the night be a celebration. Even if you cannot dance, this gesture is perfect if it comes from the heart.',
   'Ateşli flamenko gecesinde teklif','A proposal on a fiery flamenco night',
   5, 8000, 30000, 2, 30, 21, 'indoor', '{"all"}', '{"flamenko","ispanya","teklif","dans","romantik"}',
   'https://images.unsplash.com/photo-1518548419970-58e3b4079ab2?w=800&h=600&fit=crop',
   true, true, ARRAY['es'])

) AS s(category_slug, slug, title_tr, title_en, description_tr, description_en,
       short_desc_tr, short_desc_en, difficulty, min_budget, max_budget,
       min_people, max_people, prep_days, indoor_outdoor, season, tags,
       cover_image_url, is_premium, is_featured, cultural_locale)
JOIN public.categories c ON c.slug = s.category_slug
ON CONFLICT (slug) DO UPDATE SET cultural_locale = EXCLUDED.cultural_locale, is_active = true;

-- ── ITALIAN (it) ──────────────────────────────────────────────────────────────

INSERT INTO public.scenarios (
  category_id, slug, title_tr, title_en,
  description_tr, description_en, short_desc_tr, short_desc_en,
  difficulty, min_budget, max_budget, min_people, max_people,
  prep_days, indoor_outdoor, season, tags,
  cover_image_url, is_premium, is_featured, is_active,
  cultural_locale
)
SELECT c.id, s.slug, s.title_tr, s.title_en,
  s.description_tr, s.description_en, s.short_desc_tr, s.short_desc_en,
  s.difficulty, s.min_budget, s.max_budget, s.min_people, s.max_people,
  s.prep_days, s.indoor_outdoor, s.season::text[], s.tags::text[],
  s.cover_image_url, s.is_premium, s.is_featured, true, s.cultural_locale::text[]
FROM (VALUES

  -- IT-1: Venice Gondola Proposal
  ('proposal','cultural-it-gondola-proposal',
   'Venedik Gondolunda Evlilik Teklifi','Venice Gondola Proposal',
   'Venedik''in dar kanallarında özel bir gondol turu rezerve edin. Gondolcu geleneksel İtalyan şarkıları söylerken Rialto Köprüsü altından geçtiğinizde yüzüğü çıkarın. Önceden akordeon çalanı da gondola ekleyin. Bu an sinema filmlerinin bile kıskandığı bir an olacak.',
   'Reserve a private gondola tour through Venice''s narrow canals. As the gondolier sings traditional Italian songs and you pass under the Rialto Bridge, take out the ring. Add an accordion player to the gondola in advance. This moment will make even films jealous.',
   'Kanal şehri Venedik''te romantik teklif','A romantic proposal in the canal city of Venice',
   5, 15000, 50000, 2, 2, 30, 'outdoor', '{"all"}', '{"venedik","gondol","italyan","teklif","romantik"}',
   'https://images.unsplash.com/photo-1514890547357-a9ee288728e0?w=800&h=600&fit=crop',
   true, true, ARRAY['it']),

  -- IT-2: Ferragosto Family Feast
  ('holiday','cultural-it-ferragosto',
   'Ferragosto Aile Şöleni','Ferragosto Family Feast',
   'İtalyanların büyük yaz bayramı Ferragosto''da (15 Ağustos) aile için özel bir deniz kenarı şöleni hazırlayın. Nonna''nın tarifleriyle hazırlanmış ev yemekleri, taze deniz mahsulleri ve İtalyan şarabıyla dolu sofrada aile sürprizini açıklayın: bir bebek haberi, bir evlilik teklifi ya da büyük bir başarı.',
   'For Ferragosto (15 August), Italy''s great summer holiday, prepare a special seaside feast for the family. Reveal the family surprise at a table filled with home-cooked dishes made from Nonna''s recipes, fresh seafood and Italian wine: a baby announcement, a marriage proposal or a great achievement.',
   'İtalyan yaz bayramında aile sürprizi','A family surprise on Italy''s summer holiday',
   3, 5000, 20000, 5, 30, 14, 'outdoor', '{"summer"}', '{"ferragosto","italya","aile","yaz","deniz"}',
   'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800&h=600&fit=crop',
   false, false, ARRAY['it'])

) AS s(category_slug, slug, title_tr, title_en, description_tr, description_en,
       short_desc_tr, short_desc_en, difficulty, min_budget, max_budget,
       min_people, max_people, prep_days, indoor_outdoor, season, tags,
       cover_image_url, is_premium, is_featured, cultural_locale)
JOIN public.categories c ON c.slug = s.category_slug
ON CONFLICT (slug) DO UPDATE SET cultural_locale = EXCLUDED.cultural_locale, is_active = true;

-- ── PORTUGUESE (pt) ───────────────────────────────────────────────────────────

INSERT INTO public.scenarios (
  category_id, slug, title_tr, title_en,
  description_tr, description_en, short_desc_tr, short_desc_en,
  difficulty, min_budget, max_budget, min_people, max_people,
  prep_days, indoor_outdoor, season, tags,
  cover_image_url, is_premium, is_featured, is_active,
  cultural_locale
)
SELECT c.id, s.slug, s.title_tr, s.title_en,
  s.description_tr, s.description_en, s.short_desc_tr, s.short_desc_en,
  s.difficulty, s.min_budget, s.max_budget, s.min_people, s.max_people,
  s.prep_days, s.indoor_outdoor, s.season::text[], s.tags::text[],
  s.cover_image_url, s.is_premium, s.is_featured, true, s.cultural_locale::text[]
FROM (VALUES

  -- PT-1: Fado Night Surprise
  ('romantic','cultural-pt-fado-night',
   'Fado Gecesi Sürprizi','Fado Night Surprise',
   'Lizbon''un tarihi Alfama semtindeki en iyi fado evinde özel bir masa rezerve edin. Fado şarkıcısı kederli ama güzel sesini yükseltirken sevdiğinize el yazısıyla yazılmış bir mektup sunun. Portekiz şarabı ve pasteis de nata eşliğinde geçecek bu gece "saudade" ruhunu tam yaşatır.',
   'Reserve a special table at the best fado house in Lisbon''s historic Alfama district. As the fado singer raises their melancholy but beautiful voice, present your loved one with a handwritten letter. This evening with Portuguese wine and pasteis de nata will fully capture the spirit of "saudade".',
   'Saudade ruhuyla fado gecesi sürprizi','A fado night surprise with the spirit of saudade',
   3, 4000, 15000, 2, 6, 14, 'indoor', '{"all"}', '{"fado","portekiz","lizbon","romantik","müzik"}',
   'https://images.unsplash.com/photo-1555881400-74d7acaacd8b?w=800&h=600&fit=crop',
   false, true, ARRAY['pt']),

  -- PT-2: Carnival Rio Surprise
  ('holiday','cultural-pt-carnival-rio',
   'Rio Karnaval Sürprizi','Rio Carnival Surprise',
   'Brezilya karnavalının büyüsünde ya da evde düzenleyeceğiniz Rio temalı bir gecede sürprizinizi yapın. Samba müziği, renkli kostümler ve Caipirinha eşliğinde başlayan gecenin sonunda teklifinizi ya da büyük haberinizi açıklayın.',
   'Deliver your surprise in the magic of the Brazilian carnival or at a Rio-themed evening you organise at home. End the evening of samba music, colourful costumes and Caipirinha with your proposal or big announcement.',
   'Samba ritmiyle sürpriz an','A surprise moment to the samba rhythm',
   4, 5000, 20000, 2, 20, 14, 'both', '{"winter"}', '{"karnaval","brezilya","samba","renkli","eğlence"}',
   'https://images.unsplash.com/photo-1518639192441-8fce0a366e2e?w=800&h=600&fit=crop',
   false, false, ARRAY['pt'])

) AS s(category_slug, slug, title_tr, title_en, description_tr, description_en,
       short_desc_tr, short_desc_en, difficulty, min_budget, max_budget,
       min_people, max_people, prep_days, indoor_outdoor, season, tags,
       cover_image_url, is_premium, is_featured, cultural_locale)
JOIN public.categories c ON c.slug = s.category_slug
ON CONFLICT (slug) DO UPDATE SET cultural_locale = EXCLUDED.cultural_locale, is_active = true;

-- ── RUSSIAN (ru) ──────────────────────────────────────────────────────────────

INSERT INTO public.scenarios (
  category_id, slug, title_tr, title_en,
  description_tr, description_en, short_desc_tr, short_desc_en,
  difficulty, min_budget, max_budget, min_people, max_people,
  prep_days, indoor_outdoor, season, tags,
  cover_image_url, is_premium, is_featured, is_active,
  cultural_locale
)
SELECT c.id, s.slug, s.title_tr, s.title_en,
  s.description_tr, s.description_en, s.short_desc_tr, s.short_desc_en,
  s.difficulty, s.min_budget, s.max_budget, s.min_people, s.max_people,
  s.prep_days, s.indoor_outdoor, s.season::text[], s.tags::text[],
  s.cover_image_url, s.is_premium, s.is_featured, true, s.cultural_locale::text[]
FROM (VALUES

  -- RU-1: Banya Surprise Evening
  ('romantic','cultural-ru-banya-evening',
   'Banya Sürpriz Akşamı','Banya Surprise Evening',
   'Rus saunası banya''da özel bir akşam planlayın. Huş ağacı dallarıyla masaj, soğuk havuz seansları ve ardından geleneksel boş sandalla açık hava. Banya sonrası hazırladığınız özel akşam yemeği sofrasında sürprizinizi açıklayın. Rus geleneğinde banya paylaşmak derin bir güven ifadesidir.',
   'Plan a special evening at a Russian banya sauna. Birch branch massage, cold plunge sessions and then open air with a traditional empty-belly. Reveal your surprise at the special dinner table you have prepared after the banya. In Russian tradition, sharing a banya is a profound expression of trust.',
   'Rus geleneğinde banya ve sürpriz','Banya and surprise in Russian tradition',
   3, 3000, 10000, 2, 6, 7, 'indoor', '{"all"}', '{"banya","rus","sauna","gelenek","romantik"}',
   'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800&h=600&fit=crop',
   false, false, ARRAY['ru']),

  -- RU-2: New Year (Novy God) Surprise
  ('holiday','cultural-ru-novy-god',
   'Rus Yeni Yılı (Novy God) Sürprizi','Russian New Year (Novy God) Surprise',
   'Rusya''da Noel değil Novy God (Yeni Yıl, 31 Aralık) kutlanır ve yılın en büyük kutlamasıdır. Ded Moroz ve Snegurochka kostümleriyle aile çocuklarına sürpriz hediyeler getirin. Gece yarısı sayım sırasında şampanya kadehinin içine saklanmış bir yüzük ya da mektupla teklifinizi yapın.',
   'In Russia it is not Christmas but Novy God (New Year, 31 December) that is celebrated as the biggest event of the year. Bring surprise gifts for the family''s children dressed as Ded Moroz and Snegurochka. Make your proposal at midnight with a ring or letter hidden inside the champagne glass.',
   'Novy God sayımında beklenmedik teklif','An unexpected proposal at the Novy God countdown',
   3, 5000, 20000, 2, 20, 21, 'indoor', '{"winter"}', '{"novy god","yeni yıl","rus","gelenek","kış"}',
   'https://images.unsplash.com/photo-1467810563316-b5af368dc70c?w=800&h=600&fit=crop',
   false, false, ARRAY['ru'])

) AS s(category_slug, slug, title_tr, title_en, description_tr, description_en,
       short_desc_tr, short_desc_en, difficulty, min_budget, max_budget,
       min_people, max_people, prep_days, indoor_outdoor, season, tags,
       cover_image_url, is_premium, is_featured, cultural_locale)
JOIN public.categories c ON c.slug = s.category_slug
ON CONFLICT (slug) DO UPDATE SET cultural_locale = EXCLUDED.cultural_locale, is_active = true;

-- ── HINDI (hi) ────────────────────────────────────────────────────────────────

INSERT INTO public.scenarios (
  category_id, slug, title_tr, title_en,
  description_tr, description_en, short_desc_tr, short_desc_en,
  difficulty, min_budget, max_budget, min_people, max_people,
  prep_days, indoor_outdoor, season, tags,
  cover_image_url, is_premium, is_featured, is_active,
  cultural_locale
)
SELECT c.id, s.slug, s.title_tr, s.title_en,
  s.description_tr, s.description_en, s.short_desc_tr, s.short_desc_en,
  s.difficulty, s.min_budget, s.max_budget, s.min_people, s.max_people,
  s.prep_days, s.indoor_outdoor, s.season::text[], s.tags::text[],
  s.cover_image_url, s.is_premium, s.is_featured, true, s.cultural_locale::text[]
FROM (VALUES

  -- HI-1: Diwali Surprise
  ('holiday','cultural-hi-diwali-surprise',
   'Diwali Işık Festivali Sürprizi','Diwali Festival of Lights Surprise',
   'Işıklar bayramı Diwali''de (Ekim-Kasım) evi binlerce diya kandiliyle süsleyin. Aile ve arkadaşlar gizlice toplanmış olsun. Maytap ve havai fişek gösterisi sırasında teklifinizi ya da büyük haberinizi açıklayın. Geleneksel mithai tatlıları ve renkli rangoli desenleriyle süslü bu ortam masallardaki gibi olacak.',
   'For Diwali, the festival of lights (October–November), decorate the house with thousands of diya lamps. Have family and friends secretly gathered. During the firecracker and fireworks display, reveal your proposal or big announcement. This setting decorated with traditional mithai sweets and colourful rangoli will be like a fairy tale.',
   'Diya kandilleri altında sürpriz an','A surprise moment under diya lamps',
   4, 5000, 20000, 5, 50, 14, 'both', '{"fall"}', '{"diwali","hint","ışık","gelenek","aile"}',
   'https://images.unsplash.com/photo-1604423043492-41c0e243c9a6?w=800&h=600&fit=crop',
   false, true, ARRAY['hi']),

  -- HI-2: Holi Color Surprise
  ('holiday','cultural-hi-holi-surprise',
   'Holi Renk Festivali Sürprizi','Holi Colour Festival Surprise',
   'Renklerin festivali Holi''de (Mart) özel bir organizasyon yapın. Renkli toz boya oyununun sonunda beyaz kıyafet içinde bir noktada durun ve teklifinizi ya da sürprizinizi açıklayın. Renklere bulanmış bu mutlu anın fotoğrafları hayatınızın en güzel karelerinden biri olacak.',
   'Organise a special event at Holi, the festival of colours (March). At the end of the coloured powder play, stand at a chosen spot in white clothing and reveal your proposal or surprise. The photos of this joyful moment covered in colours will be among the most beautiful frames of your life.',
   'Renklerin festivali Holi''de sürpriz','A surprise at Holi, the festival of colours',
   3, 3000, 12000, 2, 30, 14, 'outdoor', '{"spring"}', '{"holi","hint","renkler","festival","eğlence"}',
   'https://images.unsplash.com/photo-1520810006078-5e0f39be4316?w=800&h=600&fit=crop',
   false, false, ARRAY['hi'])

) AS s(category_slug, slug, title_tr, title_en, description_tr, description_en,
       short_desc_tr, short_desc_en, difficulty, min_budget, max_budget,
       min_people, max_people, prep_days, indoor_outdoor, season, tags,
       cover_image_url, is_premium, is_featured, cultural_locale)
JOIN public.categories c ON c.slug = s.category_slug
ON CONFLICT (slug) DO UPDATE SET cultural_locale = EXCLUDED.cultural_locale, is_active = true;

-- ── CHINESE (zh) ──────────────────────────────────────────────────────────────

INSERT INTO public.scenarios (
  category_id, slug, title_tr, title_en,
  description_tr, description_en, short_desc_tr, short_desc_en,
  difficulty, min_budget, max_budget, min_people, max_people,
  prep_days, indoor_outdoor, season, tags,
  cover_image_url, is_premium, is_featured, is_active,
  cultural_locale
)
SELECT c.id, s.slug, s.title_tr, s.title_en,
  s.description_tr, s.description_en, s.short_desc_tr, s.short_desc_en,
  s.difficulty, s.min_budget, s.max_budget, s.min_people, s.max_people,
  s.prep_days, s.indoor_outdoor, s.season::text[], s.tags::text[],
  s.cover_image_url, s.is_premium, s.is_featured, true, s.cultural_locale::text[]
FROM (VALUES

  -- ZH-1: Chinese New Year Surprise
  ('holiday','cultural-zh-spring-festival',
   'Çin Yeni Yılı Sürprizi','Chinese New Year Surprise',
   'Bahar Festivali''nde (Ocak-Şubat) kırmızı zarflarla (hongbao) dolu bir ev hazırlayın. Her zarfın içinde özel bir mesaj ya da hatıra olsun, son zarfı açtığında teklifinizi ya da büyük haberinizi bulsun. Aslan dansı, maytap sesleri ve geleneksel Çin yemekleriyle kutlamayı tamamlayın.',
   'For the Spring Festival (January–February), prepare a house filled with red envelopes (hongbao). Each envelope contains a special message or memory, and in the final envelope they find your proposal or big announcement. Complete the celebration with a lion dance, the sound of firecrackers and traditional Chinese dishes.',
   'Kırmızı zarfta saklanan sürpriz','A surprise hidden in a red envelope',
   4, 5000, 20000, 5, 50, 14, 'indoor', '{"winter"}', '{"çin yeni yılı","bahar festivali","çin","gelenek","aile"}',
   'https://images.unsplash.com/photo-1547981609-4b6bfe67ca0b?w=800&h=600&fit=crop',
   false, true, ARRAY['zh']),

  -- ZH-2: Mid-Autumn (Mooncake) Surprise
  ('holiday','cultural-zh-mid-autumn',
   'Sonbahar Ortası Festivali Sürprizi','Mid-Autumn Festival Surprise',
   'Sonbahar Ortası Festivali''nde (Eylül-Ekim) dolunay ışığı altında özel bir açık hava etkinliği düzenleyin. Geleneksel mooncake''lerin içine küçük mesajlar gizleyin. Fener yürüyüşünde elinde tuttuğu fenerin içinden teklif kartınız çıksın.',
   'At the Mid-Autumn Festival (September–October), organise a special outdoor event under the light of the full moon. Hide small messages inside traditional mooncakes. Have your proposal card emerge from inside the lantern they are holding during the lantern walk.',
   'Dolunay altında mooncake sürprizi','A mooncake surprise under the full moon',
   3, 3000, 12000, 2, 10, 14, 'outdoor', '{"fall"}', '{"sonbahar festivali","ay","çin","mooncake","fener"}',
   'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=800&h=600&fit=crop',
   false, false, ARRAY['zh'])

) AS s(category_slug, slug, title_tr, title_en, description_tr, description_en,
       short_desc_tr, short_desc_en, difficulty, min_budget, max_budget,
       min_people, max_people, prep_days, indoor_outdoor, season, tags,
       cover_image_url, is_premium, is_featured, cultural_locale)
JOIN public.categories c ON c.slug = s.category_slug
ON CONFLICT (slug) DO UPDATE SET cultural_locale = EXCLUDED.cultural_locale, is_active = true;

-- ── DUTCH (nl) ────────────────────────────────────────────────────────────────

INSERT INTO public.scenarios (
  category_id, slug, title_tr, title_en,
  description_tr, description_en, short_desc_tr, short_desc_en,
  difficulty, min_budget, max_budget, min_people, max_people,
  prep_days, indoor_outdoor, season, tags,
  cover_image_url, is_premium, is_featured, is_active,
  cultural_locale
)
SELECT c.id, s.slug, s.title_tr, s.title_en,
  s.description_tr, s.description_en, s.short_desc_tr, s.short_desc_en,
  s.difficulty, s.min_budget, s.max_budget, s.min_people, s.max_people,
  s.prep_days, s.indoor_outdoor, s.season::text[], s.tags::text[],
  s.cover_image_url, s.is_premium, s.is_featured, true, s.cultural_locale::text[]
FROM (VALUES

  -- NL-1: King''s Day Surprise
  ('holiday','cultural-nl-koningsdag',
   'Kral Günü Sürprizi','King''s Day Surprise',
   'Hollanda''nın en büyük kutlaması Koningsdag''da (27 Nisan) turuncu kıyafetlerle Amsterdam kanalları kenarında sürprizinizi planlayın. Geleneksel stroopwafel ve bier eşliğinde, kanalın üzerindeki bir teknede veya köprüde teklifinizi yapın. Tüm şehir turuncu giyerken siz ona özel bir turuncu gülle teklifinizi yapın.',
   'On Koningsdag (27 April), the Netherlands'' biggest celebration, plan your surprise along the Amsterdam canals in orange outfits. Make your proposal on a boat over the canal or on a bridge with traditional stroopwafel and beer. While the whole city wears orange, present your proposal with a special orange rose.',
   'Turuncu festivalde özel teklif','A special proposal at the orange festival',
   3, 4000, 15000, 2, 100, 14, 'outdoor', '{"spring"}', '{"koningsdag","hollanda","turuncu","amsterdam","teklif"}',
   'https://images.unsplash.com/photo-1584979747315-d5d8e84a30ca?w=800&h=600&fit=crop',
   false, false, ARRAY['nl']),

  -- NL-2: Tulip Season Surprise
  ('romantic','cultural-nl-tulip-surprise',
   'Lale Sezonu Sürprizi','Tulip Season Surprise',
   'Nisan-Mayıs''ta Keukenhof''un renkli lale bahçelerini gezerken sevdiğinize büyük sürprizinizi yapın. Önceden bahçe personeline haber verin ve özel bir lale tarlasında adını yazan devasa bir lale aranjmanı hazırlatın. Ya da yalnızca en güzel lale tarlaları arasında diz çöküp teklifinizi yapın.',
   'While visiting the colourful tulip gardens of Keukenhof in April–May, deliver your big surprise to your loved one. Inform the garden staff in advance and have a huge tulip arrangement spelling out their name prepared in a special tulip field. Or simply drop to one knee among the most beautiful tulip fields and make your proposal.',
   'Rengarenk lale tarlasında teklif','A proposal in a colourful tulip field',
   3, 3000, 12000, 2, 2, 14, 'outdoor', '{"spring"}', '{"lale","hollanda","keukenhof","bahar","romantik"}',
   'https://images.unsplash.com/photo-1490750967868-88df5691cc11?w=800&h=600&fit=crop',
   false, true, ARRAY['nl'])

) AS s(category_slug, slug, title_tr, title_en, description_tr, description_en,
       short_desc_tr, short_desc_en, difficulty, min_budget, max_budget,
       min_people, max_people, prep_days, indoor_outdoor, season, tags,
       cover_image_url, is_premium, is_featured, cultural_locale)
JOIN public.categories c ON c.slug = s.category_slug
ON CONFLICT (slug) DO UPDATE SET cultural_locale = EXCLUDED.cultural_locale, is_active = true;

-- ── POLISH (pl) ───────────────────────────────────────────────────────────────

INSERT INTO public.scenarios (
  category_id, slug, title_tr, title_en,
  description_tr, description_en, short_desc_tr, short_desc_en,
  difficulty, min_budget, max_budget, min_people, max_people,
  prep_days, indoor_outdoor, season, tags,
  cover_image_url, is_premium, is_featured, is_active,
  cultural_locale
)
SELECT c.id, s.slug, s.title_tr, s.title_en,
  s.description_tr, s.description_en, s.short_desc_tr, s.short_desc_en,
  s.difficulty, s.min_budget, s.max_budget, s.min_people, s.max_people,
  s.prep_days, s.indoor_outdoor, s.season::text[], s.tags::text[],
  s.cover_image_url, s.is_premium, s.is_featured, true, s.cultural_locale::text[]
FROM (VALUES

  -- PL-1: Andrzejki Fortune Night
  ('holiday','cultural-pl-andrzejki',
   'Andrzejki Fal Gecesi Sürprizi','Andrzejki Fortune Night Surprise',
   'Polonya''nın Andrzejki geleneğinde (30 Kasım) mum alevi ile kurşun döküm yapılır ve gölgelerden gelecek okunur. Arkadaşlar bu ritüeli yaparken sürprizinizi planlayın: kurşun döküm gölgesinin içine önceden yüzüğü ya da mesajı gizleyin. Polonya pierogisi ve şarabı eşliğinde büyülü bir gece.',
   'In Poland''s Andrzejki tradition (30 November), molten lead is poured over candle flames and the future is read from the shadows. While friends perform this ritual, plan your surprise: hide the ring or message inside the lead casting shadow in advance. A magical evening with Polish pierogi and wine.',
   'Polonya gelenek gecesinde saklanan sürpriz','A hidden surprise on Polish tradition night',
   3, 2000, 8000, 4, 20, 7, 'indoor', '{"fall"}', '{"andrzejki","polonya","fal","gelenek","romantik"}',
   'https://images.unsplash.com/photo-1577083552431-6e5fd01988ec?w=800&h=600&fit=crop',
   false, false, ARRAY['pl']),

  -- PL-2: Easter Śmigus-Dyngus Surprise
  ('holiday','cultural-pl-dyngus-day',
   'Dyngus Günü Sürprizi','Śmigus-Dyngus Surprise',
   'Polonya Paskalya geleneği Śmigus-Dyngus''ta (Paskalya Pazartesi) sevdiğinize su serpme oyununun ardından sürprizinizi yapın. Su savaşının en komik anında saydamlığıyla güzelleşen sürpriz kartı ya da saat geçirmez kutuda yüzüğü sunun. Polonya''da bu gün sevgi ve eğlencenin simgesidir.',
   'After the water-sprinkling game of the Polish Easter tradition Śmigus-Dyngus (Easter Monday), make your surprise. At the funniest moment of the water fight, present a surprise card that becomes beautiful when wet, or a ring in a waterproof box. In Poland this day is a symbol of love and fun.',
   'Su savaşında sürpriz teklif','A surprise proposal in a water fight',
   3, 1500, 6000, 2, 10, 7, 'outdoor', '{"spring"}', '{"dyngus","polonya","paskalya","su","eğlence"}',
   'https://images.unsplash.com/photo-1524492412937-b28074a5d7da?w=800&h=600&fit=crop',
   false, false, ARRAY['pl'])

) AS s(category_slug, slug, title_tr, title_en, description_tr, description_en,
       short_desc_tr, short_desc_en, difficulty, min_budget, max_budget,
       min_people, max_people, prep_days, indoor_outdoor, season, tags,
       cover_image_url, is_premium, is_featured, cultural_locale)
JOIN public.categories c ON c.slug = s.category_slug
ON CONFLICT (slug) DO UPDATE SET cultural_locale = EXCLUDED.cultural_locale, is_active = true;

-- ── SWEDISH (sv) ──────────────────────────────────────────────────────────────

INSERT INTO public.scenarios (
  category_id, slug, title_tr, title_en,
  description_tr, description_en, short_desc_tr, short_desc_en,
  difficulty, min_budget, max_budget, min_people, max_people,
  prep_days, indoor_outdoor, season, tags,
  cover_image_url, is_premium, is_featured, is_active,
  cultural_locale
)
SELECT c.id, s.slug, s.title_tr, s.title_en,
  s.description_tr, s.description_en, s.short_desc_tr, s.short_desc_en,
  s.difficulty, s.min_budget, s.max_budget, s.min_people, s.max_people,
  s.prep_days, s.indoor_outdoor, s.season::text[], s.tags::text[],
  s.cover_image_url, s.is_premium, s.is_featured, true, s.cultural_locale::text[]
FROM (VALUES

  -- SV-1: Midsommar Proposal
  ('proposal','cultural-sv-midsommar',
   'Midsommar Yaz Ortası Teklifi','Midsommar Midsummer Proposal',
   'İsveç''in en büyük bayramı Midsommar''da (Haziran) çiçek çelenglerini takın, geleneksel midsommarstång (yaz direği) etrafında dans edin. Dansın en güzel anında durdurun ve sevdiğinize Midsommar çiçeğiyle teklifinizi yapın. Gelenekte Midsommar''da rüyada görülen kişiyle evlenilir — teklifiniz bu geleneği gerçeğe taşır.',
   'On Midsommar (June), Sweden''s biggest holiday, put on flower wreaths and dance around the traditional midsommarstång (maypole). At the most beautiful moment of the dance, stop and make your proposal to your loved one with a midsummer flower. In tradition, you marry the person you see in your dream on Midsommar — your proposal makes this tradition real.',
   'Yaz ortasının büyüsünde teklif','A proposal in the magic of midsummer',
   3, 4000, 15000, 2, 20, 14, 'outdoor', '{"summer"}', '{"midsommar","isveç","yaz","çiçek","teklif"}',
   'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&h=600&fit=crop',
   false, true, ARRAY['sv']),

  -- SV-2: Fika Surprise
  ('romantic','cultural-sv-fika-surprise',
   'Fika Sürpriz Molası','Fika Surprise Break',
   'İsveç''in sevilen fika geleneğinde (kahve ve tatlı molası) sevdiğinize özel bir sürpriz hazırlayın. En sevdiği kafede sizi bekleyen arkadaşlar, özel sipariş edilmiş bir pasta ve kişiselleştirilmiş bir hediye ile küçük ama derinden dokunacak bir sürpriz. İsveçliler büyük jestlerden değil, samimi anlardan etkilenir.',
   'In Sweden''s beloved fika tradition (coffee and pastry break), prepare a special surprise for your loved one. Friends waiting at their favourite café, a specially ordered cake and a personalised gift make a small but deeply touching surprise. Swedes are moved not by grand gestures but by sincere moments.',
   'İsveç kahve geleneğiyle samimi sürpriz','A sincere surprise with Swedish coffee tradition',
   1, 500, 2000, 2, 6, 3, 'indoor', '{"all"}', '{"fika","isveç","kahve","samimi","romantik"}',
   'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800&h=600&fit=crop',
   false, false, ARRAY['sv'])

) AS s(category_slug, slug, title_tr, title_en, description_tr, description_en,
       short_desc_tr, short_desc_en, difficulty, min_budget, max_budget,
       min_people, max_people, prep_days, indoor_outdoor, season, tags,
       cover_image_url, is_premium, is_featured, cultural_locale)
JOIN public.categories c ON c.slug = s.category_slug
ON CONFLICT (slug) DO UPDATE SET cultural_locale = EXCLUDED.cultural_locale, is_active = true;

-- ── UKRAINIAN (uk) ────────────────────────────────────────────────────────────

INSERT INTO public.scenarios (
  category_id, slug, title_tr, title_en,
  description_tr, description_en, short_desc_tr, short_desc_en,
  difficulty, min_budget, max_budget, min_people, max_people,
  prep_days, indoor_outdoor, season, tags,
  cover_image_url, is_premium, is_featured, is_active,
  cultural_locale
)
SELECT c.id, s.slug, s.title_tr, s.title_en,
  s.description_tr, s.description_en, s.short_desc_tr, s.short_desc_en,
  s.difficulty, s.min_budget, s.max_budget, s.min_people, s.max_people,
  s.prep_days, s.indoor_outdoor, s.season::text[], s.tags::text[],
  s.cover_image_url, s.is_premium, s.is_featured, true, s.cultural_locale::text[]
FROM (VALUES

  -- UK-1: Ivana Kupala Night
  ('romantic','cultural-uk-ivana-kupala',
   'İvana Kupala Ateş Gecesi','Ivana Kupala Fire Night',
   'Ukrayna''nın en mistik geleneği İvana Kupala gecesinde (6-7 Temmuz) ateş üzerinden atlayın. Gelenekte birlikte atlayan çiftler ömür boyu birlikte kalır. El ele tutuşarak ateşin üzerinden atladıktan sonra teklifinizi yapın. Çiçek çelenglerini nehre bırakma ritüelini birlikte yapın.',
   'On Ivana Kupala, Ukraine''s most mystical tradition (6–7 July), jump over the fire together. In tradition, couples who jump together stay together for life. After jumping over the fire hand in hand, make your proposal. Perform the ritual of releasing flower wreaths onto the river together.',
   'Ateş üzerinden atlayan çiftler ömür boyu birlikte','Couples who jump over fire stay together forever',
   3, 2000, 8000, 2, 10, 7, 'outdoor', '{"summer"}', '{"ivana kupala","ukrayna","ateş","gelenek","romantik"}',
   'https://images.unsplash.com/photo-1513151233558-d860c5398176?w=800&h=600&fit=crop',
   false, true, ARRAY['uk']),

  -- UK-2: Pysanka (Easter Egg) Surprise
  ('holiday','cultural-uk-pysanka',
   'Pysanka Paskalya Yumurtası Sürprizi','Pysanka Easter Egg Surprise',
   'Ukrayna''nın geleneksel balmumu boyama sanatı pysanka ile sevdiğinize özel bir yumurta yapın. İçi boş yumurtanın içine küçük bir yüzük ya da mesaj kağıdı saklayın. Paskalya sabahı bunu hediye edin. Pysanka Ukrayna kültüründe sevgi, bereket ve koruyuculuk sembolüdür.',
   'Using pysanka, Ukraine''s traditional beeswax egg-painting art, make a special egg for your loved one. Hide a small ring or message paper inside a hollow egg. Gift it on Easter morning. Pysanka is a symbol of love, fertility and protection in Ukrainian culture.',
   'Geleneksel boyama sanatıyla sürpriz yumurta','A surprise egg with traditional painting art',
   3, 1000, 4000, 2, 2, 14, 'indoor', '{"spring"}', '{"pysanka","ukrayna","paskalya","gelenek","el sanatı"}',
   'https://images.unsplash.com/photo-1524492412937-b28074a5d7da?w=800&h=600&fit=crop',
   false, false, ARRAY['uk'])

) AS s(category_slug, slug, title_tr, title_en, description_tr, description_en,
       short_desc_tr, short_desc_en, difficulty, min_budget, max_budget,
       min_people, max_people, prep_days, indoor_outdoor, season, tags,
       cover_image_url, is_premium, is_featured, cultural_locale)
JOIN public.categories c ON c.slug = s.category_slug
ON CONFLICT (slug) DO UPDATE SET cultural_locale = EXCLUDED.cultural_locale, is_active = true;

-- ── VERIFICATION ──────────────────────────────────────────────────────────────

SELECT
  cultural_locale,
  COUNT(*) AS scenario_count
FROM public.scenarios,
  UNNEST(cultural_locale) AS cultural_locale
GROUP BY cultural_locale
ORDER BY cultural_locale;
