-- Migration 022: Fix Turkish characters and remove duplicates
-- 1. Fix title_tr and short_desc_tr for scenarios with missing diacritics
-- 2. Remove duplicate scenarios (keep the one with longer description)

BEGIN;

-- =============================================
-- PART 1: Fix Turkish characters
-- =============================================

UPDATE public.scenarios SET
  title_tr = 'Sahilde Evlilik Teklifi',
  short_desc_tr = 'Gün batımında sahilde romantik teklif'
WHERE slug = 'beach-proposal' AND title_tr = 'Sahilde Evlilik Teklifi';

UPDATE public.scenarios SET
  title_tr = 'Doğum Günü Hazine Avı',
  short_desc_tr = 'İpuçları ve hediyelerle eğlenceli bir macera'
WHERE slug = 'birthday-treasure-hunt' AND title_tr = 'Dogum Gunu Hazine Avi';

UPDATE public.scenarios SET
  title_tr = 'Mum Işığında Akşam Yemeği',
  short_desc_tr = 'Romantik mum ışığı yemeği'
WHERE slug = 'candlelight-dinner' AND title_tr = 'Mum Isiginda Aksam Yemegi';

UPDATE public.scenarios SET
  title_tr = 'Klasik Baby Shower',
  short_desc_tr = 'Anne adayı için sevgi dolu kutlama'
WHERE slug = 'classic-baby-shower' AND title_tr = 'Klasik Baby Shower';

UPDATE public.scenarios SET
  title_tr = 'Kaçış Odası Macerası',
  short_desc_tr = 'Heyecanlı kaçış odası deneyimi'
WHERE slug = 'escape-room-adventure' AND title_tr = 'Kacis Odasi Macerasi';

UPDATE public.scenarios SET
  short_desc_tr = 'Dansçılarla gösterişli teklif'
WHERE slug = 'flash-mob-proposal' AND short_desc_tr = 'Danscilarla gosterisli teklif';

UPDATE public.scenarios SET
  title_tr = 'Arkadaşlık Takdir Günü',
  short_desc_tr = 'En yakın arkadaşınız için özel gün'
WHERE slug = 'friendship-appreciation-day' AND title_tr = 'Arkadaslik Takdir Gunu';

UPDATE public.scenarios SET
  title_tr = 'Cinsiyet Açıklama Partisi',
  short_desc_tr = 'Renkli ve eğlenceli cinsiyet açıklaması'
WHERE slug = 'gender-reveal-party' AND short_desc_tr = 'Renkli ve eglenceli cinsiyet aciklamasi';

UPDATE public.scenarios SET
  title_tr = 'Mezuniyet Sürpriz Kutlaması',
  short_desc_tr = 'Mezuniyet sonrası sürpriz kutlama'
WHERE slug = 'graduation-surprise-party' AND title_tr = 'Mezuniyet Surpriz Kutlamasi';

UPDATE public.scenarios SET
  title_tr = 'İçten Özür Sürprizi',
  short_desc_tr = 'Anlamlı ve samimi bir özür'
WHERE slug = 'heartfelt-apology' AND title_tr = 'Icten Ozur Surprizi';

UPDATE public.scenarios SET
  title_tr = 'Evde Spa Günü',
  short_desc_tr = 'Evde lüks spa deneyimi'
WHERE slug = 'home-spa-date' AND title_tr = 'Evde Spa Gunu';

UPDATE public.scenarios SET
  title_tr = 'Sıcak Hava Balonu Turu',
  short_desc_tr = 'Göklerde unutulmaz romantik deneyim'
WHERE slug = 'hot-air-balloon-ride' AND title_tr = 'Sicak Hava Balonu Turu';

UPDATE public.scenarios SET
  title_tr = 'Aşk Mektubu Rotası',
  short_desc_tr = 'Mektuplarla dolu romantik rota'
WHERE slug = 'love-letter-trail' AND short_desc_tr = 'Mektuplarla dolu romantik rota';

UPDATE public.scenarios SET
  title_tr = 'Anı Yolu Yıldönümü',
  short_desc_tr = 'Fotoğraflarla süslü anı yolculuğu'
WHERE slug = 'memory-lane-anniversary' AND title_tr = 'Ani Yolu Yildonumu';

UPDATE public.scenarios SET
  title_tr = 'Gece Yarısı Doğum Günü Sürprizi',
  short_desc_tr = 'Gece yarısı pastası ile basit ama etkili'
WHERE slug = 'midnight-birthday-surprise' AND title_tr = 'Gece Yarisi Dogum Gunu Surprizi';

UPDATE public.scenarios SET
  short_desc_tr = 'Arkadaşlarla keyifli film gecesi'
WHERE slug = 'movie-marathon-night' AND short_desc_tr = 'Arkadaslarla keyifli film gecesi';

UPDATE public.scenarios SET
  title_tr = 'Yılbaşı Sürprizi',
  short_desc_tr = 'Yeni yıl için muhteşem sürpriz'
