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
