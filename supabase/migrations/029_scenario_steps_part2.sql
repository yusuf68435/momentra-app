-- =====================================================
-- Scenario Steps Part 2
-- ~103 scenarios x 4-5 steps each
-- =====================================================

-- 1. Song Dedication Apology
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '9dd88af0-306e-4c2c-8372-aba1a128e12d', 1, 'Şarkı Seçimi', 'Song Selection', 'İlişkinizi en iyi anlatan anlamlı bir şarkı seçin.', 'Choose a meaningful song that best represents your relationship.', false, 7, 0),
(gen_random_uuid(), '9dd88af0-306e-4c2c-8372-aba1a128e12d', 2, 'İthaf Mesajı Hazırlama', 'Prepare Dedication Message', 'Şarkıyla birlikte sunulacak samimi bir özür mesajı yazın.', 'Write a heartfelt apology message to accompany the song.', false, 5, 0),
(gen_random_uuid(), '9dd88af0-306e-4c2c-8372-aba1a128e12d', 3, 'Sunum Yöntemi Belirleme', 'Choose Delivery Method', 'Şarkıyı radyoda, çevrimiçi platformda veya canlı olarak nasıl ithaf edeceğinizi belirleyin.', 'Decide how to dedicate the song: via radio, online platform, or live performance.', false, 3, 200),
(gen_random_uuid(), '9dd88af0-306e-4c2c-8372-aba1a128e12d', 4, 'Ortam Hazırlığı', 'Set the Atmosphere', 'Şarkının çalınacağı ortamı mumlar veya çiçeklerle süsleyin.', 'Decorate the space where the song will play with candles or flowers.', true, 1, 150),
(gen_random_uuid(), '9dd88af0-306e-4c2c-8372-aba1a128e12d', 5, 'Şarkıyı Sunma', 'Present the Song', 'Şarkıyı çalın ve özür mesajınızı samimiyetle iletin.', 'Play the song and sincerely deliver your apology message.', true, 0, 0);

-- 2. Spa Gift Apology
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '22dd6a57-5dfe-40cc-8369-86ea0b01c25a', 1, 'Spa Araştırması', 'Spa Research', 'Yakındaki en iyi spa merkezlerini araştırın ve fiyatları karşılaştırın.', 'Research the best nearby spa centers and compare prices.', false, 7, 0),
(gen_random_uuid(), '22dd6a57-5dfe-40cc-8369-86ea0b01c25a', 2, 'Spa Rezervasyonu', 'Book Spa Appointment', 'Uygun bir tarih ve saat için spa randevusu oluşturun.', 'Book a spa appointment for a suitable date and time.', false, 5, 1500),
(gen_random_uuid(), '22dd6a57-5dfe-40cc-8369-86ea0b01c25a', 3, 'Özür Kartı Yazma', 'Write Apology Card', 'Spa hediye kartıyla birlikte verilecek el yazısıyla bir özür kartı hazırlayın.', 'Prepare a handwritten apology card to accompany the spa gift certificate.', false, 3, 50),
(gen_random_uuid(), '22dd6a57-5dfe-40cc-8369-86ea0b01c25a', 4, 'Hediye Paketi Hazırlama', 'Prepare Gift Package', 'Spa kartını güzel bir kutuyla birlikte bornoz veya havlu hediyesiyle paketleyin.', 'Package the spa card in a nice box along with a bathrobe or towel gift.', true, 1, 300),
(gen_random_uuid(), '22dd6a57-5dfe-40cc-8369-86ea0b01c25a', 5, 'Hediyeyi Sunma', 'Present the Gift', 'Hediyeyi kişisel olarak verin ve içten bir şekilde özür dileyin.', 'Personally deliver the gift and sincerely apologize.', true, 0, 0);

-- 3. Spotify Code Keychain Gift
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '814b9f9e-618d-40bd-bec9-11eb64ea35fb', 1, 'Özel Şarkı Seçimi', 'Choose the Special Song', 'İkiniz için anlam taşıyan bir şarkıyı Spotify''da bulun.', 'Find a song on Spotify that holds special meaning for both of you.', false, 10, 0),
(gen_random_uuid(), '814b9f9e-618d-40bd-bec9-11eb64ea35fb', 2, 'Spotify Kodu Alma', 'Get Spotify Code', 'Şarkının Spotify kodunu ekran görüntüsü olarak kaydedin.', 'Save the Spotify code of the song as a screenshot.', false, 8, 0),
(gen_random_uuid(), '814b9f9e-618d-40bd-bec9-11eb64ea35fb', 3, 'Anahtarlık Siparişi', 'Order Keychain', 'Spotify kodunun gravür edildiği özel bir anahtarlık sipariş edin.', 'Order a custom keychain with the Spotify code engraved on it.', false, 6, 250),
(gen_random_uuid(), '814b9f9e-618d-40bd-bec9-11eb64ea35fb', 4, 'Hediye Paketi', 'Gift Wrapping', 'Anahtarlığı şık bir hediye kutusuna koyun ve özür notu ekleyin.', 'Place the keychain in an elegant gift box and add an apology note.', true, 1, 50),
(gen_random_uuid(), '814b9f9e-618d-40bd-bec9-11eb64ea35fb', 5, 'Hediyeyi Verme', 'Give the Gift', 'Anahtarlığı kişisel olarak verin ve şarkının neden seçildiğini anlatın.', 'Personally give the keychain and explain why you chose that song.', true, 0, 0);

-- 4. Star Naming Apology
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '004d6bfb-e810-43af-9f85-155a5c9f704c', 1, 'Yıldız İsimlendirme Servisi Araştırma', 'Research Star Naming Services', 'Güvenilir yıldız isimlendirme platformlarını araştırın ve en uygununu seçin.', 'Research reliable star naming platforms and choose the most suitable one.', false, 10, 0),
(gen_random_uuid(), '004d6bfb-e810-43af-9f85-155a5c9f704c', 2, 'Yıldız Satın Alma', 'Purchase Star Naming', 'Sevdiğiniz kişinin adıyla bir yıldızı isimlendirin ve sertifikayı alın.', 'Name a star after your loved one and receive the certificate.', false, 7, 500),
(gen_random_uuid(), '004d6bfb-e810-43af-9f85-155a5c9f704c', 3, 'Özür Mektubu Yazma', 'Write Apology Letter', 'Yıldızla birlikte verilecek duygusal bir özür mektubu hazırlayın.', 'Prepare an emotional apology letter to accompany the star certificate.', false, 3, 20),
(gen_random_uuid(), '004d6bfb-e810-43af-9f85-155a5c9f704c', 4, 'Yıldız Gözlem Planı', 'Plan Stargazing', 'Yıldız gözlemi için uygun bir gece ve karanlık bir yer belirleyin.', 'Find a suitable night and dark location for stargazing.', true, 2, 100),
(gen_random_uuid(), '004d6bfb-e810-43af-9f85-155a5c9f704c', 5, 'Sürprizi Gerçekleştirme', 'Execute the Surprise', 'Yıldız altında sertifikayı ve mektubunuzu sunarak özür dileyin.', 'Under the stars, present the certificate and letter with your apology.', true, 0, 0);

-- 5. Sunset Walk Apology
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '8a9d2469-5f24-4241-ae94-b6ad1c405970', 1, 'Güzergah Araştırması', 'Route Research', 'Gün batımını en güzel izleyebileceğiniz bir yürüyüş güzergahı belirleyin.', 'Find a walking route with the best sunset views.', false, 5, 0),
(gen_random_uuid(), '8a9d2469-5f24-4241-ae94-b6ad1c405970', 2, 'Gün Batımı Saatini Kontrol Etme', 'Check Sunset Time', 'Seçtiğiniz gün için kesin gün batımı saatini öğrenin ve yola çıkış saatini planlayın.', 'Find the exact sunset time for your chosen day and plan departure accordingly.', false, 3, 0),
(gen_random_uuid(), '8a9d2469-5f24-4241-ae94-b6ad1c405970', 3, 'Küçük İkramlar Hazırlama', 'Prepare Small Treats', 'Yürüyüş sırasında paylaşmak için küçük atıştırmalıklar ve içecekler hazırlayın.', 'Prepare small snacks and drinks to share during the walk.', false, 1, 100),
(gen_random_uuid(), '8a9d2469-5f24-4241-ae94-b6ad1c405970', 4, 'Çiçek Buketi Alma', 'Get a Flower Bouquet', 'Yürüyüş sırasında sunmak üzere küçük bir çiçek buketi satın alın.', 'Buy a small flower bouquet to present during the walk.', true, 0, 150),
(gen_random_uuid(), '8a9d2469-5f24-4241-ae94-b6ad1c405970', 5, 'Yürüyüşe Çıkma ve Özür Dileme', 'Walk and Apologize', 'Gün batımında yürürken samimi bir şekilde duygularınızı ifade edin ve özür dileyin.', 'Express your feelings sincerely and apologize while walking at sunset.', true, 0, 0);

-- 6. Surprise Trip Apology
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a00ae9e8-3656-445a-ada0-8763e691523d', 1, 'Destinasyon Seçimi', 'Choose Destination', 'Partnerinizin sevdiği veya gitmek istediği bir yeri araştırıp belirleyin.', 'Research and choose a place your partner loves or wants to visit.', false, 14, 0),
(gen_random_uuid(), 'a00ae9e8-3656-445a-ada0-8763e691523d', 2, 'Ulaşım ve Konaklama Rezervasyonu', 'Book Transport and Accommodation', 'Uçak bileti veya araç kiralama ve otel rezervasyonu yapın.', 'Book flight tickets or car rental and hotel reservations.', false, 10, 5000),
(gen_random_uuid(), 'a00ae9e8-3656-445a-ada0-8763e691523d', 3, 'Gezi Planı Oluşturma', 'Create Trip Itinerary', 'Ziyaret edilecek yerleri ve yapılacak aktiviteleri planlayın.', 'Plan the places to visit and activities to do during the trip.', false, 5, 0),
(gen_random_uuid(), 'a00ae9e8-3656-445a-ada0-8763e691523d', 4, 'Sürpriz Açıklama Hazırlığı', 'Prepare Surprise Reveal', 'Gezi sürprizini açıklamak için yaratıcı bir yol düşünün.', 'Think of a creative way to reveal the trip surprise.', true, 2, 100),
(gen_random_uuid(), 'a00ae9e8-3656-445a-ada0-8763e691523d', 5, 'Sürprizi Açıklama', 'Reveal the Surprise', 'Gezi planını heyecan verici bir şekilde açıklayın ve birlikte yola çıkın.', 'Reveal the trip plan in an exciting way and set off together.', true, 0, 0);

-- 7. Treasure Hunt Apology
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'e5692ec3-0ce7-4795-9dfb-7f9f7ffe7920', 1, 'İpuçları Hazırlama', 'Prepare Clues', 'Evinizde veya şehirde 5-7 ipucu noktası belirleyin ve her biri için bilmeceler yazın.', 'Identify 5-7 clue points at home or in the city and write riddles for each.', false, 5, 0),
(gen_random_uuid(), 'e5692ec3-0ce7-4795-9dfb-7f9f7ffe7920', 2, 'Hediye Hazırlama', 'Prepare the Final Gift', 'Hazine avının sonunda bulunacak anlamlı bir hediye satın alın.', 'Purchase a meaningful gift to be found at the end of the treasure hunt.', false, 3, 500),
(gen_random_uuid(), 'e5692ec3-0ce7-4795-9dfb-7f9f7ffe7920', 3, 'İpuçlarını Yerleştirme', 'Place the Clues', 'Tüm ipuçlarını belirlenen noktalara gizleyin ve sıranın doğru olduğundan emin olun.', 'Hide all clues at the designated spots and make sure the sequence is correct.', false, 1, 50),
(gen_random_uuid(), 'e5692ec3-0ce7-4795-9dfb-7f9f7ffe7920', 4, 'Özür Mektubu Ekleme', 'Add Apology Letter', 'Son hediyenin yanına duygusal bir özür mektubu bırakın.', 'Leave an emotional apology letter next to the final gift.', true, 1, 0),
(gen_random_uuid(), 'e5692ec3-0ce7-4795-9dfb-7f9f7ffe7920', 5, 'Avı Başlatma', 'Start the Hunt', 'İlk ipucunu verin ve partnerinizin maceraya başlamasını izleyin.', 'Give the first clue and watch your partner start the adventure.', true, 0, 0);

-- 8. Turkish Delight Box Apology
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'dda6c42c-0e20-4652-ae72-0414e0b6b56f', 1, 'Lokum Çeşitleri Araştırma', 'Research Turkish Delight Varieties', 'En kaliteli lokum üreticilerini araştırın ve çeşitleri inceleyin.', 'Research the best Turkish delight producers and examine varieties.', false, 7, 0),
(gen_random_uuid(), 'dda6c42c-0e20-4652-ae72-0414e0b6b56f', 2, 'Özel Lokum Kutusu Sipariş Etme', 'Order Special Turkish Delight Box', 'Farklı lezzetlerden oluşan özel bir lokum kutusu sipariş edin.', 'Order a special Turkish delight box with different flavors.', false, 5, 400),
(gen_random_uuid(), 'dda6c42c-0e20-4652-ae72-0414e0b6b56f', 3, 'Kişisel Not Yazma', 'Write Personal Note', 'Lokum kutusunun içine yerleştirilecek kişisel bir özür notu yazın.', 'Write a personal apology note to be placed inside the Turkish delight box.', false, 2, 0),
(gen_random_uuid(), 'dda6c42c-0e20-4652-ae72-0414e0b6b56f', 4, 'Hediyeyi Sunma', 'Present the Gift', 'Lokum kutusunu güzel bir şekilde paketleyip samimi bir şekilde sunun.', 'Beautifully wrap the Turkish delight box and present it sincerely.', true, 0, 50);

-- 9. Video Message Apology
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '99c763ba-e7d4-4ebe-a7af-475154274fcf', 1, 'Mesaj İçeriği Planlama', 'Plan Message Content', 'Video mesajda ne söyleyeceğinizi planlayın ve anahtar noktaları yazın.', 'Plan what to say in the video message and write down key points.', false, 5, 0),
(gen_random_uuid(), '99c763ba-e7d4-4ebe-a7af-475154274fcf', 2, 'Çekim Ortamı Hazırlama', 'Prepare Filming Environment', 'Temiz ve aydınlık bir çekim ortamı hazırlayın.', 'Prepare a clean and well-lit filming environment.', false, 3, 0),
(gen_random_uuid(), '99c763ba-e7d4-4ebe-a7af-475154274fcf', 3, 'Video Kaydetme', 'Record Video', 'İçten ve doğal bir şekilde özür video mesajınızı kaydedin.', 'Record your apology video message in a sincere and natural way.', false, 2, 0),
(gen_random_uuid(), '99c763ba-e7d4-4ebe-a7af-475154274fcf', 4, 'Video Düzenleme', 'Edit Video', 'Videoyu düzenleyin, isterseniz müzik veya fotoğraflar ekleyin.', 'Edit the video and optionally add music or photos.', true, 1, 0),
(gen_random_uuid(), '99c763ba-e7d4-4ebe-a7af-475154274fcf', 5, 'Videoyu Gönderme', 'Send the Video', 'Videoyu özel bir mesajla birlikte gönderin veya yüz yüze izletin.', 'Send the video with a special message or show it face to face.', true, 0, 0);

-- 10. Vinyl Record Apology Gift
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '36783f50-ce7e-4a31-88a3-aa95cbb4778b', 1, 'Şarkı veya Albüm Seçimi', 'Choose Song or Album', 'İlişkiniz için anlam taşıyan bir şarkıyı veya albümü belirleyin.', 'Identify a song or album that holds meaning for your relationship.', false, 10, 0),
(gen_random_uuid(), '36783f50-ce7e-4a31-88a3-aa95cbb4778b', 2, 'Vinil Plak Satın Alma', 'Purchase Vinyl Record', 'Seçtiğiniz albümün vinil plağını online veya plakçıdan satın alın.', 'Purchase the vinyl record of your chosen album online or from a record store.', false, 7, 350),
(gen_random_uuid(), '36783f50-ce7e-4a31-88a3-aa95cbb4778b', 3, 'Özür Mesajı Hazırlama', 'Prepare Apology Message', 'Plak kapağının içine el yazısıyla bir özür mesajı yazın.', 'Write a handwritten apology message inside the record sleeve.', false, 3, 0),
(gen_random_uuid(), '36783f50-ce7e-4a31-88a3-aa95cbb4778b', 4, 'Hediye Paketi Yapma', 'Gift Wrap', 'Plağı özel bir ambalaj kağıdıyla paketleyin.', 'Wrap the record with special wrapping paper.', true, 1, 30),
(gen_random_uuid(), '36783f50-ce7e-4a31-88a3-aa95cbb4778b', 5, 'Hediyeyi Verme', 'Give the Gift', 'Plağı birlikte dinleme önerisiyle birlikte hediye edin.', 'Gift the record with a suggestion to listen to it together.', true, 0, 0);

-- 11. Watercolor Love Letter
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '04b7c528-b78b-466c-9588-10e96a42e6a3', 1, 'Malzeme Temin Etme', 'Gather Materials', 'Suluboya, fırça, kaliteli suluboya kağıdı ve kaligrafi kalemi temin edin.', 'Obtain watercolors, brushes, quality watercolor paper, and a calligraphy pen.', false, 7, 200),
(gen_random_uuid(), '04b7c528-b78b-466c-9588-10e96a42e6a3', 2, 'Mektup Taslağı Yazma', 'Draft the Letter', 'Özür ve sevgi dolu bir mektup taslağı hazırlayın.', 'Draft a letter full of apology and love.', false, 5, 0),
(gen_random_uuid(), '04b7c528-b78b-466c-9588-10e96a42e6a3', 3, 'Suluboya Arka Plan Oluşturma', 'Create Watercolor Background', 'Kağıda güzel bir suluboya arka plan boyayın ve kurumasını bekleyin.', 'Paint a beautiful watercolor background on the paper and let it dry.', false, 3, 0),
(gen_random_uuid(), '04b7c528-b78b-466c-9588-10e96a42e6a3', 4, 'Mektubu Yazma', 'Write the Letter', 'Kurumuş suluboya kağıdı üzerine kaligrafi kalemiyle mektubunuzu yazın.', 'Write your letter on the dried watercolor paper with a calligraphy pen.', true, 1, 0),
(gen_random_uuid(), '04b7c528-b78b-466c-9588-10e96a42e6a3', 5, 'Mektubu Sunma', 'Present the Letter', 'Mektubu zarfa koyun ve özel bir anı bekleyerek sunun.', 'Place the letter in an envelope and present it at a special moment.', true, 0, 30);

-- 12. Baby Shower Picnic Party
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '6540367f-63cf-497d-aae5-f634c08b7cd1', 1, 'Mekan ve Tarih Belirleme', 'Choose Venue and Date', 'Piknik için uygun bir park veya bahçe belirleyin ve misafirlere haber verin.', 'Choose a suitable park or garden for the picnic and notify guests.', false, 14, 0),
(gen_random_uuid(), '6540367f-63cf-497d-aae5-f634c08b7cd1', 2, 'Dekorasyon Malzemeleri Temin Etme', 'Get Decoration Supplies', 'Bebek temalı balonlar, flamalar ve masa örtüleri satın alın.', 'Buy baby-themed balloons, banners, and tablecloths.', false, 7, 500),
(gen_random_uuid(), '6540367f-63cf-497d-aae5-f634c08b7cd1', 3, 'Yiyecek ve İçecek Hazırlama', 'Prepare Food and Drinks', 'Piknik sepeti, sandviçler, kurabiyeler ve limonata hazırlayın.', 'Prepare a picnic basket, sandwiches, cookies, and lemonade.', false, 2, 800),
(gen_random_uuid(), '6540367f-63cf-497d-aae5-f634c08b7cd1', 4, 'Oyunlar ve Aktiviteler Planlama', 'Plan Games and Activities', 'Bebek bezi yarışı veya bebek adı tahmin oyunu gibi eğlenceli aktiviteler planlayın.', 'Plan fun activities like diaper relay race or baby name guessing game.', true, 3, 200),
(gen_random_uuid(), '6540367f-63cf-497d-aae5-f634c08b7cd1', 5, 'Piknik Alanını Hazırlama', 'Set Up Picnic Area', 'Piknik battaniyeleri serin, dekorasyonları yerleştirin ve yiyecekleri düzenleyin.', 'Spread picnic blankets, place decorations, and arrange food.', true, 0, 0);

-- 13. Balloon Box Gender Reveal
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'ffe180b9-97bd-417f-a96b-eeb74babf4db', 1, 'Cinsiyet Bilgisini Almak', 'Get Gender Information', 'Doktordan cinsiyet bilgisini kapalı bir zarfta alın ve güvendiğiniz birine verin.', 'Get the gender information in a sealed envelope from the doctor and give it to someone you trust.', false, 10, 0),
(gen_random_uuid(), 'ffe180b9-97bd-417f-a96b-eeb74babf4db', 2, 'Büyük Kutu Hazırlama', 'Prepare the Big Box', 'İçinden balonlar çıkacak büyük bir karton kutu temin edin ve süsleyin.', 'Get a large cardboard box from which balloons will come out and decorate it.', false, 5, 200),
(gen_random_uuid(), 'ffe180b9-97bd-417f-a96b-eeb74babf4db', 3, 'Helyum Balonları Doldurma', 'Fill Helium Balloons', 'Cinsiyete uygun renkte helyum balonlarını kutuya yerleştirin.', 'Place helium balloons in the appropriate gender color inside the box.', false, 1, 400),
(gen_random_uuid(), 'ffe180b9-97bd-417f-a96b-eeb74babf4db', 4, 'Misafirleri Toplama', 'Gather Guests', 'Aile ve arkadaşları belirli bir saatte bir araya getirin.', 'Gather family and friends together at a specific time.', true, 1, 300),
(gen_random_uuid(), 'ffe180b9-97bd-417f-a96b-eeb74babf4db', 5, 'Kutuyu Açma', 'Open the Box', 'Hep birlikte kutuyu açın ve balonların yükselmesini izleyin.', 'Open the box together and watch the balloons rise.', true, 0, 0);

