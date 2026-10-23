# REPORT — audio/video players spacing + alignment (fix/players-alignment)

Branch `fix/players-alignment`, worktree `dashcn-w-players2`.
Notes folder `scratchpad/ui/round2/players2`.
Sizing source `scratchpad/ui/design/SIZING.md` followed exactly: every size
below is from the 4px scale (4, 8, 12, 16, 24) and theme tokens. Same sizes
on desktop and mobile; touch comfort from invisible hit areas (progress
2px visual / 12px hit, volume slider 36px visual / 48px touch hit), never
larger visuals.

## 1. Audio compact pill — 36px controls in 48px pill, 12px padding

Before:
- Controls 32x48 visuals (`audioPillButton`, `AudioSpeedChip`,
  `_iconPlay`: `SizedBox 32x48`, `minWidth/minHeight 32`), icons 18
  (pill buttons) / 20 (play), card padding 16 horizontal, gap 12 before
  title only (0 between volume/speed/download), seek line left/right 16,
  Row height 43 (48-5 padding bottom).

After (measured via `flutter test`, layout px):
- Pill `394.0x48.0` (in 420 stage; 48 height includes border).
- Controls `36.0x36.0` (play, mute, speed `1x`, download — all four).
- Card padding 12 horizontal (`EdgeInsetsDensity.pxSymmetric(horizontal: 12)`;
  seek line `left/right 12`, seek width `370.0` = 394-24).
- Icons 16 (`audioPillButton size 16`, `_iconPlay style.iconSize ?? 16`).
- Gaps 8 (`controlGap = baseGap * scaling * gapSm` = 8; 8 between
  title/volume/speed/download; 4 inside time cluster elapsed/total).
- Times (12px tabular) + title (13px medium) vertically centred
  (`Row crossAxisAlignment center`, controls row `SizedBox height 36`
  centered in 48 via `Center`).
- Slider draggable: `_CompactSeekLine` tap/drag seeks RTL-aware, time
  labels update (test `compact progress line seeks on drag` passes;
  `compact volume slider maps taps to position` passes).

Files:
- `audio_player_compact.dart`: 36x36 play, 8px gaps, centred 36 row in 48.
- `audio_player_compact_parts.dart`: 36x36 buttons, icons 16, slider
  64x36 visual (48 touch hit via `TapTarget`).
- `audio_player.dart`: compact padding 16→12 horizontal.
- `audio_player_style.dart`: defaults `padding` removed (null) so
  per-variant fallback applies (12 pill / 16 card); theme override intact.

## 2. Audio expanded card — 16px padding, disc inside, centred lines

Before:
- Padding 16 horizontal + patch adds 16 vertical (effective 16 all, but
  defaults declared 16 horizontal only).
- Disc 144 fully inside (already).
- Transport gaps 12 (`gapMd`), big play 56 (`style.controlSize ?? 56`,
  icons 24, `min 56`), secondary icons 18, artist/title gap 6 (not in
  scale).

After (measured):
- Padding 16 all (`pxAll(16)` fallback; `pxSymmetric(horizontal: 12)` pill
  only). Nothing touches card edge (transport `Wrap` centred, disc 144
  centred with 16px clearance).
- Disc `144.0x144.0` fully inside (test `expanded disc sits fully inside`
  passes).
- Title, artist, times centred on one centre line (`textAlign center`,
  `Column crossAxisAlignment stretch`; times Row balances 32px spacer vs
  32px speed button so times stay centred).
- Times row + `1x` speed on one baseline (both 12px, centred in 32px row;
  same y).
- Controls row centred with 8px gaps (`gapSm` = 8), large play `48.0x48.0`
  (measured), icons 16.
- Artist/title gap 4 (was 6, not in scale; 4 inside compound per SIZING).

Files:
- `audio_player_expanded_transport.dart`: gaps 12→8, big play 56→48,
  icons 18→16.
- `audio_player_expanded.dart`: xsGap 6→4, comments updated.
- `audio_player_metrics.dart`: all densities unified (36/36/16, padding 12,
  track 4, title 13 / subtitle 12 / time 12) — same sizes desktop/mobile.
- `audio_player_style.dart` + `meta.json`: padding/controlSize/iconSize
  docs updated (12 pill / 16 card; 36 pill / 48 card; 16 icons).

## 3. Video player — 32px buttons, 8px gaps, 12px bar, baseline, 56 centre

Before:
- Bar buttons 32 visuals with variable hits (48 wide / 32 narrow),
  gaps 0, padding 10h/6v compact, header `Row center` (title Column +
  time, no baseline; subtitle crowds time), centre 64, menu padding 8h/6v
  (6 not in scale), spacing 6 (not in scale), menu chip padding 10h/4v,
  minimal bar hits 32, gaps 8/8/4 (4→8 needed), phone title overlay unchanged.
- User screenshot: time + dot overlapping title area (header centre with
  2px header-scrub gap, no baseline, time centred in 2-line block).

After (measured):
- Bar buttons visual `32x32` (`videoIconButton` child), hit `48.0x48.0`
  (measured back/forward/fullscreen 48x48 on touch; desktop layouts stay
  32 via `TapTarget`), gaps 8 (added `SizedBox 8` between all bar buttons;
  volume cluster icon-slider gap 8), bar padding 12 all
  (`VideoPlayerMetrics.controlsPadding = pxAll(12)` all densities).
