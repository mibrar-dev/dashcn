# players-polish REPORT — audio/video players polish (PR 51)

Branch `feat/players-polish`, worktree `dashcn-w-audio`. Do NOT merge
(PR open for review).

## What changed

Audio (`dashcn/lib/src/components/audio_player/`):

- `audio_player_controller.dart`: `AudioTrack` gains `album` and
  `trackNumber` (demo tracks filled in: Southern Roots/1, Sax Party EP/2,
  Raw Sessions/3).
- `audio_player_expanded.dart`: rewritten as stateful. Full 144 px disc
  centred fully inside the card (no half-circle crop); `_RotatingDisc`
  rotates one turn per 20 s while playing and stops (angle preserved) on
  pause. Tapping the disc opens a details panel on top of the card: title,
  artist, album, duration (`formatAudioTime`), track position (`n / total`,
  digits only so no new i18n strings), dismiss via localized
  `dialogDismiss`. Card gaps are the 12 px density token.
- `audio_player_expanded_transport.dart`: 12 px density gaps
  (`baseGap * scaling * gapMd`); buttons keep 40 px visuals with 32 px
  minimums so the row fits 386 px stages with custom content.
- `audio_player_compact.dart`: bottom-edge progress is now a draggable
  `_CompactSeekLine` (tap/drag seeks, RTL-aware, time labels update via the
  shared controller); 12 px density gap before the title; play button 32 px
  minimum.
- `audio_player_compact_parts.dart`: pill buttons and speed chip keep 32 px
  hit targets (`minWidth/minHeight 32`, visuals 32x48).
- `audio_player.dart` + `audio_player_style.dart`: 16 px density card
  padding (`EdgeInsetsDensity.pxAll(16)` expanded,
  `pxSymmetric(horizontal: 16)` compact).

Video (`dashcn/lib/src/components/video_player/`):

- `video_player.dart`: responsive `LayoutBuilder` (`<600 px` = phone).
  Phone: tap toggles controls (not play), title overlay hidden until tap,
  `_onPhoneTap` + `_ensureAutoHide` give 3 s auto-hide while playing.
  Desktop: tap toggles play, hover/enter shows, 3 s hide (unchanged).
- `video_player_controls.dart`: new `VideoMinimalBar` — single thin bar
  (play, draggable `VideoScrubBar`, time, fullscreen; 32 px targets, no
  header/speed/captions). Exported through the existing barrel; added to
  `meta.json` api classes.
- `meta.json`: +`VideoMinimalBar`; `registry.json` regenerated (hashes +
  class list only).

Docs (`docs/`):

- `widgets/docs_sidebar.dart`: audio/video entries show a `WIP` chip
  (semantics: "… WIP, Work in progress: bugs may occur.").
- `pages/component_page.dart`: audio/video headers show a `WIP` badge plus
  the visible text "Work in progress: bugs may occur.".
- Mirror (`lib/ui/dashcn/…`) and generated data refreshed
  (`sync_registry.sh`, `gen_docs_data.dart`); live real-source examples
  (`live_audio.dart`, `live_video.dart`) untouched.

Tests:

- `audio_player_test.dart`: +5 polish tests (album/track numbers, 144 px
  disc, details tap, compact drag-seek with time update, 32 px targets).
- `video_player_test.dart`: phone test now expects `VideoMinimalBar`;
  +5 polish tests (minimal bar contents, title-until-tap + tap toggles,
  3 s phone auto-hide, desktop tap-to-play, minimal scrub drag).
- New `test/registry/visual/players_polish_captures_test.dart`: 20 PNGs
  (see `captures/CAPTURES.md`).

## Captures

`scratchpad/ui/players-polish/captures/` (20 PNGs, dpr 2) + `CAPTURES.md`:

- audio compact / expanded / details x 1280x800 + 375x812 x light/dark (12).
- video desktop paused/playing x 1280x800 x light/dark (4).
- video phone paused/playing x 375x812 x light/dark (4).

Real-source verification (docs app wires MP4/HLS/camera; browser opened
for the check, then closed):

- MP4 `butterfly.mp4`: `readyState 4`, `duration 7.54`, `play()` ->
  `paused=false`, `currentTime` 1.00 -> 4.29 in 3 s (advances).
- HLS `x36xhzz.m3u8`: reachable (`networkState 2`, `canPlayType "maybe"`);
  Chrome takes the plugin-error path the docs app surfaces.
- Camera: docs `live_video.dart` shows the permission-denied fallback
  message via `webRequestCamera`.

## Gates

- `dart format` (kit `lib test tool`): clean (1 file reformatted).
- `dart analyze`: No issues found (kit + docs).
- `flutter test test/registry/components/audio_player_test.dart`: 28/28.
- `flutter test test/registry/components/video_player_test.dart`: 31/31.
- `flutter test test/registry/previews_test.dart`: 580/580
  (audio 6/6, video 6/6).
- `flutter test test/registry/i18n_guard_test.dart`: 2/2.
- `dart run tool/gen_scorecards.dart [--check]`: clean.
- `dart run tool/registry/gen_registry_manifest.dart [--check]`: clean.
- `bash tool/sync_registry.sh [--check]` (docs): clean.
- `dart run tool/gen_docs_data.dart [--check]` (docs): clean.
- `flutter test test/component_page_test.dart` (docs): 13/13.
- `flutter build web --release --base-href /dashcn` (docs): clean.

## PR

- https://github.com/mibrar-dev/dashcn/pull/51 (base `main`, no merge).
