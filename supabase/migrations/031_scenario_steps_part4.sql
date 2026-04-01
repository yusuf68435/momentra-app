-- Migration: scenario_steps_part4
-- Inserts 4-5 steps per scenario for part4 scenarios (~100 scenarios)

-- 1) Kadınlar Günü Kutlaması
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'd87467cb-25d6-444b-a9c2-d3ddcf291eb8', 1, 'Kutlama Planı Oluşturma', 'Create Celebration Plan', 'Kadınlar Günü için özel bir kutlama planı hazırlayın ve davetli listesini belirleyin.', 'Prepare a special celebration plan for Women''s Day and determine the guest list.', false, 7, 0),
(gen_random_uuid(), 'd87467cb-25d6-444b-a9c2-d3ddcf291eb8', 2, 'Hediye ve Çiçek Siparişi', 'Order Gifts and Flowers', 'Kutlamaya katılacak kadınlar için anlamlı hediyeler ve çiçekler sipariş edin.', 'Order meaningful gifts and flowers for the women attending the celebration.', false, 5, 500),
(gen_random_uuid(), 'd87467cb-25d6-444b-a9c2-d3ddcf291eb8', 3, 'Mekan Süslemesi', 'Venue Decoration', 'Kutlama mekanını balonlar, afişler ve çiçeklerle süsleyin.', 'Decorate the venue with balloons, banners, and flowers.', false, 1, 300),
(gen_random_uuid(), 'd87467cb-25d6-444b-a9c2-d3ddcf291eb8', 4, 'Özel Pasta Siparişi', 'Order Special Cake', 'Kadınlar Günü temalı özel bir pasta sipariş edin.', 'Order a special Women''s Day themed cake.', true, 2, 400),
(gen_random_uuid(), 'd87467cb-25d6-444b-a9c2-d3ddcf291eb8', 5, 'Anı Fotoğrafları Çekimi', 'Capture Memory Photos', 'Kutlama sırasında güzel anıları fotoğraflayın ve paylaşın.', 'Photograph and share beautiful moments during the celebration.', true, 0, 0);

-- 2) Dünya Saat Dilimleri Geri Sayımı
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '6658beac-aafd-4250-84f1-9d69b7b0414f', 1, 'Saat Dilimi Araştırması', 'Timezone Research', 'Kutlamak istediğiniz saat dilimlerini belirleyin ve geri sayım takvimi oluşturun.', 'Identify the timezones you want to celebrate and create a countdown calendar.', false, 7, 0),
(gen_random_uuid(), '6658beac-aafd-4250-84f1-9d69b7b0414f', 2, 'Yiyecek ve İçecek Hazırlığı', 'Food and Drink Preparation', 'Her saat dilimi geçişi için farklı ülkelerin atıştırmalıklarını hazırlayın.', 'Prepare snacks from different countries for each timezone transition.', false, 3, 600),
(gen_random_uuid(), '6658beac-aafd-4250-84f1-9d69b7b0414f', 3, 'Dekorasyon ve Ekran Kurulumu', 'Decoration and Screen Setup', 'Dünya haritası ve canlı saat ekranlarıyla mekanı hazırlayın.', 'Set up the venue with a world map and live clock displays.', false, 1, 200),
(gen_random_uuid(), '6658beac-aafd-4250-84f1-9d69b7b0414f', 4, 'Müzik Listesi Hazırlama', 'Prepare Music Playlist', 'Her ülke için yerel müziklerden oluşan bir çalma listesi hazırlayın.', 'Create a playlist of local music for each country.', true, 2, 0),
(gen_random_uuid(), '6658beac-aafd-4250-84f1-9d69b7b0414f', 5, 'Geri Sayım Kutlaması', 'Countdown Celebration', 'Her saat dilimi değişiminde kadeh kaldırarak kutlayın.', 'Celebrate each timezone transition with a toast.', true, 0, 300);

-- 3) Yılbaşı Tombala Gecesi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a8ba8099-1646-477d-80d1-dcf0020b0e5a', 1, 'Tombala Seti ve Ödül Temini', 'Get Tombala Set and Prizes', 'Tombala kartları, taşları ve kazananlara verilecek ödülleri temin edin.', 'Obtain tombala cards, tokens, and prizes for winners.', false, 7, 400),
(gen_random_uuid(), 'a8ba8099-1646-477d-80d1-dcf0020b0e5a', 2, 'Davetli Listesi ve Davetiye', 'Guest List and Invitations', 'Misafir listesini oluşturun ve yılbaşı temalı davetiyeler gönderin.', 'Create the guest list and send New Year''s themed invitations.', false, 5, 100),
(gen_random_uuid(), 'a8ba8099-1646-477d-80d1-dcf0020b0e5a', 3, 'Yılbaşı Süslemeleri', 'New Year Decorations', 'Mekanı yılbaşı ağacı, ışıklar ve süslemelerle donatın.', 'Decorate the venue with a Christmas tree, lights, and ornaments.', false, 1, 500),
(gen_random_uuid(), 'a8ba8099-1646-477d-80d1-dcf0020b0e5a', 4, 'Yiyecek ve İçecek Büfesi', 'Food and Drink Buffet', 'Geleneksel yılbaşı yemekleri ve içeceklerinden oluşan bir büfe hazırlayın.', 'Prepare a buffet of traditional New Year''s foods and drinks.', true, 2, 800),
(gen_random_uuid(), 'a8ba8099-1646-477d-80d1-dcf0020b0e5a', 5, 'Tombala Gecesi Başlasın', 'Let Tombala Night Begin', 'Tombala oyununu başlatın ve ödülleri dağıtarak eğlenceli bir gece geçirin.', 'Start the tombala game and distribute prizes for a fun-filled night.', true, 0, 0);

-- 4) Kaçış Odası Macerası
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a0000013-0001-0001-0001-000000000002', 1, 'Kaçış Odası Araştırması', 'Research Escape Rooms', 'Şehirdeki en iyi kaçış odalarını araştırın ve tema seçin.', 'Research the best escape rooms in the city and choose a theme.', false, 7, 0),
(gen_random_uuid(), 'a0000013-0001-0001-0001-000000000002', 2, 'Rezervasyon Yapma', 'Make Reservation', 'Seçtiğiniz kaçış odası için tarih ve saat belirleyip rezervasyon yapın.', 'Set a date and time and make a reservation for your chosen escape room.', false, 5, 300),
(gen_random_uuid(), 'a0000013-0001-0001-0001-000000000002', 3, 'Takım Oluşturma', 'Form the Team', 'Katılacak arkadaşlarınızı belirleyin ve herkesi bilgilendirin.', 'Determine the friends who will participate and inform everyone.', false, 3, 0),
(gen_random_uuid(), 'a0000013-0001-0001-0001-000000000002', 4, 'Sonrası İçin Plan Yapma', 'Plan Post-Game Activity', 'Kaçış odasından sonra kutlama yemeği veya aktivite planlayın.', 'Plan a celebration dinner or activity after the escape room.', true, 1, 500),
(gen_random_uuid(), 'a0000013-0001-0001-0001-000000000002', 5, 'Macera Anısı Paylaşımı', 'Share Adventure Memories', 'Çektiğiniz fotoğrafları ve videoları grupla paylaşın.', 'Share the photos and videos you took with the group.', true, 0, 0);

-- 5) Rastgele İyilik Günü
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a0000013-0001-0001-0001-000000000001', 1, 'İyilik Fikirleri Listesi', 'Kindness Ideas List', 'Yapılabilecek rastgele iyilik fikirlerinin bir listesini oluşturun.', 'Create a list of random acts of kindness ideas you can do.', false, 5, 0),
(gen_random_uuid(), 'a0000013-0001-0001-0001-000000000001', 2, 'Malzeme Hazırlığı', 'Prepare Materials', 'İyilik kartları, küçük hediyeler ve teşekkür notları hazırlayın.', 'Prepare kindness cards, small gifts, and thank-you notes.', false, 3, 200),
(gen_random_uuid(), 'a0000013-0001-0001-0001-000000000001', 3, 'Güzergah Planlama', 'Plan the Route', 'Gün boyunca ziyaret edeceğiniz yerleri ve yapacağınız iyilikleri planlayın.', 'Plan the places you will visit and the acts of kindness throughout the day.', false, 1, 0),
(gen_random_uuid(), 'a0000013-0001-0001-0001-000000000001', 4, 'İyilikleri Gerçekleştirme', 'Perform Acts of Kindness', 'Planladığınız iyilikleri tek tek gerçekleştirin ve tepkileri gözlemleyin.', 'Carry out your planned acts of kindness one by one and observe the reactions.', true, 0, 300),
(gen_random_uuid(), 'a0000013-0001-0001-0001-000000000001', 5, 'Deneyimi Belgeleme', 'Document the Experience', 'Günün güzel anlarını fotoğraflayın ve sosyal medyada ilham verin.', 'Photograph the beautiful moments of the day and inspire others on social media.', true, 0, 0);

-- 6) Akvaryum Tüneli Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '060dfb14-adab-4b55-8dba-e2fb7ddc7c72', 1, 'Akvaryum ile İletişime Geçme', 'Contact the Aquarium', 'Akvaryum yönetimiyle iletişime geçerek özel etkinlik izni alın.', 'Contact the aquarium management to get permission for a special event.', false, 14, 0),
(gen_random_uuid(), '060dfb14-adab-4b55-8dba-e2fb7ddc7c72', 2, 'Yüzük ve Dekorasyon Hazırlığı', 'Ring and Decoration Prep', 'Evlilik yüzüğünü temin edin ve tünel için dekorasyon malzemelerini hazırlayın.', 'Obtain the engagement ring and prepare decoration materials for the tunnel.', false, 7, 5000),
(gen_random_uuid(), '060dfb14-adab-4b55-8dba-e2fb7ddc7c72', 3, 'Fotoğrafçı Ayarlama', 'Arrange Photographer', 'Anı ölümsüzleştirmek için profesyonel bir fotoğrafçı ayarlayın.', 'Arrange a professional photographer to capture the moment.', false, 5, 2000),
(gen_random_uuid(), '060dfb14-adab-4b55-8dba-e2fb7ddc7c72', 4, 'Tünel Süsleme', 'Decorate the Tunnel', 'Teklif saatinden önce tüneli çiçekler ve mumlarla süsleyin.', 'Decorate the tunnel with flowers and candles before the proposal time.', true, 1, 1500),
(gen_random_uuid(), '060dfb14-adab-4b55-8dba-e2fb7ddc7c72', 5, 'Teklif Anı', 'The Proposal Moment', 'Partnerinizi akvaryum tüneline götürün ve diz çökerek teklif edin.', 'Take your partner to the aquarium tunnel and propose on one knee.', true, 0, 0);

-- 7) Artırılmış Gerçeklik Kart Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '1fa77726-cf14-422f-beeb-b85e4f6eeffc', 1, 'AR Uygulama Araştırması', 'Research AR Apps', 'Artırılmış gerçeklik kartı oluşturabilecek uygulama veya hizmeti araştırın.', 'Research apps or services that can create augmented reality cards.', false, 14, 0),
(gen_random_uuid(), '1fa77726-cf14-422f-beeb-b85e4f6eeffc', 2, 'İçerik Hazırlama', 'Prepare Content', 'Kart tarandığında gösterilecek video mesajı ve görselleri hazırlayın.', 'Prepare the video message and visuals to be shown when the card is scanned.', false, 10, 500),
(gen_random_uuid(), '1fa77726-cf14-422f-beeb-b85e4f6eeffc', 3, 'Kartı Tasarlama ve Bastırma', 'Design and Print Card', 'AR özellikli kartı tasarlayın ve profesyonel olarak bastırın.', 'Design the AR-enabled card and have it professionally printed.', false, 5, 300),
(gen_random_uuid(), '1fa77726-cf14-422f-beeb-b85e4f6eeffc', 4, 'Yüzüğü Kartla Birlikte Paketleme', 'Package Ring with Card', 'Yüzüğü özel bir kutuyla kartın yanına yerleştirin.', 'Place the ring in a special box alongside the card.', true, 1, 5000),
(gen_random_uuid(), '1fa77726-cf14-422f-beeb-b85e4f6eeffc', 5, 'Teklif Sunumu', 'Present the Proposal', 'Kartı partnerinize verin ve AR deneyimiyle teklifi yapın.', 'Give the card to your partner and make the proposal through the AR experience.', true, 0, 0);

-- 8) Sahilde Evlilik Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a0000002-0001-0001-0001-000000000002', 1, 'Sahil Lokasyonu Seçimi', 'Choose Beach Location', 'Romantik ve sakin bir sahil lokasyonu belirleyin.', 'Choose a romantic and quiet beach location.', false, 10, 0),
(gen_random_uuid(), 'a0000002-0001-0001-0001-000000000002', 2, 'Dekorasyon Malzemeleri Temini', 'Get Decoration Supplies', 'Meşaleler, çiçek yaprakları, mumlar ve pankart için malzeme alın.', 'Get supplies for torches, flower petals, candles, and a banner.', false, 5, 800),
(gen_random_uuid(), 'a0000002-0001-0001-0001-000000000002', 3, 'Fotoğrafçı ve Müzisyen Ayarlama', 'Arrange Photographer and Musician', 'Profesyonel fotoğrafçı ve canlı müzik için müzisyen ayarlayın.', 'Arrange a professional photographer and musician for live music.', false, 5, 3000),
(gen_random_uuid(), 'a0000002-0001-0001-0001-000000000002', 4, 'Sahili Hazırlama', 'Prepare the Beach', 'Teklif saatinden önce sahili mumlar ve çiçeklerle süsleyin.', 'Decorate the beach with candles and flowers before the proposal time.', true, 1, 500),
(gen_random_uuid(), 'a0000002-0001-0001-0001-000000000002', 5, 'Gün Batımında Teklif', 'Sunset Proposal', 'Gün batımında sahilde diz çökerek evlilik teklifi edin.', 'Propose on one knee at the beach during sunset.', true, 0, 0);

-- 9) Boğaz'da Havai Fişek Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '32ff4895-99fa-490d-80c2-b0b1cf30730c', 1, 'Tekne ve Havai Fişek Organizasyonu', 'Boat and Fireworks Organization', 'Özel bir tekne kiralayın ve havai fişek gösterisi için izin alın.', 'Rent a private boat and get permission for a fireworks display.', false, 21, 10000),
(gen_random_uuid(), '32ff4895-99fa-490d-80c2-b0b1cf30730c', 2, 'Tekne Dekorasyonu Planlama', 'Plan Boat Decoration', 'Tekneyi çiçekler, mumlar ve romantik ışıklarla süslemek için plan yapın.', 'Plan to decorate the boat with flowers, candles, and romantic lights.', false, 7, 2000),
(gen_random_uuid(), '32ff4895-99fa-490d-80c2-b0b1cf30730c', 3, 'Yemek ve İçecek Organizasyonu', 'Food and Beverage Setup', 'Tekne üzerinde özel bir akşam yemeği menüsü hazırlatın.', 'Have a special dinner menu prepared on the boat.', false, 3, 3000),
(gen_random_uuid(), '32ff4895-99fa-490d-80c2-b0b1cf30730c', 4, 'Video Çekim Ekibi', 'Video Recording Team', 'Havai fişek gösterisini ve teklif anını çekmek için kameraman ayarlayın.', 'Arrange a cameraman to film the fireworks show and the proposal moment.', true, 5, 3000),
(gen_random_uuid(), '32ff4895-99fa-490d-80c2-b0b1cf30730c', 5, 'Boğaz''da Teklif Anı', 'Proposal Moment on the Bosphorus', 'Havai fişekler patlarken Boğaz''ın ortasında evlilik teklifi edin.', 'Propose in the middle of the Bosphorus as fireworks light up the sky.', true, 0, 0);

-- 10) Kapadokya Gün Doğumu Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a1de9ba4-75fa-4800-9fff-23d1e795f632', 1, 'Balon Turu Rezervasyonu', 'Book Balloon Tour', 'Kapadokya''da özel bir sıcak hava balonu turu için rezervasyon yapın.', 'Book a private hot air balloon tour in Cappadocia.', false, 21, 8000),
(gen_random_uuid(), 'a1de9ba4-75fa-4800-9fff-23d1e795f632', 2, 'Konaklama ve Ulaşım', 'Accommodation and Transport', 'Mağara otel rezervasyonu yapın ve ulaşım detaylarını ayarlayın.', 'Book a cave hotel and arrange transportation details.', false, 14, 3000),
(gen_random_uuid(), 'a1de9ba4-75fa-4800-9fff-23d1e795f632', 3, 'Yüzük ve Hediye Hazırlığı', 'Ring and Gift Preparation', 'Evlilik yüzüğünü ve özel bir hediye kutusunu hazırlayın.', 'Prepare the engagement ring and a special gift box.', false, 7, 10000),
(gen_random_uuid(), 'a1de9ba4-75fa-4800-9fff-23d1e795f632', 4, 'Balon Pilotu ile Koordinasyon', 'Coordinate with Balloon Pilot', 'Balon pilotuna teklif planını anlatın ve iniş noktasını ayarlayın.', 'Explain the proposal plan to the balloon pilot and arrange the landing spot.', true, 2, 0),
(gen_random_uuid(), 'a1de9ba4-75fa-4800-9fff-23d1e795f632', 5, 'Gökyüzünde Teklif', 'Proposal in the Sky', 'Gün doğarken balonun tepesinde evlilik teklifi edin.', 'Propose at the top of the balloon as the sun rises.', true, 0, 0);

-- 11) Kedi Bandanası Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a70ec37e-6f90-414f-9366-f63113120ab7', 1, 'Özel Bandana Tasarımı', 'Custom Bandana Design', 'Kediye takılacak özel bir bandana tasarlayın ve "Benimle evlenir misin?" yazdırın.', 'Design a custom bandana for the cat with "Will you marry me?" printed on it.', false, 10, 200),
(gen_random_uuid(), 'a70ec37e-6f90-414f-9366-f63113120ab7', 2, 'Yüzük Taşıma Düzeneği', 'Ring Carrying Setup', 'Bandanaya yüzüğü güvenli şekilde sabitleyecek küçük bir cep dikirin.', 'Sew a small pocket on the bandana to safely hold the ring.', false, 5, 100),
(gen_random_uuid(), 'a70ec37e-6f90-414f-9366-f63113120ab7', 3, 'Kediyi Hazırlama', 'Prepare the Cat', 'Kedinin bandanaya alışması için birkaç gün önceden deneme yapın.', 'Let the cat get used to the bandana by trying it on a few days before.', false, 3, 0),
(gen_random_uuid(), 'a70ec37e-6f90-414f-9366-f63113120ab7', 4, 'Fotoğrafçı Ayarlama', 'Arrange Photographer', 'Teklif anını yakalamak için gizli bir fotoğrafçı ayarlayın.', 'Arrange a hidden photographer to capture the proposal moment.', true, 2, 1500),
(gen_random_uuid(), 'a70ec37e-6f90-414f-9366-f63113120ab7', 5, 'Teklif Anı', 'Proposal Moment', 'Kediyi partnerinize gönderin ve bandanadaki mesajı keşfetmesini izleyin.', 'Send the cat to your partner and watch them discover the message on the bandana.', true, 0, 0);

-- 12) Sinema Fragmanı Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '1cf7f4ac-1a17-4dfa-bf71-d7d93cde81a2', 1, 'Video İçeriği Hazırlama', 'Prepare Video Content', 'İlişkinizin güzel anlarından oluşan bir fragman videosu hazırlayın.', 'Create a trailer video featuring beautiful moments from your relationship.', false, 21, 0),
(gen_random_uuid(), '1cf7f4ac-1a17-4dfa-bf71-d7d93cde81a2', 2, 'Sinema ile Anlaşma', 'Arrange with Cinema', 'Bir sinema salonuyla anlaşarak fragmanınızı film öncesi gösterimde oynatın.', 'Arrange with a cinema to play your trailer before a movie screening.', false, 14, 5000),
(gen_random_uuid(), '1cf7f4ac-1a17-4dfa-bf71-d7d93cde81a2', 3, 'Profesyonel Kurgu', 'Professional Editing', 'Videoyu profesyonel bir editöre teslim edin ve müzik ekletin.', 'Hand the video to a professional editor and have music added.', false, 10, 2000),
(gen_random_uuid(), '1cf7f4ac-1a17-4dfa-bf71-d7d93cde81a2', 4, 'Sinema Bileti Ayarlama', 'Get Cinema Tickets', 'Film gösterimi için biletleri alın ve partnerinizi sinemaya davet edin.', 'Get tickets for the screening and invite your partner to the cinema.', true, 3, 200),
(gen_random_uuid(), '1cf7f4ac-1a17-4dfa-bf71-d7d93cde81a2', 5, 'Perdede Teklif', 'Proposal on Screen', 'Fragman biterken ışıklar açılsın ve sahneye çıkarak teklif edin.', 'As the trailer ends, have the lights come on and propose on stage.', true, 0, 0);