- Title block + time same baseline (`Row crossAxisAlignment baseline,
  textBaseline alphabetic`: title 14 + time 12 in one Row; subtitle +
  LIVE chip below with 4px top gap, 8px subtitle-chip gap; long titles
  ellipsize, time fixed, no overlap).
- Minimal bar same sizes (visuals 32, hits 48, gaps 8, padding 12;
  fullscreen gap 4→8).
- Centre play `56.0x56.0` (measured `barPlay` first `Play` = centre 56;
  metrics `controlSize` 64→56 all densities).
- Header-scrub gap 2→8, scrub-buttons gap 0→8 (8 between controls).
- Menu (open popup): margin top 4→8, padding 8h/6v→8h/8v, spacing 6→8,
  chip padding 10h/4v→12h/8v (all in scale).
- Captions on: overlay above bar (unchanged position, `bottom 64`).
- No overlap: title `Expanded` ellipsis + time fixed + subtitle/chip below;
  verified in captures (desktop + phone, light/dark).

Files:
- `video_player_metrics.dart`: all densities 56/16/pxAll(12)/4/12.
- `video_player_controls.dart`: gaps 8, always 48 hits, header/scrub/buttons
  8px rhythm, minimal bar 48 hits + 8 gap.
- `video_player_header.dart`: baseline Row + subtitle/chip below.
- `video_player_menu.dart`: 8px paddings/spacings, 12h/8v chips.
- `video_player_volume.dart`: 8px icon-slider gap, centred row.
- `video_player_buttons.dart`: comment 64→56.
- `meta.json` + `preview.dart` (custom `controlSize` 64→56): docs updated.

## 4. Every example, both themes

- Audio 6/6 previews pass (`previews_centered_test --plain-name audio_player`):
  Default, Compact, Expanded card, Shared playlist, Phone width, Customized.
- Video 8/8 previews pass (`previews_centered_test --plain-name video_player`):
  Default, Live stream, Camera fallback, Speed menu open, Captions on,
  Bar hidden, Phone width, Customized.
- `previews_test --plain-name audio_player` 6/6, `--plain-name video_player`
  6/6 (neutral/claude × light/dark).
- No overflow in any example (centered QA + 320px/375px phone guards pass).

## 5. Captures (32 PNGs, dpr 2)

Folder `scratchpad/ui/round2/players2/captures/`:

- Audio (1280x800 + 375x812 × light/dark = 4 each):
  `audio_compact_closed`, `audio_compact_volume_open` (OPEN: volume slider),
  `audio_expanded_closed`, `audio_expanded_speed_open` (OPEN: speed menu),
  `audio_details_open` (OPEN: tap disc → details panel).
- Video desktop 1280x800 × light/dark (2 each):
  `video_desktop_closed`, `video_desktop_menu_open` (OPEN: more menu),
  `video_desktop_volume_open` (OPEN: volume slider),
  `video_desktop_captions_on` (OPEN: captions overlay + enabled toggle).
- Video phone 375x812 × light/dark (2 each):
  `video_phone_closed` (minimal bar + title overlay),
  `video_phone_playing` (minimal bar pinned, auto-hide verified by test).
- Swiped rows: N/A (players have no swipeable rows; no swipe UI to capture).
- Harness: `dashcn/test/registry/visual/players_alignment_captures_test.dart`
  (temporary, removed after capture; asserts `takeException() isNull` per
  scene so every PNG is overflow-free). Before PNGs: see
  `scratchpad/ui/players-polish/captures/` (prior 20 PNGs, unchanged).

Measured px cross-check (from widget tests, layout px):
- Compact pill 48 high, controls 36, padding 12, icons 16, seek 370 wide
  (12 insets).
- Expanded disc 144, big play 48.
- Video centre 56, bar hits 48 (visuals 32), bar padding 12, gaps 8.

## 6. Gates (each `flutter test` run one at a time)

- `dart format lib test tool` (dashcn): 5 files reformatted, then clean.
- `flutter analyze` (dashcn): No issues found.
- `dart run tool/check_names.dart`: 0 hits.
- `flutter test test/registry/components/audio_player_test.dart`: 28/28.
- `flutter test test/registry/components/video_player_test.dart`: 31/31.
- `flutter test test/registry/previews_test.dart --plain-name audio_player`:
  6/6; `--plain-name video_player`: 6/6.
- `flutter test test/registry/qa/previews_centered_test.dart
  --plain-name audio_player`: 6/6; `--plain-name video_player`: 8/8.
- `flutter test test/registry/visual/players_polish_captures_test.dart`:
  20/20 (old harness still green; its PNGs reverted, not committed).
- `flutter test test/scorecards/`: all pass (audio + video scorecards pass
  tap targets, RTL, frames).
- Regenerated + `--check` clean:
  `gen_scorecards.dart`, `registry/gen_registry_manifest.dart`,
  `gen_exports.dart`, `registry/gen_previews_test.dart`,
  `registry/gen_blocks_test.dart`, docs `sync_registry.sh`,
  `gen_docs_data.dart`.
- `dart format lib test tool` (docs): 0 changed.
- `flutter analyze` (docs): No issues found.
- `flutter test test/component_page_test.dart` (docs): 13/13.
- `flutter build web --release --base-href /dashcn/` (docs): ✓ Built
  build/web (pre-existing MaterialIcons/CupertinoIcons tree-shake note only).
- Browser rule: never played audio; headless captures via `flutter test`
  only (no browser opened). Docs live MP4/HLS/camera already verified in
  players-polish REPORT; not re-played here.

## 7. Deliver

- Pushed to `fix/players-alignment` (no force-push). PR open, NOT merged.
