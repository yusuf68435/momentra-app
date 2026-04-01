-- ==========================================
-- SEED: 75 Scenarios — PROPOSAL (40) + BIRTHDAY (35)
-- Part 1 of scenario expansion
-- ==========================================

DO $$
DECLARE
  cat_proposal uuid;
  cat_birthday uuid;
BEGIN

SELECT id INTO cat_proposal FROM public.categories WHERE slug = 'proposal';
SELECT id INTO cat_birthday FROM public.categories WHERE slug = 'birthday';

-- ==========================================
-- PROPOSAL — 40 scenarios
-- ==========================================

-- 1. escape-room-proposal (difficulty:4, indoor, premium:false, featured:true)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'escape-room-proposal',
'Escape Room''da Evlilik Teklifi', 'Escape Room Proposal',
'Bir escape room mekanıyla anlaşarak son bulmacayı kişiselleştirin. Partneriniz bulmacayı çözdüğünde açılan kutuda yüzük, aşk mektupları ve ilişkinizden fotoğraflar bulunsun. Oyun ustası size gizli bir anahtar vererek "bulunan ipucu" olarak yerleştirmenizi sağlar. Takım çalışmasının adrenalini ile samimi bir sürpriz anını birleştiren bu senaryo, partnerinizin bulmacalara o kadar odaklanmasını sağlar ki teklifi asla tahmin edemez. Odadan çıktığınızda arkadaşlarınız konfeti ve şampanyayla karşılasın.',
'Coordinate with an escape room venue to customize the final puzzle. When your partner solves it, it unlocks a box containing the engagement ring, love letters, and photos from your relationship. The game master gives you a secret key to plant as a "found clue." This scenario combines the adrenaline of teamwork with an intimate surprise moment — your partner is so focused on puzzles they never see it coming. When you exit the room, have friends waiting with confetti and champagne.',
'Escape room''da son bulmacayı kişiselleştirerek unutulmaz bir teklif anı yaratın.',
'Create an unforgettable proposal by customizing the final escape room puzzle.',
4, 1000, 3000, 2, 8, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['escape room','bulmaca','macera','yaratıcı','teklif','takım'], false, true);

-- 2. minecraft-world-proposal (difficulty:3, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'minecraft-world-proposal',
'Minecraft Dünyasında Evlilik Teklifi', 'Minecraft World Proposal',
'Partnerinizin en sevdiği oyunda özel bir dünya inşa edin. İlk buluşmanızın geçtiği mekanı, birlikte gittiğiniz yerleri blok blok yeniden yaratın. Dünyanın sonunda dev harflerle "Benimle evlenir misin?" yazılı bir alan oluşturun. Yolda sandıklara fotoğraflarınızın linklerini ve anı notlarını gizleyin. Partnerinizi "yeni bir harita deneyeceğiz" diyerek oyuna davet edin. Ekrandaki soruyu gördüğünde gerçek yüzüğü çıkarın. Oyun severler için dijital ve gerçek dünyayı birleştiren eşsiz bir deneyim.',
'Build a custom world in your partner''s favorite game. Recreate your first date location, places you visited together, block by block. At the end of the world, create a giant area spelling "Will you marry me?" Hide photo links and memory notes in chests along the way. Invite your partner to play saying "let''s try a new map." When they see the question on screen, pull out the real ring. A unique experience for gamers that bridges the digital and real world.',
'Minecraft''ta özel bir dünya inşa ederek dijital ve gerçek aşkı birleştirin.',
'Build a custom Minecraft world that bridges digital and real-world love.',
3, 200, 800, 2, 2, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['oyun','minecraft','dijital','yaratıcı','teknoloji','eğlenceli'], false, false);

