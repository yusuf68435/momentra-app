-- ===== SEED SCENARIOS =====
INSERT INTO scenarios (id, category_id, slug, title_tr, title_en, description_tr, description_en, short_desc_tr, short_desc_en, difficulty, min_budget, max_budget, min_people, max_people, prep_days, indoor_outdoor, season, tags, is_featured, is_premium, is_active, rating_avg, rating_count, view_count)
VALUES

-- BIRTHDAY
('a0000001-0001-0001-0001-000000000001', '986d9372-8f86-4bd7-9bd2-26671ad0553f',
 'surprise-birthday-party', 'Sürpriz Doğum Günü Partisi', 'Surprise Birthday Party',
 'Sevdiğiniz kişi için unutulmaz bir sürpriz doğum günü partisi planlayın. Tema seçimi, dekorasyon, pasta ve eğlenceli aktiviteler ile mükemmel bir gece.',
 'Plan an unforgettable surprise birthday party for your loved one. Theme selection, decoration, cake and fun activities for a perfect night.',
 'Tema, dekorasyon ve pasta ile tam bir parti', 'A complete party with theme, decoration and cake',
 3, 500, 5000, 5, 50, 14, 'indoor', '{spring,summer,autumn,winter}',
 '{parti,doğum günü,eğlence,pasta}', true, false, true, 4.8, 234, 5621),

('a0000001-0001-0001-0001-000000000002', '986d9372-8f86-4bd7-9bd2-26671ad0553f',
 'midnight-birthday-surprise', 'Gece Yarısı Doğum Günü Sürprizi', 'Midnight Birthday Surprise',
 'Saat tam 00:00''da kapıyı çalın, elinizdeki pasta ve balonlarla sevdiklerinizi şaşırtın. Basit ama çok etkili.',
 'Ring the doorbell right at midnight with cake and balloons. Simple but incredibly effective.',
 'Gece yarısı pastası ile basit ama etkili', 'Simple but effective with midnight cake',
 1, 100, 500, 2, 10, 1, 'indoor', '{spring,summer,autumn,winter}',
 '{gece,basit,pasta,balon}', true, false, true, 4.9, 567, 12340),

('a0000001-0001-0001-0001-000000000003', '986d9372-8f86-4bd7-9bd2-26671ad0553f',
 'birthday-treasure-hunt', 'Doğum Günü Hazine Avı', 'Birthday Treasure Hunt',
 'Ev veya şehir genelinde ipuçları saklayarak heyecanlı bir hazine avı düzenleyin. Her ipucu küçük bir hediyeye yönlendirsin.',
 'Organize an exciting treasure hunt with clues hidden around the house or city. Each clue leads to a small gift.',
 'İpuçları ve hediyelerle eğlenceli bir macera', 'A fun adventure with clues and gifts',
 3, 300, 2000, 1, 5, 5, 'both', '{spring,summer,autumn,winter}',
 '{hazine avı,macera,ipucu,hediye}', true, false, true, 4.7, 189, 4532),

('a0000001-0001-0001-0001-000000000004', '986d9372-8f86-4bd7-9bd2-26671ad0553f',
 'outdoor-bbq-birthday', 'Açık Hava BBQ Doğum Günü', 'Outdoor BBQ Birthday Party',
 'Bahçede veya parkta mangal partisi. Oyunlar, müzik ve sıcak bir atmosfer.',
 'A BBQ party in the garden or park. Games, music, and a warm atmosphere.',
 'Mangal, müzik ve eğlence', 'BBQ, music and fun',
 2, 300, 2000, 5, 30, 5, 'outdoor', '{spring,summer}',
 '{mangal,açık hava,parti,müzik}', false, false, true, 4.5, 312, 5432),

