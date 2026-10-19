# FIX ROUND: Rive loader — REPORT-fix

Branch: `feat/rive-loader` (worktree `dashcn-rive`). No push. Local commit only.
Co-Authored-By: Claude Haiku 5.5 <noreply@anthropic.com>

## What changed

### `docs/rive/boot/scene.rml` (rewrote, 2141 lines, 128999-byte .riv)
- Artboards `BootDark`/`BootLight` now **1280x800** (was 400x440). Matches desktop 1:1, mobile via Cover crop (central slice).
- **5 brand birds**, not flat solids. Restored from `brand/svg/glyph.svg`: body gradient #47D4FF→#0562D2, wing #0B5BC9→#03398F, beak #E9F8FF→#2EE6D6, cheek #DDF5FF, eye white/pupil #0B1B33/highlight, crest #47D4FF/#2BB8F5, tails #0B5BC9. Fixed **radian bug**: old file used degrees (`rotation="146"`, `-10`, Node `-6/4/-3/6`, wing `±22`) where Rive wants radians (full turn 6.283). Converted: tail 146°→2.548, 166°→2.898, beak -10°→-0.1745, Node 0 (no banking spins), wing flap ±0.38–0.48 rad. Old flock rendered upside-down/small due to this.
- **Page sheet**: 1200x720 rounded 24 in page bg (#171717 dark / #FFFFFF light), 3 faint content lines (#262626 / #E5E5E5) at y400/430/460 + 4px top edge. Draw order fixed (lines front, sheet back; previous sheet covered lines). Covers viewport, lifts as one.
- Texts: wordmark 44px `dashcn` (#E5E5E5/#000000) at (640,560), Loading 20px at (640,610), bar track 320x10 + fill 312x6 (#47D4FF) at y652. Centred below birds.
- State machine `boot` (progress 0–100, ready bool). **No Intro** (Entry→Wander directly) so birds visible frame 1. Wander 180f loop: birds (640,280,0.85) (380,220,0.65) (900,230,0.65) (200,320,0.5) (1080,320,0.5) with ±90–140px loops/swoops + wing flap. Seamless (start=end). Progress layer BlendState1DInput drives **only BarFill scaleX** (0.04→1).
- Outro `Lift` **48f (800ms) + 150ms transition = ~950ms**. Grip at f12 (birds to top edge y70), hold to f15, lift -960px to f48 with **CubicEaseInterpolator ease-in-out (0.42,0,0.58,1)** on lift, ease-out on dive. No linear jumps. Page + texts + bar lift together, fade to 0 at end.

### `docs/web/index.html`
- Placeholder `position:fixed;inset:0`, canvas `absolute;inset:0;width/height:100%` fullscreen (was 300px centered). `rive-on` shows canvas, hides fallback.
- Rive `layout: Cover, center` (was Contain) + `resizeDrawingSurfaceToCanvas()` on load/resize. Canvas attrs 1280x800.
- **Start immediately, hide fallback on first frame**: `onLoad` grabs inputs + resize, then `double rAF → showRive`; `onPlay → showRive`. Ticker starts only on show. Old hid on `onLoad` (pre-first-frame).
- `__bootRiveDone` requires `shown`, sets progress 100 + ready true. `OUTRO_MS 950` (was 850).
- Reduced-motion: Rive never starts (kept), CSS static via media query (kept), **fade-out 300ms** on flutter-first-frame (new `.fade-out`).
- Kept: runtime `@rive-app/canvas@2.44.0` jsDelivr, `boot.riv`, artboard pick (data-theme else prefers-color-scheme), progress cap 90, 3s timeout, no slow-down shipped.

### Support (not shipped)
- `scratchpad/rive/slow_server.py` (new): `slow_server.py <dir> <port> [delay]` delays only `main.dart.js`. Used with `/tmp/slow_web` copy (6s) for capture. Repo `build/web` pristine.
- `scratchpad/rive/review/`: `cold-1280.webm` (546K, 1280x800), `cold-375.webm` (184K, 375x812), `contact.png` (94K), `frames-*/` (8fps extracts).

## Frame evidence (8fps extracts)

`cold-1280.webm` (34.7s, 278 frames @8fps), slowed `/tmp/slow_web` :8822, viewport 1280x800:
- **f001**: Rive flock visible **from first frame**. 5 brand birds (blue gradients, beak, eye, crest), `dashcn` + `Loading` (Rive text, not fallback `Loading docs…`). No CSS bird. Centred, spread x~150–1130, wordmark/bar centred below. Fixes A+B.
- **f005, f020, f030, f040**: birds move across viewport (central bird shifts, overlaps change, wing angles differ). Wander loop alive, not static. Fixes B.
- **f046**: lift mid-flight. Birds at top edge (gripping), sheet lifted ~400px, `dashcn`/bar lifting with it, Flutter app (`Every platform at once`, nav, cards) visible underneath at bottom. No cut.
- **f048**: sheet almost off-screen top (only bottom edge visible), app revealed underneath, birds+wordmark exiting top. Ease smooth, no jump. Fixes C.
- **f050, f060**: Flutter app fully revealed, placeholder removed, no flash. Fixes C.

`cold-375.webm` (20.3s, 162 frames), viewport 375x812:
- **g001**: Rive visible first frame. `dashcn` + `Loading` + bar centred below, birds centred. 2–3 birds visible (central slice; see plain note).
- **g020**: birds moved (central bird x shifted, right bird cropped differently). Wander across viewport.

Contact: `scratchpad/rive/review/contact.png` (f001,f005,f020,f040,f046,f048,f050,g001).

## Exit codes
- `rive docs/rive/boot --verify` → **0** (0 errors, 0 warnings)
- `rive docs/rive/boot --once` → **0**, `build/boot.riv` 128999 bytes, `cp` to `docs/web/boot.riv` (MD5 match)
- `cd docs && flutter build web --release --base-href /` → **0** (✓ Built build/web, 20.6s)
- Serve: `:8821` canonical `/` 200, `/boot.riv` 200; `:8822` slowed `/boot.riv` 200, `window.rive` true (eval), placeholder removed after load
- `cd docs && flutter test` → **0** (All 869 tests passed, ~2:24)
- `bash tool/sync_registry.sh --check` → **0** (mirror up to date)
- `dart run tool/gen_docs_data.dart --check` → **0** (18 files up to date)

## Plain: what still looks wrong
1. **Mobile shows 2–3 birds, not 5.** Cover on 375x812 shows central 369px of 1280 (29%). Outer birds (x200,1080) cropped. Centred, no `scrollWidth` overflow (canvas fullscreen), wordmark/bar centred below and visible in video (g001), wandering visible, but full flock only on desktop. Single fixed artboard cannot show 5-across on both landscape and portrait with Cover; Contain would letterbox and break “covers viewport”. Kept Cover + central safe area. If brief demands 5 visible on mobile, need responsive artboard or Fill (distorts brand – refused).
2. **Reduced-motion fade not in video.** Implemented (early return + `.fade-out` 300ms on ready, CSS static), manually checked `matchMedia reduce` true with Rive never started, but cold videos are motion-only. No frame proof.
3. **CLI `--viewport=375x812` screenshots missed text** (rendered black lower half). Browser Cover video (g001) shows text correctly. CLI previewer layout differs from browser `Cover`; trusted browser per verification spec.
