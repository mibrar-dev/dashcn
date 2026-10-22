# REPORT — dashboard sidebar (`feat/sidebar-dashboard`)

## What changed

New `sidebar` component (`dashcn/lib/src/components/sidebar/`): a
production dashboard sidebar that renders as a fixed column on desktop and
inside a drawer/sheet on phone widths.

- `sidebar.dart` — `DashboardSidebar` plus `SidebarItem` (id/label/icon/
  optional badge/optional children), `SidebarSection` (optional label +
  items) and `SidebarUser` (name/email). Header: logo tile, title, collapse
  control (48 px hit target, localized Collapse/Expand semantics). Rows:
  32 px, 16 px icon, label, badge, trailing chevron with `MotionChevron`,
  active highlight from `sidebarAccent` tokens. Collapsed mode: 56 px rail,
  icons only with tooltips, group dividers, avatar-only footer. Footer:
  avatar (initials), name, email, dropdown chevron. Surface goes through
  the surface primitive (`surfaceColor` + `GlassSurface`), so surface
  opacity/blur apply. Same widget drops into an `openDrawer` builder.
  Keyboard: `↑`/`↓` move between visible rows, `Home`/`End` jump, `→`
  expands / `←` collapses (mirrored in RTL), `Enter`/`Space` activate via
  `Clickable`; rows override Clickable's arrow traversal with an unhandled
  marker intent so arrows bubble to the scope handler. Row taps focus the
  row, keeping pointer and keyboard selection in sync.
- `sidebar_style.dart` — `SidebarTheme` (12 legs incl. `surfaceOpacity` /
  `surfaceBlur`), sizing constants (240/56/32/16/12), `sidebarDefaults`.
- `sidebar_theme.dart` — user overrides (empty, as convention).
- `preview.dart` — `sidebarPreviews`: Dashboard (responsive: rail + content
  ≥560 px, phone bar + drawer below), Drawer (400 px capped phone mock),
  Collapsed (56 px rail + content). Self-contained, constraint-driven.
- `meta.json` / `README.md` — registry entry (Navigation) incl. keyboard
  table (feeds the docs Accessibility section), sizes, install/import.
- Docs: `component_page.dart` shows `Work in progress: bugs may occur.`
  for `audio_player`, `video_player` and `sidebar` through one shared set.
- Tests: `sidebar_test.dart` (9: render, tap, submenu toggle, keyboard,
  RTL, collapsed 56 px, 240 px, 375 px), `surface_everywhere_test.dart`
  gains the sidebar frosted-rail group, `i18n_guard_test.dart` gains one
  allow-list entry (demo brand default), `sidebar_captures_test.dart`
  renders all 16 captures.
- Regen: `registry.json`, exports (159 libs), `previews_test.dart` +
  `previews_centered_test.dart` (97 components), `scorecards.json`
  (a11y all-pass), docs mirror + `gen_docs_data` (18 files).

## Captures

`scratchpad/ui/sidebar/`: 12 harness PNGs (3 examples + drawer-open ×
1280x800/375x812 × light/dark) + `docspage_1280_light.png` (live docs page
with WIP badge). See CAPTURES.md. Reviewed for spacing, alignment and
padding; two layout fixes applied (Dashboard width, Drawer phone mock).

## Gates (codes)

- `dart format` (kit + touched docs file): clean.
- `flutter analyze` (kit full + docs touched): no issues.
- `flutter test test/registry`: 6418 passed.
- `flutter test test/rearch`: 42 passed.
- `flutter test test/tool`: 26 passed.
- `flutter test test/scorecards`: 109 passed (sidebar a11y all-pass).
- `flutter test test/...component_page_test.dart` (docs): 13 passed.
- `tool/check_names.dart`: 0 hits.
- `gen_registry_manifest --check`, `gen_exports --check`,
  `gen_previews_test --check`, `gen_scorecards --check`: up to date.
- docs `sync_registry.sh --check`, `gen_docs_data --check`: up to date.
- `flutter build web --release --base-href /dashcn/`: built.

## PR

https://github.com/mibrar-dev/dashcn/pull/53 (open, not merged).