('a0000001-0001-0001-0001-000000000005', '986d9372-8f86-4bd7-9bd2-26671ad0553f',
 'video-montage-birthday', 'Video Montaj Sürprizi', 'Video Montage Surprise',
 'Arkadaş ve aileden toplanan video mesajlarla muhteşem bir montaj hazırlayın. Doğum gününde birlikte izleyin.',
 'Create an amazing montage from video messages collected from friends and family. Watch it together on the birthday.',
 'Sevdiklerinden video mesaj montajı', 'Video message montage from loved ones',
 2, 0, 200, 1, 1, 14, 'indoor', '{spring,summer,autumn,winter}',
 '{video,montaj,mesaj,duygusal}', true, false, true, 4.9, 456, 11234),

-- PROPOSAL
('a0000002-0001-0001-0001-000000000001', 'cbafc48e-e580-41fc-a84d-046ca53eee85',
 'rooftop-proposal', 'Çatı Katında Evlilik Teklifi', 'Rooftop Proposal',
 'Şehrin ışıkları altında, çatı katında romantik bir evlilik teklifi. Mumlar, çiçekler ve özel bir yemek ile unutulmaz bir an.',
 'A romantic rooftop proposal under city lights. Candles, flowers, and a special dinner for an unforgettable moment.',
 'Şehir manzaralı romantik teklif', 'Romantic proposal with city view',
 4, 2000, 15000, 2, 2, 14, 'outdoor', '{spring,summer}',
 '{romantik,çatı,manzara,teklif}', true, true, true, 4.9, 342, 8901),

('a0000002-0001-0001-0001-000000000002', 'cbafc48e-e580-41fc-a84d-046ca53eee85',
 'beach-proposal', 'Sahilde Evlilik Teklifi', 'Beach Proposal',
 'Gün batımında sahilde, kumun üzerine yazılmış mesaj ve etrafta mumlar. Fotoğrafçı gizlice anı yakalasın.',
 'At sunset on the beach with a message written in the sand surrounded by candles. A photographer secretly captures the moment.',
 'Gün batımında sahil teklifi', 'Sunset beach proposal',
 3, 1000, 8000, 2, 2, 7, 'outdoor', '{spring,summer}',
 '{sahil,gün batımı,romantik,fotoğraf}', true, false, true, 4.8, 278, 7654),

('a0000002-0001-0001-0001-000000000003', 'cbafc48e-e580-41fc-a84d-046ca53eee85',
 'flash-mob-proposal', 'Flash Mob Evlilik Teklifi', 'Flash Mob Proposal',
 'AVM ya da parkta aniden dans eden bir grup, sonunda sevgilinizin önünde diz çökün. Profesyonel dansçılar ve koreografi.',
 'A group suddenly starts dancing in a mall or park, ending with you on one knee. Professional dancers and choreography.',
 'Dansçılarla gösterişli teklif', 'Spectacular proposal with dancers',
 5, 5000, 25000, 2, 30, 21, 'both', '{spring,summer,autumn}',
 '{flash mob,dans,gösterişli,koreografi}', true, true, true, 5.0, 156, 15670),

('a0000002-0001-0001-0001-000000000004', 'cbafc48e-e580-41fc-a84d-046ca53eee85',
 'restaurant-proposal', 'Restoranda Evlilik Teklifi', 'Restaurant Proposal',
 'Özel bir restoranda, tatlıyla birlikte gelen yüzük sürprizi. Şef ile önceden planlayın, canlı müzik eşliğinde.',
 'A ring surprise with dessert at a special restaurant. Plan ahead with the chef, accompanied by live music.',
 'Restoranda zarif teklif', 'Elegant restaurant proposal',
 3, 2000, 8000, 2, 2, 7, 'indoor', '{spring,summer,autumn,winter}',
 '{restoran,yemek,yüzük,müzik}', false, false, true, 4.7, 345, 6543),

