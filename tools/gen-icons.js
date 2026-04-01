const sharp = require("sharp");
const fs = require("fs");
const path = require("path");

const OUT = path.join(__dirname, "../assets/images");
if (!fs.existsSync(OUT)) fs.mkdirSync(OUT, { recursive: true });

function buildSVG(size, variant = "icon") {
  const rx = Math.round(size * 0.225);
  const hlCx = Math.round(size * 0.38);
  const hlCy = Math.round(size * 0.32);
  const hlR = Math.round(size * 0.42);

  const s = size;
  const mx1 = s * 0.289,
    my1 = s * 0.674;
  const mx2 = s * 0.289,
    my2 = s * 0.361;
  const mx3 = s * 0.5,
    my3 = s * 0.582;
  const mx4 = s * 0.711,
    my4 = s * 0.361;
  const mx5 = s * 0.711,
    my5 = s * 0.674;

  const sp1x = s * 0.5,
    sp1y = s * 0.211,
    sp1s = s * 0.042;
  const sp2x = s * 0.73,
    sp2y = s * 0.238,
    sp2s = s * 0.025;
  const sp3x = s * 0.293,
    sp3y = s * 0.266,
    sp3s = s * 0.019;

  const sw = Math.max(2, s * 0.059);
  const gwSw = Math.max(4, s * 0.121);

  function star(cx, cy, r) {
    const p = r * 0.83,
      q = r * 0.29;
    return `M${cx},${cy - r} L${cx + q},${cy - q} L${cx + p},${cy} L${cx + q},${cy + q} L${cx},${cy + r} L${cx - q},${cy + q} L${cx - p},${cy} L${cx - q},${cy - q} Z`;
  }

  if (variant === "monochrome") {
    return `<svg xmlns="http://www.w3.org/2000/svg" width="${s}" height="${s}" viewBox="0 0 ${s} ${s}">
  <rect x="0" y="0" width="${s}" height="${s}" rx="${rx}" fill="white"/>
  <g fill="none" stroke="#9a7420" stroke-linecap="round" stroke-linejoin="round" stroke-width="${gwSw}" opacity="0.18">
    <line x1="${mx1}" y1="${my1}" x2="${mx2}" y2="${my2}"/>
    <line x1="${mx2}" y1="${my2}" x2="${mx3}" y2="${my3}"/>
    <line x1="${mx3}" y1="${my3}" x2="${mx4}" y2="${my4}"/>
    <line x1="${mx4}" y1="${my4}" x2="${mx5}" y2="${my5}"/>
  </g>
  <g fill="none" stroke="#7a5c11" stroke-linecap="round" stroke-linejoin="round" stroke-width="${sw}" opacity="0.95">
    <line x1="${mx1}" y1="${my1}" x2="${mx2}" y2="${my2}"/>
    <line x1="${mx2}" y1="${my2}" x2="${mx3}" y2="${my3}"/>
    <line x1="${mx3}" y1="${my3}" x2="${mx4}" y2="${my4}"/>
    <line x1="${mx4}" y1="${my4}" x2="${mx5}" y2="${my5}"/>
  </g>
  <path d="${star(sp1x, sp1y, sp1s)}" fill="#9a7420" opacity="0.80"/>
  <path d="${star(sp2x, sp2y, sp2s)}" fill="#9a7420" opacity="0.55"/>
  <path d="${star(sp3x, sp3y, sp3s)}" fill="#9a7420" opacity="0.45"/>
</svg>`;
  }

  if (variant === "bg") {
    return `<svg xmlns="http://www.w3.org/2000/svg" width="${s}" height="${s}" viewBox="0 0 ${s} ${s}">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#b07820"/>
      <stop offset="45%" stop-color="#9A7420"/>
      <stop offset="100%" stop-color="#6a4c0e"/>
    </linearGradient>
  </defs>
  <rect x="0" y="0" width="${s}" height="${s}" fill="url(#bg)"/>
</svg>`;
  }

  if (variant === "fg") {
    const pad = Math.round(s * 0.17);
    const inner = s - pad * 2;
    const irx = Math.round(inner * 0.225);
    const ihlCx = pad + Math.round(inner * 0.38);
    const ihlCy = pad + Math.round(inner * 0.32);
    const ihlR = Math.round(inner * 0.42);
    const imx1 = pad + inner * 0.289,
      imy1 = pad + inner * 0.674;
    const imx2 = pad + inner * 0.289,
      imy2 = pad + inner * 0.361;
    const imx3 = pad + inner * 0.5,
      imy3 = pad + inner * 0.582;
    const imx4 = pad + inner * 0.711,
      imy4 = pad + inner * 0.361;
    const imx5 = pad + inner * 0.711,
      imy5 = pad + inner * 0.674;
    const isp1x = pad + inner * 0.5,
      isp1y = pad + inner * 0.211,
      isp1s = inner * 0.042;
    const isp2x = pad + inner * 0.73,
      isp2y = pad + inner * 0.238,
      isp2s = inner * 0.025;
    const isp3x = pad + inner * 0.293,
      isp3y = pad + inner * 0.266,
      isp3s = inner * 0.019;
    const isw = Math.max(2, inner * 0.059);
    const igwSw = Math.max(4, inner * 0.121);
    return `<svg xmlns="http://www.w3.org/2000/svg" width="${s}" height="${s}" viewBox="0 0 ${s} ${s}">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#b07820"/>
      <stop offset="45%" stop-color="#9A7420"/>
      <stop offset="100%" stop-color="#6a4c0e"/>
    </linearGradient>
    <radialGradient id="hl" cx="${ihlCx}" cy="${ihlCy}" r="${ihlR}" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#fffce0" stop-opacity="0.40"/>
      <stop offset="100%" stop-color="#e8b830" stop-opacity="0"/>
    </radialGradient>
  </defs>
  <rect x="${pad}" y="${pad}" width="${inner}" height="${inner}" rx="${irx}" fill="url(#bg)"/>
  <circle cx="${ihlCx}" cy="${ihlCy}" r="${ihlR}" fill="url(#hl)"/>
  <g fill="none" stroke="rgba(255,255,255,0.14)" stroke-linecap="round" stroke-linejoin="round" stroke-width="${igwSw}">
    <line x1="${imx1}" y1="${imy1}" x2="${imx2}" y2="${imy2}"/>
    <line x1="${imx2}" y1="${imy2}" x2="${imx3}" y2="${imy3}"/>
    <line x1="${imx3}" y1="${imy3}" x2="${imx4}" y2="${imy4}"/>
    <line x1="${imx4}" y1="${imy4}" x2="${imx5}" y2="${imy5}"/>
  </g>
  <g fill="none" stroke="white" stroke-linecap="round" stroke-linejoin="round" stroke-width="${isw}" opacity="0.97">
    <line x1="${imx1}" y1="${imy1}" x2="${imx2}" y2="${imy2}"/>
    <line x1="${imx2}" y1="${imy2}" x2="${imx3}" y2="${imy3}"/>
    <line x1="${imx3}" y1="${imy3}" x2="${imx4}" y2="${imy4}"/>
    <line x1="${imx4}" y1="${imy4}" x2="${imx5}" y2="${imy5}"/>
  </g>
  <path d="${star(isp1x, isp1y, isp1s)}" fill="rgba(255,250,220,0.88)"/>
  <path d="${star(isp2x, isp2y, isp2s)}" fill="rgba(255,250,220,0.64)"/>
  <path d="${star(isp3x, isp3y, isp3s)}" fill="rgba(255,250,220,0.52)"/>
</svg>`;
  }

  // Default full icon
  return `<svg xmlns="http://www.w3.org/2000/svg" width="${s}" height="${s}" viewBox="0 0 ${s} ${s}">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#b07820"/>
      <stop offset="45%" stop-color="#9A7420"/>
      <stop offset="100%" stop-color="#6a4c0e"/>
    </linearGradient>
    <radialGradient id="hl" cx="${hlCx}" cy="${hlCy}" r="${hlR}" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#fffce0" stop-opacity="0.40"/>
      <stop offset="100%" stop-color="#e8b830" stop-opacity="0"/>
    </radialGradient>
  </defs>
  <rect x="0" y="0" width="${s}" height="${s}" rx="${rx}" fill="url(#bg)"/>
  <circle cx="${hlCx}" cy="${hlCy}" r="${hlR}" fill="url(#hl)"/>
  <g fill="none" stroke="rgba(255,255,255,0.14)" stroke-linecap="round" stroke-linejoin="round" stroke-width="${gwSw}">
    <line x1="${mx1}" y1="${my1}" x2="${mx2}" y2="${my2}"/>
    <line x1="${mx2}" y1="${my2}" x2="${mx3}" y2="${my3}"/>
    <line x1="${mx3}" y1="${my3}" x2="${mx4}" y2="${my4}"/>
    <line x1="${mx4}" y1="${my4}" x2="${mx5}" y2="${my5}"/>
  </g>
  <g fill="none" stroke="white" stroke-linecap="round" stroke-linejoin="round" stroke-width="${sw}" opacity="0.97">
    <line x1="${mx1}" y1="${my1}" x2="${mx2}" y2="${my2}"/>
    <line x1="${mx2}" y1="${my2}" x2="${mx3}" y2="${my3}"/>
    <line x1="${mx3}" y1="${my3}" x2="${mx4}" y2="${my4}"/>
    <line x1="${mx4}" y1="${my4}" x2="${mx5}" y2="${my5}"/>
  </g>
  <path d="${star(sp1x, sp1y, sp1s)}" fill="rgba(255,250,220,0.88)"/>
  <path d="${star(sp2x, sp2y, sp2s)}" fill="rgba(255,250,220,0.64)"/>
  <path d="${star(sp3x, sp3y, sp3s)}" fill="rgba(255,250,220,0.52)"/>
</svg>`;
}

const FILES = [
  { file: "icon.png", size: 1024, variant: "icon" },
  { file: "splash-icon.png", size: 1024, variant: "icon" },
  { file: "android-icon-foreground.png", size: 1024, variant: "fg" },
  { file: "android-icon-background.png", size: 1024, variant: "bg" },
  { file: "android-icon-monochrome.png", size: 1024, variant: "monochrome" },
  { file: "favicon.png", size: 64, variant: "icon" },
];

(async () => {
  for (const { file, size, variant } of FILES) {
    const svg = buildSVG(size, variant);
    const outPath = path.join(OUT, file);
    await sharp(Buffer.from(svg)).png().toFile(outPath);
    console.log(`✓ ${file} (${size}×${size})`);
  }
  console.log(`\nTümü assets/images/ klasörüne kaydedildi.`);
})();
