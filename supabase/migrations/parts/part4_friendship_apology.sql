-- ==========================================
-- PART 4: FRIENDSHIP (30) + APOLOGY (30) Scenarios
-- 60 total scenarios
-- ==========================================

DO $$
DECLARE
  cat_friendship uuid;
  cat_apology    uuid;
  s_id uuid;
BEGIN

SELECT id INTO cat_friendship FROM public.categories WHERE slug = 'friendship';
SELECT id INTO cat_apology    FROM public.categories WHERE slug = 'apology';

-- ==========================================
-- FRIENDSHIP - 30 scenarios
-- ==========================================

-- 1. friendship-geocaching
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'friendship-geocaching',
'Arkadaşlık Geocaching Macerası', 'Friendship Geocaching Adventure',
'Arkadaşınız için özel bir geocaching parkuru oluşturun. İlişkinizde anlam taşıyan mekanlara küçük hediyeler ve anı notları gizleyin. İlk tanıştığınız kafe, birlikte gezdiğiniz park, en çok güldüğünüz restoran gibi noktaları rotanıza ekleyin. Her noktada bir ipucu ve küçük bir sürpriz beklesin. Son durağa en büyük hediyeyi ve duygusal bir mektup yerleştirin. GPS koordinatlarını süslü bir harita üzerine işaretleyip arkadaşınıza verin. Bu macera boyunca birlikte yürüyecek, eski anıları tazeleyecek ve yeni hatıralar biriktirecesiniz. Parkuru tamamladığınızda kutlama için favori mekanınızda buluşun.',
'Create a custom geocaching trail for your friend. Hide small gifts and memory notes at locations meaningful to your friendship. Include spots like the cafe where you first met, the park you explored together, and the restaurant where you laughed the most. Each stop should have a clue and a small surprise. Place the biggest gift and an emotional letter at the final stop. Mark GPS coordinates on a decorated map and give it to your friend. Throughout this adventure, you''ll walk together, refresh old memories, and create new ones. When you complete the trail, meet at your favorite spot to celebrate.',
'Anlamlı mekanlara gizlenmiş ipuçlarıyla unutulmaz bir arkadaşlık macerası yaşayın.',
'Experience an unforgettable friendship adventure with clues hidden at meaningful spots.',
3, 200, 1000, 2, 6, 5, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['geocaching','macera','arkadaşlık','dış mekan','keşif','harita','anı'], false, true);

-- 2. custom-board-game-friends
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'custom-board-game-friends',
'Özel Tasarım Kutu Oyunu Gecesi', 'Custom Board Game Night',
'Arkadaş grubunuza özel bir kutu oyunu tasarlayın. Oyun kartlarına ortak anılarınızı, iç esprileri ve grup dinamiklerinizi yansıtan sorular ve görevler yazın. Oyun tahtasını el yapımı veya dijital olarak tasarlayıp bastırabilirsiniz. Her kart bir kahkaha garantisi olsun: "İlk kampımızda kim çadırı yanlış kurdu?" gibi anı soruları, "30 saniyede grubun en iyi dansını taklit et" gibi eğlenceli görevler ekleyin. Kutunun kapağına grubun en sevdiği fotoğrafı yerleştirin. Oyun gecesi için atıştırmalıklar hazırlayın ve kazanana mini bir kupa verin.',
'Design a custom board game for your friend group. Write questions and challenges on game cards reflecting your shared memories, inside jokes, and group dynamics. Create the game board by hand or digitally design and print it. Each card should guarantee a laugh: add memory questions like "Who set up the tent wrong on our first camping trip?" and fun challenges like "Imitate the group''s best dance in 30 seconds." Place your group''s favorite photo on the box cover. Prepare snacks for game night and give the winner a mini trophy.',
'Arkadaş grubunuza özel tasarlanmış kutu oyunuyla eğlenceli bir gece geçirin.',
'Enjoy a fun night with a board game custom-designed for your friend group.',
4, 300, 1500, 3, 10, 10, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kutu oyunu','yaratıcı','el yapımı','eğlence','grup','tasarım'], true, false);

-- 3. rooftop-friendsgiving
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'rooftop-friendsgiving',
'Çatı Katında Arkadaşlık Şükran Yemeği', 'Rooftop Friendsgiving',
'Bir çatı katı veya teras mekanını arkadaşlık şükran yemeği için hazırlayın. Uzun bir masa kurun, her arkadaşınızın yerine kişiselleştirilmiş isim kartları ve küçük hediyeler koyun. Mevsime uygun dekorasyonlarla mekanı süsleyin: sonbaharda balkabakları ve yapraklar, yazın çiçekler ve mumlar. Her arkadaşınızdan bir yemek getirmesini isteyin, ana yemeği siz hazırlayın. Yemekten önce herkes sırayla arkadaşlık grubunda minnettar olduğu bir şeyi paylaşsın. Gün batımıyla birlikte kadeh kaldırın ve arkadaşlığınızın değerini kutlayın. Geceyi dışarıda battaniyeler altında sıcak içeceklerle bitirin.',
'Transform a rooftop or terrace into a friendsgiving celebration space. Set up a long table with personalized name cards and small gifts at each friend''s seat. Decorate with seasonal items: pumpkins and leaves in autumn, flowers and candles in summer. Ask each friend to bring a dish while you prepare the main course. Before eating, everyone takes turns sharing something they''re grateful for about the friend group. Toast at sunset and celebrate the value of your friendship. End the night outdoors under blankets with warm drinks.',
'Çatı katında manzaralı ve duygusal bir arkadaşlık şükran yemeği düzenleyin.',
'Host an emotional friendsgiving dinner with views on a rooftop terrace.',
3, 1500, 5000, 4, 12, 7, 'outdoor', ARRAY['fall','summer'], ARRAY['yemek','teras','şükran','kutlama','arkadaşlık','dekorasyon','manzara'], true, false);

-- 4. playlist-exchange-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'playlist-exchange-surprise',
'Sürpriz Playlist Değişimi', 'Surprise Playlist Exchange',
'Arkadaşınız için duygusal bir playlist hazırlayın ve sürpriz olarak hediye edin. Her şarkının yanına neden o şarkıyı seçtiğinizi anlatan kısa notlar yazın: "Bu şarkı ilk yol yolculuğumuzu hatırlatıyor" veya "Sen üzgünken hep bunu dinlerdik." Playlist''i Spotify veya Apple Music''te oluşturun ve QR kodunu güzel bir kartın içine yerleştirin. Kartın kapağına arkadaşlığınızı simgeleyen bir çizim veya fotoğraf ekleyin. Playlist''in sonuna kendi sesinizle kaydettiğiniz kısa bir mesaj ekleyebilirsiniz. Bu hediye hem ucuz hem de inanılmaz kişisel ve anlamlıdır.',
'Create an emotional playlist for your friend and gift it as a surprise. Write short notes next to each song explaining why you chose it: "This song reminds me of our first road trip" or "We always listened to this when you were sad." Create the playlist on Spotify or Apple Music and place the QR code inside a beautiful card. Add a drawing or photo symbolizing your friendship on the card cover. You can add a short voice message recorded in your own voice at the end of the playlist. This gift is both affordable and incredibly personal and meaningful.',
'Kişisel notlarla zenginleştirilmiş duygusal bir müzik listesi hediye edin.',
'Gift an emotional playlist enriched with personal notes for each song.',
1, 50, 300, 2, 2, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['müzik','playlist','kişisel','ucuz','duygusal','yaratıcı'], false, false);

-- 5. friendship-bracelet-party
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'friendship-bracelet-party',
'Arkadaşlık Bilekliği Yapım Partisi', 'Friendship Bracelet Making Party',
'Arkadaşlarınızı bir araya toplayıp birbirinize özel arkadaşlık bileklikleri yapın. Önceden renkli ipler, boncuklar, harf boncukları ve bileklik yapım malzemeleri temin edin. Her arkadaşınızın adının baş harfini veya grubunuza özel bir kelimeyi bilekliklere işleyin. Arka planda nostaljik müzikler çalsın, masada atıştırmalıklar ve içecekler bulunsun. Bileklikleri yaparken eski anıları konuşun, birbirinize ne kadar değerli olduğunuzu hatırlatın. Bitirdiğinizde bileklikleri birbirinize takın ve grup fotoğrafı çekin. Bu basit aktivite, derinlemesine sohbetler ve kahkahalar için mükemmel bir ortam yaratır.',
'Gather your friends to make friendship bracelets for each other. Stock up on colorful threads, beads, letter beads, and bracelet-making supplies beforehand. Weave the initials of each friend or a word special to your group into the bracelets. Play nostalgic music in the background with snacks and drinks on the table. While making bracelets, talk about old memories and remind each other how valuable you are. When finished, put bracelets on each other and take a group photo. This simple activity creates the perfect environment for deep conversations and laughter.',
'Arkadaşlarınızla el yapımı bileklikler oluşturup anılar biriktirin.',
'Create handmade bracelets with friends while making precious memories.',
1, 100, 500, 3, 8, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['bileklik','el yapımı','yaratıcı','parti','grup','nostalji'], false, false);

-- 6. memory-road-trip
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'memory-road-trip',
'Anı Rotası Yol Gezisi', 'Memory Lane Road Trip',
'Arkadaşınızla birlikte geçirdiğiniz en güzel anıların yaşandığı yerlere bir yol gezisi planlayın. İlk tanıştığınız okul, tatile gittiğiniz kasaba, en çok eğlendiğiniz festival alanı gibi duraklar belirleyin. Her durakta o anıyla ilgili bir fotoğraf çekin ve eski fotoğrafla karşılaştırın. Yolculuk boyunca hazırladığınız özel playlist''i dinleyin. Arabanın torpido gözüne her durak için küçük sürprizler koyun: favori şekerlemesi, eski bir bilet, anlamlı bir not. Son durağı en özel mekan yapın ve orada arkadaşınıza hazırladığınız anı defterini hediye edin. Dönüş yolunda yeni anılarla dolu bir kalple sürün.',
'Plan a road trip to places where you shared the best memories with your friend. Set stops like the school where you first met, the town you vacationed in, and the festival ground where you had the most fun. Take a photo at each stop and compare it with the old one. Listen to a special playlist you prepared throughout the journey. Put small surprises in the glove box for each stop: their favorite candy, an old ticket, a meaningful note. Make the final stop the most special place and gift them the memory journal you prepared. Drive back with a heart full of new memories.',
'Arkadaşlığınızın en özel mekanlarını ziyaret eden duygusal bir yol gezisi.',
'An emotional road trip visiting the most special places of your friendship.',
3, 1000, 5000, 2, 4, 7, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['yol gezisi','anı','macera','araba','nostalji','keşif','fotoğraf'], false, false);

-- 7. appreciation-day-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'appreciation-day-surprise',
'Arkadaşlık Takdir Günü Sürprizi', 'Friendship Appreciation Day Surprise',
'Arkadaşınız için sıradan bir günü özel bir takdir gününe dönüştürün. Sabah kapısına favori kahvesi ve bir teşekkür notuyla başlayın. Gün içinde farklı saatlerde küçük sürprizler gönderin: öğle yemeğine favori restoranından sipariş, öğleden sonra ofisine çiçek, akşam eve geldiğinde kapıda sıcak bir karşılama. Her sürprizle birlikte arkadaşlığınızda onu takdir ettiğiniz bir özelliği anlatan kart bırakın. Günü özel bir akşam yemeğiyle bitirin ve ona arkadaşlığınızın hayatınıza kattığı değeri anlatan bir mektup okuyun.',
'Transform an ordinary day into a special appreciation day for your friend. Start with their favorite coffee and a thank-you note at their door in the morning. Send small surprises at different times throughout the day: order lunch from their favorite restaurant, send flowers to their office in the afternoon, and greet them warmly at their door when they come home. Leave a card with each surprise describing a quality you appreciate about them. End the day with a special dinner and read them a letter about the value their friendship adds to your life.',
'Sıradan bir günü arkadaşınız için unutulmaz bir takdir gününe çevirin.',
'Turn an ordinary day into an unforgettable appreciation day for your friend.',
2, 500, 2000, 2, 5, 3, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['takdir','sürpriz','hediye','duygusal','günlük','arkadaşlık'], false, false);

