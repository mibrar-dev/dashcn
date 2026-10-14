# P7I-docs — resolve the P7 → dashcn merge conflicts for area `docs`

Read first: `$KIT/rearch/plans/P7_INTEGRATION.md` (binding resolution table). You work in `$KIT` (worktree
`dashcn-kit-b`, branch `integrate/p7-into-dashcn`) where a `git merge` of `refactor/rearchitecture` into dashcn is IN
PROGRESS. Two other agents resolve other areas in the SAME worktree at the same time.

## Your files
Exactly the paths listed in `$KIT/rearch/plans/p7-integration/docs.txt` (relative to `$KIT`). Edit only these, plus
NEW helper files strictly needed by them. Do not touch any other path.

## How to resolve each file
- See both sides: `git show :2:<path>` (dashcn / ours), `git show :3:<path>` (P7 / theirs), `git show :1:<path>` (base,
  if present). For the P7 intent, read the P7 commit messages (`git log -3 --format=%B MERGE_HEAD`) and the P7 diff of
  the old path: `git diff fa22ef2 MERGE_HEAD -- flutter_shadcn_kit/lib/registry/<same/relative/path>` (kit) or
  `-- docs/<path>` (docs app).
- Status `UU` (both changed): keep P7's behaviour, use dashcn's names, and hand-merge where dashcn also changed the
  logic (per Ibrar's table in the plan). dashcn-side work you must not lose: P8-2 plain names (`dashcn/tool/rename_map.yaml`: `ShadcnX` →
  plain), KIT-FIX-1 (`ThemeColors.onMuted`, semantic labels, `TouchHitArea` + `ThemeData.touchTargets`, form
  pristine/dirty validation), P9 features (flows, starters, scorecards, frames, playground, landing hero, search,
  locale shim). If both sides changed the same behaviour, keep the one that satisfies both sides' tests, and explain
  the choice in the report.
- Status `UA`/`AU` (added by P7): take P7's content. The orchestrator runs the rename tool over the whole tree
  afterwards, so translating old names by hand is optional; if you do translate, follow the rename map (identifiers,
  imports `package:flutter_shadcn_kit/...` / `registry/...` → the dashcn paths, `ui/shadcn` → `ui/dashcn`, prose
  "shadcn" → plain words; "Design inspired by shadcn/ui." is the only allowed attribution).
- `UD`/`DU` (modify/delete): follow the table's rule.
- No conflict markers may remain (`grep -n '^<<<<<<<\|^=======$\|^>>>>>>>' <file>`).
- Do NOT run `git add`, `git commit`, `git checkout`, `git merge`, `git reset`, `git stash` or anything that changes the
  index or HEAD. The orchestrator stages your files after review.
- (This overrides the preamble rules "format whole packages" and "run the docs generator gates".) Do NOT run generators that rewrite shared files (`gen_*`, `sync_registry.sh`, `rename_api.dart`) and do NOT format
  or analyze the whole package (other agents' files are mid-resolution). Format only your files
  (`dart format <files>`). Analyze only your files (`dart analyze <files>` from the package dir) and read only the
  errors in your files; errors caused by another area's unresolved file are expected, so list them in the report
  instead of fixing them.
- Run the tests that cover your files where they can run (`flutter test <test files>` in `dashcn/` or `docs/`). If a
  test fails only because another area is unresolved, record it.

## Report
`$KIT/rearch/reports/P7I-docs.md`: per file, the resolution (what each side changed, what you kept or combined, and
why), the tests you ran with their results, and the cross-area errors you saw. End with `## RESULT` and
`status: done` or `status: blocked`.
