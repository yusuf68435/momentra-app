-- ==========================================
-- SEED: 65 Scenarios (30 Achievement + 35 Holiday)
-- Part 5: Achievement & Holiday categories
-- ==========================================

DO $$
DECLARE
  cat_achievement uuid;
  cat_holiday     uuid;
BEGIN

SELECT id INTO cat_achievement FROM public.categories WHERE slug = 'achievement';
SELECT id INTO cat_holiday     FROM public.categories WHERE slug = 'holiday';

-- ==========================================
-- ACHIEVEMENT - 30 scenarios
-- ==========================================

-- 1. charity-donation-chain
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'charity-donation-chain',
'Bağış Zinciri Kutlaması', 'Charity Donation Chain Celebration',
'Birisi büyük bir başarıya imza attığında, bu başarıyı topluma yansıtmanın en anlamlı yolu bir bağış zinciri oluşturmaktır. Arkadaşlardan ve aileden oluşan bir grup, başarı sahibinin en çok önemsediği hayır kurumuna zincir halinde bağış yapar. Her bağışçı, bir sonraki kişiye ilham veren kısa bir mesaj yazar. Tüm bağışlar tamamlandığında, toplam tutarı ve mesajları içeren özel tasarlanmış bir sertifika hazırlanarak başarı sahibine sürpriz olarak sunulur. Bu jest, bireysel başarının toplumsal etkiye dönüşmesini simgeler ve başarı sahibini derinden etkiler.',
'When someone achieves something remarkable, creating a charity donation chain is the most meaningful way to reflect that success back into the community. A group of friends and family members make sequential donations to a charity the achiever cares about most. Each donor writes a short message inspiring the next person in the chain. Once all donations are complete, a custom-designed certificate showing the total amount and all messages is prepared and presented as a surprise. This gesture symbolizes how individual achievement can transform into collective impact and deeply moves the achiever.',
'Başarıyı onurlandırmak için arkadaş ve aileden oluşan bağış zinciri oluşturun.',
'Create a donation chain from friends and family to honor the achievement.',
2, 200, 2000, 5, 50, 5, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['bağış','başarı','topluluk','anlamlı','kutlama','hayır','zincir'], false, true);

-- 2. custom-jersey-achievement
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'custom-jersey-achievement',
'Özel Forma Sürprizi', 'Custom Jersey Achievement Surprise',
'Başarı sahibinin en sevdiği spor takımının formasını kişiselleştirerek unutulmaz bir hediye hazırlayın. Formanın arkasına başarının tarihini, kişinin adını ve başarıyla ilgili özel bir numara yazdırın. Formayı profesyonel bir çerçeveye yerleştirip, takım arkadaşlarından veya iş arkadaşlarından toplanan tebrik mesajlarıyla birlikte sunun. Sunum anında herkesin aynı takımın formasını giyerek kutlama yapması, anı daha da özel kılar. Çerçeveli forma, ofiste veya evde gurur köşesinin en değerli parçası olacaktır.',
'Personalize a jersey of the achiever''s favorite sports team to create an unforgettable gift. Print the achievement date, the person''s name, and a special number related to the accomplishment on the back. Frame the jersey professionally and present it alongside congratulatory messages collected from teammates or colleagues. Having everyone wear the same team''s jersey during the presentation makes the moment even more special. The framed jersey will become the most treasured piece in their pride corner at the office or home.',
'Başarıyı spor formasıyla ölümsüzleştirin, kişiselleştirilmiş detaylarla donatın.',
'Immortalize the achievement with a personalized sports jersey and custom details.',
2, 500, 2500, 3, 20, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['forma','spor','kişisel','hediye','kutlama','çerçeve'], false, false);

-- 3. scratch-off-adventure-map
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'scratch-off-adventure-map',
'Kazı Kazan Macera Haritası', 'Scratch-Off Adventure Map',
'Başarı sahibi için özel bir kazı kazan haritası tasarlayın. Haritada, kişinin geçmiş başarılarını ve gelecekte yapabileceği maceraları temsil eden noktalar yer alsın. Her nokta kazıldığında altından bir anı fotoğrafı, başarı tarihi veya gelecekteki macera önerisi çıksın. Haritayı büyük bir çerçeveye yerleştirip duvarına asması için hediye edin. İlk birkaç noktayı birlikte kazıyarak kutlama yapın. Bu hediye hem geçmişe saygı duruşu hem de geleceğe ilham kaynağı olur. Her yeni başarıda haritaya yeni noktalar eklenebilir.',
'Design a custom scratch-off map for the achiever. The map features points representing past achievements and future adventures they could embark on. When each point is scratched, it reveals a memory photo, achievement date, or future adventure suggestion. Frame the map in a large frame and gift it to hang on their wall. Celebrate by scratching the first few points together. This gift serves as both a tribute to the past and an inspiration for the future. New points can be added to the map with each new achievement.',
'Geçmiş başarıları ve gelecek maceraları gösteren özel kazı kazan haritası hediye edin.',
'Gift a custom scratch-off map showing past achievements and future adventures.',
3, 300, 1500, 2, 10, 10, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['harita','macera','yaratıcı','kişisel','anı','hediye'], false, false);

-- 4. hall-of-fame-desk
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'hall-of-fame-desk',
'Şöhret Salonu Masası', 'Hall of Fame Desk',
'Kişinin çalışma masasını bir gecede "Şöhret Salonu"na dönüştürün. Masanın üzerine küçük bir kırmızı halı serin, miniatur ödül heykelleri yerleştirin, başarılarını kronolojik sırayla gösteren mini bir sergi oluşturun. Masanın kenarına altın renkli bir isim plakası koyun. Çekmecenin içine arkadaşlardan ve aileden gelen tebrik kartları saklayın. Sabah işe geldiğinde masasını bu halde bulması, günün en güzel sürpriziyle başlamasını sağlar. Fotoğraf çekmek için mini bir fotoğraf köşesi de ekleyebilirsiniz.',
'Transform someone''s desk into a "Hall of Fame" overnight. Lay a small red carpet on the desk, place miniature award trophies, and create a mini exhibition showing their achievements in chronological order. Place a gold-colored nameplate on the edge of the desk. Hide congratulatory cards from friends and family inside the drawer. Finding their desk like this when they arrive at work ensures they start the day with the best surprise. You can also add a mini photo booth corner for taking pictures.',
'Çalışma masasını bir gecede şöhret salonuna dönüştürerek sürpriz yapın.',
'Transform their desk into a hall of fame overnight as a surprise.',
2, 200, 800, 2, 5, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['ofis','masa','dekorasyon','eğlenceli','sürpriz','ödül'], false, false);

-- 5. retirement-video-montage
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'retirement-video-montage',
'Emeklilik Video Montajı', 'Retirement Video Montage',
'Emekliye ayrılan kişi için kariyer boyunca birlikte çalıştığı insanlardan video mesajlar toplayın. Eski müdürler, ilk iş arkadaşları, mentorluk yaptığı gençler ve müşterilerden birer dakikalık duygusal mesajlar isteyin. Bu videoları profesyonel şekilde düzenleyerek, kariyer kronolojisini gösteren fotoğraflarla zenginleştirin. Arka plan müziği olarak kişinin en sevdiği şarkıyı kullanın. Emeklilik yemeğinde büyük bir ekranda gösterin. Video sonunda "Yeni macerana hoş geldin" mesajıyla bitirin. Montajın USB veya dijital kopyasını da hediye olarak verin.',
'Collect video messages from people the retiree has worked with throughout their career. Request one-minute emotional messages from former managers, first colleagues, young people they mentored, and clients. Edit these videos professionally, enriching them with photos showing their career chronology. Use their favorite song as background music. Screen it on a large display at the retirement dinner. End the video with a "Welcome to your new adventure" message. Also give them a USB or digital copy of the montage as a gift.',
'Kariyer boyunca çalıştığı insanlardan toplanan video mesajlarla emeklilik sürprizi.',
'Retirement surprise with video messages collected from career-long colleagues.',
3, 1000, 5000, 10, 100, 21, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['emeklilik','video','montaj','duygusal','kariyer','anı','veda'], true, false);

-- 6. champagne-toast-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'champagne-toast-surprise',
'Şampanya ile Kutlama Sürprizi', 'Champagne Toast Surprise',
'Başarı anını özel kılmak için yakın çevreyi gizlice bir araya getirin ve şampanya kadeh kaldırma töreni düzenleyin. Önceden hazırlanmış özel etiketli şampanya şişeleri kullanın; etiketlerde başarının adı ve tarihi yazsın. Her davetli sırayla kalkıp kısa bir tebrik konuşması yapsın. En son başarı sahibinin en yakını duygusal bir konuşma yaparak kadeh kaldırsın. Ortamı mumlar ve çiçeklerle süsleyerek şık bir atmosfer yaratın. Kadeh kaldırma anında konfeti patlatsın ve anı profesyonel fotoğrafçıyla ölümsüzleştirin.',
'Secretly gather close friends and family for a champagne toast ceremony to make the achievement moment special. Use custom-labeled champagne bottles with the achievement name and date on the labels. Each guest takes turns giving a short congratulatory speech. Finally, the closest person to the achiever delivers an emotional speech and raises a toast. Decorate the setting with candles and flowers to create an elegant atmosphere. Pop confetti during the toast and capture the moment with a professional photographer.',
'Özel etiketli şampanya ve duygusal konuşmalarla zarif bir başarı kutlaması yapın.',
'Host an elegant achievement celebration with custom-labeled champagne and heartfelt speeches.',
3, 1500, 5000, 5, 30, 5, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['şampanya','kutlama','zarif','konuşma','tören','şık'], true, false);

-- 7. bucket-list-board
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'bucket-list-board',
'Yaşam Listesi Panosu', 'Bucket List Board',
'Kişinin hayatta yapmak istediği şeyleri araştırarak büyük bir yaşam listesi panosu hazırlayın. Zaten gerçekleştirdiği hayallerin yanına tik işareti koyun, henüz gerçekleşmemiş olanları renkli kartlarla yazın. Her hedefin yanına ilham veren bir görsel ekleyin. Panonun ortasına son başarısının fotoğrafını büyükçe yerleştirin. Bu pano hem motivasyon kaynağı hem de güzel bir dekorasyon olacaktır. Hediye ederken "Bu listeden çok daha fazlasını başaracaksın" notuyla birlikte sunun. İsteğe bağlı olarak dijital versiyonunu da oluşturabilirsiniz.',
'Research what the person wants to do in life and create a large bucket list board. Put checkmarks next to dreams they''ve already achieved, and write unfulfilled ones on colorful cards. Add an inspiring visual next to each goal. Place a large photo of their latest achievement in the center of the board. This board serves as both a motivation source and beautiful decoration. Present it with a note saying "You''ll accomplish so much more than this list." Optionally, you can also create a digital version.',
'Hayalleri ve başarıları gösteren kişiselleştirilmiş yaşam listesi panosu hazırlayın.',
'Create a personalized bucket list board showcasing dreams and achievements.',
2, 150, 600, 1, 5, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['pano','hayal','motivasyon','yaratıcı','kişisel','liste'], false, false);

-- 8. promotion-picnic-celebration
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'promotion-picnic-celebration',
'Terfi Pikniği Kutlaması', 'Promotion Picnic Celebration',
'Terfi eden kişi için doğada sürpriz bir piknik organizasyonu yapın. Güzel bir parkta veya göl kenarında piknik alanı hazırlayın; battaniyeler, yastıklar ve çiçeklerle dekore edin. Kişinin favori yiyeceklerinden oluşan bir piknik sepeti hazırlayın. Davetlilerin her biri, terfi eden kişiyle olan en güzel anılarını anlatan küçük kartlar yazsın. Pasta üzerinde yeni pozisyon unvanını yazın. Günün sonunda herkesin birlikte çekileceği grup fotoğrafını büyük baskı olarak hediye edin. Müzik için bluetooth hoparlör ve kişinin favori çalma listesini hazırlayın.',
'Organize a surprise outdoor picnic for the promoted person. Set up a picnic area in a beautiful park or by a lake, decorated with blankets, cushions, and flowers. Prepare a picnic basket with their favorite foods. Have each guest write small cards sharing their best memories with the promoted person. Write the new position title on the cake. At the end of the day, gift a large print of the group photo taken together. Prepare a Bluetooth speaker and the person''s favorite playlist for music.',
'Terfi eden kişi için doğada süslenmiş sürpriz piknik kutlaması düzenleyin.',
'Organize a decorated surprise picnic celebration outdoors for the promoted person.',
2, 500, 2000, 5, 25, 3, 'outdoor', ARRAY['spring','summer'], ARRAY['piknik','terfi','doğa','kutlama','yemek','arkadaş'], false, false);

