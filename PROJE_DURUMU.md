# SurprizApp - Proje Durumu ve Hatirlatici
> Son guncelleme: 18 Mart 2026
> Teknoloji: React Native (Expo SDK 54) + TypeScript + Supabase + Zustand

---

## MIMARI GENEL BAKIS

```
surprise-planner/
├── app/                          # Expo Router sayfalari (file-based routing)
│   ├── (auth)/                   # Giris/kayit akisi
│   │   ├── _layout.tsx
│   │   ├── login.tsx
│   │   └── register.tsx
│   ├── (tabs)/                   # Ana tab navigasyonu (6 tab)
│   │   ├── _layout.tsx           # Tab layout - CustomTabBar + center FAB
│   │   ├── index.tsx             # Ana sayfa
│   │   ├── explore.tsx           # Kesfet
│   │   ├── plans.tsx             # Planlarim
│   │   ├── ai.tsx                # AI Asistan
│   │   ├── community.tsx         # Topluluk hikayeleri
│   │   └── profile.tsx           # Profil
│   ├── plan/[id]/                # Plan detay alt sayfalari
│   │   ├── index.tsx             # Plan detay (feature hub ile)
│   │   ├── checklist.tsx         # Kontrol listesi
│   │   ├── expenses.tsx          # Harcamalar
│   │   ├── chat.tsx              # AI sohbet
│   │   ├── co-organizers.tsx     # Organizatorler
│   │   ├── complete.tsx          # Surprizi tamamla
│   │   ├── weather.tsx           # Hava durumu (Open-Meteo API)
│   │   ├── timeline.tsx          # Akilli zaman cizelgesi
│   │   ├── moodboard.tsx         # Ilham panosu (masonry grid)
│   │   ├── guests.tsx            # Misafir RSVP yonetimi
│   │   ├── gifts.tsx             # Hediye onerileri (AI destekli)
│   │   ├── music.tsx             # Playlist olusturucu
│   │   ├── backup.tsx            # Plan B (AI destekli)
│   │   ├── capsule.tsx           # Zaman kapsulu
│   │   └── secret-chat.tsx       # Gizli mesajlasma
│   ├── category/[slug].tsx       # Kategori filtreleme
│   ├── scenario/[id].tsx         # Senaryo detay
│   │   └── [id]/reviews.tsx      # Senaryo yorumlari
│   ├── invite/[code].tsx         # Davet linki
│   ├── settings/                 # Ayarlar alt sayfalari
│   │   ├── language.tsx
│   │   ├── notifications.tsx
│   │   ├── privacy.tsx
│   │   ├── profile-edit.tsx
│   │   ├── stealth.tsx           # Gizli mod
│   │   ├── subscription.tsx
│   │   └── terms.tsx
│   ├── vendors.tsx               # Tedarikci rehberi
│   ├── favorites.tsx             # Favoriler
│   ├── important-dates.tsx       # Onemli tarihler
│   ├── onboarding.tsx            # Ilk acilis
│   ├── _layout.tsx               # Root layout
│   ├── +html.tsx                 # Web HTML
│   ├── +not-found.tsx            # 404
│   └── modal.tsx                 # Modal sayfasi
│
├── src/
│   ├── components/
│   │   ├── ui/                   # Temel UI bilesenleri
│   │   │   ├── Button.tsx
│   │   │   ├── Card.tsx
│   │   │   ├── Input.tsx
│   │   │   ├── Badge.tsx
│   │   │   ├── Skeleton.tsx       # Skeleton + SkeletonCard/ListItem/Profile/Bento
│   │   │   ├── BottomSheet.tsx   # Gesture-driven bottom sheet (spring physics)
│   │   │   └── index.ts
│   │   ├── navigation/           # Navigasyon bilesenleri
│   │   │   └── CustomTabBar.tsx  # Custom bottom tab bar + center FAB
│   │   ├── common/               # Ortak bilesenler
│   │   │   ├── BlurHeader.tsx
│   │   │   ├── CachedImage.tsx
│   │   │   ├── CategoryChip.tsx
│   │   │   ├── EmptyState.tsx
│   │   │   ├── FavoriteButton.tsx
│   │   │   ├── LoadingScreen.tsx
│   │   │   ├── PremiumGate.tsx
│   │   │   ├── ShareButton.tsx
│   │   │   └── Toast.tsx
│   │   ├── plans/                # Plan bilesenleri (20 BILESEN)
│   │   │   ├── CountdownTimer.tsx      # Geri sayim
│   │   │   ├── ChecklistItem.tsx       # Kontrol listesi ogesi
│   │   │   ├── BudgetTracker.tsx       # Butce takibi
│   │   │   ├── AddExpenseModal.tsx     # Harcama ekleme
│   │   │   ├── ExpenseItem.tsx         # Harcama ogesi
│   │   │   ├── PhotoGallery.tsx        # Fotograf galerisi
│   │   │   ├── WeatherWidget.tsx       # Hava durumu karti (gradient arkaplan)
│   │   │   ├── SmartTimeline.tsx       # Dikey zaman cizelgesi
│   │   │   ├── MoodBoard.tsx           # Pinterest tarzi masonry grid
│   │   │   ├── BudgetAnalytics.tsx     # SVG dairesel grafik
│   │   │   ├── GiftSuggestions.tsx     # Hediye onerileri
│   │   │   ├── BackupPlan.tsx          # Plan B karti
│   │   │   ├── MusicPlaylist.tsx       # Sarki listesi
│   │   │   ├── ConfettiCelebration.tsx # 60 parcacikli konfeti efekti
│   │   │   ├── QRInvite.tsx            # QR kod davetiye
│   │   │   ├── VoiceNote.tsx           # Sesli not kaydi
│   │   │   ├── SecretMessage.tsx       # Sifreli mesaj baloncuklari
│   │   │   ├── TimeCapsule.tsx         # 3 durumlu zaman kapsulu
│   │   │   ├── EmojiReactions.tsx      # 6 emoji tepki butonu
│   │   │   ├── GuestRsvpCard.tsx       # Misafir RSVP karti
│   │   │   ├── RecurringEventBadge.tsx # Tekrarlayan etkinlik rozeti
│   │   │   └── SurpriseComparison.tsx  # Yan yana plan karsilastirma
│   │   ├── community/            # Topluluk bilesenleri
│   │   │   ├── StoryCard.tsx           # Hikaye karti
│   │   │   └── StoryFeed.tsx           # Hikaye akisi (FlatList)
│   │   ├── vendors/              # Tedarikci bilesenleri
│   │   │   └── VendorCard.tsx          # Tedarikci karti
│   │   ├── coorganizer/          # Organizator bilesenleri
│   │   │   ├── CoOrganizerCard.tsx
│   │   │   ├── InviteModal.tsx
│   │   │   ├── TaskCard.tsx
│   │   │   └── AddTaskModal.tsx
│   │   ├── dates/                # Tarih bilesenleri
│   │   │   ├── ImportantDateCard.tsx
│   │   │   └── AddDateModal.tsx
│   │   ├── gamification/         # Oyunlastirma bilesenleri
│   │   │   ├── BadgeCard.tsx
│   │   │   ├── LevelProgress.tsx
│   │   │   ├── MilestoneDisplay.tsx
│   │   │   └── StreakDisplay.tsx
│   │   ├── reviews/              # Degerlendirme bilesenleri
│   │   │   ├── ReviewCard.tsx
│   │   │   ├── StarRating.tsx
│   │   │   └── WriteReviewModal.tsx
│   │   └── scenarios/            # Senaryo bilesenleri
│   │       ├── ScenarioCard.tsx
│   │       └── FilterModal.tsx
│   │
│   ├── services/                 # API ve veritabani servisleri (22 DOSYA)
│   │   ├── supabase.ts           # Supabase istemcisi
│   │   ├── helpers.ts            # getCurrentUser, getCurrentUserId
│   │   ├── auth.ts               # Giris/kayit/cikis
│   │   ├── plans.ts              # Plan CRUD
│   │   ├── scenarios.ts          # Senaryo islemleri
│   │   ├── expenses.ts           # Harcama takibi
│   │   ├── photos.ts             # Fotograf yukleme
│   │   ├── favorites.ts          # Favori islemleri
│   │   ├── notifications.ts      # Bildirimler
│   │   ├── reviews.ts            # Degerlendirmeler
│   │   ├── coOrganizer.ts        # Organizator yonetimi
│   │   ├── importantDates.ts     # Onemli tarihler
│   │   ├── gamification.ts       # XP/rozet/seviye
│   │   ├── subscription.ts       # Premium abonelik (RevenueCat)
│   │   ├── purchases.ts          # Satin alma
│   │   ├── credits.ts            # AI kredi sistemi
│   │   ├── ai.ts                 # AI sohbet
│   │   ├── aiContext.ts          # AI baglam yonetimi
│   │   ├── aiConversations.ts    # AI konusma gecmisi
│   │   ├── weather.ts            # Open-Meteo hava durumu API
│   │   ├── timeline.ts           # Akilli zaman cizelgesi
│   │   ├── music.ts              # Playlist yonetimi
│   │   ├── gifts.ts              # Hediye onerileri
│   │   ├── guestRsvp.ts          # Misafir RSVP sistemi
│   │   ├── community.ts          # Topluluk hikayeleri
│   │   ├── vendors.ts            # Tedarikci rehberi
│   │   ├── voiceNotes.ts         # Sesli notlar (Storage)
│   │   ├── secretMessages.ts     # Gizli mesajlasma
│   │   ├── timeCapsule.ts        # Zaman kapsulu
│   │   ├── recurringEvents.ts    # Tekrarlayan etkinlikler
│   │   └── index.ts              # Barrel export
│   │
│   ├── stores/                   # Zustand durum yonetimi (12 STORE)
│   │   ├── authStore.ts          # Kimlik dogrulama durumu
│   │   ├── planStore.ts          # Plan listesi ve islemleri
│   │   ├── scenarioStore.ts      # Senaryo durumu
│   │   ├── favoriteStore.ts      # Favori durumu
│   │   ├── coOrganizerStore.ts   # Organizator durumu
│   │   ├── gamificationStore.ts  # XP/seviye/rozet durumu
│   │   ├── settingsStore.ts      # Uygulama ayarlari
│   │   ├── communityStore.ts     # Topluluk hikayeleri
│   │   ├── guestStore.ts         # Misafir yonetimi (plan bazli)
│   │   ├── vendorStore.ts        # Tedarikci arama/filtreleme
│   │   ├── timelineStore.ts      # Zaman cizelgesi (plan bazli)
│   │   ├── musicStore.ts         # Playlist yonetimi
│   │   ├── giftStore.ts          # Hediye yonetimi
│   │   └── selectors.ts          # Ortak selectorler
│   │
│   ├── constants/
│   │   ├── theme.ts              # APPLE TASARIM SISTEMI (asagida detay)
│   │   ├── categories.ts         # Surpriz kategorileri
│   │   ├── config.ts             # Uygulama konfigurasyonu
│   │   └── defaults.ts           # Varsayilan degerler
│   │
│   ├── contexts/
│   │   ├── ThemeContext.tsx       # Karanlik/aydinlik mod
│   │   └── ToastContext.tsx       # Bildirim toast
│   │
│   ├── hooks/
│   │   ├── useCountdown.ts       # Geri sayim hook'u
│   │   ├── useLanguage.ts        # Dil secimi
│   │   ├── useReducedMotion.ts   # Erisebilirlik
│   │   ├── useThemeColors.ts     # Tema renkleri
│   │   └── useToast.ts           # Toast bildirimi
│   │
│   ├── i18n/
│   │   ├── index.ts              # i18next yapilandirmasi
│   │   ├── tr/common.json        # Turkce ceviriler (18+ bolum)
│   │   └── en/common.json        # Ingilizce ceviriler (18+ bolum)
│   │
│   ├── types/
│   │   ├── database.ts           # Supabase veritabani tipleri
│   │   ├── coOrganizer.ts        # Organizator tipleri
│   │   └── react-native-purchases.d.ts
│   │
│   ├── utils/                    # Yardimci araclar
│   │   ├── animations.ts        # Animasyon sistemi (spring/timing presets, reveal, float, pulse)
│   │   ├── accessibility.ts      # Erisebilirlik (a11y helpers, touch targets, focus mgmt)
│   │   ├── cache.ts              # AsyncStorage onbellek
│   │   ├── calendar.ts           # Takvim entegrasyonu
│   │   ├── contacts.ts           # Rehber erisimi
│   │   ├── dynamicType.ts        # Dinamik yazi boyutu
│   │   ├── errorReporting.ts     # Hata raporlama
│   │   ├── formatters.ts         # Tarih/para formatlama
│   │   ├── haptics.ts            # Dokunsal geri bildirim
│   │   ├── notificationStore.ts  # Bildirim depolama
│   │   ├── notifications.ts      # Push bildirimler
│   │   ├── searchHistory.ts      # Arama gecmisi
│   │   ├── sharing.ts            # Paylasim
│   │   ├── spotlight.ts          # iOS Spotlight arama
│   │   ├── stealthMode.ts        # Gizli mod
│   │   └── validation.ts         # Form dogrulama
│   │
│   └── data/
│       └── mockScenarios.ts      # Ornek senaryolar
│
├── supabase/
│   ├── functions/                # Edge Functions (AI destekli)
│   │   ├── ai-chat/index.ts           # Genel AI sohbet
│   │   ├── ai-recommend/index.ts      # AI surpriz onerisi
│   │   ├── ai-customize-plan/index.ts # Plan kisisellestirme
│   │   ├── ai-timeline/index.ts       # Zaman cizelgesi olusturma
│   │   ├── ai-gifts/index.ts          # Hediye onerisi
│   │   ├── ai-backup/index.ts         # Plan B olusturma
│   │   ├── ai-music/index.ts          # Sarki onerisi
│   │   └── delete-account/index.ts    # Hesap silme
│   │
│   └── migrations/               # Veritabani migrasyonlari (13 dosya)
│       ├── 001_initial_schema.sql
│       ├── 002_seed_categories.sql
│       ├── 003_seed_scenarios.sql
│       ├── 004_db_functions.sql
│       ├── 005_seed_expanded_scenarios.sql
│       ├── 006_co_organizer_and_gamification.sql
│       ├── 007_account_deletion.sql
│       ├── 008_favorites.sql
│       ├── 009_fulltext_search.sql
│       ├── 010_ai_conversations.sql
│       ├── 011_world_class_features.sql    # 22 yeni tablo
│       ├── 012_milestone_metrics.sql
│       └── 013_post_surprise.sql
│
├── __tests__/                    # Test dosyalari
│   ├── setup.ts
│   ├── services/subscription.test.ts
│   ├── stores/gamificationStore.test.ts
│   ├── stores/settingsStore.test.ts
│   └── utils/cache.test.ts
│
├── assets/
│   ├── animations/               # Lottie animasyonlari
│   ├── fonts/                    # Ozel fontlar
│   └── images/                   # Gorseller
│
├── components/                   # Expo default bilesenleri (kullanilmiyor)
├── constants/Colors.ts           # Eski renk dosyasi (tema theme.ts'e tasindi)
└── package.json
```

