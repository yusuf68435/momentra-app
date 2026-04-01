-- Fix Turkish character encoding in scenario_steps
-- These steps were inserted without proper Turkish diacritics (ş,ç,ö,ü,ğ,ı,İ)

-- memory-lane-anniversary
UPDATE scenario_steps SET
  title_tr = 'Fotoğrafları Topla',
  description_tr = 'İlişkinizden önemli anları gösteren fotoğrafları seçin.'
WHERE id = 'b7ac4d4e-89d3-4f20-a13b-b7dcb86e144c';

UPDATE scenario_steps SET
  title_tr = 'Fotoğrafları Bastır',
  description_tr = 'En güzel fotoğrafları bastırın ve çerçeveletin.'
WHERE id = '36c6ec6e-0c3d-4a2d-b61a-a98258be56a4';

UPDATE scenario_steps SET
  title_tr = 'Rota Planla',
  description_tr = 'Anılarınızın geçtiği mekanlarda bir rota oluşturun.'
WHERE id = '6c328ab8-2405-468f-bb3d-f2d08566400c';

UPDATE scenario_steps SET
  title_tr = 'Mektup Yaz',
  description_tr = 'Her durak için kısa bir anı notu yazın.'
WHERE id = '1ed6ef68-8b40-4c2c-bac3-00318f79bcad';

UPDATE scenario_steps SET
  title_tr = 'Son Durak Sürprizi',
  description_tr = 'Son durakta özel bir hediye veya akşam yemeği hazırlayın.'
WHERE id = 'fc93af7d-5e92-4aca-ade6-0cb9d6b8fd8e';

-- midnight-birthday-surprise
UPDATE scenario_steps SET
  title_tr = 'Pasta Siparişi',
  description_tr = 'Favori pastaneden özel bir doğum günü pastası sipariş edin.'
WHERE id = '14de04d1-68f4-466d-b7d6-f849d3008cfc';

UPDATE scenario_steps SET
  title_tr = 'Balon ve Dekorasyon',
  description_tr = 'Helyum balonlar ve doğum günü süslemeleri alın.'
WHERE id = '2fe1a2c9-3af6-47c4-a812-117181bb3c3d';

UPDATE scenario_steps SET
  title_tr = 'Hediye Hazırla',
  description_tr = 'Anlamlı bir hediye seçin ve paketleyin.'
WHERE id = '852cfc9e-19df-4930-ad20-49787405f58f';

UPDATE scenario_steps SET
  title_tr = 'Arkadaş Grubu Koordinasyonu',
  description_tr = 'Katılacak arkadaşları organize edin ve saat belirleyin.'
WHERE id = 'a245bc98-2a4c-47ae-941f-cbbffefc17b4';

UPDATE scenario_steps SET
  title_tr = 'Gece Yarısı Sürprizi',
  description_tr = 'Saat 00:00''da pasta ve balonlarla kapıyı çalın!'
WHERE id = 'b67c6ef4-7337-4da7-ae5b-be7b3dd6eecb';

-- rooftop-proposal
UPDATE scenario_steps SET
  title_tr = 'Mekan Araştırması',
  description_tr = 'Şehirdeki en iyi çatı katı mekanlarını araştırın ve rezervasyon yapın.'
WHERE id = 'f1099e26-c2c5-48ab-8259-817c985be5eb';

UPDATE scenario_steps SET
  title_tr = 'Yüzük Seçimi',
  description_tr = 'Özel bir yüzük seçin veya kişisel tasarım yaptırın.'
WHERE id = 'b7349e2e-052d-4715-903b-5de52894e47a';

UPDATE scenario_steps SET
  title_tr = 'Fotoğrafçı Ayarla',
  description_tr = 'Profesyonel bir fotoğrafçı ile gizlice anlaşın.'
WHERE id = 'e3abe402-cc92-4ae2-9f13-f570de0c1c7d';

UPDATE scenario_steps SET
  title_tr = 'Dekorasyon Planı',
  description_tr = 'Mumlar, çiçekler ve LED ışıklar ile dekorasyon planlayın.'
WHERE id = '53670f8f-f089-48a6-89ed-3e961a44ada8';

UPDATE scenario_steps SET
  title_tr = 'Özel Menü',
  description_tr = 'Restoran ile özel bir menü ve şampanya hazırlayın.'
WHERE id = '3b0d52b3-2518-4c4a-a0c5-7f4e8c6b8ef5';

UPDATE scenario_steps SET
  title_tr = 'Büyük Gün',
  description_tr = 'Her şey hazır! Sevgilinizi çatı katına götürün ve teklif edin.'
WHERE id = '1f561bd6-2e41-4bbb-a20f-d1f024d8b125';

-- stargazing-night
UPDATE scenario_steps SET
  title_tr = 'Konum Seç',
  description_tr = 'Işık kirliliği olmayan bir alan araştırın.'
WHERE id = '248f4953-636f-4afa-b946-7b41061cd228';

UPDATE scenario_steps SET
  title_tr = 'Ekipman Hazırla',
  description_tr = 'Battaniye, termos, sıcak çikolata ve atıştırmalık hazırlayın.'
WHERE id = '08fd6089-8aa0-42e8-9bdf-44288bf04b89';

UPDATE scenario_steps SET
  title_tr = 'Teleskop Bul',
  description_tr = 'Ödünç veya kiralık bir teleskop edinin.'
WHERE id = '750c1090-2c44-4953-a801-3ce5811ef893';

UPDATE scenario_steps SET
  title_tr = 'Müzik Listesi',
  description_tr = 'Romantik ve sakin bir playlist oluşturun.'
WHERE id = '21a08a13-dfa0-4dee-ad71-5833ff6caae2';

UPDATE scenario_steps SET
  title_tr = 'Yıldız Gözlemi',
  description_tr = 'Birlikte uzanın, yıldızları izleyin ve dilekler dileyin.'
WHERE id = '97451926-b11d-4855-a066-603c9c772677';

-- surprise-birthday-party
UPDATE scenario_steps SET
  title_tr = 'Tema Seç',
  description_tr = 'Doğum günü kişisi için en uygun parti temasını belirleyin.'
WHERE id = '05dbc9b5-bd30-489e-bf26-887e43dcbeec';

UPDATE scenario_steps SET
  title_tr = 'Davetiye Gönder',
  description_tr = 'Davetlilere sürpriz olduğunu belirterek davetiye gönderin.'
WHERE id = 'c3b7874e-76c2-4c16-974a-95e020e6da6c';

UPDATE scenario_steps SET
  title_tr = 'Mekan Hazırla',
  description_tr = 'Parti mekanını temaya uygun şekilde dekore edin.'
WHERE id = 'ae39e8f8-5041-4c93-b721-aadd499aa531';

UPDATE scenario_steps SET
  title_tr = 'Pasta ve Yiyecekler',
  description_tr = 'Özel pasta sipariş edin ve ikramlıkları hazırlayın.'
WHERE id = 'e3789072-1540-4e1f-ac83-910cbe28f384';

UPDATE scenario_steps SET
  title_tr = 'Müzik ve Eğlence',
  description_tr = 'DJ veya playlist hazırlayın, oyunlar planlayın.'
WHERE id = '4233a7c5-7cde-4634-9a25-3954298f2cb7';

UPDATE scenario_steps SET
  title_tr = 'Sürpriz Anı',
  description_tr = 'Doğum günü kişisi geldiğinde herkes saklansın ve SÜRPRİZ!'
WHERE id = '3023429b-bdc0-4f92-b2b4-a98bc60d2919';
