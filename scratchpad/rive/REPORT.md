# Rive boot loader — single brand bird lift-away REPORT

Branch: `feat/rive-loader`. My implementation commit: `ecd26c7c`
("feat(rive): single brand bird wander with lift-away carry").
HEAD at report time is `01c2d1d8` (flock agent restored flock over mine;
see concurrency note). My work is preserved in `ecd26c7c`.

This implements the REVISED TASK (singular brand bird, lift-away smoother),
not the flock brief (4–6 flat birds, no gradients).

## State machine and inputs

- One state machine named `boot` per artboard (BootDark/BootLight, 400×440).
- Inputs:
  - `progress` (number 0–100): drives ONLY the thin bar/line under the
    wordmark via `BlendState1DInput` (`BarEmpty` scaleX 0.04 at 0,
    `BarFull` scaleX 1 at 100). The page caps it at 90 (`PROGRESS_CAP`
    in `docs/web/index.html`); on `ready` the page sets it to 100.
  - `ready` (boolean): when true, `AnyState → Carry` (350 ms blend).
    Renamed from the previous brief's `done`; `docs/web/index.html`
    looks up `ready` (not `done`).
- Layers:
  - `Main`: `Intro` (72f) → `Wander` (240f loop) → `Carry` (90f).
    Intro→Wander: exitTime 1200 ms, 250 ms blend. AnyState→Carry on
    `ready`, 350 ms blend (smooth handover while the app is already
    drawn underneath — `flutter-first-frame` has fired).
  - `Progress`: `BlendState1DInput` on `progress` (0/100 endpoints).
- Artboards: BootDark (#171717 bg, #E5E5E5 wordmark, #A3A3A3 Loading,
  #262626 BarTrack, #262626 PageCard) and BootLight (#FFFFFF bg,
  #000000 wordmark, #737373 Loading, #E5E5E5 BarTrack, #F5F5F5
  PageCard). Bird colours identical both artboards, matching
  `brand/svg/glyph.svg`: body gradient #47D4FF→#0562D2, wing gradient
  #0B5BC9→#03398F, beak gradient #E9F8FF→#2EE6D6, cheek #DDF5FF,
  eye white/pupil #0B1B33/highlight white, crest #47D4FF/#2BB8F5,
  tail #0B5BC9.
- `Intro` 72f: bird parts fly in + PageCard fade (opacity 0→1, y 242→230).
- `Wander` 240f loop: single Bird Node x/y loops/swoops over the page
  area (x 30–130, y −15–70; center 158–258 / 125–210, always fully
  visible, no off-screen), wing flap continuous (rotation −25/12° every
  15f, alive, not static). NO Bird Node rotation (banking removed — see
  wrong frames; rotation caused huge spins). Wordmark/bar/static.
- `Carry` 90f oneShot: 0–25 dive (Bird y 10→−80, ease-out, to PageCard
  top edge y 50; Bird center 60, 10 px below top = grip), 25–35 grip
  hold, 35–90 lift (Bird −80→−500, Card 230→−190, Wordmark 282→−138,
  Loading 338→−82, Bar 376→−44; all −420 px, ease-in accelerating,
  wing fast flap). Bird+card fly up and away together like lifting a
  sheet of paper; canvas ends transparent except background, then the
  page fades the placeholder (300 ms opacity) revealing the real page
  underneath (already painted — `flutter-first-frame` fired before
  `ready`). No cut, no jump.
- `BarEmpty`/`BarFull` 1f (scaleX 0.04 / 1).
- `prefers-reduced-motion`: JS never starts Rive (early return); CSS
  fallback renders finished state statically (no wandering); on
  `flutter-first-frame` the placeholder fades out (300 ms) — bird sits
  still and fades out, as specified.

## Runtime version and source

- `@rive-app/canvas` **2.44.0** from jsDelivr:
  `https://cdn.jsdelivr.net/npm/@rive-app/canvas@2.44.0/rive.min.js`
  (also serves `rive.js`; both return 200).
