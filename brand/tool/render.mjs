// Renders an SVG file to a PNG with headless Chromium (Playwright).
// Usage: node render.mjs <in.svg> <out.png> <width> [height]
import { readFileSync } from 'fs';

async function loadPlaywright() {
  try {
    return await import('playwright');
  } catch {
    // Global install fallback (e.g. /opt/node22/lib/node_modules/playwright).
    const { execSync } = await import('child_process');
    const root = execSync('npm root -g').toString().trim();
    return await import(`${root}/playwright/index.mjs`);
  }
}

const [svgPath, out, w, h] = process.argv.slice(2);
const W = Number(w);
const H = Number(h ?? w);
const svg = readFileSync(svgPath, 'utf8').replace('<svg', `<svg width="${W}" height="${H}"`);
const { chromium } = await loadPlaywright();
const browser = await chromium.launch();
const page = await browser.newPage({ viewport: { width: W, height: H } });
await page.setContent(`<html><body style="margin:0;background:transparent">${svg}</body></html>`);
await page.screenshot({ path: out, omitBackground: true, clip: { x: 0, y: 0, width: W, height: H } });
await browser.close();
