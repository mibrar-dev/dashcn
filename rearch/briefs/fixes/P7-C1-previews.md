# Brief P7-C1 — chip, carousel, pinned_sheet, tree, breadcrumb: look right AND be fully interactive (user 2026-10-11)

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs.
Do NOT open PNGs yourself (model crashes on images). Orchestrator evidence (release build, 1440 dark):
`rearch/design/ours/screens/user-bugs-2026-10-11/{chip-carousel,pinned-tree-breadcrumb}.png`. Compare with the shadcn/ui
docs pages for carousel, breadcrumb, badge/toggle-group-like chips, a file-tree demo, and drawer/sheet (agent-browser).

User: these previews don't look good; every preview must be a WORKING preview the user can interact with to see what
the widget can do. Fix component bugs at the root (registry) and rewrite the previews (named examples per the
ComponentPreview contract).

1. pinned_sheet: preview is completely BLANK. → Visible trigger + sheet that slides in from an edge, drag between snap
   stages, close; examples per side (bottom/right/left/top) and with snap points; works inside the bounded stage.
2. tree: tiny, stray grey checkbox squares misaligned at the row start, the "Pictures" folder shows a FILE icon,
   no indent guides, expand/collapse not demonstrated. → shadcn-quality file tree: correct folder/file icons
   (open/closed folder), chevrons that expand/collapse on click + keyboard (arrows, Enter, Space), selection highlight,
   indent guides, proper row height/padding/density, checkboxes ONLY in a "Multi-select" example and aligned; examples:
   Default, With selection, Multi-select (checkboxes with tri-state), Lazy/large.
3. breadcrumb: static, left-aligned text. → Centred, interactive: clicking a crumb navigates (trail updates, current
   page non-link), hover underline/colour, an ellipsis (…) that opens a dropdown of collapsed items, custom
   separator (slash) example, responsive collapse at narrow widths.
4. chip: tiny chips with developer labels ("static", "leading", "trailing"). → Realistic, correctly sized chips (shadcn
   badge-ish sizing from the theme): Removable (× removes it from a list, with a "reset" button), Selectable/filter
   chips (toggle on/off), With icon, Sizes/variants; keyboard: Backspace/Delete removes the focused chip.
5. carousel: slides spill past the card edges, flat grey boxes, no prev/next buttons. → shadcn carousel: contained
   within the preview width (clip), card-style slides with numbers, prev/next buttons outside/beside the slides,
   dot indicators synced, drag/swipe + keyboard arrows; examples: Default, Sizes (1/3 basis), Vertical, Autoplay,
   With API (current/total counter).
Tests (widget tests that INTERACT): tap/keyboard drives every example (tree expands/collapses/selects; breadcrumb
navigates; chip removes/toggles; carousel next/prev/drag changes page; pinned sheet opens/snaps/closes); nothing
overflows the stage at 375/1440; light/dark.
Gates: `cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; docs sync + --check, codegen --check,
format/analyze/test, `flutter build web --release`. Captures (agent-browser, incl. after interacting) →
`rearch/design/ours/screens/p7c1-*.png`. Report `rearch/reports/P7-C1.md`, `## RESULT`. No git ops. Agent P7-F3 is
editing formatted/object/date/time inputs + gooey toast — don't touch those.