---

## TASARIM SISTEMI (Apple-Inspired)

### Renk Paleti

| Rol | Light Mode | Dark Mode | Kullanim |
|-----|-----------|-----------|----------|
| Primary | `#FF6B8A` (Rose Coral) | `#FF8FA8` | Ana marka rengi, butonlar, linkler |
| Primary Light | `#FF9EB5` | `#FFB3C6` | Hover/aktif durumlar |
| Primary Dark | `#E8456A` | `#FF6B8A` | Vurgulu butonlar |
| Secondary | `#FFAA5C` (Amber Gold) | `#FFBB7A` | Ikincil aksiyonlar |
| Accent | `#A78BFA` (Soft Violet) | `#C4B5FD` | Vurgu elemanlari |
| Success | `#34C759` | `#30D158` | Basari durumu |
| Warning | `#FF9F0A` | `#FFD60A` | Uyari durumu |
| Error | `#FF3B30` | `#FF453A` | Hata durumu |
| Info | `#5AC8FA` | `#64D2FF` | Bilgi durumu |
| Background | `#F9F8F6` (Warm Off-White) | `#000000` (True Black OLED) | Sayfa arkaplani |
| Surface | `#FFFFFF` | `#2C2C2E` | Kart/modal arkaplani |
| Text | `#1C1C1E` | `#F5F5F7` | Ana metin |
| Text Secondary | `#8E8E93` | `#98989D` | Ikincil metin |
| Border | `#E5E5EA` | `#38383A` | Kenarlari |