-- 13) Bulmaca Çözdüren Teklif
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '9acca900-54f8-4b8e-8e32-1dcd32fa15f0', 1, 'Bulmaca Tasarımı', 'Design the Crossword', 'İlişkinize özel ipuçlarıyla dolu bir bulmaca tasarlayın.', 'Design a crossword puzzle filled with clues specific to your relationship.', false, 14, 0),
(gen_random_uuid(), '9acca900-54f8-4b8e-8e32-1dcd32fa15f0', 2, 'Profesyonel Baskı', 'Professional Printing', 'Bulmacayı profesyonel kalitede bastırın veya çerçeveletin.', 'Have the crossword printed in professional quality or framed.', false, 7, 300),
(gen_random_uuid(), '9acca900-54f8-4b8e-8e32-1dcd32fa15f0', 3, 'Yüzük Gizleme Planı', 'Ring Hiding Plan', 'Bulmaca çözüldüğünde yüzüğün ortaya çıkacağı bir düzenek hazırlayın.', 'Prepare a mechanism for the ring to appear when the puzzle is solved.', false, 3, 5000),
(gen_random_uuid(), '9acca900-54f8-4b8e-8e32-1dcd32fa15f0', 4, 'Ortam Hazırlığı', 'Set the Scene', 'Bulmacayı çözeceği romantik bir ortam hazırlayın.', 'Create a romantic setting where the puzzle will be solved.', true, 1, 500),
(gen_random_uuid(), '9acca900-54f8-4b8e-8e32-1dcd32fa15f0', 5, 'Bulmaca Teklifi', 'Puzzle Proposal', 'Partnerinizin bulmacayı çözmesini izleyin ve son cevapla teklif yapın.', 'Watch your partner solve the puzzle and propose with the final answer.', true, 0, 0);

-- 14) Kişisel Hikaye Kitabıyla Teklif
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '6e1f50ea-459d-41bc-aa7d-56a735b56576', 1, 'Hikaye Yazımı', 'Write the Story', 'İlişkinizin hikayesini anlatan kısa bir kitap yazın.', 'Write a short book telling the story of your relationship.', false, 30, 0),
(gen_random_uuid(), '6e1f50ea-459d-41bc-aa7d-56a735b56576', 2, 'İllüstrasyon Hazırlama', 'Prepare Illustrations', 'Hikaye için profesyonel illüstrasyonlar yaptırın.', 'Have professional illustrations made for the story.', false, 21, 3000),
(gen_random_uuid(), '6e1f50ea-459d-41bc-aa7d-56a735b56576', 3, 'Kitap Basımı', 'Print the Book', 'Kitabı profesyonel olarak ciltletip bastırın.', 'Have the book professionally bound and printed.', false, 10, 1500),
(gen_random_uuid(), '6e1f50ea-459d-41bc-aa7d-56a735b56576', 4, 'Son Sayfaya Yüzük Yerleştirme', 'Place Ring on Last Page', 'Son sayfaya "Benimle evlenir misin?" yazın ve yüzüğü kitaba gizleyin.', 'Write "Will you marry me?" on the last page and hide the ring in the book.', true, 1, 5000),
(gen_random_uuid(), '6e1f50ea-459d-41bc-aa7d-56a735b56576', 5, 'Kitabı Hediye Etme', 'Gift the Book', 'Kitabı partnerinize hediye edin ve son sayfaya ulaşmasını bekleyin.', 'Gift the book to your partner and wait for them to reach the last page.', true, 0, 0);

-- 15) Yunus Gösterisi Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'b5d8b0a3-c064-418f-bcac-7828378993d3', 1, 'Yunus Parkı ile İletişim', 'Contact Dolphin Park', 'Yunus parkıyla iletişime geçerek özel bir gösteri düzenleyin.', 'Contact the dolphin park to arrange a special show.', false, 21, 5000),
(gen_random_uuid(), 'b5d8b0a3-c064-418f-bcac-7828378993d3', 2, 'Gösteri Senaryosu Planlama', 'Plan Show Scenario', 'Yunus eğitmeniyle teklif anının senaryosunu planlayın.', 'Plan the proposal scenario with the dolphin trainer.', false, 14, 0),
(gen_random_uuid(), 'b5d8b0a3-c064-418f-bcac-7828378993d3', 3, 'Yüzük ve Dekorasyon', 'Ring and Decoration', 'Yüzüğü hazırlayın ve gösteri alanının dekorasyonunu ayarlayın.', 'Prepare the ring and arrange the decoration of the show area.', false, 5, 6000),
(gen_random_uuid(), 'b5d8b0a3-c064-418f-bcac-7828378993d3', 4, 'Kameraman Ayarlama', 'Arrange Cameraman', 'Gösteri sırasında anı çekmek için profesyonel kameraman tutun.', 'Hire a professional cameraman to capture the moment during the show.', true, 3, 2000),
(gen_random_uuid(), 'b5d8b0a3-c064-418f-bcac-7828378993d3', 5, 'Yunuslarla Teklif', 'Propose with Dolphins', 'Yunus gösterisi sırasında sahneye çıkarak teklif edin.', 'Go on stage during the dolphin show and propose.', true, 0, 0);

-- 16) Açık Hava Sineması Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '40704b45-2619-4dbc-a194-08d736b2f99d', 1, 'Açık Hava Sineması Bulma', 'Find Drive-In Cinema', 'Şehrinize yakın bir açık hava sineması bulun veya kiralayın.', 'Find or rent a drive-in cinema near your city.', false, 14, 2000),
(gen_random_uuid(), '40704b45-2619-4dbc-a194-08d736b2f99d', 2, 'Özel Video Hazırlama', 'Prepare Custom Video', 'Film öncesi gösterilecek kişisel bir teklif videosu hazırlayın.', 'Prepare a personal proposal video to be shown before the movie.', false, 10, 1000),
(gen_random_uuid(), '40704b45-2619-4dbc-a194-08d736b2f99d', 3, 'Araç Dekorasyonu', 'Car Decoration', 'Aracınızı çiçekler, ışıklar ve yastıklarla süsleyin.', 'Decorate your car with flowers, lights, and pillows.', false, 1, 500),
(gen_random_uuid(), '40704b45-2619-4dbc-a194-08d736b2f99d', 4, 'Piknik Sepeti Hazırlama', 'Prepare Picnic Basket', 'Özel atıştırmalıklar ve şampanya içeren bir piknik sepeti hazırlayın.', 'Prepare a picnic basket with special snacks and champagne.', true, 1, 600),
(gen_random_uuid(), '40704b45-2619-4dbc-a194-08d736b2f99d', 5, 'Ekranda Teklif', 'On-Screen Proposal', 'Video oynarken partnerinize dönüp evlilik teklifi edin.', 'Turn to your partner while the video plays and propose.', true, 0, 0);

-- 17) Drone Işık Gösterisi Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '352a5844-975a-4e05-a7e3-e80360adf7fd', 1, 'Drone Şirketi ile Anlaşma', 'Contract Drone Company', 'Profesyonel drone ışık gösterisi yapan bir şirketle anlaşın.', 'Contract a professional drone light show company.', false, 30, 20000),
(gen_random_uuid(), '352a5844-975a-4e05-a7e3-e80360adf7fd', 2, 'Gösterim Tasarımı', 'Design the Show', 'Gökyüzüne yazılacak mesaj ve şekillerin tasarımını onaylayın.', 'Approve the design of messages and shapes to be written in the sky.', false, 14, 0),
(gen_random_uuid(), '352a5844-975a-4e05-a7e3-e80360adf7fd', 3, 'Lokasyon ve İzinler', 'Location and Permits', 'Gösteri lokasyonunu belirleyin ve gerekli uçuş izinlerini alın.', 'Determine the show location and obtain necessary flight permits.', false, 10, 500),
(gen_random_uuid(), '352a5844-975a-4e05-a7e3-e80360adf7fd', 4, 'Partnerinizi Lokasyona Götürme', 'Bring Partner to Location', 'Partnerinizi sürpriz bir şekilde gösterim alanına götürün.', 'Bring your partner to the show area as a surprise.', true, 1, 0),
(gen_random_uuid(), '352a5844-975a-4e05-a7e3-e80360adf7fd', 5, 'Gökyüzünde Teklif', 'Proposal in the Sky', 'Drone''lar "Evlenirmisin?" yazarken diz çöküp teklif edin.', 'Kneel and propose as the drones write "Will you marry me?" in the sky.', true, 0, 0);

-- 18) Escape Room'da Evlilik Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '7df6d753-b27d-43bc-83e0-1a7b92cf3cc4', 1, 'Escape Room Seçimi', 'Choose Escape Room', 'Özel etkinliklere açık bir escape room bulun ve teklif planını paylaşın.', 'Find an escape room open to special events and share the proposal plan.', false, 14, 1000),
(gen_random_uuid(), '7df6d753-b27d-43bc-83e0-1a7b92cf3cc4', 2, 'Özel Bulmaca Tasarımı', 'Custom Puzzle Design', 'Son bulmacada yüzüğün ortaya çıkacağı özel bir düzenek tasarlayın.', 'Design a special mechanism for the ring to appear in the final puzzle.', false, 10, 2000),
(gen_random_uuid(), '7df6d753-b27d-43bc-83e0-1a7b92cf3cc4', 3, 'Yüzük Yerleştirme', 'Place the Ring', 'Yüzüğü son bulmacadaki gizli bölmeye yerleştirin.', 'Place the ring in the hidden compartment of the final puzzle.', false, 1, 5000),
(gen_random_uuid(), '7df6d753-b27d-43bc-83e0-1a7b92cf3cc4', 4, 'Fotoğrafçı Gizleme', 'Hide Photographer', 'Odanın kamera sistemini kullanarak veya gizli fotoğrafçı ayarlayarak anı kaydedin.', 'Record the moment using the room''s camera system or a hidden photographer.', true, 1, 1500),
(gen_random_uuid(), '7df6d753-b27d-43bc-83e0-1a7b92cf3cc4', 5, 'Son Bulmacada Teklif', 'Proposal at Final Puzzle', 'Son bulmaca çözüldüğünde yüzük ortaya çıksın ve teklif edin.', 'When the final puzzle is solved, the ring appears and you propose.', true, 0, 0);

-- 19) Sahte TikTok Çekimi Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'ae727b09-69de-40e6-a38c-a0a6ffb49158', 1, 'TikTok Senaryosu Yazma', 'Write TikTok Script', 'Sahte bir TikTok çekim senaryosu yazın ve teklif anını gizleyin.', 'Write a fake TikTok recording script and hide the proposal moment within it.', false, 7, 0),
(gen_random_uuid(), 'ae727b09-69de-40e6-a38c-a0a6ffb49158', 2, 'Çekim Ekipmanı Hazırlama', 'Prepare Recording Equipment', 'Telefon standı, ışık halkası ve mikrofon gibi çekim ekipmanlarını hazırlayın.', 'Prepare recording equipment like phone stand, ring light, and microphone.', false, 3, 300),
(gen_random_uuid(), 'ae727b09-69de-40e6-a38c-a0a6ffb49158', 3, 'Yüzüğü Saklama', 'Hide the Ring', 'Yüzüğü çekim sırasında kolayca ulaşabileceğiniz bir yere saklayın.', 'Hide the ring in a place you can easily reach during the recording.', false, 1, 5000),
(gen_random_uuid(), 'ae727b09-69de-40e6-a38c-a0a6ffb49158', 4, 'Çekim Sırasında Teklif', 'Propose During Recording', 'TikTok çekimi sırasında senaryodan saparak gerçek teklifi yapın.', 'Deviate from the script during the TikTok recording and make the real proposal.', true, 0, 0);

-- 20) Dönme Dolap Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'e5dd0152-f568-44fb-8e55-755b236e4c63', 1, 'Dönme Dolap Rezervasyonu', 'Ferris Wheel Reservation', 'Özel bir kabine sahip dönme dolap için rezervasyon yapın.', 'Make a reservation for a Ferris wheel with a private cabin.', false, 14, 2000),
(gen_random_uuid(), 'e5dd0152-f568-44fb-8e55-755b236e4c63', 2, 'Kabin Dekorasyonu Planlama', 'Plan Cabin Decoration', 'Kabini çiçekler, balonlar ve ışıklarla süsleme planı yapın.', 'Plan to decorate the cabin with flowers, balloons, and lights.', false, 5, 800),
(gen_random_uuid(), 'e5dd0152-f568-44fb-8e55-755b236e4c63', 3, 'Yüzük ve Şampanya Hazırlığı', 'Ring and Champagne Prep', 'Evlilik yüzüğünü ve kutlama şampanyasını hazırlayın.', 'Prepare the engagement ring and celebration champagne.', false, 3, 5500),
(gen_random_uuid(), 'e5dd0152-f568-44fb-8e55-755b236e4c63', 4, 'Fotoğrafçı Koordinasyonu', 'Photographer Coordination', 'Aşağıdan veya drone ile fotoğraf çekimi için fotoğrafçı ayarlayın.', 'Arrange a photographer for photos from below or with a drone.', true, 2, 2000),
(gen_random_uuid(), 'e5dd0152-f568-44fb-8e55-755b236e4c63', 5, 'Tepede Teklif', 'Propose at the Top', 'Dönme dolap en üst noktaya ulaştığında diz çökerek teklif edin.', 'Kneel and propose when the Ferris wheel reaches the highest point.', true, 0, 0);

-- 21) Geocaching Hazine Avı Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'ef800d25-3c0e-4465-96ec-608ed330e823', 1, 'Geocache Rotası Oluşturma', 'Create Geocache Route', 'İlişkinize özel anlamlı noktalardan geçen bir geocache rotası oluşturun.', 'Create a geocache route passing through meaningful locations in your relationship.', false, 14, 0),
(gen_random_uuid(), 'ef800d25-3c0e-4465-96ec-608ed330e823', 2, 'İpuçları ve Kutular Hazırlama', 'Prepare Clues and Boxes', 'Her durağa ipucu ve küçük anı kutuları yerleştirin.', 'Place clues and small memory boxes at each stop.', false, 7, 500),
(gen_random_uuid(), 'ef800d25-3c0e-4465-96ec-608ed330e823', 3, 'Son Noktayı Hazırlama', 'Prepare Final Location', 'Son geocache noktasına yüzüğü ve özel bir mesajı yerleştirin.', 'Place the ring and a special message at the final geocache point.', false, 1, 5000),
(gen_random_uuid(), 'ef800d25-3c0e-4465-96ec-608ed330e823', 4, 'Fotoğrafçı Gizleme', 'Hide Photographer', 'Son noktada gizli bir fotoğrafçı konumlandırın.', 'Position a hidden photographer at the final location.', true, 1, 1500),
(gen_random_uuid(), 'ef800d25-3c0e-4465-96ec-608ed330e823', 5, 'Hazine Avı Teklifi', 'Treasure Hunt Proposal', 'Partneriniz son kutuyu açtığında diz çökerek teklif edin.', 'Kneel and propose when your partner opens the final box.', true, 0, 0);

-- 22) Yıldızlı Tavan Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '054eca69-1d16-4868-90b4-0c1d247d88e0', 1, 'Fosforlu Yıldız Temini', 'Get Glow Stars', 'Fosforlu yıldızlar ve LED ışıklar satın alın.', 'Purchase glow-in-the-dark stars and LED lights.', false, 7, 300),
(gen_random_uuid(), '054eca69-1d16-4868-90b4-0c1d247d88e0', 2, 'Tavan Tasarımı', 'Ceiling Design', 'Tavana yıldız haritası şeklinde fosforlu yıldızları yerleştirin.', 'Place glow stars on the ceiling in the shape of a star map.', false, 3, 0),
(gen_random_uuid(), '054eca69-1d16-4868-90b4-0c1d247d88e0', 3, 'Mesaj Yerleştirme', 'Place Message', 'Yıldızlarla "Evlen Benimle" mesajını tavana yazın.', 'Write "Marry Me" on the ceiling using the stars.', false, 2, 0),
(gen_random_uuid(), '054eca69-1d16-4868-90b4-0c1d247d88e0', 4, 'Romantik Ortam Hazırlama', 'Create Romantic Setting', 'Odayı mumlar, çiçekler ve romantik müzikle donatın.', 'Furnish the room with candles, flowers, and romantic music.', true, 1, 500),
(gen_random_uuid(), '054eca69-1d16-4868-90b4-0c1d247d88e0', 5, 'Karanlıkta Teklif', 'Propose in the Dark', 'Işıkları kapatın ve yıldızlı mesaj ortaya çıktığında teklif edin.', 'Turn off the lights and propose when the starry message appears.', true, 0, 5000);

-- 23) Kütüphane Hazine Avı Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '366233b6-1183-43ea-92ac-54f1243eee4f', 1, 'Kütüphane İzni Alma', 'Get Library Permission', 'Kütüphane yönetimiyle iletişime geçerek özel etkinlik izni alın.', 'Contact the library management to get permission for a special event.', false, 14, 0),
(gen_random_uuid(), '366233b6-1183-43ea-92ac-54f1243eee4f', 2, 'İpuçlarını Kitaplara Gizleme', 'Hide Clues in Books', 'Partnerinizin sevdiği kitaplara ipucu notları yerleştirin.', 'Place clue notes in your partner''s favorite books.', false, 3, 100),
(gen_random_uuid(), '366233b6-1183-43ea-92ac-54f1243eee4f', 3, 'Son İpucunu Hazırlama', 'Prepare Final Clue', 'Son kitapta yüzüğü ve teklif mesajını gizleyin.', 'Hide the ring and proposal message in the final book.', false, 1, 5000),
(gen_random_uuid(), '366233b6-1183-43ea-92ac-54f1243eee4f', 4, 'Kütüphane Atmosferi', 'Library Atmosphere', 'Kütüphane görevlilerine yardım etmeleri için bilgi verin.', 'Inform librarians so they can help guide the experience.', true, 1, 200),
(gen_random_uuid(), '366233b6-1183-43ea-92ac-54f1243eee4f', 5, 'Kitaplar Arasında Teklif', 'Proposal Among Books', 'Son ipucu çözüldüğünde kitaplar arasında diz çökerek teklif edin.', 'Kneel and propose among the books when the final clue is solved.', true, 0, 0);

-- 24) Sihirbaz Gösterisi Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '7a04c7bb-04a5-4817-b176-acf62e024e05', 1, 'Sihirbaz Bulma', 'Find a Magician', 'Profesyonel bir sahne sihirbazı bulun ve teklif senaryosunu planlayın.', 'Find a professional stage magician and plan the proposal scenario.', false, 21, 3000),
(gen_random_uuid(), '7a04c7bb-04a5-4817-b176-acf62e024e05', 2, 'Gösteri Senaryosu Hazırlama', 'Prepare Show Scenario', 'Sihirbazla birlikte yüzüğün büyüyle ortaya çıkacağı senaryoyu hazırlayın.', 'Prepare the scenario with the magician where the ring appears through magic.', false, 14, 0),
(gen_random_uuid(), '7a04c7bb-04a5-4817-b176-acf62e024e05', 3, 'Mekan Ayarlama', 'Arrange Venue', 'Gösterinin yapılacağı mekanı ayarlayın ve davetlileri bilgilendirin.', 'Arrange the venue for the show and inform guests.', false, 7, 2000),
(gen_random_uuid(), '7a04c7bb-04a5-4817-b176-acf62e024e05', 4, 'Prova Yapma', 'Rehearsal', 'Sihirbazla son bir prova yaparak teklif anının pürüzsüz geçmesini sağlayın.', 'Do a final rehearsal with the magician to ensure the proposal goes smoothly.', true, 2, 0),
(gen_random_uuid(), '7a04c7bb-04a5-4817-b176-acf62e024e05', 5, 'Büyülü Teklif', 'Magical Proposal', 'Gösteri sırasında sihirbaz yüzüğü ortaya çıkarsın ve teklif edin.', 'During the show, the magician reveals the ring and you propose.', true, 0, 0);

-- 25) Anı Galerisi Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'd2c21a56-917a-4770-a08f-0711776c4e64', 1, 'Fotoğraf Seçimi ve Baskı', 'Photo Selection and Printing', 'İlişkinizin en güzel fotoğraflarını seçin ve büyük boyutta bastırın.', 'Select the most beautiful photos of your relationship and print them in large format.', false, 14, 1500),
(gen_random_uuid(), 'd2c21a56-917a-4770-a08f-0711776c4e64', 2, 'Galeri Mekanı Ayarlama', 'Set Up Gallery Venue', 'Fotoğrafları sergileyeceğiniz bir mekan bulun ve çerçevelerle asın.', 'Find a venue to display the photos and hang them with frames.', false, 5, 2000),
(gen_random_uuid(), 'd2c21a56-917a-4770-a08f-0711776c4e64', 3, 'Işıklandırma ve Müzik', 'Lighting and Music', 'Galeriyi profesyonel ışıklandırma ve arka plan müziğiyle donatın.', 'Equip the gallery with professional lighting and background music.', false, 2, 1000),
(gen_random_uuid(), 'd2c21a56-917a-4770-a08f-0711776c4e64', 4, 'Son Tablo: Teklif Mesajı', 'Final Frame: Proposal Message', 'Son tabloya "Benimle evlenir misin?" yazılı bir çerçeve asın.', 'Hang a frame with "Will you marry me?" as the last display.', true, 1, 300),
(gen_random_uuid(), 'd2c21a56-917a-4770-a08f-0711776c4e64', 5, 'Galeri Turu ve Teklif', 'Gallery Tour and Proposal', 'Partnerinizi galeriye götürün ve son tabloda diz çökerek teklif edin.', 'Take your partner to the gallery and kneel to propose at the final display.', true, 0, 5000);

