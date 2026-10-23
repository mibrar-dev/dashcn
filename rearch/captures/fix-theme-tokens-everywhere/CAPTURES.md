# Captures: theme tokens drive every component (`fix/theme-tokens-everywhere`)

Matrix: 9 scenes (button, input, select, card, dialog, popup, menu,
swipe_actions, sidebar) × radius factor 0 vs 1.0 × compact vs touch density
= 36 PNGs, 720×520 @1x.

## Why a test harness instead of the docs site

The docs `/themes` page cannot drive this matrix: radius is only adjustable
through the rail's slider UI (no `?radius=` URL param can set it) and no rail
control sets global density at all. So the matrix is captured by pumping the
kit directly under modified tokens:
`dashcn/test/registry/theme_tokens_captures_test.dart` (regenerates every PNG
here on demand; outputs are git-ignored).

## What to look for

- `*_r0_*`: everything rectangular — buttons, inputs, cards, dialogs lose
  all rounding (radius factor 0 zeroes every scale step).
- `*_r16_*`: everything deeply round — the same scenes pick up the large
  radius end of the scale.
- `*_compact` vs `*_touch`: controls, rows and gaps grow under touch
  density (36 px default fields/buttons at default density per SIZING.md
  scale up; sidebar rows spread).
- Media chrome (video scrims), barriers and status tones stay fixed —
  see the allow-list in `theme_tokens_guard_test.dart`.

## Files

- `button/input/select/card_{r0,r16}_{compact,touch}.png` — closed controls.
- `dialog/popup/menu_{r0,r16}_{compact,touch}.png` — overlay trigger tapped
  open before the snapshot.
- `swipe_actions_{r0,r16}_{compact,touch}.png` — controller opened before
  the snapshot.
- `sidebar_{r0,r16}_{compact,touch}.png` — full rail, 280×460.