-- ANNIVERSARY
('a0000003-0001-0001-0001-000000000001', 'db9f74fb-c362-4eaf-9a78-3d833ad6d4d5',
 'memory-lane-anniversary', 'Anı Yolu Yıldönümü', 'Memory Lane Anniversary',
 'İlişkinizin önemli anlarını fotoğraflarla süslenmiş bir yolda yeniden yaşayın. Her durak bir anıyı temsil etsin.',
 'Relive important moments of your relationship on a path decorated with photos. Each stop represents a memory.',
 'Fotoğraflarla süslü anı yolculuğu', 'A memory journey decorated with photos',
 3, 500, 3000, 2, 2, 7, 'both', '{spring,summer,autumn,winter}',
 '{anı,fotoğraf,romantik,yıldönümü}', true, false, true, 4.7, 423, 6789),

('a0000003-0001-0001-0001-000000000002', 'db9f74fb-c362-4eaf-9a78-3d833ad6d4d5',
 'candlelight-dinner', 'Mum Işığında Akşam Yemeği', 'Candlelight Dinner',
 'Evinizde veya özel bir mekanda, mumlar, çiçekler ve özel hazırlanmış bir menü ile romantik akşam yemeği.',
 'A romantic dinner at home or a special venue with candles, flowers, and a specially prepared menu.',
 'Romantik mum ışığı yemeği', 'Romantic candlelight dinner',
 2, 300, 2000, 2, 2, 3, 'indoor', '{spring,summer,autumn,winter}',
 '{romantik,yemek,mum,çiçek}', false, false, true, 4.6, 567, 8901),

-- ROMANTIC
('a0000004-0001-0001-0001-000000000001', '230be98c-45dc-4517-b3b8-c62f9c7afe66',
 'stargazing-night', 'Yıldız Gözlemi Gecesi', 'Stargazing Night',
 'Şehir dışında, battaniyelerin üzerinde uzanarak yıldızları izleyin. Sıcak çikolata, romantik müzik ve teleskop.',
 'Lie on blankets outside the city watching stars. Hot chocolate, romantic music and a telescope.',
 'Yıldızlar altında romantik gece', 'Romantic night under the stars',
 2, 200, 1500, 2, 4, 3, 'outdoor', '{summer,autumn}',
 '{yıldız,gece,romantik,doğa}', true, false, true, 4.8, 345, 7890),

('a0000004-0001-0001-0001-000000000002', '230be98c-45dc-4517-b3b8-c62f9c7afe66',
 'love-letter-trail', 'Aşk Mektubu Rotası', 'Love Letter Trail',
 'Evin her köşesine saklanan aşk mektupları. Her mektup bir sonrakinin yerini söylesin ve son mektup büyük hediyeye yönlendirsin.',
 'Love letters hidden in every corner of the house. Each letter reveals the location of the next, leading to the big gift.',
 'Mektuplarla dolu romantik rota', 'Romantic trail filled with letters',
 2, 100, 500, 2, 2, 3, 'indoor', '{spring,summer,autumn,winter}',
 '{mektup,romantik,hediye,ev}', false, false, true, 4.5, 234, 4567),

('a0000004-0001-0001-0001-000000000003', '230be98c-45dc-4517-b3b8-c62f9c7afe66',
 'hot-air-balloon-ride', 'Sıcak Hava Balonu Turu', 'Hot Air Balloon Ride',
 'Gökyüzünde süzülerek muhteşem manzaraların tadını çıkarın. Şampanya ve kahvaltı ile göklerde romantik bir deneyim.',
 'Soar through the sky enjoying breathtaking views. A romantic experience in the skies with champagne and breakfast.',
 'Göklerde unutulmaz romantik deneyim', 'Unforgettable romantic experience in the sky',
 4, 3000, 10000, 2, 4, 7, 'outdoor', '{spring,summer}',
 '{balon,gökyüzü,manzara,lüks}', true, true, true, 4.9, 123, 9876),