-- 9. office-desk-decoration
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'office-desk-decoration',
'Ofis Masası Süsleme Sürprizi', 'Office Desk Decoration Surprise',
'Başarı sahibinin ofis masasını sabah gelmeden önce balonlar, flamalar ve tebrik pankartlarıyla süsleyin. Masanın üzerine küçük hediyeler, çikolata ve tebrik kartları bırakın. Bilgisayar ekranına yapışkan notla "Sen harikasın!" yazın. Sandalyesine özel bir yastık veya battaniye koyun. İş arkadaşlarından gizlice toplanan kısa tebrik videolarını içeren bir QR kodu masasına yerleştirin. Kişi masasına oturduğunda tüm ekip alkışla karşılasın. Bu basit ama etkili sürpriz, kişinin kendini değerli hissetmesini sağlar ve ofis moralini yükseltir.',
'Decorate the achiever''s office desk with balloons, streamers, and congratulatory banners before they arrive in the morning. Leave small gifts, chocolates, and greeting cards on the desk. Stick a note saying "You are amazing!" on the computer screen. Place a special cushion or blanket on their chair. Put a QR code on their desk containing short congratulatory videos secretly collected from colleagues. When the person sits at their desk, have the whole team greet them with applause. This simple but effective surprise makes the person feel valued and boosts office morale.',
'Ofis masasını balonlar, flamalar ve tebrik mesajlarıyla sabah sürprizi olarak süsleyin.',
'Decorate the office desk with balloons, streamers, and congratulations as a morning surprise.',
1, 100, 400, 3, 15, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['ofis','dekorasyon','balon','sürpriz','iş','tebrik'], false, false);

-- 10. achievement-photo-wall
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'achievement-photo-wall',
'Başarı Fotoğraf Duvarı', 'Achievement Photo Wall',
'Kişinin hayatındaki tüm önemli başarı anlarını kronolojik sırayla gösteren bir fotoğraf duvarı oluşturun. İlk okul mezuniyetinden son başarısına kadar her dönüm noktasını temsil eden fotoğrafları zarif çerçevelerle duvara asın. Her fotoğrafın altına tarihi ve kısa bir açıklama yazın. Duvarın merkezine en son başarısının büyük bir fotoğrafını yerleştirin. LED iplik ışıklarla çevreleyerek sıcak bir ambiyans yaratın. Duvarın sonuna boş bir çerçeve koyun ve "Gelecek başarın için" notu ekleyin. Bu duvar, kişinin ne kadar yol kat ettiğini hatırlatır.',
'Create a photo wall showing all the important achievement moments in the person''s life in chronological order. Hang photos representing every milestone from elementary school graduation to their latest achievement in elegant frames. Write the date and a short description below each photo. Place a large photo of their most recent achievement at the center of the wall. Surround it with LED string lights to create a warm ambiance. Put an empty frame at the end of the wall with a note saying "For your next achievement." This wall reminds the person how far they have come.',
'Hayatındaki tüm başarı anlarını kronolojik fotoğraf duvarıyla ölümsüzleştirin.',
'Immortalize all achievement moments in life with a chronological photo wall.',
3, 500, 2000, 2, 5, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['fotoğraf','duvar','anı','kronoloji','dekorasyon','çerçeve'], false, false);

-- 11. trophy-ceremony-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'trophy-ceremony-surprise',
'Kupa Töreni Sürprizi', 'Trophy Ceremony Surprise',
'Gerçek bir ödül töreni gibi kupa takdim töreni düzenleyin. Özel tasarlanmış bir kupa veya plaket yaptırın, üzerine kişinin adını ve başarısını kazıtın. Bir sunucu belirleyin ve resmi bir tören senaryosu yazın. Kırmızı halı serin, sahne ışıkları kurun ve davetlilerin smokin veya gece kıyafeti giymesini isteyin. Sunucu, kişinin başarı hikayesini anlatırken arka planda epik müzik çalsın. Kupa takdim anında konfeti patlasın ve alkış tufanı koparak kişiyi onurlandırın. Profesyonel fotoğrafçı ve kameraman ile tüm anları kaydedin.',
'Organize a trophy presentation ceremony like a real awards show. Commission a custom-designed trophy or plaque with the person''s name and achievement engraved. Assign a host and write a formal ceremony script. Lay a red carpet, set up stage lights, and ask guests to wear tuxedos or evening attire. While the host narrates the person''s achievement story, play epic music in the background. Pop confetti during the trophy presentation and honor the person with thunderous applause. Record all moments with a professional photographer and videographer.',
'Gerçek bir ödül töreni gibi kupa takdim sürprizi düzenleyin.',
'Organize a trophy presentation surprise like a real awards ceremony.',
4, 3000, 10000, 10, 50, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kupa','tören','ödül','resmi','şık','sahne','kutlama'], true, true);

-- 12. confetti-entrance-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'confetti-entrance-surprise',
'Konfetili Giriş Sürprizi', 'Confetti Entrance Surprise',
'Başarı sahibi kapıdan girdiği anda unutulmaz bir karşılama yapın. Kapının arkasına konfeti topları ve serpantinler yerleştirin. Tüm ekip veya aile kapının arkasında sessizce beklesin. Kişi kapıyı açtığı anda herkes "Sürpriz!" diye bağırsın, konfetiler patlasın ve müzik çalmaya başlasın. Girişe "Tebrikler Şampiyon!" pankartı asın. İlk adımını attığı yere kırmızı halı serin. Bu ani ve enerjik sürpriz, başarı anının coşkuyla kutlanmasını sağlar. Anı kamerada yakalamak için birini önceden görevlendirin.',
'Create an unforgettable welcome the moment the achiever walks through the door. Place confetti poppers and streamers behind the door. Have the entire team or family wait silently behind the door. The moment they open it, everyone shouts "Surprise!", confetti pops, and music starts playing. Hang a "Congratulations Champion!" banner at the entrance. Lay a red carpet where they take their first step. This sudden and energetic surprise ensures the achievement moment is celebrated with excitement. Assign someone beforehand to capture the moment on camera.',
'Kapıdan girdiği anda konfeti, müzik ve tezahüratla karşılayın.',
'Welcome them with confetti, music, and cheers the moment they walk in.',
1, 100, 500, 5, 30, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['konfeti','sürpriz','giriş','enerji','coşku','karşılama'], false, false);

-- 13. surprise-party-achievement
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'surprise-party-achievement',
'Başarı Sürpriz Partisi', 'Achievement Surprise Party',
'Kişinin en yakın arkadaşları ve ailesini bir araya getirerek büyük bir sürpriz parti organizasyonu yapın. Mekanı başarıyla ilgili temalarla dekore edin; posterler, fotoğraflar ve başarı sembolü süslemeler kullanın. DJ veya canlı müzik ayarlayın. Büfe masasını kişinin favori yemekleriyle donatın. Gecenin bir bölümünde slayt gösterisiyle kişinin başarı yolculuğunu anlatın. Herkesin birer cümleyle tebrik mesajı söylediği bir bölüm ekleyin. Pasta kesimi sırasında tüm ışıkları kapatıp spot ışığıyla aydınlatın. Partinin sonunda anı defteri hediye edin.',
'Bring together the person''s closest friends and family for a grand surprise party. Decorate the venue with achievement-related themes using posters, photos, and achievement symbol decorations. Arrange a DJ or live music. Set up the buffet table with the person''s favorite foods. During part of the evening, narrate their achievement journey through a slideshow. Add a segment where everyone shares a one-sentence congratulatory message. During cake cutting, turn off all lights and illuminate with a spotlight. At the end of the party, gift a memory book.',
'Yakın çevresiyle büyük bir sürpriz başarı partisi düzenleyin.',
'Organize a grand surprise achievement party with their closest circle.',
3, 2000, 8000, 15, 60, 10, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['parti','sürpriz','kutlama','müzik','eğlence','büyük','organizasyon'], false, false);

-- 14. personalized-nameplate
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'personalized-nameplate',
'Kişiselleştirilmiş İsim Plakası', 'Personalized Nameplate',
'Başarı sahibi için el yapımı veya profesyonel olarak üretilmiş özel bir isim plakası hazırlayın. Plaka üzerinde kişinin adı, yeni unvanı veya başarısının adı altın veya gümüş harflerle yazılsın. Plakanın arka yüzüne tüm ekibin veya ailenin imzaları kazınsın. Masif ahşap, mermer veya kristal gibi kaliteli malzemeler tercih edin. Plakayı kadife bir kutu içinde sunun ve küçük bir tören yaparak takdim edin. Bu zarif hediye, kişinin ofisinde veya evinde yıllarca gurur kaynağı olarak sergilenecektir.',
'Prepare a handcrafted or professionally produced custom nameplate for the achiever. Have the person''s name, new title, or achievement name written in gold or silver lettering on the plate. Engrave the signatures of the entire team or family on the back. Choose quality materials like solid wood, marble, or crystal. Present the plate in a velvet box with a small ceremony. This elegant gift will be displayed with pride in their office or home for years to come.',
'Altın harflerle yazılmış özel isim plakası hediye edin.',
'Gift a custom nameplate with gold lettering.',
2, 300, 1500, 1, 10, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['plaka','isim','zarif','hediye','ofis','kişisel'], false, false);

-- 15. career-milestone-dinner
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'career-milestone-dinner',
'Kariyer Dönüm Noktası Yemeği', 'Career Milestone Dinner',
'Kariyer dönüm noktasını kutlamak için lüks bir restoranda özel yemek organizasyonu yapın. Restoranla önceden koordine ederek özel bir menü hazırlatın ve masayı çiçeklerle süsletin. Yemek boyunca kişinin kariyer hikayesini anlatan küçük bir sunum yapın. Her tabağın yanına bir kariyer anısını anlatan kart koyun. Tatlı servisinde özel tasarlanmış bir pasta getirin; üzerinde "10 Yıllık Başarı" gibi bir mesaj yazsın. Yemeğin sonunda kişiye kariyer portföyünü içeren deri ciltli bir kitap hediye edin.',
'Organize a special dinner at a luxury restaurant to celebrate a career milestone. Coordinate with the restaurant beforehand to prepare a custom menu and decorate the table with flowers. During the meal, deliver a small presentation narrating the person''s career story. Place a card next to each plate sharing a career memory. During dessert service, bring a custom-designed cake with a message like "10 Years of Success." At the end of dinner, gift the person a leather-bound book containing their career portfolio.',
'Lüks restoranda özel menü ve sunumla kariyer dönüm noktası kutlaması.',
'Celebrate a career milestone with a custom menu and presentation at a luxury restaurant.',
3, 3000, 12000, 4, 20, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['yemek','kariyer','lüks','restoran','kutlama','şık','milestone'], true, false);

-- 16. achievement-video-call
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'achievement-video-call',
'Sürpriz Başarı Video Görüşmesi', 'Achievement Surprise Video Call',
'Uzaktaki sevdiklerini bir video görüşmesinde bir araya getirerek sürpriz bir kutlama yapın. Farklı şehirlerden hatta ülkelerden arkadaş ve aile üyelerini aynı anda görüşmeye bağlayın. Her katılımcı önceden hazırladığı kısa bir tebrik mesajını sırayla okusun. Görüşme sırasında ekranda "Tebrikler!" yazılı dijital konfetiler patlasın. Herkesin aynı anda kadeh kaldırdığı bir an yaratın. Görüşmenin kaydını alarak daha sonra hediye olarak gönderin. Bu sürpriz, mesafenin sevgiyi engellemediğini gösterir.',
'Bring distant loved ones together in a video call for a surprise celebration. Connect friends and family members from different cities or even countries simultaneously. Each participant reads a short congratulatory message they prepared beforehand. During the call, digital confetti with "Congratulations!" pops on screen. Create a moment where everyone raises a toast simultaneously. Record the call and send it later as a gift. This surprise shows that distance cannot stop love.',
'Uzaktaki sevdikleri bir video görüşmesinde buluşturarak sürpriz kutlama yapın.',
'Surprise them by uniting distant loved ones in a celebration video call.',
1, 0, 200, 5, 50, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['video','uzak','dijital','aile','tebrik','görüşme'], false, false);

-- 17. custom-mug-celebration
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'custom-mug-celebration',
'Özel Kupa Kutlaması', 'Custom Mug Celebration',
'Başarı sahibi için kişiselleştirilmiş bir kupa tasarlayın. Kupanın bir yüzüne başarıyla ilgili komik veya duygusal bir fotoğraf, diğer yüzüne motivasyon verici bir alıntı veya içten bir mesaj yazdırın. Kupayı güzel bir kutuya koyarak kahve veya çay çeşitleriyle birlikte hediye edin. Kupayı verirken küçük bir kahve molası düzenleyin ve başarı hikayesini birlikte kutlayın. Her sabah kahvesini içerken başarısını hatırlayacak bu pratik ve duygusal hediye, günlük motivasyon kaynağı olacaktır.',
'Design a personalized mug for the achiever. Print a funny or emotional photo related to the achievement on one side and a motivational quote or heartfelt message on the other. Gift the mug in a beautiful box along with coffee or tea varieties. When giving the mug, organize a small coffee break and celebrate the achievement story together. This practical and emotional gift that reminds them of their achievement every morning over coffee will become a daily motivation source.',
'Kişiselleştirilmiş kupa ile her sabah başarısını hatırlatan hediye verin.',
'Give a personalized mug gift that reminds them of their achievement every morning.',
1, 50, 300, 1, 5, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kupa','hediye','kişisel','kahve','pratik','motivasyon'], false, false);