-- 26) Şişede Mesaj Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a36ed3ad-4cf0-449b-9e52-76c26fb4ad59', 1, 'Özel Şişe Hazırlama', 'Prepare Special Bottle', 'Dekoratif bir cam şişe satın alın ve içine teklif mektubu yazın.', 'Buy a decorative glass bottle and write a proposal letter for inside.', false, 10, 200),
(gen_random_uuid(), 'a36ed3ad-4cf0-449b-9e52-76c26fb4ad59', 2, 'Mektup Yazma', 'Write the Letter', 'Duygusal ve anlamlı bir teklif mektubu kaleme alın.', 'Write an emotional and meaningful proposal letter.', false, 7, 0),
(gen_random_uuid(), 'a36ed3ad-4cf0-449b-9e52-76c26fb4ad59', 3, 'Şişeyi Gizleme', 'Hide the Bottle', 'Şişeyi sahilde veya özel bir yere gömün ve harita hazırlayın.', 'Bury the bottle at the beach or a special place and prepare a map.', false, 1, 100),
(gen_random_uuid(), 'a36ed3ad-4cf0-449b-9e52-76c26fb4ad59', 4, 'Hazine Avına Çıkma', 'Go on Treasure Hunt', 'Partnerinizi haritayla şişenin gizlendiği yere yönlendirin.', 'Guide your partner to the hidden bottle location using the map.', true, 0, 0),
(gen_random_uuid(), 'a36ed3ad-4cf0-449b-9e52-76c26fb4ad59', 5, 'Şişeyi Açma ve Teklif', 'Open Bottle and Propose', 'Partneriniz şişeyi açıp mektubu okurken diz çökerek teklif edin.', 'Kneel and propose as your partner opens the bottle and reads the letter.', true, 0, 5000);

-- 27) Meteor Yağmuru Altında Teklif
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'e061d5c5-edcc-48ba-a66e-35a237ff824f', 1, 'Meteor Yağmuru Takvimi Araştırma', 'Research Meteor Shower Calendar', 'Yaklaşan meteor yağmurlarının tarihlerini araştırın ve en uygununu seçin.', 'Research upcoming meteor shower dates and choose the best one.', false, 30, 0),
(gen_random_uuid(), 'e061d5c5-edcc-48ba-a66e-35a237ff824f', 2, 'Gözlem Noktası Seçimi', 'Choose Observation Point', 'Işık kirliliğinden uzak, karanlık ve güvenli bir gözlem noktası belirleyin.', 'Identify a dark and safe observation point away from light pollution.', false, 14, 0),
(gen_random_uuid(), 'e061d5c5-edcc-48ba-a66e-35a237ff824f', 3, 'Ekipman Hazırlığı', 'Equipment Preparation', 'Battaniye, termos, sıcak içecek ve teleskop hazırlayın.', 'Prepare blankets, thermos, hot drinks, and a telescope.', false, 3, 500),
(gen_random_uuid(), 'e061d5c5-edcc-48ba-a66e-35a237ff824f', 4, 'Romantik Ortam Oluşturma', 'Create Romantic Setting', 'Gözlem noktasına mumlar ve çiçeklerle romantik bir ortam kurun.', 'Set up a romantic atmosphere at the observation point with candles and flowers.', true, 1, 400),
(gen_random_uuid(), 'e061d5c5-edcc-48ba-a66e-35a237ff824f', 5, 'Yıldızlar Altında Teklif', 'Propose Under the Stars', 'Meteor yağmuru başladığında diz çökerek evlilik teklifi edin.', 'Kneel and propose when the meteor shower begins.', true, 0, 5000);

-- 28) Minecraft Dünyasında Evlilik Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'ab13c496-31b2-432e-8880-2953795aaf85', 1, 'Minecraft Dünyası Oluşturma', 'Create Minecraft World', 'Özel bir Minecraft dünyası oluşturun ve teklif alanını inşa etmeye başlayın.', 'Create a special Minecraft world and start building the proposal area.', false, 14, 0),
(gen_random_uuid(), 'ab13c496-31b2-432e-8880-2953795aaf85', 2, 'Teklif Yapısını İnşa Etme', 'Build Proposal Structure', 'Oyun içinde çiçekler, ışıklar ve "Evlen Benimle" yazısı olan bir yapı inşa edin.', 'Build a structure in-game with flowers, lights, and a "Marry Me" sign.', false, 7, 0),
(gen_random_uuid(), 'ab13c496-31b2-432e-8880-2953795aaf85', 3, 'Macera Haritası Hazırlama', 'Prepare Adventure Map', 'Partnerinizi teklif noktasına yönlendirecek ipuçlarıyla dolu bir macera haritası yapın.', 'Create an adventure map filled with clues that lead your partner to the proposal spot.', false, 3, 0),
(gen_random_uuid(), 'ab13c496-31b2-432e-8880-2953795aaf85', 4, 'Gerçek Yüzüğü Hazırlama', 'Prepare Real Ring', 'Oyun içi teklifle eş zamanlı olarak gerçek yüzüğü yanınızda hazır bulundurun.', 'Have the real ring ready alongside the in-game proposal.', true, 1, 5000),
(gen_random_uuid(), 'ab13c496-31b2-432e-8880-2953795aaf85', 5, 'Sanal ve Gerçek Teklif', 'Virtual and Real Proposal', 'Oyunda teklif anında ekranı kapatıp gerçek hayatta da teklif edin.', 'At the in-game proposal moment, close the screen and propose in real life too.', true, 0, 0);

-- 29) Film Sahnesi Canlandırma Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'ef943877-c08f-4b82-8602-aa41b2865128', 1, 'Film Seçimi', 'Choose the Movie', 'Partnerinizin en sevdiği romantik film sahnesini belirleyin.', 'Identify your partner''s favorite romantic movie scene.', false, 14, 0),
(gen_random_uuid(), 'ef943877-c08f-4b82-8602-aa41b2865128', 2, 'Sahne Detaylarını Planlama', 'Plan Scene Details', 'Kostümler, mekan ve diyaloglar dahil sahne detaylarını planlayın.', 'Plan scene details including costumes, venue, and dialogues.', false, 10, 1500),
(gen_random_uuid(), 'ef943877-c08f-4b82-8602-aa41b2865128', 3, 'Mekan ve Kostüm Hazırlığı', 'Venue and Costume Prep', 'Mekanı film sahnesine uygun şekilde süsleyin ve kostümleri hazırlayın.', 'Decorate the venue to match the movie scene and prepare costumes.', false, 3, 2000),
(gen_random_uuid(), 'ef943877-c08f-4b82-8602-aa41b2865128', 4, 'Kameraman Ayarlama', 'Arrange Cameraman', 'Canlandırma sahnesini kaydetmek için kameraman tutun.', 'Hire a cameraman to record the recreation scene.', true, 2, 2000),
(gen_random_uuid(), 'ef943877-c08f-4b82-8602-aa41b2865128', 5, 'Sahne Canlandırma ve Teklif', 'Scene Recreation and Proposal', 'Film sahnesini canlandırırken senaryodan saparak gerçek teklifi yapın.', 'While recreating the movie scene, deviate from the script and make the real proposal.', true, 0, 5000);

-- 30) Kuzey Işıkları Altında Teklif
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '37532423-06a6-475e-a357-1f62004ec5f0', 1, 'Seyahat Planlaması', 'Travel Planning', 'Kuzey ışıklarını görebileceğiniz bir destinasyon araştırın ve uçak bileti alın.', 'Research a destination where you can see the northern lights and book flights.', false, 60, 15000),
(gen_random_uuid(), '37532423-06a6-475e-a357-1f62004ec5f0', 2, 'Konaklama Rezervasyonu', 'Book Accommodation', 'Cam tavan veya igloo otel gibi kuzey ışıklarını göreceğiniz bir konaklama ayarlayın.', 'Book accommodation like a glass-roof igloo hotel where you can see the northern lights.', false, 30, 10000),
(gen_random_uuid(), '37532423-06a6-475e-a357-1f62004ec5f0', 3, 'Yüzük ve Hediye Hazırlığı', 'Ring and Gift Preparation', 'Evlilik yüzüğünü ve özel bir hediye paketini hazırlayın.', 'Prepare the engagement ring and a special gift package.', false, 14, 10000),
(gen_random_uuid(), '37532423-06a6-475e-a357-1f62004ec5f0', 4, 'Kuzey Işıkları Turuna Katılma', 'Join Northern Lights Tour', 'Profesyonel bir kuzey ışıkları turuna katılın.', 'Join a professional northern lights tour.', true, 1, 3000),
(gen_random_uuid(), '37532423-06a6-475e-a357-1f62004ec5f0', 5, 'Aurora Altında Teklif', 'Propose Under the Aurora', 'Kuzey ışıkları gökyüzünü aydınlatırken diz çökerek teklif edin.', 'Kneel and propose as the northern lights illuminate the sky.', true, 0, 0);

-- 31) Paris Sokak Ressamı Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '79c3fb86-5c25-42cc-848b-2a7928cab12f', 1, 'Paris Seyahati Planlama', 'Plan Paris Trip', 'Paris''e seyahat planı yapın ve uçak bileti ile otel ayarlayın.', 'Plan a trip to Paris and arrange flight tickets and hotel.', false, 30, 15000),
(gen_random_uuid(), '79c3fb86-5c25-42cc-848b-2a7928cab12f', 2, 'Sokak Ressamı ile Anlaşma', 'Arrange with Street Artist', 'Montmartre''daki bir sokak ressamıyla önceden anlaşarak teklif sahnesini çizmesini isteyin.', 'Pre-arrange with a street artist in Montmartre to draw the proposal scene.', false, 14, 2000),
(gen_random_uuid(), '79c3fb86-5c25-42cc-848b-2a7928cab12f', 3, 'Teklif Anı Planlaması', 'Plan Proposal Moment', 'Ressamın teklif sahnesini tamamlayacağı anı ve işareti planlayın.', 'Plan the moment and signal when the artist will complete the proposal scene.', false, 3, 0),
(gen_random_uuid(), '79c3fb86-5c25-42cc-848b-2a7928cab12f', 4, 'Fotoğrafçı Ayarlama', 'Arrange Photographer', 'Gizli bir fotoğrafçı ayarlayarak anı ölümsüzleştirin.', 'Arrange a hidden photographer to immortalize the moment.', true, 3, 3000),
(gen_random_uuid(), '79c3fb86-5c25-42cc-848b-2a7928cab12f', 5, 'Resimle Teklif', 'Propose with the Painting', 'Ressam tabloyu gösterdiğinde diz çökerek teklif edin.', 'Kneel and propose when the artist reveals the painting.', true, 0, 5000);

-- 32) Köpek Yüzük Taşıyıcısı Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '17ff561b-e724-4ff5-aa53-d2adbafb691f', 1, 'Yüzük Taşıma Aksesuarı', 'Ring Carrying Accessory', 'Köpeğin tasmasına takılacak özel bir yüzük taşıma aksesuarı yaptırın.', 'Have a special ring-carrying accessory made for the dog''s collar.', false, 10, 300),
(gen_random_uuid(), '17ff561b-e724-4ff5-aa53-d2adbafb691f', 2, 'Köpeği Eğitme', 'Train the Dog', 'Köpeğin komutla partnerinize gitmesi için birkaç gün eğitin.', 'Train the dog for a few days to go to your partner on command.', false, 7, 0),
(gen_random_uuid(), '17ff561b-e724-4ff5-aa53-d2adbafb691f', 3, 'Yüzüğü Hazırlama', 'Prepare the Ring', 'Yüzüğü köpeğin tasma aksesuarına güvenli şekilde yerleştirin.', 'Securely place the ring on the dog''s collar accessory.', false, 1, 5000),
(gen_random_uuid(), '17ff561b-e724-4ff5-aa53-d2adbafb691f', 4, 'Ortam Hazırlığı', 'Set the Scene', 'Teklif yapacağınız mekanı romantik şekilde hazırlayın.', 'Prepare the proposal venue in a romantic way.', true, 1, 500),
(gen_random_uuid(), '17ff561b-e724-4ff5-aa53-d2adbafb691f', 5, 'Köpekli Teklif', 'Proposal with the Dog', 'Köpeği partnerinize gönderin ve yüzüğü keşfetmesini izleyin.', 'Send the dog to your partner and watch them discover the ring.', true, 0, 0);

-- 33) Planetaryumda Yıldızlar Altında Teklif
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '3f7bcae7-2e3c-46b2-b136-550623125d0d', 1, 'Planetaryum ile İletişim', 'Contact Planetarium', 'Planetaryum yönetimiyle özel gösterim için iletişime geçin.', 'Contact the planetarium management for a private screening.', false, 21, 3000),
(gen_random_uuid(), '3f7bcae7-2e3c-46b2-b136-550623125d0d', 2, 'Özel Gösteri İçeriği', 'Custom Show Content', 'Gösterim sonunda teklif mesajınızın yıldızlarla yazılmasını isteyin.', 'Request your proposal message to be written with stars at the end of the show.', false, 14, 2000),
(gen_random_uuid(), '3f7bcae7-2e3c-46b2-b136-550623125d0d', 3, 'Mekan Hazırlığı', 'Venue Preparation', 'Planetaryum koltuklarına çiçek ve mum yerleştirin.', 'Place flowers and candles on the planetarium seats.', false, 1, 500),
(gen_random_uuid(), '3f7bcae7-2e3c-46b2-b136-550623125d0d', 4, 'Fotoğrafçı ve Video', 'Photographer and Video', 'Karanlıkta çekim yapabilen bir fotoğrafçı ayarlayın.', 'Arrange a photographer capable of shooting in the dark.', true, 3, 2000),
(gen_random_uuid(), '3f7bcae7-2e3c-46b2-b136-550623125d0d', 5, 'Yıldızlı Teklif', 'Starry Proposal', 'Yıldızlar altında teklif mesajı belirlediğinde diz çökerek teklif edin.', 'Kneel and propose when the proposal message appears under the stars.', true, 0, 5000);

-- 34) Seramik Atölyesinde Teklif
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a1ac3689-c399-42ba-bc2b-7fe0855e2a27', 1, 'Seramik Atölyesi Rezervasyonu', 'Book Pottery Class', 'Özel çift seramik atölyesi için rezervasyon yapın.', 'Book a private couples pottery class.', false, 14, 1000),
(gen_random_uuid(), 'a1ac3689-c399-42ba-bc2b-7fe0855e2a27', 2, 'Atölye Sahibiyle Koordinasyon', 'Coordinate with Workshop Owner', 'Atölye sahibiyle teklif planını paylaşın ve destek isteyin.', 'Share the proposal plan with the workshop owner and ask for support.', false, 7, 0),
(gen_random_uuid(), 'a1ac3689-c399-42ba-bc2b-7fe0855e2a27', 3, 'Yüzük Gizleme Planı', 'Ring Hiding Plan', 'Yüzüğü seramik kilin içine veya önceden yapılmış bir kaseye gizleyin.', 'Hide the ring inside the ceramic clay or in a pre-made bowl.', false, 1, 5000),
(gen_random_uuid(), 'a1ac3689-c399-42ba-bc2b-7fe0855e2a27', 4, 'Seramik Yapım Anı', 'Pottery Making Moment', 'Birlikte seramik yaparken romantik bir anın tadını çıkarın.', 'Enjoy a romantic moment while making pottery together.', true, 0, 0),
(gen_random_uuid(), 'a1ac3689-c399-42ba-bc2b-7fe0855e2a27', 5, 'Seramik İçinden Teklif', 'Propose from the Pottery', 'Seramik açıldığında yüzük ortaya çıksın ve teklif edin.', 'When the pottery is opened, the ring appears and you propose.', true, 0, 0);

-- 35) Yapboz Mesajı Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '4e1103a7-74ec-4e72-82f1-c87c55e8ac1d', 1, 'Özel Yapboz Tasarımı', 'Design Custom Puzzle', 'İlişkinize ait bir fotoğraftan özel yapboz yaptırın ve teklif mesajını ekletin.', 'Have a custom puzzle made from a photo of your relationship with the proposal message.', false, 14, 500),
(gen_random_uuid(), '4e1103a7-74ec-4e72-82f1-c87c55e8ac1d', 2, 'Yapboz Siparişi', 'Order Puzzle', 'Yapbozu profesyonel bir firmaya sipariş verin ve kalitesini kontrol edin.', 'Order the puzzle from a professional company and check the quality.', false, 10, 300),
(gen_random_uuid(), '4e1103a7-74ec-4e72-82f1-c87c55e8ac1d', 3, 'Ortam Hazırlığı', 'Prepare the Setting', 'Yapbozu birlikte yapacağınız rahat ve romantik bir ortam hazırlayın.', 'Prepare a comfortable and romantic setting where you will assemble the puzzle together.', false, 1, 200),
(gen_random_uuid(), '4e1103a7-74ec-4e72-82f1-c87c55e8ac1d', 4, 'Birlikte Yapboz Yapma', 'Assemble Puzzle Together', 'Partnerinizle birlikte yapbozu yapmaya başlayın ve son parçaları ona bırakın.', 'Start assembling the puzzle with your partner and leave the final pieces for them.', true, 0, 0),
(gen_random_uuid(), '4e1103a7-74ec-4e72-82f1-c87c55e8ac1d', 5, 'Yapboz Teklifi', 'Puzzle Proposal', 'Son parça yerleştirildiğinde teklif mesajı ortaya çıksın ve diz çökün.', 'When the last piece is placed, the proposal message appears and you kneel.', true, 0, 5000);

-- 36) Restoranda Evlilik Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a0000002-0001-0001-0001-000000000004', 1, 'Restoran Seçimi ve Rezervasyon', 'Choose Restaurant and Reserve', 'Romantik bir restoran seçin ve özel bir masa için rezervasyon yapın.', 'Choose a romantic restaurant and make a reservation for a special table.', false, 14, 0),
(gen_random_uuid(), 'a0000002-0001-0001-0001-000000000004', 2, 'Şefle Koordinasyon', 'Coordinate with Chef', 'Şefle iletişime geçerek yüzüğün tatlıda sunulmasını ayarlayın.', 'Contact the chef to arrange the ring to be presented with dessert.', false, 7, 500),
(gen_random_uuid(), 'a0000002-0001-0001-0001-000000000004', 3, 'Çiçek ve Dekorasyon', 'Flowers and Decoration', 'Masaya özel çiçek aranjmanı ve mum hazırlatın.', 'Have a special flower arrangement and candles prepared for the table.', false, 3, 800),
(gen_random_uuid(), 'a0000002-0001-0001-0001-000000000004', 4, 'Canlı Müzik Ayarlama', 'Arrange Live Music', 'Özel anınız için bir müzisyen veya küçük orkestra ayarlayın.', 'Arrange a musician or small ensemble for your special moment.', true, 5, 2000),
(gen_random_uuid(), 'a0000002-0001-0001-0001-000000000004', 5, 'Tatlıda Teklif', 'Dessert Proposal', 'Tatlı geldiğinde yüzük ortaya çıksın ve diz çökerek teklif edin.', 'When dessert arrives, the ring appears and you kneel to propose.', true, 0, 5000);

-- 37) Çatı Katı Akşam Yemeği Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '26018006-b4e2-4e90-9bdb-96a16b169fd6', 1, 'Çatı Katı Mekanı Ayarlama', 'Arrange Rooftop Venue', 'Şehir manzaralı bir çatı katı mekanı bulun ve kiralayın.', 'Find and rent a rooftop venue with a city view.', false, 14, 3000),
(gen_random_uuid(), '26018006-b4e2-4e90-9bdb-96a16b169fd6', 2, 'Yemek Menüsü Planlama', 'Plan Dinner Menu', 'Özel bir akşam yemeği menüsü hazırlatın veya şef tutun.', 'Have a special dinner menu prepared or hire a chef.', false, 7, 2000),
(gen_random_uuid(), '26018006-b4e2-4e90-9bdb-96a16b169fd6', 3, 'Dekorasyon Hazırlığı', 'Decoration Setup', 'Çatı katını mumlar, çiçekler, ışık zincirleri ve balonlarla süsleyin.', 'Decorate the rooftop with candles, flowers, string lights, and balloons.', false, 1, 1500),
(gen_random_uuid(), '26018006-b4e2-4e90-9bdb-96a16b169fd6', 4, 'Canlı Müzik', 'Live Music', 'Romantik canlı müzik için müzisyen ayarlayın.', 'Arrange a musician for romantic live music.', true, 3, 2000),
(gen_random_uuid(), '26018006-b4e2-4e90-9bdb-96a16b169fd6', 5, 'Şehir Işıklarında Teklif', 'Propose Under City Lights', 'Yemekten sonra şehir manzarası eşliğinde diz çökerek teklif edin.', 'After dinner, kneel and propose with the city skyline as a backdrop.', true, 0, 5000);

