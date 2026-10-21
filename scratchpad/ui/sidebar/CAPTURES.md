# CAPTURES — dashboard sidebar (`feat/sidebar-dashboard`)

Docs: `http://127.0.0.1:8884/#/docs/components/sidebar`, debug build served
on port 8884. Browser session: agent-browser `--session sb` (1280x800 and
375x812 viewports, light/dark via `set media`).

## Method note

The docs app is a Flutter canvas build: the accessibility tree exposes no
clickable refs, so all interaction used coordinate mouse events, and the
page itself does not scroll under wheel/scroll commands — TOC rail clicks
do scroll the article. In-stage clicks (preview card controls and demo
buttons) never registered, so the open-drawer state could not be captured
from the browser: it is covered by the widget-test captures below, where a
real tap opens a real `DrawerRoute`.

- `*_1280x800_*.png`, `*_375x812_*.png` — rendered by
  `dashcn/test/registry/visual/sidebar_captures_test.dart` (each example at
  both sizes, light + dark; the drawer menu is tapped for `drawer_open`).
- `docspage_1280_light.png` — browser viewport shot of the live docs page,
  proving the WIP badge and the Dashboard example in situ.

## Files

- `dashboard_1280x800_light.png` / `dashboard_1280x800_dark.png` — full rail
  beside content: header (logo, title, collapse control), Main/Account
  groups, highlighted Dashboard row, Documents badge "12", Settings
  chevron, footer account row.
- `dashboard_375x812_light.png` / `dashboard_375x812_dark.png` — phone
  layout below 560 px: bar with menu button + title, content below, no
  overflow.
- `drawer_1280x800_light.png` / `drawer_1280x800_dark.png` — phone mock
  (400 px) on desktop: bar + content, all cards reachable by scroll.
- `drawer_375x812_light.png` / `drawer_375x812_dark.png` — full-bleed
  phone bar + content.
- `drawer_open_1280x800_light.png` / `drawer_open_1280x800_dark.png` —
  drawer slid in from the left with the full sidebar; scrim over content.
- `drawer_open_375x812_light.png` / `drawer_open_375x812_dark.png` — drawer
  fills the phone width with header, both groups, badge, chevron, footer.
- `collapsed_1280x800_light.png` / `collapsed_1280x800_dark.png` — 56 px
  icon rail with group dividers, avatar-only footer, content beside it.
- `collapsed_375x812_light.png` / `collapsed_375x812_dark.png` — rail +
  squeezed content, no overflow.
- `docspage_1280_light.png` — docs page: title, `3 files` / `stable` /
  `Work in progress: bugs may occur.` badges, Dashboard example rendering.

## Fixes applied after review

- Dashboard demo width 640 → responsive fill (was cropped by the preview
  card edge in `page_1280_light.png`); Drawer demo 360x360 fixed → 400 px
  capped full-height phone mock (was a tiny island with a cut-off card at
  1280x800).
