-- Migration 016: Enrich scenario content with detailed descriptions, steps and pro tips
-- Updates top featured scenarios with richer, more actionable content

DO $$
DECLARE
  s_id uuid;
BEGIN

-- ============================================
-- 1. SAHILDE GÜN BATIMI TEKLİFİ (beach-sunset-proposal)
-- ============================================
SELECT id INTO s_id FROM public.scenarios WHERE slug = 'beach-sunset-proposal';
IF s_id IS NOT NULL THEN

UPDATE public.scenarios SET
  description_tr = 'Hayatınızın en önemli sorusunu, güneşin denizle buluştuğu o büyülü anda sorun. Kumsalda kumla yazılmış "Benimle evlenir misin?" yazısını, alev alev yanan mumların çevrelediği çiçek taçları ve uçuşan gül yaprakları tamamlıyor. Özelleştirilmiş bir Spotify listesi hoparlörden akarken, uzakta gizlenen fotoğrafçınız bu anı ölümsüzleştiriyor. Partneriniz kumu görüp şaşırdığında yüzüğü çıkarın ve hayatınızı birleştirme teklifinizi yapın. Bu senaryo her mevsim uygulanabilir; ancak Haziran-Eylül arası gün batımı renkleri en dramatik sonucu verir. Kapadokya sahilleri, Alaçatı veya Bodrum gibi sığ ve sakin koylar bu senaryo için idealdir.',
  description_en = 'Pop the question at the magical moment when the sun meets the sea. "Will you marry me?" written in sand is surrounded by blazing candles, flower crowns and scattered rose petals. A custom Spotify playlist flows from a Bluetooth speaker while your hidden photographer immortalizes the moment. When your partner spots the writing and gasps in surprise, pull out the ring and make your life-changing ask. This scenario works any season, but June–September sunsets deliver the most dramatic colors. Shallow, calm coves like those in Alaçatı or Bodrum are ideal.'
WHERE id = s_id;

UPDATE public.scenario_steps SET
  description_tr = 'Google Maps veya yerel forumlardan kalabalık olmayan, erişimi kolay bir koy araştırın. İzinli plaj olup olmadığını kontrol edin — bazı özel plajlar akşam saatlerini kısıtlar. Gün batımının tam saatini timeanddate.com''dan öğrenin ve en az 2 saat öncesi için plan yapın. Saha ziyareti yaparak zemini inceleyin: ince kum mı, çakıllı mı? İnce kum kumda yazı için çok daha uygun.',
  description_en = 'Research uncrowded, easily accessible coves using Google Maps or local forums. Check whether it''s a licensed beach — some private beaches restrict evening access. Find the exact sunset time on timeanddate.com and plan to arrive at least 2 hours early. Do a site visit to inspect the ground: fine sand or pebbles? Fine sand is far better for writing text.',
  pro_tip_tr = 'Fotoğrafçı ile aynı gün bir "kuru prova" yapın: mum yerleşimini test edin, hoparlörün sesi yeterli mi kontrol edin ve güneş tam nereye batıyor gözlemleyin.',
  pro_tip_en = 'Do a dry run with the photographer the same day: test candle placement, check speaker volume, and observe exactly where the sun sets.'
WHERE scenario_id = s_id AND step_number = 1;

UPDATE public.scenario_steps SET
  description_tr = 'Partnerinizin parmak ölçüsünü gizlice öğrenmenin en iyi yolu, birlikte takı vitrinlerinde gezerken "bu yakışır mı?" diye sorup denettirmektir. Alternatif olarak takılarından birini bir kuyumcuya götürün. Metal türünü (altın, platin, gül altını) ve taş tercihini önceden araştırın; Instagram kayıtlarına bakın. Bütçenizin %70-80''ini yüzüğe ayırın — diğer detaylar ikinci planda kalabilir ama yüzük ömür boyu kalır.',
  description_en = 'The best way to secretly learn your partner''s ring size is to browse jewelry stores together and ask them to try on rings casually. Alternatively, take one of their existing rings to a jeweler. Research metal preference (gold, platinum, rose gold) and stone choice in advance; check their Instagram saves. Allocate 70-80% of your budget to the ring — other details can be secondary but the ring lasts a lifetime.',
  pro_tip_tr = 'Yüzüğü güvenli bir kutu içinde yanınızda taşıyın; sahilde bunu cebinizde tutmak çok rahatsız edici. Küçük bir kadife kese veya özel kutu kullanın.',
  pro_tip_en = 'Carry the ring in a secure, compact box — keeping it in your pocket on the beach is uncomfortable. Use a small velvet pouch or purpose-built ring box.'
WHERE scenario_id = s_id AND step_number = 2;

UPDATE public.scenario_steps SET
  description_tr = 'Alacağınız malzemeler: en az 20 adet uzun saplı beyaz/kırmızı mum, mum tutucu veya kum dolu küçük fenerler, 200-300 adet gül yaprağı, büyük tarak veya cetvel (kumda harfleri çizmek için), 4-5 adet balon. "Benimle evlenir misin?" yazısını en az 2 metre boyunda yazın — aksi halde fotoğrafta görünmez. Mum çemberini bu yazının etrafına yerleştirin ve gül yapraklarıyla doldurun. Rüzgâr varsa mumların etrafına taş koyun.',
  description_en = 'Shopping list: at least 20 long-stem white/red candles, candle holders or sand-filled small lanterns, 200-300 rose petals, a large rake or ruler (for drawing letters in sand), 4-5 balloons. Write "Will you marry me?" at least 2 meters tall — otherwise it won''t show in photos. Place the candle ring around the text and fill with rose petals. If windy, place stones around the candles.',
  pro_tip_tr = 'Güçlü rüzgâr varsa mum yerine LED mum kullanın — rüzgar söndürmez ve batarya ömrü genellikle 8+ saattir. Görüntü olarak neredeyse aynı.',
  pro_tip_en = 'If it''s windy, use LED candles instead — they won''t blow out and batteries typically last 8+ hours. Visually nearly identical.'
WHERE scenario_id = s_id AND step_number = 3;