-- 14. Balloon Pop Gender Reveal
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '150d2412-033d-435f-afc5-0df0dd0495d4', 1, 'Cinsiyet Bilgisini Güvenilir Birine Verme', 'Share Gender Info with Trusted Person', 'Doktordan alınan cinsiyet bilgisini balonları hazırlayacak kişiye iletin.', 'Share the gender information from the doctor with the person who will prepare the balloons.', false, 7, 0),
(gen_random_uuid(), '150d2412-033d-435f-afc5-0df0dd0495d4', 2, 'Balonları Hazırlama', 'Prepare the Balloons', 'Siyah balonların içine cinsiyete uygun renkte konfeti doldurun.', 'Fill black balloons with confetti in the appropriate gender color.', false, 3, 150),
(gen_random_uuid(), '150d2412-033d-435f-afc5-0df0dd0495d4', 3, 'Mekan Süsleme', 'Decorate the Venue', 'Balon patlatma alanını süsleyin ve fotoğraf köşesi oluşturun.', 'Decorate the balloon popping area and create a photo booth.', false, 1, 300),
(gen_random_uuid(), '150d2412-033d-435f-afc5-0df0dd0495d4', 4, 'Kamera Hazırlığı', 'Camera Setup', 'Anı yakalamak için kamera veya telefon tripodunu konumlandırın.', 'Position a camera or phone tripod to capture the moment.', true, 0, 0),
(gen_random_uuid(), '150d2412-033d-435f-afc5-0df0dd0495d4', 5, 'Balon Patlatma Anı', 'Pop the Balloons', 'Hep birlikte balonları patlatın ve cinsiyeti öğrenin.', 'Pop the balloons together and find out the gender.', true, 0, 0);

-- 15. Bee Themed Baby Shower
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'ccd574b8-8b9b-4bd2-b76f-198f2dea8fe8', 1, 'Arı Temalı Davetiye Gönderme', 'Send Bee Themed Invitations', '"What Will It Bee?" temalı davetiyeler tasarlayın ve misafirlere gönderin.', 'Design "What Will It Bee?" themed invitations and send them to guests.', false, 14, 200),
(gen_random_uuid(), 'ccd574b8-8b9b-4bd2-b76f-198f2dea8fe8', 2, 'Arı Temalı Dekorasyon', 'Bee Themed Decoration', 'Sarı-siyah balonlar, petek süsler ve arı figürleri ile mekanı süsleyin.', 'Decorate the venue with yellow-black balloons, honeycomb ornaments, and bee figures.', false, 5, 600),
(gen_random_uuid(), 'ccd574b8-8b9b-4bd2-b76f-198f2dea8fe8', 3, 'Arı Temalı Yiyecekler Hazırlama', 'Prepare Bee Themed Food', 'Bal temalı kurabiyeler, sarı kek ve arı kovanı cupcake''ler hazırlayın.', 'Prepare honey-themed cookies, yellow cake, and beehive cupcakes.', false, 2, 700),
(gen_random_uuid(), 'ccd574b8-8b9b-4bd2-b76f-198f2dea8fe8', 4, 'Hediye İstasyonu Kurma', 'Set Up Gift Station', 'Misafir hediyelerini toplamak için arı temalı bir köşe oluşturun.', 'Create a bee-themed corner to collect guest gifts.', true, 1, 150),
(gen_random_uuid(), 'ccd574b8-8b9b-4bd2-b76f-198f2dea8fe8', 5, 'Parti Günü Düzenlemeler', 'Party Day Arrangements', 'Son kontrolleri yapın, müziği ayarlayın ve misafirleri karşılayın.', 'Do final checks, set up music, and welcome guests.', true, 0, 0);

-- 16. Book Themed Baby Shower
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '68f1fe8d-7e25-4ea3-81a4-166f240ee4eb', 1, 'Kitap Temalı Davetiye Hazırlama', 'Prepare Book Themed Invitations', 'Kitap kapağı şeklinde davetiyeler tasarlayın ve gönderin.', 'Design invitations shaped like book covers and send them out.', false, 14, 200),
(gen_random_uuid(), '68f1fe8d-7e25-4ea3-81a4-166f240ee4eb', 2, 'Kitap Koleksiyonu Oluşturma', 'Build Book Collection', 'Misafirlerden bebeğe çocuk kitabı getirmelerini isteyin ve bir kitaplık hazırlayın.', 'Ask guests to bring children''s books for the baby and set up a bookshelf.', false, 7, 300),
(gen_random_uuid(), '68f1fe8d-7e25-4ea3-81a4-166f240ee4eb', 3, 'Dekorasyon Hazırlama', 'Prepare Decorations', 'Eski kitaplardan çelenkler, kitap sayfalarından origami süsler yapın.', 'Make wreaths from old books and origami decorations from book pages.', false, 3, 400),
(gen_random_uuid(), '68f1fe8d-7e25-4ea3-81a4-166f240ee4eb', 4, 'Dilek Kitabı Hazırlama', 'Prepare Wish Book', 'Misafirlerin bebek için dilek yazacağı boş bir dilek kitabı hazırlayın.', 'Prepare a blank wish book where guests can write wishes for the baby.', true, 2, 100),
(gen_random_uuid(), '68f1fe8d-7e25-4ea3-81a4-166f240ee4eb', 5, 'Parti Düzenleme', 'Set Up Party', 'Mekanı düzenleyin, yiyecekleri hazırlayın ve misafirleri karşılayın.', 'Arrange the venue, prepare food, and welcome guests.', true, 0, 500);

-- 17. Cake Cutting Gender Reveal
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'e50703fb-74b9-44eb-9497-6d7ddb79cb7b', 1, 'Cinsiyet Bilgisini Pastacıya İletme', 'Share Gender Info with Baker', 'Doktordan alınan cinsiyet bilgisini kapalı zarfta pastacıya verin.', 'Give the gender information from the doctor in a sealed envelope to the baker.', false, 10, 0),
(gen_random_uuid(), 'e50703fb-74b9-44eb-9497-6d7ddb79cb7b', 2, 'Pasta Siparişi Verme', 'Order the Cake', 'Dışı beyaz, içi cinsiyete uygun renkte bir pasta sipariş edin.', 'Order a cake that is white on the outside and colored inside according to the gender.', false, 7, 800),
(gen_random_uuid(), 'e50703fb-74b9-44eb-9497-6d7ddb79cb7b', 3, 'Mekan Süsleme', 'Decorate Venue', 'Nötr renklerle mekanı süsleyin ve masa düzenlemesini yapın.', 'Decorate the venue with neutral colors and set up the table arrangement.', false, 1, 400),
(gen_random_uuid(), 'e50703fb-74b9-44eb-9497-6d7ddb79cb7b', 4, 'Misafirleri Toplama', 'Gather Guests', 'Aile ve yakın arkadaşları özel anı paylaşmak için davet edin.', 'Invite family and close friends to share the special moment.', true, 3, 0),
(gen_random_uuid(), 'e50703fb-74b9-44eb-9497-6d7ddb79cb7b', 5, 'Pastayı Kesme', 'Cut the Cake', 'Heyecanla pastayı kesin ve cinsiyeti hep birlikte öğrenin.', 'Excitedly cut the cake and find out the gender together.', true, 0, 0);

-- 18. Cloud Themed Baby Shower
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '0d6737ac-674e-4a52-9415-c9a686206d26', 1, 'Bulut Temalı Davetiye Tasarımı', 'Design Cloud Themed Invitations', 'Yumuşak mavi ve beyaz tonlarda bulut temalı davetiyeler hazırlayın.', 'Prepare cloud-themed invitations in soft blue and white tones.', false, 14, 150),
(gen_random_uuid(), '0d6737ac-674e-4a52-9415-c9a686206d26', 2, 'Bulut Dekorasyonları Hazırlama', 'Make Cloud Decorations', 'Pamuk ve balon kullanarak bulut dekorasyonları yapın ve tavana asın.', 'Make cloud decorations using cotton and balloons and hang them from the ceiling.', false, 5, 400),
(gen_random_uuid(), '0d6737ac-674e-4a52-9415-c9a686206d26', 3, 'Yiyecek Menüsü Hazırlama', 'Prepare Food Menu', 'Bulut şekilli kurabiyeler, pamuk şeker ve açık renkli içecekler hazırlayın.', 'Prepare cloud-shaped cookies, cotton candy, and light-colored drinks.', false, 2, 600),
(gen_random_uuid(), '0d6737ac-674e-4a52-9415-c9a686206d26', 4, 'Fotoğraf Köşesi Oluşturma', 'Create Photo Corner', 'Bulut arka planlı bir fotoğraf köşesi kurun.', 'Set up a photo corner with a cloud backdrop.', true, 1, 200),
(gen_random_uuid(), '0d6737ac-674e-4a52-9415-c9a686206d26', 5, 'Parti Düzenleme', 'Set Up Party', 'Tüm dekorasyonları yerleştirin ve misafirleri sıcak bir şekilde karşılayın.', 'Place all decorations and warmly welcome guests.', true, 0, 0);

-- 19. Color Changing Drinks Gender Reveal
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'aaa05255-1e84-4b6e-a813-c9ad1c02def0', 1, 'Renk Değiştiren İçecek Tarifi Araştırma', 'Research Color Changing Drinks', 'Kelebek bezelye çiçeği veya gıda boyası ile renk değiştiren içecek tariflerini araştırın.', 'Research color-changing drink recipes using butterfly pea flower or food coloring.', false, 7, 0),
(gen_random_uuid(), 'aaa05255-1e84-4b6e-a813-c9ad1c02def0', 2, 'Malzemeleri Temin Etme', 'Get Ingredients', 'İçecek malzemelerini ve cinsiyete uygun gıda boyasını satın alın.', 'Purchase drink ingredients and gender-appropriate food coloring.', false, 5, 200),
(gen_random_uuid(), 'aaa05255-1e84-4b6e-a813-c9ad1c02def0', 3, 'İçecekleri Hazırlama', 'Prepare the Drinks', 'İçecekleri hazırlayın; karıştırıldığında cinsiyete uygun renk ortaya çıkacak şekilde ayarlayın.', 'Prepare the drinks so that when stirred, the gender-appropriate color appears.', false, 0, 100),
(gen_random_uuid(), 'aaa05255-1e84-4b6e-a813-c9ad1c02def0', 4, 'Sunum Hazırlığı', 'Setup Presentation', 'Bardakları ve dekorasyonu hazırlayın, misafirlere nötr renkte içecekler dağıtın.', 'Prepare glasses and decoration, distribute neutral-colored drinks to guests.', true, 0, 150),
(gen_random_uuid(), 'aaa05255-1e84-4b6e-a813-c9ad1c02def0', 5, 'Renk Değiştirme Anı', 'Color Change Moment', 'Hep birlikte içecekleri karıştırın ve renk değişimini izleyin.', 'Stir the drinks together and watch the color change.', true, 0, 0);

-- 20. Confetti Cannon Gender Reveal
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'ffe702b6-df9d-441e-80a4-924e869d2e4d', 1, 'Konfeti Topları Sipariş Etme', 'Order Confetti Cannons', 'Cinsiyete uygun renkte konfeti toplarını önceden sipariş edin.', 'Order confetti cannons in the appropriate gender color in advance.', false, 10, 300),
(gen_random_uuid(), 'ffe702b6-df9d-441e-80a4-924e869d2e4d', 2, 'Mekan Belirleme', 'Choose Venue', 'Açık hava veya geniş bir alan seçin ve temizlik planı yapın.', 'Choose an outdoor or spacious area and plan for cleanup.', false, 5, 0),
(gen_random_uuid(), 'ffe702b6-df9d-441e-80a4-924e869d2e4d', 3, 'Misafirleri Davet Etme', 'Invite Guests', 'Aile ve arkadaşları davet edin ve tarih-saat bilgisini paylaşın.', 'Invite family and friends and share the date-time information.', false, 7, 0),
(gen_random_uuid(), 'ffe702b6-df9d-441e-80a4-924e869d2e4d', 4, 'Kamera ve Video Hazırlığı', 'Camera and Video Setup', 'Anı kaydetmek için birden fazla açıdan kamera yerleştirin.', 'Set up cameras from multiple angles to record the moment.', true, 0, 0),
(gen_random_uuid(), 'ffe702b6-df9d-441e-80a4-924e869d2e4d', 5, 'Konfeti Toplarını Patlatma', 'Pop the Confetti Cannons', 'Geri sayım yapın ve hep birlikte konfeti toplarını patlatın.', 'Count down and pop the confetti cannons together.', true, 0, 0);

-- 21. Digital Time Capsule Baby Surprise
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '4ab2bd2d-07f8-4b12-8286-cb00f043581d', 1, 'Dijital Platform Seçimi', 'Choose Digital Platform', 'Zaman kapsülü için güvenilir bir dijital platform veya uygulama seçin.', 'Choose a reliable digital platform or app for the time capsule.', false, 14, 0),
(gen_random_uuid(), '4ab2bd2d-07f8-4b12-8286-cb00f043581d', 2, 'İçerik Toplama', 'Collect Content', 'Aile üyelerinden bebek için video mesajlar, fotoğraflar ve mektuplar toplayın.', 'Collect video messages, photos, and letters from family members for the baby.', false, 10, 0),
(gen_random_uuid(), '4ab2bd2d-07f8-4b12-8286-cb00f043581d', 3, 'Zaman Kapsülünü Oluşturma', 'Create the Time Capsule', 'Tüm içerikleri düzenleyin ve dijital zaman kapsülüne yükleyin.', 'Organize all content and upload it to the digital time capsule.', false, 5, 200),
(gen_random_uuid(), '4ab2bd2d-07f8-4b12-8286-cb00f043581d', 4, 'Açılma Tarihi Belirleme', 'Set Opening Date', 'Kapsülün bebeğin 18. yaş gününde açılacak şekilde zamanlanmasını ayarlayın.', 'Set the capsule to be timed to open on the baby''s 18th birthday.', true, 3, 0),
(gen_random_uuid(), '4ab2bd2d-07f8-4b12-8286-cb00f043581d', 5, 'Sürprizi Sunma', 'Present the Surprise', 'Anne-babaya zaman kapsülünün varlığını özel bir anla birlikte açıklayın.', 'Reveal the existence of the time capsule to the parents with a special moment.', true, 0, 0);

-- 22. Elephant Themed Baby Shower
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'ba311926-24ca-4ef0-aa8a-67122d0c009b', 1, 'Fil Temalı Davetiye Gönderme', 'Send Elephant Themed Invitations', 'Sevimli fil görselli davetiyeler tasarlayın ve misafirlere gönderin.', 'Design invitations with cute elephant illustrations and send to guests.', false, 14, 200),
(gen_random_uuid(), 'ba311926-24ca-4ef0-aa8a-67122d0c009b', 2, 'Fil Dekorasyonları Hazırlama', 'Prepare Elephant Decorations', 'Gri ve pastel renklerle fil figürleri, balonlar ve süsler hazırlayın.', 'Prepare elephant figures, balloons, and ornaments in grey and pastel colors.', false, 7, 600),
(gen_random_uuid(), 'ba311926-24ca-4ef0-aa8a-67122d0c009b', 3, 'Fil Temalı Pasta ve Yiyecekler', 'Elephant Themed Cake and Food', 'Fil şekilli pasta ve temalı kurabiyeler sipariş edin.', 'Order an elephant-shaped cake and themed cookies.', false, 3, 800),
(gen_random_uuid(), 'ba311926-24ca-4ef0-aa8a-67122d0c009b', 4, 'Parti Oyunları Planlama', 'Plan Party Games', 'Fil temalı eğlenceli oyunlar ve yarışmalar planlayın.', 'Plan fun elephant-themed games and competitions.', true, 2, 100),
(gen_random_uuid(), 'ba311926-24ca-4ef0-aa8a-67122d0c009b', 5, 'Parti Günü Hazırlık', 'Party Day Preparation', 'Mekanı hazırlayın, dekorasyonları yerleştirin ve müziği ayarlayın.', 'Prepare the venue, place decorations, and set up music.', true, 0, 0);

-- 23. Fireworks Gender Reveal
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '3e349b02-878a-4c33-9b8a-b01d02d1815c', 1, 'Yasal İzinler ve Güvenlik', 'Legal Permits and Safety', 'Havai fişek kullanımı için gerekli izinleri alın ve güvenlik önlemlerini araştırın.', 'Obtain necessary permits for fireworks use and research safety measures.', false, 14, 500),
(gen_random_uuid(), '3e349b02-878a-4c33-9b8a-b01d02d1815c', 2, 'Havai Fişek Temin Etme', 'Obtain Fireworks', 'Cinsiyete uygun renkte profesyonel havai fişekleri sipariş edin.', 'Order professional fireworks in the appropriate gender color.', false, 10, 2000),
(gen_random_uuid(), '3e349b02-878a-4c33-9b8a-b01d02d1815c', 3, 'Mekan Hazırlığı', 'Venue Preparation', 'Güvenli ve açık bir alan belirleyin, güvenlik bariyerleri kurun.', 'Identify a safe open area and set up safety barriers.', false, 3, 300),
(gen_random_uuid(), '3e349b02-878a-4c33-9b8a-b01d02d1815c', 4, 'Misafirleri Davet Etme', 'Invite Guests', 'Aile ve arkadaşları davet edin ve güvenlik kurallarını paylaşın.', 'Invite family and friends and share safety rules.', true, 5, 0),
(gen_random_uuid(), '3e349b02-878a-4c33-9b8a-b01d02d1815c', 5, 'Havai Fişekleri Ateşleme', 'Light the Fireworks', 'Profesyonel yardımla havai fişekleri ateşleyin ve cinsiyeti gökyüzünde açıklayın.', 'Light the fireworks with professional help and reveal the gender in the sky.', true, 0, 0);

-- 24. Fortune Cookie Gender Reveal
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'd3b86ab4-7ab2-469c-a98c-c0ca0388fe84', 1, 'Özel Kurabiye Tarifi Bulma', 'Find Custom Cookie Recipe', 'Fal kurabiyesi tarifini araştırın veya bir pastaneden özel sipariş verin.', 'Research fortune cookie recipes or place a custom order at a bakery.', false, 10, 0),
(gen_random_uuid(), 'd3b86ab4-7ab2-469c-a98c-c0ca0388fe84', 2, 'Cinsiyet Mesajlarını Hazırlama', 'Prepare Gender Messages', 'Kurabiyelerin içine konulacak cinsiyet açıklama mesajlarını yazın.', 'Write gender reveal messages to be placed inside the cookies.', false, 5, 0),
(gen_random_uuid(), 'd3b86ab4-7ab2-469c-a98c-c0ca0388fe84', 3, 'Kurabiyeleri Hazırlama', 'Prepare Cookies', 'Fal kurabiyelerini pişirin ve mesajları içlerine yerleştirin.', 'Bake the fortune cookies and place the messages inside them.', false, 2, 300),
(gen_random_uuid(), 'd3b86ab4-7ab2-469c-a98c-c0ca0388fe84', 4, 'Sunum Düzenlemesi', 'Arrange Presentation', 'Kurabiyeleri güzel bir tabakta düzenleyin ve masayı süsleyin.', 'Arrange cookies on a beautiful plate and decorate the table.', true, 0, 100),
(gen_random_uuid(), 'd3b86ab4-7ab2-469c-a98c-c0ca0388fe84', 5, 'Kurabiyeleri Kırma', 'Break the Cookies', 'Hep birlikte kurabiyeleri kırın ve cinsiyet mesajını okuyun.', 'Break the cookies together and read the gender message.', true, 0, 0);

-- 25. Garden Fairy Baby Shower
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '7058d8f3-f71d-4501-9f3e-264bcc5cd037', 1, 'Bahçe Mekanı Seçimi', 'Choose Garden Venue', 'Peri masalı temasına uygun çiçekli bir bahçe veya mekan seçin.', 'Choose a flowery garden or venue suitable for the fairy tale theme.', false, 14, 0),
(gen_random_uuid(), '7058d8f3-f71d-4501-9f3e-264bcc5cd037', 2, 'Peri Temalı Dekorasyon', 'Fairy Themed Decoration', 'Peri kanatları, tüller, peri ışıkları ve çiçek çelenkleri hazırlayın.', 'Prepare fairy wings, tulle, fairy lights, and flower garlands.', false, 7, 800),
(gen_random_uuid(), '7058d8f3-f71d-4501-9f3e-264bcc5cd037', 3, 'Büyülü Yiyecekler Hazırlama', 'Prepare Magical Food', 'Peri temalı kekler, simli limonata ve çiçekli sandviçler hazırlayın.', 'Prepare fairy-themed cakes, glittery lemonade, and flower sandwiches.', false, 2, 700),
(gen_random_uuid(), '7058d8f3-f71d-4501-9f3e-264bcc5cd037', 4, 'Peri Kanatları Dağıtma', 'Distribute Fairy Wings', 'Misafirlere peri kanatları ve taçlar dağıtın.', 'Distribute fairy wings and crowns to guests.', true, 1, 400),
(gen_random_uuid(), '7058d8f3-f71d-4501-9f3e-264bcc5cd037', 5, 'Parti Başlatma', 'Start the Party', 'Müziği açın, oyunları başlatın ve büyülü anların tadını çıkarın.', 'Turn on the music, start the games, and enjoy the magical moments.', true, 0, 0);