-- 8. friendship-pinata-party
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'friendship-pinata-party',
'Arkadaşlık Pinyata Partisi', 'Friendship Piñata Party',
'Arkadaşınız için özel bir pinyata partisi düzenleyin. Pinyatanın içine şekerler ve küçük hediyelerin yanı sıra, arkadaşlığınızla ilgili anıları anlatan küçük kağıtlar koyun. Her kağıtta "Seninle en çok güldüğüm an..." veya "Seni en çok sevdiğim özelliğin..." gibi tamamlanmış cümleler olsun. Pinyatayı arkadaşınızın en sevdiği renklerde ve tema da süsleyin. Parti alanını balonlar ve süslerle donatın. Müzik açın, dans edin ve sırayla pinyatayı vurun. Pinyata kırıldığında yere düşen notları birlikte okuyun. Bu eğlenceli aktivite hem gülme hem ağlama garantisi verir.',
'Organize a special piñata party for your friend. Fill the piñata with candies and small gifts alongside little papers telling memories about your friendship. Each paper should have completed sentences like "The moment I laughed the most with you..." or "My favorite thing about you..." Decorate the piñata in your friend''s favorite colors and theme. Fill the party area with balloons and decorations. Play music, dance, and take turns hitting the piñata. When it breaks, read the notes that fall to the ground together. This fun activity guarantees both laughter and happy tears.',
'Anı notlarıyla dolu özel bir pinyatayla eğlenceli ve duygusal bir parti.',
'A fun and emotional party with a special piñata filled with memory notes.',
2, 300, 1000, 3, 10, 4, 'both', ARRAY['spring','summer'], ARRAY['pinyata','parti','eğlence','anı','dekorasyon','hediye'], false, false);

-- 9. photo-album-gift-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'photo-album-gift-surprise',
'Sürpriz Fotoğraf Albümü Hediyesi', 'Surprise Photo Album Gift',
'Arkadaşınızla birlikte çektiğiniz tüm fotoğrafları toplayarak kronolojik bir albüm hazırlayın. İlk fotoğraftan en son çekilene kadar arkadaşlığınızın yolculuğunu görsel olarak anlatın. Her sayfaya fotoğrafın çekildiği tarih, yer ve o anki duygularınızı anlatan kısa notlar ekleyin. Albümün son sayfasına gelecekte birlikte yapmak istediğiniz şeylerin listesini yazın. Kapağını kişiselleştirilmiş bir tasarımla bastırın veya el yapımı süsleyin. Albümü özel bir kutuya koyun ve arkadaşınızla buluştuğunuz bir günde sürpriz olarak verin. Birlikte sayfaları çevirirken eski anıları konuşun.',
'Collect all photos you''ve taken with your friend and create a chronological album. Visually tell the journey of your friendship from the first photo to the most recent one. Add short notes on each page with the date, location, and your feelings at that moment. On the last page, write a list of things you want to do together in the future. Print the cover with a personalized design or decorate it by hand. Place the album in a special box and surprise your friend on a day you meet. Turn the pages together and talk about old memories.',
'Arkadaşlığınızın kronolojik hikayesini anlatan kişisel bir fotoğraf albümü.',
'A personal photo album telling the chronological story of your friendship.',
2, 200, 1000, 2, 2, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['fotoğraf','albüm','anı','kişisel','hediye','yaratıcı'], false, false);

-- 10. friendship-time-capsule
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'friendship-time-capsule',
'Arkadaşlık Zaman Kapsülü', 'Friendship Time Capsule',
'Arkadaşlarınızla birlikte bir zaman kapsülü hazırlayın ve gömün. Her arkadaş kapsüle koyacak anlamlı bir nesne seçsin: bir fotoğraf, bir mektup, o dönemin popüler bir nesnesi, gelecekteki kendinize yazılmış bir not. Kapsülü su geçirmez bir kutuya yerleştirin ve üzerine açılış tarihini yazın: 5 veya 10 yıl sonra. Birlikte anlamlı bir yere gömün veya güvenli bir yerde saklayın. Gömme töreninde herkes sırayla arkadaşlıktan beklentilerini ve umutlarını paylaşsın. Bir sözleşme imzalayın: belirtilen tarihte hep birlikte açacağınıza dair. Bu ritüel arkadaşlığınıza zamansız bir bağ ekler.',
'Prepare and bury a time capsule with your friends. Each friend should choose a meaningful object to put in the capsule: a photo, a letter, a popular item of the era, a note written to your future selves. Place the capsule in a waterproof box and write the opening date on it: 5 or 10 years from now. Bury it together at a meaningful place or store it safely. During the burial ceremony, everyone takes turns sharing their expectations and hopes for the friendship. Sign a contract: promising to open it together on the specified date. This ritual adds a timeless bond to your friendship.',
'Arkadaşlarınızla anlamlı nesneler dolu bir zaman kapsülü gömün.',
'Bury a time capsule filled with meaningful objects with your friends.',
2, 150, 800, 3, 8, 5, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['zaman kapsülü','anı','gelecek','ritüel','arkadaşlık','nostalji'], false, true);

-- 11. movie-marathon-night
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'movie-marathon-night',
'Film Maratonu Gecesi', 'Movie Marathon Night',
'Arkadaşınız için tematik bir film maratonu gecesi düzenleyin. Onun en sevdiği film serisini veya türünü seçin ve 3-5 film sıralayın. Salonu sinema salonuna çevirin: projektör veya büyük ekran kurun, karanlık perdeler asın, patlamış mısır standı hazırlayın. Her film arasına özel mola aktiviteleri ekleyin: film temalı trivia soruları, karakter tahmini oyunları. Koltukları battaniye ve yastıklarla donatın, yanlarına atıştırmalık kutuları koyun. Gece boyunca favorik içeceklerini hazır bulundurun. Maratonun sonunda en iyi sahneyi oylayın ve birlikte çektiğiniz fotoğraflardan dijital anı defteri oluşturun.',
'Organize a themed movie marathon night for your friend. Choose their favorite film series or genre and line up 3-5 movies. Transform the living room into a cinema: set up a projector or large screen, hang dark curtains, prepare a popcorn station. Add special break activities between each film: movie-themed trivia questions, character guessing games. Fill the seating area with blankets and pillows, place snack boxes beside them. Keep their favorite drinks ready throughout the night. At the end of the marathon, vote on the best scene and create a digital memory journal from photos taken together.',
'Tematik dekorasyonlu ev sinema deneyimiyle arkadaşınızı şaşırtın.',
'Surprise your friend with a home cinema experience with themed decorations.',
1, 200, 800, 2, 6, 2, 'indoor', ARRAY['fall','winter'], ARRAY['film','sinema','gece','eğlence','ev','atıştırmalık','maraton'], false, false);

-- 12. friendship-jar-messages
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'friendship-jar-messages',
'Arkadaşlık Kavanozu Mesajları', 'Friendship Jar Messages',
'Güzel bir cam kavanoz alın ve içine arkadaşınız için yazdığınız 365 küçük mesaj koyun - her gün bir tane açması için. Mesajları renkli kağıtlara yazın ve kategorilere ayırın: "Seni seviyorum çünkü..." (pembe), "En güzel anımız..." (mavi), "Bugün yap..." (yeşil motivasyon notları), "Komik bir hatıra..." (sarı). Her kağıdı rulayıp şeritlerle bağlayın. Kavanozu süsleyin, üzerine "Arkadaşlık Kavanozu - Her gün bir tane aç" yazın. Yanına nasıl kullanacağını anlatan küçük bir kart ekleyin. Bu hediye bir yıl boyunca her gün arkadaşınıza gülümseme verecek, yalnız hissettiği günlerde moral olacak.',
'Get a beautiful glass jar and fill it with 365 small messages for your friend - one to open each day. Write messages on colorful papers and categorize them: "I love you because..." (pink), "Our best memory..." (blue), "Do this today..." (green motivation notes), "A funny memory..." (yellow). Roll each paper and tie with ribbons. Decorate the jar and write "Friendship Jar - Open one each day" on it. Add a small card explaining how to use it. This gift will bring a smile to your friend every day for a year and boost morale on lonely days.',
'365 günlük kişisel mesajlarla dolu bir arkadaşlık kavanozu hediye edin.',
'Gift a friendship jar filled with 365 days of personal messages.',
2, 100, 400, 2, 2, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kavanoz','mesaj','kişisel','duygusal','yıllık','el yapımı'], false, false);

-- 13. surprise-reunion-party
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'surprise-reunion-party',
'Sürpriz Arkadaş Buluşması Partisi', 'Surprise Friend Reunion Party',
'Uzun süredir görüşemediğiniz arkadaş grubunuzu gizlice bir araya getirin. Herkesle ayrı ayrı iletişime geçin ve ortak bir tarih belirleyin. Ana sürpriz kişi hiçbir şeyden habersiz olsun - onu sıradan bir yemeğe davet edin. Mekanı eski fotoğraflarla, "Seni özledik" pankartlarıyla süsleyin. Herkes saklanıp kişi geldiğinde "Sürpriz!" diye bağırsın. Geceye eski fotoğrafların slayt gösterisiyle başlayın, herkes sırayla en komik ortak anısını anlatsın. Arka planda liseden veya üniversiteden kalma şarkılar çalsın. Bu buluşma, uzak kalmış dostlukları yeniden alevlendirecek.',
'Secretly bring together your friend group that hasn''t met in a long time. Contact everyone individually and set a common date. The main surprise person should know nothing - invite them for a casual dinner. Decorate the venue with old photos and "We missed you" banners. Everyone hides and shouts "Surprise!" when the person arrives. Start the night with a slideshow of old photos, everyone takes turns telling their funniest shared memory. Play songs from high school or college in the background. This reunion will reignite distant friendships.',
'Uzun süredir görüşmediğiniz arkadaşları gizlice bir araya getirin.',
'Secretly bring together friends who haven''t seen each other in a long time.',
3, 1000, 4000, 5, 20, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['buluşma','sürpriz','parti','nostalji','grup','eski arkadaş','kutlama'], false, false);

-- 14. friends-cooking-night
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'friends-cooking-night',
'Arkadaşlarla Yemek Pişirme Gecesi', 'Friends Cooking Night',
'Arkadaşlarınızla birlikte yeni bir mutfak keşfedin. İtalyan, Japon, Meksika veya Türk mutfağından bir tema seçin ve tüm malzemeleri önceden hazırlayın. Her arkadaşa bir görev verin: biri sos yapacak, biri hamur açacak, biri salata hazırlayacak. Mutfağa temalı müzik açın, herkes önlük taksın. Yemek yapma sürecini videoya çekin - montajlanmış hali harika bir anı olacak. Yemeği hep birlikte güzelce kurulmuş bir masada yiyin. Tatlıyı birlikte hazırlayın ve en iyi şefe "Gecenin Şefi" ödülü verin. Bu aktivite hem yeni bir beceri kazandırır hem de birlikte vakit geçirmenin keyfini ikiye katlar.',
'Explore a new cuisine together with your friends. Choose a theme from Italian, Japanese, Mexican, or Turkish cuisine and prepare all ingredients beforehand. Assign each friend a task: one makes sauce, one rolls dough, one prepares salad. Play themed music in the kitchen, everyone wears an apron. Record the cooking process on video - the edited version will make a great memory. Eat the meal together at a beautifully set table. Prepare dessert together and give a "Chef of the Night" award to the best chef. This activity both teaches a new skill and doubles the joy of spending time together.',
'Arkadaşlarınızla tematik bir yemek pişirme deneyimi yaşayın.',
'Experience a themed cooking session with your friends.',
2, 300, 1500, 3, 6, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['yemek','pişirme','mutfak','grup','eğlence','deneyim'], false, false);

-- 15. friendship-mural-painting
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'friendship-mural-painting',
'Arkadaşlık Duvar Resmi Boyama', 'Friendship Mural Painting',
'Arkadaş grubunuzla birlikte büyük bir tuval veya duvar üzerine ortak bir sanat eseri oluşturun. Büyük bir tuval (en az 1x2 metre), akrilik boyalar, fırçalar ve koruyucu örtüler temin edin. Önceden bir tema belirleyin: arkadaşlığınızı simgeleyen semboller, ortak anılarınızdan sahneler veya soyut bir tasarım. Her arkadaş tualin bir bölümünü boyasın, sonunda parçalar bir bütün oluştursun. Boyama sırasında müzik açın, atıştırmalıklar hazırlayın. Bittiğinde eseri imzalayın ve tarih atın. Bu tablo birinizin evinin duvarını süsleyecek kalıcı bir arkadaşlık sembolü olacak.',
'Create a collaborative artwork on a large canvas or wall with your friend group. Get a large canvas (at least 1x2 meters), acrylic paints, brushes, and protective sheets. Decide on a theme beforehand: symbols representing your friendship, scenes from shared memories, or an abstract design. Each friend paints a section of the canvas, with pieces forming a whole at the end. Play music and prepare snacks during painting. When finished, sign the artwork and add the date. This painting will become a permanent friendship symbol decorating one of your homes.',
'Arkadaşlarınızla birlikte büyük bir sanat eseri oluşturun.',
'Create a large collaborative artwork together with your friends.',
3, 400, 1500, 3, 8, 5, 'both', ARRAY['spring','summer','fall'], ARRAY['sanat','boyama','tuval','yaratıcı','grup','el yapımı','dekorasyon'], false, false);

