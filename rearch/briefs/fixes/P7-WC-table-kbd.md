# Brief P7-WC — table padding + resizable columns/rows; keyboard shortcut preview; ⌘K hint in docs search
KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs.
Do NOT open PNGs yourself (the model crashes on images). Reference look: ui.shadcn.com docs pages + the deployed main site https://mibrar-dev.github.io/shadcn_flutter_kit/ (agent-browser, SHORT commands; Flutter canvas → click by coordinates). Previews must be BEAUTIFUL, realistic, working examples (users install what looks great), centred, theme-token driven, light/dark. Fix at the root; tests that interact. Gates: `cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; docs sync + --check, codegen --check, format/analyze/test, build web --release. Other agents are active in the same tree (TH1 docs theming, CP1 colour picker, NM1 navigation menu, and the other P7-W batches) — touch only your files; if a gate fails only on their in-flight files, record it. No git ops.
Owns: registry table (+ table primitives), keyboard_shortcut; docs search field in the header only.
1. table: cell padding still wrong — shadcn table: head h-10 px-2 text-left font-medium muted; cell p-2 align-middle;
   row border-b, hover muted/50. Columns and rows must be RESIZABLE by dragging the header column dividers (and row
   dividers where the API enables it) with min/max sizes, resize cursor, keyboard resize; previews: data table
   (sortable headers, row selection checkboxes, status badges, pagination, resizable columns), simple invoices table.
2. keyboard_shortcut: preview not centred and not following the theme — centred, themed kbd keys (muted bg, border,
   radius from theme, mono/sans per shadcn Kbd), realistic examples (⌘K, Ctrl+Shift+P, sequence G then H, inside a menu
   item).
3. Docs header search field shows the shortcut hint (⌘K on macOS, Ctrl K elsewhere) as a kbd at the right of the field
   like shadcn; pressing it opens the palette (already wired — verify).
Report `rearch/reports/P7-WC.md`, `## RESULT`. Captures → `p7wc-*.png`.
