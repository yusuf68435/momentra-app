-- ==========================================
-- SEED: 68 Additional Scenarios (s-33 to s-100)
-- World-inspired surprise ideas
-- ==========================================

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
-- PROPOSAL - 7 new scenarios
-- ==========================================

-- Custom Bookstore Proposal
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'custom-bookstore-proposal',
  'Kitapçıda Gizli Kitap Teklifi', 'Custom Bookstore Proposal',
  'Aşk hikayenizi anlatan özel basılmış bir kitabı, sevdiğinizin favori kitapçısının rafına gizlice yerleştirin. Kitapçıda gezinirken kitabı keşfetsin — son sayfada evlilik teklifi!',
  'Secretly place a custom-printed book telling your love story on the shelf of their favorite bookstore. They discover it while browsing — the last page contains your proposal!',
  'Kitap rafında gizli evlilik teklifi', 'Hidden proposal in a bookstore',
  4, 2000, 6000, 2, 3, 28, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kitap','yaratıcı','gizli','duygusal'], true, true)
RETURNING id INTO s_id;
INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Aşk Hikayesini Yaz', 'Write Your Love Story', 'İlişkinizi 15-20 sayfada anlatan hikayeyi yazın, fotoğraflar ekleyin.', 'Write your relationship story in 15-20 pages, add photos.', 28, 0),
(s_id, 2, 'Kitabı Bastır', 'Print the Book', 'Online self-publishing servisi ile profesyonel ciltli kitap bastırın.', 'Print a professional hardcover book with an online self-publishing service.', 14, 1500),
(s_id, 3, 'Kitapçıyla Koordine Et', 'Coordinate with Bookstore', 'Bağımsız kitapçıyla konuşup kitabı belirli bir rafa yerleştirmesini isteyin.', 'Talk to an independent bookstore to place your book on a specific shelf.', 3, 0),
(s_id, 4, 'Keşif Anı', 'The Discovery Moment', 'Birlikte kitapçıya gidin, doğru rafa yönlendirin ve keşfetmesini izleyin!', 'Go to the bookstore together, guide to the right shelf, and watch them discover it!', 0, 0);

-- Hot Air Balloon Proposal
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'hot-air-balloon-proposal',
  'Sıcak Hava Balonu Teklifi', 'Hot Air Balloon Proposal',
  'Gün doğumunda sıcak hava balonuyla yükselirken, bulutların üzerinde diz çökün. Profesyonel fotoğrafçı balonda hazır, şampanya soğuyor.',
  'Get on one knee while rising in a hot air balloon at sunrise. Professional photographer ready in the basket, champagne chilling.',
  'Gökyüzünde romantik evlilik teklifi', 'Sky-high romantic proposal',
  3, 5000, 15000, 2, 3, 14, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['balon','gökyüzü','macera','lüks'], true, true)
RETURNING id INTO s_id;
INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Balon Şirketi Araştır', 'Research Balloon Companies', 'Yerel sıcak hava balonu operatörlerini inceleyin, gün doğumu seferi rezervasyonu yapın.', 'Research local hot air balloon operators, book a sunrise flight.', 14, 5000),
(s_id, 2, 'Fotoğrafçı Ayarla', 'Arrange Photographer', 'Balonda çekim yapacak fotoğrafçıyı ayarlayın veya GoPro hazırlayın.', 'Arrange a photographer for in-balloon shooting or prepare a GoPro.', 10, 2000),
(s_id, 3, 'Şampanya ve Yüzük', 'Champagne and Ring', 'Şampanya ve yüzüğü güvenli şekilde balona taşıyın.', 'Safely transport champagne and the ring to the balloon.', 1, 1000),
(s_id, 4, 'Gökyüzünde Teklif!', 'Proposal in the Sky!', 'En güzel manzarada diz çökün ve soruyu sorun!', 'Get on one knee at the most beautiful view and pop the question!', 0, 0);

-- Drone Sky Message Proposal
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'drone-sky-message-proposal',
  'Drone ile Gökyüzü Mesajı Teklifi', 'Drone Sky Message Proposal',
  'Gece gökyüzünde drone ışık şovuyla mesaj yazdırın. LED bantlı tek drone ile bütçe dostu versiyon da mümkün.',
  'Spell a message in the night sky with a drone light show. Budget-friendly version possible with a single LED-banner drone.',
  'Gökyüzünde ışıklı evlilik teklifi', 'Sky-written proposal with drones',
  4, 8000, 50000, 2, 5, 21, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['drone','teknoloji','gökyüzü','lüks'], true, false)
RETURNING id INTO s_id;
INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Drone Operatörü Bul', 'Find Drone Operator', 'Özel mesaj yapabilen drone şov şirketlerini araştırın.', 'Research drone show companies that can create custom messages.', 21, 0),
(s_id, 2, 'Mesaj ve Görsel Tasarla', 'Design Message and Visuals', 'Mesajı, kalp ve yüzük gibi görselleri planlayın.', 'Plan the message, heart and ring visuals.', 14, 0),
(s_id, 3, 'Mekan Hazırlığı', 'Venue Preparation', 'Açık gökyüzü olan, az ışık kirliliği olan bir mekan hazırlayın.', 'Prepare a location with open sky and minimal light pollution.', 7, 500),
(s_id, 4, 'Gökyüzü Şovu!', 'Sky Show!', 'Sıradan bir bahane ile mekana gidin, gökyüzüne bakmasını sağlayın!', 'Go to the location with a casual excuse, make them look at the sky!', 0, 0);

-- Underwater Love Letter
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'underwater-love-letter',
  'Su Altı Aşk Mektubu Teklifi', 'Underwater Love Letter Proposal',
  'Dalış sırasında su geçirmez bir tahtaya yazılmış mesajı gösterin. Denizin sessizliğinde duygusal bir an.',
  'Show a waterproof board message during a dive. An emotional moment in the silence of the sea.',
  'Dalışta su altı evlilik teklifi', 'Underwater diving proposal',
  4, 3000, 12000, 2, 4, 14, 'outdoor', ARRAY['summer'], ARRAY['dalış','deniz','macera','su-altı'], true, false)
