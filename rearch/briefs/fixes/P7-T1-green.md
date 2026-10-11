# Brief P7-T1 — make the tree green before commit + two visual fixes (orchestrator QA)

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit.
Do NOT open PNGs yourself. Context: `rearch/reports/P7-C1.md` (chip/carousel/pinned_sheet/tree/breadcrumb previews were
rewritten), `rearch/reports/P7-G2.md` (gooey toast ported from main).
1. These QA tests target the OLD previews and now fail — update them to the new examples (keep their intent: real
   interaction assertions), don't delete coverage:
   - test/registry/qa/chip_qa_test.dart: "pressable preview counts taps"
   - test/registry/qa/pinned_sheet_qa_test.dart: "Default sheet drags between stages", "Snapping buttons move the
     sheet without exceptions"
   - test/registry/qa/tree_qa_test.dart: "Collapsed preview hides children"
2. chip preview: the Removable example's content is left-aligned inside the stage (chips row + "4 of 4 shown" + tip
   start at the left); centre the whole example (and every other chip example).
3. tree: the indent guides render as thick grey BLOCKS (~16px wide bars) at the start of child rows instead of thin 1px
   guide lines (border token) centred under the parent chevron; fix in the registry tree (TreeRow/indent guide paint),
   add a test that the guide's painted width is ≤ 1px × scaling.
4. Remove any scratch/probe/zz_ test files left by agents (grep test/ for zz_ / probe).
Gates: `cd $APP && flutter test test/registry` must be ALL GREEN; `cd $KIT && rearch/qa_gate.sh`; generators
regenerate + --check; docs sync + --check, codegen --check, analyze/test. Report `rearch/reports/P7-T1.md`, `## RESULT`.
No git ops.
