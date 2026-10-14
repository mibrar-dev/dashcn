# P8-2 — orchestrator nudge #2 (time box)

The identifier scan is fast now (400 files / 2 s) — good. Something later in the run still hangs. Time box: apply the
rename within the next 30 minutes.
1. Make the tool print the path BEFORE processing each file in the slow pass (text/string/comment pass), run it with
   `timeout 120`, and read the last printed path: that file is the culprit.
2. Typical cause: a regex with nested quantifiers / catastrophic backtracking on a large file (`llms-full.txt`,
   `markdown_qa_test.dart`, generated `docs/lib/generated/*.dart`). Replace that regex with plain `String.replaceAll`
   on the explicit map strings (they are literal substrings — no regex needed), or skip generated files that the
   generators will rewrite anyway (`docs/lib/generated/**`, `gen/llms-full.txt`, `test/registry/previews_test.dart`,
   `lib/src/manifests/registry.json`) and regenerate them afterwards.
3. Then APPLY (no more benchmarking), mirror via `git mv docs/lib/ui/shadcn docs/lib/ui/dashcn` + `sync_registry.sh`,
   regenerate, run the gates, write the final report. Delete your `tool/p82_*_tmp.dart` scratch files.