### Feature Hub Renkleri (Plan Detay)

| Ozellik | Renk | Ikon |
|---------|------|------|
| Hava Durumu | `#5AC8FA` | weather-partly-cloudy |
| Zaman Cizelgesi | `#A78BFA` | timeline-clock |
| Ilham Panosu | `#FF6B8A` | image-multiple |
| Misafirler | `#34C759` | account-multiple |
| Hediyeler | `#FFAA5C` | gift |
| Playlist | `#5EEAD4` | music-note |
| Plan B | `#FF3B30` | shield-check |
| Zaman Kapsulu | `#AF8E6F` | treasure-chest |
| Gizli Sohbet | `#8E8E93` | lock |
| Hizmet Bul | `#FF9F0A` | store |

### Tipografi (SF Pro Inspired)

| Stil | Boyut | Agirlik | Satir Yuksekligi | Letter Spacing |
|------|-------|---------|------------------|----------------|
| h1 | 34px | Bold (700) | 41 | 0.37 |
| h2 | 28px | Bold (700) | 34 | 0.36 |
| h3 | 22px | SemiBold (600) | 28 | 0.35 |
| h4 | 20px | SemiBold (600) | 25 | 0.38 |
| body | 17px | Regular (400) | 22 | -0.41 |
| bodySmall | 15px | Regular (400) | 20 | -0.24 |
| caption | 13px | Regular (400) | 18 | -0.08 |
| button | 17px | SemiBold (600) | 22 | -0.41 |