-- 18. team-celebration-lunch
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'team-celebration-lunch',
'Ekip Kutlama Öğle Yemeği', 'Team Celebration Lunch',
'Tüm ekibi bir araya getirerek sürpriz bir kutlama öğle yemeği düzenleyin. Favori restoranlarından catering sipariş edin veya ofiste özel bir yemek alanı oluşturun. Masayı balonlar ve tebrik kartlarıyla süsleyin. Yemek sırasında her ekip üyesi, başarı sahibiyle ilgili en komik veya en güzel anısını paylaşsın. Yemeğin ortasında sürpriz bir pasta getirin. Pasta üzerinde ekip fotoğrafı baskısı olsun. Yemeğin sonunda tüm ekibin imzaladığı bir tebrik kartı ve küçük bir hediye takdim edin. Bu sade ama anlamlı kutlama, ekip bağlarını güçlendirir.',
'Bring the whole team together for a surprise celebration lunch. Order catering from their favorite restaurants or create a special dining area in the office. Decorate the table with balloons and greeting cards. During the meal, have each team member share their funniest or fondest memory with the achiever. Bring a surprise cake midway through the meal with the team photo printed on it. At the end of the meal, present a greeting card signed by the whole team and a small gift. This simple but meaningful celebration strengthens team bonds.',
'Ekibi bir araya getirerek sürpriz kutlama öğle yemeği düzenleyin.',
'Organize a surprise celebration lunch bringing the whole team together.',
1, 300, 1500, 5, 20, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['ekip','yemek','öğle','kutlama','iş','pasta','birlik'], false, false);

-- 19. achievement-balloon-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'achievement-balloon-surprise',
'Başarı Balon Sürprizi', 'Achievement Balloon Surprise',
'Başarı sahibinin odasını veya ofisini yüzlerce balonla doldurun. Balonların içine küçük kağıtlar koyun; her kağıtta tebrik mesajı, komik anı veya motivasyon sözü yazsın. Bazı balonların içine küçük hediyeler veya hediye kartları saklayın. Kapıyı açtığında balonlar üzerine dökülsün. Tavan yüksekliğine uçan helyum balonlarına "Tebrikler" ve başarıyla ilgili mesajlar bağlayın. Odanın ortasına büyük bir folyo balon rakamı koyun; örneğin terfi yılı veya başarı sayısı. Bu renkli sürpriz, çocuksu bir sevinç yaratır.',
'Fill the achiever''s room or office with hundreds of balloons. Put small notes inside the balloons with congratulatory messages, funny memories, or motivational quotes. Hide small gifts or gift cards inside some balloons. When they open the door, balloons should spill over them. Tie "Congratulations" and achievement-related messages to helium balloons floating at ceiling height. Place a large foil balloon number in the center of the room representing the promotion year or achievement count. This colorful surprise creates childlike joy.',
'Odasını yüzlerce balonla doldurup içlerine mesajlar ve hediyeler saklayın.',
'Fill their room with hundreds of balloons hiding messages and gifts inside.',
2, 200, 800, 2, 5, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['balon','renkli','sürpriz','eğlenceli','mesaj','oda'], false, false);

-- 20. wish-tree-celebration
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'wish-tree-celebration',
'Dilek Ağacı Kutlaması', 'Wish Tree Celebration',
'Dekoratif bir ağaç dalı veya yapay ağaç kullanarak bir dilek ağacı oluşturun. Her davetliden, başarı sahibine olan dileklerini renkli kartlara yazmasını isteyin. Kartları kurdeleyle ağaca bağlayın. Ağacın altına küçük hediyeler ve LED ışıklar yerleştirin. Kutlama sırasında başarı sahibi tek tek kartları okusun. Her kartın okunmasından sonra dilek sahibi ayağa kalkıp kişiyi kucaklasın. Ağacı daha sonra evine götürmesi için hediye edin. Bu sembolik ve duygusal tören, sevginin somut bir ifadesi olarak yıllarca saklanabilir.',
'Create a wish tree using a decorative tree branch or artificial tree. Ask each guest to write their wishes for the achiever on colorful cards. Tie the cards to the tree with ribbons. Place small gifts and LED lights under the tree. During the celebration, have the achiever read the cards one by one. After each card is read, the wish writer stands up and hugs the person. Gift the tree to take home afterward. This symbolic and emotional ceremony can be kept for years as a tangible expression of love.',
'Dileklerin yazılı kartlarla süslendiği sembolik bir dilek ağacı oluşturun.',
'Create a symbolic wish tree decorated with cards bearing heartfelt wishes.',
2, 200, 1000, 5, 30, 3, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['dilek','ağaç','sembolik','duygusal','kart','sevgi'], false, false);

-- 21. framed-achievement-poster
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'framed-achievement-poster',
'Çerçeveli Başarı Posteri', 'Framed Achievement Poster',
'Grafik tasarımcıyla çalışarak kişinin başarısını anlatan sinema posteri tarzında bir afiş tasarlayın. Posterde kişinin fotoğrafı kahraman pozunda olsun, arka planda başarıyla ilgili semboller yer alsın. Film afişi formatında başlık, tarih ve "başrol" bilgileri yazın. Posteri yüksek kaliteli baskıyla büyük formatta bastırın ve şık bir çerçeveye yerleştirin. Sunum sırasında posterin örtüsünü kaldırma töreni yapın. Kişinin tepkisini kameraya kaydedin. Bu eğlenceli ve yaratıcı hediye, duvarda her zaman gülümseme yaratacaktır.',
'Work with a graphic designer to create a movie poster-style print telling the person''s achievement story. Feature their photo in a heroic pose with achievement-related symbols in the background. Write the title, date, and "starring" information in movie poster format. Print the poster in large format with high-quality printing and place it in a stylish frame. During presentation, hold an unveiling ceremony. Record the person''s reaction on camera. This fun and creative gift will always bring a smile on the wall.',
'Sinema posteri tarzında kişiselleştirilmiş başarı afişi tasarlayıp çerçeveleyin.',
'Design a personalized movie poster-style achievement print and frame it.',
3, 500, 2000, 1, 5, 10, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['poster','tasarım','yaratıcı','çerçeve','film','eğlenceli'], false, false);

-- 22. surprise-bonus-trip
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'surprise-bonus-trip',
'Sürpriz Ödül Gezisi', 'Surprise Bonus Trip',
'Başarı sahibine sürpriz bir hafta sonu tatili hediye edin. Kişinin en çok gitmek istediği yeri gizlice araştırın. Otel rezervasyonu, uçak bileti ve aktivite planlarını önceden ayarlayın. Sürprizi bir bavul hediye ederek açıklayın; bavulun içine uçak bileti, otel bilgileri ve gezi programını koyun. Bavulun üzerine "Macera Seni Bekliyor" etiketi yapıştırın. Varış noktasında küçük sürprizler ayarlayın: odada çiçekler, hoş geldin notu, yerel lezzetlerden oluşan bir sepet. Bu büyük jest, başarının gerçekten takdir edildiğini gösterir.',
'Gift the achiever a surprise weekend getaway. Secretly research where they most want to go. Arrange hotel reservations, flight tickets, and activity plans in advance. Reveal the surprise by gifting a suitcase containing flight tickets, hotel information, and the trip itinerary. Stick an "Adventure Awaits You" label on the suitcase. Arrange small surprises at the destination: flowers in the room, a welcome note, a basket of local delicacies. This grand gesture shows that the achievement is truly appreciated.',
'Gizlice planlanan sürpriz hafta sonu tatili ile başarıyı ödüllendirin.',
'Reward the achievement with a secretly planned surprise weekend getaway.',
4, 5000, 25000, 1, 4, 14, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['gezi','tatil','sürpriz','lüks','macera','ödül','seyahat'], true, false);

-- 23. achievement-cake-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'achievement-cake-surprise',
'Başarı Pastası Sürprizi', 'Achievement Cake Surprise',
'Özel tasarlanmış bir pasta ile başarıyı kutlayın. Pastanın teması tamamen başarıyla ilgili olsun; örneğin diploma pastası, kupa pastası veya meslek sembolü pastası. Pastacıyla çalışarak kişinin yüz fotoğrafından yenilebilir baskı yaptırın. Pastanın yanına her davetlinin bir dilim pastayla birlikte okuyacağı tebrik kartları hazırlayın. Pasta kesim anını özel kılmak için mumlar ve maytaplar kullanın. Arka planda kişinin en sevdiği şarkı çalsın. Pastanın bir dilimini küçük bir kutuya koyup "İlk dilim sana" notuyla ailesine gönderin.',
'Celebrate the achievement with a custom-designed cake. Make the cake theme entirely about the achievement; such as a diploma cake, trophy cake, or profession symbol cake. Work with a baker to create an edible print from the person''s face photo. Prepare congratulation cards for each guest to read along with a slice of cake. Use candles and sparklers to make the cake cutting moment special. Play the person''s favorite song in the background. Put one slice in a small box and send it to their family with a "First slice is for you" note.',
'Başarı temalı özel tasarım pasta ile sürpriz kutlama yapın.',
'Celebrate with a custom-designed achievement-themed cake surprise.',
1, 200, 1000, 3, 20, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['pasta','kutlama','tatlı','özel','tasarım','lezzetli'], false, false);

-- 24. photo-mosaic-achievement
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'photo-mosaic-achievement',
'Fotoğraf Mozaiği Sürprizi', 'Photo Mosaic Achievement Surprise',
'Kişinin yüzlerce fotoğrafından oluşan dev bir mozaik portre oluşturun. Arkadaşlardan, aileden ve iş arkadaşlarından birlikte çekilmiş fotoğrafları toplayın. Profesyonel bir yazılımla bu fotoğrafları birleştirerek uzaktan bakıldığında kişinin portresini oluşturan bir mozaik tasarlayın. Mozaiği büyük formatta bastırıp çerçeveleyin. Sunum sırasında önce uzaktan gösterin ki büyük resmi görsün, sonra yaklaştırarak her küçük fotoğrafı keşfetmesini sağlayın. Her fotoğrafın bir anıyı temsil ettiğini fark ettikçe duygulanacaktır.',
'Create a giant mosaic portrait made from hundreds of the person''s photos. Collect photos taken together from friends, family, and colleagues. Using professional software, combine these photos to design a mosaic that forms the person''s portrait when viewed from a distance. Print the mosaic in large format and frame it. During presentation, first show it from afar so they see the big picture, then move closer so they discover each small photo. They will be moved as they realize each photo represents a memory.',
'Yüzlerce anı fotoğrafından oluşan dev mozaik portre hediye edin.',
'Gift a giant mosaic portrait created from hundreds of memory photos.',
4, 1000, 4000, 1, 5, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['mozaik','fotoğraf','portre','anı','sanat','yaratıcı','büyük'], true, false);

-- 25. standing-ovation-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'standing-ovation-surprise',
'Ayakta Alkış Sürprizi', 'Standing Ovation Surprise',
'Başarı sahibi odaya girdiğinde tüm davetlilerin ayağa kalkarak alkışlamasını organize edin. Önceden tüm katılımcılara mesaj göndererek tam zamanlamayı koordine edin. Kişi kapıdan girdiğinde herkes sessizce ayağa kalksın ve ardından gürültülü bir alkış başlatsın. Alkış en az otuz saniye sürsün. Alkış sırasında "Bravo!" ve "Hak ettin!" tezahüratları yapılsın. Alkış bittiğinde en yakını öne çıkıp kısa bir konuşma yapsın. Bu güçlü ve duygusal an, kişinin ne kadar takdir edildiğini hissettiren en sade ama en etkili sürprizdir.',
'Organize all guests to stand up and applaud when the achiever enters the room. Send messages to all participants beforehand to coordinate exact timing. When the person walks through the door, everyone silently stands up and then starts thunderous applause. The applause should last at least thirty seconds. During the applause, chant "Bravo!" and "You deserve it!" After the applause ends, the closest person steps forward and gives a short speech. This powerful and emotional moment is the simplest yet most effective surprise that makes the person feel truly appreciated.',
'Odaya girdiğinde herkesin ayağa kalkıp alkışladığı güçlü bir sürpriz.',
'A powerful surprise where everyone stands and applauds as they enter the room.',
1, 0, 100, 10, 100, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['alkış','duygusal','güçlü','sade','tören','takdir'], false, false);

-- 26. achievement-time-capsule
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'achievement-time-capsule',
'Başarı Zaman Kapsülü', 'Achievement Time Capsule',
'Başarı anını sonsuza dek korumak için bir zaman kapsülü hazırlayın. Güzel bir kutu veya özel yapım bir kapsüle şu öğeleri yerleştirin: başarıyla ilgili gazete kupürleri, fotoğraflar, tebrik mektupları, o günkü tarihli bir gazete, kişinin gelecekteki kendisine yazdığı bir mektup ve başarıyı simgeleyen küçük bir obje. Kapağına açılış tarihini yazın — beş veya on yıl sonrası. Kapsülü birlikte mühürleyin ve güvenli bir yere kaldırın. Yıllar sonra açıldığında, o anın tüm duyguları yeniden canlanacak ve ne kadar ilerleme kaydedildiği görülecektir.',
'Prepare a time capsule to preserve the achievement moment forever. In a beautiful box or custom-built capsule, place the following items: newspaper clippings about the achievement, photos, congratulatory letters, a newspaper dated that day, a letter the person writes to their future self, and a small object symbolizing the achievement. Write the opening date on the lid — five or ten years later. Seal the capsule together and store it in a safe place. When opened years later, all the emotions of that moment will come alive again, showing how much progress has been made.',
'Başarı anını mühürleyen ve yıllar sonra açılacak bir zaman kapsülü hazırlayın.',
'Prepare a time capsule sealing the achievement moment to be opened years later.',
2, 100, 500, 2, 15, 5, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['zaman','kapsül','anı','gelecek','mühür','duygusal','sakla'], false, false);

