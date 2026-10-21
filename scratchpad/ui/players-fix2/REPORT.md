# players-fix2 REPORT — audio_player preview overflow (PR 48)

## Overflowing widget
- `Column ← AudioExpandedCard ← AudioPlayerBody` (`dashcn/lib/src/components/audio_player/audio_player_expanded.dart`).
- Render tree (720x420 stage, neutral/light) showed `RenderFlex OVERFLOWING`, constraints `698x418`, children total `429` → overflow **11px on the bottom**.
- Height stack: cover `168` + gaps `12+12+6+12+8+12 (62)` + equaliser `16` + artist `~11` + title `~20` + progress `48` (TapTarget min on Android) + times `48` (speed-button FocusableTap min) + transport `56` = `429` vs `418` available.
- Failing examples: `Default`, `Expanded card`, `Customized` at stage size (all `full` variant). Phone (`375` wide, unbounded height) and `Shared playlist` (SingleChildScrollView) passed. Compact pill passed at stage/phone (SPEC `48px` height intact).

## Change
- `audio_player_expanded.dart` only (compact pill untouched, stays SPEC `48px`):
  - Density tokens: gaps from `Theme.of(context).density.baseGap * scaling` (`gap * gapMd` = 12, `gap * 0.75` = 6, `gap * gapSm` = 8 at default — same SPEC rhythm, now scales with theme instead of fixed sizes).
  - Cover window from same gap: `gap * 19` = `152` at default (was fixed `168`; saves 16, net `413` vs `418` with 5px spare). Half-circle crop position unchanged.
  - Row flex + truncate: artist/title wrapped in `Row > Expanded > Text(maxLines: 1, ellipsis)` (same contract as compact pill title); times text gets `maxLines: 1, ellipsis` (keeps existing `Expanded`).
- Merge `origin/main` (i18n #46, #49) into `feat/ui-players-fix`: kept players-fix structure (FocusableTap, speed menu, 56px play, glass stage, rotate icons) and applied main's `ComponentLocalizations` strings to it (play/pause/mute/download/speed/captions/skip/repeat/untitled/seek/errors); localized `VideoPlayerStage` errors; updated stale `audio_player_test` speed-menu expectation to `'Playback speed 1x, tap to change'`; regenerated `registry.json` (`gen_registry_manifest`), `scorecards.json` + harness (`gen_scorecards`), docs generated (`gen_docs_data`); mirrored resolved kit files into `docs/lib/ui/dashcn/...`.
- Previews test and expected sizes untouched.

## Test results
- `flutter test test/registry/previews_test.dart --plain-name "audio_player"` → **pass** (6/6: exports, unique, neutral/light, neutral/dark, claude/light, claude/dark).
- `flutter test test/registry/components/audio_player_test.dart` → **pass** (23/23, incl. 375px + 320px no-overflow, speed menu, 56px play, volume slider).
- `flutter test test/registry --plain-name "surface"` → **pass** (133/133).
- `flutter test test/registry/components/video_player_test.dart` → **pass** (26/26, merge guard).
- `dart format` on changed files → clean (1 file reformatted pre-merge; post-merge menu reformat synced to docs mirror).
- `dart analyze` (dashcn) → **No issues found!**

No merge to main. Branch `feat/ui-players-fix` ready for PR 48 review.