-- 26. Garden Grazing Table Baby Shower
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '78070ef1-d82a-4796-9575-3a7272c3ffd3', 1, 'Mekan ve Masa Düzeni Planlama', 'Plan Venue and Table Layout', 'Bahçede geniş bir grazing table için uygun alanı belirleyin.', 'Identify a suitable area in the garden for a large grazing table.', false, 10, 0),
(gen_random_uuid(), '78070ef1-d82a-4796-9575-3a7272c3ffd3', 2, 'Yiyecek Listesi Hazırlama', 'Create Food List', 'Peynirler, meyve, kurutulmuş etler, ekmekler ve dip soslardan oluşan menüyü planlayın.', 'Plan a menu of cheeses, fruits, cured meats, breads, and dip sauces.', false, 7, 0),
(gen_random_uuid(), '78070ef1-d82a-4796-9575-3a7272c3ffd3', 3, 'Malzeme Alışverişi', 'Shop for Ingredients', 'Taze ve kaliteli malzemeleri satın alın.', 'Purchase fresh and quality ingredients.', false, 1, 1500),
(gen_random_uuid(), '78070ef1-d82a-4796-9575-3a7272c3ffd3', 4, 'Masayı Düzenleme', 'Arrange the Table', 'Yiyecekleri estetik bir şekilde ahşap tahtalar ve tabaklarda düzenleyin.', 'Arrange food aesthetically on wooden boards and plates.', true, 0, 200),
(gen_random_uuid(), '78070ef1-d82a-4796-9575-3a7272c3ffd3', 5, 'Bahçe Dekorasyonu', 'Garden Decoration', 'Çiçekler, mumlar ve bebek temalı süslerle bahçeyi dekore edin.', 'Decorate the garden with flowers, candles, and baby-themed ornaments.', true, 0, 500);

-- 27. Glow Night Gender Reveal
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '7f14d1f0-9bbe-44dd-83b2-a979ccf73b4e', 1, 'Neon Malzeme Temin Etme', 'Get Neon Supplies', 'UV ışıklar, neon boyalar, parlayan bileklikler ve neon balonlar satın alın.', 'Buy UV lights, neon paints, glow sticks, and neon balloons.', false, 10, 600),
(gen_random_uuid(), '7f14d1f0-9bbe-44dd-83b2-a979ccf73b4e', 2, 'Mekan Karartma', 'Darken the Venue', 'Mekanı karartın ve UV ışıkları stratejik noktalara yerleştirin.', 'Darken the venue and place UV lights at strategic points.', false, 1, 200),
(gen_random_uuid(), '7f14d1f0-9bbe-44dd-83b2-a979ccf73b4e', 3, 'Neon Dekorasyon Yapma', 'Create Neon Decorations', 'Neon boyalarla "Boy or Girl?" yazıları ve süsler hazırlayın.', 'Create "Boy or Girl?" signs and decorations with neon paints.', false, 2, 300),
(gen_random_uuid(), '7f14d1f0-9bbe-44dd-83b2-a979ccf73b4e', 4, 'Cinsiyet Açıklama Hazırlığı', 'Prepare Gender Reveal', 'Cinsiyete uygun renkte parlayan bir element hazırlayın.', 'Prepare a glowing element in the appropriate gender color.', true, 1, 150),
(gen_random_uuid(), '7f14d1f0-9bbe-44dd-83b2-a979ccf73b4e', 5, 'Neon Parti ve Açıklama', 'Neon Party and Reveal', 'Işıkları kapatın, UV ışıkları açın ve cinsiyeti neon ile açıklayın.', 'Turn off lights, switch on UV lights, and reveal gender with neon.', true, 0, 0);

-- 28. Halloween Pumpkin Gender Reveal
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'd442386a-abf0-495a-a39e-010780e68960', 1, 'Balkabağı Temin Etme', 'Get Pumpkins', 'Büyük bir balkabağı ve dekoratif küçük balkabakları satın alın.', 'Purchase a large pumpkin and decorative small pumpkins.', false, 7, 200),
(gen_random_uuid(), 'd442386a-abf0-495a-a39e-010780e68960', 2, 'Balkabağını Oyma', 'Carve the Pumpkin', 'Büyük balkabağının içini boşaltın ve "Boy" veya "Girl" yazısını oyun.', 'Hollow out the large pumpkin and carve "Boy" or "Girl" into it.', false, 2, 0),
(gen_random_uuid(), 'd442386a-abf0-495a-a39e-010780e68960', 3, 'Renkli Işık Yerleştirme', 'Place Colored Lights', 'Balkabağının içine cinsiyete uygun renkte LED ışık yerleştirin.', 'Place LED lights in the appropriate gender color inside the pumpkin.', false, 1, 100),
(gen_random_uuid(), 'd442386a-abf0-495a-a39e-010780e68960', 4, 'Halloween Dekorasyonu', 'Halloween Decoration', 'Cadılar Bayramı temalı ek dekorasyonlar yapın.', 'Create additional Halloween-themed decorations.', true, 1, 300),
(gen_random_uuid(), 'd442386a-abf0-495a-a39e-010780e68960', 5, 'Balkabağını Aydınlatma', 'Light the Pumpkin', 'Karanlıkta balkabağının ışığını yakın ve cinsiyeti açıklayın.', 'Light the pumpkin in the dark and reveal the gender.', true, 0, 0);

-- 29. Hot Air Balloon Baby Shower
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '8f2d6a21-0a93-447a-bd7e-35f53d651956', 1, 'Sıcak Hava Balonu Temalı Dekor Planlama', 'Plan Hot Air Balloon Decor', 'Minyatür sıcak hava balonu süsleri, sepet dekorasyonları ve bulut detayları planlayın.', 'Plan miniature hot air balloon ornaments, basket decorations, and cloud details.', false, 14, 0),
(gen_random_uuid(), '8f2d6a21-0a93-447a-bd7e-35f53d651956', 2, 'Dekorasyon Malzemeleri Temin Etme', 'Get Decoration Materials', 'Büyük balonlar, hasır sepetler ve renkli kumaşlar satın alın.', 'Purchase large balloons, wicker baskets, and colorful fabrics.', false, 7, 800),
(gen_random_uuid(), '8f2d6a21-0a93-447a-bd7e-35f53d651956', 3, 'Yiyecek ve Pasta Hazırlığı', 'Prepare Food and Cake', 'Sıcak hava balonu şekilli pasta ve temalı atıştırmalıklar sipariş edin.', 'Order a hot air balloon shaped cake and themed snacks.', false, 3, 1000),
(gen_random_uuid(), '8f2d6a21-0a93-447a-bd7e-35f53d651956', 4, 'Mekanı Süsleme', 'Decorate the Venue', 'Tavandan asılı balon dekorasyonları ve duvar süslerini yerleştirin.', 'Place hanging balloon decorations from the ceiling and wall ornaments.', true, 1, 0),
(gen_random_uuid(), '8f2d6a21-0a93-447a-bd7e-35f53d651956', 5, 'Parti Başlatma', 'Start the Party', 'Misafirleri karşılayın ve büyülü balon temalı partiyi başlatın.', 'Welcome guests and start the magical balloon-themed party.', true, 0, 0);

-- 30. Indian Blessing Baby Shower
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'fc23c8b3-1515-483c-9536-2e167790e619', 1, 'Hint Geleneğini Araştırma', 'Research Indian Traditions', 'Hint baby shower (Godh Bharai) geleneklerini araştırın ve uygun ritüelleri belirleyin.', 'Research Indian baby shower (Godh Bharai) traditions and identify appropriate rituals.', false, 14, 0),
(gen_random_uuid(), 'fc23c8b3-1515-483c-9536-2e167790e619', 2, 'Hint Dekorasyonu Hazırlama', 'Prepare Indian Decorations', 'Rangoli desenleri, marigold çiçekleri ve renkli kumaşlarla mekanı süsleyin.', 'Decorate the venue with rangoli patterns, marigold flowers, and colorful fabrics.', false, 5, 1000),
(gen_random_uuid(), 'fc23c8b3-1515-483c-9536-2e167790e619', 3, 'Hint Yemekleri Hazırlama', 'Prepare Indian Food', 'Geleneksel Hint tatlıları ve yemeklerinden oluşan bir menü hazırlayın.', 'Prepare a menu of traditional Indian sweets and dishes.', false, 2, 1200),
(gen_random_uuid(), 'fc23c8b3-1515-483c-9536-2e167790e619', 4, 'Kına Köşesi Kurma', 'Set Up Henna Station', 'Misafirler için kına yapılacak bir köşe hazırlayın.', 'Set up a corner for henna application for guests.', true, 1, 300),
(gen_random_uuid(), 'fc23c8b3-1515-483c-9536-2e167790e619', 5, 'Kutlama ve Dua', 'Celebration and Blessing', 'Geleneksel dualarla anneyi kutlayın ve hediye sunumunu yapın.', 'Celebrate the mother with traditional prayers and present gifts.', true, 0, 0);

-- 31. Nautical Themed Baby Shower
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '4fe99142-200e-4d9b-9f86-ae0cb8d67c03', 1, 'Denizci Temalı Davetiye Hazırlama', 'Prepare Nautical Invitations', 'Çapa, deniz yıldızı ve yelkenli temalı davetiyeler hazırlayıp gönderin.', 'Prepare and send invitations with anchor, starfish, and sailboat themes.', false, 14, 200),
(gen_random_uuid(), '4fe99142-200e-4d9b-9f86-ae0cb8d67c03', 2, 'Denizci Dekorasyonu', 'Nautical Decorations', 'Mavi-beyaz çizgili kumaşlar, halatlar, çapalar ve deniz kabukları ile mekanı süsleyin.', 'Decorate the venue with blue-white striped fabrics, ropes, anchors, and seashells.', false, 5, 700),
(gen_random_uuid(), '4fe99142-200e-4d9b-9f86-ae0cb8d67c03', 3, 'Deniz Temalı Yiyecekler', 'Nautical Themed Food', 'Balık şekilli kurabiyeler, mavi jöle ve denizci pastası hazırlayın.', 'Prepare fish-shaped cookies, blue jelly, and a nautical cake.', false, 2, 800),
(gen_random_uuid(), '4fe99142-200e-4d9b-9f86-ae0cb8d67c03', 4, 'Denizci Oyunları Planlama', 'Plan Nautical Games', 'Denizci düğümü yarışması ve hazine haritası oyunu gibi aktiviteler planlayın.', 'Plan activities like sailor knot competition and treasure map game.', true, 3, 150),
(gen_random_uuid(), '4fe99142-200e-4d9b-9f86-ae0cb8d67c03', 5, 'Parti Günü Hazırlık', 'Party Day Setup', 'Son dekorasyon düzenlemelerini yapın ve misafirleri karşılayın.', 'Make final decoration arrangements and welcome guests.', true, 0, 0);

-- 32. Paint Splash Gender Reveal
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '227f6235-9f22-4bc2-a3c7-e376a5bb0b3b', 1, 'Boya Malzemeleri Temin Etme', 'Get Paint Supplies', 'Cinsiyete uygun renkte yıkanabilir boyalar ve büyük bir tuval satın alın.', 'Buy washable paints in the appropriate gender color and a large canvas.', false, 7, 400),
(gen_random_uuid(), '227f6235-9f22-4bc2-a3c7-e376a5bb0b3b', 2, 'Mekan Hazırlığı', 'Venue Preparation', 'Açık alanı branda ile koruyun ve boya atma alanını hazırlayın.', 'Protect the outdoor area with tarpaulin and prepare the paint throwing area.', false, 2, 200),
(gen_random_uuid(), '227f6235-9f22-4bc2-a3c7-e376a5bb0b3b', 3, 'Koruyucu Kıyafet Hazırlama', 'Prepare Protective Clothing', 'Misafirler için eski tişörtler veya tek kullanımlık önlükler hazırlayın.', 'Prepare old t-shirts or disposable aprons for guests.', false, 1, 100),
(gen_random_uuid(), '227f6235-9f22-4bc2-a3c7-e376a5bb0b3b', 4, 'Boya Sıçratma Anı', 'Paint Splash Moment', 'Hep birlikte tuvale boya fırlatın ve cinsiyetin rengini ortaya çıkarın.', 'Throw paint at the canvas together and reveal the gender color.', true, 0, 0);

-- 33. Painted T-Shirt Gender Reveal
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'bdfd2afa-6969-4864-ba17-b894e209a4ec', 1, 'Tişört ve Boya Temini', 'Get T-Shirts and Paint', 'Beyaz tişörtler ve kumaş boyaları satın alın.', 'Buy white t-shirts and fabric paints.', false, 7, 300),
(gen_random_uuid(), 'bdfd2afa-6969-4864-ba17-b894e209a4ec', 2, 'Tişört Tasarımı Planlama', 'Plan T-Shirt Design', 'Cinsiyete uygun gizli mesajlı bir tasarım planlayın.', 'Plan a design with a hidden message appropriate to the gender.', false, 5, 0),
(gen_random_uuid(), 'bdfd2afa-6969-4864-ba17-b894e209a4ec', 3, 'Tişörtleri Boyama', 'Paint the T-Shirts', 'Tişörtleri cinsiyete uygun renk ve desenlerle boyayın.', 'Paint the t-shirts with gender-appropriate colors and patterns.', false, 3, 0),
(gen_random_uuid(), 'bdfd2afa-6969-4864-ba17-b894e209a4ec', 4, 'Tişörtleri Paketleme', 'Package the T-Shirts', 'Boyalı tişörtleri güzel bir şekilde paketleyin.', 'Beautifully package the painted t-shirts.', true, 1, 50),
(gen_random_uuid(), 'bdfd2afa-6969-4864-ba17-b894e209a4ec', 5, 'Tişörtleri Giyme Anı', 'T-Shirt Wearing Moment', 'Hep birlikte tişörtleri açın, giyin ve cinsiyeti kutlayın.', 'Open the t-shirts together, wear them, and celebrate the gender.', true, 0, 0);

-- 34. Pinata Gender Reveal
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'd273ce6a-d58f-436e-8556-bb9cba3755cc', 1, 'Pinyata Temin Etme', 'Get Pinata', 'Cinsiyet açıklaması için özel bir pinyata sipariş edin veya kendiniz yapın.', 'Order a special pinata for gender reveal or make one yourself.', false, 10, 300),
(gen_random_uuid(), 'd273ce6a-d58f-436e-8556-bb9cba3755cc', 2, 'Pinyatayı Doldurma', 'Fill the Pinata', 'Pinyatanın içine cinsiyete uygun renkte konfeti ve şeker doldurun.', 'Fill the pinata with confetti and candy in the appropriate gender color.', false, 3, 150),
(gen_random_uuid(), 'd273ce6a-d58f-436e-8556-bb9cba3755cc', 3, 'Mekan Hazırlığı', 'Prepare Venue', 'Pinyatayı asacak güvenli bir alan belirleyin ve dekorasyonları yapın.', 'Identify a safe area to hang the pinata and set up decorations.', false, 1, 200),
(gen_random_uuid(), 'd273ce6a-d58f-436e-8556-bb9cba3755cc', 4, 'Pinyatayı Kırma', 'Break the Pinata', 'Anne ve baba birlikte pinyatayı kırsın ve renkli konfetileri görsün.', 'Let the parents break the pinata together and see the colored confetti.', true, 0, 0);

-- 35. Puzzle Piece Gender Reveal
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '430e1bf6-666f-4281-9d23-6a54e393f69b', 1, 'Yapboz Tasarımı', 'Puzzle Design', 'Cinsiyeti açıklayan bir görselle özel bir yapboz tasarlayın veya sipariş edin.', 'Design or order a custom puzzle with an image revealing the gender.', false, 14, 250),
(gen_random_uuid(), '430e1bf6-666f-4281-9d23-6a54e393f69b', 2, 'Yapbozu Sipariş Etme', 'Order the Puzzle', 'Özel tasarımlı yapbozu bir baskı merkezinden sipariş edin.', 'Order the custom-designed puzzle from a print center.', false, 10, 0),
(gen_random_uuid(), '430e1bf6-666f-4281-9d23-6a54e393f69b', 3, 'Mekan ve Masa Hazırlığı', 'Prepare Venue and Table', 'Yapbozun tamamlanacağı masayı ve mekanı hazırlayın.', 'Prepare the table and venue where the puzzle will be completed.', false, 1, 100),
(gen_random_uuid(), '430e1bf6-666f-4281-9d23-6a54e393f69b', 4, 'Yapbozu Birlikte Tamamlama', 'Complete Puzzle Together', 'Aile ile birlikte yapbozu tamamlayın ve son parçada cinsiyeti görün.', 'Complete the puzzle with family and see the gender in the last piece.', true, 0, 0);

-- 36. Rainbow Themed Baby Shower
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'c2f17bb9-3d30-48ac-9463-a683b4c14048', 1, 'Gökkuşağı Temalı Davetiye', 'Rainbow Themed Invitations', 'Gökkuşağı renklerinde davetiyeler tasarlayın ve misafirlere gönderin.', 'Design invitations in rainbow colors and send them to guests.', false, 14, 200),
(gen_random_uuid(), 'c2f17bb9-3d30-48ac-9463-a683b4c14048', 2, 'Gökkuşağı Dekorasyonu', 'Rainbow Decoration', 'Yedi renkte balonlar, flamalar ve gökkuşağı kemeri hazırlayın.', 'Prepare balloons, banners, and a rainbow arch in seven colors.', false, 5, 800),
(gen_random_uuid(), 'c2f17bb9-3d30-48ac-9463-a683b4c14048', 3, 'Renkli Yiyecekler Hazırlama', 'Prepare Colorful Food', 'Gökkuşağı kek, renkli meyve tabağı ve renkli içecekler hazırlayın.', 'Prepare rainbow cake, colorful fruit platter, and colorful drinks.', false, 2, 900),
(gen_random_uuid(), 'c2f17bb9-3d30-48ac-9463-a683b4c14048', 4, 'Dilek Balonu Aktivitesi', 'Wish Balloon Activity', 'Her misafirin farklı renkte bir balona dilek yazmasını sağlayın.', 'Have each guest write a wish on a different colored balloon.', true, 1, 100),
(gen_random_uuid(), 'c2f17bb9-3d30-48ac-9463-a683b4c14048', 5, 'Parti Başlatma', 'Start the Party', 'Tüm hazırlıkları tamamlayın ve renkli partiyi başlatın.', 'Complete all preparations and start the colorful party.', true, 0, 0);

-- 37. Safari Themed Baby Shower
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'd9b0335c-34d3-4d69-83a3-20ed9ff52d32', 1, 'Safari Davetiyesi Hazırlama', 'Prepare Safari Invitations', 'Hayvan baskılı ve yeşil tonlarda davetiyeler tasarlayıp gönderin.', 'Design and send invitations with animal prints in green tones.', false, 14, 200),
(gen_random_uuid(), 'd9b0335c-34d3-4d69-83a3-20ed9ff52d32', 2, 'Safari Dekorasyonu', 'Safari Decorations', 'Yapay yapraklar, hayvan figürleri ve leopar desenli süslerle mekanı dekore edin.', 'Decorate the venue with artificial leaves, animal figures, and leopard print ornaments.', false, 5, 700),
(gen_random_uuid(), 'd9b0335c-34d3-4d69-83a3-20ed9ff52d32', 3, 'Safari Yiyecekleri', 'Safari Food', 'Hayvan şekilli kurabiyeler, tropik meyveler ve safari pastası hazırlayın.', 'Prepare animal-shaped cookies, tropical fruits, and a safari cake.', false, 2, 800),
(gen_random_uuid(), 'd9b0335c-34d3-4d69-83a3-20ed9ff52d32', 4, 'Hayvan Tahmin Oyunu', 'Animal Guessing Game', 'Misafirler için hayvan seslerini tahmin etme oyunu hazırlayın.', 'Prepare an animal sound guessing game for guests.', true, 1, 50),
(gen_random_uuid(), 'd9b0335c-34d3-4d69-83a3-20ed9ff52d32', 5, 'Parti Düzenleme', 'Set Up Party', 'Son hazırlıkları yapın ve safari macerasını başlatın.', 'Make final preparations and start the safari adventure.', true, 0, 0);

-- 38. Scratch Card Gender Reveal
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '8b518851-a843-492c-a1fd-3aaf8c337105', 1, 'Kazı Kazan Kartı Tasarlama', 'Design Scratch Cards', 'Cinsiyeti gizleyen özel kazı kazan kartları tasarlayın.', 'Design custom scratch cards that hide the gender.', false, 10, 0),
(gen_random_uuid(), '8b518851-a843-492c-a1fd-3aaf8c337105', 2, 'Kartları Bastırma', 'Print the Cards', 'Kazı kazan kartlarını profesyonel olarak bastırın veya evde yapın.', 'Have the scratch cards professionally printed or make them at home.', false, 7, 200),
(gen_random_uuid(), '8b518851-a843-492c-a1fd-3aaf8c337105', 3, 'Kartları Dağıtma Planı', 'Plan Card Distribution', 'Her misafire bir kart verilecek şekilde dağıtım planı yapın.', 'Plan distribution so each guest receives a card.', false, 2, 0),
(gen_random_uuid(), '8b518851-a843-492c-a1fd-3aaf8c337105', 4, 'Kartları Kazıma Anı', 'Card Scratching Moment', 'Hep birlikte geri sayım yapın ve kartları aynı anda kazıyın.', 'Count down together and scratch the cards at the same time.', true, 0, 0);