-- 27. custom-comic-achievement
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'custom-comic-achievement',
'Özel Çizgi Roman Başarı Hikayesi', 'Custom Comic Achievement Story',
'Kişinin başarı hikayesini anlatan özel bir çizgi roman kitabı tasarlatın. Profesyonel bir çizerle çalışarak kişiyi süper kahraman olarak çizin. Hikaye, başarının zorluklarını ve zaferlerini dramatik bir şekilde anlatsın. Arkadaşları ve ailesini de yan karakter olarak ekleyin. Kitabı profesyonel baskıyla bastırın ve özel bir kapak tasarlayın. İçine gerçek fotoğraflar ve alıntılar da ekleyin. Sunum için küçük bir "kitap imza günü" düzenleyin ve kişiden kitabı imzalamasını isteyin. Bu benzersiz hediye, koleksiyon değeri taşır.',
'Commission a custom comic book telling the person''s achievement story. Work with a professional illustrator to draw the person as a superhero. The story should dramatically depict the challenges and triumphs of the achievement. Include friends and family as supporting characters. Print the book professionally and design a special cover. Add real photos and quotes inside. Organize a small "book signing day" for the presentation and ask the person to sign the book. This unique gift has collectible value.',
'Başarı hikayesini süper kahraman çizgi romanına dönüştürerek hediye edin.',
'Turn the achievement story into a superhero comic book and gift it.',
5, 2000, 8000, 1, 5, 21, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['çizgi roman','süper kahraman','yaratıcı','kitap','sanat','benzersiz','hikaye'], true, false);

-- 28. rooftop-party-achievement
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'rooftop-party-achievement',
'Çatı Katı Başarı Partisi', 'Rooftop Achievement Party',
'Şehir manzaralı bir çatı katında görkemli bir başarı partisi düzenleyin. Mekanı ışık zincirleri, mumlar ve çiçeklerle süsleyin. Kokteyl barı kurun ve profesyonel barmen tutun. DJ ile dans pisti oluşturun. Gün batımında kadeh kaldırma töreni yapın; şehrin ışıkları arka plan olsun. Gecenin ana olayı olarak kişinin başarı hikayesini anlatan kısa bir film gösterimi yapın. Havai fişek veya maytap gösterisiyle geceyi taçlandırın. VIP alanı oluşturarak başarı sahibini özel hissettirin. Bu lüks kutlama, başarının görkemini yansıtır.',
'Organize a magnificent achievement party on a rooftop with city views. Decorate the venue with string lights, candles, and flowers. Set up a cocktail bar and hire a professional bartender. Create a dance floor with a DJ. Hold a toast ceremony at sunset with the city lights as backdrop. As the main event of the night, screen a short film narrating the person''s achievement story. Crown the night with fireworks or sparkler shows. Create a VIP area to make the achiever feel special. This luxurious celebration reflects the grandeur of the achievement.',
'Şehir manzaralı çatı katında görkemli bir başarı partisi düzenleyin.',
'Host a magnificent achievement party on a rooftop with stunning city views.',
5, 15000, 50000, 20, 100, 14, 'outdoor', ARRAY['spring','summer'], ARRAY['çatı','parti','lüks','manzara','gece','kokteyl','görkemli','dans'], true, true);

-- 29. achievement-podcast-episode
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'achievement-podcast-episode',
'Başarı Podcast Bölümü', 'Achievement Podcast Episode',
'Kişinin başarı hikayesini anlatan profesyonel bir podcast bölümü kaydedin. Arkadaşları, ailesi ve mentorlarıyla röportajlar yaparak başarının perde arkasını ortaya çıkarın. Profesyonel ses düzenleme ve müzikle zenginleştirin. Bölümü gerçek bir podcast platformuna yükleyerek herkesin dinleyebileceği hale getirin. Sürpriz olarak kişiyi "konuk" olarak davet edin ve canlı yayında başarı hikayesini anlatmasını isteyin. Bölümün QR kodlu özel kapak tasarımını çerçeveleyerek hediye edin. Bu modern ve yaratıcı kutlama, dijital bir miras bırakır.',
'Record a professional podcast episode telling the person''s achievement story. Conduct interviews with their friends, family, and mentors to reveal the behind-the-scenes of the achievement. Enrich with professional audio editing and music. Upload the episode to a real podcast platform making it available for everyone. As a surprise, invite the person as a "guest" and ask them to share their achievement story live. Gift a framed custom cover design with the episode''s QR code. This modern and creative celebration leaves a digital legacy.',
'Başarı hikayesini anlatan profesyonel podcast bölümü kaydedip hediye edin.',
'Record and gift a professional podcast episode telling the achievement story.',
4, 500, 3000, 3, 10, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['podcast','dijital','modern','röportaj','ses','yaratıcı','hikaye'], true, false);

-- 30. first-day-survival-kit
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_achievement, 'first-day-survival-kit',
'İlk Gün Hayatta Kalma Kiti', 'First Day Survival Kit',
'Yeni bir işe başlayan veya yeni bir okula giden kişi için eğlenceli bir "hayatta kalma kiti" hazırlayın. Kutunun içine şunları koyun: stres topu, favori atıştırmalıkları, mini kahve seti, motivasyon kartları, acil durum çikolataları, komik post-it notlar, küçük bir bitki, kişiselleştirilmiş kalem ve not defteri, mini parfüm ve "İlk günü atlattın!" kuponu. Her öğenin yanına esprili bir açıklama kartı ekleyin; örneğin stres topunun yanına "Toplantı uzadığında sık" yazın. Kutuyu renkli ambalaj kağıdıyla sararak ilk günün sabahı kapısına bırakın.',
'Prepare a fun "survival kit" for someone starting a new job or attending a new school. Include in the box: a stress ball, favorite snacks, mini coffee set, motivation cards, emergency chocolates, funny post-it notes, a small plant, personalized pen and notebook, mini perfume, and a "You survived day one!" coupon. Add a humorous explanation card next to each item; for example, write "Squeeze when the meeting runs long" next to the stress ball. Wrap the box in colorful wrapping paper and leave it at their door on the morning of their first day.',
'Yeni başlangıçlar için eğlenceli ve pratik hayatta kalma kiti hazırlayın.',
'Prepare a fun and practical survival kit for new beginnings.',
1, 150, 500, 1, 3, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kit','eğlenceli','yeni iş','başlangıç','hediye','pratik','motivasyon'], false, false);

-- ==========================================
-- HOLIDAY - 35 scenarios
-- ==========================================

-- 1. bayram-family-reunion
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'bayram-family-reunion',
'Bayram Aile Buluşması', 'Holiday Family Reunion',
'Bayramda tüm aileyi sürpriz bir buluşmayla bir araya getirin. Uzak şehirlerdeki aile üyelerine gizlice ulaşarak hepsini aynı anda büyükanne veya büyükbabanın evine davet edin. Evi bayram süsleriyle donatın, geleneksel tatlılar hazırlayın. Kapı çalındığında büyüklerin şaşkınlığını kameraya kaydedin. Her aile üyesinden birer dakikalık "en güzel bayram anım" videosu çekin. Çocuklar için bayram harçlığı avı düzenleyin, bahçeye saklanan zarfları bulmalarını sağlayın. Akşam hep birlikte aile fotoğrafı çekerek geleneği ölümsüzleştirin.',
'Bring the whole family together with a surprise reunion during the holiday. Secretly contact family members in distant cities and invite them all to grandparents'' house at the same time. Decorate the house with holiday decorations and prepare traditional sweets. Record the elders'' surprise on camera when the doorbell rings. Film one-minute "my best holiday memory" videos from each family member. Organize a holiday money hunt for children, having them find envelopes hidden in the garden. In the evening, take a family photo together to immortalize the tradition.',
'Bayramda uzaktaki aile üyelerini sürpriz bir buluşmayla bir araya getirin.',
'Bring distant family members together with a surprise reunion during the holiday.',
3, 1000, 5000, 10, 50, 14, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['bayram','aile','buluşma','gelenek','sürpriz','büyükanne','sevgi'], false, true);

-- 2. yilbasi-tombala-night
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'yilbasi-tombala-night',
'Yılbaşı Tombala Gecesi', 'New Year''s Tombola Night',
'Geleneksel yılbaşı tombala gecesini modern dokunuşlarla yeniden canlandırın. Her hediye için özel sarılmış sürpriz paketler hazırlayın; çeşit çeşit, büyükten küçüğe hediyeler olsun. Tombala kartlarını kişiselleştirerek her kartın arka yüzüne eğlenceli bir görev yazın — tombala yapan kişi görevi yerine getirsin. Çinko, iki çinko ve tombala için farklı ödül kategorileri oluşturun. Ara sıra "joker" turları ekleyin: herkesin hediye değiş tokuş yapması gibi. Gece boyunca çerez ve sıcak içecek ikramı yapın. Gecenin sonunda en çok gülen kişiye özel bir ödül verin.',
'Revive the traditional New Year''s tombola night with modern touches. Prepare specially wrapped surprise packages for each prize — variety of gifts from large to small. Personalize tombola cards by writing a fun challenge on the back of each — the winner must complete the challenge. Create different prize categories for one line, two lines, and full house. Add occasional "joker" rounds: like everyone swapping gifts. Serve snacks and hot drinks throughout the night. At the end of the night, give a special prize to the person who laughed the most.',
'Geleneksel tombala gecesini modern dokunuşlar ve eğlenceli görevlerle canlandırın.',
'Revive traditional tombola night with modern touches and fun challenges.',
2, 500, 2000, 6, 20, 3, 'indoor', ARRAY['winter'], ARRAY['yılbaşı','tombala','eğlence','gelenek','hediye','oyun','gece'], false, false);

-- 3. valentines-home-dinner
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'valentines-home-dinner',
'Sevgililer Günü Ev Yemeği', 'Valentine''s Day Home Dinner',
'Sevgililer Günü''nde evinizi beş yıldızlı restorana dönüştürün. Masayı beyaz örtü, mumlar, gül yaprakları ve kristal bardaklarla hazırlayın. Üç çanaklı bir menü planlayın: başlangıç, ana yemek ve özel tatlı. Yemek tariflerini önceden deneyin ve malzemeleri taze alın. Arka planda romantik bir çalma listesi hazırlayın. Sevgiliniz eve geldiğinde onu garson kıyafetiyle karşılayın ve menü kartını sunun. Yemek boyunca birlikte geçirdiğiniz güzel anların fotoğraflarını slayt olarak gösterin. Tatlıyla birlikte kişiselleştirilmiş bir hediye sunun. Gece boyunca telefonları kapatın.',
'Transform your home into a five-star restaurant on Valentine''s Day. Set the table with white cloth, candles, rose petals, and crystal glasses. Plan a three-course menu: appetizer, main course, and special dessert. Practice the recipes beforehand and buy fresh ingredients. Prepare a romantic playlist in the background. When your partner arrives home, greet them in waiter attire and present the menu card. During the meal, show a slideshow of beautiful moments you''ve shared together. Present a personalized gift with dessert. Keep phones off all evening.',
'Evinizi beş yıldızlı restorana çevirerek romantik bir yemek sürprizi yapın.',
'Transform your home into a five-star restaurant for a romantic dinner surprise.',
3, 500, 2000, 2, 2, 3, 'indoor', ARRAY['winter'], ARRAY['sevgililer günü','romantik','yemek','mum','ev','aşk','özel'], false, false);

-- 4. mothers-day-breakfast
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'mothers-day-breakfast',
'Anneler Günü Kahvaltı Sürprizi', 'Mother''s Day Breakfast Surprise',
'Anneler Günü''nde anneniz için muhteşem bir kahvaltı sofrası hazırlayın. Gece önceden tüm malzemeleri alın ve sabah erken kalkarak kahvaltıyı hazırlayın. Sofrayı çiçeklerle süsleyin, her tabağın yanına küçük bir teşekkür kartı koyun. Annenizin en sevdiği yiyecekleri hazırlayın: ev yapımı börek, taze sıkılmış portakal suyu, özel kahve. Yatak odasına tepsi servisi yaparak onu uyandırın. Kahvaltı boyunca çocukluk fotoğraflarınızı gösterin ve en güzel anılarınızı paylaşın. Kahvaltı sonunda el yapımı bir hediye veya anlamlı bir mektup sunun.',
'Prepare a magnificent breakfast spread for your mother on Mother''s Day. Buy all ingredients the night before and wake up early to prepare breakfast. Decorate the table with flowers and place a small thank-you card next to each plate. Prepare your mother''s favorite foods: homemade pastry, freshly squeezed orange juice, special coffee. Wake her up with bed tray service. During breakfast, show your childhood photos and share your best memories. After breakfast, present a handmade gift or a meaningful letter.',
'Anneler Günü''nde sevgiyle hazırlanmış sürpriz kahvaltı sofrası kurun.',
'Set up a lovingly prepared surprise breakfast table on Mother''s Day.',
1, 200, 800, 2, 8, 1, 'indoor', ARRAY['spring'], ARRAY['anneler günü','kahvaltı','anne','sevgi','sabah','yemek','aile'], false, false);

