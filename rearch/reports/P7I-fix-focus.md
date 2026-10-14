# P7I-fix-focus report — first Tab must land in the header again

Worktree `dashcn-kit-b`, branch `integrate/p7-into-dashcn` (merge in progress,
fully resolved, no `UU`). No git state-changing commands run (only
`log/diff/show/status`; worktree edits via file tools only). No processes left
behind (http.servers on 8901/8902/17912/7188/15184/15498 all killed by PID;
docs suite PID 14641 exited). Scratch only under `rearch/logs/p7i-focus/`.

## 1. Bug and reproduction (before)

Release docs build (`flutter build web --release --base-href
/shadcn_flutter_kit/`), served from `/tmp/p7i-serve` (symlink
`shadcn_flutter_kit` → `docs/build/web`), driven with Playwright Chromium
(`/opt/pw-browsers/chromium`, swiftshader args) via
`rearch/logs/p7i-focus/browser_check.mjs`:

- Before screenshots: `rearch/logs/p7i-focus/before/{11-dialog-open,12-toast-open,13-tab-once,14-drawer-open}.png`,
  console `11-dialog-open 0`, `12-toast-open 0`, `13-tab-once 0`,
  `14-drawer-open 0` (0 pageerrors).
- `13-tab-once` (`#/` + one Tab) is the failing shot: the orchestrator sees the
  hero iPhone Email field focused; three Tabs reach `Forgot password?`.
  A custom probe (`probe_focus.mjs`, `probe_cycle.mjs`, console `FOCUS-DIAG`
  from temporary instrumentation, since reverted) confirmed programmatically:
  after load `inHeader=true inHero=false`; after 1×Tab
  `inHero=true keys=[auth01.signin.email,demo-auth-/,hero-frame-iphone,…]`;
  after 3×Tab `auth01.signin.password` then the forgot-password button;
  20 Tabs cycle iPhone → Android → Desktop frames and never leave the hero.

## 2. Root cause (evidence)

1. **Initial focus is intact (P9-Z gate works).** After load, primaryFocus is
   the header anchor (`inHeader=true`). Removing the hero
   `FocusScope(canRequestFocus: _installed)` gate makes primaryFocus jump to
   the hero desktop frame before any Tab — proving the gate prevents the
   nested-Navigator autofocus steal and is **innocent** of this bug.
2. **Header buttons are missing from the traversable set (the bug).** A
   release-only dump (`FOCUS-TRAV`) counts 122 traversable leaf nodes, of
   which exactly 1 is in the header (the anchor, `t32l24`). No `t16*` header
   rects and no announcement/CTA rects (`t100–300`) appear; `trav=2` is already
   hero Email (`t333l527`). 18 skipped header nodes (9 positions × 2) cover all
   header interactives (nav, search, GitHub, theme, CTA).
3. **Per-button wrapper pair.** Widget-subtree dump of the first header Button
   (Home) shows `FAD(enabled=true) > ShortcutsWidget >
   Focus(wSkip=false wCan=false) > ActionsWidget > Focus(wSkip=true
   wCan=true)`. The first Focus is the expected `Shortcuts`-widget handler
   (non-focusable by design). The second occupies the `FocusableActionDetector`
   inner-Focus position but reports `skipTraversal=true`, while
   `FocusableActionDetector` builds its inner `Focus` with **no**
   `skipTraversal` parameter — and kit/docs build no other per-button
   `Focus(skipTraversal:true)` (only the app gate and `feature_layout` for
   Input features, neither present here).
4. **Test-vs-browser divergence, same source.** The identical dump in
   `flutter test` (debug) shows `Focus(wSkip=false wCan=true)` at the same
   position and first Tab lands in the header (`tab-in-header=true`, dark and
   light brightness). So the node flags diverge at runtime with no source
   setter found (`grep` for `.skipTraversal =` finds only route scopes and
   `_FocusState`←widget; no assert/`kReleaseMode`/`kIsWeb` branches;
   navigationMode/brightness ruled out).
