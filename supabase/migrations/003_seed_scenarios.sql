-- ==========================================
-- SEED: 33 Scenarios with Steps
-- Each category gets 3-4 scenarios
-- ==========================================

-- Helper: get category IDs
DO $$
DECLARE
  cat_proposal    uuid;
  cat_birthday    uuid;
  cat_anniversary uuid;
  cat_graduation  uuid;
  cat_baby        uuid;
  cat_romantic    uuid;
  cat_friendship  uuid;
  cat_apology     uuid;
  cat_achievement uuid;
  cat_holiday     uuid;

  s_id uuid;
BEGIN

SELECT id INTO cat_proposal    FROM public.categories WHERE slug = 'proposal';
SELECT id INTO cat_birthday    FROM public.categories WHERE slug = 'birthday';
SELECT id INTO cat_anniversary FROM public.categories WHERE slug = 'anniversary';
SELECT id INTO cat_graduation  FROM public.categories WHERE slug = 'graduation';
SELECT id INTO cat_baby        FROM public.categories WHERE slug = 'baby';
SELECT id INTO cat_romantic    FROM public.categories WHERE slug = 'romantic';
SELECT id INTO cat_friendship  FROM public.categories WHERE slug = 'friendship';
SELECT id INTO cat_apology     FROM public.categories WHERE slug = 'apology';
SELECT id INTO cat_achievement FROM public.categories WHERE slug = 'achievement';
SELECT id INTO cat_holiday     FROM public.categories WHERE slug = 'holiday';

-- ==========================================
-- 1. PROPOSAL (Evlilik Teklifi) - 4 scenarios
-- ==========================================

-- 1.1 Sahilde Gün Batımı Teklifi
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'beach-sunset-proposal',
  'Sahilde Gün Batımı Teklifi', 'Beach Sunset Proposal',
  'Deniz kenarında, gün batımının büyülü ışığında hayatınızın en önemli sorusunu sorun. Kumda yazılmış mesajlar, mum ışıkları ve romantik müzik eşliğinde unutulmaz bir an yaratın.',
  'Ask the most important question of your life by the sea, in the magical light of sunset. Create an unforgettable moment with messages written in the sand, candlelight, and romantic music.',
  'Gün batımında deniz kenarında romantik teklif', 'Romantic proposal by the sea at sunset',
  3, 2000, 8000, 2, 2, 14, 'outdoor', ARRAY['summer','spring'], ARRAY['romantik','deniz','gün batımı','plaj'], false, true)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Mekan Araştırması', 'Venue Research', 'Uygun sahil lokasyonunu belirleyin. Gün batımı saatlerini kontrol edin, kalabalık olmayan bir bölge seçin.', 'Identify a suitable beach location. Check sunset times and choose a less crowded area.', 14, null),
(s_id, 2, 'Yüzük Seçimi', 'Ring Selection', 'Partnerinizin tarzına uygun yüzüğü seçin. Parmak ölçüsünü gizlice öğrenin.', 'Choose a ring that suits your partner''s style. Secretly find out the ring size.', 12, 3000),
(s_id, 3, 'Dekorasyon Hazırlığı', 'Decoration Setup', 'Mum, gül yaprakları, kumda yazı şablonu ve fener hazırlayın.', 'Prepare candles, rose petals, sand writing template and lanterns.', 3, 500),
(s_id, 4, 'Fotoğrafçı Ayarlama', 'Arrange Photographer', 'Gizli çekim yapacak bir fotoğrafçı ile anlaşın. Lokasyonu ve zamanlamayı paylaşın.', 'Arrange a photographer for secret shots. Share the location and timing.', 7, 2000),
(s_id, 5, 'Müzik Hazırlığı', 'Music Preparation', 'Bluetooth hoparlör ve romantik şarkı listesi hazırlayın.', 'Prepare a Bluetooth speaker and a romantic playlist.', 2, 200),
(s_id, 6, 'Büyük Gün', 'The Big Day', 'Mekanı 2 saat önceden hazırlayın. Mum ve gül yapraklarını yerleştirin. Fotoğrafçının pozisyonda olduğundan emin olun.', 'Set up the venue 2 hours early. Place candles and rose petals. Make sure the photographer is in position.', 0, null);

-- 1.2 Restoran Sürprizi
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'restaurant-surprise-proposal',
  'Restoranda Sürpriz Teklif', 'Restaurant Surprise Proposal',
  'Şık bir restoranda, özel olarak hazırlanmış bir akşam yemeğinde hayatınızın en önemli sorusunu sorun. Yüzük tatlının içinde ya da şampanya kadehinde gizlensin.',
  'Pop the question at a fine dining restaurant with a specially prepared dinner. Hide the ring in the dessert or champagne glass.',
  'Şık restoranda unutulmaz teklif anı', 'Unforgettable proposal moment at a fine restaurant',
  2, 3000, 15000, 2, 2, 10, 'indoor', ARRAY['winter','spring','summer','fall'], ARRAY['restoran','şık','akşam yemeği'], false, true)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Restoran Rezervasyonu', 'Restaurant Reservation', 'Özel ve romantik bir restoran seçin. Pencere kenarı veya özel oda rezervasyonu yapın.', 'Choose a special romantic restaurant. Reserve a window table or private room.', 10, null),
(s_id, 2, 'Restoran ile Koordinasyon', 'Coordinate with Restaurant', 'Garsonlarla planı paylaşın. Yüzüğün nasıl sunulacağını kararlaştırın.', 'Share the plan with waitstaff. Decide how the ring will be presented.', 7, null),
(s_id, 3, 'Özel Menü', 'Custom Menu', 'Partnerinizin favori yemeklerinden özel menü oluşturun.', 'Create a custom menu from your partner''s favorite dishes.', 5, 2000),
(s_id, 4, 'Kıyafet ve Görünüm', 'Outfit and Grooming', 'Şık kıyafetlerinizi hazırlayın, gerekirse kuaför randevusu alın.', 'Prepare your elegant outfit, get a haircut appointment if needed.', 2, 500),
(s_id, 5, 'Teklif Anı', 'The Proposal Moment', 'Tatlı servisinde ya da şampanya ile birlikte yüzüğü sunun. Konuşmanızı önceden hazırlayın.', 'Present the ring with dessert or champagne. Prepare your speech beforehand.', 0, null);

-- 1.3 Balon Teklifi
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'hot-air-balloon-proposal',
  'Sıcak Hava Balonu Teklifi', 'Hot Air Balloon Proposal',
  'Gökyüzünde, bulutların arasında, sıcak hava balonunda hayatınızın en önemli sorusunu sorun. Kapadokya''nın eşsiz manzarası eşliğinde bir rüya gerçek olsun.',
  'Ask the most important question in a hot air balloon among the clouds. Make a dream come true with the unique landscape of Cappadocia.',
  'Gökyüzünde büyülü teklif anı', 'Magical proposal moment in the sky',
  4, 5000, 20000, 2, 2, 21, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['balon','kapadokya','gökyüzü','macera'], true, true)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Balon Firması Araştırması', 'Research Balloon Companies', 'Kapadokya''daki güvenilir balon firmalarını araştırın. Özel uçuş seçeneklerini sorun.', 'Research reliable balloon companies in Cappadocia. Ask about private flight options.', 21, null),
(s_id, 2, 'Özel Uçuş Rezervasyonu', 'Book Private Flight', 'Özel balon uçuşu rezervasyonu yapın. Teklif planınızı firma ile paylaşın.', 'Book a private balloon flight. Share your proposal plan with the company.', 14, 8000),
(s_id, 3, 'Konaklama Ayarlama', 'Arrange Accommodation', 'Kapadokya''da romantik bir mağara otel rezervasyonu yapın.', 'Book a romantic cave hotel in Cappadocia.', 14, 3000),
(s_id, 4, 'Dekorasyon Detayları', 'Decoration Details', 'Balon sepetine çiçek, şampanya ve pankart hazırlığı yapın.', 'Prepare flowers, champagne and banner for the balloon basket.', 3, 1000),
(s_id, 5, 'Büyük Gün', 'The Big Day', 'Sabahın erken saatlerinde uçuş noktasına gidin. Gün doğumunda teklif edin.', 'Head to the flight point early in the morning. Propose at sunrise.', 0, null);