-- 3. custom-storybook-proposal (difficulty:4, indoor, premium:true, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'custom-storybook-proposal',
'Kişisel Hikaye Kitabıyla Teklif', 'Custom Storybook Proposal',
'İlişkinizin hikayesini çocuk kitabı tarzında illüstrasyonlarla anlatan özel bir kitap tasarlayın. Bir illüstratörle çalışarak tanışmanızı, ilk buluşmanızı, komik anılarınızı ve dönüm noktalarınızı renkli çizimlerle canlandırın. Son sayfada boş bir kutucuk bırakın ve "Bu hikayenin devamını birlikte yazmak ister misin?" yazısının altına gerçek yüzüğü yerleştirin. Kitabı özel bir akşam yemeğinde hediye edin. Her sayfayı birlikte okurken duygusal bir yolculuğa çıkacaksınız.',
'Design a custom book that tells your relationship story with children''s book-style illustrations. Work with an illustrator to bring your first meeting, first date, funny moments, and milestones to life with colorful drawings. Leave a blank box on the last page with the text "Would you like to write the next chapter together?" and place the real ring underneath. Gift the book during a special dinner. You''ll go on an emotional journey as you read each page together.',
'İlişkinizi çocuk kitabı illüstrasyonlarıyla anlatarak duygusal bir teklif yapın.',
'Tell your love story through children''s book illustrations for an emotional proposal.',
4, 3000, 8000, 2, 2, 30, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kitap','illüstrasyon','sanat','duygusal','yaratıcı','kişisel'], true, false);

-- 4. meteor-shower-proposal (difficulty:3, outdoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'meteor-shower-proposal',
'Meteor Yağmuru Altında Teklif', 'Meteor Shower Proposal',
'Yılın en güzel meteor yağmurunu araştırın — Perseid (Ağustos) veya Geminid (Aralık) idealdir. Şehir ışıklarından uzak bir tepeye battaniye, sıcak çikolata termosu ve yastıklar hazırlayın. Gökyüzünü izlerken önceden hazırladığınız küçük bir teleskop veya dürbünü kullanın. İlk yıldız kayması anında "Bir dilek tut" deyin, sonra diz çökerek "Benim dileğim sensin" ile devam edin. Gökyüzünün doğal ışık şovuyla birleşen bu an, hiçbir yapay efektin veremeyeceği bir büyü yaratır.',
'Research the year''s best meteor shower — Perseid (August) or Geminid (December) are ideal. Prepare blankets, a thermos of hot chocolate, and pillows on a hilltop away from city lights. Use a small telescope or binoculars you''ve prepared beforehand. At the first shooting star, say "Make a wish," then get on one knee and continue with "My wish is you." Combined with the sky''s natural light show, this moment creates a magic that no artificial effect could replicate.',
'Meteor yağmuru altında doğanın ışık şovuyla büyüleyici bir teklif yapın.',
'Propose under a meteor shower with nature''s own magical light show.',
3, 300, 1500, 2, 2, 10, 'outdoor', ARRAY['summer','winter'], ARRAY['doğa','yıldız','gökyüzü','romantik','gece','macera'], false, false);

-- 5. planetarium-proposal (difficulty:2, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'planetarium-proposal',
'Planetaryumda Yıldızlar Altında Teklif', 'Planetarium Proposal',
'Yerel planetaryumla iletişime geçerek özel bir gösteri sırasında veya sonrasında teklif için izin alın. Gösterinin son dakikalarında kişisel bir mesajın kubbede belirmesini talep edin — örneğin "Seninle aynı yıldızların altında bir ömür geçirmek istiyorum." Karanlıkta yıldızların parıldadığı kubbede, yüzüğü partnerinize uzatın. Bazı planetaryumlar özel seans düzenleyebilir; bu durumda müzik listenizi de ekleyebilirsiniz. Hava koşullarından bağımsız, romantik ve kontrollü bir ortamda unutulmaz bir an yaşayın.',
'Contact your local planetarium to arrange a proposal during or after a special show. Request a personal message to appear on the dome in the final minutes — for example, "I want to spend a lifetime under the same stars with you." Present the ring to your partner under the dome glittering with stars in darkness. Some planetariums can arrange private sessions where you can also add your music playlist. Experience an unforgettable moment in a romantic, controlled environment regardless of weather.',
'Planetaryumda yıldızların altında romantik ve büyüleyici bir teklif yapın.',
'Propose under the stars at a planetarium for a romantic, weather-proof moment.',
2, 1500, 5000, 2, 4, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['planetaryum','yıldız','bilim','romantik','gece','kapalı mekan'], false, false);

-- 6. pottery-class-proposal (difficulty:2, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'pottery-class-proposal',
'Seramik Atölyesinde Teklif', 'Pottery Class Proposal',
'Partnerinize "birlikte seramik kursu deneyelim" teklif edin. Önceden atölye sahibiyle konuşarak yüzüğü özel bir kabın içine gizlemesini isteyin. Ders sırasında birlikte çamurla çalışırken Ghost filmi tarzı romantik anlar yaşayın. Dersin sonunda eğitmen "bakın bu sizin için özel bir eser" diyerek önceden hazırlanmış, içinde yüzük olan seramik kutuyu getirsin. Kutunun kapağında "Benimle evlenir misin?" yazısı bulunsun. El yapımı ve samimi bir sürpriz için mükemmel bir seçenek.',
'Suggest to your partner "let''s try a pottery class together." Talk to the workshop owner beforehand to hide the ring in a special piece. Enjoy romantic Ghost-movie moments working with clay together during the class. At the end, have the instructor bring a pre-made ceramic box with the ring inside, saying "look, this special piece is for you." The lid should read "Will you marry me?" A perfect choice for a handmade, heartfelt surprise.',
'Seramik atölyesinde el yapımı bir sürprizle samimi bir teklif gerçekleştirin.',
'Propose with a handmade surprise at a pottery workshop for a heartfelt moment.',
2, 500, 2000, 2, 2, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['seramik','sanat','atölye','el yapımı','romantik','yaratıcı'], false, false);

-- 7. movie-scene-recreation (difficulty:3, both, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'movie-scene-recreation',
'Film Sahnesi Canlandırma Teklifi', 'Movie Scene Recreation Proposal',
'Partnerinizin en sevdiği romantik film sahnesini gerçek hayatta canlandırın. Örneğin The Notebook''taki göl sahnesini, La La Land''daki Griffith Gözlemevi sahnesini veya Amelie''deki kafe sahnesini yeniden yaratın. Kostümler, müzik ve mekan seçimiyle detayları birebir uygulayın. Film sahnesini tıpa tıp yaşadıktan sonra kamerayı kırarak "Ama benim hikayem farklı bitiyor" deyip diz çökün. Bir arkadaşınız anı gizlice filme alsın. Partneriniz en sevdiği filmi gerçekten yaşayacak.',
'Recreate your partner''s favorite romantic movie scene in real life. For example, recreate the lake scene from The Notebook, the Griffith Observatory scene from La La Land, or the café scene from Amélie. Match details exactly with costumes, music, and location. After living the scene, break the fourth wall with "But my story ends differently" and get on one knee. Have a friend secretly film the moment. Your partner will literally live their favorite movie.',
'Favori film sahnesini gerçek hayatta canlandırarak sinematik bir teklif yapın.',
'Recreate a favorite movie scene in real life for a cinematic proposal moment.',
3, 1000, 5000, 2, 6, 14, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['film','sinema','romantik','yaratıcı','kostüm','sahne'], false, false);

-- 8. cinema-trailer-proposal (difficulty:4, indoor, premium:true, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'cinema-trailer-proposal',
'Sinema Fragmanı Teklifi', 'Cinema Trailer Proposal',
'Bir sinema salonuyla anlaşarak film başlamadan önce kişisel bir fragman oynatın. Fragmanda ilişkinizden fotoğraflar, videolar ve ortak anılarınız film müzikleriyle harmanlanmış şekilde ekranda aksın. Fragmanın sonunda "Benimle evlenir misin?" sorusu belirsin ve salon ışıkları açılsın. Tüm salon alkışlarken diz çökün. Bunu gerçekleştirmek için bağımsız sinemalarla çalışmak daha kolaydır. Video düzenleme için profesyonel yardım alabilir veya Canva/CapCut gibi araçları kullanabilirsiniz.',
'Arrange with a cinema to play a custom trailer before a movie. Have photos, videos, and shared memories from your relationship flow on screen, blended with movie soundtracks. At the trailer''s end, the question "Will you marry me?" appears and the lights come on. Get on one knee as the entire theater applauds. Working with independent cinemas makes this easier to arrange. You can get professional help for video editing or use tools like Canva/CapCut.',
'Sinemada kişisel bir fragmanla dev ekranda unutulmaz bir teklif yapın.',
'Play a custom trailer on the big screen at a cinema for an unforgettable proposal.',
4, 3000, 10000, 2, 50, 21, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['sinema','film','video','dev ekran','yaratıcı','teknoloji'], true, false);

-- 9. subscription-box-countdown (difficulty:2, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'subscription-box-countdown',
'Geri Sayım Kutuları Teklifi', 'Subscription Box Countdown Proposal',
'Yedi gün boyunca her gün partnerinize numaralı bir kutu gönderin. Her kutuda ilişkinizle ilgili bir anı objesi bulunsun: ilk buluşmada içtiğiniz kahvenin markası, birlikte izlediğiniz filmin DVD''si, ilk hediye ettiğiniz parfüm. Her kutuya el yazısıyla bir mektup ekleyin. Yedinci gün son kutu geldiğinde içinde sadece bir adres ve saat yazsın. O adrese geldiğinde sizi çiçekler, mumlar ve yüzükle hazır bulsun. Sabır ve detaycılık gerektiren ama etkisi çok büyük olan bir senaryo.',
'Send your partner a numbered box every day for seven days. Each box should contain a memory object from your relationship: the coffee brand from your first date, a DVD of a movie you watched together, the first perfume you gifted. Add a handwritten letter to each box. When the seventh box arrives, it should contain only an address and time. When they arrive at that address, they find you ready with flowers, candles, and the ring. A scenario that requires patience and attention to detail but has enormous impact.',
'Yedi günlük geri sayım kutularıyla heyecanı doruk noktasına taşıyan bir teklif.',
'Build anticipation with seven countdown boxes leading to the ultimate proposal.',
2, 500, 2000, 2, 2, 10, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kutu','geri sayım','anı','mektup','romantik','sabır'], false, false);

-- 10. geocaching-proposal (difficulty:3, outdoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'geocaching-proposal',
'Geocaching Hazine Avı Teklifi', 'Geocaching Treasure Hunt Proposal',
'Geocaching uygulamasını kullanarak veya kendi GPS koordinatlarınızı oluşturarak partnerinizi bir hazine avına çıkarın. Her durağı ilişkinizden önemli bir mekanla eşleştirin: ilk karşılaştığınız yer, ilk öpüştüğünüz park, favori restoranınız. Her durağa bir ipucu ve küçük bir hediye bırakın. Son koordinat sizi bekleyen romantik bir alana yönlendirsin — piknik örtüsü, çiçekler ve yüzükle hazır olun. Macera dolu bir gün geçirdikten sonra en güzel sürprizle karşılaşacak.',
'Take your partner on a treasure hunt using the Geocaching app or by creating your own GPS coordinates. Match each stop with an important location from your relationship: where you first met, the park where you first kissed, your favorite restaurant. Leave a clue and small gift at each stop. The final coordinates should lead to a romantic area where you''re waiting — be ready with a picnic blanket, flowers, and the ring. After an adventure-filled day, they''ll encounter the best surprise.',
'GPS koordinatlarıyla hazine avı düzenleyerek macera dolu bir teklif yapın.',
'Organize a GPS treasure hunt leading to an adventure-filled proposal.',
3, 300, 1500, 2, 2, 7, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['hazine avı','GPS','macera','doğa','keşif','harita'], false, false);

-- 11. memory-gallery-proposal (difficulty:3, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'memory-gallery-proposal',
'Anı Galerisi Teklifi', 'Memory Gallery Proposal',
'Bir odayı veya koridor alanını kişisel fotoğraf galerisine dönüştürün. İlişkinizden fotoğrafları kronolojik sırayla çerçeveleyip duvara asın, her fotoğrafın altına o anın hikayesini yazan küçük kartlar ekleyin. Galerinin sonunda boş bir çerçeve asın ve altına "Bu çerçeveyi birlikte dolduracağız" yazın. Yumuşak ışıklandırma, arka plan müziği ve yerdeki gül yaprakları atmosferi tamamlasın. Partnerinizi gözleri kapalı getirin ve galerinin başından sonuna yürümesini izleyin. Son çerçevenin önünde diz çökün.',
'Transform a room or hallway into a personal photo gallery. Frame photos from your relationship in chronological order on the wall, adding small cards below each photo telling that moment''s story. At the end of the gallery, hang an empty frame with the note "We''ll fill this frame together." Soft lighting, background music, and rose petals on the floor complete the atmosphere. Bring your partner with eyes closed and watch them walk from the beginning to the end. Get on one knee in front of the last frame.',
'Fotoğraf galerisine dönüştürülmüş bir odada duygusal bir teklif yaşayın.',
'Experience an emotional proposal in a room transformed into a photo gallery.',
3, 800, 3000, 2, 2, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['fotoğraf','galeri','anı','dekorasyon','duygusal','romantik'], false, false);

-- 12. stadium-jumbotron-proposal (difficulty:3, outdoor, premium:true, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'stadium-jumbotron-proposal',
'Stadyum Dev Ekran Teklifi', 'Stadium Jumbotron Proposal',
'Partnerinizin favori takımının maçında stadyum dev ekranında evlilik teklifi yapın. Stadyum yönetimiyle iletişime geçerek devre arasında veya uygun bir anda ekranda mesajınızın gösterilmesini ayarlayın. "Sevgilim, benimle evlenir misin?" mesajı binlerce taraftarın önünde ekranda belirsin. Tribünlerdeki tezahürat eşliğinde diz çökün. Bu senaryoyu futbol, basketbol veya voleybol maçlarında uygulayabilirsiniz. Bazı stadyumlar bu hizmeti resmi olarak sunmaktadır.',
'Propose on the stadium jumbotron during your partner''s favorite team''s game. Contact the stadium management to arrange your message to be shown during halftime or at a suitable moment. "My love, will you marry me?" appears on screen in front of thousands of fans. Get on one knee amid the cheering crowd. You can apply this scenario at football, basketball, or volleyball matches. Some stadiums officially offer this service.',
'Stadyum dev ekranında binlerce taraftarın önünde teklif yapın.',
'Propose on a stadium jumbotron in front of thousands of cheering fans.',
3, 2000, 8000, 2, 2, 21, 'outdoor', ARRAY['spring','summer','fall','winter'], ARRAY['stadyum','spor','dev ekran','kalabalık','heyecanlı','cesur'], true, false);

-- 13. glow-star-ceiling-proposal (difficulty:2, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'glow-star-ceiling-proposal',
'Yıldızlı Tavan Teklifi', 'Glowing Star Ceiling Proposal',
'Yatak odanızın tavanını fosforlu yıldız çıkartmalarıyla kaplayın. Yıldızları rastgele değil, gerçek bir takımyıldızı şeklinde yerleştirin — tercihen partnerinizin burcunun takımyıldızı. Yıldızların ortasına fosforlu harflerle "Benimle evlenir misin?" yazın. Akşam ışıkları kapattığınızda tavan aydınlansın. Yatağın yanına gül yaprakları ve mumlar yerleştirin. Bu senaryo düşük bütçeli ama son derece romantik bir seçenek sunar. Sürprizin güzelliği, günlük yaşam alanınızı büyülü bir mekana dönüştürmesinde.',
'Cover your bedroom ceiling with glow-in-the-dark star stickers. Place the stars not randomly but in the shape of a real constellation — preferably your partner''s zodiac constellation. Write "Will you marry me?" in glow-in-the-dark letters among the stars. When you turn off the lights in the evening, the ceiling lights up. Place rose petals and candles next to the bed. This scenario offers a low-budget but extremely romantic option. The beauty of the surprise lies in transforming your everyday space into a magical place.',
'Yatak odası tavanını yıldızlarla kaplayarak evde büyülü bir teklif yapın.',
'Transform your bedroom ceiling with glowing stars for a magical home proposal.',
2, 100, 500, 2, 2, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['yıldız','tavan','ev','romantik','bütçe dostu','gece'], false, false);

-- 14. fake-tiktok-proposal (difficulty:2, both, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'fake-tiktok-proposal',
'Sahte TikTok Çekimi Teklifi', 'Fake TikTok Proposal',
'Partnerinize "TikTok için viral olacak bir video çekelim" deyin. Popüler bir dans trendi veya challenge seçin ve birkaç deneme çekimi yapın. Son çekimde koreografiyi takip eder gibi yapın, sonra aniden müziği durdurup diz çökün. Kamera zaten kayıtta olduğu için tüm tepki anı kaydedilmiş olacak. Bu senaryonun güzelliği partnerinizin kameranın önünde rahat olması ve sürprizi hiç beklememesidir. Video gerçekten viral olabilir! Doğal ve modern bir teklif arayanlar için idealdir.',
'Tell your partner "let''s shoot a TikTok video that will go viral." Choose a popular dance trend or challenge and do a few practice takes. In the final take, pretend to follow the choreography, then suddenly stop the music and get on one knee. Since the camera is already recording, the entire reaction moment is captured. The beauty of this scenario is that your partner is comfortable in front of the camera and never expects the surprise. The video might actually go viral! Ideal for those wanting a natural, modern proposal.',
'TikTok video çekimi sırasında doğal ve modern bir teklif sürprizi yapın.',
'Create a natural, modern proposal surprise during a fake TikTok filming session.',
2, 100, 500, 2, 4, 3, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['TikTok','sosyal medya','video','modern','eğlenceli','doğal'], false, false);

-- 15. pet-ring-bearer-proposal (difficulty:2, both, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'pet-ring-bearer-proposal',
'Köpek Yüzük Taşıyıcısı Teklifi', 'Pet Ring Bearer Proposal',
'Evcil köpeğinizi yüzük taşıyıcısı yapın. Köpeğiniz için özel bir tasma veya bandana sipariş edin; üzerinde "Annem/Babam benimle evlenir misin diye soracak" yazsın. Yüzüğü güvenli bir şekilde bandanaya veya minik bir sırt çantasına bağlayın. Akşam yürüyüşüne çıkarken veya sabah partneriniz uyandığında köpeği odaya gönderin. Evcil hayvan severlerin kalbini eritecek bu senaryo, ailenin en tüylü üyesini de bu özel ana dahil eder. Köpeğinizi önceden birkaç kez prova ettirin.',
'Make your pet dog the ring bearer. Order a custom collar or bandana for your dog with the text "My mom/dad is going to ask me to marry them." Securely attach the ring to the bandana or a tiny backpack. Send the dog into the room during an evening walk or when your partner wakes up in the morning. This scenario melts the hearts of pet lovers and includes the family''s furriest member in this special moment. Practice with your dog a few times beforehand.',
'Evcil köpeğinizi yüzük taşıyıcısı yaparak sevimli bir teklif düzenleyin.',
'Make your pet dog the ring bearer for an adorable proposal moment.',
2, 200, 800, 2, 3, 5, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['köpek','evcil hayvan','sevimli','ev','doğal','aile'], false, false);

-- 16. cat-bandana-proposal (difficulty:1, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'cat-bandana-proposal',
'Kedi Bandanası Teklifi', 'Cat Bandana Proposal',
'Kedinize özel tasarlanmış bir bandana veya papyon takın. Bandananın üzerinde "Evlenelim mi?" veya "Ona evet de!" yazısı bulunsun. Yüzüğü minik bir kese içinde kedinizin tasmasına bağlayın. Partneriniz eve geldiğinde veya sabah kahvaltısında kediyi kucağına koyun. Kedinin doğal sevimli tavırları sürprizin etkisini artıracaktır. Meraklı ve bağımsız ruhlu kediler bazen planı bozabilir, bu yüzden kedinizin sakin bir anını seçin. Backup olarak yüzüğü cebinizde de hazır tutun.',
'Put a custom-designed bandana or bow tie on your cat. The bandana should read "Shall we get married?" or "Say yes!" Attach the ring in a tiny pouch to your cat''s collar. Place the cat in your partner''s lap when they come home or during breakfast. The cat''s natural cute behavior will amplify the surprise effect. Curious and independent-spirited cats may sometimes disrupt the plan, so choose a calm moment for your cat. Keep the ring in your pocket as backup.',
'Kedinize teklif bandanası takarak sevimli ve samimi bir teklif yapın.',
'Put a proposal bandana on your cat for a cute and intimate proposal.',
1, 100, 400, 2, 2, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kedi','evcil hayvan','sevimli','ev','bütçe dostu','samimi'], false, false);

-- 17. venice-gondola-proposal (difficulty:5, outdoor, premium:true, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'venice-gondola-proposal',
'Venedik Gondol Teklifi', 'Venice Gondola Proposal',
'Venedik''in büyülü kanallarında bir gondol turu sırasında teklif yapın. Gondolcuyla önceden konuşarak özel bir rota belirleyin — Rialto Köprüsü altından geçerken veya San Marco Meydanı''nın önünde durun. Gondolcudan İtalyanca bir aşk şarkısı söylemesini isteyin. Gondolda şampanya, çiçekler ve mumlar hazırlayın. Gün batımı saatini seçerek altın ışığın suyun üzerinde yansımasını sağlayın. Suyun hafif çalkantısı, İtalyan müziği ve tarihi yapıların silüetleri arasında diz çökün. Profesyonel fotoğrafçıyı köprüde konumlandırın.',
'Propose during a gondola ride through Venice''s enchanting canals. Arrange a special route with the gondolier beforehand — stop while passing under the Rialto Bridge or in front of St. Mark''s Square. Ask the gondolier to sing an Italian love song. Prepare champagne, flowers, and candles in the gondola. Choose sunset time to let golden light reflect on the water. Get on one knee amid the gentle sway of water, Italian music, and silhouettes of historic buildings. Position a professional photographer on the bridge.',
'Venedik''in kanallarında gondol turunda masalsı bir teklif yapın.',
'Propose during a fairy-tale gondola ride through Venice''s enchanting canals.',
5, 20000, 60000, 2, 2, 30, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['Venedik','gondol','İtalya','lüks','seyahat','romantik'], true, false);

-- 18. northern-lights-proposal (difficulty:5, outdoor, premium:true, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'northern-lights-proposal',
'Kuzey Işıkları Altında Teklif', 'Northern Lights Proposal',
'Norveç, İzlanda veya Finlandiya''da kuzey ışıklarını izlerken teklif yapın. Eylül-Mart arası dönemde bir gece, şehir ışıklarından uzak bir noktada aurora borealis''i bekleyin. Sıcak giysiler, termos çikolata ve battaniyelerle donanın. Yerel bir rehber tutarak en iyi gözlem noktalarını keşfedin. Gökyüzü yeşil ve mor dansına başladığında, doğanın en büyük ışık şovunun altında diz çökün. Cam iglo otel rezervasyonu yaparak geceyi yıldızların altında geçirebilirsiniz. Doğanın sanatıyla evlilik teklifinizi birleştiren eşsiz bir deneyim.',
'Propose while watching the northern lights in Norway, Iceland, or Finland. Wait for the aurora borealis at a point away from city lights during a night between September and March. Equip yourselves with warm clothes, thermos hot chocolate, and blankets. Hire a local guide to discover the best viewing spots. When the sky begins its green and purple dance, get on one knee under nature''s greatest light show. Book a glass igloo hotel to spend the night under the stars. A unique experience combining nature''s art with your proposal.',
'Kuzey ışıklarının büyülü dansı altında hayatın teklifini yapın.',
'Propose under the magical dance of the northern lights for a once-in-a-lifetime moment.',
5, 25000, 80000, 2, 2, 45, 'outdoor', ARRAY['fall','winter'], ARRAY['kuzey ışıkları','İskandinavya','doğa','lüks','seyahat','macera'], true, false);

-- 19. paris-artist-proposal (difficulty:4, outdoor, premium:true, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'paris-artist-proposal',
'Paris Sokak Ressamı Teklifi', 'Paris Street Artist Proposal',
'Paris''te Montmartre''daki bir sokak ressamıyla önceden anlaşın. Partnerinize "portre yaptıralım" teklif edin. Ressam sizi çizerken, portreye gizlice bir evlilik teklifi mesajı veya yüzük detayı eklesin. Portre tamamlandığında partneriniz resme yakından baktığında mesajı keşfetsin. Arka planda Sacré-Cœur Bazilikası''nın manzarası, sokak müzisyenleri ve Fransız atmosferi sürprizi taçlandırsın. Eyfel Kulesi''nde romantik bir akşam yemeğiyle günü sonlandırın.',
'Arrange with a street artist in Montmartre, Paris beforehand. Suggest to your partner "let''s get our portrait done." While the artist draws you, they secretly add a proposal message or ring detail to the portrait. When the portrait is finished and your partner looks closely at the painting, they discover the message. The Sacré-Cœur Basilica view in the background, street musicians, and French atmosphere crown the surprise. End the day with a romantic dinner at the Eiffel Tower.',
'Paris''te Montmartre''da sokak ressamıyla sanatsal bir teklif yapın.',
'Propose through a Montmartre street artist in Paris for an artistic moment.',
4, 15000, 50000, 2, 2, 30, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['Paris','sanat','ressam','seyahat','lüks','romantik'], true, false);

-- 20. drone-light-show-proposal (difficulty:5, outdoor, premium:true, featured:true)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'drone-light-show-proposal',
'Drone Işık Gösterisi Teklifi', 'Drone Light Show Proposal',
'Profesyonel bir drone ışık şovu şirketiyle çalışarak gökyüzünde kalp, yüzük ve "Evlen Benimle" yazısı oluşturun. 50-200 arası LED drone ile koordineli uçuş programlanır. Partnerinizi gece açık bir alana getirin — çatı terası veya deniz kenarı idealdir. Şov başladığında gökyüzünde önce kalp şekli, sonra yüzük, son olarak mesaj belirsin. Modern teknoloji ve romantizmin mükemmel birleşimi olan bu senaryo, yüzlerce kişinin izleyebileceği bir gösteri sunar. Yerel drone uçuş izinlerini önceden almayı unutmayın.',
'Work with a professional drone light show company to create a heart, ring, and "Marry Me" text in the sky. 50-200 LED drones are programmed for coordinated flight. Bring your partner to an open area at night — a rooftop terrace or seaside is ideal. When the show begins, a heart shape appears first, then a ring, finally the message. This scenario, a perfect fusion of modern technology and romance, offers a show that hundreds can watch. Don''t forget to obtain local drone flight permits in advance.',
'Gökyüzünde drone ışık şovuyla spektaküler bir teklif gerçekleştirin.',
'Create a spectacular proposal with a drone light show painting the night sky.',
5, 30000, 100000, 2, 200, 30, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['drone','teknoloji','ışık şovu','gökyüzü','lüks','spektaküler'], true, true);

-- 21. dolphin-show-proposal (difficulty:3, outdoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'dolphin-show-proposal',
'Yunus Gösterisi Teklifi', 'Dolphin Show Proposal',
'Bir yunus parkı veya akvaryumla anlaşarak gösteri sırasında teklif yapın. Eğitmenle koordine olarak yunusun ağzında su geçirmez bir kutu taşımasını sağlayın — kutunun içinde "Benimle evlenir misin?" yazılı bir kart bulunsun. Gösteri sırasında seyirciler arasında oturun, sonra eğitmen sizi sahneye davet etsin. Yunus kutuyu size teslim ettiğinde diz çökün. Alternatif olarak, yunus havuzunun kenarında özel bir alan hazırlatarak gösteriden sonra sürprizi gerçekleştirin.',
'Arrange with a dolphin park or aquarium to propose during a show. Coordinate with the trainer to have a dolphin carry a waterproof box in its mouth — the box should contain a card reading "Will you marry me?" Sit among the audience during the show, then have the trainer invite you to the stage. Get on one knee when the dolphin delivers the box. Alternatively, have a special area prepared by the pool edge for the surprise after the show.',
'Yunus gösterisinde sevimli bir yardımcıyla sürpriz teklif yapın.',
'Propose during a dolphin show with an adorable aquatic assistant.',
3, 2000, 6000, 2, 10, 14, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['yunus','akvaryum','hayvan','eğlenceli','gösterişli','farklı'], false, false);

-- 22. magician-show-proposal (difficulty:3, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'magician-show-proposal',
'Sihirbaz Gösterisi Teklifi', 'Magician Show Proposal',
'Profesyonel bir sihirbazla çalışarak evlilik teklifini bir sihir numarasına dönüştürün. Sihirbaz partnerinizi sahneye davet ederek bir dizi numara yapsın. Son numarada boş bir kutunun içinden yüzük çıksın veya kartlar arasından "Evlen Benimle" yazılı kart belirsin. Sihirbaz "Bu numarayı sadece gerçek aşk yapabilir" diyerek sizi sahneye çağırsın. Bir restoran veya özel bir etkinlikte düzenlenebilir. Sihirbazla en az iki prova yaparak zamanlamayı mükemmelleştirin.',
'Work with a professional magician to turn your proposal into a magic trick. The magician invites your partner to the stage for a series of tricks. In the final trick, the ring appears from an empty box, or a card reading "Marry Me" emerges from the deck. The magician says "Only true love can perform this trick" and calls you to the stage. Can be arranged at a restaurant or special event. Do at least two rehearsals with the magician to perfect the timing.',
'Sihirbaz gösterisinde büyülü bir numarayla teklif yapın.',
'Propose through a magical trick during a professional magician''s show.',
3, 1500, 5000, 2, 30, 10, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['sihirbaz','büyü','gösteri','eğlenceli','yaratıcı','sahne'], false, false);

-- 23. bosphorus-fireworks-proposal (difficulty:4, outdoor, premium:true, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'bosphorus-fireworks-proposal',
'Boğaz''da Havai Fişek Teklifi', 'Bosphorus Fireworks Proposal',
'İstanbul Boğazı''nda özel bir tekne kiralayarak havai fişek eşliğinde teklif yapın. Tekneyi çiçekler, mumlar ve kırmızı halıyla süsleyin. Gün batımında yola çıkarak Boğaz''ın iki yakasını izleyin. Akşam karardığında özel olarak ayarlanmış havai fişekler gökyüzünü aydınlatsın. Havai fişeklerin ışığında diz çökün. Tekneye canlı müzik grubu veya kemancı ekleyerek atmosferi güçlendirin. İstanbul''un eşsiz silueti arka planında gerçekleşen bu teklif, ömür boyu unutulmayacak anılar yaratır.',
'Rent a private boat on the Bosphorus in Istanbul and propose with fireworks. Decorate the boat with flowers, candles, and a red carpet. Set off at sunset and watch both shores of the Bosphorus. When darkness falls, specially arranged fireworks light up the sky. Get on one knee in the glow of fireworks. Add a live music band or violinist to strengthen the atmosphere. This proposal against Istanbul''s unique skyline creates memories that will last a lifetime.',
'İstanbul Boğazı''nda tekne ve havai fişekle unutulmaz bir teklif yapın.',
'Propose with fireworks on a private boat cruising the Bosphorus in Istanbul.',
4, 15000, 50000, 2, 10, 21, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['İstanbul','Boğaz','havai fişek','tekne','lüks','gece'], true, false);

-- 24. cappadocia-sunrise-proposal (difficulty:3, outdoor, premium:true, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'cappadocia-sunrise-proposal',
'Kapadokya Gün Doğumu Teklifi', 'Cappadocia Sunrise Proposal',
'Kapadokya''da gün doğumunda yüzlerce balonun gökyüzünü doldurduğu o masalsı anda teklif yapın. Bir terasında veya özel bir gözlem noktasında sabahın ilk ışıklarıyla birlikte kahvaltı masası hazırlayın. Balonlar uçmaya başladığında, rengarenk gökyüzünün altında diz çökün. Profesyonel fotoğrafçı anı ölümsüzleştirsin. Alternatif olarak balonlardan birinde de teklif yapabilirsiniz. Peri bacaları, vadiler ve balonların oluşturduğu manzara dünyanın en ikonik teklif dekorunu sunar.',
'Propose in Cappadocia at the fairy-tale moment when hundreds of balloons fill the sunrise sky. Prepare a breakfast table on a terrace or special viewpoint with the first lights of morning. When the balloons begin to rise, get on one knee under the colorful sky. Have a professional photographer immortalize the moment. Alternatively, you can propose from one of the balloons. The landscape of fairy chimneys, valleys, and balloons offers the world''s most iconic proposal backdrop.',
'Kapadokya''da balonların arasında gün doğumunda masalsı bir teklif yapın.',
'Propose at sunrise in Cappadocia among hundreds of balloons for a fairy-tale moment.',
3, 5000, 20000, 2, 2, 14, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['Kapadokya','balon','gün doğumu','doğa','romantik','Türkiye'], true, true);

-- 25. turkish-coffee-fortune (difficulty:1, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'turkish-coffee-fortune',
'Türk Kahvesi Falı Teklifi', 'Turkish Coffee Fortune Proposal',
'Partnerinize Türk kahvesi yapın veya bir kafede birlikte için. Kahve fincanını kapattıktan sonra "Ben senin falına bakayım" deyin. Fincanı açar gibi yaparak önceden hazırladığınız sahte fal yorumunu okuyun: "Çok yakında hayatını değiştirecek bir soru gelecek... Bu soruyu soran kişi karşında oturuyor." Sonra yüzüğü çıkarın. Alternatif olarak, fincanın altına önceden küçük bir kağıda "Benimle evlenir misin?" yazıp yapıştırabilirsiniz. Türk kültürüne özgü, samimi ve bütçe dostu bir teklif.',
'Make Turkish coffee for your partner or drink it together at a café. After flipping the cup, say "Let me read your fortune." Pretend to open the cup and read a pre-prepared fake fortune: "Very soon a life-changing question will come... The person asking sits across from you." Then pull out the ring. Alternatively, you can stick a small note saying "Will you marry me?" under the cup beforehand. An intimate, budget-friendly proposal unique to Turkish culture.',
'Türk kahvesi falında gizli bir mesajla kültürel ve samimi bir teklif yapın.',
'Hide a proposal in a Turkish coffee fortune reading for a culturally intimate moment.',
1, 50, 300, 2, 2, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kahve','Türk kültürü','fal','samimi','bütçe dostu','ev'], false, false);

-- 26. puzzle-message-proposal (difficulty:2, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'puzzle-message-proposal',
'Yapboz Mesajı Teklifi', 'Puzzle Message Proposal',
'İlişkinizden güzel bir fotoğrafı özel yapboza bastırın. Yapboz tamamlandığında fotoğrafın altında "Benimle evlenir misin?" mesajı görünsün. Partnerinize "Birlikte yapboz yapalım" teklif edin ve birlikte parçaları birleştirin. Son parçaları partnerinizin yerleştirmesini sağlayın — mesaj ortaya çıktığında yüzüğü çıkarın. 500-1000 parçalık yapbozlar en ideal boyuttadır. Saatler süren birlikte geçirilen zamanın ardından ortaya çıkan mesaj, sabrın ve birlikteliğin sembolü olur.',
'Print a beautiful photo from your relationship as a custom puzzle. When completed, the message "Will you marry me?" appears beneath the photo. Suggest to your partner "let''s do a puzzle together" and assemble the pieces together. Make sure your partner places the final pieces — when the message appears, pull out the ring. 500-1000 piece puzzles are the ideal size. The message revealed after hours spent together becomes a symbol of patience and togetherness.',
'Özel yapbozun son parçasıyla ortaya çıkan mesajla teklif yapın.',
'Propose with a message revealed by completing the final puzzle piece.',
2, 200, 800, 2, 2, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['yapboz','bulmaca','sabır','birlikte','yaratıcı','ev'], false, false);

-- 27. library-scavenger-proposal (difficulty:3, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'library-scavenger-proposal',
'Kütüphane Hazine Avı Teklifi', 'Library Scavenger Hunt Proposal',
'Partnerinizin favori kütüphanesinde bir hazine avı düzenleyin. Kütüphaneciyle anlaşarak farklı kitapların içine not kağıtları gizleyin. Her not bir ipucu ve sevgi dolu bir mesaj içersin. İlk notu partnerinize verin: "Favori kitabının olduğu rafa git." Her kitapta bulunan not bir sonraki rafa yönlendirsin. Son kitabın içinde "Son sayfayı birlikte çevirelim" yazsın ve o rafın arkasında siz yüzükle bekliyor olun. Kitap kokusu, sessizlik ve bilginin huzuruyla çevrili bu teklif, entelektüel çiftler için mükemmel.',
'Organize a treasure hunt in your partner''s favorite library. Arrange with the librarian to hide notes inside different books. Each note should contain a clue and a loving message. Give the first note to your partner: "Go to the shelf with your favorite book." Each note found in a book directs to the next shelf. The last book should say "Let''s turn the final page together," and you''ll be waiting behind that shelf with the ring. Surrounded by the scent of books, silence, and the serenity of knowledge, this proposal is perfect for intellectual couples.',
'Kütüphanede kitapların arasına gizlenmiş ipuçlarıyla romantik bir teklif yapın.',
'Propose with clues hidden among books in a library treasure hunt.',
3, 200, 1000, 2, 2, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kütüphane','kitap','hazine avı','entelektüel','romantik','ipucu'], false, false);

-- 28. secret-garden-bloom (difficulty:3, outdoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'secret-garden-bloom',
'Gizli Bahçe Çiçek Teklifi', 'Secret Garden Bloom Proposal',
'Botanik bahçesinde veya özel bir bahçede gizli bir köşe hazırlayın. Çiçek kemeri, peri ışıkları ve gül yapraklarıyla süslenmiş bir patika oluşturun. Patikanın sonunda küçük bir çardak veya bank olsun. Bankın üzerine el yazısıyla bir mektup ve çiçeklerle çevrili yüzük kutusu yerleştirin. Partnerinizi "yeni bir botanik bahçesi keşfettim" diyerek davet edin. Patikada yürürken her köşede bir anı fotoğrafı asılı olsun. Baharın çiçekleri ve kuş sesleriyle çevrili bu teklif, masal gibi bir atmosfer sunar.',
'Prepare a hidden corner in a botanical garden or private garden. Create a path decorated with a floral arch, fairy lights, and rose petals. At the end of the path, have a small gazebo or bench. Place a handwritten letter and ring box surrounded by flowers on the bench. Invite your partner saying "I discovered a new botanical garden." As you walk the path, have memory photos hanging at each corner. Surrounded by spring blooms and birdsong, this proposal offers a fairy-tale atmosphere.',
'Çiçeklerle süslenmiş gizli bir bahçede masalsı bir teklif yaşayın.',
'Experience a fairy-tale proposal in a secret garden adorned with blooming flowers.',
3, 1000, 4000, 2, 2, 7, 'outdoor', ARRAY['spring','summer'], ARRAY['bahçe','çiçek','doğa','romantik','masalsı','dekorasyon'], false, false);

-- 29. vinyl-record-proposal (difficulty:2, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'vinyl-record-proposal',
'Plak Kaydı Teklifi', 'Vinyl Record Proposal',
'Özel bir vinil plak bastırın. A yüzünde "bizim şarkımız" olsun, B yüzünde ise sizin sesinizle kaydettiğiniz bir teklif mesajı bulunsun. Partnerinize "sana bir sürpriz hediyem var" diyerek plağı verin. Birlikte A yüzünü dinleyin, anılara dalın. Sonra "B yüzünü de dinleyelim" deyin. Kendi sesinizle "Seninle geçirdiğim her anı seviyorum, benimle evlenir misin?" mesajını duyduğunda yüzüğü çıkarın. Müzik tutkunları için hem kişisel hem nostaljik bir deneyim. Online servislerle özel plak bastırmak artık çok kolay.',
'Press a custom vinyl record. Side A should have "our song," side B should have a proposal message recorded in your voice. Give the record to your partner saying "I have a surprise gift for you." Listen to side A together and reminisce. Then say "let''s listen to side B too." When they hear your voice saying "I love every moment with you, will you marry me?" pull out the ring. A personal and nostalgic experience for music lovers. Custom record pressing is now very easy with online services.',
'Özel bir vinil plağın B yüzüne kaydettiğiniz mesajla teklif yapın.',
'Propose with a message recorded on the B-side of a custom vinyl record.',
2, 500, 1500, 2, 2, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['müzik','plak','vinil','nostaljik','kişisel','yaratıcı'], false, false);

-- 30. drive-in-movie-proposal (difficulty:2, outdoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'drive-in-movie-proposal',
'Açık Hava Sineması Teklifi', 'Drive-In Movie Proposal',
'Bir açık hava sinemasında veya arabalı sinemada teklif yapın. Organizatörle anlaşarak filmden önce kişisel bir video oynatın — ilişkinizin en güzel anlarından derlenen bir montaj. Videonun sonunda "Benimle evlenir misin?" sorusu ekranda belirsin. Araba bagajını battaniyeler, yastıklar ve atıştırmalıklarla romantik bir oturma alanına dönüştürün. Popcorn kutusunun içine yüzüğü gizleyin. Yaz gecelerinin sıcaklığında, yıldızlı gökyüzünün altında nostaljik ve samimi bir teklif deneyimi yaşayın.',
'Propose at an outdoor or drive-in cinema. Arrange with the organizer to play a personal video before the film — a montage of your relationship''s best moments. At the video''s end, "Will you marry me?" appears on screen. Transform the car trunk into a romantic seating area with blankets, pillows, and snacks. Hide the ring inside the popcorn box. Experience a nostalgic and intimate proposal under the starry sky on warm summer nights.',
'Açık hava sinemasında dev ekranda kişisel bir videoyla teklif yapın.',
'Propose with a personal video on the big screen at a drive-in cinema.',
2, 500, 2000, 2, 2, 10, 'outdoor', ARRAY['spring','summer'], ARRAY['sinema','film','açık hava','araba','nostaljik','romantik'], false, false);

-- 31. rooftop-dinner-proposal (difficulty:3, outdoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'rooftop-dinner-proposal',
'Çatı Katı Akşam Yemeği Teklifi', 'Rooftop Dinner Proposal',
'Şehir manzaralı bir çatı katında özel bir akşam yemeği düzenleyin. Masayı mumlar, çiçekler ve peri ışıklarıyla süsleyin. Özel bir şef tutarak çok kurslu bir menü hazırlatın. Tatlı servisinde şefin "özel bir sürpriz" olarak getirdiği tabağın üzerinde çikolatadan yazılmış teklif mesajı bulunsun. Arka planda canlı keman veya gitar müziği çalsın. Şehrin ışıkları ayaklarınızın altında parıldarken diz çökün. Gökyüzüne en yakın noktada, yıldızların ve şehir ışıklarının tanık olduğu romantik bir an yaşayın.',
'Arrange a private dinner on a rooftop with city views. Decorate the table with candles, flowers, and fairy lights. Hire a private chef to prepare a multi-course menu. During dessert, the chef brings a "special surprise" plate with the proposal message written in chocolate. Have live violin or guitar music playing in the background. Get on one knee as city lights sparkle beneath your feet. Experience a romantic moment at the closest point to the sky, witnessed by stars and city lights.',
'Şehir manzaralı çatı katında özel bir akşam yemeğiyle teklif yapın.',
'Propose with a private dinner on a rooftop overlooking stunning city views.',
3, 3000, 10000, 2, 2, 10, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['çatı katı','akşam yemeği','şehir','romantik','lüks','manzara'], false, false);

-- 32. aquarium-tunnel-proposal (difficulty:3, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'aquarium-tunnel-proposal',
'Akvaryum Tüneli Teklifi', 'Aquarium Tunnel Proposal',
'Büyük bir akvaryumun sualtı tünelinde teklif yapın. Akvaryum yönetimiyle anlaşarak kapanış saatinden sonra özel bir tur düzenleyin veya sakin bir saati seçin. Tünelde yürürken köpek balıkları ve vatozlar üstünüzden geçerken mavi ışıkların büyüsünde diz çökün. Önceden dalgıçlarla anlaşarak su içinde "Evlen Benimle" pankartı tutmalarını sağlayabilirsiniz. Sualtı dünyasının huzuruyla çevrili bu teklif, sanki başka bir gezegende yaşanmış gibi hissedilir.',
'Propose in the underwater tunnel of a large aquarium. Arrange with the aquarium management for a private tour after closing hours or choose a quiet time. Get on one knee as sharks and rays pass overhead in the magical blue light while walking through the tunnel. You can arrange with divers beforehand to hold a "Marry Me" banner underwater. Surrounded by the tranquility of the underwater world, this proposal feels like it happened on another planet.',
'Akvaryum tünelinde sualtı dünyasının büyüsünde teklif yapın.',
'Propose in an aquarium tunnel surrounded by the magic of the underwater world.',
3, 2000, 8000, 2, 4, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['akvaryum','sualtı','tünel','büyülü','farklı','mavi'], false, false);

-- 33. sunrise-mountain-proposal (difficulty:4, outdoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'sunrise-mountain-proposal',
'Dağ Zirvesinde Gün Doğumu Teklifi', 'Sunrise Mountain Proposal',
'Partnerinizi gece yürüyüşüne davet ederek şafaktan önce bir dağ zirvesine ulaşın. Gün doğumunu izlemek için battaniye ve termos çay hazırlayın. Güneşin ilk ışınları ufukta belirdiğinde, dünyanın en yüksek noktasında diz çökün. Önceden zirveye bir arkadaşınızı göndererek çiçekler ve bir "Benimle evlenir misin?" pankartı yerleştirmesini sağlayın. Doğanın sessizliği, kuş sesleri ve gökyüzünün değişen renkleriyle çevrili bu an, şehrin gürültüsünden uzakta saf bir duygu deneyimi sunar.',
'Invite your partner for a night hike to reach a mountain summit before dawn. Prepare blankets and thermos tea for watching the sunrise. When the first rays appear on the horizon, get on one knee at the highest point. Send a friend to the summit beforehand to place flowers and a "Will you marry me?" banner. Surrounded by nature''s silence, birdsong, and the sky''s changing colors, this moment offers a pure emotional experience away from the city''s noise.',
'Dağ zirvesinde gün doğumunda doğayla iç içe bir teklif yapın.',
'Propose at a mountain summit during sunrise for a pure, nature-immersed moment.',
4, 300, 1500, 2, 4, 5, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['dağ','gün doğumu','doğa','macera','yürüyüş','zirve'], false, false);

-- 34. message-in-bottle-proposal (difficulty:1, outdoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'message-in-bottle-proposal',
'Şişede Mesaj Teklifi', 'Message in a Bottle Proposal',
'Sahilde yürüyüş yaparken "şişede mesaj" klasiğini modern bir dokunuşla canlandırın. Önceden sahile güzel bir cam şişe gömün — içinde rulo halinde aşk mektubunuz ve yüzük bulunsun. Yürüyüş sırasında "bak burada bir şey var!" diyerek şişeyi keşfetmesini sağlayın. Mektupta ilişkinizin hikayesini ve gelecek planlarınızı yazın, son cümlede teklifi yapın. Deniz kenarında, dalgaların sesi eşliğinde düğüm atın. Bu senaryo romantik filmlerdeki gibi bir an yaratır ve son derece düşük bütçeyle gerçekleştirilebilir.',
'Bring the "message in a bottle" classic to life with a modern touch during a beach walk. Bury a beautiful glass bottle on the beach beforehand — inside should be your rolled-up love letter and the ring. During the walk, say "look, there''s something here!" and let them discover the bottle. Write your relationship story and future plans in the letter, making the proposal in the last sentence. Tie the knot by the sea, accompanied by the sound of waves. This scenario creates a movie-like moment and can be done on an extremely low budget.',
'Sahilde keşfedilen şişede mesajla romantik bir teklif yapın.',
'Propose with a message in a bottle discovered during a romantic beach walk.',
1, 50, 300, 2, 2, 2, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['sahil','deniz','şişe','romantik','bütçe dostu','klasik'], false, false);

-- 35. ar-card-proposal (difficulty:3, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'ar-card-proposal',
'Artırılmış Gerçeklik Kart Teklifi', 'AR Card Proposal',
'Artırılmış gerçeklik (AR) özellikli özel bir kart tasarlayın. Kart görünüşte güzel bir tebrik kartıdır, ancak telefon kamerasıyla tarandığında 3D animasyonlar belirir — birlikte çekilmiş fotoğraflar, kalpler ve son olarak "Benimle evlenir misin?" mesajı ekranda canlanır. Bunu oluşturmak için Artivive, ZapWorks veya Spark AR gibi platformları kullanabilirsiniz. Kartı "sana küçük bir hediye aldım" diyerek verin ve telefonuyla taramasını isteyin. Teknoloji ve romantizmi birleştiren modern bir teklif deneyimi.',
'Design a custom augmented reality (AR) card. The card looks like a beautiful greeting card, but when scanned with a phone camera, 3D animations appear — photos taken together, hearts, and finally the message "Will you marry me?" comes alive on screen. You can use platforms like Artivive, ZapWorks, or Spark AR to create this. Give the card saying "I got you a little gift" and ask them to scan it with their phone. A modern proposal experience combining technology and romance.',
'Artırılmış gerçeklik kartıyla teknoloji ve romantizmi birleştiren bir teklif yapın.',
'Propose with an augmented reality card that blends technology and romance.',
3, 500, 2000, 2, 2, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['AR','teknoloji','kart','dijital','modern','yaratıcı'], false, false);

-- 36. custom-crossword-proposal (difficulty:1, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'custom-crossword-proposal',
'Bulmaca Çözdüren Teklif', 'Custom Crossword Proposal',
'İlişkinizle ilgili ipuçları içeren özel bir çapraz bulmaca tasarlayın. Soruların cevapları ilk buluşma mekanınız, sevdiği çiçek, favori filminiz gibi ortak anılardan oluşsun. Bulmaca çözüldüğünde belirli harfler birleşerek "EVLEN BENİMLE" mesajını oluştursun. Partnerinize "İnternette ilginç bir bulmaca buldum, birlikte çözelim mi?" diyerek sunun. Online bulmaca oluşturma araçlarıyla kolayca hazırlanabilir. Kahvaltıda, kafede veya evde keyifli bir aktivite olarak başlayıp duygusal bir anla biten bir senaryo.',
'Design a custom crossword puzzle with clues about your relationship. Answers should come from shared memories like your first date location, their favorite flower, your favorite movie. When solved, specific letters combine to spell "MARRY ME." Present it to your partner saying "I found an interesting puzzle online, shall we solve it together?" Easily created with online puzzle-making tools. A scenario that starts as a fun activity during breakfast, at a café, or at home and ends with an emotional moment.',
'Özel çapraz bulmacada gizli mesajla eğlenceli bir teklif yapın.',
'Propose with a hidden message in a custom crossword puzzle about your relationship.',
1, 50, 200, 2, 2, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['bulmaca','çapraz','oyun','eğlenceli','bütçe dostu','yaratıcı'], false, false);

-- 37. train-journey-proposal (difficulty:3, both, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'train-journey-proposal',
'Tren Yolculuğu Teklifi', 'Train Journey Proposal',
'Doğu Ekspresi gibi manzaralı bir tren yolculuğunda teklif yapın. Özel bir kompartıman rezerve ederek içini çiçekler, mumlar ve fotoğraflarla süsleyin. Yolculuk boyunca farklı istasyonlarda küçük sürprizler hazırlayın — bir istasyonda çiçek, diğerinde çikolata, bir diğerinde mektup. Son istasyona yaklaşırken veya en güzel manzarada diz çökün. Tren personelini de sürprize dahil edebilirsiniz — vagon şefi anons sisteminden özel bir mesaj okuyabilir. Yolculuğun ritmi ve romantizmiyle unutulmaz bir deneyim.',
'Propose on a scenic train journey like the Eastern Express. Reserve a private compartment and decorate it with flowers, candles, and photos. Prepare small surprises at different stations throughout the journey — flowers at one station, chocolate at another, a letter at the next. Get on one knee approaching the last station or at the most beautiful scenery. You can include the train staff in the surprise — the conductor can read a special message over the PA system. An unforgettable experience with the rhythm and romance of the journey.',
'Manzaralı bir tren yolculuğunda romantik bir teklif deneyimi yaşayın.',
'Experience a romantic proposal on a scenic train journey through breathtaking views.',
3, 1000, 5000, 2, 2, 14, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['tren','yolculuk','seyahat','manzara','romantik','macera'], false, false);

-- 38. ferris-wheel-proposal (difficulty:2, outdoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'ferris-wheel-proposal',
'Dönme Dolap Teklifi', 'Ferris Wheel Proposal',
'Lunapark veya sahil kenarındaki bir dönme dolapta teklif yapın. Operatörle anlaşarak en tepe noktada durmasını sağlayın. Kabinin içini küçük LED ışıklarla süsleyin — bir arkadaşınız önceden yerleştirsin. Tepede durduğunuzda şehrin veya denizin manzarası ayaklarınızın altında olacak. "Buradan her şey çok küçük görünüyor ama sana olan aşkım gökyüzü kadar büyük" diyerek diz çökün. Gün batımı saatini seçerek altın ışığın romantik atmosferinden faydalanın. Basit ama etkileyici bir klasik.',
'Propose on a Ferris wheel at an amusement park or seaside. Arrange with the operator to stop at the very top. Decorate the cabin with small LED lights — have a friend place them beforehand. When you stop at the top, the city or sea view will be beneath your feet. Get on one knee saying "Everything looks so small from up here, but my love for you is as big as the sky." Choose sunset time to benefit from the golden light''s romantic atmosphere. A simple but impressive classic.',
'Dönme dolabın zirvesinde manzara eşliğinde romantik bir teklif yapın.',
'Propose at the top of a Ferris wheel with stunning panoramic views.',
2, 300, 1500, 2, 2, 5, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['dönme dolap','lunapark','manzara','romantik','klasik','eğlenceli'], false, false);

-- 39. underwater-scuba-proposal (difficulty:5, outdoor, premium:true, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'underwater-scuba-proposal',
'Sualtı Dalış Teklifi', 'Underwater Scuba Proposal',
'Scuba dalışı sırasında sualtında teklif yapın. Su geçirmez bir yazı tahtasına "Benimle evlenir misin?" yazın ve dalış sırasında partnerinize gösterin. Dalış eğitmeniyle koordine ederek güvenli ve sakin bir noktada durmanızı sağlayın. Mercan resifleri, renkli balıklar ve turkuaz suyun ışığında bu anı yaşayın. Yüzüğü su geçirmez bir kapsülde taşıyın. Dalıştan sonra yüzeye çıktığında tekneyi çiçekler ve şampanyayla süslü bulsun. İleri seviye dalış sertifikası gerektirebilir; alternatif olarak sığ dalış da yapılabilir.',
'Propose underwater during a scuba dive. Write "Will you marry me?" on a waterproof slate and show it to your partner during the dive. Coordinate with the dive instructor to stop at a safe, calm spot. Experience this moment amid coral reefs, colorful fish, and turquoise water light. Carry the ring in a waterproof capsule. When they surface after the dive, the boat should be decorated with flowers and champagne. May require advanced dive certification; alternatively, a shallow dive can work.',
'Sualtı dalışında mercanlar arasında benzersiz bir teklif deneyimi yaşayın.',
'Experience a unique proposal among coral reefs during an underwater scuba dive.',
5, 3000, 12000, 2, 4, 14, 'outdoor', ARRAY['spring','summer'], ARRAY['dalış','sualtı','deniz','macera','ekstrem','mercan'], true, false);

-- 40. skywriting-proposal (difficulty:4, outdoor, premium:true, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_proposal, 'skywriting-proposal',
'Gökyüzüne Yazı Teklifi', 'Skywriting Proposal',
'Profesyonel bir gökyüzü yazıcısıyla (skywriter) çalışarak bulutların arasına "EVLEN BENİMLE" yazdırın. Partnerinizi açık bir alana, terasa veya parkta pikniğe davet edin. Belirlenen saatte uçak gökyüzünde mesajı yazmaya başlayacak. "Yukarı bak" diyerek gökyüzüne yönlendirin ve mesaj belirirken diz çökün. Rüzgarsız ve bulutsuz günleri tercih edin, çünkü duman hızla dağılır. Bir arkadaşınız anı uzaktan fotoğraflasın. Eskiden çok popüler olan bu klasik yöntem günümüzde nadir uygulandığı için çok daha etkileyici.',
'Work with a professional skywriter to spell "MARRY ME" among the clouds. Invite your partner to an open area, terrace, or park picnic. At the designated time, the plane begins writing the message in the sky. Say "look up" to direct their gaze to the sky and get on one knee as the message appears. Prefer windless, cloudless days as smoke disperses quickly. Have a friend photograph the moment from a distance. This classic method, once very popular, is now rare — making it even more impressive today.',
'Gökyüzüne dumanla yazılan mesajla gösterişli bir teklif yapın.',
'Propose with a skywritten message among the clouds for a grand gesture.',
4, 10000, 30000, 2, 2, 21, 'outdoor', ARRAY['spring','summer'], ARRAY['gökyüzü','uçak','duman','gösterişli','klasik','lüks'], true, false);

-- ==========================================
-- BIRTHDAY — 35 scenarios
-- ==========================================

-- 1. escape-room-birthday (difficulty:2, indoor, premium:false, featured:true)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'escape-room-birthday',
'Escape Room Doğum Günü Sürprizi', 'Escape Room Birthday Surprise',
'Doğum günü kahramanını escape room''a davet edin. Mekan sahibiyle anlaşarak son odayı doğum günü temasıyla süsleyin — pasta, balonlar ve hediyeler son bulmacayı çözdüklerinde ortaya çıksın. Arkadaş grubunu önceden organize ederek hep birlikte kaçış deneyimi yaşayın. Son odanın kapısı açıldığında herkes "İyi ki doğdun!" diye bağırsın. Bulmacaların içine doğum günü kahramanının hayatından sorular ekleyin — ilk okulu, favori filmi, en komik anısı gibi. Hem eğlenceli hem sürpriz dolu bir kutlama.',
'Invite the birthday person to an escape room. Arrange with the venue to decorate the final room with a birthday theme — cake, balloons, and gifts appear when they solve the last puzzle. Organize the friend group beforehand for a group escape experience. When the final door opens, everyone shouts "Happy Birthday!" Add questions about the birthday person''s life into the puzzles — their first school, favorite movie, funniest memory. A celebration that''s both fun and full of surprises.',
'Escape room''da son odayı doğum günü sürprizine dönüştürün.',
'Transform the final escape room into a birthday surprise celebration.',
2, 800, 2500, 4, 10, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['escape room','bulmaca','arkadaş','eğlenceli','takım','kutlama'], false, true);

-- 2. fortnite-island-birthday (difficulty:3, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'fortnite-island-birthday',
'Fortnite Doğum Günü Adası', 'Fortnite Birthday Island',
'Fortnite''ın Creative modunda özel bir doğum günü adası inşa edin. Parkurlar, mini oyunlar ve doğum günü süslemeleriyle dolu bir alan yaratın. Adadaki duvarlara "İyi ki doğdun!" mesajları yerleştirin. Arkadaş grubunu aynı saatte online toplayarak hep birlikte adayı keşfedin. Adanın sonunda sanal bir parti alanı hazırlayın — DJ booth, dans pisti ve havai fişek efektleri. Uzaktan kutlama için mükemmel olan bu senaryo, oyun sever gençler ve çocuklar için idealdir. Ekran kaydıyla anı ölümsüzleştirin.',
'Build a custom birthday island in Fortnite''s Creative mode. Create an area full of obstacle courses, mini-games, and birthday decorations. Place "Happy Birthday!" messages on walls throughout the island. Gather the friend group online at the same time to explore the island together. Prepare a virtual party area at the end — DJ booth, dance floor, and fireworks effects. Perfect for remote celebrations, this scenario is ideal for gaming teens and kids. Immortalize the moment with screen recording.',
'Fortnite''ta özel bir doğum günü adası inşa ederek sanal parti yapın.',
'Build a custom birthday island in Fortnite for a virtual party experience.',
3, 0, 200, 2, 20, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['oyun','Fortnite','dijital','sanal','gençlik','eğlenceli'], false, false);

-- 3. advent-calendar-birthday (difficulty:2, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'advent-calendar-birthday',
'Doğum Günü Geri Sayım Takvimi', 'Birthday Advent Calendar',
'Doğum gününe 10 gün kala her gün açılacak bir geri sayım takvimi hazırlayın. Her kutuda küçük hediyeler, anı fotoğrafları, el yazısı notlar ve ipuçları bulunsun. 10. gün "Sana en büyük sürprizi vermek için bu adreste ol" mesajıyla son bulsun. Her gün artan heyecan ve merak, doğum gününe kadar muhteşem bir beklenti oluşturur. Kutuları numaralı kraft kağıt zarflarda veya küçük hediye kutularında hazırlayın. Kapıya asılabilir veya her sabah yastığının altına konabilir.',
'Prepare a countdown calendar with something to open each day for 10 days before the birthday. Each box should contain small gifts, memory photos, handwritten notes, and clues. Day 10 ends with the message "Be at this address for the biggest surprise." The daily increasing excitement and curiosity builds wonderful anticipation until the birthday. Prepare boxes in numbered kraft paper envelopes or small gift boxes. They can be hung on the door or placed under their pillow each morning.',
'10 günlük geri sayım takvimiyle doğum gününe heyecan dolu bir hazırlık yapın.',
'Build birthday excitement with a 10-day countdown calendar full of daily surprises.',
2, 300, 1000, 1, 2, 12, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['takvim','geri sayım','hediye','anı','sabır','heyecan'], false, false);

-- 4. volunteer-day-birthday (difficulty:2, outdoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'volunteer-day-birthday',
'Gönüllülük Doğum Günü', 'Volunteer Day Birthday',
'Doğum gününü hayır işleriyle kutlayın. Bir hayvan barınağında gönüllü olun, çocuk hastanesine ziyaret düzenleyin veya yaşlı bakım evinde etkinlik yapın. Doğum günü kahramanının değer verdiği bir konuda topluma katkıda bulunun. Gönüllülük aktivitesinden sonra sürpriz bir parti düzenleyin — hem iyi bir şey yapmanın mutluluğu hem kutlama heyecanı bir arada. Bu anlamlı kutlama formatı, özellikle "benim her şeyim var, hediye istemiyorum" diyen kişiler için mükemmel bir alternatif sunar.',
'Celebrate the birthday with charity work. Volunteer at an animal shelter, organize a visit to a children''s hospital, or hold an activity at an elderly care home. Contribute to society in a cause the birthday person values. After the volunteer activity, throw a surprise party — combining the happiness of doing good with celebration excitement. This meaningful celebration format is a perfect alternative especially for people who say "I have everything, I don''t want gifts."',
'Doğum gününü gönüllülük çalışmasıyla anlamlı bir şekilde kutlayın.',
'Celebrate a birthday meaningfully through volunteer work and giving back.',
2, 200, 1000, 3, 15, 7, 'outdoor', ARRAY['spring','summer','fall','winter'], ARRAY['gönüllü','hayır','anlamlı','toplum','farklı','değerli'], false, false);

-- 5. sunrise-hike-birthday (difficulty:3, outdoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'sunrise-hike-birthday',
'Gün Doğumu Yürüyüşü Doğum Günü', 'Sunrise Hike Birthday',
'Doğum günü sabahı gün doğumunu karşılamak için yakın bir tepeye yürüyüş düzenleyin. Zirvede önceden hazırladığınız kahvaltı pikniği beklesin — termos kahve, pasta ve balonlar. Arkadaş grubunu zirveye önceden konumlandırarak doğum günü kahramanı tepeye ulaştığında sürpriz karşılama yapın. Güneşin doğuşuyla birlikte mumları üflesin. Doğanın güzelliğiyle çevrili bu kutlama, alışılmış parti formatından farklı, enerji dolu ve huzurlu bir deneyim sunar. Sporcu ve doğa sever kişiler için idealdir.',
'Organize a hike to a nearby hilltop to welcome the sunrise on the birthday morning. A pre-prepared breakfast picnic awaits at the summit — thermos coffee, cake, and balloons. Position the friend group at the summit beforehand for a surprise welcome when the birthday person reaches the top. They blow out candles with the rising sun. This celebration surrounded by nature''s beauty offers an energetic and peaceful experience different from typical party formats. Ideal for sporty and nature-loving people.',
'Doğum günü sabahı gün doğumunda dağ yürüyüşüyle sürpriz piknik yapın.',
'Organize a surprise sunrise hike with a birthday picnic waiting at the summit.',
3, 200, 800, 3, 10, 5, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['yürüyüş','doğa','gün doğumu','piknik','aktif','sağlıklı'], false, false);

-- 6. desk-transformation-birthday (difficulty:1, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'desk-transformation-birthday',
'Masa Sürprizi Doğum Günü', 'Desk Transformation Birthday',
'İş arkadaşlarıyla koordine ederek doğum günü kahramanının masasını sabah gelmeden önce süsleyin. Balonlar, serpantinler, doğum günü yazısı ve küçük hediyeleri masaya yerleştirin. Bilgisayar ekranına özel bir doğum günü mesajı yazın veya masaüstü duvar kağıdını değiştirin. İş yerinde herkesin imzaladığı bir kart hazırlayın. Doğum günü kahramanı ofise geldiğinde masasını tanıyamayacak! Öğle yemeğinde sürpriz pasta kesimi de planlayın. Basit ama iş ortamında çok etkileyici bir kutlama.',
'Coordinate with coworkers to decorate the birthday person''s desk before they arrive in the morning. Place balloons, streamers, birthday banner, and small gifts on the desk. Write a special birthday message on the computer screen or change the desktop wallpaper. Prepare a card signed by everyone at work. The birthday person won''t recognize their desk when they arrive! Also plan a surprise cake cutting at lunch. A simple but very impressive celebration in the workplace.',
'Ofiste masayı gizlice süsleyerek iş yerinde doğum günü sürprizi yapın.',
'Secretly decorate their office desk for a workplace birthday surprise.',
1, 100, 400, 3, 15, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['ofis','masa','iş','kolay','bütçe dostu','arkadaş'], false, false);

-- 7. birthday-spin-wheel (difficulty:2, both, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'birthday-spin-wheel',
'Çarkıfelek Doğum Günü', 'Birthday Spin Wheel',
'Doğum günü için renkli bir çarkıfelek hazırlayın. Her dilimde farklı bir aktivite veya ödül yazsın: "1 saat masaj", "istediğin restoranda akşam yemeği", "Netflix maratonu", "alışveriş turu" gibi. Doğum günü kahramanı gün boyunca çarkı çevirsin ve çıkan aktiviteleri yaşasın. Tüm dilimler özenle seçilmiş ödüllerden oluşsun — hiçbir dilim boş veya sıradan olmasın. Karton, keçe veya tahta kullanarak el yapımı çark oluşturabilir veya dijital çarkıfelek uygulaması kullanabilirsiniz. Eğlenceli ve interaktif bir kutlama.',
'Prepare a colorful spin wheel for the birthday. Each section should have a different activity or prize: "1 hour massage", "dinner at any restaurant", "Netflix marathon", "shopping spree." The birthday person spins the wheel throughout the day and experiences whatever comes up. All sections should be carefully chosen rewards — no section should be empty or ordinary. You can create a handmade wheel using cardboard, felt, or wood, or use a digital spin wheel app. A fun and interactive celebration.',
'Çarkıfelek çevirerek gün boyunca sürpriz ödüller kazanılan bir doğum günü yapın.',
'Celebrate with a spin wheel full of surprise prizes throughout the birthday.',
2, 100, 500, 2, 10, 3, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['çarkıfelek','oyun','eğlenceli','ödül','interaktif','yaratıcı'], false, false);

-- 8. balloon-memory-ceiling (difficulty:2, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'balloon-memory-ceiling',
'Anı Balonlu Tavan Sürprizi', 'Memory Balloon Ceiling Surprise',
'Doğum günü kahramanının odasının tavanını helyum balonlarıyla kaplayın. Her balonun ucundaki iple bir fotoğraf ve o anıyla ilgili kısa bir not bağlayın. Balonlar tavandan sarkan fotoğraf galerisi gibi görünsün. Fotoğraflar kronolojik sırayla — bebeklikten bugüne — dizilsin. Her fotoğrafın altındaki notta o yılın en güzel anısı yazılsın. Kapıyı açtığında kendini anılarla çevrili bulsun. Balonların arasına LED peri ışıkları ekleyerek sihirli bir atmosfer yaratın. Duygusal ve görsel açıdan çok etkileyici bir sürpriz.',
'Cover the birthday person''s room ceiling with helium balloons. Attach a photo and a short note about that memory to the string of each balloon. The balloons should look like a hanging photo gallery from the ceiling. Photos should be arranged chronologically — from babyhood to today. Each photo''s note should describe that year''s best memory. When they open the door, they find themselves surrounded by memories. Add LED fairy lights among the balloons for a magical atmosphere. An emotionally and visually impressive surprise.',
'Tavandan sarkan anı balonlarıyla duygusal bir doğum günü sürprizi hazırlayın.',
'Create an emotional birthday surprise with memory-filled balloons hanging from the ceiling.',
2, 300, 1000, 1, 3, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['balon','anı','fotoğraf','dekorasyon','duygusal','tavan'], false, false);

-- 9. memory-lane-roadtrip (difficulty:3, outdoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'memory-lane-roadtrip',
'Anı Yolu Gezisi Doğum Günü', 'Memory Lane Road Trip Birthday',
'Doğum günü kahramanının hayatındaki önemli mekanları ziyaret eden bir günlük yol gezisi planlayın. Doğduğu hastane, büyüdüğü ev, ilk okulu, ilk iş yeri gibi durakları rotaya ekleyin. Her durakta o döneme ait bir fotoğrafla selfie çekin. Arabada özel bir müzik listesi çalsın — her şarkı hayatının farklı bir dönemini temsil etsin. Son durak sürpriz bir parti mekanı olsun. Yolculuk boyunca anıları paylaşarak hem nostaljik hem eğlenceli bir gün geçirin. Arabanın bagajında gizli pasta ve hediyeler bulunsun.',
'Plan a day-long road trip visiting important locations in the birthday person''s life. Add stops to the route like the hospital where they were born, the house they grew up in, their first school, first workplace. Take a selfie at each stop with a photo from that era. Play a special playlist in the car — each song representing a different period of their life. The final stop should be a surprise party venue. Share memories along the way for a nostalgic yet fun day. Keep a hidden cake and gifts in the trunk.',
'Hayatındaki önemli mekanları ziyaret eden bir yol gezisiyle doğum günü kutlayın.',
'Celebrate with a road trip visiting significant locations from their life story.',
3, 500, 2000, 2, 6, 7, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['yol gezisi','araba','anı','nostaljik','macera','keşif'], false, false);

-- 10. mad-scientist-birthday (difficulty:3, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'mad-scientist-birthday',
'Çılgın Bilim İnsanı Doğum Günü', 'Mad Scientist Birthday Party',
'Evi veya parti mekanını bilim laboratuvarına dönüştürün. Deney masaları kurun ve güvenli, eğlenceli bilim deneyleri hazırlayın — volkanik patlama (sirke+karbonat), slime yapımı, renk değiştiren sıvılar, kuru buz efektleri. Herkes beyaz önlük ve koruyucu gözlük taksın. Doğum günü pastası bile bilimsel olsun — kuru buzla tüten bir pasta veya LED ışıklı bir pasta. Çocuklar ve bilim meraklısı yetişkinler için mükemmel bir tema. Her deneyin sonunda "Deney başarılı: Sonuç = Eğlence!" diye bağırın.',
'Transform the house or party venue into a science laboratory. Set up experiment stations and prepare safe, fun science experiments — volcanic eruptions (vinegar+baking soda), slime making, color-changing liquids, dry ice effects. Everyone wears white lab coats and safety goggles. Even the birthday cake should be scientific — a smoking cake with dry ice or an LED-lit cake. A perfect theme for kids and science-enthusiast adults. Shout "Experiment successful: Result = Fun!" at the end of each experiment.',
'Bilim laboratuvarı temalı deneylerle eğlenceli bir doğum günü partisi düzenleyin.',
'Throw a science lab-themed birthday party with safe, fun experiments for all ages.',
3, 500, 2000, 5, 20, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['bilim','deney','laboratuvar','çocuk','eğitici','eğlenceli'], false, false);

-- 11. food-truck-party (difficulty:3, outdoor, premium:true, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'food-truck-party',
'Yemek Tırı Doğum Günü Partisi', 'Food Truck Birthday Party',
'Bir veya birden fazla yemek tırını doğum günü partisine davet edin. Hamburger, taco, waffle veya dondurma tırları gibi farklı lezzetler sunan araçlarla açık hava festivali atmosferi yaratın. Bahçeye veya parka piknik masaları, peri ışıkları ve doğum günü süsleri yerleştirin. DJ veya Bluetooth hoparlörle müzik çalsın. Her misafir istediği tırdan yemek alsın — restoran menüsü gibi seçenek bolluğu ama piknik havası. Doğum günü pastasını da özel olarak tırlardan birine yaptırın.',
'Invite one or more food trucks to the birthday party. Create an outdoor festival atmosphere with vehicles offering different flavors like burgers, tacos, waffles, or ice cream. Set up picnic tables, fairy lights, and birthday decorations in the garden or park. Play music with a DJ or Bluetooth speaker. Each guest orders from whichever truck they like — restaurant-level variety with a picnic vibe. Have the birthday cake custom-made by one of the trucks.',
'Yemek tırlarıyla açık hava festival tarzında doğum günü partisi düzenleyin.',
'Throw an outdoor festival-style birthday party with food trucks.',
3, 3000, 10000, 10, 50, 14, 'outdoor', ARRAY['spring','summer'], ARRAY['yemek','festival','açık hava','parti','lezzet','sosyal'], true, false);

-- 12. midnight-balloon-room (difficulty:1, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'midnight-balloon-room',
'Gece Yarısı Balon Odası Sürprizi', 'Midnight Balloon Room Surprise',
'Doğum günü gecesi saat 00:00''da partneriniz veya arkadaşınız uyurken odayı balonlarla doldurun. Yüzlerce renkli balon yerden tavana kadar kaplasın — kapıyı açtığında balonlar üzerine dökülen bir etki yaratın. Balonların arasına konfeti, küçük hediye kutuları ve LED ışıklar serpin. Gece yarısı çalar saati ayarlayarak "Uyanma zamanı!" diye uyandırın ve sürprizi yaşatın. Basit, ekonomik ve son derece etkileyici bir sürpriz. Özellikle çocuklar ve gençler için unutulmaz bir uyanış deneyimi.',
'Fill the room with balloons while your partner or friend sleeps on their birthday at midnight. Hundreds of colorful balloons should cover the floor to ceiling — when they open the door, balloons cascade onto them. Scatter confetti, small gift boxes, and LED lights among the balloons. Set a midnight alarm to wake them with "Time to wake up!" and let them experience the surprise. A simple, economical, and extremely effective surprise. An unforgettable waking experience especially for kids and teens.',
'Gece yarısı yüzlerce balonla odayı doldurarak unutulmaz bir uyanış sürprizi yapın.',
'Fill a room with hundreds of balloons at midnight for an unforgettable birthday wake-up.',
1, 100, 400, 1, 3, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['balon','gece yarısı','sürpriz','kolay','bütçe dostu','renkli'], false, false);

-- 13. retro-90s-party (difficulty:3, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'retro-90s-party',
'90''lar Retro Parti', 'Retro 90s Party',
'90''lara geri dönün! Mekanı neon renkler, kasetçalar, VHS kasetler ve retro posterlerle süsleyin. Herkes 90''lar tarzında giyinsin — oversize tişörtler, yırtık kotlar, platform ayakkabılar. 90''lar hit listesinden bir müzik listesi hazırlayın. Twister, Monopoly gibi masa oyunları kurun. Eski gameboy ve konsol oyunlarıyla oyun köşesi oluşturun. Doğum günü pastasını kaset veya Walkman şeklinde yaptırın. Polaroid fotoğraf makinesiyle anıları yakalayın. Nostalji dolu bu parti, 90''larda büyüyen kuşak için muhteşem bir zaman yolculuğu sunar.',
'Go back to the 90s! Decorate the venue with neon colors, cassette players, VHS tapes, and retro posters. Everyone dresses 90s style — oversized t-shirts, ripped jeans, platform shoes. Prepare a playlist from the 90s hit list. Set up board games like Twister and Monopoly. Create a gaming corner with old Gameboy and console games. Order the birthday cake shaped like a cassette or Walkman. Capture memories with a Polaroid camera. This nostalgia-filled party offers an amazing time travel experience for the generation that grew up in the 90s.',
'90''lar temasıyla nostalji dolu bir retro doğum günü partisi düzenleyin.',
'Throw a nostalgia-packed retro 90s birthday party with period-perfect details.',
3, 500, 2000, 5, 20, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['retro','90lar','nostalji','tema','parti','kostüm'], false, false);

-- 14. silent-disco-birthday (difficulty:3, both, premium:true, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'silent-disco-birthday',
'Sessiz Disko Doğum Günü', 'Silent Disco Birthday Party',
'Kablosuz kulaklıklarla sessiz disko partisi düzenleyin. Her misafir kulaklık taksın ve 2-3 farklı kanal arasında geçiş yapabilsin — her kanal farklı müzik türü çalsın (pop, rock, dans). Dışarıdan bakınca sessizlik içinde dans eden insanlar çok komik görünecek. Kulaklık kiralama firmaları bu hizmeti sağlamaktadır. Bahçede, çatıda veya evde düzenlenebilir. LED ışıklı kulaklıklar tercih ederek renkli bir görsel şov yaratın. Gece geç saatlere kadar komşuları rahatsız etmeden parti yapabilirsiniz.',
'Throw a silent disco party with wireless headphones. Each guest wears headphones and can switch between 2-3 channels — each channel plays a different music genre (pop, rock, dance). From outside, people dancing in silence looks hilarious. Headphone rental companies provide this service. Can be arranged in a garden, rooftop, or home. Choose LED-lit headphones for a colorful visual show. You can party late into the night without disturbing the neighbors.',
'Kablosuz kulaklıklarla sessiz disko doğum günü partisi düzenleyin.',
'Throw a silent disco birthday party with wireless headphones and multiple channels.',
3, 2000, 6000, 8, 40, 10, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['disko','müzik','kulaklık','dans','parti','farklı'], true, false);

-- 15. picnic-surprise-birthday (difficulty:2, outdoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'picnic-surprise-birthday',
'Sürpriz Piknik Doğum Günü', 'Surprise Picnic Birthday',
'Güzel bir parkta veya göl kenarında bohem tarzı bir piknik düzenleyin. Vintage battaniyeler, yastıklar, çiçek düzenlemeleri ve cam kavanozlarda mumlarla dekore edin. Peynir tabağı, meyveler, sandviçler ve özel bir doğum günü pastası hazırlayın. Doğum günü kahramanını "parktayız, gel bize katıl" diyerek davet edin — geldiğinde süslü piknik alanını ve arkadaşlarını bulsun. Gitar çalan bir arkadaş veya Bluetooth hoparlörle müzik ekleyin. Açık hava, güneş ışığı ve samimi bir ortamda stressiz bir kutlama.',
'Organize a bohemian-style picnic in a beautiful park or lakeside. Decorate with vintage blankets, cushions, flower arrangements, and candles in glass jars. Prepare a cheese board, fruits, sandwiches, and a special birthday cake. Invite the birthday person saying "we''re at the park, come join us" — they find the decorated picnic area and their friends. Add music with a guitar-playing friend or Bluetooth speaker. A stress-free celebration in open air, sunshine, and an intimate setting.',
'Bohem tarzı parkta piknikle samimi bir doğum günü kutlaması düzenleyin.',
'Organize a bohemian-style surprise picnic birthday celebration in a park.',
2, 300, 1000, 4, 15, 3, 'outdoor', ARRAY['spring','summer'], ARRAY['piknik','park','doğa','bohem','samimi','açık hava'], false, false);

-- 16. gaming-night-birthday (difficulty:1, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'gaming-night-birthday',
'Oyun Gecesi Doğum Günü', 'Gaming Night Birthday',
'Evi ultimate oyun merkezine dönüştürün. Birden fazla ekran kurun — konsol oyunları, masa oyunları ve kart oyunları köşeleri hazırlayın. Mario Kart, FIFA veya Smash Bros turnuvası düzenleyin. Kazananlara komik ödüller verin. Atıştırmalık masası hazırlayın — pizza, chips, enerji içeceği, şekerleme. LED ışıklar ve neon dekorasyonla oyun atmosferi yaratın. Doğum günü pastasını joystick veya oyun karakteri şeklinde sipariş edin. Gece boyunca oyun oynayarak eğlence dolu bir doğum günü geçirin.',
'Transform the home into the ultimate gaming center. Set up multiple screens — console games, board games, and card game corners. Organize a Mario Kart, FIFA, or Smash Bros tournament. Give funny prizes to winners. Prepare a snack table — pizza, chips, energy drinks, candy. Create a gaming atmosphere with LED lights and neon decor. Order the birthday cake shaped like a joystick or game character. Spend a fun-filled birthday playing games all night long.',
'Evi oyun merkezine çevirerek turnuva dolu bir doğum günü gecesi düzenleyin.',
'Transform home into a gaming center for a tournament-filled birthday night.',
1, 200, 800, 3, 10, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['oyun','konsol','turnuva','eğlenceli','gece','arkadaş'], false, false);

-- 17. karaoke-night-birthday (difficulty:1, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'karaoke-night-birthday',
'Karaoke Gecesi Doğum Günü', 'Karaoke Night Birthday',
'Karaoke mekanında veya evde karaoke sistemi kurarak müzikli bir doğum günü kutlaması yapın. Doğum günü kahramanının favori şarkılarından bir liste hazırlayın. Grubun birlikte söyleyeceği özel bir doğum günü şarkısı prova edin — belki bilinen bir şarkının sözlerini kişiselleştirin. Karaoke yarışması düzenleyerek en iyi ve en komik performansa ödül verin. Disko topu, sahne ışıkları ve mikrofon ile küçük bir konser atmosferi yaratın. Gece sonunda herkes birlikte doğum günü şarkısını söylesin.',
'Celebrate with a musical birthday at a karaoke venue or with a karaoke system at home. Prepare a list from the birthday person''s favorite songs. Rehearse a special birthday song for the group to sing together — maybe customize the lyrics of a well-known song. Organize a karaoke contest and give prizes for the best and funniest performances. Create a mini-concert atmosphere with a disco ball, stage lights, and microphone. At the end of the night, everyone sings the birthday song together.',
'Karaoke gecesiyle müzik dolu ve eğlenceli bir doğum günü kutlayın.',
'Celebrate with a music-filled karaoke night birthday party.',
1, 200, 1000, 4, 15, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['karaoke','müzik','şarkı','parti','eğlenceli','gece'], false, false);

-- 18. rooftop-cinema-birthday (difficulty:3, outdoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'rooftop-cinema-birthday',
'Çatı Sineması Doğum Günü', 'Rooftop Cinema Birthday',
'Çatı katına veya bahçeye açık hava sineması kurun. Projektör ve beyaz çarşaf ekranıyla film gösterimi yapın. Yer minderler, battaniyeler ve yastıklarla rahat bir oturma alanı oluşturun. Popcorn, nachos ve içecek istasyonu hazırlayın. Filmden önce doğum günü kahramanının hayatından derlenen komik ve duygusal bir video montajı oynatın. Doğum günü kahramanının en sevdiği filmi izleyin. Yıldızlı gökyüzünün altında, arkadaşlarla birlikte film izlemek unutulmaz bir doğum günü deneyimi sunar.',
'Set up an outdoor cinema on the rooftop or in the garden. Screen a movie with a projector and white sheet screen. Create a comfortable seating area with floor cushions, blankets, and pillows. Prepare a popcorn, nachos, and beverage station. Before the movie, play a funny and emotional video montage compiled from the birthday person''s life. Watch the birthday person''s favorite movie. Watching a film under the starry sky with friends offers an unforgettable birthday experience.',
'Çatıda açık hava sineması kurarak film ve arkadaşlarla doğum günü kutlayın.',
'Set up a rooftop cinema for a birthday movie night under the stars.',
3, 500, 2000, 4, 15, 5, 'outdoor', ARRAY['spring','summer'], ARRAY['sinema','film','çatı','açık hava','arkadaş','gece'], false, false);

-- 19. breakfast-bed-birthday (difficulty:1, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'breakfast-bed-birthday',
'Yatakta Kahvaltı Doğum Günü', 'Breakfast in Bed Birthday',
'Doğum günü sabahı erken kalkarak özel bir kahvaltı tabağı hazırlayın. Tepsiye çiçek, doğum günü kartı ve küçük bir hediye ekleyin. Pancake''lere çikolata sosuyla "İyi ki doğdun" yazın veya yumurtaları kalp şeklinde pişirin. Taze sıkılmış portakal suyu ve özel kahve hazırlayın. Yatak odasını balonlar ve çiçeklerle süsleyin. Doğum günü kahramanı uyandığında güzel bir müzik çalsın. Basit ama son derece özenli ve sevgi dolu bu sürpriz, güne en güzel şekilde başlamayı sağlar. Kahvaltıdan sonra günün planını sürpriz olarak açıklayın.',
'Wake up early on the birthday morning and prepare a special breakfast tray. Add flowers, a birthday card, and a small gift to the tray. Write "Happy Birthday" on pancakes with chocolate sauce or cook eggs in heart shapes. Prepare fresh-squeezed orange juice and special coffee. Decorate the bedroom with balloons and flowers. Play beautiful music when the birthday person wakes up. This simple but extremely thoughtful and loving surprise ensures the best possible start to the day. After breakfast, reveal the day''s plan as a surprise.',
'Doğum günü sabahı özenli bir yatakta kahvaltı sürpriziyle güne başlayın.',
'Start the birthday with a lovingly prepared breakfast-in-bed surprise.',
1, 100, 400, 1, 2, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kahvaltı','ev','sabah','kolay','sevgi','bütçe dostu'], false, false);

-- 20. museum-tour-birthday (difficulty:2, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'museum-tour-birthday',
'Müze Turu Doğum Günü', 'Museum Tour Birthday',
'Doğum günü kahramanının ilgi alanlarına göre bir müze turu organize edin. Sanat, bilim, tarih veya teknoloji müzesi olabilir. Özel rehber tutarak özel bir tur düzenleyin. Müze yönetimiyle konuşarak turdaki son odayı doğum günü sürprizine dönüştürün — pasta, balonlar ve hediyeler hazır olsun. Müze kafesinde önceden organize edilmiş bir doğum günü masası da alternatif olabilir. Hem kültürel hem eğlenceli bir kutlama sunan bu format, alışılmış parti kavramını yeniden tanımlar.',
'Organize a museum tour based on the birthday person''s interests. It can be an art, science, history, or technology museum. Hire a private guide for a special tour. Talk to museum management to transform the tour''s last room into a birthday surprise — cake, balloons, and gifts ready. A pre-organized birthday table at the museum café is also an alternative. This format offering both cultural and fun celebration redefines the conventional party concept.',
'İlgi alanına uygun müze turuyla farklı bir doğum günü deneyimi yaşatın.',
'Create a unique birthday experience with a museum tour matched to their interests.',
2, 500, 2000, 2, 8, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['müze','kültür','tur','farklı','sanat','eğitici'], false, false);

-- 21. cooking-class-birthday (difficulty:2, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'cooking-class-birthday',
'Yemek Kursu Doğum Günü', 'Cooking Class Birthday',
'Doğum günü kahramanının en sevdiği mutfağa uygun bir yemek kursu ayarlayın — İtalyan, Japon, Türk veya Meksika mutfağı. Profesyonel bir şefle birlikte yemek pişirme deneyimi yaşayın. Herkes birlikte hamur açsın, sos hazırlasın ve yemekleri pişirsin. Kursun sonunda hep birlikte hazırladığınız yemeği yiyin. Doğum günü pastasını da kursun bir parçası yapın — herkes birlikte süslesin. Şeften doğum günü mesajını tabağa çikolatayla yazmasını isteyin. Hem eğlenceli hem lezzetli bir kutlama deneyimi.',
'Arrange a cooking class matching the birthday person''s favorite cuisine — Italian, Japanese, Turkish, or Mexican. Experience cooking with a professional chef. Everyone rolls dough, prepares sauce, and cooks together. At the end of the class, eat the meal you prepared together. Make the birthday cake part of the class — everyone decorates it together. Ask the chef to write the birthday message in chocolate on the plate. A celebration experience that''s both fun and delicious.',
'Profesyonel şefle yemek kursu alarak lezzetli bir doğum günü kutlayın.',
'Celebrate with a cooking class led by a professional chef for a delicious birthday.',
2, 800, 3000, 4, 12, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['yemek','kurs','şef','mutfak','lezzetli','birlikte'], false, false);

-- 22. spa-day-birthday (difficulty:1, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'spa-day-birthday',
'Spa Günü Doğum Günü', 'Spa Day Birthday',
'Doğum günü kahramanına bir gün boyunca tam bir spa deneyimi hediye edin. Masaj, yüz bakımı, hamam ve havuz keyfi içeren bir paket seçin. Spa''ya varışta özel bir karşılama düzenleyin — odada çiçekler, bornoz ve doğum günü mesajı bulunsun. Spa sonrasında şık bir restoranda akşam yemeği organize edin. Ev spa alternatifi olarak banyoyu mumlar, banyo tuzları ve yüz maskeleriyle hazırlayıp özel bir bakım gecesi de düzenleyebilirsiniz. Stres dolu hayatta huzurlu bir mola hediye edin.',
'Gift the birthday person a full spa experience for the day. Choose a package including massage, facial, Turkish bath, and pool relaxation. Arrange a special welcome at the spa — flowers, a robe, and birthday message in the room. After the spa, organize dinner at an elegant restaurant. As a home spa alternative, prepare the bathroom with candles, bath salts, and face masks for a special pampering night. Gift a peaceful break from stressful life.',
'Spa günü hediye ederek huzurlu ve şımartıcı bir doğum günü yaşatın.',
'Gift a relaxing spa day for a peaceful, pampering birthday experience.',
1, 500, 3000, 1, 4, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['spa','masaj','rahatlama','bakım','huzur','şımartma'], false, false);

-- 23. concert-reveal-birthday (difficulty:3, both, premium:true, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'concert-reveal-birthday',
'Konser Bileti Açığa Çıkarma', 'Concert Ticket Reveal Birthday',
'Doğum günü kahramanının en sevdiği sanatçının konserine bilet alın ve sürpriz şekilde açığa çıkarın. Bileti bir kutu içine koyup hediye olarak verin — kutuyu açtığında konser biletini bulsun. Alternatif olarak, gün boyunca ipuçları verin: sabah sanatçının şarkısını çalın, öğleden sonra konser mekanının fotoğrafını gönderin, akşam bileti verin. Konser gününe özel kıyafet alışverişi de planın parçası olsun. VIP veya backstage pass ekleyerek deneyimi bir üst seviyeye taşıyabilirsiniz.',
'Buy tickets to the birthday person''s favorite artist''s concert and reveal them as a surprise. Put the ticket in a box and give it as a gift — they find the concert ticket when they open it. Alternatively, give clues throughout the day: play the artist''s song in the morning, send a photo of the concert venue in the afternoon, give the ticket in the evening. Include a concert-outfit shopping trip as part of the plan. Elevate the experience with VIP or backstage passes.',
'Favori sanatçının konser biletini sürpriz şekilde hediye edin.',
'Surprise-reveal concert tickets to their favorite artist for the birthday.',
3, 1000, 8000, 2, 4, 14, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['konser','müzik','bilet','sürpriz','sanatçı','hediye'], true, false);

-- 24. trip-reveal-birthday (difficulty:3, indoor, premium:true, featured:true)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'trip-reveal-birthday',
'Seyahat Sürprizi Doğum Günü', 'Trip Reveal Birthday',
'Doğum günü hediyesi olarak sürpriz bir seyahat organize edin. Bavulu gizlice hazırlayın, uçak biletlerini sahte bir hediye kutusuna koyun. Doğum günü sabahı "Havaalanına gitmemiz gerekiyor" diyerek sürprizi açığa çıkarın. Alternatif olarak, bir yapbozun son parçası seyahat destinasyonunu gösterebilir veya pasaportu hediye kutusunda bulabilir. Gidilecek yerin ipuçlarını gün boyunca verin — o ülkenin yemeğini yaptırın, müziğini çalın, harita üzerinde gösterin. Her detayı düşünerek stressiz bir seyahat deneyimi hediye edin.',
'Organize a surprise trip as the birthday gift. Secretly pack the suitcase and put plane tickets in a fake gift box. On the birthday morning, reveal the surprise by saying "We need to get to the airport." Alternatively, the last piece of a puzzle can show the travel destination, or they find their passport in a gift box. Give clues about the destination throughout the day — cook that country''s food, play its music, show it on a map. Gift a stress-free travel experience by thinking of every detail.',
'Sürpriz seyahat organize ederek unutulmaz bir doğum günü hediyesi verin.',
'Organize a surprise trip for the ultimate birthday gift experience.',
3, 5000, 30000, 2, 4, 21, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['seyahat','uçak','tatil','sürpriz','lüks','macera'], true, true);

-- 25. photo-booth-party (difficulty:2, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'photo-booth-party',
'Fotoğraf Köşesi Partisi', 'Photo Booth Party',
'Partide eğlenceli bir fotoğraf köşesi hazırlayın. Komik şapkalar, gözlükler, bıyıklar, konuşma balonları ve çerçeveler gibi aksesuar masası kurun. Arka planı balonlar, peri ışıkları ve doğum günü temasıyla süsleyin. Anlık baskı yapabilen bir kamera veya Polaroid kullanın — her misafir anı olarak fotoğraf alsın. Doğum günü kahramanıyla her misafirin ayrı ayrı komik pozlar verdiği fotoğraflardan bir albüm oluşturun. DIY fotoğraf köşesi kurmak hem bütçe dostu hem eğlenceli bir parti aktivitesi.',
'Set up a fun photo booth at the party. Create an accessory table with funny hats, glasses, mustaches, speech bubbles, and frames. Decorate the backdrop with balloons, fairy lights, and birthday theme. Use an instant-print camera or Polaroid — each guest takes a photo as a memento. Create an album from photos of each guest striking funny poses with the birthday person. Setting up a DIY photo booth is both budget-friendly and a fun party activity.',
'Eğlenceli aksesuarlarla fotoğraf köşesi kurarak partiye renk katın.',
'Set up a fun photo booth with props to add color to the birthday party.',
2, 300, 1000, 5, 30, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['fotoğraf','aksesuar','parti','eğlenceli','anı','dekorasyon'], false, false);

-- 26. drive-through-birthday (difficulty:2, outdoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'drive-through-birthday',
'Arabalı Geçit Doğum Günü', 'Drive-Through Birthday Parade',
'Arkadaş ve aile grubunu organize ederek doğum günü kahramanının evinin önünde arabalı bir geçit düzenleyin. Her araba balonlar ve pankartlarla süslensin. Arabalar sırayla geçerken kornaya bassın, pencereden hediye atsın ve "İyi ki doğdun!" diye bağırsın. Son araba doğum günü pastasını getirsin. Bu format özellikle büyük grupları bir araya getirmek zor olduğunda veya ev dışı mekan bulunamadığında harika çalışır. Video kaydıyla anı ölümsüzleştirin. Enerjik ve neşeli bir kutlama şekli.',
'Organize the friend and family group for a car parade in front of the birthday person''s house. Each car decorated with balloons and banners. Cars honk as they pass, throw gifts from windows, and shout "Happy Birthday!" The last car brings the birthday cake. This format works great especially when gathering large groups is difficult or when no outside venue is available. Immortalize the moment with video recording. An energetic and joyful celebration style.',
'Süslenmiş arabalarla doğum günü geçidi düzenleyerek coşkulu bir kutlama yapın.',
'Organize a decorated car parade for an energetic drive-through birthday celebration.',
2, 200, 800, 5, 30, 3, 'outdoor', ARRAY['spring','summer','fall','winter'], ARRAY['araba','geçit','kalabalık','coşkulu','sokak','neşeli'], false, false);

-- 27. birthday-newspaper (difficulty:2, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'birthday-newspaper',
'Kişisel Doğum Günü Gazetesi', 'Personal Birthday Newspaper',
'Doğum günü kahramanı hakkında özel bir gazete tasarlayın. Manşet: "FLAŞ! [İsim] Bugün X Yaşında!" Gazetede hayatındaki önemli olayları haber formatında yazın, arkadaşlarının röportajlarını ekleyin, komik karikatürler çizin ve gelecek tahminleri bölümü oluşturun. Canva veya InDesign ile profesyonel görünümlü bir tasarım yapın ve birkaç kopya bastırın. Sabah kahvaltısında gerçek gazeteyle birlikte masaya koyun. Her sayfada farklı bir "haber" bulunsun. Düşük maliyetli ama son derece kişisel ve yaratıcı bir hediye.',
'Design a custom newspaper about the birthday person. Headline: "BREAKING! [Name] Turns X Today!" Write important life events as news stories, include interviews from friends, draw funny cartoons, and create a future predictions section. Create a professional-looking design with Canva or InDesign and print a few copies. Place it on the breakfast table with the real newspaper in the morning. Each page should have a different "story." A low-cost but extremely personal and creative gift.',
'Kişisel doğum günü gazetesi tasarlayarak yaratıcı bir hediye verin.',
'Design a personal birthday newspaper for a creative and thoughtful gift.',
2, 50, 300, 1, 2, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['gazete','yaratıcı','kişisel','tasarım','bütçe dostu','komik'], false, false);

-- 28. video-message-compilation (difficulty:2, both, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'video-message-compilation',
'Video Mesaj Derlemesi', 'Video Message Compilation Birthday',
'Doğum günü kahramanının tüm arkadaş, aile ve sevdiklerinden gizlice doğum günü videoları toplayın. Her kişiden 30-60 saniyelik bir tebrik mesajı, anı paylaşımı veya komik bir an kaydetmesini isteyin. Videoları profesyonel bir montajla birleştirin — geçiş efektleri, arka plan müziği ve başlık kartları ekleyin. Doğum günü partisinde veya özel bir anda büyük ekranda oynatın. Uzaktaki arkadaşlar, eski öğretmenler, çocukluk arkadaşları gibi beklenmedik kişilerin mesajları en duygusal anları yaratır.',
'Secretly collect birthday videos from all the birthday person''s friends, family, and loved ones. Ask each person to record a 30-60 second congratulatory message, memory sharing, or funny moment. Combine the videos with professional editing — add transition effects, background music, and title cards. Play it on a big screen at the birthday party or a special moment. Messages from unexpected people like distant friends, old teachers, and childhood friends create the most emotional moments.',
'Sevdiklerinden toplanan video mesajlarla duygusal bir doğum günü hediyesi oluşturun.',
'Create an emotional birthday gift by compiling video messages from loved ones.',
2, 0, 500, 1, 100, 14, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['video','mesaj','derleme','duygusal','arkadaş','anı'], false, false);

-- 29. birthday-jar-365 (difficulty:2, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'birthday-jar-365',
'365 Mesajlı Doğum Günü Kavanozu', '365 Messages Birthday Jar',
'Bir cam kavanoza 365 adet küçük kağıt rulo yerleştirin. Her kağıtta farklı bir mesaj bulunsun: sevgi dolu notlar, komik anılar, motivasyon cümleleri, aktivite önerileri ve küçük görevler. Renklere göre kategorize edin — pembe: aşk, mavi: aktivite, yeşil: motivasyon, sarı: komik anı. Doğum günü kahramanı her gün bir kağıt çeksin ve bir yıl boyunca her gün küçük bir sürpriz yaşasın. Kavanozu süsleyin — kurdele, sticker ve el yazısı etiketle kişiselleştirin. Bir yıl boyunca süren bir hediye.',
'Place 365 small paper rolls in a glass jar. Each paper should have a different message: loving notes, funny memories, motivational quotes, activity suggestions, and small tasks. Categorize by color — pink: love, blue: activity, green: motivation, yellow: funny memory. The birthday person draws one paper each day and experiences a small surprise every day for a year. Decorate the jar — personalize with ribbon, stickers, and a handwritten label. A gift that lasts for an entire year.',
'365 mesajlı kavanozla bir yıl boyunca sürecek bir doğum günü hediyesi verin.',
'Give a birthday jar with 365 messages for a gift that lasts all year long.',
2, 100, 400, 1, 2, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kavanoz','mesaj','kişisel','el yapımı','uzun süreli','sevgi'], false, false);

-- 30. theme-park-birthday (difficulty:2, outdoor, premium:true, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'theme-park-birthday',
'Tema Parkı Doğum Günü', 'Theme Park Birthday',
'Doğum gününü bir tema parkında veya lunaparkta kutlayın. VIP veya hızlı geçiş biletleri alarak sıra beklemeden tüm oyuncaklara binin. Park girişinde doğum günü rozeti takarak personelin "İyi ki doğdun" demesini sağlayın. En heyecanlı oyuncakta fotoğraf çektirin — roller coaster çıkışındaki fotoğrafta doğum günü mesajı yazılı bir pankart tutun. Park içinde favori karakterle buluşma organize edin. Günün sonunda parkın havai fişek gösterisini izleyerek kutlamayı taçlandırın. Adrenalin ve eğlence dolu bir gün.',
'Celebrate the birthday at a theme park or amusement park. Get VIP or fast-pass tickets to skip lines on all rides. Wear a birthday badge at the park entrance so staff wish "Happy Birthday." Take photos at the most exciting ride — hold a banner with a birthday message in the roller coaster exit photo. Organize a meet-and-greet with a favorite character inside the park. Crown the celebration by watching the park''s fireworks show at the end of the day. A day full of adrenaline and fun.',
'Tema parkında VIP deneyimle adrenalin dolu bir doğum günü kutlayın.',
'Celebrate with a VIP theme park experience for an adrenaline-filled birthday.',
2, 2000, 8000, 2, 10, 7, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['tema parkı','lunapark','adrenalin','eğlenceli','macera','VIP'], true, false);

-- 31. boat-party-birthday (difficulty:4, outdoor, premium:true, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'boat-party-birthday',
'Tekne Partisi Doğum Günü', 'Boat Party Birthday',
'Denizde veya gölde özel bir tekne kiralayarak doğum günü partisi düzenleyin. Tekneyi balonlar, peri ışıkları ve doğum günü süsleriyle dekore edin. DJ veya müzik sistemiyle dans edin, gün batımında pasta kesin. Yüzme molası vererek denize atlayın. Catering hizmeti alarak lezzetli bir büfe hazırlatın. Teknenin güvertesinde yıldızların altında gece partisi yapın. Kaptan köşküyle anlaşarak özel bir rotada ilerleyin — koy, ada veya sahil şeridi manzaraları eşliğinde. Lüks ve özgür bir kutlama deneyimi.',
'Rent a private boat on the sea or lake for a birthday party. Decorate the boat with balloons, fairy lights, and birthday decorations. Dance with a DJ or music system, cut the cake at sunset. Take a swimming break and jump into the sea. Arrange catering for a delicious buffet. Have a night party under the stars on the deck. Arrange a special route with the captain — accompanied by cove, island, and coastline views. A luxurious and liberating celebration experience.',
'Denizde özel tekne partisiyle özgür ve lüks bir doğum günü kutlayın.',
'Celebrate with a private boat party at sea for a luxurious birthday.',
4, 5000, 20000, 8, 30, 14, 'outdoor', ARRAY['spring','summer'], ARRAY['tekne','deniz','parti','lüks','gün batımı','dans'], true, false);

-- 32. laser-tag-birthday (difficulty:2, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'laser-tag-birthday',
'Lazer Tag Doğum Günü', 'Laser Tag Birthday',
'Lazer tag arenasında aksiyon dolu bir doğum günü partisi düzenleyin. Takımları oluşturun ve turnuva yapın. Doğum günü kahramanının takımına özel isim verin. Oyunlar arasında skorboard ile yarışmayı takip edin. En yüksek skoru yapana ve doğum günü kahramanına özel ödüller verin. Lazer tag sonrasında arena kafeteryasında pasta kesimi yapın. Neon ışıklar, duman makinesi ve aksiyon müziği atmosferi tamamlasın. Hem çocuklar hem yetişkinler için enerjik ve rekabetçi bir kutlama.',
'Throw an action-packed birthday party at a laser tag arena. Form teams and have a tournament. Give the birthday person''s team a special name. Track the competition with a scoreboard between games. Give special prizes to the highest scorer and the birthday person. After laser tag, cut the cake at the arena cafeteria. Neon lights, fog machine, and action music complete the atmosphere. An energetic and competitive celebration for both kids and adults.',
'Lazer tag arenasında aksiyon dolu bir doğum günü turnuvası düzenleyin.',
'Throw an action-packed laser tag tournament for a competitive birthday party.',
2, 500, 2000, 6, 20, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['lazer tag','aksiyon','turnuva','takım','rekabet','eğlenceli'], false, false);

-- 33. art-jamming-birthday (difficulty:1, indoor, premium:false, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'art-jamming-birthday',
'Sanat Atölyesi Doğum Günü', 'Art Jamming Birthday',
'Bir resim atölyesinde veya evde sanat partisi düzenleyin. Herkese tuval, boya ve fırça verin. Serbest resim yapın veya belirli bir temada çalışın — doğum günü kahramanının portresini çizin. Arka planda müzik çalsın, şarap veya kokteyl eşliğinde yaratıcı bir akşam geçirin. Herkesin eserini doğum günü kahramanına hediye etsin. Profesyonel bir sanatçı eşliğinde veya YouTube tutorial''ı takip ederek rehberli bir deneyim de sunabilirsiniz. Sanatsal yetenekten bağımsız herkes eğlenebilir.',
'Organize an art party at a painting studio or at home. Give everyone canvas, paint, and brushes. Do free painting or work on a specific theme — draw a portrait of the birthday person. Play music in the background and enjoy a creative evening with wine or cocktails. Everyone gifts their artwork to the birthday person. You can also offer a guided experience with a professional artist or following a YouTube tutorial. Everyone can enjoy regardless of artistic talent.',
'Tuval ve boyalarla sanat atölyesi partisi düzenleyerek yaratıcı bir doğum günü kutlayın.',
'Celebrate with a canvas painting party for a creative birthday experience.',
1, 300, 1000, 4, 15, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['sanat','resim','tuval','yaratıcı','atölye','rahatlatıcı'], false, false);

-- 34. mystery-dinner-birthday (difficulty:4, indoor, premium:true, featured:true)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'mystery-dinner-birthday',
'Gizemli Akşam Yemeği Doğum Günü', 'Mystery Dinner Birthday',
'Cinayet gizemi temalı bir akşam yemeği düzenleyin. Her misafire gizli bir karakter ve görev verin. Geceyi bir dedektif hikayesi etrafında kurgulayın — ipuçları, şüpheliler ve sürpriz sonuçlar. Kostümler zorunlu olsun — 1920''ler, Agatha Christie veya noir tema seçebilirsiniz. Yemek boyunca karakterler arası diyaloglar ve ipucu paylaşımları yapılsın. Gecesonunda "katil" ortaya çıkarılsın ve doğum günü pastası "kanıt" olarak sunulsun. Profesyonel bir moderatör tutabilir veya online cinayet gizemi kitleri satın alabilirsiniz.',
'Organize a murder mystery-themed dinner party. Give each guest a secret character and mission. Build the evening around a detective story — clues, suspects, and surprise outcomes. Costumes are mandatory — choose from 1920s, Agatha Christie, or noir themes. Throughout dinner, have inter-character dialogues and clue sharing. At the end, the "killer" is revealed and the birthday cake is presented as "evidence." You can hire a professional moderator or purchase online murder mystery kits.',
'Cinayet gizemi temalı akşam yemeğiyle heyecan dolu bir doğum günü kutlayın.',
'Celebrate with a murder mystery dinner party for a thrilling birthday experience.',
4, 1000, 5000, 6, 15, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['gizem','cinayet','akşam yemeği','kostüm','dedektif','heyecan'], true, true);

-- 35. flash-mob-birthday (difficulty:4, outdoor, premium:true, featured:false)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_birthday, 'flash-mob-birthday',
'Flash Mob Doğum Günü', 'Flash Mob Birthday',
'Doğum günü kahramanı için sürpriz bir flash mob düzenleyin. 10-30 kişilik bir grup organize ederek bir dans koreografisi prova edin. Doğum günü kahramanının favori şarkısını seçin. Alışveriş merkezi, park veya meydan gibi kamusal bir alanda gerçekleştirin. Önce bir kişi dans etmeye başlasın, sonra teker teker herkes katılsın. Doğum günü kahramanı şaşkınlıkla izlerken son anda herkes ona dönüp "İyi ki doğdun!" diye bağırsın. Profesyonel dans grubu tutarak kaliteyi artırabilirsiniz. Birden fazla kameradan kayıt alın.',
'Organize a surprise flash mob for the birthday person. Organize a group of 10-30 people and rehearse a dance choreography. Choose the birthday person''s favorite song. Perform in a public area like a shopping mall, park, or square. First one person starts dancing, then everyone joins one by one. While the birthday person watches in amazement, at the last moment everyone turns to them and shouts "Happy Birthday!" You can hire a professional dance group to elevate the quality. Record from multiple camera angles.',
'Sürpriz flash mob dans gösterisiyle unutulmaz bir doğum günü kutlaması yapın.',
'Create an unforgettable birthday celebration with a surprise flash mob dance.',
4, 2000, 8000, 10, 30, 21, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['flash mob','dans','koreografi','sürpriz','kalabalık','gösteri'], true, false);

END $$;