-- 16. surprise-concert-trip
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'surprise-concert-trip',
'Sürpriz Konser Gezisi', 'Surprise Concert Trip',
'Arkadaşınızın en sevdiği sanatçının konserine gizlice bilet alın ve onu sürpriz bir yolculuğa çıkarın. Konserin olduğu şehre bir gün önceden gidin veya aynı gün erkenden yola çıkın. Yolculuk boyunca o sanatçının şarkılarını çalın ama nereye gittiğinizi söylemeyin. Konser mekanına yaklaştığında ipuçları verin ve tepkisini kaydedin. Konserde birlikte söyleyin, dans edin ve fotoğraflar çekin. Konser sonrası şehri keşfedin, gece yürüyüşü yapın veya yerel bir restoranda yemek yiyin. Eve dönerken konser biletini ve çektiğiniz fotoğrafları içeren küçük bir anı kutusu hazırlayın.',
'Secretly buy tickets to your friend''s favorite artist''s concert and take them on a surprise trip. Go to the concert city a day early or leave early the same day. Play that artist''s songs throughout the journey but don''t reveal where you''re going. Give clues as you approach the venue and record their reaction. Sing together at the concert, dance, and take photos. After the concert, explore the city, take a night walk, or eat at a local restaurant. On the way home, prepare a small memory box containing the concert ticket and photos you took.',
'En sevdiği sanatçının konserine gizlice götürün.',
'Secretly take your friend to their favorite artist''s concert.',
3, 2000, 8000, 2, 4, 14, 'both', ARRAY['spring','summer','fall'], ARRAY['konser','müzik','yolculuk','sürpriz','eğlence','sanatçı'], true, false);

-- 17. spa-day-friends
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'spa-day-friends',
'Arkadaşlarla Spa Günü', 'Spa Day with Friends',
'Arkadaşlarınız için rahatlatıcı bir spa günü organize edin. Profesyonel bir spa''ya randevu alabilir veya evde kendi spa deneyiminizi yaratabilirsiniz. Ev versiyonu için yüz maskeleri, el bakım setleri, aromatik mumlar, rahatlatıcı müzik ve sıcak havlular hazırlayın. Salata ve detoks içecekleri gibi sağlıklı atıştırmalıklar sunun. Birbirinize manikür-pedikür yapın, yüz maskesi uygulayın ve saç bakımı deneyin. Yoga veya meditasyon seansıyla başlayın, rahatladıktan sonra sohbet edin. Her arkadaşınıza kişiselleştirilmiş bakım seti hediye edin. Bu gün, günlük stresin arkadaşlarla birlikte atıldığı huzurlu bir deneyim olacak.',
'Organize a relaxing spa day for your friends. You can book appointments at a professional spa or create your own spa experience at home. For the home version, prepare face masks, hand care sets, aromatic candles, relaxing music, and hot towels. Serve healthy snacks like salads and detox drinks. Give each other manicures and pedicures, apply face masks, and try hair treatments. Start with a yoga or meditation session, then chat after relaxing. Gift each friend a personalized care set. This day will be a peaceful experience where daily stress melts away with friends.',
'Arkadaşlarınızla rahatlatıcı bir ev spa deneyimi yaşayın.',
'Enjoy a relaxing home spa experience with your friends.',
1, 300, 2000, 2, 6, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['spa','bakım','rahatlama','sağlık','ev','arkadaşlık','huzur'], false, false);

-- 18. friendship-photo-book
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'friendship-photo-book',
'Profesyonel Arkadaşlık Fotoğraf Kitabı', 'Professional Friendship Photo Book',
'Arkadaşlığınızı anlatan profesyonel bir fotoğraf kitabı tasarlayıp bastırın. Online fotoğraf kitabı platformlarını kullanarak şık bir tasarım oluşturun. Kitabı bölümlere ayırın: "Tanışma", "İlk Maceralar", "Zor Günler", "Kahkahalar", "Gelecek Planları". Her bölüme uygun fotoğrafları yerleştirin ve altlarına anekdotlar yazın. Kapağını dergi gibi profesyonel tasarlayın, arkadaşınızın fotoğrafıyla. İçine gizli zarflar yapıştırın, her zarfta küçük bir hediye kartı veya bilet olsun. Kitabı lüks bir kutuya koyun ve kişisel bir mektupla birlikte hediye edin.',
'Design and print a professional photo book telling the story of your friendship. Create an elegant design using online photo book platforms. Divide the book into chapters: "Meeting", "First Adventures", "Tough Days", "Laughter", "Future Plans". Place appropriate photos in each chapter with anecdotes underneath. Design the cover professionally like a magazine, featuring your friend''s photo. Paste hidden envelopes inside, each containing a small gift card or ticket. Place the book in a luxury box and gift it with a personal letter.',
'Profesyonelce tasarlanmış bir fotoğraf kitabıyla arkadaşlığınızı ölümsüzleştirin.',
'Immortalize your friendship with a professionally designed photo book.',
3, 500, 2500, 2, 2, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['fotoğraf','kitap','profesyonel','hediye','tasarım','anı','lüks'], true, false);

-- 19. surprise-camping-trip
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'surprise-camping-trip',
'Sürpriz Kamp Gezisi', 'Surprise Camping Trip',
'Arkadaşınızı sıradan bir hafta sonu planıyla kandırıp sürpriz bir kamp gezisine çıkarın. Tüm kamp ekipmanlarını önceden hazırlayın: çadır, uyku tulumu, kamp sandalyeleri, mangal malzemeleri. Arabanın bagajını gizlice yükleyin. Yolculuğa çıktığınızda nereye gittiğinizi söylemeyin, doğanın içine girdiğinizde sürprizi açıklayın. Kampta ateş yakın, marshmallow kızartın, yıldızları izleyin. Gece gökyüzü altında arkadaşlık anılarını paylaşın. Sabah kahvaltısını birlikte doğada hazırlayın. Doğa yürüyüşü yapın, göl veya dere kenarında vakit geçirin. Şehrin gürültüsünden uzakta arkadaşlığınızın derinleştiği bir hafta sonu olacak.',
'Trick your friend with a casual weekend plan and take them on a surprise camping trip. Prepare all camping equipment beforehand: tent, sleeping bag, camping chairs, barbecue supplies. Secretly load the car trunk. Don''t reveal the destination when you start driving, and announce the surprise when you enter nature. At camp, light a fire, roast marshmallows, and watch the stars. Share friendship memories under the night sky. Prepare breakfast together in nature the next morning. Go on a nature hike, spend time by a lake or stream. It will be a weekend away from city noise where your friendship deepens.',
'Arkadaşınızı gizlice sürpriz bir doğa kampına götürün.',
'Secretly take your friend on a surprise nature camping trip.',
3, 500, 3000, 2, 6, 7, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['kamp','doğa','macera','sürpriz','yıldız','ateş','hafta sonu'], false, false);

-- 20. friend-video-montage
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'friend-video-montage',
'Arkadaşlık Video Montajı', 'Friendship Video Montage',
'Arkadaşınız için duygusal bir video montajı hazırlayın. Ortak arkadaşlarınızdan gizlice video mesajları toplayın - herkes arkadaşınız hakkında en sevdiği anıyı, onu neden sevdiğini ve bir dileğini paylaşsın. Birlikte çekilmiş fotoğrafları ve videoları kronolojik sıraya koyun. Arka plana duygusal bir müzik ekleyin. Videonun başına bir intro, sonuna da sizin kendi mesajınızı ekleyin. Videoyu profesyonel görünümlü bir şekilde montajlayın - ücretsiz uygulamalarla bile harika sonuçlar alabilirsiniz. Videoyu özel bir akşam yemeğinde veya buluşmada büyük ekranda gösterin ve tepkisini kaydedin.',
'Create an emotional video montage for your friend. Secretly collect video messages from mutual friends - everyone shares their favorite memory about your friend, why they love them, and a wish. Arrange photos and videos taken together in chronological order. Add emotional music in the background. Add an intro at the beginning and your own message at the end of the video. Edit the video to look professional - you can get amazing results even with free apps. Show the video on a big screen at a special dinner or gathering and record their reaction.',
'Ortak arkadaşların mesajlarıyla duygusal bir video montajı hazırlayın.',
'Create an emotional video montage with messages from mutual friends.',
2, 50, 500, 2, 10, 10, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['video','montaj','mesaj','duygusal','dijital','anı'], false, false);

-- 21. friendship-tattoo-day
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'friendship-tattoo-day',
'Arkadaşlık Dövme Günü', 'Friendship Tattoo Day',
'En yakın arkadaşınızla eşleşen veya tamamlayıcı dövmeler yaptırın. Birlikte bir dövme tasarımı seçin: yarım kalp, puzzle parçaları, koordinatlar, bir tarih, küçük semboller veya anlamlı bir kelime. Güvenilir bir dövme stüdyosu araştırın, sanatçıyla önceden tasarımı konuşun. Dövme günü birlikte gidin, birbirinize moral verin ve süreci kaydedin. Kalıcı dövme istemiyorsanız geçici dövme veya kına alternatifini değerlendirin. Dövme sonrası kutlama yemeğine çıkın ve yeni dövmelerinizle selfie çekin. Bu deneyim arkadaşlığınızı kalıcı bir şekilde vücudunuza ve kalbinize işleyecek.',
'Get matching or complementary tattoos with your best friend. Choose a tattoo design together: half hearts, puzzle pieces, coordinates, a date, small symbols, or a meaningful word. Research a trusted tattoo studio and discuss the design with the artist beforehand. Go together on tattoo day, support each other, and record the process. If you don''t want permanent tattoos, consider temporary tattoo or henna alternatives. Go out for a celebration dinner after and take selfies with your new tattoos. This experience will permanently engrave your friendship on your body and heart.',
'En yakın arkadaşınızla eşleşen dövmeler yaptırarak bağınızı kalıcılaştırın.',
'Make your bond permanent by getting matching tattoos with your best friend.',
4, 1000, 5000, 2, 2, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['dövme','kalıcı','sanat','cesaret','arkadaşlık','eşleşen'], true, false);

-- 22. karaoke-night-friends
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'karaoke-night-friends',
'Arkadaşlarla Karaoke Gecesi', 'Karaoke Night with Friends',
'Arkadaşlarınız için unutulmaz bir karaoke gecesi düzenleyin. Bir karaoke mekanı kiralayabilir veya evde karaoke sistemi kurabilirsiniz. Ev versiyonu için mikrofon, hoparlör ve karaoke uygulaması yeterli. Şarkı listesini önceden hazırlayın: herkesin en sevdiği şarkılar, grup olarak söylediğiniz şarkılar ve komik düetler. Sahneyi ışıklandırma ve disko topu ile süsleyin. Kostüm kutusu hazırlayın, herkes rock yıldızı gibi giyinsin. En iyi performansa "Grammy" ödülü verin. Gecenin en komik anlarını kaydedin. Tematik içecekler hazırlayın ve şarkı aralarında dans edin. Bu gece herkesin içindeki sanatçıyı ortaya çıkaracak.',
'Organize an unforgettable karaoke night for your friends. You can rent a karaoke venue or set up a karaoke system at home. For the home version, a microphone, speaker, and karaoke app are enough. Prepare the song list beforehand: everyone''s favorite songs, songs you sing as a group, and funny duets. Decorate the stage with lighting and a disco ball. Prepare a costume box so everyone dresses like a rock star. Give a "Grammy" award for the best performance. Record the funniest moments of the night. Prepare themed drinks and dance between songs. This night will bring out the artist in everyone.',
'Kostümler ve ödüllerle dolu eğlenceli bir karaoke gecesi düzenleyin.',
'Host a fun karaoke night complete with costumes and awards.',
1, 200, 1500, 3, 10, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['karaoke','müzik','eğlence','parti','şarkı','gece','dans'], false, false);

-- 23. escape-room-friends
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'escape-room-friends',
'Arkadaşlarla Kaçış Odası Macerası', 'Escape Room Adventure with Friends',
'Arkadaş grubunuz için heyecanlı bir kaçış odası deneyimi organize edin. Şehrinizde en iyi puanlı kaçış odalarını araştırın ve grubunuzun ilgi alanına uygun bir tema seçin: korku, dedektiflik, macera veya tarih. Kaçış odasına gitmeden önce takım ruhunu artırmak için bir kafe buluşması yapın. Kaçış odasından sonra deneyimi değerlendireceğiniz bir akşam yemeği planlayın. Kim en çok ipucu çözdü, kim en komik tepkiyi verdi gibi ödüller dağıtın. Deneyimi videoya çekin veya fotoğraf çektirin. Ekstra sürpriz olarak en iyi takım oyuncusuna küçük bir hediye hazırlayın.',
'Organize an exciting escape room experience for your friend group. Research the highest-rated escape rooms in your city and choose a theme matching your group''s interests: horror, detective, adventure, or history. Before the escape room, have a cafe meetup to boost team spirit. Plan a dinner after to discuss the experience. Hand out awards for who solved the most clues and who had the funniest reaction. Record the experience on video or take photos. As an extra surprise, prepare a small gift for the best team player.',
'Arkadaş grubunuzla heyecanlı bir kaçış odası deneyimi yaşayın.',
'Experience an exciting escape room adventure with your friend group.',
1, 500, 2000, 3, 6, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kaçış odası','macera','takım','bulmaca','heyecan','deneyim'], false, false);