-- 1.4 Ev Sineması Teklifi
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'home-cinema-proposal',
  'Ev Sineması Teklifi', 'Home Cinema Proposal',
  'Evinizi bir sinema salonuna çevirin ve özel bir kısa film ile teklif edin. Birlikte geçirdiğiniz anların videosunu hazırlayıp, sonunda ''Benimle evlenir misin?'' sorusunu ekranda gösterin.',
  'Turn your home into a cinema and propose with a custom short film. Prepare a video of your memories together and display "Will you marry me?" at the end.',
  'Ev sinemasında kişisel film ile teklif', 'Proposal with personal film at home cinema',
  2, 500, 3000, 2, 2, 10, 'indoor', ARRAY['winter','spring','summer','fall'], ARRAY['ev','sinema','video','kişisel'], false, false)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Video Hazırlığı', 'Video Preparation', 'Birlikte çektiğiniz fotoğraf ve videoları toplayın. Kronolojik bir kısa film oluşturun.', 'Collect photos and videos taken together. Create a chronological short film.', 10, null),
(s_id, 2, 'Mekan Düzenleme', 'Space Setup', 'Projeksiyon veya büyük ekran, karartma perdesi, rahat yastıklar hazırlayın.', 'Prepare a projector or large screen, blackout curtains, and comfortable pillows.', 5, 1500),
(s_id, 3, 'Atıştırmalık Hazırlığı', 'Snack Preparation', 'Popcorn, favori içecekler ve romantik atıştırmalıklar hazırlayın.', 'Prepare popcorn, favorite drinks and romantic snacks.', 1, 200),
(s_id, 4, 'Teklif Anı', 'Proposal Moment', 'Film bittiğinde ''Benimle evlenir misin?'' yazısı ekranda belirsin. Yüzüğü çıkarın.', 'When the film ends, "Will you marry me?" appears on screen. Present the ring.', 0, null);

-- ==========================================
-- 2. BIRTHDAY (Doğum Günü) - 4 scenarios
-- ==========================================

-- 2.1 Sürpriz Parti
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'surprise-birthday-party',
  'Sürpriz Doğum Günü Partisi', 'Surprise Birthday Party',
  'Sevdiğiniz kişiyi hiç beklemediği bir anda şok edin! Arkadaşları, ailesi ve en sevdiği şeylerle dolu bir sürpriz parti organize edin.',
  'Shock your loved one when they least expect it! Organize a surprise party filled with friends, family, and their favorite things.',
  'Klasik ama unutulmaz sürpriz parti', 'Classic but unforgettable surprise party',
  3, 1000, 10000, 5, 50, 14, 'indoor', ARRAY['winter','spring','summer','fall'], ARRAY['parti','arkadaşlar','eğlence','müzik'], false, true)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Davetli Listesi', 'Guest List', 'Davet edilecek kişilerin listesini oluşturun. Gizlice iletişim bilgilerini toplayın.', 'Create a list of people to invite. Secretly collect contact information.', 14, null),
(s_id, 2, 'Mekan Seçimi', 'Venue Selection', 'Ev, restoran veya kiralık mekan seçin. Kapasiteyi kontrol edin.', 'Choose home, restaurant or rental venue. Check the capacity.', 12, 2000),
(s_id, 3, 'Tema ve Dekorasyon', 'Theme and Decoration', 'Kişinin ilgi alanlarına göre tema belirleyin. Balon, afiş, masa düzeni hazırlayın.', 'Set a theme based on the person''s interests. Prepare balloons, banners, table setup.', 7, 1500),
(s_id, 4, 'Pasta ve İkram', 'Cake and Catering', 'Özel tasarım pasta sipariş edin. Yiyecek ve içecek menüsünü planlayın.', 'Order a custom designed cake. Plan the food and drink menu.', 5, 2000),
(s_id, 5, 'Eğlence Planı', 'Entertainment Plan', 'DJ, oyunlar veya karaoke hazırlayın. Müzik listesi oluşturun.', 'Prepare DJ, games or karaoke. Create a music playlist.', 3, 1000),
(s_id, 6, 'Davetli Koordinasyonu', 'Guest Coordination', 'Herkese saat ve mekanı bildirin. Sürpriz planını paylaşın.', 'Inform everyone about time and venue. Share the surprise plan.', 2, null),
(s_id, 7, 'Parti Günü', 'Party Day', 'Mekanı hazırlayın. Kişiyi mekanı getirecek bir plan yapın. SÜRPRIZ!', 'Set up the venue. Make a plan to bring the person to the venue. SURPRISE!', 0, null);

-- 2.2 Hazine Avı Doğum Günü
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'treasure-hunt-birthday',
  'Hazine Avı Doğum Günü', 'Treasure Hunt Birthday',
  'Şehrin farklı noktalarına ipuçları saklayarak sevdiğiniz kişiyi maceraya çıkarın. Her ipucu bir anıyı, bir hediyeyi ve sonraki durağı işaret etsin.',
  'Take your loved one on an adventure by hiding clues around the city. Each clue points to a memory, a gift, and the next stop.',
  'İpuçlarıyla dolu macera doğum günü', 'Adventure birthday full of clues',
  4, 500, 5000, 1, 5, 10, 'both', ARRAY['spring','summer','fall'], ARRAY['macera','hazine avı','ipucu','şehir'], true, false)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Rota Planlama', 'Route Planning', '5-8 durak belirleyin. Her durak bir anıyla veya favori mekanla bağlantılı olsun.', 'Identify 5-8 stops. Each stop should be linked to a memory or favorite place.', 10, null),
(s_id, 2, 'İpucu Kartları Hazırlama', 'Prepare Clue Cards', 'Her durak için yaratıcı ipucu kartları hazırlayın. Fotoğraflar ve bulmacalar ekleyin.', 'Prepare creative clue cards for each stop. Add photos and puzzles.', 7, 200),
(s_id, 3, 'Hediye Yerleştirme', 'Gift Placement', 'Her durağa küçük bir hediye veya mektup yerleştirin.', 'Place a small gift or letter at each stop.', 2, 1500),
(s_id, 4, 'Yardımcıları Bilgilendirme', 'Brief Helpers', 'Her durağa bir arkadaş yerleştirin. Zamanlama ve görevleri paylaşın.', 'Place a friend at each stop. Share timing and tasks.', 1, null),
(s_id, 5, 'Macera Başlasın', 'Let the Adventure Begin', 'İlk ipucunu sabah kahvaltıda verin. Son durakta büyük sürpriz bekliyor olsun!', 'Give the first clue at breakfast. The big surprise awaits at the final stop!', 0, null);

-- 2.3 Video Mesaj Kolajı
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'video-montage-birthday',
  'Video Mesaj Kolajı', 'Video Message Montage',
  'Arkadaşları ve ailesinden gizlice video mesajlar toplayın ve muhteşem bir kolaj oluşturun. Doğum gününde hep birlikte izleyin.',
  'Secretly collect video messages from friends and family and create an amazing montage. Watch it together on the birthday.',
  'Sevdiklerinden video mesaj sürprizi', 'Video message surprise from loved ones',
  2, 0, 500, 1, 100, 14, 'indoor', ARRAY['winter','spring','summer','fall'], ARRAY['video','mesaj','anı','duygusal'], false, false)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Katılımcı Listesi', 'Participant List', 'Video mesaj isteyeceğiniz kişilerin listesini çıkarın.', 'List the people you will ask for video messages.', 14, null),