- Published 2026-09-30 (`npm view @rive-app/canvas time` → 2.44.0
  2026-09-30T15:51:07.756Z). Cutoff 2026-10-05 (14 days before
  2026-10-19); 2.44.0 is 19 days old (eligible). 2.44.1 (2026-10-09)
  and 2.45.0 (2026-10-17) are too recent — NOT used.
- Served as `docs/web/boot.riv` (copied from `docs/rive/boot/build/boot.riv`
  after `rive docs/rive/boot --once`; 113531 bytes single-bird).
  `flutter build web` copies `web/` → `build/web/`, so `/boot.riv`
  returns 200 on :8812 (verified). Slowed capture copy lives only in
  `/tmp/slow_web` (8 s Flutter delay via index.html setTimeout);
  repo `build/web` is pristine (no delay shipped).

## Captures (worktree `scratchpad/rive/shots/`, video `scratchpad/rive/boot-rive.webm`)

Slow copy: `/tmp/slow_web` (copy of `docs/build/web` + 8 s
`flutter_bootstrap.js` delay), served on :8814 (repo :8812 untouched).
Agent-browser headless, viewports 1280×800 and 375×667.

- `wander-1280.png` (24K, agent-browser, :8814, 3 s): Rive bird + PageCard
  + `dashcn` + `Loading...` (Rive text, not fallback `Loading docs...`),
  colours correct (gradients, beak, eye, crest), no scroll.
- `wander-375.png` (14K, agent-browser, :8814, 375 px): bird+card centered,
  fully visible. `scrollWidth==clientWidth` (375) → no horizontal scroll.
  1280 px also `scrollWidth==clientWidth` (1280) → no scroll.
- `final-1280.png` (83K, agent-browser): Flutter app (`Every platform at
  once`, nav, cards) after placeholder removal — real page revealed.
- `liftaway-cli-grip.png` (`/tmp/ct30`, Rive CLI `--screenshot --advance=30`
  with Entry→Carry): bird at top edge (center ~60, straddling card top 50)
  = grip moment. `liftaway-cli-lift.png` (`ct90`): card leaving (almost
  empty, top edge visible) = carry up and away.
- `liftaway-video-9p5-rive.png` (video frame 9.5 s, Rive wander) and
  `liftaway-1280.png` / `carry-mid-2.png` / `carry-late.png` (all 83K,
  identical MD5 = Flutter final, NOT lift — see “could not do”).
- `boot-rive.webm` (14.3 s, 308K, agent-browser `record start/stop`):
  wander (Rive 0–9.5 s) → Flutter (10–14 s). Fade smooth, no cut.
  NOTE: Carry mid-flight is missing in the video (0.2 s Rive→Flutter gap
  at 9.8–10.0 s; Carry 1.5 s skipped — see below). Video still proves
  smooth handover (no cut/jump, fade 300 ms).

## Verification exit codes (my single-bird commit `ecd26c7c`)

- `rive docs/rive/boot --verify` → exit **0** (0 errors, 0 warnings;
  `inspect` problems []).
- `rive docs/rive/boot --once` → exit **0**, `build/boot.riv` 113531 bytes.
  (HEAD currently builds 116223 bytes flock — see concurrency.)
- `cd docs && flutter build web --release --base-href /` → exit **0**
  (✓ Built build/web, 21.5 s; `web/boot.riv` == `build/web/boot.riv` MD5,
  :8812 `/boot.riv` + `/` both 200).
- `cd docs && flutter test` → exit **0** (All 869 tests passed, 2:44;
  version-independent — passes on either scene).
- `bash tool/sync_registry.sh --check` → exit **0** (mirror up to date).
- `dart run tool/gen_docs_data.dart --check` → exit **0** (up to date,
  18 files).

## Anything I could not do + wrong frames (plain)