-- 24. beach-day-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'beach-day-surprise',
'Sürpriz Plaj Günü', 'Surprise Beach Day',
'Arkadaşınız için mükemmel bir plaj günü sürprizi planlayın. Güzel bir plaj seçin ve tüm hazırlıkları önceden yapın: şemsiye, şezlong, plaj havluları, güneş kremi, soğutucu çanta dolusu içecek ve meyve. Plajda arkadaşınız için küçük bir alan oluşturun: renkli şemsiyeler, rahat mindeler ve hoş bir piknik sepeti. Plaj oyunları hazırlayın: frisbee, plaj voleybolu, kumdan kale yarışması. Gün batımında kumda ateş yakın ve marshmallow kızartın. Geceyi yıldızları izleyerek bitirin. Tüm gün boyunca fotoğraflar çekin ve günün sonunda dijital bir kolaj oluşturun.',
'Plan the perfect beach day surprise for your friend. Choose a beautiful beach and do all preparations beforehand: umbrella, lounger, beach towels, sunscreen, a cooler full of drinks and fruit. Create a small area for your friend on the beach: colorful umbrellas, comfortable cushions, and a lovely picnic basket. Prepare beach games: frisbee, beach volleyball, sandcastle competition. Light a fire in the sand at sunset and roast marshmallows. End the night watching the stars. Take photos throughout the day and create a digital collage at the end.',
'Arkadaşınız için hazırlıklı ve eğlenceli bir plaj günü sürprizi yapın.',
'Throw a prepared and fun beach day surprise for your friend.',
2, 300, 1500, 2, 8, 3, 'outdoor', ARRAY['summer'], ARRAY['plaj','deniz','yaz','piknik','eğlence','doğa','güneş'], false, false);

-- 25. friendship-potluck-dinner
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'friendship-potluck-dinner',
'Arkadaşlık Potluck Akşam Yemeği', 'Friendship Potluck Dinner',
'Herkesin bir yemek getirdiği özel bir potluck akşam yemeği düzenleyin. Her arkadaşınıza gizlice bir yemek türü atayın: ana yemek, başlangıç, salata, tatlı, içecek. Masayı zarif bir şekilde kurun: kumaş peçeteler, mumlar, çiçekler. Her yemeğin yanına yemeği yapanın adı ve tarifin hikayesi yazılmış küçük kartlar koyun. Yemekten önce herkes sırayla yemeğinin arkasındaki anlamı anlatsın: "Bu annemin tarifi" veya "Bunu birlikte tatil yaptığımızda öğrendim." Gecenin sonunda en beğenilen yemeğe oy verin ve şefe bir sertifika hazırlayın. Bu gelenek her ay tekrarlanabilir.',
'Organize a special potluck dinner where everyone brings a dish. Secretly assign each friend a food category: main dish, appetizer, salad, dessert, drink. Set the table elegantly: fabric napkins, candles, flowers. Place small cards next to each dish with the cook''s name and the recipe''s story. Before eating, everyone takes turns explaining the meaning behind their dish: "This is my mom''s recipe" or "I learned this on our vacation together." At the end of the night, vote for the most popular dish and prepare a certificate for the chef. This tradition can be repeated monthly.',
'Herkesin kendi yemeğini getirdiği zarif bir arkadaşlık yemeği.',
'An elegant friendship dinner where everyone brings their own dish.',
1, 100, 500, 4, 10, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['yemek','potluck','grup','ev','gelenek','paylaşım','akşam yemeği'], false, false);

-- 26. surprise-birthday-bash
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'surprise-birthday-bash',
'Sürpriz Doğum Günü Kutlaması', 'Surprise Birthday Bash',
'Arkadaşınızın doğum gününü unutulmaz bir sürpriz partiyle kutlayın. Tema belirleyin: retro, Hollywood, tropikal veya arkadaşınızın favori film/dizi teması. Mekanı temalı dekorasyonlarla donatın: balonlar, flamalar, fotoğraf köşesi. Özelleştirilmiş pasta sipariş edin - üzerine iç esprinizi veya anlamlı bir mesajı yazdırın. Misafirlere gizlice davetiye gönderin, herkes küçük birer hediye getirsin. Doğum günü kişisi kapıdan girdiğinde konfeti patlatın. Gecede slayt gösterisi, dans, hediye açılışı ve dilek tutma ritüeli olsun. Her misafir bir dilek kağıdına yazıp balonla uçursun.',
'Celebrate your friend''s birthday with an unforgettable surprise party. Set a theme: retro, Hollywood, tropical, or your friend''s favorite movie/show theme. Decorate the venue with themed decorations: balloons, streamers, photo booth. Order a customized cake with your inside joke or a meaningful message on it. Send invitations secretly to guests, everyone brings a small gift. Pop confetti when the birthday person walks through the door. Include a slideshow, dancing, gift opening, and wish-making ritual. Each guest writes a wish on paper and releases it with a balloon.',
'Tematik dekorasyon ve sürprizlerle unutulmaz bir doğum günü partisi.',
'An unforgettable birthday party with themed decorations and surprises.',
3, 1500, 5000, 5, 20, 7, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['doğum günü','parti','sürpriz','dekorasyon','pasta','kutlama','tema'], false, false);

-- 27. paint-and-sip-night
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'paint-and-sip-night',
'Boya ve İç Gecesi', 'Paint and Sip Night',
'Arkadaşlarınız için sanatsal ve rahatlatıcı bir boya gecesi düzenleyin. Tuval, akrilik boya, fırça ve paletleri her kişi için hazırlayın. YouTube''dan bir resim eğitimi seçin veya yerel bir sanatçıyı davet edin. Herkes aynı tabloyu yapmaya çalışsın ama herkesin yorumu farklı olacak - bu en eğlenceli kısım. Masaya şarap, peynir tabağı ve meyve dizin. Sakin müzik açın, rahat bir atmosfer yaratın. Gecenin sonunda tabloları yan yana koyup oy verin. En yaratıcı esere komik bir ödül verin. Herkes kendi tablosunu eve götürsün - her baktığında o geceyi hatırlasın.',
'Organize an artistic and relaxing paint night for your friends. Prepare canvas, acrylic paint, brushes, and palettes for each person. Choose a painting tutorial from YouTube or invite a local artist. Everyone tries to paint the same picture but each interpretation will be different - that''s the most fun part. Set wine, cheese platter, and fruit on the table. Play calm music and create a cozy atmosphere. At the end of the night, place all paintings side by side and vote. Give a funny award for the most creative piece. Everyone takes their painting home - a reminder of that night every time they look at it.',
'Şarap ve boyayla sanatsal bir arkadaş gecesi geçirin.',
'Enjoy an artistic friend night with wine and painting.',
1, 300, 1200, 3, 8, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['boya','sanat','şarap','yaratıcı','rahatlatıcı','gece','tuval'], false, false);

-- 28. friendship-quiz-night
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'friendship-quiz-night',
'Arkadaşlık Bilgi Yarışması Gecesi', 'Friendship Quiz Night',
'Arkadaş grubunuz hakkında eğlenceli bir bilgi yarışması hazırlayın. Kategoriler oluşturun: "Kim söyledi?", "Hangi yılda oldu?", "Kimin favori...?", "Doğru mu yanlış mı?" gibi. Her kategoriden 10 soru hazırlayın, toplamda 50-60 soru olsun. Soruları PowerPoint veya Kahoot üzerinden gösterin. Takımlar oluşturun veya bireysel yarışın. Her doğru cevaba puan verin, yanlışlara komik cezalar koyun. Yarışmanın sonunda birinci olana kupa, ikinciye madalya, sonuncuya "En az arkadaşını tanıyan" ödülü verin. Bu gece arkadaşlığınızı ne kadar iyi tanıdığınızı test edecek ve bolca güleceksiniz.',
'Prepare a fun quiz night about your friend group. Create categories: "Who said it?", "What year did it happen?", "Whose favorite...?", "True or false?" Prepare 10 questions per category, 50-60 questions total. Display questions via PowerPoint or Kahoot. Form teams or compete individually. Award points for correct answers, add funny penalties for wrong ones. At the end, give the winner a trophy, runner-up a medal, and last place a "Least likely to know their friends" award. This night will test how well you know your friendship and guarantee lots of laughter.',
'Arkadaşlık bilginizi test eden eğlenceli bir bilgi yarışması gecesi.',
'A fun quiz night testing how well you know your friends.',
2, 100, 500, 4, 12, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['bilgi yarışması','eğlence','quiz','grup','rekabet','gece','kahkaha'], false, false);

-- 29. adventure-day-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'adventure-day-surprise',
'Sürpriz Macera Günü', 'Surprise Adventure Day',
'Arkadaşınız için adrenalin dolu bir macera günü planlayın. Zipline, ATV safari, rafting, tırmanma duvarı veya yamaç paraşütü gibi aktivitelerden birini veya birkaçını seçin. Arkadaşınıza sadece "Rahat kıyafet giy ve hazır ol" deyin, detayları gizli tutun. Sabah erkenden yola çıkın, yolda enerji veren kahvaltı yapın. Aktivite sırasında GoPro veya telefonla anları kaydedin. Maceradan sonra rahatlamak için bir kafede oturun veya doğada piknik yapın. Günün sonunda video montajı yapın ve arkadaşınıza "Macera Sertifikası" hazırlayın. Bu gün rutinden kaçış ve arkadaşlığınızı güçlendirecek paylaşılmış bir deneyim olacak.',
'Plan an adrenaline-packed adventure day for your friend. Choose one or several activities like zipline, ATV safari, rafting, climbing wall, or paragliding. Just tell your friend "Wear comfortable clothes and be ready," keep the details secret. Leave early in the morning, have an energizing breakfast on the way. Record moments with a GoPro or phone during activities. After the adventure, sit at a cafe to relax or have a picnic in nature. At the end of the day, make a video montage and prepare an "Adventure Certificate" for your friend. This day will be an escape from routine and a shared experience strengthening your friendship.',
'Adrenalin dolu aktivitelerle dolu sürpriz bir macera günü planlayın.',
'Plan a surprise adventure day filled with adrenaline-packed activities.',
4, 1500, 8000, 2, 6, 7, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['macera','adrenalin','doğa','spor','sürpriz','aktivite','deneyim'], true, false);

-- 30. friendship-letter-box
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_friendship, 'friendship-letter-box',
'Arkadaşlık Mektup Kutusu', 'Friendship Letter Box',
'Arkadaşınız için özel bir mektup kutusu hazırlayın. Güzel bir ahşap veya karton kutuyu arkadaşlığınızı yansıtan renklerle boyayın ve süsleyin. İçine farklı zarflar koyun, her zarfın üzerine açılacağı zamanı yazın: "Üzgün olduğunda aç", "Bir başarı kutladığında aç", "Beni özlediğinde aç", "Cesaret ihtiyacın olduğunda aç", "Doğum günümde aç." Her zarfa o duruma uygun bir mektup, küçük bir hediye veya anlamlı bir fotoğraf koyun. Kutunun kapağına arkadaşlığınızın tarihini ve "Sonsuza kadar" yazısını ekleyin. Bu kutu, yanında olmadığınız anlarda bile arkadaşınıza destek olacak.',
'Prepare a special letter box for your friend. Paint and decorate a beautiful wooden or cardboard box in colors reflecting your friendship. Place different envelopes inside, writing the opening time on each: "Open when you''re sad", "Open when celebrating a success", "Open when you miss me", "Open when you need courage", "Open on my birthday." Put a letter appropriate for each situation, a small gift, or a meaningful photo in each envelope. Add your friendship date and "Forever" on the box lid. This box will support your friend even when you''re not around.',
'Her anı için mektuplar içeren kişisel bir arkadaşlık kutusu hediye edin.',
'Gift a personal friendship box containing letters for every occasion.',
2, 150, 600, 2, 2, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['mektup','kutu','el yapımı','duygusal','kişisel','hediye','destek'], false, true);


-- ==========================================
-- APOLOGY - 30 scenarios
-- ==========================================

