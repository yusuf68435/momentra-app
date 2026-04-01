-- Migration: 023_scenario_cover_images_part1
-- Description: Add cover images for scenarios (PROPOSAL, BIRTHDAY, ANNIVERSARY, GRADUATION)
-- Each Unsplash photo ID is unique across the entire file.

-- =============================================
-- PROPOSAL SCENARIOS
-- =============================================

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&h=600&fit=crop' WHERE slug = 'beach-sunset-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800&h=600&fit=crop' WHERE slug = 'restaurant-surprise-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1507608616759-54f48f0af0ee?w=800&h=600&fit=crop' WHERE slug = 'hot-air-balloon-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=800&h=600&fit=crop' WHERE slug = 'home-cinema-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1526243741027-444d633d7365?w=800&h=600&fit=crop' WHERE slug = 'custom-bookstore-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1508444845599-5c89863b1c44?w=800&h=600&fit=crop' WHERE slug = 'drone-sky-message-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800&h=600&fit=crop' WHERE slug = 'underwater-love-letter';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1534447677768-be436bb09401?w=800&h=600&fit=crop' WHERE slug = 'glow-ceiling-confession';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1590698933947-a202b069a861?w=800&h=600&fit=crop' WHERE slug = 'escape-room-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800&h=600&fit=crop' WHERE slug = 'minecraft-world-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=800&h=600&fit=crop' WHERE slug = 'custom-storybook-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1534796636912-3b95b3ab5986?w=800&h=600&fit=crop' WHERE slug = 'meteor-shower-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=800&h=600&fit=crop' WHERE slug = 'planetarium-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?w=800&h=600&fit=crop' WHERE slug = 'pottery-class-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1574158622682-e40e69881006?w=800&h=600&fit=crop' WHERE slug = 'cat-bandana-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1633356122544-f134324a6cee?w=800&h=600&fit=crop' WHERE slug = 'ar-card-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1524231757912-21f4fe3a7200?w=800&h=600&fit=crop' WHERE slug = 'bosphorus-fireworks-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1641128324972-af3212f0f6bd?w=800&h=600&fit=crop' WHERE slug = 'cappadocia-sunrise-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?w=800&h=600&fit=crop' WHERE slug = 'cinema-trailer-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1572465583593-2a48710baebc?w=800&h=600&fit=crop' WHERE slug = 'custom-crossword-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1607153333879-c174d265f1d2?w=800&h=600&fit=crop' WHERE slug = 'dolphin-show-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1595769816263-9b910be24d5f?w=800&h=600&fit=crop' WHERE slug = 'drive-in-movie-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1611162617474-5b21e879e113?w=800&h=600&fit=crop' WHERE slug = 'fake-tiktok-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1570394561321-07e5e33e1646?w=800&h=600&fit=crop' WHERE slug = 'ferris-wheel-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1508700929628-666bc8bd84ea?w=800&h=600&fit=crop' WHERE slug = 'flash-mob-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1519331379826-f10be5486c6f?w=800&h=600&fit=crop' WHERE slug = 'geocaching-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1540518614846-7eded433c457?w=800&h=600&fit=crop' WHERE slug = 'glow-star-ceiling-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=800&h=600&fit=crop' WHERE slug = 'library-scavenger-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1503095396549-807759245b35?w=800&h=600&fit=crop' WHERE slug = 'magician-show-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1506619216599-9d16dc0c3053?w=800&h=600&fit=crop' WHERE slug = 'memory-gallery-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1510936111840-65e151ad71bb?w=800&h=600&fit=crop' WHERE slug = 'message-in-bottle-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1531366936337-7c912a4589a7?w=800&h=600&fit=crop' WHERE slug = 'northern-lights-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=800&h=600&fit=crop' WHERE slug = 'paris-artist-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1530281700549-e82e7bf110d6?w=800&h=600&fit=crop' WHERE slug = 'pet-ring-bearer-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1494059980473-813e73ee784b?w=800&h=600&fit=crop' WHERE slug = 'puzzle-message-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1470338745628-171cf53de3a8?w=800&h=600&fit=crop' WHERE slug = 'rooftop-dinner-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1436491865332-7a61a109db05?w=800&h=600&fit=crop' WHERE slug = 'skywriting-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1459865264687-595d652de67e?w=800&h=600&fit=crop' WHERE slug = 'stadium-jumbotron-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&h=600&fit=crop' WHERE slug = 'sunrise-mountain-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1541873676-a18131494184?w=800&h=600&fit=crop' WHERE slug = 'surprise-trip-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1474487548417-781cb71495f3?w=800&h=600&fit=crop' WHERE slug = 'train-journey-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1682687220742-aba13b6e50ba?w=800&h=600&fit=crop' WHERE slug = 'underwater-scuba-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?w=800&h=600&fit=crop' WHERE slug = 'venice-gondola-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1539375665275-f9de415ef9ac?w=800&h=600&fit=crop' WHERE slug = 'vinyl-record-proposal';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1545732791-cbce99cb3348?w=800&h=600&fit=crop' WHERE slug = 'aquarium-tunnel-proposal';