UPDATE public.scenario_steps SET
  description_tr = 'Fotoğrafçıya sahili önceden tanıtın; "gün batımı sürprizi" için deneyimli biri tercih edin. Pozisyonu konuşun: yakın-orta-uzak plan için 3 farklı nokta belirleyin. Partnerinizi sahile getiren arkadaşınıza da sinyal verin — "hazırız" mesajı attığınızda arkadaş artık uzaklaşacak. Fotoğrafçı kum yazısının arkasında belirli bir kayalığın arkasına saklanabilir; önceden test edin.',
  description_en = 'Introduce the photographer to the beach in advance; prefer someone experienced with "golden hour surprises." Discuss positions: identify 3 different spots for close, medium, and wide shots. Also brief the friend bringing your partner — they''ll step away when you text "ready." The photographer can hide behind a specific rock formation behind the sand writing; test this beforehand.',
  pro_tip_tr = 'Fotoğrafçıya hem fotoğraf hem video çekmesini isteyin. Partnerinizin ilk tepkisini video olarak yakalamak çok daha değerli — o anki sesin kaydı ömürlük bir anı.',
  pro_tip_en = 'Ask the photographer to shoot both photos and video. Capturing your partner''s first reaction on video is far more precious — the sound of that moment is a lifelong memory.'
WHERE scenario_id = s_id AND step_number = 4;

UPDATE public.scenario_steps SET
  description_tr = 'Bluetooth hoparlör şarjını tam yapın ve IP67 su geçirmez olduğundan emin olun. Spotify''dan "Teklif Anı" özel playlist oluşturun: en başa partnerinizin en sevdiği şarkıyı koyun, ardından romantik enstrümental parçalar. Hoparlörü kum yazısına yakın ama görünmeyecek şekilde bir taşın yanına yerleştirin. Şarkı listesini partnerinizi mekanla götürmeden önce test edin.',
  description_en = 'Fully charge the Bluetooth speaker and ensure it''s IP67 waterproof. Create a custom "Proposal Moment" playlist on Spotify: put your partner''s all-time favorite song first, then romantic instrumental pieces. Place the speaker near the sand writing but hidden behind a rock. Test the playlist before bringing your partner to the venue.',
  pro_tip_tr = 'İlk şarkı olarak ilk buluştuğunuzda çalan şarkıyı veya birlikte gittiğiniz bir konserin şarkısını seçin. O an daha da derin bir anlam kazanır.',
  pro_tip_en = 'Choose the song that was playing when you first met, or from a concert you attended together, as the first track. That moment gains even deeper meaning.'
WHERE scenario_id = s_id AND step_number = 5;

UPDATE public.scenario_steps SET
  description_tr = 'Gün batımından 2.5 saat önce mekana gidin ve düzeni kurun. Mum ve çiçekleri 1 saat önce yerleştirin (çok erken koyarsanız rüzgar bozar). Fotoğrafçının yerinde olduğunu teyit edin. Partnerinizi "sürpriz bir şey var" demeden "sahile yürüyüşe gidelim" diyerek getirin. Yazıyı görünce şaşırmasına izin verin, sonra yavaşça yüzüğü çıkarın. Söyleyeceğiniz sözleri önceden kafanızda canlandırın — ama ezberlemeyin, içten konuşun.',
  description_en = 'Arrive 2.5 hours before sunset and set everything up. Place candles and flowers 1 hour before (too early and wind will ruin them). Confirm the photographer is in position. Bring your partner without saying "there''s a surprise" — just "let''s go for a beach walk." Let them be surprised when they spot the writing, then slowly pull out the ring. Visualize what you''ll say beforehand — but don''t memorize it, speak from the heart.',
  pro_tip_tr = 'İlk "evet" anından sonra paniğe kapılmayın. Yüzüğü takmadan önce bir an için sadece birbirinize bakın — fotoğrafçı bu anı ölümsüzleştirecek.',
  pro_tip_en = 'Don''t panic after the first "yes." Before putting on the ring, take a moment just to look at each other — the photographer will immortalize this moment.'
WHERE scenario_id = s_id AND step_number = 6;

END IF;

-- ============================================
-- 2. SÜRPRİZ DOĞUM GÜNÜ PARTİSİ (surprise-birthday-party)
-- ============================================
SELECT id INTO s_id FROM public.scenarios WHERE slug = 'surprise-birthday-party';
IF s_id IS NOT NULL THEN

UPDATE public.scenarios SET
  description_tr = 'Kapıyı açtığında bütün sevdiklerinin orada olduğunu gören birinin yüzündeki ifadeyi hayal edin — işte bu senaryo tam olarak o anı yaratmak için tasarlandı. Kişinin ilgi alanlarına göre özelleştirilmiş bir tema (favori film, müzik türü, seyahat ettiği şehir...) mekanı tamamen kaplıyor. Haftalarca süren gizli koordinasyon, ince planlama ve mükemmel zamanlamayı gerektiriyor. Ama o "SÜRPRİZ!" anı her şeye değer. 5 kişilik samimi bir gather''dan 50 kişilik büyük kutlamaya kadar her ölçeğe uyarlanabilir.',
  description_en = 'Imagine the expression on someone''s face when they open the door and find all their loved ones there — that''s exactly what this scenario is designed to create. A customized theme based on the person''s interests (favorite film, music genre, city they''ve visited...) takes over the entire venue. It requires weeks of secret coordination, meticulous planning, and perfect timing. But that "SURPRISE!" moment is worth everything. Scalable from an intimate 5-person gathering to a 50-person celebration.'
WHERE id = s_id;

UPDATE public.scenario_steps SET
  description_tr = 'Listeyi 3 gruba ayırın: kesinlikle olması gerekenler (yakın arkadaşlar, aile), olsa iyi olur (iş arkadaşları, eski okul arkadaşları) ve bildirilecekler (uzak çevredekiler). Herkese "bu çok gizli, kimseye söyleme" diye tek tek bildirin — toplu mesaj atmayın, biri kazara sızdırabilir. Her kişinin iletişim bilgisini (telefon + WhatsApp) kaydedin. Davetlilerin eski fotoğraflarını toplamanızı da isteyin — dekorasyon ve slayt için kullanacaksınız.',
  description_en = 'Split the list into 3 groups: must-haves (close friends, family), nice-to-haves (coworkers, old classmates), and inform-only (extended circle). Notify everyone individually saying "this is top secret, don''t tell anyone" — don''t send a group message as someone might accidentally leak it. Record each person''s contact info (phone + WhatsApp). Also ask them to send old photos — you''ll use them for decorations and a slideshow.',
  pro_tip_tr = 'En yakın bir arkadaşı "sürpriz koordinatörü" olarak atayın. Bu kişi doğum günü çocuğunu mekanı getirecek ve tüm davetlilerle tek iletişim noktası olacak.',
  pro_tip_en = 'Assign one close friend as the "surprise coordinator." This person will bring the birthday person to the venue and serve as the single point of contact for all guests.'
