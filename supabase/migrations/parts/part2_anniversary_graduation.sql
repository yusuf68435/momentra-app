-- ==========================================
-- SEED: Part 2 - Anniversary (35) + Graduation (30) Scenarios
-- Total: 65 scenarios
-- ==========================================

DO $$
DECLARE
  cat_anniversary uuid;
  cat_graduation  uuid;
BEGIN

SELECT id INTO cat_anniversary FROM public.categories WHERE slug = 'anniversary';
SELECT id INTO cat_graduation  FROM public.categories WHERE slug = 'graduation';

-- ==========================================
-- ANNIVERSARY - 35 scenarios
-- ==========================================

-- 1. time-capsule-reveal (difficulty 3, both, premium false, featured true)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'time-capsule-reveal',
'Zaman Kapsülü Açılışı', 'Time Capsule Reveal Celebration',
'Düğün gününüzde veya ilişkinizin başında mühürlenmiş bir zaman kapsülünü açma zamanı geldi. Kapsülün içine o dönemden mektuplar, fotoğraflar, küçük hatıra eşyalar ve geleceğe dair hayallerinizi yazmıştınız. Şimdi özel bir akşam yemeği hazırlayın, mumları yakın ve kapsülü birlikte açın. Her bir öğeyi çıkarırken o anın hikayesini anlatın, gülün, belki gözyaşı dökün. Ardından yeni bir kapsül hazırlayıp gelecek yıldönümünüz için mühürleyin. Bu gelenek her yıl tekrarlanabilir ve ilişkinizin büyüme hikayesini somut olarak belgeler.',
'The time has come to open the time capsule sealed on your wedding day or at the start of your relationship. Inside you placed letters, photos, small keepsakes, and dreams for the future. Now prepare a special dinner, light candles, and open the capsule together. As you pull out each item, share the story behind that moment — laugh, and maybe shed a tear. Then prepare a new capsule and seal it for your next anniversary. This tradition can repeat every year and tangibly documents your relationship''s growth story.',
'Yıllar önce mühürlenen zaman kapsülünü birlikte açarak anıları yeniden yaşayın.',
'Relive memories by opening a time capsule sealed years ago together.',
3, 500, 2000, 2, 20, 7, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['zaman kapsülü','anı','nostalji','kutlama','mektup','gelenek'], false, true);

-- 2. star-naming-anniversary (difficulty 2, outdoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'star-naming-anniversary',
'Yıldız Adlandırma Sürprizi', 'Star Naming Anniversary Surprise',
'Sevdiğiniz kişinin adına bir yıldız satın alarak gökyüzünde kalıcı bir iz bırakın. Uluslararası yıldız kayıt hizmetlerinden birini kullanarak sertifika ve yıldız haritası alın. Yıldönümü gecesi şehir ışıklarından uzak bir noktaya gidin, battaniyeler ve sıcak içecekler hazırlayın. Teleskop veya dürbün ile yıldızı bulmaya çalışın. Sertifikayı çerçeveletip hediye edin. Gökyüzüne her baktığında sizin aşkınızı hatırlatan bir yıldız — bu hediye sonsuza dek parlayacak.',
'Leave a permanent mark in the sky by purchasing a star in your loved one''s name. Use an international star registry service to get a certificate and star map. On your anniversary night, drive to a spot far from city lights, prepare blankets and hot drinks. Try to locate the star with a telescope or binoculars. Frame the certificate as a gift. A star that reminds them of your love every time they look at the sky — this gift will shine forever.',
'Sevdiğinizin adına bir yıldız satın alıp gökyüzünde kalıcı bir hediye verin.',
'Buy a star in your loved one''s name for an eternal gift in the sky.',
2, 300, 1500, 2, 4, 5, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['yıldız','gökyüzü','romantik','hediye','gece','sertifika'], false, false);

-- 3. library-hunt-anniversary (difficulty 3, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'library-hunt-anniversary',
'Kütüphanede Aşk Avı', 'Library Love Hunt Anniversary',
'Sevdiğiniz kişinin favori kitapçısında veya kütüphanede romantik bir ipucu avı düzenleyin. Her ipucunu farklı bir kitabın sayfaları arasına gizleyin — her kitap ilişkinizden özel bir anıyı temsil etsin. İpuçları ona raflar arasında bir yolculuğa çıkarsın. Son ipucu onu özel bir bölüme yönlendirsin: orada el yazısıyla bir aşk mektubu ve küçük bir hediye bekliyor olsun. Kütüphane yetkilileriyle önceden koordine edin, belki sessiz bir köşeye çiçekler yerleştirin. Kitap kokusu arasında yaşanan bu sürpriz, entelektüel ruhları derinden etkileyecektir.',
'Organize a romantic clue hunt at your loved one''s favorite bookstore or library. Hide each clue between pages of different books — each book representing a special memory from your relationship. The clues take them on a journey through the shelves. The final clue leads to a special section where a handwritten love letter and a small gift await. Coordinate with library staff beforehand; perhaps place flowers in a quiet corner. This surprise amid the scent of books will deeply touch intellectual souls.',
'Kütüphanede kitap sayfaları arasına gizlenmiş ipuçlarıyla romantik bir av düzenleyin.',
'Organize a romantic hunt with clues hidden between book pages in a library.',
3, 200, 1000, 2, 5, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kütüphane','kitap','ipucu avı','romantik','mektup','entelektüel'], false, false);

-- 4. vinyl-guestbook-anniversary (difficulty 2, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'vinyl-guestbook-anniversary',
'Vinil Plak Misafir Defteri', 'Vinyl Record Guestbook Anniversary',
'Yıldönümü kutlamanızda misafirlerin mesajlarını sıradan bir deftere değil, gerçek bir vinil plak üzerine yazmalarını sağlayın. Özel baskı vinil plak hizmeti veren firmalardan boş veya kişiselleştirilmiş bir plak sipariş edin. Kutlamada her misafir plak üzerine kalıcı kalemle kısa bir mesaj yazsın. Plak aynı zamanda sizin şarkınızı çalabilir — bir yüzünde müzik, diğer yüzünde mesajlar. Kutlamadan sonra bu plağı duvarınıza asın veya pikabınızda çalın. Hem dekoratif hem işlevsel, hem de paha biçilmez bir hatıra.',
'At your anniversary celebration, have guests write their messages not in an ordinary guestbook but on a real vinyl record. Order a blank or personalized record from a custom vinyl pressing service. At the celebration, each guest writes a short message on the record with a permanent marker. The record can also play your song — music on one side, messages on the other. After the celebration, hang it on your wall or play it on your turntable. Both decorative and functional, a priceless keepsake.',
'Yıldönümü kutlamanızda misafirler vinil plak üzerine mesajlarını yazsın.',
'Have guests write anniversary messages on a real vinyl record at your celebration.',
2, 500, 2000, 2, 30, 10, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['vinil','plak','müzik','misafir defteri','hatıra','retro'], false, false);

-- 5. handprint-bowl-anniversary (difficulty 1, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'handprint-bowl-anniversary',
'El İzi Seramik Kase', 'Handprint Ceramic Bowl Anniversary',
'Bir seramik atölyesine gidin ve birlikte el izlerinizi bastığınız özel bir kase yapın. Kaseyi ilişkinizi simgeleyen renklerle boyayın ve fırınlattırın. Bu el izi kasesi mutfağınızda her gün kullanabileceğiniz, aynı zamanda aşkınızın somut bir sembolü olacak. Çocuklarınız varsa onların el izlerini de ekleyerek aile kasesi oluşturabilirsiniz. Atölye deneyiminin kendisi de harika bir aktivite — birlikte çamurla oynamak, gülmek ve yaratmak. Kaseyi her kullandığınızda o güzel günü hatırlayacaksınız.',
'Visit a ceramic workshop and make a special bowl with both of your handprints pressed into it. Paint the bowl in colors that symbolize your relationship and have it fired. This handprint bowl will be something you can use daily in your kitchen while also being a tangible symbol of your love. If you have children, add their handprints to create a family bowl. The workshop experience itself is a wonderful activity — playing with clay together, laughing, and creating. Every time you use the bowl, you''ll remember that beautiful day.',
'Seramik atölyesinde birlikte el izi basarak özel bir kase yapın.',
'Make a special bowl together by pressing your handprints at a ceramic workshop.',
1, 200, 800, 2, 6, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['seramik','el izi','atölye','yaratıcı','hatıra','el yapımı'], false, false);

-- 6. backyard-drive-in (difficulty 3, outdoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'backyard-drive-in',
'Bahçede Açık Hava Sineması', 'Backyard Drive-In Movie Night',
'Bahçenize veya terasınıza bir açık hava sineması kurun. Beyaz çarşaftan veya taşınabilir projeksiyon perdesinden bir ekran oluşturun, projektörü ayarlayın ve tanıştığınız günden bu yana izlediğiniz özel filmleri seçin. Yere yumuşak battaniyeler ve yastıklar serin, patlamış mısır standı hazırlayın, ışık zincirleri ile ortamı süsleyin. Film aralarında ilişkinizden komik ve romantik anları anlatan kısa slayt gösterileri hazırlayın. Arabanızı bahçeye park edip gerçek bir drive-in deneyimi yaratabilirsiniz. Yıldızlar altında, aşkınızın filmini izleyin.',
'Set up an outdoor cinema in your backyard or terrace. Create a screen from a white sheet or portable projection screen, set up the projector, and choose special films you''ve watched since the day you met. Lay soft blankets and pillows on the ground, prepare a popcorn stand, and decorate with string lights. Between films, prepare short slideshows narrating funny and romantic moments from your relationship. Park your car in the backyard for an authentic drive-in experience. Watch the movie of your love under the stars.',
'Bahçenizde açık hava sineması kurarak romantik bir film gecesi düzenleyin.',
'Set up a backyard open-air cinema for a romantic movie night under the stars.',
3, 1000, 4000, 2, 20, 5, 'outdoor', ARRAY['spring','summer'], ARRAY['sinema','açık hava','film','romantik','bahçe','projeksiyon'], false, false);

-- 7. gatsby-themed-party (difficulty 5, indoor, premium true, featured true)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'gatsby-themed-party',
'Gatsby Temalı Yıldönümü Partisi', 'Gatsby Themed Anniversary Party',
'1920''lerin ihtişamını yıldönümünüze taşıyın. Altın ve siyah dekorasyonlar, art deco detaylar, caz müziği ve şampanya kuleleri ile göz kamaştırıcı bir parti düzenleyin. Misafirlerden flapper elbiseler ve smokinlerle gelmelerini isteyin. Giriş kapısına kişiselleştirilmiş bir "Gatsby''nin Malikanesine Hoş Geldiniz" tabelası asın. Canlı caz bandı veya DJ ile charleston dansı öğrenin. Kokteyl barında dönemin klasik içeceklerini servis edin. Photo booth köşesinde tüylü şapkalar ve inci kolyelerle fotoğraf çekin. Bu gösterişli gece, yıldönümünüzü efsanevi bir kutlamaya dönüştürecek.',
'Bring the glamour of the 1920s to your anniversary. Organize a dazzling party with gold and black decorations, art deco details, jazz music, and champagne towers. Ask guests to come in flapper dresses and tuxedos. Hang a personalized "Welcome to Gatsby''s Mansion" sign at the entrance. Learn the Charleston dance with a live jazz band or DJ. Serve classic period cocktails at the cocktail bar. Take photos with feathered hats and pearl necklaces at the photo booth corner. This spectacular night will turn your anniversary into a legendary celebration.',
'1920''ler temalı gösterişli bir Gatsby partisi ile yıldönümünüzü kutlayın.',
'Celebrate your anniversary with a glamorous 1920s Gatsby-themed party.',
5, 15000, 50000, 10, 100, 30, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['gatsby','parti','1920ler','caz','lüks','tema','dekorasyon'], true, true);

-- 8. decade-photo-recreation (difficulty 2, both, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'decade-photo-recreation',
'On Yıllık Fotoğraf Canlandırma', 'Decade Photo Recreation Anniversary',
'İlişkinizin her yılından bir fotoğraf seçin ve aynı pozları, aynı mekanlarda yeniden canlandırın. İlk buluşma restoranınız, tatil fotoğrafınız, düğün pozunuz — hepsini bugünkü halinizle tekrarlayın. Profesyonel bir fotoğrafçı tutarak bu karşılaştırmalı fotoğrafları çekin. Sonra "O Zaman ve Şimdi" temalı bir fotoğraf albümü veya duvar kolajı hazırlayın. Değişen saç stilleri, kıyafetler ve çevreler komik anlar yaratırken, değişmeyen sevginiz duygu dolu kareler oluşturacak. Her fotoğrafın altına o anın hikayesini yazın.',
'Select a photo from each year of your relationship and recreate the same poses in the same locations. Your first date restaurant, vacation photo, wedding pose — repeat them all with your current selves. Hire a professional photographer to capture these comparison shots. Then create a "Then and Now" themed photo album or wall collage. While changing hairstyles, outfits, and surroundings create funny moments, your unchanged love will create emotion-filled frames. Write the story of each moment beneath each photo.',
'İlişkinizin her yılından fotoğrafları aynı mekanlarda yeniden canlandırın.',
'Recreate photos from each year of your relationship in the same locations.',
2, 500, 3000, 2, 4, 10, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['fotoğraf','anı','nostalji','canlandırma','albüm','karşılaştırma'], false, false);

