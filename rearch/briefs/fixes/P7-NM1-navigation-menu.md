# Brief P7-NM1 — navigation menu dropdown like shadcn (user 2026-10-11)

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs.
Do NOT open PNGs yourself. Evidence (described): `rearch/design/ours/screens/user-bugs-2026-10-11b/navigation-menu-fullwidth.webp`
— on /docs/components/navigation_menu, opening "Products" shows a content strip spanning the ENTIRE window width
(across the docs sidebar, edge to edge) with two items far apart ("Web Apps / Ship in the browser" at left, "Mobile
Apps / Ship on the go" at right), no visible panel border/shadow, overlapping the page.
References: https://ui.shadcn.com/docs/components/navigation-menu (agent-browser, SHORT commands; hover "Getting
started"/"Components") and the deployed main site https://mibrar-dev.github.io/shadcn_flutter_kit/#/components/
navigation_menu (canvas; click by coordinates) + `git show origin/main:` navigation menu sources.
## Expected (shadcn)
- The dropdown is a viewport panel anchored BELOW the menu bar, aligned to the trigger/menu start, sized to its content
  (e.g. 400–600px), rounded-md, border, shadow, bg popover, p-2/p-4, opening with fade/zoom and moving between triggers.
- Content layouts: a grid (1–2 columns) of link items (title text-sm font-medium + description muted line-clamp-2,
  rounded-md p-3, hover/focus accent bg), optional featured tile; "Products" example with a 2-column grid.
- Hover opens (with delay) and press toggles; keyboard: arrows across triggers, Down into content, Escape closes,
  focus returns; trigger shows chevron rotating; active trigger accent bg; indicator optional.
- Never wider than the viewport minus margins; on narrow screens it fits.
## Do
Fix at the root in registry `navigation_menu` (+ the popover/positioning primitive it uses if the full-width comes from
a loose overlay constraint). Rewrite previews: "Default" (Getting started featured tile + 3 links, Components 2-col grid
of 6, Docs link), "Content list", "With icons". Tests: panel rect width ≤ content/max (not window width), left aligns
with menu start ±16px, below the bar; hover/press/keyboard behaviour; no overflow at 375.
Gates: `cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; docs sync + --check, codegen --check,
analyze/test, build web. Captures (open state) → `rearch/design/ours/screens/p7nm1-*.png`. Report `rearch/reports/P7-NM1.md`,
`## RESULT`. No git ops. Other agents active (TH1 theming of docs/blocks, CP1 colour picker, DL1 dialogs) — touch only
navigation_menu (+ minimal shared popover fix, documented).