RETURNING id INTO s_id;
INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Dalış Kursu Rezervasyonu', 'Dive Course Reservation', 'Güvenilir dalış merkezi bulun, tandem dalış rezervasyonu yapın.', 'Find a reputable dive center, book a tandem dive session.', 14, 3000),
(s_id, 2, 'Su Geçirmez Tahta Hazırla', 'Prepare Waterproof Board', 'Mesajı su geçirmez tahtaya yazın ve suda test edin.', 'Write the message on a waterproof board and test it in water.', 7, 200),
(s_id, 3, 'Su Altı Kamera', 'Underwater Camera', 'GoPro veya su altı fotoğrafçısı ayarlayın.', 'Arrange a GoPro or underwater photographer.', 5, 1000),
(s_id, 4, 'Dalışta Teklif!', 'Proposal During Dive!', 'En güzel noktada tahtayı çıkarın ve gösterin!', 'Pull out the board at the most scenic point and show it!', 0, 0);

-- Glow-in-the-Dark Ceiling
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'glow-ceiling-confession',
  'Karanlıkta Parlayan Tavan Teklifi', 'Glow-in-the-Dark Ceiling Proposal',
  'Yatak odasının tavanına fosforlu yıldızlarla mesaj yazın. Işıklar kapandığında mesaj ortaya çıksın.',
  'Spell a message with glow-in-the-dark stars on the bedroom ceiling. The message appears when lights go off.',
  'Tavanda parlayan yıldız teklifi', 'Glowing stars ceiling proposal',
  1, 100, 300, 1, 1, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['ucuz','kolay','samimi','yatak-odası'], false, false)
RETURNING id INTO s_id;
INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Fosforlu Yıldız Al', 'Buy Glow Stars', 'Fosforlu yıldız çıkartmaları satın alın.', 'Purchase glow-in-the-dark star stickers.', 1, 100),
(s_id, 2, 'Mesajı Tavana Yaz', 'Write Message on Ceiling', 'Eşiniz yokken tavana mesajı yapıştırın. Yataktan okunacak şekilde ayarlayın.', 'Stick the message while they are away. Position so it is readable from bed.', 0, 0),
(s_id, 3, 'Işıkları Şarj Et', 'Charge the Stars', 'Oda ışığını en az 30 dk açık bırakarak yıldızları şarj edin.', 'Leave room lights on for 30+ minutes to charge the stars.', 0, 0),
(s_id, 4, 'Işıkları Kapat ve Bekle!', 'Turn Off Lights and Wait!', 'Yatağa girin, ışıkları kapatın, yukarı bakmasını bekleyin!', 'Get in bed, turn off lights, wait for them to look up!', 0, 0);

-- Flash Mob Proposal
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'flash-mob-proposal',
  'Flash Mob Evlilik Teklifi', 'Flash Mob Proposal',
  'Parkta veya meydanda arkadaşlarınız dans etmeye başlasın! Müzik yükselsin, kalabalık açılsın ve ortada diz çökün.',
  'Friends start dancing in a park or square! Music rises, the crowd parts, and you get on one knee in the center.',
  'Dans ve müzikle sürpriz teklif', 'Flash mob dance proposal',
  4, 3000, 10000, 10, 30, 21, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['dans','müzik','kalabalık','eğlenceli'], true, true)
RETURNING id INTO s_id;
INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Koreografi ve Şarkı Seç', 'Choose Choreography and Song', 'Sevdiği şarkıyı seçin ve basit bir koreografi oluşturun.', 'Choose their favorite song and create simple choreography.', 21, 0),
(s_id, 2, 'Dansçıları Topla ve Prova', 'Recruit Dancers and Rehearse', '10-30 arkadaş toplayın ve 2-3 gizli prova yapın.', 'Recruit 10-30 friends and hold 2-3 secret rehearsals.', 14, 500),
(s_id, 3, 'Kameracıları Yerleştir', 'Position Camera Crew', 'Birden fazla açıdan çekim yapacak kişileri ayarlayın.', 'Arrange people to film from multiple angles.', 3, 0),
(s_id, 4, 'Flash Mob Başlasın!', 'Let the Flash Mob Begin!', 'İşaret verin, dansçılar harekete geçsin, siz ortada diz çökün!', 'Give the signal, dancers start moving, get on one knee!', 0, 0);

-- Surprise Trip Proposal
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'surprise-trip-proposal',
  'Sürpriz Seyahat Teklifi', 'Surprise Trip Proposal',
  'Farklı bir şehire gidiyoruz deyin ama asıl hayalindeki şehir olsun. Aktarma sırasında gerçek destinasyonu açıklayıp orada teklif edin.',
  'Tell them you are going to City A, but the real destination is their dream city. Reveal during the layover and propose there.',
  'Gizli destinasyonda evlilik teklifi', 'Secret destination proposal',
  3, 5000, 25000, 2, 2, 21, 'both', ARRAY['spring','summer','fall'], ARRAY['seyahat','sürpriz','lüks','yurt-dışı'], true, false)
RETURNING id INTO s_id;
INSERT INTO public.scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, days_before, estimated_cost) VALUES
(s_id, 1, 'Hayalindeki Destinasyonu Belirle', 'Identify Dream Destination', 'Bahsettiği hayalindeki şehri belirleyin, uçak bileti ve otel ayarlayın.', 'Identify the dream city they have mentioned, book flights and hotel.', 21, 8000),
(s_id, 2, 'Sahte Seyahat Planı', 'Fake Travel Plan', 'İnandırıcı bir sahte destinasyon hikayesi oluşturun.', 'Create a convincing fake destination story.', 14, 0),
(s_id, 3, 'Gizli Bavul Hazırlığı', 'Secret Packing', 'Gerçek destinasyon için uygun kıyafetleri gizlice hazırlayın.', 'Secretly prepare appropriate clothes for the real destination.', 3, 0),
(s_id, 4, 'Büyük Açıklama!', 'The Big Reveal!', 'Aktarma sırasında gerçek destinasyonu açıklayın ve orada teklif edin!', 'Reveal the true destination during layover and propose there!', 0, 0);

-- ==========================================
-- BIRTHDAY - 9 new scenarios
-- ==========================================

INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES
(gen_random_uuid(), cat_birthday, 'korean-doljanchi-party', 'Kore Usulü Doljanchi Partisi', 'Korean Doljanchi Birthday Party', 'Kore geleneğiyle süslenmiş masa, Doljabi falı oyunu ve Kore yemekleri.', 'Korean tradition with decorated table, Doljabi fortune game, and Korean cuisine.', 'Kore geleneğiyle doğum günü', 'Korean tradition birthday', 2, 1000, 4000, 10, 30, 10, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kore','gelenek','parti','yemek'], false, true),
(gen_random_uuid(), cat_birthday, 'mexican-fiesta-birthday', 'Meksika Fiesta Doğum Günü', 'Mexican Fiesta Birthday Party', 'Renkli papel picado, piñata, Las Mañanitas ve La Mordida pasta geleneği! Taco barı ile eğlence.', 'Colorful papel picado, piñata, Las Mañanitas, and La Mordida cake tradition! Taco bar fun.', 'Renkli Meksika doğum günü partisi', 'Colorful Mexican birthday fiesta', 2, 1500, 5000, 10, 40, 5, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['meksika','piñata','parti','renkli'], false, false),
(gen_random_uuid(), cat_birthday, 'sakura-birthday', 'Sakura Doğum Günü Kutlaması', 'Sakura Cherry Blossom Birthday', 'Japon estetiğinden ilham alan zarif doğum günü. Kiraz çiçeği dekor, matcha pasta, origami detaylar.', 'Elegant birthday inspired by Japanese aesthetics. Cherry blossom decor, matcha cake, origami details.', 'Japon esintili zarif doğum günü', 'Japanese-inspired elegant birthday', 2, 1000, 4000, 5, 15, 7, 'both', ARRAY['spring'], ARRAY['japon','zarif','matcha','kiraz-çiçeği'], false, false),
(gen_random_uuid(), cat_birthday, 'neon-glow-party', 'Neon Glow Parti Gecesi', 'Neon Glow Dance Party', 'UV ışıklar, neon yüz boyaları, fosforlu balonlar ve karanlıkta parlayan kokteyller!', 'UV lights, neon face paint, glow-in-the-dark balloons and cocktails!', 'Karanlıkta parlayan neon parti', 'Glow-in-the-dark neon party', 3, 2000, 8000, 15, 50, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['neon','dans','UV','parti'], false, true),
(gen_random_uuid(), cat_birthday, 'adventure-passport-birthday', 'Macera Pasaportu Doğum Günü', 'Adventure Day Passport Birthday', 'Özel tasarım pasaport kitapçığı — her sayfada farklı sürpriz aktivite! Gün boyu macera.', 'Custom passport booklet — each page reveals a different surprise activity! All-day adventure.', 'Gün boyu sürpriz macera turu', 'All-day surprise adventure tour', 3, 1500, 6000, 1, 5, 10, 'both', ARRAY['spring','summer','fall'], ARRAY['macera','gün-boyu','pasaport','yaratıcı'], true, false),
(gen_random_uuid(), cat_birthday, 'sticky-note-takeover', 'Yapışkan Not İstilası', 'Sticky Note Takeover Birthday', 'Odayı yüzlerce renkli yapışkan notla kaplayın! Her notta bir anı, şaka veya sevgi nedeni.', 'Cover the room with hundreds of colorful sticky notes! Each with a memory, joke, or reason you love them.', 'Yüzlerce notla renkli sürpriz', 'Hundreds of notes surprise', 1, 50, 200, 1, 3, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['ucuz','kolay','renkli','kişisel'], false, false),
(gen_random_uuid(), cat_birthday, 'this-is-your-life-dinner', 'Bu Senin Hayatın Yemeği', 'This Is Your Life Birthday Dinner', 'Hayatının her döneminden insanları bir araya getirin. Her biri bir anı paylaşsın.', 'Bring together people from every era of their life. Each shares a memory.', 'Tüm dönemlerden arkadaşlarla yemek', 'Life chapters dinner party', 3, 1500, 5000, 10, 25, 21, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['duygusal','yemek','arkadaşlar','anı'], false, false),
(gen_random_uuid(), cat_birthday, 'enchanted-forest-party', 'Büyülü Orman Partisi', 'Enchanted Forest Party', 'Bahçeyi peri ışıkları, yosun, dallar ve fenerlerle mistik ormana dönüştürün.', 'Transform garden into a mystical forest with fairy lights, moss, branches, and lanterns.', 'Mistik orman temalı doğum günü', 'Mystical forest theme birthday', 3, 2000, 6000, 10, 30, 5, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['orman','doğa','peri','rustik'], false, false),
(gen_random_uuid(), cat_birthday, 'german-kinderfeste', 'Alman Usulü Kinderfeste Günü', 'German Kinderfeste Birthday', 'Gün doğumunda yaş mumları, gün boyu hiç iş yok, doğum günü sahibi kral/kraliçe!', 'Age candles at sunrise, no chores all day, birthday person is king/queen!', 'Gün boyu kral gibi kutlama', 'Full-day royal celebration', 1, 500, 1500, 2, 10, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['alman','gelenek','gün-boyu','aile'], false, false);

-- ==========================================
-- ANNIVERSARY - 7 new scenarios
-- ==========================================

INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES
(gen_random_uuid(), cat_anniversary, 'korean-100-day-box', 'Kore 100 Gün Kutusu', 'Korean 100-Day Countdown Box', '100 bölmeli kutu: notlar, fotoğraflar, şekerler, küçük hediyeler. Her gün bir tane açılır!', '100-compartment box: notes, photos, candies, small gifts. One opened daily!', '100 günlük sürpriz geri sayım', '100-day surprise countdown', 3, 500, 3000, 1, 1, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kore','geri-sayım','hediye','romantik'], true, false),
(gen_random_uuid(), cat_anniversary, 'italian-passeggiata', 'İtalyan Passeggiata Akşamı', 'Italian Passeggiata Evening', 'İtalyan akşam yürüyüşü geleneği. Şık giyinin, güzel sokaklarda yürüyün, dondurma ve espresso.', 'Italian evening stroll tradition. Dress up, walk scenic streets, gelato and espresso.', 'İtalyan usulü romantik akşam gezisi', 'Italian-style romantic evening walk', 1, 300, 1500, 2, 2, 1, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['italyan','yürüyüş','dondurma','romantik'], false, false),
(gen_random_uuid(), cat_anniversary, 'twelve-hour-surprise-marathon', '12 Saatlik Sürpriz Maratonu', '12-Hour Surprise Marathon', 'Sabahtan akşama her saat başı farklı mikro-sürpriz! Kahvaltı, çiçek, hediye ve büyük final.', 'A different micro-surprise every hour from morning to night! Breakfast, flowers, gift, and grand finale.', 'Her saat farklı sürpriz', 'Hourly surprises all day', 4, 2000, 8000, 3, 5, 14, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['maraton','gün-boyu','yaratıcı','koordineli'], true, true),
(gen_random_uuid(), cat_anniversary, 'love-lock-bridge', 'Evde Aşk Kilidi Köprüsü', 'Love Lock Bridge at Home', 'Seoul N Tower geleneğinden ilham alarak balkona mini kilit köprüsü kurun. Kilidi takın, anahtarı atın.', 'Inspired by Seoul N Tower, set up a mini lock bridge on your balcony. Attach the lock, toss the key.', 'Kendi aşk kilidi köprünüzü kurun', 'Build your own love lock bridge', 1, 200, 800, 2, 2, 2, 'outdoor', ARRAY['spring','summer','fall','winter'], ARRAY['kore','kilit','sembolik','romantik'], false, false),
(gen_random_uuid(), cat_anniversary, 'cinematic-flashback-reel', 'Sinematik Anı Filmi', 'Cinematic Flashback Reel', 'İlişkinizden fotoğraf ve videolarla kısa film hazırlayıp projektörle gala düzenleyin.', 'Create a short film from relationship photos and videos, host a projector premiere.', 'Anılarınız beyaz perdede', 'Your memories on the big screen', 2, 300, 1500, 1, 2, 10, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['film','anı','projektör','duygusal'], false, false),
(gen_random_uuid(), cat_anniversary, 'tango-lesson-for-two', 'İkiye Özel Tango Dersi', 'Private Tango Lesson for Two', 'Arjantin tangosu özel dersi. Loş ışıkta birbirinize güvenmeyi öğrenin. Ardından Arjantin yemeği.', 'Private Argentine tango lesson. Learn trust in dim light. Then Argentine dinner.', 'Romantik özel tango dersi', 'Romantic private tango lesson', 2, 800, 3000, 2, 3, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['dans','tango','arjantin','romantik'], false, false),
(gen_random_uuid(), cat_anniversary, 'calligraphy-love-map', 'Kaligrafi Aşk Haritası', 'Calligraphy Love Map', 'İlişkinizin önemli mekanlarını işaretleyen el yapımı kaligrafi harita. Çerçevelenmiş duvar sanatı.', 'Handmade calligraphy map marking meaningful relationship places. Framed wall art.', 'El yapımı anlamlı mekan haritası', 'Handmade meaningful places map', 2, 200, 1500, 1, 1, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kaligrafi','harita','el-yapımı','sanat'], false, false);

-- ==========================================
-- GRADUATION - 4 new scenarios
-- ==========================================

INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES
(gen_random_uuid(), cat_graduation, 'graduation-scavenger-hunt', 'Mezuniyet Hazine Avı', 'Graduation Scavenger Hunt', 'Önemli mekanlar üzerinden ipuçlu macera: eski okul, kütüphane, çalışma kafesi. Finalde büyük sürpriz!', 'Clue-based adventure through meaningful places: old school, library, study cafe. Big surprise at finale!', 'Anlam dolu mekan avı mezuniyet', 'Meaningful places graduation hunt', 3, 500, 3000, 2, 10, 10, 'both', ARRAY['spring','summer'], ARRAY['hazine-avı','anı','mezuniyet','macera'], false, false),
(gen_random_uuid(), cat_graduation, 'senbazuru-wish-cranes', 'Senbazuru Dilek Turnaları', 'Senbazuru Wish Paper Cranes', 'Japon geleneğinde 1000 origami turna dilek getirir. Arkadaşlar turna katlar, her birine dilek yazar.', 'In Japanese tradition 1000 origami cranes grant a wish. Friends fold cranes writing a wish on each.', 'Origami turnalarla dilek hediyesi', 'Origami crane wish gift', 2, 200, 600, 3, 15, 21, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['japon','origami','dilek','el-yapımı'], false, false),
(gen_random_uuid(), cat_graduation, 'vision-board-ceremony', 'Vizyon Panosu Töreni', 'Vision Board Ceremony', 'Yakın arkadaşlarla gelecek vizyon panosu atölyesi. Dilek mumu, anı paylaşımı ve kolektif katkı.', 'Future vision board workshop with close friends. Wish candle, memory sharing, and collective contribution.', 'Gelecek hayalleri panosu töreni', 'Future dreams board ceremony', 1, 300, 1000, 5, 15, 3, 'indoor', ARRAY['spring','summer'], ARRAY['vizyon','gelecek','atölye','dilek'], false, false),
(gen_random_uuid(), cat_graduation, 'friendship-awards-graduation', 'Mezuniyet Dostluk Ödül Gecesi', 'Graduation Friendship Awards Night', 'Sahte ödül töreni! Eğlenceli kategoriler, kırmızı halı, DIY kupalar ve kabul konuşmaları.', 'Mock awards ceremony! Fun categories, red carpet, DIY trophies, and acceptance speeches.', 'Eğlenceli sahte ödül töreni', 'Fun mock awards ceremony', 1, 300, 1000, 4, 15, 5, 'indoor', ARRAY['spring','summer'], ARRAY['ödül','eğlence','arkadaşlık','komik'], false, false);

-- ==========================================
-- BABY - 4 new scenarios
-- ==========================================

INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES
(gen_random_uuid(), cat_baby, 'indian-blessing-baby-shower', 'Hint Usulü Kutsal Baby Shower', 'Indian Blessing Baby Shower', 'Hint geleneğiyle tilak sürme, çiçek kolye ve tatlı ritüelleriyle sıcak bebek kutlaması.', 'Indian tradition with tilak blessing, flower garland, and sweet rituals for warm baby celebration.', 'Hint geleneğiyle ruhani bebek kutlaması', 'Spiritual baby celebration', 2, 800, 3000, 8, 25, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['hint','gelenek','ruhani','bebek'], false, false),
(gen_random_uuid(), cat_baby, 'garden-grazing-baby-shower', 'Bahçe Partisi Grazing Table', 'Garden Grazing Table Baby Shower', 'Bahçede dev otlama masası! Peynirler, meyveler, tatlılar pastel renk düzeninde. Bebek temalı oyunlar.', 'Giant grazing table in garden! Cheeses, fruits, sweets in pastel palette. Baby-themed games.', 'Bahçede dev otlama masası partisi', 'Garden party with grazing table', 2, 1500, 5000, 10, 30, 5, 'outdoor', ARRAY['spring','summer'], ARRAY['bahçe','otlama-masası','pastel','bebek'], false, false),
(gen_random_uuid(), cat_baby, 'balloon-box-gender-reveal', 'Balon Kutusu Cinsiyet Açıklaması', 'Balloon Box Gender Reveal', 'İç içe kutuları açtıkça pembe veya mavi balonlar yükselsin! Konfeti patlaması.', 'Pink or blue balloons rise as nested boxes are opened! Confetti burst.', 'Kutulardan yükselen renkli balonlar', 'Rising balloons from nested boxes', 1, 300, 800, 5, 30, 2, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['balon','kutu','cinsiyet','renkli'], false, false),
(gen_random_uuid(), cat_baby, 'stork-home-decoration', 'Leylek Temalı Ev Süsleme', 'Stork Themed Home Decoration Surprise', 'Evi bebek temasıyla süsleyin! Dev leylek maketi, hoş geldin yazısı, minyatür kıyafetler.', 'Decorate the house baby-themed! Giant stork cutout, welcome banner, tiny clothes.', 'Eve sürpriz bebek dekorasyonu', 'Surprise baby home decoration', 1, 500, 1500, 2, 5, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['leylek','dekorasyon','ev','bebek'], false, false);

-- ==========================================
-- ROMANTIC - 12 new scenarios
-- ==========================================

INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES
(gen_random_uuid(), cat_romantic, 'serenata-moderna', 'La Serenata Moderna', 'Modern Serenade Surprise', 'Meksika serenata geleneği! Canlı müzisyenler pencereden serenat yapsın. Ardından gizli akşam yemeği.', 'Mexican serenade tradition! Live musicians serenade from the window. Then reveal hidden dinner.', 'Canlı müzikle pencere serenası', 'Live music window serenade', 3, 2000, 8000, 3, 6, 7, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['müzik','meksika','serenat','canlı'], true, true),
(gen_random_uuid(), cat_romantic, 'hanami-bento-picnic', 'Hanami Bento Pikniği', 'Japanese Hanami Bento Picnic', 'Japon çiçek seyri geleneğiyle sanat eseri bento kutuları. Çiçek açan ağaçların altında piknik.', 'Japanese flower viewing tradition with art-level bento boxes. Picnic under blossoming trees.', 'Çiçekler altında Japon pikniği', 'Japanese picnic under blossoms', 3, 300, 1500, 2, 2, 2, 'outdoor', ARRAY['spring'], ARRAY['japon','bento','piknik','çiçek'], false, false),
(gen_random_uuid(), cat_romantic, 'rumi-persian-tea', 'Rumi Şiiri ve İran Çay Seremonisi', 'Rumi Poetry and Persian Tea Ceremony', 'Yer minderleri, safran çayı ve baklava eşliğinde Mevlana şiirleri okuyun. Mum ışığında derin akşam.', 'Read Rumi poems with floor cushions, saffron tea, and baklava. Deep evening by candlelight.', 'Şiir ve çayla İran akşamı', 'Poetry and tea Persian evening', 1, 300, 1500, 2, 2, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['şiir','çay','iran','mevlana'], false, false),
(gen_random_uuid(), cat_romantic, 'northern-lights-bedroom', 'Kuzey Işıkları Yatak Odası', 'Northern Lights Bedroom Experience', 'Aurora projektörü, mavi-yeşil LED ve kürk battaniyelerle yatak odanızı dönüştürün. Sıcak şarap ve waffle.', 'Transform bedroom with aurora projector, blue-green LEDs, faux fur blankets. Mulled wine and waffles.', 'Yatak odası Kuzey Işıkları deneyimi', 'Bedroom Northern Lights experience', 1, 500, 2000, 2, 2, 2, 'indoor', ARRAY['fall','winter'], ARRAY['iskandinav','projektör','ışık','romantik'], false, true),
(gen_random_uuid(), cat_romantic, 'sky-lantern-ceremony', 'Gökyüzü Feneri Dilek Töreni', 'Sky Lantern Wish Ceremony', 'Tayvan ve Tayland geleneğinden dilek fenerleri! Her birine dilek yazıp gün batımında bırakın.', 'Taiwanese and Thai tradition wish lanterns! Write a wish on each and release at sunset.', 'Dilek fenerleriyle gökyüzü töreni', 'Sky lantern wish ceremony', 1, 150, 600, 2, 4, 1, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['fener','dilek','tayvan','gökyüzü'], false, false),
(gen_random_uuid(), cat_romantic, 'italian-trattoria-home', 'Evde İtalyan Trattoria Gecesi', 'Italian Trattoria Night at Home', 'Yemek odasını kareli masa örtüsü ve şişe mumlukla mini trattoria''ya çevirin. El yapımı makarna ve tiramisu.', 'Turn dining room into a mini trattoria with checkered tablecloth and wine bottle candles. Handmade pasta and tiramisu.', 'Evde otantik İtalyan akşamı', 'Authentic Italian evening at home', 2, 400, 1500, 2, 2, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['italyan','makarna','yemek','ev'], false, false),
(gen_random_uuid(), cat_romantic, 'rooftop-starlight-dinner', 'Çatıda Yıldız Işığı Yemeği', 'Rooftop Starlight Dinner', 'Terasta peri ışıkları, mumlar ve şehir manzarasıyla üç çeşit romantik yemek. Göz bağıyla sürpriz.', 'Three-course romantic dinner on terrace with fairy lights, candles, and city views. Blindfold surprise.', 'Yıldızlar altında çatı yemeği', 'Dinner under the stars on rooftop', 3, 1000, 4000, 2, 2, 3, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['çatı','yıldız','yemek','manzara'], true, true),
(gen_random_uuid(), cat_romantic, 'luxury-surprise-picnic', 'Lüks Sürpriz Piknik', 'Luxury Surprise Picnic', 'Bohem tarzı lüks piknik: battaniyeler, yastıklar, peynir tabağı, şampanya ve canlı çiçekler.', 'Bohemian luxury picnic: blankets, cushions, cheese board, champagne, and fresh flowers.', 'Bohem tarzı lüks açık hava pikniği', 'Bohemian luxury outdoor picnic', 1, 500, 2000, 2, 4, 1, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['piknik','lüks','bohem','şampanya'], false, false),
(gen_random_uuid(), cat_romantic, 'glamping-getaway', 'Glamping Kaçamak Gecesi', 'Enchanted Glamping Getaway', 'Doğada lüks kamp! Peri ışıklı çadır, gerçek yatak takımı, kilim, fenerler ve gurme peynir tabağı.', 'Luxury camping in nature! Fairy-lit tent, real bedding, rug, lanterns, and gourmet cheese board.', 'Doğada lüks çadır deneyimi', 'Luxury tent experience in nature', 2, 1000, 5000, 2, 2, 5, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['glamping','doğa','lüks','çadır'], true, false),
(gen_random_uuid(), cat_romantic, 'sunset-sailing-surprise', 'Gün Batımı Yelken Sürprizi', 'Sunset Sailing Surprise', 'Marina''da yürüyüşe çıkalım deyin ama şampanyalı tekne turu sizi bekliyor! Denizde romantik saatler.', 'Say lets walk by the marina but a champagne boat tour awaits! Romantic hours on the sea.', 'Denizde gün batımı tekne turu', 'Sunset boat tour on the sea', 2, 2000, 8000, 2, 4, 7, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['yelken','deniz','gün-batımı','tekne'], true, true),
(gen_random_uuid(), cat_romantic, 'horseback-sunset-ride', 'Gün Batımında At Binme', 'Horseback Ride Into the Sunset', 'Sahilde veya kırlarda gün batımında at gezisi! Yeni başlayanlar için uygun. Ardından ateş başında marshmallow.', 'Horseback ride at sunset on beach or countryside! Beginner-friendly. Then marshmallows by the fire.', 'Gün batımında romantik at gezisi', 'Romantic sunset horseback ride', 1, 800, 3000, 2, 4, 7, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['at','gün-batımı','doğa','macera'], false, false),
(gen_random_uuid(), cat_romantic, 'mystery-road-trip', 'Gizemli Yol Gezisi', 'Mystery Road Trip Adventure', 'Gözlerini bağlayın, arabaya bindirin! Yol boyunca mühürlü zarflarla ipucu. Her durakta sürpriz.', 'Blindfold them and drive! Sealed envelope clues along the way. Surprises at each stop.', 'Gizli destinasyonlu yol macerası', 'Secret destination road adventure', 2, 500, 3000, 2, 4, 5, 'both', ARRAY['spring','summer','fall'], ARRAY['yol','gizem','macera','araba'], false, false);

-- ==========================================
-- FRIENDSHIP - 6 new scenarios
-- ==========================================

INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES
(gen_random_uuid(), cat_friendship, 'murder-mystery-dinner', 'Cinayet Gizemi Akşam Yemeği', 'Murder Mystery Dinner Party', 'Herkes karakter canlandırır, ipuçları yemek aralarında açıklanır! Kostümlü interaktif gece.', 'Everyone plays a character, clues revealed between courses! Costumed interactive evening.', 'Kostümlü cinayet gizemi partisi', 'Costumed murder mystery party', 3, 800, 3000, 6, 15, 10, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['gizem','kostüm','interaktif','yemek'], false, true),
(gen_random_uuid(), cat_friendship, 'nostalgia-picnic', 'Nostalji Pikniği', 'Nostalgia Friendship Picnic', 'Arkadaşlığınızın başladığı yerde piknik! Eski fotoğraflar, o zamanki yemekler ve ortak playlist.', 'Picnic where your friendship began! Old photos, the food from back then, and shared playlist.', 'Arkadaşlık anılarıyla piknik', 'Picnic with friendship memories', 1, 200, 800, 2, 8, 3, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['nostalji','piknik','anı','müzik'], false, false),
(gen_random_uuid(), cat_friendship, 'blind-wine-tasting', 'Kör Şarap Tadımı Gecesi', 'Blind Wine Tasting Night', 'Şişeler kağıt poşetle kaplanır, herkes tadarak puan verir ve fiyat tahmin eder!', 'Bottles wrapped in paper bags, everyone tastes, rates, and guesses the price!', 'Gizemli şarap tadımı partisi', 'Mystery wine tasting party', 1, 500, 2000, 4, 10, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['şarap','tadım','interaktif','eğlence'], false, false),
(gen_random_uuid(), cat_friendship, 'thai-street-food-night', 'Tayland Sokak Lezzetleri Gecesi', 'Thai Street Food Night at Home', 'Mutfağı Bangkok sokak pazarına çevirin! Pad Thai, yeşil köri, mango yapışkan pirinç istasyonları.', 'Turn your kitchen into Bangkok street market! Pad Thai, green curry, mango sticky rice stations.', 'Evde Tayland sokak yemekleri', 'Thai street food at home', 2, 400, 1200, 4, 8, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['tayland','yemek','sokak','egzotik'], false, false),
(gen_random_uuid(), cat_friendship, 'japanese-izakaya-night', 'Japon İzakaya Gecesi', 'Japanese Izakaya Night', 'Evde Japon pub yemekleri! Gyoza, yakitori, edamame, tempura. Sake ve lo-fi müzik.', 'Japanese pub dining at home! Gyoza, yakitori, edamame, tempura. Sake and lo-fi music.', 'Evde otantik Japon pub gecesi', 'Authentic Japanese pub night', 2, 500, 1500, 2, 6, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['japon','izakaya','yemek','sake'], false, false),
(gen_random_uuid(), cat_friendship, 'secret-buddy-weekend', 'Gizli Arkadaş Hafta Sonu', 'Secret Buddy Weekend', 'Herkes isim çeker ve hafta sonu boyunca gizlice küçük hediyeler bırakır. Finalde büyük açıklama!', 'Everyone draws a name and secretly leaves small gifts throughout the weekend. Big reveal at the end!', 'Hafta sonu boyunca gizli hediyeler', 'Secret gifts throughout the weekend', 1, 300, 1000, 4, 12, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['gizli','hediye','arkadaş','oyun'], false, false);

-- ==========================================
-- APOLOGY - 5 new scenarios
-- ==========================================

INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES
(gen_random_uuid(), cat_apology, 'open-when-letters', '"Şu An Aç..." Mektup Seti', '"Open When..." Letter Set', 'Farklı anlar için etiketlenmiş mühürlü zarflar: Üzgün olduğunda aç, Beni özlediğinde aç...', 'Sealed envelopes labeled for specific moments: Open when sad, Open when you miss me...', 'Her an için özel mühürlü mektuplar', 'Special sealed letters for every mood', 1, 50, 300, 1, 1, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['mektup','kişisel','duygusal','ucuz'], false, false),
(gen_random_uuid(), cat_apology, 'explosion-box-memories', 'Patlayan Anı Kutusu', 'Explosion Box of Memories', 'Kapağı açınca patlayan origami kutu! İç katmanlarda fotoğraflar, notlar, küçük hatıralar.', 'An origami box that explodes open! Photos, notes, small keepsakes in inner layers.', 'Açılınca patlayan anı kutusu', 'Exploding memory box surprise', 2, 100, 500, 1, 1, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['el-yapımı','origami','fotoğraf','anı'], false, false),
(gen_random_uuid(), cat_apology, '365-reasons-jar', '365 Neden Kavanozu', '365 Reasons Why I Love You Jar', 'Kavanoza 365 küçük not — her birinde seni sevme nedenim. Her gün biri açılır, tam bir yıl.', 'Jar with 365 small notes — each a reason I love you. One opened daily, a whole year.', 'Her gün bir aşk notu tam bir yıl', 'One love note daily for a year', 1, 50, 200, 1, 1, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kavanoz','not','ucuz','kişisel'], false, false),
(gen_random_uuid(), cat_apology, 'watercolor-love-letter', 'Suluboya Aşk Mektubu', 'Watercolor Love Letter', 'Kağıda soyut suluboya arka plan yapın, kuruduktan sonra aşk mektubunuzu yazın. Çerçevelenebilir!', 'Paint abstract watercolor wash on paper, then handwrite your love letter. Frame-worthy!', 'Sanat eseri gibi el yapımı mektup', 'Art-quality handmade love letter', 1, 50, 200, 1, 1, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['suluboya','mektup','sanat','el-yapımı'], false, false),
(gen_random_uuid(), cat_apology, 'spotify-code-keychain', 'Spotify Kod Anahtarlık', 'Spotify Code Keychain Gift', 'Şarkınızın Spotify kodunu anahtarlığa kazıyın. Tarandığında şarkı çalar — gizli müzikal sürpriz.', 'Engrave your songs Spotify code on a keychain. Scanning plays the song — hidden musical surprise.', 'Taranınca şarkı çalan anahtarlık', 'Keychain that plays your song', 1, 50, 300, 1, 1, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['spotify','müzik','anahtarlık','teknoloji'], false, false);

-- ==========================================
-- ACHIEVEMENT - 6 new scenarios
-- ==========================================

INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES
(gen_random_uuid(), cat_achievement, 'retirement-smash-clock', 'Emeklilik Saati Kır Fiestası', 'Retirement Smash the Clock Fiesta', 'Çalar saat şeklinde piñata! Emekli saati kırar, konfetiler uçar. Taco barı ve kariyer slayt gösterisi.', 'Alarm clock-shaped piñata! Retiree smashes it, confetti flies. Taco bar and career slideshow.', 'Piñata kırarak emekliliği kutla', 'Celebrate retirement by smashing piñata', 2, 1500, 5000, 10, 30, 10, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['emeklilik','piñata','meksika','kutlama'], false, false),
(gen_random_uuid(), cat_achievement, 'family-olympics', 'Aile Olimpiyatları', 'Family Olympics Extravaganza', 'Aile üyelerini takımlara ayırın! Çuval yarışı, bilgi yarışması, halat çekme. DIY madalyalar.', 'Divide family into teams! Sack race, trivia, tug of war. DIY medals.', 'Eğlenceli aile spor günü', 'Fun family sports day', 2, 500, 2000, 10, 40, 7, 'outdoor', ARRAY['spring','summer'], ARRAY['aile','olimpiyat','yarışma','eğlence'], false, false),
(gen_random_uuid(), cat_achievement, 'homecoming-feast', 'Hoş Geldin Ziyafeti', 'Homecoming Feast and Memory Wall', 'Uzun süre uzakta kalan kişiye: kaçırdığı anların fotoğraf duvarı ve favori ev yemekleri.', 'For someone returning after long absence: photo wall of missed moments and favorite home-cooked meals.', 'Eve dönen kişiye sürpriz karşılama', 'Surprise homecoming celebration', 2, 500, 2000, 3, 15, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['hoş-geldin','aile','yemek','anı'], false, false),
(gen_random_uuid(), cat_achievement, 'secret-supper-club', 'Gizli Yemek Kulübü Kutlaması', 'Secret Supper Club Celebration', 'Davetlilere sadece tarih ve kıyafet kodu — mekan ve menü gizli! 4 çeşit yemek ve hikaye.', 'Guests receive only date and dress code — venue and menu secret! 4-course meal and stories.', 'Mekanı ve menüsü gizli özel yemek', 'Secret location exclusive dinner', 3, 2000, 6000, 6, 12, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['gizli','yemek','lüks','özel'], true, false),
(gen_random_uuid(), cat_achievement, 'discovery-flight-experience', 'Keşif Uçuşu Deneyimi', 'Discovery Flight Experience', 'Uçuş okulunda keşif uçuşu hediye edin! Küçük uçağın kumandasını gerçekten alır.', 'Gift a discovery flight at a flight school! Actually take the controls of a small aircraft.', 'Gerçek uçak kullanma deneyimi', 'Real flight experience gift', 2, 2000, 5000, 2, 3, 10, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['uçuş','macera','deneyim','hediye'], true, false),
(gen_random_uuid(), cat_achievement, 'retirement-bucket-list', 'Emeklilik Kova Listesi Partisi', 'Retirement Bucket List Party', 'Emeklinin hayat listesini kutlayın! Misafirler bir kova listesi öğesine kolektif katkı sunar.', 'Celebrate the retirees bucket list! Guests collectively contribute toward a bucket list item.', 'Hayallerini gerçekleştiren parti', 'Dreams-come-true party', 2, 1000, 5000, 10, 30, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['emeklilik','kova-listesi','hayal','grup'], false, false);

-- ==========================================
-- HOLIDAY - 8 new scenarios
-- ==========================================

INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES
(gen_random_uuid(), cat_holiday, 'valentines-dessert-bar', 'Sevgililer Günü Tatlı Barı', 'Valentines Day Dessert Bar', 'Akşam yemeği yerine tatlı cenneti! Çikolata lav kek, çilekli krep, fondue ve şampanya.', 'Skip dinner dive into dessert paradise! Chocolate lava cake, strawberry crepes, fondue and champagne.', 'Sadece tatlılarla romantik akşam', 'Romantic evening of just desserts', 2, 400, 1500, 2, 4, 2, 'indoor', ARRAY['winter'], ARRAY['sevgililer-günü','tatlı','çikolata','romantik'], false, true),
(gen_random_uuid(), cat_holiday, 'christmas-morning-brunch', 'Noel Sabahı Sürpriz Brunch', 'Christmas Morning Surprise Brunch', 'Herkes uyanmadan sofraya sihir! Geceden hazırlanan French toast, sıcak çikolata barı ve somon tabağı.', 'Magic at the table before anyone wakes! Overnight French toast casserole, hot cocoa bar, salmon board.', 'Sihirli Noel sabahı sofrası', 'Magical Christmas morning table', 2, 500, 2000, 4, 10, 1, 'indoor', ARRAY['winter'], ARRAY['noel','brunch','sabah','aile'], false, false),
(gen_random_uuid(), cat_holiday, 'new-year-countdown-feast', 'Yılbaşı Geri Sayım Ziyafeti', 'New Years Eve Countdown Feast', 'Gece yarısına kadar her saat farklı çeşit yemek ve kokteyl! Son saatte şampanya ve dilek kartları.', 'A different course and cocktail every hour until midnight! Champagne and wish cards at the final hour.', 'Saatlik çeşitlerle geri sayım', 'Hourly course countdown dinner', 3, 1500, 5000, 4, 12, 3, 'indoor', ARRAY['winter'], ARRAY['yılbaşı','geri-sayım','ziyafet','şampanya'], false, false),
(gen_random_uuid(), cat_holiday, 'songkran-water-festival', 'Songkran Su Festivali', 'Thai Songkran Water Festival', 'Tayland Yeni Yıl geleneğinden ilham! Bahçede su tabancaları, su balonları ve su kaydırağı.', 'Inspired by Thai New Year! Water guns, water balloons, and slip-n-slide in the garden.', 'Bahçede Tayland su festivali', 'Thai water festival in the garden', 1, 300, 1000, 8, 30, 2, 'outdoor', ARRAY['summer'], ARRAY['tayland','su','festival','aile'], false, false),
(gen_random_uuid(), cat_holiday, 'moroccan-riad-dinner', 'Fas Riad Yemek Gecesi', 'Moroccan Riad Dinner Night', 'Yemek odasını Fas riadına çevirin! Yer minderleri, pirinç fenerler, tagine, kuskus ve nane çayı.', 'Transform dining room into Moroccan riad! Floor cushions, brass lanterns, tagine, couscous, mint tea.', 'Evde otantik Fas yemeği deneyimi', 'Authentic Moroccan dining at home', 3, 500, 2000, 4, 8, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['fas','tagine','egzotik','yemek'], false, false),
(gen_random_uuid(), cat_holiday, 'fondue-cozy-night', 'Fondue Keyif Gecesi', 'Cozy Fondue Night', 'Peynir ve çikolata fondue istasyonu! Ekmek, meyve ve tatlıları kaynayan potlara batırın.', 'Cheese and chocolate fondue station! Dip bread, fruit, and sweets into bubbling pots.', 'Kış gecesi peynir-çikolata fondue', 'Winter night cheese-chocolate fondue', 1, 300, 1000, 2, 6, 1, 'indoor', ARRAY['fall','winter'], ARRAY['fondue','peynir','çikolata','kış'], false, false),
(gen_random_uuid(), cat_holiday, 'afternoon-tea-party', 'İngiliz Usulü Çay Partisi', 'Victorian Afternoon Tea Party', 'Katlı tepsiler, parmak sandviçler, scone, petit four ve seçkin çaylar! Vintage porselen ve çiçekler.', 'Tiered trays, finger sandwiches, scones, petit fours, and fine teas! Vintage china and flowers.', 'Zarif İngiliz çay partisi', 'Elegant British tea party', 2, 400, 1500, 4, 8, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['çay','ingiliz','zarif','vintage'], false, false),
(gen_random_uuid(), cat_holiday, 'family-heritage-dinner', 'Aile Kökeni Yemek Gecesi', 'Family Heritage Dinner Night', 'Her aile kolu kendi kökeninden yemek getirir! Harita, eski fotoğraflar ve göç hikayeleri.', 'Each family branch brings a dish from their heritage! Maps, old photos, and migration stories.', 'Kökleri keşfeden aile yemeği', 'Heritage-discovering family dinner', 2, 400, 2000, 6, 25, 10, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['aile','kültür','köken','yemek'], false, false);

END $$;