-- 9. korean-100-days (difficulty 2, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'korean-100-days',
'Kore Usulü 100. Gün Kutlaması', 'Korean Style 100th Day Celebration',
'Kore kültüründen ilham alarak ilişkinizin 100. gününü özel bir şekilde kutlayın. Geleneksel Kore yemekleri hazırlayın veya bir Kore restoranına gidin. Birbirinize "100 Sebep Neden Seni Seviyorum" listesi yazın. Eşleşen kıyafetler giyin — Kore''de çiftler bunu sıkça yapar. Birbirinize küçük ama anlamlı hediyeler verin: yüzük, bileklik veya kişiselleştirilmiş telefon kılıfı. Gün boyunca 100 küçük not bırakın — çantasında, cüzdanında, arabada. K-drama izleyerek geceyi tamamlayın. Her 100 günde bu geleneği sürdürün.',
'Celebrate the 100th day of your relationship in a special way inspired by Korean culture. Prepare traditional Korean dishes or visit a Korean restaurant. Write each other a "100 Reasons Why I Love You" list. Wear matching outfits — couples in Korea do this frequently. Give each other small but meaningful gifts: rings, bracelets, or personalized phone cases. Leave 100 small notes throughout the day — in their bag, wallet, car. Complete the night watching K-dramas. Continue this tradition every 100 days.',
'Kore geleneğiyle ilişkinizin 100. gününü özel olarak kutlayın.',
'Celebrate the 100th day of your relationship with Korean cultural traditions.',
2, 300, 1500, 2, 4, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kore','100.gün','gelenek','eşleşen kıyafet','romantik','liste'], false, false);

-- 10. couple-ring-ceremony (difficulty 3, both, premium true, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'couple-ring-ceremony',
'Çift Yüzüğü Töreni', 'Couple Ring Ceremony Anniversary',
'Yıldönümünüzde özel tasarım çift yüzükleri takarak bağlılığınızı yenileyin. Bir kuyumcuyla çalışarak ilişkinizi simgeleyen benzersiz yüzükler tasarlayın — belki iç kısmına özel bir tarih veya mesaj kazıtın. Küçük ama samimi bir tören düzenleyin: mumlar, çiçekler ve en yakın arkadaşlarınız eşliğinde birbirinize yüzükleri takın. Kendi yazdığınız yeminleri okuyun. Bu tören düğün yemini yenileme kadar gösterişli olmak zorunda değil — samimi, kişisel ve anlamlı olsun. Yüzükler her gün taşıdığınız, aşkınızın somut sembolü olacak.',
'Renew your commitment on your anniversary by exchanging custom-designed couple rings. Work with a jeweler to design unique rings symbolizing your relationship — perhaps engrave a special date or message inside. Organize a small but heartfelt ceremony: exchange rings accompanied by candles, flowers, and your closest friends. Read vows you wrote yourselves. This ceremony doesn''t have to be as grand as a vow renewal — let it be intimate, personal, and meaningful. The rings will become tangible symbols of your love that you carry every day.',
'Özel tasarım çift yüzükleri ile bağlılığınızı yenileyen samimi bir tören düzenleyin.',
'Hold an intimate ceremony renewing your commitment with custom couple rings.',
3, 3000, 15000, 2, 20, 14, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['yüzük','tören','bağlılık','kuyumcu','yemin','tasarım'], true, false);

-- 11. love-letter-chain (difficulty 1, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'love-letter-chain',
'Aşk Mektubu Zinciri', 'Love Letter Chain Anniversary',
'Yıldönümünüzden bir ay önce her gün sevdiğinize bir aşk mektubu yazın ve numaralı zarflara koyun. Her mektup farklı bir temayı işlesin: ilk tanışma, ilk öpücük, en komik anınız, en zor dönemde nasıl güçlendiğiniz, gelecek hayalleriniz. Zarfları güzel bir kutuda veya cam kavanozda biriktirin. Yıldönümü günü bu kutuyu hediye edin — 30 gün boyunca her gün bir zarf açsın. Alternatif olarak tüm mektupları yıldönümü gecesi birlikte okuyun. El yazısı mektuplar dijital çağda paha biçilmez. Parfümünüzü zarflara sıkarak duyusal bir deneyim ekleyin.',
'Write a love letter to your partner every day for a month before your anniversary, placing them in numbered envelopes. Each letter covers a different theme: first meeting, first kiss, funniest moment, how you grew stronger during tough times, future dreams. Collect the envelopes in a beautiful box or glass jar. On your anniversary, gift this box — they open one envelope each day for 30 days. Alternatively, read all letters together on anniversary night. Handwritten letters are priceless in the digital age. Spray your perfume on the envelopes for a sensory experience.',
'Yıldönümünüzden önce her gün bir aşk mektubu yazarak 30 mektupluk koleksiyon oluşturun.',
'Write a love letter every day before your anniversary to create a 30-letter collection.',
1, 100, 500, 2, 2, 30, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['mektup','aşk','el yazısı','romantik','hediye','gelenek'], false, false);

-- 12. love-jar-365 (difficulty 2, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'love-jar-365',
'365 Günlük Aşk Kavanozu', '365 Day Love Jar Anniversary',
'Büyük bir cam kavanoz alın ve 365 adet renkli kağıda sevdiğiniz kişiyle ilgili bir anı, bir neden, bir teşekkür veya bir dilek yazın. Her günü temsil eden bu notlar farklı renk kağıtlara yazılabilir: pembe aşk notları, mavi anılar, yeşil teşekkürler, sarı gelecek dilekleri. Kavanozu güzel bir kurdele ile süsleyin. Yıldönümünüzde bu kavanozu hediye edin — her gün bir not çekerek bir yıl boyunca her gün küçük bir sürpriz yaşasın. Bu hediye hem ekonomik hem son derece kişisel ve duygusal bir armağandır.',
'Get a large glass jar and write a memory, a reason, a thank you, or a wish about your loved one on 365 colored papers. These notes representing each day can be written on different colored papers: pink love notes, blue memories, green thank-yous, yellow future wishes. Decorate the jar with a beautiful ribbon. Gift this jar on your anniversary — they pull one note each day for a small surprise every day for a year. This gift is both economical and an extremely personal and emotional present.',
'365 renkli kağıda yazılmış notlarla dolu bir aşk kavanozu hediye edin.',
'Gift a love jar filled with 365 notes written on colored papers.',
2, 100, 400, 2, 2, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kavanoz','not','365 gün','romantik','hediye','el yapımı'], false, false);

-- 13. star-map-gift (difficulty 1, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'star-map-gift',
'Yıldız Haritası Hediyesi', 'Star Map Gift Anniversary',
'Tanıştığınız veya evlendiğiniz gecenin gökyüzü haritasını kişiselleştirilmiş bir poster olarak bastırın. Online yıldız haritası servisleri belirli bir tarih, saat ve konumdaki yıldız dizilimini gösterir. Posterın altına özel bir mesaj, tarihiniz ve koordinatlarınızı ekleyin. Şık bir çerçeveye koyup yıldönümü hediyesi olarak sunun. Bu minimalist ve zarif hediye evinizin duvarını süslerken aynı zamanda en özel gecenizin gökyüzünü sonsuza dek saklayacak. Birden fazla önemli tarih için yan yana haritalar da oluşturabilirsiniz.',
'Print a personalized poster of the night sky on the night you met or married. Online star map services show the star alignment at a specific date, time, and location. Add a special message, your date, and coordinates below the poster. Present it in a stylish frame as an anniversary gift. This minimalist and elegant gift will adorn your wall while preserving the sky of your most special night forever. You can also create side-by-side maps for multiple important dates.',
'Tanıştığınız gecenin gökyüzü haritasını kişisel bir poster olarak bastırın.',
'Print the night sky map from when you met as a personalized poster.',
1, 200, 800, 2, 2, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['yıldız haritası','poster','hediye','kişisel','dekorasyon','minimalist'], false, false);

-- 14. bungalow-escape (difficulty 3, outdoor, premium true, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'bungalow-escape',
'Doğada Bungalov Kaçamağı', 'Nature Bungalow Escape Anniversary',
'Yıldönümünüz için şehirden uzak, doğayla iç içe bir bungalov kiralayın. Ormanlık bir alanda, göl kenarında veya dağ yamacında huzurlu bir kaçamak planlayın. Bungalova varmadan önce içeriyi çiçekler, mumlar ve ışık zincirleriyle süsleyin. Şöminede ateş yakın, birlikte yemek pişirin, yıldızları izleyin. Sabah kuş sesleriyle uyanın, doğa yürüyüşüne çıkın. Telefonları kapatın ve sadece birbirinize odaklanın. İki gece kalarak günlük rutinden tamamen kopun. Bu kaçamak ilişkinizi yeniden şarj edecek, ilk günlerdeki heyecanı hatırlatacak.',
'Rent a bungalow immersed in nature, away from the city, for your anniversary. Plan a peaceful getaway in a forested area, by a lake, or on a mountain slope. Before arriving, decorate the interior with flowers, candles, and string lights. Light a fire in the fireplace, cook together, watch the stars. Wake up to birdsong in the morning, go on a nature hike. Turn off your phones and focus only on each other. Stay two nights to completely disconnect from daily routine. This getaway will recharge your relationship and remind you of the excitement from early days.',
'Doğada huzurlu bir bungalovda romantik bir yıldönümü kaçamağı planlayın.',
'Plan a romantic anniversary getaway at a peaceful bungalow in nature.',
3, 3000, 10000, 2, 4, 14, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['bungalov','doğa','kaçamak','romantik','tatil','şömine'], true, false);

-- 15. cooking-together-anniversary (difficulty 1, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'cooking-together-anniversary',
'Birlikte Yemek Pişirme Gecesi', 'Cooking Together Anniversary Night',
'Yıldönümünüzü dışarıda yemek yerine evde birlikte özel bir menü hazırlayarak kutlayın. İlk buluşmanızda yediğiniz yemeği veya balayınızdaki mutfağı yeniden yaratın. Malzemeleri birlikte alışveriş yaparak temin edin. Mutfakta eşleşen önlükler giyin, romantik bir playlist açın, şarap eşliğinde pişirin. Masayı mumlar ve çiçeklerle süsleyin, en güzel tabaklarınızı çıkarın. Yemeği birlikte hazırlamanın verdiği keyif, restorandan çok daha özel bir deneyim yaratır. Tatlı olarak birlikte pasta yapın ve üzerine yıldönümü mesajı yazın.',
'Celebrate your anniversary by preparing a special menu together at home instead of dining out. Recreate the dish from your first date or the cuisine from your honeymoon. Get ingredients by shopping together. Wear matching aprons in the kitchen, play a romantic playlist, cook with wine. Set the table with candles and flowers, bring out your finest dishes. The joy of preparing food together creates a much more special experience than a restaurant. For dessert, bake a cake together and write an anniversary message on it.',
'Evde birlikte özel bir menü hazırlayarak romantik bir yıldönümü geçirin.',
'Spend a romantic anniversary cooking a special menu together at home.',
1, 200, 1000, 2, 4, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['yemek','pişirme','ev','romantik','birlikte','mutfak'], false, false);

-- 16. dance-lesson-surprise (difficulty 2, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'dance-lesson-surprise',
'Sürpriz Dans Dersi', 'Surprise Dance Lesson Anniversary',
'Sevdiğiniz kişiyi habersiz bir dans dersine götürün. Tango, salsa, vals veya bachata — ilişkinizin enerjisine uygun bir dans stili seçin. Özel ders ayarlayarak sadece ikinize özel bir deneyim yaşayın. Dans eğitmeni size temel adımları öğretirken birlikte gülecek, hata yapacak ve yakınlaşacaksınız. Dersten sonra öğrendiğiniz dansı evde pratik edin — bu yeni ortak hobiniz olabilir. Haftalık dans derslerine kaydolarak bu sürprizi devam eden bir hediyeye dönüştürün. Dans, iletişim ve güven gibi ilişki becerilerini de güçlendirir.',
'Take your loved one to an unexpected dance lesson. Tango, salsa, waltz, or bachata — choose a dance style that matches your relationship''s energy. Arrange a private lesson for an experience just for the two of you. As the dance instructor teaches you basic steps, you''ll laugh together, make mistakes, and grow closer. After the lesson, practice your dance at home — this could become your new shared hobby. Turn this surprise into an ongoing gift by enrolling in weekly dance classes. Dancing also strengthens relationship skills like communication and trust.',
'Sevdiğinizi sürpriz bir dans dersine götürerek birlikte yeni bir hobi başlatın.',
'Start a new hobby together by taking your loved one to a surprise dance lesson.',
2, 500, 2000, 2, 4, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['dans','ders','tango','salsa','hobi','birlikte'], false, false);

-- 17. sunset-cruise-anniversary (difficulty 4, outdoor, premium true, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'sunset-cruise-anniversary',
'Gün Batımı Tekne Turu', 'Sunset Cruise Anniversary Celebration',
'Yıldönümünüzü denizde gün batımını izleyerek kutlayın. Özel bir tekne veya yat kiralayın, güvertede çiçekler ve mumlar hazırlayın. Kaptan rotayı en güzel gün batımı noktasına ayarlasın. Tekne üzerinde özel bir akşam yemeği servisi düzenleyin — taze deniz ürünleri, şampanya ve çikolatalı tatlılar. Gün batımının altın ışığında kadeh kaldırın ve birbirinizin gözlerinin içine bakın. Profesyonel bir fotoğrafçı bu anları ölümsüzleştirsin. Dönüş yolunda yıldızları izleyin ve denizin sakinleştirici sesini dinleyin. Bu deneyim hayatınızın en romantik akşamlarından biri olacak.',
'Celebrate your anniversary watching the sunset at sea. Rent a private boat or yacht, prepare flowers and candles on deck. Have the captain set course to the best sunset viewpoint. Arrange a special dinner service on the boat — fresh seafood, champagne, and chocolate desserts. Toast under the golden light of sunset and gaze into each other''s eyes. Have a professional photographer immortalize these moments. Watch the stars on the way back and listen to the calming sound of the sea. This experience will be one of the most romantic evenings of your life.',
'Özel bir teknede gün batımını izleyerek unutulmaz bir yıldönümü yaşayın.',
'Experience an unforgettable anniversary watching the sunset on a private boat.',
4, 5000, 20000, 2, 10, 10, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['tekne','gün batımı','deniz','romantik','lüks','akşam yemeği'], true, false);

-- 18. wine-tasting-anniversary (difficulty 2, both, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'wine-tasting-anniversary',
'Şarap Tadım Deneyimi', 'Wine Tasting Anniversary Experience',
'Yıldönümünüzü bir bağ evinde veya butik şaraphane'de şarap tadım etkinliğiyle kutlayın. Önceden rezervasyon yaparak özel bir tadım deneyimi ayarlayın. Sommelier eşliğinde farklı şarapları tadın, her birinin hikayesini dinleyin ve eşleştirme peynirlerini keşfedin. İlişkinizin her yılını temsil eden şarapları seçin — örneğin evlendiğiniz yılın mahsulünden bir şişe. Tadım sonunda favori şarabınızdan birkaç şişe alıp eve götürün. Bağ arasında romantik bir yürüyüş yapın, üzüm bağlarında fotoğraflar çekin. Bu sofistike deneyim hem damak zevkinizi hem ilişkinizi zenginleştirecek.',
'Celebrate your anniversary with a wine tasting event at a vineyard or boutique winery. Make reservations in advance for a private tasting experience. Taste different wines with a sommelier, hear the story behind each one, and discover pairing cheeses. Select wines representing each year of your relationship — for example, a bottle from the vintage of your wedding year. Take a few bottles of your favorite wine home after the tasting. Take a romantic walk through the vineyard and snap photos among the grapevines. This sophisticated experience will enrich both your palate and your relationship.',
'Bir bağ evinde şarap tadım deneyimi ile sofistike bir yıldönümü kutlayın.',
'Celebrate with a sophisticated wine tasting experience at a vineyard.',
2, 1000, 4000, 2, 10, 5, 'both', ARRAY['spring','summer','fall'], ARRAY['şarap','tadım','bağ','romantik','sofistike','sommelier'], false, false);

-- 19. memory-book-anniversary (difficulty 2, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'memory-book-anniversary',
'Anı Kitabı Sürprizi', 'Memory Book Anniversary Surprise',
'İlişkinizin tüm önemli anlarını içeren profesyonel bir anı kitabı hazırlayın. Online fotoğraf kitabı servislerini kullanarak kronolojik bir albüm oluşturun. Her sayfaya fotoğrafların yanı sıra o anın hikayesini, tarihini ve duygularınızı yazın. Arkadaşlarınızdan ve ailenizden gizlice mesajlar toplayarak kitaba ekleyin. Kapak tasarımını kişiselleştirin — isimleriniz, tarihiniz ve özel bir alıntı. Kitabı lüks bir hediye kutusunda, çiçeklerle birlikte sunun. Bu kitap yıllar geçtikçe değeri artan, her açıldığında gülümseten bir hazine olacak.',
'Prepare a professional memory book containing all the important moments of your relationship. Create a chronological album using online photo book services. On each page, alongside photos, write the story of that moment, the date, and your feelings. Secretly collect messages from your friends and family to add to the book. Customize the cover design — your names, date, and a special quote. Present the book in a luxury gift box with flowers. This book will be a treasure that increases in value over the years and brings smiles every time it''s opened.',
'İlişkinizin tüm önemli anlarını içeren profesyonel bir anı kitabı hazırlayın.',
'Prepare a professional memory book containing all important moments of your relationship.',
2, 300, 1500, 2, 2, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['anı kitabı','fotoğraf','albüm','hediye','kişisel','hikaye'], false, false);

-- 20. second-honeymoon-reveal (difficulty 4, both, premium true, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'second-honeymoon-reveal',
'İkinci Balayı Açıklaması', 'Second Honeymoon Reveal Anniversary',
'Yıldönümünüzde sevdiğinize ikinci bir balayı tatili sürprizi yapın. Tatil planını tamamen gizli tutun — pasaport, bavul ve biletleri önceden hazırlayın. Yıldönümü günü zarif bir kutu içinde uçak biletlerini veya otel rezervasyonunu sunun. Balayınızda gittiğiniz yere tekrar gidebilir veya hayalini kurduğunuz yeni bir destinasyon seçebilirsiniz. Kutu içine destinasyonla ilgili ipuçları koyun: harita, yerel para birimi, o ülkenin bayrağı. Açıklama anını videoya kaydedin. İkinci balayı ilişkinizi yenileyecek, günlük stresten uzaklaştıracak ve yeni anılar biriktirmenizi sağlayacak.',
'Surprise your loved one with a second honeymoon trip on your anniversary. Keep the vacation plan completely secret — prepare passport, luggage, and tickets in advance. On your anniversary day, present the plane tickets or hotel reservation in an elegant box. You can revisit where you went on your honeymoon or choose a new dream destination. Put destination-related clues in the box: a map, local currency, the country''s flag. Record the reveal moment on video. The second honeymoon will renew your relationship, distance you from daily stress, and let you collect new memories.',
'Yıldönümünüzde ikinci balayı tatili sürprizi yaparak ilişkinizi yenileyin.',
'Renew your relationship with a second honeymoon trip surprise on your anniversary.',
4, 10000, 50000, 2, 2, 30, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['balayı','tatil','seyahat','sürpriz','uçak','destinasyon'], true, false);

-- 21. renewal-vows-ceremony (difficulty 4, outdoor, premium true, featured true)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'renewal-vows-ceremony',
'Nikah Yemini Yenileme Töreni', 'Vow Renewal Ceremony Anniversary',
'Yıldönümünüzde nikah yeminlerinizi yenileyerek aşkınızı bir kez daha ilan edin. Düğününüzden farklı, daha samimi ve kişisel bir tören planlayın. Açık havada — bahçede, sahilde veya dağ tepesinde — küçük bir platform hazırlayın. Çiçek kemeri altında, sadece en yakınlarınızla birlikte yeni yeminlerinizi okuyun. Bu kez yeminler gerçek deneyimlerinizden, aştığınız zorluklardan ve büyüyen sevginizden ilham alsın. Profesyonel fotoğrafçı ve videograf ile anı ölümsüzleştirin. Tören sonrası intimate bir kokteyl resepsiyonu düzenleyin. Bu deneyim evliliğinize yeni bir sayfa açacak.',
'Declare your love once again by renewing your wedding vows on your anniversary. Plan a ceremony different from your wedding — more intimate and personal. Outdoors — in a garden, at the beach, or on a mountaintop — set up a small platform. Under a flower arch, with only your closest ones, read your new vows. This time let the vows be inspired by real experiences, challenges you''ve overcome, and your growing love. Immortalize the moment with a professional photographer and videographer. Host an intimate cocktail reception after the ceremony. This experience will open a new chapter in your marriage.',
'Nikah yeminlerinizi yenileyerek aşkınızı bir kez daha ilan edin.',
'Declare your love once again by renewing your wedding vows.',
4, 5000, 25000, 2, 50, 30, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['yemin yenileme','tören','nikah','düğün','romantik','açık hava'], true, true);

-- 22. private-chef-dinner (difficulty 3, indoor, premium true, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'private-chef-dinner',
'Özel Şef Akşam Yemeği', 'Private Chef Dinner Anniversary',
'Evinize profesyonel bir şef davet ederek lüks bir restoran deneyimini salonunuza taşıyın. Şefle önceden menüyü planlayın — sevdiğiniz mutfaktan 4-5 çeşit yemek, her biriyle uyumlu şarap eşleştirmesi. Şef mutfağınızda pişirirken siz oturma odanızda müzik eşliğinde keyif sürün. Her tabak şefin sunumuyla masanıza gelsin, yemeğin hikayesini anlatsın. Masayı önceden çiçekler, mumlar ve özel peçetelerle süsleyin. Evin konforunda, dışarı çıkmadan, kuyruk beklemeden tam bir fine dining deneyimi. Bu gece sadece damak zevkinizi değil, ilişkinizi de besleyecek.',
'Invite a professional chef to your home and bring the luxury restaurant experience to your living room. Plan the menu with the chef in advance — 4-5 courses from your favorite cuisine, each with wine pairing. While the chef cooks in your kitchen, enjoy music in your living room. Each plate arrives at your table with the chef''s presentation as they tell the dish''s story. Decorate the table beforehand with flowers, candles, and special napkins. A complete fine dining experience in the comfort of your home, without going out or waiting in line. This night will nourish not just your palate but your relationship.',
'Evinize özel şef davet ederek lüks bir fine dining deneyimi yaşayın.',
'Experience luxury fine dining at home by inviting a private chef.',
3, 3000, 10000, 2, 8, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['şef','yemek','fine dining','lüks','ev','şarap'], true, false);

-- 23. photo-calendar-anniversary (difficulty 1, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'photo-calendar-anniversary',
'Fotoğraflı Takvim Hediyesi', 'Photo Calendar Anniversary Gift',
'İlişkinizden en güzel 12 fotoğrafı seçerek kişiselleştirilmiş bir takvim bastırın. Her ay farklı bir anınızı temsil etsin — Ocak ilk buluşma, Şubat Sevgililer Günü anısı, Haziran tatil fotoğrafı gibi. Her ayın sayfasına kısa bir not veya alıntı ekleyin. Önemli tarihleri işaretleyin: tanışma günü, ilk öpücük, düğün tarihi. Doğum günleri ve yıldönümleri zaten takvimde hazır olsun. Online fotoğraf baskı servislerinden kolayca sipariş edebilirsiniz. Bu hediye hem pratik hem duygusal — her gün duvarda sizin aşkınızı hatırlatacak.',
'Select the 12 most beautiful photos from your relationship to print a personalized calendar. Each month represents a different memory — January the first date, February a Valentine''s Day memory, June a vacation photo. Add a short note or quote to each month''s page. Mark important dates: the day you met, first kiss, wedding date. Birthdays and anniversaries are already prepared in the calendar. You can easily order from online photo printing services. This gift is both practical and emotional — it will remind of your love on the wall every day.',
'İlişkinizden 12 fotoğrafla kişiselleştirilmiş bir yıllık takvim bastırın.',
'Print a personalized annual calendar with 12 photos from your relationship.',
1, 100, 400, 2, 2, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['takvim','fotoğraf','hediye','kişisel','pratik','yıllık'], false, false);

-- 24. spa-weekend-anniversary (difficulty 2, indoor, premium true, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'spa-weekend-anniversary',
'Spa Hafta Sonu Kaçamağı', 'Spa Weekend Anniversary Getaway',
'Yıldönümünüzü lüks bir spa otelinde geçirerek hem bedeninizi hem ilişkinizi yenileyin. Çift masajı, hamam, sauna, yüz bakımı ve jakuzi içeren bir paket rezerve edin. Spa deneyiminden önce odanıza çiçekler, şampanya ve çikolata hazırlattırın. Birlikte termal havuzlarda dinlenin, aromaterapi seanslarına katılın. Stresli günlük hayattan tamamen koparak sadece birbirinize ve kendinize odaklanın. Akşam spa otelin restoranında özel bir yıldönümü yemeği yiyin. Pazar günü geç kalkın, kahvaltıyı yatakta yapın. Bu kaçamak hem fiziksel hem ruhsal olarak sizi yenileyecek.',
'Renew both your body and relationship by spending your anniversary at a luxury spa hotel. Reserve a package including couples massage, hammam, sauna, facial treatment, and jacuzzi. Have flowers, champagne, and chocolate prepared in your room before the spa experience. Relax together in thermal pools, attend aromatherapy sessions. Completely disconnect from stressful daily life and focus only on each other and yourselves. Have a special anniversary dinner at the spa hotel''s restaurant in the evening. Sleep in on Sunday, have breakfast in bed. This getaway will renew you both physically and spiritually.',
'Lüks bir spa otelinde çift masajı ve termal deneyimlerle yıldönümünüzü kutlayın.',
'Celebrate your anniversary with couples massage and thermal experiences at a luxury spa.',
2, 3000, 12000, 2, 2, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['spa','masaj','wellness','lüks','kaçamak','termal'], true, false);

-- 25. constellation-projector (difficulty 1, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'constellation-projector',
'Yıldız Projektörü Romantik Gece', 'Constellation Projector Romantic Night',
'Yatak odanızı bir planetaryuma dönüştürün. Galaxy projektör veya yıldız projektörü satın alarak tavan ve duvarları yıldızlarla kaplayın. Yatağı yere indirin, etrafına yastıklar ve battaniyeler serin. Projektörü açın, ışıkları kapatın ve birlikte takımyıldızlarını keşfedin. Her takımyıldızının mitolojik hikayesini birbirinize anlatın. Yumuşak müzik eşliğinde yıldızların altında uzanın. Birbirinize gelecek hayallerinizi fısıldayın. Bu basit ama etkili sürpriz her yıldönümünde tekrarlanabilir — her seferinde farklı bir gökyüzü projeksiyonu seçerek yeni bir deneyim yaratın.',
'Transform your bedroom into a planetarium. Buy a galaxy projector or star projector to cover the ceiling and walls with stars. Lower the bed to the floor, surround it with pillows and blankets. Turn on the projector, switch off the lights, and discover constellations together. Tell each other the mythological stories of each constellation. Lie under the stars with soft music playing. Whisper your future dreams to each other. This simple yet impactful surprise can be repeated every anniversary — create a new experience each time by choosing a different sky projection.',
'Yatak odanızı yıldız projektörüyle planetaryuma çevirerek romantik bir gece geçirin.',
'Turn your bedroom into a planetarium with a star projector for a romantic night.',
1, 100, 500, 2, 2, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['projektör','yıldız','romantik','gece','yatak odası','galaksi'], false, false);

-- 26. love-lock-bridge (difficulty 2, outdoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'love-lock-bridge',
'Aşk Kilidi Köprüsü Ritüeli', 'Love Lock Bridge Anniversary Ritual',
'Paris''in ünlü geleneğinden ilham alarak kendi aşk kilidi ritüelinizi oluşturun. Güzel bir asma kilit satın alın ve üzerine isimlerinizi ve tarihinizi kazıtın. Şehrinizde romantik bir köprü veya iskele bulun. Yıldönümü günü oraya birlikte gidin, kilidi takın ve anahtarı suya atın. Bu sembolik jest aşkınızın sonsuza dek kilitli kalacağını simgeler. Öncesinde köprüye giden yolda küçük notlar bırakarak bir mini ipucu avı oluşturun. Kilidi taktıktan sonra yanında çekilmiş fotoğrafı çerçeveletin. Her yıl aynı köprüye yeni bir kilit ekleyerek geleneği sürdürün.',
'Create your own love lock ritual inspired by Paris''s famous tradition. Buy a beautiful padlock and engrave your names and date on it. Find a romantic bridge or pier in your city. On your anniversary, go there together, attach the lock, and throw the key into the water. This symbolic gesture represents your love being locked forever. Create a mini clue hunt by leaving small notes along the path to the bridge. After attaching the lock, frame a photo taken beside it. Continue the tradition by adding a new lock to the same bridge every year.',
'Romantik bir köprüye isimlerinizi kazıtılmış bir aşk kilidi takarak aşkınızı mühürleyin.',
'Seal your love by attaching an engraved love lock to a romantic bridge.',
2, 100, 500, 2, 4, 3, 'outdoor', ARRAY['spring','summer','fall','winter'], ARRAY['aşk kilidi','köprü','ritüel','romantik','gelenek','sembol'], false, false);

-- 27. message-bottle-anniversary (difficulty 2, outdoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'message-bottle-anniversary',
'Şişede Mesaj Sürprizi', 'Message in a Bottle Anniversary',
'Romantik filmlerdeki gibi cam bir şişenin içine aşk mektubu koyarak sürpriz yapın. Güzel bir cam şişe bulun, içine el yazısıyla kaleme aldığınız aşk mektubunu rulo yaparak yerleştirin. Mektubu antik görünümlü kağıda yazın, balmumu mühürle kapatın. Şişeyi sahilde, göl kenarında veya özel bir mekanda birlikte bulun — önceden oraya gizlice bırakın veya bir arkadaşınıza emanet edin. Keşif anını doğal gösterin. Mektubun içinde gelecek yıllar için vaatler, hayaller ve planlar olsun. Bu nostaljik ve romantik jest basit ama unutulmazdır.',
'Create a surprise by putting a love letter in a glass bottle just like in romantic movies. Find a beautiful glass bottle, roll up your handwritten love letter and place it inside. Write the letter on antique-looking paper, seal with a wax stamp. Find the bottle together at the beach, lakeside, or a special location — secretly leave it there beforehand or entrust it to a friend. Make the discovery moment look natural. Include promises, dreams, and plans for future years in the letter. This nostalgic and romantic gesture is simple but unforgettable.',
'Cam şişeye el yazısı aşk mektubu koyarak romantik bir sürpriz hazırlayın.',
'Prepare a romantic surprise with a handwritten love letter in a glass bottle.',
2, 100, 500, 2, 4, 3, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['şişe','mesaj','mektup','romantik','sahil','nostaljik'], false, false);

-- 28. first-date-recreation (difficulty 3, both, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'first-date-recreation',
'İlk Buluşmayı Yeniden Yaşama', 'First Date Recreation Anniversary',
'Yıldönümünüzde ilk buluşmanızı en ince ayrıntısına kadar yeniden canlandırın. Aynı restoran, aynı yemek, mümkünse aynı masa. O gün giydiğiniz kıyafetlere benzer giysiler seçin. Aynı konuları konuşun, aynı soruları sorun — ama bu kez cevapları bilmenin verdiği gülümsemeyle. İlk buluşmadan sonra ne yaptıysanız onu yapın: sinemaya gittiyseniz aynı türde film izleyin, yürüyüş yaptıysanız aynı rotayı yürüyün. O günden bu güne ne kadar değiştiğinizi ve ne kadar aynı kaldığınızı fark etmek duygusal bir deneyim olacak. Akşamı "tekrar tanışma" oyunuyla tamamlayın.',
'Recreate your first date in every detail on your anniversary. The same restaurant, same food, same table if possible. Choose clothes similar to what you wore that day. Talk about the same topics, ask the same questions — but this time with a smile from knowing the answers. Whatever you did after the first date, do it again: if you went to the movies, watch a similar film; if you took a walk, walk the same route. Realizing how much you''ve changed and how much you''ve stayed the same will be an emotional experience. End the evening with a "meeting again" role-play.',
'İlk buluşmanızı aynı mekan ve detaylarla yeniden canlandırarak nostalji yaşayın.',
'Relive nostalgia by recreating your first date with the same venue and details.',
3, 500, 3000, 2, 4, 5, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['ilk buluşma','nostalji','canlandırma','romantik','anı','restoran'], false, false);

-- 29. custom-board-game-anniversary (difficulty 3, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'custom-board-game-anniversary',
'Kişisel Kutu Oyunu Sürprizi', 'Custom Board Game Anniversary Surprise',
'İlişkinizin hikayesini anlatan tamamen özel bir kutu oyunu tasarlayın. Oyun tahtası ilişkinizin kronolojik yolculuğunu temsil etsin — başlangıç noktası tanışma günü, bitiş noktası şimdiki an. Arada uğranacak kareler önemli anılarınız olsun: ilk öpücük, ilk tatil, zorluklar, komik anlar. Şans ve bilgi kartları hazırlayın: "Partnerinin en sevdiği yemek nedir?" gibi sorular. Özel zar, piyon ve kurallar oluşturun. El yapımı olabilir veya online özel oyun baskı servislerini kullanabilirsiniz. Bu oyunu her yıldönümünde çıkarıp oynamak güzel bir gelenek olacak.',
'Design a completely custom board game that tells the story of your relationship. The game board represents the chronological journey of your relationship — starting point is the day you met, ending point is the present. Squares along the way are your important memories: first kiss, first vacation, challenges, funny moments. Prepare chance and trivia cards: questions like "What is your partner''s favorite food?" Create custom dice, pawns, and rules. It can be handmade or you can use online custom game printing services. Playing this game every anniversary will become a beautiful tradition.',
'İlişkinizin hikayesini anlatan özel bir kutu oyunu tasarlayarak sürpriz yapın.',
'Surprise with a custom board game that tells the story of your relationship.',
3, 200, 1500, 2, 6, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kutu oyunu','tasarım','yaratıcı','kişisel','eğlenceli','el yapımı'], false, false);

-- 30. rooftop-stargazing-anniversary (difficulty 3, outdoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'rooftop-stargazing-anniversary',
'Çatı Katında Yıldız Gözlemi', 'Rooftop Stargazing Anniversary Night',
'Binanızın çatısını veya güzel manzaralı bir teras barı romantik bir yıldız gözlem alanına dönüştürün. Zemine kalın battaniyeler ve yastıklar serin, etrafına LED mumlar dizin. Bir teleskop kiralayın veya dürbün hazırlayın. Sıcak çikolata, şarap ve peynir tabağı hazırlayın. Gökyüzü haritası uygulaması indirerek birlikte takımyıldızlarını tanımlayın. Kayan yıldız görürseniz dilek tutun. Karanlıkta birbirinize ilişkinizle ilgili hiç söylemediğiniz şeyleri itiraf edin. Şehrin ışıkları ayaklarınızın altında, yıldızlar üstünüzde — bu atmosfer sihirli bir gece yaratacak.',
'Transform your building''s rooftop or a terrace bar with a beautiful view into a romantic stargazing area. Lay thick blankets and pillows on the ground, line LED candles around them. Rent a telescope or prepare binoculars. Prepare hot chocolate, wine, and a cheese platter. Download a sky map app and identify constellations together. Make a wish if you spot a shooting star. In the dark, confess things you''ve never told each other about your relationship. City lights beneath your feet, stars above you — this atmosphere will create a magical night.',
'Çatı katında battaniyeler ve teleskopla romantik bir yıldız gözlem gecesi düzenleyin.',
'Host a romantic stargazing night on the rooftop with blankets and a telescope.',
3, 500, 2000, 2, 6, 3, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['çatı','yıldız','gözlem','romantik','teleskop','gece'], false, false);

-- 31. vintage-photo-shoot (difficulty 3, both, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'vintage-photo-shoot',
'Vintage Fotoğraf Çekimi', 'Vintage Photo Shoot Anniversary',
'Yıldönümünüzde retro temalı bir fotoğraf çekimi organize edin. 1950''ler, 60''lar veya 70''ler tarzı kıyafetler kiralayın veya vintage mağazalardan temin edin. Eski bir araba, klasik bir kafe veya retro dekorlu bir stüdyo bulun. Profesyonel fotoğrafçıyla film efektli, siyah-beyaz veya sepya tonlarında çekimler yapın. Polaroid fotoğraf makinesiyle anlık kareler de çekin. En güzel kareleri vintage çerçevelere koyarak evinize asın. Bu çekim sadece güzel fotoğraflar değil, unutulmaz bir deneyim de üretecek. Hazırlık sürecinde birlikte kıyafet seçmek bile eğlenceli bir aktivite.',
'Organize a retro-themed photo shoot on your anniversary. Rent 1950s, 60s, or 70s style outfits or find them at vintage shops. Find a classic car, retro cafe, or studio with vintage decor. Do shoots with film effects, black-and-white, or sepia tones with a professional photographer. Also take instant shots with a Polaroid camera. Put the best frames in vintage frames and hang them at home. This shoot will produce not just beautiful photos but also an unforgettable experience. Even choosing outfits together during preparation is a fun activity.',
'Retro kıyafetler ve vintage dekorla profesyonel bir fotoğraf çekimi yapın.',
'Do a professional photo shoot with retro outfits and vintage decor.',
3, 1000, 5000, 2, 4, 7, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['vintage','fotoğraf','retro','çekim','kıyafet','stüdyo'], false, false);

-- 32. scrapbook-surprise-anniversary (difficulty 2, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'scrapbook-surprise-anniversary',
'El Yapımı Karalama Defteri', 'Handmade Scrapbook Anniversary Surprise',
'İlişkinizin en güzel anlarını içeren el yapımı bir karalama defteri hazırlayın. Bilet kökleri, kurumuş çiçekler, el yazısı notlar, fotoğraflar, restoran kartvizitleri — her şeyi kullanın. Her sayfayı farklı bir tema etrafında tasarlayın: ilk buluşma, ilk tatil, komik anlar, romantik anlar. Washi tape, renkli kalemler, sticker ve yapıştırıcılarla sayfaları süsleyin. Son sayfada gelecek planlarınızı ve hayallerinizi yazın, boş sayfalar bırakarak ileride ekleme yapılmasına olanak tanıyın. Bu defteri her yıldönümünde güncelleyin — zamanla ilişkinizin büyüyen bir arşivi olacak.',
'Create a handmade scrapbook containing the most beautiful moments of your relationship. Use everything: ticket stubs, dried flowers, handwritten notes, photos, restaurant business cards. Design each page around a different theme: first date, first vacation, funny moments, romantic moments. Decorate pages with washi tape, colored pens, stickers, and adhesives. On the last page, write your future plans and dreams, leaving blank pages for future additions. Update this scrapbook every anniversary — over time it will become a growing archive of your relationship.',
'El yapımı bir karalama defteri ile ilişkinizin en güzel anlarını biriktirin.',
'Collect the most beautiful moments of your relationship in a handmade scrapbook.',
2, 100, 600, 2, 2, 10, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['karalama defteri','el yapımı','fotoğraf','anı','yaratıcı','kolaj'], false, false);

-- 33. couples-pottery-class (difficulty 2, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'couples-pottery-class',
'Çiftler İçin Seramik Atölyesi', 'Couples Pottery Class Anniversary',
'Yıldönümünüzde "Ghost" filmindeki ikonik sahneyi yaşayın — birlikte bir seramik atölyesine gidin. Torna başında yan yana oturarak kendi kaselerinizi, vazolarınızı veya fincanlarınızı şekillendirin. Çamurla oynamak hem rahatlatıcı hem eğlenceli bir deneyim. Birbirinizin eserlerini şekillendirmeye yardım edin, gülün, kirlerin. Atölye sonunda eserlerinizi boyayın ve fırınlanmak üzere bırakın. Birkaç gün sonra hazır eserleri alıp evinizde kullanın — her çay içtiğinizde o güzel günü hatırlayın. Bu atölye yeni bir ortak hobi başlatabilir, düzenli olarak devam edebilirsiniz.',
'Live the iconic scene from the movie "Ghost" on your anniversary — go to a pottery workshop together. Sit side by side at the wheel, shaping your own bowls, vases, or cups. Playing with clay is both relaxing and fun. Help shape each other''s creations, laugh, get dirty. At the end of the workshop, paint your pieces and leave them to be fired. Pick up the finished pieces a few days later and use them at home — remember that beautiful day every time you have tea. This workshop could start a new shared hobby you continue regularly.',
'Seramik atölyesinde birlikte çamurla şekiller yaratarak eğlenceli bir yıldönümü geçirin.',
'Spend a fun anniversary creating shapes with clay together at a pottery workshop.',
2, 300, 1200, 2, 8, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['seramik','atölye','çamur','yaratıcı','hobi','birlikte'], false, false);

-- 34. bonsai-growth-journey (difficulty 2, both, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'bonsai-growth-journey',
'Bonsai Büyüme Yolculuğu', 'Bonsai Growth Journey Anniversary',
'Yıldönümünüzde birlikte bir bonsai ağacı satın alın veya dikin. Bu canlı hediye ilişkiniz gibi bakım, sabır ve sevgi ister. Bir bonsai atölyesine katılarak birlikte budama ve şekillendirme tekniklerini öğrenin. Bonsaiye birlikte isim verin — ilişkinizin sembolü olsun. Her yıldönümünde bonsainin yanında fotoğraf çekerek büyüme sürecini belgelyin. Ağaç büyüdükçe ilişkiniz de büyüyecek. Bonsai bakımı meditasyon gibidir — birlikte yapıldığında ilişkinize de huzur katar. Yıllar sonra bu ağaç evinizin en değerli parçası olacak.',
'Buy or plant a bonsai tree together on your anniversary. This living gift requires care, patience, and love — just like your relationship. Attend a bonsai workshop together to learn pruning and shaping techniques. Give the bonsai a name together — let it be a symbol of your relationship. Document the growth process by taking photos next to the bonsai every anniversary. As the tree grows, so will your relationship. Bonsai care is like meditation — when done together, it brings peace to your relationship too. Years later, this tree will be the most valuable piece in your home.',
'Birlikte bir bonsai ağacı dikerek ilişkinizi simgeleyen canlı bir hediye verin.',
'Give a living gift symbolizing your relationship by planting a bonsai tree together.',
2, 200, 1000, 2, 4, 3, 'both', ARRAY['spring','summer'], ARRAY['bonsai','ağaç','büyüme','doğa','sabır','sembol'], false, false);

-- 35. personalized-map-art (difficulty 1, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_anniversary, 'personalized-map-art',
'Kişiselleştirilmiş Harita Sanatı', 'Personalized Map Art Anniversary',
'İlişkinizde önemli olan mekanların haritalarını sanatsal posterlere dönüştürün. Tanıştığınız şehir, ilk buluşma yeri, evlendiğiniz mekan, balayı destinasyonunuz — her birinin haritasını minimalist bir tasarımla bastırın. Haritaların altına yer adı, tarih ve kısa bir mesaj ekleyin. Eşleşen çerçevelere koyarak duvara yan yana asın. Online harita sanatı servisleri bu tasarımları kolayca oluşturmanızı sağlar. Alternatif olarak tüm mekanları tek bir dünya haritası üzerinde işaretleyerek "Aşkımızın Haritası" temalı büyük bir poster de oluşturabilirsiniz.',
'Transform maps of locations important to your relationship into artistic posters. The city where you met, first date location, where you married, honeymoon destination — print each map in a minimalist design. Add the place name, date, and a short message below each map. Put them in matching frames and hang side by side on the wall. Online map art services make it easy to create these designs. Alternatively, you can mark all locations on a single world map to create a large poster themed "Map of Our Love."',
'İlişkinizde önemli mekanların haritalarını sanatsal posterlere dönüştürün.',
'Transform maps of important places in your relationship into artistic posters.',
1, 200, 1000, 2, 2, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['harita','poster','sanat','kişisel','mekan','minimalist'], false, false);

-- ==========================================
-- GRADUATION - 30 scenarios
-- ==========================================

-- 1. photo-timeline-walk (difficulty 2, outdoor, premium false, featured true)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'photo-timeline-walk',
'Fotoğraf Zaman Çizelgesi Yürüyüşü', 'Photo Timeline Walk Graduation',
'Mezunun bebekliğinden mezuniyetine kadar olan fotoğraflarını kronolojik sırayla bir yürüyüş parkuruna asın. Her fotoğrafın altına yaş, tarih ve o dönemden bir anı yazın. Parkurun sonunda mezuniyet kıyafetli güncel fotoğrafı ve "Seninle gurur duyuyoruz" yazılı bir pankart beklesin. Aile üyeleri ve arkadaşlar parkur boyunca gizlenip her durakta sürpriz yapabilir. Son durakta konfeti, balonlar ve pasta ile kutlama yapın. Bu yürüyüş mezunun hayat yolculuğunu somut olarak gösterir ve hem mezun hem misafirler için duygusal bir deneyim olur.',
'Hang photos chronologically from the graduate''s baby years to graduation along a walking path. Below each photo, write the age, date, and a memory from that period. At the end of the path, have a current photo in graduation attire and a banner reading "We are proud of you." Family members and friends can hide along the path and surprise at each stop. Celebrate at the final stop with confetti, balloons, and cake. This walk tangibly shows the graduate''s life journey and creates an emotional experience for both the graduate and guests.',
'Mezunun bebekliğinden bugüne fotoğraflarla süslenmiş bir yürüyüş parkuru oluşturun.',
'Create a walking path decorated with photos from the graduate''s baby years to today.',
2, 500, 2000, 5, 30, 5, 'outdoor', ARRAY['spring','summer'], ARRAY['fotoğraf','zaman çizelgesi','yürüyüş','mezuniyet','anı','kutlama'], false, true);

-- 2. this-is-your-life-podcast (difficulty 3, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'this-is-your-life-podcast',
'Bu Senin Hayatın Podcast''i', 'This Is Your Life Podcast Graduation',
'Mezun için "Bu Senin Hayatın" temalı özel bir podcast bölümü kaydedin. Ailesinden, öğretmenlerinden, arkadaşlarından ve mentorlarından gizlice ses kayıtları toplayın — her biri mezunla ilgili en güzel anılarını, gurur duyduğu anları ve gelecek dileklerini anlatsın. Bu kayıtları profesyonel bir şekilde düzenleyip müzik ve geçiş efektleriyle zenginleştirin. Mezuniyet gününde bu podcast''i hediye edin — kulaklıkla veya hoparlörden birlikte dinleyin. Sevdiklerinin seslerini duymak çok duygusal olacak. Podcast''i platformlara yükleyerek istediği zaman dinleyebilmesini sağlayın.',
'Record a special podcast episode themed "This Is Your Life" for the graduate. Secretly collect audio recordings from their family, teachers, friends, and mentors — each sharing their best memories with the graduate, proud moments, and future wishes. Edit these recordings professionally, enriching them with music and transition effects. Gift this podcast on graduation day — listen together with headphones or speakers. Hearing the voices of loved ones will be very emotional. Upload the podcast to platforms so they can listen anytime they want.',
'Mezun için sevdiklerinin seslerinden oluşan özel bir podcast bölümü hazırlayın.',
'Prepare a special podcast episode made of voices from the graduate''s loved ones.',
3, 200, 1000, 1, 5, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['podcast','ses kaydı','anı','duygusal','mezuniyet','hediye'], false, false);

-- 3. custom-jersey-graduation (difficulty 1, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'custom-jersey-graduation',
'Özel Tasarım Forma Hediyesi', 'Custom Jersey Graduation Gift',
'Mezunun favori spor takımının veya sevdiği sporun formasını kişiselleştirerek hediye edin. Formanın arkasına mezunun soyadı ve mezuniyet yılını yazdırın. Ön tarafa üniversite veya okul logosunu ekleyin. Formayı profesyonel bir çerçeveye koyarak imzalatmak için arkadaşlarına ve ailesine dağıtın — herkes bir mesaj ve imza eklesin. Çerçevelenmiş forma hem dekoratif bir duvar süsü hem paha biçilmez bir hatıra olacak. Bunu mezuniyet töreninden sonra özel bir kutlamada sunun. Sporla ilgilenmiyorsa bile mezuniyet yılı yazılı bir forma anlamlı bir semboldür.',
'Personalize and gift a jersey from the graduate''s favorite sports team or sport. Print the graduate''s surname and graduation year on the back. Add the university or school logo to the front. Put the jersey in a professional frame and distribute it to friends and family for signing — everyone adds a message and signature. The framed jersey will be both a decorative wall piece and a priceless keepsake. Present it at a special celebration after the graduation ceremony. Even if they''re not into sports, a jersey with the graduation year is a meaningful symbol.',
'Mezunun adı ve yılı yazılı kişisel bir forma hazırlayıp imzalatarak hediye edin.',
'Gift a personalized jersey with the graduate''s name and year, signed by loved ones.',
1, 300, 1200, 1, 20, 10, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['forma','spor','kişisel','imza','hediye','hatıra'], false, false);

-- 4. chalk-mural-celebration (difficulty 2, outdoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'chalk-mural-celebration',
'Kaldırım Tebeşiri Duvar Resmi', 'Chalk Mural Graduation Celebration',
'Mezunun evinin önünde veya okulun bahçesinde renkli tebeşirlerle devasa bir tebrik duvar resmi çizin. "Tebrikler Mezun!" yazısını büyük harflerle yazın, etrafına mezuniyet şapkası, diploma, yıldız ve konfeti çizimleri ekleyin. Arkadaşları ve aileyi gizlice organize ederek herkesin bir bölüm çizmesini sağlayın. Herkes kendi mesajını ve çizimini eklesin. Mezun sabah kapıyı açtığında veya okuldan döndüğünde bu renkli sürprizle karşılaşsın. Tebeşir geçici olduğu için sorun yaratmaz ama fotoğraflarla ölümsüzleştirin. Basit, ekonomik ama çok etkili bir kutlama.',
'Draw a giant congratulatory mural with colorful chalk in front of the graduate''s home or in the school yard. Write "Congratulations Graduate!" in large letters, adding drawings of graduation caps, diplomas, stars, and confetti around it. Secretly organize friends and family so everyone draws a section. Everyone adds their own message and drawing. When the graduate opens the door in the morning or returns from school, they''ll encounter this colorful surprise. Since chalk is temporary, it won''t cause problems, but immortalize it with photos. Simple, economical, but very impactful celebration.',
'Renkli tebeşirlerle mezunun kapısı önüne devasa bir tebrik resmi çizin.',
'Draw a giant congratulatory mural with colorful chalk at the graduate''s doorstep.',
2, 50, 300, 3, 15, 1, 'outdoor', ARRAY['spring','summer'], ARRAY['tebeşir','duvar resmi','kutlama','renkli','sürpriz','sokak sanatı'], false, false);

-- 5. awards-ceremony-surprise (difficulty 4, indoor, premium true, featured true)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'awards-ceremony-surprise',
'Sürpriz Ödül Töreni', 'Surprise Awards Ceremony Graduation',
'Mezun için Oscar veya Grammy tarzında sahte ama görkemli bir ödül töreni düzenleyin. Kırmızı halı serin, sahne kurun, sunucu belirleyin. Kategoriler oluşturun: "En İyi Sınav Performansı", "En Çok Kahve İçen Öğrenci", "Yılın Arkadaşı", "En Yaratıcı Bahane" gibi eğlenceli ödüller. Her ödül için kısa bir aday tanıtım videosu hazırlayın. Altın boyalı plastik kupalar veya özel tasarım sertifikalar verin. Misafirler gala kıyafetleri giysin. DJ veya playlist ile müzik eşliğinde eğlenceli bir gece geçirin. Bu tören mezunu hem onurlandıracak hem herkesi güldürecek unutulmaz bir etkinlik olacak.',
'Organize a fake but magnificent awards ceremony for the graduate in the style of the Oscars or Grammys. Roll out a red carpet, set up a stage, assign a host. Create categories: fun awards like "Best Exam Performance," "Student Who Drank Most Coffee," "Friend of the Year," "Most Creative Excuse." Prepare a short nominee introduction video for each award. Give gold-painted plastic trophies or custom-designed certificates. Guests wear gala attire. Enjoy an entertaining night with music from a DJ or playlist. This ceremony will be an unforgettable event that both honors the graduate and makes everyone laugh.',
'Oscar tarzı eğlenceli bir ödül töreni düzenleyerek mezunu onurlandırın.',
'Honor the graduate with a fun Oscar-style awards ceremony celebration.',
4, 2000, 8000, 10, 50, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['ödül töreni','kırmızı halı','eğlenceli','kutlama','sahne','kupa'], true, true);

