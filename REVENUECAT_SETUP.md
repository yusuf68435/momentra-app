# RevenueCat Setup — Momentra

> ⏸ **DEFERRED to v1.1+**
> v1.0 App Store sürümünde tüm özellikler ücretsiz ve IAP yok. Bu rehberi
> sonradan paywall'ı yeniden aktive ederken kullanacaksın. Mevcut kod
> RevenueCat SDK'sı zaten yüklü ve graceful fallback ile çalışıyor —
> sadece API key'ler eksik (kasıtlı). Hazır olduğunda paywall'ı geri
> getirmek için bkz: `SUBMIT_CHECKLIST.md` → "v1.1+ Yol Haritası".

> Tahmini setup süresi (v1.1'e başladığında): 30-45 dk. App Store Connect + Play Console + RevenueCat panel arası geçişler gerekir.

---

## 1️⃣ Code'da Tanımlı Entitlement'lar

`src/services/purchases.ts` aşağıdaki entitlement ID'leri kontrol ediyor:

- **`pro`** — ana premium tier (önceliğe öncelikli kontrol edilir)
- **`plus`** — alternatif/eski premium tier (geriye uyum için)

⚠️ RevenueCat dashboard'daki entitlement ID'leri **bunlarla birebir aynı** olmalı.

---

## 2️⃣ App Store Connect — IAP Tanımlama

`App Store Connect → Apps → Momentra → Monetization → In-App Purchases`

### Subscription Group Oluştur

- Group reference name: `Momentra Premium`
- Localization (TR + EN): "Momentra Premium"

### Auto-Renewable Subscription #1 — Aylık

| Alan                  | Değer                                        |
| --------------------- | -------------------------------------------- |
| Reference Name        | Momentra Premium Monthly                     |
| Product ID            | `com.uyart.momentra.premium.monthly`         |
| Subscription Group    | Momentra Premium                             |
| Subscription Duration | 1 month                                      |
| Price (TR)            | ₺59.00                                       |
| Price (US)            | $1.99                                        |
| Localizations         | TR + EN (display name + description)         |
| Free Trial            | 7 days (Introductory Offer, first-time only) |
| Review Screenshot     | 1290×2796 paywall ekranı                     |

**Display Name (TR):** Momentra Premium — Aylık
**Display Name (EN):** Momentra Premium — Monthly
**Description (TR):** Sınırsız AI asistan, sınırsız co-organizer, uçtan uca şifreli mesajlaşma. 7 gün ücretsiz deneme.
**Description (EN):** Unlimited AI assistant, unlimited co-organizers, end-to-end encrypted messaging. 7-day free trial.

### Auto-Renewable Subscription #2 — Yıllık

| Alan                  | Değer                                                               |
| --------------------- | ------------------------------------------------------------------- |
| Reference Name        | Momentra Premium Annual                                             |
| Product ID            | `com.uyart.momentra.premium.annual`                                 |
| Subscription Group    | Momentra Premium                                                    |
| Subscription Duration | 1 year                                                              |
| Price (TR)            | ₺395.00 (≈₺33/ay)                                                   |
| Price (US)            | $11.99 (≈$0.99/mo)                                                  |
| Localizations         | TR + EN                                                             |
| Free Trial            | 7 days (aynı subscription group içinde tek introductory offer alır) |
| Review Screenshot     | 1290×2796 paywall ekranı                                            |

**Display Name (TR):** Momentra Premium — Yıllık
**Display Name (EN):** Momentra Premium — Annual

---

## 3️⃣ Google Play Console — Subscription Tanımlama

`Play Console → Momentra → Monetize → Products → Subscriptions`

### Subscription Base Plan #1 — Aylık

- Subscription ID: `momentra_premium`
- Base Plan ID: `monthly`
- Product ID (full): `momentra_premium:monthly`
- Billing period: Monthly
- Price: ₺59.00 / $1.99
- Free trial: 7 days (offer)
- Status: Active

### Subscription Base Plan #2 — Yıllık

- Subscription ID: `momentra_premium`
- Base Plan ID: `annual`
- Product ID (full): `momentra_premium:annual`
- Billing period: Yearly
- Price: ₺395.00 / $11.99
- Free trial: 7 days (offer)
- Status: Active

> 📌 Android'de tek "subscription" altında iki "base plan" yapılır (modern Play Billing v5+ yapısı).

---

## 4️⃣ RevenueCat Dashboard

`https://app.revenuecat.com → Project → Momentra`

### Step 1: App'leri Ekle

- **iOS**: Bundle ID `com.uyart.momentra`, App Store Connect API key bağla
- **Android**: Package `com.uyart.momentra`, Google Play service account JSON bağla

### Step 2: Products

RevenueCat otomatik App Store Connect ve Play Console'dan ürünleri çeker. Aşağıdakiler görünmeli:

| Product Identifier (iOS)             | Product Identifier (Android) | RC Internal Name  |
| ------------------------------------ | ---------------------------- | ----------------- |
| `com.uyart.momentra.premium.monthly` | `momentra_premium:monthly`   | `premium_monthly` |
| `com.uyart.momentra.premium.annual`  | `momentra_premium:annual`    | `premium_annual`  |

### Step 3: Entitlements

- Yeni Entitlement ekle:
  - **Identifier**: `pro` (KÜÇÜK HARF, kodla aynı)
  - **Display name**: Premium
  - **Attached products**: `premium_monthly` + `premium_annual` (her iki ürünü de ekle)

> ⚠️ Entitlement adı "**pro**" olmalı, "Pro" değil. `purchases.ts` lowercase string ile kontrol ediyor.

### Step 4: Offerings

- **Default Offering** oluştur:
  - Identifier: `default` (RevenueCat'in standart adı)
  - Packages:
    - `$rc_monthly` → `premium_monthly`
    - `$rc_annual` → `premium_annual`
- ✅ "Make this the current offering" işaretle

### Step 5: API Keys

- iOS (Public): `appl_XXXXXXXX` → `.env`'de `EXPO_PUBLIC_REVENUECAT_IOS_KEY`
- Android (Public): `goog_XXXXXXXX` → `.env`'de `EXPO_PUBLIC_REVENUECAT_ANDROID_KEY`

---

## 5️⃣ Test

### Sandbox iOS Test

1. App Store Connect → Users and Access → Sandbox Testers → "review-sandbox@momentra.com"
2. iPhone'da Settings → App Store → Sandbox Account ile giriş
3. App'te paywall'a git, "Ücretsiz Dene" → sandbox satın alma → premium aktif olmalı

### Sandbox Android Test

1. Play Console → Setup → License Testing → review hesabını ekle
2. Internal track build'i indirip test et

### RevenueCat Sandbox Sağlama

- Dashboard → Customers → arama: test e-posta
- Active entitlement: `pro` görünmeli
- Latest transaction: monthly/annual

---

## 6️⃣ Production Sonrası İzleme

İlk yayın sonrası RevenueCat Dashboard'da kontrol et:

- **Charts** → MRR, churn, conversion
- **Customers** → ilk gerçek satın alımlar
- **Webhooks** (opsiyonel) → Supabase'e subscription event'leri push et

---

## ❓ Sorun Giderme

### "Premium aktif olmadı" — kullanıcı satın aldı ama app görmüyor

1. RC Dashboard → Customer'ı bul → entitlement aktif mi?
2. Aktifse: app'te `Purchases.getCustomerInfo()` cache invalidation gerekebilir → app'i tekrar başlat
3. Aktif değilse: Product ↔ Entitlement bağlantısı eksik → Entitlement sayfasında ürünü ekle

### "Free trial çalışmıyor"

- Apple: Subscription group içinde tek introductory offer alır — doğru subscription group seçili mi?
- Google: Free trial "Offer" olarak ayrı tanımlanır, base plan altında "Add offer" ile

### "Sandbox satın alma reddediliyor"

- Sandbox tester farklı Apple ID ile login mi? (production iCloud account ile karıştırma)
- Settings → App Store → Sandbox Account'tan login ol

---

## ✅ Submit'ten Önce Son Kontrol

- [ ] iOS IAP'ler "Ready to Submit" durumunda
- [ ] Android subscription "Active" durumunda
- [ ] RC Entitlement `pro` her iki ürüne bağlı
- [ ] RC Default Offering aktif
- [ ] iOS + Android API key'leri `.env`'de
- [ ] Sandbox satın alma test edildi (en az iOS)
- [ ] Paywall ekranı App Store Connect'e screenshot olarak yüklendi
