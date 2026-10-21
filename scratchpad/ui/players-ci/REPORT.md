# players-ci REPORT — PR 51 CI fixes

Branch `feat/players-polish`, worktree `dashcn-w-audio`. Do NOT merge.

## CI failures fixed

1. `dashcn surface_guard_test: no direct solid surface paint without the surface primitive`
   - Flagged `components/audio_player/audio_player_expanded.dart:257` (details panel painted `colors.card` directly).
   - Fixed by routing both details surfaces through the primitive, navigation-bar parity:
     - `audio_player_expanded.dart` now imports `primitives/surface.dart`, resolves `surfaceOpacity`/`surfaceBlur` from `style.surfaceOpacity`/`surfaceBlur`, paints scrim (`cardBase.withAlpha(0xF2)`) and inner card (`cardBase`) via `surfaceColor`, wraps the panel in `GlassSurface`. Padding uses `EdgeInsetsDensity.pxAll(16)` resolved against `density.baseContentPadding * scaling`.
     - `video_player/video_player.dart` phone title overlay (previously `const Color(0x99000000)`) now resolves `style.scrim ?? 0x99000000` through `surfaceColor` + `GlassSurface`, padding via `EdgeInsetsDensity.pxSymmetric(horizontal:12, vertical:8)`. Frame border container has no fill (not a surface) and is untouched.
   - No allow-list entries added. `surface_guard_test` now 2/2.

2. `docs component_examples_test: every listed page renders one card per example` — `RenderFlex overflowed by 300 px on the right`, `audio_player`
   - Root cause was the title row, not the preview: `docs_article.dart:418` `Row(title Expanded, badges Wrap, actions)` measures non-flex children with unbounded width, so the badges `Wrap` never wrapped. The new WIP note (`Badge WIP` + `Text Work in progress…`, intrinsic 396 px) made badges 672 px wide, leaving `Expanded` title at 0×396 and overflowing by 300.
   - Fixed with density tokens + flexible layout:
     - `docs/lib/widgets/docs_article.dart`: wide branch wraps `badges` in `Flexible`, so the `Wrap` gets a bounded width and wraps instead of overflowing.
     - `docs/lib/pages/component_page.dart`: WIP note becomes `_WipNote` — `ConstrainedBox(maxWidth: density.baseContentPadding * scaling * 12)` (192 at default), `maxLines:1, overflow:ellipsis, softWrap:false`, styled with `docsText(size:12, mutedForeground)`.
     - Previews also made flexible so they fit at 375 and 1280: `dashcn …/audio_player/preview.dart` and `…/video_player/preview.dart` replace fixed `SizedBox(width:640/420/360/320)` with `_capped(max, child)` (`LayoutBuilder` picks `min(available, max)`); shared audio gap uses `baseGap * scaling * gapMd` (12 px). `docs/lib/media/live_audio.dart` uses the same `LayoutBuilder` clamp (was fixed 360) and density gap. `live_video.dart` already used `clamp(320,640)`.
   - `component_examples_test.dart` now 7/7 (including `every listed page…`).

3. `docs scorecards_page_test: no checks are exempt; every row passes`
   - `audio_player` had `androidTapTarget: false` (40×40 vs 48) and `iOSTapTarget: false` (40×40 vs 44) on shuffle/previous/next/repeat.
   - Fixed the component, not the test: `audio_player_expanded_transport.dart` `_transportButton`/`_toggleButton` now `minWidth/minHeight 48`, `SizedBox 48×48`. Transport `Row` becomes `Wrap(alignment:center, spacing:controlGap, runSpacing:controlGap)` (density gap 12) so 48 px targets + custom wide builders wrap instead of overflowing (fixes `custom builders replace parts` overflow by 16).
   - Regenerated `dashcn/lib/src/manifests/scorecards.json` (`dart run tool/gen_scorecards.dart`) — `audio_player` now `android/iOS: true` — then `docs/lib/generated/docs_scorecards.dart` (`dart run tool/gen_docs_data.dart`). No exemptions. `scorecards_page_test` now 4/4.

Kept from previous batch: disc rotation (20 s/turn, paused preserves angle), details on tap (disc opens panel with title/artist/album/duration/track number, dismiss via `dialogDismiss`), minimal slider behaviour (compact bottom-edge drag seek with time update, volume slider tap mapping).

## Verify

- `cd dashcn && flutter test test/registry/surface/surface_guard_test.dart` — 2/2.
- `cd dashcn && flutter test test/registry/surface` — 44/44 (includes `video_player control bar frosts`, `audio_player card frosts`).
- `cd dashcn && flutter test test/registry/components/audio_player_test.dart` — 28/28.
- `cd dashcn && flutter test test/registry/components/video_player_test.dart` — 31/31.
- `cd docs && flutter test test/scorecard/scorecards_page_test.dart` — 4/4.
- `cd docs && flutter test test/component_examples_test.dart` — 7/7.
- `dart format` changed files + `dart format --output=none --set-exit-if-changed lib test tool` (dashcn) and `lib test tool` (docs) — clean.
- `dart analyze` (dashcn, docs) — No issues found.
- `dart run tool/check_names.dart` (dashcn) — 0 hits.
- `dart run tool/gen_scorecards.dart --check`, `gen_exports.dart --check`, `registry/gen_registry_manifest.dart --check`, `registry/gen_previews_test.dart --check`, `registry/gen_blocks_test.dart --check` — clean (regenerated `registry.json`, `scorecards.json`).
- `bash docs/tool/sync_registry.sh --check`, `dart run tool/gen_docs_data.dart --check` (docs) — clean (regenerated `docs_example_sources.dart`, `docs_scorecards.dart`, mirror).

Browser rule: no audio played; no browser opened for this batch (previous batch already verified MP4/HLS/camera).

## PR

- https://github.com/mibrar-dev/dashcn/pull/51 (base `main`, no merge, no force-push).

Co-Authored-By: Claude Haiku 5.5 <noreply@anthropic.com>
