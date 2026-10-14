# P7I-fix-focus2 report — header skipped by Tab: gate replaced

Worktree `dashcn-kit-b`, branch `integrate/p7-into-dashcn` (merge in progress,
fully resolved). No state-changing git commands (only `log/diff/show/status`;
file edits via file tools; `sync_registry.sh`/generators only rewrite their
owned outputs). No processes left behind (http server on 8971 killed by PID
14095 and verified gone; both `flutter test` background runs exited on their
own; `/tmp/p7i-fix-focus2` removed). Scratch only under
`rearch/logs/p7i-fix-focus2/`. Temporary instrumentation (`focus2_diag.dart`,
`main.dart` hook, two throwaway kit tests, gate `fffg` key) was fully reverted
and verified absent (`grep` exit 1; `main.dart` has zero diff).

## 1. Confirmation (Do #1)

Release docs build (`flutter build web --release --base-href
/shadcn_flutter_kit/`), served via symlink dir, Playwright Chromium,
`browser_check.mjs` + new `tab_probe.mjs`, focus located by pixel-diff
(`focus_diff.py`: tab0 vs tab1) since images can't be opened here.

- **Before (merged tree, gate in kit + mirror):** `13-tab-once` diff is 884 px
  at `x=[58,261] y=[611,637]` → **first Tab lands in the hero** (iPhone Email
  region), header skipped. Deterministic across two independent shots
  (`tab1.png` and `13-tab-once.png` diffs identical). 4 shots, 0 pageerrors;
  console clean on `#/`, `#/themes`, `#/docs/components/button` × `en-US`,`C`.
- **Gate removed (kit source + `sync_registry.sh` mirror re-sync, rebuild):**
  diff is 530 px at `x=[21,84] y=[13,50]` → **first Tab lands on header
  "Home"**. This confirms the orchestrator bisection on the merged tree.
- **P7I conflict resolved (the stale-mirror trap):** P7I's "gate removed →
  still blocked" is explained — the docs app imports the MIRROR
  (`docs/lib/ui/dashcn/components/app/app.dart`), not `dashcn/lib/src`.
  Proven by accident: one diag build ran with kit=gate-restored but
  mirror=gate-removed (sync forgotten) and behaved gate-removed (Tab→Home,
  per-node flags healthy). The build follows the mirror, always; every
  conclusion below was re-verified with `diff -q` mirror-in-sync.
- **Gate-out cost:** the no-gate build logged
  `Bad state: RenderBox was not laid out` on `#/` load — the P7-FOCUS race is
  real on this tree, so plain removal is rejected.

## 2. Mechanism hunt (why the fix looks the way it does)

Temporary release instrumentation (3 instrumented builds, all reverted) dumped
per-node `skipTraversal`/`canRequestFocus`, the gate state, and ancestor
chains in the gate build:

- Gate is open at dump time (`descendantsAreTraversable=true`, single instance
  by temporary key, present in the header nodes' ancestor chain).
- All 9 header interactives report getter-`skipTraversal=true` (plus 3 hero
  frame-root `demo-auth-/` nodes, which are nested-`Navigator` focus nodes —
  `(skip=true, can=true)` by Navigator construction, not victims; their inner
  Email field stays reachable).
- The header nodes' ancestors all report `descendantsAreTraversable=true`,
  which points at a stuck own-`_skipTraversal` flag — yet an exhaustive grep of
  the whole `package:flutter` (`lib/`) plus kit/docs finds no writer that sets
  own-`skipTraversal=true` on a plain node (only `routes.dart:1175` on route
  scopes, widget→node same-value syncs, and constructor params; kit has only
  the gate itself and input `feature_layout`). In-harness repro of the stuck
  flag fails (closed→open is healthy: `skip=true` frame 1, `skip=false`
  frame 2). So the exact write path is **UNVERIFIED** — but the trigger class
  is certain: **nodes that exist while the gate is closed stay blocked; nodes
  created after it opens (deferred hero Email) are healthy.**

## 3. The fix (Do #2)

`dashcn/lib/src/components/app/app.dart`: `_FirstFrameFocusGate` no longer
wraps the subtree in `Focus(descendantsAreTraversable:)` — it **builds nothing
(`SizedBox.shrink()`) until the first post-frame**, then builds the child.
Mirror re-synced (exact).

- **Keeps P7-FOCUS:** no focusable exists before the first layout, so the
  engine's pre-layout view-focus traversal finds nothing and cannot throw.
  Stronger than before (vacuous, not filter-dependent). Verified: 0 console
  errors/pageerrors on all 3 routes × 2 locales.
- **Keeps P9-Z:** hero gate (`hero_demo.dart`, untouched) and anchor logic
  untouched; initial focus is still the header anchor — Tab-1 lands on Home,
  the node immediately after the anchor in traversal order, which is only
  possible from the anchor (nothing precedes it; a stolen-to-hero focus would
  Tab inside the hero instead). `autofocus` works (requests run once the
  subtree exists; pinned by test).
- **Why not the brief's event-interception candidate:** `_ViewState` owns the
  traversal call and observers can't consume the event, so there is no clean
  interception point; not building is proof-by-construction against the whole
  poison class.
- **Known tradeoff:** first Flutter frame is blank (content installs one frame
  later; total time-to-content unchanged — the layout work just moves a
  frame). Covered by the host splash in practice.
- Files with attempted-but-rejected alternatives: none shipped. `hero_demo.dart`,
  `docs_header.dart`, `docs_shell.dart`, `main.dart`: zero diff.

## 4. Tests (Do #3)

- `app_focus_gate_test.dart`: header comment updated to the new mechanism;
  both existing tests pass unchanged (frame-1 empty ⇒ nothing traversable;
  autofocus after settle). **New:** `first-frame nodes are traversable after
  the first frame` — two buttons, settle, Tab→first, Tab→second (the
  harness analogue of `13-tab-once`).
- `view_focus_test.dart`: comments updated (gate builds nothing; one pump =
  nothing built yet); all assertions unchanged and passing.
- Collateral (honest cost of content arriving one frame later — each first
  `DashcnApp` pump followed by one extra `pump()`, never settle near timers):
  `app_test.dart` (`_pumpApp` + 4 single-pump tests),
  `gooey_toast_test.dart` (13 sites + RTL site),
  `gooey_toast_p7g1_test.dart` (`pumpApp` helper),
  `gooey_toast_p7g3_test.dart` (3 sites),
  `localizations_test.dart` (odd-locale loop).

## 5. Browser results, after fix (Do #4)

Fix release build, same harness:

- `tab_probe` + `browser_check` `13-tab-once`: identical 530 px diffs at
  `x=[21,84] y=[13,50]` → **first Tab on header "Home"** (screenshots
  `after/13-tab-once.png`, `after/tab1.png` for the orchestrator).
- `11-dialog-open / 12-toast-open / 13-tab-once / 14-drawer-open`: **0
  pageerrors each**.
- `console_check.mjs` on `#/`, `#/themes`, `#/docs/components/button`:
  **0 pageerrors + 0 console errors under both `en-US` and `C`.**
- Before shots kept under `before/` (same names) for side-by-side.

## 6. Regeneration + gates (Do #5)

- Kit generators run, then all `--check` green: registry manifest up to date
  (hash refresh for `app.dart`; the 360-line diff also picks up merged-source
  state never regenerated — badge dep, shell files, spinner removals),
  exports 145, previews 84, blocks 16, scorecards 84, `check_names` 0 hits.
- Kit `bash ../rearch/qa_gate.sh` (`qa_gate.log`): format 0 changed, exports
  up to date, analyze clean (lib+tests), rearch +42 pass, layers 0 errors,
  theme 0, banned empty (the `test:` line got truncated by the script's own
  `cut`, so the suite was re-run with full logging).
- Kit `flutter test test/registry` (`kit_tests2.log`): **+5361: All tests
  passed!** (first full run caught the 25 single-pump failures above, all in
  4 files, all fixed, all 72 in those files green before the rerun).
- `dart format --set-exit-if-changed .`: dashcn 1489 files 0 changed, docs
  1064 files 0 changed.
- Docs: `sync_registry.sh --check` up to date, `gen_docs_data.dart --check`
  18 files up to date, `flutter analyze` No issues found, `flutter test test
  tool` (`docs_tests.log`, background): **+720 ~1: All tests passed!**
  (incl. `view_focus_test` 4/4 and the `focus_test` header-first tests).

## Files

- `/home/user/dashcn-kit-b/dashcn/lib/src/components/app/app.dart` (the fix)
- `/home/user/dashcn-kit-b/docs/lib/ui/dashcn/components/app/app.dart` (mirror)
- `/home/user/dashcn-kit-b/dashcn/lib/src/manifests/registry.json` (regen)
- `/home/user/dashcn-kit-b/dashcn/lib/src/manifests/scorecards.json` (regen)
- `/home/user/dashcn-kit-b/dashcn/test/registry/qa/previews_centered_test.dart` (regen)
- `/home/user/dashcn-kit-b/dashcn/test/registry/components/app_focus_gate_test.dart`
- `/home/user/dashcn-kit-b/dashcn/test/registry/components/app_test.dart`
- `/home/user/dashcn-kit-b/dashcn/test/registry/components/gooey_toast_test.dart`
- `/home/user/dashcn-kit-b/dashcn/test/registry/qa/gooey_toast_p7g1_test.dart`
- `/home/user/dashcn-kit-b/dashcn/test/registry/qa/gooey_toast_p7g3_test.dart`
- `/home/user/dashcn-kit-b/dashcn/test/registry/primitives/localizations_test.dart`
- `/home/user/dashcn-kit-b/docs/test/view_focus_test.dart`
- `/home/user/dashcn-kit-b/rearch/logs/p7i-fix-focus2/` (`tab_probe.mjs`,
  `console_check.mjs`, `diag_probe.mjs`, `focus_diff.py`, `before/`,
  `after/`, `gate-removed/`, `diag*/`, `*.log`, `app.dart.with-gate`)
- `/home/user/dashcn-kit-b/rearch/reports/P7I-fix-focus2.md` (this report)

## Open questions

- Exact write path of the stuck `skipTraversal` flag: UNVERIFIED (no writer in
  SDK/kit/docs; harness cannot reproduce; release-only). A Flutter-team minimal
  repro (app-nested `Focus(descendantsAreTraversable:false)` flipped post-frame
  + slow first frame + pre-layout view-focus + deferred install) could isolate
  it; the shipped fix does not depend on the answer.
- Whether a future SDK change alters first-frame timing enough to matter for
  the one blank frame (behavioral, cosmetic only).

## RESULT
status: done
files_written: [/home/user/dashcn-kit-b/dashcn/lib/src/components/app/app.dart, /home/user/dashcn-kit-b/docs/lib/ui/dashcn/components/app/app.dart, /home/user/dashcn-kit-b/dashcn/lib/src/manifests/registry.json, /home/user/dashcn-kit-b/dashcn/lib/src/manifests/scorecards.json, /home/user/dashcn-kit-b/dashcn/test/registry/qa/previews_centered_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/app_focus_gate_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/app_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/gooey_toast_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/qa/gooey_toast_p7g1_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/qa/gooey_toast_p7g3_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/primitives/localizations_test.dart, /home/user/dashcn-kit-b/docs/test/view_focus_test.dart, /home/user/dashcn-kit-b/rearch/logs/p7i-fix-focus2/tab_probe.mjs, /home/user/dashcn-kit-b/rearch/logs/p7i-fix-focus2/console_check.mjs, /home/user/dashcn-kit-b/rearch/logs/p7i-fix-focus2/diag_probe.mjs, /home/user/dashcn-kit-b/rearch/logs/p7i-fix-focus2/focus_diff.py, /home/user/dashcn-kit-b/rearch/logs/p7i-fix-focus2/before/11-dialog-open.png, /home/user/dashcn-kit-b/rearch/logs/p7i-fix-focus2/before/12-toast-open.png, /home/user/dashcn-kit-b/rearch/logs/p7i-fix-focus2/before/13-tab-once.png, /home/user/dashcn-kit-b/rearch/logs/p7i-fix-focus2/before/14-drawer-open.png, /home/user/dashcn-kit-b/rearch/logs/p7i-fix-focus2/before/tab0.png, /home/user/dashcn-kit-b/rearch/logs/p7i-fix-focus2/before/tab1.png, /home/user/dashcn-kit-b/rearch/logs/p7i-fix-focus2/after/11-dialog-open.png, /home/user/dashcn-kit-b/rearch/logs/p7i-fix-focus2/after/12-toast-open.png, /home/user/dashcn-kit-b/rearch/logs/p7i-fix-focus2/after/13-tab-once.png, /home/user/dashcn-kit-b/rearch/logs/p7i-fix-focus2/after/14-drawer-open.png, /home/user/dashcn-kit-b/rearch/logs/p7i-fix-focus2/after/tab0.png, /home/user/dashcn-kit-b/rearch/logs/p7i-fix-focus2/after/tab1.png, /home/user/dashcn-kit-b/rearch/reports/P7I-fix-focus2.md]
commands_run: [flutter build web --release --base-href /shadcn_flutter_kit/ (before) -> Built build/web; node tab_probe.mjs before -> tab0/tab1, 0 pageerrors/0 consoleErrors; focus_diff before -> 884px y611-637 BODY/HERO; node browser_check.mjs before -> 11/12/13/14 0 pageerrors; node console_check.mjs 3 routes x en-US,C -> all 0/0; flutter build (gate-removed, mirror synced) -> Built; tab_probe gate-removed -> 530px y13-50 HEADER + 1 RenderBox console error; flutter build (diag, gate) x3 -> Built; diag_probe -> gate open, 9 header nodes skip=true, Tab-1 hero Email; flutter test tmp repro/struct (deleted after) -> harness healthy, structure mapped; flutter build (fix) -> Built; tab_probe after -> 530px y13-50 HEADER 0/0; browser_check after -> 11/12/13/14 0; console_check 3x2 -> all 0/0; kit generators run + --check x5 -> all up to date; check_names -> 0 hits; dart format --set-exit-if-changed . (dashcn 1489 files, docs 1064 files) -> 0 changed; bash ../rearch/qa_gate.sh -> format 0 / exports 145 / analyze clean / rearch +42 pass / layers 0 errors / theme 0 / banned empty (test line truncated, rerun separately); flutter test test/registry (kit_tests2.log) -> +5361 All tests passed; docs sync_registry --check -> up to date; gen_docs_data --check -> 18 files up to date; docs flutter analyze -> No issues found; docs flutter test test tool (docs_tests.log) -> +720 ~1 All tests passed]
key_findings: [Before: Tab-1 -> hero Email (884px y611-637), deterministic; gate-removed+mirror-sync -> Tab-1 header Home (530px y13-50) confirming causality; P7I conflict = stale mirror (build follows mirror, proven by a mismatched build); gate-out returns the RenderBox view-focus error; gate-build diag: gate open + in chain, yet 9 header nodes getter-skip=true with all ancestors traversable; no flag writer exists in SDK/kit/docs (UNVERIFIED write path) and harness cannot reproduce; shipped build-gate (nothing built frame 1) sidesteps the poison by construction; after fix Tab-1 -> Home deterministically with zero console/pageerrors on all routes x locales; P9-Z intact (anchor-first proven by Tab-1 landing on Home; hero gate untouched)]
open_questions: [Exact stuck-flag write path UNVERIFIED (needs Flutter-team minimal repro; fix independent of it), blank-first-frame splash timing on very slow devices (cosmetic)]