('a0000004-0001-0001-0001-000000000004', '230be98c-45dc-4517-b3b8-c62f9c7afe66',
 'picnic-in-the-park', 'Parkta Piknik Sürprizi', 'Surprise Park Picnic',
 'Sevdiğiniz kişiyi güzel bir parkta hazırlanmış özel bir pikniğe götürün. Şarap, peynir tabağı ve romantik müzik.',
 'Take your loved one to a specially prepared picnic in a beautiful park. Wine, cheese board, and romantic music.',
 'Doğada romantik piknik', 'Romantic picnic in nature',
 1, 200, 1000, 2, 4, 2, 'outdoor', '{spring,summer}',
 '{piknik,park,romantik,doğa}', false, false, true, 4.6, 289, 5678),

('a0000004-0001-0001-0001-000000000005', '230be98c-45dc-4517-b3b8-c62f9c7afe66',
 'surprise-weekend-getaway', 'Sürpriz Hafta Sonu Kaçamağı', 'Surprise Weekend Getaway',
 'Sevdiğinizi bilmeden bir hafta sonu tatili için bavulunu hazırlayın. Otel, aktiviteler ve romantik yemekler.',
 'Pack their bag without them knowing for a weekend getaway. Hotel, activities, and romantic dinners.',
 'Sürpriz hafta sonu tatili', 'Surprise weekend vacation',
 4, 2000, 10000, 2, 2, 7, 'both', '{spring,summer,autumn}',
 '{tatil,kaçamak,otel,lüks}', true, true, true, 4.8, 234, 8765),

-- GRADUATION
('a0000005-0001-0001-0001-000000000001', '39ba985e-7c1d-45d4-a4bf-f3589d2b28f5',
 'graduation-surprise-party', 'Mezuniyet Sürpriz Kutlaması', 'Graduation Surprise Party',
 'Mezuniyet töreninden sonra sürpriz bir kutlama. Arkadaşlar, aile, dekorasyon ve özel pasta.',
 'A surprise celebration after the graduation ceremony. Friends, family, decorations and a special cake.',
 'Mezuniyet sonrası sürpriz kutlama', 'Surprise celebration after graduation',
 2, 500, 3000, 5, 30, 7, 'both', '{spring,summer}',
 '{mezuniyet,kutlama,parti,başarı}', false, false, true, 4.6, 189, 3456),

-- BABY
('a0000006-0001-0001-0001-000000000001', '15de082d-38a2-4810-8f56-f8076641b94f',
 'gender-reveal-party', 'Cinsiyet Açıklama Partisi', 'Gender Reveal Party',
 'Bebeğin cinsiyetini renkli konfeti, balon patlatma veya pasta kesme ile açıklayın. Unutulmaz bir aile anı.',
 'Reveal the babys gender with colorful confetti, balloon popping or cake cutting. An unforgettable family moment.',
 'Renkli ve eğlenceli cinsiyet açıklaması', 'Colorful and fun gender reveal',
 2, 300, 2000, 5, 30, 7, 'both', '{spring,summer,autumn,winter}',
 '{cinsiyet,bebek,konfeti,parti}', true, false, true, 4.7, 456, 8765),

-- VALENTINES
('a0000007-0001-0001-0001-000000000001', '3f344a20-ce18-4ed6-8b5e-f1f511bf6297',
 'valentines-scavenger-hunt', 'Sevgililer Günü Hazine Avı', 'Valentines Day Scavenger Hunt',
 'Sevgiliniz için şehirde romantik bir hazine avı. Anlamlı mekanlarda ipuçları ve her durakta küçük hediyeler.',
 'A romantic city scavenger hunt for your Valentine. Clues at meaningful locations with small gifts at each stop.',
 'Şehirde romantik ipucu avı', 'Romantic clue hunt in the city',
 3, 500, 3000, 2, 2, 5, 'both', '{winter}',
 '{sevgililer günü,hazine avı,romantik,ipucu}', true, false, true, 4.8, 321, 6543),