(s_id, 2, 'Mesaj Toplama', 'Collect Messages', 'Herkese yönerge gönderin: 30-60 saniyelik bir tebrik videosu isteyin.', 'Send instructions to everyone: request a 30-60 second greeting video.', 10, null),
(s_id, 3, 'Video Düzenleme', 'Video Editing', 'Tüm videoları bir araya getirin. Müzik ve geçiş efektleri ekleyin.', 'Compile all videos together. Add music and transition effects.', 3, null),
(s_id, 4, 'Gösterim Hazırlığı', 'Screening Setup', 'TV veya projeksiyon hazırlayın. Rahat bir izleme ortamı oluşturun.', 'Set up TV or projector. Create a comfortable viewing environment.', 1, 200),
(s_id, 5, 'İzleme Partisi', 'Viewing Party', 'Doğum gününde videoyu birlikte izleyin. Mendil hazır olsun!', 'Watch the video together on the birthday. Keep tissues ready!', 0, null);

-- ==========================================
-- 3. ANNIVERSARY (Yıldönümü) - 3 scenarios
-- ==========================================

-- 3.1 İlk Buluşma Canlandırması
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'first-date-reenactment',
  'İlk Buluşma Canlandırması', 'First Date Reenactment',
  'İlk buluşmanızı birebir canlandırın. Aynı mekan, aynı kıyafetler, aynı müzik... Ama bu sefer her şeyin ne kadar güzel büyüdüğünü kutlayarak.',
  'Reenact your first date exactly. Same place, same outfits, same music... But this time celebrating how beautifully everything has grown.',
  'İlk buluşmayı yeniden yaşayın', 'Relive your first date',
  2, 500, 3000, 2, 2, 7, 'both', ARRAY['winter','spring','summer','fall'], ARRAY['romantik','nostalji','ilk buluşma','özel'], false, true)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Anıları Hatırlama', 'Recall Memories', 'İlk buluşmanızın detaylarını hatırlayın: mekan, kıyafet, yemek, müzik.', 'Remember the details of your first date: venue, outfit, food, music.', 7, null),
(s_id, 2, 'Mekan Ayarlama', 'Venue Arrangement', 'İlk buluşma mekanında rezervasyon yapın veya mekanı aynı şekilde hazırlayın.', 'Make a reservation at the first date venue or prepare the space identically.', 5, 1000),
(s_id, 3, 'Kıyafet Hazırlığı', 'Outfit Preparation', 'İlk buluşmadaki kıyafetlerinizi bulun veya benzerlerini hazırlayın.', 'Find your first date outfits or prepare similar ones.', 3, 500),
(s_id, 4, 'Detayları Tamamlama', 'Complete Details', 'Aynı müziği, aynı içeceği, aynı atmosferi oluşturun. Küçük bir hediye hazırlayın.', 'Create the same music, same drink, same atmosphere. Prepare a small gift.', 1, 500),
(s_id, 5, 'Buluşma Günü', 'The Date', 'İlk buluşmadaki gibi davranın ama sonunda "seni seçtiğim için ne kadar mutluyum" deyin.', 'Act like the first date but end by saying "I''m so happy I chose you."', 0, null);

-- 3.2 Anı Defteri Sürprizi
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'memory-scrapbook',
  'Anı Defteri Sürprizi', 'Memory Scrapbook Surprise',
  'İlişkinizin en güzel anlarını bir anı defterinde toplayın. Fotoğraflar, biletler, notlar ve el yazısı mektuplarla dolu özel bir albüm hazırlayın.',
  'Collect the most beautiful moments of your relationship in a scrapbook. Prepare a special album full of photos, tickets, notes and handwritten letters.',
  'El yapımı anı defteri ile duygusal sürpriz', 'Emotional surprise with handmade scrapbook',
  2, 200, 1000, 1, 1, 14, 'indoor', ARRAY['winter','spring','summer','fall'], ARRAY['anı','el yapımı','fotoğraf','mektup'], false, false)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Malzeme Toplama', 'Gather Materials', 'Fotoğrafları, biletleri, kartpostalları ve özel anıları toplayın.', 'Collect photos, tickets, postcards and special memorabilia.', 14, null),
(s_id, 2, 'Defter ve Malzeme Alımı', 'Buy Scrapbook Supplies', 'Güzel bir defter, yapıştırıcı, kalem, sticker ve dekoratif malzeme alın.', 'Buy a nice notebook, glue, pens, stickers and decorative materials.', 10, 300),
(s_id, 3, 'Sayfa Tasarımı', 'Page Design', 'Her sayfayı bir tema veya döneme ayırın. Fotoğraf ve notları yerleştirin.', 'Dedicate each page to a theme or period. Place photos and notes.', 7, null),
(s_id, 4, 'Mektup Yazma', 'Write Letters', 'Her bölüme kısa el yazısı notlar ve sevgi mesajları ekleyin.', 'Add short handwritten notes and love messages to each section.', 3, null),
(s_id, 5, 'Hediye Etme', 'Gift Giving', 'Defteri güzelce paketleyin. Yıldönümü yemeğinde ya da özel bir anda hediye edin.', 'Wrap the scrapbook beautifully. Gift it at the anniversary dinner or a special moment.', 0, 100);

-- 3.3 Sürpriz Kaçamak
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'surprise-getaway',
  'Sürpriz Kaçamak', 'Surprise Getaway',
  'Partnerinize haber vermeden bir hafta sonu kaçamağı planlayın. Bavulunu gizlice hazırlayın ve ''arabaya bin, sürprizin var'' deyin.',
  'Plan a weekend getaway without telling your partner. Secretly pack their bag and say "get in the car, you have a surprise."',
  'Gizlice planlanan romantik kaçamak', 'Secretly planned romantic getaway',
  3, 2000, 10000, 2, 2, 14, 'both', ARRAY['spring','summer','fall'], ARRAY['seyahat','kaçamak','otel','romantik'], true, true)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Destinasyon Seçimi', 'Choose Destination', 'Partnerinizin sevdiği veya görmek istediği bir yer seçin. Ulaşım planını yapın.', 'Choose a place your partner loves or wants to see. Plan the transportation.', 14, null),
(s_id, 2, 'Konaklama Rezervasyonu', 'Book Accommodation', 'Özel bir otel veya butik konaklama yeri ayırtın.', 'Reserve a special hotel or boutique accommodation.', 10, 4000),
(s_id, 3, 'Aktivite Planı', 'Activity Plan', 'Gidilecek yerdeki romantik aktiviteleri planlayın: spa, yemek, gezi.', 'Plan romantic activities at the destination: spa, dining, sightseeing.', 7, 2000),
(s_id, 4, 'Gizli Bavul Hazırlığı', 'Secret Packing', 'Partnerinizin kıyafetlerini ve ihtiyaçlarını gizlice bavula koyun.', 'Secretly pack your partner''s clothes and necessities.', 1, null),
(s_id, 5, 'Yola Çıkış', 'Hit the Road', '"Arabaya bin, sürprizin var" deyin ve yola çıkın!', '"Get in the car, you have a surprise" and hit the road!', 0, null);

-- ==========================================
-- 4. GRADUATION (Mezuniyet) - 3 scenarios
-- ==========================================

-- 4.1 Mezuniyet Bahçe Partisi
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'graduation-garden-party',
  'Mezuniyet Bahçe Partisi', 'Graduation Garden Party',
  'Bahçede şık bir mezuniyet kutlaması düzenleyin. Işık süslemeleri, özel yemekler ve duygusal konuşmalarla mezuniyeti kutlayın.',
  'Organize an elegant graduation celebration in the garden. Celebrate with light decorations, special food and emotional speeches.',
  'Bahçede şık mezuniyet kutlaması', 'Elegant graduation celebration in the garden',
  3, 2000, 8000, 10, 40, 10, 'outdoor', ARRAY['spring','summer'], ARRAY['mezuniyet','parti','bahçe','kutlama'], false, true)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Mekan ve Tarih', 'Venue and Date', 'Bahçeli bir mekan belirleyin. Hava durumunu kontrol edin, yedek plan yapın.', 'Choose a venue with a garden. Check weather forecast, make a backup plan.', 10, 1000),