5. **Bisection exonerates the prime suspects.** Hero gate removed → header
   still blocked (`headerTrav=1`) — innocent. P7 `_FirstFrameFocusGate` +
   `EyeDropperLayer` removed together → header still blocked (`headerTrav=1`)
   — innocent for the blocking (gate still required for P7-FOCUS anyway).
6. **Harness limitation.** `flutter test` (debug asserts, FakeAsync pumps, no
   engine pre-first-frame view-focus dispatch, synchronously resolving
   deferred chunks) keeps the header traversable, so `focus_test`,
   `view_focus_test` and `landing_hero_test` all pass. UNVERIFIED: the exact
   framework mechanism that flips the header FAD nodes to `skip=true` in
   release web only.

## 3. Fix status: blocked (no focus code changed)

No focus-code fix is shipped: with the mechanism UNVERIFIED, any edit to the
gates, hero scope or header buttons risks breaking P7-FOCUS (view-focus
exception) or P9-Z (steal/hero usability) without addressing the observed
button-level blocking. Deliberately left untouched:
`dashcn/lib/src/components/app/app.dart` (P7 gate),
`docs/lib/landing/hero_demo.dart` (hero gate + lineage repair),
`docs/lib/widgets/docs_header.dart`, `docs/lib/widgets/docs_shell.dart`.
Next steps proposed: framework dive on release-web `FocusNode.skipTraversal`
mutation for `FocusableActionDetector` inner nodes (shared-node suspects,
`FocusAttachment` reparenting, `_didUpdateWidget` paths), or a minimal
Flutter-team repro (header Button + deferred hero + gates); then re-run the
browser check below.