-- 39. Smoke Bomb Gender Reveal
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '6b274203-c0b1-4a26-a79b-b934b01c3314', 1, 'Duman Bombası Temin Etme', 'Get Smoke Bombs', 'Cinsiyete uygun renkte güvenli duman bombalarını sipariş edin.', 'Order safe smoke bombs in the appropriate gender color.', false, 10, 400),
(gen_random_uuid(), '6b274203-c0b1-4a26-a79b-b934b01c3314', 2, 'Güvenli Mekan Seçimi', 'Choose Safe Location', 'Açık havada, rüzgar yönüne uygun güvenli bir alan belirleyin.', 'Identify a safe outdoor area suitable for wind direction.', false, 5, 0),
(gen_random_uuid(), '6b274203-c0b1-4a26-a79b-b934b01c3314', 3, 'Fotoğrafçı Ayarlama', 'Arrange Photographer', 'Duman anını profesyonel fotoğraflarla ölümsüzleştirmek için fotoğrafçı ayarlayın.', 'Arrange a photographer to immortalize the smoke moment with professional photos.', false, 3, 1000),
(gen_random_uuid(), '6b274203-c0b1-4a26-a79b-b934b01c3314', 4, 'Misafirleri Pozisyonlandırma', 'Position Guests', 'Misafirleri güvenli bir mesafeye konumlandırın ve kameraları hazırlayın.', 'Position guests at a safe distance and prepare cameras.', true, 0, 0),
(gen_random_uuid(), '6b274203-c0b1-4a26-a79b-b934b01c3314', 5, 'Duman Bombasını Patlatma', 'Pop the Smoke Bomb', 'Duman bombasını ateşleyin ve renkli dumanla cinsiyeti açıklayın.', 'Light the smoke bomb and reveal the gender with colorful smoke.', true, 0, 0);

-- 40. Sports Ball Gender Reveal
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '4981d61e-78f2-424b-b888-8d5cfe6fdc89', 1, 'Cinsiyet Açıklama Topu Sipariş Etme', 'Order Gender Reveal Ball', 'İçinde renkli toz bulunan bir futbol, basketbol veya golf topu sipariş edin.', 'Order a football, basketball, or golf ball filled with colored powder.', false, 10, 350),
(gen_random_uuid(), '4981d61e-78f2-424b-b888-8d5cfe6fdc89', 2, 'Spor Alanı Ayarlama', 'Set Up Sports Area', 'Topu atacağınız veya vuracağınız açık bir alan hazırlayın.', 'Prepare an open area where you will throw or hit the ball.', false, 3, 0),
(gen_random_uuid(), '4981d61e-78f2-424b-b888-8d5cfe6fdc89', 3, 'Misafirleri Toplama', 'Gather Guests', 'Aile ve arkadaşları belirlenen alan ve saatte bir araya getirin.', 'Gather family and friends at the designated area and time.', false, 5, 0),
(gen_random_uuid(), '4981d61e-78f2-424b-b888-8d5cfe6fdc89', 4, 'Topu Atma/Vurma', 'Throw/Hit the Ball', 'Anne veya babadan biri topu atsın/vursun ve renkli toz açığa çıksın.', 'Have one parent throw/hit the ball and release the colored powder.', true, 0, 0);

-- 41. Stork Themed Home Decoration Surprise
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'e048954c-6dcd-4cfd-9e1e-090f8a6c441d', 1, 'Leylek Dekorasyon Malzemeleri Temin Etme', 'Get Stork Decoration Materials', 'Büyük leylek figürü, balonlar ve "Hoş geldin bebek" yazılı süsler satın alın.', 'Buy a large stork figure, balloons, and "Welcome baby" signs.', false, 7, 500),
(gen_random_uuid(), 'e048954c-6dcd-4cfd-9e1e-090f8a6c441d', 2, 'Dekorasyon Planı Yapma', 'Plan Decoration Layout', 'Evin hangi bölümlerinin nasıl süsleneceğini detaylı olarak planlayın.', 'Plan in detail which parts of the house will be decorated and how.', false, 5, 0),
(gen_random_uuid(), 'e048954c-6dcd-4cfd-9e1e-090f8a6c441d', 3, 'Evi Gizlice Süsleme', 'Secretly Decorate the House', 'Anne veya baba evde yokken tüm dekorasyonları yerleştirin.', 'Place all decorations while the mother or father is not at home.', false, 0, 0),
(gen_random_uuid(), 'e048954c-6dcd-4cfd-9e1e-090f8a6c441d', 4, 'Hediye Sepeti Hazırlama', 'Prepare Gift Basket', 'Bebek kıyafetleri ve oyuncaklarla dolu bir hediye sepeti hazırlayın.', 'Prepare a gift basket filled with baby clothes and toys.', true, 1, 800),
(gen_random_uuid(), 'e048954c-6dcd-4cfd-9e1e-090f8a6c441d', 5, 'Sürpriz Anı', 'Surprise Moment', 'Kapıda karşılayın ve süslenmiş evi göstererek sürprizi yapın.', 'Greet at the door and reveal the surprise by showing the decorated house.', true, 0, 0);

-- 42. Teddy Bear Baby Shower
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '05fc0f41-fc1f-4cc8-a18c-91b6f193b287', 1, 'Oyuncak Ayı Temalı Davetiye', 'Teddy Bear Themed Invitations', 'Sevimli oyuncak ayı görsellerle davetiyeler hazırlayın ve gönderin.', 'Prepare invitations with cute teddy bear visuals and send them.', false, 14, 200),
(gen_random_uuid(), '05fc0f41-fc1f-4cc8-a18c-91b6f193b287', 2, 'Oyuncak Ayı Dekorasyonu', 'Teddy Bear Decorations', 'Farklı boyutlarda oyuncak ayılar, kahverengi-bej balonlar ve ayı figürleri hazırlayın.', 'Prepare teddy bears in different sizes, brown-beige balloons, and bear figures.', false, 5, 600),
(gen_random_uuid(), '05fc0f41-fc1f-4cc8-a18c-91b6f193b287', 3, 'Ayı Temalı Yiyecekler', 'Bear Themed Food', 'Ayı pençesi şekilli kurabiyeler ve ayı yüzlü cupcake''ler hazırlayın.', 'Prepare bear paw shaped cookies and bear face cupcakes.', false, 2, 700),
(gen_random_uuid(), '05fc0f41-fc1f-4cc8-a18c-91b6f193b287', 4, 'Ayı Yapma Aktivitesi', 'Bear Making Activity', 'Misafirlerin kendi oyuncak ayılarını dolduracağı bir köşe kurun.', 'Set up a corner where guests can stuff their own teddy bears.', true, 1, 500),
(gen_random_uuid(), '05fc0f41-fc1f-4cc8-a18c-91b6f193b287', 5, 'Parti Başlatma', 'Start the Party', 'Dekorasyonları son kez kontrol edin ve misafirleri karşılayın.', 'Check decorations one last time and welcome guests.', true, 0, 0);

-- 43. Twinkle Star Baby Shower
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '5a14bb2d-a081-4bf8-a97b-11ae6136be3a', 1, 'Yıldız Temalı Davetiye', 'Star Themed Invitations', '"Twinkle Twinkle Little Star" temalı davetiyeler tasarlayın.', 'Design "Twinkle Twinkle Little Star" themed invitations.', false, 14, 200),
(gen_random_uuid(), '5a14bb2d-a081-4bf8-a97b-11ae6136be3a', 2, 'Yıldız Işıkları ve Dekorasyon', 'Star Lights and Decorations', 'Yıldız şekilli ışıklar, altın yıldız süsler ve pırıltılı kumaşlar temin edin.', 'Get star-shaped lights, gold star ornaments, and glittery fabrics.', false, 7, 600),
(gen_random_uuid(), '5a14bb2d-a081-4bf8-a97b-11ae6136be3a', 3, 'Yıldız Yiyecekleri Hazırlama', 'Prepare Star Food', 'Yıldız şekilli kurabiyeler, simli kekler ve parlak içecekler hazırlayın.', 'Prepare star-shaped cookies, glittery cakes, and sparkling drinks.', false, 2, 700),
(gen_random_uuid(), '5a14bb2d-a081-4bf8-a97b-11ae6136be3a', 4, 'Dilek Yıldızı Aktivitesi', 'Wish Star Activity', 'Her misafirin bir yıldıza bebek için dilek yazmasını sağlayın.', 'Have each guest write a wish for the baby on a star.', true, 1, 50),
(gen_random_uuid(), '5a14bb2d-a081-4bf8-a97b-11ae6136be3a', 5, 'Parti Düzenleme', 'Set Up Party', 'Işıkları karartın, yıldız ışıklarını açın ve büyülü geceyi başlatın.', 'Dim the lights, turn on star lights, and start the magical night.', true, 0, 0);

-- 44. Watercolor Gender Reveal
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '569dc3e5-22e6-41ff-8b33-766f3db24f02', 1, 'Suluboya Malzemeleri Temin Etme', 'Get Watercolor Supplies', 'Beyaz tuval, suluboya seti ve fırçalar satın alın.', 'Buy white canvas, watercolor set, and brushes.', false, 7, 300),
(gen_random_uuid(), '569dc3e5-22e6-41ff-8b33-766f3db24f02', 2, 'Gizli Mesaj Hazırlama', 'Prepare Hidden Message', 'Tuval üzerine beyaz mumla "Boy" veya "Girl" yazın; suluboya sürüldüğünde görünecek.', 'Write "Boy" or "Girl" with white wax on canvas; it will appear when watercolor is applied.', false, 3, 0),
(gen_random_uuid(), '569dc3e5-22e6-41ff-8b33-766f3db24f02', 3, 'Boyama Ortamı Hazırlama', 'Prepare Painting Setup', 'Boyama masasını, koruyucu örtüleri ve malzemeleri düzenleyin.', 'Arrange the painting table, protective covers, and supplies.', false, 1, 50),
(gen_random_uuid(), '569dc3e5-22e6-41ff-8b33-766f3db24f02', 4, 'Boyama ve Cinsiyet Açıklama', 'Paint and Reveal Gender', 'Anne ve baba birlikte tuvale suluboya sürün ve cinsiyetin ortaya çıkmasını izleyin.', 'Have parents paint watercolor on the canvas together and watch the gender appear.', true, 0, 0);

-- 45. Woodland Themed Baby Shower
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'b722e691-9d9c-475b-aa6f-cd5ff3de8928', 1, 'Orman Temalı Davetiye', 'Woodland Themed Invitations', 'Tilki, geyik ve sincap görselli doğal tonlarda davetiyeler hazırlayın.', 'Prepare invitations in natural tones with fox, deer, and squirrel illustrations.', false, 14, 200),
(gen_random_uuid(), 'b722e691-9d9c-475b-aa6f-cd5ff3de8928', 2, 'Orman Dekorasyonu', 'Woodland Decorations', 'Kütük, kozalak, yaprak ve mantar süsleri ile doğal bir ortam yaratın.', 'Create a natural ambiance with log, pinecone, leaf, and mushroom ornaments.', false, 5, 600),
(gen_random_uuid(), 'b722e691-9d9c-475b-aa6f-cd5ff3de8928', 3, 'Doğa Temalı Yiyecekler', 'Nature Themed Food', 'Mantar şekilli kurabiyeler, orman meyveli tart ve doğal içecekler hazırlayın.', 'Prepare mushroom-shaped cookies, forest fruit tart, and natural drinks.', false, 2, 700),
(gen_random_uuid(), 'b722e691-9d9c-475b-aa6f-cd5ff3de8928', 4, 'Hayvan Maskesi Aktivitesi', 'Animal Mask Activity', 'Misafirler için orman hayvanları temalı maske yapma etkinliği düzenleyin.', 'Organize a forest animal mask-making activity for guests.', true, 1, 200),
(gen_random_uuid(), 'b722e691-9d9c-475b-aa6f-cd5ff3de8928', 5, 'Parti Başlatma', 'Start the Party', 'Doğal ortamı son kez kontrol edin ve orman partisini başlatın.', 'Check the natural setting one last time and start the woodland party.', true, 0, 0);

-- 46. Classic Baby Shower
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a0000012-0001-0001-0001-000000000001', 1, 'Davetiye Hazırlama ve Gönderme', 'Prepare and Send Invitations', 'Klasik baby shower davetiyelerini hazırlayın ve misafir listesindeki herkese gönderin.', 'Prepare classic baby shower invitations and send them to everyone on the guest list.', false, 14, 200),
(gen_random_uuid(), 'a0000012-0001-0001-0001-000000000001', 2, 'Mekan ve Dekorasyon', 'Venue and Decoration', 'Pastel renklerle mekanı süsleyin; balonlar, çiçekler ve bebek temalı süsler kullanın.', 'Decorate the venue in pastel colors using balloons, flowers, and baby-themed ornaments.', false, 5, 800),
(gen_random_uuid(), 'a0000012-0001-0001-0001-000000000001', 3, 'Yiyecek ve İçecek Hazırlama', 'Prepare Food and Drinks', 'Mini sandviçler, kurabiyeler, pasta ve meyveli içecekler hazırlayın.', 'Prepare mini sandwiches, cookies, cake, and fruit drinks.', false, 2, 1000),
(gen_random_uuid(), 'a0000012-0001-0001-0001-000000000001', 4, 'Oyunlar Planlama', 'Plan Games', 'Bebek bezi yarışı, bebek fotoğrafı tahmin oyunu gibi klasik oyunlar hazırlayın.', 'Prepare classic games like diaper relay and baby photo guessing game.', true, 3, 200),
(gen_random_uuid(), 'a0000012-0001-0001-0001-000000000001', 5, 'Hediye Açılışı Düzenleme', 'Organize Gift Opening', 'Hediye açma alanını hazırlayın ve anıları kaydedin.', 'Prepare the gift opening area and record the memories.', true, 0, 0);

-- 47. Birthday Advent Calendar
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'c2b7c3cf-6db4-4f1e-9e1c-e674e8926e97', 1, 'Takvim Tasarımı', 'Calendar Design', 'Doğum gününe kadar açılacak gün sayısını belirleyin ve takvim yapısını tasarlayın.', 'Determine the number of days until the birthday and design the calendar structure.', false, 30, 0),
(gen_random_uuid(), 'c2b7c3cf-6db4-4f1e-9e1c-e674e8926e97', 2, 'Hediye ve Sürpriz Hazırlama', 'Prepare Gifts and Surprises', 'Her gün için küçük bir hediye, not veya aktivite hazırlayın.', 'Prepare a small gift, note, or activity for each day.', false, 20, 1000),
(gen_random_uuid(), 'c2b7c3cf-6db4-4f1e-9e1c-e674e8926e97', 3, 'Takvimi Oluşturma', 'Build the Calendar', 'Zarflar, kutucuklar veya poşetlerle fiziksel takvimi oluşturun.', 'Build the physical calendar using envelopes, boxes, or pouches.', false, 15, 300),
(gen_random_uuid(), 'c2b7c3cf-6db4-4f1e-9e1c-e674e8926e97', 4, 'Takvimi Asma veya Yerleştirme', 'Hang or Place Calendar', 'Takvimi kişinin göreceği bir yere asın veya yerleştirin.', 'Hang or place the calendar where the person will see it.', true, 14, 0),
(gen_random_uuid(), 'c2b7c3cf-6db4-4f1e-9e1c-e674e8926e97', 5, 'Geri Sayımı Başlatma', 'Start the Countdown', 'İlk günü birlikte açın ve geri sayım heyecanını başlatın.', 'Open the first day together and start the countdown excitement.', true, 0, 0);

-- 48. Adventure Day Passport Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'b7e0411c-5878-42bd-80a4-93c5c2d32bd9', 1, 'Macera Noktaları Belirleme', 'Identify Adventure Spots', 'Gün boyunca ziyaret edilecek farklı macera noktalarını araştırın ve listeleyin.', 'Research and list different adventure spots to visit throughout the day.', false, 14, 0),
(gen_random_uuid(), 'b7e0411c-5878-42bd-80a4-93c5c2d32bd9', 2, 'Pasaport Kitapçığı Hazırlama', 'Create Passport Booklet', 'Her durak için damga alanı olan kişiselleştirilmiş bir macera pasaportu tasarlayın.', 'Design a personalized adventure passport with stamp areas for each stop.', false, 7, 100),
(gen_random_uuid(), 'b7e0411c-5878-42bd-80a4-93c5c2d32bd9', 3, 'Aktivite Rezervasyonları', 'Activity Reservations', 'Her durağın aktivitesini önceden ayırtın veya organize edin.', 'Book or organize the activity at each stop in advance.', false, 5, 2000),
(gen_random_uuid(), 'b7e0411c-5878-42bd-80a4-93c5c2d32bd9', 4, 'Damga ve Ödül Hazırlama', 'Prepare Stamps and Prizes', 'Her durak için farklı damgalar ve final ödülünü hazırlayın.', 'Prepare different stamps for each stop and the final prize.', true, 2, 200),
(gen_random_uuid(), 'b7e0411c-5878-42bd-80a4-93c5c2d32bd9', 5, 'Macera Gününü Başlatma', 'Start Adventure Day', 'Pasaportu hediye edin ve ilk macera durağına doğru yola çıkın.', 'Gift the passport and head towards the first adventure stop.', true, 0, 0);

-- 49. Art Jamming Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'b1a346ad-aaa9-4361-a728-0d6cd146bdb1', 1, 'Sanat Atölyesi Rezervasyonu', 'Book Art Studio', 'Grup sanat etkinliği için bir atölye veya mekan ayırtın.', 'Book a studio or venue for the group art activity.', false, 14, 1500),
(gen_random_uuid(), 'b1a346ad-aaa9-4361-a728-0d6cd146bdb1', 2, 'Sanat Malzemeleri Temin Etme', 'Get Art Supplies', 'Tuval, boya, fırça ve önlük gibi malzemeleri temin edin.', 'Get supplies like canvas, paint, brushes, and aprons.', false, 5, 800),
(gen_random_uuid(), 'b1a346ad-aaa9-4361-a728-0d6cd146bdb1', 3, 'Misafirleri Davet Etme', 'Invite Guests', 'Sanat temalı davetiyelerle misafirleri bilgilendirin.', 'Inform guests with art-themed invitations.', false, 10, 100),
(gen_random_uuid(), 'b1a346ad-aaa9-4361-a728-0d6cd146bdb1', 4, 'Yiyecek ve İçecek Hazırlama', 'Prepare Food and Drinks', 'Boyama sırasında yenecek atıştırmalıklar ve içecekler hazırlayın.', 'Prepare snacks and drinks to enjoy during painting.', true, 1, 500),
(gen_random_uuid(), 'b1a346ad-aaa9-4361-a728-0d6cd146bdb1', 5, 'Sanat Partisi Başlatma', 'Start Art Party', 'Mekanı düzenleyin, müziği açın ve yaratıcı partiyi başlatın.', 'Set up the venue, turn on music, and start the creative party.', true, 0, 0);

-- 50. Memory Balloon Ceiling Surprise
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '56756ea2-7559-41b8-ba5a-61f0eef432e5', 1, 'Fotoğraf ve Anıları Toplama', 'Collect Photos and Memories', 'Doğum günü kişisinin en güzel anılarının fotoğraflarını toplayın.', 'Collect photos of the birthday person''s best memories.', false, 10, 0),
(gen_random_uuid(), '56756ea2-7559-41b8-ba5a-61f0eef432e5', 2, 'Balonları ve Fotoğrafları Hazırlama', 'Prepare Balloons and Photos', 'Helyum balonları şişirin ve her birinin ipine bir fotoğraf bağlayın.', 'Inflate helium balloons and tie a photo to each string.', false, 1, 600),
(gen_random_uuid(), '56756ea2-7559-41b8-ba5a-61f0eef432e5', 3, 'Odayı Gizlice Süsleme', 'Secretly Decorate Room', 'Kişi uyurken veya dışarıdayken odanın tavanını balonlarla doldurun.', 'Fill the ceiling with balloons while the person is sleeping or out.', false, 0, 0),
(gen_random_uuid(), '56756ea2-7559-41b8-ba5a-61f0eef432e5', 4, 'Ek Sürprizler Ekleme', 'Add Extra Surprises', 'Balonların arasına el yazısı notlar ve küçük hediyeler ekleyin.', 'Add handwritten notes and small gifts among the balloons.', true, 0, 100),
(gen_random_uuid(), '56756ea2-7559-41b8-ba5a-61f0eef432e5', 5, 'Sürprizi İzleme', 'Watch the Surprise', 'Kişinin odaya girdiğinde tepkisini izleyin ve kutlamayı başlatın.', 'Watch the person''s reaction entering the room and start celebrating.', true, 0, 0);

-- 51. 365 Messages Birthday Jar
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '818e3a0d-c72a-4c94-acce-1042bbeaf3fe', 1, 'Güzel Bir Kavanoz Temin Etme', 'Get a Beautiful Jar', 'Büyük ve şık bir cam kavanoz satın alın veya mevcut birini süsleyin.', 'Buy a large and elegant glass jar or decorate an existing one.', false, 30, 100),
(gen_random_uuid(), '818e3a0d-c72a-4c94-acce-1042bbeaf3fe', 2, '365 Mesaj Yazma', 'Write 365 Messages', 'Her gün için bir sevgi, motivasyon veya anı mesajı yazın.', 'Write a love, motivation, or memory message for each day.', false, 25, 0),
(gen_random_uuid(), '818e3a0d-c72a-4c94-acce-1042bbeaf3fe', 3, 'Mesajları Katlama ve Yerleştirme', 'Fold and Place Messages', 'Mesajları renkli kağıtlara yazıp katlayın ve kavanoza yerleştirin.', 'Write messages on colored papers, fold them, and place them in the jar.', false, 5, 100),
(gen_random_uuid(), '818e3a0d-c72a-4c94-acce-1042bbeaf3fe', 4, 'Kavanozu Süsleme', 'Decorate the Jar', 'Kavanozu kurdele, etiket ve süslerle dekore edin.', 'Decorate the jar with ribbon, label, and ornaments.', true, 2, 50),
(gen_random_uuid(), '818e3a0d-c72a-4c94-acce-1042bbeaf3fe', 5, 'Hediyeyi Sunma', 'Present the Gift', 'Kavanozu doğum gününde hediye edin ve her gün bir mesaj okumasını söyleyin.', 'Gift the jar on the birthday and tell them to read one message each day.', true, 0, 0);

