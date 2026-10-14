# P7I-fix-kit report — merged P7 + dashcn tree green (kit tests)

Worktree `dashcn-kit-b`, branch `integrate/p7-into-dashcn` (merge in progress,
fully resolved, no markers). No git state-changing commands run. No processes
left behind (background suite PID 24344 exited; `kill -0` confirmed DONE).
No scratch files outside `rearch/logs/`.

## 1. `form_mount_validation_test`: "initial validators still run at mount"

Root cause: the kit-a/kit-b hand-merge combined the two sides' silence
mechanisms into a double suppression. P7's `FormController.getDisplayError`
returns null for every `initial`-mode result, `FormEntry._pullValidity`
mirrors only that suppressed value, and `FormEntryErrorBuilder` filters the
mirror by modes. A field that opts into mount-time errors (`showErrors`
containing `initial`, validator running at `initial`) therefore never shows —
the KIT-FIX-1 contract is broken. The `defaultShowErrors` set
(`{changed, submitted}`, `form_core.dart`) already keeps default fields
silent, so the controller-level blanket suppression is redundant as well as
wrong.

Fix (`dashcn/lib/src/primitives/form_core/form_builders.dart`):
`FormEntryErrorBuilder` keeps the mirrored display error on the normal path,
and only when that is null **and** its modes explicitly list `initial` does it
read the raw `controller.getSyncError(handle.formKey)` and show it when its
state is `initial`. `getDisplayError` itself is untouched (doc comment updated
to point at the opt-in), so its direct contract is unchanged.
Which side: keeps dashcn/KIT-FIX-1 intent (opt-in `initial` runs at mount and
shows) while preserving P7 intent (`form_validation_display_test` seeded-
invalid stays silent, `getDisplayError` null; `blocks_forms_silent_test`
9/9 silent — blocks/flows use `{changed, submitted}`/`{submitted}`).
Verified: `form_mount_validation` 5/5, `form_validation_display` 8/8,
`blocks_forms_silent` 9/9, `form_core` 26/26, `form_test` + `blocks_forms_misc`
22/22 — all green in shared runs.

Side effect (intended, P7-documented): `phone_input/preview.dart`
`_InvalidPhone` opts into `initial` precisely "to document what the error
state looks like" — its message now renders at mount as its doc comment says.
`phone_input_qa` still passes (18/18 across the four QA files below).

## 2. `previews_centered_test`: 27 vertical-centring failures

Root cause (all 27): `flutter test` runs as Android, where KIT-FIX-1
`TouchHitArea` (`button.dart:355`, mobile-only, `touchTargets != shrinkWrap`)
wraps every button in invisible symmetric padding to reach 44/48 px hit
targets. The audit's painted-leaf union counts the shifted leaves, so any
preview with an off-centre small control (e.g. `alert/Compact`'s trailing
icon button: union `Rect(104,144,616,268)`, centre 206 vs 210) misses by
3–4 px. Subjects and previews are correct on both sides — the harness measured
phone-only layout on a desktop stage.

Fix (no whitelist, no subject change, per brief): the audit now pumps under a
desktop platform, as dashcn's size tests do (`button_test.dart`
`ThemeData(platform: TargetPlatform.macOS)`). Edited the generator template
(`dashcn/tool/registry/gen_previews_test.dart`, centered `_measure` +
`_measurePhone` only) and regenerated:
`dart run tool/registry/gen_previews_test.dart` → base `previews_test.dart`
byte-identical (no diff), centered file gains `platform: TargetPlatform.macOS`
in both harnesses. `gen_previews_test.dart --check` passes.
Which side: keeps P7's previews and dashcn's `TouchHitArea` behaviour both
untouched; only the P7-TH1 audit harness changes.
Verified: `previews_centered_test` 290/290 (was 27 failed).

## 3. Stale entries (already green, no change)

`kit-failures.txt` also lists `chip_qa` (2), `phone_input_qa` (2),
`scaffold_qa` (1), `spell_check_suggestions_toolbar_qa` (1). The orchestrator-
run log (`p7i_kit_tests.log`) shows none of them failing, and a fresh run of
all four files passes 18/18. They failed at orchestrator-run time on
unrenamed P7 files; the subsequent rename pass fixed their load errors.
No fix needed; re-verified green.

## Gates

- `dart format` on the 4 touched files: 0 changed.
- `dart analyze` on `form_builders.dart`, `form_controller.dart`,
  `gen_previews_test.dart`: No issues found (one `unchecked_use_of_nullable_value`
  caught and fixed during the edit via an explicit non-null `fieldKey` local).
- `gen_previews_test.dart --check`: both generated files up to date.
- Full `flutter test test/registry` in background → 
  `rearch/logs/p7i_fix_kit_full.log` final line: `10:49 +5352: All tests passed!`
- Docs mirror: ran `cd docs && bash tool/sync_registry.sh` once at the very
  end (mirror updated: `form_core/form_builders.dart`,
  `form_core/form_controller.dart` among 757 files). Docs tests NOT run per
  brief — orchestrator owns them.

## Files changed by me

- `/home/user/dashcn-kit-b/dashcn/lib/src/primitives/form_core/form_builders.dart`
- `/home/user/dashcn-kit-b/dashcn/lib/src/primitives/form_core/form_controller.dart`
  (doc comment only)
- `/home/user/dashcn-kit-b/dashcn/tool/registry/gen_previews_test.dart`
- `/home/user/dashcn-kit-b/dashcn/test/registry/qa/previews_centered_test.dart`
  (regenerated)
- `/home/user/dashcn-kit-b/rearch/reports/P7I-fix-kit.md` (this report)

Note: the tree carries the orchestrator's rename-pass unstaged edits on top of
staged merge resolutions (e.g. `MM` on the files above); my edits use plain
dashcn names throughout and compose with them.

## Open questions

- None blocking. The `sign_in_screen.dart` comment "the mount-time report lands
  as `changed`" predates the merged first-report-`initial` lifecycle; stale
  prose, behaviour verified silent by `blocks_forms_silent_test`.

## RESULT
status: done
files_written: [/home/user/dashcn-kit-b/dashcn/lib/src/primitives/form_core/form_builders.dart, /home/user/dashcn-kit-b/dashcn/lib/src/primitives/form_core/form_controller.dart, /home/user/dashcn-kit-b/dashcn/tool/registry/gen_previews_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/qa/previews_centered_test.dart, /home/user/dashcn-kit-b/rearch/reports/P7I-fix-kit.md]
commands_run: [flutter test form_mount_validation + form_validation_display + blocks_forms_silent + form_core -> All tests passed (48); flutter test chip_qa + phone_input_qa + scaffold_qa + spell_check_qa -> All tests passed (18); flutter test previews_centered_test -> All tests passed (290); flutter test form_test + blocks_forms_misc -> All tests passed (22); dart format (4 touched files) -> 0 changed; dart analyze (form_builders, form_controller, gen_previews_test) -> No issues found; gen_previews_test --check -> both files up to date; flutter test test/registry (background, rearch/logs/p7i_fix_kit_full.log) -> All tests passed (5352); docs tool/sync_registry.sh -> mirrored 757 files]
key_findings: [form failure was a double suppression from the hand-merge (controller getDisplayError nulls initial AND builder only sees the mirror) — fixed with a builder-local raw read gated on explicit initial opt-in, both sides' tests green; all 27 centering failures were phone-only TouchHitArea padding skewing the painted union — fixed by pumping the generated audit under TargetPlatform.macOS, zero whitelists/subject changes, base previews_test byte-identical; 6 kit-failures.txt entries were stale (rename pass had already fixed them), re-verified 18/18]
open_questions: []