-- 1. flower-bomb-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'flower-bomb-apology',
'Çiçek Bombardımanı Özrü', 'Flower Bomb Apology',
'Sevdiğiniz kişiden özür dilemek için günün farklı saatlerinde çiçek gönderin. Sabah küçük bir demet papatya ile "Günaydın, üzgünüm" notuyla başlayın. Öğle saatlerinde ofisine güller gönderin: "Hala düşünüyorum." Akşam eve geldiğinde kapıda dev bir buket bulsun: "Seni kaybetmek istemiyorum." Her çiçeğin yanına el yazısıyla yazılmış samimi bir not ekleyin. Son bukete uzun bir özür mektubu iliştirin. Çiçek türlerini kişinin favorilerine göre seçin. Bu jestler dizisi, özrünüzün ne kadar derin olduğunu gösterecek ve gün boyunca kişiyi düşündüğünüzü hissettirecek.',
'Send flowers at different times throughout the day to apologize to your loved one. Start with a small daisy bouquet in the morning with a "Good morning, I''m sorry" note. Send roses to their office at noon: "Still thinking of you." When they come home, a huge bouquet at the door: "I don''t want to lose you." Add a handwritten sincere note with each flower. Attach a long apology letter to the last bouquet. Choose flower types based on their favorites. This series of gestures will show how deep your apology is and make them feel you thought of them all day.',
'Gün boyunca farklı saatlerde çiçek göndererek duygusal bir özür dileyin.',
'Apologize emotionally by sending flowers at different times throughout the day.',
2, 500, 3000, 1, 1, 1, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['çiçek','özür','romantik','duygusal','jest','sürpriz'], false, true);

-- 2. vinyl-record-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'vinyl-record-apology',
'Vinil Plak Özür Hediyesi', 'Vinyl Record Apology Gift',
'Özel bir vinil plak bastırarak özrünüzü müziğe dönüştürün. Online platformlardan tek kopya vinil plak bastırabilirsiniz. Plağın A yüzüne birlikte dinlediğiniz en anlamlı şarkıları, B yüzüne kendi sesinizle kaydettiğiniz özür mesajını yerleştirin. Plağın kapağını kişiselleştirin: ikinizin fotoğrafı, özel bir çizim veya anlamlı bir tasarım. Plağı vintage bir plak çalarla birlikte hediye edin veya zaten varsa sadece plağı güzel bir kutuya koyun. Hediyeyi verirken birlikte oturup plağı dinleyin. Müzik akarken duygularınızı yüz yüze ifade edin. Bu benzersiz hediye, standart özürlerin ötesine geçecek.',
'Turn your apology into music by pressing a custom vinyl record. You can press single-copy vinyl records from online platforms. Place your most meaningful shared songs on the A-side and your voice-recorded apology message on the B-side. Customize the record cover: a photo of you two, a special drawing, or a meaningful design. Gift the record with a vintage record player or just place the record in a beautiful box if they already have one. When giving the gift, sit together and listen to the record. Express your feelings face to face while the music plays. This unique gift will go beyond standard apologies.',
'Kişisel özür mesajınızı içeren özel basım bir vinil plak hediye edin.',
'Gift a custom-pressed vinyl record containing your personal apology message.',
4, 2000, 6000, 1, 2, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['vinil','plak','müzik','özel','kişisel','retro','hediye'], true, false);

-- 3. podcast-apology-episode
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'podcast-apology-episode',
'Podcast Özür Bölümü', 'Podcast Apology Episode',
'Sevdiğiniz kişi için özel bir podcast bölümü kaydedin. Telefonunuzun ses kayıt uygulaması veya ücretsiz bir podcast aracı yeterli. Bölümü profesyonel bir giriş müziğiyle başlatın. İlişkinizin güzel anlarından bahsedin, hata yaptığınızı kabul edin ve ne hissettiğinizi samimiyetle anlatın. Ortak arkadaşlarınızdan veya aile üyelerinden kısa ses mesajları toplayın: herkes o kişi hakkında güzel bir şey söylesin. Bölümü gelecek planlarınız ve vaatlerinizle bitirin. Podcast''i özel bir link veya QR kodla paylaşın. QR kodu güzel bir kartın içine yerleştirin ve hediye olarak verin. Bu modern ve yaratıcı özür yöntemi, kalıcı bir dijital anı olacak.',
'Record a special podcast episode for your loved one. Your phone''s voice recorder or a free podcast tool is enough. Start the episode with professional intro music. Talk about beautiful moments in your relationship, acknowledge your mistake, and sincerely explain how you feel. Collect short voice messages from mutual friends or family members: everyone says something nice about that person. End the episode with your future plans and promises. Share the podcast with a private link or QR code. Place the QR code inside a beautiful card and give it as a gift. This modern and creative apology method will become a lasting digital memory.',
'Özür ve güzel anılarınızı anlatan özel bir podcast bölümü kaydedin.',
'Record a special podcast episode telling your apology and beautiful memories.',
3, 50, 300, 1, 1, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['podcast','ses','dijital','yaratıcı','modern','kişisel','özür'], false, false);

-- 4. message-chain-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'message-chain-apology',
'Mesaj Zinciri Özrü', 'Message Chain Apology',
'Sevdiğiniz kişiye günde bir tane olmak üzere 7 gün boyunca özel mesajlar gönderin. Her mesajı farklı bir formatta hazırlayın: 1. gün el yazısı mektup fotoğrafı, 2. gün sesli mesaj, 3. gün video mesajı, 4. gün şiir, 5. gün ortak fotoğraflardan kolaj, 6. gün bir şarkı kaydı (kendiniz söyleyin), 7. gün yüz yüze buluşma daveti. Her mesajda özrünüzün farklı bir yönünü işleyin: pişmanlık, anlayış, takdir, söz, umut, sevgi ve yeni başlangıç. Son gün buluşmada tüm mesajları bir albüm olarak hediye edin. Bu 7 günlük yolculuk, özrünüzün sabırlı ve kararlı olduğunu gösterecek.',
'Send special messages to your loved one, one per day for 7 days. Prepare each message in a different format: Day 1 handwritten letter photo, Day 2 voice message, Day 3 video message, Day 4 poem, Day 5 collage of shared photos, Day 6 a song recording (sing it yourself), Day 7 face-to-face meeting invitation. Address a different aspect of your apology in each message: regret, understanding, appreciation, promise, hope, love, and new beginnings. On the last day, gift all messages as an album at the meeting. This 7-day journey will show your apology is patient and determined.',
'7 gün boyunca farklı formatlarda özür mesajları gönderin.',
'Send apology messages in different formats over 7 days.',
2, 100, 500, 1, 1, 7, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['mesaj','günlük','sabır','yaratıcı','dijital','mektup','özür'], false, false);

-- 5. handwritten-letter-series
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'handwritten-letter-series',
'El Yazısı Mektup Serisi', 'Handwritten Letter Series',
'Beş adet el yazısıyla mektup yazın ve her birini farklı yerlere gizleyin. İlk mektup kapının altından, ikincisi araba torpido gözüne, üçüncüsü çanta cebine, dördüncüsü yastığın altına, beşincisi favori kitabının arasına. Her mektup özrünüzün farklı bir boyutunu anlatsın: ilki hatanızı kabul etsin, ikincisi onun duygularını anladığınızı, üçüncüsü birlikte geçirdiğiniz en güzel anları, dördüncüsü onsuz geçen günlerin zorluğunu, beşincisi gelecek vaatlerinizi. Güzel kağıtlar ve zarflar kullanın, her zarfın üzerine numara yazın. Mektupları keşfettikçe duyguları yoğunlaşacak ve son mektupta gözyaşlarını tutamayacak.',
'Write five handwritten letters and hide each in a different place. First letter under the door, second in the car glove box, third in their bag pocket, fourth under their pillow, fifth inside their favorite book. Each letter should address a different dimension of your apology: the first acknowledges your mistake, the second shows you understand their feelings, the third recalls your most beautiful moments together, the fourth describes how hard days are without them, the fifth contains your promises for the future. Use beautiful stationery and envelopes, number each envelope. Their emotions will intensify as they discover each letter, and they won''t hold back tears at the last one.',
'Farklı yerlere gizlenmiş beş el yazısı mektupla derin bir özür dileyin.',
'Deliver a deep apology with five handwritten letters hidden in different places.',
2, 50, 200, 1, 1, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['mektup','el yazısı','gizli','duygusal','samimi','klasik'], false, false);

-- 6. room-transformation-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'room-transformation-apology',
'Oda Dönüşümü Özrü', 'Room Transformation Apology',
'Sevdiğiniz kişi evde yokken odayı tamamen dönüştürün. Yüzlerce mum yakın (LED mumlar daha güvenli), gül yaprakları serpin, tavana peri ışıkları asın. Duvara ikinizin fotoğraflarından oluşan bir kalp şekli yapın. Ortaya güzel bir masa kurun: şarap, çikolata, favori yemeği. Masanın üzerine uzun bir özür mektubu koyun. Arka planda yumuşak müzik çalsın. Kapıya "Lütfen içeri gel" notu yapıştırın. Eve geldiğinde bu manzarayla karşılaşsın. Odaya girdiğinde siz zaten orada bekliyor olun. Yüz yüze, gözlerinin içine bakarak özrünüzü dileyin. Bu dramatik dönüşüm, sözlerinize güç katacak.',
'Completely transform the room while your loved one is away from home. Light hundreds of candles (LED candles are safer), scatter rose petals, hang fairy lights on the ceiling. Create a heart shape on the wall from photos of you two. Set up a beautiful table in the center: wine, chocolate, their favorite food. Place a long apology letter on the table. Play soft music in the background. Stick a "Please come in" note on the door. They should encounter this scene when they come home. Be already waiting inside when they enter the room. Apologize face to face, looking into their eyes. This dramatic transformation will add power to your words.',
'Odayı romantik bir şekilde dönüştürerek dramatik bir özür hazırlayın.',
'Prepare a dramatic apology by romantically transforming the room.',
3, 500, 2000, 1, 1, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['oda','dönüşüm','mum','romantik','dekorasyon','dramatik','özür'], false, true);

-- 7. star-naming-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'star-naming-apology',
'Yıldız İsimlendirme Özrü', 'Star Naming Apology',
'Sevdiğiniz kişinin adına bir yıldız isimlendirin ve bu jesti özür olarak sunun. Online yıldız isimlendirme servislerinden bir yıldız satın alın, sertifika ve yıldız haritası içeren paketi seçin. Sertifikayı güzel bir çerçeveye koyun. Açık bir gecede sevdiğiniz kişiyi dışarı çıkarın, battaniye serin, sıcak içecekler hazırlayın. Gökyüzüne bakarken yıldız haritasını çıkarın ve "Şu yıldız artık senin adını taşıyor" deyin. Sertifikayı gösterin ve mektubunuzu okuyun: "Hata yaptım ama sevgim bu yıldız kadar sonsuz." Bu romantik jest, özrünüzü kozmik bir boyuta taşıyacak ve her gece gökyüzüne baktığında sizi hatırlayacak.',
'Name a star after your loved one and present this gesture as an apology. Purchase a star from online star naming services, choose the package with certificate and star map. Frame the certificate beautifully. On a clear night, take your loved one outside, lay blankets, prepare warm drinks. While looking at the sky, pull out the star map and say "That star now carries your name." Show the certificate and read your letter: "I made a mistake but my love is as infinite as this star." This romantic gesture will elevate your apology to a cosmic level and they''ll remember you every time they look at the night sky.',
'Sevdiğiniz kişinin adına yıldız isimlendirerek kozmik bir özür dileyin.',
'Make a cosmic apology by naming a star after your loved one.',
2, 300, 1500, 1, 2, 5, 'outdoor', ARRAY['spring','summer','fall','winter'], ARRAY['yıldız','gökyüzü','romantik','kozmik','gece','sertifika','özür'], true, false);

-- 8. breakfast-bed-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'breakfast-bed-apology',
'Yatakta Kahvaltı Özrü', 'Breakfast in Bed Apology',
'Sevdiğiniz kişi için mükemmel bir yatakta kahvaltı hazırlayın. Sabah erkenden kalkın ve sessizce mutfağa gidin. Favori kahvaltılıklarını hazırlayın: taze sıkılmış portakal suyu, yumurta, taze ekmek, bal, peynir, meyve tabağı. Tepsiye tek bir gül ve küçük bir özür kartı koyun. Kahvaltıyı yatak odasına götürün ve nazikçe uyandırın. Kart üzerinde basit ama içten bir mesaj olsun: "Dünü geri alamam ama bugünü güzelleştirebilirim." Kahvaltı boyunca birlikte konuşun, dinleyin ve duygularınızı paylaşın. Bu basit ama samimi jest, büyük jestlerden daha etkili olabilir çünkü gündelik sevgiyi ve özeni gösterir.',
'Prepare a perfect breakfast in bed for your loved one. Wake up early and quietly go to the kitchen. Prepare their favorite breakfast items: freshly squeezed orange juice, eggs, fresh bread, honey, cheese, fruit platter. Place a single rose and a small apology card on the tray. Take the breakfast to the bedroom and gently wake them up. The card should have a simple but heartfelt message: "I can''t take back yesterday but I can make today beautiful." Talk, listen, and share your feelings together during breakfast. This simple but sincere gesture can be more effective than grand gestures because it shows everyday love and care.',
'Sabah kahvaltısı sürpriziyle basit ama samimi bir özür dileyin.',
'Deliver a simple but sincere apology with a morning breakfast surprise.',
1, 100, 400, 1, 1, 0, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kahvaltı','sabah','basit','samimi','ev','romantik','yemek'], false, false);