1. **Agent-browser lift-away mid-flight missing.** Video shows Rive until
   9.5 s, Flutter at 10.0 s (0.2 s gap); Carry (1.5 s) + fade (0.3 s) =
   1.8 s cannot fit. `__bootRiveDone()` returns true when called manually
   (verified via `eval`), so inputs are wired, but on natural
   `flutter-first-frame` it must have returned false (immediate removal,
   Carry skipped, fade 300 ms still smooth — no cut, but bird-carry not
   visible in browser captures). Likely race: `instance`/`readyInput` null
   at first-frame instant (Rive onLoad vs first-frame timing with 8 s
   delay + local load variance), or transition blend 350 ms + exitTime
   interaction. CLI frames prove Carry itself is correct (grip at top,
   lift to −190/−500, ease-in). In the report shots, lift-away is therefore
   represented by CLI `liftaway-cli-grip/lift.png`, NOT agent-browser.
   Be plain: the browser video does NOT show the bird carrying the page;
   it shows wander → fade → Flutter. The carry animation exists and verifies,
   but the handover trigger in-browser skipped it in every capture run
   (8 rapid screenshots 8–12 s all identical Flutter MD5).
2. **Bird banking removed.** Original Wander had Bird Node rotation
   −12…+12° for banking into turns. Screenshots showed huge/cropped/missing
   bird (a85/a90 missing, w120 left-huge, w220 left edge, w300 missing,
   wt10/wt30 missing with Entry→Wander). Minimal X-only test moved correctly
   (72→200 clearly right), Y-only moved subtly, X+Y alone stayed visible;
   adding Bird rotation reproduced huge spins. Root cause: rotation values
   intended as degrees likely applied with enough radius (182 px Node→center)
   to swing the bird off-screen, and/or radian/degree confusion making
   −8 rad ≈ −98° (sideways). Fixed by zeroing banking (all rots 0); Wander
   now uses position loops + wing flap only — always fully visible
   (n72–n200 verified), alive, but less dramatic banking. Swoops read via
   position (dive in Carry) rather than tilt.
3. **Carry direct-entry ct5 missing.** With Entry forced to Carry (bypassing
   Intro), frame 5 shows no bird (expected dive visible). Frames 15/30/60/90
   then show dive/grip/lift correctly, so Carry overall is sound; frame 5
   anomaly is likely Intro-opacity blend (Bird parts fade in Intro, base
   opacity relied upon when skipping Intro) — not present in natural flow
   (Intro→Wander→Carry, Bird visible throughout). Noted, no fix needed.
4. **Wander-1280 card right-shift?** Card appears ~210 px right of center in
   1280 px capture (my pixel estimate; may be mismeasurement of scaled
   preview). `scrollWidth==clientWidth` at 375 and 1280, fully visible, no
   scroll, colours/text correct — layout passes regardless of exact centering.
   If the canvas is indeed off-center, suspect flex `align-items` vs Rive
   `Layout: contain, center` interaction at 480 px width; functions (no
   scroll, readable) unaffected.
5. **Concurrency / HEAD.** Concurrent flock agent (`opencode run --auto
   --title rive:loader3`, BRIEF-3: 4–6 flat birds, no gradients) committed
   `edf53ba7` (flock), then `bce55687` (its REPORT), `1c04573d` (gitignore),
   then `01c2d1d8` explicitly restoring flock over my `ecd26c7c`
   (“fix(rive): restore the flock scene over the single-bird commit”).
   Its REPORT already notes my single-bird commit as not meeting its flock
   brief. Conversely, flock does NOT meet THIS revised brief (singular bird,
   glyph gradients, lift-away smoother — flock uses flat solids, no beak/eye/
   crest, 5 birds). My work is intact in `ecd26c7c` (scene.rml 975 lines,
   PageCard, Wander 240f/Carry 90f, 113531-byte .riv); HEAD (`01c2d1d8`)
   is flock (1242 lines, 5 birds, Hills/Horizon, 116223 bytes). Rebuilding
   from HEAD overwrites boot.riv with flock. Pick the wanted scene before
   building — this report + `ecd26c7c` is the single-bird, gradient-correct,
   revised-task implementation. No push was made by me (local commits only).