### Spacing ve Border Radius

| Spacing | Deger | | Border Radius | Deger |
|---------|-------|-|---------------|-------|
| xs | 4px | | sm | 8px |
| sm | 8px | | md | 14px |
| md | 16px | | lg | 20px |
| lg | 24px | | xl | 28px |
| xl | 32px | | full | 9999px |
| xxl | 48px | | | |

### Golge Sistemi (Minimalist)

| Seviye | Opacity | Radius | Elevation |
|--------|---------|--------|-----------|
| sm | 0.04 | 3px | 1 |
| md | 0.08 | 8px | 3 |
| lg | 0.10 | 16px | 6 |

### Tasarim Kurallari
- Border kalinligi: `0.5px` (Apple ince cizgi stili)
- Border opacity: `40` hex suffix (ornek: `colors.border + '40'`)
- Ikon arkaplan opacity: `12` veya `14` hex suffix
- iOS Tab Bar: `expo-blur` ile glassmorphism efekti
- Dark mode: True black (#000000) OLED uyumlu
- Kartlar: `surface` renk + `0.5px border` + `Shadows.sm`

---

## OZELLIK LISTESI (20 Ozellik)

### 1. Hava Durumu Tahmini
- **API:** Open-Meteo (ucretsiz, API key gerekmez)
- **Servis:** `src/services/weather.ts`
- **Bilesen:** `WeatherWidget.tsx` (gradient arkaplan, detay satirlari)
- **Ekran:** `app/plan/[id]/weather.tsx` (7 gunluk tahmin)
- **Veri:** Sicaklik, nem, ruzgar, UV, yagis olasiligi

### 2. Akilli Zaman Cizelgesi
- **AI:** `supabase/functions/ai-timeline/index.ts` (GPT-4o-mini)
- **Servis:** `src/services/timeline.ts`
- **Store:** `src/stores/timelineStore.ts`
- **Bilesen:** `SmartTimeline.tsx` (dikey timeline, checkbox, oncelik)
- **Ekran:** `app/plan/[id]/timeline.tsx`

### 3. Ilham Panosu (Mood Board)
- **Bilesen:** `MoodBoard.tsx` (2 sutunlu masonry grid)
- **Ekran:** `app/plan/[id]/moodboard.tsx`
- **Ozellikler:** Kamera/galeri ekleme, uzun basma silme, tam ekran goruntuleme

### 4. Misafir RSVP Sistemi
- **Servis:** `src/services/guestRsvp.ts`
- **Store:** `src/stores/guestStore.ts`
- **Bilesen:** `GuestRsvpCard.tsx` (durum ikonlari, istatistik cubugu)
- **Ekran:** `app/plan/[id]/guests.tsx`
- **Durumlar:** accepted, declined, maybe, pending

### 5. Hediye Onerileri
- **AI:** `supabase/functions/ai-gifts/index.ts`
- **Servis:** `src/services/gifts.ts`
- **Store:** `src/stores/giftStore.ts`
- **Bilesen:** `GiftSuggestions.tsx`
- **Ekran:** `app/plan/[id]/gifts.tsx`

### 6. Plan B (Yedek Plan)
- **AI:** `supabase/functions/ai-backup/index.ts`
- **Bilesen:** `BackupPlan.tsx` (tetikleyici kosullar, karsilastirma)
- **Ekran:** `app/plan/[id]/backup.tsx`

### 7. Muzik Playlist
- **AI:** `supabase/functions/ai-music/index.ts`
- **Servis:** `src/services/music.ts`
- **Store:** `src/stores/musicStore.ts`
- **Bilesen:** `MusicPlaylist.tsx` (mood secimleri, surukleme)
- **Ekran:** `app/plan/[id]/music.tsx`
- **Modlar:** Romantic, Fun, Energetic, Chill, Emotional

### 8. Topluluk Hikayeleri
- **Servis:** `src/services/community.ts`
- **Store:** `src/stores/communityStore.ts`
- **Bilesenler:** `StoryCard.tsx`, `StoryFeed.tsx`
- **Ekran:** `app/(tabs)/community.tsx`
- **Ozellikler:** Begeni, yorum, paylas, anonim mod, trend

### 9. Tedarikci Rehberi
- **Servis:** `src/services/vendors.ts`
- **Store:** `src/stores/vendorStore.ts`
- **Bilesen:** `VendorCard.tsx` (10 vendor tipi)
- **Ekran:** `app/vendors.tsx`
- **Tipler:** cicekci, restoran, fotografci, pastane, dekorasyon, muzisyen, mekan, kuyumcu, organizator, diger

### 10. Sesli Notlar
- **Servis:** `src/services/voiceNotes.ts` (Supabase Storage)
- **Bilesen:** `VoiceNote.tsx` (nabiz kayit butonu, dalga formu)
- **Ozellikler:** Kayit, oynatma, silme, transkripsiyon (edge function)

### 11. Gizli Mesajlasma
- **Servis:** `src/services/secretMessages.ts`
- **Bilesen:** `SecretMessage.tsx` (sohbet baloncuklari)
- **Ekran:** `app/plan/[id]/secret-chat.tsx`
- **Ozellikler:** Sadece co-organizer'lar gorebilir, sifreleme alanlari

### 12. Zaman Kapsulu
- **Servis:** `src/services/timeCapsule.ts`
- **Bilesen:** `TimeCapsule.tsx`
- **Ekran:** `app/plan/[id]/capsule.tsx`
- **3 Durum:** collecting (toplama) → sealed (muhurlu) → opened (acik)
- **Ozellikler:** Foto/metin/ses anilari, geri sayim, paylasim

### 13. QR Kod Davetiye
- **Bilesen:** `QRInvite.tsx` (deterministik grid QR gorunumu)
- **Ozellikler:** Paylas butonu, link kopyalama, davet kodu

### 14. Konfeti Kutlama
- **Bilesen:** `ConfettiCelebration.tsx`
- **Ozellikler:** 60 parcacik (daire, kare, serit), Reanimated animasyon, 3sn otomatik kapanma

### 15. Emoji Tepkileri
- **Bilesen:** `EmojiReactions.tsx`
- **Ozellikler:** 6 emoji, sayi rozeti, animasyonlu olcek efekti

### 16. Butce Analitigi
- **Bilesen:** `BudgetAnalytics.tsx`
- **Ozellikler:** SVG dairesel ilerleme, kategori dagilimi, %80+ uyari

### 17. Surpriz Karsilastirma
- **Bilesen:** `SurpriseComparison.tsx`
- **Ozellikler:** 2 sutunlu karsilastirma, yesil/kirmizi deger vurgulama, swipe

### 18. Tekrarlayan Etkinlikler
- **Servis:** `src/services/recurringEvents.ts`
- **Bilesen:** `RecurringEventBadge.tsx` (nabiz animasyonu)

### 19. Oyunlastirma Sistemi
- **Servis:** `src/services/gamification.ts`
- **Store:** `src/stores/gamificationStore.ts`
- **Bilesenler:** `BadgeCard.tsx`, `LevelProgress.tsx`, `MilestoneDisplay.tsx`, `StreakDisplay.tsx`

### 20. AI Asistan
- **Edge Functions:** ai-chat, ai-recommend, ai-customize-plan, ai-timeline, ai-gifts, ai-backup, ai-music
- **Servisler:** ai.ts, aiContext.ts, aiConversations.ts
- **Model:** GPT-4o-mini (OpenAI)
- **Kredi Sistemi:** credits.ts

---

## VERITABANI SEMASI

### Migration 001-010 (Temel)
- `profiles`, `categories`, `scenarios`, `plans`, `plan_checklists`
- `plan_expenses`, `plan_photos`, `plan_invites`
- `scenario_reviews`, `favorites`, `important_dates`
- `user_gamification`, `badges`, `user_badges`, `milestones`
- `co_organizers`, `co_organizer_tasks`
- `ai_conversations`, `ai_messages`, `ai_interactions`

### Migration 011 (World Class Features - 22 Yeni Tablo)
- `weather_cache` - Hava durumu onbellegi
- `smart_timeline_items` - Zaman cizelgesi (self-referencing depends_on)
- `mood_boards`, `mood_board_items` - Ilham panosu
- `guest_invitations` - Misafir RSVP (token tabanli)
- `recurring_events` - Tekrarlayan etkinlikler
- `gift_suggestions` - Hediye onerileri (AI, satin alma takibi)
- `backup_plans` - Yedek planlar (tetikleyici kosullar)
- `music_playlists`, `playlist_items` - Muzik listeleri
- `community_stories`, `story_likes`, `story_comments` - Topluluk (thread destekli)
- `vendors`, `vendor_reviews`, `plan_vendor_bookings` - Tedarikci
- `voice_notes` - Sesli notlar (transkripsiyon destekli)
- `secret_messages` - Gizli mesajlar (sifreleme, otomatik imha)
- `emoji_reactions` - Emoji tepkileri (polimorfik hedef)
- `time_capsules`, `time_capsule_items` - Zaman kapsulu
- `smart_notifications` - Akilli bildirimler (zamanlama, gruplama, oncelik)

### Enum Tipleri
- `rsvp_status`: invited, accepted, declined, maybe
- `vendor_type`: florist, restaurant, photographer, bakery, decorator, musician, venue, jeweler, organizer, other
- `story_status`: draft, published, reported, hidden
- `recurrence_type`: daily, weekly, monthly, yearly
- `notification_channel`: push, email, sms, in_app
- `timeline_item_status`: pending, in_progress, completed, skipped

### Guvenlik
- Tum tablolarda RLS (Row Level Security) politikalari
- `auth.uid()` tabanli erisim kontrolu
- Co-organizer erisim kaliplari (migration 006 ile uyumlu)

---

## BAGIMLILKLAR (package.json)

### Ana Kutuphaneler
| Paket | Versiyon | Kullanim |
|-------|---------|----------|
| expo | ~54.x.x | Uygulama cercevesi (SDK 54 — yukseltme yapma!) |
| react-native | 0.81.5 | Mobil UI |
| expo-router | ~54.x.x | Dosya tabanli yonlendirme |
| @supabase/supabase-js | ^2.99.1 | Backend/veritabani |
| zustand | ^5.0.11 | Durum yonetimi |
| react-i18next | ^16.5.8 | Coklu dil |
| react-native-reanimated | ^4.2.1 | Animasyonlar |
| expo-blur | ~55.0.9 | iOS glassmorphism |
| lottie-react-native | ^7.3.6 | Lottie animasyonlari |
| react-native-purchases | ^8.2.0 | RevenueCat abonelik |
| react-native-paper | ^5.15.0 | Material UI bilesenleri |

---

## CEVIRI BOLUMLERI (i18n)

TR ve EN dosyalarinda su bolumler var:
`common`, `auth`, `tabs`, `home`, `explore`, `plans`, `profile`, `categories`,
`dates`, `settings`, `ai`, `onboarding`, `gamification`, `subscription`,
`features`, `weather`, `timeline`, `moodboard`, `guests`, `gifts`, `backup`,
`music`, `voice_notes`, `secret_chat`, `capsule`, `vendors`, `community`,
`reactions`, `comparison`, `recurring`

---

## GELECEKTE YAPILACAKLAR

### Oncelikli
- [ ] Gercek Spotify API entegrasyonu (simdilik mock veri)
- [ ] Push bildirim yapilandirmasi (expo-notifications ayari)
- [ ] Gercek QR kod kutuphanesi entegrasyonu (react-native-qrcode-svg)
- [ ] RevenueCat urun tanimlari
- [ ] App Store / Google Play yayin hazirligi

### Orta Oncelik
- [ ] Offline mod (AsyncStorage sync)
- [ ] Widget desteği (expo-widgets)
- [ ] Deep linking yapilandirmasi
- [ ] Performans optimizasyonu (FlatList, memo, lazy loading)
- [ ] E2E testler (Detox veya Maestro)

### Dusuk Oncelik
- [ ] Web platformu uyumu
- [ ] Tablet/iPad layout optimizasyonu
- [ ] Accessibility audit (VoiceOver/TalkBack)
- [ ] Analytics entegrasyonu (Mixpanel/Amplitude)
- [ ] A/B test altyapisi

---

## CALISTIRMA KOMUTLARI

```bash
# Gelistirme
npm start                    # Expo dev server
npm run ios                  # iOS simulator
npm run android              # Android emulator
npm run web                  # Web tarayici

# Test
npm test                     # Jest testleri
npm run test:coverage        # Kapsam raporu

# Supabase
supabase start               # Yerel Supabase
supabase db push             # Migrasyonlari uygula
supabase functions serve     # Edge Functions yerel calistir
supabase functions deploy    # Edge Functions yayinla
```

---

## ONEMLI NOTLAR

1. **AI Edge Functions** OpenAI API key gerektirir: `OPENAI_API_KEY` env degiskeni
2. **Hava durumu** Open-Meteo API kullanir - ucretsiz, key gerekmez
3. **Tema** `useTheme()` hook'u ile dinamik - karanlik/aydinlik otomatik
4. **Store pattern:** Tum store'lar optimistic update + revert on failure kullanir
5. **Service pattern:** Tum servisler `getCurrentUserId()` ile auth kontrolu yapar
6. **Tab bar:** iOS'ta glassmorphism blur efekti, Android'de duz yuzey
7. **Border stili:** Apple'in 0.5px ince cizgi yaklasimiyla tutarli
8. **Dark mode:** True black (#000000) OLED ekranlar icin pil tasarrufu

---

## OTURUM 2 — UI BILESENLERI & DENEYIM KATMANI (Mart 2026)

### Yapilan Isler

| # | Ozellik | Durum | Dosya(lar) |
|---|---------|-------|------------|
| 1 | Custom Bottom Tab Bar + Center FAB | ✅ | `src/components/navigation/CustomTabBar.tsx`, `app/(tabs)/_layout.tsx` |
| 2 | Card Bilesen Sistemi (primary/secondary/compact) | ✅ | `src/components/ui/Card.tsx` (enhanced) |
| 3 | Bottom Sheet (spring gesture) | ✅ | `src/components/ui/BottomSheet.tsx` |
| 4 | Skeleton Loading (Card/ListItem/Profile/Bento) | ✅ | `src/components/ui/Skeleton.tsx` (enhanced) |
| 5 | Bento Grid Ana Sayfa | ✅ | `app/(tabs)/index.tsx` (redesigned) |
| 6 | Onboarding Animasyon Polish | ✅ | `app/onboarding.tsx` (spring dots, animated progress) |
| 7 | Empty State Tasarimlari | ✅ | `src/components/common/EmptyState.tsx` (enhanced) |
| 8 | Animasyon Sistemi | ✅ | `src/utils/animations.ts` (new) |
| 9 | Erisebilirlik (Accessibility) | ✅ | `src/utils/accessibility.ts`, `src/components/ui/Button.tsx` |

### Yeni Dosyalar
- `src/utils/animations.ts` — SpringPresets, TimingPresets, staggerDelay, pressIn/Out, surpriseReveal, float, pulse, sheet open/close
- `src/components/navigation/CustomTabBar.tsx` — iOS glassmorphism + Android solid, center FAB, spring press, active dot
- `src/components/ui/BottomSheet.tsx` — Snap points, pan gesture, backdrop, velocity threshold, Android back button

### Degisiklikler
- `app/_layout.tsx` — GestureHandlerRootView wrapper eklendi (BottomSheet icin zorunlu)
- `app/(tabs)/_layout.tsx` — CustomTabBar entegrasyonu (`tabBar` prop)
- `app/(tabs)/index.tsx` — Bento grid quick actions, skeleton loading, Card bileseni kullanimi
- `app/onboarding.tsx` — AnimatedDot + spring-based progress bar
- `src/components/ui/Card.tsx` — 3 variant, spring press, CardHeader/CardFooter, a11y
- `src/components/ui/Skeleton.tsx` — SkeletonCard, SkeletonListItem, SkeletonProfile, SkeletonBento
- `src/components/common/EmptyState.tsx` — Floating emoji, pulsating ring, compact variant, secondary action
- `src/components/ui/Button.tsx` — accessibilityRole, accessibilityState, 48dp minHeight
- `src/utils/accessibility.ts` — a11yAlert, a11yLiveRegion, ensureTouchTarget, announceDelayed, setAccessibilityFocus

---

## GUVENLIK AUDIT OZETI (Mart 2026)

### Oturum 1 — Backend & Veritabani

| Dosya | Yapilan |
|-------|---------|
| `supabase/functions/_shared/security.ts` (yeni) | requireAuth, validateInput, checkRateLimit (20/5dk), checkCredits modulu |
| 7 AI Edge Function | Tumune zorunlu JWT auth + input validation + rate limit + kredi kontrolu |
| `supabase/migrations/014_security_fixes.sql` (yeni) | 6 kritik RLS/yetki acigi kapatildi |
| `src/constants/config.ts` | Hardcoded API key'ler kaldirildi, sadece .env'den yukleme |
| `eas.json` | Env bloklari temizlendi |

**Migration 014 Detay:**
- `delete_user_account()` → auth.uid() kontrolu (privilege escalation fix)
- `add_user_xp()` → sadece kendi XP'sini degistirebilir
- `compute_unique_recipients()` → cross-user veri erisimi engellendi
- `invite_links` → eksik RLS politikalari eklendi (SELECT/INSERT/UPDATE/DELETE)
- `time_capsules` → kilitli kapsul icerik sizintisi engellendi
- `secret_messages` → suresi dolmus/imha edilmis mesaj filtresi + cleanup fonksiyonu
- `vendors` → dogrulanmamis vendor INSERT kisitlamasi

### Oturum 2 — Frontend (8 dosya + 3 paket)

**Kurulan paketler:** `tweetnacl`, `tweetnacl-util`, `expo-crypto`

| Dosya | Yapilan |
|-------|---------|
| `src/utils/crypto.ts` (yeni) | SHA-256 PIN hash, NaCl secretbox E2E sifreleme, rejection-sampling token, 5 sanitizasyon fonk. |
| `src/utils/stealthMode.ts` | Zayif djb2 hash → SHA-256 + per-device salt + timing-safe karsilastirma |
| `src/services/secretMessages.ts` | E2E sifreleme (XSalsa20-Poly1305), `enc:v1:` prefix ile geriye uyumlu |
| `src/services/guestRsvp.ts` | Modulo bias fix (rejection sampling), input sanitizasyon, `verifyRsvpToken()` |
| `src/utils/validation.ts` | sanitize re-export, `validatePin()`, `validateAndSanitizeName/Text()` |
| `src/services/timeCapsule.ts` | `Math.random()` → crypto secure token, deep link scheme `momentra://` |
| `src/services/coOrganizer.ts` | `requirePlanOwner()` guard, mesaj sanitizasyon, invite code bias fix |
| `src/services/community.ts` | Hikaye/yorum sanitizasyonu, arama query param guvenlik |

### Deploy Oncesi Manuel Adimlar
- [ ] `eas secret:create` ile Supabase URL ve key'leri EAS'e ekle
- [ ] Supabase Dashboard'dan **anon key rotate** et (git history'de expose olmus)
- [ ] `.env` ve EAS Secret'i yeni key ile guncelle
- [ ] `supabase db push` ile 014_security_fixes.sql uygula
- [ ] `supabase functions deploy` ile edge function'lari deploy et

### Kalan Dusuk Oncelikli Bosluklar
- [ ] CORS `*` → app domain restrict (edge functions)
- [ ] PIN brute-force lockout (client-side sayac)
- [ ] RSVP endpoint server-side rate limiting