-- 9. photo-album-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'photo-album-apology',
'Özür Fotoğraf Albümü', 'Apology Photo Album',
'İlişkinizin en güzel anlarını içeren bir fotoğraf albümü hazırlayın ve son sayfaya özür mektubunuzu yazın. Fotoğrafları kronolojik sırada dizin: tanışma, ilk randevu, tatiller, kutlamalar, gündelik anlar. Her fotoğrafın altına o anı neden özel kıldığını yazın. Albümün ortasına "Hatalarım" başlıklı bir sayfa ekleyin, hatanızı kabul edin. Son sayfalarda gelecek planlarınızı ve vaatlerinizi paylaşın. Albümün son sayfası bir mektup olsun: neden üzgün olduğunuzu, onu ne kadar sevdiğinizi ve ilişkinize ne kadar değer verdiğinizi anlatın. Albümü birlikte açın ve sayfaları birlikte çevirin.',
'Create a photo album featuring the most beautiful moments of your relationship and write your apology letter on the last page. Arrange photos chronologically: meeting, first date, vacations, celebrations, everyday moments. Write under each photo what makes that moment special. Add a page titled "My Mistakes" in the middle of the album and acknowledge your error. Share your future plans and promises on the later pages. The last page should be a letter: explaining why you''re sorry, how much you love them, and how much you value the relationship. Open the album together and turn the pages together.',
'Anılarınızı ve özrünüzü bir arada sunan duygusal bir fotoğraf albümü.',
'An emotional photo album presenting your memories and apology together.',
2, 200, 1000, 1, 2, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['fotoğraf','albüm','anı','duygusal','mektup','kişisel'], false, false);

-- 10. love-jar-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'love-jar-apology',
'Sevgi Kavanozu Özrü', 'Love Jar Apology',
'Cam bir kavanozu 100 küçük kağıtla doldurun, her birinde sevdiğiniz kişiyi neden sevdiğinizi anlatan bir cümle olsun. Kağıtları farklı renklerde yazın: pembe kağıtlara fiziksel özelliklerini, mavi kağıtlara kişilik özelliklerini, yeşil kağıtlara birlikte yaptığınız en güzel şeyleri, sarı kağıtlara geleceğe dair hayallerinizi, beyaz kağıtlara özrünüzü ve pişmanlıklarınızı yazın. Kavanozu şeritlerle süsleyin, kapağına "100 Sebep" yazın. Yanına kısa bir mektup ekleyin: "Hata yaptım ama seni sevmemin 100 sebebi burada. Her birini oku ve beni affet." Her gün bir kağıt açması için teşvik edin.',
'Fill a glass jar with 100 small papers, each containing a sentence about why you love your person. Write on different colored papers: physical qualities on pink, personality traits on blue, the best things you do together on green, future dreams on yellow, your apology and regrets on white. Decorate the jar with ribbons, write "100 Reasons" on the lid. Add a short letter: "I made a mistake but here are 100 reasons I love you. Read each one and forgive me." Encourage them to open one paper each day.',
'100 sevgi cümlesiyle dolu bir kavanoz hazırlayarak özür dileyin.',
'Apologize by preparing a jar filled with 100 love sentences.',
1, 50, 200, 1, 1, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kavanoz','sevgi','kağıt','kişisel','el yapımı','duygusal','özür'], false, false);

-- 11. sunset-walk-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'sunset-walk-apology',
'Gün Batımı Yürüyüşü Özrü', 'Sunset Walk Apology',
'Sevdiğiniz kişiyi gün batımında anlamlı bir yere yürüyüşe davet edin. İlk randevunuzun olduğu park, teklif ettiğiniz sahil veya en mutlu gününüzü geçirdiğiniz yer olabilir. Yürüyüş boyunca duygularınızı paylaşın, onu dinleyin ve hatanızı yüz yüze kabul edin. Yolun sonunda küçük bir sürpriz hazırlayın: battaniye, sıcak çikolata ve tatlılar. Gün batımını izlerken elini tutun ve gözlerinin içine bakarak özür dileyin. Cebinizde hazırladığınız küçük hediyeyi çıkarın: anlamlı bir takı, kitap veya kişisel bir obje. Bu samimi ve romantik an, yapay jestlerden çok daha güçlü bir etki bırakacak.',
'Invite your loved one for a sunset walk to a meaningful place. It could be the park of your first date, the beach where you proposed, or the place where you spent your happiest day. Share your feelings during the walk, listen to them, and acknowledge your mistake face to face. Prepare a small surprise at the end of the path: blanket, hot chocolate, and treats. Hold their hand while watching the sunset and apologize looking into their eyes. Pull out the small gift you prepared in your pocket: meaningful jewelry, a book, or a personal object. This sincere and romantic moment will leave a stronger impact than artificial gestures.',
'Gün batımında anlamlı bir yerde samimi ve romantik bir özür dileyin.',
'Deliver a sincere and romantic apology at a meaningful place during sunset.',
1, 100, 800, 1, 2, 1, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['gün batımı','yürüyüş','romantik','samimi','doğa','basit'], false, false);

-- 12. cooking-dinner-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'cooking-dinner-apology',
'Özür Yemeği Pişirme', 'Cooking an Apology Dinner',
'Sevdiğiniz kişi için en sevdiği yemeği sıfırdan pişirin. Daha önce hiç pişirmediyseniz bile bu çaba çok anlamlı olacak. Tarifi araştırın, malzemeleri özenle seçin. Mutfağı temizleyin ve masayı zarif bir şekilde kurun: örtü, peçeteler, mumlar, çiçekler. Yemeği hazırlarken fotoğraf çekin - bu çabayı göstermek güzel olur. Eve geldiğinde güzel kokuların onu karşılamasını sağlayın. Yemek servisini restoran kalitesinde yapmaya çalışın. Yemek sırasında samimi bir konuşma yapın, hatanızı kabul edin ve dinleyin. Tatlı olarak birlikte hazırlayabileceğiniz basit bir tarif seçin. Bu ev yapımı jest, samimiyetinizi gösterecek.',
'Cook your loved one''s favorite meal from scratch. Even if you''ve never cooked before, this effort will be very meaningful. Research the recipe, carefully select ingredients. Clean the kitchen and set the table elegantly: tablecloth, napkins, candles, flowers. Take photos while preparing the meal - showing this effort is nice. Make sure pleasant aromas greet them when they come home. Try to serve the food at restaurant quality. Have a sincere conversation during dinner, acknowledge your mistake, and listen. Choose a simple recipe you can prepare together for dessert. This homemade gesture will demonstrate your sincerity.',
'Sevdiğiniz kişinin favori yemeğini sıfırdan pişirerek özür dileyin.',
'Apologize by cooking your loved one''s favorite meal from scratch.',
2, 200, 800, 1, 2, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['yemek','pişirme','ev','romantik','çaba','samimi','akşam yemeği'], false, false);

-- 13. playlist-apology-gift
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'playlist-apology-gift',
'Özür Playlist Hediyesi', 'Apology Playlist Gift',
'Duygularınızı anlatan şarkılardan özel bir playlist oluşturun ve görsel bir hediye olarak sunun. Playlist''i mantıksal bir sırada dizin: pişmanlık şarkılarıyla başlayın, özlem şarkılarıyla devam edin, umut dolu şarkılarla bitirin. Her şarkı için bir not kartı hazırlayın: şarkının adı, neden seçtiğiniz ve o şarkının ilişkinizle bağlantısı. Not kartlarını güzel bir kutuya koyun, kutunun içine playlist''in QR kodunu ve küçük bir bluetooth hoparlör ekleyin. Hediyeyi verirken birlikte ilk şarkıyı dinleyin. Playlist''in son şarkısını "bizim şarkımız" yapın ve geleceğe dair bir umut mesajı ekleyin.',
'Create a special playlist of songs expressing your feelings and present it as a visual gift. Arrange the playlist in a logical order: start with regret songs, continue with longing songs, finish with hopeful songs. Prepare a note card for each song: the song name, why you chose it, and its connection to your relationship. Put the note cards in a beautiful box, add the playlist''s QR code and a small bluetooth speaker inside. When giving the gift, listen to the first song together. Make the last song "our song" and add a message of hope for the future.',
'Duygularınızı anlatan şarkılarla özel bir özür playlist''i hediye edin.',
'Gift a special apology playlist with songs expressing your feelings.',
1, 100, 800, 1, 2, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['müzik','playlist','şarkı','duygusal','hediye','dijital'], false, false);

-- 14. scrapbook-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'scrapbook-apology',
'Karalama Defteri Özrü', 'Scrapbook Apology',
'İlişkinizin hikayesini anlatan el yapımı bir karalama defteri oluşturun. Fotoğraflar, biletler, kurumuş çiçekler, notlar ve küçük hatıra nesnelerini güzel bir deftere yapıştırın. Her sayfayı bir tema etrafında düzenleyin: "İlk Gün", "En Güzel Gülümsemen", "Birlikte Seyahatlerimiz", "Seni Güldüren Anlar." Defterin ortasına "Benim Hatam" sayfası ekleyin - hatanızı kabul eden, samimi ve detaylı bir yazı yazın. Son sayfalarda "Söz Veriyorum" başlığıyla gelecek vaatlerinizi listeleyin. Defteri washi tape, sticker ve renkli kalemlerle süsleyin. Bu emek yoğun hediye, özrünüzün ne kadar ciddi olduğunu gösterecek.',
'Create a handmade scrapbook telling the story of your relationship. Paste photos, tickets, dried flowers, notes, and small keepsakes into a beautiful notebook. Organize each page around a theme: "First Day", "Your Most Beautiful Smile", "Our Travels Together", "Moments That Made You Laugh." Add a "My Mistake" page in the middle - write a sincere and detailed text acknowledging your error. On the last pages, list your future promises under the title "I Promise." Decorate the notebook with washi tape, stickers, and colored pens. This labor-intensive gift will show how serious your apology is.',
'El yapımı bir karalama defteriyle ilişkinizin hikayesini ve özrünüzü sunun.',
'Present your relationship story and apology through a handmade scrapbook.',
3, 200, 800, 1, 1, 10, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['karalama defteri','el yapımı','fotoğraf','yaratıcı','emek','anı'], false, false);

-- 15. picnic-apology-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'picnic-apology-surprise',
'Piknik Özür Sürprizi', 'Picnic Apology Surprise',
'Sevdiğiniz kişi için özel ve romantik bir piknik organize edin. Anlamlı bir yer seçin: ilk randevunuzun olduğu park veya ikinizin sevdiği sakin bir bahçe. Piknik sepetine el yapımı sandviçler, meyveler, peynir tabağı, tatlılar ve favori içeceğini koyun. Battaniyeyi yere serin, etrafına küçük çiçek vazoları yerleştirin. Bluetooth hoparlörle yumuşak müzik açın. Piknik alanına geldiğinde onu özür notuyla karşılayın. Birlikte yemek yerken sakin ve samimi bir şekilde konuşun. Pikniğin sonunda cebinizden küçük bir hediye kutusu çıkarın: içinde anlamlı bir takı veya anahtar. Doğanın huzurunda kalpten kalbe konuşun.',
'Organize a special and romantic picnic for your loved one. Choose a meaningful place: the park of your first date or a quiet garden you both love. Pack the picnic basket with homemade sandwiches, fruits, cheese platter, sweets, and their favorite drink. Spread the blanket on the ground, place small flower vases around it. Play soft music with a bluetooth speaker. Greet them with an apology note when they arrive at the picnic area. Talk calmly and sincerely while eating together. At the end of the picnic, pull out a small gift box from your pocket: containing meaningful jewelry or a keychain. Have a heart-to-heart talk in nature''s peace.',
'Doğada romantik bir piknik düzenleyerek samimi bir özür dileyin.',
'Deliver a sincere apology by organizing a romantic picnic in nature.',
2, 300, 1200, 1, 2, 2, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['piknik','doğa','romantik','yemek','samimi','özür','bahçe'], false, false);

