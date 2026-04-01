-- ===== SEED COMMUNITY STORIES =====
-- Demo hikayeler - çeşitli yazarlar ve Türkçe karakterler ile
-- Supabase SQL Editor'da (service_role olarak) çalıştırın.

-- Geçici olarak RLS bypass (service_role zaten bypass eder)
-- user_id alanı display için değil, sahiplik için kullanılır.
-- Demo veriler için sabit UUID'ler kullanıyoruz.

INSERT INTO community_stories (
  id,
  user_id,
  title,
  content,
  photos,
  category,
  is_anonymous,
  is_reported,
  author_name,
  author_avatar,
  likes_count,
  comments_count,
  created_at,
  updated_at
)
VALUES

-- Hikaye 1: Sürpriz doğum günü - Ayşe
(
  'b1000001-0001-0001-0001-000000000001',
  'b2000001-0001-0001-0001-000000000001',
  'Eşime 40. Yaş Sürprizi — Gözleri Doldu!',
  'Eşim 40 yaşına giriyordu ve hiç beklemiyordu. 3 ay önceden hazırlığa başladım. Tüm arkadaşlarını ve ailesini davet ettim ama eşime hiç söylemedim. En zor kısım poker yüzü yapmaktı. Gün geldi, restorana "romantik akşam yemeği" bahanesiyle götürdüm. Kapıyı açınca 50 kişi "Sürpriz!" diye bağırdı. Hayatımda ilk kez eşimi ağlarken gördüm — mutluluktan. Bu anı unutamam.',
  '{}',
  'birthday',
  false,
  false,
  'Ayşe K.',
  null,
  87,
  14,
  NOW() - INTERVAL '2 days',
  NOW() - INTERVAL '2 days'
),

-- Hikaye 2: Evlilik teklifi - Mehmet
(
  'b1000002-0001-0001-0001-000000000002',
  'b2000002-0001-0001-0001-000000000002',
  'Sahilde Evlilik Teklifi — Fotoğrafçı Gizlice Kaydetti',
  'Sevgilime tam 2 yıldır evlilik teklifini nasıl yapacağımı düşünüyordum. Doğum gününün arifesinde sahile götürdüm. Kuma "Evlenir misin?" yazdırdım — dalgalar silmeden önce teklif ettim. Profesyonel bir fotoğrafçıyı gizlice aydınlıktım, o da tüm anı böyle güzel yakaladı. Evet dedi tabii ki! En güzel gece hayatımda.',
  '{}',
  'proposal',
  false,
  false,
  'Mehmet A.',
  null,
  243,
  38,
  NOW() - INTERVAL '5 days',
  NOW() - INTERVAL '5 days'
),

-- Hikaye 3: Yıldönümü - Zeynep (anonim değil)
(
  'b1000003-0001-0001-0001-000000000003',
  'b2000003-0001-0001-0001-000000000003',
  '10. Yıldönümümüzde Evimizi Baştan Süsledik',
  '10 yıl... İnanamıyorum. Eşimle tanıştığımız gün ile bugün arasında geçen her anı bir fotoğrafla anlattım. Evimizin tüm odalarına fotoğraf astım, aydınlatma ile romantik bir atmosfer yarattım ve favori restoranımızdan paket yemek sipariş ettim. Eşim işten döndüğünde ağladı. Ben de ağladım. Çocuklarımız da... Mükemmel bir akşamdı.',
  '{}',
  'anniversary',
  false,
  false,
  'Zeynep M.',
  null,
  156,
  22,
  NOW() - INTERVAL '8 days',
  NOW() - INTERVAL '8 days'
),

-- Hikaye 4: Mezuniyet sürprizi - Burak
(
  'b1000004-0001-0001-0001-000000000004',
  'b2000004-0001-0001-0001-000000000004',
  'Kız Kardeşimin Mezuniyeti İçin Şehirler Arası Sürpriz',
  'Kız kardeşim İzmir''de üniversite okuyor, ben İstanbul''dayım. Mezuniyet törenine katılamayacağımı söyledim, ama aslında gizlice uçağa bindim. Tören sonrası ailesiyle dışarıdayken kapıdan içeri girdim. Beni görünce önce dondu kaldı, sonra koşup sarıldı ve hıçkıra hıçkıra ağladı. Hayatımın en güzel anlarından biri oldu.',
  '{}',
  'graduation',
  false,
  false,
  'Burak T.',
  null,
  312,
  47,
  NOW() - INTERVAL '12 days',
  NOW() - INTERVAL '12 days'
),