-- 52. Personal Birthday Newspaper
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'f29e3026-a8c2-454b-854e-9fd8c546756a', 1, 'İçerik Toplama', 'Collect Content', 'Kişinin hayatından komik anekdotlar, önemli olaylar ve fotoğraflar toplayın.', 'Collect funny anecdotes, important events, and photos from the person''s life.', false, 14, 0),
(gen_random_uuid(), 'f29e3026-a8c2-454b-854e-9fd8c546756a', 2, 'Gazete Tasarımı', 'Design Newspaper', 'Gerçek bir gazete formatında sayfa düzenini oluşturun ve haberleri yazın.', 'Create the page layout in a real newspaper format and write the articles.', false, 7, 0),
(gen_random_uuid(), 'f29e3026-a8c2-454b-854e-9fd8c546756a', 3, 'Gazeteyi Bastırma', 'Print the Newspaper', 'Gazeteyi profesyonel bir matbaada veya kaliteli bir yazıcıda bastırın.', 'Print the newspaper at a professional print shop or quality printer.', false, 3, 300),
(gen_random_uuid(), 'f29e3026-a8c2-454b-854e-9fd8c546756a', 4, 'Gazeteyi Sunma', 'Present the Newspaper', 'Gazeteyi sabah kahvaltısında gerçek bir gazete gibi sunun.', 'Present the newspaper like a real newspaper at breakfast.', true, 0, 0);

-- 53. Spin Wheel Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '12f9395e-630d-4e3e-bfd9-6811b61fd48e', 1, 'Çarkıfelek Hazırlama', 'Build Spin Wheel', 'Kartondan veya tahtadan renkli bir çarkıfelek yapın veya satın alın.', 'Make a colorful spin wheel from cardboard or wood, or buy one.', false, 10, 300),
(gen_random_uuid(), '12f9395e-630d-4e3e-bfd9-6811b61fd48e', 2, 'Ödüller ve Aktiviteler Belirleme', 'Set Prizes and Activities', 'Çarkın her dilimi için farklı bir hediye veya aktivite belirleyin.', 'Assign a different gift or activity for each section of the wheel.', false, 7, 1000),
(gen_random_uuid(), '12f9395e-630d-4e3e-bfd9-6811b61fd48e', 3, 'Ödülleri Hazırlama', 'Prepare Prizes', 'Her dilimde yazan hediye ve aktivitelerin hazırlığını tamamlayın.', 'Complete the preparation of gifts and activities listed on each section.', false, 3, 0),
(gen_random_uuid(), '12f9395e-630d-4e3e-bfd9-6811b61fd48e', 4, 'Mekanı Süsleme', 'Decorate Venue', 'Çarkın etrafını balonlar ve süslerle dekore edin.', 'Decorate around the wheel with balloons and ornaments.', true, 1, 200),
(gen_random_uuid(), '12f9395e-630d-4e3e-bfd9-6811b61fd48e', 5, 'Çarkı Çevirme', 'Spin the Wheel', 'Doğum günü kişisinin çarkı çevirmesini izleyin ve ödülleri sunun.', 'Watch the birthday person spin the wheel and present the prizes.', true, 0, 0);

-- 54. Birthday Treasure Hunt
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a0000001-0001-0001-0001-000000000003', 1, 'İpucu Noktalarını Belirleme', 'Identify Clue Locations', 'Evde veya şehirde 5-8 ipucu noktası belirleyin ve rotayı planlayın.', 'Identify 5-8 clue locations at home or in the city and plan the route.', false, 7, 0),
(gen_random_uuid(), 'a0000001-0001-0001-0001-000000000003', 2, 'İpuçlarını ve Bilmeceleri Yazma', 'Write Clues and Riddles', 'Her nokta için eğlenceli bilmeceler ve ipuçları hazırlayın.', 'Prepare fun riddles and clues for each location.', false, 5, 0),
(gen_random_uuid(), 'a0000001-0001-0001-0001-000000000003', 3, 'Son Hediyeyi Hazırlama', 'Prepare Final Gift', 'Hazine avının sonunda bulunacak özel doğum günü hediyesini paketleyin.', 'Package the special birthday gift to be found at the end of the treasure hunt.', false, 2, 500),
(gen_random_uuid(), 'a0000001-0001-0001-0001-000000000003', 4, 'İpuçlarını Gizleme', 'Hide the Clues', 'Tüm ipuçlarını belirlenen noktalara gizleyin.', 'Hide all clues at the designated locations.', true, 0, 50),
(gen_random_uuid(), 'a0000001-0001-0001-0001-000000000003', 5, 'Avı Başlatma', 'Start the Hunt', 'İlk ipucunu verin ve doğum günü kişisinin macerasını izleyin.', 'Give the first clue and watch the birthday person''s adventure.', true, 0, 0);

-- 55. Boat Party Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'd855c877-dc42-4305-8e2b-8af758ed0242', 1, 'Tekne Rezervasyonu', 'Book the Boat', 'Misafir sayısına uygun bir tekne veya yat kiralayın.', 'Rent a boat or yacht suitable for the number of guests.', false, 14, 5000),
(gen_random_uuid(), 'd855c877-dc42-4305-8e2b-8af758ed0242', 2, 'Yiyecek ve İçecek Planı', 'Plan Food and Drinks', 'Teknede servis edilecek yiyecek ve içecek menüsünü planlayın.', 'Plan the food and drink menu to be served on the boat.', false, 7, 2000),
(gen_random_uuid(), 'd855c877-dc42-4305-8e2b-8af758ed0242', 3, 'Dekorasyon ve Müzik', 'Decoration and Music', 'Tekneyi balonlar ve süslerle dekore edin, müzik listesini hazırlayın.', 'Decorate the boat with balloons and ornaments, prepare the music playlist.', false, 2, 500),
(gen_random_uuid(), 'd855c877-dc42-4305-8e2b-8af758ed0242', 4, 'Misafirleri Bilgilendirme', 'Inform Guests', 'Misafirlere kıyafet önerisi, buluşma noktası ve saat bilgisi verin.', 'Give guests clothing suggestions, meeting point, and time information.', true, 5, 0),
(gen_random_uuid(), 'd855c877-dc42-4305-8e2b-8af758ed0242', 5, 'Partiye Başlama', 'Start the Party', 'Misafirleri teknede karşılayın ve denizde doğum günü kutlamasını başlatın.', 'Welcome guests on the boat and start the birthday celebration at sea.', true, 0, 0);

-- 56. Breakfast in Bed Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'b6465593-4574-4d3a-8424-338cc9a42626', 1, 'Menü Planlama', 'Plan Menu', 'Kişinin en sevdiği kahvaltılıkları belirleyin ve menüyü oluşturun.', 'Identify the person''s favorite breakfast items and create the menu.', false, 3, 0),
(gen_random_uuid(), 'b6465593-4574-4d3a-8424-338cc9a42626', 2, 'Malzeme Alışverişi', 'Shop for Ingredients', 'Taze meyve, yumurta, ekmek ve özel malzemeleri satın alın.', 'Buy fresh fruits, eggs, bread, and special ingredients.', false, 1, 200),
(gen_random_uuid(), 'b6465593-4574-4d3a-8424-338cc9a42626', 3, 'Kahvaltıyı Hazırlama', 'Prepare Breakfast', 'Sabah erken kalkın ve kahvaltıyı sessizce hazırlayın.', 'Wake up early and quietly prepare the breakfast.', false, 0, 0),
(gen_random_uuid(), 'b6465593-4574-4d3a-8424-338cc9a42626', 4, 'Tepsi Süsleme', 'Decorate Tray', 'Tepsiyi çiçek, mum ve doğum günü kartıyla süsleyin.', 'Decorate the tray with flowers, candles, and a birthday card.', true, 0, 50),
(gen_random_uuid(), 'b6465593-4574-4d3a-8424-338cc9a42626', 5, 'Kahvaltıyı Sunma', 'Serve Breakfast', 'Tepsiyi yatağa getirin ve "Doğum günün kutlu olsun" diyerek sunun.', 'Bring the tray to bed and present it saying "Happy Birthday".', true, 0, 0);

-- 57. Concert Ticket Reveal Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '4e3b94fb-76f9-4c0f-83b6-ef9fb3b7cdde', 1, 'Konser Araştırma ve Bilet Alma', 'Research Concert and Buy Tickets', 'Kişinin en sevdiği sanatçının yaklaşan konserini bulun ve bilet alın.', 'Find an upcoming concert of the person''s favorite artist and buy tickets.', false, 30, 2000),
(gen_random_uuid(), '4e3b94fb-76f9-4c0f-83b6-ef9fb3b7cdde', 2, 'Yaratıcı Açıklama Yöntemi Planlama', 'Plan Creative Reveal Method', 'Bileti yapboz, hediye kutusu veya hazine avı gibi yaratıcı bir şekilde açıklayın.', 'Plan to reveal the ticket creatively through a puzzle, gift box, or treasure hunt.', false, 7, 100),
(gen_random_uuid(), '4e3b94fb-76f9-4c0f-83b6-ef9fb3b7cdde', 3, 'Sürpriz Hazırlığı', 'Prepare Surprise', 'Bilet açıklama paketini hazırlayın ve güzel bir şekilde paketleyin.', 'Prepare the ticket reveal package and wrap it beautifully.', false, 2, 50),
(gen_random_uuid(), '4e3b94fb-76f9-4c0f-83b6-ef9fb3b7cdde', 4, 'Bileti Açıklama', 'Reveal the Ticket', 'Doğum gününde sürprizi yapın ve biletleri heyecanla açıklayın.', 'Make the surprise on the birthday and excitedly reveal the tickets.', true, 0, 0);

-- 58. Cooking Class Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '12b75913-1663-4185-b06b-fb4ac059712c', 1, 'Yemek Kursu Araştırma', 'Research Cooking Classes', 'Kişinin ilgi alanına uygun yemek kurslarını araştırın ve karşılaştırın.', 'Research cooking classes suitable for the person''s interests and compare them.', false, 14, 0),
(gen_random_uuid(), '12b75913-1663-4185-b06b-fb4ac059712c', 2, 'Kurs Rezervasyonu', 'Book the Class', 'Grup için uygun bir yemek kursu rezervasyonu yapın.', 'Book a suitable cooking class for the group.', false, 10, 1500),
(gen_random_uuid(), '12b75913-1663-4185-b06b-fb4ac059712c', 3, 'Misafirleri Bilgilendirme', 'Inform Guests', 'Misafirlere tarih, saat ve kıyafet önerisini iletin.', 'Inform guests about the date, time, and clothing suggestion.', false, 7, 0),
(gen_random_uuid(), '12b75913-1663-4185-b06b-fb4ac059712c', 4, 'Özel Detaylar Ekleme', 'Add Special Details', 'Şef ile iletişime geçip doğum günü pastası veya özel menü ekletin.', 'Contact the chef and add a birthday cake or special menu.', true, 3, 300),
(gen_random_uuid(), '12b75913-1663-4185-b06b-fb4ac059712c', 5, 'Sürprizi Açıklama', 'Reveal the Surprise', 'Kişiyi kursa götürerek sürprizi yapın.', 'Make the surprise by taking the person to the class.', true, 0, 0);

-- 59. Desk Transformation Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '39617f11-e9d6-4096-a7ff-6be80bfcbb8a', 1, 'Süsleme Malzemeleri Temin Etme', 'Get Decoration Supplies', 'Balonlar, flamalar, konfeti ve renkli kağıtlar satın alın.', 'Buy balloons, banners, confetti, and colorful papers.', false, 5, 200),
(gen_random_uuid(), '39617f11-e9d6-4096-a7ff-6be80bfcbb8a', 2, 'Küçük Hediyeler Hazırlama', 'Prepare Small Gifts', 'Masanın üzerine bırakılacak küçük sürpriz hediyeler hazırlayın.', 'Prepare small surprise gifts to leave on the desk.', false, 3, 300),
(gen_random_uuid(), '39617f11-e9d6-4096-a7ff-6be80bfcbb8a', 3, 'Masayı Gizlice Süsleme', 'Secretly Decorate Desk', 'Kişi gelmeden önce masasını balonlar, süsler ve hediyelerle doldurun.', 'Fill their desk with balloons, decorations, and gifts before they arrive.', false, 0, 0),
(gen_random_uuid(), '39617f11-e9d6-4096-a7ff-6be80bfcbb8a', 4, 'Doğum Günü Mesajı Bırakma', 'Leave Birthday Message', 'Masanın üzerine kişisel bir doğum günü kartı veya mesajı bırakın.', 'Leave a personal birthday card or message on the desk.', true, 0, 0),
(gen_random_uuid(), '39617f11-e9d6-4096-a7ff-6be80bfcbb8a', 5, 'Tepkiyi İzleme', 'Watch the Reaction', 'Kişinin masasını gördüğündeki tepkisini izleyin ve kutlamayı başlatın.', 'Watch the person''s reaction seeing their desk and start celebrating.', true, 0, 0);

-- 60. Drive-Through Birthday Parade
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'b2306938-af25-45b0-ac2e-92709fb0bc3e', 1, 'Katılımcıları Organize Etme', 'Organize Participants', 'Arabalı geçide katılacak aile ve arkadaşları belirleyin ve iletişime geçin.', 'Identify family and friends who will join the car parade and contact them.', false, 10, 0),
(gen_random_uuid(), 'b2306938-af25-45b0-ac2e-92709fb0bc3e', 2, 'Araba Süsleme Malzemeleri', 'Car Decoration Supplies', 'Araba süsleme için balonlar, yazılar ve süsler satın alın.', 'Buy balloons, signs, and decorations for car decorating.', false, 5, 300),
(gen_random_uuid(), 'b2306938-af25-45b0-ac2e-92709fb0bc3e', 3, 'Geçit Rotası Belirleme', 'Plan Parade Route', 'Geçit güzergahını ve doğum günü kişisinin olacağı noktayı belirleyin.', 'Determine the parade route and the point where the birthday person will be.', false, 3, 0),
(gen_random_uuid(), 'b2306938-af25-45b0-ac2e-92709fb0bc3e', 4, 'Arabaları Süsleme', 'Decorate Cars', 'Katılımcılarla birlikte arabaları balonlar ve "Doğum günün kutlu olsun" yazılarıyla süsleyin.', 'Decorate cars with participants using balloons and "Happy Birthday" signs.', true, 0, 0),
(gen_random_uuid(), 'b2306938-af25-45b0-ac2e-92709fb0bc3e', 5, 'Geçidi Başlatma', 'Start the Parade', 'Kornalar çalarak ve el sallayarak arabalı doğum günü geçidini başlatın.', 'Start the birthday car parade by honking horns and waving.', true, 0, 0);

-- 61. Enchanted Forest Party
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '9ad33e65-fff0-43a0-ba3d-4c346d1be428', 1, 'Mekan Seçimi', 'Choose Venue', 'Ormanlık bir alan veya bahçeyi büyülü orman partisi için ayırtın.', 'Reserve a wooded area or garden for the enchanted forest party.', false, 14, 1000),
(gen_random_uuid(), '9ad33e65-fff0-43a0-ba3d-4c346d1be428', 2, 'Büyülü Orman Dekorasyonu', 'Enchanted Forest Decoration', 'Peri ışıkları, yapay yosun, mantar figürleri ve ağaç süsleri hazırlayın.', 'Prepare fairy lights, artificial moss, mushroom figures, and tree decorations.', false, 7, 1200),
(gen_random_uuid(), '9ad33e65-fff0-43a0-ba3d-4c346d1be428', 3, 'Kostüm ve Temalar', 'Costumes and Themes', 'Misafirlerden orman temalı kostümler giymelerini isteyin.', 'Ask guests to wear forest-themed costumes.', false, 10, 0),
(gen_random_uuid(), '9ad33e65-fff0-43a0-ba3d-4c346d1be428', 4, 'Büyülü Yiyecekler Hazırlama', 'Prepare Enchanted Food', 'Mantar şekilli kurabiyeler, yeşil smoothie ve orman meyveli tatlılar hazırlayın.', 'Prepare mushroom-shaped cookies, green smoothie, and forest fruit desserts.', true, 2, 800),
(gen_random_uuid(), '9ad33e65-fff0-43a0-ba3d-4c346d1be428', 5, 'Büyülü Geceyi Başlatma', 'Start Enchanted Night', 'Işıkları yakın, müziği açın ve büyülü orman partisini başlatın.', 'Light up the lights, turn on music, and start the enchanted forest party.', true, 0, 0);

-- 62. Escape Room Birthday Surprise
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '733ba7b3-0804-47f4-a570-998682aa42bd', 1, 'Escape Room Araştırma', 'Research Escape Rooms', 'Yakındaki en iyi escape room''ları araştırın ve temalarını inceleyin.', 'Research the best nearby escape rooms and examine their themes.', false, 14, 0),
(gen_random_uuid(), '733ba7b3-0804-47f4-a570-998682aa42bd', 2, 'Rezervasyon Yapma', 'Make Reservation', 'Grup büyüklüğüne uygun bir escape room odası rezerve edin.', 'Reserve an escape room suitable for the group size.', false, 10, 1200),
(gen_random_uuid(), '733ba7b3-0804-47f4-a570-998682aa42bd', 3, 'Misafirleri Organize Etme', 'Organize Guests', 'Katılacak arkadaşları bilgilendirin ve buluşma noktası belirleyin.', 'Inform participating friends and set a meeting point.', false, 7, 0),
(gen_random_uuid(), '733ba7b3-0804-47f4-a570-998682aa42bd', 4, 'Sürpriz Planı', 'Plan the Surprise', 'Kişiyi escape room''a nasıl götüreceğinizi planlayın.', 'Plan how to take the person to the escape room.', true, 2, 0),
(gen_random_uuid(), '733ba7b3-0804-47f4-a570-998682aa42bd', 5, 'Maceraya Başlama', 'Start the Adventure', 'Sürprizi açıklayın ve hep birlikte kaçış odasına girin.', 'Reveal the surprise and enter the escape room together.', true, 0, 0);

-- 63. Flash Mob Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'c68389f1-7d44-4fa2-84b0-c227bd1d469a', 1, 'Flash Mob Ekibini Toplama', 'Assemble Flash Mob Team', 'Flash mob''a katılacak arkadaşları ve gönüllüleri belirleyin.', 'Identify friends and volunteers who will participate in the flash mob.', false, 21, 0),
(gen_random_uuid(), 'c68389f1-7d44-4fa2-84b0-c227bd1d469a', 2, 'Dans Koreografisi Oluşturma', 'Create Dance Choreography', 'Basit ve eğlenceli bir koreografi oluşturun ve prova planlayın.', 'Create a simple and fun choreography and plan rehearsals.', false, 14, 500),
(gen_random_uuid(), 'c68389f1-7d44-4fa2-84b0-c227bd1d469a', 3, 'Provalar Yapma', 'Conduct Rehearsals', 'En az 2-3 prova yaparak koreografiyi mükemmelleştirin.', 'Perfect the choreography with at least 2-3 rehearsals.', false, 7, 0),
(gen_random_uuid(), 'c68389f1-7d44-4fa2-84b0-c227bd1d469a', 4, 'Mekan ve Müzik Ayarlama', 'Set Up Location and Music', 'Flash mob''ın yapılacağı mekanı ve müzik sistemini ayarlayın.', 'Set up the venue and sound system where the flash mob will take place.', true, 1, 200),
(gen_random_uuid(), 'c68389f1-7d44-4fa2-84b0-c227bd1d469a', 5, 'Flash Mob''ı Gerçekleştirme', 'Execute the Flash Mob', 'Müziği başlatın ve sürpriz flash mob performansını gerçekleştirin.', 'Start the music and perform the surprise flash mob.', true, 0, 0);

-- 64. Food Truck Birthday Party
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '42b16441-4649-4844-b828-bad1ba81a84c', 1, 'Yemek Tırı Araştırma ve Kiralama', 'Research and Rent Food Truck', 'Bölgedeki yemek tırlarını araştırın ve doğum günü için birini kiralayın.', 'Research food trucks in the area and rent one for the birthday.', false, 14, 3000),
(gen_random_uuid(), '42b16441-4649-4844-b828-bad1ba81a84c', 2, 'Menü Belirleme', 'Set the Menu', 'Doğum günü kişisinin favori yemeklerini içeren bir menü oluşturun.', 'Create a menu featuring the birthday person''s favorite foods.', false, 7, 0),
(gen_random_uuid(), '42b16441-4649-4844-b828-bad1ba81a84c', 3, 'Mekan Hazırlığı', 'Prepare Venue', 'Yemek tırının park edeceği alanı ve oturma düzenini hazırlayın.', 'Prepare the area where the food truck will park and the seating arrangement.', false, 2, 500),
(gen_random_uuid(), '42b16441-4649-4844-b828-bad1ba81a84c', 4, 'Dekorasyon ve Müzik', 'Decoration and Music', 'Alanı doğum günü süsleriyle dekore edin ve müzik ayarlayın.', 'Decorate the area with birthday decorations and set up music.', true, 1, 300),
(gen_random_uuid(), '42b16441-4649-4844-b828-bad1ba81a84c', 5, 'Partiyi Başlatma', 'Start the Party', 'Misafirleri karşılayın ve yemek tırı doğum günü partisini başlatın.', 'Welcome guests and start the food truck birthday party.', true, 0, 0);

-- 65. Fortnite Birthday Island
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '5913d8ce-1377-435b-a75c-723074659b48', 1, 'Fortnite Temalı Dekorasyon Planlama', 'Plan Fortnite Themed Decoration', 'Fortnite karakterleri, sandık ve harita görselleriyle dekorasyon planlayın.', 'Plan decoration with Fortnite characters, chest, and map visuals.', false, 10, 0),
(gen_random_uuid(), '5913d8ce-1377-435b-a75c-723074659b48', 2, 'Oyun İstasyonları Kurma', 'Set Up Game Stations', 'Birden fazla oyun konsolu ve ekran hazırlayarak turnuva alanı kurun.', 'Set up a tournament area with multiple game consoles and screens.', false, 5, 1000),
(gen_random_uuid(), '5913d8ce-1377-435b-a75c-723074659b48', 3, 'Fortnite Yiyecekleri', 'Fortnite Food', 'Chug Jug içecekler, Victory Royale pastası ve sandık şekilli kurabiyeler hazırlayın.', 'Prepare Chug Jug drinks, Victory Royale cake, and chest-shaped cookies.', false, 2, 800),
(gen_random_uuid(), '5913d8ce-1377-435b-a75c-723074659b48', 4, 'Ödüller Hazırlama', 'Prepare Prizes', 'Turnuva kazananları için Fortnite temalı ödüller hazırlayın.', 'Prepare Fortnite-themed prizes for tournament winners.', true, 1, 500),
(gen_random_uuid(), '5913d8ce-1377-435b-a75c-723074659b48', 5, 'Turnuvayı Başlatma', 'Start the Tournament', 'Tüm oyuncuları toplayın ve Fortnite doğum günü turnuvasını başlatın.', 'Gather all players and start the Fortnite birthday tournament.', true, 0, 0);