-- 5. fathers-day-adventure
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'fathers-day-adventure',
'Babalar Günü Macera Sürprizi', 'Father''s Day Adventure Surprise',
'Babalar Günü''nde babanızı unutulmaz bir maceraya çıkarın. Babanızın her zaman yapmak isteyip de fırsat bulamadığı bir aktiviteyi organize edin: balık tutma, off-road macerası, uçuş simülasyonu, atış poligonu veya doğa yürüyüşü. Sabah "Hazırlan, sürprizimiz var!" diyerek gizli programı açıklayın. Yolculuk boyunca onun gençliğindeki macera hikayelerini dinleyin. Aktivite sonrası babanın favori restoranında yemek yiyin. Günün sonunda birlikte çekilen fotoğrafları içeren bir albüm hazırlayarak hediye edin. Bu gün, baba-evlat bağını güçlendiren özel bir anı olacaktır.',
'Take your father on an unforgettable adventure on Father''s Day. Organize an activity he''s always wanted to do but never found the chance: fishing, off-road adventure, flight simulation, shooting range, or nature hike. In the morning, reveal the secret program saying "Get ready, we have a surprise!" Listen to his adventure stories from his youth during the journey. After the activity, eat at your father''s favorite restaurant. At the end of the day, gift an album with photos taken together. This day will be a special memory strengthening the father-child bond.',
'Babalar Günü''nde babanızı hep istediği maceraya sürpriz olarak çıkarın.',
'Take your father on the adventure he''s always wanted as a Father''s Day surprise.',
2, 500, 3000, 2, 6, 5, 'outdoor', ARRAY['spring','summer'], ARRAY['babalar günü','macera','baba','doğa','aktivite','bağ','anı'], false, false);

-- 6. world-timezone-countdown
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'world-timezone-countdown',
'Dünya Saat Dilimleri Geri Sayımı', 'World Timezone Countdown',
'Yılbaşı gecesini farklı saat dilimlerinden gelen canlı bağlantılarla kutlayın. Dünyanın dört bir yanındaki arkadaş ve akrabalarla koordine olun; her saat diliminde gece yarısı olduğunda video bağlantısıyla birlikte kutlayın. Dev bir dünya haritası asarak her kutlanan saat dilimini işaretleyin. Yeni Zelanda''dan başlayarak Hawaii''ye kadar tüm gece boyunca kutlama yapın. Her saat diliminden bir yerel gelenek öğrenin ve uygulayın. Farklı ülkelerin yılbaşı atıştırmalıklarını hazırlayın. Bu benzersiz kutlama, dünyayı evinize getirir ve yeni yılı tam yirmi dört kez kutlamanızı sağlar.',
'Celebrate New Year''s Eve with live connections from different time zones. Coordinate with friends and relatives around the world; celebrate together via video call when midnight strikes in each time zone. Hang a large world map and mark each celebrated time zone. Celebrate all night long starting from New Zealand to Hawaii. Learn and practice a local tradition from each time zone. Prepare New Year snacks from different countries. This unique celebration brings the world to your home and lets you celebrate the new year a full twenty-four times.',
'Farklı saat dilimlerinden canlı bağlantılarla yılbaşını dünya çapında kutlayın.',
'Celebrate New Year''s globally with live connections from different time zones.',
4, 500, 2000, 4, 20, 7, 'indoor', ARRAY['winter'], ARRAY['yılbaşı','dünya','saat dilimi','canlı','video','kutlama','küresel'], true, false);

-- 7. ornament-time-capsule
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'ornament-time-capsule',
'Süs Zaman Kapsülü', 'Ornament Time Capsule',
'Her yıl yılbaşı ağacına asılacak özel bir süs zaman kapsülü geleneği başlatın. Şeffaf cam veya plastik topların içine o yılın anılarını temsil eden küçük objeler yerleştirin: konser bileti, tatil fotoğrafı, bebek ilk diş, mezuniyet şeridi. Her topun dışına yılı ve kısa bir açıklama yazın. Yıllar geçtikçe ağaç, ailenin anı koleksiyonuyla dolacak. Her yılbaşı ağacı süslenirken eski topları açıp anıları yeniden yaşayın. Çocuklar büyüdükçe kendi toplarını hazırlamaya başlasın. Bu gelenek, nesiller boyu sürecek duygusal bir aile mirası oluşturur.',
'Start a tradition of hanging a special ornament time capsule on the Christmas tree every year. Place small objects representing that year''s memories inside transparent glass or plastic balls: concert tickets, vacation photos, baby''s first tooth, graduation ribbon. Write the year and a short description on the outside of each ball. Over the years, the tree will fill with the family''s memory collection. Relive memories by opening old balls when decorating the tree each year. As children grow, they can start preparing their own balls. This tradition creates an emotional family legacy lasting generations.',
'Her yıl ağaca asılan anı toplarıyla nesiller boyu sürecek bir gelenek başlatın.',
'Start a generations-lasting tradition with memory ornaments hung on the tree each year.',
1, 100, 400, 2, 10, 3, 'indoor', ARRAY['winter'], ARRAY['yılbaşı','ağaç','süs','anı','gelenek','aile','kapsül'], false, false);

-- 8. custom-word-search-card
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'custom-word-search-card',
'Özel Kelime Bulmaca Kartı', 'Custom Word Search Card',
'Bayram veya özel gün kartı olarak kişiselleştirilmiş bir kelime bulmaca kartı tasarlayın. Bulmacada saklanmış kelimelerin hepsi kişiyle ilgili özel anlamlar taşısın: ilk buluşma yeri, sevdiği yemek, ortak anılar, hayalleri. Bulunan kelimelerin baş harflerini birleştirdiğinde gizli bir mesaj ortaya çıksın — örneğin "SENİ SEVİYORUM" veya "BAYRAMIMIZ KUTLU OLSUN." Kartın arka yüzüne duygusal bir mektup yazın. Bulmacayı birlikte çözerek eğlenceli vakit geçirin. Bu yaratıcı kart, sıradan bir tebrik kartından çok daha kişisel ve unutulmaz olacaktır.',
'Design a personalized word search puzzle card as a holiday or special occasion card. All hidden words in the puzzle should carry special meanings related to the person: first date location, favorite food, shared memories, dreams. When combining the first letters of found words, a secret message appears — such as "I LOVE YOU" or "HAPPY HOLIDAYS." Write an emotional letter on the back of the card. Have fun solving the puzzle together. This creative card will be much more personal and memorable than an ordinary greeting card.',
'Gizli mesaj içeren kişiselleştirilmiş kelime bulmaca kartı tasarlayın.',
'Design a personalized word search card with a hidden secret message.',
2, 50, 200, 1, 2, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['bulmaca','kart','yaratıcı','kelime','gizli','mesaj','kişisel'], false, false);

-- 9. kina-night-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'kina-night-surprise',
'Kına Gecesi Sürprizi', 'Henna Night Surprise',
'Gelin adayı için unutulmaz bir kına gecesi organizasyonu yapın. Mekanı geleneksel kırmızı ve altın tonlarıyla süsleyin. Kına tablası hazırlayın: mumlar, kına, şekerlemeler ve altın takıları yerleştirin. Gelinin en yakın arkadaşlarından oluşan bir dans grubu sürpriz bir koreografi hazırlasın. Kına yakma töreni sırasında kayınvalideden altın yüzük sürprizi olsun. Gelin ağlarken arkadaşları teselli şarkısı söylesin. Gecenin sonunda tüm kadınların bir araya geldiği kına halayı çekilsin. Drone ile havadan video çekimi yapılsın. Geline özel tasarlanmış kına elbisesi hediye edin.',
'Organize an unforgettable henna night for the bride-to-be. Decorate the venue in traditional red and gold tones. Prepare the henna tray with candles, henna, sweets, and gold jewelry. Have the bride''s closest friends prepare a surprise choreography as a dance group. During the henna ceremony, surprise with a gold ring from the mother-in-law. As the bride cries, friends sing a comfort song. At the end of the night, all women join in a henna folk dance. Record aerial video with a drone. Gift the bride a specially designed henna dress.',
'Geleneksel kırmızı ve altın temalı unutulmaz bir kına gecesi organize edin.',
'Organize an unforgettable henna night with traditional red and gold themes.',
4, 3000, 15000, 15, 100, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kına','gelin','düğün','gelenek','dans','altın','tören','kadın'], true, false);

-- 10. bridal-bath-hamam
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'bridal-bath-hamam',
'Gelin Hamamı Sürprizi', 'Bridal Bath Hamam Surprise',
'Gelin adayı için geleneksel Türk hamamında özel bir gelin hamamı organizasyonu yapın. Tarihi bir hamamı özel olarak kiralayın. Hamama gül yaprakları, mumlar ve hoş kokular yerleştirin. Gelinin yakın arkadaşlarını ve kadın akrabalarını davet edin. Profesyonel masaj ve kese hizmeti ayarlayın. Hamam sonrası özel bir alan hazırlayarak meyve tabağı, tatlılar ve içecek ikramı yapın. Gelinin gözleri bağlıyken hamamı süsleyin ve gözlerini açtığında sürprizle karşılaşsın. Hamamda çekilen vintage tarzı fotoğrafları albüm olarak hediye edin.',
'Organize a special bridal bath at a traditional Turkish hamam for the bride-to-be. Privately rent a historic hamam. Place rose petals, candles, and fragrances throughout the hamam. Invite the bride''s close friends and female relatives. Arrange professional massage and scrub services. After the hamam, prepare a special area with fruit platters, desserts, and beverages. Decorate the hamam while the bride is blindfolded and let her discover the surprise when she opens her eyes. Gift a vintage-style photo album from the hamam session.',
'Geleneksel Türk hamamında gelin adayı için özel bir hamam günü düzenleyin.',
'Organize a special bridal bath day at a traditional Turkish hamam.',
4, 5000, 20000, 8, 30, 10, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['hamam','gelin','düğün','gelenek','lüks','kadın','spa','Türk'], true, false);

-- 11. easter-egg-hunt-party
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'easter-egg-hunt-party',
'Paskalya Yumurtası Avı Partisi', 'Easter Egg Hunt Party',
'Çocuklar ve yetişkinler için eğlenceli bir Paskalya yumurtası avı organizasyonu yapın. Bahçeyi veya parkı renkli süslemelerle donatın. Farklı renklerde boyanmış yumurtaları zorluk seviyelerine göre saklayın; bazılarının içine çikolata, bazılarına küçük oyuncaklar, bazılarına da hediye kuponları koyun. Harita ve ipuçlarıyla macera hissini artırın. Yetişkinler için daha zor bulmacalarla korunan altın yumurtalar saklayın. En çok yumurta bulan kişiye büyük ödül verin. Aktivite sonrası birlikte yumurta boyama atölyesi yapın. Taze limonata ve kurabiyelerle ikram hazırlayın.',
'Organize a fun Easter egg hunt for both children and adults. Decorate the garden or park with colorful decorations. Hide differently painted eggs according to difficulty levels; put chocolate in some, small toys in others, and gift coupons in some. Increase the adventure feeling with maps and clues. Hide golden eggs protected by harder puzzles for adults. Give a grand prize to the person who finds the most eggs. After the activity, do an egg painting workshop together. Prepare fresh lemonade and cookies for refreshments.',
'Renkli yumurtalar, ipuçları ve ödüllerle dolu eğlenceli Paskalya avı düzenleyin.',
'Organize a fun Easter hunt filled with colorful eggs, clues, and prizes.',
2, 300, 1500, 5, 30, 5, 'outdoor', ARRAY['spring'], ARRAY['paskalya','yumurta','avı','çocuk','eğlence','bahçe','renkli'], false, false);

-- 12. halloween-costume-party
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'halloween-costume-party',
'Cadılar Bayramı Kostüm Partisi', 'Halloween Costume Party',
'Unutulmaz bir Cadılar Bayramı kostüm partisi düzenleyin. Evi veya mekanı örümcek ağları, bal kabağı fenerleri, iskeletler ve korkutucu süslemelerle donatın. Davetlilerin en yaratıcı kostümlerle gelmesini isteyin ve en iyi kostüm yarışması düzenleyin. Karanlık bir oda hazırlayarak korku evi deneyimi yaşatın. Balkabağı oyma atölyesi yapın. Cadı kazanı temalı punch ve korkutucu temalı yiyecekler hazırlayın: mumya sosisler, örümcek kurabiyeleri, hayalet meringue. Gece boyunca korku filmi maratonu yapın. Dans pistinde disko ışıklarıyla Monster Mash çalsın.',
'Organize an unforgettable Halloween costume party. Decorate the house or venue with spider webs, pumpkin lanterns, skeletons, and spooky decorations. Ask guests to come in their most creative costumes and hold a best costume contest. Create a haunted house experience in a dark room. Have a pumpkin carving workshop. Prepare witch cauldron-themed punch and spooky-themed foods: mummy sausages, spider cookies, ghost meringue. Run a horror movie marathon throughout the night. Play Monster Mash with disco lights on the dance floor.',
'Korkutucu süslemeler, kostüm yarışması ve eğlenceli aktivitelerle Cadılar Bayramı partisi.',
'Halloween party with spooky decorations, costume contest, and fun activities.',
3, 1000, 4000, 10, 50, 7, 'indoor', ARRAY['fall'], ARRAY['cadılar bayramı','kostüm','korku','parti','eğlence','balkabağı','gece'], false, false);