WHERE scenario_id = s_id AND step_number = 1;

UPDATE public.scenario_steps SET
  description_tr = 'Mekan kapasitesini kişi sayısına göre değil, kişi başına en az 1.5m² hesabıyla seçin. Ev kullanıyorsanız: mobilyaları önceden kaydırın ve yeterli alan açın. Kiralık mekan kullanıyorsanız: gürültü kısıtlaması, park yeri ve mutfak erişimini kontrol edin. Mekan sahibine sürpriz organizasyonu olduğunu bildirin — partinin başında "SÜRPRİZ" bağırılacağını söyleyin. Giriş kapısının arkasında herkesin saklanabileceği bir alan olduğundan emin olun.',
  description_en = 'Choose the venue based on at least 1.5m² per person, not just headcount. If using your home: shift furniture in advance and clear enough space. If renting: check noise restrictions, parking, and kitchen access. Inform the venue owner it''s a surprise party — tell them guests will shout "SURPRISE." Make sure there''s a hiding area behind the entrance door.',
  pro_tip_tr = 'Bir kişiyi "kapı bekçisi" olarak atayın — doğum günü çocuğunun arabasının yolda olduğunu size bildirsin. Böylece herkes zamanında pozisyon alır.',
  pro_tip_en = 'Assign one person as "door lookout" — they notify you when the birthday person''s car is on the way. This ensures everyone is in position in time.'
WHERE scenario_id = s_id AND step_number = 2;

UPDATE public.scenario_steps SET
  description_tr = 'Doğum günü kişisinin ilgi alanlarını düşünün: sevdiği film/dizi, müzik grubu, seyahat destinasyonu, hobi veya kariyer. Temayı bu üzerine kurun. Dekorasyon: kişisel fotoğraf kolajı (balmumu gibi gergin ip üstüne mandal ile asın), tema renkleri balonlar, isme özel afiş ("40 Yıllık Harika İnsan" gibi). Masa düzeni: kişi başına küçük bir kişisel not veya hatıra bırakın. Masalara tema rengi mumluk ve çiçek koyun.',
  description_en = 'Think about the birthday person''s interests: favorite film/show, music act, travel destination, hobby, or career. Build the theme around this. Decoration: personal photo collage (hang with clothes pegs on a taut string like a washing line), themed balloons in their colors, a personalized banner ("40 Years of Awesomeness"). Table setting: leave a small personal note or memento per person. Add themed candleholders and flowers on tables.',
  pro_tip_tr = 'Dekorasyonun en dikkat çekici unsuru kişisel fotoğraflardır. Balon ve hazır malzemeleri azaltın, fotoğraf sayısını artırın — duygusal etki çok daha güçlü olur.',
  pro_tip_en = 'The most impactful decoration element is personal photos. Reduce balloons and off-the-shelf items, increase photo count — the emotional impact is much stronger.'
WHERE scenario_id = s_id AND step_number = 3;

UPDATE public.scenario_steps SET
  description_tr = 'Pasta için en az 10 gün önceden özel tasarım sipariş verin — son dakika siparişlerinde tasarım seçenekleri kısıtlı olur. Pastanın üzerinde kişinin sevdiği bir alıntı, karikatür veya fotoğraf olsun. Yiyecek için bütçenize göre: ev yapımı yemekler (en kişisel), catering servisi (en pratik), restoran siparişi (ortası). Kişinin alerjileri ve diyet kısıtlamalarını davetlilere bildirin. Alkollü ve alkolsüz seçenek mutlaka sunun.',
  description_en = 'Order a custom-designed cake at least 10 days in advance — last-minute orders have limited design options. The cake should feature a quote, cartoon, or photo the person loves. For food by budget: homemade dishes (most personal), catering service (most practical), restaurant order (middle ground). Inform guests of any allergies and dietary restrictions. Always offer both alcoholic and non-alcoholic options.',
  pro_tip_tr = 'Pastayı körleme getirmeyin — bir foto önizleme isteyin. Ve "doğum günü kutlu olsun" yerine kişinin sevdiği bir şarkının ilk dizisiyle başlamayı düşünün.',
  pro_tip_en = 'Don''t order the cake blindly — ask for a photo preview. And instead of "Happy Birthday," consider starting with the opening line of their favorite song.'
WHERE scenario_id = s_id AND step_number = 4;

UPDATE public.scenario_steps SET
  description_tr = 'Eğlence planı 3 aşamalı olsun: (1) ilk 30 dakika serbest sohbet ve içecek — herkes birbirini tanısın; (2) orta kısım: ısınma oyunu (kişi hakkında doğru-yanlış soruları), slayt gösterisi veya video kolajı; (3) son bölüm: pasta, şarkı, hediyeler. DJ veya canlı müzik varsa dans alanını önceden belirleyin. Karaoke ekleyecekseniz kişinin sevdiği şarkıları başa koyun. Çocuk davetli varsa ayrı bir köşe hazırlayın.',
  description_en = 'Structure entertainment in 3 phases: (1) first 30 minutes: free mingling and drinks — let everyone get acquainted; (2) middle section: warm-up game (true/false questions about the person), slideshow or video montage; (3) closing: cake, singing, gifts. If there''s a DJ or live music, designate the dance floor in advance. If adding karaoke, put their favorite songs first. If children are attending, prepare a separate corner for them.',
  pro_tip_tr = 'Partinin en yavaş anı genellikle hediye açma sürecidir — kalabalık varsa herkesi bekletmek yerine hediyeleri özel bir masa üzerinde toplayın ve sonrasında açtırın.',
  pro_tip_en = 'The slowest moment of a party is usually gift opening — if it''s a crowd, rather than making everyone wait, collect gifts on a dedicated table and have them opened privately afterward.'
WHERE scenario_id = s_id AND step_number = 5;