('a0000007-0001-0001-0001-000000000002', '3f344a20-ce18-4ed6-8b5e-f1f511bf6297',
 'home-spa-date', 'Evde Spa Günü', 'Home Spa Date',
 'Evinizi bir spaya dönüştürün. Aromatik mumlar, yüz maskeleri, masaj yağları ve rahatlatıcı müzik.',
 'Transform your home into a spa. Aromatic candles, face masks, massage oils, and relaxing music.',
 'Evde lüks spa deneyimi', 'Luxury spa experience at home',
 1, 100, 500, 2, 2, 1, 'indoor', '{spring,summer,autumn,winter}',
 '{spa,rahatlama,masaj,mum}', false, false, true, 4.4, 234, 5432),

-- FRIENDSHIP
('a0000008-0001-0001-0001-000000000001', 'c993b21b-5dd6-4a78-87a5-3285e514fba5',
 'friendship-appreciation-day', 'Arkadaşlık Takdir Günü', 'Friendship Appreciation Day',
 'En yakın arkadaşınız için özel bir gün planlayın. Favori aktiviteler, anı albümü ve samimi bir kutlama.',
 'Plan a special day for your best friend. Favorite activities, memory album, and a heartfelt celebration.',
 'En yakın arkadaşınız için özel gün', 'A special day for your best friend',
 2, 200, 1500, 2, 10, 5, 'both', '{spring,summer,autumn,winter}',
 '{arkadaşlık,anı,kutlama,özel}', false, false, true, 4.5, 167, 3210),

('a0000008-0001-0001-0001-000000000002', 'c993b21b-5dd6-4a78-87a5-3285e514fba5',
 'surprise-road-trip', 'Sürpriz Yol Gezisi', 'Surprise Road Trip',
 'Arkadaşlarınızı alıp bilinmeyen bir hedefe doğru yola çıkın. Yol boyunca eğlenceli aktiviteler ve sürprizler.',
 'Pick up your friends and head to an unknown destination. Fun activities and surprises along the way.',
 'Arkadaşlarla bilinmeze yolculuk', 'Journey into the unknown with friends',
 3, 500, 3000, 3, 8, 5, 'outdoor', '{spring,summer}',
 '{yol gezisi,macera,arkadaş,sürpriz}', true, false, true, 4.7, 198, 5678),

('a0000008-0001-0001-0001-000000000003', 'c993b21b-5dd6-4a78-87a5-3285e514fba5',
 'movie-marathon-night', 'Film Maratonu Gecesi', 'Movie Marathon Night',
 'Arkadaşlarınızla favori film serisi maratonu. Patlamış mısır, battaniyeler ve rahat bir atmosfer.',
 'A favorite movie series marathon with friends. Popcorn, blankets, and a cozy atmosphere.',
 'Arkadaşlarla keyifli film gecesi', 'Fun movie night with friends',
 1, 100, 500, 3, 10, 2, 'indoor', '{spring,summer,autumn,winter}',
 '{film,arkadaş,eğlence,rahat}', false, false, true, 4.4, 234, 4567),

-- ACHIEVEMENT
('a0000009-0001-0001-0001-000000000001', '6a1f78e9-554c-4cea-8223-95f7e94bfada',
 'promotion-celebration', 'Terfi Kutlaması', 'Promotion Celebration',
 'İş yerinde terfi alan sevdikleriniz için şık bir kutlama. Özel mekan, şampanya ve onur konuşması.',
 'An elegant celebration for a loved one who got promoted. Special venue, champagne, and an honor speech.',
 'Terfi için şık ve özel kutlama', 'Elegant celebration for promotion',
 3, 1000, 5000, 5, 20, 7, 'indoor', '{spring,summer,autumn,winter}',
 '{terfi,kutlama,başarı,iş}', false, false, true, 4.5, 145, 2345),