-- 38) Gizli Bahçe Çiçek Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'c0f494fe-05d9-42f6-9430-b90cba8310f9', 1, 'Gizli Bahçe Lokasyonu Bulma', 'Find Secret Garden Location', 'Şehirde veya kırsal alanda saklı, romantik bir bahçe mekanı bulun.', 'Find a hidden, romantic garden venue in the city or countryside.', false, 14, 1000),
(gen_random_uuid(), 'c0f494fe-05d9-42f6-9430-b90cba8310f9', 2, 'Çiçek Düzenlemesi', 'Flower Arrangement', 'Bahçeyi yüzlerce taze çiçekle süsletin ve patika oluşturun.', 'Decorate the garden with hundreds of fresh flowers and create a path.', false, 1, 3000),
(gen_random_uuid(), 'c0f494fe-05d9-42f6-9430-b90cba8310f9', 3, 'Mum ve Işık Düzenlemesi', 'Candle and Light Setup', 'Bahçe yollarını mumlar ve peri ışıklarıyla aydınlatın.', 'Light up the garden paths with candles and fairy lights.', false, 1, 800),
(gen_random_uuid(), 'c0f494fe-05d9-42f6-9430-b90cba8310f9', 4, 'Fotoğrafçı Gizleme', 'Hide Photographer', 'Bahçede gizlenmiş bir fotoğrafçı konumlandırın.', 'Position a hidden photographer in the garden.', true, 1, 2000),
(gen_random_uuid(), 'c0f494fe-05d9-42f6-9430-b90cba8310f9', 5, 'Çiçekler Arasında Teklif', 'Propose Among Flowers', 'Partnerinizi çiçek patikasından yürüterek son noktada teklif edin.', 'Walk your partner down the flower path and propose at the end.', true, 0, 5000);

-- 39) Gökyüzüne Yazı Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '07bf25b4-8263-4624-bbbe-bca389e96d7d', 1, 'Skywriting Şirketi Bulma', 'Find Skywriting Company', 'Gökyüzüne yazı yazan bir havacılık şirketi bulun ve iletişime geçin.', 'Find an aviation company that does skywriting and contact them.', false, 30, 15000),
(gen_random_uuid(), '07bf25b4-8263-4624-bbbe-bca389e96d7d', 2, 'Mesaj ve Tarih Belirleme', 'Set Message and Date', 'Gökyüzüne yazılacak mesajı ve hava durumuna uygun tarihi belirleyin.', 'Determine the message for the sky and a date suitable for the weather.', false, 14, 0),
(gen_random_uuid(), '07bf25b4-8263-4624-bbbe-bca389e96d7d', 3, 'İzleme Noktası Seçimi', 'Choose Viewing Point', 'Gökyüzü yazısını en iyi görebileceğiniz bir piknik noktası seçin.', 'Choose a picnic spot with the best view of the skywriting.', false, 3, 0),
(gen_random_uuid(), '07bf25b4-8263-4624-bbbe-bca389e96d7d', 4, 'Piknik Hazırlığı', 'Picnic Preparation', 'İzleme noktasında romantik bir piknik hazırlayın.', 'Set up a romantic picnic at the viewing point.', true, 1, 500),
(gen_random_uuid(), '07bf25b4-8263-4624-bbbe-bca389e96d7d', 5, 'Gökyüzü Teklifi', 'Sky Proposal', 'Gökyüzünde mesaj belirdiğinde partnerinize dönüp teklif edin.', 'Turn to your partner and propose when the message appears in the sky.', true, 0, 5000);

-- 40) Stadyum Dev Ekran Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '6fa5d0a2-ec47-4887-907b-a0ac57772002', 1, 'Stadyum Yönetimi ile İletişim', 'Contact Stadium Management', 'Stadyum yönetimiyle iletişime geçerek dev ekran teklifi için izin alın.', 'Contact stadium management to get permission for a jumbotron proposal.', false, 30, 5000),
(gen_random_uuid(), '6fa5d0a2-ec47-4887-907b-a0ac57772002', 2, 'Mesaj ve Görsel Hazırlama', 'Prepare Message and Visuals', 'Dev ekranda gösterilecek mesajı ve görselleri hazırlayın.', 'Prepare the message and visuals to be displayed on the jumbotron.', false, 14, 1000),
(gen_random_uuid(), '6fa5d0a2-ec47-4887-907b-a0ac57772002', 3, 'Maç Bileti Alma', 'Get Match Tickets', 'Partnerinizle birlikte maça gitmek için bilet alın.', 'Get tickets to attend the match with your partner.', false, 7, 500),
(gen_random_uuid(), '6fa5d0a2-ec47-4887-907b-a0ac57772002', 4, 'Kamera Ekibi Koordinasyonu', 'Camera Crew Coordination', 'Stadyum kamera ekibiyle teklif anının çekilmesini koordine edin.', 'Coordinate with the stadium camera crew to capture the proposal moment.', true, 3, 0),
(gen_random_uuid(), '6fa5d0a2-ec47-4887-907b-a0ac57772002', 5, 'Dev Ekranda Teklif', 'Jumbotron Proposal', 'Devre arasında dev ekranda mesaj belirdiğinde diz çökerek teklif edin.', 'Kneel and propose when the message appears on the jumbotron during halftime.', true, 0, 5000);

-- 41) Geri Sayım Kutuları Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'aedb552e-ae09-4789-8091-6db686368e7f', 1, 'Kutu Tasarımı ve Temini', 'Design and Get Boxes', 'Geri sayım kutuları için özel tasarım yaptırın ve kutuları temin edin.', 'Have custom designs made for countdown boxes and obtain them.', false, 30, 1000),
(gen_random_uuid(), 'aedb552e-ae09-4789-8091-6db686368e7f', 2, 'İçerik Hazırlama', 'Prepare Contents', 'Her kutuya anlamlı hediyeler, notlar ve anılar yerleştirin.', 'Place meaningful gifts, notes, and memories in each box.', false, 14, 2000),
(gen_random_uuid(), 'aedb552e-ae09-4789-8091-6db686368e7f', 3, 'Teslimat Planı', 'Delivery Plan', 'Kutuların her gün partnerinize ulaşacağı teslimat planını oluşturun.', 'Create a delivery plan for the boxes to reach your partner each day.', false, 7, 500),
(gen_random_uuid(), 'aedb552e-ae09-4789-8091-6db686368e7f', 4, 'Son Kutuya Yüzük Yerleştirme', 'Place Ring in Final Box', 'Son kutunun içine yüzüğü ve teklif mektubunu yerleştirin.', 'Place the ring and proposal letter in the final box.', true, 1, 5000),
(gen_random_uuid(), 'aedb552e-ae09-4789-8091-6db686368e7f', 5, 'Son Kutu ve Teklif', 'Final Box and Proposal', 'Son kutu açıldığında yanında olun ve diz çökerek teklif edin.', 'Be present when the final box is opened and kneel to propose.', true, 0, 0);

-- 42) Dağ Zirvesinde Gün Doğumu Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '6cd06995-bc8f-46eb-a3cf-7f5ffeba8fa6', 1, 'Dağ ve Rota Seçimi', 'Choose Mountain and Route', 'Gün doğumunu izleyebileceğiniz güvenli bir dağ ve tırmanış rotası seçin.', 'Choose a safe mountain and hiking route where you can watch the sunrise.', false, 14, 0),
(gen_random_uuid(), '6cd06995-bc8f-46eb-a3cf-7f5ffeba8fa6', 2, 'Ekipman Hazırlığı', 'Equipment Preparation', 'Tırmanış ekipmanı, battaniye ve termos hazırlayın.', 'Prepare hiking equipment, blankets, and a thermos.', false, 5, 500),
(gen_random_uuid(), '6cd06995-bc8f-46eb-a3cf-7f5ffeba8fa6', 3, 'Yüzük ve Kahvaltı Paketi', 'Ring and Breakfast Pack', 'Yüzüğü güvenli bir yerde saklayın ve zirve kahvaltısı hazırlayın.', 'Keep the ring in a safe place and prepare a summit breakfast.', false, 1, 5200),
(gen_random_uuid(), '6cd06995-bc8f-46eb-a3cf-7f5ffeba8fa6', 4, 'Gece Tırmanışı', 'Night Hike', 'Gün doğumuna yetişmek için gece tırmanışına başlayın.', 'Begin the night hike to reach the summit in time for sunrise.', true, 0, 0),
(gen_random_uuid(), '6cd06995-bc8f-46eb-a3cf-7f5ffeba8fa6', 5, 'Zirvede Teklif', 'Summit Proposal', 'Gün doğarken dağın zirvesinde diz çökerek teklif edin.', 'Kneel and propose at the mountain summit as the sun rises.', true, 0, 0);

-- 43) Tren Yolculuğu Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '775c2d10-73df-4064-86dd-62c8597822b6', 1, 'Tren Bileti ve Rota Seçimi', 'Choose Train Route and Tickets', 'Manzaralı bir tren rotası seçin ve özel kompartıman bileti alın.', 'Choose a scenic train route and book tickets for a private compartment.', false, 14, 2000),
(gen_random_uuid(), '775c2d10-73df-4064-86dd-62c8597822b6', 2, 'Kompartıman Dekorasyonu', 'Compartment Decoration', 'Tren personeli ile anlaşarak kompartımanı çiçekler ve mumlarla süsletin.', 'Arrange with train staff to decorate the compartment with flowers and candles.', false, 5, 1000),
(gen_random_uuid(), '775c2d10-73df-4064-86dd-62c8597822b6', 3, 'Yiyecek ve İçecek Hazırlığı', 'Food and Drink Preparation', 'Özel şampanya ve atıştırmalıklar hazırlayın.', 'Prepare special champagne and snacks.', false, 1, 800),
(gen_random_uuid(), '775c2d10-73df-4064-86dd-62c8597822b6', 4, 'Müzik Listesi Hazırlama', 'Prepare Music Playlist', 'Yolculuk boyunca çalacak romantik bir müzik listesi hazırlayın.', 'Prepare a romantic music playlist for the journey.', true, 1, 0),
(gen_random_uuid(), '775c2d10-73df-4064-86dd-62c8597822b6', 5, 'Manzara Eşliğinde Teklif', 'Propose with the View', 'En güzel manzara noktasında diz çökerek evlilik teklifi edin.', 'Kneel and propose at the most beautiful scenic point.', true, 0, 5000);

-- 44) Türk Kahvesi Falı Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '9c66559c-31ee-43cd-8f6c-e46ccf880f66', 1, 'Fal Senaryosu Yazma', 'Write Fortune Script', 'Sahte bir kahve falı senaryosu yazın ve teklif mesajını gizleyin.', 'Write a fake coffee fortune script and hide the proposal message within it.', false, 7, 0),
(gen_random_uuid(), '9c66559c-31ee-43cd-8f6c-e46ccf880f66', 2, 'Falcı ile Anlaşma', 'Arrange with Fortune Teller', 'Bir falcı veya arkadaşınızla anlaşarak sahte falı okumasını isteyin.', 'Arrange with a fortune teller or friend to read the fake fortune.', false, 5, 500),
(gen_random_uuid(), '9c66559c-31ee-43cd-8f6c-e46ccf880f66', 3, 'Özel Kahve Fincanı Hazırlama', 'Prepare Special Coffee Cup', 'Fincanın altına yüzüğü gizleyecek bir düzenek hazırlayın.', 'Prepare a mechanism to hide the ring under the coffee cup.', false, 3, 5100),
(gen_random_uuid(), '9c66559c-31ee-43cd-8f6c-e46ccf880f66', 4, 'Kahve Keyfi', 'Coffee Enjoyment', 'Partnerinizle birlikte Türk kahvesi içip fincanı çevirmesini bekleyin.', 'Enjoy Turkish coffee with your partner and wait for them to flip the cup.', true, 0, 0),
(gen_random_uuid(), '9c66559c-31ee-43cd-8f6c-e46ccf880f66', 5, 'Falda Teklif', 'Proposal in the Fortune', 'Fal okunurken "evlilik görüyorum" denildiğinde yüzükle teklif edin.', 'When "I see a wedding" is said during the fortune reading, propose with the ring.', true, 0, 0);

-- 45) Sualtı Dalış Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '9bcfb6ae-2a2f-49ff-ad5e-b8b3fc3a8f8d', 1, 'Dalış Merkezi ile Anlaşma', 'Arrange with Dive Center', 'Profesyonel bir dalış merkeziyle anlaşarak sualtı teklifi planlayın.', 'Arrange with a professional dive center to plan an underwater proposal.', false, 21, 3000),
(gen_random_uuid(), '9bcfb6ae-2a2f-49ff-ad5e-b8b3fc3a8f8d', 2, 'Su Geçirmez Tabela Hazırlama', 'Prepare Waterproof Sign', 'Su geçirmez bir "Benimle evlenir misin?" tabelası hazırlayın.', 'Prepare a waterproof "Will you marry me?" sign.', false, 7, 300),
(gen_random_uuid(), '9bcfb6ae-2a2f-49ff-ad5e-b8b3fc3a8f8d', 3, 'Yüzüğü Su Geçirmez Kutuya Koyma', 'Put Ring in Waterproof Box', 'Yüzüğü su geçirmez özel bir kutuya yerleştirin.', 'Place the ring in a special waterproof box.', false, 1, 5200),
(gen_random_uuid(), '9bcfb6ae-2a2f-49ff-ad5e-b8b3fc3a8f8d', 4, 'Sualtı Kamera Ayarlama', 'Arrange Underwater Camera', 'Sualtı fotoğraf ve video çekimi için ekipman ayarlayın.', 'Arrange equipment for underwater photo and video recording.', true, 3, 2000),
(gen_random_uuid(), '9bcfb6ae-2a2f-49ff-ad5e-b8b3fc3a8f8d', 5, 'Denizin Altında Teklif', 'Propose Under the Sea', 'Dalış sırasında tabelayı göstererek sualtında teklif edin.', 'Show the sign during the dive and propose underwater.', true, 0, 0);

-- 46) Venedik Gondol Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '224d8843-df57-4ff0-be64-6c8441525c4d', 1, 'Venedik Seyahati Planlama', 'Plan Venice Trip', 'Venedik''e seyahat planı yapın ve uçak bileti ile otel ayarlayın.', 'Plan a trip to Venice and arrange flight tickets and hotel.', false, 30, 15000),
(gen_random_uuid(), '224d8843-df57-4ff0-be64-6c8441525c4d', 2, 'Özel Gondol Rezervasyonu', 'Book Private Gondola', 'Özel bir gondol turu için rezervasyon yapın ve gondolcuyla anlaşın.', 'Book a private gondola tour and make arrangements with the gondolier.', false, 14, 3000),
(gen_random_uuid(), '224d8843-df57-4ff0-be64-6c8441525c4d', 3, 'Gondol Dekorasyonu', 'Gondola Decoration', 'Gondolu çiçekler ve mumlarla süslenmesini isteyin.', 'Request the gondola to be decorated with flowers and candles.', false, 3, 1000),
(gen_random_uuid(), '224d8843-df57-4ff0-be64-6c8441525c4d', 4, 'Müzisyen Ayarlama', 'Arrange Musician', 'Gondol turunda eşlik edecek bir akordeoncu ayarlayın.', 'Arrange an accordion player to accompany the gondola tour.', true, 5, 1500),
(gen_random_uuid(), '224d8843-df57-4ff0-be64-6c8441525c4d', 5, 'Kanallarda Teklif', 'Propose on the Canals', 'Rialto Köprüsü''nün altından geçerken diz çökerek teklif edin.', 'Kneel and propose while passing under the Rialto Bridge.', true, 0, 5000);

-- 47) Plak Kaydı Teklifi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '2fb92c87-71f0-4dae-92f6-b52f53bc69a2', 1, 'Şarkı veya Mesaj Kaydı', 'Record Song or Message', 'Partnerinize özel bir şarkı veya sesli mesaj kaydedin.', 'Record a special song or audio message for your partner.', false, 21, 0),
(gen_random_uuid(), '2fb92c87-71f0-4dae-92f6-b52f53bc69a2', 2, 'Vinil Plak Bastırma', 'Press Vinyl Record', 'Kaydı özel bir vinil plak olarak bastırın ve kapak tasarlayın.', 'Have the recording pressed as a custom vinyl record and design the cover.', false, 14, 2000),
(gen_random_uuid(), '2fb92c87-71f0-4dae-92f6-b52f53bc69a2', 3, 'Pikap Hazırlığı', 'Turntable Setup', 'Plağı çalmak için bir pikap hazırlayın ve ortamı düzenleyin.', 'Set up a turntable to play the record and arrange the setting.', false, 1, 500),
(gen_random_uuid(), '2fb92c87-71f0-4dae-92f6-b52f53bc69a2', 4, 'Romantik Ortam Yaratma', 'Create Romantic Atmosphere', 'Odayı mumlar, çiçekler ve ışıklarla süsleyin.', 'Decorate the room with candles, flowers, and lights.', true, 1, 500),
(gen_random_uuid(), '2fb92c87-71f0-4dae-92f6-b52f53bc69a2', 5, 'Plakla Teklif', 'Propose with the Record', 'Plağı birlikte dinlerken teklif mesajı çalındığında diz çökün.', 'Kneel when the proposal message plays as you listen to the record together.', true, 0, 5000);

-- 48) Gözü Bağlı Gizemli Buluşma
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '7acbd863-252b-44cc-81b4-3539a89a3ac2', 1, 'Sürpriz Rota Planlama', 'Plan Surprise Route', 'Partnerinizi gözleri bağlı götüreceğiniz sürpriz bir rota planlayın.', 'Plan a surprise route where you will take your blindfolded partner.', false, 7, 0),
(gen_random_uuid(), '7acbd863-252b-44cc-81b4-3539a89a3ac2', 2, 'Mekan Hazırlığı', 'Venue Preparation', 'Son durak mekanını romantik şekilde süsleyin ve hazırlayın.', 'Decorate and prepare the final destination venue in a romantic way.', false, 3, 1000),
(gen_random_uuid(), '7acbd863-252b-44cc-81b4-3539a89a3ac2', 3, 'Duyusal Deneyimler Hazırlama', 'Prepare Sensory Experiences', 'Her durakta farklı kokular, tatlar ve sesler içeren duyusal deneyimler hazırlayın.', 'Prepare sensory experiences with different scents, tastes, and sounds at each stop.', false, 1, 500),
(gen_random_uuid(), '7acbd863-252b-44cc-81b4-3539a89a3ac2', 4, 'Anı Kayıt Hazırlığı', 'Memory Recording Prep', 'Tepkileri kaydetmek için gizli kamera veya fotoğrafçı ayarlayın.', 'Arrange a hidden camera or photographer to record reactions.', true, 1, 500),
(gen_random_uuid(), '7acbd863-252b-44cc-81b4-3539a89a3ac2', 5, 'Göz Bandını Açma', 'Remove the Blindfold', 'Son durakta göz bandını çıkarın ve sürprizi açıklayın.', 'Remove the blindfold at the final stop and reveal the surprise.', true, 0, 0);

-- 49) Bonsai Aşk Ağacı Hediyesi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'bfbea56f-7ee1-4342-b470-d1d616d973f3', 1, 'Bonsai Seçimi', 'Choose Bonsai', 'Anlamlı bir bonsai ağacı türü araştırın ve satın alın.', 'Research and purchase a meaningful type of bonsai tree.', false, 10, 500),
(gen_random_uuid(), 'bfbea56f-7ee1-4342-b470-d1d616d973f3', 2, 'Saksı ve Dekorasyon', 'Pot and Decoration', 'Özel bir saksı seçin ve bonsaiyi güzelce yerleştirin.', 'Choose a special pot and beautifully place the bonsai.', false, 5, 300),
(gen_random_uuid(), 'bfbea56f-7ee1-4342-b470-d1d616d973f3', 3, 'Kişisel Mesaj Hazırlama', 'Prepare Personal Message', 'Bonsainin anlamını açıklayan duygusal bir kart yazın.', 'Write an emotional card explaining the meaning of the bonsai.', false, 2, 50),
(gen_random_uuid(), 'bfbea56f-7ee1-4342-b470-d1d616d973f3', 4, 'Hediye Paketleme', 'Gift Wrapping', 'Bonsaiyi özel bir şekilde paketleyin ve süsleyin.', 'Wrap and decorate the bonsai in a special way.', true, 1, 100),
(gen_random_uuid(), 'bfbea56f-7ee1-4342-b470-d1d616d973f3', 5, 'Hediye Sunumu', 'Gift Presentation', 'Bonsaiyi partnerinize sunun ve birlikte büyüteceğiniz aşk ağacınızı tanıtın.', 'Present the bonsai to your partner and introduce the love tree you will grow together.', true, 0, 0);