-- 6. trip-reveal-graduation (difficulty 3, indoor, premium true, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'trip-reveal-graduation',
'Mezuniyet Seyahati Açıklaması', 'Graduation Trip Reveal Surprise',
'Mezun için hayalindeki seyahati planlayın ve bunu sürpriz olarak açıklayın. Uçak biletlerini, otel rezervasyonunu ve gezi planını hazırlayın. Açıklama için yaratıcı bir yöntem seçin: bavulun içine biletleri ve destinasyon ipuçlarını koyun, bir dünya haritası üzerinde destinasyonu işaretleyin veya pasaportu hediye paketi olarak sunun. Açıklama anını videoya çekin. Bu seyahat mezuniyetin en güzel ödülü olacak — yeni bir hayat dönemine girmeden önce unutulmaz anılar biriktirmek için mükemmel bir fırsat. Arkadaşlarıyla birlikte grup seyahati de olabilir.',
'Plan the graduate''s dream trip and reveal it as a surprise. Prepare plane tickets, hotel reservations, and the itinerary. Choose a creative reveal method: put tickets and destination clues inside a suitcase, mark the destination on a world map, or present the passport as a gift package. Record the reveal moment on video. This trip will be the best reward for graduation — a perfect opportunity to collect unforgettable memories before entering a new chapter of life. It could also be a group trip with friends.',
'Mezunun hayalindeki seyahati planlayıp sürpriz olarak açıklayın.',
'Plan the graduate''s dream trip and reveal it as a surprise.',
3, 5000, 30000, 1, 6, 21, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['seyahat','tatil','sürpriz','bilet','destinasyon','açıklama'], true, false);

