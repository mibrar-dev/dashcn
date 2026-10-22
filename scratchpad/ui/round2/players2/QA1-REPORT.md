# QA1 — expanded audio slider track invisible (fix/players-alignment)

Branch `fix/players-alignment`, worktree `dashcn-w-players2`.
Notes folder `scratchpad/ui/round2/players2`, this file `QA1-REPORT.md`.

## Finding

`audio_expanded_closed_1280x800_dark.png` (and the user's earlier
screenshot) showed only a floating white dot for the expanded progress
slider: the track and the played portion were invisible. The same
floating-dot symptom was visible in `video_desktop_closed_1280x800_dark.png`.
The compact pill bottom line (`_CompactSeekLine`, `ColoredBox`-based) was
visible, so the bug was specific to the two `CustomPaint` sliders.

## Root cause

Both `AudioProgressBar` (`audio_player_progress.dart`) and `VideoScrubBar`
(`video_player_scrub.dart`) built:

```dart
SizedBox(height: 24, child: CustomPaint(...))
```

`CustomPaint` with no child has zero intrinsic width. In a loose-width
parent it therefore sizes to 0 px wide:

- Video: `Column` defaults to `crossAxisAlignment.center`, so `_scrub`
  gets loose `maxWidth` and the `SizedBox` shrink-wraps to 0 px. The
  0 px track is centred in the bar, leaving only the thumb dot visible.
- Audio expanded: the same `SizedBox` sits inside `TapTarget`, which on
  touch/mobile platforms (including `flutter test`, where
  `defaultTargetPlatform` is Android) wraps the child in
  `Center(widthFactor: 1, heightFactor: 1)`. The `Center` loosens the
  tight `Column stretch` width, so the bar again shrink-wraps to 0 px
  (floored to the 48 px touch minimum) with the thumb centred.

A secondary visibility issue: the expanded track defaulted to the
`secondary` token (`#F5F5F5` on a white card, `#262626` on a
`#171717` card — ~4 % and low-contrast deltas), and the video fill
defaulted to `primary` (black in light theme on the always-dark scrim),
so even at full width the colours were wrong per the QA directive.

## Fix

Layout (both sliders):

- `SizedBox(height: 24, width: double.infinity, ...)` in
  `audio_player_progress.dart` and `video_player_scrub.dart`, so
  `CustomPaint` fills the available width in loose parents and under
  `TapTarget`'s centring `Center`.

Tokens (all three sliders use the same pair):

- Inactive track from the `border` token, active fill/thumb from the
  `foreground` token, 4 px tall, full width inside the card's 16 px
  padding, thumb (`r=4`, centred at `cy`) on the track.
- Audio expanded (`audio_player_expanded.dart` `_progress` +
  `_equaliser` defaults): `track ?? colors.border`, `buffered ?? colors.muted`,
  `fill/thumb = fg` (cardForeground), `trackHeight ?? 4`.
- `audioPlayerDefaults.track`: `secondary` → `border`; meta.json track docs
  updated to `border`.
- Compact pill (`audio_player_compact.dart`): `_CompactSeekLine` now takes
  `track` (border) + `fill` (fg, foreground) instead of
  `fg.withAlpha(0x24)` + `primary`. Volume `_MiniLevel`
  (`audio_player_compact_parts.dart`) now takes `track` (border) + `fill`
  (fg) instead of `fg.withAlpha(0x3D)`.
- Video bar (`video_player_controls.dart` desktop `_scrub` + `VideoMinimalBar`):
  `track/border`, `buffered/border`, `fill: accent ?? fg`,
  `thumb: thumb ?? fg` (fg is white on the dark scrim in both themes),
  `trackHeight` from metrics (4). `videoPlayerDefaults`: `track/border`,
  `buffered/border`, `accent/white` (was primary black-in-light, invisible
  on the scrim); meta.json updated to `border` + foreground.

## Captures (re-captured, dpr 2, checked)

Folder `scratchpad/ui/round2/players2/captures/`, harness
`dashcn/test/registry/visual/players_qa1_captures_test.dart`
(temporary, removed after capture; asserts `takeException() isNull`):

- `audio_expanded_closed_1280x800_dark.png` — track full width, white
  active ~29 % (1:12 / 4:05), thumb on track, faint border inactive.
- `audio_expanded_closed_1280x800_light.png` — same with black active on
  white card, light-grey border inactive.
- `audio_expanded_closed_375x812_dark.png` — same at phone width, no
  overflow.
- `audio_expanded_closed_375x812_light.png` — same at phone width, no
  overflow.

All four checked in this session: the track and played portion are now
visible in both themes, 4 px tall, full width inside the 16 px card
padding, thumb centred on the track.

## Gates

- `dart format lib/src/components/audio_player lib/src/components/video_player`:
  0 changed (one intermediate format applied during the fix).
- `dart analyze lib/src/components/audio_player lib/src/components/video_player`:
  No issues found.
- `flutter test test/registry/components/audio_player_test.dart`: 28/28
  (includes `compact progress line seeks on drag`, `expanded disc sits
  fully inside`, `compact speed and volume keep 36px visuals`).
- `flutter test test/registry/components/audio_player_test.dart
  test/registry/components/video_player_test.dart`: audio 28/28, video
  31/31 (run together after the fix; no regressions from the shared token
  change).
- Browser rule: never played audio; headless captures via `flutter test`
  only (no browser opened).

## Deliver

- Pushed to `fix/players-alignment` (no force-push). PR open, NOT merged.
