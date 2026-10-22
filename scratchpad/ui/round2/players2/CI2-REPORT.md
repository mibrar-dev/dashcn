# CI2 — video_player scorecard tap-target fix (fix/players-alignment)

Branch `fix/players-alignment`, worktree `dashcn-w-players2`.
Notes folder `scratchpad/ui/round2/players2`, this file `CI2-REPORT.md`.

## Failing test

`docs/test/scorecard/scorecards_page_test.dart` — `no checks are exempt;
every row passes` failed with `video_player failures: Expected <0>, Actual <2>`.

## Which checks (measured, not guessed)

Dashcn harness (`flutter test test/scorecards --plain-name "video_player scorecard"`):

- `textContrast`: **passed** (no glass-bar contrast fix needed).
- `labeledTapTarget`: **passed**.
- `androidTapTarget`: **failed** — `Seek` node `Size(742.0, 24.0)`, expected
  `Size(48.0, 48.0)`.
- `iOSTapTarget`: **failed** — same node, expected `Size(44.0, 44.0)`.
- `semantics`: **passed**.

The task memo guessed "32 px control-bar buttons, or contrast on the glass
bar". Both guesses were wrong as measured: every bar button already reports
`48.0x48.0` (32 px visual + 48 px invisible hit area via `FocusableTap` /
`TapTarget`), and contrast passes. The only failing node is the `Seek`
slider (`VideoScrubBar`): `742x24`.

## Root cause

`VideoScrubBar` (`dashcn/lib/src/components/video_player/video_player_scrub.dart`)
built `Semantics > Focus > MouseRegion > GestureDetector > SizedBox(height: 24,
width: double.infinity)`. With no `TapTarget`, the semantics tap target is
the 24 px visual height, under both the 48 px (Android) and 44 px (iOS)
minima. `AudioProgressBar` already wraps its identical 24 px visual in
`TapTarget(minHeight: 48)` and passes; video was the only scrub/progress bar
missing it. (`slider` passes for an unrelated reason — its tappable node
merges to the full 800x600 stage — so it never exercised the 24 px path.)

## Fix (component, never the test)

- `video_player_scrub.dart`: import `TapTarget`; wrap in
  `Semantics > TapTarget(minHeight: 48) > Focus > … > SizedBox(height: 24, …)`
  (mirrors `AudioProgressBar`). Comment documents the 24 px visual / 48 px
  invisible hit area.
- Visuals unchanged: 32 px bar buttons stay 32 px with 48 px hits
  (`video_player_buttons.dart` untouched); scrub visual stays 24 px tall with
  a 4 px track; `TapTarget` is a no-op on desktop / under `shrinkWrap`, so
  desktop layouts are pixel-identical and only the mobile/test hit area grows.
- No test weakened: `scorecard_model.dart` exemptions still empty, harness and
  `scorecards_page_test.dart` untouched.
- Seek mapping unaffected: `_trackKey` stays on the inner 24 px `SizedBox`,
  so `_trackWidth` still measures the full bar width.

Measured after fix (temporary semantics dump, removed): `SEEK rect 742.0x48.0`
— full width preserved, height 48. No shrink-wrap regression (the
`width: double.infinity` from the QA1 fix holds under `TapTarget`'s centring
`Center`, exactly as audio demonstrates).

## Gates (each `flutter test` run one at a time)

- `flutter test test/scorecards --plain-name "video_player scorecard"` (dashcn):
  `androidTapTarget` + `iOSTapTarget` now `passed: true`.
- `flutter test test/scorecards` (dashcn): all pass (109 incl. harness).
- `flutter test test/scorecard` (docs): 11/11, incl.
  `no checks are exempt; every row passes`.
- `flutter test test/registry/components/video_player_test.dart
  test/registry/components/audio_player_test.dart` (dashcn): 59/59
  (video 31 + audio 28, incl. `minimal bar scrub seeks on drag`).
- `flutter test test/registry/previews_test.dart --plain-name video_player`:
  6/6; `--plain-name audio_player`: 6/6.
- `dart run tool/check_names.dart` (dashcn): 0 hits.
- `dart run tool/gen_scorecards.dart --check`, `gen_registry_manifest --check`,
  `gen_exports --check`, `gen_previews_test --check`, `gen_blocks_test --check`
  (dashcn): all up to date.
- `docs/tool/sync_registry.sh --check`: mirror up to date.
- `dart run tool/gen_docs_data.dart --check` (docs): 18 files up to date.
- `dart format lib test tool` (dashcn): 0 changed; (docs): 0 changed.
- `flutter analyze` (dashcn): No issues found; (docs): No issues found.

## Deliver

Regenerated (no hand edits to generated files):

- `dashcn/tool/gen_scorecards.dart` → `scorecards.json` (video_player a11y all
  true) + harness (unchanged, 97 components).
- `dashcn/tool/registry/gen_registry_manifest.dart` → `registry.json`
  (scrub file hash).
- `docs/tool/sync_registry.sh` → `docs/lib/ui/dashcn/.../video_player_scrub.dart`
  mirror.
- `docs dart run tool/gen_docs_data.dart` → `docs/lib/generated/docs_scorecards.dart`
  (video_player row 0 failures).

Files changed (5):

- `dashcn/lib/src/components/video_player/video_player_scrub.dart`
- `dashcn/lib/src/manifests/registry.json`
- `dashcn/lib/src/manifests/scorecards.json`
- `docs/lib/generated/docs_scorecards.dart`
- `docs/lib/ui/dashcn/components/video_player/video_player_scrub.dart`

- Browser rule: never played audio; headless `flutter test` only (no browser
  opened).
- Pushed to `fix/players-alignment` (no force-push). PR open, NOT merged.
