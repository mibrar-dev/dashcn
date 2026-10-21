# CAPTURES — component sizing and spacing (feat/component-spacing)

Docs served from `docs/build/web` on http://localhost:8882 (python http.server,
background). Browser: agent-browser, headless, session `w-components`.
Pages: `#/docs/components/<id>`. Viewports 1280x800 and 375x812, `set media
light|dark` + reload for themes (the app follows `prefers-color-scheme`).

Scroll method: the docs app is a Flutter canvas build, so DOM scroll/click refs
are unavailable. Scrolling was done by dispatching synthetic `WheelEvent`s with
pointer coordinates on `flutter-view` via `agent-browser eval`; `mouse wheel`
was unusable (CDP dispatch hangs) and bare coordinate-less wheel events did not
move the page. No element could be clicked for the same reason — see "not covered".

## Files

| File | Shows |
|---|---|
| calendar-1280x800-light-top.png | 1280x800 light, page top: Calendar: compact 32 px day cells + weekday header |
| calendar-1280x800-dark-top.png | 1280x800 dark, page top: Calendar: compact 32 px day cells + weekday header |
| calendar-375x812-light-top.png | 375x812 light, page top: Calendar: compact 32 px day cells + weekday header |
| calendar-375x812-dark-top.png | 375x812 dark, page top: Calendar: compact 32 px day cells + weekday header |
| fab-1280x800-light-top.png | 1280x800 light, page top: FAB: enabled default (md 56, icon 20, token shadow), dark/light |
| fab-1280x800-dark-top.png | 1280x800 dark, page top: FAB: enabled default (md 56, icon 20, token shadow), dark/light |
| fab-375x812-light-top.png | 375x812 light, page top: FAB: enabled default (md 56, icon 20, token shadow), dark/light |
| fab-375x812-dark-top.png | 375x812 dark, page top: FAB: enabled default (md 56, icon 20, token shadow), dark/light |
| swipe_actions-1280x800-light-top.png | 1280x800 light, page top: Swipe actions: compact 36 px rows, 13 px labels |
| swipe_actions-1280x800-dark-top.png | 1280x800 dark, page top: Swipe actions: compact 36 px rows, 13 px labels |
| swipe_actions-375x812-light-top.png | 375x812 light, page top: Swipe actions: compact 36 px rows, 13 px labels |
| swipe_actions-375x812-dark-top.png | 375x812 dark, page top: Swipe actions: compact 36 px rows, 13 px labels |
| action_sheet-1280x800-light-top.png | 1280x800 light, page top: Action sheet: compact rows, token padding |
| action_sheet-1280x800-dark-top.png | 1280x800 dark, page top: Action sheet: compact rows, token padding |
| action_sheet-375x812-light-top.png | 375x812 light, page top: Action sheet: compact rows, token padding |
| action_sheet-375x812-dark-top.png | 375x812 dark, page top: Action sheet: compact rows, token padding |
| list_tile-1280x800-light-top.png | 1280x800 light, page top: List tile: compact rows, token padding |
| list_tile-1280x800-dark-top.png | 1280x800 dark, page top: List tile: compact rows, token padding |
| list_tile-375x812-light-top.png | 375x812 light, page top: List tile: compact rows, token padding |
| list_tile-375x812-dark-top.png | 375x812 dark, page top: List tile: compact rows, token padding |
| table-1280x800-light-top.png | 1280x800 light, page top: Table: 36 px rows, sortable headers, pagination, scrolls in frame |
| table-1280x800-dark-top.png | 1280x800 dark, page top: Table: 36 px rows, sortable headers, pagination, scrolls in frame |
| table-375x812-light-top.png | 375x812 light, page top: Table: 36 px rows, sortable headers, pagination, scrolls in frame |
| table-375x812-dark-top.png | 375x812 dark, page top: Table: 36 px rows, sortable headers, pagination, scrolls in frame |
| filter_bar-1280x800-light-top.png | 1280x800 light, page top: Filter bar: inline default + Popup/Dialog/Sheet variants (see variants shot) |
| filter_bar-1280x800-dark-top.png | 1280x800 dark, page top: Filter bar: inline default + Popup/Dialog/Sheet variants (see variants shot) |
| filter_bar-375x812-light-top.png | 375x812 light, page top: Filter bar: inline default + Popup/Dialog/Sheet variants (see variants shot) |
| filter_bar-375x812-dark-top.png | 375x812 dark, page top: Filter bar: inline default + Popup/Dialog/Sheet variants (see variants shot) |
| menu-1280x800-light-top.png | 1280x800 light, page top: Menu: 32 px rows, submenu chevron (right-edge flip covered by widget test) |
| menu-1280x800-dark-top.png | 1280x800 dark, page top: Menu: 32 px rows, submenu chevron (right-edge flip covered by widget test) |
| menu-375x812-light-top.png | 375x812 light, page top: Menu: 32 px rows, submenu chevron (right-edge flip covered by widget test) |
| menu-375x812-dark-top.png | 375x812 dark, page top: Menu: 32 px rows, submenu chevron (right-edge flip covered by widget test) |
| menubar-1280x800-light-top.png | 1280x800 light, page top: Menubar: 48 px triggers, single border |
| menubar-1280x800-dark-top.png | 1280x800 dark, page top: Menubar: 48 px triggers, single border |
| menubar-375x812-light-top.png | 375x812 light, page top: Menubar: 48 px triggers, single border |
| menubar-375x812-dark-top.png | 375x812 dark, page top: Menubar: 48 px triggers, single border |
| skeleton-1280x800-light-top.png | 1280x800 light, page top: Skeleton: shimmer over real shapes (card/list/table) |
| skeleton-1280x800-dark-top.png | 1280x800 dark, page top: Skeleton: shimmer over real shapes (card/list/table) |
| skeleton-375x812-light-top.png | 375x812 light, page top: Skeleton: shimmer over real shapes (card/list/table) |
| skeleton-375x812-dark-top.png | 375x812 dark, page top: Skeleton: shimmer over real shapes (card/list/table) |
| popup-1280x800-light-top.png | 1280x800 light, page top: Popup: single bordered surface |
| popup-1280x800-dark-top.png | 1280x800 dark, page top: Popup: single bordered surface |
| popup-375x812-light-top.png | 375x812 light, page top: Popup: single bordered surface |
| popup-375x812-dark-top.png | 375x812 dark, page top: Popup: single bordered surface |
| dropdown_menu-1280x800-light-top.png | 1280x800 light, page top: Dropdown menu: single bordered surface |
| dropdown_menu-1280x800-dark-top.png | 1280x800 dark, page top: Dropdown menu: single bordered surface |
| dropdown_menu-375x812-light-top.png | 375x812 light, page top: Dropdown menu: single bordered surface |
| dropdown_menu-375x812-dark-top.png | 375x812 dark, page top: Dropdown menu: single bordered surface |
| filter_bar-1280x800-light-variants.png | 1280 light, scrolled: With-chips + Popup live examples |