Shipped instead (Do #3–#5):

- **Widget test** (`docs/test/focus_test.dart`, +1): `real startup order:
  first Tab lands in the header` pumps `DocsApp` directly (no harness warm),
  drains the deferred hero chunk like the browser's late arrival, then asserts
  header-first Tab. Passes in-harness by design (documents the limitation in
  comments); the release-browser `13-tab-once` shot stays the ground truth.
- **Alert dialog description** (`dashcn/lib/src/components/alert_dialog/meta.json`):
  `Dashcn alert dialog: …` → `Alert dialog: icon, title, description and an
  action footer on top of the dialog route.` Grep finds no other
  `"description": "Dashcn …` / `: "Dashcn [A-Z]` sentences in
  `dashcn/lib/src/**/meta.json` and no `^Dashcn [A-Z]` sentences in
  `dashcn/lib/src/**/README.md`; regenerated `registry.json` and
  `docs_data.dart` carry the plain text.
- **Regeneration:** kit `gen_registry_manifest`, `gen_exports` (145),
  `gen_previews_test` (84), `gen_blocks_test` (16 blocks), `gen_scorecards`
  (84); docs `sync_registry.sh` (757 files) + `gen_docs_data.dart` (18 files).

## 4. Gates (final lines)

- Kit `bash ../rearch/qa_gate.sh` (log `rearch/logs/p7i-focus/qa_gate.log`):
  `format: 0 changed`, `exports: up to date (145)`, `analyze: No issues
  found!`, `test: +5352: All tests passed!`, `rearch: +42: All tests passed!`,
  `layers: 757 files, 0 errors`, `theme: 0 findings`, `banned:` empty.
- Kit `--check`: registry manifest up to date; exports up to date (145);
  previews tests up to date (84); blocks tests up to date (16); scorecards up
  to date (84); `check_names: 0 hits`; `dart format --set-exit-if-changed .`:
  `1488 files, 0 changed`.
- Docs: `dart format`: `1064 files, 0 changed`; `sync_registry.sh --check`:
  mirror up to date; `gen_docs_data.dart --check`: `18 files up to date`;
  `flutter analyze`: `No issues found!`; `flutter test test tool`
  (background PID 14641, log `rearch/logs/p7i-focus/docs_tests.log`):
  `+720 ~1: All tests passed!` (includes the new test; `focus_test` 11/11).
- Docs `flutter build web --release --base-href /shadcn_flutter_kit/`: `✓
  Built build/web` (before and clean-after builds).
- Browser check after (clean tree, no focus change):
  `rearch/logs/p7i-focus/after/*.png`, `11/12/13/14 … 0` pageerrors — the
  `13-tab-once` shot still shows the hero Email (bug reproduced, fix pending).

## Files

- `/home/user/dashcn-kit-b/docs/test/focus_test.dart` (new regression test)
- `/home/user/dashcn-kit-b/dashcn/lib/src/components/alert_dialog/meta.json`
- `/home/user/dashcn-kit-b/dashcn/lib/src/manifests/registry.json` (regen)
- `/home/user/dashcn-kit-b/docs/lib/generated/docs_data.dart` (regen)
- `/home/user/dashcn-kit-b/rearch/logs/p7i-focus/before/13-tab-once.png`
- `/home/user/dashcn-kit-b/rearch/logs/p7i-focus/after/13-tab-once.png`
- `/home/user/dashcn-kit-b/rearch/reports/P7I-fix-focus.md` (this report)

## Open questions

- Which release-web-only path flips header FAD inner nodes to
  `skipTraversal=true` (UNVERIFIED; prime suspects exonerated by bisection)?
- Should the eventual fix live kit-side (e.g. explicit focus nodes for header
  buttons) or framework-side (Flutter issue)?

## RESULT
status: blocked
files_written: [/home/user/dashcn-kit-b/docs/test/focus_test.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/alert_dialog/meta.json, /home/user/dashcn-kit-b/dashcn/lib/src/manifests/registry.json, /home/user/dashcn-kit-b/docs/lib/generated/docs_data.dart, /home/user/dashcn-kit-b/rearch/logs/p7i-focus/before/13-tab-once.png, /home/user/dashcn-kit-b/rearch/logs/p7i-focus/after/13-tab-once.png, /home/user/dashcn-kit-b/rearch/reports/P7I-fix-focus.md]
commands_run: [flutter build web --release --base-href /shadcn_flutter_kit/ (before) -> Built build/web; node browser_check.mjs <base> before -> 11/12/13/14 0 pageerrors; flutter test test/focus_test.dart -> 11/11 All tests passed; bash ../rearch/qa_gate.sh -> format 0 / exports 145 / analyze clean / +5352 pass / +42 pass / layers 0 / theme 0 / banned empty; kit generators --check (5) -> all up to date; dart run tool/check_names.dart -> 0 hits; dart format --set-exit-if-changed . (dashcn) -> 1488 files 0 changed; dart format (docs) -> 1064 files 0 changed; sync_registry.sh --check -> up to date; gen_docs_data --check -> 18 files up to date; flutter analyze (docs) -> No issues found; flutter test test tool (docs, PID 14641) -> +720 ~1 All tests passed; flutter build web (after, clean) -> Built build/web; node browser_check.mjs <base> after -> 11/12/13/14 0 pageerrors, 13-tab-once still hero (fix pending)]
key_findings: [After load primaryFocus is the header anchor (P9-Z gate works; removing hero gate steals focus to hero desktop, proving necessity), Only the header anchor is traversable (122 nodes, headerTrav=1); all 9 header interactives + announcement/CTAs blocked while hero/collage traversable; first Tab anchor->hero Email then trapped by hero closedLoop scope, Home subtree shows FAD Focus with skip=true in browser vs false in test (same source; no setter found; navigationMode/brightness ruled out), Bisection exonerates hero gate and P7 gate+EyeDropper (header still blocked without each), Harness cannot reproduce (FakeAsync/debug/no engine view-focus); browser check is ground truth]
open_questions: [Release-web-only FAD skip=true mutator UNVERIFIED; kit-side vs framework-side home for eventual fix]
