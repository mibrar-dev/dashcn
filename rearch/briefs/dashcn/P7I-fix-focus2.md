# P7I-fix-focus2 — header skipped by Tab: replace P7's first-frame focus gate

Read first: `$KIT/rearch/reports/P7I-fix-focus.md` (previous attempt, blocked, with probes under
`$KIT/rearch/logs/p7i-focus/`) and `rearch/reports/P7-FOCUS.md` (why the gate exists). You work in `$KIT` (worktree
`dashcn-kit-b`, branch `integrate/p7-into-dashcn`, merge in progress and fully resolved). Do NOT run git commands that
change the index or HEAD. Kill processes by PID only (your own http servers too).

## Root cause (orchestrator bisection in a real release browser, Playwright Chromium)
On the frozen P7 branch itself: at `5ebe8c1` (before P7-FOCUS) one Tab on `#/` focuses the header "Home" link; at
`426f7eb` (P7-FOCUS, which only adds `_FirstFrameFocusGate` around the app subtree in `ShadcnApp`, now
`DashcnApp` in `dashcn/lib/src/components/app/app.dart`, plus its tests) the first Tab skips the WHOLE header (lands on
the hero badge). So `_FirstFrameFocusGate` — `Focus(canRequestFocus: false, skipTraversal: true,
descendantsAreTraversable: _ready)` flipped after the first post-frame — leaves the nodes built in the first frame (the
header) non-traversable in release web. The earlier "gate removed → still blocked" result conflicts with this; re-check
it carefully (e.g. was the docs mirror `docs/lib/ui/dashcn/components/app/app.dart` regenerated after editing the kit
source? the docs app imports the MIRROR, not `dashcn/lib/src`).

## Do
1. Reproduce on the merged tree (release build + `browser_check.mjs` shot `13-tab-once`), then confirm the cause by
   removing the gate in the kit source AND re-syncing the mirror (`cd $DOCS && bash tool/sync_registry.sh`), rebuild,
   re-check.
2. Replace the gate with a fix that keeps P7-FOCUS's goal (no "RenderBox was not laid out" / view-focus exception when
   the engine delivers the initial view-focus event before the first layout on web) WITHOUT leaving first-frame nodes
   untraversable. Candidates: handle the early view-focus event instead of hiding the subtree (e.g. defer/ignore
   `FocusManager`'s handling of a view-focus event that arrives before the first frame), or gate via a mechanism that
   re-marks descendants traversable (verify in the browser). Keep autofocus working (P7-FOCUS requirement) and keep
   P9-Z's hero focus gate behaviour (initial focus on the header anchor, hero flows never steal focus).
3. Tests: keep `app_focus_gate_test` / `view_focus_test` meaning (update them to the new mechanism), and add a test that
   the first frame's focusable nodes are traversable after the first frame (e.g. build an app with two buttons, pump,
   send Tab, expect the first button focused) — under conditions as close to web startup as the harness allows.
4. Browser check, both before and after, on the merged release build: one Tab on `#/` focuses header "Home"; no
   console errors/pageerrors on `#/`, `#/themes`, `#/docs/components/button` (the P7-FOCUS exception must not
   return — check the console with `locale: en-US` and `C`).
5. Regenerate (kit generators, docs sync + gen_docs_data) and gates: kit `bash ../rearch/qa_gate.sh`, every generator
   `--check`, `check_names` 0, `dart format --set-exit-if-changed .` in both packages; docs `flutter analyze`,
   `flutter test test tool` (background + log under `$KIT/rearch/logs/`).

## Report
`$KIT/rearch/reports/P7I-fix-focus2.md`: confirmation, the fix and why it keeps both P7-FOCUS and P9-Z, tests,
before/after browser results with console summaries, gate lines. End with `## RESULT` and `status: done` or
`status: blocked`.
