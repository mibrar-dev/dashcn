# Brief P7-TH1 — the WHOLE site and every block/card follows the selected theme exactly (user 2026-10-11)

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs.
Do NOT open PNGs yourself. Evidence: `rearch/design/ours/screens/user-bugs-2026-10-11b/home-radius-mismatch.webp`
(home hero "Get Started"/"View Components" and the announcement pill are fully rounded pills, while the header "Get
Started" uses the theme radius — so the hero ignores the Theme Studio radius).

User: make sure the whole app follows the theme exactly (radius, colours, fonts, spacing/density, shadows) — home,
docs shell, Theme Studio, component pages, blocks pages, and all blocks/cards.
## Do
1. Scan `docs/lib/**` (exclude `lib/ui/shadcn/**` mirror and `lib/generated/**`) and `flutter_shadcn_kit/lib/registry/
   blocks/**` + the docs home/studio card files for hard-coded design values: `BorderRadius.circular(<n>)`,
   `Radius.circular(<n>)`, `StadiumBorder`, `999`, `Color(0x…)`/`Colors.*`, literal font sizes/weights/families not
   from `theme.typography`, literal paddings/gaps not from theme spacing/density, literal shadows. Write the findings
   table FIRST in the report (file:line → value → token).
2. Replace each with the theme token: radius → `theme.borderRadius{Sm,Md,Lg,Xl}` (shadcn mapping: buttons/inputs md,
   cards xl, badges md… use the same component defaults the registry uses); hero CTAs and pills must be registry
   `Button`/`Badge` (which already follow the theme) instead of custom pill containers; colours → `theme.colors.*`;
   type → `theme.typography.*`; spacing → theme spacing/density; shadows → theme shadow tokens. Allowed exceptions
   (justify each): avatars/dots that are circles by definition, the gooey toast's main-matched fixed palette, code
   syntax colours, brand logos.
3. Prove it: widget tests that switch the Theme Studio model (radius 0 → 1rem, a different preset, density compact →
   comfortable, a different font) and assert the hero buttons/pill, header buttons, home cards, block cards and docs
   chrome all change accordingly (radius of their decoration equals the theme value, colours equal tokens).
4. Capture home + a block page + /themes at radius 0 and radius 1rem, light/dark → `rearch/design/ours/screens/p7th1-*.png`.
Gates: `cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; docs sync + --check, codegen --check,
format/analyze/test, build web --release. Report `rearch/reports/P7-TH1.md`, `## RESULT`. No git ops.
Keep recent orchestrator edits (chat incoming bubble theme, block page backgrounds = background, brand panels = card).

## Also: Button status width must be DYNAMIC (user 2026-10-11)
P7-S1's ButtonStatus machine reserves a fixed slot so the width stays stable — the user rejects that (an empty reserved
gap looks like something is missing). Change `components/button/**` so the button ALWAYS hugs its current content:
idle = label (+ its own icons) only; loading = spinner + gap + label (or loading label); success/failure = status icon
+ gap + label. Animate the width change smoothly (AnimatedSize ~150–200ms, ease-out; reduced motion = instant) and
cross-fade the icon; no reserved/min-width slot, no layout jank in rows (siblings may move with the animation). Full-width
buttons (expand / tight parent) keep the parent width. Update P7-S1's tests (replace "width stable" with "width hugs
content in each state + animates between them") and README.

## Also: EVERY preview example centred (user 2026-10-11 — e.g. /docs/components/toggle sits on the left)
1. Add a generated test (extend `tool/registry/gen_previews_test.dart` or a new `test/registry/qa/previews_centered_test.dart`)
   that pumps EVERY ComponentPreview example of every listed component inside a 720×420 stage (and 375 wide) and computes
   the bounding box of the painted content (union of leaf render boxes: RenderParagraph, RenderImage, decorated/
   coloured boxes, custom paints — ignoring full-stage transparent wrappers) and asserts its horizontal centre equals
   the stage centre ±2px (vertical too, unless the example is intentionally top-anchored like a full-width table/list —
   whitelist with a reason).
2. Fix every failing example at the root of its preview (Row/Column/Wrap with max main-axis size → min, Align start →
   centre, crossAxisAlignment.stretch only where content is intentionally full-width and then centred within a
   max-width box). Toggle first. Keep examples interactive.
3. The docs stage keeps `Center` for the child; no IntrinsicWidth in the stage (breaks LayoutBuilder examples).

## Also: component page header is crammed (user 2026-10-11)
Evidence `rearch/design/ours/screens/user-bugs-2026-10-11b/page-header-crammed.png`: the "3 files" badge, "stable"
badge, "Copy Page" button and the prev/next buttons touch each other (0px gaps). Use theme spacing: gap-2 between
badges, gap-3 between the badge group and the actions, gap-2 between Copy Page and the pager; badges at shadcn badge
size, buttons size sm; wrap to the next line on narrow widths instead of squeezing. Same check for every docs header/
toolbar row (blocks page, themes page, code card toolbars).
