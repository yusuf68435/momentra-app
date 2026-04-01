# CLAUDE.md - Momentra Proje Rehberi

---

## 📁 Nerede Ne Var — Hızlı Harita

### Uygulama Kodu

| Konum                    | Ne var?                                                        |
| ------------------------ | -------------------------------------------------------------- |
| `app/`                   | Tüm ekranlar (Expo Router file-based)                          |
| `app/(tabs)/`            | 6 ana tab: Anasayfa, Keşfet, Planlarım, AI, Topluluk, Profil   |
| `app/(auth)/`            | Giriş / Kayıt ekranları                                        |
| `app/plan/[id]/`         | Plan detay ve 12 alt sayfa (checklist, expenses, timeline vb.) |
| `app/settings/`          | 7 ayar sayfası                                                 |
| `app/vendors.tsx`        | Tedarikçi rehberi ekranı                                       |
| `src/components/`        | 50+ yeniden kullanılabilir bileşen                             |
| `src/services/`          | Supabase API katmanı (22 servis)                               |
| `src/stores/`            | Zustand state yönetimi (13 store)                              |
| `src/constants/theme.ts` | Tasarım sistemi: renkler, tipografi, spacing                   |
| `src/i18n/`              | 17 dil çeviri dosyaları                                        |
| `supabase/migrations/`   | 13 SQL migration                                               |
| `supabase/functions/`    | 8 Edge Function (AI servisleri)                                |

### Tasarım & Prodüksiyon Dosyaları