WHERE slug = 'new-year-surprise' AND title_tr = 'Yilbasi Surprizi';

UPDATE public.scenarios SET
  title_tr = 'Açık Hava BBQ Doğum Günü',
  short_desc_tr = 'Mangal, müzik ve eğlence'
WHERE slug = 'outdoor-bbq-birthday' AND title_tr = 'Acik Hava BBQ Dogum Gunu';

UPDATE public.scenarios SET
  title_tr = 'Parkta Piknik Sürprizi',
  short_desc_tr = 'Doğada romantik piknik'
WHERE slug = 'picnic-in-the-park' AND title_tr = 'Parkta Piknik Surprizi';

UPDATE public.scenarios SET
  title_tr = 'Terfi Kutlaması',
  short_desc_tr = 'Terfi için şık ve özel kutlama'
WHERE slug = 'promotion-celebration' AND short_desc_tr = 'Terfi icin sik ve ozel kutlama';

UPDATE public.scenarios SET
  title_tr = 'Rastgele İyilik Günü',
  short_desc_tr = 'Beklenmedik küçük iyilikler'
WHERE slug = 'random-act-of-kindness' AND title_tr = 'Rastgele Iyilik Gunu';

UPDATE public.scenarios SET
  title_tr = 'Restoranda Evlilik Teklifi',
  short_desc_tr = 'Restoranda zarif teklif'
WHERE slug = 'restaurant-proposal' AND title_tr = 'Restoranda Evlilik Teklifi';

UPDATE public.scenarios SET
  title_tr = 'Çatı Katında Evlilik Teklifi',
  short_desc_tr = 'Şehir manzaralı romantik teklif'
WHERE slug = 'rooftop-proposal' AND title_tr = 'Cati Katinda Evlilik Teklifi';

UPDATE public.scenarios SET
  title_tr = 'Yıldız Gözlemi Gecesi',
  short_desc_tr = 'Yıldızlar altında romantik gece'
WHERE slug = 'stargazing-night' AND title_tr = 'Yildiz Gozlemi Gecesi';

UPDATE public.scenarios SET
  title_tr = 'Sürpriz Doğum Günü Partisi',
  short_desc_tr = 'Tema, dekorasyon ve pasta ile tam bir parti'
WHERE slug = 'surprise-birthday-party' AND title_tr = 'Surpriz Dogum Gunu Partisi';

UPDATE public.scenarios SET
  title_tr = 'Sürpriz Yol Gezisi',
  short_desc_tr = 'Arkadaşlarla bilinmeze yolculuk'
WHERE slug = 'surprise-road-trip' AND title_tr = 'Surpriz Yol Gezisi';

UPDATE public.scenarios SET
  title_tr = 'Sürpriz Hafta Sonu Kaçamağı',
  short_desc_tr = 'Sürpriz hafta sonu tatili'
WHERE slug = 'surprise-weekend-getaway' AND title_tr = 'Surpriz Hafta Sonu Kacamagi';

UPDATE public.scenarios SET
  title_tr = 'Sevgililer Günü Hazine Avı',
  short_desc_tr = 'Şehirde romantik ipucu avı'
WHERE slug = 'valentines-scavenger-hunt' AND title_tr = 'Sevgililer Gunu Hazine Avi';

UPDATE public.scenarios SET
  title_tr = 'Video Montaj Sürprizi',
  short_desc_tr = 'Sevdiklerinden video mesaj montajı'
WHERE slug = 'video-montage-birthday' AND title_tr = 'Video Montaj Surprizi';

-- =============================================
-- PART 2: Remove duplicate scenarios
-- Keep the one with longer description_tr
-- =============================================

-- Delete the duplicate flash-mob-proposal with shorter description
DELETE FROM public.scenarios
WHERE slug = 'flash-mob-proposal'
AND id = (SELECT id FROM public.scenarios WHERE slug = 'flash-mob-proposal' ORDER BY length(description_tr) ASC LIMIT 1);

-- Delete the duplicate gender-reveal-party with shorter description
DELETE FROM public.scenarios
WHERE slug = 'gender-reveal-party'
AND id = (SELECT id FROM public.scenarios WHERE slug = 'gender-reveal-party' ORDER BY length(description_tr) ASC LIMIT 1);

-- Delete the duplicate movie-marathon-night with shorter description
DELETE FROM public.scenarios
WHERE slug = 'movie-marathon-night'
AND id = (SELECT id FROM public.scenarios WHERE slug = 'movie-marathon-night' ORDER BY length(description_tr) ASC LIMIT 1);

-- Delete the duplicate promotion-celebration with shorter description
DELETE FROM public.scenarios
WHERE slug = 'promotion-celebration'
AND id = (SELECT id FROM public.scenarios WHERE slug = 'promotion-celebration' ORDER BY length(description_tr) ASC LIMIT 1);

COMMIT;
