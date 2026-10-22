# Docsshell captures

All in `scratchpad/ui/docsshell/captures/` (agent-browser, docs on :8881,
release build with deep-link fix; open states via temporary `?playground=open`,
`?scorecards=open`, `?drawer=open`, `?toast=open`, `?usage=top` query hooks,
reverted before commit — final code opens the same states via taps, verified
via widget tests).

## 1. Sidebar stays fixed
- `1280x800-light-button.png`, `1280x800-dark-button.png`
- `375x812-light-button.png`, `375x812-dark-button.png`
- Shows docs sidebar with selected item highlighted; scroll offset preserved
  via static offset (no auto-centre on route change). Only content changes.

## 2. Playground right-side panel (Figma-like)
- `1280x800-light-button-playground-open.png`, `1280x800-dark-button-playground-open.png`
- `375x812-light-button-playground-open.png`, `375x812-dark-button-playground-open.png`
- Page content replaced by playground panel on the right; sidebar stays put.
  Desktop: 380px docked panel with Close; phone: full-width overlay.

## 3. Trust scorecards dialog/sheet
- `1280x800-light-button-scorecards-open.png`, `1280x800-dark-button-scorecards-open.png` (dialog)
- `375x812-light-button-scorecards-open.png`, `375x812-dark-button-scorecards-open.png` (bottom sheet)
- "Trust scorecards" button at top opens dialog (desktop, centred 640px) or
  sheet (phone, bottom-aligned). No inline list at bottom.

## 4. Charts tab bar
- `1280x800-light-charts.png`, `1280x800-dark-charts.png` (hub, first family Area selected)
- `375x812-light-charts.png`, `375x812-dark-charts.png`
- Plus switching evidence: `*-charts-bar.png` (Bar tab selected via `/charts/bar`).
- Tab bar of families, first selected default, only selected family renders.

## 5. Usage section
- `1280x800-light-button-usage-top.png`, `1280x800-dark-button-usage-top.png`
- `375x812-light-button-usage-top.png`, `375x812-dark-button-usage-top.png`
- Shows install (`dashcn add`), minimal example in compact syntax-coloured
  snippet with copy button, key parameters list. No wall of code.

## 6. Theme switch (200ms cross-fade)
- Light vs dark pairs: `1280x800-light-button.png` vs `1280x800-dark-button.png`,
  `375x812-light-button.png` vs `375x812-dark-button.png`
- Colours cross-fade over 200ms (snapshot fades out 1→0 to reveal new base).
  Verified via `theme_switch_test` + `ts1_transition_test` (200–400ms band).

## 7. Toast (one frame)
- `1280x800-light-toast-toast-open.png`, `1280x800-dark-toast-toast-open.png`
- `375x812-light-toast-toast-open.png`, `375x812-dark-toast-toast-open.png`
- Toast appears within one frame: `ToastLayer` Stack slot always mounted,
  showing toast never moves `child` in tree (no full relayout).

## 8. Mobile drawer + menubar nav
- Drawer: `*-button-drawer-open.png` (4 combos) — scrim fades, panel slides
  out/in over 200ms, then unmounts (no lingering off-screen widgets).
- Menubar: `1280x800-light-menubar.png`, `1280x800-dark-menubar.png`,
  `375x812-light-menubar.png`, `375x812-dark-menubar.png` — bar with normal
  density padding; trailing trigger submenus anchor to trailing edge
  (`topEnd`/`bottomEnd` with mirrored offset) so right-edge menus stay on-screen.
  Popup rows use density tokens (`resolveDensityTokens().rowMinHeight`).

## 9. Header surface primitive
- `1280x800-light-button.png`, `1280x800-dark-button.png`,
  `375x812-light-button.png`, `375x812-dark-button.png` (header bar visible)
- Header paints `surfaceColor(background, surfaceOpacity)` inside
  `GlassSurface(surfaceBlur)`, matching `feat/surface-tokens-audit`
  (`docs/lib/widgets/docs_header.dart`). Opaque default identical.

## 10. Double borders
- Popup: `1280x800-light-popup.png`, `1280x800-dark-popup.png`,
  `375x812-light-popup.png`, `375x812-dark-popup.png` — `MenuPopup` inline
  with single border (outer `PreviewFrame` borderless for popup-like).
- Docs cards: `*-button.png` (4 combos) — `PreviewFrame` Card borderless +
  single overlay frame (no Card+overlay double).
