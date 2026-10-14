# P7I-fix-docs — make the merged P7 + dashcn tree green (docs tests)

Read first: `$KIT/rearch/plans/P7_INTEGRATION.md` (Ibrar's binding table) and the three area reports in
`$KIT/rearch/reports/` (P7I-kit-a, P7I-kit-b, P7I-docs). You work in `$KIT` (worktree `dashcn-kit-b`, branch
`integrate/p7-into-dashcn`). The merge of `refactor/rearchitecture` is IN PROGRESS and fully resolved (no conflicts).
Do NOT run `git add/commit/checkout/merge/reset/stash`. Another fix-up agent works on the kit (`dashcn/`) tests at the same time:
do not edit its files.

## Failing tests (from the orchestrator's full run)
`$KIT/rearch/plans/p7-integration/docs-failures.txt` (one `file: test name` per line). Full log:
`$KIT/rearch/logs/p7i_docs_tests.log`.

## Rules
- Find each root cause. The usual cause: P7 code or tests meeting dashcn changes (P8-2 names, KIT-FIX-1 `onMuted`/
  semantics/`TouchHitArea` (phones get 44/48 px hit padding; the test bed runs as Android; `ThemeData.touchTargets`
  = `shrinkWrap` opts out), form pristine/dirty, P9 frames/playground/flows/starters/landing hero, scorecards).
- Keep P7's behaviour (Ibrar's table). Fix the subject when the behaviour is wrong. Update a test only when it asserts
  something the other side intentionally changed, and say which side and why in the report. Never delete or skip a
  test to make it pass. A centring audit that fails only because of phone touch padding is fixed by pumping that audit
  under a desktop platform (as dashcn's size tests do) or `touchTargets: shrinkWrap`, not by whitelisting.
- Known case: `form_mount_validation_test` "initial validators still run at mount" — KIT-FIX-1 contract: a validator
  registered with `FormValidationMode.initial` runs at mount and shows; `{changed}` stays silent until an edit;
  P7's "change/submit only" for blocks/flows must keep passing too (`blocks_forms_silent_test`).
- Do not edit `dashcn/` (the kit agent owns it) and do not run `sync_registry.sh`; if a docs failure needs a kit change,
  describe it in the report instead.
- Re-run every test file from the list until green, then the whole `flutter test test tool` in `$DOCS` in the background
  writing to `$KIT/rearch/logs/p7i_fix_docs_full.log`, and poll it. Format only the files you changed.

## Report
`$KIT/rearch/reports/P7I-fix-docs.md`: per failing test, root cause → fix (file) → which side's intent it keeps; the
final full-suite line. End with `## RESULT` and `status: done` or `status: blocked`.
