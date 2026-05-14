# App Store Submission Checklist — Momentra v1.0

> **Scope:** iOS only, fully free (no IAP). Android + RevenueCat deferred to v1.1+.
> **Tahmini hands-on süre:** ~2 saat (Apple review dahil değil — ~24-48 saat ek)

---

## ✅ Code Ready (Done)

- [x] TypeScript strict, 0 errors
- [x] 279/279 tests passing
- [x] expo-doctor 17/17 checks passed
- [x] Sentry wired (DSN env-driven, no-ops in dev)
- [x] `supportsTablet: false` → iPad screenshots not required
- [x] `ITSAppUsesNonExemptEncryption: true` with exemption justification
- [x] Privacy manifests configured (4 API categories)
- [x] All Info.plist permission strings present (8 entries)
- [x] Associated Domains configured for momentra.app
- [x] **Paywall/IAP disabled for v1.0** — all features free
- [x] AI credits unlimited for v1.0
- [x] Screenshots TR + EN ready (1290×2796, 7 each)

---

## 📋 Faz 1: Web (Domain + Privacy/Terms Hosting) — ~20 dk

- [ ] Domain `momentra.app` satın al (Namecheap/Porkbun/Cloudflare ~$14/yr)
- [ ] DNS'i Vercel nameserver'a yönlendir
- [ ] Vercel'e `public/` deploy:
  ```bash
  npm i -g vercel
  vercel login
  cd C:\Users\yusuf\Desktop\Momentra\momentra-master\momentra-master
  vercel --prod public/
  ```
- [ ] Vercel Dashboard → Settings → Domains → `momentra.app` bağla
- [ ] Aşağıdaki URL'leri test et:
  - https://momentra.app/privacy.html ✅
  - https://momentra.app/terms.html ✅
  - https://momentra.app/.well-known/apple-app-site-association → JSON dönmeli, Content-Type: application/json

---

## 📋 Faz 2: Apple Configuration — ~15 dk