-- APOLOGY
('a0000010-0001-0001-0001-000000000001', '66c6313c-8824-4920-8de8-fbfe61c0cb78',
 'heartfelt-apology', 'İçten Özür Sürprizi', 'Heartfelt Apology Surprise',
 'Kalbi kırılmış birine özrünüzü özel bir şekilde sunun. El yazısı mektup, favori çiçekler ve anlamlı bir hediye.',
 'Present your apology in a special way. A handwritten letter, favorite flowers, and a meaningful gift.',
 'Anlamlı ve samimi bir özür', 'A meaningful and sincere apology',
 2, 200, 1000, 2, 2, 3, 'indoor', '{spring,summer,autumn,winter}',
 '{özür,mektup,çiçek,barışma}', false, false, true, 4.3, 123, 2100),

-- HOLIDAY
('a0000011-0001-0001-0001-000000000001', '2aad3c7b-65c2-427e-94c0-1b1b3e44d02d',
 'new-year-surprise', 'Yılbaşı Sürprizi', 'New Years Eve Surprise',
 'Yeni yıla girerken sevdiklerinizi özel bir sürprizle karşılayın. Havai fişek, dilek fenerleri ve özel bir parti.',
 'Welcome the new year by surprising your loved ones. Fireworks, wish lanterns, and a special party.',
 'Yeni yıl için muhteşem sürpriz', 'Amazing surprise for New Year',
 3, 500, 5000, 5, 50, 7, 'both', '{winter}',
 '{yılbaşı,parti,havai fişek,fener}', true, false, true, 4.6, 289, 7654),

-- BABY SHOWER
('a0000012-0001-0001-0001-000000000001', '1a5804d6-9941-4582-beb9-209e1ff9e3f3',
 'classic-baby-shower', 'Klasik Baby Shower', 'Classic Baby Shower',
 'Anne adayı için sevgi dolu bir baby shower. Oyunlar, hediyeler, dekorasyon ve özel bir pasta.',
 'A loving baby shower for the mom-to-be. Games, gifts, decorations, and a special cake.',
 'Anne adayı için sevgi dolu kutlama', 'A loving celebration for the mom-to-be',
 2, 500, 3000, 5, 25, 10, 'indoor', '{spring,summer,autumn,winter}',
 '{baby shower,bebek,parti,hediye}', false, false, true, 4.6, 234, 4321),

-- OTHER
('a0000013-0001-0001-0001-000000000001', '5f268123-c3de-406f-8468-cc32ddfe5752',
 'random-act-of-kindness', 'Rastgele İyilik Günü', 'Random Act of Kindness Day',
 'Sevdiğiniz birine beklenmedik küçük iyilikler yapın. Kapısına çiçek bırakın, kahvesini ısmarlayın, arabasını yıkayın.',
 'Do unexpected small acts of kindness for someone you love. Leave flowers at their door, buy their coffee, wash their car.',
 'Beklenmedik küçük iyilikler', 'Unexpected small acts of kindness',
 1, 50, 300, 1, 1, 1, 'both', '{spring,summer,autumn,winter}',
 '{iyilik,sürpriz,basit,günlük}', false, false, true, 4.3, 456, 6789),

('a0000013-0001-0001-0001-000000000002', '5f268123-c3de-406f-8468-cc32ddfe5752',
 'escape-room-adventure', 'Kaçış Odası Macerası', 'Escape Room Adventure',
 'Arkadaş veya sevgilinizle heyecan dolu bir kaçış odası deneyimi. Takım çalışması ve eğlence garantili.',
 'An exciting escape room experience with friends or your partner. Teamwork and fun guaranteed.',
 'Heyecanlı kaçış odası deneyimi', 'Exciting escape room experience',
 2, 200, 800, 2, 6, 2, 'indoor', '{spring,summer,autumn,winter}',
 '{kaçış odası,macera,takım,eğlence}', false, false, true, 4.5, 178, 3456);


-- ===== SEED SCENARIO STEPS =====