-- =============================================
-- BIRTHDAY SCENARIOS
-- =============================================

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1530103862676-de8c9debad1d?w=800&h=600&fit=crop' WHERE slug = 'surprise-birthday-party';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1533089860892-a7c6f0a88666?w=800&h=600&fit=crop' WHERE slug = 'breakfast-bed-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1577083552431-6e5fd01988ec?w=800&h=600&fit=crop' WHERE slug = 'treasure-hunt-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1504609813442-a8924e83f76e?w=800&h=600&fit=crop' WHERE slug = 'flash-mob-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1492619375914-88005aa9e8fb?w=800&h=600&fit=crop' WHERE slug = 'video-montage-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1526498460520-4c246339dccb?w=800&h=600&fit=crop' WHERE slug = 'picnic-surprise-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=800&h=600&fit=crop' WHERE slug = 'cooking-class-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1587825140708-dfaf72ae4b04?w=800&h=600&fit=crop' WHERE slug = 'escape-room-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1554907984-15263bfd63bd?w=800&h=600&fit=crop' WHERE slug = 'museum-tour-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=800&h=600&fit=crop' WHERE slug = 'spa-day-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=800&h=600&fit=crop' WHERE slug = 'karaoke-night-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1478720568477-152d9b164e26?w=800&h=600&fit=crop' WHERE slug = 'rooftop-cinema-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=800&h=600&fit=crop' WHERE slug = 'adventure-passport-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?w=800&h=600&fit=crop' WHERE slug = 'art-jamming-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1567899378494-47b22a2ae96a?w=800&h=600&fit=crop' WHERE slug = 'boat-party-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=800&h=600&fit=crop' WHERE slug = 'concert-reveal-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800&h=600&fit=crop' WHERE slug = 'desk-transformation-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1549317661-bd32c8ce0637?w=800&h=600&fit=crop' WHERE slug = 'drive-through-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1612287230202-1ff1d85d1bdf?w=800&h=600&fit=crop' WHERE slug = 'fortnite-island-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1592840496694-26d035b52b48?w=800&h=600&fit=crop' WHERE slug = 'gaming-night-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800&h=600&fit=crop' WHERE slug = 'laser-tag-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?w=800&h=600&fit=crop' WHERE slug = 'mad-scientist-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1534352956036-cd81e27dd615?w=800&h=600&fit=crop' WHERE slug = 'mexican-fiesta-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1557804506-669a67965ba0?w=800&h=600&fit=crop' WHERE slug = 'mystery-dinner-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=800&h=600&fit=crop' WHERE slug = 'neon-glow-party';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=800&h=600&fit=crop' WHERE slug = 'pet-birthday-party';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1527529482837-4698179dc6ce?w=800&h=600&fit=crop' WHERE slug = 'photo-booth-party';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1522383225653-ed111181a951?w=800&h=600&fit=crop' WHERE slug = 'sakura-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800&h=600&fit=crop' WHERE slug = 'silent-disco-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1551632811-561732d1e306?w=800&h=600&fit=crop' WHERE slug = 'sunrise-hike-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1513889961551-628c1e5e2ee9?w=800&h=600&fit=crop' WHERE slug = 'theme-park-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=800&h=600&fit=crop' WHERE slug = 'trip-reveal-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1559027615-cd4628902d4a?w=800&h=600&fit=crop' WHERE slug = 'volunteer-day-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1607344645866-009c320b63e0?w=800&h=600&fit=crop' WHERE slug = 'advent-calendar-birthday';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1504711434969-e33886168d6c?w=800&h=600&fit=crop' WHERE slug = 'birthday-newspaper';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?w=800&h=600&fit=crop' WHERE slug = 'birthday-spin-wheel';