-- 50) Aşkın Kimyası Deneyi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '71a08be4-a478-4935-a2e0-6b0397218552', 1, 'Deney Malzemeleri Temini', 'Get Experiment Materials', 'Renkli kimyasal reaksiyonlar için güvenli malzemeler satın alın.', 'Purchase safe materials for colorful chemical reactions.', false, 7, 300),
(gen_random_uuid(), '71a08be4-a478-4935-a2e0-6b0397218552', 2, 'Deney Senaryosu Hazırlama', 'Prepare Experiment Scenario', 'Her deneye romantik bir anlam yükleyen senaryo yazın.', 'Write a scenario that gives each experiment a romantic meaning.', false, 5, 0),
(gen_random_uuid(), '71a08be4-a478-4935-a2e0-6b0397218552', 3, 'Deney Masası Kurma', 'Set Up Experiment Table', 'Mutfağı veya odayı laboratuvar gibi hazırlayın ve güvenlik önlemlerini alın.', 'Set up the kitchen or room like a lab and take safety precautions.', false, 1, 200),
(gen_random_uuid(), '71a08be4-a478-4935-a2e0-6b0397218552', 4, 'Birlikte Deney Yapma', 'Do Experiments Together', 'Partnerinizle birlikte eğlenceli ve renkli deneyleri gerçekleştirin.', 'Perform fun and colorful experiments together with your partner.', true, 0, 0),
(gen_random_uuid(), '71a08be4-a478-4935-a2e0-6b0397218552', 5, 'Sonuçları Paylaşma', 'Share Results', 'Son deneyin sonucunda "aşkın formülü" mesajını ortaya çıkarın.', 'Reveal the "formula of love" message as the result of the final experiment.', true, 0, 0);

-- 51) Sürpriz Çift Fotoğraf Çekimi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'c7e5df42-0b64-43fb-90c7-558015d07a53', 1, 'Fotoğrafçı Seçimi', 'Choose Photographer', 'Profesyonel bir çift fotoğrafçısı araştırın ve rezervasyon yapın.', 'Research and book a professional couples photographer.', false, 14, 2000),
(gen_random_uuid(), 'c7e5df42-0b64-43fb-90c7-558015d07a53', 2, 'Lokasyon ve Tema Belirleme', 'Set Location and Theme', 'Fotoğraf çekimi için romantik bir lokasyon ve tema belirleyin.', 'Choose a romantic location and theme for the photoshoot.', false, 7, 0),
(gen_random_uuid(), 'c7e5df42-0b64-43fb-90c7-558015d07a53', 3, 'Kıyafet Hazırlığı', 'Outfit Preparation', 'Çekim için uyumlu ve şık kıyafetler hazırlayın.', 'Prepare matching and stylish outfits for the shoot.', false, 3, 500),
(gen_random_uuid(), 'c7e5df42-0b64-43fb-90c7-558015d07a53', 4, 'Sürpriz Planı', 'Surprise Plan', 'Partnerinize sıradan bir etkinlik gibi gösterin ve sürprizi saklayın.', 'Present it to your partner as a casual activity and keep the surprise hidden.', true, 1, 0),
(gen_random_uuid(), 'c7e5df42-0b64-43fb-90c7-558015d07a53', 5, 'Fotoğraf Çekimi', 'Photoshoot', 'Birlikte güzel anılar biriktirin ve profesyonel fotoğrafları paylaşın.', 'Collect beautiful memories together and share the professional photos.', true, 0, 0);

-- 52) Çift Yemek Yapma Atölyesi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'dda5d919-1ca4-4e1a-8c36-eeb0b2359a54', 1, 'Atölye Araştırması ve Rezervasyon', 'Research and Book Workshop', 'Çift yemek yapma atölyesi araştırın ve rezervasyon yapın.', 'Research couples cooking classes and make a reservation.', false, 10, 1500),
(gen_random_uuid(), 'dda5d919-1ca4-4e1a-8c36-eeb0b2359a54', 2, 'Menü Seçimi', 'Menu Selection', 'Birlikte yapacağınız yemeklerin menüsünü seçin.', 'Select the menu of dishes you will cook together.', false, 5, 0),
(gen_random_uuid(), 'dda5d919-1ca4-4e1a-8c36-eeb0b2359a54', 3, 'Malzeme Kontrolü', 'Ingredient Check', 'Atölye öncesi malzemelerin hazır olduğundan emin olun.', 'Make sure all ingredients are ready before the workshop.', false, 1, 0),
(gen_random_uuid(), 'dda5d919-1ca4-4e1a-8c36-eeb0b2359a54', 4, 'Birlikte Pişirme', 'Cook Together', 'Şefin rehberliğinde birlikte yemek yapmanın keyfini çıkarın.', 'Enjoy cooking together under the chef''s guidance.', true, 0, 0),
(gen_random_uuid(), 'dda5d919-1ca4-4e1a-8c36-eeb0b2359a54', 5, 'Yemeği Birlikte Yeme', 'Eat Together', 'Hazırladığınız yemekleri romantik bir sofrada birlikte yiyin.', 'Eat the dishes you prepared together at a romantic table.', true, 0, 300);

-- 53) Çift Resim Yapma Gecesi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'd840689c-f4ee-4199-8454-88a5f78c6c8d', 1, 'Malzeme Temini', 'Get Supplies', 'Tuval, boya, fırça ve şövale satın alın.', 'Purchase canvas, paint, brushes, and easels.', false, 7, 500),
(gen_random_uuid(), 'd840689c-f4ee-4199-8454-88a5f78c6c8d', 2, 'Mekan Hazırlığı', 'Prepare Venue', 'Resim yapacağınız odayı koruyucu örtülerle ve ışıklandırmayla hazırlayın.', 'Prepare the room where you will paint with protective covers and lighting.', false, 2, 200),
(gen_random_uuid(), 'd840689c-f4ee-4199-8454-88a5f78c6c8d', 3, 'İçecek ve Atıştırmalık Hazırlama', 'Prepare Drinks and Snacks', 'Şarap, peynir tabağı ve atıştırmalıklar hazırlayın.', 'Prepare wine, cheese platter, and snacks.', false, 1, 400),
(gen_random_uuid(), 'd840689c-f4ee-4199-8454-88a5f78c6c8d', 4, 'Birlikte Resim Yapma', 'Paint Together', 'Müzik eşliğinde birbirinizin portrelerini çizin veya soyut resim yapın.', 'Paint each other''s portraits or create abstract art while listening to music.', true, 0, 0),
(gen_random_uuid(), 'd840689c-f4ee-4199-8454-88a5f78c6c8d', 5, 'Eserleri Paylaşma', 'Share Artworks', 'Tamamlanan resimleri birbirinize gösterin ve duvara asın.', 'Show each other the completed paintings and hang them on the wall.', true, 0, 0);

-- 54) Kişiye Özel Kutu Oyunu Buluşması
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '8a5fe721-7730-4be7-bfe9-e0788c0970f3', 1, 'Oyun Tasarımı', 'Game Design', 'İlişkinize özel kuralları ve görevleri olan bir kutu oyunu tasarlayın.', 'Design a board game with rules and tasks specific to your relationship.', false, 14, 0),
(gen_random_uuid(), '8a5fe721-7730-4be7-bfe9-e0788c0970f3', 2, 'Oyun Malzemeleri Hazırlama', 'Prepare Game Materials', 'Oyun tahtası, kartlar, zar ve piyon gibi malzemeleri hazırlayın veya bastırın.', 'Prepare or print game materials like the board, cards, dice, and tokens.', false, 7, 500),
(gen_random_uuid(), '8a5fe721-7730-4be7-bfe9-e0788c0970f3', 3, 'Kuralları Yazma', 'Write the Rules', 'Oyun kurallarını eğlenceli ve anlaşılır şekilde yazın.', 'Write the game rules in a fun and understandable way.', false, 3, 0),
(gen_random_uuid(), '8a5fe721-7730-4be7-bfe9-e0788c0970f3', 4, 'Oyun Gecesi Hazırlığı', 'Game Night Setup', 'Atıştırmalıklar ve içeceklerle rahat bir oyun gecesi ortamı kurun.', 'Set up a cozy game night atmosphere with snacks and drinks.', true, 1, 300),
(gen_random_uuid(), '8a5fe721-7730-4be7-bfe9-e0788c0970f3', 5, 'Oyunu Oynama', 'Play the Game', 'Partnerinizle birlikte özel oyununuzu oynayın ve eğlenin.', 'Play your custom game with your partner and have fun.', true, 0, 0);

-- 55) Kişiye Özel Vinil Aşk Albümü
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'fefa90d3-c9b0-4d0a-aafe-3f22faa25438', 1, 'Şarkı Listesi Oluşturma', 'Create Song List', 'İlişkinizi anlatan şarkılardan bir albüm listesi oluşturun.', 'Create an album tracklist of songs that tell the story of your relationship.', false, 21, 0),
(gen_random_uuid(), 'fefa90d3-c9b0-4d0a-aafe-3f22faa25438', 2, 'Vinil Bastırma Siparişi', 'Order Vinyl Press', 'Şarkıları bir vinil plak olarak bastırmak için sipariş verin.', 'Place an order to press the songs as a vinyl record.', false, 14, 2500),
(gen_random_uuid(), 'fefa90d3-c9b0-4d0a-aafe-3f22faa25438', 3, 'Kapak Tasarımı', 'Cover Design', 'Albüm kapağı için özel bir fotoğraf ve tasarım hazırlayın.', 'Prepare a special photo and design for the album cover.', false, 14, 500),
(gen_random_uuid(), 'fefa90d3-c9b0-4d0a-aafe-3f22faa25438', 4, 'Hediye Paketi', 'Gift Package', 'Vinil plağı özel bir kutuda hediye paketi olarak hazırlayın.', 'Prepare the vinyl record as a gift package in a special box.', true, 1, 200),
(gen_random_uuid(), 'fefa90d3-c9b0-4d0a-aafe-3f22faa25438', 5, 'Birlikte Dinleme', 'Listen Together', 'Plağı pikaba koyun ve birlikte dinleyerek anıları yaşayın.', 'Put the record on the turntable and relive memories as you listen together.', true, 0, 0);

-- 56) Buluşma Gecesi Kavanozu
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '3f1d63b0-eb43-40e5-a3b3-4943fc801a0a', 1, 'Kavanoz ve Malzeme Temini', 'Get Jar and Supplies', 'Dekoratif bir cam kavanoz ve renkli kağıtlar satın alın.', 'Buy a decorative glass jar and colorful papers.', false, 5, 150),
(gen_random_uuid(), '3f1d63b0-eb43-40e5-a3b3-4943fc801a0a', 2, 'Buluşma Fikirleri Yazma', 'Write Date Ideas', 'En az 50 farklı buluşma fikri yazın ve kağıtlara katlayın.', 'Write at least 50 different date ideas and fold them into papers.', false, 3, 0),
(gen_random_uuid(), '3f1d63b0-eb43-40e5-a3b3-4943fc801a0a', 3, 'Kavanozu Süsleme', 'Decorate the Jar', 'Kavanozu kurdeleler, etiketler ve süslemelerle güzelleştirin.', 'Beautify the jar with ribbons, labels, and decorations.', false, 1, 100),
(gen_random_uuid(), '3f1d63b0-eb43-40e5-a3b3-4943fc801a0a', 4, 'Hediye Sunumu', 'Gift Presentation', 'Kavanozu partnerinize özel bir anda hediye edin.', 'Gift the jar to your partner at a special moment.', true, 0, 0),
(gen_random_uuid(), '3f1d63b0-eb43-40e5-a3b3-4943fc801a0a', 5, 'İlk Kağıdı Çekme', 'Pull First Paper', 'Birlikte ilk kağıdı çekin ve ilk buluşmanızı planlayın.', 'Pull the first paper together and plan your first date.', true, 0, 0);

-- 57) Beş Duyu Hediye Kutusu
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '7e66379b-c1d0-491a-8117-325404785f0b', 1, 'Beş Duyu İçin Hediye Seçimi', 'Choose Gifts for Five Senses', 'Görme, duyma, dokunma, tatma ve koklama için birer hediye seçin.', 'Choose a gift for each sense: sight, hearing, touch, taste, and smell.', false, 10, 0),
(gen_random_uuid(), '7e66379b-c1d0-491a-8117-325404785f0b', 2, 'Hediyeleri Satın Alma', 'Purchase Gifts', 'Parfüm, çikolata, müzik kutusu, yumuşak battaniye ve fotoğraf albümü gibi hediyeler alın.', 'Buy gifts like perfume, chocolate, music box, soft blanket, and photo album.', false, 7, 1500),
(gen_random_uuid(), '7e66379b-c1d0-491a-8117-325404785f0b', 3, 'Kutu Tasarımı ve Paketleme', 'Box Design and Packaging', 'Her hediyeyi ayrı bölmeli özel bir kutuya yerleştirin.', 'Place each gift in a special box with separate compartments.', false, 3, 300),
(gen_random_uuid(), '7e66379b-c1d0-491a-8117-325404785f0b', 4, 'Kişisel Notlar Ekleme', 'Add Personal Notes', 'Her hediyeye neden seçtiğinizi anlatan kişisel bir not ekleyin.', 'Add a personal note to each gift explaining why you chose it.', true, 1, 0),
(gen_random_uuid(), '7e66379b-c1d0-491a-8117-325404785f0b', 5, 'Hediye Sunumu', 'Gift Presentation', 'Kutuyu partnerinize verin ve her hediyeyi tek tek açmasını izleyin.', 'Give the box to your partner and watch them open each gift one by one.', true, 0, 0);

-- 58) Dilek Feneri Gecesi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '1a9f8c8e-c004-4c4c-b2f0-ad9a3fa76e75', 1, 'Dilek Feneri Temini', 'Get Floating Lanterns', 'Güvenli ve çevre dostu dilek fenerleri satın alın.', 'Purchase safe and eco-friendly floating lanterns.', false, 7, 300),
(gen_random_uuid(), '1a9f8c8e-c004-4c4c-b2f0-ad9a3fa76e75', 2, 'Lokasyon Seçimi', 'Choose Location', 'Göl kenarı veya açık alan gibi güvenli bir lokasyon belirleyin.', 'Choose a safe location like a lakeside or open field.', false, 5, 0),
(gen_random_uuid(), '1a9f8c8e-c004-4c4c-b2f0-ad9a3fa76e75', 3, 'Ortam Hazırlığı', 'Prepare Setting', 'Battaniyeler, mumlar ve sıcak içeceklerle romantik bir ortam kurun.', 'Set up a romantic atmosphere with blankets, candles, and hot drinks.', false, 1, 300),
(gen_random_uuid(), '1a9f8c8e-c004-4c4c-b2f0-ad9a3fa76e75', 4, 'Dilek Yazma', 'Write Wishes', 'Fenerlere dileklerinizi yazın ve birlikte paylaşın.', 'Write your wishes on the lanterns and share them together.', true, 0, 0),
(gen_random_uuid(), '1a9f8c8e-c004-4c4c-b2f0-ad9a3fa76e75', 5, 'Fenerleri Uçurma', 'Release Lanterns', 'Birlikte dilek fenerleri uçurun ve gökyüzünü izleyin.', 'Release the wish lanterns together and watch the sky.', true, 0, 0);

-- 59) Glamping Kaçamak Gecesi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a7ea94c0-096c-47f0-8d48-45e34dadecdf', 1, 'Glamping Alanı Rezervasyonu', 'Book Glamping Site', 'Doğada lüks bir glamping alanı araştırın ve rezervasyon yapın.', 'Research and book a luxury glamping site in nature.', false, 14, 3000),
(gen_random_uuid(), 'a7ea94c0-096c-47f0-8d48-45e34dadecdf', 2, 'Ekipman ve Malzeme Listesi', 'Equipment and Supply List', 'Battaniye, yastık, ışık zinciri ve kamp malzemeleri listesi hazırlayın.', 'Prepare a list of blankets, pillows, string lights, and camping supplies.', false, 7, 1000),
(gen_random_uuid(), 'a7ea94c0-096c-47f0-8d48-45e34dadecdf', 3, 'Yiyecek ve İçecek Hazırlığı', 'Food and Drink Prep', 'Gurme piknik sepeti ve özel içecekler hazırlayın.', 'Prepare a gourmet picnic basket and special drinks.', false, 1, 800),
(gen_random_uuid(), 'a7ea94c0-096c-47f0-8d48-45e34dadecdf', 4, 'Çadırı Süsleme', 'Decorate the Tent', 'Çadırı ışık zincirleri, çiçekler ve yastıklarla süsleyin.', 'Decorate the tent with string lights, flowers, and pillows.', true, 1, 500),
(gen_random_uuid(), 'a7ea94c0-096c-47f0-8d48-45e34dadecdf', 5, 'Doğada Romantik Gece', 'Romantic Night in Nature', 'Yıldızların altında ateş başında romantik bir gece geçirin.', 'Spend a romantic night by the fire under the stars.', true, 0, 0);

-- 60) Yıldızlı Yatak Odası Sürprizi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '698a3825-4a97-4702-bd71-368c2826a0d1', 1, 'Yıldız Projektörü Temini', 'Get Star Projector', 'Kaliteli bir yıldız projektörü veya LED ışık sistemi satın alın.', 'Purchase a quality star projector or LED light system.', false, 7, 500),
(gen_random_uuid(), '698a3825-4a97-4702-bd71-368c2826a0d1', 2, 'Oda Düzenlemesi', 'Room Arrangement', 'Yatak odasını temizleyin ve projektör için en iyi konumu belirleyin.', 'Clean the bedroom and determine the best position for the projector.', false, 2, 0),
(gen_random_uuid(), '698a3825-4a97-4702-bd71-368c2826a0d1', 3, 'Romantik Detaylar Ekleme', 'Add Romantic Details', 'Gül yaprakları, mumlar ve güzel kokulu difüzör ekleyin.', 'Add rose petals, candles, and a nicely scented diffuser.', false, 1, 300),
(gen_random_uuid(), '698a3825-4a97-4702-bd71-368c2826a0d1', 4, 'Müzik Listesi Hazırlama', 'Prepare Music Playlist', 'Yıldızlar altında dinlenecek sakin bir müzik listesi oluşturun.', 'Create a calm music playlist to listen to under the stars.', true, 1, 0),
(gen_random_uuid(), '698a3825-4a97-4702-bd71-368c2826a0d1', 5, 'Sürprizi Açıklama', 'Reveal the Surprise', 'Partnerinizi odaya götürün ve yıldızlı tavan sürprizini açın.', 'Take your partner to the room and reveal the starry ceiling surprise.', true, 0, 0);

-- 61) Hanami Bento Pikniği
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'b4bc3f3b-5295-40b5-9996-7e34d276780e', 1, 'Bento Kutusu ve Malzeme Temini', 'Get Bento Box and Supplies', 'Geleneksel bir bento kutusu ve Japon yemek malzemeleri satın alın.', 'Purchase a traditional bento box and Japanese cooking ingredients.', false, 7, 400),
(gen_random_uuid(), 'b4bc3f3b-5295-40b5-9996-7e34d276780e', 2, 'Bento Hazırlama', 'Prepare Bento', 'Onigiri, tamagoyaki ve taze sebzelerle güzel bir bento hazırlayın.', 'Prepare a beautiful bento with onigiri, tamagoyaki, and fresh vegetables.', false, 1, 300),
(gen_random_uuid(), 'b4bc3f3b-5295-40b5-9996-7e34d276780e', 3, 'Piknik Alanı Seçimi', 'Choose Picnic Spot', 'Çiçek açan ağaçların altında bir piknik alanı seçin.', 'Choose a picnic spot under blooming trees.', false, 3, 0),
(gen_random_uuid(), 'b4bc3f3b-5295-40b5-9996-7e34d276780e', 4, 'Piknik Seti Hazırlama', 'Prepare Picnic Set', 'Piknik örtüsü, tabaklar ve yeşil çay termosu hazırlayın.', 'Prepare a picnic blanket, plates, and green tea thermos.', true, 1, 200),
(gen_random_uuid(), 'b4bc3f3b-5295-40b5-9996-7e34d276780e', 5, 'Çiçekler Altında Piknik', 'Picnic Under Blossoms', 'Çiçek açan ağaçların altında bento pikniğinin tadını çıkarın.', 'Enjoy the bento picnic under the blooming trees.', true, 0, 0);

-- 62) El Yazması Şiir Hediyesi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '72da5bd8-cd27-46a2-9fc9-ac455af91b6f', 1, 'Şiir Yazma', 'Write the Poem', 'Partnerinize duygusal ve kişisel bir şiir kaleme alın.', 'Write an emotional and personal poem for your partner.', false, 10, 0),
(gen_random_uuid(), '72da5bd8-cd27-46a2-9fc9-ac455af91b6f', 2, 'Özel Kağıt ve Mürekkep Temini', 'Get Special Paper and Ink', 'El yapımı kağıt ve kaligrafi kalemi satın alın.', 'Purchase handmade paper and a calligraphy pen.', false, 5, 200),
(gen_random_uuid(), '72da5bd8-cd27-46a2-9fc9-ac455af91b6f', 3, 'Şiiri Kaligrafiyle Yazma', 'Write Poem in Calligraphy', 'Şiiri güzel bir el yazısıyla özel kağıda yazın.', 'Write the poem on the special paper with beautiful handwriting.', false, 3, 0),
(gen_random_uuid(), '72da5bd8-cd27-46a2-9fc9-ac455af91b6f', 4, 'Çerçeveleme', 'Framing', 'Şiiri zarif bir çerçeveye koyun.', 'Place the poem in an elegant frame.', true, 1, 300),
(gen_random_uuid(), '72da5bd8-cd27-46a2-9fc9-ac455af91b6f', 5, 'Şiiri Hediye Etme', 'Gift the Poem', 'Şiiri partnerinize özel bir anda hediye edin ve sesli okuyun.', 'Gift the poem to your partner at a special moment and read it aloud.', true, 0, 0);

