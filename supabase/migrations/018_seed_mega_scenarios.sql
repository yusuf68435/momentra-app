-- ==========================================
-- SEED: 330 New Scenarios (Mega Expansion)
-- Categories: proposal(40), birthday(35), anniversary(35),
--   graduation(30), baby(30), romantic(35), friendship(30),
--   apology(30), achievement(30), holiday(35)
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
VALUES (gen_random_uuid(), cat_anniversary, 'star-map-anniversary-gift',
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
'Yıldönümünüzü bir bağ evinde veya butik şaraphane''de şarap tadım etkinliğiyle kutlayın. Önceden rezervasyon yaparak özel bir tadım deneyimi ayarlayın. Sommelier eşliğinde farklı şarapları tadın, her birinin hikayesini dinleyin ve eşleştirme peynirlerini keşfedin. İlişkinizin her yılını temsil eden şarapları seçin — örneğin evlendiğiniz yılın mahsulünden bir şişe. Tadım sonunda favori şarabınızdan birkaç şişe alıp eve götürün. Bağ arasında romantik bir yürüyüş yapın, üzüm bağlarında fotoğraflar çekin. Bu sofistike deneyim hem damak zevkinizi hem ilişkinizi zenginleştirecek.',
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
VALUES (gen_random_uuid(), cat_graduation, 'graduation-garden-celebration',
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
VALUES (gen_random_uuid(), cat_graduation, 'career-starter-kit-deluxe',
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


-- ============================================================
-- PART 3: BABY (30) + ROMANTIC (35) SCENARIOS
-- Total: 65 scenarios
-- ============================================================
-- ============================================================
-- BABY CATEGORY (30 scenarios)
-- ============================================================
-- 1. paint-splash-reveal (difficulty:2, outdoor, spring/summer, budget:200-800, free, featured)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'paint-splash-reveal',
'Boya Sıçrama Cinsiyet Açıklaması', 'Paint Splash Gender Reveal',
'Büyük bir beyaz tuval veya çarşaf hazırlayarak açık havada yaratıcı bir cinsiyet açıklama etkinliği düzenleyin. İçi pembe ya da mavi boya dolu balonları tuvale fırlatarak hem bebeğin cinsiyetini açıklayın hem de benzersiz bir sanat eseri ortaya çıkarın. Katılımcılara beyaz önlükler ve boya tabancaları dağıtarak herkesin sürece dahil olmasını sağlayın. Tuvali önceden bir şövale ya da iki ağaç arasına gerin. Boya dolum işlemini güvenilir bir arkadaşınıza bırakarak sürpriz efektini koruyun. Etkinlik sonunda ortaya çıkan tabloyu çerçeveletip bebek odasına asabilirsiniz. Fotoğraf ve video çekimi için iyi bir açı ayarlayın.',
'Set up a large white canvas or sheet outdoors for a creative gender reveal event. Throw balloons filled with pink or blue paint at the canvas to reveal the baby''s gender while creating a unique piece of art. Distribute white aprons and paint guns to participants so everyone can join in. Stretch the canvas on an easel or between two trees beforehand. Leave the paint filling to a trusted friend to maintain the surprise effect. After the event, you can frame the resulting painting and hang it in the nursery. Set up a good angle for photo and video capture to immortalize the moment.',
'Beyaz tuvale renkli boya balonları fırlatarak cinsiyeti açıklayın ve kalıcı bir sanat eseri yaratın.',
'Reveal gender by throwing colored paint balloons at a white canvas, creating lasting art.',
2, 200, 800, 2, 30, 3, 'outdoor', ARRAY['spring','summer'], ARRAY['boya','cinsiyet','sanat','yaratıcı','bebek','tuval','açıklama'], false, true);
-- 2. sports-ball-reveal (difficulty:2, outdoor, spring/summer/fall, budget:300-1000, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'sports-ball-reveal',
'Spor Topu Cinsiyet Açıklaması', 'Sports Ball Gender Reveal',
'Spor tutkunu aileler için mükemmel bir cinsiyet açıklama sürprizi hazırlayın. Futbol, basketbol veya beyzbol topu şeklinde özel hazırlanmış bir topu tekmelediğinizde ya da vurduğunuzda içinden pembe veya mavi toz bulutu çıksın. Topu özel olarak hazırlatan firmalardan temin edebilir ya da kendiniz içi boş bir topu renkli toz ile doldurabilirsiniz. Parkta ya da bahçede bir mini maç organizasyonu düzenleyerek heyecanı doruk noktasına çıkarın. Anne veya baba adayının topu vurma anını slow motion olarak kaydedin. Tüm misafirlere takım formaları dağıtarak pembe ve mavi takımlar oluşturun. Etkinlik sonrası pasta kesimi ile kutlamaya devam edin.',
'Prepare a perfect gender reveal surprise for sports-loving families. When you kick or hit a specially prepared ball shaped like a football, basketball, or baseball, a cloud of pink or blue powder bursts out. You can order the ball from specialized vendors or fill a hollow ball with colored powder yourself. Organize a mini match in a park or garden to bring excitement to its peak. Record the moment the expecting parent hits the ball in slow motion. Distribute team jerseys to all guests, creating pink and blue teams. Continue the celebration with a cake cutting after the event.',
'Spor topu tekmelendiğinde pembe ya da mavi toz bulutu ile bebeğin cinsiyetini açıklayın.',
'Reveal gender with a burst of pink or blue powder when a sports ball is kicked or hit.',
2, 300, 1000, 4, 40, 5, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['spor','cinsiyet','top','futbol','toz','bebek','açıklama'], false, false);
-- 3. scratch-card-reveal (difficulty:1, indoor, all seasons, budget:50-200, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'scratch-card-reveal',
'Kazı Kazan Cinsiyet Açıklaması', 'Scratch Card Gender Reveal',
'Her misafire özel tasarlanmış kazı kazan kartları dağıtarak eğlenceli ve samimi bir cinsiyet açıklaması yapın. Kartların üzerine bebek temalı görseller ve şirin mesajlar yazın. Kazındığında altından pembe veya mavi renkte cinsiyet bilgisi çıksın. Online tasarım araçlarıyla kartları kendiniz tasarlayabilir ya da profesyonel bir matbaaya sipariş verebilirsiniz. Kartları zarflara koyup misafirlere dağıtın ve hep birlikte geri sayım yaparak aynı anda kazımalarını sağlayın. Bu anı kameralara almayı unutmayın. Kartların arkasına ultrason fotoğrafı ve tahmini doğum tarihi gibi özel detaylar ekleyerek hatıra değerini artırın.',
'Distribute custom-designed scratch cards to each guest for a fun and intimate gender reveal. Write baby-themed graphics and cute messages on the cards. When scratched, reveal the gender in pink or blue underneath. You can design the cards yourself using online tools or order from a professional printer. Put cards in envelopes and distribute to guests, counting down together to scratch simultaneously. Don''t forget to capture this moment on camera. Add special details like ultrasound photos and estimated due date on the back of the cards to increase their keepsake value.',
'Misafirlere dağıtılan kazı kazan kartları ile eğlenceli ve samimi bir cinsiyet açıklaması yapın.',
'Reveal gender through custom scratch cards distributed to guests for a fun intimate moment.',
1, 50, 200, 2, 20, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kazıkazan','cinsiyet','kart','eğlenceli','bebek','samimi'], false, false);
-- 4. color-changing-drinks-reveal (difficulty:2, indoor, all seasons, budget:100-400, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'color-changing-drinks-reveal',
'Renk Değiştiren İçecek Cinsiyet Açıklaması', 'Color Changing Drinks Gender Reveal',
'Misafirlerinize şeffaf bardaklarda sunulan özel içeceklerle büyüleyici bir cinsiyet açıklaması yapın. Kelebek bezelye çiçeği çayı veya gıda boyası kullanarak limon suyu eklediğinizde renk değiştiren içecekler hazırlayın. İçecekler başlangıçta mor ya da berrak görünürken, misafirler limon damlattığında pembe ya da mavi renge dönüşsün. Her bardağın altına küçük notlar yerleştirin. Masa düzenini bebek temasıyla süsleyin ve her misafir için isimli bardaklar hazırlayın. Renk değişim anını toplu olarak yaşamak için herkesin aynı anda limon sıkmasını sağlayın. Bu sihirli an büyük heyecan yaratacak ve muhteşem fotoğraf kareleri oluşturacaktır.',
'Create a magical gender reveal by serving special drinks in clear glasses. Use butterfly pea flower tea or food coloring to prepare beverages that change color when lemon juice is added. The drinks initially appear purple or clear, then transform to pink or blue when guests add lemon drops. Place small notes under each glass. Decorate the table setting with a baby theme and prepare named glasses for each guest. Have everyone squeeze lemon simultaneously to experience the color change together. This magical moment will create great excitement and wonderful photo opportunities for everyone to treasure.',
'Şeffaf bardaklardaki içecekler limon eklediğinizde pembe ya da mavi renge dönüşerek cinsiyeti açıklar.',
'Clear drinks transform to pink or blue when lemon is added, magically revealing the gender.',
2, 100, 400, 2, 15, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['içecek','renk','cinsiyet','sihir','bebek','yaratıcı'], false, false);
-- 5. glow-night-reveal (difficulty:3, outdoor, summer, budget:500-2000, premium)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'glow-night-reveal',
'Neon Gece Cinsiyet Açıklaması', 'Glow Night Gender Reveal',
'Karanlıkta parlayan neon ışıklarla unutulmaz bir gece cinsiyet açıklaması düzenleyin. UV ışıklar altında parlayan neon boyalar, fosforlu bileklikler ve ışıklı balonlarla büyülü bir atmosfer yaratın. Bahçeyi ya da terası UV lambalarla aydınlatın. Misafirlere neon boyalarla yüzlerini boyamaları için boya istasyonu kurun. Geri sayımla birlikte pembe veya mavi neon ışıklar yakılarak cinsiyet açıklansın. DJ eşliğinde neon parti düzenleyerek kutlamayı sabaha kadar sürdürün. Fosforlu konfetiler ve ışıklı çubuklar dağıtarak herkesin parıldamasını sağlayın. Profesyonel UV fotoğrafçısı ile etkileyici kareler yakalayın.',
'Organize an unforgettable nighttime gender reveal with glowing neon lights. Create a magical atmosphere with neon paints that glow under UV light, phosphorescent bracelets, and illuminated balloons. Light up the garden or terrace with UV lamps. Set up a paint station for guests to paint their faces with neon colors. Reveal the gender by lighting up pink or blue neon lights with a countdown. Continue the celebration until morning with a neon party accompanied by a DJ. Distribute phosphorescent confetti and glow sticks so everyone sparkles. Capture stunning shots with a professional UV photographer.',
'Karanlıkta parlayan neon ışıklar ve UV boyalarla büyüleyici bir gece cinsiyet açıklaması yapın.',
'Create a magical nighttime gender reveal with glowing neon lights and UV paints.',
3, 500, 2000, 5, 50, 7, 'outdoor', ARRAY['summer'], ARRAY['neon','gece','ışık','parti','cinsiyet','bebek','fosfor'], true, false);
-- 6. halloween-pumpkin-reveal (difficulty:2, outdoor, fall, budget:200-600, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'halloween-pumpkin-reveal',
'Cadılar Bayramı Balkabağı Cinsiyet Açıklaması', 'Halloween Pumpkin Gender Reveal',
'Sonbahar mevsiminin büyüsünü cinsiyet açıklamasıyla birleştirin. Büyük bir balkabağını oyarak içine pembe veya mavi duman bombası yerleştirin. Misafirler balkabağının etrafında toplandığında kapağı açın ve renkli dumanın yükselmesini izleyin. Balkabağının üzerine bebek temalı yüz ifadeleri oyun ve etrafını sonbahar yaprakları, mum ve çiçeklerle süsleyin. Küçük balkabakları misafirlere hediye olarak dağıtın. Sıcak elma şarabı ve tarçınlı kurabiyeler ikram ederek sonbahar temasını tamamlayın. Etkinliği gün batımında yaparak doğal ışığın büyüsünden faydalanın. Balkabağı boyama istasyonu kurarak çocukları da eğlendirin.',
'Combine the magic of autumn with a gender reveal. Carve a large pumpkin and place a pink or blue smoke bomb inside. When guests gather around the pumpkin, open the lid and watch the colored smoke rise. Carve baby-themed face expressions on the pumpkin and decorate the surroundings with autumn leaves, candles, and flowers. Distribute small pumpkins to guests as gifts. Complete the autumn theme by serving hot apple cider and cinnamon cookies. Hold the event at sunset to benefit from natural lighting magic. Set up a pumpkin painting station to entertain children as well.',
'Oyulmuş balkabağından yükselen renkli dumanla sonbahar temalı cinsiyet açıklaması yapın.',
'Reveal gender with colored smoke rising from a carved pumpkin in an autumn-themed setting.',
2, 200, 600, 3, 25, 3, 'outdoor', ARRAY['fall'], ARRAY['balkabağı','sonbahar','cinsiyet','duman','bebek','cadılar'], false, false);
-- 7. balloon-pop-gender-reveal (difficulty:1, both, all seasons, budget:100-300, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'balloon-pop-gender-reveal',
'Balon Patlatma Cinsiyet Açıklaması', 'Balloon Pop Gender Reveal',
'Klasik ve etkili bir cinsiyet açıklaması için büyük siyah balonları pembe veya mavi konfeti ile doldurun. Anne ve baba adayının birlikte iğneyle balonu patlatması ile konfetiler havada uçuşsun. Birden fazla balon hazırlayarak misafirlerin de katılımını sağlayın. Balonların içine küçük kağıt kalpler ve yıldızlar ekleyerek görsel zenginlik katın. Arka plana bebek temalı bir pankart asın ve fotoğraf köşesi oluşturun. Slow motion video çekimi yaparak o büyülü anı ölümsüzleştirin. Balonları helyum ile şişirerek tavana yakın tutun ve ip çekerek patlatma seçeneğini de değerlendirin. Basit ama son derece etkili bir sürpriz.',
'For a classic and effective gender reveal, fill large black balloons with pink or blue confetti. Have the expecting parents pop the balloon together with a pin as confetti flies through the air. Prepare multiple balloons to involve guests in the fun. Add small paper hearts and stars inside the balloons for visual richness. Hang a baby-themed banner in the background and create a photo corner. Take slow motion video to immortalize that magical moment. Consider filling balloons with helium to keep them near the ceiling and pulling strings to pop them. A simple yet extremely effective surprise.',
'Siyah balonlar patlatıldığında içinden pembe ya da mavi konfetiler uçuşarak cinsiyeti açıklar.',
'Pop black balloons to release pink or blue confetti, revealing the baby''s gender.',
1, 100, 300, 2, 20, 1, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['balon','konfeti','cinsiyet','patlatma','bebek','klasik'], false, false);
-- 8. cake-cutting-gender-reveal (difficulty:2, indoor, all seasons, budget:300-1500, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'cake-cutting-gender-reveal',
'Pasta Kesme Cinsiyet Açıklaması', 'Cake Cutting Gender Reveal',
'Dışı beyaz ya da nötr renkte, içi pembe veya mavi katmanlı özel bir pasta sipariş vererek lezzetli bir cinsiyet açıklaması düzenleyin. Pastanın üzerine soru işareti ya da bebek figürleri yerleştirin. Anne ve baba adayı birlikte pastayı keserken içindeki renk ortaya çıksın. Pastanın yanı sıra aynı renkte cupcake ve kurabiyeler de hazırlatın. Pasta kesim anını dramatik bir müzik eşliğinde gerçekleştirin. Misafirlere tahmin kartları dağıtarak kız mı erkek mi oylaması yapın. Doğru tahmin edenlere küçük hediyeler verin. Profesyonel bir pastacıdan sipariş vererek görsel şöleni garantileyin.',
'Order a special cake with white or neutral exterior and pink or blue layered interior for a delicious gender reveal. Place question marks or baby figurines on top. As the expecting parents cut the cake together, the color inside is revealed. Also prepare cupcakes and cookies in the same color. Perform the cake cutting to dramatic music. Distribute guess cards to guests for a boy or girl vote. Give small gifts to those who guess correctly. Order from a professional baker to guarantee a visual feast. This timeless tradition creates beautiful photo moments and satisfies everyone''s sweet tooth.',
'Dışı beyaz içi renkli özel pastayı keserek bebeğin cinsiyetini tatlı bir sürprizle açıklayın.',
'Cut a specially made cake to reveal pink or blue layers inside for a sweet gender reveal.',
2, 300, 1500, 2, 30, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['pasta','cinsiyet','tatlı','kesim','bebek','kutlama'], false, false);
-- 9. painted-tshirt-reveal (difficulty:1, both, all seasons, budget:100-400, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'painted-tshirt-reveal',
'Boyalı Tişört Cinsiyet Açıklaması', 'Painted T-Shirt Gender Reveal',
'Anne ve baba adayı için özel tasarlanmış tişörtlerle eğlenceli bir cinsiyet açıklaması yapın. Tişörtlerin üzerine gizli mesajlar veya bebek görselleri basılsın. Ceketin altındaki tişörtü açarak cinsiyeti ortaya koyun. Misafirlere de boyama malzemeleri dağıtarak kendi bebek tişörtlerini tasarlamalarını sağlayın. Kumaş boyaları ve şablonlar kullanarak herkes benzersiz bir tişört yapsın. Bu tişörtler hem hatıra hem de pratik bir hediye olarak kalır. Tişört boyama etkinliğini müzik eşliğinde düzenleyin. Bütçe dostu ve herkesin katılabileceği samimi bir etkinlik oluşturun.',
'Create a fun gender reveal with specially designed t-shirts for the expecting parents. Have secret messages or baby graphics printed on the shirts. Reveal the gender by opening the jacket to show the t-shirt underneath. Distribute painting supplies to guests so they can design their own baby t-shirts. Using fabric paints and stencils, everyone creates a unique shirt. These shirts remain as both keepsakes and practical gifts. Organize the t-shirt painting activity accompanied by music. Create a budget-friendly and intimate event where everyone can participate and feel involved in welcoming the new baby.',
'Özel tasarım tişörtleri açarak cinsiyeti gösterin ve misafirlerle birlikte tişört boyayın.',
'Reveal gender by unveiling custom t-shirts and paint baby shirts together with guests.',
1, 100, 400, 2, 15, 2, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['tişört','boya','cinsiyet','tasarım','bebek','yaratıcı'], false, false);
-- 10. digital-time-capsule-baby (difficulty:3, indoor, all seasons, budget:200-1000, premium)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'digital-time-capsule-baby',
'Dijital Zaman Kapsülü Bebek Sürprizi', 'Digital Time Capsule Baby Surprise',
'Bebeğiniz için dijital bir zaman kapsülü oluşturarak duygusal ve teknolojik bir sürpriz hazırlayın. Aile üyelerinden ve yakın arkadaşlardan bebeğe video mesajları toplayın. Bu mesajları özel bir USB bellek veya dijital albüme kaydedin. Hamilelik sürecindeki ultrason görüntüleri, fotoğraflar ve günlük tutulmuş notları da ekleyin. Kapsüle günün gazetesi, popüler şarkılar listesi ve aile ağacı bilgileri koyun. Bebeğin 18. yaşında açılmak üzere şifreli bir dosya oluşturun. Baby shower partisinde misafirlerin canlı mesaj kaydetmelerini sağlayın. Bu paha biçilmez hediye yıllar sonra çok değerli olacak.',
'Create a digital time capsule for your baby as an emotional and technological surprise. Collect video messages from family members and close friends addressed to the baby. Save these messages on a special USB drive or digital album. Add ultrasound images, photos, and diary notes from the pregnancy journey. Include the day''s newspaper, popular songs list, and family tree information in the capsule. Create an encrypted file to be opened on the baby''s 18th birthday. Have guests record live messages at the baby shower party. This priceless gift will become incredibly valuable years later as a window into the past.',
'Bebeğe video mesajları ve anılar içeren dijital zaman kapsülü oluşturun, 18 yaşında açılsın.',
'Create a digital time capsule with video messages and memories to be opened on baby''s 18th birthday.',
3, 200, 1000, 2, 20, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['dijital','zaman','kapsül','video','bebek','hatıra','teknoloji'], true, false);
-- 11. baby-shower-picnic (difficulty:2, outdoor, spring/summer, budget:500-2000, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'baby-shower-picnic',
'Piknik Baby Shower Partisi', 'Baby Shower Picnic Party',
'Açık havada doğanın güzelliği içinde unutulmaz bir baby shower pikniği düzenleyin. Battaniyeler, yastıklar ve çiçek düzenlemeleriyle bohem tarzı bir oturma alanı oluşturun. Pastel renklerde balonlar ve flamalar ile alanı süsleyin. Parmak sandviçler, mini kekler, meyve tabakları ve limonata gibi piknik lezzetleri hazırlayın. Bebek bezi pasta yapma yarışması, bebek fotoğrafı tahmin oyunu ve dilek ağacı gibi aktiviteler planlayın. Her misafire bebek temalı küçük hediye paketleri hazırlayın. Güzel bir parkta ya da sahilde piknik kurarak fotoğraf için doğal bir arka plan oluşturun. Müzik çalma listesi hazırlayarak keyifli bir atmosfer yaratın.',
'Organize an unforgettable baby shower picnic in the beauty of nature outdoors. Create a bohemian-style seating area with blankets, cushions, and flower arrangements. Decorate the area with pastel-colored balloons and banners. Prepare picnic delights like finger sandwiches, mini cakes, fruit platters, and lemonade. Plan activities such as diaper cake making contests, baby photo guessing games, and a wishing tree. Prepare small baby-themed gift packages for each guest. Set up the picnic in a beautiful park or beach to create a natural backdrop for photos. Create a pleasant atmosphere with a prepared music playlist.',
'Doğanın içinde bohem tarzı battaniyeler ve çiçeklerle süslenmiş bir baby shower pikniği yapın.',
'Host a bohemian-style baby shower picnic with blankets and flowers in beautiful nature.',
2, 500, 2000, 5, 25, 5, 'outdoor', ARRAY['spring','summer'], ARRAY['piknik','bebek','parti','doğa','shower','kutlama'], false, false);
-- 12. book-themed-shower (difficulty:3, indoor, all seasons, budget:800-3000, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'book-themed-shower',
'Kitap Temalı Baby Shower', 'Book Themed Baby Shower',
'Edebiyat severler için masalsı bir kitap temalı baby shower düzenleyin. Davetiye yerine mini kitapçıklar gönderin. Mekanı eski kitaplar, kütüphane rafları ve meşhur çocuk kitabı karakterleriyle süsleyin. Her misafirden hediye yerine bebeğe bir kitap ve içine yazılmış özel bir not getirmesini isteyin. Bu şekilde bebeğin ilk kütüphanesini oluşturun. Masaları kitap sayfalarından yapılmış çiçek buketleriyle süsleyin. Kitap ayracı yapma atölyesi düzenleyin. Favori çocuk kitabı karakterlerinin kostümleriyle fotoğraf köşesi oluşturun. Hikaye okuma köşesi hazırlayarak misafirlerin bebeğe sesli mesaj bırakmasını sağlayın.',
'Organize a fairy-tale book-themed baby shower for literature lovers. Send mini booklets instead of invitations. Decorate the venue with old books, library shelves, and famous children''s book characters. Ask each guest to bring a book for the baby instead of a gift, with a special note written inside. This way, build the baby''s first library. Decorate tables with flower bouquets made from book pages. Organize a bookmark-making workshop. Create a photo corner with costumes of favorite children''s book characters. Set up a story reading corner where guests can leave audio messages for the baby.',
'Kitap ve edebiyat temalı baby shower ile bebeğin ilk kütüphanesini oluşturun.',
'Build baby''s first library with a book-themed baby shower full of literary touches.',
3, 800, 3000, 5, 30, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kitap','edebiyat','bebek','kütüphane','shower','masal','tema'], false, false);
-- 13. safari-themed-shower (difficulty:3, both, spring/summer, budget:1000-4000, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'safari-themed-shower',
'Safari Temalı Baby Shower', 'Safari Themed Baby Shower',
'Tropik bitkiler, hayvan desenleri ve doğal ahşap detaylarla vahşi doğa atmosferi yaratarak safari temalı baby shower düzenleyin. Aslan, zürafa, fil ve zebra figürleri ile mekanı süsleyin. Yeşil yapraklar ve kahverengi tonlarda masa örtüleri kullanın. Hayvan şekilli kurabiyeler ve safari temalı pasta hazırlatın. Misafirlere safari şapkaları ve dürbünler dağıtarak eğlenceyi artırın. Peluş hayvan yapma istasyonu kurarak her misafirin bebeğe bir peluş hediye hazırlamasını sağlayın. Doğa sesleri çalarak atmosferi güçlendirin. Fotoğraf köşesinde safari jip maketi ve tropikal arka plan kullanın.',
'Create a wild nature atmosphere with tropical plants, animal patterns, and natural wood details for a safari-themed baby shower. Decorate the venue with lion, giraffe, elephant, and zebra figures. Use green leaves and brown-toned tablecloths. Have animal-shaped cookies and safari-themed cake prepared. Increase the fun by distributing safari hats and binoculars to guests. Set up a stuffed animal making station where each guest prepares a plush gift for the baby. Strengthen the atmosphere by playing nature sounds. Use a safari jeep model and tropical backdrop at the photo corner.',
'Hayvan figürleri ve tropikal bitkilerle safari temalı unutulmaz bir baby shower düzenleyin.',
'Host an unforgettable safari-themed baby shower with animal figures and tropical plants.',
3, 1000, 4000, 8, 40, 7, 'both', ARRAY['spring','summer'], ARRAY['safari','hayvan','tropik','bebek','shower','doğa','tema'], false, false);
-- 14. teddy-bear-shower (difficulty:2, indoor, all seasons, budget:600-2500, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'teddy-bear-shower',
'Oyuncak Ayı Temalı Baby Shower', 'Teddy Bear Baby Shower',
'Sevimli oyuncak ayılarla dolu sıcacık bir baby shower düzenleyin. Mekanı farklı boyutlarda peluş ayılarla süsleyin ve pastel renklerde balonlarla tamamlayın. Her masaya minik ayıcık figürleri yerleştirin. Ayı şekilli kurabiyeler, bal temalı tatlılar ve ayıcıklı pasta hazırlatın. Misafirlerin kendi ayıcıklarını giydirmeleri için küçük kıyafetler ve aksesuarlar hazırlayın. Bebeğe mektup yazma köşesi oluşturarak misafirlerin duygusal mesajlarını toplayın. Hediye olarak her misafire ayı temalı mum ya da sabun verin. Arka planda hafif ninni müzikleri çalarak huzurlu bir atmosfer oluşturun.',
'Organize a cozy baby shower filled with adorable teddy bears. Decorate the venue with plush bears of different sizes and complement with pastel-colored balloons. Place tiny bear figurines on each table. Have bear-shaped cookies, honey-themed desserts, and a teddy bear cake prepared. Prepare small clothes and accessories for guests to dress their own teddy bears. Create a letter-writing corner for guests to write emotional messages to the baby. Give each guest a bear-themed candle or soap as a favor. Create a peaceful atmosphere by playing soft lullaby music in the background.',
'Peluş ayıcıklar ve pastel balonlarla süslenmiş sevimli bir baby shower düzenleyin.',
'Host an adorable baby shower decorated with plush teddy bears and pastel balloons.',
2, 600, 2500, 5, 25, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['ayıcık','peluş','sevimli','bebek','shower','pastel'], false, false);
-- 15. cloud-themed-shower (difficulty:2, indoor, all seasons, budget:500-2000, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'cloud-themed-shower',
'Bulut Temalı Baby Shower', 'Cloud Themed Baby Shower',
'Pamuk bulutlar ve gökkuşağı renkleriyle rüya gibi bir baby shower atmosferi yaratın. Tavandan sarkan pamuk bulutları ve yağmur damlası şeklinde süslemeler asın. Beyaz, açık mavi ve gri tonlarda dekorasyon kullanın. Bulut şekilli marshmallow çubukları, gökkuşağı renkli kekler ve yağmur damlası jöleleri hazırlayın. Misafirlere bulut şeklinde dilek kartları dağıtarak bebeğe dileklerini yazmalarını isteyin. Bu kartları bir ipe asarak dilek bulutu oluşturun. Fotoğraf köşesinde büyük pamuk bulutları ve ay figürü kullanın. Hafif ve rüya gibi bir müzik listesi hazırlayarak eterik bir atmosfer yaratın.',
'Create a dreamy baby shower atmosphere with cotton clouds and rainbow colors. Hang cotton clouds and raindrop-shaped decorations from the ceiling. Use white, light blue, and gray tone decorations. Prepare cloud-shaped marshmallow sticks, rainbow-colored cupcakes, and raindrop jellies. Distribute cloud-shaped wish cards to guests and ask them to write their wishes for the baby. Create a wish cloud by hanging these cards on a string. Use large cotton clouds and a moon figure at the photo corner. Create an ethereal atmosphere by preparing a light and dreamy music playlist throughout the event.',
'Pamuk bulutlar ve gökkuşağı renkleriyle rüya gibi bir baby shower deneyimi yaşatın.',
'Create a dreamy baby shower experience with cotton clouds and rainbow colors.',
2, 500, 2000, 5, 20, 4, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['bulut','gökkuşağı','rüya','bebek','shower','pastel'], false, false);
-- 16. garden-fairy-shower (difficulty:4, outdoor, spring/summer, budget:2000-6000, premium)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'garden-fairy-shower',
'Bahçe Perisi Baby Shower', 'Garden Fairy Baby Shower',
'Büyülü bir peri bahçesi temasıyla açık havada masalsı bir baby shower düzenleyin. Ağaçlara peri ışıkları ve tül kumaşlar sarın. Minik peri kapıları ve mantar evleri bahçeye yerleştirin. Çiçek taçları yapma atölyesi kurarak misafirlerin kendi taçlarını örmelerini sağlayın. Peri kanatları ve değnekleri dağıtarak herkesin kostüme bürünmesini sağlayın. Doğal malzemelerle süslenmiş masalarda çiçek şekilli sandviçler ve peri tozu serpilmiş tatlılar ikram edin. Canlı keman veya arp müziği ile büyülü atmosferi tamamlayın. Kelebek salınımı ile büyüleyici bir final yapın.',
'Organize a fairy-tale baby shower outdoors with an enchanting fairy garden theme. Wrap fairy lights and tulle fabrics around trees. Place tiny fairy doors and mushroom houses throughout the garden. Set up a flower crown making workshop for guests to weave their own crowns. Distribute fairy wings and wands so everyone gets into costume. Serve flower-shaped sandwiches and fairy dust-sprinkled desserts on naturally decorated tables. Complete the magical atmosphere with live violin or harp music. Create an enchanting finale with a butterfly release that will leave everyone breathless with wonder.',
'Peri ışıkları, çiçek taçları ve büyülü dekorlarla masalsı bir bahçe baby shower''ı yapın.',
'Host a fairy-tale garden baby shower with fairy lights, flower crowns, and magical decor.',
4, 2000, 6000, 10, 40, 10, 'outdoor', ARRAY['spring','summer'], ARRAY['peri','bahçe','masal','çiçek','bebek','büyülü','shower'], true, false);
-- 17. nautical-themed-shower (difficulty:3, both, summer, budget:1000-3500, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'nautical-themed-shower',
'Denizci Temalı Baby Shower', 'Nautical Themed Baby Shower',
'Lacivert, beyaz ve kırmızı tonlarında denizci temalı şık bir baby shower düzenleyin. Çapa, dümen, yelkenli ve deniz yıldızı figürleriyle mekanı süsleyin. İp düğümleri ve çizgili kumaşlarla masa düzenlemesi yapın. Denizci şapkaları ve çizgili yelek dağıtarak misafirlerin tema ile bütünleşmesini sağlayın. Balık şekilli sandviçler, deniz kabuğu kurabiyeleri ve çapa şekilli kekler hazırlatın. Dümen çevirme oyunu ve hazine avı gibi deniz temalı aktiviteler planlayın. Hediye olarak deniz kokulu mumlar ve mini pusula anahtarlıkları verin. Misafirlere şişe mesajı yazdırarak bebeğe dileklerini gönderin.',
'Organize a stylish nautical-themed baby shower in navy, white, and red tones. Decorate the venue with anchor, rudder, sailboat, and starfish figures. Create table arrangements with rope knots and striped fabrics. Distribute sailor hats and striped vests so guests blend with the theme. Have fish-shaped sandwiches, seashell cookies, and anchor-shaped cakes prepared. Plan sea-themed activities like rudder spinning games and treasure hunts. Give ocean-scented candles and mini compass keychains as favors. Have guests write bottle messages to send their wishes to the baby.',
'Çapa, dümen ve deniz yıldızlarıyla lacivert-beyaz tonlarında denizci temalı baby shower yapın.',
'Host a nautical baby shower in navy and white with anchors, rudders, and starfish decor.',
3, 1000, 3500, 5, 30, 7, 'both', ARRAY['summer'], ARRAY['denizci','lacivert','çapa','deniz','bebek','shower','tema'], false, false);
-- 18. twinkle-star-shower (difficulty:2, indoor, all seasons, budget:400-1500, free, featured)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'twinkle-star-shower',
'Yıldız Işığı Baby Shower', 'Twinkle Star Baby Shower',
'Parıldayan yıldızlar ve ay ışığı temasıyla büyüleyici bir baby shower düzenleyin. Tavandan altın ve gümüş renkte yıldızlar asın. Peri ışıkları ile mekanı aydınlatarak sıcak bir atmosfer yaratın. Lacivert ve altın renk paletini kullanarak zarif bir dekorasyon oluşturun. Yıldız şekilli kurabiyeler, hilal ay kekleri ve galaksi temalı pasta hazırlatın. Misafirlere yıldız dilek kartları dağıtarak bebeğe dileklerini yazmalarını isteyin. Her misafir için yıldız şekilli isim kartı hazırlayın. Teleskop kurarak yıldız gözlemi yapın veya projektörle tavana yıldızlı gökyüzü yansıtın.',
'Organize a mesmerizing baby shower with a sparkling stars and moonlight theme. Hang gold and silver stars from the ceiling. Create a warm atmosphere by illuminating the venue with fairy lights. Create elegant decoration using a navy blue and gold color palette. Have star-shaped cookies, crescent moon cupcakes, and galaxy-themed cake prepared. Distribute star wish cards to guests and ask them to write wishes for the baby. Prepare star-shaped name cards for each guest. Set up a telescope for stargazing or project a starry sky onto the ceiling with a projector.',
'Altın yıldızlar ve peri ışıklarıyla parıldayan büyüleyici bir baby shower yaşayın.',
'Experience a mesmerizing baby shower sparkling with gold stars and fairy lights.',
2, 400, 1500, 5, 25, 4, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['yıldız','ışık','altın','gece','bebek','shower','büyülü'], false, true);
-- 19. woodland-themed-shower (difficulty:3, both, fall, budget:800-3000, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'woodland-themed-shower',
'Orman Temalı Baby Shower', 'Woodland Themed Baby Shower',
'Doğanın sıcaklığını evinize taşıyarak orman temalı huzurlu bir baby shower düzenleyin. Ağaç kütükleri, yosunlar, kozalaklar ve kuru dallarla rustik bir dekorasyon oluşturun. Tilki, geyik, tavşan ve baykuş figürleri ile orman atmosferi yaratın. Toprak tonlarında masa örtüleri ve doğal çiçek düzenlemeleri kullanın. Mantar şekilli kekler, meşe palamudu kurabiyeleri ve kütük pasta hazırlatın. Yaprak baskı atölyesi düzenleyerek misafirlerin doğal sanat eserleri oluşturmasını sağlayın. Odun kokulu mumlar yakarak otantik bir atmosfer yaratın. Her misafire tohum bombası hediye ederek doğaya katkıda bulunun.',
'Bring the warmth of nature indoors by organizing a peaceful woodland-themed baby shower. Create rustic decoration with tree stumps, moss, pine cones, and dry branches. Create a forest atmosphere with fox, deer, rabbit, and owl figures. Use earth-toned tablecloths and natural flower arrangements. Have mushroom-shaped cupcakes, acorn cookies, and log cake prepared. Organize a leaf printing workshop for guests to create natural artworks. Light wood-scented candles to create an authentic atmosphere. Gift seed bombs to each guest to contribute to nature and remember this special day.',
'Ağaç kütükleri, hayvan figürleri ve doğal malzemelerle rustik orman temalı baby shower yapın.',
'Host a rustic woodland baby shower with tree stumps, animal figures, and natural materials.',
3, 800, 3000, 5, 25, 7, 'both', ARRAY['fall'], ARRAY['orman','doğa','rustik','hayvan','bebek','shower','tema'], false, false);
-- 20. rainbow-themed-shower (difficulty:2, indoor, all seasons, budget:500-2000, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'rainbow-themed-shower',
'Gökkuşağı Temalı Baby Shower', 'Rainbow Themed Baby Shower',
'Rengarenk gökkuşağı temasıyla neşeli ve enerjik bir baby shower düzenleyin. Her masayı gökkuşağının farklı bir renginde süsleyin. Renkli balonlar, flamalar ve kağıt fanlarla mekanı canlandırın. Gökkuşağı katmanlı pasta, renkli makaron kulesi ve şeker büfesi hazırlatın. Misafirlere renkli bileklikler ve güneş gözlükleri dağıtın. Renk bazlı takım oyunları düzenleyerek eğlenceli aktiviteler planlayın. Her misafirin gökkuşağının bir renginde kıyafet giymesini isteyerek toplu fotoğrafta canlı bir görüntü oluşturun. Bebek için renkli iplerden dream catcher yapma atölyesi düzenleyin.',
'Organize a cheerful and energetic baby shower with a colorful rainbow theme. Decorate each table in a different color of the rainbow. Liven up the venue with colorful balloons, streamers, and paper fans. Have a rainbow-layered cake, colorful macaron tower, and candy buffet prepared. Distribute colorful bracelets and sunglasses to guests. Plan fun activities by organizing color-based team games. Ask each guest to wear clothing in one color of the rainbow to create a vibrant group photo. Organize a dream catcher making workshop with colorful threads for the baby.',
'Gökkuşağının tüm renkleriyle neşeli ve enerjik bir baby shower deneyimi yaşatın.',
'Create a cheerful and energetic baby shower experience with all colors of the rainbow.',
2, 500, 2000, 5, 30, 4, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['gökkuşağı','renk','neşeli','bebek','shower','parti','renkli'], false, false);
-- 21. hot-air-balloon-shower (difficulty:5, outdoor, spring/summer, budget:5000-20000, premium)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'hot-air-balloon-shower',
'Sıcak Hava Balonu Baby Shower', 'Hot Air Balloon Baby Shower',
'Gökyüzüne yükselen sıcak hava balonlarıyla nefes kesici bir baby shower deneyimi yaşatın. Profesyonel bir balon şirketiyle anlaşarak bağlı balon uçuşu veya mini balon festivali düzenleyin. Anne adayı ve en yakınları balonla kısa bir uçuş yaparak gökyüzünden manzaranın tadını çıkarsın. Yerde kalan misafirler için balon temalı dekorasyon ve piknik düzeni kurun. Mini sıcak hava balonu maketleri ile mekanı süsleyin. Balon şekilli kurabiyeler ve bulut temalı tatlılar hazırlatın. Drone ile havadan çekim yaparak unutulmaz görüntüler elde edin. Bu lüks deneyim hayat boyu unutulmayacak anılar bırakacak.',
'Create a breathtaking baby shower experience with hot air balloons rising to the sky. Arrange a tethered balloon flight or mini balloon festival with a professional balloon company. Have the expecting mother and closest ones enjoy the view from the sky with a short balloon ride. Set up balloon-themed decoration and picnic arrangement for guests remaining on the ground. Decorate the venue with mini hot air balloon models. Have balloon-shaped cookies and cloud-themed desserts prepared. Capture unforgettable footage with drone aerial photography. This luxury experience will leave memories that last a lifetime.',
'Sıcak hava balonu uçuşuyla gökyüzünde nefes kesici bir baby shower deneyimi yaşayın.',
'Experience a breathtaking baby shower in the sky with a hot air balloon flight.',
5, 5000, 20000, 5, 30, 14, 'outdoor', ARRAY['spring','summer'], ARRAY['balon','gökyüzü','uçuş','lüks','bebek','shower','macera'], true, false);
-- 22. elephant-themed-shower (difficulty:2, indoor, all seasons, budget:400-1800, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'elephant-themed-shower',
'Fil Temalı Baby Shower', 'Elephant Themed Baby Shower',
'Sevimli fil figürleri ve gri-pastel renk paletiyle zarif bir baby shower düzenleyin. Peluş filler, fil balonları ve fil desenli süslerle mekanı donatın. Gri, beyaz ve pastel pembe ya da mavi tonlarında şık bir dekorasyon oluşturun. Fil şekilli kurabiyeler, fıstıklı kekler ve fil figürlü pasta hazırlatın. Misafirlere fil temalı anahtarlıklar ve mini peluşler hediye edin. Fil hortumu atma oyunu gibi eğlenceli aktiviteler düzenleyin. Bebeğin adını fil kulakları şeklinde kesilmiş kartlara yazdırarak misafirlere dağıtın. Bebek fil kostümü hazırlayarak sevimli fotoğraf çekimleri yapın.',
'Organize an elegant baby shower with adorable elephant figures and a gray-pastel color palette. Equip the venue with plush elephants, elephant balloons, and elephant-patterned decorations. Create stylish decoration in gray, white, and pastel pink or blue tones. Have elephant-shaped cookies, pistachio cupcakes, and elephant-figured cake prepared. Gift elephant-themed keychains and mini plush toys to guests. Organize fun activities like elephant trunk toss games. Write the baby''s name on cards cut in elephant ear shapes and distribute to guests. Prepare a baby elephant costume for adorable photo shoots.',
'Peluş filler ve gri-pastel tonlarla zarif ve sevimli bir fil temalı baby shower yapın.',
'Host an elegant and cute elephant-themed baby shower with plush elephants and pastel tones.',
2, 400, 1800, 5, 25, 4, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['fil','peluş','sevimli','bebek','shower','zarif','gri'], false, false);
-- 23. bee-themed-shower (difficulty:2, both, spring/summer, budget:400-1500, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'bee-themed-shower',
'Arı Temalı Baby Shower', 'Bee Themed Baby Shower',
'Sarı ve siyah renklerde tatlı bir arı temalı baby shower düzenleyin. Petek desenleri, arı figürleri ve ayçiçekleriyle neşeli bir dekorasyon oluşturun. Bal kavanozlarını masa süsü olarak kullanın ve her birinin üzerine misafir ismi yazın. Petek şekilli kurabiyeler, ballı kekler ve arı kovanı pasta hazırlatın. Misafirlere mini bal kavanozu hediye edin. Arı kostümü ile fotoğraf çekimi alanı oluşturun. Çiçek tohumu paketleri dağıtarak doğaya katkı sağlayın. Sarı balonlar ve siyah şeritlerle mekanı canlandırın. Bu tatlı tema ile herkesin yüzünde gülümseme olacak.',
'Organize a sweet bee-themed baby shower in yellow and black colors. Create cheerful decoration with honeycomb patterns, bee figures, and sunflowers. Use honey jars as table centerpieces with each guest''s name written on them. Have honeycomb-shaped cookies, honey cupcakes, and beehive cake prepared. Gift mini honey jars to guests as favors. Create a photo area with a bee costume. Distribute flower seed packets to contribute to nature. Liven up the venue with yellow balloons and black ribbons. This sweet theme will put a smile on everyone''s face and create buzz-worthy memories.',
'Sarı-siyah arı teması, bal kavanozu süsleri ve petek kurabiyelerle neşeli bir baby shower yapın.',
'Host a cheerful bee-themed baby shower with honey jar decor and honeycomb cookies.',
2, 400, 1500, 5, 25, 4, 'both', ARRAY['spring','summer'], ARRAY['arı','bal','sarı','petek','bebek','shower','çiçek'], false, false);
-- 24. confetti-cannon-reveal (difficulty:1, outdoor, spring/summer/fall, budget:150-500, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'confetti-cannon-reveal',
'Konfeti Topu Cinsiyet Açıklaması', 'Confetti Cannon Gender Reveal',
'Pembe ya da mavi konfeti dolu özel toplarla heyecan verici bir cinsiyet açıklaması yapın. Birden fazla konfeti topu hazırlayarak anne baba ve büyükanne büyükbaba dahil herkesin aynı anda patlatmasını sağlayın. Konfeti toplarını özel mağazalardan temin edebilir ya da kendiniz hazırlayabilirsiniz. Açık havada geniş bir alanda sıralanın ve geri sayımla birlikte topları patlatan herkesin üstüne konfeti yağsın. Bu rengarenk anı birden fazla açıdan kameraya almak için arkadaşlarınızı görevlendirin. Rüzgar yönünü kontrol ederek konfetilerin güzel dağılmasını sağlayın. Temizlik için çevre dostu konfetiler tercih edin.',
'Create an exciting gender reveal with special cannons filled with pink or blue confetti. Prepare multiple confetti cannons so parents and grandparents can all pop them simultaneously. You can purchase confetti cannons from specialty stores or make them yourself. Line up in an open area outdoors and with a countdown, let confetti rain on everyone popping the cannons. Assign friends to capture this colorful moment from multiple angles on camera. Check wind direction to ensure confetti disperses beautifully. Choose eco-friendly confetti for easy cleanup to keep the celebration environmentally responsible.',
'Pembe ya da mavi konfeti toplarını hep birlikte patlatarak heyecanlı bir cinsiyet açıklaması yapın.',
'Pop pink or blue confetti cannons together for an exciting gender reveal celebration.',
1, 150, 500, 2, 30, 1, 'outdoor', ARRAY['spring','summer','fall'], ARRAY['konfeti','patlatma','cinsiyet','renkli','bebek','heyecan'], false, false);
-- 25. smoke-bomb-reveal (difficulty:3, outdoor, spring/summer, budget:300-1000, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'smoke-bomb-reveal',
'Duman Bombası Cinsiyet Açıklaması', 'Smoke Bomb Gender Reveal',
'Pembe ya da mavi renkli duman bombalarıyla dramatik ve görsel olarak etkileyici bir cinsiyet açıklaması yapın. Güvenli ve toksik olmayan fotoğraf duman bombalarını kullanarak açık havada renkli dumanın yayılmasını izleyin. En az iki duman bombası kullanarak yoğun bir efekt yaratın. Duman bombasını güvenli bir mesafede tutun ve rüzgar yönüne dikkat edin. Bu tekniği profesyonel fotoğrafçılarla birlikte planlayarak sinematik kareler elde edin. Altın saat denilen gün batımı öncesi sıcak ışıkta çekim yaparak muhteşem görseller yakalayın. Drone çekimi ile havadan da görüntüler alarak epik bir video oluşturun.',
'Create a dramatic and visually stunning gender reveal with pink or blue colored smoke bombs. Use safe, non-toxic photography smoke bombs and watch the colored smoke spread outdoors. Use at least two smoke bombs for an intense effect. Hold the smoke bomb at a safe distance and pay attention to wind direction. Plan this technique with professional photographers to achieve cinematic shots. Capture magnificent visuals by shooting during golden hour, the warm light before sunset. Create an epic video by capturing aerial footage with drone photography for a truly spectacular reveal.',
'Renkli duman bombalarıyla açık havada dramatik ve sinematik bir cinsiyet açıklaması yapın.',
'Create a dramatic cinematic gender reveal outdoors with colored smoke bombs.',
3, 300, 1000, 2, 30, 3, 'outdoor', ARRAY['spring','summer'], ARRAY['duman','bomba','cinsiyet','dramatik','bebek','fotoğraf','sinematik'], false, false);
-- 26. fireworks-gender-reveal (difficulty:5, outdoor, summer, budget:8000-25000, premium)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'fireworks-gender-reveal',
'Havai Fişek Cinsiyet Açıklaması', 'Fireworks Gender Reveal',
'Gökyüzünü pembe ya da mavi havai fişeklerle aydınlatarak unutulmaz bir cinsiyet açıklaması yapın. Profesyonel bir havai fişek şirketiyle anlaşarak güvenli ve görkemli bir gösteri planlayın. Gerekli izinleri belediyeden ve itfaiyeden önceden alın. Misafirler için güvenli izleme alanı oluşturun ve oturma düzeni hazırlayın. Havai fişek gösterisinden önce kısa bir konuşma yaparak duyguları doruk noktasına çıkarın. Son ateşleme ile gökyüzünde pembe ya da mavi renk patladığında herkesin çığlıkları geceyi dolduracak. Profesyonel video çekimi ile bu anı sinematik bir film gibi kaydedin. Gösterinin ardından pasta kesimi ile kutlamaya devam edin.',
'Illuminate the sky with pink or blue fireworks for an unforgettable gender reveal. Plan a safe and magnificent show by working with a professional fireworks company. Obtain necessary permits from the municipality and fire department in advance. Create a safe viewing area for guests and prepare seating arrangements. Build emotions to their peak with a short speech before the fireworks show. When the final ignition bursts pink or blue across the sky, everyone''s cheers will fill the night. Record this moment like a cinematic film with professional video capture. Continue the celebration with cake cutting after the show.',
'Gökyüzünü pembe ya da mavi havai fişeklerle aydınlatarak görkemli bir cinsiyet açıklaması yapın.',
'Light up the sky with pink or blue fireworks for a magnificent gender reveal.',
5, 8000, 25000, 10, 100, 14, 'outdoor', ARRAY['summer'], ARRAY['havai fişek','gökyüzü','cinsiyet','görkemli','bebek','gece','lüks'], true, false);
-- 27. pinata-gender-reveal (difficulty:1, both, all seasons, budget:100-400, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'pinata-gender-reveal',
'Pinyata Cinsiyet Açıklaması', 'Pinata Gender Reveal',
'İçi pembe ya da mavi şeker ve konfetilerle dolu renkli bir pinyata ile eğlenceli bir cinsiyet açıklaması yapın. Bebek temalı bir pinyata sipariş edin veya kendiniz yapın. Pinyatayı bir ağaç dalına ya da tavana asın. Anne ve baba adayına gözlerini bağlayarak sopa ile pinyatayı vurmalarını sağlayın. Pinyata kırıldığında içinden dökülen renkli şekerler ve konfetiler cinsiyeti açıklasın. Misafirler dökülen şekerleri toplamak için yarışsın. Çocuklar için de küçük pinyatalar hazırlayarak herkesin eğlenmesini sağlayın. Bu ekonomik ve eğlenceli yöntem her yaştan misafirin keyif alacağı bir aktivite sunar.',
'Create a fun gender reveal with a colorful pinata filled with pink or blue candy and confetti. Order a baby-themed pinata or make your own. Hang the pinata from a tree branch or ceiling. Blindfold the expecting parents and have them hit the pinata with a stick. When the pinata breaks, the colored candy and confetti that pour out reveal the gender. Have guests race to collect the fallen candy. Prepare smaller pinatas for children so everyone has fun. This affordable and entertaining method offers an activity that guests of all ages will enjoy.',
'Pinyata kırıldığında içinden dökülen renkli şekerlerle eğlenceli bir cinsiyet açıklaması yapın.',
'Break a pinata to reveal gender through pink or blue candy and confetti pouring out.',
1, 100, 400, 3, 25, 2, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['pinyata','şeker','cinsiyet','eğlence','bebek','konfeti'], false, false);
-- 28. puzzle-piece-reveal (difficulty:2, indoor, all seasons, budget:150-600, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'puzzle-piece-reveal',
'Yapboz Parçası Cinsiyet Açıklaması', 'Puzzle Piece Gender Reveal',
'Özel tasarlanmış bir yapboz ile merak uyandıran ve etkileşimli bir cinsiyet açıklaması düzenleyin. Ultrason fotoğrafı ve cinsiyet bilgisini içeren kişisel bir yapboz bastırın. Misafirlerin birlikte yapbozu tamamlamasını sağlayarak heyecanı kademeli olarak artırın. Son parça yerleştirildiğinde cinsiyetin ortaya çıkması büyük bir sevinç patlamasına neden olacak. Alternatif olarak büyükanne büyükbabaya yapbozu hediye paketi olarak göndererek onların tepkisini video ile kaydedin. Yapbozu çerçeveletip bebek odasına asarak kalıcı bir hatıra oluşturun. Bu yöntem özellikle uzaktaki aile üyelerine sürprizi iletmek için mükemmeldir.',
'Organize an intriguing and interactive gender reveal with a custom-designed puzzle. Print a personalized puzzle containing the ultrasound photo and gender information. Have guests complete the puzzle together, gradually building excitement. When the last piece is placed, the gender reveal will cause an eruption of joy. Alternatively, send the puzzle as a gift package to grandparents and record their reaction on video. Frame the completed puzzle and hang it in the nursery as a lasting keepsake. This method is especially perfect for delivering the surprise to distant family members.',
'Özel tasarım yapbozun son parçası yerleştiğinde bebeğin cinsiyeti ortaya çıksın.',
'Reveal gender when the last piece of a custom puzzle is placed, building excitement gradually.',
2, 150, 600, 2, 15, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['yapboz','cinsiyet','etkileşim','hatıra','bebek','sürpriz'], false, false);
-- 29. fortune-cookie-reveal (difficulty:1, indoor, all seasons, budget:80-300, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'fortune-cookie-reveal',
'Kurabiye Fal Cinsiyet Açıklaması', 'Fortune Cookie Gender Reveal',
'Özel hazırlanmış şans kurabiyelerinin içine cinsiyet bilgisi yazılmış kağıtlar yerleştirerek zarif bir cinsiyet açıklaması yapın. Her misafir için bir kurabiye hazırlayın ve hep birlikte aynı anda kırılmasını sağlayın. Kağıtların üzerine eğlenceli ve şirin mesajlar yazın. Kurabiyeleri evde kendiniz yapabilir ya da bir pastaneden özel sipariş verebilirsiniz. Pembe veya mavi renkte glasür ile kaplayarak ipucu verin ya da nötr renkte bırakarak sürprizi saklayın. Çin yemeği temalı bir akşam yemeği düzenleyerek konsepti tamamlayın. Kurabiyeleri zarif kutularda sunarak sunum kalitesini artırın. Basit ama çok etkili bir yöntem.',
'Create an elegant gender reveal by placing gender information notes inside specially made fortune cookies. Prepare one cookie for each guest and have everyone crack them open simultaneously. Write fun and cute messages on the papers inside. You can make the cookies at home or order custom ones from a bakery. Coat them with pink or blue glaze to give hints or leave them neutral to keep the surprise. Complete the concept by organizing a Chinese food-themed dinner. Present cookies in elegant boxes to enhance presentation quality. A simple yet very effective method that everyone will love.',
'Şans kurabiyelerini kırdığınızda içinden cinsiyet bilgisi çıkan zarif bir açıklama yapın.',
'Crack fortune cookies to reveal gender information inside for an elegant surprise.',
1, 80, 300, 2, 20, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kurabiye','şans','cinsiyet','zarif','bebek','sürpriz'], false, false);
-- 30. watercolor-gender-reveal (difficulty:3, outdoor, spring/summer, budget:300-1200, premium)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_baby, 'watercolor-gender-reveal',
'Suluboya Cinsiyet Açıklaması', 'Watercolor Gender Reveal',
'Sanatsal bir suluboya etkinliği ile zarif ve yaratıcı bir cinsiyet açıklaması düzenleyin. Büyük kağıtlar ve suluboya malzemeleri hazırlayarak misafirlerle birlikte resim yapma etkinliği düzenleyin. Gizli bir mesaj tekniği kullanarak beyaz mum boyayla önceden cinsiyet bilgisini yazın. Misafirler suluboya sürdüğünde gizli mesaj ortaya çıksın. Alternatif olarak su ile çözünen pembe veya mavi boya kapsülleri suya atarak renk değişimini izleyin. Havuzda ya da şeffaf bir kapta yapılan bu gösteri büyüleyici görseller sunar. Ortaya çıkan sanat eserlerini kurutup çerçeveletmeniz mümkün. Profesyonel bir sanatçı eşliğinde atölye düzenleyin.',
'Organize an elegant and creative gender reveal with an artistic watercolor event. Prepare large papers and watercolor supplies for a painting activity with guests. Using a secret message technique, write the gender information beforehand with white wax crayon. When guests apply watercolor, the hidden message is revealed. Alternatively, watch the color change by dropping water-soluble pink or blue paint capsules into water. This display done in a pool or clear container offers mesmerizing visuals. You can dry and frame the resulting artworks. Organize the workshop with a professional artist for guidance.',
'Suluboya tekniğiyle gizli cinsiyet mesajını ortaya çıkaran sanatsal bir açıklama yapın.',
'Reveal gender through hidden watercolor messages in an artistic creative event.',
3, 300, 1200, 3, 20, 5, 'outdoor', ARRAY['spring','summer'], ARRAY['suluboya','sanat','cinsiyet','yaratıcı','bebek','resim','atölye'], true, false);
-- ============================================================
-- ROMANTIC CATEGORY (35 scenarios)
-- ============================================================
-- 1. glow-star-bedroom (difficulty:2, indoor, all seasons, budget:200-800, free, featured)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'glow-star-bedroom',
'Yıldızlı Yatak Odası Sürprizi', 'Glow Star Bedroom Surprise',
'Yatak odasını yıldızlarla parıldayan büyülü bir gece gökyüzüne dönüştürün. Tavana fosforlu yıldızlar, peri ışıkları ve mini projektör ile yıldız yansıması yapın. Yatağı gül yaprakları ile süsleyin ve vanilya kokulu mumlar yakın. Sevdiğiniz kişinin en sevdiği çiçeklerden bir buket hazırlayın. Yastığın altına el yazısıyla yazılmış duygusal bir mektup bırakın. Bluetooth hoparlörden romantik bir çalma listesi çalın. Küçük bir masa kurarak iki kişilik şarap ve çikolata ikramı hazırlayın. Odaya girdiği an ışıkları kapatarak yıldızların parıldamasını izlemesini sağlayın. Bu basit ama etkili sürpriz unutulmaz bir gece yaşatacak.',
'Transform the bedroom into a magical night sky sparkling with stars. Project star reflections on the ceiling using phosphorescent stars, fairy lights, and a mini projector. Decorate the bed with rose petals and light vanilla-scented candles. Prepare a bouquet of your loved one''s favorite flowers. Leave an emotional handwritten letter under the pillow. Play a romantic playlist from a Bluetooth speaker. Set up a small table with wine and chocolate for two. When they enter the room, turn off the lights so they can watch the stars sparkle. This simple yet effective surprise will create an unforgettable night.',
'Tavana yıldız projektörü, gül yaprakları ve mumlarla yatak odasını romantik gökyüzüne çevirin.',
'Transform the bedroom into a romantic starry sky with projector, rose petals, and candles.',
2, 200, 800, 2, 2, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['yıldız','yatak','romantik','mum','gül','gece','sürpriz'], false, true);
-- 2. five-senses-box (difficulty:3, indoor, all seasons, budget:300-1500, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'five-senses-box',
'Beş Duyu Hediye Kutusu', 'Five Senses Gift Box',
'Sevdiğiniz kişinin beş duyusuna hitap eden özel bir hediye kutusu hazırlayın. Görme için çerçevelenmiş bir fotoğrafınız veya el yapımı bir kart, duyma için özel bir çalma listesi QR kodu, dokunma için yumuşak bir eşarp veya kaşmir eldiven, tatma için el yapımı çikolatalar veya özel bir kurabiye, koklama için kişiye özel bir parfüm veya aromatik mum yerleştirin. Her hediyenin yanına o duyuya dair duygusal bir not ekleyin. Kutuyu şık bir şekilde paketleyin ve üzerine el yazısıyla isim yazın. Bu düşünceli hediye sevdiğiniz kişiye ne kadar özenle düşündüğünüzü gösterecek ve her hediyeyi açtıkça duygulanmasını sağlayacak.',
'Prepare a special gift box that appeals to your loved one''s five senses. For sight, include a framed photo or handmade card. For hearing, a special playlist QR code. For touch, a soft scarf or cashmere gloves. For taste, handmade chocolates or special cookies. For smell, a personalized perfume or aromatic candle. Add an emotional note related to that sense alongside each gift. Package the box elegantly and write the name by hand on top. This thoughtful gift will show how carefully you think about your loved one and will make them emotional as they open each gift inside the beautifully curated box.',
'Beş duyuya hitap eden özel hediyelerle dolu duygusal ve düşünceli bir kutu hazırlayın.',
'Create a thoughtful box filled with special gifts appealing to all five senses.',
3, 300, 1500, 2, 2, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['duyu','hediye','kutu','düşünceli','romantik','özel','kişisel'], false, false);
-- 3. blindfold-mystery-date (difficulty:3, both, all seasons, budget:500-2000, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'blindfold-mystery-date',
'Gözü Bağlı Gizemli Buluşma', 'Blindfold Mystery Date',
'Sevdiğiniz kişinin gözlerini bağlayarak onu sürpriz bir buluşmaya götürün. Önceden planladığınız romantik bir mekana araba ile gidin. Yol boyunca ipuçları vererek merakını artırın. Mekana vardığınızda gözlerini açtığında karşılaştığı muhteşem manzara veya dekorasyon onu büyüleyecek. Bu mekan özel bir restoran, sahil kenarı, çatı terası veya sürpriz bir piknik alanı olabilir. Gözleri bağlıyken duyularını harekete geçirmek için müzik dinletin, parfüm koklattırın ve el ele tutuşun. Her adımda güvenle rehberlik ederek heyecanı artırın. Bu macera dolu buluşma her iki taraf için de unutulmaz olacak.',
'Blindfold your loved one and take them to a surprise date location. Drive to a romantic venue you planned in advance. Increase their curiosity by giving hints along the way. When they open their eyes upon arrival, the magnificent view or decoration will mesmerize them. This venue could be a special restaurant, beachside, rooftop terrace, or a surprise picnic area. While blindfolded, engage their senses by playing music, letting them smell perfume, and holding hands. Increase excitement by guiding them safely at every step. This adventure-filled date will be unforgettable for both of you.',
'Gözlerini bağlayıp sürpriz bir romantik mekana götürerek heyecan dolu bir buluşma yapın.',
'Blindfold your partner and take them to a surprise romantic venue for an exciting date.',
3, 500, 2000, 2, 2, 2, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['gizem','buluşma','sürpriz','romantik','macera','heyecan'], false, false);
-- 4. long-distance-lamp (difficulty:2, indoor, all seasons, budget:400-1000, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'long-distance-lamp',
'Uzak Mesafe Dokunma Lambası', 'Long Distance Touch Lamp',
'Uzak mesafe ilişkileri için tasarlanmış özel dokunmatik lambaları hediye edin. Bu lambalar WiFi ile birbirine bağlıdır ve biri dokunduğunda diğeri aynı renkte yanar. Böylece kilometrelerce uzakta olsanız bile sevdiğiniz kişiye dokunduğunuzu hissettirebilirsiniz. Lambaları özel bir kutuya koyarak el yazısıyla yazılmış bir mektupla birlikte gönderin. Mektupta lambanın anlamını ve onu ne zaman düşündüğünüzde dokunacağınızı yazın. Lambaları farklı renklere ayarlayarak her rengin farklı bir mesaj taşımasını sağlayın. Kırmızı seni seviyorum, mavi seni özledim, yeşil iyi geceler anlamına gelebilir. Bu teknolojik ama duygusal hediye her gün kullanılacak.',
'Gift specially designed touch lamps made for long-distance relationships. These lamps are connected via WiFi, and when one is touched, the other lights up in the same color. This way, even if you are miles apart, you can make your loved one feel your touch. Package the lamps in a special box and send with a handwritten letter. In the letter, explain the lamp''s meaning and when you''ll touch it thinking of them. Set lamps to different colors so each color carries a different message. Red could mean I love you, blue I miss you, green good night. This technological yet emotional gift will be used every single day.',
'WiFi bağlantılı dokunma lambalarıyla uzaktaki sevdiğinize her dokunuşta ışık gönderin.',
'Send light to your distant loved one with every touch using WiFi-connected lamps.',
2, 400, 1000, 2, 2, 5, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['lamba','uzak','mesafe','dokunma','teknoloji','romantik','ışık'], false, false);
-- 5. scheduled-love-messages (difficulty:1, indoor, all seasons, budget:50-200, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'scheduled-love-messages',
'Zamanlanmış Aşk Mesajları', 'Scheduled Love Messages',
'Sevdiğiniz kişinin bir ay boyunca her gün farklı bir sürpriz mesaj almasını sağlayın. E-posta zamanlama araçları veya özel uygulamalar kullanarak 30 gün boyunca her sabah uyanır uyanmaz bir aşk mesajı gönderılecek şekilde planlayın. Her mesajda farklı bir anınızı, sevdiğiniz bir özelliğini veya geleceğe dair bir hayalinizi paylaşın. Bazı günler şiir, bazı günler eski bir fotoğraf, bazı günler ise küçük bir görev ekleyin. Mesajların sonuncusunda fiziksel bir hediyeye yönlendiren bir ipucu bırakın. Bu sürdürülebilir romantik jest her günü özel kılacak ve sevdiğiniz kişiye sürekli düşünüldüğünü hissettirecek.',
'Arrange for your loved one to receive a different surprise message every day for a month. Using email scheduling tools or special apps, plan a love message to be sent every morning upon waking for 30 days. In each message, share a different memory, a quality you love about them, or a dream for the future. On some days add poetry, some days an old photo, and some days a small task. In the final message, leave a clue leading to a physical gift. This sustainable romantic gesture will make every day special and make your loved one feel constantly thought about throughout the entire month.',
'Bir ay boyunca her gün zamanlanmış aşk mesajları göndererek sürekli düşündüğünüzü hissettirin.',
'Send scheduled love messages every day for a month to show you''re always thinking of them.',
1, 50, 200, 2, 2, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['mesaj','aşk','zamanlama','günlük','romantik','düşünceli'], false, false);
-- 6. custom-vinyl-love-album (difficulty:4, indoor, all seasons, budget:2000-5000, premium)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'custom-vinyl-love-album',
'Kişiye Özel Vinil Aşk Albümü', 'Custom Vinyl Love Album',
'Sevdiğiniz kişi için birlikte dinlediğiniz şarkılardan oluşan kişiye özel bir vinil plak albümü bastırın. Tanıştığınız gün çalan şarkı, ilk dansınız, arabanızda sürekli çalan parçalar gibi anlamlı şarkıları derleyin. Plağın kapak tasarımını özel olarak yaptırın, belki birlikte çekilmiş bir fotoğrafınız ya da el çizimi bir illüstrasyon olsun. Plağın yanına retro bir pikap hediye ederek tam bir deneyim sunun. Plağın iç kapağına her şarkının neden seçildiğini anlatan kısa notlar yazın. Özel bir akşam yemeği hazırlayarak plağı birlikte dinlemeye başlayın. Bu nostaljik ve kişisel hediye müzik seven çiftler için paha biçilmez olacak.',
'Have a custom vinyl record album pressed featuring songs you listened to together. Compile meaningful songs like the song playing when you met, your first dance, tracks that always play in your car. Have the album cover designed specially, perhaps a photo of you together or a hand-drawn illustration. Gift a retro turntable alongside the record for a complete experience. Write short notes on the inner cover explaining why each song was chosen. Prepare a special dinner and start listening to the record together. This nostalgic and personal gift will be priceless for music-loving couples and will be treasured forever.',
'Birlikte dinlediğiniz şarkılardan özel vinil plak bastırarak nostaljik bir hediye verin.',
'Press a custom vinyl record of your shared songs for a nostalgic personal gift.',
4, 2000, 5000, 2, 2, 14, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['vinil','müzik','plak','nostaljik','romantik','hediye','kişisel'], true, false);
-- 7. bonsai-love-gift (difficulty:2, indoor, all seasons, budget:200-800, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'bonsai-love-gift',
'Bonsai Aşk Ağacı Hediyesi', 'Bonsai Love Tree Gift',
'Aşkınızın sembolü olarak birlikte büyütecek bir bonsai ağacı hediye edin. Özel bir saksıya dikilmiş bonsaiyi el yazısıyla yazılmış bir kartla sunun. Kartta ağacın bakımı gibi ilişkinize de özen gösterme sözü verin. Bonsai bakım seti ile birlikte hediye paketleyin. İlişkinizin başlangıç tarihini saksıya kazıyın veya küçük bir plaketle ekleyin. Her yıl yıl dönümünde ağacın fotoğrafını çekerek büyüme günlüğü tutun. Bu yaşayan hediye yıllar geçtikçe değer kazanacak ve ilişkinizle birlikte büyüyecek. Bonsai türünü sevdiğiniz kişinin tercihlerine göre seçerek kişiselleştirin.',
'Gift a bonsai tree to grow together as a symbol of your love. Present the bonsai planted in a special pot with a handwritten card. In the card, promise to nurture your relationship like caring for the tree. Package it as a gift along with a bonsai care kit. Engrave or add a small plaque with your relationship''s start date on the pot. Take a photo of the tree every anniversary to keep a growth diary. This living gift will gain value over the years and grow alongside your relationship. Personalize by choosing the bonsai type according to your loved one''s preferences.',
'Aşkınızın sembolü olarak birlikte büyütecek bir bonsai ağacı hediye edin.',
'Gift a bonsai tree as a symbol of your love to grow together over the years.',
2, 200, 800, 2, 2, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['bonsai','ağaç','doğa','büyüme','romantik','hediye','sembol'], false, false);
-- 8. secret-message-garden (difficulty:4, outdoor, spring/summer, budget:1500-5000, premium)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'secret-message-garden',
'Gizli Mesaj Bahçesi', 'Secret Message Garden',
'Bahçenizde veya bir saksıda sevdiğiniz kişiye özel bir gizli mesaj bahçesi oluşturun. Tohum harflerini kullanarak toprağa bir aşk mesajı ekin. Tohumlar filizlendiğinde mesaj yeşil harflerle ortaya çıksın. Bu sürpriz sabır gerektirir ancak sonucu inanılmaz duygusal olacaktır. Hazır tohum harf setleri satın alabilir veya kendiniz şablonla ekebilirsiniz. Filizlenme süresini hesaplayarak özel bir güne denk getirin. Bahçeye romantik süsler, minik taş yollar ve peri ışıkları ekleyerek büyülü bir atmosfer yaratın. Mesajın yanına çiçekler dikerek renkli bir çerçeve oluşturun. Bu yaşayan mektup zamanla daha da güzelleşecek.',
'Create a secret message garden for your loved one in your garden or a planter. Plant a love message in the soil using seed letters. When the seeds sprout, the message will appear in green letters. This surprise requires patience but the result will be incredibly emotional. You can buy ready seed letter sets or sow them yourself with templates. Calculate sprouting time to coincide with a special day. Create a magical atmosphere by adding romantic decorations, tiny stone paths, and fairy lights to the garden. Plant flowers next to the message to create a colorful frame. This living letter will become more beautiful over time.',
'Tohum harflerle toprağa ekilmiş aşk mesajının filizlenmesini birlikte izleyin.',
'Watch a love message sprout from seed letters planted in the soil together.',
4, 1500, 5000, 2, 2, 30, 'outdoor', ARRAY['spring','summer'], ARRAY['bahçe','tohum','mesaj','doğa','romantik','gizli','büyüme'], true, false);
-- 9. popup-restaurant-home (difficulty:4, indoor, all seasons, budget:500-2500, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'popup-restaurant-home',
'Evde Pop-up Restoran', 'Pop-up Restaurant at Home',
'Evinizi lüks bir restorana dönüştürerek özel bir akşam yemeği deneyimi yaşatın. Yemek odasını beyaz örtüler, kristal bardaklar, gümüş çatal bıçak ve taze çiçeklerle süsleyin. Menü kartı tasarlayarak üç veya dört çeşit yemek hazırlayın. Garson gibi giyinerek servisi profesyonelce yapın. Arka planda caz müziği çalın ve mumları yakın. Restoran ismi vererek özel bir davetiye gönderin. Aperatif, ana yemek, ara sıcak ve tatlı olmak üzere tam bir fine dining deneyimi sunun. Her tabağı şık bir şekilde sunarak görsel bir şölen yaratın. Yemek sonrası dans ederek geceyi taçlandırın.',
'Transform your home into a luxury restaurant for a special dinner experience. Decorate the dining room with white tablecloths, crystal glasses, silver cutlery, and fresh flowers. Design a menu card and prepare three or four courses. Dress as a waiter and serve professionally. Play jazz music in the background and light the candles. Give the restaurant a name and send a special invitation. Offer a complete fine dining experience with appetizer, main course, palate cleanser, and dessert. Create a visual feast by presenting each plate elegantly. Crown the night by dancing together after dinner.',
'Evinizi beyaz örtüler ve mumlarla lüks bir restorana dönüştürüp özel akşam yemeği verin.',
'Transform your home into a luxury restaurant with white tablecloths and candles for a special dinner.',
4, 500, 2500, 2, 2, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['restoran','yemek','lüks','ev','romantik','akşam','mum'], false, false);
-- 10. chemistry-of-love-experiment (difficulty:3, indoor, all seasons, budget:150-500, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'chemistry-of-love-experiment',
'Aşkın Kimyası Deneyi', 'Chemistry of Love Experiment',
'Bilim ve aşkı birleştiren eğlenceli deneylerle dolu bir sürpriz akşam düzenleyin. Kalp şekilli buz kalıplarında renkli sıvılar dondurun. Sirke ve karbonat ile köpüren kalp volkanları yapın. Sütte gıda boyası ve deterjan ile büyüleyici renk patlamaları oluşturun. Her deneyin yanına aşkın kimyasını anlatan bilimsel notlar ekleyin. Oksitosin, dopamin ve serotonin gibi aşk hormonlarını eğlenceli infografiklerle anlatın. Laboratuvar önlükleri giyerek bilim insanı rolüne bürünün. Deneylerin sonunda sevdiğiniz kişiye aşk formülünüzü içeren özel bir sertifika hazırlayın. Bilim meraklısı çiftler için mükemmel bir buluşma.',
'Organize a surprise evening full of fun experiments combining science and love. Freeze colorful liquids in heart-shaped ice molds. Make foaming heart volcanoes with vinegar and baking soda. Create mesmerizing color explosions with food coloring and detergent in milk. Add scientific notes explaining the chemistry of love alongside each experiment. Present love hormones like oxytocin, dopamine, and serotonin with fun infographics. Don lab coats to take on the role of scientists. At the end of experiments, prepare a special certificate containing your love formula. A perfect date for science-enthusiast couples.',
'Bilimsel deneylerle aşkın kimyasını keşfedin: kalp volkanları, renk patlamaları ve daha fazlası.',
'Discover the chemistry of love with scientific experiments: heart volcanoes, color explosions, and more.',
3, 150, 500, 2, 2, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['bilim','deney','kimya','eğlence','romantik','yaratıcı','keşif'], false, false);
-- 11. reasons-i-love-you-jar (difficulty:1, indoor, all seasons, budget:50-200, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'reasons-i-love-you-jar',
'Seni Sevmemin Nedenleri Kavanozu', 'Reasons I Love You Jar',
'Cam bir kavanozu sevdiğiniz kişiye olan duygularınızla doldurun. En az 50 küçük kağıda sevme nedenlerinizi yazın. Her kağıdı rulo yapıp minik kurdelelerle bağlayın. Kağıtları farklı renklerde kullanarak gökkuşağı efekti yaratın. Kavanozu şık bir şekilde süsleyerek üzerine el yazısıyla etiket yapıştırın. Her gün bir kağıt açması için talimat notu ekleyin. Nedenlerin arasına komik anıları, fiziksel özelliklerini, alışkanlıklarını ve birlikte yaşadığınız unutulmaz anları dahil edin. Kavanozu özel bir akşam yemeğinde ya da sabah kahvaltısında sürpriz olarak sunun. Bu el yapımı hediye her gün yeni bir gülümseme yaratacak.',
'Fill a glass jar with your feelings for your loved one. Write your reasons for loving them on at least 50 small papers. Roll each paper and tie with tiny ribbons. Use different colored papers to create a rainbow effect. Decorate the jar elegantly and attach a handwritten label. Add an instruction note for them to open one paper each day. Include funny memories, physical features, habits, and unforgettable moments you shared among the reasons. Present the jar as a surprise during a special dinner or morning breakfast. This handmade gift will create a new smile every single day.',
'Sevme nedenlerinizi yazdığınız 50 kağıdı kavanoza koyarak her gün yeni bir sürpriz verin.',
'Put 50 love reasons in a jar for a new surprise smile every single day.',
1, 50, 200, 2, 2, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kavanoz','neden','aşk','el yapımı','romantik','düşünceli'], false, false);
-- 12. custom-board-game-date (difficulty:3, indoor, all seasons, budget:200-800, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'custom-board-game-date',
'Kişiye Özel Kutu Oyunu Buluşması', 'Custom Board Game Date',
'İlişkinizin hikayesini anlatan kişiye özel bir kutu oyunu tasarlayın ve birlikte oynayın. Oyun tahtasını tanıştığınız günden bugüne kadar olan yolculuğunuzu yansıtacak şekilde çizin. Karelere gerçek anılarınızı, şakalarınızı ve özel anlarınızı yerleştirin. Görev kartları oluşturarak dans etme, şarkı söyleme, masaj yapma gibi romantik aktiviteler ekleyin. Soru kartları ile birbirinizi daha iyi tanıyacağınız sorular hazırlayın. Oyun parçalarını minik figürleriniz olarak tasarlayın. Zar atarak ilerleyin ve her karede yeni bir macera yaşayın. Kazananın ödülünü önceden belirleyerek heyecanı artırın. Bu benzersiz oyun her oynandığında yeni anılar yaratacak.',
'Design a custom board game telling the story of your relationship and play it together. Draw the game board reflecting your journey from the day you met until today. Place real memories, jokes, and special moments on the squares. Create task cards adding romantic activities like dancing, singing, and giving massages. Prepare question cards with questions to get to know each other better. Design game pieces as tiny figures of yourselves. Roll the dice to advance and experience a new adventure on each square. Increase excitement by predetermining the winner''s prize. This unique game will create new memories every time it is played.',
'İlişkinizin hikayesini anlatan özel kutu oyunu tasarlayıp romantik bir gece geçirin.',
'Design a custom board game telling your love story for a romantic evening together.',
3, 200, 800, 2, 2, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['oyun','kutu','tasarım','eğlence','romantik','kişisel','yaratıcı'], false, false);
-- 13. home-cinema-date-night (difficulty:1, indoor, all seasons, budget:100-500, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'home-cinema-date-night',
'Ev Sineması Gecesi', 'Home Cinema Date Night',
'Oturma odanızı gerçek bir sinema salonuna dönüştürerek film gecesi düzenleyin. Projektör veya büyük ekran kurarak karartma perdesi çekin. Yere yumuşak battaniyeler ve yastıklar serip rahat bir izleme alanı oluşturun. Patlamış mısır makinesi kiralayın veya satın alın. Sinema biletleri tasarlayarak sevdiğiniz kişiye giriş bileti verin. Film seçimini ortak zevklerinize göre yapın veya tanıştığınız dönemin filmlerini izleyin. Şekerlemeler, nachos ve içeceklerden oluşan sinema büfesi hazırlayın. Perde kapanış reklamları gibi eğlenceli detaylar ekleyin. Filmden önce kısa bir ev yapımı reklam filmi çekerek gülümseme yaratın.',
'Transform your living room into a real cinema hall for a movie night. Set up a projector or large screen and draw blackout curtains. Lay soft blankets and cushions on the floor to create a comfortable viewing area. Rent or buy a popcorn machine. Design cinema tickets and give your loved one an admission ticket. Choose films based on shared tastes or watch movies from the era you met. Prepare a cinema buffet with candies, nachos, and drinks. Add fun details like pre-show curtain advertisements. Create smiles by filming a short homemade commercial before the movie starts.',
'Projektör, patlamış mısır ve battaniyelerle oturma odanızı sinema salonuna dönüştürün.',
'Transform your living room into a cinema with projector, popcorn, and cozy blankets.',
1, 100, 500, 2, 2, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['sinema','film','ev','gece','romantik','rahat','eğlence'], false, false);
-- 14. love-coupon-book (difficulty:1, indoor, all seasons, budget:30-150, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'love-coupon-book',
'Aşk Kuponu Kitapçığı', 'Love Coupon Book',
'Sevdiğiniz kişinin istediği zaman kullanabileceği aşk kuponlarından oluşan el yapımı bir kitapçık hazırlayın. Her kupona farklı bir romantik aktivite yazın. Bir saatlik masaj, sürpriz akşam yemeği, film gecesi seçimi, kahvaltı yatağa servis, bir günlük her isteğini yapma gibi çeşitli kuponlar oluşturun. Kuponları renkli kağıtlara basarak veya el yazısıyla yazarak kişiselleştirin. Her kuponun bir son kullanma tarihi olmasını komik bir detay olarak ekleyin. Kitapçığı şık bir kapakla ciltleyerek profesyonel bir görünüm verin. Bu ekonomik ama son derece düşünceli hediye aylarca sürecek sürprizler sunacak.',
'Create a handmade booklet of love coupons your loved one can use whenever they want. Write a different romantic activity on each coupon. Create various coupons like one hour of massage, surprise dinner, movie night choice, breakfast in bed, a day of fulfilling every wish. Personalize coupons by printing on colorful paper or writing by hand. Add expiration dates on each coupon as a funny detail. Bind the booklet with an elegant cover for a professional look. This affordable yet extremely thoughtful gift will offer surprises lasting for months and bring joy with every coupon redeemed.',
'El yapımı aşk kuponları kitapçığıyla aylarca sürecek romantik sürprizler hediye edin.',
'Gift months of romantic surprises with a handmade love coupon booklet.',
1, 30, 150, 2, 2, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kupon','el yapımı','romantik','hediye','ekonomik','düşünceli'], false, false);
-- 15. sunrise-breakfast-beach (difficulty:3, outdoor, spring/summer, budget:300-1000, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'sunrise-breakfast-beach',
'Sahilde Gün Doğumu Kahvaltısı', 'Sunrise Breakfast on the Beach',
'Sevdiğiniz kişiyi sabahın erken saatlerinde uyandırarak sahilde gün doğumu eşliğinde romantik bir kahvaltı yapın. Önceden sahile battaniye, yastık ve piknik sepeti hazırlayın. Taze simit, peynir, zeytin, domates, yumurta ve taze sıkılmış portakal suyu gibi geleneksel kahvaltı lezzetleri hazırlayın. Termosa sıcak çay veya kahve doldurun. Sahile varınca gül yaprakları serpin ve mumlar yakın. Gün doğumunu izlerken birbirinize mektuplarınızı okuyun. Bu erken kalkış fedakarlığı sevdiğiniz kişiye çok değerli gelecek. Kahvaltı sonrası sahilde yürüyüş yaparak günü güzel başlatın. Güneşin denizden yükselişini fotoğraflayın.',
'Wake your loved one early in the morning for a romantic breakfast on the beach at sunrise. Prepare a blanket, cushions, and picnic basket at the beach beforehand. Prepare traditional breakfast delights like fresh simit, cheese, olives, tomatoes, eggs, and freshly squeezed orange juice. Fill a thermos with hot tea or coffee. Scatter rose petals and light candles upon arriving at the beach. Read letters to each other while watching the sunrise. This early wake-up sacrifice will mean so much to your loved one. Start the day beautifully with a walk on the beach after breakfast. Photograph the sun rising from the sea.',
'Sahilde gün doğumunu izlerken romantik bir kahvaltı ile güne başlayın.',
'Start the day with a romantic breakfast while watching the sunrise on the beach.',
3, 300, 1000, 2, 2, 2, 'outdoor', ARRAY['spring','summer'], ARRAY['sahil','gündoğumu','kahvaltı','romantik','sabah','deniz'], false, false);
-- 16. picnic-under-stars (difficulty:2, outdoor, summer, budget:200-800, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'picnic-under-stars',
'Yıldızların Altında Piknik', 'Picnic Under the Stars',
'Şehir ışıklarından uzak bir yerde yıldızların altında romantik bir gece pikniği düzenleyin. Yumuşak battaniyeler ve yastıklarla rahat bir oturma alanı oluşturun. Mum fenerleri ve peri ışıkları ile atmosferik bir aydınlatma yapın. Şarap, peynir tabağı, meyve ve çikolata gibi gurme piknik lezzetleri hazırlayın. Yıldız haritası uygulaması indirerek gökyüzündeki takım yıldızları birlikte keşfedin. Bluetooth hoparlörden hafif müzik çalın. Birbirinize geleceğe dair hayallerinizi anlatın ve dilek yıldızı bekleyin. Sıcak bir battaniyenin altında sarılarak yıldızları izlemek bu gecenin en güzel anı olacak. Teleskop getirerek deneyimi zenginleştirin.',
'Organize a romantic nighttime picnic under the stars away from city lights. Create a comfortable seating area with soft blankets and cushions. Create atmospheric lighting with candle lanterns and fairy lights. Prepare gourmet picnic delights like wine, cheese platters, fruit, and chocolate. Download a star map app to discover constellations in the sky together. Play soft music from a Bluetooth speaker. Share dreams for the future and wait for shooting stars. Cuddling under a warm blanket while watching the stars will be the most beautiful moment of the night. Enrich the experience by bringing a telescope.',
'Şehirden uzakta yıldızların altında battaniye ve mumlarla romantik bir gece pikniği yapın.',
'Have a romantic nighttime picnic under the stars with blankets and candles away from the city.',
2, 200, 800, 2, 2, 2, 'outdoor', ARRAY['summer'], ARRAY['yıldız','piknik','gece','romantik','doğa','gökyüzü'], false, false);
-- 17. love-letter-trail (difficulty:3, both, all seasons, budget:100-500, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'love-letter-trail-surprise',
'Aşk Mektubu Parkuru', 'Love Letter Trail',
'Ev veya şehir genelinde gizlenmiş aşk mektuplarından oluşan bir parkur oluşturun. Her mektup bir sonrakinin yerini gösteren bir ipucu içersin. İlk mektubu yastığın altına veya çantasına koyun. Mektuplarda birlikte yaşadığınız güzel anıları, sevme nedenlerinizi ve geleceğe dair vaatlerinizi yazın. Parkuru anlamlı mekanlardan geçirin: ilk buluşma yeriniz, ilk öpüştüğünüz yer, en sevdiği kafe. Son mektupta buluşma noktasını belirterek sizi bekleyen büyük sürprizle karşılaştırın. Bu sürpriz bir hediye, bir yemek daveti veya romantik bir kaçamak olabilir. Her istasyonda küçük hediyeler bırakarak yolculuğu zenginleştirin.',
'Create a trail of hidden love letters throughout the house or city. Each letter contains a clue pointing to the next one''s location. Place the first letter under the pillow or in their bag. Write about beautiful moments you shared, reasons you love them, and promises for the future in the letters. Route the trail through meaningful places: your first date spot, where you first kissed, their favorite cafe. In the final letter, specify the meeting point for the big surprise awaiting them. This surprise could be a gift, a dinner invitation, or a romantic getaway. Enrich the journey by leaving small gifts at each station.',
'Gizli aşk mektupları parkuruyla anlamlı mekanlar boyunca romantik bir macera yaşatın.',
'Create a romantic adventure through meaningful places with a trail of hidden love letters.',
3, 100, 500, 2, 2, 3, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['mektup','parkur','gizli','macera','romantik','ipucu','sürpriz'], false, false);
-- 18. couples-painting-night (difficulty:2, indoor, all seasons, budget:200-700, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'couples-painting-night',
'Çift Resim Yapma Gecesi', 'Couples Painting Night',
'Evde veya bir atölyede birlikte resim yaparak yaratıcı ve romantik bir gece geçirin. Tuval, akrilik boya, fırça ve paleti hazırlayın. İki ayrı tuvale birbirinin portresini çizin veya aynı manzarayı farklı perspektiflerden boyayın. YouTube''dan takip edilebilecek bir çift resim dersi açın. Arka planda sakin müzik çalın ve şarap eşliğinde keyifli bir atmosfer yaratın. Resim yaparken sohbet ederek birbirinizi daha iyi tanıyın. Bitmiş tabloları çerçeveletip evinize asarak kalıcı bir hatıra oluşturun. Sanat konusunda yetenekli olmanız gerekmiyor, önemli olan birlikte geçirilen keyifli zaman ve ortaya çıkan eğlenceli eserler.',
'Spend a creative and romantic evening painting together at home or in a workshop. Prepare canvas, acrylic paint, brushes, and palette. Draw each other''s portraits on separate canvases or paint the same landscape from different perspectives. Open a follow-along couples painting tutorial on YouTube. Play calm music in the background and create an enjoyable atmosphere with wine. Chat while painting to get to know each other better. Frame the finished paintings and hang them in your home as lasting keepsakes. You don''t need to be artistically talented; what matters is the enjoyable time spent together and the fun works that emerge.',
'Birlikte tuval boyayarak yaratıcı ve romantik bir gece geçirin, eserleri eve asın.',
'Spend a creative romantic evening painting on canvas together and hang the art at home.',
2, 200, 700, 2, 2, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['resim','boya','sanat','yaratıcı','romantik','tuval','gece'], false, false);
-- 19. turkish-coffee-date-surprise (difficulty:2, indoor, all seasons, budget:100-400, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'turkish-coffee-date-surprise',
'Türk Kahvesi Buluşma Sürprizi', 'Turkish Coffee Date Surprise',
'Geleneksel Türk kahvesi ritüeli ile romantik ve nostaljik bir buluşma düzenleyin. Bakır cezve, fincan ve lokum seti hazırlayın. Kahveyi geleneksel yöntemle birlikte pişirin ve köpüğüne dikkat edin. Kahvenin yanına ev yapımı lokum, badem ezmesi ve kuru meyveler ikram edin. Kahve içtikten sonra fincanları ters çevirerek birbirinize fal bakın. Falda gördüklerinizi eğlenceli ve romantik yorumlarla anlatın. Arka planda klasik Türk müziği çalarak otantik bir atmosfer yaratın. Masayı geleneksel motifli örtü ve bakır aksesuarlarla süsleyin. Bu samimi buluşma kültürel bir deneyimle birlikte derin sohbetlere kapı açacak.',
'Organize a romantic and nostalgic date with the traditional Turkish coffee ritual. Prepare a copper cezve, cups, and Turkish delight set. Brew the coffee together using the traditional method, paying attention to the foam. Serve homemade Turkish delight, marzipan, and dried fruits alongside the coffee. After drinking, turn the cups over and read each other''s fortunes. Narrate what you see in the fortune with fun and romantic interpretations. Create an authentic atmosphere by playing classical Turkish music in the background. Decorate the table with traditional patterned cloth and copper accessories. This intimate date will open doors to deep conversations alongside a cultural experience.',
'Bakır cezvede birlikte kahve pişirip fal bakarak nostaljik bir buluşma yapın.',
'Brew coffee together in a copper cezve and read fortunes for a nostalgic date.',
2, 100, 400, 2, 2, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kahve','türk','gelenek','fal','nostaljik','romantik','buluşma'], false, false);
-- 20. moonlight-boat-ride (difficulty:4, outdoor, summer, budget:3000-10000, premium)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'moonlight-boat-ride',
'Ay Işığında Tekne Gezintisi', 'Moonlight Boat Ride',
'Dolunay gecesinde özel bir tekne kiralayarak ay ışığında romantik bir deniz gezintisi yapın. Tekneyi mumlar, çiçekler ve peri ışıklarıyla süsleyin. Güverte üzerinde iki kişilik özel bir yemek masası kurdurun. Kaptan ve şef dahil komple bir hizmet alarak sadece birbirinize odaklanın. Boğaz''da veya sahil şeridinde yavaşça ilerlerken ay ışığının suya yansımasını izleyin. Şampanya kadehlerinizi kaldırarak birbirinize olan sevginizi ilan edin. Canlı müzisyen eşliğinde dans edin. Dönüş yolunda havai fişek gösterisi veya dilek feneri uçurma ile geceyi taçlandırın. Bu lüks deneyim yıl dönümü veya evlilik teklifi için idealdir.',
'Rent a private boat on a full moon night for a romantic sea ride under the moonlight. Decorate the boat with candles, flowers, and fairy lights. Have a private dinner table for two set up on deck. Get complete service including captain and chef so you can focus only on each other. Watch the moonlight reflecting on the water while slowly cruising along the Bosphorus or coastline. Raise your champagne glasses and declare your love to each other. Dance accompanied by a live musician. Crown the night with a fireworks display or releasing wish lanterns on the way back. This luxury experience is ideal for anniversaries or marriage proposals.',
'Dolunay gecesinde mumlarla süslü özel teknede romantik bir deniz gezintisi yapın.',
'Take a romantic sea ride on a candlelit private boat under the full moon.',
4, 3000, 10000, 2, 2, 7, 'outdoor', ARRAY['summer'], ARRAY['tekne','ay','deniz','lüks','romantik','gece','boğaz'], true, false);
-- 21. love-map-wall-art (difficulty:3, indoor, all seasons, budget:300-1200, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'love-map-wall-art',
'Aşk Haritası Duvar Sanatı', 'Love Map Wall Art',
'İlişkinizin önemli anlarının gerçekleştiği mekanların haritalarından oluşan bir duvar sanatı eseri yaratın. Tanıştığınız yer, ilk buluşma mekanınız, tatile gittiğiniz şehirler ve evlilik teklifinin yapıldığı yer gibi anlamlı konumların haritalarını bastırın. Her haritanın altına tarihi ve o anın hikayesini yazın. Haritaları aynı boyutta çerçeveletip yan yana asarak görsel bir zaman çizelgesi oluşturun. Kalp şeklinde kesilmiş haritalar kullanarak farklı bir stil deneyin. Bu kişisel sanat eseri hem dekoratif hem de duygusal bir hediye olacak. Her ziyaretçi bu haritaların arkasındaki hikayeyi soracak ve siz birlikte anlatmanın keyfini çıkaracaksınız.',
'Create a wall art piece from maps of locations where important moments of your relationship took place. Print maps of meaningful locations like where you met, your first date venue, cities you vacationed in, and where the proposal happened. Write the date and story of that moment below each map. Frame the maps in the same size and hang side by side to create a visual timeline. Try a different style using heart-shaped cut maps. This personal artwork will be both decorative and an emotional gift. Every visitor will ask about the story behind these maps, and you''ll enjoy telling it together.',
'İlişkinizin önemli mekanlarının haritalarından duvar sanatı oluşturarak anıları ölümsüzleştirin.',
'Immortalize memories by creating wall art from maps of your relationship''s significant places.',
3, 300, 1200, 2, 2, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['harita','sanat','duvar','anı','romantik','dekorasyon','kişisel'], false, false);
-- 22. home-spa-massage (difficulty:2, indoor, all seasons, budget:300-1200, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'home-spa-massage',
'Evde Spa ve Masaj Gecesi', 'Home Spa and Massage Night',
'Banyoyu ve yatak odasını lüks bir spa merkezine dönüştürerek rahatlatıcı bir gece düzenleyin. Küveti sıcak suyla doldurup banyo bombası, gül yaprakları ve aromatik yağlar ekleyin. Mumlar yakarak yumuşak ışık ortamı oluşturun. Spa müziği çalarak huzurlu bir atmosfer yaratın. Masaj yağları ve sıcak taşlar hazırlayarak birbirinize masaj yapın. Yüz maskesi, el bakımı ve ayak bakımı için malzemeler temin edin. Detoks suyu ve sağlıklı atıştırmalıklar hazırlayın. Bornoz ve terlik hazırlayarak lüks otel deneyimi sunun. Bu stres giderici akşam hem fiziksel hem de duygusal olarak bağınızı güçlendirecek.',
'Transform the bathroom and bedroom into a luxury spa center for a relaxing evening. Fill the bathtub with hot water and add bath bombs, rose petals, and aromatic oils. Create soft lighting by burning candles. Create a peaceful atmosphere by playing spa music. Prepare massage oils and hot stones to massage each other. Obtain supplies for face masks, hand care, and foot care. Prepare detox water and healthy snacks. Provide bathrobes and slippers for a luxury hotel experience. This stress-relieving evening will strengthen your bond both physically and emotionally, making you both feel refreshed and renewed.',
'Banyoyu mumlar ve aromatik yağlarla lüks bir spa''ya dönüştürüp birbirinize masaj yapın.',
'Transform the bathroom into a luxury spa with candles and aromatic oils for mutual massages.',
2, 300, 1200, 2, 2, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['spa','masaj','rahatlama','mum','romantik','bakım','lüks'], false, false);
-- 23. stargazing-rooftop-date (difficulty:3, outdoor, summer, budget:400-1500, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'stargazing-rooftop-date',
'Çatıda Yıldız Gözlemi Buluşması', 'Stargazing Rooftop Date',
'Binanızın çatısını veya bir teras restoranı romantik bir yıldız gözlemi buluşmasına dönüştürün. Şezlonglar veya rahat minderleri yere serip yumuşak battaniyeler hazırlayın. Teleskop kurarak gezegenleri ve takımyıldızlarını keşfedin. Yıldız haritası uygulaması ile gökyüzünü birlikte okuyun. Sıcak çikolata veya şarap eşliğinde gökyüzünü izleyin. Romantik bir çalma listesi hazırlayarak arka plan müziği oluşturun. Karanlıkta parıldayan peri ışıkları ile mekanı süsleyin. Birbirinize çocukluk hayallerinizi ve geleceğe dair umutlarınızı anlatın. Kayan yıldız gördüğünüzde birlikte dilek tutun. Bu huzurlu gece şehrin gürültüsünden kaçış sunacak.',
'Transform your building''s rooftop or a terrace restaurant into a romantic stargazing date. Lay lounge chairs or comfortable cushions on the ground and prepare soft blankets. Set up a telescope to discover planets and constellations. Read the sky together using a star map app. Watch the sky accompanied by hot chocolate or wine. Create background music by preparing a romantic playlist. Decorate the space with fairy lights glowing in the dark. Share childhood dreams and hopes for the future with each other. Make a wish together when you see a shooting star. This peaceful night will offer an escape from the city''s noise.',
'Çatıda teleskop ve battaniyelerle yıldızları izleyerek huzurlu bir romantik gece geçirin.',
'Spend a peaceful romantic night watching stars with a telescope and blankets on the rooftop.',
3, 400, 1500, 2, 2, 2, 'outdoor', ARRAY['summer'], ARRAY['yıldız','çatı','gözlem','teleskop','romantik','gece','huzur'], false, false);
-- 24. love-playlist-exchange (difficulty:1, indoor, all seasons, budget:20-100, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'love-playlist-exchange',
'Aşk Müzik Listesi Değişimi', 'Love Playlist Exchange',
'Birbirinize özel hazırlanmış müzik listeleri oluşturarak duygusal bir sürpriz yapın. Her şarkıyı neden seçtiğinizi anlatan kısa notlarla birlikte Spotify veya Apple Music üzerinden paylaşın. Tanıştığınız günü hatırlatan şarkılar, birlikte yolculuk yaparken dinledikleriniz, size birbirinizi düşündüren melodiler ve geleceğe dair hayallerinizi yansıtan parçalar ekleyin. Listenin kapak görselini özel tasarlayın. Birlikte rahat bir ortamda şarkıları dinleyerek her birinin arkasındaki hikayeyi paylaşın. Bu basit ama derin hediye müzikle kurduğunuz duygusal bağı güçlendirecek. Her dinlediğinizde birbirinizi düşüneceksiniz.',
'Create a special surprise by making personalized music playlists for each other. Share them on Spotify or Apple Music with short notes explaining why you chose each song. Add songs that remind you of the day you met, ones you listened to while traveling together, melodies that make you think of each other, and tracks reflecting your future dreams. Custom design the playlist cover image. Listen to the songs together in a comfortable setting, sharing the story behind each one. This simple yet profound gift will strengthen the emotional bond you''ve built through music. You''ll think of each other every time you listen.',
'Birbirinize özel şarkı listeleri hazırlayıp her şarkının hikayesini paylaşarak duygusal bağ kurun.',
'Create personalized playlists for each other and share the story behind every song.',
1, 20, 100, 2, 2, 1, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['müzik','liste','şarkı','duygusal','romantik','paylaşım'], false, false);
-- 25. handwritten-poem-gift (difficulty:2, indoor, all seasons, budget:50-300, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'handwritten-poem-gift',
'El Yazması Şiir Hediyesi', 'Handwritten Poem Gift',
'Sevdiğiniz kişiye kendi yazdığınız bir şiiri el yazısıyla güzel bir kağıda yazarak hediye edin. Şiirde birlikte yaşadığınız anları, onun güzelliğini ve aşkınızın derinliğini anlatın. Kaligrafi kalemi kullanarak zarif bir yazı stili oluşturun. Şiiri vintage görünümlü bir kağıda yazarak eskitme efekti verin. Çerçeveletip hediye paketi yapın veya mum mühürü ile kapatılmış bir zarfa koyun. Şiiri özel bir akşamda mum ışığında sesli okuyarak sunun. Şiir yazmak konusunda kendinize güvenmiyorsanız sevdiğiniz bir şairin eserini güzel bir kağıda el yazısıyla yazarak da kişiselleştirebilirsiniz.',
'Gift your loved one a poem you wrote yourself, handwritten on beautiful paper. In the poem, describe moments you shared, their beauty, and the depth of your love. Create an elegant writing style using a calligraphy pen. Write the poem on vintage-looking paper for an aged effect. Frame it as a gift package or put it in an envelope sealed with a wax seal. Present the poem by reading it aloud by candlelight on a special evening. If you don''t feel confident writing poetry, you can personalize by handwriting a favorite poet''s work on beautiful paper with your own personal touch added.',
'Kendi yazdığınız şiiri kaligrafi kalemiyle güzel kağıda yazıp mum ışığında okuyun.',
'Handwrite your own poem with calligraphy pen on beautiful paper and read it by candlelight.',
2, 50, 300, 2, 2, 3, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['şiir','el yazısı','kaligrafi','duygusal','romantik','hediye','mektup'], false, false);
-- 26. couple-photoshoot-surprise (difficulty:3, both, spring/summer/fall, budget:1000-4000, premium)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'couple-photoshoot-surprise',
'Sürpriz Çift Fotoğraf Çekimi', 'Couple Photoshoot Surprise',
'Profesyonel bir fotoğrafçı ile sürpriz bir çift fotoğraf çekimi organize edin. Sevdiğiniz kişiye normal bir gezinti planladığınızı söyleyin ve anlamlı bir mekanda fotoğrafçının sizi beklemesini ayarlayın. Gardırop seçimini önceden yaparak uyumlu kıyafetler hazırlayın. Çekim mekanını birlikte anlamlı bulduğunuz bir yer seçin. Fotoğrafçıyla önceden konsept belirleyerek doğal ve samimi pozlar planlayın. Çekim sırasında birlikte gülerken, el ele yürürken ve göz göze gelirken muhteşem kareler yakalanacak. Fotoğrafları özel bir albüm haline getirerek yıl dönümünde veya özel bir günde hediye edin.',
'Organize a surprise couple photoshoot with a professional photographer. Tell your loved one you''ve planned a normal outing and arrange for the photographer to be waiting at a meaningful location. Prepare coordinated outfits by making wardrobe choices in advance. Choose a shooting location that is meaningful to both of you. Plan natural and candid poses by determining the concept with the photographer beforehand. During the shoot, magnificent shots will be captured while laughing together, walking hand in hand, and making eye contact. Turn the photos into a special album and gift it on an anniversary or special occasion.',
'Profesyonel fotoğrafçıyla sürpriz çift çekimi yaparak anılarınızı ölümsüzleştirin.',
'Immortalize memories with a surprise couple photoshoot by a professional photographer.',
3, 1000, 4000, 2, 2, 7, 'both', ARRAY['spring','summer','fall'], ARRAY['fotoğraf','çekim','profesyonel','anı','romantik','sürpriz','albüm'], true, false);
-- 27. love-scrapbook-gift (difficulty:3, indoor, all seasons, budget:200-800, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'love-scrapbook-gift',
'Aşk Anı Defteri Hediyesi', 'Love Scrapbook Gift',
'İlişkinizin en güzel anlarını bir araya getiren el yapımı bir anı defteri hazırlayın. Fotoğrafları kronolojik sırayla düzenleyerek tanışma gününüzden bugüne bir zaman çizelgesi oluşturun. Her sayfaya o anın hikayesini ve hissettiklerinizi yazın. Bilet kopyaları, kurumuş çiçekler, tren biletleri ve restoran menüleri gibi hatıra eşyaları yapıştırın. Renkli kağıtlar, washi bantları ve çıkartmalarla sayfaları süsleyin. Son sayfalara gelecekte birlikte yapmak istediğiniz şeylerin listesini ekleyin. Defterin son birkaç sayfasını boş bırakarak gelecek anılar için yer ayırın. Bu emek yoğun hediye paha biçilemez duygusal değer taşıyacak.',
'Create a handmade scrapbook bringing together the most beautiful moments of your relationship. Arrange photos chronologically to create a timeline from the day you met to today. Write the story of each moment and how you felt on every page. Attach memorabilia like ticket copies, dried flowers, train tickets, and restaurant menus. Decorate pages with colored papers, washi tapes, and stickers. Add a list of things you want to do together in the future on the last pages. Leave the final few pages blank to save room for future memories. This labor-intensive gift will carry priceless emotional value.',
'Fotoğraflar, biletler ve anılarla dolu el yapımı anı defteri hazırlayarak aşkınızı belgeleyin.',
'Document your love with a handmade scrapbook filled with photos, tickets, and memories.',
3, 200, 800, 2, 2, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['anı','defter','fotoğraf','el yapımı','romantik','hatıra','kişisel'], false, false);
-- 28. date-night-jar (difficulty:1, indoor, all seasons, budget:50-200, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'date-night-jar',
'Buluşma Gecesi Kavanozu', 'Date Night Jar',
'Farklı buluşma fikirleri yazılmış renkli kağıtlarla dolu bir kavanoz hazırlayın. En az 52 farklı fikir yazarak her hafta bir kağıt çekmeyi gelenek haline getirin. Fikirleri kategorilere ayırın: ücretsiz aktiviteler yeşil, bütçe dostu mavi, lüks deneyimler kırmızı, macera dolu sarı kağıtlara yazın. Göl kenarında piknik, sushi yapma dersi, karaoke gecesi, müze gezisi, çömlekçilik atölyesi gibi çeşitli aktiviteler ekleyin. Her çekilen kağıdın tarihini not ederek hangi aktiviteleri yaptığınızı takip edin. Kavanozu birlikte süsleyerek ortak bir proje haline getirin. Bu basit ama etkili fikir her haftayı heyecanlı bir maceraya dönüştürecek.',
'Prepare a jar filled with colorful papers with different date ideas written on them. Write at least 52 different ideas to make pulling one paper each week a tradition. Categorize ideas: write free activities on green, budget-friendly on blue, luxury experiences on red, adventure-filled on yellow papers. Add various activities like lakeside picnic, sushi-making class, karaoke night, museum visit, pottery workshop. Track which activities you''ve done by noting the date on each pulled paper. Decorate the jar together to make it a shared project. This simple yet effective idea will turn every week into an exciting adventure.',
'Farklı buluşma fikirleri dolu kavanozdan her hafta kağıt çekerek yeni maceralar yaşayın.',
'Pull a paper from a jar full of date ideas each week for new adventures together.',
1, 50, 200, 2, 2, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['kavanoz','buluşma','fikir','macera','romantik','haftalık','eğlence'], false, false);
-- 29. love-video-capsule (difficulty:3, indoor, all seasons, budget:200-800, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'love-video-capsule',
'Aşk Video Kapsülü', 'Love Video Capsule',
'Sevdiğiniz kişi için duygusal bir video montaj hazırlayarak dijital bir aşk kapsülü oluşturun. Birlikte çekilmiş videoları ve fotoğrafları kronolojik sırayla düzenleyin. Tanıştığınız günden bugüne kadar olan yolculuğunuzu görsel olarak anlatın. Her bölüme duygusal müzikler ekleyin. Aile ve arkadaşlardan gizli video mesajları toplayarak sürprizi zenginleştirin. Videonun sonuna kendinizin konuştuğu samimi bir bölüm ekleyerek duygularınızı dile getirin. Videoyu özel bir USB''ye yükleyerek şık bir kutuyla hediye edin. Birlikte izlemek için rahat bir ortam hazırlayın. Bu emek dolu hediye gözyaşlarını tutamayacağı kadar duygusal olacak.',
'Create a digital love capsule by preparing an emotional video montage for your loved one. Arrange videos and photos taken together in chronological order. Visually narrate your journey from the day you met until today. Add emotional music to each section. Enrich the surprise by collecting secret video messages from family and friends. Add an intimate section at the end where you speak, expressing your feelings. Upload the video to a special USB and gift it in an elegant box. Prepare a comfortable setting to watch together. This labor-intensive gift will be so emotional they won''t be able to hold back tears.',
'Birlikte çekilmiş video ve fotoğraflardan duygusal bir aşk montajı hazırlayın.',
'Create an emotional love montage from videos and photos you''ve taken together.',
3, 200, 800, 2, 2, 7, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['video','montaj','anı','duygusal','romantik','dijital','hediye'], false, false);
-- 30. secret-date-reveal (difficulty:2, both, all seasons, budget:300-1500, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'secret-date-reveal',
'Gizli Buluşma Açıklaması', 'Secret Date Reveal',
'Sevdiğiniz kişiye gün boyunca ipuçları vererek akşamki sürpriz buluşmayı tahmin ettirmeye çalışın. Sabah bir zarfla başlayın, öğle yemeğinde ikinci ipucunu gönderin, iş çıkışında üçüncü zarfı bırakın. Her ipucu buluşmanın bir detayını açıklasın: ne giyeceği, hangi semtte olacağı, ne tür bir aktivite yapılacağı. Son ipucunda buluşma saatini ve yerini belirtin. Bu gizem dolu süreç heyecanı saatler boyunca canlı tutacak. Buluşma yerine geldiğinde masa üzerinde çiçekler ve küçük bir hediye bekliyor olsun. Gün boyunca aldığı ipuçlarını bir zarfta saklayarak hatıra olarak biriktirin.',
'Try to make your loved one guess the surprise date by giving clues throughout the day. Start with an envelope in the morning, send the second clue at lunch, leave the third envelope after work. Each clue reveals a detail about the date: what to wear, which neighborhood it''ll be in, what type of activity. Specify the meeting time and place in the final clue. This mystery-filled process will keep excitement alive for hours. When they arrive at the venue, flowers and a small gift should be waiting on the table. Collect the clues received throughout the day in an envelope as a keepsake.',
'Gün boyunca verdiğiniz ipuçlarıyla akşamki sürpriz buluşmayı tahmin ettirin.',
'Have your partner guess the surprise date by giving clues throughout the day.',
2, 300, 1500, 2, 2, 2, 'both', ARRAY['spring','summer','fall','winter'], ARRAY['gizem','ipucu','buluşma','sürpriz','heyecan','romantik','tahmin'], false, false);
-- 31. love-treasure-hunt (difficulty:4, both, spring/summer/fall, budget:500-2000, free, featured)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'love-treasure-hunt',
'Aşk Hazine Avı', 'Love Treasure Hunt',
'Şehrin farklı noktalarında gizlenmiş ipuçları ve hediyelerle epik bir hazine avı düzenleyin. En az 7-10 istasyon planlayarak her istasyonda bir ipucu, bir anı ve küçük bir hediye bırakın. İstasyonları ilişkiniz için anlamlı mekanlardan seçin. Her istasyonda çözülmesi gereken bir bulmaca veya bilmece hazırlayın. QR kodları kullanarak dijital ipuçları ekleyin. Güvenilir arkadaşları bazı istasyonlara görevli olarak yerleştirin. Son istasyonda büyük sürpriz beklesin: evlilik teklifi, özel bir hediye veya romantik bir yemek. Tüm rotayı haritada işaretleyerek zaman planlaması yapın. Bu macera dolu gün hayatınızın en heyecan verici buluşması olacak.',
'Organize an epic treasure hunt with clues and gifts hidden at different points across the city. Plan at least 7-10 stations, leaving a clue, a memory, and a small gift at each. Choose stations from places meaningful to your relationship. Prepare a puzzle or riddle to solve at each station. Add digital clues using QR codes. Station trusted friends as attendants at some stops. Have the big surprise waiting at the final station: a marriage proposal, a special gift, or a romantic dinner. Mark the entire route on a map and plan the timing. This adventure-filled day will be the most exciting date of your life.',
'Şehir genelinde ipuçları ve hediyelerle dolu epik bir romantik hazine avı düzenleyin.',
'Organize an epic romantic treasure hunt across the city with clues and gifts.',
4, 500, 2000, 2, 2, 7, 'both', ARRAY['spring','summer','fall'], ARRAY['hazine','avı','macera','ipucu','şehir','romantik','sürpriz','heyecan'], false, true);
-- 32. floating-lantern-night (difficulty:3, outdoor, summer, budget:300-1000, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'floating-lantern-night',
'Dilek Feneri Gecesi', 'Floating Lantern Night',
'Romantik bir akşamda gökyüzüne dilek fenerleri uçurarak büyüleyici bir gece yaşayın. Bir göl kenarı, sahil veya açık alan seçerek güvenli bir uçurma noktası belirleyin. Fenerlerin üzerine kalıcı kalemle dileklerinizi ve birbirinize mesajlarınızı yazın. Gün batımından sonra fenerleri yakarak birlikte gökyüzüne bırakın. Fenerlerin yavaşça yükselişini izlerken el ele tutun ve dileklerinizi paylaşın. Güvenlik önlemlerini alarak çevredeki yanıcı maddelerden uzak durun. Çevre dostu ve biyolojik olarak parçalanabilir fenerler tercih edin. Bu büyülü anı video ile kaydedin. Fener uçurma öncesi piknik kurarak geceyi uzatın.',
'Experience a magical night by releasing wish lanterns into the sky on a romantic evening. Choose a lakeside, beach, or open area and determine a safe release point. Write your wishes and messages to each other on the lanterns with permanent markers. Light the lanterns after sunset and release them together into the sky. Hold hands and share your wishes while watching the lanterns slowly rise. Take safety precautions and stay away from flammable materials in the area. Choose eco-friendly and biodegradable lanterns. Record this magical moment with video. Extend the night by setting up a picnic before the lantern release.',
'Gökyüzüne dilek fenerleri uçurarak büyülü ve romantik bir gece deneyimi yaşayın.',
'Experience a magical romantic night by releasing wish lanterns into the sky.',
3, 300, 1000, 2, 2, 2, 'outdoor', ARRAY['summer'], ARRAY['fener','dilek','gökyüzü','büyülü','romantik','gece','ışık'], false, false);
-- 33. couples-cooking-class (difficulty:2, indoor, all seasons, budget:400-1500, free)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'couples-cooking-class',
'Çift Yemek Yapma Atölyesi', 'Couples Cooking Class',
'Birlikte yeni bir mutfak keşfetmek için çift yemek yapma atölyesine katılın veya evde kendi atölyenizi düzenleyin. İtalyan, Japon, Meksika veya Fransız mutfağından bir menü seçin. Tüm malzemeleri önceden temin ederek mutfağı düzenleyin. Online bir şef eşliğinde veya tarif kitabı takip ederek birlikte yemek pişirin. Birbirinize görevler dağıtarak takım çalışması yapın. Mutfakta dans ederek ve şarkı söyleyerek eğlenceli bir atmosfer yaratın. Hazırladığınız yemekleri şık bir masa düzeniyle servis edin. Mum ışığında birlikte yemeğinizi yiyin. Bu deneyim hem yeni beceriler öğretecek hem de birlikte kaliteli zaman geçirmenizi sağlayacak.',
'Join a couples cooking class or organize your own workshop at home to discover a new cuisine together. Choose a menu from Italian, Japanese, Mexican, or French cuisine. Obtain all ingredients in advance and organize the kitchen. Cook together following an online chef or recipe book. Distribute tasks to work as a team. Create a fun atmosphere by dancing and singing in the kitchen. Serve your prepared dishes with an elegant table setting. Eat your meal together by candlelight. This experience will both teach new skills and provide quality time together, creating delicious memories you''ll want to recreate again and again.',
'Birlikte yeni bir mutfak keşfedip yemek yaparak eğlenceli ve lezzetli bir gece geçirin.',
'Discover a new cuisine together by cooking for a fun and delicious evening.',
2, 400, 1500, 2, 2, 2, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['yemek','mutfak','atölye','birlikte','romantik','lezzet','eğlence'], false, false);
-- 34. romantic-train-journey (difficulty:4, both, spring/fall, budget:2000-8000, premium)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'romantic-train-journey',
'Romantik Tren Yolculuğu', 'Romantic Train Journey',
'Sevdiğiniz kişiyle nostaljik bir tren yolculuğuna çıkarak romantik bir macera yaşayın. Doğu Ekspresi, turistik tren hatları veya şehirler arası manzaralı rotalar arasından seçim yapın. Özel kompartıman veya yataklı vagon rezervasyonu yaparak mahremiyet sağlayın. Yolculuk için özel bir piknik sepeti hazırlayın. Tren penceresinden geçen manzaraları izlerken sohbet edin ve kitap okuyun. Varış noktasında romantik bir otel rezervasyonu yaparak tatilin tadını çıkarın. Tren istasyonunda nostaljik fotoğraflar çekin. Yolculuk boyunca kart oyunları oynayarak eğlenin. Bu slow travel deneyimi hızlı dünyadan kaçarak birbirinize odaklanmanızı sağlayacak.',
'Embark on a romantic adventure by taking a nostalgic train journey with your loved one. Choose from the Eastern Express, tourist train routes, or scenic intercity routes. Ensure privacy by booking a private compartment or sleeper car. Prepare a special picnic basket for the journey. Chat and read books while watching the scenery pass through the train window. Enjoy the vacation by making a romantic hotel reservation at the destination. Take nostalgic photos at the train station. Have fun playing card games throughout the journey. This slow travel experience will allow you to focus on each other by escaping the fast-paced world.',
'Nostaljik tren yolculuğuyla manzaralar eşliğinde romantik bir kaçamak yapın.',
'Take a romantic getaway on a nostalgic train journey with scenic views.',
4, 2000, 8000, 2, 2, 14, 'both', ARRAY['spring','fall'], ARRAY['tren','yolculuk','nostaljik','macera','romantik','manzara','kaçamak'], true, false);
-- 35. love-story-comic-book (difficulty:4, indoor, all seasons, budget:1500-5000, premium)
INSERT INTO public.scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_premium, is_featured)
VALUES (gen_random_uuid(), cat_romantic, 'love-story-comic-book',
'Aşk Hikayesi Çizgi Roman', 'Love Story Comic Book',
'İlişkinizin hikayesini anlatan kişiye özel bir çizgi roman bastırın. Profesyonel bir illüstratörle çalışarak tanışma anınızdan bugüne kadar olan yolculuğunuzu çizgi roman formatında anlatın. Gerçek anılarınızı, komik diyaloglarınızı ve duygusal anlarınızı karelere dönüştürün. Karakterlerinizi size benzeterek kişiselleştirin. En az 20-30 sayfalık bir hikaye oluşturun. Kapak tasarımını özel olarak yaptırın ve profesyonel baskı ile ciltleyin. Birden fazla kopya bastırarak aile üyelerine de hediye edin. Son sayfada geleceğe dair bir mesaj veya evlilik teklifi gibi sürpriz bir final ekleyin. Bu benzersiz hediye ömür boyu saklanacak.',
'Have a custom comic book printed telling the story of your relationship. Work with a professional illustrator to narrate your journey from the moment you met until today in comic book format. Transform real memories, funny dialogues, and emotional moments into panels. Personalize by making the characters resemble you. Create a story of at least 20-30 pages. Have the cover design custom made and bind with professional printing. Print multiple copies to gift to family members as well. Add a surprise finale on the last page like a message for the future or a marriage proposal. This unique gift will be treasured for a lifetime.',
'İlişkinizin hikayesini profesyonel illüstratörle çizgi roman olarak bastırıp hediye edin.',
'Gift your relationship story as a professionally illustrated custom comic book.',
4, 1500, 5000, 2, 2, 21, 'indoor', ARRAY['spring','summer','fall','winter'], ARRAY['çizgi roman','hikaye','illüstrasyon','kişisel','romantik','hediye','sanat'], true, false);


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
VALUES (gen_random_uuid(), cat_friendship, 'surprise-camping-getaway',
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