UPDATE public.scenario_steps SET
  description_tr = 'Davetlilere iki kez bildirim yapın: ilk davet (1 hafta önce) ve hatırlatıcı (1-2 gün önce). Hatırlatıcıda şu kritik detayları vurgulayın: (1) kapıda tam sessizlik — kimse konuşmaz, telefon sessizde, (2) doğum günü kişisi geldiğinde ışıklar kapalı olacak, (3) koordinatör "hazır" sinyali verene kadar herkes saklı durur. WhatsApp grubu oluşturun — ama gruba doğum günü kişisini eklemeyin!',
  description_en = 'Send two notifications to guests: initial invite (1 week before) and reminder (1-2 days before). In the reminder, emphasize these critical details: (1) complete silence at the door — no talking, phones on silent, (2) lights will be off when the birthday person arrives, (3) everyone stays hidden until the coordinator gives the "ready" signal. Create a WhatsApp group — but don''t add the birthday person to it!',
  pro_tip_tr = 'Koordinatöre şu mesajı göndermesini söyleyin: "Parkta yürüyüş edelim mi?" gibi masum bir bahane — mekanı geçerken "bir şeyi aldım" diyerek içeri girsin.',
  pro_tip_en = 'Tell the coordinator to use an innocent pretext like "Want to take a walk?" — then pass by the venue and say "let me grab something" to go inside.'
WHERE scenario_id = s_id AND step_number = 6;

UPDATE public.scenario_steps SET
  description_tr = 'Parti günü checklist: ışıkları kapatın (giriş karanlık olsun), hoparlörü hazır tutun (şarkı başlatmak için tek tıklama yeterli olsun), pasta hazır ama görünmez olsun, herkes pozisyonda. Koordinatör "3 dakika" mesajı attığında herkes nefesini tutar. Kapı açıldığında koordinatör ışığı açar, herkes "SÜRPRİZ!" diye bağırır. İlk tepkiyi fotoğraflayın/videolayın — yüz ifadesi en değerli kaydınız.',
  description_en = 'Party day checklist: lights off (entrance should be dark), speaker queued up (one tap to start the song), cake ready but out of sight, everyone in position. When the coordinator texts "3 minutes," everyone holds their breath. When the door opens, the coordinator flips the light, everyone shouts "SURPRISE!" Photograph/video the first reaction — the facial expression is your most valuable recording.',
  pro_tip_tr = 'Birini "tepki fotoğrafçısı" olarak atayın — tek görevi kapı açıldığı an doğum günü kişisinin yüzünü çekmek. Bu anı kaçırmayın.',
  pro_tip_en = 'Assign a dedicated "reaction photographer" — their only job is to capture the birthday person''s face the moment the door opens. Don''t miss this shot.'
WHERE scenario_id = s_id AND step_number = 7;

END IF;

-- ============================================
-- 3. SICAK HAVA BALONU TEKLİFİ (hot-air-balloon-proposal)
-- ============================================
SELECT id INTO s_id FROM public.scenarios WHERE slug = 'hot-air-balloon-proposal';
IF s_id IS NOT NULL THEN

UPDATE public.scenarios SET
  description_tr = 'Yüzlerce metre yüksekte, sabahın ilk ışıklarında, Kapadokya''nın peri bacalarına bakan bir balonun sepetinde hayatınızın sorusunu sormak — bu dünyadaki en sinematik teklif anlarından biridir. Yerden ayrıldıktan sonra gökyüzünde gün doğumunu izlerken, partneriniz şampanya kadehini tutarken yüzüğü çıkarın. Uçuş firması genellikle bu anı özel fotoğraf ve video çekimiyle ölümsüzleştirebilir. Kapadokya yılın büyük bölümünde uçuşa elveriş durumda, ancak Nisan-Haziran ve Eylül-Ekim arası hem hava koşulları hem de manzara açısından en ideal dönemdir.',
  description_en = 'Asking the most important question of your life hundreds of meters up, in the first light of dawn, looking over Cappadocia''s fairy chimneys from a balloon basket — this is one of the most cinematic proposal moments on earth. After lifting off, as you watch the sunrise in the sky and your partner holds their champagne flute, pull out the ring. The flight company can often immortalize this moment with dedicated photo and video coverage. Cappadocia is flyable most of the year, but April–June and September–October offer the best combination of conditions and scenery.'
WHERE id = s_id;

UPDATE public.scenario_steps SET
  description_tr = 'Kapadokya''da düzinelerce balon şirketi faaliyet gösteriyor — kalite ve güvenlik standartları ciddi ölçüde farklılık gösteriyor. TripAdvisor''da en az 500 değerlendirmesi olan ve son 6 ay içinde kaza kaydı olmayan şirketleri tercih edin. "Özel uçuş" veya "özel sepet" seçeneği sunup sunmadıklarını sorun — çoğu şirket 2-4 kişilik özel balonlar sunmaktadır. Royal Balloon, Turkiye Balloons ve Butterfly Balloons bu kategoride öne çıkan isimler. Fiyat karşılaştırması için en az 3 firmadan teklif alın.',
  description_en = 'Dozens of balloon companies operate in Cappadocia — quality and safety standards vary considerably. Prefer companies with at least 500 TripAdvisor reviews and no accident record in the last 6 months. Ask whether they offer "private flight" or "private basket" — most companies offer private balloons for 2-4 people. Royal Balloon, Turkiye Balloons, and Butterfly Balloons are standout names in this category. Get quotes from at least 3 companies for price comparison.',
  pro_tip_tr = 'Teklif planladığınızı firmaya söyleyin — birçok şirkette "evlilik teklifi paketi" var ve sepete çiçek, şampanya ve pankart dahil ediyorlar. Ayrıca pilot bu an için özellikle dikkatini veriyor.',
  pro_tip_en = 'Tell the company you''re planning a proposal — many have a "marriage proposal package" that includes flowers, champagne, and a banner in the basket. The pilot also gives the moment special attention.'
WHERE scenario_id = s_id AND step_number = 1;

