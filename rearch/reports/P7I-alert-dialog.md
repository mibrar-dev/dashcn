# P7I-alert-dialog report — alert dialogs open over the whole app, spacing fixed

## What changed

**`dashcn/lib/src/components/alert_dialog/alert_dialog.dart`** (398 lines)
- `AlertDialog.build` resolves gaps from the spacing scale: an explicit
  `AlertDialogTheme` field wins, otherwise `style.themeSpacing ?? ambient.spacing`
  supplies `iconGap = lg`, `headerGap = sm`, `footerGap = lg`, `actionGap = sm`.
- Wide header `Row` is now `CrossAxisAlignment.start`: the icon sits beside the
  title, top-aligned with its first line (was `center`, which sank the icon
  against title+description).
- Stacked rule is now card-outer `<= 480px` (was interior `< 360px`). Inside the
  route the `LayoutBuilder` measures the interior, so the resolved route padding
  is added back (`_routePaddingHorizontal`) to map onto the same outer width;
  the standalone shell measures the exterior directly. Unbounded width keeps
  the row. Result: 390px phone stacks full-width, 512px desktop card rows.
- Standalone shell: outside a `DialogRoute` (detected via
  `ModalRoute.of(context) is DialogRoute<dynamic>`) the widget paints the
  `DialogTheme` card itself — background, `borderRadiusLg`, border, `shadowLg`,
  `p-6` padding, capped at `dialogEffectiveMaxWidth` (512 default). Inside the
  route the content is returned bare: no double padding (asserted by test).
- `showAlertDialog` unchanged (already root navigator + barrier).

**`dashcn/lib/src/components/alert_dialog/alert_dialog_style.dart`**
- `alertDialogDefaults` gap fields are now null so they resolve against the
  ambient spacing scale; docs updated (`lg`/`sm` mapping). No public API change.

**`dashcn/lib/src/components/alert_dialog/preview.dart`**
- All five examples (names unchanged, order unchanged) are centred `_Trigger`
  buttons calling `showAlertDialog` (root navigator), exactly like
  `components/dialog/preview.dart`. Contents kept: circleAlert delete-account
  (destructive), triangleAlert discard-changes (destructive), clock session
  dialog with a live `_SessionCountdown` (90s ticker, Sign out / Stay signed
  in), circleCheck success (Done), Live push unchanged.

**`dashcn/lib/src/components/alert_dialog/README.md`** — standalone-shell
paragraph; theme table fixed (title 18px w600, gaps as spacing tokens,
footerGap 16 not 24); footer stacking note (<= 480px card).

**`dashcn/lib/src/components/alert_dialog/meta.json`** — description notes root
overlay + inline shell; gap/titleStyle fields document token resolution; added
`density` to `deps.theme` (required by `check_layers` for the new
`resolveEdgeInsets` import; same spelling as other components).

## Spacing values and where they come from

At the default base (`SpacingScale(4)` → xs 4 / sm 8 / md 12 / lg 16 / xl 24):
- Card padding 24 = `DialogTheme.padding` (`EdgeInsetsDensity.all(padMd)` =
  1.5 × 16), upstream `p-6`. Radius/border/shadow from `DialogTheme` /
  ambient tokens. UNVERIFIED against the live web CSS beyond the brief's
  mapping (p-6 / gap-4 / gap-2).
- `iconGap` 16 = `spacing.lg` (media-to-text gap); `headerGap` 8 =
  `spacing.sm` (title-to-description, upstream `gap-2`); `footerGap` 16 =
  `spacing.lg` (header-to-footer, upstream `gap-4`); `actionGap` 8 =
  `spacing.sm` (between buttons, upstream `gap-2`).
- Title 18px w600 `foreground`; description 14px `mutedForeground`; icon
  20×scaling `mutedForeground`. Footer `WrapAlignment.end` wide, stacked
  stretched at/​below 480px card-outer.

## Tests

- `test/registry/qa/alert_dialog_qa_test.dart` (rewritten): light+dark pump,
  centered-alignments kept, delete-trigger footer-gap test, live-push test via
  shared `_pumpExample` helper, 375px fit, and the required new test —
  **example opens in the root overlay with card insets**: nested inner
  navigator + root navigator, tap trigger, asserts `AlertDialog` present, root
  `canPop` true / inner `canPop` false, title inset ≥ 16px left+top from
  `kDialogSurfaceKey` card, every `Gap` inside > 0.
- `test/registry/components/alert_dialog_test.dart` (+`card shell` group):
  inline insets ≥ 16px, route has exactly one `Padding` under the surface (no
  double padding), actionGap resolves 8 from the scale.
- `test/registry/components/p7wa_overlays_test.dart`: header test now expects
  `start` alignment; stacking test renamed to the 480px rule (500 rows,
  300 stacks still pass).
- `test/registry/visual/p7wa_screens_test.dart`: `_AlertScene` is a trigger
  opening `showAlertDialog`, with an interact tap (design PNGs rewritten as a
  side effect; not my changes).
- `test/registry/qa/interactive_previews_test.dart`: alert test is now
  trigger-opens-dialog (this file was not in the brief's list but the framed
  API it drove no longer exists; minimal edit, same file).
- New `test/registry/visual/p7i_alert_dialog_captures_test.dart`: 4 captures.

## Captures (`rearch/screenshots/p7i-alert-dialog/`, background in boundary)