(s_id, 2, 'Davetiye Gönderimi', 'Send Invitations', 'Dijital veya basılı davetiyeler hazırlayıp gönderin.', 'Prepare and send digital or printed invitations.', 8, 300),
(s_id, 3, 'Dekorasyon', 'Decoration', 'Işık zincirleri, mezuniyet temalı süsler, fotoğraf köşesi hazırlayın.', 'Prepare string lights, graduation themed decorations, photo corner.', 5, 1500),
(s_id, 4, 'Yemek ve İçecek', 'Food and Drinks', 'Catering veya ev yapımı büfe hazırlayın. Özel mezuniyet pastası sipariş edin.', 'Prepare catering or homemade buffet. Order a special graduation cake.', 3, 3000),
(s_id, 5, 'Konuşma Hazırlığı', 'Speech Preparation', 'Duygusal bir konuşma hazırlayın. Fotoğraf slayt gösterisi yapın.', 'Prepare an emotional speech. Create a photo slideshow.', 2, null),
(s_id, 6, 'Parti Günü', 'Party Day', 'Mekanı sabahtan hazırlayın. Müzik, ışıklar ve masaları düzenleyin.', 'Set up the venue in the morning. Arrange music, lights and tables.', 0, null);

-- 4.2 Diploma Çerçevesi + Mektup
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'diploma-frame-letter',
  'Diploma Çerçevesi & Gurur Mektubu', 'Diploma Frame & Pride Letter',
  'Özel tasarım bir diploma çerçevesi hediye edin ve yanına el yazısıyla bir gurur mektubu ekleyin. Başarının değerini gösteren anlamlı bir hediye.',
  'Gift a custom diploma frame with a handwritten pride letter. A meaningful gift showing the value of achievement.',
  'Özel çerçeve ve el yazısı mektup', 'Custom frame and handwritten letter',
  1, 200, 1000, 1, 1, 7, 'indoor', ARRAY['winter','spring','summer','fall'], ARRAY['diploma','mektup','hediye','duygusal'], false, false)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Çerçeve Seçimi', 'Frame Selection', 'Diploma boyutuna uygun, şık bir çerçeve seçin. Kişiselleştirme seçeneklerini araştırın.', 'Choose an elegant frame suitable for diploma size. Research customization options.', 7, 400),
(s_id, 2, 'Mektup Yazma', 'Write the Letter', 'Kişinin hayattaki yolculuğunu, başarılarını anlatan duygusal bir mektup yazın.', 'Write an emotional letter describing the person''s journey and achievements in life.', 5, null),
(s_id, 3, 'Paketleme', 'Gift Wrapping', 'Çerçeve ve mektubu zarif bir şekilde paketleyin.', 'Elegantly wrap the frame and letter.', 1, 100),
(s_id, 4, 'Hediye Anı', 'Gift Moment', 'Mezuniyet töreninden sonra veya özel bir anda hediye edin.', 'Gift it after the graduation ceremony or at a special moment.', 0, null);

-- 4.3 Kariyer Başlangıç Seti
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'career-starter-kit',
  'Kariyer Başlangıç Seti', 'Career Starter Kit',
  'Yeni mezuna iş hayatında lazım olacak her şeyi düşünülmüş bir kutu halinde hediye edin: ajanda, kalem, kartvizitlik, motivasyon kitabı ve kişisel not.',
  'Gift the new graduate a thoughtfully curated box with everything they need for work life: planner, pen, card holder, motivational book and a personal note.',
  'İş hayatı için düşünceli hediye kutusu', 'Thoughtful gift box for career life',
  1, 300, 2000, 1, 1, 7, 'indoor', ARRAY['winter','spring','summer','fall'], ARRAY['kariyer','hediye kutusu','profesyonel','motivasyon'], false, false)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'İhtiyaç Listesi', 'Needs List', 'Kişinin kariyer alanına göre ihtiyaçlarını belirleyin.', 'Identify needs based on the person''s career field.', 7, null),
(s_id, 2, 'Ürün Alışverişi', 'Product Shopping', 'Kaliteli ajanda, kalem, kartvizitlik, kitap ve aksesuar alın.', 'Buy quality planner, pen, card holder, book and accessories.', 5, 1000),
(s_id, 3, 'Kutu Hazırlama', 'Box Preparation', 'Güzel bir kutuya düzenli şekilde yerleştirin. Kişisel not ekleyin.', 'Neatly place items in a nice box. Add a personal note.', 2, 200),
(s_id, 4, 'Hediye Etme', 'Gift Giving', 'Mezuniyet kutlamasında ya da ilk iş gününde hediye edin.', 'Give the gift at the graduation celebration or on the first day of work.', 0, null);

-- ==========================================
-- 5. BABY (Bebek / Cinsiyet) - 3 scenarios
-- ==========================================

-- 5.1 Cinsiyet Belirleme Partisi
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'gender-reveal-party',
  'Cinsiyet Belirleme Partisi', 'Gender Reveal Party',
  'Bebeğinizin cinsiyetini aileniz ve arkadaşlarınızla birlikte eğlenceli bir şekilde öğrenin. Balonlar, pasta veya konfeti ile renkli bir kutlama yapın.',
  'Find out your baby''s gender in a fun way with family and friends. Have a colorful celebration with balloons, cake or confetti.',
  'Renkli ve eğlenceli cinsiyet partisi', 'Colorful and fun gender reveal party',
  3, 1000, 5000, 10, 30, 10, 'both', ARRAY['winter','spring','summer','fall'], ARRAY['bebek','cinsiyet','parti','aile'], false, true)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Cinsiyet Bilgisini Güvence Altına Alma', 'Secure Gender Info', 'Doktorden zarfla cinsiyeti alın. Güvenilir bir kişiye verin.', 'Get gender info in an envelope from the doctor. Give it to a trusted person.', 10, null),
(s_id, 2, 'Reveal Yöntemi Seçimi', 'Choose Reveal Method', 'Balon patlatma, pasta kesme veya konfeti topu seçin.', 'Choose balloon pop, cake cutting or confetti cannon.', 8, 500),
(s_id, 3, 'Davetiye ve Mekan', 'Invitations and Venue', 'Davetiye gönderin. Mekanı mavi-pembe tema ile dekore edin.', 'Send invitations. Decorate the venue with blue-pink theme.', 7, 1000),
(s_id, 4, 'Yemek ve Pasta', 'Food and Cake', 'Temaya uygun yiyecekler ve özel pasta sipariş edin.', 'Order themed foods and a special cake.', 3, 1500),
(s_id, 5, 'Büyük An', 'The Big Moment', 'Herkes toplandığında reveal anını yaşayın. Tepkileri videoya kaydedin!', 'Experience the reveal moment when everyone gathers. Record the reactions!', 0, null);

-- 5.2 Bebek Odası Sürprizi
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'nursery-room-surprise',
  'Bebek Odası Sürprizi', 'Nursery Room Surprise',
  'Eşiniz evde yokken bebek odasını tamamen hazırlayın. Mobilya, dekorasyon, kıyafetler... Kapıyı açtığında gözyaşlarına hazır olun.',
  'Prepare the nursery room completely while your partner is away. Furniture, decoration, clothes... Be ready for tears when they open the door.',
  'Gizlice hazırlanan rüya bebek odası', 'Secretly prepared dream nursery room',
  4, 3000, 15000, 2, 5, 14, 'indoor', ARRAY['winter','spring','summer','fall'], ARRAY['bebek odası','dekorasyon','mobilya','sürpriz'], true, false)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Tema ve Renk Seçimi', 'Theme and Color Selection', 'Bebek odasının temasını ve renk paletini belirleyin.', 'Determine the nursery theme and color palette.', 14, null),