-- 13. thanksgiving-potluck-feast
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'thanksgiving-potluck-feast',
'Şükran Günü Potluck Ziyafeti', 'Thanksgiving Potluck Feast',
'Şükran Günü''nde herkesin bir yemek getirdiği büyük bir potluck ziyafeti düzenleyin. Her davetliye önceden bir yemek kategorisi atayın: birisi çorba, birisi salata, birisi ana yemek, birisi tatlı getirsin. Masayı sonbahar temasıyla süsleyin: yapraklar, bal kabakları, buğday başakları. Yemekten önce herkes sırayla minnettar olduğu bir şeyi paylaşsın. Büyük bir hindi veya ana yemeği ev sahibi hazırlasın. Yemek boyunca arka planda jazz müzik çalsın. Yemek sonrası şükran mektupları yazma aktivitesi yapın. Her davetli, yanındaki kişiye teşekkür mektubu yazsın.',
'Organize a large potluck feast where everyone brings a dish on Thanksgiving. Assign each guest a food category in advance: someone brings soup, someone salad, someone main course, someone dessert. Decorate the table with fall themes: leaves, pumpkins, wheat stalks. Before the meal, have everyone take turns sharing something they are grateful for. The host prepares a large turkey or main dish. Play jazz music in the background during the meal. After dinner, do a gratitude letter writing activity where each guest writes a thank-you letter to the person next to them.',
'Herkesin bir yemek getirdiği şükran temalı büyük bir potluck ziyafeti düzenleyin.',
'Organize a large gratitude-themed potluck feast where everyone brings a dish.',
2, 500, 2000, 8, 25, 5, 'indoor', ARRAY['fall'], ARRAY['şükran','yemek','potluck','ziyafet','sonbahar','minnet','aile'], false, false);

-- 14. christmas-advent-calendar
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'christmas-advent-calendar',
'Noel Advent Takvimi Sürprizi', 'Christmas Advent Calendar Surprise',
'Sevdikleriniz için el yapımı bir advent takvimi hazırlayın. Yirmi dört küçük kutu, poşet veya zarf hazırlayarak her birinin içine farklı bir sürpriz koyun: çikolata, mini hediye, sevgi notu, kupon, küçük oyuncak, çay paketi, maske, mum. Her günün dışına tarihi ve eğlenceli bir ipucu yazın. Takvimi güzel bir panoya veya ipe asarak duvara monte edin. Aralık ayının ilk gününden başlayarak her gün bir sürpriz açılsın. Yirmi dördüncü günün sürprizi en büyük hediye olsun. Bu gelenek, Noel''e kadar olan bekleme süresini sihirli bir maceraya dönüştürür.',
'Create a handmade advent calendar for your loved ones. Prepare twenty-four small boxes, bags, or envelopes with a different surprise in each: chocolate, mini gift, love note, coupon, small toy, tea packet, face mask, candle. Write the date and a fun clue on the outside of each day. Mount the calendar on a beautiful board or hang on a string on the wall. Starting from the first day of December, one surprise opens each day. Make the twenty-fourth day''s surprise the biggest gift. This tradition transforms the waiting period until Christmas into a magical adventure.',
'El yapımı advent takvimi ile Noel''e yirmi dört sürprizle geri sayım yapın.',
'Count down to Christmas with twenty-four surprises in a handmade advent calendar.',
3, 500, 2500, 1, 5, 14, 'indoor', ARRAY['winter'], ARRAY['noel','advent','takvim','sürpriz','hediye','aralık','gelenek'], false, false);

-- 15. new-year-resolution-party
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'new-year-resolution-party',
'Yeni Yıl Karar Partisi', 'New Year Resolution Party',
'Yeni yıla girerken arkadaşlarla bir "Yeni Yıl Kararları" partisi düzenleyin. Her davetli, yeni yıl hedeflerini yazdığı üç kart hazırlasın. Kartları yüksek sesle okusun ve grubun desteğini alsın. Geçen yılın kararlarını gözden geçirin; başarılanları kutlayın. Herkes bir "hesap verebilirlik ortağı" seçsin — yıl boyunca birbirlerinin hedeflerini takip etsinler. Gece yarısında balonların içine hedefleri yazıp gökyüzüne bırakın. Vision board yapma atölyesi düzenleyin. Yeni yılın ilk yemeğini birlikte pişirin. Bu parti, yeni yıla bilinçli ve motive başlamanızı sağlar.',
'Organize a "New Year Resolutions" party with friends as you enter the new year. Have each guest prepare three cards with their new year goals. Read the cards aloud and receive the group''s support. Review last year''s resolutions and celebrate the achieved ones. Everyone picks an "accountability partner" to track each other''s goals throughout the year. At midnight, write goals inside balloons and release them to the sky. Organize a vision board making workshop. Cook the first meal of the new year together. This party ensures you start the new year consciously and motivated.',
'Hedef belirleme, vision board ve balonlarla yeni yıla motive başlangıç partisi.',
'A motivated start-of-year party with goal setting, vision boards, and balloons.',
2, 300, 1500, 5, 20, 3, 'indoor', ARRAY['winter'], ARRAY['yeni yıl','hedef','karar','parti','motivasyon','vision board','başlangıç'], false, false);

-- 16. ramadan-iftar-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'ramadan-iftar-surprise',
'Ramazan İftar Sürprizi', 'Ramadan Iftar Surprise',
'Ramazan ayında sevdikleriniz için özel bir iftar sofrası hazırlayın. Geleneksel Türk iftar menüsü planlayın: hurma, su, çorba, pide, ana yemek ve güllaç. Sofrayı Ramazan fenerleri, mumlar ve ay-yıldız temalı süslemelerle donatın. İftar vaktinden önce her davetlinin yerine kişiselleştirilmiş bir dua kartı koyun. Ezanla birlikte hep birlikte oruç açın. Yemek sonrası Kur''an okuma veya sohbet halkaları oluşturun. Gecenin sonunda her davetliye küçük bir Ramazan hediye paketi verin: hurma, tesbih, misvak ve dua kitabı. Bu iftar, manevi bağları güçlendirir.',
'Prepare a special iftar table for your loved ones during Ramadan. Plan a traditional Turkish iftar menu: dates, water, soup, pide bread, main course, and gullac. Decorate the table with Ramadan lanterns, candles, and crescent-star themed decorations. Place a personalized prayer card at each guest''s seat before iftar time. Break the fast together with the call to prayer. After the meal, form Quran reading or discussion circles. At the end of the evening, give each guest a small Ramadan gift package: dates, prayer beads, miswak, and a prayer book. This iftar strengthens spiritual bonds.',
'Geleneksel süslemeler ve özel menüyle duygu dolu bir iftar sofrası kurun.',
'Set an emotional iftar table with traditional decorations and a special menu.',
2, 500, 3000, 6, 30, 3, 'indoor', ARRAY['spring','summer'], ARRAY['ramazan','iftar','oruç','gelenek','sofra','manevi','dua'], false, true);

-- 17. hanukkah-candle-ceremony
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'hanukkah-candle-ceremony',
'Hanuka Mum Yakma Töreni', 'Hanukkah Candle Ceremony',
'Hanuka bayramı için özel bir mum yakma töreni düzenleyin. El yapımı veya özel tasarlanmış bir menora hazırlayın. Her gece bir mum yakarken, aile üyelerinden sırayla o yılın minnettarlıklarını paylaşmalarını isteyin. Geleneksel sufganiyot (çörek) ve latke (patates köftesi) hazırlayın. Çocuklar için dreidel oyun turnuvası organize edin. Her gece için küçük hediyeler sarın ve mum yakma sonrası dağıtın. Sekizinci gecede büyük bir aile yemeği düzenleyin. Menora ışığında aile fotoğrafları çekin. Bu sekiz gecelik kutlama, aile birliğini ve minnettarlığı simgeler.',
'Organize a special candle lighting ceremony for Hanukkah. Prepare a handmade or custom-designed menorah. As one candle is lit each night, ask family members to take turns sharing their gratitude for the year. Prepare traditional sufganiyot (doughnuts) and latke (potato pancakes). Organize a dreidel game tournament for children. Wrap small gifts for each night and distribute after candle lighting. Host a large family dinner on the eighth night. Take family photos by menorah light. This eight-night celebration symbolizes family unity and gratitude.',
'Menora, geleneksel yemekler ve hediyelerle Hanuka mum yakma töreni düzenleyin.',
'Organize a Hanukkah candle lighting ceremony with menorah, traditional food, and gifts.',
2, 300, 1500, 4, 15, 5, 'indoor', ARRAY['winter'], ARRAY['hanuka','mum','menora','gelenek','aile','tören','ışık'], false, false);

-- 18. diwali-light-celebration
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'diwali-light-celebration',
'Diwali Işık Festivali Kutlaması', 'Diwali Light Festival Celebration',
'Diwali''nin büyüsünü yaşatan renkli bir ışık festivali kutlaması düzenleyin. Evi ve bahçeyi yüzlerce mum, kandil ve LED ışıkla aydınlatın. Kapının önüne renkli tozlarla geleneksel rangoli desenleri çizin. Hint mutfağından tatlılar hazırlayın: gulab jamun, laddu, barfi. Renkli sari ve geleneksel kıyafetler giyin. Akşam herkesin elinde bir kandil tutarak dilek dilediği bir tören yapın. Maytap ve havai fişek gösterisi düzenleyin. Bollywood müzikleriyle dans edin. Davetlilere renkli toz paketleri ve tatlı kutuları hediye edin. Bu festival, ışığın karanlığa galip geldiğini kutlar.',
'Organize a colorful light festival celebration capturing the magic of Diwali. Illuminate the house and garden with hundreds of candles, oil lamps, and LED lights. Draw traditional rangoli patterns with colorful powders in front of the door. Prepare Indian sweets: gulab jamun, laddu, barfi. Wear colorful saris and traditional outfits. In the evening, hold a ceremony where everyone holds a lamp and makes a wish. Organize a sparkler and fireworks show. Dance to Bollywood music. Gift guests colorful powder packets and sweet boxes. This festival celebrates light triumphing over darkness.',
'Yüzlerce mum ve renkli süslemelerle Diwali ışık festivali kutlaması düzenleyin.',
'Organize a Diwali light festival celebration with hundreds of candles and colorful decorations.',
3, 1000, 5000, 8, 40, 7, 'both', ARRAY['fall'], ARRAY['diwali','ışık','festival','renkli','mum','Hint','kutlama','dans'], false, false);

-- 19. chinese-new-year-party
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'chinese-new-year-party',
'Çin Yeni Yılı Partisi', 'Chinese New Year Party',
'Çin Yeni Yılı''nı geleneksel ve modern unsurlarla kutlayan renkli bir parti düzenleyin. Mekanı kırmızı fenerler, ejderha süslemeleri ve altın renkli aksesuarlarla süsleyin. Geleneksel Çin yemekleri hazırlayın: dim sum, erişteli çorba, portakallı tavuk, baharatlı tofu. Kırmızı zarflar içinde şanslı para hediye edin. Ejderha dansı performansı organize edin veya video gösterimi yapın. Çin burçları hakkında eğlenceli bir sunum yapın. Dilekler yazılmış kağıtları fener balonu ile gökyüzüne bırakın. Herkes kırmızı bir parça giyerek gelsin. Pasta yerine ay çöreği ikram edin.',
'Organize a colorful party celebrating Chinese New Year with traditional and modern elements. Decorate the venue with red lanterns, dragon decorations, and gold accessories. Prepare traditional Chinese dishes: dim sum, noodle soup, orange chicken, spicy tofu. Gift lucky money in red envelopes. Organize a dragon dance performance or video screening. Give a fun presentation about Chinese zodiac signs. Release wish-written papers to the sky with sky lanterns. Everyone should come wearing something red. Serve mooncakes instead of regular cake.',
'Kırmızı fenerler, ejderha dansı ve geleneksel yemeklerle Çin Yeni Yılı kutlayın.',
'Celebrate Chinese New Year with red lanterns, dragon dance, and traditional food.',
3, 1000, 4000, 8, 30, 7, 'both', ARRAY['winter'], ARRAY['Çin','yeni yıl','fener','ejderha','kırmızı','gelenek','parti','şans'], false, false);

