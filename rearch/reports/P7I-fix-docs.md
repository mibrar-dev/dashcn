# P7I-fix-docs report — merged P7 + dashcn tree green (docs tests)

Worktree `dashcn-kit-b`, branch `integrate/p7-into-dashcn`. No `git` state-changing
commands run. `dashcn/` untouched; `sync_registry.sh` not run. `dart format` applied
only to the 3 files changed below. No scratch files outside `rearch/logs/`.

## Per-failing-test root cause → fix

Of the 13 entries in `rearch/plans/p7-integration/docs-failures.txt`, 4 were already
green on re-run (stale entries from the orchestrator's run — the tree moved under
them, partly via the concurrent kit agent and the orchestrator's rename/regen pass):
`initial_route_test` (8/8), `starters_test` "getting started links to the starters
index" (file 12/12), both `studio_canvas_test` entries (file 7/7), and `responsive_test`
"every route lays out" (verified green in isolation and again inside the full suite).

### 1. `view_focus_test`: "startup: nothing is focusable…" — stale P7 hero copy (dashcn/P9-Z intent)
- Root cause: the test asserted the pre-P9 hero H1 `A Flutter component kit you own`;
  the merged landing page (`docs/lib/pages/landing_page.dart:59`) intentionally
  renders the P9-Z hero `Every platform at once` (P7I-docs §2 kept dashcn's hero
  structure/copy). Same stale string also broke the 3 `p7th1` tests below.
- Fix (`docs/test/view_focus_test.dart`): expect `Every platform at once`. Test
  updated because the dashcn side intentionally changed the copy; P7-FOCUS gate
  behaviour (unfocusable-before-first-frame, clean view-focus traversal) is untouched.

### 2. `view_focus_test`: "view focus is clean on /themes" — cross-zone chunk poisoning (P9-Z harness intent)
- Root cause: passes alone, fails when the startup test runs first. The startup test
  pumps `DocsApp` directly (no harness warm), so its zone is the first in the isolate
  to issue a deferred-chunk load (the P9-Z landing hero). Per `support/app_harness.dart`,
  a fresh chunk load issued from a later zone after an earlier zone did its own loads
  never lands — so the warm's navigation to the button component page finds 0
  `Playground` widgets. Draining the hero inside the startup test does not help; the
  issue is cross-zone delivery, not pending state.
- Fix (`docs/test/view_focus_test.dart`): the startup test now runs LAST (with a NOTE
  explaining why), preceded by the two harness-warmed tests. All chunk loads then
  happen in the first zone; the direct pump reuses installed libraries. No test
  deleted, skipped, or reordered in a way that changes what each asserts; P7-FOCUS
  behaviour kept, P9-Z deferred-loading intent kept.

### 3–5. `p7th1_theme_everywhere_test`: hero CTA radius, preset re-theme, font re-type — stale P7 hero copy (dashcn/P9-Z intent)
- Root cause: all three used `find.text('A Flutter component kit you own')` as the
  "landing loaded" guard / hero-title probe; the merged hero says
  `Every platform at once` (see §1). The theme assertions themselves (radiusMd
  reshapes CTAs, preset swaps chrome colours, font switch re-types) were correct.
- Fix (`docs/test/p7th1_theme_everywhere_test.dart`): replaced the 4 stale hero
  lookups with `Every platform at once`. P7-TH1 behaviour kept; only the
  intentionally-changed P9-Z copy updated.

### 6. `responsive_test`: "every route lays out…" — stale entry, no fix needed
- Green in isolation (`All tests passed!`) and green again inside the final full suite.

### 7. `starters_test`: "getting started links…" — stale entry, no fix needed
- File 12/12 green in isolation.

### 8–9. `studio_canvas_test`: masonry + registry-blocks — stale entries, no fix needed
- File 7/7 green in isolation.

### 10–12. `gen_docs_data_test`: button API golden, button theme golden, preview-examples golden — stale P7-era goldens (kit-a/kit-b intent)
- Root cause: the merged kit intentionally extends `Button` with P7's status machine
  (`onPressedAsync`, `status`, `successLabel`, `failureLabel`, `statusResetDuration`,
  `onStatusChanged`, `onAsyncError` — verified in
  `dashcn/lib/src/components/button/button.dart:62-68`) and `ButtonTheme` with the
  `status: ButtonStatusStyle?` leg (verified in `button_status_style.dart:43-51`);
  the button preview adds `Async (success)` / `Async (failure)` / `Controlled status`
  (verified in generated `docs/lib/generated/docs_previews.dart`, which the
  `names match the registry preview sources` test confirms against kit source). The
  checked-in goldens predated the merge; the regenerated data files already contain
  the new facts, so the expectations were stale, not the generator.
- Fix (`docs/tool/gen_docs_data_test.dart`): API params list gains the 7 status
  params after `onPressed`; theme fields gain `status` + 9 `status.*` legs;
  button previews list gains the 3 status examples; `kComponentPreviewCounts['button']`
  11 → 14. Tests updated because kit-a intentionally changed the subject (P7 behaviour
  + dashcn names, per the P7I-kit-a report); P7's status-machine behaviour kept.

## Gates
- `flutter test test/view_focus_test.dart` → `All tests passed!` (3/3).
- `flutter test test/p7th1_theme_everywhere_test.dart` → `All tests passed!` (6/6).
- `flutter test tool/gen_docs_data_test.dart` → `All tests passed!` (35/35).
- `flutter test test/initial_route_test.dart` → `All tests passed!` (8/8, stale entry confirmed).
- `flutter test test/starters/starters_test.dart` → `All tests passed!` (12/12, stale entry confirmed).
- `flutter test test/studio_canvas_test.dart` → `All tests passed!` (7/7, stale entries confirmed).
- `flutter test test/responsive_test.dart --plain-name "every route lays out…"` → `All tests passed!` (stale entry confirmed).
- Full `flutter test test tool` in `docs/`, log `rearch/logs/p7i_fix_docs_full.log` → `20:51 +719 ~1: All tests passed!` (719 pass, 1 skipped, 0 failures).
- `dart analyze` on the 3 changed files → `No issues found!`.
- `dart format` on the 3 changed files → clean (1 file reflowed on first pass, 0 changed on re-run).
- No processes left behind (background PIDs 20976, 24986 both exited; only match for "flutter test" is this agent's own command line). No `dashcn/` edits, no `sync_registry.sh` run, no kit change needed — nothing to hand to the kit agent.

## Open questions
- None blocking. UNVERIFIED (not re-checked here): whether the orchestrator's pending `rename_api.dart` + mirror regen pass touches any of the 3 files I edited — my edits are confined to test expectations and one test-ordering NOTE, so a rename pass should not conflict semantically, but a re-run of these files after regen is cheap insurance.

## RESULT
status: done
files_written: [/home/user/dashcn-kit-b/docs/test/view_focus_test.dart, /home/user/dashcn-kit-b/docs/test/p7th1_theme_everywhere_test.dart, /home/user/dashcn-kit-b/docs/tool/gen_docs_data_test.dart, /home/user/dashcn-kit-b/rearch/reports/P7I-fix-docs.md]
commands_run: [flutter test test/view_focus_test.dart -> All tests passed! (3/3), flutter test test/p7th1_theme_everywhere_test.dart -> All tests passed! (6/6), flutter test tool/gen_docs_data_test.dart -> All tests passed! (35/35), flutter test test/initial_route_test.dart -> All tests passed! (8/8, stale entry), flutter test test/starters/starters_test.dart -> All tests passed! (12/12, stale entry), flutter test test/studio_canvas_test.dart -> All tests passed! (7/7, stale entries), flutter test test/responsive_test.dart (every-route) -> All tests passed! (stale entry), flutter test test tool (full docs suite) -> 20:51 +719 ~1: All tests passed!, dart analyze (3 changed files) -> No issues found!, dart format (3 changed files) -> clean]
key_findings: [4 of 13 failure entries were stale (initial_route, starters/getting-started, studio_canvas x2, responsive every-route) — green without edits, 5 failures (view_focus startup + 3 p7th1 + view_focus /themes guard) traced to the intentional P9-Z hero copy `Every platform at once` replacing P7's `A Flutter component kit you own` — tests updated, subjects kept, view_focus /themes failure was cross-zone deferred-chunk poisoning by the directly-pumped startup test — fixed by running the startup test last with an explanatory NOTE, 3 gen_docs_data goldens were stale vs kit-a's intentional Button status machine (7 params, status theme leg, 3 preview examples) — expectations updated to the regenerated facts verified against kit source, No kit (dashcn/) change needed; full docs suite 719 pass / 0 fail]
open_questions: [None blocking; suggest re-running these 3 files after the orchestrator's rename/regen pass as cheap insurance (UNVERIFIED whether that pass touches them)]
