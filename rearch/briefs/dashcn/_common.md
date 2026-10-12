# Common rules for every dashcn sub-agent (read fully before starting)

You are a sub-agent on the **dashcn** project (branch `refactor/dashcn`): turning the Flutter UI kit into the
`dashcn` package with plain public names, then adding the P9 signature features. An orchestrator (QA lead) reviews
every line you produce. Accuracy beats speed. When a fact is not verified from the code, write `UNVERIFIED`.

## Paths (worktrees — the ONLY places you may write)
- ROOT = /Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste
- KIT  = $ROOT/dashcn-kit                       (kit repo worktree, branch refactor/dashcn)
- APP  = $KIT/flutter_shadcn_kit  → becomes $KIT/dashcn after P8-1 (run flutter/dart commands here)
- REG  = $APP/lib/registry        → becomes $APP/lib/src after P8-1
- DOCS = $KIT/docs                              (docs Flutter app)
- CLI  = $ROOT/dashcn-cli                       (CLI repo worktree, branch refactor/dashcn)
- Plans (binding): $KIT/rearch/plans/DASHCN_PACKAGE_PLAN.md, $KIT/rearch/plans/DASHCN_FEATURES_PLAN.md
- FORBIDDEN: $ROOT/shadcn_flutter_kit and $ROOT/shadcn_flutter_cli — another session works there. Never read-modify-
  write, build, or run commands inside them.

## Decisions you must follow
- Package `dashcn`, CLI package `dashcn_cli`, executable `dashcn`. Version **1.0.0** everywhere.
- No "shadcn"/"Shadcn" anywhere in public API, paths, CLI, config, docs, samples. Plain names; on a clash with
  `package:flutter/widgets.dart` use a descriptive name, never a prefix. Root widget: **`DashcnApp`**.
- Clean break: no aliases, no deprecated typedefs.
- Widgets-only: no `package:flutter/material.dart` or `cupertino.dart` imports in anything you write.

## Hard rules
1. Only create or modify files listed under "Outputs"/"Owns" in your brief. Everything else is read-only.
2. NO state-changing git: no commit, push, fetch, pull, checkout, switch, stash, reset, add, rm, branch, tag, merge,
   worktree. Only `git log/diff/show/status`. Exception: a brief may explicitly allow `git mv`.
3. Never delete files unless your brief lists them. Never `flutter pub upgrade`. Edit pubspec.yaml only if the brief
   says so.
4. Dart you write passes `dart format` and `flutter analyze`/`dart analyze` with zero issues, without `ignore` comments.
5. Use `package:analyzer` (unresolved AST, `parseString`) for parsing Dart, never regex, for any codemod.
6. Files under ~400 lines; clear names; short doc comments only where non-obvious.
7. Large writes get truncated by the tool layer: write files > ~150 lines in appended chunks, then verify
   (`grep -n truncated <file>` empty, `tail -5` ends where intended).
8. **Do NOT open PNG/JPG images yourself** (your model crashes on images). Write screenshots to the path in the
   brief; the orchestrator looks at them.
9. Leave no scratch files outside `$KIT/rearch/logs/` (use it for temp output) — the orchestrator commits explicit
   paths only and rejects stray files.

## Finish with a report
Write the report to the path in your brief AND print it last:
```
## RESULT
status: done | partial | blocked
files_written: [absolute paths]
commands_run: [command -> outcome]   # every gate in your brief, with its final line
key_findings: [bullets]
open_questions: [bullets]
```