UPDATE public.scenario_steps SET
  description_tr = 'Kapadokya uçuşları hava koşullarına çok duyarlıdır; rüzgar 15 km/s üzerine çıktığında uçuşlar iptal edilir. Rezervasyon yaparken "yedek güne otomatik aktarım" politikasını netleştirin. Özel uçuş için en az 2 hafta önceden rezervasyon yaptırın; özellikle Nisan-Ekim arası aylarda doluluk yüksektir. Rezervasyon yaparken ödeme iptali politikasına dikkat edin: geri ödemesiz mi, yedek güne aktarım mı? Uçuş saatini partnerinize "bir sürpriz var ama sabah erkenden kalkacağız" olarak duyurabilirsiniz.',
  description_en = 'Cappadocia flights are very sensitive to weather; flights are cancelled when wind exceeds 15 km/h. When booking, clarify the "automatic transfer to backup day" policy. Book private flights at least 2 weeks in advance; occupancy is high especially April–October. Watch the cancellation policy when booking: no refund, or transfer to another day? You can tell your partner "there''s a surprise but we''ll need to get up early" for the flight time.',
  pro_tip_tr = 'Güvence için 2 ardışık gün rezervasyonu yaptırın — ilk gün hava nedeniyle iptal olursa ikinci gün gerçekleştirin. İlk ödeme ile ikinci günün teyidi için firmadan yazılı onay alın.',
  pro_tip_en = 'For security, book 2 consecutive days — if the first day is cancelled due to weather, you''ll have the second. Get written confirmation from the company for both the first payment and second-day guarantee.'
WHERE scenario_id = s_id AND step_number = 2;

UPDATE public.scenario_steps SET
  description_tr = 'Kapadokya''nın en romantik konaklama seçeneği mağara otellerdir. Ürgüp''teki Sultan Cave Suites, Göreme''deki Museum Hotel veya Ayvali bölgesindeki butik mağara pansiyonları öne çıkan seçenekler. Süit seçeneğini tercih edin — özel jakuzi veya teras genellikle mağara otellerinde mevcuttur. Teklif planınızı otele bildirin: oda çiçekle, mektupla veya şampanyayla süsleyebilirler. Konaklama için en az 2 gece rezervasyonu yapın — uçuş gecikmesi veya iptali durumunda tampon gününüz olsun.',
  description_en = 'The most romantic accommodation option in Cappadocia is cave hotels. Sultan Cave Suites in Ürgüp, Museum Hotel in Göreme, or boutique cave guesthouses in the Ayvali area are standout choices. Choose the suite option — private jacuzzi or terrace is usually available in cave hotels. Inform the hotel of your proposal plan: they can decorate the room with flowers, a letter, or champagne. Book at least 2 nights — this gives you a buffer day for flight delays or cancellations.',
  pro_tip_tr = 'Uçuş sonrası kahvaltıyı otelde hazırlayın — teklif sonrası yorgun ama mutlu bir çift için sıcak kahvaltı çok değerlidir. Mağara otellerin açık terası veya vadiye bakan balkonu buna mükemmel bir fon sağlar.',
  pro_tip_en = 'Arrange a hotel breakfast for after the flight — a warm breakfast is priceless for a tired-but-happy newly engaged couple. Cave hotels'' open terraces or valley-view balconies provide a perfect backdrop for this.'
WHERE scenario_id = s_id AND step_number = 3;

UPDATE public.scenario_steps SET
  description_tr = 'Balon sepetine taşınabilir dekorasyon: 5-7 adet kırmızı gül (uzun saplı, şeritli — sepete tutturabilmek için), 1 küçük şampanya şişesi ve 2 kristal bardak (kırılmaz tercih edin), kişisel el yazısıyla yazılmış küçük kart, "Benimle evlenir misin?" yazan küçük bir kumaş pankart. Yüzüğü küçük ve sağlam bir kutu içinde montünüzün iç cebine koyun — sepette sıçrama olabilir. Uçuş firmasına dekorasyonları önceden gönderin ve yerleştirmelerini isteyin.',
  description_en = 'Portable decorations for the basket: 5-7 red roses (long-stemmed, ribboned — so they can be attached to the basket), 1 small champagne bottle and 2 crystal glasses (choose shatterproof), a small card with a handwritten personal message, a small fabric banner reading "Will you marry me?" Keep the ring in a small, sturdy box in your inner coat pocket — there can be jostling in the basket. Send decorations to the flight company in advance and ask them to set everything up.',
  pro_tip_tr = 'Şampanyayı uçuş sırasında değil, iniş sonrası zeminde açın. Uçuşta ellerin titremesi veya rüzgar açısıyla boşaltma riski var. İniş alanında kutlama çok daha rahat.',
  pro_tip_en = 'Open the champagne after landing on the ground, not during the flight. During the flight there''s risk of spilling due to shaky hands or wind angle. Celebrating at the landing area is much more comfortable.'
WHERE scenario_id = s_id AND step_number = 4;

UPDATE public.scenario_steps SET
  description_tr = 'Sabah 4:30-5:00''da kalkmanız gerekecek — uçuş şirketleri genellikle 5:30-6:00''da toplantı ister. Partnerinizi heyecanlandırarak "bu gün hayatınızın en güzel sabahı olacak" diyerek uyandırın. Uçuş briefinginde pilot size genellikle teklif anı için en uygun pozisyonu gösterecek. Yükseklik kazanıldıktan ve manzara tam açıldıktan sonra (genellikle kalkıştan 15-20 dakika sonra) teklif edin. Pilottan fotoğraf çekmesini rica edebilirsiniz — çoğu pilot bu an için fotoğraf makinesiyle hazır bekler.',
  description_en = 'You''ll need to wake up at 4:30–5:00am — flight companies usually want you at the meeting point by 5:30–6:00am. Wake your partner with excitement saying "today is going to be the most beautiful morning of your life." During the flight briefing, the pilot will usually show you the best position for the proposal moment. Propose after altitude is gained and the full panorama opens up (usually 15–20 minutes after takeoff). You can ask the pilot to take photos — most pilots stand ready with a camera for this moment.',
  pro_tip_tr = 'Diz çökmek sepette zor olabilir. Eğer denge sorunu yaşarsanız — yüzüğü çıkarıp elinizde tutarken, ona bakarak teklif etmek tamamen yeterlidir. Önemli olan söz, poz değil.',
  pro_tip_en = 'Kneeling can be tricky in the basket. If balance is an issue — simply take out the ring, hold it in your hand, and propose while looking into their eyes. What matters is the words, not the pose.'