(s_id, 2, 'Mobilya Alışverişi', 'Furniture Shopping', 'Beşik, şifonyer, sallanan sandalye ve raf alın.', 'Buy crib, dresser, rocking chair and shelves.', 10, 8000),
(s_id, 3, 'Duvar Dekorasyonu', 'Wall Decoration', 'Duvar boyası, sticker veya duvar kağıdı uygulayın.', 'Apply wall paint, stickers or wallpaper.', 7, 2000),
(s_id, 4, 'Detayları Tamamlama', 'Complete Details', 'Perde, halı, aydınlatma, dekoratif objeler yerleştirin.', 'Place curtains, rug, lighting, decorative objects.', 3, 2000),
(s_id, 5, 'Kıyafet ve Aksesuar', 'Clothes and Accessories', 'Bebek kıyafetlerini dolaba düzenli şekilde yerleştirin.', 'Neatly organize baby clothes in the closet.', 1, 1500),
(s_id, 6, 'Sürpriz Anı', 'Surprise Moment', 'Odanın kapısına bir kurdele bağlayın. Birlikte açın.', 'Tie a ribbon on the room door. Open it together.', 0, null);

-- 5.3 Baby Shower
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'baby-shower',
  'Baby Shower Partisi', 'Baby Shower Party',
  'Anne adayı için sıcak ve eğlenceli bir baby shower düzenleyin. Oyunlar, hediyeler ve bol kahkaha ile unutulmaz bir gün geçirin.',
  'Organize a warm and fun baby shower for the mom-to-be. Spend an unforgettable day with games, gifts and lots of laughter.',
  'Sıcak ve eğlenceli baby shower', 'Warm and fun baby shower',
  2, 1000, 5000, 8, 25, 10, 'indoor', ARRAY['winter','spring','summer','fall'], ARRAY['baby shower','parti','hediye','oyun'], false, false)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Tema Belirleme', 'Choose Theme', 'Sevimli bir tema seçin: hayvanlar, yıldızlar, gökkuşağı vb.', 'Choose a cute theme: animals, stars, rainbow etc.', 10, null),
(s_id, 2, 'Davetiye Gönderimi', 'Send Invitations', 'Temaya uygun davetiyeler hazırlayıp gönderin.', 'Prepare and send themed invitations.', 8, 200),
(s_id, 3, 'Dekorasyon ve Mekan', 'Decoration and Venue', 'Mekanı balon, çiçek ve temalı süslerle hazırlayın.', 'Prepare the venue with balloons, flowers and themed decorations.', 5, 1000),
(s_id, 4, 'Oyunlar ve Aktiviteler', 'Games and Activities', 'Bebek bezi yarışı, tahmin oyunları ve dilek kartları hazırlayın.', 'Prepare diaper race, guessing games and wish cards.', 3, 300),
(s_id, 5, 'Yemek ve Pasta', 'Food and Cake', 'Tatlı büfesi, finger food ve özel pasta hazırlayın.', 'Prepare dessert buffet, finger food and special cake.', 2, 1500),
(s_id, 6, 'Parti Günü', 'Party Day', 'Mekanı hazırlayın. Anne adayını karşılayın ve kutlamaya başlayın!', 'Set up the venue. Welcome the mom-to-be and start celebrating!', 0, null);

-- ==========================================
-- 6. ROMANTIC (Romantik Sürpriz) - 3 scenarios
-- ==========================================

-- 6.1 Çatı Katı Romantik Akşam
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'rooftop-romantic-dinner',
  'Çatı Katında Romantik Akşam', 'Rooftop Romantic Evening',
  'Şehrin ışıkları altında, çatı katında özel bir akşam yemeği hazırlayın. Mumlar, çiçekler ve yıldızlı gece ile büyülü bir atmosfer yaratın.',
  'Prepare a special dinner on the rooftop under city lights. Create a magical atmosphere with candles, flowers and a starry night.',
  'Yıldızlar altında romantik akşam yemeği', 'Romantic dinner under the stars',
  3, 500, 3000, 2, 2, 5, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['romantik','akşam yemeği','çatı','mum ışığı'], false, true)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Mekan Hazırlığı', 'Venue Preparation', 'Çatı katı erişimini ayarlayın. Gerekli izinleri alın.', 'Arrange rooftop access. Get necessary permissions.', 5, null),
(s_id, 2, 'Masa ve Dekor', 'Table and Decor', 'Masa örtüsü, tabak, kadeh, mum, çiçek ve ışık zinciri hazırlayın.', 'Prepare tablecloth, plates, glasses, candles, flowers and string lights.', 3, 800),
(s_id, 3, 'Menü Planlama', 'Menu Planning', 'Ev yapımı veya özel sipariş yemek hazırlayın. Şarap veya şampanya seçin.', 'Prepare homemade or special order meal. Choose wine or champagne.', 2, 1000),
(s_id, 4, 'Müzik ve Atmosfer', 'Music and Ambiance', 'Romantik müzik listesi ve hoparlör hazırlayın.', 'Prepare a romantic playlist and speaker.', 1, 100),
(s_id, 5, 'Büyülü Akşam', 'Magical Evening', 'Her şeyi 2 saat önceden kurun. Partneri gözleri kapalı getirin.', 'Set up everything 2 hours early. Bring your partner with eyes closed.', 0, null);

-- 6.2 Aşk Mektubu Rotası
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'love-letter-trail',
  'Aşk Mektubu Rotası', 'Love Letter Trail',
  'Evin farklı köşelerine gizlenmiş aşk mektupları bırakın. Her mektup bir anıyı anlatır ve bir sonraki mektubun yerini gösterir.',
  'Leave love letters hidden in different corners of the house. Each letter tells a memory and shows where the next letter is.',
  'Eve gizlenmiş mektuplarla romantik macera', 'Romantic adventure with hidden letters at home',
  1, 50, 300, 1, 2, 3, 'indoor', ARRAY['winter','spring','summer','fall'], ARRAY['mektup','romantik','ev','macera'], false, false)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Mektup Yazma', 'Write Letters', '5-7 adet kısa aşk mektubu yazın. Her biri bir anıyı veya sevdiğiniz bir özelliği anlatsın.', 'Write 5-7 short love letters. Each one describes a memory or a quality you love.', 3, null),
(s_id, 2, 'Gizleme Planı', 'Hiding Plan', 'Mektupları nereye saklayacağınızı planlayın. Her mektup bir sonrakinin ipucunu versin.', 'Plan where to hide the letters. Each letter gives a clue to the next one.', 2, null),
(s_id, 3, 'Son Durak Hediyesi', 'Final Stop Gift', 'Son mektubun yanına küçük bir hediye koyun: çiçek, çikolata veya anlamlı bir obje.', 'Place a small gift with the last letter: flowers, chocolate or a meaningful object.', 1, 200),
(s_id, 4, 'Mektupları Yerleştirme', 'Place the Letters', 'Partner uyurken veya evde yokken mektupları saklayın. İlk mektubu görünür bırakın.', 'Hide letters while partner is sleeping or away. Leave the first letter visible.', 0, null);

-- 6.3 Yıldız Haritası Hediyesi
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'star-map-gift',
  'Yıldız Haritası Hediyesi', 'Star Map Gift',
  'Tanıştığınız veya özel bir anınızın tarihindeki gökyüzü haritasını bastırın. Altına anlamlı bir not ekleyin ve çerçeveletip hediye edin.',
  'Print the star map of the sky on the date you met or a special moment. Add a meaningful note and gift it framed.',
  'Özel tarihte gökyüzü haritası hediyesi', 'Sky map gift from a special date',
  1, 200, 800, 1, 1, 10, 'indoor', ARRAY['winter','spring','summer','fall'], ARRAY['yıldız','harita','hediye','kişisel'], false, false)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Tarih ve Konum Belirleme', 'Determine Date and Location', 'Özel tarihinizi ve konumunuzu belirleyin (tanışma, ilk öpücük vb.).', 'Determine your special date and location (meeting, first kiss etc.).', 10, null),
