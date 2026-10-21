# REPORT — Batch 1A: density + sizing foundation (`feat/ui-density-foundation`)

Branch: `feat/ui-density-foundation` · worktree `dashcn-w-ui1` · docs port 8861.

## What was built

DESIGN.md sizing/density foundation in `dashcn/lib/src/theme/`:

- `density_tokens.dart` (new, 276 lines): `DensityPreset`
  (compact/comfortable/touch), `DensityTokens` with DESIGN.md values —
  compact (default): control 32, icon 16, row 32-36, hPad 12, vPad 6,
  gap 8, body 14/sub 13, overlay 160/320; comfortable: 40/20/40-44/
  14/8/10/15/14, overlay 180/360; touch: 48/24/48-56/16/12/12/16/15,
  overlay 200/400. Spacing constants `kSpace1..kSpace8` +
  `kSpacingScaleSteps` (4, 8, 12, 16, 24, 32). Icon resolvers
  `resolveIconSize` (16/20/24) and `buttonIconSize` (capped at 60% of
  control). Phone breakpoint `kPhoneWidthBreakpoint = 600`,
  `isPhoneWidth`, and `resolveDensityTokens` (override wins; else touch
  on phone widths with nonzero MediaQuery width; else theme value).
- `ThemeData.densityTokens` (default `compact`) + copyWith/lerp/==/hash;
  `ComponentThemeData.themeDensityTokens` (wins over legacy
  `themeDensity`); old `Density` system untouched (all existing callers
  keep compiling).
- Reference components (sizes only, no behaviour change):
  - `Button`: new `densityTokens` widget param; resolves
    widget → `ButtonTheme.themeDensityTokens` (tree + app legs) →
    phone-aware theme. New `buttonMetricsForTokens` table: `sm` =
    control (32/40/48), `md`/`icon` = row max (36/44/56),
    `xs` = control−4, `lg` = rowMax+4; compact reproduces upstream
    exactly (28/32/36/40, pad 8/12/16/24, icon 36) so every existing
    size assertion still holds; comfortable/touch step up
    (pad 10/14/20/28 and 12/16/24/32, icon 44/56). Gap and status gap
    use `tokens.gap`; label text uses token body size; icons get a
    density `IconTheme` default (explicit `Icon(size:)` still wins).
    Old `buttonMetricsFor` kept for back-compat.
  - `ListTile`: new `densityTokens` widget param + `ListTileTheme`
    leg; padding/gap/type/icon from tokens (hPad 12/14/16, vPad 6/8/12
    with dense = tokens−2, gap 8/10/12, body 14/15/16, sub one step
    smaller, icon 16/20/24); title/subtitle ellipsis; leading
    constrained to row max; trailing `Flexible` — no 375px overflow.
- Docs: theme README “Sizing and density” table + snippets; theming
  page section with `sizing` code sample + `DensityDemos` (live
  compact/comfortable/touch rows of Button + ListTile).
- Downstream overflow fixes exposed by touch-on-phones (all narrow-
  viewport, all keep desktop layout identical): button icon preview
  status truncates; table pagination hides the selection count and uses
  icon-only Prev/Next below 600 px; card footer stacks below 600 px via
  MediaQuery (CardFooter gives children unbounded width, so no
  LayoutBuilder/Wrap); swipe-action labels truncate; docs example
  toolbar uses xs actions + xs gap below 600 px; flows cards use
  icon-only copy below 600 px.

## Customization surface

- Theme: `ThemeData(densityTokens: …)`; per instance:
  `Button(densityTokens: …)`, `ListTile(densityTokens: …)`;
  component legs: `ButtonTheme(themeDensityTokens: …)`,
  `ListTileTheme(themeDensityTokens: …)` (also works through
  `ComponentTheme<T>` tree and `ComponentThemes` app legs).
- Tokens are plain `copyWith`able values; `DensityTokens.lerp`
  animates theme changes. Phone auto-touch is overridden by any
  explicit widget value.

## Files

- New: `dashcn/lib/src/theme/density_tokens.dart`,
  `dashcn/test/registry/theme/density_tokens_test.dart` (10 tests),
  `docs/lib/widgets/density_demos.dart`, captures + docs in
  `rearch/captures/w-ui1/`.
- Edited (kit): `theme.dart`, `button.dart`, `button_layout.dart`,
  `button_style.dart`, `button preview.dart`, `list_tile.dart`,
  `list_tile_style.dart`, `swipe_action_buttons.dart`,
  `table preview.dart`, `card preview.dart`, `meta.json` ×2,
  `theme/README.md`, manifests/exports/scorecards (regen).
- Edited (tests): `button_test`, `button_status_extra_test`,
  `layout_audit_density_test` (token table), `layout_audit` button
  audit (tokens).
- Edited (docs): `theming_page.dart`, `docs_samples.dart` (sizing),
  `example_preview_card.dart`, `flows_pages.dart`, generated data
  (regen), mirrored `ui/dashcn` (sync).

## Gates (exit codes)

- `dart format --output=none --set-exit-if-changed …` → 0 (kit 1410
  files + docs).
- `dart run tool/check_names.dart` → 0 hits.
- `dart analyze` → No issues (kit `lib/src` + `test/registry`; docs).
- `rearch/qa_gate.sh` → exit 0: format ok, exports ok, analyze ok,
  `flutter test test/registry` +6103 pass, `test/rearch` +42 pass,
  layers warnings only (file-too-long 76, unused-dependency 6 —
  pre-existing), owner switcher preview (pre-existing),
  `check_user_theme` 0, banned empty.
- `cd dashcn && flutter test test tool` → kit suite passes
  (registry + rearch; `tool/` has no runnable tests beyond scripts).
- docs: `flutter analyze` → No issues; `flutter test` → 900 pass;
  `gen_docs_data.dart --check` → up to date;
  `sync_registry.sh --check` → up to date;
  `flutter build web --release --base-href /` → success (served on
  8861 for captures).

## Deliver

- Commit message trailer: `Co-Authored-By: Claude Opus 5.5
  <noreply@anthropic.com>`.
- PR: https://github.com/mibrar-dev/dashcn/pull/35 (base `main`,
  ends with the Claude Code footer).
- Captures: see `CAPTURES.md` (10 PNGs: 1280×800 + 375×812, light +
  dark, browser real-font + flutter-test layout proofs). No RenderFlex
  overflow at 375 in any density for button/list_tile (asserted in
  `density_tokens_test`); full-page 375 suites (component examples,
  flows capture) pass with touch active.

## Not done / notes

- Other components still use legacy `Density` scaling; they adopt
  `DensityTokens` in their own batches (button/list_tile are the
  reference). `buttonMetricsFor` (legacy) is kept until its audit
  callers migrate.
- Touch icon buttons are row-max squares (36/44/56); control-height
  squares would be smaller but would break the upstream 36 px compact
  contract — kept upstream-exact at compact by design.
- Previews that embed buttons (table pagination, card footers) adapt
  below 600 px (icon-only / stacked / count hidden) instead of
  overflowing; desktop rendering is unchanged. Test fonts (Ahem) are
  wider than production fonts, so these adaptations are conservative —
  production has more margin, never less.
- No interaction video: the sizing demos are static rows; the only
  behaviour (phone auto-touch) is asserted in tests + 375 captures.

🤖 Generated with [Claude Code](https://claude.com/claude-code)