-- 16. video-message-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'video-message-apology',
'Video Mesaj Özrü', 'Video Message Apology',
'Kamera karşısında yüreğinizi açarak duygusal bir özür videosu çekin. Videoyu anlamlı bir yerde çekin: ilk tanıştığınız yer, en sevdiğiniz mekan veya evinizde özel bir köşe. Kıyafetinize dikkat edin, sakin ve samimi olun. Videoyu birkaç bölüme ayırın: hatanızı kabul ettiğiniz kısım, birlikte geçirdiğiniz güzel anları anlattığınız kısım ve gelecek vaatleriniz. Arka plana hafif bir müzik ekleyin. Videoyu montajlarken araya fotoğraflar ve kısa klipler serpiştirin. Videoyu USB bellekte, özel bir kutuda veya gizli bir QR kodla sunun. Bu video yıllar sonra bile izlenecek kalıcı bir özür anısı olacak.',
'Record an emotional apology video by opening your heart in front of the camera. Film it at a meaningful place: where you first met, your favorite spot, or a special corner of your home. Pay attention to your outfit, be calm and sincere. Divide the video into sections: acknowledging your mistake, recounting beautiful moments together, and your promises for the future. Add light music in the background. Sprinkle photos and short clips throughout the edit. Present the video on a USB drive, in a special box, or with a hidden QR code. This video will be a lasting apology memory that can be watched even years later.',
'Kamera karşısında samimi bir özür videosu çekerek duygularınızı paylaşın.',
'Share your feelings by recording a sincere apology video on camera.',
2, 50, 300, 1, 1, 3, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['video','dijital','duygusal','samimi','mesaj','kamera'], false, false);

-- 17. treasure-hunt-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'treasure-hunt-apology',
'Hazine Avı Özrü', 'Treasure Hunt Apology',
'Sevdiğiniz kişi için evde veya şehirde bir hazine avı organize edin. 5-7 durak belirleyin, her durakta bir ipucu ve küçük bir hediye bırakın. İlk ipucuyu sabah yastığının altına koyun. Her ipucu bir sonraki durağa yönlendirsin ve her durakta özrünüzün bir parçasını anlatan küçük bir not olsun. Duraklar anlamlı yerler olsun: ilk randevunuzun olduğu yer, en çok güldüğünüz mekan. Her duraktaki hediyeler giderek büyüsün: ilkinde çikolata, sonra çiçek, sonra parfüm. Son durakta siz bekliyor olun - elinizdeki en büyük hediye ve dudağınızdaki en samimi özürle. Bu macera, özrünüzü unutulmaz bir deneyime dönüştürecek.',
'Organize a treasure hunt at home or around the city for your loved one. Set 5-7 stops, leaving a clue and small gift at each. Place the first clue under their pillow in the morning. Each clue should lead to the next stop with a small note telling part of your apology. Make stops meaningful places: where your first date was, where you laughed the most. Gifts at each stop should get progressively bigger: chocolate first, then flowers, then perfume. You should be waiting at the final stop - with the biggest gift in your hands and the most sincere apology on your lips. This adventure will turn your apology into an unforgettable experience.',
'İpuçları ve hediyelerle dolu bir hazine avıyla yaratıcı bir özür dileyin.',
'Deliver a creative apology with a treasure hunt full of clues and gifts.',
3, 500, 3000, 1, 1, 3, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['hazine avı','ipucu','hediye','macera','yaratıcı','sürpriz','özür'], false, false);

-- 18. spa-gift-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'spa-gift-apology',
'Spa Hediye Özrü', 'Spa Gift Apology',
'Sevdiğiniz kişiye lüks bir spa deneyimi hediye ederek özür dileyin. Şehrin en iyi spa merkezlerinden birinde paket rezervasyonu yapın: masaj, yüz bakımı, hamam ve rahatlama alanı kullanımı dahil. İki kişilik çift paketi seçin, birlikte gidin. Spa öncesi güzel bir özür kartı hazırlayın: "Sana verdiğim stresi alıp götürsün bu gün." Spa''ya giderken yolda favori içeceğini alın. Spa sonrası rahatlamış halde güzel bir kafede oturun ve sakin bir ortamda konuşun. Eve döndüğünüzde masanın hazır olduğunu görsün - hafif bir akşam yemeği ve mumlar. Bu gün boyunca sadece onu düşündüğünüzü ve rahatını önemsediğinizi hissettirin.',
'Apologize by gifting your loved one a luxury spa experience. Book a package at one of the city''s best spa centers: including massage, facial, Turkish bath, and relaxation area access. Choose the couples package and go together. Prepare a nice apology card before the spa: "Let this day wash away the stress I caused you." Get their favorite drink on the way to the spa. After the spa, sit at a nice cafe while relaxed and talk in a calm environment. When you return home, the table should be ready - a light dinner and candles. Throughout the day, make them feel you''re only thinking of them and care about their comfort.',
'Lüks bir spa deneyimi hediye ederek rahatlatıcı bir özür dileyin.',
'Deliver a relaxing apology by gifting a luxury spa experience.',
2, 2000, 8000, 1, 2, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['spa','masaj','lüks','rahatlama','bakım','hediye','özür'], true, false);

-- 19. custom-cake-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'custom-cake-apology',
'Özel Tasarım Pasta Özrü', 'Custom Cake Apology',
'Sevdiğiniz kişi için özel tasarım bir özür pastası sipariş edin veya kendiniz yapın. Pastanın üzerine iç esprinizi, anlamlı bir cümleyi veya komik bir özür mesajını yazdırın. Tasarımı kişiselleştirin: en sevdiği renk, karakter veya hobi temalı olsun. Eğer kendiniz yaparsanız mükemmel olması gerekmez - çabanız daha değerli olacak. Pastanın yanına mumlar ve küçük bir kart koyun. Pasta kutusunun içine gizli bir mektup yerleştirin. Pastayı akşam eve geldiğinde masada hazır bulunsun. Birlikte kesin, birlikte yiyin ve birlikte gülün. Tatlı bir jest bazen en acı özürleri bile tatlıya çevirebilir.',
'Order or make a custom apology cake for your loved one. Write your inside joke, a meaningful sentence, or a funny apology message on the cake. Personalize the design: make it themed around their favorite color, character, or hobby. If you make it yourself, it doesn''t need to be perfect - your effort will be more valuable. Place candles and a small card next to the cake. Hide a secret letter inside the cake box. The cake should be ready on the table when they come home in the evening. Cut it together, eat it together, and laugh together. A sweet gesture can sometimes turn even the bitterest apologies into something sweet.',
'Özel tasarım bir pastayla tatlı ve yaratıcı bir özür dileyin.',
'Make a sweet and creative apology with a custom-designed cake.',
2, 200, 1000, 1, 2, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['pasta','tatlı','özel tasarım','yaratıcı','ev','yemek','özür'], false, false);

-- 20. balloon-room-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'balloon-room-apology',
'Balon Dolu Oda Özrü', 'Balloon-Filled Room Apology',
'Sevdiğiniz kişi evde yokken odayı yüzlerce balonla doldurun. Her balona küçük bir not bağlayın: "Seni seviyorum çünkü...", "En güzel anımız...", "Söz veriyorum ki..." gibi. Bazı balonların içine konfeti koyun, bazılarının içine küçük hediyeler (takı, çikolata, bilet). Balonları yere ve tavana dağıtın, oda kapısını açtığında balon seli gelsin. Balonların arasına büyük harflerle "ÖZÜR DİLERİM" yazan bir pankart asın. Odanın ortasına bir sepet koyun: içinde şampanya, çikolata ve uzun bir özür mektubu olsun. Bu görsel şov, kapıyı açtığı anda nefesini kesecek ve yüzündeki gülümseme her şeyi düzeltecek.',
'Fill the room with hundreds of balloons while your loved one is away. Tie a small note to each balloon: "I love you because...", "Our best memory...", "I promise that..." Put confetti in some balloons and small gifts in others (jewelry, chocolate, tickets). Distribute balloons on the floor and ceiling so a balloon flood greets them when they open the door. Hang a banner reading "I''M SORRY" in large letters among the balloons. Place a basket in the center of the room: containing champagne, chocolate, and a long apology letter. This visual show will take their breath away the moment they open the door and the smile on their face will fix everything.',
'Yüzlerce balonla doldurulmuş odayla nefes kesen bir özür hazırlayın.',
'Prepare a breathtaking apology with a room filled with hundreds of balloons.',
3, 300, 1500, 1, 1, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['balon','dekorasyon','sürpriz','romantik','oda','görsel','özür'], false, false);

-- 21. song-dedication-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'song-dedication-apology',
'Şarkı İthafı Özrü', 'Song Dedication Apology',
'Sevdiğiniz kişiye bir şarkı ithaf ederek özür dileyin. Bir müzisyen arkadaşınızdan veya profesyonel bir müzisyenden canlı performans organize edin. Bir restoranda, kafede veya parkta buluşun ve müzisyen sürpriz olarak gelsin. Müzisyene "bu şarkıyı sevgilime ithaf ediyorum" dedirtin. Eğer müzisyen bulamazsanız, kendiniz şarkı söyleyin veya bir enstrüman çalın - mükemmel olması gerekmez, çaba önemli. Şarkı sırasında bir buket çiçek sunun. Şarkının sözlerini güzel bir kağıda yazıp çerçeveleyin ve hediye edin. Bu müzikal jest, standart özürlerin ötesine geçen romantik bir deneyim yaratacak.',
'Apologize by dedicating a song to your loved one. Organize a live performance from a musician friend or professional musician. Meet at a restaurant, cafe, or park and have the musician arrive as a surprise. Have the musician say "I''m dedicating this song to my partner." If you can''t find a musician, sing the song yourself or play an instrument - it doesn''t need to be perfect, the effort matters. Present a bouquet of flowers during the song. Write the song lyrics on beautiful paper, frame it, and gift it. This musical gesture will create a romantic experience beyond standard apologies.',
'Canlı müzik performansıyla romantik bir şarkı ithafı yaparak özür dileyin.',
'Apologize with a romantic song dedication through a live music performance.',
3, 500, 3000, 1, 3, 5, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['şarkı','müzik','canlı','romantik','ithaf','performans','özür'], false, false);

-- 22. garden-plant-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'garden-plant-apology',
'Bahçe Bitkisi Özrü', 'Garden Plant Apology',
'Sevdiğiniz kişiye özel bir bitki hediye ederek büyüyen bir özür sunun. Uzun ömürlü ve bakımı kolay bir bitki seçin: zeytin ağacı fidanı, bonsai, lavanta veya gül çalısı. Saksıyı kişiselleştirin: üzerine ikinizin adını, özel bir tarihi veya anlamlı bir mesaj yazın. Bitkinin yanına bir kart ekleyin: "Bu bitki gibi sevgimiz de her gün büyüsün. Hatamı affet ve birlikte büyümeye devam edelim." Bitkiyi birlikte dikin - toprağa el ele dokunun, suyu birlikte verin. Bakım talimatları yazın ve birlikte takip edin. Bu bitki zamanla büyüdükçe affedişin ve yeniden başlamanın canlı sembolü olacak.',
'Offer a growing apology by gifting a special plant to your loved one. Choose a long-lasting, easy-to-care-for plant: an olive tree sapling, bonsai, lavender, or rose bush. Personalize the pot: write both your names, a special date, or a meaningful message on it. Add a card with the plant: "May our love grow every day like this plant. Forgive my mistake and let''s keep growing together." Plant it together - touch the soil hand in hand, water it together. Write care instructions and follow them together. As this plant grows over time, it will become a living symbol of forgiveness and new beginnings.',
'Büyüyen bir bitkiyle sevginizin ve özrünüzün canlı sembolünü oluşturun.',
'Create a living symbol of your love and apology with a growing plant.',
1, 100, 500, 1, 2, 2, 'outdoor', ARRAY['spring','summer'], ARRAY['bitki','bahçe','doğa','büyüme','sembol','sürdürülebilir','özür'], false, false);