-- 20. republic-day-celebration
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'republic-day-celebration',
'Cumhuriyet Bayramı Kutlaması', 'Republic Day Celebration',
'29 Ekim Cumhuriyet Bayramı''nı coşkuyla kutlamak için özel bir organizasyon yapın. Mekanı Türk bayrakları, kırmızı beyaz balonlar ve Atatürk posterleriyle süsleyin. Çocuklar için bayrak boyama atölyesi düzenleyin. Cumhuriyetin kuruluş hikayesini anlatan kısa bir gösteri veya sunum hazırlayın. Hep birlikte İstiklal Marşı okuyun. Geleneksel Türk halk müziği eşliğinde halay çekin. Bayrama özel pasta kesin: üzerinde ay yıldız ve "100. Yıl" yazısı olsun. Akşam fener alayı düzenleyin, ellerinde Türk bayrakları ve fenerlerle mahallede yürüyün.',
'Organize a special event to enthusiastically celebrate October 29th Republic Day. Decorate the venue with Turkish flags, red and white balloons, and Ataturk posters. Organize a flag painting workshop for children. Prepare a short show or presentation telling the story of the Republic''s founding. Sing the national anthem together. Dance folk dances accompanied by traditional Turkish folk music. Cut a special holiday cake with a crescent star and "Centennial" written on it. In the evening, organize a lantern parade, walking through the neighborhood with Turkish flags and lanterns.',
'Bayraklar, etkinlikler ve fener alayıyla coşkulu Cumhuriyet Bayramı kutlaması.',
'An enthusiastic Republic Day celebration with flags, activities, and lantern parade.',
2, 500, 3000, 10, 100, 5, 'both', ARRAY['fall'], ARRAY['cumhuriyet','bayram','bayrak','Atatürk','kutlama','milli','halay','fener'], false, false);

-- 21. teachers-day-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'teachers-day-surprise',
'Öğretmenler Günü Sürprizi', 'Teachers'' Day Surprise',
'24 Kasım Öğretmenler Günü''nde öğretmeninize unutulmaz bir sürpriz yapın. Sınıfı gizlice çiçekler, balonlar ve tebrik pankartlarıyla süsleyin. Her öğrenciden öğretmene yazdığı bir teşekkür mektubu toplayarak güzel bir deftere yapıştırın. Öğretmen sınıfa girdiğinde herkes ayağa kalkıp alkışlasın. Koro halinde hazırlanmış bir şarkı söyleyin. Öğretmenin en sevdiği çiçeği bir buketle birlikte sunun. Eski öğrencilerden video mesajlar toplayarak sürprize ekleyin. Öğretmenin gözyaşlarına hazır olun! Günün sonunda sınıf fotoğrafı çekerek çerçeveleyip hediye edin.',
'Create an unforgettable surprise for your teacher on November 24th Teachers'' Day. Secretly decorate the classroom with flowers, balloons, and congratulatory banners. Collect thank-you letters from each student and paste them in a beautiful notebook. When the teacher enters the classroom, everyone stands and applauds. Sing a song prepared as a choir. Present a bouquet with the teacher''s favorite flowers. Collect video messages from former students and add them to the surprise. Be ready for the teacher''s tears! At the end of the day, take a class photo, frame it, and gift it.',
'Sınıfı gizlice süsleyerek ve mektuplarla öğretmeninize unutulmaz sürpriz yapın.',
'Create an unforgettable surprise for your teacher with secret decorations and letters.',
1, 100, 500, 10, 40, 3, 'indoor', ARRAY['fall'], ARRAY['öğretmen','24 kasım','teşekkür','mektup','sınıf','sürpriz','eğitim'], false, false);

-- 22. childrens-day-party
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'childrens-day-party',
'23 Nisan Çocuk Bayramı Partisi', 'Children''s Day Party',
'23 Nisan Ulusal Egemenlik ve Çocuk Bayramı''nda çocuklar için muhteşem bir parti düzenleyin. Mahalledeki çocukları davet edin. Yüz boyama, balon sanatı ve sihirbazlık gösterisi organize edin. Palyaço veya animatör tutun. Bayrak yarışı, sandalye kapmaca ve müzikli sandalye gibi geleneksel oyunlar oynayın. Her çocuğa kırmızı beyaz kostüm veya şapka dağıtın. Pasta kesimi yapın; üzerinde Türk bayrağı ve "23 Nisan" yazısı olsun. Ödül dağıtım töreni düzenleyerek her çocuğa katılım sertifikası ve küçük hediye verin.',
'Organize a magnificent party for children on April 23rd National Sovereignty and Children''s Day. Invite neighborhood children. Organize face painting, balloon art, and magic shows. Hire a clown or animator. Play traditional games like relay races, musical chairs, and freeze dance. Distribute red and white costumes or hats to each child. Cut a cake with the Turkish flag and "April 23" written on it. Hold a prize distribution ceremony giving each child a participation certificate and small gift.',
'Yüz boyama, oyunlar ve gösterilerle çocuklar için 23 Nisan partisi düzenleyin.',
'Organize an April 23rd party for children with face painting, games, and shows.',
2, 500, 3000, 10, 50, 5, 'outdoor', ARRAY['spring'], ARRAY['23 nisan','çocuk','bayram','oyun','eğlence','parti','kutlama'], false, false);

-- 23. labor-day-appreciation
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'labor-day-appreciation',
'İşçi Bayramı Takdir Sürprizi', 'Labor Day Appreciation Surprise',
'1 Mayıs İşçi Bayramı''nda çalışanları ve emekçileri onurlandıran bir takdir sürprizi organize edin. Ofiste veya iş yerinde herkesin masasına teşekkür kartı ve küçük hediye bırakın. Ortak alanlarda kahvaltı büfesi kurun. "Ayın Çalışanı" yerine "Yılın Kahramanları" ödül töreni düzenleyin; herkese bir ödül verin. Çalışanların ailelerine teşekkür mektubu gönderin. Öğle yemeğini birlikte dışarıda yiyin. Herkesin mesleğiyle ilgili en komik anısını paylaştığı bir oturum düzenleyin. Bu gün, emeğe saygıyı somut olarak gösterir ve çalışan motivasyonunu artırır.',
'Organize an appreciation surprise honoring workers and laborers on May 1st Labor Day. Leave thank-you cards and small gifts on everyone''s desk at the office or workplace. Set up a breakfast buffet in common areas. Hold a "Heroes of the Year" award ceremony instead of "Employee of the Month" — give everyone an award. Send thank-you letters to employees'' families. Have lunch together outdoors. Hold a session where everyone shares their funniest work-related memory. This day tangibly demonstrates respect for labor and boosts employee motivation.',
'1 Mayıs''ta çalışanları onurlandıran hediyeler ve ödül töreni düzenleyin.',
'Organize gifts and an award ceremony honoring workers on May 1st.',
1, 200, 1000, 5, 50, 2, 'indoor', ARRAY['spring'], ARRAY['işçi bayramı','emek','takdir','ödül','çalışan','teşekkür','1 mayıs'], false, false);

-- 24. womens-day-celebration
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'womens-day-celebration',
'Kadınlar Günü Kutlaması', 'Women''s Day Celebration',
'8 Mart Dünya Kadınlar Günü''nde hayatınızdaki kadınlara özel bir kutlama düzenleyin. Her kadına kişiselleştirilmiş bir çiçek buketi ve el yazısıyla yazılmış bir mektup hazırlayın. Kadınların başarı hikayelerini anlatan bir sunum yapın. Spa veya güzellik günü organize edin: manikür, masaj, cilt bakımı. Kadınların bir araya geldiği bir brunch düzenleyin. Hayatınızdaki kadınların size öğrettiği en değerli dersleri anlatan kısa videolar hazırlayın. Mentorluk yapan kadınlara özel teşekkür plaketi takdim edin. Günün sonunda grup fotoğrafı çekin.',
'Organize a special celebration for the women in your life on March 8th International Women''s Day. Prepare a personalized flower bouquet and a handwritten letter for each woman. Give a presentation sharing women''s success stories. Organize a spa or beauty day: manicure, massage, skincare. Host a brunch where women come together. Prepare short videos sharing the most valuable lessons the women in your life taught you. Present special thank-you plaques to mentoring women. Take a group photo at the end of the day.',
'8 Mart''ta hayatınızdaki kadınları çiçek, mektup ve spa günüyle kutlayın.',
'Celebrate the women in your life with flowers, letters, and a spa day on March 8th.',
2, 500, 3000, 3, 20, 5, 'both', ARRAY['spring'], ARRAY['kadınlar günü','8 mart','çiçek','kutlama','kadın','takdir','güzellik'], false, false);

-- 25. nevruz-spring-festival
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'nevruz-spring-festival',
'Nevruz Bahar Festivali', 'Nevruz Spring Festival',
'Nevruz''u geleneksel ve modern unsurlarla kutlayan bir bahar festivali düzenleyin. Açık alanda büyük bir ateş yakarak geleneksel ateş atlama töreni yapın. Sofraya yedi adet "S" ile başlayan yiyecek koyun: semeni, sirke, sumak, siyah üzüm, sebze, süt ve sarımsak. Halk oyunları ekibi eşliğinde halay çekin. Çocuklar için yumurta boyama ve yumurta tokuşturma yarışması düzenleyin. Canlı müzik ve saz eşliğinde türküler söyleyin. Dilek kağıtlarını ateşe atarak yeni başlangıçlar için niyet belirleyin. Geleneksel kıyafetlerle renkli bir atmosfer yaratın.',
'Organize a spring festival celebrating Nevruz with traditional and modern elements. Light a large bonfire in an open area and hold a traditional fire-jumping ceremony. Place seven foods starting with "S" on the table: semeni, vinegar, sumac, black grapes, vegetables, milk, and garlic. Dance folk dances accompanied by a folk dance team. Organize egg painting and egg tapping contests for children. Sing folk songs accompanied by live music and saz. Throw wish papers into the fire to set intentions for new beginnings. Create a colorful atmosphere with traditional outfits.',
'Ateş atlama, halk oyunları ve geleneksel sofrayla Nevruz bahar festivali düzenleyin.',
'Organize a Nevruz spring festival with fire jumping, folk dances, and traditional table.',
3, 1000, 5000, 15, 100, 7, 'outdoor', ARRAY['spring'], ARRAY['nevruz','bahar','ateş','gelenek','halk oyunu','festival','yeniden doğuş'], false, true);

-- 26. summer-solstice-party
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'summer-solstice-party',
'Yaz Gündönümü Partisi', 'Summer Solstice Party',
'Yılın en uzun gününü kutlayan büyük bir açık hava partisi düzenleyin. Gün batımında başlayan ve gece yarısına kadar süren bir kutlama planlayın. Mekanı çiçek çelenklerle, renkli kumaşlarla ve meşalelerle süsleyin. Açık ateşte barbekü yapın ve tropik kokteyller hazırlayın. Güneş batarken yoga veya meditasyon seansı düzenleyin. Gece gökyüzünü izlemek için battaniyeler serin. Canlı akustik müzik eşliğinde dans edin. Dileklerinizi yazarak denize veya nehre bırakacağınız küçük tekneler hazırlayın. Gecenin sonunda herkes bir çiçek çelengi taksın.',
'Organize a big outdoor party celebrating the longest day of the year. Plan a celebration that starts at sunset and lasts until midnight. Decorate the venue with flower wreaths, colorful fabrics, and torches. Barbecue over open fire and prepare tropical cocktails. Hold a yoga or meditation session as the sun sets. Lay blankets for stargazing at night. Dance to live acoustic music. Make small boats with your wishes written on them to release into the sea or river. At the end of the night, everyone wears a flower wreath.',
'Yılın en uzun gününü açık havada barbekü, müzik ve çiçek çelenklerle kutlayın.',
'Celebrate the longest day of the year outdoors with barbecue, music, and flower wreaths.',
3, 1000, 4000, 10, 40, 5, 'outdoor', ARRAY['summer'], ARRAY['yaz','gündönümü','açık hava','barbekü','çiçek','gece','parti','doğa'], false, false);

-- 27. autumn-harvest-festival
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'autumn-harvest-festival',
'Sonbahar Hasat Festivali', 'Autumn Harvest Festival',
'Sonbaharın bereketini kutlayan bir hasat festivali düzenleyin. Bahçeyi veya mekanı bal kabakları, mısır koçanları, saman balyaları ve sonbahar yapraklarıyla süsleyin. Tarladan sofraya konseptli bir yemek hazırlayın: mevsim sebzeleriyle çorba, fırında kabak, elmalı turta. Elma toplama veya üzüm hasadı aktivitesi organize edin. Çocuklar için balkabağı oyma atölyesi yapın. Sıcak elmalı şarap veya sıcak çikolata ikram edin. Arka planda akustik folk müzik çalsın. Herkes sonbahar renklerinde kıyafetler giysin. Günün sonunda şükran halka olarak teşekkürlerinizi paylaşın.',
'Organize a harvest festival celebrating autumn''s abundance. Decorate the garden or venue with pumpkins, corn cobs, straw bales, and autumn leaves. Prepare a farm-to-table concept meal: seasonal vegetable soup, roasted squash, apple pie. Organize apple picking or grape harvesting activities. Hold a pumpkin carving workshop for children. Serve hot mulled wine or hot chocolate. Play acoustic folk music in the background. Everyone wears clothes in autumn colors. At the end of the day, share your gratitude in a thankfulness circle.',
'Balkabakları, hasat aktiviteleri ve mevsim lezzetleriyle sonbahar festivali düzenleyin.',
'Organize an autumn festival with pumpkins, harvest activities, and seasonal flavors.',
2, 500, 2500, 8, 40, 5, 'outdoor', ARRAY['fall'], ARRAY['sonbahar','hasat','festival','balkabağı','doğa','mevsim','bereket'], false, false);

