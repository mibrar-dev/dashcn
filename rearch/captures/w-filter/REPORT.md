# REPORT — Batch 2B: filter_bar rewrite on theme and sizing principles (`feat/ui-filter-bar`)

Branch: `feat/ui-filter-bar` · worktree `dashcn-w-filter` · docs port 8872 · session `w-filter`.

## What was built

Redesigned the `filter_bar` component on design tokens and density principles per `DESIGN.md`:

- **Density scaling & compact default**:
  - Compact default: 36 px search field height, 16 px icon size across triggers, search, and controls, 8 px gaps (`kSpace2`), compact row spacing.
  - Touch targets: Sort dropdown and touch targets adhere to the 48 px minimum height.
  - Sizing overrides: Callers can override control dimensions per instance via `FilterBarStyle(controlHeight: ..., controlWidth: ..., iconSize: ...)` or across the tree via `FilterBarTheme`.
- **Compact overflow menu & responsive presentation**:
  - New `FilterBarPresentation.autoMenu` (default) and `FilterBarPresentation.menu` modes: On narrow screens (`< 720` or phone widths), active filters and secondary controls collapse into a compact anchored popup menu (`FilterBarOverflowMenu`).
  - Menu card respects `kOverlayMinWidthCompact` (160 px) and `kOverlayMaxWidthCompact` (320 px), uses `GlassSurface` and `surfaceColor` with card fill, border, and elevation tokens.
  - Keyboard accessible: Closes cleanly on `Escape` key press.
  - Backwards-compatible sheet support: `FilterBarPresentation.autoSheet` and `FilterBarPresentation.sheet` continue to work, rendering `FilterBarSheetScaffold` with live state mirroring and Clear all action.
- **Clear-all control**:
  - `FilterBarClearButton` renders in the inline bar, inside the overflow menu footer, and in the bottom sheet footer whenever active filters exist or `showClearAllWhenEmpty: true`.
  - Honours `FilterClearPolicy` (clearSearch, clearSort, clearDateRange, clearCustomFilters, clearChips).
- **Uncontrolled mode**:
  - `FilterBar` can now be used uncontrolled without providing `controller` or `state`/`onStateChanged` (internal controller manages search and filter state). Mutual exclusivity assert preserved.
- **Builder slots**:
  - Builders available for all key slots: `searchBuilder`, `sortBuilder`, `dateBuilder`, `clearAllBuilder`, `chipBuilder`, `counterBuilder`, `leading`, `trailing`, `triggerBuilder`, `overflowMenuBuilder`, `sheetBuilder`.
- **RTL & Accessibility**:
  - Insets and padding use `EdgeInsetsDirectional`, labels sourced from `ComponentLocalizations`, semantics labels and contrast compliant.
- **File length constraint**:
  - All source files kept strictly under ~300 lines (longest is `filter_bar.dart` at 288 lines). Split into modular single-responsibility helpers:
    - `filter_bar.dart` (288 lines): Main widget, controller/uncontrolled mode, builders, state mirror.
    - `filter_bar_style.dart` (246 lines): Visual style object, presentation enum, clear resolver.
    - `filter_bar_controls.dart` (238 lines): Search field, sort control, date control.
    - `filter_bar_triggers.dart` (110 lines): Clear button, sheet trigger, overflow trigger.
    - `filter_bar_menu.dart` (255 lines): `FilterBarOverflowMenu` and `openFilterBarMenu`.
    - `filter_bar_sheet.dart` (239 lines): `FilterBarSheetScaffold` and `openFilterBarSheet`.
    - `filter_bar_layout.dart` (208 lines): Chips row, overflow content, overflow body.
    - `filter_bar_inline.dart` (186 lines): Desktop/inline row wrap composition.
    - `filter_bar_body.dart` (171 lines): Responsive container and presentation switcher.
    - `filter_bar_search.dart` (33 lines): Caret-preserving sync helper.
    - `filter_bar_theme.dart` (12 lines): Re-export of primitive filter theme.
    - `filter_bar_overflow.dart` (4 lines): Export helper for sheet and menu scaffolds.
    - `preview.dart` (214 lines): 5 named previews (Default, With chips, Overflow menu, Overflow menu open, Customized).
    - `meta.json` (118 lines) & `README.md` (177 lines).

## Customization surface

