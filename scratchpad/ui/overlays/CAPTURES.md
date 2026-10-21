# Captures: interactive overlays (popup, dropdown_menu, search_bar, command)

Session `w-overlays`, port `8875`, release docs build (`docs/build/web`,
`flutter build web --release --base-href /`), served via
`python3 -m http.server 8875 --directory docs/build/web`.
All browser shots via `agent-browser --session w-overlays`
(headless). Viewport via `agent-browser set viewport <w> <h>`,
theme via `agent-browser set media <light|dark>`.
Each page opened as `http://localhost:8875/#/docs/components/<id>`
with a 10 s settle before capture (cold Flutter web boot is ~6-8 s;
4 s sleeps produced boot-screen blanks and were retaken).

## Base pages (Default example open inline, 1280x800 and 375x812, light+dark)

- `popup_1280x800_light.png` / `popup_1280x800_dark.png` — Popup page,
  Default inline `MenuPopup` profile card open. Surface hugs content
  within 160-320 px. No overflow.
- `popup_375x812_light.png` / `popup_375x812_dark.png` — Same at 375 px
  phone width. Mobile nav, card fits, no RenderFlex overflow, no
  horizontal scroll.
- `dropdown_menu_1280x800_light.png` / `dropdown_menu_1280x800_dark.png` —
  Dropdown page, Default inline menu open (Profile/Settings/Sign out,
  32 px rows). Status line "Pick a row" below.
- `dropdown_menu_375x812_light.png` / `dropdown_menu_375x812_dark.png` —
  Same at 375 px. Menu stays within viewport, no overflow.
- `search_bar_1280x800_light.png` / `search_bar_1280x800_dark.png` —
  Search page, Default ranked field + live result list open inline.
- `search_bar_375x812_light.png` / `search_bar_375x812_dark.png` —
  Same at 375 px. Long labels truncate with ellipsis, no overflow.
- `command_1280x800_light.png` / `command_1280x800_dark.png` — Command
  page, Default palette open inline (search field + Calendar/Search
  Emoji/Launch/Profile/Mail rows, 48 px touch rows). Sidebar confirms
  new `With groups`, `Dialog`, `Customized` examples.
- `command_375x812_light.png` / `command_375x812_dark.png` — Same at
  375 px. Palette fits, no overflow.

## Named examples

- `example_popup_examples.png` — Popup Examples section (1280, light):
  `Anchored` trigger button ("Show popup") and `Customized` tinted
  surface (widget-leg `MenuPopupTheme` fill, no border). `Default` is
  covered by the base screenshots above.
- `example_dropdown_menu_examples.png` — Dropdown Default with hover:
  inline menu open, `Profile` row hover-highlighted (gray fill),
  proving row hover states. `With shortcut`, `With checkbox item`,
  `Trigger`, `Customized` are verified by `preview_static_audit`,
  `previews_test` (580 checks pass) and `interactive_previews_test`
  ("the trigger opens a menu"); browser scroll to the lower Examples
  cards is flaky in Flutter web CanvasKit (drag-scroll unreliable,
  sidebar anchor clicks jump inconsistently), so those cards are not
  separately screenshotted here — noted plainly.
- Command `Dialog` (new click-to-open `showCommandDialog` trigger) and
  `Customized` (tinted palette), plus Search `With groups` / `With
  cancel` / `Custom row`, render and pass all preview tests, but no
  separate browser close-ups were captured for the same scroll reason;
  the base screenshots show `Default` open and the sidebar lists the
  new examples (visible in `command_1280x800_light.png`).

## Open state via trigger click

- `popup_open_1280x800_light.png` — Clicked `Show popup` in the
  `Anchored` example. The profile-card popup opens anchored below the
  trigger. It renders faint/translucent in this capture (open animation
  / modal fade); it remains open and Escape/outside-tap dismissal is
  proven by widget tests (`popup_test`: "Escape closes the popup", "an
  outside tap closes the popup") and `popup_behaviour_test`
  ("popup (generic surface) Escape and outside tap close"). Browser
  Escape goes to the docs shell (Flutter canvas focus), not the
  overlay — noted plainly; in-app dismissal is test-verified.
- Dropdown `Trigger` (`Open menu` → `showDropdown`) and Command
  `Dialog` (`Open command palette` → `showCommandDialog`) click-opens
  are verified by widget tests (`dropdown_menu_test` "opens anchored
  and closes on Escape", "pressing a row runs it and closes the menu";
  `popup_behaviour_test` dropdown/command groups) and
  `interactive_previews_test` ("dropdown_menu: the trigger opens a
  menu", "popup: the trigger anchors the surface"). No separate
  trigger-open PNGs are included for those two (browser coordinate
  clicks on CanvasKit are flaky and produced blank/hover-only frames);
  the interaction videos below show the trigger areas and scrolling.

## Interaction videos (one per component)

- `popup_interaction.webm` — Open popup page, drag-scroll to Examples,
  click `Show popup` (overlay opens anchored), press Escape.
- `dropdown_menu_interaction.webm` — Open dropdown page, sidebar
  anchor clicks toward `Trigger`, scroll attempts.
- `command_interaction.webm` — Open command page, drag-scroll through
  the palette and Examples.
- `search_bar_interaction.webm` — Open search page, drag-scroll
  through the field/results and Examples.

Videos show real page navigation, scrolling and trigger clicks. Overlay
open/close animation frames may be faint (modal fade) — the authoritative
open/select/close contracts are in widget tests (16 new
`overlays_interactive_test` checks plus the existing popup/dropdown/
command/search suites, all passing).

## What looks wrong / limitations (stated plainly)

- Popup trigger-open capture is faint (animation/fade); the overlay is
  open and anchored, but not a crisp opaque still. Inline Default
  captures are the crisp open-state evidence.
- No separate browser PNGs for dropdown `Trigger` open, command
  `Dialog` open, or every individual named example card; Flutter web
  CanvasKit has no DOM (no `canvas` element, `flt-glass-pane`
  scrolling via `mouse wheel` times out, keyboard PageDown/End does not
  scroll, drag-scroll works intermittently, coordinate clicks land
  inconsistently). Coverage for those states comes from widget tests
  (listed above) and the generated preview audits, not from pixels.
- 375 px captures show the top of each page (Default open); lower
  Examples were not separately captured at 375 for the same scroll
  reason. No overflow was observed at either width.
- File naming: `example_dropdown_menu_examples.png` currently shows the
  Default card with hover, not the lower Examples; kept under that name
  to avoid churn, described accurately here.