-- 7. video-compilation-graduation (difficulty 2, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'video-compilation-graduation',
'Mezuniyet Video Derlemesi', 'Graduation Video Compilation Surprise',
'Mezunun hayatındaki önemli kişilerden gizlice video mesajları toplayarak duygusal bir derleme hazırlayın. Ailesi, çocukluk arkadaşları, öğretmenleri, mentorları ve iş arkadaşlarından kısa videolar isteyin — her biri en güzel anısını anlatsın ve gelecek dileklerini paylaşsın. Videoları kronolojik sırayla düzenleyin, araya fotoğraflar ve müzik ekleyin. Bebek videolarından mezuniyet anına kadar bir yolculuk oluşturun. Mezuniyet kutlamasında büyük ekranda veya projektörle gösterin. Bu video mezunu gözyaşlarına boğacak ve hayatındaki herkesin onu ne kadar sevdiğini hissettirecek.',
'Secretly collect video messages from important people in the graduate''s life to create an emotional compilation. Ask family, childhood friends, teachers, mentors, and colleagues for short videos — each sharing their best memory and future wishes. Edit videos chronologically, adding photos and music in between. Create a journey from baby videos to graduation. Show it on a big screen or projector at the graduation celebration. This video will bring the graduate to tears and make them feel how much everyone in their life loves them.',
'Mezunun sevdiklerinden gizlice toplanan video mesajlarıyla duygusal bir derleme hazırlayın.',
'Create an emotional compilation from secretly collected video messages from loved ones.',
2, 100, 800, 1, 5, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['video','derleme','mesaj','duygusal','montaj','hatıra'], false, false);