-- Steps for Midnight Birthday Surprise
INSERT INTO scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost)
VALUES
('a0000001-0001-0001-0001-000000000002', 1, 'Pasta Siparişi', 'Order Cake', 'Favori pastaneden özel bir doğum günü pastası sipariş edin.', 'Order a special birthday cake from their favorite bakery.', false, 1, 150),
('a0000001-0001-0001-0001-000000000002', 2, 'Balon ve Dekorasyon', 'Balloons and Decoration', 'Helyum balonlar ve doğum günü süslemeleri alın.', 'Get helium balloons and birthday decorations.', false, 1, 100),
('a0000001-0001-0001-0001-000000000002', 3, 'Hediye Hazırla', 'Prepare Gift', 'Anlamlı bir hediye seçin ve paketleyin.', 'Choose a meaningful gift and wrap it.', false, 2, 200),
('a0000001-0001-0001-0001-000000000002', 4, 'Arkadaş Grubu Koordinasyonu', 'Coordinate Friend Group', 'Katılacak arkadaşları organize edin ve saat belirleyin.', 'Organize attending friends and set the time.', true, 1, 0),
('a0000001-0001-0001-0001-000000000002', 5, 'Gece Yarısı Sürprizi', 'Midnight Surprise', 'Saat 00:00''da pasta ve balonlarla kapıyı çalın!', 'Ring the doorbell at midnight with cake and balloons!', false, 0, 0);

-- Steps for Rooftop Proposal
INSERT INTO scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost)
VALUES
('a0000002-0001-0001-0001-000000000001', 1, 'Mekan Araştırması', 'Venue Research', 'Şehirdeki en iyi çatı katı mekanlarını araştırın ve rezervasyon yapın.', 'Research the best rooftop venues in the city and make a reservation.', false, 14, 0),
('a0000002-0001-0001-0001-000000000001', 2, 'Yüzük Seçimi', 'Ring Selection', 'Özel bir yüzük seçin veya kişisel tasarım yaptırın.', 'Choose a special ring or have one custom designed.', false, 30, 5000),
('a0000002-0001-0001-0001-000000000001', 3, 'Fotoğrafçı Ayarla', 'Arrange Photographer', 'Profesyonel bir fotoğrafçı ile gizlice anlaşın.', 'Secretly arrange with a professional photographer.', true, 7, 2000),
('a0000002-0001-0001-0001-000000000001', 4, 'Dekorasyon Planı', 'Decoration Plan', 'Mumlar, çiçekler ve LED ışıklar ile dekorasyon planlayın.', 'Plan decoration with candles, flowers and LED lights.', false, 3, 1500),
('a0000002-0001-0001-0001-000000000001', 5, 'Özel Menü', 'Special Menu', 'Restoran ile özel bir menü ve şampanya hazırlayın.', 'Prepare a special menu and champagne with the restaurant.', false, 3, 1000),
('a0000002-0001-0001-0001-000000000001', 6, 'Büyük Gün', 'The Big Day', 'Her şey hazır! Sevgilinizi çatı katına götürün ve teklif edin.', 'Everything is ready! Take your partner to the rooftop and propose.', false, 0, 0);

