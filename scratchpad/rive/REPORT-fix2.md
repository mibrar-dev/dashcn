# FIX ROUND 2: Rive loader — REPORT-fix2

Branch: `feat/rive-loader` (worktree `dashcn-rive`). No push. Local commits only.
Co-Authored-By: Claude Haiku 5.5 <noreply@anthropic.com>

## What was wrong (round-2 frame check of review2/cold-load-fixed.webm)

1. CSS fallback (`Loading docs…` + single bird) visible 0–5.4 s; Rive only from ~5.4 s.
2. Handover at 5.6–5.8 s was a 2-frame cut; no birds gripping/carrying.
3. Root causes found by instrumenting the shipped page:
   - The runtime was fetched from a CDN (`@rive-app/canvas` jsDelivr `rive.min.js`),
     and `rive.min.js` in turn fetches `rive.wasm` from `https://unpkg.com`
     (measured **401 ms** for the WASM alone; first Rive frame at **~460 ms**).
   - The canvas was `display:none` until a double-rAF after `onLoad`, so the CSS
     fallback painted first by design.
   - `__bootRiveDone` returned `false` whenever Flutter fired before Rive
     finished loading, so the placeholder was removed immediately (cut) instead
     of waiting for the lift.
   - Lift choreography put the birds *above* the sheet's top edge, so they
     exited the viewport in the first ~100 ms of the rise while the sheet kept
     lifting alone for the remaining ~700 ms.

## Changes

### `docs/web/index.html`
- **Self-hosted runtime.** `docs/web/rive.min.js` (215 KB, v2.44.0) and
  `docs/web/rive.wasm` (1.99 MB) vendored; `<script src="rive.min.js">` is
  synchronous in `<head>`; `rive.wasm` + `boot.riv` preloaded. `init()` calls
  `rive.RuntimeLoader.setWasmUrl('rive.wasm')` so no CDN is touched on the
  critical path. Measured resource times on cold load: `rive.min.js` 3 ms,
  `rive.wasm` **5 ms** (was 401 ms), `boot.riv` 3 ms; `__bootTimes`: parsed
  13 ms → `riveLoaded` **41.5 ms** → `firstFrame` **51.3 ms**.
- **Fallback hidden by default.** `#boot-rive` is `display:block` from first
  paint; `.boot-fallback` is `display:none` unless `#docs-first-paint` gets
  `.show-fallback` (runtime/.riv failure, no WebAssembly/canvas, or
  prefers-reduced-motion). `<noscript>` forces the fallback on. No `rive-on`
  class, no CDN, no `RIVE_CDN` anymore.
- **No-cut handover.** `OUTRO_MS = 1000` (150 ms blend + 800 ms lift + margin).
  `__bootRiveDone()` returns `true` while Rive is still loading and records
  `flutterFired`, so the flutter-first-frame listener does NOT remove the node;
  `onLoad` then fires the lift and schedules removal after the lift completes.
  If Rive failed it returns `false` and the caller removes immediately.
  Reduced-motion still fades out in 300 ms. Progress still drives only the thin
  bar (cap 90, 100 on ready).

### `docs/rive/boot/scene.rml` (both `BootDark` and `BootLight` lifts)
- Lift grip retargeted: birds dive DOWN to node y 510/520/520/550/550
  (visual ~650–690, lower sheet) at f12, hold to f15, then rise 960 px with the
  sheet to f48 with the existing ease-in-out
  (`CubicEaseInterpolator 0.42,0,0.58,1` on 15→48). X-gather, wing flap, texts,
  bar, and Page keyframes unchanged; duration still 48 f @60 fps + 150 ms
  blend ≈ 950 ms. Birds now ride the sheet for ~2/3 of the rise instead of
  exiting in the first ~100 ms. `rive --verify` clean; `boot.png` Wander frame
  unchanged.

### Support (not shipped in the web bundle)
- `scratchpad/rive/review3/`: `cold-load-fixed.webm` (1280x800, 16 s),
  `frames/` (8 fps extracts f001–f128), `contact.png` (3x3 sheet),
  `reduced-motion.png`.

## Frame evidence (8 fps extracts, `review3/frames/`, 1280x800, slow_server :8821, 6 s main.dart.js delay)

- **A (first paint + 0.2 s):** `f001` (t=0 s) shows the 5-bird Rive flock +
  `dashcn`/`Loading`/thin bar; no CSS fallback anywhere. `f002` (t=0.125 s,
  the 0.2 s check) shows the same flock. No `Loading docs…` text or single
  72 px bird in any motion frame (`f001`–`f042` all Rive).
- **B (birds move + carry):** flock positions differ `f001`→`f002`→`f020`→`f040`
  (Wander loop alive). Handover: `f042` full loader → `f043` birds gathered
  under the sheet, sheet rising, app sliver at bottom → `f044`/`f045` birds +
  sheet rising together, app bottom third/half → `f046` birds at the top with
  the sheet's top sliver, app almost full. Birds visible in **all 4** handover
  frames; sheet visible `f043`–`f046` (4 frames @8 fps = 500 ms ≈ 30 frames
  @60 fps, well over the 6-frame minimum), eased (slow ends, fast middle).
- **C (no cut):** placeholder present through `f046`; app progressively
  revealed `f043`→`f046`, fully visible `f047`; node removal fires
  `OUTRO_MS` (1000 ms) after `ready` (measured `liftFired`→`removed` Δ ≈ 1002 ms
  in the instrumented run). No single-frame jump from loader to app.
- **D (bar / reduced-motion / wiring):** thin bar only under `Loading` in
  `f001`–`f042` (no spinner overlay). `reduced-motion.png`: static CSS fallback
  (single bird, `Loading docs…`), canvas `display:none`, Rive never
  constructed. `flutter-first-frame` → `ready=true` → lift → delayed removal
  verified by `__bootTimes` (`liftFired` 6468.9 ms, `removed` 7470.8 ms).

## Exit codes
- `rive docs/rive/boot --verify` → **0** (0 errors, 0 warnings)
- `rive docs/rive/boot --once` → **0**; `cp build/boot.riv docs/web/boot.riv`;
  `md5` `docs/web/boot.riv` == `build/web/boot.riv` (`fc6951d5…`); same for `rive.min.js` / `rive.wasm`
- `cd docs && flutter build web --release --base-href /` → **0**
- `cd docs && flutter test` → **0** (All 869 tests passed, ~2:39)
- `bash tool/sync_registry.sh --check` → **0** (mirror up to date)
- `dart run tool/gen_docs_data.dart --check` → **0** (18 files up to date)

## Frames that still fail
None. Every required check passes on the frames above: flock from `f001`, motion
through the load, birds carrying the sheet through all handover frames, full app
only after the sheet is gone, thin-bar progress, static reduced-motion fallback,
and lift-gated removal.