-- 8. cap-decoration-party (difficulty 1, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'cap-decoration-party',
'Kep Süsleme Partisi', 'Cap Decoration Party Graduation',
'Mezuniyet töreninden önce arkadaşlarla birlikte bir kep süsleme partisi düzenleyin. Herkes kendi mezuniyet kepini yaratıcı bir şekilde süslesin: glitter, yapay çiçekler, komik yazılar, alıntılar, küçük figürler kullanılabilir. Malzemeleri önceden temin edin — yapıştırıcı tabancası, boya kalemleri, sticker''lar, kumaş parçaları. Müzik açın, atıştırmalıklar hazırlayın ve yaratıcı bir atmosfer oluşturun. Her kepi oylayarak "En Yaratıcı", "En Komik", "En Duygusal" gibi ödüller verin. Bu parti hem eğlenceli bir etkinlik hem de mezuniyet töreni için benzersiz kepler üretecek.',
'Organize a cap decoration party with friends before the graduation ceremony. Everyone decorates their graduation cap creatively: glitter, artificial flowers, funny quotes, small figurines can be used. Get materials in advance — glue gun, paint markers, stickers, fabric pieces. Play music, prepare snacks, and create a creative atmosphere. Vote on each cap and give awards like "Most Creative," "Funniest," "Most Emotional." This party will be both a fun activity and produce unique caps for the graduation ceremony.',
'Mezuniyet öncesi arkadaşlarla eğlenceli bir kep süsleme partisi düzenleyin.',
'Organize a fun cap decoration party with friends before graduation.',
1, 100, 500, 3, 15, 2, 'indoor', ARRAY['spring','summer'], ARRAY['kep','süsleme','parti','yaratıcı','arkadaşlar','eğlence'], false, false);