WHERE scenario_id = s_id AND step_number = 5;

END IF;

-- ============================================
-- 4. HAZINE AVI DOĞUM GÜNÜ (treasure-hunt-birthday)
-- ============================================
SELECT id INTO s_id FROM public.scenarios WHERE slug = 'treasure-hunt-birthday';
IF s_id IS NOT NULL THEN

UPDATE public.scenarios SET
  description_tr = 'Doğum günü hediyesi yerine bir macera verin. Her ipucu birlikte yaşadığınız bir anıya, gizli bir mekana veya ortak bir sevdaya işaret ediyor. Sabahın ilk ipucuyla başlayan bu yolculuk, şehrin farklı köşelerini kapsayan 5-8 durağı geçip akşama kadar büyük final sürprizine ulaşıyor. Her durakta küçük bir hediye, bir mektup veya ortak bir arkadaşla karşılaşma bekliyor. Bu senaryo, hediyenin kendisi kadar yolu da hediye haline getiriyor.',
  description_en = 'Give an adventure instead of a birthday gift. Each clue points to a shared memory, a secret location, or a common passion. Starting with the first clue in the morning, this journey passes through 5-8 stops across different corners of the city, reaching the grand finale surprise by evening. At each stop, a small gift, a letter, or an encounter with a mutual friend awaits. This scenario makes the journey itself a gift, as much as the final present.'
WHERE id = s_id;

UPDATE public.scenario_steps SET
  description_tr = 'İlk durağı uyanır uyanmaz görebilecekleri yere koyun — yastığın altı, banyo aynasına yapıştırılmış not veya kahvaltı tabağının yanı ideal. Rotanın her durağı bir anlam taşısın: ilk buluştuğunuz kafe, birlikte gittiğiniz konser alanı, bir arkadaşın evi, okulları veya iş yeri. 5-8 durak arası ideal — 4 fazla kısa, 10 fazla yorucu. Rotayı haritada çizin ve iki durak arası 15 dakikayı geçmeyecek şekilde optimize edin. Her durak için bir "bekçi" atayın — biri gelip ipucunu alacak.',
  description_en = 'Place the first clue somewhere they''ll see it the moment they wake up — under the pillow, a note stuck to the bathroom mirror, or next to the breakfast plate is ideal. Each stop on the route should carry meaning: the café where you first met, a concert venue you attended together, a friend''s house, their school or workplace. 5-8 stops is ideal — 4 is too short, 10 is too tiring. Draw the route on a map and optimize so no two stops are more than 15 minutes apart. Assign a "guardian" for each stop — someone who will hand over the clue when they arrive.',
  pro_tip_tr = 'İlk ipucunu bir "şiir" veya "bulmaca" olarak yazın — doğrudan adres vermeyin. Tahmin sürecinin kendisi eğlencenin yarısı.',
  pro_tip_en = 'Write the first clue as a "poem" or "riddle" — don''t give the address directly. The guessing process is half the fun.'
WHERE scenario_id = s_id AND step_number = 1;

UPDATE public.scenario_steps SET
  description_tr = 'İpucu kartları için kaliteli kağıt veya kartpostal kullanın. Her kartta üç unsur olsun: (1) bir anı veya ortak şakayı çağrıştıran kişisel bir giriş cümlesi ("Hatırlıyor musun 2019 yazını..."), (2) bir bulmaca veya şiir halinde sonraki durağın ipucu, (3) küçük bir "ara ödül" notu ("Cebine bak!"). Kartları hazırladıktan sonra bir arkadaşa okutun — anlaşılır ama çok kolay olmamalı. Laminasyon veya zarf içine koyarak hava koşullarından koruyun.',
  description_en = 'Use quality paper or postcards for clue cards. Each card should have three elements: (1) a personal opening line evoking a memory or shared joke ("Remember the summer of 2019..."), (2) the next stop clue in riddle or poem form, (3) a small "bonus reward" note ("Check your pocket!"). After preparing the cards, have a friend read them — they should be understandable but not too easy. Protect from weather by laminating or placing in envelopes.',
  pro_tip_tr = 'Son durağın ipucunu diğerlerinden belirgin biçimde farklı yapın — özel bir zarf, altın mühür veya el yazısıyla yazılmış mektup. "Bu son durak" hissini yaratın.',
  pro_tip_en = 'Make the final stop''s clue noticeably different from the others — a special envelope, gold seal, or handwritten letter. Create the feeling that "this is the last stop."'
WHERE scenario_id = s_id AND step_number = 2;

UPDATE public.scenario_steps SET
  description_tr = 'Her durağa orantılı bir hediye koyun — küçük ve kişisel. Örnek: durak 1 (favori çikolata/atıştırmalık), durak 2 (birlikte çekilmiş eski bir fotoğraf çerçeveli), durak 3 (küçük bir hobi malzemesi), durak 4 (hediye kartı), son durak (büyük hediye veya aktivite deneyimi). Her hediyeyi el yazısıyla yazılmış küçük bir not eşliğinde sunun. Hediyeleri önceden "bekçi"lere bırakın veya saklayın — son dakika paniğini önler.',
  description_en = 'Place a proportionate, personal gift at each stop — small but meaningful. Example: stop 1 (favorite chocolate/snack), stop 2 (an old photo of you together, framed), stop 3 (a small hobby item), stop 4 (gift card), final stop (big gift or experience activity). Present each gift with a small handwritten note. Drop off gifts to "guardians" or hide them in advance — this prevents last-minute panic.',
  pro_tip_tr = 'Büyük hediyeyi final durakta açtırmak yerine, finali bir aktivite veya deneyim yapın: birlikte akşam yemeği, konser bileti veya seyahat. Deneyim hediyeleri maddî hediyelerden çok daha uzun akılda kalır.',
  pro_tip_en = 'Instead of having them unwrap the big gift at the final stop, make the finale an activity or experience: dinner together, a concert ticket, or a trip. Experience gifts are remembered far longer than material ones.'
WHERE scenario_id = s_id AND step_number = 3;