-- 66. Gaming Night Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '57ddf307-c857-466d-9ac9-967512731e90', 1, 'Oyun Seçimi ve Hazırlık', 'Game Selection and Preparation', 'Oynanacak oyunları belirleyin ve gerekli konsolları, bilgisayarları hazırlayın.', 'Choose the games to play and prepare the necessary consoles and computers.', false, 7, 0),
(gen_random_uuid(), '57ddf307-c857-466d-9ac9-967512731e90', 2, 'Oyun Alanı Düzenleme', 'Set Up Gaming Area', 'Ekranları, koltukları ve ışıklandırmayı oyun gecesine uygun şekilde düzenleyin.', 'Arrange screens, seating, and lighting suitable for a gaming night.', false, 2, 500),
(gen_random_uuid(), '57ddf307-c857-466d-9ac9-967512731e90', 3, 'Atıştırmalık ve İçecek Hazırlama', 'Prepare Snacks and Drinks', 'Pizza, cips, popcorn ve enerji içecekleri hazırlayın.', 'Prepare pizza, chips, popcorn, and energy drinks.', false, 1, 500),
(gen_random_uuid(), '57ddf307-c857-466d-9ac9-967512731e90', 4, 'Turnuva Formatı Belirleme', 'Set Tournament Format', 'Oyun gecesi için bir turnuva veya yarışma formatı oluşturun.', 'Create a tournament or competition format for the gaming night.', true, 1, 0),
(gen_random_uuid(), '57ddf307-c857-466d-9ac9-967512731e90', 5, 'Oyun Gecesini Başlatma', 'Start Gaming Night', 'Misafirleri karşılayın ve epik oyun gecesini başlatın.', 'Welcome guests and start the epic gaming night.', true, 0, 0);

-- 67. German Kinderfeste Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '6a74cee0-9a22-4a02-806d-18950dc2d821', 1, 'Alman Geleneğini Araştırma', 'Research German Traditions', 'Kinderfeste geleneklerini araştırın: Schultüte, pasta ve oyunlar hakkında bilgi toplayın.', 'Research Kinderfeste traditions: gather info about Schultüte, cake, and games.', false, 14, 0),
(gen_random_uuid(), '6a74cee0-9a22-4a02-806d-18950dc2d821', 2, 'Alman Temalı Dekorasyon', 'German Themed Decorations', 'Alman bayrak renkleri, geleneksel desenler ve Schultüte ile mekanı süsleyin.', 'Decorate the venue with German flag colors, traditional patterns, and Schultüte.', false, 5, 500),
(gen_random_uuid(), '6a74cee0-9a22-4a02-806d-18950dc2d821', 3, 'Alman Yemekleri Hazırlama', 'Prepare German Food', 'Pretzel, Apfelstrudel ve Alman pastası gibi geleneksel yiyecekler hazırlayın.', 'Prepare traditional foods like pretzel, Apfelstrudel, and German cake.', false, 2, 800),
(gen_random_uuid(), '6a74cee0-9a22-4a02-806d-18950dc2d821', 4, 'Geleneksel Oyunlar Planlama', 'Plan Traditional Games', 'Topfschlagen ve Sackhüpfen gibi geleneksel Alman çocuk oyunlarını planlayın.', 'Plan traditional German children''s games like Topfschlagen and Sackhüpfen.', true, 3, 100),
(gen_random_uuid(), '6a74cee0-9a22-4a02-806d-18950dc2d821', 5, 'Partiyi Başlatma', 'Start the Party', 'Alman geleneğine uygun kutlamayı başlatın ve eğlenceye dalın.', 'Start the celebration according to German tradition and dive into fun.', true, 0, 0);

-- 68. Karaoke Night Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '81241f23-6f9a-4415-9188-13cc3f24b7c9', 1, 'Karaoke Mekanı veya Ekipman Ayarlama', 'Set Up Karaoke Venue or Equipment', 'Karaoke salonu kiralayın veya ev için karaoke mikrofon ve hoparlör temin edin.', 'Rent a karaoke room or get karaoke microphone and speakers for home.', false, 7, 800),
(gen_random_uuid(), '81241f23-6f9a-4415-9188-13cc3f24b7c9', 2, 'Şarkı Listesi Hazırlama', 'Prepare Song List', 'Doğum günü kişisinin sevdiği şarkılardan oluşan bir liste oluşturun.', 'Create a playlist of the birthday person''s favorite songs.', false, 3, 0),
(gen_random_uuid(), '81241f23-6f9a-4415-9188-13cc3f24b7c9', 3, 'Dekorasyon ve Işık', 'Decoration and Lighting', 'Sahne ışıkları, disco topu ve neon süslerle ortamı hazırlayın.', 'Set up the atmosphere with stage lights, disco ball, and neon decorations.', false, 1, 400),
(gen_random_uuid(), '81241f23-6f9a-4415-9188-13cc3f24b7c9', 4, 'Yiyecek ve İçecek', 'Food and Drinks', 'Parti atıştırmalıkları ve içecekleri hazırlayın.', 'Prepare party snacks and drinks.', true, 1, 500),
(gen_random_uuid(), '81241f23-6f9a-4415-9188-13cc3f24b7c9', 5, 'Karaoke Gecesini Başlatma', 'Start Karaoke Night', 'Mikrofonu açın ve doğum günü şarkısıyla geceyi başlatın.', 'Turn on the microphone and start the night with the birthday song.', true, 0, 0);

-- 69. Korean Doljanchi Birthday Party
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '2b42c495-5497-4575-a3c7-44ebd3b5c633', 1, 'Doljanchi Geleneğini Araştırma', 'Research Doljanchi Tradition', 'Kore Doljanchi geleneğini araştırın: doljabi ritüeli ve geleneksel öğeler hakkında bilgi edinin.', 'Research Korean Doljanchi tradition: learn about doljabi ritual and traditional elements.', false, 14, 0),
(gen_random_uuid(), '2b42c495-5497-4575-a3c7-44ebd3b5c633', 2, 'Geleneksel Dekorasyon', 'Traditional Decoration', 'Kore tarzı dekorasyonlar, renkli çizgili kumaşlar ve geleneksel süsler hazırlayın.', 'Prepare Korean-style decorations, colorful striped fabrics, and traditional ornaments.', false, 7, 800),
(gen_random_uuid(), '2b42c495-5497-4575-a3c7-44ebd3b5c633', 3, 'Doljabi Objeleri Hazırlama', 'Prepare Doljabi Objects', 'İplik, kalem, para ve kitap gibi doljabi nesnelerini masaya yerleştirin.', 'Place doljabi objects like thread, pen, money, and book on the table.', false, 2, 200),
(gen_random_uuid(), '2b42c495-5497-4575-a3c7-44ebd3b5c633', 4, 'Kore Yemekleri Hazırlama', 'Prepare Korean Food', 'Tteok (pirinç keki), japchae ve songpyeon gibi Kore yemeklerini hazırlayın.', 'Prepare Korean dishes like tteok (rice cake), japchae, and songpyeon.', true, 1, 1000),
(gen_random_uuid(), '2b42c495-5497-4575-a3c7-44ebd3b5c633', 5, 'Doljabi Ritüelini Gerçekleştirme', 'Perform Doljabi Ritual', 'Bebeğin hangi nesneyi seçeceğini izleyin ve kutlamayı yapın.', 'Watch which object the baby chooses and celebrate.', true, 0, 0);

-- 70. Laser Tag Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'd249485a-9147-47c7-beaf-88d14dac558c', 1, 'Lazer Tag Mekanı Rezervasyonu', 'Reserve Laser Tag Venue', 'Grup için uygun bir lazer tag mekanı bulun ve rezervasyon yapın.', 'Find a suitable laser tag venue for the group and make a reservation.', false, 14, 2000),
(gen_random_uuid(), 'd249485a-9147-47c7-beaf-88d14dac558c', 2, 'Misafirleri Davet Etme', 'Invite Guests', 'Lazer tag temalı davetiyelerle misafirleri bilgilendirin.', 'Inform guests with laser tag themed invitations.', false, 10, 100),
(gen_random_uuid(), 'd249485a-9147-47c7-beaf-88d14dac558c', 3, 'Takım Düzeni ve Kurallar', 'Teams and Rules', 'Takımları belirleyin ve oyun kurallarını hazırlayın.', 'Determine teams and prepare game rules.', false, 2, 0),
(gen_random_uuid(), 'd249485a-9147-47c7-beaf-88d14dac558c', 4, 'Ödül ve Pasta Hazırlığı', 'Prize and Cake Preparation', 'Kazanan takım için ödüller ve doğum günü pastasını hazırlayın.', 'Prepare prizes for the winning team and the birthday cake.', true, 1, 500),
(gen_random_uuid(), 'd249485a-9147-47c7-beaf-88d14dac558c', 5, 'Oyun Başlatma', 'Start the Game', 'Takımları konumlandırın ve lazer tag mücadelesini başlatın.', 'Position teams and start the laser tag battle.', true, 0, 0);

-- 71. Mad Scientist Birthday Party
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '88c94e23-caee-4f1a-ad4a-1f0dfe29dd9c', 1, 'Deney Malzemeleri Temin Etme', 'Get Experiment Supplies', 'Karbonat, sirke, gıda boyası ve diğer güvenli deney malzemelerini satın alın.', 'Buy baking soda, vinegar, food coloring, and other safe experiment supplies.', false, 7, 400),
(gen_random_uuid(), '88c94e23-caee-4f1a-ad4a-1f0dfe29dd9c', 2, 'Deneyleri Planlama', 'Plan Experiments', 'Yaş grubuna uygun 3-4 eğlenceli bilim deneyi hazırlayın.', 'Prepare 3-4 fun science experiments suitable for the age group.', false, 5, 0),
(gen_random_uuid(), '88c94e23-caee-4f1a-ad4a-1f0dfe29dd9c', 3, 'Laboratuvar Ortamı Oluşturma', 'Create Lab Environment', 'Mekanı laboratuvar gibi düzenleyin: önlükler, koruyucu gözlükler ve test tüpleri hazırlayın.', 'Set up the venue like a lab: prepare lab coats, safety goggles, and test tubes.', false, 2, 600),
(gen_random_uuid(), '88c94e23-caee-4f1a-ad4a-1f0dfe29dd9c', 4, 'Bilim Temalı Yiyecekler', 'Science Themed Food', 'Deney şişesi şekilli içecekler ve beyin şekilli jöle hazırlayın.', 'Prepare drinks in lab bottle shapes and brain-shaped jelly.', true, 1, 300),
(gen_random_uuid(), '88c94e23-caee-4f1a-ad4a-1f0dfe29dd9c', 5, 'Deneylere Başlama', 'Start Experiments', 'Küçük bilim insanlarını toplayın ve deneyleri sırayla gerçekleştirin.', 'Gather the little scientists and conduct experiments one by one.', true, 0, 0);

-- 72. Memory Lane Road Trip Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '56c8c3cb-045b-4e4d-aaae-db6574b9e7fa', 1, 'Anlamlı Mekanları Belirleme', 'Identify Meaningful Places', 'Kişinin hayatında önemli olan yerleri listeleyin: doğduğu ev, okul, ilk buluşma yeri.', 'List places important in the person''s life: birthplace, school, first date location.', false, 14, 0),
(gen_random_uuid(), '56c8c3cb-045b-4e4d-aaae-db6574b9e7fa', 2, 'Rota Planlama', 'Plan Route', 'Anlamlı mekanları sırasıyla ziyaret edecek bir araç rotası planlayın.', 'Plan a driving route to visit meaningful places in order.', false, 7, 0),
(gen_random_uuid(), '56c8c3cb-045b-4e4d-aaae-db6574b9e7fa', 3, 'Her Durak İçin Sürpriz Hazırlama', 'Prepare Surprises for Each Stop', 'Her mekan için ilgili bir anı fotoğrafı, not veya küçük hediye hazırlayın.', 'Prepare a related memory photo, note, or small gift for each place.', false, 3, 500),
(gen_random_uuid(), '56c8c3cb-045b-4e4d-aaae-db6574b9e7fa', 4, 'Yol Müziği Hazırlama', 'Prepare Road Music', 'Kişinin hayatının farklı dönemlerinden şarkılarla bir çalma listesi oluşturun.', 'Create a playlist with songs from different periods of the person''s life.', true, 1, 0),
(gen_random_uuid(), '56c8c3cb-045b-4e4d-aaae-db6574b9e7fa', 5, 'Anı Yolculuğuna Çıkma', 'Start Memory Lane Trip', 'Kişiyi sürpriz bir yolculuğa çıkarın ve her durakta anıları paylaşın.', 'Take the person on a surprise trip and share memories at each stop.', true, 0, 0);

-- 73. Mexican Fiesta Birthday Party
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '109b5401-851c-4b75-bad6-d3f8851ca8bf', 1, 'Fiesta Dekorasyon Malzemeleri', 'Fiesta Decoration Supplies', 'Renkli papel picado, sombrero, kaktüs süsleri ve piñata satın alın.', 'Buy colorful papel picado, sombreros, cactus decorations, and a piñata.', false, 10, 600),
(gen_random_uuid(), '109b5401-851c-4b75-bad6-d3f8851ca8bf', 2, 'Meksika Yemekleri Hazırlama', 'Prepare Mexican Food', 'Taco, nachos, guacamole ve salsa gibi Meksika yemeklerini hazırlayın.', 'Prepare Mexican food like tacos, nachos, guacamole, and salsa.', false, 2, 800),
(gen_random_uuid(), '109b5401-851c-4b75-bad6-d3f8851ca8bf', 3, 'Mekanı Dekore Etme', 'Decorate Venue', 'Mekanı canlı renklerle, ışıklarla ve Meksika temalı süslerle doldurun.', 'Fill the venue with vibrant colors, lights, and Mexican-themed decorations.', false, 1, 0),
(gen_random_uuid(), '109b5401-851c-4b75-bad6-d3f8851ca8bf', 4, 'Müzik ve Dans', 'Music and Dance', 'Mariachi müziği veya Latin müziği çalma listesi hazırlayın.', 'Prepare a mariachi music or Latin music playlist.', true, 1, 0),
(gen_random_uuid(), '109b5401-851c-4b75-bad6-d3f8851ca8bf', 5, 'Fiesta Başlatma', 'Start the Fiesta', 'Müziği açın, yemekleri sunun ve Meksika partisini başlatın.', 'Turn on the music, serve the food, and start the Mexican party.', true, 0, 0);

-- 74. Midnight Balloon Room Surprise
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '5015054d-7c19-4e1e-8d5a-197233a9641d', 1, 'Balon ve Süs Malzemeleri Alma', 'Buy Balloons and Decorations', 'Yüzlerce renkli balon, flamalar ve "Doğum günün kutlu olsun" yazısı alın.', 'Buy hundreds of colorful balloons, banners, and "Happy Birthday" sign.', false, 3, 400),
(gen_random_uuid(), '5015054d-7c19-4e1e-8d5a-197233a9641d', 2, 'Hediye ve Pasta Hazırlama', 'Prepare Gift and Cake', 'Doğum günü hediyesini ve pastayı hazırlayın.', 'Prepare the birthday gift and cake.', false, 1, 800),
(gen_random_uuid(), '5015054d-7c19-4e1e-8d5a-197233a9641d', 3, 'Gece Yarısı Odayı Süsleme', 'Decorate Room at Midnight', 'Kişi uyurken odayı sessizce balonlarla doldurun ve süsleyin.', 'Quietly fill the room with balloons and decorate while the person sleeps.', false, 0, 0),
(gen_random_uuid(), '5015054d-7c19-4e1e-8d5a-197233a9641d', 4, 'Mum ve Konfeti Hazırlama', 'Prepare Candles and Confetti', 'Pastanın üzerine mumları yerleştirin ve konfeti hazırlayın.', 'Place candles on the cake and prepare confetti.', true, 0, 50),
(gen_random_uuid(), '5015054d-7c19-4e1e-8d5a-197233a9641d', 5, 'Sürpriz Anı', 'Surprise Moment', 'Gece yarısı veya sabah kişiyi uyandırın ve "Doğum günün kutlu olsun!" diye bağırın.', 'Wake the person at midnight or morning and shout "Happy Birthday!"', true, 0, 0);

-- 75. Museum Tour Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '7443f6c6-b29e-425a-a7e5-26484889bce7', 1, 'Müze Seçimi', 'Choose Museum', 'Kişinin ilgi alanına uygun bir müze seçin ve bilet alın.', 'Choose a museum matching the person''s interests and buy tickets.', false, 10, 500),
(gen_random_uuid(), '7443f6c6-b29e-425a-a7e5-26484889bce7', 2, 'Rehberli Tur Ayarlama', 'Arrange Guided Tour', 'Varsa özel rehberli tur için rezervasyon yapın.', 'Book a private guided tour if available.', false, 7, 300),
(gen_random_uuid(), '7443f6c6-b29e-425a-a7e5-26484889bce7', 3, 'Tur Sonrası Yemek Planı', 'Plan Post-Tour Dinner', 'Müze turunu ardından şık bir restoranda yemek için rezervasyon yapın.', 'Make a restaurant reservation for a nice dinner after the museum tour.', false, 5, 1000),
(gen_random_uuid(), '7443f6c6-b29e-425a-a7e5-26484889bce7', 4, 'Müze Hediye Mağazası', 'Museum Gift Shop', 'Müze hediyelik eşya mağazasından özel bir hediye almayı planlayın.', 'Plan to buy a special gift from the museum gift shop.', true, 0, 200),
(gen_random_uuid(), '7443f6c6-b29e-425a-a7e5-26484889bce7', 5, 'Turu Başlatma', 'Start the Tour', 'Kişiyi müzeye götürün ve sürpriz doğum günü turunu başlatın.', 'Take the person to the museum and start the surprise birthday tour.', true, 0, 0);

-- 76. Mystery Dinner Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '581dea7b-7302-4621-8b1c-71377e6649d0', 1, 'Gizem Senaryosu Seçimi', 'Choose Mystery Scenario', 'Cinayet gizemi veya dedektif temalı bir akşam yemeği senaryosu hazırlayın veya satın alın.', 'Prepare or buy a murder mystery or detective-themed dinner scenario.', false, 14, 300),
(gen_random_uuid(), '581dea7b-7302-4621-8b1c-71377e6649d0', 2, 'Rol Dağılımı ve Davetiye', 'Role Assignment and Invitations', 'Her misafir için karakter rolü belirleyin ve gizemli davetiyeler gönderin.', 'Assign character roles for each guest and send mysterious invitations.', false, 10, 150),
(gen_random_uuid(), '581dea7b-7302-4621-8b1c-71377e6649d0', 3, 'Yemek ve Mekan Hazırlığı', 'Prepare Dinner and Venue', 'Gizemli bir atmosfer oluşturun: loş ışıklar, mumlar ve özel bir menü hazırlayın.', 'Create a mysterious atmosphere: prepare dim lights, candles, and a special menu.', false, 2, 1000),
(gen_random_uuid(), '581dea7b-7302-4621-8b1c-71377e6649d0', 4, 'Kostüm ve Aksesuar Hazırlığı', 'Prepare Costumes and Accessories', 'Karakterlere uygun kostümler ve ipucu kartları hazırlayın.', 'Prepare costumes and clue cards suitable for the characters.', true, 3, 400),
(gen_random_uuid(), '581dea7b-7302-4621-8b1c-71377e6649d0', 5, 'Gizemli Yemeği Başlatma', 'Start Mystery Dinner', 'Misafirleri karşılayın, rolleri tanıtın ve gizemi başlatın.', 'Welcome guests, introduce roles, and start the mystery.', true, 0, 0);

-- 77. Neon Glow Dance Party
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'f76753a9-ad69-41cf-b2ce-d55456b0a562', 1, 'Neon Malzeme Alışverişi', 'Buy Neon Supplies', 'UV ışıklar, neon boyalar, parlayan bileklikler ve neon balonlar satın alın.', 'Buy UV lights, neon paints, glow sticks, and neon balloons.', false, 7, 600),
(gen_random_uuid(), 'f76753a9-ad69-41cf-b2ce-d55456b0a562', 2, 'Dans Alanı Hazırlama', 'Prepare Dance Floor', 'Mekanı karartın, UV ışıkları yerleştirin ve dans alanını oluşturun.', 'Darken the venue, place UV lights, and create the dance floor.', false, 1, 300),
(gen_random_uuid(), 'f76753a9-ad69-41cf-b2ce-d55456b0a562', 3, 'Müzik Listesi Hazırlama', 'Prepare Music Playlist', 'Dans partisi için enerjik bir müzik çalma listesi oluşturun.', 'Create an energetic music playlist for the dance party.', false, 3, 0),
(gen_random_uuid(), 'f76753a9-ad69-41cf-b2ce-d55456b0a562', 4, 'Neon Yüz Boyama', 'Neon Face Painting', 'Misafirler için neon yüz ve vücut boyaması köşesi hazırlayın.', 'Set up a neon face and body painting station for guests.', true, 0, 200),
(gen_random_uuid(), 'f76753a9-ad69-41cf-b2ce-d55456b0a562', 5, 'Partiyi Başlatma', 'Start the Party', 'Işıkları kapatın, UV ışıkları açın, müziği başlatın ve dans partisini açın.', 'Turn off lights, switch on UV lights, start music, and open the dance party.', true, 0, 0);