-- 9. graduation-boat-party (difficulty 4, outdoor, premium true, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'graduation-boat-party',
'Mezuniyet Tekne Partisi', 'Graduation Boat Party Celebration',
'Mezuniyeti denizde kutlayın! Bir tekne veya yat kiralayarak arkadaşlarla unutulmaz bir parti düzenleyin. Tekneyi mezuniyet temalı süslemeler, balonlar ve pankartlarla donatın. DJ veya bluetooth hoparlörle müzik açın, dans edin. Güvertede barbekü yapın veya catering servisi alın. Gün batımında kadeh kaldırarak mezuna tebrik konuşmaları yapın. Denizde fotoğraf çekimi yapın — mezuniyet kepleri havaya atılırken çekilecek kareler muhteşem olacak. Yüzme molası verin, su sporları yapın. Bu parti alışılmışın dışında, enerjik ve sosyal medyada unutulmaz paylaşımlar yaratacak bir kutlama olacak.',
'Celebrate graduation at sea! Rent a boat or yacht and throw an unforgettable party with friends. Deck the boat with graduation-themed decorations, balloons, and banners. Play music with a DJ or Bluetooth speaker, dance. Have a barbecue on deck or get catering service. Toast at sunset with congratulatory speeches for the graduate. Take photos at sea — shots of graduation caps thrown in the air will be spectacular. Take a swimming break, do water sports. This party will be an extraordinary, energetic celebration creating unforgettable social media posts.',
'Tekne kiralayarak denizde enerjik bir mezuniyet partisi düzenleyin.',
'Rent a boat and throw an energetic graduation party at sea.',
4, 5000, 20000, 10, 40, 10, 'outdoor', ARRAY['spring','summer'], ARRAY['tekne','parti','deniz','eğlence','dans','kutlama'], true, false);

-- 10. graduation-picnic-celebration (difficulty 1, outdoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'graduation-picnic-celebration',
'Mezuniyet Pikniği Kutlaması', 'Graduation Picnic Celebration',
'Güzel bir parkta veya sahilde rahat ve eğlenceli bir mezuniyet pikniği düzenleyin. Battaniyeler, yastıklar ve piknik sepetleri hazırlayın. Mezuniyet temalı süslemeler ekleyin — balonlar, flamalar ve "Tebrikler" pankartı. Herkes bir yemek getirsin veya birlikte sandviçler, salatalar ve tatlılar hazırlayın. Açık havada oyunlar oynayın: frisbee, voleybol, kart oyunları. Piknik sırasında mezunla ilgili "Bunu Biliyor Muydunuz?" oyunu oynayın. Pasta kesimi yapın ve dileklerinizi paylaşın. Bu samimi kutlama pahalı olmadan herkesin keyif alacağı, rahat bir ortamda güzel anılar biriktirmenizi sağlar.',
'Organize a comfortable and fun graduation picnic at a beautiful park or beach. Prepare blankets, pillows, and picnic baskets. Add graduation-themed decorations — balloons, streamers, and a "Congratulations" banner. Everyone brings a dish or prepare sandwiches, salads, and desserts together. Play outdoor games: frisbee, volleyball, card games. During the picnic, play a "Did You Know?" game about the graduate. Cut cake and share your wishes. This intimate celebration lets you collect beautiful memories in a relaxed atmosphere without spending much.',
'Parkta rahat bir piknik düzenleyerek mezuniyeti samimi bir şekilde kutlayın.',
'Celebrate graduation with an intimate picnic in a park.',
1, 100, 800, 5, 30, 2, 'outdoor', ARRAY['spring','summer'], ARRAY['piknik','açık hava','kutlama','rahat','ekonomik','eğlence'], false, false);

-- 11. diploma-frame-surprise (difficulty 1, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'diploma-frame-surprise',
'Diploma Çerçevesi Sürprizi', 'Diploma Frame Surprise Graduation',
'Mezunun diplomasını sergileyeceği özel ve lüks bir çerçeve hazırlayın. Üniversite veya okulun renklerinde, altın veya gümüş detaylı, cam korumalı profesyonel bir çerçeve seçin. Çerçevenin alt kısmına mezunun adı, bölümü ve mezuniyet yılı yazılı bir plaket ekletin. İçine diploma ile birlikte mezuniyet töreninden en güzel fotoğrafı da yerleştirin. Çerçeveyi güzel bir hediye kutusunda, el yazısı bir tebrik kartıyla birlikte sunun. Bu hediye mezunun başarısını onurlandırır ve çalışma odasının veya ofisinin en göze çarpan parçası olacak.',
'Prepare a special and luxurious frame for the graduate to display their diploma. Choose a professional frame in the university or school''s colors, with gold or silver details and glass protection. Have a plaque added to the bottom with the graduate''s name, department, and graduation year. Place the diploma along with the best photo from the graduation ceremony inside. Present the frame in a beautiful gift box with a handwritten congratulations card. This gift honors the graduate''s achievement and will be the most prominent piece in their study or office.',
'Mezunun diploması için kişiselleştirilmiş lüks bir çerçeve hediye edin.',
'Gift a personalized luxury frame for the graduate''s diploma.',
1, 200, 1000, 1, 3, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['diploma','çerçeve','hediye','plaket','onur','dekorasyon'], false, false);

-- 12. graduation-scrapbook (difficulty 2, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'graduation-scrapbook',
'Mezuniyet Anı Albümü', 'Graduation Scrapbook Surprise',
'Mezunun okul yıllarını anlatan kapsamlı bir anı albümü hazırlayın. Sınıf arkadaşlarından, öğretmenlerden ve okul personelinden gizlice mesajlar ve fotoğraflar toplayın. Her sınıf için bir sayfa oluşturun — o yılın en önemli olayları, komik anılar, ders notları ve fotoğraflar. Okul gazetesinden kesitler, yarışma sertifikaları ve etkinlik biletlerini ekleyin. Son sayfalarda arkadaşların el yazısı mesajları ve gelecek dilekleri olsun. Cilt kapağını mezunun okul renkleriyle ve logosıyla özelleştirin. Bu albüm okul yıllarının en değerli hatırası olacak ve yıllar sonra açıldığında gülümseten bir hazine.',
'Create a comprehensive memory album telling the story of the graduate''s school years. Secretly collect messages and photos from classmates, teachers, and school staff. Create a page for each grade — the year''s most important events, funny memories, class notes, and photos. Add clippings from the school newspaper, competition certificates, and event tickets. On the last pages, include friends'' handwritten messages and future wishes. Customize the cover with the graduate''s school colors and logo. This album will be the most precious keepsake of school years — a treasure that brings smiles when opened years later.',
'Okul yıllarını anlatan kapsamlı bir anı albümü hazırlayarak mezuna hediye edin.',
'Gift the graduate a comprehensive memory album documenting their school years.',
2, 200, 1000, 1, 5, 21, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['albüm','anı','fotoğraf','okul','mesaj','el yapımı'], false, false);

-- 13. future-letter-box (difficulty 2, both, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'future-letter-box',
'Geleceğe Mektup Kutusu', 'Future Letter Box Graduation',
'Mezuniyet kutlamasında herkesten mezuna geleceğe yönelik mektuplar yazmasını isteyin. Güzel bir ahşap veya dekoratif kutu hazırlayın. Her misafir zarfa koyduğu mektubunda 5 yıl sonrası için tahminler, tavsiyeler, komik anılar ve dilekler yazsın. Mezunun kendisi de kendine bir mektup yazsın — hayallerini, korkularını ve hedeflerini. Kutuyu mühürleyin ve üzerine "5 Yıl Sonra Aç" yazın. Beş yıl sonra bir araya gelerek mektupları birlikte açın. Bu gelenek gelecekte muhteşem bir buluşma sebebi olacak ve tahminlerin ne kadar tutup tutmadığını görmek çok eğlenceli olacak.',
'At the graduation celebration, ask everyone to write letters to the graduate about the future. Prepare a beautiful wooden or decorative box. In their sealed letters, each guest writes predictions for 5 years from now, advice, funny memories, and wishes. The graduate also writes a letter to themselves — their dreams, fears, and goals. Seal the box and write "Open in 5 Years" on it. Five years later, gather together and open the letters. This tradition will be a wonderful reason for a future reunion, and seeing which predictions came true will be incredibly fun.',
'Mezuniyet kutlamasında herkesten geleceğe mektup yazmasını isteyin ve 5 yıl sonra açın.',
'Have everyone write letters to the future at graduation and open them in 5 years.',
2, 100, 500, 5, 30, 3, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['mektup','gelecek','kutu','tahmin','gelenek','buluşma'], false, false);

-- 14. senior-year-documentary (difficulty 4, both, premium true, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'senior-year-documentary',
'Son Sınıf Belgeseli', 'Senior Year Documentary Graduation',
'Mezunun son sınıf yılını anlatan profesyonel bir kısa belgesel çekin. Okul kampüsünde, sınıflarda, kantinde ve kütüphanede çekimler yapın. Arkadaşlarıyla röportajlar kaydedin — en komik anıları, en stresli sınav dönemlerini, en güzel dostluk hikayelerini anlatsınlar. Öğretmenlerden ve mentorlardan mesajlar alın. Mezunun kendi hikayesini anlatmasını sağlayın — neden bu bölümü seçti, en zorlayıcı an ne oldu, gelecek hayalleri neler. Profesyonel kurgu, müzik ve grafik efektlerle 15-20 dakikalık bir belgesel hazırlayın. Mezuniyet partisinde büyük ekranda gösterin.',
'Shoot a professional short documentary about the graduate''s senior year. Film on the school campus, in classrooms, the cafeteria, and library. Record interviews with friends — let them share the funniest memories, most stressful exam periods, and best friendship stories. Get messages from teachers and mentors. Have the graduate tell their own story — why they chose this major, what the most challenging moment was, what their future dreams are. Prepare a 15-20 minute documentary with professional editing, music, and graphic effects. Show it on a big screen at the graduation party.',
'Son sınıf yılını anlatan profesyonel bir kısa belgesel çekerek mezuna hediye edin.',
'Gift the graduate a professional short documentary about their senior year.',
4, 2000, 10000, 1, 10, 30, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['belgesel','film','röportaj','okul','profesyonel','hatıra'], true, false);

