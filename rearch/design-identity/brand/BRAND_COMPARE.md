# dashcn — Brand comparison (Brief B1)

Question: which identity should dashcn wear?

Reference: the dashcn bird — original round Flutter-blue bird with glowing
"dash" beak and "cn" gradient wordmark.
Tokens: ink #09090B, paper #FAFAFA, body #47D4FF -> #0562D2,
wing #0B5BC9 -> #03398F, beak #E9F8FF -> #2EE6D6.
Artwork: `svg/mark-dark.svg` (shown in `compare.html` via `svg/mark-dark.svg`
`<img>` alongside each direction, plus inline copies).

Compared directions (see `compare.html`):

- A — Plinth (Workbench): precise engineer's bench. Paper #FAF8F5,
  ink #141414, ember #E2552B / #FF7A4D. Type: Geist + Geist Mono.
- B — Kiln (warm craft): tactile glazed tiles, editorial serif.
  Paper #F6F1EA, ink #1A1714. Type: Instrument Serif + Inter.
- C — Facet (dark prism): dark-first spatial canvas.
  #0B0B0F / #F7F7FA, violet #7C5CFF -> cyan #22D3EE. Type: Geist + Geist Mono.
- D — Hybrid (A + B + C): Workbench skeleton warmed by glaze tiles
  and a prism accent. Paper #FAF8F5, ink #141414, ember #E2552B / #FF7A4D,
  glaze #C96F2E, prism #7C5CFF -> #22D3EE.
  Type: Geist + Geist Mono + Instrument Serif accent.

Each direction in `compare.html` shows: name, one-line mood, palette
swatches with hex labels, type sample, inline-SVG logo concept
(tile + short wordmark), side-by-side row with the dashcn bird,
16px favicon rendering, and dark + light tile rendering.
Light/dark page toggle via CSS variables. Responsive with 16px gutters,
no horizontal scroll at 375px. No external images.

## Recommendation

Adopt D — Hybrid (Workbench skeleton + Kiln glaze + Facet flow map).

D keeps A's precise Workbench skeleton, so copy-paste stays trustworthy
with rulers, token tables and spec sheets; it borrows B's glaze-tile
warmth and smooth lerps so own-your-code feels crafted rather than
clinical; and it uses C's flow map sparingly to show Flutter-first reach
(one flow, every platform) without surrendering readability. That balance
lets the friendly Flutter-blue dashcn bird sit beside an exact, ownable
system instead of fighting it.

## What would change if we adopted it

- Repo name: stays `dashcn` (package + CLI); Hybrid ships as the
  `plinth+` theme/identity, not a rename.
- Icon: keep the dashcn bird mark as the app/package icon; use the
  Hybrid tile (ember rule + glaze dot + prism sliver) only as the
  docs/brand companion mark and 16px favicon fallback.
- Colours in brand/: keep bird tokens (ink #09090B, paper #FAFAFA,
  body #47D4FF -> #0562D2, wing #0B5BC9 -> #03398F,
  beak #E9F8FF -> #2EE6D6); add Hybrid UI tokens (paper #FAF8F5,
  ink #141414, ember #E2552B / #FF7A4D, glaze #C96F2E,
  prism #7C5CFF -> #22D3EE) and regenerate lockups from the bird SVG.

## RESULT: PASS