UPDATE public.scenario_steps SET
  description_tr = 'Her durağa bir "bekçi" atayın ve onlara şu bilgileri verin: (1) tam lokasyon ve ipucu kartının tam nerede olduğu, (2) doğum günü kişisi geldiğinde söyleyecekleri kısa bir senaryo ("Seni bekliyordum, işte sıradaki ipucu!"), (3) telefon numaranız — gecikme veya sorun durumunda sizi aramaları için. Bekçilere "ne zaman gelecekler" konusunda yaklaşık bir zaman bilgisi verin. Birden fazla durağa aynı kişiyi atarsanız lojistik zorlaşır — mümkünse her durak için farklı kişi.',
  description_en = 'Assign a "guardian" to each stop and give them: (1) the exact location and where the clue card is hidden, (2) a short script for when the birthday person arrives ("I''ve been waiting for you, here''s the next clue!"), (3) your phone number — for them to call if there''s a delay or problem. Give guardians an approximate time window for when the person will arrive. If you assign the same person to multiple stops, logistics get complicated — use different people for each stop where possible.',
  pro_tip_tr = 'Bir "yedek bekçi" belirleyin — birinin gelememesi durumunda hızlıca o durağa gidebilecek güvenilir bir arkadaş. Planın en zayıf halkası insan faktörü.',
  pro_tip_en = 'Designate a "backup guardian" — a reliable friend who can quickly go to any stop if someone can''t make it. The weakest link in the plan is the human factor.'
WHERE scenario_id = s_id AND step_number = 4;

UPDATE public.scenario_steps SET
  description_tr = 'İlk ipucunu sabah kahvaltısında masada (veya yatakta) bırakın ve kendiniz de orada olun — ilk tepkiyi görmek istiyorsunuz. Final durağını akşama ayarlayın ki gün boyu bir beklenti inşa edilsin. Finalde ne olacağını siz de orada olarak yaşayın: son ipucunu birlikte çözmelerine izin verin, son durağa birlikte gidin veya siz de orada bekleyin. Final lokasyonunda küçük bir kutlama hazırlayın: balon, pasta, aile/arkadaş sürprizi veya sevdikleri müzik.',
  description_en = 'Leave the first clue at the breakfast table (or in bed) in the morning and be there yourself — you want to see the first reaction. Set the finale in the evening so anticipation builds throughout the day. Live the finale with them: let them solve the last clue together, walk to the final stop together, or be waiting there yourself. Prepare a small celebration at the final location: balloons, cake, a family/friend surprise, or their favorite music.',
  pro_tip_tr = 'Tüm gün boyunca onlara her durağın fotoğrafını "anlık güncelleme" olarak WhatsApp''tan göndermelerini isteyin. Akşam bu fotoğrafları bir kolaj yapın — gün bir anı albümüne dönüşür.',
  pro_tip_en = 'Ask them to send you a photo from each stop throughout the day as a "live update" via WhatsApp. In the evening, turn these photos into a collage — the day becomes a memory album.'
WHERE scenario_id = s_id AND step_number = 5;

END IF;

-- ============================================
-- 5. RESTORANDA SÜRPRİZ TEKLİF (restaurant-surprise-proposal)
-- ============================================
SELECT id INTO s_id FROM public.scenarios WHERE slug = 'restaurant-surprise-proposal';
IF s_id IS NOT NULL THEN

UPDATE public.scenarios SET
  description_tr = 'Şık bir restoranda, özenle hazırlanmış bir akşam yemeği sırasında o büyük soruyu sormak — klasik ama zamansız bir teklif senaryosu. Yüzüğü tatlının içine gizlemek mi, yoksa garsonun özel sunumu mu, yoksa şampanya kadehinin dibinde mi — bu detaylar senaryoyu kişisel yapıyor. Restoran ortamının avantajı, profesyonel kadro (garsonlar, şef, müzisyenler) sizin için sahneyi hazırlayabilir. İki kişilik özel masa ile çevre sessizliği, her sözün net duyulmasını ve anın tamamen size ait olmasını sağlıyor.',
  description_en = 'Popping the question during a carefully prepared dinner at a fine restaurant — a classic yet timeless proposal scenario. Whether hiding the ring in the dessert, having the waiter present it specially, or placing it at the bottom of the champagne flute — these details make the scenario personal. The advantage of a restaurant setting is that the professional staff (waiters, chef, musicians) can set the stage for you. A private table for two with ambient quiet ensures every word is heard clearly and the moment is entirely yours.'
WHERE id = s_id;

UPDATE public.scenario_steps SET
  description_tr = 'Sadece "romantik" bir yer seçmek yeterli değil — teklif senaryosuna uygun teknik koşulları da değerlendirin. Pencere kenarı veya alkoven masası tercih edin: komşu masalardan görsel yalıtım sağlar. Restoranın gürültü seviyesi konuşmayı kolaylaştırmalı — çok kalabalık ve gürültülü mekanlar teklif anında ses tonunuzu yükseltmenizi zorunlu kılar, bu romantizmi zedeler. Michelin rehberinde "romantik mekan" etiketi arayın. Masa fotoğrafını görün veya masa planını isteyin.',
  description_en = 'Simply choosing a "romantic" place isn''t enough — also evaluate the technical conditions suitable for a proposal scenario. Prefer a window or alcove table: provides visual privacy from neighboring tables. The restaurant''s noise level should facilitate conversation — very crowded and noisy venues force you to raise your voice during the proposal moment, which undermines the romance. Look for the "romantic venue" tag in the Michelin guide. See a table photo or request a floor plan.',
  pro_tip_tr = 'Rezervasyonda "özel etkinlik için" notunu düşmeyi unutmayın — bu notu gören restoran yönetimi otomatik olarak daha özenli hazırlanır ve yan masa tahsisini size göre düzenleyebilir.',
  pro_tip_en = 'Don''t forget to add the note "for a special occasion" when booking — restaurant management who sees this note automatically prepares more carefully and can arrange neighboring table assignments with you in mind.'
WHERE scenario_id = s_id AND step_number = 1;

