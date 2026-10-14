# P7-STAB — stabilise the P7 batch (report)

All 9 kit failures + all 7 docs failures are fixed. Two were real product
bugs (fixed in product, tests unchanged); the rest were tests encoding
pre-P7 behaviour (tests updated to the new behaviour, no coverage deleted).

## Kit (`flutter_shadcn_kit`)

### F1 — `toast_qa_test.dart`: Default / Destructive / With action previews
Cause: P7-WA rebuilt the toast previews as triggers that call `showToast`
over the whole app through the app-level `ToastLayer`. The tests still
asserted the old inline behaviour (toast rendered on mount, placement
buttons inline), so `find.text('Saved to your workspace.')` found nothing.
Product behaviour is right.
Fix (test): `_pumpPreview` now hosts a `ToastLayer` (as the docs shell
does); each test taps its trigger and asserts the toast appears.
Placement coverage moved to the `Positions` preview (`bottomCenter` →
`Toast at bottomCenter`). Each test also asserts nothing renders before
the trigger.
File: `flutter_shadcn_kit/test/registry/qa/toast_qa_test.dart`

### F2 — `gooey_toast_qa_test.dart`: example-names list
Cause: P7-WA collapsed the per-variant demos into one shared-look
Playground; the registry now exports 3 examples, the test still expected
15 names (`Variants`, `Success`, … at index 1).
Fix (test): expected list is now `Playground, Promise, Interactive Reply`.
File: `flutter_shadcn_kit/test/registry/qa/gooey_toast_qa_test.dart`

### F3 — `interactive_previews_test.dart`: alert_dialog (`Default`)
Cause: example renamed; `Default` no longer exists (`No element`).
Fix (test): drives `Delete account` (same confirm/cancel/result shape):
`Delete account` → `Confirmed.` → `Show again` → `Delete your account?` →
`Cancel` → `Cancelled.`
File: `flutter_shadcn_kit/test/registry/qa/interactive_previews_test.dart`

### F4 — same file: dialog (`Open dialog`)
Cause: first example is now the `Edit profile` form; no `Open dialog` text.
Fix (test): taps `Edit profile`, expects the title rendered in the pushed
dialog (`findsWidgets`: trigger behind the route + dialog title).

### F5 — same file: navigation_menu (`Bar`, Home/About)
Cause: redesigned like shadcn; `Bar` no longer exists. The new `Default`
bar hosts Getting-started/Components dropdowns + a plain `Docs` link.
Fix (test): pumps `Default`, expects `Viewing Getting started`, taps the
plain `Docs` item, expects `Viewing Documentation`.

### F6 — same file: toast (`With action` inline + `Watched the deployment`)
Cause: nothing renders on mount any more; the `View` action calls
`dismissAll()` (no report strip), so both old assertions failed.
Fix (test): renamed to `toast: the trigger shows and the action
dismisses`. Asserts nothing before the trigger, toast after
`Show toast with action`, gone after `View` (+500 ms past the 200 ms
shared exit animation, during which the exiting entry still renders).
Also added `ToastLayer` to the shared `_pump` harness (idle layers
return the child directly, so the other ~40 swept previews are
unaffected — full suite confirms).

### F7 — `alert_dialog_qa_test.dart`: live push (`previews[2]`)
Cause: example order changed; index 2 is now `Session expiring`, which has
no `Show alert dialog` trigger.
Fix (test): looks up the `Live push` example by name instead of index.
(Open/push/return-result/pop flow itself is unchanged and still passes.)
File: `flutter_shadcn_kit/test/registry/qa/alert_dialog_qa_test.dart`

### F8 — REAL PRODUCT BUG: drawer/sheet push crashed semantics (docs
`home_collage` panel test + whole docs app)
Cause: `DrawerBackgroundScale` (P7-WA.7) mounted/unmounted a
`Transform` + `ClipRRect` + `Stack` around the ENTIRE app shell whenever
the observer progress crossed 0. Reparenting the whole render subtree on
the push/pop frame trips a debug-only framework assertion —
`identical(childRenderObject, parentRenderObject)` in
`_SemanticsGeometry.computeChildGeometry` (object.dart:6723) — under
large trees. Verified by bisection: direct `openDrawer` crashed on every
docs page (landing and installation, no scroll needed); the same drawer
in a bare harness was clean; dialog/alert/command pushes (which never
touch the scale wrapper) were clean; open AND close frames crashed;
product open/close/content behaviour was always correct.
Fix (product): the wrapper chain (Stack > ClipRRect > Transform) is now
ALWAYS mounted with the same keys; only paint-level values (scale,
radius, dim alpha) follow the progress. At rest everything is
identity/transparent, so the wrappers are layout-, paint- and
hit-test-neutral (dim veil is `IgnorePointer` when alpha is 0).
The `home_collage` panel test passes UNCHANGED.
File: `flutter_shadcn_kit/lib/registry/components/drawer/drawer_background_scale.dart`
(mirrored to `docs/lib/ui/shadcn/...` via `bash docs/tool/sync_registry.sh`)
Collateral (test, same file's contract): `p7wa_overlays_test.dart`
opt-out / reduced-motion / dialogs-closed cases pinned the OLD structure
(`drawer-background-scale` key absent). They now pin the new contract:
key present, `getMaxScaleOnAxis() == 1.0`, dim veil alpha 0 (veil finder
scoped to `DrawerBackgroundScale` descendants — the route paints its own
barrier `ColoredBox`es).
File: `flutter_shadcn_kit/test/registry/components/p7wa_overlays_test.dart`
Generated: `flutter_shadcn_kit/lib/registry/manifests/registry.json`
regenerated (`gen_registry_manifest.dart`; content hash of the fixed file).

### F9 — REAL PRODUCT BUG: docs article title row (all narrow-width docs
failures: `component_examples` ×4 + `responsive` ×2)
Cause: `DocsArticle._titleRow`'s tight branch (`maxWidth < 560`) put an
`Expanded` title inside a `Column` living in the article scroll view
(unbounded height) → `RenderFlex children have non-zero flex but incoming
height constraints are unbounded` (Column ← LayoutBuilder ← Column ←
DocsArticleScope ← … ← _SingleChildViewport). Every component/article
page at 375/640/768 crashed; the 1440 legs passed, and the D1b/toolbar
tests cascaded from the same exception (`button@375.0`).
Fix (product): tight branch uses the plain title text; `Expanded` is only
used in the wide `Row` branch.
File: `docs/lib/widgets/docs_article.dart`
`docs/test/ts1_captures_test.dart`: absent, nothing to delete. No capture
tests created. No PNG images opened.

