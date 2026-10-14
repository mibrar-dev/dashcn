# Brief P7-WB — navigation bar, refresh trigger, overflow marquee, card image, pinned sheet handle, dot indicator
KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs.
Do NOT open PNGs yourself (the model crashes on images). Reference look: ui.shadcn.com docs pages + the deployed main site https://mibrar-dev.github.io/shadcn_flutter_kit/ (agent-browser, SHORT commands; Flutter canvas → click by coordinates). Previews must be BEAUTIFUL, realistic, working examples (users install what looks great), centred, theme-token driven, light/dark. Fix at the root; tests that interact. Gates: `cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; docs sync + --check, codegen --check, format/analyze/test, build web --release. Other agents are active in the same tree (TH1 docs theming, CP1 colour picker, NM1 navigation menu, and the other P7-W batches) — touch only your files; if a gate fails only on their in-flight files, record it. No git ops.
Owns: registry navigation_bar, refresh_trigger, overflow_marquee, card_image, pinned_sheet, dot_indicator.
1. navigation_bar: beautiful working previews (bottom tab bar for a mobile app with badges, sidebar rail with labels,
   top bar with active indicator, compact icon-only) — interactive selection.
2. refresh_trigger: pull-to-refresh does not work in the docs (cannot pull; it "opens all the way up"). Fix at the root
   (drag/scroll gesture, threshold, indicator follows the pull, releases → refreshing → done → snaps back; mouse drag on
   web + trackpad + touch), realistic preview (inbox list that gains new items on refresh).
3. overflow_marquee: the preview shows NOTHING. Fix (likely zero-size/unbounded or fade mask) and make realistic examples
   (now-playing song title, news ticker, long filename in a fixed-width card).
4. card_image: renders as a tall thin bar (width too small). Proper card with image area (aspect ratio), title,
   subtitle, actions; grid of cards example; never collapses in a loose parent.
5. pinned_sheet: the grab handle is always at the top. Handle position follows the side: opens from left → handle on the
   RIGHT edge (vertical bar); from right → on the LEFT edge; from top → at the BOTTOM; from bottom → at the top.
6. dot_indicator: dots have no gaps — add the theme gap between dots (gap-2/density) and proper sizes, active dot style.
Report `rearch/reports/P7-WB.md`, `## RESULT`. Captures → `p7wb-*.png`.
