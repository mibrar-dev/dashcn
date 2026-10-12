# P9-4b — Bring your web theme: API trim, Theme Studio import/export, CLI commands

Prerequisites: P9-4a accepted (`$APP/lib/src/theme/interop/`), P8-3 accepted (CLI renamed to `dashcn`).
Spec: `DASHCN_FEATURES_PLAN.md` §P9-4 (binding). Read `$KIT/rearch/reports/P9-4a.md` first.

## 1. Public API trim (orchestrator ruling — do this first)
1.0.0 is permanent, so the interop surface must be small and deliberate:
- `tool/gen_exports.dart`: exclude `src/theme/interop/**` from `lib/theme.dart` and `lib/dashcn.dart`; generate a
  dedicated `lib/theme_interop.dart` that exports only `src/theme/interop/interop.dart`.
- `interop.dart` exports ONLY: `WebTheme`, `ImportReport`, `CssVariant`, `parseCssTheme` (+ its result type),
  the Tailwind v3 entry point, `writeWebCss`, `writeTailwindV4Theme`, `writeDtcgTokens`, the dashcn preset
  writer(s), `webThemeFromPresetJson`, `Oklch` + `oklchFromArgb`/`argbFromOklch`, `parseWebColor`, the two
  exception types. Everything else (`stripCssComments`, `splitCssDeclarations`, `formatCssNumber`,
  `resolveCssRefs`, `missingTokens`, `ignoredReason`, `cssVarToKitToken`, …) becomes library-private or moves to
  an unexported `src/theme/interop/internal/` file. Use `show` lists, not wildcard exports.
- Keep it pure Dart (no `package:` imports) so the CLI can vendor it.
- Regenerate exports/manifest; all interop tests still pass (tests may import `src/` directly).

## 2. Theme Studio: Import and Export (docs)
- Import: a dialog (button in the Theme Studio toolbar) with a paste area + "Choose file" (`.css`, `.js`, `.json`),
  live preview of the parsed theme applied to the studio canvas, the `ImportReport` (mapped / defaulted / ignored with
  reasons), and "Apply" which loads it as the current theme document. Light/dark both previewed.
- Export: tabs "Web CSS (v4)", "Tailwind v4", "Figma tokens (DTCG)", "dashcn preset JSON", "Dart"; each a selectable
  code block with copy + download. Reuse existing code-block/copy widgets; theme-dependent spacing only.
- DTCG shape: verify against the W3C Design Tokens format; if per-token `$extensions.mode` is not what Figma
  Variables / Tokens Studio import, output one token set per mode (`light`, `dark`) and say which you chose and why.
- Tests in `$DOCS/test/theme_interop/`: paste → preview → apply round-trip; export tab contents equal the writers'
  output; import of each P9-4a fixture shows the right report counts.

## 3. CLI commands (in `$CLI`)
- Vendor `$APP/lib/src/theme/interop/` into the CLI (copy script `tool/sync_interop.sh` + `--check` mode so drift
  fails a gate; never edit the vendored copy by hand).
- `dashcn theme import <file|url> [--name <id>] [--apply]`: parses, prints the report, writes a preset JSON into the
  app (and applies it when `--apply`). `dashcn theme export --format css|tailwind|dtcg|json|dart [--out <file>]`
  exports the app's current theme.
- Unit tests + one e2e (`test/e2e/theme_interop_test.dart`): temp app → import a tweakcn-style CSS → export DTCG →
  re-import → same tokens.

## Owns
`$APP/tool/gen_exports.dart`, `$APP/lib/theme_interop.dart` (new), `$APP/lib/src/theme/interop/**`,
`$APP/test/registry/theme/interop/**`, regenerated barrels/manifest; `$DOCS/lib/**` Theme Studio import/export
widgets + `$DOCS/test/theme_interop/**`; in `$CLI`: theme commands, vendored interop, `tool/sync_interop.sh`, tests,
README section.

## Gates
Kit `rearch/qa_gate.sh` + `gen_exports --check` + `check_names`; docs format/analyze/test/`gen_docs_data --check`/
`sync_registry --check`/`flutter build web --release`; CLI format/analyze/test/e2e + `tool/sync_interop.sh --check`.
Write screenshots of the import dialog and export tabs (light + dark) to `$KIT/rearch/screenshots/p9-4b/` (do not
open them). Keep tool outputs short; never sleep > 60 s.

## Report
`$KIT/rearch/reports/P9-4b.md`