-- 23. turkish-delight-box-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'turkish-delight-box-apology',
'Lokum Kutusu Özrü', 'Turkish Delight Box Apology',
'Sevdiğiniz kişi için özel bir lokum kutusu hazırlayın. En kaliteli lokumculardan farklı çeşitlerde lokum alın: gül, fıstık, nar, portakal, çifte kavrulmuş. Her lokumun altına küçük kağıtlar yerleştirin, her birinde bir özür mesajı veya sevgi notu olsun. Kutuyu el yapımı kağıtla sarın, üzerine Osmanlı motifleri çizin veya bastırın. Kutunun kapağına "Hayatımın lokumu" veya "Tatlım, özür dilerim" yazın. Yanına bir fincan Türk kahvesi hazırlayın ve birlikte oturup lokumları yiyin. Her lokumu açtığında altındaki notu okusun. Bu geleneksel ve zarif jest, Türk kültürünün sıcaklığını özrünüze taşıyacak.',
'Prepare a special Turkish delight box for your loved one. Buy different varieties from the finest lokum makers: rose, pistachio, pomegranate, orange, double-roasted. Place small papers under each delight with an apology message or love note on each. Wrap the box with handmade paper and draw or print Ottoman motifs on it. Write "The delight of my life" or "My sweet, I''m sorry" on the box lid. Prepare a cup of Turkish coffee alongside and sit together eating the lokum. As they pick up each piece, they read the note underneath. This traditional and elegant gesture will bring the warmth of Turkish culture to your apology.',
'Geleneksel lokum kutusuyla zarif ve kültürel bir özür sunun.',
'Present an elegant and cultural apology with a traditional Turkish delight box.',
2, 200, 800, 1, 2, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['lokum','geleneksel','tatlı','Türk','zarif','kültürel','hediye'], false, false);

-- 24. memory-video-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'memory-video-apology',
'Anı Videosu Özrü', 'Memory Video Apology',
'Birlikte geçirdiğiniz en güzel anları derleyerek profesyonel bir anı videosu hazırlayın. Telefonunuzdaki tüm ortak fotoğrafları ve videoları tarayın, en duygusal olanları seçin. Kronolojik sıraya dizin ve geçişlerle birleştirin. Arka plana "bizim şarkımızı" veya duygusal bir enstrümantal müzik ekleyin. Videonun sonuna beyaz zemin üzerine siyah harflerle yazılmış özür metninizi ekleyin. Son kare olarak "Seni seviyorum, beni affeder misin?" yazısıyla bitirin. Videoyu yüksek kalitede render edin ve USB''ye koyun. Özel bir kutuya koyup hediye edin veya ev sineması atmosferinde birlikte izleyin.',
'Create a professional memory video compiling the most beautiful moments you spent together. Scan all shared photos and videos on your phone, select the most emotional ones. Arrange chronologically and combine with transitions. Add "our song" or emotional instrumental music in the background. Add your apology text in black letters on white background at the end of the video. End with a final frame reading "I love you, will you forgive me?" Render the video in high quality and put it on USB. Gift it in a special box or watch it together in a home cinema atmosphere.',
'Ortak anılarınızdan profesyonel bir video montajıyla duygusal bir özür.',
'An emotional apology with a professional video montage of shared memories.',
3, 100, 500, 1, 2, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['video','anı','montaj','dijital','duygusal','fotoğraf','müzik'], false, false);

-- 25. charity-donation-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'charity-donation-apology',
'Hayır Bağışı Özrü', 'Charity Donation Apology',
'Sevdiğiniz kişinin adına anlamlı bir hayır kurumuna bağış yaparak özür dileyin. Onun önemsediği bir konuyu seçin: hayvan hakları, çocuk eğitimi, çevre koruma veya sağlık. Bağışı onun adına yapın ve sertifikayı güzel bir çerçeveye koyun. Yanına bir mektup yazın: "Sana verdiğim üzüntüyü telafi edemem ama senin adına dünyayı biraz daha güzel bir yer yapabilirim." Ek olarak, birlikte o hayır kurumuna gönüllü olmayı teklif edin. Bu jest, özrünüzün ötesinde, onun değerlerini anladığınızı ve paylaştığınızı gösterecek. Maddi değil, manevi bir hediye olması özrünüze derinlik katacak.',
'Apologize by making a donation to a meaningful charity in your loved one''s name. Choose a cause they care about: animal rights, children''s education, environmental protection, or health. Make the donation in their name and frame the certificate beautifully. Write a letter alongside: "I can''t undo the sadness I caused you but I can make the world a slightly better place in your name." Additionally, offer to volunteer together at that charity. This gesture, beyond your apology, will show you understand and share their values. Being a spiritual rather than material gift will add depth to your apology.',
'Sevdiğiniz kişinin adına hayır bağışı yaparak anlamlı bir özür dileyin.',
'Make a meaningful apology by donating to charity in your loved one''s name.',
1, 200, 5000, 1, 2, 1, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['bağış','hayır','sosyal','anlamlı','değer','gönüllü','özür'], false, false);

-- 26. couples-therapy-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'couples-therapy-surprise',
'Çift Terapisi Sürprizi', 'Couples Therapy Surprise',
'İlişkinizi güçlendirmek için profesyonel bir çift terapistinden randevu alın ve bunu bir özür jesti olarak sunun. Bu adım, sorunlarınızı ciddiye aldığınızı ve ilişkiniz için çaba göstermeye hazır olduğunuzu gösterir. Terapistin profilini araştırın, iyi yorumları olan birini seçin. İlk seans randevusunu alın ve sevdiğiniz kişiye anlatın: "İlişkimizi önemsiyorum ve profesyonel destek almak istiyorum. Bu benim hatamı kabul etmem ve daha iyi olmak için adım atmam." Terapiye birlikte gitmeyi teklif edin, baskı yapmayın. Bu olgun ve cesur adım, ilişkinize yeni bir sayfa açabilir ve iletişiminizi güçlendirebilir.',
'Book an appointment with a professional couples therapist and present it as an apology gesture. This step shows you take your problems seriously and are ready to work for your relationship. Research the therapist''s profile, choose one with good reviews. Book the first session and tell your loved one: "I care about our relationship and want to get professional support. This is me acknowledging my mistake and taking steps to be better." Offer to go to therapy together without pressure. This mature and brave step can open a new chapter in your relationship and strengthen your communication.',
'Çift terapisi randevusu alarak ilişkinize profesyonel destek sunun.',
'Offer professional support for your relationship by booking couples therapy.',
5, 1500, 10000, 2, 2, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['terapi','profesyonel','iletişim','gelişim','cesaret','ilişki','özür'], true, true);

-- 27. forgiveness-jar
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'forgiveness-jar',
'Affetme Kavanozu', 'Forgiveness Jar',
'İki kavanoz hazırlayın: biri "Söz Veriyorum" kavanozu, diğeri "Af Diliyorum" kavanozu. İlk kavanoza gelecekte yapmayı vaat ettiğiniz 50 şeyi yazın: "Daha iyi dinleyeceğim", "Özel günleri unutmayacağım", "Kızdığımda sakin kalacağım" gibi. İkinci kavanoza pişman olduğunuz 30 anı yazın ve her birinde ne yapmanız gerektiğini belirtin. Kavanozları süsleyin, renk kodlarıyla ayırın. Birlikte oturun, sırayla kavanozlardan kağıtlar çekin ve tartışın. Bu egzersiz hem özür hem de iyileşme sürecinin başlangıcı olacak. Kavanozları görünür bir yere koyun - her gün bir vaadi hatırlamanız için.',
'Prepare two jars: one is the "I Promise" jar, the other is the "I Apologize" jar. Write 50 things you promise to do in the first jar: "I''ll listen better", "I won''t forget special days", "I''ll stay calm when angry." Write 30 moments you regret in the second jar, specifying what you should have done in each. Decorate the jars, separate them with color codes. Sit together, take turns drawing papers from the jars and discuss. This exercise will be both an apology and the beginning of a healing process. Place the jars somewhere visible - to remind yourself of a promise every day.',
'İki kavanozla hem özür dileyin hem de birlikte iyileşme sürecini başlatın.',
'Both apologize and start a healing process together with two jars.',
2, 50, 200, 1, 2, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kavanoz','affetme','söz','iyileşme','egzersiz','kişisel','özür'], false, false);

-- 28. love-letter-bouquet
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'love-letter-bouquet',
'Mektup Buketi Özrü', 'Love Letter Bouquet Apology',
'Çiçek buketi yerine mektup buketi hazırlayın. 12 adet renkli kağıdı gül şeklinde katlayın veya kıvırın. Her kağıt gülün içine küçük bir mektup gizleyin. Mektuplarda farklı konulara değinin: "İlk görüşte hissettiklerim", "En güzel anımız", "Senden öğrendiklerim", "Hatam ve pişmanlığım", "Gelecek hayallerim seninle", "Seni neden seviyorum." Kağıt gülleri gerçek yapraklarla karıştırarak bir buket oluşturun. Buketi gerçek bir çiçekçi kağıdına sarın. Buketi teslim ederken her gülün içinde bir sürpriz olduğunu söyleyin. Bu el emeği hediye, sıradan bir çiçek buketinden çok daha kişisel ve anlamlı olacak.',
'Prepare a letter bouquet instead of a flower bouquet. Fold or curl 12 colorful papers into rose shapes. Hide a small letter inside each paper rose. Address different topics in the letters: "What I felt at first sight", "Our best memory", "What I learned from you", "My mistake and regret", "My future dreams with you", "Why I love you." Create a bouquet mixing paper roses with real leaves. Wrap the bouquet in real florist paper. When delivering, mention there''s a surprise inside each rose. This handcrafted gift will be much more personal and meaningful than an ordinary flower bouquet.',
'Kağıt güllerden oluşan, içinde gizli mektuplar taşıyan bir buket hazırlayın.',
'Prepare a bouquet of paper roses carrying hidden letters inside.',
3, 100, 400, 1, 1, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['mektup','buket','el yapımı','kağıt','yaratıcı','romantik','özür'], false, false);

-- 29. surprise-trip-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'surprise-trip-apology',
'Sürpriz Gezi Özrü', 'Surprise Trip Apology',
'Sevdiğiniz kişiyi sürpriz bir hafta sonu kaçamağına çıkarın. Onun hep gitmek istediği ama fırsat bulamadığı bir şehri veya tatil beldesini seçin. Otel, ulaşım ve aktiviteleri önceden planlayın. Bavulunu gizlice hazırlayın veya "hafta sonu için bir çanta hazırla" deyin. Yolculuk sırasında nereye gittiğinizi söylemeyin, ipuçları verin. Varış noktasında otel odasına önceden çiçek ve özür mektubu gönderin. Geziyi birlikte keşfedin: yerel yemekler deneyin, manzaralı yerlere gidin, birlikte fotoğraflar çekin. Bu gezi, rutinden koparak ilişkinizi yeniden canlandıracak ve başbaşa kaliteli vakit geçirmenizi sağlayacak.',
'Take your loved one on a surprise weekend getaway. Choose a city or resort they''ve always wanted to visit but never had the chance. Plan hotel, transportation, and activities in advance. Pack their bag secretly or say "pack a bag for the weekend." Don''t reveal the destination during the journey, give clues. Send flowers and an apology letter to the hotel room in advance. Explore the destination together: try local foods, visit scenic places, take photos together. This trip will revitalize your relationship by breaking routine and give you quality time alone together.',
'Sürpriz bir hafta sonu kaçamağıyla ilişkinizi yeniden canlandırın.',
'Revitalize your relationship with a surprise weekend getaway.',
4, 5000, 20000, 1, 2, 14, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['gezi','seyahat','sürpriz','otel','kaçamak','romantik','hafta sonu'], true, false);

-- 30. candlelight-dinner-apology
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_apology, 'candlelight-dinner-apology',
'Mum Işığında Akşam Yemeği Özrü', 'Candlelight Dinner Apology',
'Evde veya özel bir restoranda mum ışığında romantik bir akşam yemeği düzenleyin. Ev versiyonu için: masayı beyaz örtüyle kaplayın, kristal bardaklar kullanın, düzinelerce mum yakın, gül yaprakları serpin. Üç çeşit yemek hazırlayın: başlangıç, ana yemek ve tatlı. Her yemeğin servisinde küçük bir not kartı olsun - birinci tabakta hatanızı kabul eden, ikincisinde onunla birlikte olmanın ne kadar güzel olduğunu anlatan, üçüncüsünde gelecek vaatlerinizi paylaşan. Arka planda caz veya klasik müzik çalsın. Yemekten sonra birlikte dans edin. Bu klasik ama zarif akşam, sözlerinize romantik bir çerçeve sunacak.',
'Organize a romantic candlelight dinner at home or a special restaurant. For the home version: cover the table with a white cloth, use crystal glasses, light dozens of candles, scatter rose petals. Prepare three courses: appetizer, main course, and dessert. Include a small note card with each course - the first acknowledging your mistake, the second describing how wonderful being with them is, the third sharing your future promises. Play jazz or classical music in the background. Dance together after dinner. This classic yet elegant evening will provide a romantic framework for your words.',
'Mum ışığında zarif bir akşam yemeğiyle klasik ve romantik bir özür.',
'A classic and romantic apology with an elegant candlelight dinner.',
3, 1000, 5000, 1, 2, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['akşam yemeği','mum','romantik','zarif','klasik','restoran','özür'], false, false);

END $$;
