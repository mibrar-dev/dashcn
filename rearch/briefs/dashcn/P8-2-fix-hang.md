# P8-2 — orchestrator: the "slowness" is an infinite loop (exact fix)

Root cause found by the orchestrator: `dashcn/tool/rename_api_passes.dart`, `maskAllow`, line ~106:

    masked = masked.substring(0, hit) + placeholder + masked.substring(hit);

inserts the placeholder but KEEPS the matched allow-list text, so the next `indexOf` finds the same entry again right
after the placeholder → infinite loop with an ever-growing string (100% CPU, GBs of RAM). It triggers on the first
file containing an allow-listed string (`docs/lib/widgets/docs_footer.dart`, the repo URL). Every timeout you saw was
this, not slowness. Fix:

    masked = masked.substring(0, hit) + placeholder + masked.substring(hit + entry.length);

Also make the comparison case-safe (`entry.toLowerCase()` once) and add a unit test in
`dashcn/test/tool/rename_api_passes_test.dart` for maskAllow/unmaskAllow round-trip with 2+ occurrences.

Then, with NO `timeout` wrapper: `dart run tool/rename_api.dart --check` (should take well under a minute), APPLY,
mirror (`git mv docs/lib/ui/shadcn docs/lib/ui/dashcn`, update sync_registry.sh, run `bash tool/sync_registry.sh`),
regenerate, `check_names` → 0, all gates, final report `status: done`. Delete `tool/p82_*_tmp.dart` scratch.
