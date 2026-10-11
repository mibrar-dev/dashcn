# Brief P7-C2 — every preview must be a working, interactive demo (sweep)

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit.
Context: `rearch/reports/P7-C1.md` (chip/carousel/pinned_sheet/tree/breadcrumb done), P7-Q1/Q2 QA reports.
Do NOT open PNGs yourself. User rule: every preview must let the user interact and see what the widget can do.
1. For every LISTED component's `preview.dart` (except the five P7-C1 did and the inputs P7-F1/F2/F3 did), detect
   static demos of interactive widgets: no handlers (`onPressed: null`/missing `onChanged`), `const` values that never
   change, overlays without a trigger, toggles that can't toggle, lists that can't select, steppers/tabs/accordions
   that can't advance, blank stages. Write the table FIRST in `rearch/reports/P7-C2.md` (component → static examples →
   fix), then fix each preview with local state so the demo is live (and fix any component bug found at the root).
2. Visual sanity per example: centred, realistic labels (no developer placeholders like "static"/"leading"), proper
   sizes, no overflow at 375/1440, light/dark.
Tests: extend the generated previews test or add `test/registry/qa/interactive_previews_test.dart` asserting each
interactive example reacts to a tap/keyboard input (state change visible).
Gates: `cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; docs sync + --check, codegen --check,
analyze/test, build web --release. `## RESULT`. No git ops. Update the report every ~10 components.
