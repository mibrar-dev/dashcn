# Brief P7-WA — overlays over the WHOLE app + beautiful dialog/alert/toast previews + sheet/drawer scale effect
KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs.
Do NOT open PNGs yourself (the model crashes on images). Reference look: ui.shadcn.com docs pages + the deployed main site https://mibrar-dev.github.io/shadcn_flutter_kit/ (agent-browser, SHORT commands; Flutter canvas → click by coordinates). Previews must be BEAUTIFUL, realistic, working examples (users install what looks great), centred, theme-token driven, light/dark. Fix at the root; tests that interact. Gates: `cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; docs sync + --check, codegen --check, format/analyze/test, build web --release. Other agents are active in the same tree (TH1 docs theming, CP1 colour picker, NM1 navigation menu, and the other P7-W batches) — touch only your files; if a gate fails only on their in-flight files, record it. No git ops.
Owns: registry alert_dialog, dialog, toast, gooey_toast PREVIEWS, drawer, sheet (+ the overlay/scaffold piece that does
the background scale); docs app-level overlay hosting.
1. Alert dialog layout bug (evidence `rearch/design/ours/screens/user-bugs-2026-10-11b/alert-dialog-layout.png`): the icon
   sits offset at the top-left outside the title row, actions are LEFT-aligned with the left edge flush to the border,
   uneven padding. → shadcn AlertDialog: p-6, header gap-2 (icon + title on one row or icon above title, centred on
   mobile), description muted, footer right-aligned gap-2 (stacked on mobile), destructive action variant.
2. Dialogs, alert dialogs and toasts triggered from previews must open over the WHOLE app (root overlay / app-level
   toast host, barrier covering the full window), not clipped inside the preview stage.
3. Barrier-locked (non-dismissible) dialogs must still offer an explicit way out (Cancel/close button or required
   action) — never trap the user; add a test.
4. Beautiful previews: alert dialog (destructive delete account, discard changes, session expiring with countdown,
   success confirmation), dialog (edit profile form with Save/Cancel, share link with copy, invite team members,
   scrollable terms, command-like picker) — all working.
5. Toast previews: all variants open over the app at the configured position.
6. Gooey toast previews: ONE shared theme config across all gooey examples (a small theme controls bar in the Playground
   — shape sharp/smooth, animation preset, position, fill — changing it updates EVERY gooey example on the page); no
   example uses its own divergent style.
7. Drawer/sheet: when a drawer or sheet opens, the app content behind scales down slightly (≈0.95) with rounded corners
   and dims (like main's site and vaul/shadcn drawer); animate in/out with the sheet; respect reduced motion; opt-out
   param. Implement as a registry scaffold/overlay capability (e.g. `DrawerBackgroundScale`/app root wrapper) used by
   the docs app.
Captures → `rearch/design/ours/screens/p7wa-*.png`. Report `rearch/reports/P7-WA.md`, `## RESULT`.