- `p7i-alert-dialog_light_1280x900.png` (2560×1800 @2x)
- `p7i-alert-dialog_dark_1280x900.png` (2560×1800 @2x)
- `p7i-alert-dialog_light_390x844.png` (780×1688 @2x)
- `p7i-alert-dialog_dark_390x844.png` (780×1688 @2x)
- PNG headers verified (magic + IHDR dims); images not opened per brief rule 8.

## Gates (final lines)

- kit format: `Formatted 1489 files (0 changed)`; docs format:
  `Formatted 1064 files (0 changed)`
- `gen_registry_manifest --check`: up to date; `gen_exports --check`:
  `exports are up to date (145 libraries checked)`; `gen_previews_test --check`:
  both files up to date (84 components); `gen_blocks_test --check`: up to date
  (16 blocks); `gen_scorecards --check`: up to date (84 components)
- `check_names.dart`: `check_names: 0 hits.`
- kit analyze lib + tests: `No issues found!`; docs `flutter analyze`:
  `No issues found!`
- `flutter test test/registry` (full, rerun after layers fix): `+5360: All tests
  passed! EXIT:0`
- `flutter test test/rearch` (via qa_gate): `+42: All tests passed!`
- `check_layers`: all errors 0 (`undeclared-dependency` fixed via meta.json);
  warnings only (`file-too-long` 54, `unused-dependency` 3, pre-existing;
  alert_dialog in neither offender list)
- `check_single_owner`: only `stepper/preview.dart:47`, `switcher/preview.dart:76`
  (other areas, pre-existing); `check_user_theme --strict`: 0 findings;
  banned grep: empty
- docs `sync_registry.sh --check`: up to date; `gen_docs_data.dart --check`:
  up to date (18 files); docs `flutter test test tool`: `+720 ~1: All tests
  passed! EXIT:0` (log: `rearch/logs/p7i-alert-dialog/docs-test.log`; the ~1
  skip is pre-existing)
- qa_gate.sh ran `EXIT:0`; note its `test:` summary line was garbled by its own
  `sed` (showed a test name, not the count) — superseded by the clean full-suite
  rerun above (log: `rearch/logs/p7i-alert-dialog/registry-test.log`)
- No processes left behind (`ps` by comm shows no flutter/dart); probe files
  removed; scratch only under `rearch/logs/p7i-alert-dialog/`

## RESULT
status: done
files_written: [/home/user/dashcn-kit-b/dashcn/lib/src/components/alert_dialog/alert_dialog.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/alert_dialog/alert_dialog_style.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/alert_dialog/preview.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/alert_dialog/README.md, /home/user/dashcn-kit-b/dashcn/lib/src/components/alert_dialog/meta.json, /home/user/dashcn-kit-b/dashcn/test/registry/qa/alert_dialog_qa_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/alert_dialog_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/p7wa_overlays_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/visual/p7wa_screens_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/qa/interactive_previews_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/visual/p7i_alert_dialog_captures_test.dart, /home/user/dashcn-kit-b/dashcn/lib/src/manifests/registry.json, /home/user/dashcn-kit-b/dashcn/lib/src/manifests/scorecards.json, /home/user/dashcn-kit-b/dashcn/test/registry/qa/previews_centered_test.dart, /home/user/dashcn-kit-b/rearch/screenshots/p7i-alert-dialog/p7i-alert-dialog_light_1280x900.png, /home/user/dashcn-kit-b/rearch/screenshots/p7i-alert-dialog/p7i-alert-dialog_dark_1280x900.png, /home/user/dashcn-kit-b/rearch/screenshots/p7i-alert-dialog/p7i-alert-dialog_light_390x844.png, /home/user/dashcn-kit-b/rearch/screenshots/p7i-alert-dialog/p7i-alert-dialog_dark_390x844.png, /home/user/dashcn-kit-b/rearch/reports/P7I-alert-dialog.md]
commands_run: [dart format (kit 1489, 0 changed) -> ok, dart format (docs 1064, 0 changed) -> ok, gen_registry_manifest + --check -> up to date, gen_exports --check -> 145 up to date, gen_previews_test --check -> 84 up to date, gen_blocks_test --check -> 16 up to date, gen_scorecards --check -> 84 up to date, check_names -> 0 hits, dart analyze kit lib+tests -> No issues, flutter analyze docs -> No issues, flutter test test/registry -> +5360 All passed EXIT:0, flutter test test/rearch -> +42 All passed, check_layers -> 0 errors, check_single_owner -> only pre-existing stepper/switcher, check_user_theme --strict -> 0, docs sync --check -> up to date, docs gen --check -> up to date, docs flutter test test tool -> +720 ~1 All passed EXIT:0, qa_gate.sh -> EXIT:0 with garbled test: line, superseded by rerun]
key_findings: [gaps now resolve from spacing scale (lg/sm) with AlertDialogTheme overrides winning; inline AlertDialog paints the DialogTheme shell, route path returns content bare (single Padding asserted); header icon top-aligned; footer stacks at/​below 480px card-outer with route-interior mapped back via padding; all five previews are root-navigator triggers with names kept; session countdown lives in a stateful description so it ticks inside the route]
open_questions: [p7wa design PNGs under rearch/design/ours/screens were rewritten by the suite run (expected side effect, not my changes); qa_gate test: line garbled by its sed — clean rerun log kept; single-owner stepper/switcher findings and the docs ~1 skip are pre-existing and outside this pass]