(s_id, 2, 'Harita Tasarımı', 'Map Design', 'Online yıldız haritası servisi ile haritanızı tasarlayın. Altına mesaj ekleyin.', 'Design your map with an online star map service. Add a message below.', 7, 300),
(s_id, 3, 'Baskı ve Çerçeve', 'Print and Frame', 'Kaliteli kağıda bastırın ve zarif bir çerçeveye koyun.', 'Print on quality paper and place in an elegant frame.', 3, 300),
(s_id, 4, 'Hediye Etme', 'Gift Giving', 'Romantik bir anda hediye edin. Neden o tarihi seçtiğinizi anlatın.', 'Gift it at a romantic moment. Explain why you chose that date.', 0, null);

-- ==========================================
-- 7. FRIENDSHIP (Arkadaşlık) - 3 scenarios
-- ==========================================

-- 7.1 Retro Film Gecesi
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'retro-movie-night',
  'Retro Film Gecesi', 'Retro Movie Night',
  'Eski günlerdeki gibi bir film gecesi organize edin. Projeksiyon, patlamış mısır, battaniyeler ve gençlik filmlerinizle nostaljik bir gece yaşayın.',
  'Organize a movie night like the old days. Have a nostalgic night with a projector, popcorn, blankets and your youth movies.',
  'Nostaljik film gecesi organizasyonu', 'Nostalgic movie night organization',
  1, 200, 1000, 3, 10, 3, 'indoor', ARRAY['winter','fall'], ARRAY['film','nostalji','arkadaşlık','eğlence'], false, false)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Film Seçimi', 'Movie Selection', 'Birlikte izlediğiniz eski filmleri belirleyin. 2-3 film seçin.', 'Identify old movies you watched together. Choose 2-3 movies.', 3, null),
(s_id, 2, 'Mekan Hazırlığı', 'Space Setup', 'Projeksiyon veya büyük ekran kurun. Yastık, battaniye ve rahat köşe hazırlayın.', 'Set up projector or large screen. Prepare pillows, blankets and cozy corners.', 2, 500),
(s_id, 3, 'Atıştırmalıklar', 'Snacks', 'Popcorn, cips, pizza ve içecek hazırlayın.', 'Prepare popcorn, chips, pizza and drinks.', 1, 300),
(s_id, 4, 'Film Gecesi', 'Movie Night', 'Herkesi toplayın, ışıkları kapatın ve filmi başlatın!', 'Gather everyone, turn off the lights and start the movie!', 0, null);

-- 7.2 Sürpriz Doğa Kampı
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'surprise-camping-trip',
  'Sürpriz Doğa Kampı', 'Surprise Camping Trip',
  'Arkadaş grubunuzu sürpriz bir kamp gezisine çıkarın. Doğada ateş başında sohbet, yıldızları izleme ve macera dolu bir gece geçirin.',
  'Take your friend group on a surprise camping trip. Spend a night in nature with campfire chats, stargazing and adventure.',
  'Arkadaşlarla sürpriz kamp macerası', 'Surprise camping adventure with friends',
  3, 500, 3000, 3, 8, 7, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['kamp','doğa','macera','arkadaşlık'], false, true)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Kamp Yeri Seçimi', 'Choose Campsite', 'Güvenli ve doğası güzel bir kamp alanı belirleyin. İzinleri kontrol edin.', 'Choose a safe campsite with beautiful nature. Check permits.', 7, null),
(s_id, 2, 'Ekipman Hazırlığı', 'Equipment Preparation', 'Çadır, uyku tulumu, kamp sandalyesi ve aydınlatma temin edin.', 'Procure tents, sleeping bags, camp chairs and lighting.', 5, 1500),
(s_id, 3, 'Yiyecek Planı', 'Food Plan', 'Mangal malzemesi, marshmallow ve içecek hazırlayın.', 'Prepare BBQ supplies, marshmallows and drinks.', 3, 800),
(s_id, 4, 'Arkadaşları Toplama', 'Gather Friends', 'Herkese "bir yere gidiyoruz" deyip sürprizi son ana kadar saklayın.', 'Tell everyone "we''re going somewhere" and keep the surprise until the last moment.', 1, null),
(s_id, 5, 'Kamp Günü', 'Camping Day', 'Çadırları kurun, ateşi yakın ve maceraya başlayın!', 'Set up tents, start the fire and begin the adventure!', 0, null);

-- 7.3 Zaman Kapsülü
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'time-capsule',
  'Zaman Kapsülü', 'Time Capsule',
  'Arkadaşlarınızla birlikte bir zaman kapsülü hazırlayın. Mektuplar, fotoğraflar ve anıları bir kutuya koyup 5-10 yıl sonra açılmak üzere gömün.',
  'Create a time capsule with your friends. Put letters, photos and memories in a box and bury it to be opened in 5-10 years.',
  'Geleceğe mektup: arkadaşlık zaman kapsülü', 'Letter to the future: friendship time capsule',
  1, 100, 500, 3, 10, 5, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['zaman kapsülü','anı','arkadaşlık','gelecek'], false, false)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Kutu Hazırlığı', 'Box Preparation', 'Su geçirmez bir kutu veya kavanoz temin edin.', 'Get a waterproof box or jar.', 5, 100),
(s_id, 2, 'İçerik Toplama', 'Collect Contents', 'Herkesten bir mektup, fotoğraf ve küçük bir obje isteyin.', 'Ask everyone for a letter, photo and a small object.', 3, null),
(s_id, 3, 'Gömme Töreni', 'Burial Ceremony', 'Özel bir yerde kapsülü gömün. Koordinatları not alın ve herkesle paylaşın.', 'Bury the capsule at a special place. Note the coordinates and share with everyone.', 0, null);

-- ==========================================
-- 8. APOLOGY (Özür / Barışma) - 3 scenarios
-- ==========================================

-- 8.1 Özür Kahvaltısı
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'apology-breakfast',
  'Özür Kahvaltısı', 'Apology Breakfast',
  'Sabahın erken saatlerinde sevdiğiniz kişi için özel bir kahvaltı hazırlayın. Üzerinde ''Özür dilerim'' yazan bir not ve favori yemekleriyle güne güzel başlasın.',
  'Prepare a special breakfast early in the morning for your loved one. Start the day with a note saying "I''m sorry" and their favorite foods.',
  'Sevgi dolu özür kahvaltısı sürprizi', 'Love-filled apology breakfast surprise',
  1, 100, 500, 1, 2, 1, 'indoor', ARRAY['winter','spring','summer','fall'], ARRAY['özür','kahvaltı','sürpriz','aşk'], false, true)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Menü Planlama', 'Menu Planning', 'Kişinin en sevdiği kahvaltılıkları belirleyin.', 'Identify the person''s favorite breakfast items.', 1, null),
(s_id, 2, 'Malzeme Alışverişi', 'Grocery Shopping', 'Taze malzemeleri önceden alın: yumurta, peynir, taze ekmek, meyve vb.', 'Buy fresh ingredients in advance: eggs, cheese, fresh bread, fruit etc.', 1, 200),
(s_id, 3, 'Kahvaltı Hazırlığı', 'Breakfast Preparation', 'Sabah erken kalkın ve sessizce kahvaltıyı hazırlayın. Tepsiyi çiçekle süsleyin.', 'Wake up early and quietly prepare breakfast. Decorate the tray with flowers.', 0, null),
(s_id, 4, 'Özür Notu', 'Apology Note', 'Samimi bir özür notu yazın ve tepsiye koyun. Yatağa getirin.', 'Write a sincere apology note and place it on the tray. Bring it to bed.', 0, null);

-- 8.2 Anı Kutusu ile Barışma
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'memory-box-reconciliation',
  'Anı Kutusu ile Barışma', 'Memory Box Reconciliation',
  'Birlikte geçirdiğiniz güzel anların fotoğraflarını, biletlerini ve hatıralarını bir kutuya koyun. "Bak ne güzel şeyler yaşadık" mesajıyla barışın.',
  'Put photos, tickets and memories of beautiful times you spent together in a box. Make peace with the message "Look at the beautiful things we shared."',
  'Ortak anılarla kalpleri yumuşatın', 'Soften hearts with shared memories',
  2, 100, 500, 1, 1, 5, 'indoor', ARRAY['winter','spring','summer','fall'], ARRAY['anı','barışma','özür','hediye'], false, false)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Anıları Toplama', 'Gather Memories', 'Birlikte çekilmiş fotoğraflar, konser biletleri, kartpostallar toplayın.', 'Collect photos taken together, concert tickets, postcards.', 5, null),