-- 78. Outdoor BBQ Birthday Party
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a0000001-0001-0001-0001-000000000004', 1, 'Mekan ve Mangal Hazırlığı', 'Venue and BBQ Preparation', 'Bahçe veya parkta mangal alanını belirleyin ve mangal temin edin.', 'Choose a BBQ area in the garden or park and get the grill ready.', false, 7, 500),
(gen_random_uuid(), 'a0000001-0001-0001-0001-000000000004', 2, 'Et ve Malzeme Alışverişi', 'Shop for Meat and Supplies', 'Et, sebze, soslar ve barbekü malzemelerini satın alın.', 'Buy meat, vegetables, sauces, and barbecue supplies.', false, 1, 1000),
(gen_random_uuid(), 'a0000001-0001-0001-0001-000000000004', 3, 'Açık Hava Dekorasyonu', 'Outdoor Decoration', 'Alanı doğum günü balonları, flamalar ve ışıklarla süsleyin.', 'Decorate the area with birthday balloons, banners, and lights.', false, 1, 300),
(gen_random_uuid(), 'a0000001-0001-0001-0001-000000000004', 4, 'Müzik ve Oyun Hazırlığı', 'Music and Games Setup', 'Açık hava hoparlörü kurun ve misafirler için oyunlar planlayın.', 'Set up outdoor speakers and plan games for guests.', true, 1, 0),
(gen_random_uuid(), 'a0000001-0001-0001-0001-000000000004', 5, 'Mangalı Yakma ve Partiyi Başlatma', 'Light the Grill and Start Party', 'Mangalı yakın, misafirleri karşılayın ve açık hava partisini başlatın.', 'Light the grill, welcome guests, and start the outdoor party.', true, 0, 0);

-- 79. Photo Booth Party
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '64742d6a-e1ec-43c6-b96c-df35c9a898eb', 1, 'Fotoğraf Köşesi Malzemeleri', 'Photo Booth Supplies', 'Arka plan kumaşı, çerçeveler, şapkalar, gözlükler ve eğlenceli aksesuarlar alın.', 'Get backdrop fabric, frames, hats, glasses, and fun accessories.', false, 7, 500),
(gen_random_uuid(), '64742d6a-e1ec-43c6-b96c-df35c9a898eb', 2, 'Fotoğraf Köşesi Kurulumu', 'Set Up Photo Booth', 'Arka planı asın, ışıklandırmayı ayarlayın ve aksesuarları düzenleyin.', 'Hang the backdrop, adjust lighting, and arrange accessories.', false, 0, 0),
(gen_random_uuid(), '64742d6a-e1ec-43c6-b96c-df35c9a898eb', 3, 'Kamera ve Yazıcı Hazırlığı', 'Camera and Printer Setup', 'Kaliteli bir kamera veya telefon tripodu ve anlık baskı yazıcısı kurun.', 'Set up a quality camera or phone tripod and instant print printer.', false, 0, 300),
(gen_random_uuid(), '64742d6a-e1ec-43c6-b96c-df35c9a898eb', 4, 'Parti Dekorasyonu', 'Party Decoration', 'Mekanın geri kalanını doğum günü süsleriyle dekore edin.', 'Decorate the rest of the venue with birthday decorations.', true, 1, 300),
(gen_random_uuid(), '64742d6a-e1ec-43c6-b96c-df35c9a898eb', 5, 'Partiyi Başlatma', 'Start the Party', 'Misafirleri karşılayın ve fotoğraf çekimine davet edin.', 'Welcome guests and invite them to take photos.', true, 0, 0);

-- 80. Surprise Picnic Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'f3465222-8c65-44e2-8a59-28cde401b995', 1, 'Piknik Yeri Seçimi', 'Choose Picnic Spot', 'Güzel manzaralı, sakin bir piknik yeri belirleyin.', 'Choose a picnic spot with a beautiful view and peaceful atmosphere.', false, 7, 0),
(gen_random_uuid(), 'f3465222-8c65-44e2-8a59-28cde401b995', 2, 'Piknik Sepeti Hazırlama', 'Prepare Picnic Basket', 'Kişinin favori yiyecekleri, içecekleri ve doğum günü pastasını hazırlayın.', 'Prepare the person''s favorite food, drinks, and birthday cake.', false, 1, 500),
(gen_random_uuid(), 'f3465222-8c65-44e2-8a59-28cde401b995', 3, 'Piknik Alanını Süsleme', 'Decorate Picnic Area', 'Battaniyeler, yastıklar, balonlar ve çiçeklerle piknik alanını hazırlayın.', 'Set up the picnic area with blankets, pillows, balloons, and flowers.', false, 0, 300),
(gen_random_uuid(), 'f3465222-8c65-44e2-8a59-28cde401b995', 4, 'Müzik ve Atmosfer', 'Music and Atmosphere', 'Portatif hoparlörle rahatlatıcı müzik hazırlayın.', 'Prepare relaxing music with a portable speaker.', true, 0, 0),
(gen_random_uuid(), 'f3465222-8c65-44e2-8a59-28cde401b995', 5, 'Sürpriz Pikniğe Götürme', 'Take to Surprise Picnic', 'Kişiyi piknik alanına götürün ve sürprizi açıklayın.', 'Take the person to the picnic area and reveal the surprise.', true, 0, 0);

-- 81. Retro 90s Party
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '6c4d3c9e-24f7-48ef-a0c3-93214be50375', 1, '90''lar Temalı Dekorasyon', '90s Themed Decoration', 'Kasetler, diskler, neon renkler ve retro posterlerle mekanı süsleyin.', 'Decorate the venue with cassettes, discs, neon colors, and retro posters.', false, 7, 500),
(gen_random_uuid(), '6c4d3c9e-24f7-48ef-a0c3-93214be50375', 2, '90''lar Müzik Listesi', '90s Music Playlist', '90''ların en popüler şarkılarından bir çalma listesi oluşturun.', 'Create a playlist of the most popular songs from the 90s.', false, 3, 0),
(gen_random_uuid(), '6c4d3c9e-24f7-48ef-a0c3-93214be50375', 3, 'Kostüm Hazırlığı', 'Costume Preparation', 'Misafirlerden 90''lar temalı kostümler giymelerini isteyin.', 'Ask guests to wear 90s themed costumes.', false, 10, 0),
(gen_random_uuid(), '6c4d3c9e-24f7-48ef-a0c3-93214be50375', 4, 'Retro Yiyecekler', 'Retro Food', '90''ların popüler atıştırmalıklarını ve içeceklerini hazırlayın.', 'Prepare popular snacks and drinks from the 90s.', true, 1, 400),
(gen_random_uuid(), '6c4d3c9e-24f7-48ef-a0c3-93214be50375', 5, 'Retro Partiyi Başlatma', 'Start Retro Party', '90''lar müziğini açın ve zamanda yolculuğa başlayın.', 'Turn on the 90s music and start the time travel.', true, 0, 0);

-- 82. Rooftop Cinema Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'b84502e3-71fb-4477-9604-054f347ab189', 1, 'Çatı Mekanı ve Ekipman', 'Rooftop Venue and Equipment', 'Uygun bir çatı katı bulun ve projektör ile perde temin edin.', 'Find a suitable rooftop and get a projector and screen.', false, 10, 1000),
(gen_random_uuid(), 'b84502e3-71fb-4477-9604-054f347ab189', 2, 'Film Seçimi', 'Choose Film', 'Doğum günü kişisinin en sevdiği filmi veya özel bir filmi seçin.', 'Choose the birthday person''s favorite movie or a special film.', false, 5, 0),
(gen_random_uuid(), 'b84502e3-71fb-4477-9604-054f347ab189', 3, 'Oturma Düzeni', 'Seating Arrangement', 'Puflar, battaniyeler ve yastıklarla rahat bir oturma düzeni oluşturun.', 'Create a comfortable seating arrangement with bean bags, blankets, and pillows.', false, 1, 500),
(gen_random_uuid(), 'b84502e3-71fb-4477-9604-054f347ab189', 4, 'Sinema Atıştırmalıkları', 'Cinema Snacks', 'Popcorn, şekerlemeler ve soğuk içecekler hazırlayın.', 'Prepare popcorn, candy, and cold drinks.', true, 0, 300),
(gen_random_uuid(), 'b84502e3-71fb-4477-9604-054f347ab189', 5, 'Film Gösterimini Başlatma', 'Start Movie Screening', 'Işıkları kapatın, projektörü açın ve çatı sineması deneyimini başlatın.', 'Turn off lights, start the projector, and begin the rooftop cinema experience.', true, 0, 0);

-- 83. Sakura Cherry Blossom Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '9b580088-66e9-40f5-9b1e-789d65bd3d71', 1, 'Sakura Temalı Dekorasyon Planlama', 'Plan Sakura Themed Decoration', 'Pembe ve beyaz çiçekler, yapay sakura dalları ve Japon fenerlerini temin edin.', 'Get pink and white flowers, artificial sakura branches, and Japanese lanterns.', false, 10, 800),
(gen_random_uuid(), '9b580088-66e9-40f5-9b1e-789d65bd3d71', 2, 'Japon Temalı Yiyecekler', 'Japanese Themed Food', 'Mochi, matcha kek ve sakura çiçeği temalı tatlılar hazırlayın.', 'Prepare mochi, matcha cake, and sakura blossom themed desserts.', false, 3, 700),
(gen_random_uuid(), '9b580088-66e9-40f5-9b1e-789d65bd3d71', 3, 'Mekanı Süsleme', 'Decorate Venue', 'Sakura dalları, pembe tüller ve fenerlerle mekanı Japon bahçesine dönüştürün.', 'Transform the venue into a Japanese garden with sakura branches, pink tulle, and lanterns.', false, 1, 0),
(gen_random_uuid(), '9b580088-66e9-40f5-9b1e-789d65bd3d71', 4, 'Kimono veya Yukata Hazırlama', 'Prepare Kimono or Yukata', 'Doğum günü kişisi için özel bir yukata veya Japon temalı aksesuar hazırlayın.', 'Prepare a special yukata or Japanese-themed accessory for the birthday person.', true, 2, 300),
(gen_random_uuid(), '9b580088-66e9-40f5-9b1e-789d65bd3d71', 5, 'Kutlamayı Başlatma', 'Start Celebration', 'Misafirleri sakura ağaçları altında karşılayın ve kutlamayı başlatın.', 'Welcome guests under the sakura trees and start the celebration.', true, 0, 0);

-- 84. Silent Disco Birthday Party
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '4c3ed59b-3940-433e-adff-073f03d096cf', 1, 'Sessiz Disko Ekipmanı Kiralama', 'Rent Silent Disco Equipment', 'Kablosuz kulaklıklar ve vericiler kiralayın veya satın alın.', 'Rent or buy wireless headphones and transmitters.', false, 14, 2000),
(gen_random_uuid(), '4c3ed59b-3940-433e-adff-073f03d096cf', 2, 'Müzik Kanalları Hazırlama', 'Prepare Music Channels', 'Farklı müzik türlerinden 2-3 kanal için çalma listeleri oluşturun.', 'Create playlists for 2-3 channels of different music genres.', false, 5, 0),
(gen_random_uuid(), '4c3ed59b-3940-433e-adff-073f03d096cf', 3, 'Dans Alanı ve Dekorasyon', 'Dance Floor and Decoration', 'Dans alanını ışıklarla ve neon süslerle donatın.', 'Equip the dance floor with lights and neon decorations.', false, 1, 500),
(gen_random_uuid(), '4c3ed59b-3940-433e-adff-073f03d096cf', 4, 'Yiyecek ve İçecek', 'Food and Drinks', 'Parti atıştırmalıkları ve kokteyl bar hazırlayın.', 'Prepare party snacks and a cocktail bar.', true, 1, 600),
(gen_random_uuid(), '4c3ed59b-3940-433e-adff-073f03d096cf', 5, 'Sessiz Diskoyu Başlatma', 'Start Silent Disco', 'Kulaklıkları dağıtın ve sessiz dans partisini başlatın.', 'Distribute headphones and start the silent dance party.', true, 0, 0);

-- 85. Spa Day Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '4c003e70-4bca-49e9-8fd8-e208524dfb68', 1, 'Spa Merkezi Seçimi', 'Choose Spa Center', 'En iyi spa merkezlerini araştırın ve doğum günü paketi sunanları belirleyin.', 'Research the best spa centers and identify ones offering birthday packages.', false, 14, 0),
(gen_random_uuid(), '4c003e70-4bca-49e9-8fd8-e208524dfb68', 2, 'Spa Randevusu Alma', 'Book Spa Appointment', 'Masaj, yüz bakımı ve hamam paketi için randevu oluşturun.', 'Book appointments for massage, facial, and hammam package.', false, 7, 2500),
(gen_random_uuid(), '4c003e70-4bca-49e9-8fd8-e208524dfb68', 3, 'Hediye Sepeti Hazırlama', 'Prepare Gift Basket', 'Spa ürünleri, bornoz ve mum içeren bir hediye sepeti hazırlayın.', 'Prepare a gift basket with spa products, bathrobe, and candles.', false, 3, 500),
(gen_random_uuid(), '4c003e70-4bca-49e9-8fd8-e208524dfb68', 4, 'Sürprizi Açıklama', 'Reveal the Surprise', 'Doğum gününde spa gününü heyecanla açıklayın.', 'Excitedly reveal the spa day on the birthday.', true, 0, 0);

-- 86. Sticky Note Takeover Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '1a9e4b22-68c4-40fd-82a8-20d8f8e767b8', 1, 'Yapışkan Not Alışverişi', 'Buy Sticky Notes', 'Farklı renklerde yüzlerce yapışkan not satın alın.', 'Buy hundreds of sticky notes in different colors.', false, 5, 100),
(gen_random_uuid(), '1a9e4b22-68c4-40fd-82a8-20d8f8e767b8', 2, 'Mesajları Yazma', 'Write Messages', 'Her nota sevgi dolu bir mesaj, anı veya komik bir şey yazın.', 'Write a loving message, memory, or something funny on each note.', false, 3, 0),
(gen_random_uuid(), '1a9e4b22-68c4-40fd-82a8-20d8f8e767b8', 3, 'Notları Gizlice Yapıştırma', 'Secretly Post Notes', 'Kişi yokken odayı, masayı ve eşyaları yapışkan notlarla kaplama.', 'Cover the room, desk, and belongings with sticky notes while the person is away.', false, 0, 0),
(gen_random_uuid(), '1a9e4b22-68c4-40fd-82a8-20d8f8e767b8', 4, 'Fotoğraf Çekimi', 'Take Photos', 'Süslenmiş alanın fotoğraflarını çekin ve tepkiyi kaydedin.', 'Take photos of the decorated area and record the reaction.', true, 0, 0),
(gen_random_uuid(), '1a9e4b22-68c4-40fd-82a8-20d8f8e767b8', 5, 'Tepkiyi İzleme', 'Watch the Reaction', 'Kişinin yüzlerce notu keşfetmesini izleyin ve birlikte kutlayın.', 'Watch the person discover hundreds of notes and celebrate together.', true, 0, 0);

-- 87. Sunrise Hike Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'e3e39dc4-1fca-4633-a8aa-671164bec0d1', 1, 'Yürüyüş Parkuru Seçimi', 'Choose Hiking Trail', 'Gün doğumunu izlemek için güzel manzaralı bir yürüyüş parkuru belirleyin.', 'Choose a hiking trail with beautiful views for watching the sunrise.', false, 7, 0),
(gen_random_uuid(), 'e3e39dc4-1fca-4633-a8aa-671164bec0d1', 2, 'Gün Doğumu Saatini Kontrol Etme', 'Check Sunrise Time', 'Seçilen gün için gün doğumu saatini kontrol edin ve yola çıkış saatini planlayın.', 'Check the sunrise time for the chosen day and plan departure time.', false, 3, 0),
(gen_random_uuid(), 'e3e39dc4-1fca-4633-a8aa-671164bec0d1', 3, 'Piknik Kahvaltısı Hazırlama', 'Prepare Picnic Breakfast', 'Termos kahve, sandviçler ve taze meyve içeren bir kahvaltı çantası hazırlayın.', 'Prepare a breakfast bag with thermos coffee, sandwiches, and fresh fruit.', false, 1, 200),
(gen_random_uuid(), 'e3e39dc4-1fca-4633-a8aa-671164bec0d1', 4, 'Doğum Günü Sürprizi Hazırlama', 'Prepare Birthday Surprise', 'Zirveye varıldığında açılacak bir doğum günü hediyesi ve kartı hazırlayın.', 'Prepare a birthday gift and card to be opened when reaching the summit.', true, 1, 300),
(gen_random_uuid(), 'e3e39dc4-1fca-4633-a8aa-671164bec0d1', 5, 'Gün Doğumunu İzleme', 'Watch the Sunrise', 'Zirvede gün doğumunu izlerken doğum gününü kutlayın.', 'Celebrate the birthday while watching the sunrise at the summit.', true, 0, 0);

-- 88. Theme Park Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '25f823de-7794-4370-8144-d2f2dbf8c3bc', 1, 'Tema Parkı Biletleri Alma', 'Get Theme Park Tickets', 'En uygun tema parkını seçin ve biletleri önceden satın alın.', 'Choose the best theme park and buy tickets in advance.', false, 14, 1500),
(gen_random_uuid(), '25f823de-7794-4370-8144-d2f2dbf8c3bc', 2, 'Gün Planı Oluşturma', 'Create Day Plan', 'Parkta hangi gösterilere ve çekimlere katılacağınızı planlayın.', 'Plan which rides and shows to attend at the park.', false, 5, 0),
(gen_random_uuid(), '25f823de-7794-4370-8144-d2f2dbf8c3bc', 3, 'Doğum Günü Hediyesi Hazırlama', 'Prepare Birthday Gift', 'Parkta açılacak bir doğum günü hediyesi paketleyin.', 'Wrap a birthday gift to be opened at the park.', false, 2, 500),
(gen_random_uuid(), '25f823de-7794-4370-8144-d2f2dbf8c3bc', 4, 'Sürprizi Açıklama', 'Reveal the Surprise', 'Tema parkı sürprizini heyecan verici bir şekilde açıklayın.', 'Reveal the theme park surprise in an exciting way.', true, 0, 0);

-- 89. This Is Your Life Birthday Dinner
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '483367f1-2ef7-4e37-b6ef-abd741a91e8c', 1, 'Hayat Hikayesi Araştırma', 'Research Life Story', 'Kişinin hayatındaki önemli anları, kişileri ve dönüm noktalarını araştırın.', 'Research important moments, people, and milestones in the person''s life.', false, 21, 0),
(gen_random_uuid(), '483367f1-2ef7-4e37-b6ef-abd741a91e8c', 2, 'Özel Konukları Organize Etme', 'Organize Special Guests', 'Kişinin hayatından önemli kişileri gizlice davet edin.', 'Secretly invite important people from the person''s life.', false, 14, 0),
(gen_random_uuid(), '483367f1-2ef7-4e37-b6ef-abd741a91e8c', 3, 'Sunum Hazırlama', 'Prepare Presentation', 'Fotoğraflar, videolar ve anılarla bir "Bu Senin Hayatın" sunumu hazırlayın.', 'Prepare a "This Is Your Life" presentation with photos, videos, and memories.', false, 5, 200),
(gen_random_uuid(), '483367f1-2ef7-4e37-b6ef-abd741a91e8c', 4, 'Yemek Organizasyonu', 'Dinner Organization', 'Şık bir restoranda veya evde özel bir yemek düzenleyin.', 'Organize a special dinner at an elegant restaurant or at home.', true, 3, 1500),
(gen_random_uuid(), '483367f1-2ef7-4e37-b6ef-abd741a91e8c', 5, 'Sunumu Gerçekleştirme', 'Deliver Presentation', 'Yemek sırasında sunumu yapın ve özel konukları tanıtın.', 'Deliver the presentation during dinner and introduce special guests.', true, 0, 0);

-- 90. Trip Reveal Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'c66dc1bd-a22f-44ad-92ae-17ade257e891', 1, 'Seyahat Destinasyonu Seçimi', 'Choose Travel Destination', 'Kişinin hayalindeki seyahat destinasyonunu belirleyin.', 'Determine the person''s dream travel destination.', false, 30, 0),
(gen_random_uuid(), 'c66dc1bd-a22f-44ad-92ae-17ade257e891', 2, 'Bilet ve Otel Rezervasyonu', 'Book Tickets and Hotel', 'Uçak bileti ve otel rezervasyonu yapın.', 'Book flight tickets and hotel reservations.', false, 21, 5000),
(gen_random_uuid(), 'c66dc1bd-a22f-44ad-92ae-17ade257e891', 3, 'Yaratıcı Açıklama Hazırlama', 'Prepare Creative Reveal', 'Seyahati açıklamak için yapboz, kazı kazan kartı veya harita kullanarak yaratıcı bir yol hazırlayın.', 'Prepare a creative way to reveal the trip using puzzle, scratch card, or map.', false, 5, 100),
(gen_random_uuid(), 'c66dc1bd-a22f-44ad-92ae-17ade257e891', 4, 'Seyahat Hediye Paketi', 'Travel Gift Package', 'Pasaport kılıfı, boyun yastığı gibi seyahat aksesuarlarıyla hediye paketi hazırlayın.', 'Prepare a gift package with travel accessories like passport cover and neck pillow.', true, 2, 300),
(gen_random_uuid(), 'c66dc1bd-a22f-44ad-92ae-17ade257e891', 5, 'Seyahati Açıklama', 'Reveal the Trip', 'Doğum gününde seyahat sürprizini heyecanla açıklayın.', 'Excitedly reveal the travel surprise on the birthday.', true, 0, 0);