UPDATE public.scenario_steps SET
  description_tr = 'Teklif planını restoran müdürüyle telefon veya yüz yüze 5-7 gün önceden paylaşın. Belirleyin: (1) yüzük nasıl sunulacak — tatlı tabağında mı, kadeh içinde mi, özel kutuda garson mu getirecek? (2) Fotoğraf/video çekim için izin var mı? Bir arkadaşı başka masaya yerleştirecek misiniz? (3) Müzisyen varsa özel bir şarkı çalabilirler mi? Müdürü karşı tarafın fotoğrafını gösterin — "bu kişiyi görmezden gelin" ya da "yüzüğü bu kişinin önüne koyun" gibi net yönergeler verin. Plan gizli kalması için müdürden başka kimseye söylememesini isteyin.',
  description_en = 'Share the proposal plan with the restaurant manager by phone or in person 5-7 days in advance. Decide: (1) how the ring will be presented — on the dessert plate, in the glass, or in a special box brought by the waiter? (2) Is photography/video permitted? Will you seat a friend at another table? (3) If there''s a musician, can they play a special song? Show the manager a photo of your partner — give clear instructions like "ignore this person" or "place the ring in front of this person." Ask the manager not to tell anyone else to keep the plan secret.',
  pro_tip_tr = 'Yüzüğü tatlı içine gömmekten kaçının — uzun süre sıcakta kaldığında metal ısınır, nem girer ve tatlı yenirken partneriniz yüzüğü ısırabilir. En güvenli sunum: özel kadife kutu içinde garson tarafından getirilmesi.',
  pro_tip_en = 'Avoid embedding the ring in dessert — metal heats up after extended time in warmth, moisture enters, and your partner might bite the ring while eating. The safest presentation: having the waiter bring it in a special velvet box.'
WHERE scenario_id = s_id AND step_number = 2;

UPDATE public.scenario_steps SET
  description_tr = 'Menüyü özelleştirme fırsatı bazı restoranlarda mevcut — şefe danışın. Minimum: partnerinizin sevdiği 1-2 yemeğin menüde olmasını isteyin. Orta düzey kişiselleştirme: menüyü özel isimle bastırın ("Elif için özel bir akşam"). Maksimum: tamamen özel degüstation menüsü (kişisel anılara referans veren yemek adları). İçecek menüsünü de planlayın: açılış aperitifi, yemek şarapları, teklif anında şampanya. Alkol tüketmiyorsanız özel mocktail isteyebilirsiniz.',
  description_en = 'Menu customization is available at some restaurants — ask the chef. Minimum: request that 1-2 of your partner''s favorite dishes be on the menu. Mid-level customization: have the menu printed with a special name ("A special evening for Elif"). Maximum: a fully custom degustation menu (dishes named with references to personal memories). Also plan the drinks menu: opening aperitif, dinner wines, champagne for the proposal moment. If you don''t drink alcohol, you can request a special mocktail.',
  pro_tip_tr = 'Menünün en altına gizlice küçük bir not ekleyin: "Bu akşam sana sormak istediğim bir soru var..." — Teklif anına kadar yumuşak bir gerilim inşa eder.',
  pro_tip_en = 'Secretly add a small note at the bottom of the menu: "There''s a question I want to ask you tonight..." — This builds gentle tension building up to the proposal moment.'
WHERE scenario_id = s_id AND step_number = 3;

UPDATE public.scenario_steps SET
  description_tr = 'Kıyafet seçimi sadece estetik değil, pratik de önemli. Yüzük kutusunu ceplerinizde tutacaksınız — takım elbisede iç cep ideal. Kadın olarak davet edilirseniz: el çantası yerine küçük bir debriyaj kullanın. Kıyafet uyumunuzu düşünün: "birlikte fotoğraflandığımızda nasıl görünürüz?" sorusunu sorun. Etkinlikten bir gün önce her şeyi (kıyafet, ayakkabı, aksesuar, yüzük kutusu) hazırlayın ve bir de kuru prova yapın — masanın başında nasıl duracaksınız, yüzüğü nasıl çıkaracaksınız?',
  description_en = 'Clothing selection is not just about aesthetics — practicality matters too. You''ll keep the ring box in your pockets — an inner suit pocket is ideal. If invited as a woman: use a small clutch instead of a handbag. Think about outfit coordination: ask "how do we look photographed together?" Prepare everything (outfit, shoes, accessories, ring box) the day before and do a dry run — how will you stand at the table, how will you take out the ring?',
  pro_tip_tr = 'Koku da bir detay — hafif parfüm uygulayın. Araştırmalar, koku ile anıların güçlü biçimde bağlandığını gösteriyor. Partneriniz ileride bu kokuyu duyduğunda o geceye gidecek.',
  pro_tip_en = 'Scent is a detail too — apply a light fragrance. Research shows smell is powerfully linked to memory. Every time your partner smells that scent in the future, they''ll return to that evening.'
WHERE scenario_id = s_id AND step_number = 4;

UPDATE public.scenario_steps SET
  description_tr = 'Söyleyeceğiniz sözleri şablondan değil, kalbinizden oluşturun. 4 unsuru dahil edin: (1) bu kişiyle tanışmanın hayatınızı nasıl değiştirdiği, (2) onun hakkında en çok sevdiğiniz 1-2 özellik (somut, kişisel bir anıya bağlı), (3) birlikte ne yaşamak istediğinize dair bir vizyon, (4) soru. Örnek yapı: "Sen ___ olduğunda hayatım ___ oldu. Seninle ___ ve ___ paylaşabildiğim için çok şanslıyım. Seninle tüm bu anları ve daha fazlasını yaşamak istiyorum — benimle evlenir misin?" Nefes almayı unutmayın, yavaş konuşun.',
  description_en = 'Build your words from your heart, not from a template. Include 4 elements: (1) how meeting this person changed your life, (2) 1-2 things you love most about them (concrete, tied to a personal memory), (3) a vision of what you want to experience together, (4) the question. Example structure: "When you ___, my life became ___. I''m so lucky to have shared ___ and ___ with you. I want to live all these moments and more with you — will you marry me?" Remember to breathe and speak slowly.',
  pro_tip_tr = 'Konuşmanızı yazıp ezberlemeye çalışmayın — bu an için sadece anahtar kelimeleri (3-5 sözcük) belleğinize kazıyın. O sıcak hisle akıp giden sözler, ezberlenmiş konuşmalardan çok daha içtendir.',
  pro_tip_en = 'Don''t try to write and memorize your speech — just etch the key words (3-5 words) into memory for this moment. Words that flow with that warm feeling are far more sincere than memorized speeches.'
WHERE scenario_id = s_id AND step_number = 5;

END IF;

END $$;
