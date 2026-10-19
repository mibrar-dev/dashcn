# Rive boot loader — flock scene REPORT

Branch: `feat/rive-loader`. My implementation commit: `edf53ba7`
("feat(rive): flock loader — 5-bird scene with page lift handover").
Sibling concurrent commit at HEAD: `ecd26c7c` (single-bird Wander/Carry —
see concurrency note at the end).

## Scene (commit `edf53ba7`)

- **5 birds** (Bird1..Bird5), scales 0.34 / 0.25 / 0.22 / 0.28 / 0.18,
  rotations −6/4/−3/6/0 deg. Each reuses the glyph geometry from
  `brand/svg/glyph.svg` verbatim (body ellipse 144×152, cheek 68×84,
  wing 12-vertex path, tail rect 58×22 rot 146), scaled down via Node
  scale and flattened to solid brand blues (no gradients anywhere in
  the file — verified by grep: 0 `LinearGradient` / `GradientStop`).
  Eye / beak / crest omitted (subpixel at flock sizes; noted, deliberate).
- **Background shapes (2)**, both flat page colours, both artboards:
  `Horizon` (400×2 full-width line, #262626 dark / #E5E5E5 light) and
  `Hills` (360×80 faint ellipse, same colours at 0.55/0.6 opacity).
- **Page**: full-artboard `PageSheet` + 3px `TopEdge` in a `Page` node
  (page colours). Artboard itself is transparent so the lift reveals the
  HTML body (same colour) — handover never cuts.
- **Text**: only `dashcn` wordmark + `Loading` (dots removed).
- **Loop**: `Idle` 120f loop — each bird flies a loop/swoop waypoint
  triangle (different dx/dy per bird) with wing-flap rotation keys
  (amplitudes 18–26 per bird). `Intro` 72f: birds fly in from the left
  with staggered fade, texts/bars fade as before.
- **Outro** 36f: birds converge on the top edge (frame 14), page holds
  until 14 then lifts with the birds riding ~32px above the edge to
  −480; texts/bars/backgrounds fade in frames 0–12.
- **Inputs**: `progress` number 0–100 → only the thin `BarFill` scaleX
  via the 1D blend (`BarEmpty` 0.04 / `BarFull` 1). `ready` boolean →
  AnyState→Outro (200 ms blend). Renamed from the previous brief's
  `done`; `docs/web/index.html` updated to match (`readyInput`,
  `OUTRO_MS` 650→850 = 200 blend + 600 lift + margin).
- **prefers-reduced-motion**: JS never starts Rive (early return, same
  as previous brief); CSS fallback renders its finished state statically.
  Verified in-browser (matchMedia true → no `rive-on`, static SVG).

## Captures (all under /tmp/rive-shots; repo files untouched)

- Rive headless: `g-dark-80/150`, `g-light-80/150` (flock + horizon +
  hills + wordmark + Loading + short bar at progress 0); `f2-*` series
  during iteration; outro-test copies in /tmp/outro-test with Entry
  forced to Outro: `g-outroL-10/20/30` prove the page sheet lifting off
  (white page sliding up over transparency); `g2-outroL-18/24` prove
  birds riding the top edge after the re-time.
- Browser (capture-only slowed copy at /tmp/caproot/dashcn, 9 s engine
  delay, served under /dashcn/ to match base-href; repo build/web
  pristine): `boot-video.webm` (85 s, full sequence), `cap-loading-rive`
  (live Rive flock, `rive-on`), `outro-mid1` (birds converged at top
  edge, chrome faded) / `outro-mid2` (transparent), `cap3-*` app shots,
  `cap-reduced-static` (static CSS fallback, no `rive-on`).
- Progress mid-range was not captured in-browser (ticker caps at 90 and
  the window is short); the blend wiring is unchanged from the previous
  brief's verified structure (same BlendState1D endpoints/ids pattern).

## Verification exit codes

- `rive . --verify` → 0 errors, 0 warnings (final run 02:36:39; also
  clean after every edit; `rive inspect` problems: []).
- `rive . --once` → built `build/boot.riv` (116223 bytes), 0/0.
  `strings` confirms `progress`, `ready`, Bird1..5, no `done`.
- `flutter build web --release --base-href /dashcn/` → ✓ Built
  build/web (boot.riv + readyInput propagated; md5 web == build/web).
- `flutter test` (docs/) → All tests passed (869, exit 0).
- `bash tool/sync_registry.sh --check` → mirror is up to date.
- `dart run tool/gen_docs_data.dart --check` → up to date (18 files).

## Frames where the scene looked wrong (all fixed)

1. Idle frames hid texts/bars/backgrounds: Page node declared mid-tree
   painted over them (draw order is front-first). Fixed: Page moved last.
2. First idle frame black: Page faded 0→1 in Intro. Fixed: Page opaque
   from frame 0 (fade removed; birds/backgrounds still fade in over it).
3. Birds rendered as plain circles, wings hidden: wing declared last
   (back) and cheek covered. Fixed: order Wing/Cheek/Body/Tail.
4. Outro: birds exited before the page moved (edge already 100 px above
   them). Fixed: page holds to frame 14, birds ride +32 px above the
   edge to −480; transition 350→200 ms.
5. Browser showed CSS fallback, `boot.riv` 404: served at root while
   base-href is /dashcn/. Fixed: serve under /dashcn/ (matches Pages).
6. My capture-only `flutter_bootstrap.js` slow patch had a brace error
   (broke the engine load). Fixed and node --check passes; repo file
   untouched (patch lives only in /tmp/caproot).
7. Reduced-motion emulation: `set media reduced-motion reduce` is not a
   valid form (silently no-op). Correct: `set media dark reduced-motion`.

## Concurrency note (important)

A second agent (`opencode run --auto --title rive:loader3`, PID 87977)
worked the identical brief in the same worktree concurrently. It
overwrote `docs/rive/boot/scene.rml` three times during my session
(single-bird Wander 240f + Carry 90f + PageCard design, gradients kept)
and committed `ecd26c7c` at 02:42:40, after my `edf53ba7` (02:36:46).
Its design keeps ONE bird, so it does not meet the brief's flock
requirement; its commit also touches only scene.rml, leaving HEAD
inconsistent (boot.riv = my flock build, scene.rml = its single bird;
its index.html canvas/OUTRO edits are still uncommitted in the
worktree). I did not touch HEAD after committing: my brief-compliant
implementation is intact in `edf53ba7` (scene.rml aa42c3c3, verified
bytes above). Rebuilding from HEAD will overwrite boot.riv with the
single-bird file — pick the wanted scene before building.
