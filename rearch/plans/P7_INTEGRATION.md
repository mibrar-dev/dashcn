# P7 → dashcn integration

`refactor/rearchitecture` is **frozen** as of 2026-10-13: no more work there; dashcn (`refactor/dashcn`) is the only
line. The last P7 commits (`6f8262f` P7 polish batch, `5ebe8c1` docs not-found, `426f7eb` web focus fix) are merged
into dashcn through `integrate/p7-into-dashcn` (kit repo only; the CLI is unaffected).

Branch: `integrate/p7-into-dashcn` = `refactor/dashcn` (9c78356) + merge of `refactor/rearchitecture` (426f7eb),
in worktree `dashcn-kit-b`. Merge base `fa22ef2`. Trial merge: 164 conflicts, of which 60 were generated mirror/data
(resolved mechanically) and 104 are real.

## Resolution table (Ibrar's, binding)

The CLI needs nothing: its `refactor/dashcn` already contains all of `refactor/rearchitecture`. The kit is missing the
last three P7 commits, written with the old names and paths (`ShadcnTheme`, `lib/registry/...`). Git follows the
folder move (`flutter_shadcn_kit/lib/registry` → `dashcn/lib/src`) by itself.

| Merge result | Files | How to resolve |
|---|---|---|
| Merged cleanly | ~195 | none needed |
| New files from P7, old names | 111 | run the dashcn rename tool (`dashcn/tool/rename_api.dart`) on them |
| Conflicts in the docs copy of the registry (`docs/lib/ui`) and generated docs code (`docs/lib/generated`) | ~57 | regenerate with the existing sync and generator tools, no hand edits |
| Real conflicts in registry code and tests (`dashcn/lib/src`, tests) | ~90 | per file: keep P7's behaviour, apply the new names with the codemod, and hand-merge where dashcn also changed the logic |
| Real conflicts in docs widgets and pages | ~15 | same as above |

How it's carried out here:
- Generated/mirror conflicts: set to dashcn's side now, regenerated at the end (`docs/lib/ui/shadcn/` stray copy
  removed).
- Real conflicts (104 in this run): three OpenCode agents by area — `kit-a` (button, overlays, toasts, navigation
  menu, ⌘K kbd, app/focus), `kit-b` (blocks, forms, tables, pickers, refresh trigger, marquee, images, theme,
  primitives), `docs` (docs widgets, pages, tests); lists in `rearch/plans/p7-integration/`. Each file: P7's behaviour
  kept; where dashcn also changed the logic (KIT-FIX-1 `onMuted`/semantics/`TouchHitArea`/`touchTargets`/form
  pristine-dirty, P9 features) both are hand-merged. Each area's result is reviewed before it is staged.
- New P7 files and anything still carrying old names: the rename tool runs over the whole tree once all areas are
  resolved.
- `flutter_shadcn_kit/test/registry/theme/theme_lerp_animated_test.dart` (modify/delete): ported to
  `dashcn/test/registry/theme/` if its subject still exists, else dropped with a note (agent `kit-b`).

After all areas: rename codemod over the tree → regenerate everything → every gate (kit `qa_gate.sh`, all generators
`--check`, `check_names` 0, exports, format; docs gen/sync `--check`, analyze, `test tool`, build web; CLI e2e against
the merged kit) → visual check of the P7 fixes (Theme Studio, overlays, ⌘K, focus, not-found) → commit the merge →
fast-forward push `refactor/dashcn`.