-- 28. winter-solstice-gathering
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'winter-solstice-gathering',
'Kış Gündönümü Buluşması', 'Winter Solstice Gathering',
'Yılın en uzun gecesini sıcak bir ev buluşmasıyla kutlayın. Evi mumlar, şömine ışığı ve yıldız süslemeleriyle donatın. Sıcak çorba, kestane ve sıcak içecek büfesi hazırlayın. Herkesin bir battaniyeye sarınarak yere oturduğu samimi bir ortam yaratın. Sırayla yılın en güzel anısını paylaşın. Gece gökyüzünü izlemek için dışarı çıkın. Yeni yıla kadar olan sürede günlerin uzayacağını kutlayarak umut tohumları ekin. Dilek mumları yakarak dileklerinizi paylaşın. Bu samimi buluşma, kışın soğuğunda kalpleri ısıtır.',
'Celebrate the longest night of the year with a warm home gathering. Decorate the house with candles, fireplace light, and star decorations. Prepare hot soup, chestnuts, and a warm beverage buffet. Create an intimate atmosphere where everyone wraps in a blanket and sits on the floor. Take turns sharing the best memory of the year. Go outside to stargaze. Plant seeds of hope by celebrating that days will grow longer until the new year. Light wish candles and share your wishes. This intimate gathering warms hearts in the cold of winter.',
'Yılın en uzun gecesini mumlar, sıcak içecekler ve samimi sohbetlerle kutlayın.',
'Celebrate the longest night with candles, warm drinks, and intimate conversations.',
1, 200, 800, 4, 15, 2, 'indoor', ARRAY['winter'], ARRAY['kış','gündönümü','sıcak','mum','samimi','gece','buluşma','ev'], false, false);

-- 29. friendship-day-celebration
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'friendship-day-celebration',
'Arkadaşlık Günü Kutlaması', 'Friendship Day Celebration',
'En yakın arkadaşlarınızla unutulmaz bir Arkadaşlık Günü kutlaması düzenleyin. Her arkadaşa özel yazılmış mektuplar hazırlayın; içinde birlikte yaşadığınız en güzel anıları ve onlara ne kadar minnettar olduğunuzu anlatın. Arkadaşlık bilekliği yapma atölyesi düzenleyin. Birlikte eski fotoğrafları gözden geçirip anı albümü oluşturun. Favorit arkadaşlık filmini izleyin. Herkesin en komik ortak anısını anlattığı bir tur yapın. Arkadaşlık yemini okuyun ve geleceğe dair planlar yapın. Grup fotoğrafı çekin ve her birine baskısını hediye edin.',
'Organize an unforgettable Friendship Day celebration with your closest friends. Prepare specially written letters for each friend describing your best shared memories and how grateful you are for them. Hold a friendship bracelet making workshop. Review old photos together and create a memory album. Watch your favorite friendship movie. Have a round where everyone tells their funniest shared memory. Read a friendship oath and make plans for the future. Take a group photo and gift each person a print.',
'Mektuplar, bileklik yapımı ve anı paylaşımlarıyla arkadaşlık günü kutlayın.',
'Celebrate friendship day with letters, bracelet making, and sharing memories.',
1, 200, 1000, 3, 12, 3, 'both', ARRAY['summer'], ARRAY['arkadaşlık','kutlama','mektup','bileklik','anı','eğlence','dostluk'], false, false);

-- 30. grandparents-day-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'grandparents-day-surprise',
'Büyükanne Büyükbaba Günü Sürprizi', 'Grandparents'' Day Surprise',
'Büyükanne ve büyükbabanız için duygusal bir sürpriz günü organize edin. Torunlardan ve çocuklardan video mesajlar toplayarak bir montaj hazırlayın. Eski aile fotoğraflarını taratarak dijital bir albüm oluşturun. Büyükanne veya büyükbabanın gençlik fotoğraflarını yeniden canlandırarak aynı pozlarda yeni fotoğraflar çekin. Birlikte eski bir aile tarifini pişirin. Onların gençliğinden bir şarkıyı birlikte söyleyin. El izi baskısıyla aile ağacı tablosu hazırlayarak hediye edin. Hayat hikayelerini kaydedin; bu kayıtlar gelecek nesiller için paha biçilmez olacaktır.',
'Organize an emotional surprise day for your grandparents. Collect video messages from grandchildren and children to create a montage. Scan old family photos and create a digital album. Recreate grandparent''s youth photos by taking new photos in the same poses. Cook an old family recipe together. Sing a song from their youth together. Create a family tree painting with handprints and gift it. Record their life stories; these recordings will be priceless for future generations.',
'Video montaj, eski fotoğraf canlandırma ve aile tarifleriyle büyüklere sürpriz.',
'Surprise grandparents with video montage, photo recreation, and family recipes.',
2, 200, 1000, 4, 15, 7, 'indoor', ARRAY['fall'], ARRAY['büyükanne','büyükbaba','aile','anı','video','fotoğraf','gelenek','sevgi'], false, false);

-- 31. pet-birthday-party
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'pet-birthday-party',
'Evcil Hayvan Doğum Günü Partisi', 'Pet Birthday Party',
'Evcil hayvanınız için sevimli bir doğum günü partisi düzenleyin. Hayvan dostu malzemelerden pasta hazırlayın: köpekler için fıstık ezmeli pasta, kediler için ton balıklı kek. Parti şapkası ve papyon taktırın. Arkadaşlarınızı evcil hayvanlarıyla birlikte davet edin. Bahçede engel parkuru kurarak yarışma düzenleyin. Her hayvana isimli doğum günü hediye paketi hazırlayın. Profesyonel pet fotoğrafçısıyla çekim yapın. Parti alanını pati izli balonlar ve kemik şeklinde süslemelerle donatın. Hayvan barınağına bağış yaparak kutlamayı anlamlı kılın.',
'Organize an adorable birthday party for your pet. Make a cake from pet-friendly ingredients: peanut butter cake for dogs, tuna cake for cats. Put on a party hat and bow tie. Invite friends with their pets. Set up an obstacle course in the garden for competitions. Prepare named birthday gift packages for each animal. Do a photoshoot with a professional pet photographer. Decorate the party area with paw-print balloons and bone-shaped decorations. Make the celebration meaningful by donating to an animal shelter.',
'Evcil hayvanınız için pasta, oyunlar ve kostümlerle doğum günü partisi düzenleyin.',
'Organize a birthday party for your pet with cake, games, and costumes.',
2, 300, 1500, 3, 15, 3, 'outdoor', ARRAY['spring','summer','fall','winter'], ARRAY['evcil hayvan','doğum günü','parti','köpek','kedi','sevimli','pasta'], false, false);

-- 32. housewarming-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'housewarming-surprise',
'Ev Isınma Sürprizi', 'Housewarming Surprise',
'Yeni eve taşınan arkadaşınız veya aileniz için sürpriz bir ev ısınma partisi düzenleyin. Taşınmadan önce gizlice eve girerek hoş geldin süsleri asın, balonlar şişirin ve mutfağa temel gıda malzemeleri yerleştirin. Kapının önüne özel bir paspas ve saksı çiçeği koyun. Her misafirden yeni eve bir "ev kuralı" yazmasını isteyin ve bunları komik bir çerçeveye yerleştirin. Ev sahiplerine pratik hediyeler verin: mutfak seti, havlu takımı, bitki, mum. Komşularla tanışma kokteyli düzenleyin. Evin ilk yemeğini birlikte pişirin ve şerefe kadeh kaldırın.',
'Organize a surprise housewarming party for a friend or family member moving to a new home. Secretly enter the house before the move to hang welcome decorations, inflate balloons, and stock the kitchen with basic groceries. Place a special doormat and potted flower at the front door. Ask each guest to write a "house rule" for the new home and put them in a funny frame. Give the homeowners practical gifts: kitchen set, towel set, plants, candles. Organize a cocktail to meet the neighbors. Cook the home''s first meal together and raise a toast.',
'Yeni eve gizlice süslemeler ve hediyelerle sürpriz ev ısınma partisi düzenleyin.',
'Organize a surprise housewarming party with secret decorations and gifts.',
2, 500, 3000, 5, 25, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['ev','taşınma','sürpriz','hediye','komşu','parti','yeni başlangıç'], false, false);

-- 33. name-day-celebration
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'name-day-celebration',
'İsim Günü Kutlaması', 'Name Day Celebration',
'Sevdiğiniz birinin isim gününü özel bir kutlamayla taçlandırın. Kişinin isminin anlamını ve kökenini araştırarak güzel bir sunum hazırlayın. İsminin farklı dillerdeki karşılıklarını gösteren bir poster tasarlayın. İsmiyle aynı harfle başlayan hediyeler verin: örneğin Ayşe için ayçiçeği, ayna ve ayıcık. İsim günü pastasına ismini şeker hamuruyla yazın. Kişinin ismini taşıyan ünlülerin listesini hazırlayarak eğlenceli bir quiz yapın. İsmin hikayesini anlatan kişiselleştirilmiş bir kitap hazırlatın. Bu nadir kutlanan gün, kişiyi çok özel hissettirir.',
'Crown your loved one''s name day with a special celebration. Research the meaning and origin of the person''s name and prepare a beautiful presentation. Design a poster showing the name''s equivalents in different languages. Give gifts starting with the same letter as their name. Write the name in fondant on the name day cake. Prepare a list of famous people sharing the name and create a fun quiz. Commission a personalized book telling the story of the name. This rarely celebrated day makes the person feel very special.',
'İsmin anlamı, kökenini keşfeden sunum ve kişisel hediyelerle isim günü kutlayın.',
'Celebrate name day with a presentation exploring the name''s meaning and personalized gifts.',
2, 200, 1000, 3, 15, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['isim günü','kutlama','kişisel','anlam','hediye','özel','gelenek'], false, false);

-- 34. engagement-party-surprise
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'engagement-party-surprise',
'Nişan Sürpriz Partisi', 'Engagement Party Surprise',
'Nişan çiftine sürpriz bir kutlama partisi düzenleyin. Çiftin favori mekanını veya restoranı gizlice kiralayın. Mekanı çiftin aşk hikayesinden fotoğraflarla, çiçeklerle ve ışık süslemeleriyle donatın. Girişteki kronoloji duvarında tanışmalarından nişana kadar olan süreci gösterin. Gizlice toplanan ailelerden ve arkadaşlardan tebrik videoları hazırlayın. Çift kapıdan girdiğinde konfeti patlasın ve herkes "Sürpriz!" diye bağırsın. Yüzük takma töreni için özel bir köşe hazırlayın. Canlı müzik eşliğinde ilk danslarını yapsınlar. Pasta kesiminde maytap ve ışık gösterisi yapın.',
'Organize a surprise celebration party for the engaged couple. Secretly rent the couple''s favorite venue or restaurant. Decorate the venue with photos from the couple''s love story, flowers, and light decorations. Show the timeline from meeting to engagement on a chronology wall at the entrance. Prepare congratulation videos secretly collected from families and friends. When the couple enters, pop confetti and have everyone shout "Surprise!" Prepare a special corner for the ring ceremony. Have them do their first dance to live music. Create a sparkler and light show during cake cutting.',
'Nişan çiftine gizlice planlanan sürpriz kutlama partisi düzenleyin.',
'Organize a secretly planned surprise celebration party for the engaged couple.',
4, 5000, 20000, 20, 80, 14, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['nişan','sürpriz','parti','çift','aşk','kutlama','tören','dans'], true, false);

-- 35. retirement-farewell-party
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_holiday, 'retirement-farewell-party',
'Emeklilik Veda Partisi', 'Retirement Farewell Party',
'Emekliye ayrılan kişi için hem duygusal hem eğlenceli bir veda partisi düzenleyin. Kariyer boyunca çalıştığı tüm departmanlardan temsilciler davet edin. Mekanı kişinin kariyer fotoğraflarıyla ve dönüm noktalarını gösteren bir zaman tüneliyle süsleyin. "Bu Kim?" oyunu oynayın: bebek ve gençlik fotoğraflarını tahtaya asarak tahmin etmeye çalışın. Her bölümden bir kişi komik veya duygusal bir anı paylaşsın. Altın saat veya kişiselleştirilmiş bir hediye takdim edin. Emekliliğe özel bir pasta kesin. Gecenin sonunda tüm ekibin imzaladığı bir anı defteri ve gelecek planları kuponu hediye edin.',
'Organize both an emotional and fun farewell party for the retiree. Invite representatives from all departments they worked with throughout their career. Decorate the venue with the person''s career photos and a time tunnel showing milestones. Play a "Who Is This?" game: pin baby and youth photos on the board and try to guess. Have one person from each department share a funny or emotional memory. Present a gold watch or personalized gift. Cut a retirement-special cake. At the end of the night, gift a memory book signed by the entire team and a future plans coupon.',
'Kariyer fotoğrafları, anılar ve özel hediyelerle duygusal emeklilik vedası düzenleyin.',
'Organize an emotional retirement farewell with career photos, memories, and special gifts.',
3, 2000, 10000, 15, 80, 10, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['emeklilik','veda','kariyer','parti','anı','hediye','duygusal','tören'], true, false);

END $$;
