# Brief P7-B2 — blocks as real full-page layouts (user 2026-10-11)

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs.
Do NOT open PNGs yourself. Evidence: `rearch/design/ours/screens/user-bugs-2026-10-11b/login-02-congested.png` (login-02:
the testimonial is a small card floating top-right; the form is squeezed left; lots of empty space; looks congested).
Reference: ui.shadcn.com/blocks (login-02/03/04, sidebar-07, dashboard-01, signup) — agent-browser, SHORT commands.

User: block previews must look like a FULL PAGE of a real website/app, following real-world design systems: e.g. a
split auth layout's side panel takes the FULL HEIGHT of its half (edge to edge, its own background/image/quote at the
bottom), never a small card; sidebars run full height; dashboards fill the viewport with header + content.
## Do (all 16 blocks + the docs block viewport)
1. Docs block viewport: render each block as a page at a realistic page size — desktop frame ≈ 1280×800 (scaled to fit
   the card width if needed, like shadcn's iframe), tablet 768×1024, mobile 390×844; the block gets tight page
   constraints (full width + full height) so layouts can fill/split the page. "Open in new tab" shows it full-window.
2. Re-layout every block as a real page:
   - login-02 / signup-02: 2-column split, each half full height; brand panel full-height with background (muted /
     token gradient or pattern), logo top-left, quote/testimonial anchored at the bottom; form column centred
     vertically, max-w-sm. Mobile: panel hidden, form full-screen.
   - login-01/03, otp-01, signup-01: centred card on a full-page muted background (`bg-muted min-h-svh`).
   - sidebar-01/02/03: full-height sidebar + inset content with a header bar; content fills the rest.
   - dashboard-01/02: app shell (sidebar or top header) + content grid filling the page.
   - account-01/02, pricing-01, calendar-01/02: page header + content at page width with real section spacing.
   - Everything theme-token driven, light/dark, density.
3. Keep all behaviour (validation, async submit, interactions) and tests green; update layout tests to page-size frames.
Tests: at 1280×800 the split panels each take 50% width and 100% height; sidebars 100% height; no block content
smaller than intended or floating; 390-wide mobile layouts.
Gates: `cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; docs sync + --check, codegen --check,
format/analyze/test, build web --release. Captures → `rearch/design/ours/screens/p7b2-*.png` (all 16, desktop + 3 mobile).
Report `rearch/reports/P7-B2.md`, `## RESULT`. No git ops.