-- Steps for Surprise Birthday Party
INSERT INTO scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost)
VALUES
('a0000001-0001-0001-0001-000000000001', 1, 'Tema Seç', 'Choose Theme', 'Doğum günü kişisi için en uygun parti temasını belirleyin.', 'Determine the most suitable party theme for the birthday person.', false, 14, 0),
('a0000001-0001-0001-0001-000000000001', 2, 'Davetiye Gönder', 'Send Invitations', 'Davetlilere sürpriz olduğunu belirterek davetiye gönderin.', 'Send invitations noting that it is a surprise.', false, 10, 50),
('a0000001-0001-0001-0001-000000000001', 3, 'Mekan Hazırla', 'Prepare Venue', 'Parti mekanını temaya uygun şekilde dekore edin.', 'Decorate the party venue according to the theme.', false, 1, 500),
('a0000001-0001-0001-0001-000000000001', 4, 'Pasta ve Yiyecekler', 'Cake and Food', 'Özel pasta sipariş edin ve ikramlıkları hazırlayın.', 'Order a special cake and prepare refreshments.', false, 2, 800),
('a0000001-0001-0001-0001-000000000001', 5, 'Müzik ve Eğlence', 'Music and Entertainment', 'DJ veya playlist hazırlayın, oyunlar planlayın.', 'Prepare a DJ or playlist, plan games.', true, 3, 300),
('a0000001-0001-0001-0001-000000000001', 6, 'Sürpriz Anı', 'Surprise Moment', 'Doğum günü kişisi geldiğinde herkes saklansın ve SÜRPRİZ!', 'When the birthday person arrives, everyone hides and SURPRISE!', false, 0, 0);

-- Steps for Stargazing Night
INSERT INTO scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost)
VALUES
('a0000004-0001-0001-0001-000000000001', 1, 'Konum Seç', 'Choose Location', 'Işık kirliliği olmayan bir alan araştırın.', 'Research an area with no light pollution.', false, 3, 0),
('a0000004-0001-0001-0001-000000000001', 2, 'Ekipman Hazırla', 'Prepare Equipment', 'Battaniye, termos, sıcak çikolata ve atıştırmalık hazırlayın.', 'Prepare blankets, thermos, hot chocolate and snacks.', false, 1, 200),
('a0000004-0001-0001-0001-000000000001', 3, 'Teleskop Bul', 'Find Telescope', 'Ödünç veya kiralık bir teleskop edinin.', 'Get a borrowed or rented telescope.', true, 2, 500),
('a0000004-0001-0001-0001-000000000001', 4, 'Müzik Listesi', 'Playlist', 'Romantik ve sakin bir playlist oluşturun.', 'Create a romantic and calm playlist.', false, 1, 0),
('a0000004-0001-0001-0001-000000000001', 5, 'Yıldız Gözlemi', 'Stargazing', 'Birlikte uzanın, yıldızları izleyin ve dilekler dileyin.', 'Lie together, watch the stars and make wishes.', false, 0, 0);

-- Steps for Memory Lane Anniversary
INSERT INTO scenario_steps (scenario_id, step_number, title_tr, title_en, description_tr, description_en, is_optional, days_before, estimated_cost)
VALUES
('a0000003-0001-0001-0001-000000000001', 1, 'Fotoğrafları Topla', 'Collect Photos', 'İlişkinizden önemli anları gösteren fotoğrafları seçin.', 'Select photos showing important moments from your relationship.', false, 7, 0),
('a0000003-0001-0001-0001-000000000001', 2, 'Fotoğrafları Bastır', 'Print Photos', 'En güzel fotoğrafları bastırın ve çerçeveletin.', 'Print and frame the best photos.', false, 5, 300),
('a0000003-0001-0001-0001-000000000001', 3, 'Rota Planla', 'Plan Route', 'Anılarınızın geçtiği mekanlarda bir rota oluşturun.', 'Create a route through the places where your memories took place.', false, 3, 0),
('a0000003-0001-0001-0001-000000000001', 4, 'Mektup Yaz', 'Write Letter', 'Her durak için kısa bir anı notu yazın.', 'Write a short memory note for each stop.', false, 2, 50),
('a0000003-0001-0001-0001-000000000001', 5, 'Son Durak Sürprizi', 'Final Stop Surprise', 'Son durakta özel bir hediye veya akşam yemeği hazırlayın.', 'Prepare a special gift or dinner at the final stop.', false, 1, 500);

SELECT 'Seed data inserted!' as status;
SELECT count(*) as total_scenarios FROM scenarios;
SELECT count(*) as total_steps FROM scenario_steps;
