# Report: Docs Usage Parameters Table, Visible Language Switcher, Header Check & Chrome Sizing

- **Branch**: `fix/docs-usage-switcher`
- **Worktree**: `/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/dashcn-w-docsusage`
- **Notes Directory**: `scratchpad/ui/round2/docsusage`
- **Pull Request**: [#62 (https://github.com/mibrar-dev/dashcn/pull/62)](https://github.com/mibrar-dev/dashcn/pull/62)
- **Date**: 2026-10-22

---

## 1. Summary of Changes

### 1.1 Usage Parameters Table on Every Component Page
- Replaced the plain text lines in `ComponentUsageSection` ([component_sections.dart](file:///Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/dashcn-w-docsusage/docs/lib/widgets/component_sections.dart)) with `TypesetTable`.
- Configured 4 columns:
  - **Parameter** (`thParam`): Monospace parameter name.
  - **Type** (`thType`): Monospace type name (or `required` / `—`).
  - **Default** (`thDefault`): Default parameter value or `—`.
  - **Description** (`thDesc`): Documentation comment.
- Retained the install command line (`dashcn add <component>`) and the syntax-highlighted code snippet with copy button above the table.
- Added dividers (bottom borders) on the table header row and every data row.

### 1.2 Visible Language Switcher
- Updated `DocsLocaleSwitcher` in [docs_header.dart](file:///Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/dashcn-w-docsusage/docs/lib/widgets/docs_header.dart) so the trigger button prominently displays the current language code next to the globe icon (e.g. `🌐 EN` / `🌐 FR` / `🌐 JA`).
- Sized the switcher trigger to **32 px height**, consistent with all other header controls.
- The locale selection menu lists all 42 supported locales with their native names ([website_i18n.dart](file:///Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/dashcn-w-docsusage/docs/lib/state/website_i18n.dart)), highlighting the currently selected locale with a checkmark.
- Popup row items are sized to **32 px height** with 8 px horizontal padding, 16 px icons, and 4 px corner radius inside the surface, per `SIZING.md`.

### 1.3 Kit NavigationBar & Frosted Glass Header Check
- Verified that `DocsHeader` is built directly on the kit `NavigationBar` component ([navigation_bar.dart](file:///Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/dashcn-w-docsusage/dashcn/lib/src/components/navigation_bar/navigation_bar.dart)).
- Confirmed that when theme surface opacity is lowered (e.g. 0.6) and blur is enabled (`surfaceBlur` >= 12), the `NavigationBar` renders through `GlassSurface` / `BackdropFilter(sigma: 12)` with translucent background fill, blurring content scrolling behind it.

### 1.4 Docs Chrome Sizing (Strict `SIZING.md` Compliance)
- **Sidebar items**: Exactly **32 px height** (`SizedBox(height: 32)` wrapping `Clickable` with 8 px horizontal padding and `Alignment.centerLeft` in [docs_sidebar.dart](file:///Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/dashcn-w-docsusage/docs/lib/widgets/docs_sidebar.dart)).
- **TOC items**: Exactly **28 px height** (`SizedBox(height: 28)` wrapping `Clickable` with `Alignment.centerLeft` in [docs_toc.dart](file:///Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/dashcn-w-docsusage/docs/lib/widgets/docs_toc.dart)).
- **Header controls**: Exactly **32 px height** across:
  - Language switcher trigger: 32 px
  - Search trigger button: 32 px
  - GitHub repo button: 32 px
  - Theme mode toggle button: 32 px
  - Nav links: 32 px
  - Header CTA button ("Get Started"): 32 px
  - Mobile nav menu toggle: 32 px
- The exact same visual sizes apply on desktop and mobile viewports (375 px to 1600 px+), with touch comfort provided by standard hit-testing rather than oversized visuals.

---

## 2. Measured Dimensions (Screenshots & Layout)

| UI Element | Target Size (`SIZING.md`) | Measured Size (px) | Verification Method |
|---|---|---|---|
| Sidebar Item | 32 px | **32.0 px** | WidgetTester `getSize()` + screenshot |
| TOC Link | 28 px | **28.0 px** | WidgetTester `getSize()` + screenshot |
| Header Controls | 32 px | **32.0 px** | WidgetTester `getSize()` + screenshot |
| Language Switcher Trigger | 32 px | **32.0 px** | WidgetTester `getSize()` + screenshot |
| Language Switcher Menu Row | 32 px | **32.0 px** | WidgetTester `getSize()` + screenshot |
| Usage Parameters Table Header | Standard row | **32.0 px** | `TypesetTable` row height |
| Header Blur Filter | sigma: 12 | **12.0 sigma** | `BackdropFilter` inspector |
| Header Surface Alpha | <= 0.7 when translucent | **0.60 alpha** | `ColoredBox.color.a` check |

---

## 3. Captures Inventory

Captures generated and saved to `scratchpad/ui/round2/docsusage/captures/`:

1. `usage-table-light.png`: Light mode Component Usage section with the 4-column parameters table.
2. `usage-table-dark.png`: Dark mode Component Usage section with the 4-column parameters table.
3. `header-controls-32px.png`: Desktop header showing all 32 px controls including the visible "EN" globe switcher.
4. `locale-switcher-open.png`: **OPEN state** of the language switcher menu showing all 42 locales with native names and 32 px row heights.
5. `sidebar-toc-sizing.png`: 32 px sidebar items and 28 px TOC items on the Button documentation page.
6. `header-blurred-scrolled.png`: Scrolled state with 0.6 surface opacity and sigma 12 blur, showing page content blurred behind the kit `NavigationBar`.
7. `mobile-header-switcher-375.png`: Mobile 375 px viewport with 32 px "EN" globe switcher control.
8. `mobile-locale-open-375.png`: **OPEN state** of the language switcher on mobile 375 px viewport.

---

## 4. Gate Verification Results

### 4.1 Code Formatting & Linting
- `dart format .`: **Pass** (3003 files checked, 0 changed).
- `cd dashcn && dart run tool/check_names.dart`: **Pass** (0 hits).
- `dart analyze dashcn`: **Pass** (0 issues found).
- `dart analyze docs`: **Pass** (0 issues found).

### 4.2 Flutter Tests (Run One at a Time)
1. `cd docs && flutter test test/docs_usage_switcher_test.dart`: **Pass** (5/5 tests passed).
2. `cd docs && flutter test test/component_page_test.dart`: **Pass** (13/13 tests passed).
3. `cd docs && flutter test test/website_i18n_test.dart`: **Pass** (8/8 tests passed).
4. `cd docs && flutter test test/responsive_test.dart`: **Pass** (5/5 tests passed).
5. `cd docs && flutter test test/focus_test.dart`: **Pass** (11/11 tests passed).
6. `cd docs && flutter test test/p7th1_theme_everywhere_test.dart`: **Pass** (6/6 tests passed).
7. `cd docs && flutter test test/surface_rail_test.dart`: **Pass** (5/5 tests passed).
8. `cd dashcn && flutter test test/registry/components/button_test.dart`: **Pass** (12/12 tests passed).
9. `cd dashcn && flutter test test/registry/components/navigation_bar_test.dart`: **Pass** (22/22 tests passed).

### 4.3 Code Generators & Sync Mirror
- `dashcn: dart run tool/gen_scorecards.dart`: **Pass** (97 components).
- `dashcn: dart run tool/registry/gen_registry_manifest.dart`: **Pass** (`registry.json` generated).
- `dashcn: dart run tool/gen_exports.dart`: **Pass** (159 barrel libraries).
- `dashcn: dart run tool/registry/gen_previews_test.dart`: **Pass** (97 preview tests).
- `docs: dart run tool/gen_docs_data.dart`: **Pass** (generated all docs data files).
- `docs/tool/sync_registry.sh --check`: **Pass** (mirror is up to date, 924 files).

### 4.4 Docs Web Build
- `cd docs && flutter build web --release --base-href /`: **Pass** (Built `build/web` in 36.9s).
