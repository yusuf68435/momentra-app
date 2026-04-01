const puppeteer = require("puppeteer");
const sharp = require("sharp");
const path = require("path");
const fs = require("fs");

const HTML = path.resolve(__dirname, "aso-screenshots.html");
const OUT = path.resolve(__dirname, "../assets/screenshots");

// App Store: 1290×2796 (iPhone 6.7")
const TARGET_W = 1290;
const TARGET_H = 2796;
// Capture at 6x (310*6=1860, 672*6=4032) then downscale → better quality
const SCALE = 6;

const LANGS = ["en", "tr"];
const SS_COUNT = 7;

const SS_NAMES = [
  "01-hero",
  "02-ai",
  "03-co-organizer",
  "04-community",
  "05-timeline",
  "06-budget",
  "07-premium",
];

async function run() {
  if (!fs.existsSync(OUT)) fs.mkdirSync(OUT, { recursive: true });

  const browser = await puppeteer.launch({
    headless: "new",
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
  });

  for (const lang of LANGS) {
    const langDir = path.join(OUT, lang);
    if (!fs.existsSync(langDir)) fs.mkdirSync(langDir, { recursive: true });

    const page = await browser.newPage();
    await page.setViewport({
      width: 1800,
      height: 900,
      deviceScaleFactor: SCALE,
    });

    await page.goto(`file:///${HTML.replace(/\\/g, "/")}`, {
      waitUntil: "networkidle0",
    });

    // Switch to correct lang section
    await page.evaluate((l) => {
      document
        .querySelectorAll(".screenshots-section")
        .forEach((s) => s.classList.remove("active"));
      const sec = document.getElementById("sec-" + l);
      if (sec) sec.classList.add("active");
    }, lang);

    await new Promise((r) => setTimeout(r, 300));

    for (let i = 0; i < SS_COUNT; i++) {
      const name = SS_NAMES[i];

      // Get the i-th .screenshot element in the active section
      const el = await page.evaluateHandle(
        (idx, l) => {
          const sec = document.getElementById("sec-" + l);
          if (!sec) return null;
          return sec.querySelectorAll(".screenshot")[idx] || null;
        },
        i,
        lang,
      );

      if (!el || el.toString() === "undefined") {
        console.warn(`  ⚠ ${lang}/${name} — element not found, skipping`);
        continue;
      }

      // Scroll element into view inside the overflow container
      await page.evaluate(
        (idx, l) => {
          const sec = document.getElementById("sec-" + l);
          const el = sec.querySelectorAll(".screenshot")[idx];
          if (el) el.scrollIntoView({ block: "nearest", inline: "start" });
        },
        i,
        lang,
      );
      await new Promise((r) => setTimeout(r, 150));

      // el.screenshot() automatically handles scrolling and captures only the element
      const rawBuf = await el.screenshot({ type: "png" });

      // Resize to App Store dimensions
      const outFile = path.join(langDir, `${name}.png`);
      await sharp(rawBuf)
        .resize(TARGET_W, TARGET_H, { fit: "fill" })
        .png()
        .toFile(outFile);

      console.log(`✓ ${lang}/${name}.png (${TARGET_W}×${TARGET_H})`);
    }

    await page.close();
  }

  await browser.close();
  console.log(`\nTüm SS'ler assets/screenshots/ klasörüne kaydedildi.`);
}

run().catch((err) => {
  console.error("Hata:", err);
  process.exit(1);
});