-- 63) Ev Sineması Gecesi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'edd43f85-6d38-46d4-8181-7173b99c9d69', 1, 'Projeksiyon ve Ekipman Hazırlığı', 'Projector and Equipment Setup', 'Projektör, perde veya beyaz duvar ve ses sistemi hazırlayın.', 'Prepare a projector, screen or white wall, and sound system.', false, 5, 1000),
(gen_random_uuid(), 'edd43f85-6d38-46d4-8181-7173b99c9d69', 2, 'Film Seçimi', 'Movie Selection', 'Partnerinizin en sevdiği filmleri veya birlikte izlemek istediğiniz filmi seçin.', 'Choose your partner''s favorite movies or a film you both want to watch.', false, 3, 0),
(gen_random_uuid(), 'edd43f85-6d38-46d4-8181-7173b99c9d69', 3, 'Atıştırmalık Hazırlığı', 'Snack Preparation', 'Patlamış mısır, şeker ve içeceklerle sinema büfesi oluşturun.', 'Create a cinema concession stand with popcorn, candy, and drinks.', false, 1, 200),
(gen_random_uuid(), 'edd43f85-6d38-46d4-8181-7173b99c9d69', 4, 'Oturma Alanı Düzenleme', 'Arrange Seating Area', 'Yastıklar, battaniyeler ve minderlere rahat bir oturma alanı kurun.', 'Set up a comfortable seating area with pillows, blankets, and cushions.', true, 1, 300),
(gen_random_uuid(), 'edd43f85-6d38-46d4-8181-7173b99c9d69', 5, 'Film Gecesi Başlasın', 'Let Movie Night Begin', 'Işıkları kapatın ve ev sineması deneyiminin tadını çıkarın.', 'Turn off the lights and enjoy the home cinema experience.', true, 0, 0);

-- 64) Evde Spa ve Masaj Gecesi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '2617bf45-37b3-487d-a765-078c6f90c728', 1, 'Spa Malzemeleri Temini', 'Get Spa Supplies', 'Masaj yağı, yüz maskesi, banyo tuzu ve havlular satın alın.', 'Purchase massage oil, face masks, bath salts, and towels.', false, 5, 500),
(gen_random_uuid(), '2617bf45-37b3-487d-a765-078c6f90c728', 2, 'Ortam Hazırlığı', 'Prepare Atmosphere', 'Banyoyu ve odayı mumlar, aromatik yağlar ve sakin müzikle hazırlayın.', 'Prepare the bathroom and room with candles, aromatic oils, and calm music.', false, 1, 300),
(gen_random_uuid(), '2617bf45-37b3-487d-a765-078c6f90c728', 3, 'Spa Menüsü Oluşturma', 'Create Spa Menu', 'Yüz bakımı, el bakımı ve masaj içeren bir spa menüsü hazırlayın.', 'Create a spa menu including facial care, hand care, and massage.', false, 1, 0),
(gen_random_uuid(), '2617bf45-37b3-487d-a765-078c6f90c728', 4, 'Sağlıklı İçecek Hazırlama', 'Prepare Healthy Drinks', 'Detoks suyu, bitki çayı ve meyve tabağı hazırlayın.', 'Prepare detox water, herbal tea, and a fruit platter.', true, 1, 200),
(gen_random_uuid(), '2617bf45-37b3-487d-a765-078c6f90c728', 5, 'Spa Deneyimi', 'Spa Experience', 'Birbirinize masaj yapın ve spa gecesinin keyfini çıkarın.', 'Give each other massages and enjoy the spa night.', true, 0, 0);

-- 65) Gün Batımında At Binme
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a37fcf95-f542-40d5-8085-72ff36a76993', 1, 'At Çiftliği Rezervasyonu', 'Book Horse Ranch', 'Gün batımı saatinde at binme turu için çiftlik rezervasyonu yapın.', 'Make a horse ranch reservation for a horseback riding tour at sunset time.', false, 10, 1500),
(gen_random_uuid(), 'a37fcf95-f542-40d5-8085-72ff36a76993', 2, 'Kıyafet ve Ekipman Hazırlığı', 'Outfit and Equipment Prep', 'At binmeye uygun kıyafetler ve güneş gözlüğü hazırlayın.', 'Prepare horse riding appropriate clothing and sunglasses.', false, 3, 300),
(gen_random_uuid(), 'a37fcf95-f542-40d5-8085-72ff36a76993', 3, 'Fotoğrafçı Ayarlama', 'Arrange Photographer', 'Gün batımında at sırtındaki anıları yakalamak için fotoğrafçı tutun.', 'Hire a photographer to capture the sunset horseback riding memories.', false, 5, 1000),
(gen_random_uuid(), 'a37fcf95-f542-40d5-8085-72ff36a76993', 4, 'Piknik Hazırlığı', 'Prepare Picnic', 'At binme sonrası için doğada romantik bir piknik hazırlayın.', 'Prepare a romantic picnic in nature after the horseback ride.', true, 1, 500),
(gen_random_uuid(), 'a37fcf95-f542-40d5-8085-72ff36a76993', 5, 'Gün Batımı Sürüşü', 'Sunset Ride', 'Gün batımında at sırtında romantik bir gezintinin tadını çıkarın.', 'Enjoy a romantic ride on horseback at sunset.', true, 0, 0);

-- 66) Sıcak Hava Balonu Turu
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000003', 1, 'Balon Turu Rezervasyonu', 'Book Balloon Tour', 'Sıcak hava balonu turu için güvenilir bir firmadan rezervasyon yapın.', 'Book a hot air balloon tour from a reliable company.', false, 14, 5000),
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000003', 2, 'Hava Durumu Kontrolü', 'Weather Check', 'Uçuş günü için hava durumunu takip edin ve alternatif tarih belirleyin.', 'Monitor the weather for the flight day and set an alternative date.', false, 3, 0),
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000003', 3, 'Kıyafet ve Ekipman', 'Clothing and Equipment', 'Sıcak tutan katmanlı kıyafetler ve kamera hazırlayın.', 'Prepare warm layered clothing and a camera.', false, 1, 200),
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000003', 4, 'Şampanya Hazırlığı', 'Champagne Preparation', 'İniş sonrası kutlama için şampanya ve kadeh hazırlayın.', 'Prepare champagne and glasses for a post-landing celebration.', true, 1, 400),
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000003', 5, 'Gökyüzünde Romantik An', 'Romantic Moment in the Sky', 'Gökyüzünde birlikte manzaranın ve anın tadını çıkarın.', 'Enjoy the view and the moment together in the sky.', true, 0, 0);

-- 67) Evde İtalyan Trattoria Gecesi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '7b612e50-4d6a-478b-9aa7-858ddf074501', 1, 'İtalyan Menü Planlama', 'Plan Italian Menu', 'Antipasti, makarna, ana yemek ve tatlıdan oluşan bir İtalyan menüsü planlayın.', 'Plan an Italian menu consisting of antipasti, pasta, main course, and dessert.', false, 5, 0),
(gen_random_uuid(), '7b612e50-4d6a-478b-9aa7-858ddf074501', 2, 'Malzeme Alışverişi', 'Grocery Shopping', 'Taze İtalyan malzemeleri ve kaliteli zeytinyağı satın alın.', 'Purchase fresh Italian ingredients and quality olive oil.', false, 2, 500),
(gen_random_uuid(), '7b612e50-4d6a-478b-9aa7-858ddf074501', 3, 'Mekan Dekorasyonu', 'Venue Decoration', 'Yemek odasını İtalyan bayrağı, mumlar ve damalı masa örtüsüyle süsleyin.', 'Decorate the dining room with an Italian flag, candles, and checkered tablecloth.', false, 1, 300),
(gen_random_uuid(), '7b612e50-4d6a-478b-9aa7-858ddf074501', 4, 'İtalyan Müzik Listesi', 'Italian Music Playlist', 'Dean Martin ve Frank Sinatra şarkılarından bir çalma listesi hazırlayın.', 'Create a playlist of Dean Martin and Frank Sinatra songs.', true, 1, 0),
(gen_random_uuid(), '7b612e50-4d6a-478b-9aa7-858ddf074501', 5, 'Trattoria Deneyimi', 'Trattoria Experience', 'Yemekleri servis edin ve evde İtalyan restoranı atmosferinin tadını çıkarın.', 'Serve the dishes and enjoy the Italian restaurant atmosphere at home.', true, 0, 0);

-- 68) Uzak Mesafe Dokunma Lambası
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '60da64bf-a9ea-459e-8eaa-75ad6025e044', 1, 'Dokunma Lambası Araştırma', 'Research Touch Lamps', 'Wi-Fi bağlantılı uzak mesafe dokunma lambalarını araştırın ve sipariş verin.', 'Research Wi-Fi connected long-distance touch lamps and place an order.', false, 14, 1500),
(gen_random_uuid(), '60da64bf-a9ea-459e-8eaa-75ad6025e044', 2, 'Lamba Kurulumu', 'Lamp Setup', 'Her iki lambayı da Wi-Fi''ye bağlayın ve eşleştirmeyi yapın.', 'Connect both lamps to Wi-Fi and pair them together.', false, 3, 0),
(gen_random_uuid(), '60da64bf-a9ea-459e-8eaa-75ad6025e044', 3, 'Kişiselleştirme', 'Personalization', 'Lambaları kişisel mesaj veya fotoğraflarla süsleyin.', 'Decorate the lamps with personal messages or photos.', false, 1, 100),
(gen_random_uuid(), '60da64bf-a9ea-459e-8eaa-75ad6025e044', 4, 'Hediye Paketleme', 'Gift Wrapping', 'Partnerinizin lambasını özel bir kutuyla paketleyin.', 'Package your partner''s lamp in a special box.', true, 1, 100),
(gen_random_uuid(), '60da64bf-a9ea-459e-8eaa-75ad6025e044', 5, 'Hediye Sunumu ve Test', 'Gift Presentation and Test', 'Lambayı hediye edin ve birlikte ilk dokunma testini yapın.', 'Gift the lamp and do the first touch test together.', true, 0, 0);

-- 69) Aşk Kuponu Kitapçığı
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '8a857640-4f20-4e66-aebe-b996637cdbba', 1, 'Kupon Fikirleri Listeleme', 'List Coupon Ideas', 'Masaj, romantik akşam yemeği, film gecesi gibi kupon fikirleri listeleyin.', 'List coupon ideas like massage, romantic dinner, movie night, etc.', false, 5, 0),
(gen_random_uuid(), '8a857640-4f20-4e66-aebe-b996637cdbba', 2, 'Kupon Tasarımı', 'Coupon Design', 'Her kuponu güzel bir şekilde tasarlayın ve renkli kağıtlara basın.', 'Design each coupon beautifully and print on colorful paper.', false, 3, 200),
(gen_random_uuid(), '8a857640-4f20-4e66-aebe-b996637cdbba', 3, 'Kitapçık Hazırlama', 'Prepare Booklet', 'Kuponları bir kitapçık halinde ciltleyin veya deftere yapıştırın.', 'Bind the coupons into a booklet or paste them into a notebook.', false, 1, 100),
(gen_random_uuid(), '8a857640-4f20-4e66-aebe-b996637cdbba', 4, 'Kapak Tasarımı', 'Cover Design', 'Kitapçığa özel bir kapak tasarlayın ve partnerinizin adını yazın.', 'Design a special cover for the booklet with your partner''s name.', true, 1, 0),
(gen_random_uuid(), '8a857640-4f20-4e66-aebe-b996637cdbba', 5, 'Kitapçığı Hediye Etme', 'Gift the Booklet', 'Aşk kuponu kitapçığını partnerinize özel bir anda hediye edin.', 'Gift the love coupon booklet to your partner at a special moment.', true, 0, 0);

-- 70) Aşk Mektubu Rotası
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000002', 1, 'Mektup Yazma', 'Write Letters', 'İlişkinizin farklı dönemlerine ait duygusal mektuplar yazın.', 'Write emotional letters about different periods of your relationship.', false, 7, 0),
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000002', 2, 'Rota Planlama', 'Plan the Route', 'Mektupları saklanacağı anlamlı noktaların rotasını oluşturun.', 'Create a route of meaningful locations where the letters will be hidden.', false, 5, 0),
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000002', 3, 'Mektupları Yerleştirme', 'Place the Letters', 'Mektupları zarflara koyun ve belirlediğiniz noktalara yerleştirin.', 'Put the letters in envelopes and place them at the designated spots.', false, 1, 100),
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000002', 4, 'İpucu Haritası Hazırlama', 'Prepare Clue Map', 'Partnerinize vereceğiniz ilk ipucunu ve haritayı hazırlayın.', 'Prepare the first clue and map to give to your partner.', true, 1, 50),
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000002', 5, 'Mektup Keşfi', 'Letter Discovery', 'Partnerinizi rotaya çıkarın ve her mektubu birlikte keşfedin.', 'Send your partner on the route and discover each letter together.', true, 0, 0);

-- 71) Aşk Mektubu Parkuru
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '3eba584e-414c-484d-bc0c-f350a2e500a0', 1, 'Parkur Noktaları Belirleme', 'Determine Parkour Points', 'Şehirde veya evde mektupları gizleyeceğiniz noktaları belirleyin.', 'Determine the points in the city or home where you will hide the letters.', false, 7, 0),
(gen_random_uuid(), '3eba584e-414c-484d-bc0c-f350a2e500a0', 2, 'Mektupları Kaleme Alma', 'Write the Letters', 'Her durak için anlamlı ve duygusal bir mektup yazın.', 'Write a meaningful and emotional letter for each stop.', false, 5, 50),
(gen_random_uuid(), '3eba584e-414c-484d-bc0c-f350a2e500a0', 3, 'Zarfları Gizleme', 'Hide the Envelopes', 'Mektupları güzel zarflara koyarak belirlenen noktalara yerleştirin.', 'Place the letters in beautiful envelopes and hide them at the designated points.', false, 1, 100),
(gen_random_uuid(), '3eba584e-414c-484d-bc0c-f350a2e500a0', 4, 'Başlangıç İpucu', 'Starting Clue', 'Partnerinize ilk ipucunu vererek parkuru başlatın.', 'Give your partner the first clue to start the parkour.', true, 0, 0),
(gen_random_uuid(), '3eba584e-414c-484d-bc0c-f350a2e500a0', 5, 'Son Mektup Buluşması', 'Final Letter Reunion', 'Son mektupta buluşma noktasını yazın ve orada bekleyin.', 'Write the meeting point in the final letter and wait there.', true, 0, 0);

-- 72) Aşk Haritası Duvar Sanatı
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a9088c9b-10f2-4671-88d1-25ca13d2611c', 1, 'Anlamlı Lokasyonları Belirleme', 'Identify Meaningful Locations', 'İlişkinizde özel olan yerleri belirleyin: tanışma yeri, ilk buluşma gibi.', 'Identify special places in your relationship: where you met, first date, etc.', false, 10, 0),
(gen_random_uuid(), 'a9088c9b-10f2-4671-88d1-25ca13d2611c', 2, 'Harita Tasarımı', 'Map Design', 'Lokasyonları işaretleyen özel bir harita tasarlayın veya yaptırın.', 'Design or have someone create a custom map marking the locations.', false, 7, 1000),
(gen_random_uuid(), 'a9088c9b-10f2-4671-88d1-25ca13d2611c', 3, 'Baskı ve Çerçeveleme', 'Print and Frame', 'Haritayı büyük boyutta bastırın ve zarif bir çerçeveye koyun.', 'Print the map in large format and place it in an elegant frame.', false, 5, 800),
(gen_random_uuid(), 'a9088c9b-10f2-4671-88d1-25ca13d2611c', 4, 'Açıklama Notları Ekleme', 'Add Description Notes', 'Her lokasyona küçük açıklama notları ve tarihleri ekleyin.', 'Add small description notes and dates to each location.', true, 2, 0),
(gen_random_uuid(), 'a9088c9b-10f2-4671-88d1-25ca13d2611c', 5, 'Duvar Sanatını Hediye Etme', 'Gift the Wall Art', 'Haritayı partnerinize hediye edin ve birlikte duvara asın.', 'Gift the map to your partner and hang it on the wall together.', true, 0, 0);

-- 73) Aşk Müzik Listesi Değişimi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'da51bc02-895d-42bf-9955-917a0bd2ea8c', 1, 'Şarkı Seçimi', 'Song Selection', 'Partnerinize özel anlamı olan şarkıları seçin ve bir çalma listesi oluşturun.', 'Select songs with special meaning for your partner and create a playlist.', false, 5, 0),
(gen_random_uuid(), 'da51bc02-895d-42bf-9955-917a0bd2ea8c', 2, 'Şarkı Notları Yazma', 'Write Song Notes', 'Her şarkının neden seçildiğini anlatan küçük notlar yazın.', 'Write small notes explaining why each song was chosen.', false, 3, 0),
(gen_random_uuid(), 'da51bc02-895d-42bf-9955-917a0bd2ea8c', 3, 'Playlist Kapağı Tasarlama', 'Design Playlist Cover', 'Çalma listesi için özel bir kapak görseli tasarlayın.', 'Design a special cover image for the playlist.', false, 1, 0),
(gen_random_uuid(), 'da51bc02-895d-42bf-9955-917a0bd2ea8c', 4, 'Listeyi Paylaşma', 'Share the Playlist', 'Çalma listesini partnerinizle paylaşın ve aynısını yapmasını önerin.', 'Share the playlist with your partner and suggest they do the same.', true, 0, 0),
(gen_random_uuid(), 'da51bc02-895d-42bf-9955-917a0bd2ea8c', 5, 'Birlikte Dinleme', 'Listen Together', 'Birbirinizin listelerini birlikte dinleyin ve anıları paylaşın.', 'Listen to each other''s playlists together and share memories.', true, 0, 0);

-- 74) Aşk Anı Defteri Hediyesi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '01943d4e-43fd-450a-b4c4-5b09e82223da', 1, 'Anı Defteri ve Malzeme Temini', 'Get Scrapbook and Supplies', 'Kaliteli bir anı defteri, yapıştırıcı, sticker ve dekoratif malzemeler alın.', 'Get a quality scrapbook, glue, stickers, and decorative materials.', false, 10, 400),
(gen_random_uuid(), '01943d4e-43fd-450a-b4c4-5b09e82223da', 2, 'Fotoğrafları Seçme ve Bastırma', 'Select and Print Photos', 'İlişkinizin en güzel fotoğraflarını seçin ve bastırın.', 'Select and print the most beautiful photos of your relationship.', false, 7, 300),
(gen_random_uuid(), '01943d4e-43fd-450a-b4c4-5b09e82223da', 3, 'Sayfaları Tasarlama', 'Design the Pages', 'Her sayfayı farklı bir anıya ayırarak fotoğraflar ve notlarla süsleyin.', 'Dedicate each page to a different memory and decorate with photos and notes.', false, 5, 0),
(gen_random_uuid(), '01943d4e-43fd-450a-b4c4-5b09e82223da', 4, 'Kişisel Mesajlar Ekleme', 'Add Personal Messages', 'Her sayfaya kişisel mesajlar ve duygusal notlar ekleyin.', 'Add personal messages and emotional notes to each page.', true, 2, 0),
(gen_random_uuid(), '01943d4e-43fd-450a-b4c4-5b09e82223da', 5, 'Defteri Hediye Etme', 'Gift the Scrapbook', 'Anı defterini özel bir anda partnerinize hediye edin.', 'Gift the scrapbook to your partner at a special moment.', true, 0, 0);

