# P7I-fix-focus — first Tab must land in the header again (merge regression)

Read first: `$KIT/rearch/plans/P7_INTEGRATION.md` and the reports `P7I-docs`, `P7I-fix-docs` (and the P9-Z report's
"Focus fix" paragraph) in `$KIT/rearch/reports/`. You work in `$KIT` (worktree `dashcn-kit-b`, branch
`integrate/p7-into-dashcn`, merge in progress and fully resolved). Do NOT run git commands that change the index/HEAD.
No other agent is running.

## The bug (seen by the orchestrator in a real browser)
Release build of the docs (`cd $DOCS && flutter build web --release --base-href /shadcn_flutter_kit/`), served and
driven with Playwright Chromium (`/opt/pw-browsers/chromium`, launch args `--use-gl=angle --use-angle=swiftshader
--enable-unsafe-swiftshader --ignore-gpu-blocklist`; a ready script is `$KIT/rearch/logs/p7i-focus/browser_check.mjs`,
usage `node browser_check.mjs <baseUrl> <outDir>`; serve with `python3 -m http.server` from a dir containing a
`shadcn_flutter_kit` symlink to `docs/build/web`). On `#/`, ONE Tab press focuses the hero iPhone frame's Email field
(the auth-01 flow inside `LandingHeroDemo`). Before the merge (`refactor/dashcn`) the same Tab focused the header
"Home" link. Three Tabs land on "Forgot password?" in the hero. The docs widget tests (`focus_test`, `view_focus_test`,
`landing_hero_test`) pass, so they do not model this; P9-Z's hero `FocusScope(canRequestFocus: _installed)` gate plus
its lineage repair, and P7's `_FirstFrameFocusGate` in `DashcnApp` (kit `components/app/app.dart`) /
the docs `main.dart` focus handling, are the prime suspects for the interaction.

## Do
1. Reproduce in the browser first (record before screenshots/console in the report).
2. Find the root cause and fix it so that BOTH hold: (a) P7-FOCUS: no view-focus exception on web startup and nothing
   focusable before the first frame settles (`app_focus_gate_test`, `view_focus_test`); (b) P9-Z: initial focus stays
   on the header anchor and the first Tab reaches the header, never the hero flows; the hero flows stay usable by
   mouse/touch and are reachable by Tab only after the header/content order (as before).
3. Add a widget test that would have caught it (simulate the real web startup order as closely as the harness allows;
   if the harness cannot reproduce it, explain why in the report and rely on the browser check).
4. Also fix the alert dialog component description: `dashcn/lib/src/components/alert_dialog/meta.json` says
   "Dashcn alert dialog: …" — make it plain ("Alert dialog: icon, title, …"), and grep `dashcn/lib/src/**/meta.json` +
   READMEs for any other sentence starting "Dashcn " that came from the old "Shadcn X" wording; fix those the same way.
5. Regenerate: `cd $APP` all generators (`registry/gen_registry_manifest.dart`, `gen_exports.dart`,
   `registry/gen_previews_test.dart`, `registry/gen_blocks_test.dart`, `gen_scorecards.dart`); `cd $DOCS && bash
   tool/sync_registry.sh && dart run tool/gen_docs_data.dart`.
6. Gates: kit `bash ../rearch/qa_gate.sh` (from `$APP`), every generator `--check`, `dart run tool/check_names.dart`
   (0), `dart format --set-exit-if-changed .` in both packages; docs `flutter analyze`, `flutter test test tool`
   (background + log under `$KIT/rearch/logs/`), `flutter build web --release --base-href /shadcn_flutter_kit/`, then
   the browser check again: after the fix one Tab on `#/` must focus the header; record after screenshots.
Kill processes by PID only (your own http.server too).

## Report
`$KIT/rearch/reports/P7I-fix-focus.md`: root cause with evidence, fix, tests, before/after browser results, gate lines.
End with `## RESULT` and `status: done` or `status: blocked`.