(s_id, 2, 'Kutu Hazırlığı', 'Box Preparation', 'Güzel bir kutu alın. İçini dekoratif kağıtla kaplalayın.', 'Get a nice box. Line the inside with decorative paper.', 3, 150),
(s_id, 3, 'Mektup Yazma', 'Write Letter', 'Samimi bir özür ve gelecek vaatleri içeren bir mektup yazın.', 'Write a letter with a sincere apology and promises for the future.', 2, null),
(s_id, 4, 'Hediye Etme', 'Give the Gift', 'Kutuyu kişisel bir buluşmada veya kapısının önüne bırakarak verin.', 'Give the box at a personal meeting or leave it at their doorstep.', 0, null);

-- 8.3 Favori Aktivite Günü
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'favorite-activity-day',
  'Favori Aktivite Günü', 'Favorite Activity Day',
  'Kişinin en sevdiği aktiviteleri bir güne sığdırın: favori cafe, film, alışveriş, yemek... Tüm gün ona özel olsun.',
  'Fit the person''s favorite activities into one day: favorite cafe, movie, shopping, dinner... The whole day is dedicated to them.',
  'Tüm gün onun isteklerine göre planlanmış gün', 'A whole day planned according to their wishes',
  2, 500, 3000, 2, 2, 3, 'both', ARRAY['winter','spring','summer','fall'], ARRAY['aktivite','gün','özür','özel'], false, false)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Aktivite Listesi', 'Activity List', 'Kişinin en sevdiği 4-5 aktiviteyi belirleyin.', 'Identify the person''s 4-5 favorite activities.', 3, null),
(s_id, 2, 'Rezervasyonlar', 'Reservations', 'Gerekli restoran, sinema veya mekan rezervasyonlarını yapın.', 'Make necessary restaurant, cinema or venue reservations.', 2, null),
(s_id, 3, 'Günlük Program', 'Daily Schedule', 'Sabahtan akşama kadar programı oluşturun. Aralarına sürpriz detaylar ekleyin.', 'Create a schedule from morning to evening. Add surprise details in between.', 1, null),
(s_id, 4, 'Özel Gün', 'The Special Day', '"Bugün seninle geçirmek istiyorum" deyip güne başlayın.', 'Start the day by saying "I want to spend today with you."', 0, 1500);

-- ==========================================
-- 9. ACHIEVEMENT (Kutlama / Başarı) - 3 scenarios
-- ==========================================

-- 9.1 Terfi/İş Kutlaması
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'promotion-celebration',
  'Terfi Kutlaması', 'Promotion Celebration',
  'İş yerinde terfi alan sevdiğiniz kişi için sürpriz bir kutlama organize edin. Başarısının hak ettiği değeri gösterin.',
  'Organize a surprise celebration for your loved one who got promoted. Show them their success deserves recognition.',
  'Hak edilmiş başarıyı kutlayın', 'Celebrate a well-deserved achievement',
  2, 500, 3000, 2, 15, 5, 'indoor', ARRAY['winter','spring','summer','fall'], ARRAY['terfi','iş','kutlama','başarı'], false, true)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'İş Arkadaşları ile İletişim', 'Contact Colleagues', 'Varsa iş arkadaşlarını sürpriz için organize edin.', 'Organize colleagues for the surprise if applicable.', 5, null),
(s_id, 2, 'Mekan Ayarlama', 'Arrange Venue', 'Favori restoranında veya evde kutlama mekanı ayarlayın.', 'Arrange celebration at their favorite restaurant or at home.', 3, 1000),
(s_id, 3, 'Özel Hediye', 'Special Gift', 'Yeni pozisyonla ilgili anlamlı bir hediye alın (kalem, saat, kitap vb.).', 'Get a meaningful gift related to the new position (pen, watch, book etc.).', 2, 800),
(s_id, 4, 'Pasta ve Dekorasyon', 'Cake and Decoration', '"Tebrikler" yazılı pasta ve kutlama süsleri hazırlayın.', 'Prepare a "Congratulations" cake and celebration decorations.', 1, 500),
(s_id, 5, 'Sürpriz Anı', 'Surprise Moment', 'İşten döndüğünde veya restoranda bekleyin. SÜRPRIZ!', 'Wait when they return from work or at the restaurant. SURPRISE!', 0, null);

-- 9.2 Başarı Duvarı
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'achievement-wall',
  'Başarı Duvarı Sürprizi', 'Achievement Wall Surprise',
  'Kişinin tüm başarılarını kronolojik sıralamayla bir duvara asın. Diplomalar, sertifikalar, fotoğraflar ve başarı notları ile gurur duvarı oluşturun.',
  'Hang all the person''s achievements chronologically on a wall. Create a pride wall with diplomas, certificates, photos and achievement notes.',
  'Kronolojik başarı duvarı hediyesi', 'Chronological achievement wall gift',
  2, 300, 1500, 1, 3, 7, 'indoor', ARRAY['winter','spring','summer','fall'], ARRAY['başarı','duvar','dekorasyon','gurur'], false, false)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Başarıları Derleme', 'Compile Achievements', 'Tüm diploma, sertifika, ödül ve başarı fotoğraflarını toplayın.', 'Collect all diplomas, certificates, awards and achievement photos.', 7, null),
(s_id, 2, 'Çerçeve ve Malzeme', 'Frames and Materials', 'Uyumlu çerçeveler ve duvar asma malzemeleri alın.', 'Buy matching frames and wall hanging materials.', 5, 800),
(s_id, 3, 'Duvar Tasarımı', 'Wall Design', 'Kronolojik sırayla duvar düzenini planlayın ve asın.', 'Plan the wall layout chronologically and hang them.', 2, null),
(s_id, 4, 'Sürpriz Gösterim', 'Surprise Reveal', 'Kişi odaya girdiğinde duvarı görsün. Tepkiyi kaydedin!', 'Let the person see the wall when they enter the room. Record the reaction!', 0, null);

-- 9.3 Kupa/Ödül Töreni
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'award-ceremony',
  'Mini Ödül Töreni', 'Mini Award Ceremony',
  'Sevdiğiniz kişi için eğlenceli bir ödül töreni düzenleyin. Kişiselleştirilmiş kupalar, komik kategoriler ve duygusal konuşmalarla başarıyı kutlayın.',
  'Organize a fun award ceremony for your loved one. Celebrate with personalized trophies, funny categories and emotional speeches.',
  'Eğlenceli ve duygusal kişisel ödül töreni', 'Fun and emotional personal award ceremony',
  2, 200, 1000, 3, 15, 5, 'indoor', ARRAY['winter','spring','summer','fall'], ARRAY['ödül','kupa','tören','eğlence'], false, false)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Ödül Kategorileri', 'Award Categories', 'Komik ve anlamlı ödül kategorileri belirleyin: "En İyi Partner", "Sabır Ödülü" vb.', 'Create funny and meaningful award categories: "Best Partner", "Patience Award" etc.', 5, null),
(s_id, 2, 'Kupa/Sertifika Hazırlığı', 'Trophy/Certificate Prep', 'Her kategori için kişiselleştirilmiş kupa veya sertifika bastırın.', 'Print personalized trophies or certificates for each category.', 3, 500),
(s_id, 3, 'Konuşma Hazırlığı', 'Speech Preparation', 'Her ödül için kısa ve komik bir sunum konuşması hazırlayın.', 'Prepare a short and funny presentation speech for each award.', 2, null),
(s_id, 4, 'Tören Gecesi', 'Ceremony Night', 'Kırmızı halı gibi bir giriş yapın. Ödülleri teker teker sunun!', 'Create a red carpet-like entrance. Present awards one by one!', 0, 200);