-- 75) Aşk Hikayesi Çizgi Roman
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '2696e49b-70bf-4030-9191-e29e32c4c7f2', 1, 'Hikaye Senaryosu Yazma', 'Write Story Script', 'İlişkinizin hikayesini çizgi roman senaryosu olarak yazın.', 'Write the story of your relationship as a comic book script.', false, 21, 0),
(gen_random_uuid(), '2696e49b-70bf-4030-9191-e29e32c4c7f2', 2, 'Çizer Bulma', 'Find an Artist', 'Çizgi roman stilinde çizim yapabilen bir illüstratör bulun.', 'Find an illustrator who can draw in comic book style.', false, 14, 3000),
(gen_random_uuid(), '2696e49b-70bf-4030-9191-e29e32c4c7f2', 3, 'Çizimleri Onaylama', 'Approve Drawings', 'İllüstratörün çizimlerini inceleyin ve gerekli düzeltmeleri yaptırın.', 'Review the illustrator''s drawings and have necessary corrections made.', false, 7, 0),
(gen_random_uuid(), '2696e49b-70bf-4030-9191-e29e32c4c7f2', 4, 'Baskı ve Ciltleme', 'Printing and Binding', 'Çizgi romanı profesyonel olarak bastırın ve ciltletin.', 'Have the comic book professionally printed and bound.', true, 5, 1000),
(gen_random_uuid(), '2696e49b-70bf-4030-9191-e29e32c4c7f2', 5, 'Çizgi Romanı Hediye Etme', 'Gift the Comic Book', 'Çizgi romanı partnerinize hediye edin ve birlikte okuyun.', 'Gift the comic book to your partner and read it together.', true, 0, 0);

-- 76) Aşk Hazine Avı
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'f0218504-faed-4556-bd1f-e2d089a83d3e', 1, 'Hazine Avı Rotası Planlama', 'Plan Treasure Hunt Route', 'Evde veya şehirde anlamlı noktalarda ipuçları saklayacağınız bir rota planlayın.', 'Plan a route at home or in the city where you will hide clues at meaningful spots.', false, 7, 0),
(gen_random_uuid(), 'f0218504-faed-4556-bd1f-e2d089a83d3e', 2, 'İpucu Kartları Hazırlama', 'Prepare Clue Cards', 'Her ipucunu yaratıcı ve eğlenceli kartlara yazın.', 'Write each clue on creative and fun cards.', false, 3, 100),
(gen_random_uuid(), 'f0218504-faed-4556-bd1f-e2d089a83d3e', 3, 'Hazineyi Hazırlama', 'Prepare the Treasure', 'Son noktada bulunacak özel bir hediye hazırlayın.', 'Prepare a special gift to be found at the final point.', false, 2, 500),
(gen_random_uuid(), 'f0218504-faed-4556-bd1f-e2d089a83d3e', 4, 'İpuçlarını Yerleştirme', 'Place the Clues', 'Tüm ipucu kartlarını belirlenen noktalara yerleştirin.', 'Place all clue cards at the designated points.', true, 1, 0),
(gen_random_uuid(), 'f0218504-faed-4556-bd1f-e2d089a83d3e', 5, 'Avı Başlatma', 'Start the Hunt', 'Partnerinize ilk ipucunu verin ve hazine avını başlatın.', 'Give your partner the first clue and start the treasure hunt.', true, 0, 0);

-- 77) Aşk Video Kapsülü
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '893c5581-a518-4038-87c9-6dd9bad5c201', 1, 'Video İçeriği Planlama', 'Plan Video Content', 'Partnerinize söylemek istediğiniz mesajları ve anıları planlayın.', 'Plan the messages and memories you want to share with your partner.', false, 7, 0),
(gen_random_uuid(), '893c5581-a518-4038-87c9-6dd9bad5c201', 2, 'Video Çekimi', 'Record Video', 'Duygusal bir video mesajı kaydedin ve eski fotoğraf veya videoları ekleyin.', 'Record an emotional video message and add old photos or videos.', false, 5, 0),
(gen_random_uuid(), '893c5581-a518-4038-87c9-6dd9bad5c201', 3, 'Video Düzenleme', 'Edit Video', 'Videoyu müzikle düzenleyin ve profesyonel bir şekilde kurgulayın.', 'Edit the video with music and produce it professionally.', false, 3, 500),
(gen_random_uuid(), '893c5581-a518-4038-87c9-6dd9bad5c201', 4, 'Zaman Kapsülü Hazırlama', 'Prepare Time Capsule', 'Videoyu USB''ye aktarın ve dekoratif bir kutuya yerleştirin.', 'Transfer the video to a USB drive and place it in a decorative box.', true, 1, 200),
(gen_random_uuid(), '893c5581-a518-4038-87c9-6dd9bad5c201', 5, 'Kapsülü Hediye Etme', 'Gift the Capsule', 'Video kapsülünü partnerinize hediye edin ve birlikte izleyin.', 'Gift the video capsule to your partner and watch it together.', true, 0, 0);

-- 78) Lüks Sürpriz Piknik
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '161e4c2b-39fb-4730-b2fe-65aca4e5b08b', 1, 'Piknik Lokasyonu Seçimi', 'Choose Picnic Location', 'Manzaralı ve sakin bir piknik lokasyonu belirleyin.', 'Choose a scenic and quiet picnic location.', false, 7, 0),
(gen_random_uuid(), '161e4c2b-39fb-4730-b2fe-65aca4e5b08b', 2, 'Lüks Piknik Seti Hazırlama', 'Prepare Luxury Picnic Set', 'Hasır sepet, porselen tabaklar, kristal kadehler ve şampanya hazırlayın.', 'Prepare a wicker basket, porcelain plates, crystal glasses, and champagne.', false, 3, 1500),
(gen_random_uuid(), '161e4c2b-39fb-4730-b2fe-65aca4e5b08b', 3, 'Gurme Yemekler Hazırlama', 'Prepare Gourmet Foods', 'Peynir tabağı, meyve, sandviçler ve özel tatlılar hazırlayın.', 'Prepare a cheese platter, fruits, sandwiches, and special desserts.', false, 1, 800),
(gen_random_uuid(), '161e4c2b-39fb-4730-b2fe-65aca4e5b08b', 4, 'Dekorasyon Kurulumu', 'Decoration Setup', 'Piknik alanını çiçekler, yastıklar ve tül perdelerle süsleyin.', 'Decorate the picnic area with flowers, pillows, and tulle curtains.', true, 1, 500),
(gen_random_uuid(), '161e4c2b-39fb-4730-b2fe-65aca4e5b08b', 5, 'Piknik Keyfi', 'Picnic Enjoyment', 'Doğanın içinde lüks bir pikniğin tadını birlikte çıkarın.', 'Enjoy a luxury picnic together in nature.', true, 0, 0);

-- 79) Ay Işığında Tekne Gezintisi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '995685b3-00f9-4bf1-889e-1d370f98c84a', 1, 'Tekne Kiralama', 'Rent a Boat', 'Gece turu yapabileceğiniz özel bir tekne kiralayın.', 'Rent a private boat for a night tour.', false, 10, 3000),
(gen_random_uuid(), '995685b3-00f9-4bf1-889e-1d370f98c84a', 2, 'Tekne Dekorasyonu', 'Boat Decoration', 'Tekneyi mumlar, ışık zincirleri ve çiçeklerle süsleyin.', 'Decorate the boat with candles, string lights, and flowers.', false, 1, 800),
(gen_random_uuid(), '995685b3-00f9-4bf1-889e-1d370f98c84a', 3, 'Yemek ve İçecek Hazırlığı', 'Food and Drink Preparation', 'Tekne üzerinde servis edilecek romantik bir akşam yemeği hazırlatın.', 'Have a romantic dinner prepared to be served on the boat.', false, 1, 1500),
(gen_random_uuid(), '995685b3-00f9-4bf1-889e-1d370f98c84a', 4, 'Müzik Listesi', 'Music Playlist', 'Ay ışığında dinlenecek romantik bir müzik listesi hazırlayın.', 'Prepare a romantic music playlist for listening under the moonlight.', true, 1, 0),
(gen_random_uuid(), '995685b3-00f9-4bf1-889e-1d370f98c84a', 5, 'Ay Işığında Seyir', 'Moonlight Cruise', 'Ay ışığında suda süzülerek romantik bir gecenin tadını çıkarın.', 'Enjoy a romantic night gliding on the water under the moonlight.', true, 0, 0);

-- 80) Gizemli Yol Gezisi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'fff66cb6-b13e-47d7-a826-959936fd0cdb', 1, 'Gizli Rota Planlama', 'Plan Secret Route', 'Partnerinize söylemeden sürpriz bir yol gezisi rotası planlayın.', 'Plan a surprise road trip route without telling your partner.', false, 10, 0),
(gen_random_uuid(), 'fff66cb6-b13e-47d7-a826-959936fd0cdb', 2, 'Araç Hazırlığı', 'Vehicle Preparation', 'Aracı kontrol ettirin ve yol için yastık, battaniye hazırlayın.', 'Have the vehicle checked and prepare pillows and blankets for the road.', false, 3, 500),
(gen_random_uuid(), 'fff66cb6-b13e-47d7-a826-959936fd0cdb', 3, 'Yol Atıştırmalıkları', 'Road Snacks', 'Yol için özel atıştırmalıklar, içecekler ve müzik listesi hazırlayın.', 'Prepare special snacks, drinks, and a music playlist for the road.', false, 1, 300),
(gen_random_uuid(), 'fff66cb6-b13e-47d7-a826-959936fd0cdb', 4, 'Sürpriz Duraklar Planlama', 'Plan Surprise Stops', 'Yol üzerinde sürpriz mola noktaları ve aktiviteler planlayın.', 'Plan surprise stop points and activities along the way.', true, 3, 500),
(gen_random_uuid(), 'fff66cb6-b13e-47d7-a826-959936fd0cdb', 5, 'Maceraya Çıkma', 'Hit the Road', 'Partnerinizi araca alın ve gizemli yol macerasını başlatın.', 'Pick up your partner and start the mystery road adventure.', true, 0, 0);

-- 81) Kuzey Işıkları Yatak Odası
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '1d958e42-4a70-431e-9893-b8b16d3c1b75', 1, 'Aurora Projektörü Temini', 'Get Aurora Projector', 'Kuzey ışıkları efekti yaratan bir LED projektör satın alın.', 'Purchase an LED projector that creates a northern lights effect.', false, 7, 800),
(gen_random_uuid(), '1d958e42-4a70-431e-9893-b8b16d3c1b75', 2, 'Oda Düzenlemesi', 'Room Arrangement', 'Yatak odasını karartın ve projektörü en iyi konuma yerleştirin.', 'Darken the bedroom and position the projector in the best spot.', false, 2, 0),
(gen_random_uuid(), '1d958e42-4a70-431e-9893-b8b16d3c1b75', 3, 'Romantik Detaylar', 'Romantic Details', 'Odaya gül yaprakları, mumlar ve aromatik difüzör ekleyin.', 'Add rose petals, candles, and an aromatic diffuser to the room.', false, 1, 300),
(gen_random_uuid(), '1d958e42-4a70-431e-9893-b8b16d3c1b75', 4, 'Müzik ve Ses Efektleri', 'Music and Sound Effects', 'Doğa sesleri ve sakin müzik içeren bir çalma listesi ayarlayın.', 'Set up a playlist with nature sounds and calm music.', true, 1, 0),
(gen_random_uuid(), '1d958e42-4a70-431e-9893-b8b16d3c1b75', 5, 'Aurora Deneyimi', 'Aurora Experience', 'Partnerinizi odaya davet edin ve kuzey ışıkları altında romantik bir gece geçirin.', 'Invite your partner to the room and spend a romantic night under the northern lights.', true, 0, 0);

-- 82) Parkta Piknik Sürprizi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000004', 1, 'Park Seçimi', 'Choose the Park', 'Güzel manzarası olan sakin bir park seçin.', 'Choose a quiet park with a beautiful view.', false, 5, 0),
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000004', 2, 'Piknik Sepeti Hazırlama', 'Prepare Picnic Basket', 'Sandviçler, meyveler, içecekler ve tatlılarla piknik sepeti hazırlayın.', 'Prepare a picnic basket with sandwiches, fruits, drinks, and desserts.', false, 1, 400),
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000004', 3, 'Piknik Alanı Kurma', 'Set Up Picnic Area', 'Örtü, yastıklar ve çiçeklerle piknik alanını kurun.', 'Set up the picnic area with a blanket, pillows, and flowers.', false, 1, 200),
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000004', 4, 'Aktivite Hazırlama', 'Prepare Activities', 'Kutu oyunu, kitap veya müzik gibi aktiviteler hazırlayın.', 'Prepare activities like board games, books, or music.', true, 1, 100),
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000004', 5, 'Sürpriz Piknik', 'Surprise Picnic', 'Partnerinizi parka götürün ve sürpriz pikniği açıklayın.', 'Take your partner to the park and reveal the surprise picnic.', true, 0, 0);

-- 83) Yıldızların Altında Piknik
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'b7abd3e1-af05-43e4-a617-44033c9ec047', 1, 'Gece Piknik Lokasyonu Seçimi', 'Choose Night Picnic Location', 'Işık kirliliğinden uzak, yıldızları görebileceğiniz bir yer seçin.', 'Choose a location away from light pollution where you can see the stars.', false, 7, 0),
(gen_random_uuid(), 'b7abd3e1-af05-43e4-a617-44033c9ec047', 2, 'Piknik Ekipmanı Hazırlama', 'Prepare Picnic Equipment', 'Kalın battaniyeler, yastıklar, fener ve termos hazırlayın.', 'Prepare thick blankets, pillows, lanterns, and a thermos.', false, 3, 400),
(gen_random_uuid(), 'b7abd3e1-af05-43e4-a617-44033c9ec047', 3, 'Yiyecek ve İçecek', 'Food and Drink', 'Sıcak çikolata, sandviçler ve tatlılar hazırlayın.', 'Prepare hot chocolate, sandwiches, and desserts.', false, 1, 300),
(gen_random_uuid(), 'b7abd3e1-af05-43e4-a617-44033c9ec047', 4, 'Yıldız Haritası Temini', 'Get Star Map', 'Yıldız takımyıldızlarını tanımanıza yardımcı olacak bir uygulama veya harita hazırlayın.', 'Prepare an app or map to help identify star constellations.', true, 1, 0),
(gen_random_uuid(), 'b7abd3e1-af05-43e4-a617-44033c9ec047', 5, 'Yıldızlar Altında Gece', 'Night Under the Stars', 'Birlikte yıldızları izleyerek romantik bir gece geçirin.', 'Spend a romantic night watching the stars together.', true, 0, 0);

-- 84) Evde Pop-up Restoran
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '95383ebf-decc-43af-832d-51d11655bac0', 1, 'Menü Tasarlama', 'Design the Menu', 'Üç veya dört çeşitten oluşan bir fine dining menüsü tasarlayın.', 'Design a fine dining menu with three or four courses.', false, 7, 0),
(gen_random_uuid(), '95383ebf-decc-43af-832d-51d11655bac0', 2, 'Malzeme Alışverişi', 'Grocery Shopping', 'Menü için gerekli tüm kaliteli malzemeleri satın alın.', 'Purchase all quality ingredients needed for the menu.', false, 2, 800),
(gen_random_uuid(), '95383ebf-decc-43af-832d-51d11655bac0', 3, 'Mekan Dekorasyonu', 'Venue Decoration', 'Yemek odasını restoran gibi süsleyin: masa örtüsü, mumlar, çiçekler.', 'Decorate the dining room like a restaurant: tablecloth, candles, flowers.', false, 1, 500),
(gen_random_uuid(), '95383ebf-decc-43af-832d-51d11655bac0', 4, 'Menü Kartı ve Garsonluk', 'Menu Card and Service', 'Basılı menü kartı hazırlayın ve garson gibi servis yapın.', 'Prepare a printed menu card and serve like a waiter.', true, 1, 100),
(gen_random_uuid(), '95383ebf-decc-43af-832d-51d11655bac0', 5, 'Fine Dining Deneyimi', 'Fine Dining Experience', 'Yemekleri tek tek servis edin ve evde restoran deneyimini yaşatın.', 'Serve dishes one by one and create a restaurant experience at home.', true, 0, 0);

-- 85) Seni Sevmemin Nedenleri Kavanozu
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '8917b477-0353-4bdb-8336-5ad427bb8cb4', 1, 'Kavanoz ve Kağıt Temini', 'Get Jar and Paper', 'Dekoratif bir cam kavanoz ve renkli kağıtlar satın alın.', 'Buy a decorative glass jar and colorful papers.', false, 5, 150),
(gen_random_uuid(), '8917b477-0353-4bdb-8336-5ad427bb8cb4', 2, 'Nedenleri Yazma', 'Write the Reasons', 'Partnerinizi sevmenizin en az 50 nedenini kağıtlara yazın.', 'Write at least 50 reasons why you love your partner on the papers.', false, 3, 0),
(gen_random_uuid(), '8917b477-0353-4bdb-8336-5ad427bb8cb4', 3, 'Kavanozu Süsleme', 'Decorate the Jar', 'Kavanozu kurdeleler, etiketler ve süslemelerle güzelleştirin.', 'Beautify the jar with ribbons, labels, and decorations.', false, 1, 100),
(gen_random_uuid(), '8917b477-0353-4bdb-8336-5ad427bb8cb4', 4, 'Kağıtları Katlayıp Yerleştirme', 'Fold and Place Papers', 'Kağıtları küçük rulolar halinde katlayıp kavanoza yerleştirin.', 'Fold the papers into small scrolls and place them in the jar.', true, 1, 0),
(gen_random_uuid(), '8917b477-0353-4bdb-8336-5ad427bb8cb4', 5, 'Kavanozu Hediye Etme', 'Gift the Jar', 'Kavanozu partnerinize hediye edin ve ilk kağıdı birlikte okuyun.', 'Gift the jar to your partner and read the first paper together.', true, 0, 0);

-- 86) Romantik Tren Yolculuğu
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'f9e3ab81-2368-48e5-8927-af573d5d0694', 1, 'Tren Rotası Araştırma', 'Research Train Route', 'Manzaralı bir tren rotası araştırın ve bilet alın.', 'Research a scenic train route and book tickets.', false, 14, 1500),
(gen_random_uuid(), 'f9e3ab81-2368-48e5-8927-af573d5d0694', 2, 'Konaklama Ayarlama', 'Arrange Accommodation', 'Varış noktasında romantik bir konaklama ayarlayın.', 'Arrange romantic accommodation at the destination.', false, 10, 2000),
(gen_random_uuid(), 'f9e3ab81-2368-48e5-8927-af573d5d0694', 3, 'Yolculuk Sepeti Hazırlama', 'Prepare Travel Basket', 'Tren yolculuğu için özel atıştırmalıklar ve içecekler hazırlayın.', 'Prepare special snacks and drinks for the train journey.', false, 1, 400),
(gen_random_uuid(), 'f9e3ab81-2368-48e5-8927-af573d5d0694', 4, 'Sürpriz Planı', 'Surprise Plan', 'Partnerinize sıradan bir gezi gibi gösterin ve sürprizi saklayın.', 'Present it to your partner as a casual trip and keep the surprise hidden.', true, 1, 0),
(gen_random_uuid(), 'f9e3ab81-2368-48e5-8927-af573d5d0694', 5, 'Romantik Yolculuk', 'Romantic Journey', 'Manzaranın tadını çıkararak romantik bir tren yolculuğu yapın.', 'Enjoy a romantic train journey while taking in the scenery.', true, 0, 0);

-- 87) Çatıda Yıldız Işığı Yemeği
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'c39cfaff-ccc6-49f4-923d-578b70aa03f8', 1, 'Çatı Mekanı Ayarlama', 'Arrange Rooftop Venue', 'Yıldızları görebileceğiniz bir çatı katı veya teras ayarlayın.', 'Arrange a rooftop or terrace where you can see the stars.', false, 7, 1000),
(gen_random_uuid(), 'c39cfaff-ccc6-49f4-923d-578b70aa03f8', 2, 'Yemek Hazırlığı', 'Dinner Preparation', 'Özel bir akşam yemeği menüsü hazırlayın veya sipariş verin.', 'Prepare or order a special dinner menu.', false, 3, 1000),
(gen_random_uuid(), 'c39cfaff-ccc6-49f4-923d-578b70aa03f8', 3, 'Işık ve Dekorasyon', 'Lighting and Decoration', 'Çatıyı ışık zincirleri, mumlar ve çiçeklerle süsleyin.', 'Decorate the rooftop with string lights, candles, and flowers.', false, 1, 800),
(gen_random_uuid(), 'c39cfaff-ccc6-49f4-923d-578b70aa03f8', 4, 'Müzik Hazırlığı', 'Music Preparation', 'Kablosuz hoparlör ve romantik müzik listesi hazırlayın.', 'Prepare a wireless speaker and romantic music playlist.', true, 1, 0),
(gen_random_uuid(), 'c39cfaff-ccc6-49f4-923d-578b70aa03f8', 5, 'Yıldız Işığında Yemek', 'Dinner Under Starlight', 'Yıldızların altında romantik bir akşam yemeğinin tadını çıkarın.', 'Enjoy a romantic dinner under the stars.', true, 0, 0);