-- 15. graduation-flash-mob (difficulty 5, outdoor, premium true, featured true)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'graduation-flash-mob',
'Mezuniyet Flash Mob Sürprizi', 'Graduation Flash Mob Surprise',
'Mezuniyet töreni sonrası kampüste veya parkta sürpriz bir flash mob düzenleyin. Arkadaşlarını ve aile üyelerini gizlice organize ederek bir koreografi öğretin. Mezunun favori şarkısını seçin ve 2-3 hafta boyunca pratik yapın. Mezun farkında olmadan müzik başlasın ve bir bir herkes dans etmeye başlasın. Son bölümde mezunu ortaya alarak birlikte dans edin. Profesyonel kameraman ile anı kaydedin. Flash mob''dan sonra konfeti patlatın ve kutlama pastasını çıkarın. Bu sürpriz hem duygusal hem enerjik olacak ve sosyal medyada viral olma potansiyeli taşıyacak.',
'Organize a surprise flash mob on campus or at a park after the graduation ceremony. Secretly organize friends and family members and teach them choreography. Choose the graduate''s favorite song and practice for 2-3 weeks. Without the graduate knowing, the music starts and one by one everyone begins dancing. In the final part, bring the graduate to the center and dance together. Record the moment with a professional cameraman. After the flash mob, pop confetti and bring out the celebration cake. This surprise will be both emotional and energetic, with potential to go viral on social media.',
'Mezuniyet sonrası kampüste sürpriz bir flash mob düzenleyerek mezunu şaşırtın.',
'Surprise the graduate with a flash mob on campus after the graduation ceremony.',
5, 1000, 5000, 15, 50, 21, 'outdoor', ARRAY['spring','summer'], ARRAY['flash mob','dans','sürpriz','koreografi','kampüs','enerjik'], true, true);

-- 16. surprise-family-visit-grad (difficulty 3, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'surprise-family-visit-grad',
'Sürpriz Aile Ziyareti', 'Surprise Family Visit Graduation',
'Mezuniyete katılamayacağını düşündüğü uzaktaki aile üyelerini gizlice getirerek sürpriz yapın. Büyükanne, büyükbaba, teyzeler, amcalar veya başka şehirdeki kardeşler — herkesin seyahat planını gizlice organize edin. Mezuniyet töreninde veya kutlamada kapıdan içeri girdiklerinde mezunun yüz ifadesini videoya çekin. Bu sürpriz özellikle ailesi uzakta olan veya ailesiyle sık görüşemeyen mezunlar için çok anlamlı olacak. Herkes bir araya gelince büyük bir aile fotoğrafı çekin. Uzaktaki aile üyelerinin "seni gururla izledik" mesajı en değerli hediye olacak.',
'Surprise the graduate by secretly bringing family members they thought couldn''t attend. Grandparents, aunts, uncles, or siblings from other cities — secretly organize everyone''s travel plans. Record the graduate''s facial expression on video when they walk through the door at the ceremony or celebration. This surprise will be especially meaningful for graduates whose families live far away or who don''t see their families often. Take a big family photo once everyone is together. The message "we watched you with pride" from distant family members will be the most valuable gift.',
'Uzaktaki aile üyelerini gizlice getirerek mezuna unutulmaz bir sürpriz yapın.',
'Create an unforgettable surprise by secretly bringing distant family members.',
3, 1000, 8000, 2, 20, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['aile','sürpriz','ziyaret','duygusal','birleşme','gurur'], false, false);

-- 17. graduation-garden-party (difficulty 3, outdoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'graduation-garden-party',
'Bahçe Partisi Mezuniyet Kutlaması', 'Graduation Garden Party Celebration',
'Evinin bahçesinde veya kiralık bir bahçede şık bir mezuniyet partisi düzenleyin. Işık zincirleri, renkli flamalar ve çiçek aranjmanlarıyla bahçeyi süsleyin. Büfe masası kurun — finger food, mini hamburgerler, tatlılar ve içecekler hazırlayın. Bir köşeye photo booth alanı oluşturun: mezuniyet temalı proplar, komik şapkalar ve çerçeveler hazırlayın. Canlı müzik veya DJ ile dans alanı oluşturun. Gün batımında mezuna tebrik konuşmaları yapın. Dilek ağacı kurun — herkes kartlarına dileklerini yazıp ağaca assın. Havai fişek veya maytap ile geceyi sonlandırın.',
'Organize a chic graduation party in their home garden or a rented garden. Decorate the garden with string lights, colorful streamers, and flower arrangements. Set up a buffet table — prepare finger food, mini burgers, desserts, and drinks. Create a photo booth area in one corner: graduation-themed props, funny hats, and frames. Create a dance floor with live music or a DJ. Give congratulatory speeches for the graduate at sunset. Set up a wish tree — everyone writes their wishes on cards and hangs them on the tree. End the night with fireworks or sparklers.',
'Bahçede ışık zincirleri ve çiçeklerle şık bir mezuniyet partisi düzenleyin.',
'Organize a chic graduation party in the garden with string lights and flowers.',
3, 2000, 8000, 10, 50, 7, 'outdoor', ARRAY['spring','summer'], ARRAY['bahçe','parti','dekorasyon','büfe','dans','dilek ağacı'], false, false);

-- 18. achievement-wall-surprise (difficulty 2, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'achievement-wall-surprise',
'Başarı Duvarı Sürprizi', 'Achievement Wall Surprise Graduation',
'Mezunun odasında veya evde bir duvara tüm başarılarını sergileyen bir "Başarı Duvarı" oluşturun. Sertifikalar, ödüller, proje fotoğrafları, takdir belgeleri, spor madalyaları — tüm okul hayatı boyunca kazandıklarını çerçeveleyip duvara asın. Kronolojik sırada düzenleyin, her birinin altına tarih ve kısa açıklama ekleyin. Duvarın ortasına büyük bir "Tebrikler Mezun!" yazısı asın. Mezun evde yokken hazırlayın ve kapıyı açtığında sürprizle karşılaşsın. Bu duvar ona ne kadar çok şey başardığını hatırlatacak ve gelecekte motivasyon kaynağı olacak.',
'Create an "Achievement Wall" on a wall in the graduate''s room or home displaying all their accomplishments. Certificates, awards, project photos, commendation letters, sports medals — frame everything they earned throughout their school life and hang on the wall. Arrange chronologically, adding dates and brief descriptions below each one. Hang a large "Congratulations Graduate!" sign in the center of the wall. Prepare it while the graduate is away and let them encounter the surprise when they open the door. This wall will remind them how much they''ve accomplished and serve as motivation for the future.',
'Mezunun tüm başarılarını sergileyen bir duvar oluşturarak sürpriz yapın.',
'Surprise the graduate by creating a wall displaying all their achievements.',
2, 200, 1000, 1, 5, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['başarı','duvar','sertifika','ödül','sergi','motivasyon'], false, false);

-- 19. graduation-karaoke-night (difficulty 1, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'graduation-karaoke-night',
'Mezuniyet Karaoke Gecesi', 'Graduation Karaoke Night Celebration',
'Mezuniyeti eğlenceli bir karaoke gecesiyle kutlayın. Evde karaoke sistemi kurun veya bir karaoke mekanı kiralayın. Mezunun ve arkadaşlarının favori şarkılarından bir playlist oluşturun. Okul yıllarında popüler olan şarkıları da listeye ekleyin — nostalji garantili! Gruplar halinde düet ve takım performansları düzenleyin. En iyi performansı seçmek için jüri oluşturun ve eğlenceli ödüller verin. Karaoke aralarında mezunla ilgili bilgi yarışması yapın. Gece boyunca fotoğraf ve video çekerek anıları ölümsüzleştirin. Bu rahat ve eğlenceli kutlama herkesin katılabileceği harika bir aktivite.',
'Celebrate graduation with a fun karaoke night. Set up a karaoke system at home or rent a karaoke venue. Create a playlist of the graduate''s and friends'' favorite songs. Add songs that were popular during school years — nostalgia guaranteed! Organize duets and team performances in groups. Form a jury to select the best performance and give fun awards. Between karaoke sessions, hold a trivia quiz about the graduate. Take photos and videos throughout the night to immortalize memories. This relaxed and fun celebration is a great activity everyone can participate in.',
'Eğlenceli bir karaoke gecesi düzenleyerek mezuniyeti şarkılarla kutlayın.',
'Celebrate graduation with songs by organizing a fun karaoke night.',
1, 200, 1500, 5, 20, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['karaoke','müzik','eğlence','parti','şarkı','arkadaşlar'], false, false);

-- 20. mentor-message-book (difficulty 2, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'mentor-message-book',
'Mentor Mesaj Kitabı', 'Mentor Message Book Graduation',
'Mezunun hayatındaki tüm öğretmenlerinden, mentorlarından ve koçlarından el yazısı mesajlar toplayarak özel bir kitap hazırlayın. İlkokuldan üniversiteye kadar tüm eğitim hayatı boyunca etkili olan isimlere ulaşın. Her birinden bir sayfa dolusu mesaj, tavsiye ve anı isteyin. Mesajların yanına o dönemden fotoğraflar ekleyin. Kitabın girişine mezunun eğitim kronolojisini yazın, sonuna boş sayfalar bırakarak gelecek mentorlar için yer açın. Profesyonel ciltletme ile kaliteli bir kitap haline getirin. Bu kitap mezunun en zor günlerinde bile açıp güç alacağı bir kaynak olacak.',
'Create a special book by collecting handwritten messages from all the teachers, mentors, and coaches in the graduate''s life. Reach out to influential figures throughout their entire education from elementary school to university. Ask each one for a page full of messages, advice, and memories. Add photos from those periods alongside the messages. Write the graduate''s education chronology at the book''s introduction, leaving blank pages at the end for future mentors. Have it professionally bound into a quality book. This book will be a resource the graduate can open and draw strength from even on their hardest days.',
'Öğretmen ve mentorlardan toplanan el yazısı mesajlarla özel bir kitap hazırlayın.',
'Create a special book with handwritten messages collected from teachers and mentors.',
2, 300, 1500, 1, 5, 21, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['mentor','mesaj','kitap','öğretmen','tavsiye','ilham'], false, false);

-- 21. campus-nostalgia-tour (difficulty 2, outdoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'campus-nostalgia-tour',
'Kampüs Nostalji Turu', 'Campus Nostalgia Tour Graduation',
'Mezuniyet gününde veya sonrasında kampüste bir nostalji turu düzenleyin. Mezunun okul hayatında önemli olan tüm noktaları ziyaret edin: ilk dersin yapıldığı sınıf, en çok ders çalıştığı kütüphane köşesi, kantindeki favori masası, arkadaşlarıyla buluştuğu bank. Her durakta o mekanla ilgili bir anıyı paylaşın, fotoğraf çekin. Gizlice hazırlanmış küçük sürprizler bırakın — bir notta yazılı anı, küçük bir hediye. Son durak en önemli yer olsun: diploma aldığı sahne veya en sevdiği nokta. Orada arkadaşları ve ailesi bekliyor olsun. Bu tur okula veda etmenin en güzel yolu.',
'Organize a nostalgia tour on campus on graduation day or after. Visit all the spots important to the graduate''s school life: the classroom of their first lecture, their favorite library corner, their go-to table in the cafeteria, the bench where they met friends. Share a memory about each location at every stop, take photos. Leave secretly prepared small surprises — a note with a memory, a small gift. The last stop should be the most important place: the stage where they received their diploma or their favorite spot. Have friends and family waiting there. This tour is the most beautiful way to say goodbye to school.',
'Kampüste önemli mekanları ziyaret ederek duygusal bir nostalji turu düzenleyin.',
'Organize an emotional nostalgia tour visiting important campus locations.',
2, 100, 500, 2, 15, 3, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['kampüs','nostalji','tur','anı','okul','veda'], false, false);

-- 22. graduation-balloon-release (difficulty 2, outdoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'graduation-balloon-release',
'Dilek Balonu Uçurma Töreni', 'Graduation Wish Balloon Release Ceremony',
'Mezuniyet kutlamasında herkesin geleceğe dair dileklerini yazdığı balonları birlikte gökyüzüne bırakın. Çevre dostu biyobozunur balonlar ve doğal mürekkepli kalemler kullanın. Her misafir balonuna mezun için bir dilek, tavsiye veya mesaj yazsın. Mezun kendi balonuna gelecek hayallerini yazsın. Gün batımında hep birlikte sayarak balonları gökyüzüne bırakın. Bu sembolik an yeni başlangıçları, umutları ve hayalleri temsil eder. Bırakma anını birden fazla açıdan videoya kaydedin. Alternatif olarak dilek fenerleri de kullanabilirsiniz — gece gökyüzünde süzülen ışıklar büyüleyici bir görüntü yaratır.',
'At the graduation celebration, release balloons together on which everyone has written their wishes for the future. Use eco-friendly biodegradable balloons and natural ink pens. Each guest writes a wish, advice, or message for the graduate on their balloon. The graduate writes their future dreams on their own balloon. At sunset, count together and release the balloons into the sky. This symbolic moment represents new beginnings, hopes, and dreams. Record the release from multiple angles on video. Alternatively, use wish lanterns — lights floating in the night sky create a mesmerizing view.',
'Herkesin dilek yazdığı çevre dostu balonları gökyüzüne bırakarak kutlayın.',
'Celebrate by releasing eco-friendly balloons with everyone''s wishes into the sky.',
2, 200, 800, 5, 30, 2, 'outdoor', ARRAY['spring','summer'], ARRAY['balon','dilek','gökyüzü','tören','umut','kutlama'], false, false);