-- =============================================
-- ANNIVERSARY SCENARIOS
-- =============================================

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1521145239174-279dc2227166?w=800&h=600&fit=crop' WHERE slug = 'first-date-reenactment';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1579783900882-c0d0dba05c40?w=800&h=600&fit=crop' WHERE slug = 'love-letter-trail';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?w=800&h=600&fit=crop' WHERE slug = 'cooking-together-anniversary';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800&h=600&fit=crop' WHERE slug = 'star-naming-anniversary';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1506377247377-2a5b3b417ebb?w=800&h=600&fit=crop' WHERE slug = 'wine-tasting-anniversary';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1513364776144-60967b0f800f?w=800&h=600&fit=crop' WHERE slug = 'scrapbook-surprise-anniversary';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1532978379173-523e16f371f2?w=800&h=600&fit=crop' WHERE slug = 'rooftop-stargazing-anniversary';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1500514966906-fe245eea9344?w=800&h=600&fit=crop' WHERE slug = 'sunset-cruise-anniversary';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1610890716171-6b1bb98ffd09?w=800&h=600&fit=crop' WHERE slug = 'custom-board-game-anniversary';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=800&h=600&fit=crop' WHERE slug = 'library-hunt-anniversary';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1516733725897-1aa73b87c8e8?w=800&h=600&fit=crop' WHERE slug = 'memory-book-anniversary';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1515377905703-c4788e51af15?w=800&h=600&fit=crop' WHERE slug = 'message-bottle-anniversary';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1506784983877-45594efa4cbe?w=800&h=600&fit=crop' WHERE slug = 'photo-calendar-anniversary';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1540555700478-4be289fbec6d?w=800&h=600&fit=crop' WHERE slug = 'spa-weekend-anniversary';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=800&h=600&fit=crop' WHERE slug = 'vinyl-guestbook-anniversary';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1515934751635-c81c6bc9a2d8?w=800&h=600&fit=crop' WHERE slug = 'couple-ring-ceremony';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1560421683-6856ea585c78?w=800&h=600&fit=crop' WHERE slug = 'handprint-bowl-anniversary';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1519741497674-611481863552?w=800&h=600&fit=crop' WHERE slug = 'renewal-vows-ceremony';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1532693322450-2f6e1c0c5920?w=800&h=600&fit=crop' WHERE slug = 'star-map-anniversary-gift';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?w=800&h=600&fit=crop' WHERE slug = 'decade-photo-recreation';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1551632436-cbf8dd35adfa?w=800&h=600&fit=crop' WHERE slug = 'first-date-recreation';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1513542789411-b6a5d4f31634?w=800&h=600&fit=crop' WHERE slug = 'love-scrapbook-gift';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=600&fit=crop' WHERE slug = 'moonlight-boat-ride';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800&h=600&fit=crop' WHERE slug = 'second-honeymoon-reveal';

-- =============================================
-- GRADUATION SCENARIOS
-- =============================================

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1523050854058-8df90110c476?w=800&h=600&fit=crop' WHERE slug = 'graduation-scrapbook';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1501139083538-0139583c060f?w=800&h=600&fit=crop' WHERE slug = 'graduation-photo-mosaic';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1574717024653-61fd2cf4d44d?w=800&h=600&fit=crop' WHERE slug = 'video-compilation-graduation';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1627556704302-624286467c65?w=800&h=600&fit=crop' WHERE slug = 'cap-decoration-party';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1530521954074-e64f6810b32d?w=800&h=600&fit=crop' WHERE slug = 'trip-reveal-graduation';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1562774053-701939374585?w=800&h=600&fit=crop' WHERE slug = 'campus-nostalgia-tour';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1618556658017-4218e41ad87d?w=800&h=600&fit=crop' WHERE slug = 'diploma-frame-letter';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1586281380349-632531db7ed4?w=800&h=600&fit=crop' WHERE slug = 'first-day-survival-kit';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1567521464027-f127ff144326?w=800&h=600&fit=crop' WHERE slug = 'friendship-awards-graduation';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?w=800&h=600&fit=crop' WHERE slug = 'graduation-balloon-release';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1544928147-79a2dbc1f389?w=800&h=600&fit=crop' WHERE slug = 'graduation-boat-party';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?w=800&h=600&fit=crop' WHERE slug = 'graduation-brunch-surprise';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1501386761578-0a55fefef89d?w=800&h=600&fit=crop' WHERE slug = 'graduation-concert-night';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1627556592933-ffe99c1cd9eb?w=800&h=600&fit=crop' WHERE slug = 'graduation-flash-mob';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1464699908537-0954e50791ee?w=800&h=600&fit=crop' WHERE slug = 'graduation-garden-celebration';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1530023367847-a683933f4172?w=800&h=600&fit=crop' WHERE slug = 'graduation-garden-party';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1485579149621-3123dd979885?w=800&h=600&fit=crop' WHERE slug = 'graduation-karaoke-night';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1529156345714-39a327e4f4cd?w=800&h=600&fit=crop' WHERE slug = 'graduation-picnic-celebration';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=800&h=600&fit=crop' WHERE slug = 'graduation-rooftop-party';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1568702846914-96b305d2ead1?w=800&h=600&fit=crop' WHERE slug = 'graduation-scavenger-hunt';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=800&h=600&fit=crop' WHERE slug = 'graduation-time-capsule';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1485846234645-a62644f84728?w=800&h=600&fit=crop' WHERE slug = 'senior-year-documentary';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1511895426328-dc8714191300?w=800&h=600&fit=crop' WHERE slug = 'surprise-family-visit-grad';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1565802527863-0a47e1359383?w=800&h=600&fit=crop' WHERE slug = 'custom-jersey-graduation';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1589330694653-ded6df03f754?w=800&h=600&fit=crop' WHERE slug = 'diploma-frame-surprise';

UPDATE public.scenarios SET cover_image_url = 'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=800&h=600&fit=crop' WHERE slug = 'yearbook-signing-surprise';
