# players-fix3 REPORT — PR 48 kit CI i18n guard (feat/ui-players-fix)

Branch `feat/ui-players-fix`, worktree `dashcn-w-playersfix`. Do NOT merge.

## 1. Sync with main

`git fetch origin main` + `git merge origin/main` → "Already up to date"
(`origin/main` is an ancestor of HEAD; the earlier `baed53909` merge already
brought in the i18n work #46/#49). No rebase, no force-push.

## 2. `i18n_guard_test.dart` findings (before fix)

- 3 violations, all in `components/video_player/video_player_sources.dart`
  (`label: 'Online MP4'`, `label: 'Live stream'`, `label: 'Live feed'`):
  the branch split `demoVideoSources` out of `video_player_controller.dart`
  into `video_player_sources.dart` without moving the allow-list entries.
- 4 stale allow-list entries: the 3 `video_player_controller.dart` entries
  (file no longer contains those strings) plus
  `video_player_menu.dart :: 'Speed ${s}x'` (the line now reads
  `'Speed ${formatVideoSpeed(s)}x'`, which never matched).

## 3. Strings moved to locale tables

- `LIVE` badge (`video_player_header.dart`): the only remaining hardcoded
  real UI string in either player (found by a multiline-`Text(` sweep; the
  line-based guard cannot see it). New key `mediaLiveBadge` on
  `ComponentLocalizationsMedia` (`localizations_media.dart`), English
  default `'LIVE'`; widget now reads
  `ComponentLocalizations.of(context).mediaLiveBadge` (stays inside
  `ExcludeSemantics`). Overrides added to all 16 required-locale tables
  (`ar he fa ur de fr es it pt nl ru tr ja ko zh hi`; `pt-BR`/`zh-Hans`
  inherit from `pt`/`zh`), derived from each locale's existing in-repo
  `blockLive` value (uppercased for cased scripts, e.g. fr `EN DIRECT`,
  ru `ВЖИВУЮ`, ar `مباشر`). English render is unchanged, so the existing
  `find.text('LIVE')` expectations still pass.
- `AudioProgressBar` semantics valuetext now uses the locale-aware
  `formatAudioTimeValuetextIn(context, …)` (existing `mediaPositionOf` /
  `mediaHours|Minutes|Seconds` keys) instead of the English-only
  `formatAudioTimeValuetext`, matching `VideoScrubBar`. No new keys.

Everything else in `audio_player` / `video_player` (play/pause, mute,
skip, shuffle, repeat, download, seek, volume, fullscreen, captions,
speed, quality, untitled, playback-failed + retry) already read
`ComponentLocalizations`; no change needed.

## 4. Allow-list changes (`test/registry/i18n_guard_test.dart`)

- Removed the whole `video_player_controller.dart` block (3 stale entries).
- Removed the stale `'Speed ${s}x'` entry from the `video_player_menu.dart`
  block (the other 4 entries still match and stay: they are
  optional-strings fallbacks whose internal call sites always pass locale).
- Added a `video_player_sources.dart` block with the same 3 demo-source
  entries (`'Online MP4'`, `'Live stream'`, `'Live feed'`) and the
  sample-content reason (`demoVideoSources` docs-sample doctrine). No
  allow-list entries were added for real UI text.

## 5. Completeness test + generated artifacts

- `i18n_locale_completeness_test.dart` (GENERATED file; no generator exists,
  hand-edited the 2 key lists): added `mediaLiveBadge` to `_valueA` and
  `kLocaleKeys` (non-parameterized, so no `_valueB` entry). Test rewrote
  `dashcn/LOCALE_REPORT.md` (493 → 494 keys).
- Regenerated: `locale_tables.json` (`gen_locale_manifest`, 491 keys, 17
  `mediaLiveBadge` entries), `scorecards.json` + harness
  (`gen_scorecards`), `registry.json` (`gen_registry_manifest`),
  `previews_test.dart` + centered QA (`gen_previews_test`), blocks tests
  (`gen_blocks_test`); docs `sync_registry.sh` + `gen_docs_data.dart`.
  All `--check` modes pass; `registry.json` diff is only the two changed
  component file hashes, `scorecards.json` diff is timestamps/timings.

## 6. Test results

- `i18n_guard_test.dart`: 2/2 pass.
- `i18n_locale_completeness_test.dart`: 33/33 pass.
- `previews_test.dart --plain-name audio_player`: 6/6; `--plain-name
  video_player`: 6/6 pass.
- `audio_player_test.dart` + `video_player_test.dart`: 49/49 pass.
- `i18n_captures_test` + `i18n_rtl_test` + `localizations_error_test`:
  30/30 pass.
- `flutter test test/registry`: 6375/6375 pass.
- `flutter test test/rearch`: 42/42; `test/tool` + `test/scorecards`:
  134/134 pass.
- `dart format --set-exit-if-changed lib test tool`: clean (kit + docs).
- `dart analyze` / `flutter analyze`: no issues (kit + docs).
- `dart run tool/check_names.dart`: 0 hits.
- Layer / single-owner / user-theme guardrails: pass.
- Docs `flutter test test tool`: 950 pass, 1 skip (pre-existing).
- `scratchpad/ui/i18n/` capture PNGs regenerated on demand, not committed.