## Gates (all pass)
- kit `flutter test test/registry`: **All tests passed (5013+0)**
- kit `flutter test test/rearch`: **All tests passed (42+0)**
- kit `dart format --set-exit-if-changed lib/registry test/registry`:
  clean (0 changed; formatted my touched files + pre-existing
  `button_status_content.dart` whitespace)
- kit `dart analyze lib/registry` / `test/registry`: No issues
- generators `--check`: manifest up to date; previews test up to date
  (83 components); centred-previews up to date (83); blocks up to date (16)
- `check_layers`: all error counts 0 (713 files, 0 syntax errors)
- `check_single_owner`: public duplicates 0 (19 file-private)
- `check_user_theme --strict`: 0 findings
- banned-pattern grep on all touched files: no matches
- docs `dart format --set-exit-if-changed lib test tool`: clean
  (formatted pre-existing `theme_document.dart`, `ts1_switch_perf_test.dart`
  whitespace; `button_status_content.dart` mirror fixed via re-sync)
- docs `flutter analyze`: No issues
- docs `flutter test`: **All tests passed (291+0, 1 pre-existing skip)**
- docs `dart run tool/gen_docs_data.dart --check`: up to date (13 files)
- docs `bash tool/sync_registry.sh --check`: mirror is up to date
- docs `flutter build web --release`: ✓ Built build/web
- `rearch/qa_gate.sh` could not be run to completion: it exceeds the
  120 s tool timeout (full kit suite alone is ~105 s). Every gate it runs
  was executed individually above with passing results.

## RESULT
status: done
files_written: [/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/flutter_shadcn_kit/lib/registry/components/drawer/drawer_background_scale.dart, /Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/docs/lib/ui/shadcn/components/drawer/drawer_background_scale.dart (via sync), /Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/docs/lib/widgets/docs_article.dart, /Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/flutter_shadcn_kit/test/registry/qa/toast_qa_test.dart, /Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/flutter_shadcn_kit/test/registry/qa/alert_dialog_qa_test.dart, /Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/flutter_shadcn_kit/test/registry/qa/gooey_toast_qa_test.dart, /Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/flutter_shadcn_kit/test/registry/qa/interactive_previews_test.dart, /Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/flutter_shadcn_kit/test/registry/components/p7wa_overlays_test.dart, /Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/flutter_shadcn_kit/lib/registry/manifests/registry.json (regenerated), /Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/rearch/reports/P7-STAB.md]
commands_run: [kit flutter test test/registry -> 5013 passed, 0 failed; kit flutter test test/rearch -> 42 passed; kit flutter test (5 touched files) -> 72 passed; docs flutter test test/component_examples+responsive+home_collage -> 21 passed; docs flutter test (full) -> 291 passed, 1 skipped, 0 failed; docs flutter build web --release -> built; generators --check (manifest/previews/blocks) + gen_docs_data --check + sync_registry --check -> all up to date; dart format + flutter analyze (kit lib+tests, docs) -> clean]
key_findings: [toast/alert_dialog/dialog/navigation_menu/gooey failures were tests asserting pre-P7 inline/name behaviour against correct trigger-based/renamed/redesigned products — tests updated, coverage kept; DrawerBackgroundScale conditionally mounting whole-shell wrappers was a real product bug tripping a debug-only framework semantics assert on drawer/sheet push+pop frames — fixed with always-mounted identity-at-rest wrappers, home_collage panel test passes unchanged; docs_article tight-branch Expanded-in-unbounded-Column was a real product bug crashing every narrow article page — fixed with unexpanded title in the Column branch, clearing all 6 narrow-width docs failures; p7wa opt-out/reduced/dialogs tests pinned wrapper absence and now pin identity values]
open_questions: [Escape closes the dialog but not the drawer on the docs landing page in widget tests — both shells register the same DismissIntent/Shortcuts; possibly focus never enters the drawer scope (tap focus stays on the trigger) — UNVERIFIED, pre-existing, no failing test covers it; the semantics assert is debug-only and self-heals in one frame, so release builds were never affected; format-only normalisation of pre-existing P7-dirty files (button_status_content kit+mirror, theme_document, ts1_switch_perf) is whitespace-only — substantive diffs there belong to other P7 agents]