## What looks right

- Every page renders at both widths and themes with no RenderFlex overflow
  (widget tests also assert 375 px no-overflow for the touched components).
- Calendar cells read visibly compact (32 px) with the weekday header on the same pitch.
- FAB default is enabled and elevated (token `shadowLg`); the old disabled/dimmed look is gone.
- Table shows compact rows with sort headers and pagination inside its frame.
- Filter bar top shows the inline default; the variants shot shows the Popup trigger;
  the Examples index lists Popup, Dialog, Sheet, Overflow menu open, Customized.
- Menu popup rows render at 32 px with the submenu chevron; phone widths fit 375 px.
- Dark theme surfaces (popup, menu, fab, table) read correctly on dark tokens.

## What looks wrong / observations (plainly)

- API Reference tables clip the Description column at the right edge at 1280 px
  (seen on the filter_bar Theme table). Docs-chrome rendering shared with other
  components; flagging for a docs follow-up, not fixed here.

## Not covered (and why)

- Open submenu anchored to the right edge, open popup/dialog/sheet, swipe reveal drag,
  and column/row divider drags: the canvas build exposes no DOM refs and coordinate
  click/drag is unsupported, so overlay-open and gesture states cannot be screenshotted.
  They are covered by widget tests instead (`menu_test` padding test, filter_bar popup +
  dialog open tests, swipe 48 px floor test, table resize tests incl. divider-drag tests,
  skeleton two-frames-differ loop tests).
- Shimmer motion does not show in stills; the loop is proven by the `loop` group in
  `skeleton_test.dart` (card/list/table each differ across two frames).
