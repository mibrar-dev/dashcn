# CAPTURES — context_menu larger target (`feat/ui-context-target`)

Docs: `http://localhost:8877/#/docs/components/context_menu`, built with
`flutter build web --release --base-href /`, served on port 8877.
Session: agent-browser `--session w-context_menu` (HEADLESS).
Video: `ctx-interaction.webm` (13 s, 1280x800, dark).

## Method note (read this first)

The docs app is a Flutter canvas build, so the accessibility tree exposes
only an "Enable accessibility" button — no clickable refs. All interaction
was done with coordinate mouse events. Two headless-session quirks shaped
this set:

- In-page scrolling does not work: TOC clicks, keyboard (Space/PageDown/
  End), `scroll down`, and synthetic wheel/drag events produce no movement
  (verified pixel-identical screenshots). `mouse wheel` hangs the CLI.
  Per-example captures below are 1280x800 / 375x812 slices of tall-viewport
  full-page screenshots, re-framed to heading + full card. They are
  pixel-identical to what a scrolled viewport would show.
- Synthetic right-clicks are flaky in this session (events appear to be
  processed seconds late, if at all): reliable at 1280, opened only once
  at 375-dark, never at 375-light (0/8 across three strategies, incl. a
  20 s settle). The 375 open path is covered by widget test
  `a 375px phone viewport opens the menu without overflow` and by
  `menu-open-375-dark.png`.

`menu-open-375-light.png` is therefore intentionally absent (a no-menu
screenshot would be misleading). Everything else on the checklist exists.

## Files

### 1280x800, dark (viewport screenshots except where noted)

- `default-1280-dark.png` — viewport shot. Default example: bordered card,
  hint icon + "Right-click here" + "Desktop: right-click · touch:
  long-press", "Pick an action from the menu" below. Hint sits fully
  inside the card border.
- `menu-open-1280-dark.png` — viewport shot. Right-click opened the menu
  at the pointer: Back / Reload / Copy link ⌘C / More tools › / Inspect
  (disabled dimmed), compact ~160 px surface, 8 px right of the pointer.
- `submenu-1280-dark.png` — slice. "With submenu" heading + full card
  ("Right-click this card").
- `touch-1280-dark.png` — slice. "Touch target": hint label above a bare
  24 px icon trigger (the 48 px touch floor applies on mobile) + caption.
- `expanded-1280-dark.png` — slice. "Expanded target": muted wash marks
  the 28 px padded hit region around the card; hint reads
  "Right-click the wash".
- `compact-1280-dark.png` — slice. "Compact menu": 200–240 px clamped
  menu + per-instance surface padding override.

### 1280x800, light (same set)

- `default-1280-light.png`, `menu-open-1280-light.png` (open menu on white:
  rows readable, disabled rows dimmed, shortcut ⌘C visible),
  `submenu-1280-light.png`, `touch-1280-light.png`,
  `expanded-1280-light.png`, `compact-1280-light.png`. Hint text and
  caption meet contrast on the light card; wash + borders visible.

### 375x812, dark

- `default-375-dark.png` — viewport shot (drawer nav, wrapped frame bar,
  card fits, hint wraps to two lines without overflow).
- `menu-open-375-dark.png` — viewport shot. Menu opened as the adaptive
  bottom sheet (viewport < 768 px): full-width surface with 12 px gutters
  (measured 351 px incl. borders), all five rows reachable.
- `submenu-375-dark.png`, `touch-375-dark.png`, `expanded-375-dark.png`,
  `compact-375-dark.png` — slices. Same demos at phone width; hint and
  caption wrap inside the card, no RenderFlex overflow at 375 px.

### 375x812, light

- `default-375-light.png` — viewport shot, light theme.
- `submenu-375-light.png`, `touch-375-light.png`,
  `expanded-375-light.png`, `compact-375-light.png` — slices, all render
  cleanly on white.
- `menu-open-375-light.png` — MISSING (see method note). Coverage instead:
  `menu-open-375-dark.png` (adaptive sheet), `menu-open-1280-light.png`
  (light open state), widget test at 375 px.

### Video

- `ctx-interaction.webm` (13 s, 1280x800, dark): settled page →
  right-click opens the menu → click "Copy link" → menu closes and the
  demo reports "Copied the link" → end. (Recorded after opening the menu
  once to confirm input was flowing; `record start` reloads the page, so
  the first seconds show the splash/loading state.)

## What looks wrong

- Nothing in the component UI. One app-chrome observation (not this
  change): the docs TOC ("On This Page") links never scroll the article
  in this headless session, and the theme toggle does not survive a
  viewport change (light held across reloads, reset to dark on one
  viewport resize). Both are docs-shell behaviors, unrelated to
  `context_menu`; flags for the docs owner, not blockers here.
- The iPhone device-frame preview renders an empty white screen in this
  session (frame chrome paints, example content does not); also docs
  shell, not this change. No capture taken from it.