| Konum                              | Ne var?                                                                                        |
| ---------------------------------- | ---------------------------------------------------------------------------------------------- |
| `assets/images/`                   | App ikonları: `icon.png`, `splash-icon.png`, android ikonları, `favicon.png` — hepsi 1024×1024 |
| `assets/screenshots/en/`           | App Store İngilizce ekran görüntüleri (7 adet, 1290×2796)                                      |
| `assets/screenshots/tr/`           | App Store Türkçe ekran görüntüleri (7 adet, 1290×2796)                                         |
| `assets/logos/logo94-evolved.html` | Logo tasarım sistemi — seçilen logo (#94) tüm varyantlarıyla                                   |

### Araçlar

| Konum                          | Ne var?                                            |
| ------------------------------ | -------------------------------------------------- |
| `tools/aso-screenshots.html`   | App Store ekran görüntüsü tasarımı (tarayıcıda aç) |
| `tools/capture-screenshots.js` | SS PNG'leri üret → `assets/screenshots/`           |
| `tools/gen-icons.js`           | App icon PNG'leri üret → `assets/images/`          |
| `tools/add_i18n_keys.py`       | i18n anahtar ekleme aracı                          |
| `tools/add_translations.py`    | Çeviri ekleme aracı                                |

### Konfigürasyon

| Konum             | Ne var?                                  |
| ----------------- | ---------------------------------------- |
| `app.json`        | Expo uygulama konfigürasyonu             |
| `eas.json`        | EAS Build profilleri                     |
| `.env`            | API anahtarları (Supabase URL, anon key) |
| `PROJE_DURUMU.md` | Detaylı proje durum raporu               |

---

## Proje Nedir?

Sürpriz planlama mobil uygulaması. Doğum günü, evlilik teklifi, yıldönümü gibi özel günler için sürpriz planlama, AI destekli önerileri, topluluk hikayeleri ve tedarikçi rehberi içeriyor.

## Teknoloji Yığını

- **Framework:** React Native + Expo SDK 54 (Expo Router file-based routing)
- **KRİTİK:** SDK 54 kalsın — Expo Go istemcisi SDK 54 destekliyor, SDK 55'e çıkartma
- **Dil:** TypeScript (strict mode)
- **Backend:** Supabase (PostgreSQL + Auth + Storage + Edge Functions)
- **State:** Zustand v5
- **AI:** OpenAI GPT-4o-mini (Supabase Edge Functions üzerinden)
- **i18n:** react-i18next (17 dil: TR, EN, DE, FR, ES, IT, PT, RU, AR, JA, KO, ZH, HI, NL, PL, SV, UK)
- **Animasyon:** react-native-reanimated v4
- **Abonelik:** RevenueCat (react-native-purchases)
- **Tasarım:** Apple-inspired custom design system (SF Pro tipografi, glassmorphism)

## Çalıştırma

```bash
npm start          # Expo dev server
npm run ios        # iOS simulator
npm run android    # Android emulator
npm test           # Jest testleri
```

## Ortam Değişkenleri (.env)

```
EXPO_PUBLIC_SUPABASE_URL=https://xxx.supabase.co
EXPO_PUBLIC_SUPABASE_ANON_KEY=eyJ...
# Edge Function secret: OPENAI_API_KEY (supabase secrets set ile ayarla)
# Opsiyonel: EXPO_PUBLIC_REVENUECAT_IOS_KEY, EXPO_PUBLIC_REVENUECAT_ANDROID_KEY
```

## Klasör Yapısı

```
app/                    # Sayfalar (Expo Router file-based)
  (auth)/               # Login, register
  (tabs)/               # 6 tab: home, explore, plans, ai, community, profile
  plan/[id]/            # Plan detay + 12 alt sayfa (weather, timeline, gifts, music, vb.)
  settings/             # 7 ayar sayfası
  vendors.tsx           # Tedarikçi rehberi
src/
  components/           # 50+ bileşen
    ui/                 # Button, Card (3 variant), Input, Badge, Skeleton (5 varyant), BottomSheet
    navigation/         # CustomTabBar (center FAB + glassmorphism)
    common/             # EmptyState (animated), LoadingScreen, Toast, vb.
    plans/              # 20+ plan bileşeni
    community/, vendors/, coorganizer/, gamification/, reviews/, scenarios/
  services/             # 22 servis dosyası (Supabase API katmanı)
  stores/               # 13 Zustand store
  constants/theme.ts    # Tasarım sistemi (renk, tipografi, spacing, shadow, springs)
  contexts/             # ThemeContext, ToastContext
  hooks/                # useCountdown, useLanguage, useThemeColors, vb.
  i18n/                 # tr/common.json, en/common.json (30+ bölüm)
  utils/                # animations.ts, accessibility.ts, crypto.ts, haptics.ts, vb.
  types/                # TypeScript tip tanımları
supabase/
  migrations/           # 13 SQL migration (001-013)
  functions/            # 8 Edge Function (ai-chat, ai-timeline, ai-gifts, vb.)
```

## Tasarım Sistemi

- **Ana renk:** `#FF6B8A` (Rose Coral) — light, `#FF8FA8` — dark
- **İkincil:** `#FFAA5C` (Amber Gold), Accent: `#A78BFA` (Violet)
- **Arkaplan:** `#F9F8F6` light, `#000000` dark (OLED true black)
- **Yüzey:** `#FFFFFF` light, `#2C2C2E` dark
- **Border:** 0.5px kalınlık, `colors.border + '40'` opacity pattern
- **Kartlar:** surface renk + 0.5px border + Shadows.sm
- **Tab bar:** CustomTabBar — iOS glassmorphism (expo-blur), Android solid surface, center FAB
- **Tipografi:** SF Pro inspired — body 17px/-0.41 tracking, h1 34px/700
- **Animasyon presets:** `src/utils/animations.ts` — SpringPresets (standard/bouncy/gentle/snappy/sheet/fab/reveal), TimingPresets (fast/normal/slow/emphasis)

## Kod Kalıpları (Patterns)

### Yeni sayfa oluşturma

```tsx
// app/yeni-sayfa.tsx
import { useTheme } from "../src/contexts/ThemeContext";
import {
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../src/constants/theme";
export default function YeniSayfa() {
  const { colors, isDark } = useTheme();
  const { t } = useTranslation();
  // ... createStyles(colors) pattern ile dinamik stiller
}
```

### Yeni servis oluşturma

```ts
// src/services/yeniServis.ts
import { supabase } from "./supabase";
import { getCurrentUserId } from "./helpers";
// async fonksiyonlar, try/catch, Supabase query'leri
```

### Yeni store oluşturma

```ts
// src/stores/yeniStore.ts
import { create } from "zustand";
// interface State + Actions, optimistic update + revert on failure
```

### Yeni bileşen oluşturma

```tsx
// src/components/plans/YeniBilesen.tsx
import {
  Colors,
  Spacing,
  Typography,
  BorderRadius,
  Shadows,
} from "../../constants/theme";
import { Card } from "../ui/Card";
import { Icon } from "../ui/Icon";
// StyleSheet.create ile stiller, useTranslation ile çeviri
```

### İkon kullanımı (SVG)

```tsx
import { Icon } from "../ui/Icon";
import type { IconName } from "../../constants/icons";

// Statik ikon:
<Icon name="calendar" size={24} color={colors.primary} />;

// Dinamik ikon adı:
const iconName: IconName = condition ? "check" : "close";
<Icon name={iconName} size={20} color={colors.text} />;

// Yeni ikon ekleme: src/constants/icons.ts dosyasına SVG path ekle
```

## Veritabanı (13 Migration)

- **001-010:** Temel şema (profiles, categories, scenarios, plans, checklists, expenses, photos, reviews, favorites, ai_conversations, co_organizers, gamification)
- **011:** 22 yeni tablo (weather_cache, smart_timeline_items, mood_boards, guest_invitations, gift_suggestions, backup_plans, music_playlists, community_stories, vendors, voice_notes, secret_messages, emoji_reactions, time_capsules, smart_notifications)
- **012-013:** Milestone metrics, post-surprise features
- **Güvenlik:** Tüm tablolarda RLS (Row Level Security), auth.uid() tabanlı

## Edge Functions (AI)

| Function          | Görevi                   | Model       |
| ----------------- | ------------------------ | ----------- |
| ai-chat           | Genel sürpriz sohbeti    | GPT-4o-mini |
| ai-recommend      | Sürpriz önerisi          | GPT-4o-mini |
| ai-customize-plan | Plan kişiselleştirme     | GPT-4o-mini |
| ai-timeline       | Hazırlık zaman çizelgesi | GPT-4o-mini |
| ai-gifts          | Hediye önerileri         | GPT-4o-mini |
| ai-backup         | Plan B oluşturma         | GPT-4o-mini |
| ai-music          | Playlist önerileri       | GPT-4o-mini |
| delete-account    | Hesap silme (GDPR)       | —           |

## 20 Ana Özellik

1. **Geri Sayım** — CountdownTimer bileşeni
2. **AI Asistan** — 7 edge function, kredi sistemi
3. **Co-Organizer** — Ortak planlama, görev atama
4. **Oyunlaştırma** — XP, rozet, seviye, streak
5. **Hava Durumu** — Open-Meteo API (ücretsiz, key gerekmez)
6. **Akıllı Zaman Çizelgesi** — AI destekli, öncelik, bağımlılık
7. **İlham Panosu** — Masonry grid, kamera/galeri
8. **Misafir RSVP** — Token bazlı davet, 4 durum
9. **Hediye Önerileri** — AI destekli, satın alma takibi
10. **Plan B** — Tetikleyici koşullar, AI yedek plan
11. **Müzik Playlist** — 5 mod (romantic/fun/energetic/chill/emotional)
12. **Topluluk** — Hikaye paylaşımı, beğeni, yorum, trend
13. **Tedarikçi Rehberi** — 10 kategori, puan, favoriler
14. **Sesli Notlar** — Kayıt, oynatma, transkripsiyon
15. **Gizli Mesajlaşma** — Co-organizer arası şifreli
16. **Zaman Kapsülü** — toplama → mühürlü → açık
17. **QR Davetiye** — Grid QR, paylaş/kopyala
18. **Konfeti** — 60 parçacık Reanimated animasyonu
19. **Emoji Tepkileri** — 6 emoji, animasyonlu
20. **Bütçe Analitiği** — SVG dairesel grafik, kategori dağılımı

## UI Bileşen Sistemi (Oturum 2)

### Card kullanımı

```tsx
import { Card, CardHeader, CardFooter } from "../src/components/ui/Card";
// variant: 'primary' (tam), 'secondary' (orta), 'compact' (liste)
// Spring press animasyonu dahil, noAnimation ile kapatılabilir
<Card variant="secondary" onPress={handlePress} accessibilityLabel="...">
  <CardHeader title="Başlık" subtitle="Alt başlık" icon={<Icon />} />
  {/* içerik */}
  <CardFooter>{/* alt bilgi */}</CardFooter>
</Card>;
```

### BottomSheet kullanımı

```tsx
import { BottomSheet } from "../src/components/ui/BottomSheet";
// GestureHandlerRootView root layout'ta ZORUNLU
<BottomSheet
  visible={show}
  onClose={() => setShow(false)}
  title="Başlık"
  snapPoints={["50%", "90%"]}
>
  {/* içerik */}
</BottomSheet>;
```

### Animasyon kullanımı

```tsx
import {
  SpringPresets,
  pressIn,
  pressOut,
  staggerDelay,
  surpriseRevealScale,
} from "../src/utils/animations";
// Press animasyonu: pressIn(scale) / pressOut(scale) — scale SharedValue
// Stagger: staggerDelay(index, 50, 400)
// Reveal: surpriseRevealScale(scale) + surpriseRevealRotation(rot) + surpriseRevealOpacity(op)
```

### Skeleton loading

```tsx
import {
  Skeleton,
  SkeletonCard,
  SkeletonListItem,
  SkeletonProfile,
  SkeletonBento,
} from "../src/components/ui/Skeleton";
// Her biri farklı layout için hazır skeleton
```

## Önemli Kurallar

- `useTheme()` hook'u ile dinamik renk — ASLA hardcoded renk kullanma (Colors.xxx yerine colors.xxx)
- Store'larda optimistic update + catch'te revert pattern kullan
- Servislerde her zaman `getCurrentUserId()` ile auth kontrolü yap
- Çevirileri `useTranslation()` ile al, hardcoded Türkçe metin yazma
- Yeni tablo eklersen RLS politikası ZORUNLU
- Edge Function'larda CORS header ve OPTIONS preflight zorunlu
- iOS tab bar: CustomTabBar glassmorphism (expo-blur), Android: solid surface
- Border: 0.5px, opacity suffix: '40' (border), '12'/'14' (ikon bg)
- Animasyonlarda `SpringPresets` ve `TimingPresets` kullan (`src/utils/animations.ts`)
- Erişebilirlik: `a11yButton`, `a11yTab`, `ensureTouchTarget` helper'larını kullan (`src/utils/accessibility.ts`)
- Root layout'ta `GestureHandlerRootView` wrapper ZORUNLU (BottomSheet gesture için)
- **İkonlar ZORUNLU SVG formatında olmalı** — `@expo/vector-icons` veya `MaterialCommunityIcons` KULLANMA. Bunun yerine `<Icon name="xxx" />` bileşenini kullan (`src/components/ui/Icon.tsx`). Yeni ikon gerekirse `src/constants/icons.ts` dosyasına SVG path ekle. Tüm ikonlar 24x24 viewBox ile tanımlanır.
- **Çoklu dil desteği (17 dil) ZORUNLU** — Yazdığın ve ürettiğin her metin (senaryo açıklamaları, UI metinleri, bildirim mesajları, hata mesajları, veritabanı içerikleri) 17 dilde olmalı: Türkçe (TR), İngilizce (EN), Almanca (DE), Fransızca (FR), İspanyolca (ES), İtalyanca (IT), Portekizce (PT), Rusça (RU), Arapça (AR), Japonca (JA), Korece (KO), Çince (ZH), Hintçe (HI), Hollandaca (NL), Lehçe (PL), İsveççe (SV), Ukraynaca (UK). i18n dosyaları: `src/i18n/{lang}/common.json`. DB senaryolarında `title_{lang}`, `description_{lang}`, `short_desc_{lang}` kolonları kullanılır.
- **Büyük işleri paralel agent'lara böl** — Yapılacak iş boyutu büyükse (10+ dosya değişikliği, çoklu bağımsız görev), işi en uygun sayıda paralel agent'a böl ve öyle çalış. Bağımsız görevleri aynı anda yürüt, bağımlı görevleri sırayla çalıştır.

## Değişiklik Sonrası Güvenlik & Uyumluluk Kontrolü (ZORUNLU)

Her kod değişikliğinden sonra aşağıdaki kontrol listesini uygula. Herhangi bir madde başarısız olursa düzelt, sonra devam et.

### 1. Güvenlik Kontrolleri

- **Hardcoded secret kontrolü:** Değişiklikte API key, token, şifre, Supabase URL/key gibi hassas veri var mı? Varsa `.env`'e taşı, fallback olarak bile bırakma.
- **SQL Injection:** Supabase query'lerinde kullanıcı girdisi doğrudan `.or()`, `.filter()`, `.textSearch()` içine konuyor mu? `sanitizeQueryParam()` ile temizle.
- **XSS:** Kullanıcı girdisi (isim, yorum, mesaj) render edilmeden önce `sanitizeInput()` veya `sanitizeDisplayName()` ile temizleniyor mu?
- **Auth kontrolü:** Yeni servis fonksiyonu eklendiyse `getCurrentUserId()` ile kimlik doğrulaması yapılıyor mu?
- **RLS:** Yeni Supabase tablosu eklendiyse RLS politikası var mı? `auth.uid()` bazlı mı?
- **SECURITY DEFINER:** Yeni DB fonksiyonu eklendiyse `auth.uid()` kontrolü var mı? Fonksiyon doğrudan çağrılabilir mi yoksa `REVOKE` gerekiyor mu?
- **Şifreleme:** Hassas kullanıcı verisi (PIN, mesaj içeriği) düz metin olarak saklanıyor mu? `crypto.ts` fonksiyonlarını kullan.
- **Token üretimi:** `Math.random()` kullanılıyor mu? `generateSecureToken()` veya `crypto.getRandomValues()` kullan.

### 2. Uyumluluk Kontrolleri

- **SDK 54 uyumu:** Eklenen paket Expo SDK 54 ile uyumlu mu? `npx expo install <paket>` ile kur, npm install ile değil.
- **Expo Go uyumu:** Eklenen paket native modül gerektiriyor mu? Expo Go'da çalışmayan native modüller (ör. expo-crypto AES, expo-secure-store) kullanılıyorsa Expo Go'da crash yapar — pure JS alternatifi kullan veya lazy-load yap.
- **Import zinciri:** Yeni eklenen import, uygulamanın başlangıcında yüklenen bir dosyadan mı çağrılıyor? (ör. `crypto.ts` → `validation.ts` → `login.tsx` zinciri tüm uygulamayı çökertir). Native modül gerektiren importlar lazy olmalı.
- **Mevcut fonksiyonlar:** Değiştirilen fonksiyonun imzası (parametre sayısı/tipi, dönüş tipi) değişti mi? Tüm çağrı noktalarını (`Grep` ile) kontrol et.
- **Circular dependency:** Yeni import circular dependency oluşturuyor mu?

### 3. Yan Etki Kontrolleri

- **Başka dosyaları etkiler mi:** Değiştirilen/silinen export'u kullanan başka dosya var mı? (`Grep` ile kontrol et)
- **Migration sırası:** Yeni SQL migration önceki migration'lara bağımlı mı? Sıra numarası doğru mu?
- **Geriye uyumluluk:** DB şeması değiştiyse mevcut veriler etkilenir mi? Eski kayıtlar yeni formata uyumlu mu?

## Build ve Yayın

```bash
# EAS Build
eas build --platform ios --profile production
eas build --platform android --profile production
# EAS Submit
eas submit --platform ios
eas submit --platform android
# Supabase
supabase db push                    # Migrasyonları uygula
supabase functions deploy           # Tüm edge function'ları yayınla
supabase secrets set OPENAI_API_KEY=sk-...
```

## App Bilgileri

- **İsim:** Momentra
- **Slug:** momentra
- **Bundle ID:** com.momentra.app
- **Scheme:** momentra (deep linking)
- **Min Expo CLI:** >= 5.0.0
- **Orientation:** portrait only

## Hesap Bilgileri

> Hassas bilgiler `.env` dosyasında ve `eas.json`'da saklanır. Buraya yazılmaz.

## Yapılacaklar Listesi

### Öncelikli

- [ ] Gerçek Spotify API entegrasyonu (şimdilik mock veri)
- [ ] Push bildirim yapılandırması (expo-notifications ayarı)
- [ ] Gerçek QR kod kütüphanesi entegrasyonu (react-native-qrcode-svg)
- [ ] RevenueCat ürün tanımları
- [ ] App Store / Google Play yayın hazırlığı

### Orta Öncelik

- [ ] Offline mod (AsyncStorage sync)
- [ ] Widget desteği (expo-widgets)
- [ ] Deep linking yapılandırması
- [ ] Performans optimizasyonu (FlatList, memo, lazy loading)
- [ ] E2E testler (Detox veya Maestro)

### Düşük Öncelik

- [ ] Web platformu uyumu
- [ ] Tablet/iPad layout optimizasyonu
- [ ] Accessibility audit (VoiceOver/TalkBack)
- [ ] Analytics entegrasyonu (Mixpanel/Amplitude)
- [ ] A/B test altyapısı