- [ ] **Apple Team ID al** (developer.apple.com → Membership Details)
- [ ] `public/.well-known/apple-app-site-association` dosyasında **3 yerdeki** `TEAMID` placeholder'ını gerçek değerle değiştir
- [ ] Vercel'e tekrar deploy: `vercel --prod public/`
- [ ] App Store Connect'te app record oluştur:
  - https://appstoreconnect.apple.com → Apps → +
  - Bundle ID: `com.uyart.momentra` (dropdown — yoksa developer.apple.com → Identifiers'tan önce oluştur)
  - Primary Language: Turkish
  - SKU: `momentra-001`

---

## 📋 Faz 3: Backend (Supabase) — ~10 dk

- [ ] Supabase Dashboard → Authentication → Users → Add user
  - Email: `review@momentra.com`
  - Password: `MomentraReview2026!`
  - ✅ Auto Confirm User
- [ ] (Opsiyonel) Co-organizer test'i için `review2@momentra.com` ile aynı
- [ ] SQL Editor → `supabase/SUBMISSION_DEMO_SETUP.sql` içeriğini çalıştır
- [ ] Edge functions deploy (zaten yapılmış olabilir):
  ```bash
  supabase functions deploy
  supabase secrets set OPENAI_API_KEY=sk-...
  ```

---

## 📋 Faz 4: Build & Submit — ~30 dk

- [ ] `eas login` (sadece bir kez)
- [ ] Build (~15-25 dk EAS cloud'da):
  ```bash
  cd C:\Users\yusuf\Desktop\Momentra\momentra-master\momentra-master
  eas build --platform ios --profile production
  ```
- [ ] Build başarılıysa otomatik submit:
  ```bash
  eas submit --platform ios --latest
  ```
  (`eas.json`'da App Store Connect API key zaten yapılandırılmış)
- [ ] App Store Connect'te build görünür — yeni version'a bağla

---

## 📋 Faz 5: App Store Connect Form Doldurma — ~30 dk

Sırayla `APP_STORE_METADATA.md` dosyasından kopyala-yapıştır:

### App Information

- [ ] Name: Momentra
- [ ] Subtitle TR: `Sürpriz planlayıcı & AI fikir`
- [ ] Subtitle EN: `Surprise planner & AI ideas`
- [ ] Primary Category: Lifestyle
- [ ] Secondary Category: Entertainment

### Pricing and Availability

- [ ] Price: **Free**
- [ ] Availability: All countries (veya filtrele)

### App Privacy

- [ ] "Does this app collect data?" → **Yes**
- [ ] Tabloyu doldur (Name, Email, User Content, Photos, Contacts, Audio, Location, Crash Data)
- [ ] Hiçbiri "Tracking" değil (hepsi No)

### Version Information (v1.0)

- [ ] Description (TR + EN) — metadata'dan kopyala
- [ ] Keywords (TR + EN)
- [ ] Promotional Text
- [ ] Support URL: https://momentra.app
- [ ] Marketing URL: https://momentra.app
- [ ] Copyright: © 2026 Momentra

### Build

- [ ] Build seç (Faz 4'te yüklenen)

### Screenshots

- [ ] iPhone 6.9" TR → `assets/screenshots/tr/` (7 adet)
- [ ] iPhone 6.9" EN → `assets/screenshots/en/` (7 adet)

### App Review Information

- [ ] First Name / Last Name (senin)
- [ ] Phone / Email
- [ ] Demo Account: `review@momentra.com` / `MomentraReview2026!`
- [ ] Notes: metadata'daki Review Notes bloğunu kopyala

### Export Compliance

- [ ] "Does your app use encryption?" → **Yes**
- [ ] "Qualifies for exemption?" → **Yes** (mass market, HTTPS + libsodium)

---

## 📋 Faz 6: Submit for Review — 1 dk

- [ ] App Store Connect'te "Add for Review" → "Submit to App Review"
- [ ] Apple review süresi: ~24-48 saat ortalama
- [ ] E-postanı takip et: approved / rejected bilgisi gelir

---

## 🚨 Olası Reject Sebepleri & Çözümler

| Sebep                                             | Çözüm                                                       |
| ------------------------------------------------- | ----------------------------------------------------------- |
| **Guideline 5.1.1** (Data collection w/o consent) | Privacy manifests + permission strings zaten doğru          |
| **Guideline 4.0** (Spam/quality)                  | Onboarding'i hızlı + smooth tut                             |
| **Guideline 2.1** (Crash)                         | TestFlight internal test yap                                |
| **Guideline 3.1.1** (Missing IAP)                 | ✅ v1.0'da tüm özellikler ücretsiz, IAP yok                 |
| **Guideline 5.1.2** (Account delete missing)      | ✅ `delete-account` edge function var (Profil > Hesabı Sil) |
| **Privacy URL broken**                            | Faz 1'i tam yap, deploy'u doğrula                           |

---

## 🎯 Approval Sonrası

- [ ] App Store Connect → "Release this version" (manual seçtiysen)
- [ ] Sentry → Production DSN'i `.env`'e ekle, OTA update push et
- [ ] PostHog (opsiyonel analytics) konfigüre et
- [ ] İlk hafta metrikleri: crash rate, retention, install count

---

## 📅 v1.1+ Yol Haritası

Paywall'ı tekrar aktive etmek için (kod hala yerinde, sadece bypass'lar var):

- [ ] `src/services/subscription.ts` → `isPlanAtLeast` ve `hasFeature`, `canPerformAction` orijinal logic'e dön (yorum satırlarında saklı)
- [ ] `src/services/credits.ts` → `getRemainingCredits` orijinal logic'e dön
- [ ] `app/(tabs)/profile.tsx` → "Upgrade to Pro" row'unu geri ekle
- [ ] `app/onboarding.tsx` → `setShowPaywall(true)` çağrısını geri al
- [ ] `app/settings/subscription.tsx` → eski paywall ekranını restore et (git history'den)
- [ ] `REVENUECAT_SETUP.md` rehberini takip et: ASC + Play Console + RC dashboard kurulumu
- [ ] Android (Google Play) submission ekle