-- 88) Rumi Şiiri ve İran Çay Seremonisi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '0efa9017-7ad6-469f-99a5-17ede11f6141', 1, 'Rumi Şiirleri Seçimi', 'Select Rumi Poems', 'Mevlana''nın en güzel aşk şiirlerini araştırın ve seçin.', 'Research and select the most beautiful love poems by Rumi.', false, 7, 0),
(gen_random_uuid(), '0efa9017-7ad6-469f-99a5-17ede11f6141', 2, 'İran Çay Seti Temini', 'Get Persian Tea Set', 'Geleneksel İran çay bardakları, semaver ve özel çay satın alın.', 'Purchase traditional Persian tea glasses, samovar, and special tea.', false, 5, 500),
(gen_random_uuid(), '0efa9017-7ad6-469f-99a5-17ede11f6141', 3, 'Mekan Hazırlığı', 'Venue Preparation', 'Halılar, yastıklar ve tütsülerle oryantal bir ortam hazırlayın.', 'Prepare an oriental setting with carpets, cushions, and incense.', false, 2, 400),
(gen_random_uuid(), '0efa9017-7ad6-469f-99a5-17ede11f6141', 4, 'Tatlı ve İkram Hazırlığı', 'Prepare Sweets and Treats', 'Baklava, lokum ve kuru meyvelerden oluşan bir ikram tabağı hazırlayın.', 'Prepare a treat platter with baklava, Turkish delight, and dried fruits.', true, 1, 300),
(gen_random_uuid(), '0efa9017-7ad6-469f-99a5-17ede11f6141', 5, 'Çay Seremonisi ve Şiir', 'Tea Ceremony and Poetry', 'Birlikte çay içerken Rumi şiirlerini sesli okuyun.', 'Read Rumi poems aloud while drinking tea together.', true, 0, 0);

-- 89) Zamanlanmış Aşk Mesajları
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '8035f534-7137-42c4-bdc9-30179355e175', 1, 'Mesaj İçerikleri Yazma', 'Write Message Contents', 'Günün farklı saatlerinde gönderilecek duygusal mesajlar yazın.', 'Write emotional messages to be sent at different times of the day.', false, 5, 0),
(gen_random_uuid(), '8035f534-7137-42c4-bdc9-30179355e175', 2, 'Zamanlama Planı Oluşturma', 'Create Timing Plan', 'Her mesajın gönderileceği saati ve günü belirleyin.', 'Determine the time and day each message will be sent.', false, 3, 0),
(gen_random_uuid(), '8035f534-7137-42c4-bdc9-30179355e175', 3, 'Mesajları Zamanlama', 'Schedule Messages', 'Mesajları zamanlama uygulaması veya e-posta servisiyle programlayın.', 'Program the messages using a scheduling app or email service.', false, 1, 0),
(gen_random_uuid(), '8035f534-7137-42c4-bdc9-30179355e175', 4, 'Fiziksel Sürprizler Ekleme', 'Add Physical Surprises', 'Bazı mesajlarla eş zamanlı fiziksel sürprizler hazırlayın.', 'Prepare physical surprises synchronized with some messages.', true, 1, 300),
(gen_random_uuid(), '8035f534-7137-42c4-bdc9-30179355e175', 5, 'Son Mesaj Buluşması', 'Final Message Reunion', 'Son mesajda buluşma noktasını yazın ve sürprizi sonlandırın.', 'Write the meeting point in the final message and conclude the surprise.', true, 0, 0);

-- 90) Gizli Buluşma Açıklaması
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '83710242-6536-4049-803f-59b985c688fa', 1, 'Sürpriz Buluşma Planlama', 'Plan Secret Date', 'Partnerinize söylemeden gizli bir buluşma planı yapın.', 'Make a secret date plan without telling your partner.', false, 7, 0),
(gen_random_uuid(), '83710242-6536-4049-803f-59b985c688fa', 2, 'Mekan ve Aktivite Ayarlama', 'Arrange Venue and Activity', 'Özel bir restoran, aktivite veya etkinlik ayarlayın.', 'Arrange a special restaurant, activity, or event.', false, 5, 1500),
(gen_random_uuid(), '83710242-6536-4049-803f-59b985c688fa', 3, 'Kıyafet İpucu Verme', 'Give Dress Code Hint', 'Partnerinize sadece kıyafet konusunda ipucu verin.', 'Give your partner only a hint about the dress code.', false, 1, 0),
(gen_random_uuid(), '83710242-6536-4049-803f-59b985c688fa', 4, 'Ulaşım Ayarlama', 'Arrange Transportation', 'Özel bir araç veya taksi ayarlayarak buluşmaya götürün.', 'Arrange a special vehicle or taxi to take them to the date.', true, 1, 300),
(gen_random_uuid(), '83710242-6536-4049-803f-59b985c688fa', 5, 'Sürprizi Açıklama', 'Reveal the Surprise', 'Partnerinizi varış noktasında karşılayın ve sürprizi açıklayın.', 'Meet your partner at the destination and reveal the surprise.', true, 0, 0);

-- 91) Gizli Mesaj Bahçesi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a4a42467-d017-4e1b-aa10-3324d87662fc', 1, 'Bitki ve Saksı Temini', 'Get Plants and Pots', 'Küçük bitkiler, saksılar ve bahçe malzemeleri satın alın.', 'Purchase small plants, pots, and garden supplies.', false, 7, 400),
(gen_random_uuid(), 'a4a42467-d017-4e1b-aa10-3324d87662fc', 2, 'Mesaj Çubukları Hazırlama', 'Prepare Message Sticks', 'Her bitkinin yanına küçük mesaj çubukları yerleştirmek için notlar yazın.', 'Write notes to place on small message sticks next to each plant.', false, 3, 100),
(gen_random_uuid(), 'a4a42467-d017-4e1b-aa10-3324d87662fc', 3, 'Bahçe Düzenleme', 'Garden Arrangement', 'Bitkileri saksılara ekin ve mesaj çubuklarını yerleştirin.', 'Plant the plants in pots and place the message sticks.', false, 1, 0),
(gen_random_uuid(), 'a4a42467-d017-4e1b-aa10-3324d87662fc', 4, 'Bahçeyi Süsleme', 'Decorate the Garden', 'Mini bahçeyi taşlar, küçük figürler ve ışıklarla süsleyin.', 'Decorate the mini garden with stones, small figurines, and lights.', true, 1, 200),
(gen_random_uuid(), 'a4a42467-d017-4e1b-aa10-3324d87662fc', 5, 'Bahçeyi Hediye Etme', 'Gift the Garden', 'Gizli mesaj bahçesini partnerinize hediye edin ve mesajları keşfetmesini izleyin.', 'Gift the secret message garden to your partner and watch them discover the messages.', true, 0, 0);

-- 92) La Serenata Moderna
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '6960b6cf-36b3-467d-b1fa-c657ca8931a0', 1, 'Müzisyen Bulma', 'Find Musicians', 'Serenat yapabilecek bir müzisyen veya küçük grup bulun.', 'Find a musician or small group that can perform a serenade.', false, 14, 2000),
(gen_random_uuid(), '6960b6cf-36b3-467d-b1fa-c657ca8931a0', 2, 'Şarkı Seçimi', 'Song Selection', 'Partnerinize özel anlam taşıyan şarkıları müzisyenlerle belirleyin.', 'Choose songs with special meaning for your partner together with the musicians.', false, 7, 0),
(gen_random_uuid(), '6960b6cf-36b3-467d-b1fa-c657ca8931a0', 3, 'Lokasyon ve Zamanlama', 'Location and Timing', 'Serenatın yapılacağı yeri ve saati belirleyin.', 'Determine the place and time for the serenade.', false, 3, 0),
(gen_random_uuid(), '6960b6cf-36b3-467d-b1fa-c657ca8931a0', 4, 'Çiçek ve Hediye Hazırlığı', 'Flower and Gift Prep', 'Serenat sırasında sunulacak çiçek buketi ve hediye hazırlayın.', 'Prepare a flower bouquet and gift to present during the serenade.', true, 1, 500),
(gen_random_uuid(), '6960b6cf-36b3-467d-b1fa-c657ca8931a0', 5, 'Modern Serenat', 'Modern Serenade', 'Müzisyenlerle birlikte partnerinize sürpriz bir serenat yapın.', 'Perform a surprise serenade for your partner with the musicians.', true, 0, 0);

-- 93) Gökyüzü Feneri Dilek Töreni
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a90765bc-3510-4a10-9539-0d8ec7e65fde', 1, 'Gökyüzü Feneri Temini', 'Get Sky Lanterns', 'Güvenli ve çevre dostu gökyüzü fenerleri satın alın.', 'Purchase safe and eco-friendly sky lanterns.', false, 7, 400),
(gen_random_uuid(), 'a90765bc-3510-4a10-9539-0d8ec7e65fde', 2, 'Tören Lokasyonu Seçimi', 'Choose Ceremony Location', 'Açık alan, göl kenarı veya sahil gibi güvenli bir lokasyon belirleyin.', 'Choose a safe location like an open field, lakeside, or beach.', false, 5, 0),
(gen_random_uuid(), 'a90765bc-3510-4a10-9539-0d8ec7e65fde', 3, 'Dilek Kartları Hazırlama', 'Prepare Wish Cards', 'Dileklerinizi yazacağınız özel kartlar ve kalemler hazırlayın.', 'Prepare special cards and pens to write your wishes.', false, 2, 50),
(gen_random_uuid(), 'a90765bc-3510-4a10-9539-0d8ec7e65fde', 4, 'Romantik Ortam Kurma', 'Set Romantic Atmosphere', 'Battaniyeler, mumlar ve sıcak içeceklerle ortam oluşturun.', 'Create an atmosphere with blankets, candles, and hot drinks.', true, 1, 300),
(gen_random_uuid(), 'a90765bc-3510-4a10-9539-0d8ec7e65fde', 5, 'Fenerleri Uçurma', 'Release the Lanterns', 'Dileklerinizi yazın ve fenerleri birlikte gökyüzüne bırakın.', 'Write your wishes and release the lanterns into the sky together.', true, 0, 0);

-- 94) Çatıda Yıldız Gözlemi Buluşması
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '74dea79d-9419-487d-a000-242dd0c3c181', 1, 'Teleskop ve Ekipman Temini', 'Get Telescope and Equipment', 'Yıldız gözlemi için teleskop veya dürbün temin edin.', 'Obtain a telescope or binoculars for stargazing.', false, 7, 1000),
(gen_random_uuid(), '74dea79d-9419-487d-a000-242dd0c3c181', 2, 'Çatı Mekanı Hazırlama', 'Prepare Rooftop Venue', 'Çatıya battaniye, yastık ve oturma alanı kurun.', 'Set up blankets, pillows, and a seating area on the rooftop.', false, 1, 300),
(gen_random_uuid(), '74dea79d-9419-487d-a000-242dd0c3c181', 3, 'Atıştırmalık Hazırlığı', 'Prepare Snacks', 'Sıcak çikolata, termos ve atıştırmalıklar hazırlayın.', 'Prepare hot chocolate, a thermos, and snacks.', false, 1, 200),
(gen_random_uuid(), '74dea79d-9419-487d-a000-242dd0c3c181', 4, 'Yıldız Haritası İndirme', 'Download Star Map', 'Yıldız takımyıldızlarını tanıyabileceğiniz bir uygulama indirin.', 'Download an app that can identify star constellations.', true, 1, 0),
(gen_random_uuid(), '74dea79d-9419-487d-a000-242dd0c3c181', 5, 'Yıldız Gözlemi', 'Stargazing', 'Birlikte teleskopla yıldızları gözlemleyin ve takımyıldızları keşfedin.', 'Observe the stars together through the telescope and discover constellations.', true, 0, 0);

-- 95) Sahilde Gün Doğumu Kahvaltısı
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '4d6bb609-892a-4730-8a1c-3b648010bc23', 1, 'Sahil Lokasyonu Seçimi', 'Choose Beach Location', 'Gün doğumunu izleyebileceğiniz sakin bir sahil seçin.', 'Choose a quiet beach where you can watch the sunrise.', false, 5, 0),
(gen_random_uuid(), '4d6bb609-892a-4730-8a1c-3b648010bc23', 2, 'Kahvaltı Menüsü Hazırlama', 'Prepare Breakfast Menu', 'Taze simit, peynir, bal, meyve ve çay içeren bir kahvaltı hazırlayın.', 'Prepare a breakfast with fresh simit, cheese, honey, fruit, and tea.', false, 1, 300),
(gen_random_uuid(), '4d6bb609-892a-4730-8a1c-3b648010bc23', 3, 'Piknik Seti Hazırlama', 'Prepare Picnic Set', 'Piknik örtüsü, yastıklar ve termos hazırlayın.', 'Prepare a picnic blanket, pillows, and thermos.', false, 1, 200),
(gen_random_uuid(), '4d6bb609-892a-4730-8a1c-3b648010bc23', 4, 'Erken Kalkış Planı', 'Early Wake-Up Plan', 'Gün doğumundan önce sahile ulaşmak için alarm kurun.', 'Set an alarm to reach the beach before sunrise.', true, 0, 0),
(gen_random_uuid(), '4d6bb609-892a-4730-8a1c-3b648010bc23', 5, 'Gün Doğumu Kahvaltısı', 'Sunrise Breakfast', 'Sahilde gün doğumunu izleyerek romantik bir kahvaltının keyfini çıkarın.', 'Enjoy a romantic breakfast on the beach while watching the sunrise.', true, 0, 0);

-- 96) Gün Batımı Yelken Sürprizi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '61f28feb-cc22-49fd-a2b6-9786fd2b69b0', 1, 'Yelkenli Tekne Kiralama', 'Rent a Sailboat', 'Gün batımı saatinde kullanabileceğiniz bir yelkenli tekne kiralayın.', 'Rent a sailboat available at sunset time.', false, 10, 3000),
(gen_random_uuid(), '61f28feb-cc22-49fd-a2b6-9786fd2b69b0', 2, 'Tekne Dekorasyonu', 'Boat Decoration', 'Tekneyi çiçekler, ışıklar ve yastıklarla süsleyin.', 'Decorate the boat with flowers, lights, and pillows.', false, 1, 800),
(gen_random_uuid(), '61f28feb-cc22-49fd-a2b6-9786fd2b69b0', 3, 'Yiyecek ve İçecek', 'Food and Drink', 'Şampanya, meyve tabağı ve hafif atıştırmalıklar hazırlayın.', 'Prepare champagne, a fruit platter, and light snacks.', false, 1, 600),
(gen_random_uuid(), '61f28feb-cc22-49fd-a2b6-9786fd2b69b0', 4, 'Müzik Hazırlığı', 'Music Preparation', 'Denizde dinlenecek sakin bir müzik listesi hazırlayın.', 'Prepare a calm music playlist to listen to at sea.', true, 1, 0),
(gen_random_uuid(), '61f28feb-cc22-49fd-a2b6-9786fd2b69b0', 5, 'Gün Batımında Yelken', 'Sunset Sailing', 'Gün batımında yelken açarak denizin ortasında romantik bir an yaşayın.', 'Set sail at sunset and experience a romantic moment in the middle of the sea.', true, 0, 0);

-- 97) Sürpriz Hafta Sonu Kaçamağı
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000005', 1, 'Destinasyon Seçimi', 'Choose Destination', 'Partnerinizin sevebileceği sürpriz bir hafta sonu kaçamağı destinasyonu seçin.', 'Choose a surprise weekend getaway destination your partner would love.', false, 14, 0),
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000005', 2, 'Konaklama ve Ulaşım Rezervasyonu', 'Book Accommodation and Transport', 'Otel, uçak bileti veya araç kiralama gibi rezervasyonları yapın.', 'Make reservations for hotel, flight tickets, or car rental.', false, 10, 5000),
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000005', 3, 'Bavul Hazırlığı', 'Pack the Bags', 'Partnerinizin bavulunu gizlice hazırlayın veya bir çanta listesi oluşturun.', 'Secretly pack your partner''s bag or create a packing list.', false, 2, 0),
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000005', 4, 'Aktivite Planlaması', 'Plan Activities', 'Destinasyondaki aktiviteleri ve restoranları araştırıp planlayın.', 'Research and plan activities and restaurants at the destination.', true, 5, 0),
(gen_random_uuid(), 'a0000004-0001-0001-0001-000000000005', 5, 'Sürprizi Açıklama', 'Reveal the Surprise', 'Partnerinize kaçamak sürprizini açıklayın ve yola çıkın.', 'Reveal the getaway surprise to your partner and hit the road.', true, 0, 0);

-- 98) Türk Kahvesi Buluşma Sürprizi
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '9918d010-478f-42cb-b1d6-3bf504e82440', 1, 'Türk Kahvesi Seti Temini', 'Get Turkish Coffee Set', 'Geleneksel cezve, fincan ve özel Türk kahvesi satın alın.', 'Purchase a traditional cezve, cups, and special Turkish coffee.', false, 5, 300),
(gen_random_uuid(), '9918d010-478f-42cb-b1d6-3bf504e82440', 2, 'Ortam Hazırlığı', 'Prepare Setting', 'Rahat yastıklar, vintage masa örtüsü ve mumlarla ortam hazırlayın.', 'Prepare the setting with comfortable cushions, vintage tablecloth, and candles.', false, 2, 200),
(gen_random_uuid(), '9918d010-478f-42cb-b1d6-3bf504e82440', 3, 'Lokum ve İkramlar', 'Turkish Delight and Treats', 'Türk lokumu, baklava ve kurabiye gibi ikramlar hazırlayın.', 'Prepare treats like Turkish delight, baklava, and cookies.', false, 1, 200),
(gen_random_uuid(), '9918d010-478f-42cb-b1d6-3bf504e82440', 4, 'Kahve Hazırlama Ritüeli', 'Coffee Making Ritual', 'Geleneksel yöntemle partnerinize özel Türk kahvesi pişirin.', 'Brew special Turkish coffee for your partner using the traditional method.', true, 0, 0),
(gen_random_uuid(), '9918d010-478f-42cb-b1d6-3bf504e82440', 5, 'Kahve Keyfi ve Sohbet', 'Coffee and Conversation', 'Birlikte kahve içip sohbet edin ve fincanları çevirerek fal bakın.', 'Drink coffee together, chat, and read each other''s fortunes by flipping the cups.', true, 0, 0);

-- 99) Evde Spa Günü
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a0000007-0001-0001-0001-000000000002', 1, 'Spa Malzemeleri Alışverişi', 'Shop for Spa Supplies', 'Yüz maskesi, banyo bombası, masaj yağı ve vücut peelingi satın alın.', 'Purchase face masks, bath bombs, massage oil, and body scrub.', false, 5, 600),
(gen_random_uuid(), 'a0000007-0001-0001-0001-000000000002', 2, 'Banyo Hazırlığı', 'Bathroom Preparation', 'Banyoyu mumlar, aromaterapi yağları ve çiçek yapraklarıyla hazırlayın.', 'Prepare the bathroom with candles, aromatherapy oils, and flower petals.', false, 1, 300),
(gen_random_uuid(), 'a0000007-0001-0001-0001-000000000002', 3, 'Spa Programı Oluşturma', 'Create Spa Program', 'Banyo, maske, masaj ve bakım adımlarından oluşan bir program yapın.', 'Create a program with bath, mask, massage, and care steps.', false, 1, 0),
(gen_random_uuid(), 'a0000007-0001-0001-0001-000000000002', 4, 'Sağlıklı İçecekler Hazırlama', 'Prepare Healthy Drinks', 'Salatalık suyu, yeşil çay ve smoothie hazırlayın.', 'Prepare cucumber water, green tea, and smoothies.', true, 1, 150),
(gen_random_uuid(), 'a0000007-0001-0001-0001-000000000002', 5, 'Spa Deneyimi', 'Spa Experience', 'Birlikte evde spa gününün keyfini çıkarın ve rahatlayın.', 'Enjoy the home spa day together and relax.', true, 0, 0);

-- 100) Sevgililer Günü Hazine Avı
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a0000007-0001-0001-0001-000000000001', 1, 'Hazine Avı Rotası Planlama', 'Plan Scavenger Hunt Route', 'Evin içinde veya dışında ipuçları saklayacağınız bir rota oluşturun.', 'Create a route inside or outside the house where you will hide clues.', false, 7, 0),
(gen_random_uuid(), 'a0000007-0001-0001-0001-000000000001', 2, 'İpuçları ve Bilmeceler Yazma', 'Write Clues and Riddles', 'Her durak için eğlenceli bilmeceler ve ipuçları yazın.', 'Write fun riddles and clues for each stop.', false, 5, 0),
(gen_random_uuid(), 'a0000007-0001-0001-0001-000000000001', 3, 'Hediye ve Ödül Hazırlama', 'Prepare Gifts and Prizes', 'Son durak için özel bir Sevgililer Günü hediyesi hazırlayın.', 'Prepare a special Valentine''s Day gift for the final stop.', false, 3, 1000),
(gen_random_uuid(), 'a0000007-0001-0001-0001-000000000001', 4, 'İpuçlarını Yerleştirme', 'Place the Clues', 'Tüm ipuçlarını ve küçük sürprizleri belirlenen noktalara yerleştirin.', 'Place all clues and small surprises at the designated points.', true, 1, 200),
(gen_random_uuid(), 'a0000007-0001-0001-0001-000000000001', 5, 'Hazine Avını Başlatma', 'Start the Scavenger Hunt', 'Partnerinize ilk ipucunu verin ve hazine avını başlatın.', 'Give your partner the first clue and start the scavenger hunt.', true, 0, 0);