-- ==========================================
-- 10. HOLIDAY (Özel Gün) - 4 scenarios
-- ==========================================

-- 10.1 Sevgililer Günü Sürprizi
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'valentines-day-surprise',
  'Sevgililer Günü Sürprizi', 'Valentine''s Day Surprise',
  'Sevgililer Günü''nde evinizi bir aşk cennetine çevirin. Gül yaprakları, mum ışıkları, el yapımı hediyeler ve romantik bir akşam yemeği ile unutulmaz bir gece yaşayın.',
  'Turn your home into a love paradise on Valentine''s Day. Have an unforgettable night with rose petals, candlelight, handmade gifts and a romantic dinner.',
  'Ev ortamında romantik Sevgililer Günü', 'Romantic Valentine''s Day at home',
  2, 300, 2000, 2, 2, 5, 'indoor', ARRAY['winter'], ARRAY['sevgililer günü','romantik','mum','gül'], false, true)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Hediye Hazırlığı', 'Gift Preparation', 'El yapımı veya kişisel bir hediye hazırlayın.', 'Prepare a handmade or personal gift.', 5, 500),
(s_id, 2, 'Çiçek Siparişi', 'Flower Order', 'Gül veya favori çiçeklerden buket sipariş edin.', 'Order a bouquet of roses or favorite flowers.', 3, 300),
(s_id, 3, 'Mekan Dekorasyonu', 'Venue Decoration', 'Gül yaprakları, mumlar ve ışık zincirleri ile evi dekore edin.', 'Decorate the home with rose petals, candles and string lights.', 1, 400),
(s_id, 4, 'Akşam Yemeği', 'Dinner', 'Ev yapımı romantik yemek hazırlayın veya özel sipariş verin.', 'Prepare a homemade romantic meal or place a special order.', 1, 500),
(s_id, 5, 'Romantik Akşam', 'Romantic Evening', 'Mumları yakın, müziği açın ve gecenin tadını çıkarın.', 'Light the candles, turn on the music and enjoy the night.', 0, null);

-- 10.2 Anneler Günü Sürprizi
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'mothers-day-surprise',
  'Anneler Günü Sürprizi', 'Mother''s Day Surprise',
  'Annenizi özel hissettirecek bir gün planlayın. Sabah kahvaltısı, spa randevusu, aile fotoğrafı çekimi ve duygusal bir mektupla anneliğin değerini gösterin.',
  'Plan a day to make your mother feel special. Show the value of motherhood with a breakfast, spa appointment, family photo shoot and an emotional letter.',
  'Anneye özel gün planlayın', 'Plan a special day for mom',
  2, 500, 3000, 2, 10, 7, 'both', ARRAY['spring'], ARRAY['anneler günü','aile','hediye','özel gün'], false, false)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Planlama', 'Planning', 'Günün programını oluşturun. Aile bireylerini koordine edin.', 'Create the day''s schedule. Coordinate family members.', 7, null),
(s_id, 2, 'Hediye ve Çiçek', 'Gift and Flowers', 'Annenizin seveceği bir hediye ve çiçek hazırlayın.', 'Prepare a gift and flowers your mother will love.', 5, 800),
(s_id, 3, 'Spa / Güzellik Randevusu', 'Spa / Beauty Appointment', 'Annenize spa veya güzellik merkezi randevusu alın.', 'Book a spa or beauty center appointment for your mother.', 5, 1000),
(s_id, 4, 'Mektup Hazırlığı', 'Letter Preparation', 'Anneye duygusal bir teşekkür mektubu yazın.', 'Write an emotional thank you letter to mom.', 3, null),
(s_id, 5, 'Özel Gün', 'The Special Day', 'Sabah kahvaltısı ile başlayın, hediyeyi verin ve birlikte güzel vakit geçirin.', 'Start with breakfast, give the gift and spend quality time together.', 0, null);

-- 10.3 Yılbaşı Sürprizi
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'new-years-surprise',
  'Yılbaşı Sürpriz Partisi', 'New Year''s Surprise Party',
  'Yılbaşı gecesi için özel bir parti düzenleyin. Geri sayım, havai fişek, dilek fenerleri ve yeni yıl dilekleriyle muhteşem bir gece yaşayın.',
  'Organize a special party for New Year''s Eve. Have an amazing night with countdown, fireworks, wish lanterns and new year wishes.',
  'Unutulmaz yılbaşı partisi', 'Unforgettable New Year''s party',
  3, 1000, 5000, 5, 30, 10, 'both', ARRAY['winter'], ARRAY['yılbaşı','parti','havai fişek','kutlama'], false, true)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Davetli ve Mekan', 'Guests and Venue', 'Davetli listesi oluşturun. Ev veya kiralık mekan ayarlayın.', 'Create a guest list. Arrange home or rental venue.', 10, null),
(s_id, 2, 'Dekorasyon', 'Decoration', 'Yılbaşı ağacı, ışıklar, konfeti ve masa süslemeleri hazırlayın.', 'Prepare Christmas tree, lights, confetti and table decorations.', 5, 1000),
(s_id, 3, 'Yemek ve İçecek', 'Food and Drinks', 'Yılbaşı menüsü hazırlayın: hindi, tatlılar, şampanya.', 'Prepare New Year''s menu: turkey, desserts, champagne.', 3, 2000),
(s_id, 4, 'Eğlence Planı', 'Entertainment Plan', 'Tombala, oyunlar ve geri sayım aktiviteleri planlayın.', 'Plan tombola, games and countdown activities.', 2, 500),
(s_id, 5, 'Parti Gecesi', 'Party Night', 'Herkesi karşılayın. Gece yarısı geri sayımı ile yeni yılı kutlayın!', 'Welcome everyone. Celebrate the new year with the midnight countdown!', 0, null);

-- 10.4 Ramazan Bayramı Sürprizi
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'eid-celebration-surprise',
  'Bayram Kutlama Sürprizi', 'Eid Celebration Surprise',
  'Bayramda aileyi bir araya getirin. Özel bayram kahvaltısı, çocuklar için eğlenceler ve büyükler için duygusal anlar planlayın.',
  'Bring the family together during Eid. Plan a special Eid breakfast, entertainment for kids and emotional moments for elders.',
  'Aileyi buluşturan bayram kutlaması', 'Eid celebration that brings the family together',
  2, 500, 3000, 5, 30, 7, 'both', ARRAY['spring','winter'], ARRAY['bayram','aile','kutlama','gelenek'], false, false)
RETURNING id INTO s_id;

INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Aile Koordinasyonu', 'Family Coordination', 'Tüm aile bireylerini bilgilendirin. Bayram ziyareti planı yapın.', 'Inform all family members. Create an Eid visit plan.', 7, null),
(s_id, 2, 'Bayram Şekeri ve Hediyeler', 'Eid Sweets and Gifts', 'Geleneksel bayram şekerleri hazırlayın. Çocuklar için hediyeler alın.', 'Prepare traditional Eid sweets. Buy gifts for children.', 5, 1000),
(s_id, 3, 'Mekan Hazırlığı', 'Venue Preparation', 'Evi bayrama özel dekore edin. Büyük bir sofra hazırlayın.', 'Decorate the home specially for Eid. Prepare a large table.', 2, 800),
(s_id, 4, 'Bayram Kahvaltısı', 'Eid Breakfast', 'Geleneksel bayram kahvaltısı hazırlayın. Aileyi sofraya toplayın.', 'Prepare a traditional Eid breakfast. Gather the family at the table.', 0, null),
(s_id, 5, 'Bayram Eğlencesi', 'Eid Entertainment', 'Çocuklar için oyunlar, büyükler için sohbet ve aile fotoğrafı çekin.', 'Organize games for kids, chat for elders and take family photos.', 0, 500);

END $$;
