# CI Fix Report: PR 62 (`fix/docs-usage-switcher`)

- **Branch**: `fix/docs-usage-switcher`
- **Date**: 2026-10-22
- **Failures fixed**: 3 (kit `check_names`, docs `charts_pages_test`, docs `motion_test`)

## 1. Kit Plain-names guardrail (`tool/check_names.dart`)

- **Cause**: `docs/test/docs_usage_switcher_test.dart` listed a second capture
  directory as an absolute path containing the old `shadcn_copy_paste`
  segment (`/Users/.../shadcn_copy_paste/scratchpad/...`). The needle scan
  (`shadcn`, case-insensitive) flagged line 27.
- **Fix**: removed the machine-specific absolute entry; kept only the relative
  `../scratchpad/ui/round2/docsusage/captures`. No guard change.
- **Verify**: `dart run tool/check_names.dart` → `check_names: 0 hits.`

## 2. Docs `charts_pages_test.dart` header overflow (33 px @1600)

- **Cause**: the new labeled locale switcher (`🌐 EN`, ~92 px vs 32 px
  icon-only) plus the GitHub label at ≥1600 overflowed the header `Row` by
  33 px. Same root caused the `motion_test` close test to fail (13 px overflow
  @375 reported as a layout exception during the drawer-close pump).
- **Fix** (`docs/lib/widgets/docs_header.dart`, 32 px heights kept):
  - GitHub button is icon-only at every width (32×32, `ButtonSize.xs`, zero
    padding, same pattern as the theme toggle) instead of showing the text
    label at ≥1600. Frees ~50 px at wide widths for the labeled switcher.
  - Bar edge inset is responsive: 24 px at ≥768, 16 px below `md`, so the
    32 px controls (Menu, GitHub, theme, locale with code) fit 375 px.
  - Locale switcher keeps the visible code (`EN`/`DE`/`PT-BR`/…) at every
    width — no test expectation changed.
- **Verify**: `charts_pages_test.dart` 16/16 pass; `motion_test.dart` 10/10
  pass (close animates over 200 ms again — the animation code was intact,
  the overflow exception was masking it).

## 3. Docs `motion_test.dart` mobile drawer close

- No drawer/shell logic change was needed. The close path
  (`AnimatedSlide` + `AnimatedOpacity` over `kDurationPopper * 2`, generation
  guard) was already correct; the test failed only on the header overflow
  layout exception at 375 px. Fix #2 resolves it.

## Gate runs (one at a time)

- `dart run tool/check_names.dart` → 0 hits
- `docs`: `charts_pages_test` 16/16, `motion_test` 10/10,
  `docs_usage_switcher_test` 5/5, `responsive_test` 5/5,
  `website_i18n_test` 8/8, `component_page_test` 13/13, `focus_test` 11/11,
  `docs_pages_test` 10/10
- `dashcn`: `navigation_bar_test` 22/22
- `dart format` (touched files) → 0 changed
- `dart analyze docs` / `dart analyze dashcn` → no issues
- Generators: `gen_scorecards`, `gen_registry_manifest`, `gen_exports`,
  `gen_previews_test`, `gen_docs_data` re-run; scorecard timing noise
  reverted, updated captures kept; `sync_registry.sh --check` → up to date
- `SIZING.md` untouched; all header controls stay 32 px, sidebar 32 px,
  TOC 28 px.