-- Hikaye 5: Anonim hikaye
(
  'b1000005-0001-0001-0001-000000000005',
  'b2000005-0001-0001-0001-000000000005',
  'Annemin Yüzündeki İfadeyi Ömrüm Boyunca Unutmayacağım',
  'Annem 65 yaşına girdi ve tüm kardeşlerim farklı şehirlerdeydi. Kimsenin gelmeyeceğini düşünüyordu. Ben de onları koordine ettim — 4 kardeş, 11 torun, aynı anda kapıdan girdik. Annemin yüzündeki o şok ve mutluluk karışımı ifadeyi... kelimelerle anlatmak mümkün değil. Tek pişmanlığım o anı kaydetmemek.',
  '{}',
  'birthday',
  true,
  false,
  null,
  null,
  428,
  63,
  NOW() - INTERVAL '15 days',
  NOW() - INTERVAL '15 days'
),

-- Hikaye 6: Romantik sürpriz - Elif
(
  'b1000006-0001-0001-0001-000000000006',
  'b2000006-0001-0001-0001-000000000006',
  'Evde Yıldız Gecesi — Balkon Sürprizi',
  'Eşim çok stresli bir dönem geçiriyordu. Balkonumuzu tamamen farklı bir yere dönüştürdüm: yüzlerce ışık, nane çayı, favori müziği ve yıldızları izleyebileceğimiz battaniyeler. Hiçbir şey söylemeden "balkondan bir şeye bakar mısın?" dedim. Gördüğünde gülümsemesi tüm yorgunluğumu aldı. Bazen büyük jestler gerekmez, sadece dikkat lazım.',
  '{}',
  'just_because',
  false,
  false,
  'Elif Y.',
  null,
  198,
  29,
  NOW() - INTERVAL '3 days',
  NOW() - INTERVAL '3 days'
),

-- Hikaye 7: Barışma sürprizi - Can
(
  'b1000007-0001-0001-0001-000000000007',
  'b2000007-0001-0001-0001-000000000007',
  'Özür Dilemek İçin Sevdiği Tüm Şeyleri Bir Araya Getirdim',
  'Büyük bir hata yaptım ve özür dilemem gerekiyordu. Sadece "özür dilerim" yetmezdi. Sevgilimin en sevdiği çiçekleri, en sevdiği müziği çalan küçük bir Bluetooth hoparlör, el yapımı bir kart ve içinde özel mesaj olan bir vazo... Kapısında bıraktım, üzerine not ekledim. 20 dakika sonra aradı. Ağlıyordu. Barıştık.',
  '{}',
  'other',
  false,
  false,
  'Can B.',
  null,
  89,
  16,
  NOW() - INTERVAL '20 days',
  NOW() - INTERVAL '20 days'
),

-- Hikaye 8: Başarı kutlaması - Selin
(
  'b1000008-0001-0001-0001-000000000008',
  'b2000008-0001-0001-0001-000000000008',
  'Arkadaşımın Sınavı Geçmesini Böyle Kutladık',
  'En yakın arkadaşım 3 yıl boyunca hazırlandığı TUS sınavını geçti! Haber gelir gelmez WhatsApp grubuna yazdım ve herkes toplanmayı kabul etti. 2 saatte bir ev partisi organize ettik. Balonlar, pasta, fotoğraf köşesi... Arkadaşım "sizi görmek en büyük ödülüm" dedi. Planlama şansı bile olsa bu anı kaçırmazdım.',
  '{}',
  'other',
  false,
  false,
  'Selin D.',
  null,
  134,
  21,
  NOW() - INTERVAL '7 days',
  NOW() - INTERVAL '7 days'
)

ON CONFLICT (id) DO NOTHING;

SELECT count(*) as toplam_hikaye FROM community_stories;