-- 91. Video Message Compilation Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '01e1eaec-ff02-430f-b3ae-11b79e7a3fbf', 1, 'Katılımcı Listesi Oluşturma', 'Create Participant List', 'Video mesaj kaydedecek aile üyeleri ve arkadaşların listesini çıkarın.', 'Create a list of family members and friends who will record video messages.', false, 21, 0),
(gen_random_uuid(), '01e1eaec-ff02-430f-b3ae-11b79e7a3fbf', 2, 'Video Mesajları Toplama', 'Collect Video Messages', 'Her kişiden kısa bir doğum günü mesajı videosu isteyin ve toplayın.', 'Request and collect a short birthday message video from each person.', false, 14, 0),
(gen_random_uuid(), '01e1eaec-ff02-430f-b3ae-11b79e7a3fbf', 3, 'Videoyu Düzenleme', 'Edit the Video', 'Tüm video mesajlarını birleştirin, müzik ve geçişler ekleyin.', 'Combine all video messages, add music and transitions.', false, 5, 0),
(gen_random_uuid(), '01e1eaec-ff02-430f-b3ae-11b79e7a3fbf', 4, 'Final Düzenlemeleri', 'Final Edits', 'Son düzenlemeleri yapın ve videoyu izlenmeye hazır hale getirin.', 'Make final edits and prepare the video for viewing.', true, 2, 0),
(gen_random_uuid(), '01e1eaec-ff02-430f-b3ae-11b79e7a3fbf', 5, 'Videoyu Gösterme', 'Show the Video', 'Doğum gününde videoyu büyük ekranda gösterin.', 'Show the video on a big screen on the birthday.', true, 0, 0);

-- 92. Video Montage Surprise
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a0000001-0001-0001-0001-000000000005', 1, 'Fotoğraf ve Video Toplama', 'Collect Photos and Videos', 'Kişinin hayatından önemli fotoğrafları ve video klipleri toplayın.', 'Collect important photos and video clips from the person''s life.', false, 14, 0),
(gen_random_uuid(), 'a0000001-0001-0001-0001-000000000005', 2, 'Montaj Yazılımı Hazırlama', 'Prepare Editing Software', 'Video düzenleme programını kurun ve kullanmayı öğrenin.', 'Install the video editing software and learn how to use it.', false, 10, 0),
(gen_random_uuid(), 'a0000001-0001-0001-0001-000000000005', 3, 'Video Montajı Oluşturma', 'Create Video Montage', 'Fotoğrafları ve videoları kronolojik sırayla düzenleyin, müzik ekleyin.', 'Arrange photos and videos in chronological order and add music.', false, 5, 0),
(gen_random_uuid(), 'a0000001-0001-0001-0001-000000000005', 4, 'Son Düzenleme ve Kontrol', 'Final Edit and Review', 'Montajı son kez izleyin, gerekli düzeltmeleri yapın.', 'Watch the montage one last time and make necessary corrections.', true, 1, 0),
(gen_random_uuid(), 'a0000001-0001-0001-0001-000000000005', 5, 'Sürpriz Gösterim', 'Surprise Screening', 'Doğum gününde video montajını büyük ekranda göstererek sürpriz yapın.', 'Surprise by showing the video montage on a big screen on the birthday.', true, 0, 0);

-- 93. Volunteer Day Birthday
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '877902db-3ec5-4188-a248-8a6db5031a15', 1, 'Gönüllülük Alanı Seçimi', 'Choose Volunteer Area', 'Hayvan barınağı, çevre temizliği veya yardım kuruluşu gibi bir gönüllülük alanı seçin.', 'Choose a volunteer area like animal shelter, environmental cleanup, or charity organization.', false, 14, 0),
(gen_random_uuid(), '877902db-3ec5-4188-a248-8a6db5031a15', 2, 'Kuruluşla İletişime Geçme', 'Contact the Organization', 'Seçilen kuruluşla iletişime geçin ve gönüllülük günü için kayıt yaptırın.', 'Contact the chosen organization and register for the volunteer day.', false, 10, 0),
(gen_random_uuid(), '877902db-3ec5-4188-a248-8a6db5031a15', 3, 'Arkadaşları Organize Etme', 'Organize Friends', 'Katılacak arkadaşları bilgilendirin ve detayları paylaşın.', 'Inform friends who will participate and share the details.', false, 7, 0),
(gen_random_uuid(), '877902db-3ec5-4188-a248-8a6db5031a15', 4, 'Gönüllülük Sonrası Kutlama', 'Post-Volunteer Celebration', 'Gönüllülük sonrası küçük bir kutlama yemeği planlayın.', 'Plan a small celebration dinner after volunteering.', true, 3, 500),
(gen_random_uuid(), '877902db-3ec5-4188-a248-8a6db5031a15', 5, 'Gönüllülük Gününü Başlatma', 'Start Volunteer Day', 'Hep birlikte gönüllülük yapın ve anlamlı bir doğum günü geçirin.', 'Volunteer together and have a meaningful birthday.', true, 0, 0);

-- 94. Surprise Adventure Day (Friendship)
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a4f6d937-475c-4aed-b20c-300d55f7f64b', 1, 'Macera Aktiviteleri Araştırma', 'Research Adventure Activities', 'Bölgenizdeki macera aktivitelerini araştırın: tırmanış, zipline, rafting gibi.', 'Research adventure activities in your area: climbing, zipline, rafting, etc.', false, 14, 0),
(gen_random_uuid(), 'a4f6d937-475c-4aed-b20c-300d55f7f64b', 2, 'Aktivite Rezervasyonu', 'Book Activity', 'En uygun aktiviteyi seçin ve grup için rezervasyon yapın.', 'Choose the best activity and make a reservation for the group.', false, 7, 1500),
(gen_random_uuid(), 'a4f6d937-475c-4aed-b20c-300d55f7f64b', 3, 'Sürpriz Planı Hazırlama', 'Prepare Surprise Plan', 'Arkadaşınızı maceraya nasıl götüreceğinizi planlayın.', 'Plan how to take your friend to the adventure.', false, 3, 0),
(gen_random_uuid(), 'a4f6d937-475c-4aed-b20c-300d55f7f64b', 4, 'Ekipman Hazırlığı', 'Prepare Equipment', 'Gerekli kıyafet ve ekipmanları hazırlayın.', 'Prepare necessary clothing and equipment.', true, 1, 200),
(gen_random_uuid(), 'a4f6d937-475c-4aed-b20c-300d55f7f64b', 5, 'Maceraya Başlama', 'Start the Adventure', 'Sürprizi açıklayın ve heyecanlı bir macera gününe başlayın.', 'Reveal the surprise and start an exciting adventure day.', true, 0, 0);

-- 95. Friendship Appreciation Day Surprise
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '3e1cf4d5-6ed8-443b-af70-3481655a91d4', 1, 'Takdir Mesajı Hazırlama', 'Prepare Appreciation Message', 'Arkadaşınız için neden özel olduğunu anlatan samimi bir mesaj yazın.', 'Write a heartfelt message explaining why your friend is special.', false, 7, 0),
(gen_random_uuid(), '3e1cf4d5-6ed8-443b-af70-3481655a91d4', 2, 'Kişisel Hediye Seçimi', 'Choose Personal Gift', 'Arkadaşlığınızı simgeleyen anlamlı bir hediye seçin.', 'Choose a meaningful gift that symbolizes your friendship.', false, 5, 500),
(gen_random_uuid(), '3e1cf4d5-6ed8-443b-af70-3481655a91d4', 3, 'Anı Albümü Hazırlama', 'Prepare Memory Album', 'Birlikte çekilmiş fotoğraflardan bir anı albümü veya kolaj oluşturun.', 'Create a memory album or collage from photos taken together.', false, 3, 200),
(gen_random_uuid(), '3e1cf4d5-6ed8-443b-af70-3481655a91d4', 4, 'Sürpriz Planı', 'Surprise Plan', 'Hediye ve mesajı nasıl sunacağınızı planlayın.', 'Plan how you will present the gift and message.', true, 1, 0),
(gen_random_uuid(), '3e1cf4d5-6ed8-443b-af70-3481655a91d4', 5, 'Sürprizi Gerçekleştirme', 'Execute the Surprise', 'Arkadaşınıza hediyeyi ve mesajı sunarak takdirinizi gösterin.', 'Show your appreciation by presenting the gift and message to your friend.', true, 0, 0);

-- 96. Surprise Beach Day
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '02a8df05-8931-49ac-a8eb-5993ce9d4712', 1, 'Plaj Yeri Seçimi', 'Choose Beach Location', 'Güzel ve sakin bir plaj belirleyin ve hava durumunu kontrol edin.', 'Choose a beautiful and quiet beach and check the weather forecast.', false, 7, 0),
(gen_random_uuid(), '02a8df05-8931-49ac-a8eb-5993ce9d4712', 2, 'Plaj Malzemeleri Hazırlama', 'Prepare Beach Supplies', 'Şemsiye, havlu, güneş kremi ve plaj oyunları temin edin.', 'Get umbrella, towels, sunscreen, and beach games.', false, 2, 300),
(gen_random_uuid(), '02a8df05-8931-49ac-a8eb-5993ce9d4712', 3, 'Yiyecek ve İçecek Hazırlama', 'Prepare Food and Drinks', 'Soğutucu çanta içinde sandviçler, meyveler ve soğuk içecekler hazırlayın.', 'Prepare sandwiches, fruits, and cold drinks in a cooler bag.', false, 0, 300),
(gen_random_uuid(), '02a8df05-8931-49ac-a8eb-5993ce9d4712', 4, 'Arkadaşları Sürpriz Davet Etme', 'Secretly Invite Friends', 'Diğer arkadaşları gizlice plajda buluşmaları için davet edin.', 'Secretly invite other friends to meet at the beach.', true, 3, 0),
(gen_random_uuid(), '02a8df05-8931-49ac-a8eb-5993ce9d4712', 5, 'Sürpriz Plaj Günü', 'Surprise Beach Day', 'Arkadaşınızı sürpriz olarak plaja götürün ve eğlenceli bir gün geçirin.', 'Take your friend to the beach as a surprise and have a fun day.', true, 0, 0);

-- 97. Blind Wine Tasting Night
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a2ede10e-ae21-4015-b490-59803f52ad45', 1, 'Şarap Seçimi', 'Wine Selection', 'Farklı bölgelerden 4-6 çeşit şarap satın alın.', 'Purchase 4-6 varieties of wine from different regions.', false, 7, 1000),
(gen_random_uuid(), 'a2ede10e-ae21-4015-b490-59803f52ad45', 2, 'Tadım Kartları Hazırlama', 'Prepare Tasting Cards', 'Her şarap için puan ve not yazılacak tadım kartları hazırlayın.', 'Prepare tasting cards for scoring and notes for each wine.', false, 3, 50),
(gen_random_uuid(), 'a2ede10e-ae21-4015-b490-59803f52ad45', 3, 'Peynir ve Atıştırmalık Tabağı', 'Cheese and Snack Platter', 'Farklı peynirler, zeytinler ve krakerlerden oluşan bir tadım tabağı hazırlayın.', 'Prepare a tasting platter with different cheeses, olives, and crackers.', false, 0, 500),
(gen_random_uuid(), 'a2ede10e-ae21-4015-b490-59803f52ad45', 4, 'Ortam Hazırlama', 'Set the Atmosphere', 'Mumlar ve yumuşak müzikle zarif bir ortam oluşturun.', 'Create an elegant atmosphere with candles and soft music.', true, 0, 100),
(gen_random_uuid(), 'a2ede10e-ae21-4015-b490-59803f52ad45', 5, 'Kör Tadımı Başlatma', 'Start Blind Tasting', 'Şişeleri gizleyin ve sırayla her şarabı kör olarak tadın.', 'Hide the bottles and taste each wine blindly in order.', true, 0, 0);

-- 98. Custom Board Game Night
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), '54568ee9-8641-4039-a00d-c91576205742', 1, 'Oyun Konsepti Belirleme', 'Determine Game Concept', 'Arkadaş grubunuza özel bir kutu oyunu konsepti oluşturun.', 'Create a custom board game concept specific to your friend group.', false, 14, 0),
(gen_random_uuid(), '54568ee9-8641-4039-a00d-c91576205742', 2, 'Oyun Tahtası ve Kartları Tasarlama', 'Design Game Board and Cards', 'Oyun tahtasını çizin, soru kartlarını ve kuralları hazırlayın.', 'Draw the game board, prepare question cards and rules.', false, 10, 300),
(gen_random_uuid(), '54568ee9-8641-4039-a00d-c91576205742', 3, 'Oyunu Üretme', 'Produce the Game', 'Oyun tahtasını bastırın, kartları kesin ve kutuyu hazırlayın.', 'Print the game board, cut the cards, and prepare the box.', false, 5, 200),
(gen_random_uuid(), '54568ee9-8641-4039-a00d-c91576205742', 4, 'Atıştırmalık Hazırlama', 'Prepare Snacks', 'Oyun gecesi için atıştırmalıklar ve içecekler hazırlayın.', 'Prepare snacks and drinks for game night.', true, 0, 300),
(gen_random_uuid(), '54568ee9-8641-4039-a00d-c91576205742', 5, 'Oyun Gecesini Başlatma', 'Start Game Night', 'Arkadaşları toplayın ve özel tasarım kutu oyununu tanıtın.', 'Gather friends and introduce the custom-designed board game.', true, 0, 0);

-- 99. Escape Room Adventure with Friends
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'e1a7e26f-e646-4a10-9f1f-52e39bc7f4fc', 1, 'Kaçış Odası Seçimi', 'Choose Escape Room', 'Grup büyüklüğüne ve ilgi alanlarına uygun bir kaçış odası seçin.', 'Choose an escape room suitable for the group size and interests.', false, 14, 0),
(gen_random_uuid(), 'e1a7e26f-e646-4a10-9f1f-52e39bc7f4fc', 2, 'Rezervasyon Yapma', 'Make Reservation', 'Seçilen kaçış odası için tarih ve saat belirleyip rezervasyon yapın.', 'Set a date and time for the chosen escape room and make a reservation.', false, 10, 1000),
(gen_random_uuid(), 'e1a7e26f-e646-4a10-9f1f-52e39bc7f4fc', 3, 'Arkadaşları Davet Etme', 'Invite Friends', 'Arkadaşlarınızı tarihi ve buluşma noktasını bildirerek davet edin.', 'Invite your friends by informing them of the date and meeting point.', false, 7, 0),
(gen_random_uuid(), 'e1a7e26f-e646-4a10-9f1f-52e39bc7f4fc', 4, 'Sonrası Plan Hazırlama', 'Plan After-Activity', 'Kaçış odası sonrası için bir kafe veya restoranda buluşma planlayın.', 'Plan a meetup at a cafe or restaurant after the escape room.', true, 3, 500),
(gen_random_uuid(), 'e1a7e26f-e646-4a10-9f1f-52e39bc7f4fc', 5, 'Maceraya Başlama', 'Start the Adventure', 'Buluşma noktasında toplanın ve kaçış odası macerasına başlayın.', 'Gather at the meeting point and start the escape room adventure.', true, 0, 0);

-- 100. Friendship Video Montage
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'f3ac7081-69e0-4847-9d19-e5c14e4723b4', 1, 'Fotoğraf ve Video Toplama', 'Collect Photos and Videos', 'Arkadaşlığınızdan en güzel fotoğrafları ve videoları toplayın.', 'Collect the best photos and videos from your friendship.', false, 14, 0),
(gen_random_uuid(), 'f3ac7081-69e0-4847-9d19-e5c14e4723b4', 2, 'Müzik Seçimi', 'Choose Music', 'Arkadaşlığınızı en iyi anlatan şarkıları seçin.', 'Choose songs that best describe your friendship.', false, 7, 0),
(gen_random_uuid(), 'f3ac7081-69e0-4847-9d19-e5c14e4723b4', 3, 'Video Montajını Oluşturma', 'Create Video Montage', 'Fotoğrafları ve videoları kronolojik sırada düzenleyin, müzik ve yazılar ekleyin.', 'Arrange photos and videos chronologically, add music and text overlays.', false, 5, 0),
(gen_random_uuid(), 'f3ac7081-69e0-4847-9d19-e5c14e4723b4', 4, 'Son Düzenleme', 'Final Edit', 'Montajı gözden geçirin ve gerekli düzeltmeleri yapın.', 'Review the montage and make necessary corrections.', true, 2, 0),
(gen_random_uuid(), 'f3ac7081-69e0-4847-9d19-e5c14e4723b4', 5, 'Videoyu Paylaşma', 'Share the Video', 'Videoyu arkadaşınıza özel bir anla birlikte gösterin.', 'Show the video to your friend at a special moment.', true, 0, 0);

-- 101. Friends Cooking Night
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'e77f36b5-22ad-45b0-95eb-344c0b41afe5', 1, 'Menü ve Tarif Seçimi', 'Choose Menu and Recipe', 'Birlikte pişirilecek yemeklerin tariflerini araştırın ve menüyü oluşturun.', 'Research recipes to cook together and create the menu.', false, 7, 0),
(gen_random_uuid(), 'e77f36b5-22ad-45b0-95eb-344c0b41afe5', 2, 'Malzeme Alışverişi', 'Shop for Ingredients', 'Tariflerde gereken tüm malzemeleri satın alın.', 'Buy all the ingredients needed for the recipes.', false, 1, 500),
(gen_random_uuid(), 'e77f36b5-22ad-45b0-95eb-344c0b41afe5', 3, 'Mutfak Hazırlığı', 'Kitchen Preparation', 'Mutfağı düzenleyin, tezgahları temizleyin ve araç gereçleri hazırlayın.', 'Organize the kitchen, clean countertops, and prepare utensils.', false, 0, 0),
(gen_random_uuid(), 'e77f36b5-22ad-45b0-95eb-344c0b41afe5', 4, 'Müzik ve Atmosfer', 'Music and Atmosphere', 'Eğlenceli bir çalma listesi hazırlayın ve ortamı keyifli hale getirin.', 'Prepare a fun playlist and make the atmosphere enjoyable.', true, 0, 0),
(gen_random_uuid(), 'e77f36b5-22ad-45b0-95eb-344c0b41afe5', 5, 'Birlikte Pişirme ve Yeme', 'Cook and Eat Together', 'Arkadaşlarla birlikte yemekleri pişirin ve hazırladıklarınızı masada paylaşın.', 'Cook the meals with friends and share what you made at the table.', true, 0, 0);

-- 102. Friendship Appreciation Day
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'a0000008-0001-0001-0001-000000000001', 1, 'Arkadaşlık Listesi Oluşturma', 'Create Friendship List', 'Takdir edeceğiniz arkadaşlarınızı ve her birine özel bir şey planlayın.', 'List friends you want to appreciate and plan something special for each.', false, 10, 0),
(gen_random_uuid(), 'a0000008-0001-0001-0001-000000000001', 2, 'Kişisel Mesajlar Yazma', 'Write Personal Messages', 'Her arkadaşınız için samimi bir takdir mesajı veya mektup yazın.', 'Write a sincere appreciation message or letter for each friend.', false, 5, 50),
(gen_random_uuid(), 'a0000008-0001-0001-0001-000000000001', 3, 'Küçük Hediyeler Hazırlama', 'Prepare Small Gifts', 'Her arkadaşın zevkine uygun küçük ama anlamlı hediyeler seçin.', 'Choose small but meaningful gifts suited to each friend''s taste.', false, 3, 500),
(gen_random_uuid(), 'a0000008-0001-0001-0001-000000000001', 4, 'Buluşma Planı Yapma', 'Plan a Gathering', 'Arkadaşlarınızı bir araya getirecek bir buluşma planlayın.', 'Plan a gathering to bring your friends together.', true, 2, 300),
(gen_random_uuid(), 'a0000008-0001-0001-0001-000000000001', 5, 'Takdiri Gösterme', 'Show Appreciation', 'Hediyelerinizi ve mesajlarınızı sunarak arkadaşlarınıza takdirinizi gösterin.', 'Show your appreciation by presenting your gifts and messages to your friends.', true, 0, 0);

-- 103. Friendship Bracelet Making Party
INSERT INTO scenario_steps (id, scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost) VALUES
(gen_random_uuid(), 'ca190e36-4455-49fe-89e8-d1c76625aadb', 1, 'Bileklik Malzemeleri Temin Etme', 'Get Bracelet Making Supplies', 'Renkli ipler, boncuklar, klipsler ve bileklik yapım malzemelerini satın alın.', 'Buy colorful threads, beads, clasps, and bracelet making supplies.', false, 7, 300),
(gen_random_uuid(), 'ca190e36-4455-49fe-89e8-d1c76625aadb', 2, 'Bileklik Desenleri Araştırma', 'Research Bracelet Patterns', 'Farklı örgü desenleri ve tekniklerini öğrenin ve örnekler hazırlayın.', 'Learn different weaving patterns and techniques and prepare samples.', false, 5, 0),
(gen_random_uuid(), 'ca190e36-4455-49fe-89e8-d1c76625aadb', 3, 'Çalışma Alanı Hazırlama', 'Set Up Workspace', 'Masa örtüleri, malzeme kutuları ve örnek bilekliklerle çalışma alanını düzenleyin.', 'Arrange the workspace with tablecloths, supply boxes, and sample bracelets.', false, 0, 50),
(gen_random_uuid(), 'ca190e36-4455-49fe-89e8-d1c76625aadb', 4, 'Atıştırmalık ve İçecek', 'Snacks and Drinks', 'Bileklik yaparken yenecek atıştırmalıklar ve içecekler hazırlayın.', 'Prepare snacks and drinks to enjoy while making bracelets.', true, 0, 200),
(gen_random_uuid(), 'ca190e36-4455-49fe-89e8-d1c76625aadb', 5, 'Bileklik Yapım Partisini Başlatma', 'Start Bracelet Making Party', 'Arkadaşları toplayın, müziği açın ve birbirinize bileklik yapın.', 'Gather friends, turn on music, and make bracelets for each other.', true, 0, 0);