-- 23. graduation-brunch-surprise (difficulty 2, both, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'graduation-brunch-surprise',
'Sürpriz Mezuniyet Brunch''ı', 'Graduation Brunch Surprise Celebration',
'Mezuniyet töreni sabahı veya ertesi gün sürpriz bir brunch düzenleyin. Evde veya şık bir restoranda yakın aile ve arkadaşlarla samimi bir kahvaltı-öğle yemeği hazırlayın. Menüde waffle, pancake, yumurta çeşitleri, taze meyveler, pastörize sular ve kahve olsun. Masayı mezuniyet temalı süslemelerle donatın — mini diplomalar, küçük keplar ve tebrik kartları. Herkes sırayla mezuna kısa bir tebrik konuşması yapsın. Pasta kesimi yapın ve kadeh kaldırın. Brunch''ın avantajı sabahın erken saatlerinde başlayıp gün boyu devam edebilmesidir. Rahat, samimi ve sıcak bir kutlama ortamı yaratır.',
'Organize a surprise brunch on the morning of graduation or the next day. Prepare an intimate breakfast-lunch with close family and friends at home or at a chic restaurant. Menu should include waffles, pancakes, egg varieties, fresh fruits, juices, and coffee. Set the table with graduation-themed decorations — mini diplomas, small caps, and congratulations cards. Everyone takes turns giving a short congratulatory speech. Cut cake and raise glasses. The advantage of brunch is it can start early in the morning and continue throughout the day. It creates a comfortable, intimate, and warm celebration atmosphere.',
'Mezuniyet sabahı yakınlarla sürpriz bir brunch düzenleyerek kutlamaya başlayın.',
'Start celebrating with a surprise brunch with loved ones on graduation morning.',
2, 500, 3000, 5, 20, 3, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['brunch','kahvaltı','sürpriz','samimi','aile','kutlama'], false, false);

-- 24. career-starter-kit (difficulty 2, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'career-starter-kit',
'Kariyer Başlangıç Kiti', 'Career Starter Kit Graduation Gift',
'Mezunun yeni kariyerine güçlü bir başlangıç yapması için kapsamlı bir "Kariyer Başlangıç Kiti" hazırlayın. Kite şunları ekleyin: kaliteli bir evrak çantası veya laptop çantası, profesyonel kartvizitler, ajanda veya planlayıcı, kaliteli bir kalem seti, mesleğiyle ilgili en iyi kitaplar, bir profesyonel kıyafet hediye kartı, LinkedIn Premium aboneliği ve bir kahve dükkânı hediye kartı. Her öğeyi ayrı ayrı paketleyin ve numaralayın. Her paketin içine neden o hediyeyi seçtiğinizi açıklayan bir not ekleyin. Bu düşünceli ve pratik hediye mezunun iş hayatına güvenle adım atmasını sağlayacak.',
'Prepare a comprehensive "Career Starter Kit" for the graduate to make a strong start in their new career. Include in the kit: a quality briefcase or laptop bag, professional business cards, a planner, a quality pen set, the best books related to their profession, a professional clothing gift card, LinkedIn Premium subscription, and a coffee shop gift card. Package each item separately and number them. Include a note in each package explaining why you chose that gift. This thoughtful and practical gift will help the graduate step into professional life with confidence.',
'Mezunun kariyerine güçlü başlaması için pratik hediyelerden oluşan bir kit hazırlayın.',
'Prepare a kit of practical gifts for the graduate to start their career strong.',
2, 1000, 5000, 1, 5, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kariyer','hediye','profesyonel','kit','iş hayatı','pratik'], false, false);

-- 25. graduation-photo-mosaic (difficulty 3, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'graduation-photo-mosaic',
'Fotoğraf Mozaik Portresi', 'Graduation Photo Mosaic Portrait',
'Mezunun yüzlerce fotoğrafından oluşan büyük bir mozaik portre oluşturun. Online mozaik oluşturma araçlarını kullanarak bebeklikten mezuniyete kadar tüm fotoğrafları bir araya getirin. Bu küçük fotoğraflar uzaktan bakıldığında mezunun büyük bir portre fotoğrafını oluşturur. Mozaiği büyük boyutta bastırıp çerçeveletin — en az 60x80 cm olması etkili olacaktır. Arkadaşlardan ve aileden de fotoğraf toplayarak mozaike dahil edin. Bu sanat eseri hem yakından bakıldığında onlarca anıyı hem uzaktan bakıldığında güzel bir portre sunar. Mezuniyet partisinde duvara asarak herkesi şaşırtın.',
'Create a large mosaic portrait made up of hundreds of the graduate''s photos. Using online mosaic creation tools, bring together all photos from babyhood to graduation. When viewed from afar, these small photos form a large portrait of the graduate. Print and frame the mosaic in large format — at least 60x80 cm for impact. Collect photos from friends and family to include in the mosaic. This artwork presents dozens of memories up close and a beautiful portrait from a distance. Surprise everyone by hanging it on the wall at the graduation party.',
'Yüzlerce fotoğraftan oluşan büyük bir mozaik portre oluşturarak sürpriz yapın.',
'Create a surprise with a large mosaic portrait made of hundreds of photos.',
3, 500, 2000, 1, 5, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['mozaik','fotoğraf','portre','sanat','dijital','baskı'], false, false);

-- 26. yearbook-signing-surprise (difficulty 1, both, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'yearbook-signing-surprise',
'Yıllık İmzalama Sürprizi', 'Yearbook Signing Surprise Graduation',
'Mezun için özel bir yıllık defteri hazırlayın ve tüm arkadaşlarına, öğretmenlerine ve okul personeline gizlice imzalattırın. Güzel bir defter veya özel basılmış bir yıllık alın. Her kişi bir sayfa veya bölüm doldurusun: anıları yazsın, çizim yapsın, fotoğraf yapıştırsın, sticker eklesin. Öğretmenler öğrencileri hakkında en gurur verici anı yazsın. Sınıf arkadaşları en komik okul anılarını paylaşsın. Son sayfada sınıf fotoğrafı ve herkesin iletişim bilgileri olsun. Mezuniyet gününde bu yıllığı hediye edin — her sayfa farklı bir sürpriz olacak.',
'Prepare a special yearbook for the graduate and secretly have all their friends, teachers, and school staff sign it. Get a beautiful notebook or specially printed yearbook. Each person fills a page or section: writing memories, drawing, pasting photos, adding stickers. Teachers write their most proud memory about the student. Classmates share the funniest school memories. The last page has the class photo and everyone''s contact information. Gift this yearbook on graduation day — every page will be a different surprise.',
'Gizlice imzalatılan özel bir yıllık defteri hazırlayarak mezuna sürpriz yapın.',
'Surprise the graduate with a special yearbook secretly signed by everyone.',
1, 100, 500, 1, 30, 14, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['yıllık','imza','mesaj','okul','arkadaşlar','hatıra'], false, false);

-- 27. graduation-concert-night (difficulty 3, both, premium true, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'graduation-concert-night',
'Mezuniyet Konser Gecesi', 'Graduation Concert Night Celebration',
'Mezunun favori sanatçısının konserine bilet alarak mezuniyeti müzikle kutlayın. Konsere gitmeden önce bir restoranda kutlama yemeği yiyin. Konser biletlerini yaratıcı bir şekilde sunun — bir bulmaca çözdürerek, ipucu avıyla veya sahte bir davetiye ile. Grup biletleri alarak en yakın arkadaşlarını da dahil edin. Konser öncesi ve sonrası fotoğraflar çekin, anı oluşturun. Eğer canlı konser mümkün değilse, evde özel bir konser gecesi düzenleyin — projeksiyon ile konser videoları izleyin, ışık efektleri ekleyin ve salon konser havasına bürünsün. Müzik her zaman en güzel kutlama arkadaşıdır.',
'Celebrate graduation with music by getting tickets to the graduate''s favorite artist''s concert. Have a celebration dinner at a restaurant before the concert. Present the concert tickets creatively — through a puzzle, clue hunt, or fake invitation. Get group tickets to include closest friends. Take photos before and after the concert, create memories. If a live concert isn''t possible, organize a special concert night at home — watch concert videos via projector, add lighting effects, and transform the room into a concert venue. Music is always the best celebration companion.',
'Favori sanatçının konserine bilet alarak mezuniyeti müzikle kutlayın.',
'Celebrate graduation with music by getting tickets to the favorite artist''s concert.',
3, 1000, 5000, 2, 10, 7, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['konser','müzik','bilet','sanatçı','eğlence','kutlama'], true, false);

-- 28. dream-job-vision-board (difficulty 1, indoor, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'dream-job-vision-board',
'Hayalindeki İş Vizyon Panosu', 'Dream Job Vision Board Graduation',
'Mezunla birlikte veya sürpriz olarak bir "Hayalindeki Kariyer" vizyon panosu oluşturun. Büyük bir mantar pano veya poster karton alın. Dergilerden, internettten ve fotoğraflardan mezunun kariyer hedeflerini, hayallerini ve motivasyonlarını temsil eden görseller kesin. Hedef maaş, çalışmak istediği şirketler, yaşamak istediği şehir, 5-10 yıllık planı — hepsini görsel olarak panoya yerleştirin. İlham veren alıntılar, kişisel hedefler ve hatırlatıcılar ekleyin. Bu panoyu çalışma masasının üstüne veya odanın duvarına asın. Her gün gördüğü bu pano bilinçaltına hedeflerini hatırlatarak motivasyonunu artıracak.',
'Create a "Dream Career" vision board with the graduate or as a surprise. Get a large corkboard or poster board. Cut out images from magazines, internet, and photos representing the graduate''s career goals, dreams, and motivations. Target salary, companies they want to work at, city they want to live in, 5-10 year plan — visually place everything on the board. Add inspiring quotes, personal goals, and reminders. Hang this board above the desk or on the room''s wall. This board they see every day will boost motivation by reminding their subconscious of their goals.',
'Mezunun kariyer hedeflerini görselleştiren bir vizyon panosu oluşturun.',
'Create a vision board visualizing the graduate''s career goals.',
1, 50, 300, 1, 4, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['vizyon panosu','kariyer','hedef','motivasyon','ilham','planlama'], false, false);

-- 29. graduation-rooftop-party (difficulty 4, outdoor, premium true, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'graduation-rooftop-party',
'Çatı Katı Mezuniyet Partisi', 'Graduation Rooftop Party Celebration',
'Şehir manzaralı bir çatı katında veya teras barda görkemli bir mezuniyet partisi düzenleyin. Mekanı ışık zincirleri, balonlar ve mezuniyet temalı süslemelerle donatın. Kokteyl barı kurun — mezunun adını taşıyan özel bir kokteyl yaratın. DJ ile dans alanı oluşturun. Gün batımında tebrik konuşmaları yapın, kadeh kaldırın. Photo booth köşesinde mezuniyet kepli, diplomalı eğlenceli fotoğraflar çekin. Pasta kesimi için özel tasarım mezuniyet pastası sipariş edin. Gece ilerledikçe şehir ışıkları altında dans edin. Bu parti hem şık hem eğlenceli, hem de Instagram''a yakışır kareler üretecek.',
'Organize a spectacular graduation party at a rooftop or terrace bar with city views. Decorate the venue with string lights, balloons, and graduation-themed decorations. Set up a cocktail bar — create a special cocktail named after the graduate. Create a dance floor with a DJ. Give congratulatory speeches at sunset, raise glasses. Take fun photos with graduation caps and diplomas at the photo booth corner. Order a custom graduation cake for the cutting ceremony. Dance under city lights as the night progresses. This party will be both chic and fun, producing Instagram-worthy shots.',
'Şehir manzaralı çatı katında görkemli bir mezuniyet partisi düzenleyin.',
'Organize a spectacular graduation party at a rooftop with city views.',
4, 5000, 20000, 15, 60, 14, 'outdoor', ARRAY['spring','summer'], ARRAY['çatı katı','parti','kokteyl','dans','manzara','şık'], true, false);

-- 30. graduation-time-capsule (difficulty 2, both, premium false, featured false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_graduation, 'graduation-time-capsule',
'Mezuniyet Zaman Kapsülü', 'Graduation Time Capsule Ceremony',
'Mezuniyet kutlamasında bir zaman kapsülü oluşturarak geleceğe mesaj gönderin. Su geçirmez bir kutu veya kavanoz hazırlayın. İçine şunları koyun: güncel gazete, mezunun favori şarkısının sözleri, sınıf fotoğrafı, herkesin gelecek tahminleri, mezunun kendine mektubu, okul rozeti, bilet kökleri ve küçük hatıralar. Her misafir bir nesne veya mesaj eklesin. Kapsülü birlikte mühürleyin ve üzerine "10 Yıl Sonra Aç" yazın. Bahçeye gömün veya güvenli bir yere kaldırın. On yıl sonra eski arkadaşlarla bir araya gelerek kapsülü açma planı yapın — muhteşem bir buluşma sebebi olacak.',
'Create a time capsule at the graduation celebration to send a message to the future. Prepare a waterproof box or jar. Put inside: current newspaper, lyrics of the graduate''s favorite song, class photo, everyone''s future predictions, the graduate''s letter to themselves, school badge, ticket stubs, and small keepsakes. Each guest adds an object or message. Seal the capsule together and write "Open in 10 Years" on it. Bury it in the garden or store it safely. Plan to open the capsule with old friends ten years later — it will be a wonderful reason for a reunion.',
'Mezuniyet anılarını ve gelecek tahminlerini içeren bir zaman kapsülü oluşturun.',
'Create a time capsule with graduation memories and future predictions.',
2, 100, 500, 5, 30, 3, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['zaman kapsülü','gelecek','anı','mühür','buluşma','gelenek'], false, false);

END $$;