- **Theme**: `FilterBarTheme` supporting `controlWidth`, `controlHeight`, `iconSize`, `spacing`, `runSpacing`, `searchWidth`, `dense`, and `themeDensityTokens`.
- **Style**: `FilterBarStyle` supporting `controlWidth`, `controlHeight`, `iconSize`, `searchWidth`, `padding`, `backgroundColor`, `borderColor`, `borderRadius`, `elevation`, `textStyle`, `dense`, and `overflowMenuWidth`.
- **Builders**: `searchBuilder`, `sortBuilder`, `dateBuilder`, `clearAllBuilder`, `chipBuilder`, `counterBuilder`, `leading`, `trailing`, `triggerBuilder`, `overflowMenuBuilder`, `sheetBuilder`.

## Files

- **New files in kit**:
  - `dashcn/lib/src/components/filter_bar/filter_bar_body.dart`
  - `dashcn/lib/src/components/filter_bar/filter_bar_controls.dart`
  - `dashcn/lib/src/components/filter_bar/filter_bar_inline.dart`
  - `dashcn/lib/src/components/filter_bar/filter_bar_layout.dart`
  - `dashcn/lib/src/components/filter_bar/filter_bar_menu.dart`
  - `dashcn/lib/src/components/filter_bar/filter_bar_overflow.dart`
  - `dashcn/lib/src/components/filter_bar/filter_bar_search.dart`
  - `dashcn/lib/src/components/filter_bar/filter_bar_sheet.dart`
  - `dashcn/lib/src/components/filter_bar/filter_bar_triggers.dart`
  - `dashcn/test/registry/components/filter_bar_density_test.dart`
- **Updated files in kit**:
  - `dashcn/lib/src/components/filter_bar/filter_bar.dart`
  - `dashcn/lib/src/components/filter_bar/filter_bar_style.dart`
  - `dashcn/lib/src/components/filter_bar/preview.dart`
  - `dashcn/lib/src/components/filter_bar/meta.json`
  - `dashcn/lib/src/components/filter_bar/README.md`
  - `dashcn/lib/src/primitives/filter_core/filter_theme.dart`
  - `dashcn/lib/components/filter_bar.dart` (generated exports)
  - `dashcn/lib/dashcn.dart` (generated exports)
  - `dashcn/lib/src/manifests/registry.json` (generated)
  - `dashcn/lib/src/manifests/scorecards.json` (generated)
- **Updated files in docs**:
  - `docs/lib/generated/*` (regenerated via `gen_docs_data.dart`)
  - `docs/lib/ui/dashcn/components/filter_bar/*` (synced via `sync_registry.sh`)
- **Captures**:
  - `rearch/captures/w-filter/filter_bar_1280_light.png`
  - `rearch/captures/w-filter/filter_bar_1280_dark.png`
  - `rearch/captures/w-filter/filter_bar_1280_light_open.png`
  - `rearch/captures/w-filter/filter_bar_1280_dark_open.png`
  - `rearch/captures/w-filter/filter_bar_375_light.png`
  - `rearch/captures/w-filter/filter_bar_375_dark.png`
  - `rearch/captures/w-filter/filter_bar_375_light_open.png`
  - `rearch/captures/w-filter/filter_bar_375_dark_open.png`
  - `rearch/captures/w-filter/filter_bar_interaction.webm`
  - `rearch/captures/w-filter/CAPTURES.md`
  - `rearch/captures/w-filter/REPORT.md`

## Gate exit codes

1. `dart format --output=none --set-exit-if-changed lib test tool` → exit 0 (0 changed).
2. `dart run tool/check_names.dart` → exit 0 (0 hits).
3. `dart analyze` (dashcn) → exit 0 (No issues found).
4. `bash rearch/qa_gate.sh` → exit 0:
   - `format`: Formatted 1429 files (0 changed)
   - `exports`: exports are up to date (158 libraries checked)
   - `analyze`: No issues found! | tests: No issues found!
   - `test`: test/registry passed
   - `rearch`: +42: All tests passed!
   - `theme`: check_user_theme: 0 finding(s)
   - `banned`: none
5. `flutter analyze` (docs) → exit 0 (No issues found).
6. `dart run tool/gen_docs_data.dart --check` → exit 0 (up to date).
7. `bash tool/sync_registry.sh --check` → exit 0 (up to date).
8. `flutter build web --release --base-href /` → exit 0 (Built build/web).
9. Visual verification: All 8 PNG screenshots (1280 & 375, light & dark, default & open) + WebM interaction video captured.

## Pull Request
- Target repo: `mibrar-dev/dashcn`
- Base: `main`
- Branch: `feat/ui-filter-bar`
- PR URL: https://github.com/mibrar-dev/dashcn/pull/39

## Anything not done
- None. All requested features, density tokens, overflow menu, keyboard navigation, backward compatibility, builder slots, unit/widget tests, visual captures, and gates are complete.
