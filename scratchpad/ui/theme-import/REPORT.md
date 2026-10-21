# REPORT: theme import via CLI preset string + variable audit + fonts

Branch: `feat/theme-import-cli` · worktree `dashcn-w-themeimport` (this
worktree only — see §0). Sample input and the design note live in the
parent checkout (`scratchpad/ui/theme-import/sample_tailwind_theme.css`,
`scratchpad/ui/design/DESIGN.md`); a copy of the sample is vendored at
`scratchpad/ui/theme-import/sample_tailwind_theme.css` and
`dashcn/test/registry/theme/interop/fixtures/sample_tailwind_theme.css`
so this worktree is self-contained.

## §0 Scope decision (why the CLI repo is untouched)

`dashcn theme import` / `apply` / `update` / `font` ship from the separate
`mibrar-dev/dashcn_cli` repo (per `INSTRUCTIONS.md`), which vendors its
own copy of the interop layer. The brief constrained work to this
worktree, so this batch implements everything the CLI needs as tested
kit/docs foundation — codec, diff, resolver hook, font decision, builder
UI — and §5 specifies the small CLI-repo follow-up that wires it up.
No network code ships anywhere here.

Decisions recorded rather than asked: (1) `dcn1_` = canonical JSON +
raw DEFLATE + base64url-nopad, versioned prefix; (2) Google Fonts is the
default source, local `font add` the fallback; (3) at-rules get report
lines (existing tests updated); (4) `--shadow-x/-y` aliased to the
offset atoms; (5) `calc()` in `@theme` aliases stays unevaluated with a
clear ignore line.

## §1 What was built

Kit (`dashcn/lib/src/theme/interop/`, pure Dart, widgets/Material-free):

- `preset_codec.dart` — `encodePresetString` / `decodePresetString`
  (`dcn1_` + canonical JSON + raw DEFLATE + base64url, documented in the
  file header as encoding-not-encryption), `canonicalPresetJson`,
  `PresetDiff` + `diffPresetDocuments` (added/changed/removed dotted
  paths, `reportLines()` with `+`/`~`/`-`), and `PresetStoreResolver` /
  `UnconfiguredPresetStoreResolver` (interface only, no network; short
  ids fail loudly). Unknown versions (`dcn2_…`) and malformed input are
  rejected with clear messages. Decoding is local.
- `google_fonts_catalogue.dart` — bundled Google Fonts snapshot
  (Orbitron, Rajdhani, Fira Code + Studio families + common families;
  verified 2026-10-21 against the public metadata list), catalogue
  contract constants (`kGoogleFontsMetadataUrl` — no API key,
  `kGoogleFontsCacheFile`), `firstFontFamily`, `resolveFontFamily`
  (google default / local fallback with reason, never a silent swap),
  `googleFontsPubspecLine` (`google_fonts: ^9.0.0`), snippet builders.
- `interop.dart` — re-exports both modules (`show`).
- Parser fixes: `internal/css_mapping.dart` aliases `--shadow-x/-y` to
  `offsetX/offsetY` (writers still emit the canonical
  `--shadow-offset-x/-y`); `css_theme_parser.dart` + `internal/
  css_syntax.dart` record `@import`, `@custom-variant`, `@layer`/`@media`
  wrappers and `@apply` statements as `ignored` entries with reasons —
  nothing is dropped silently any more.
- `dashcn/pubspec.yaml` — new `archive: ^4.0.0` dependency (pure Dart,
  no Flutter/Material import): `dart:io` compression is unavailable on
  web, where the Theme Studio must generate the identical string live.
  Justification recorded here per the kit rules; kit stays widgets-only.

Docs site (`docs/`):

- `lib/theme/preset_share.dart` — `presetStringFromDocument`,
  `presetApplyCommand`, `presetUpdateCommand`, `presetShareGuide`.
- `lib/widgets/get_code_dialog.dart` — new `Preset string` tab: live
  `dcn1_` string in a read-only field with its own copy button plus both
  `--preset` commands prefilled; the pane listens to the model so the
  string updates on every token change (no file export step).
- `docs/pubspec.yaml` — same `archive` dep for the synced mirror
  (`tool/sync_registry.sh` run; `--check` passes).

Tests:

- `dashcn/test/registry/theme/interop/preset_codec_test.dart` — all 43
  registry presets round-trip; key order never changes the string;
  unknown-version/malformed rejection; diff paths; resolver hook fails
  loudly.
- `.../sample_tailwind_v4_import_test.dart` — every `:root` (52) and
  `.dark` (50) variable is mapped or listed as unused; per-mode colours;
  fonts/radius/spacing/tracking/shadow atoms; derived sizes + directives
  reported; `@theme` `var()` refs resolve.
- `.../font_source_test.dart` — Orbitron/Rajdhani/Fira Code → Google;
  made-up family → local with `font add` reason; pin + snippets.
- Updated: kit `web_css_fixtures_test.dart`, docs
  `theme_web_bridge_test.dart` (old tests pinned the silent skips).
- `docs/test/theme_interop/preset_share_test.dart` — encode/decode
  identity for the live document and every registry preset, string
  changes per token edit, widget test: Preset tab shows the live string
  + both commands, in-pane copy writes the string, a rail edit updates it.

Deliverables: `scratchpad/ui/theme-import/AUDIT.md` (§2 of the brief),
this file, and the sample copy.

## §2 Command usage

Builder (docs site): `/themes` → `Get Code` → `Preset string` tab. The
read-only field always shows the current document's string; copy it.

```bash
# First-time install in a project with no dashcn theme yet
# (refuses when a theme exists unless --force):
dashcn apply --preset dcn1_…

# Existing project: replaces only the preset-owned theme file + font
# entries, never user widget code; backs up the previous preset, prints
# the token diff (added/changed/removed), supports --dry-run:
dashcn update --preset dcn1_… [--dry-run]

# Local font for a family missing from Google Fonts:
dashcn font add <family> <file>   # copies to assets, registers pubspec
```

`§5` is the CLI-repo wiring spec for these three commands.

## §3 Audit summary

Full table in `AUDIT.md`. Headline for the sample: **122 mapped,
0 defaulted, 38 ignored** — every required token comes from the source.
Colours (32×2, oklch/hsl/hex), charts 1–5, sidebar-*, radius, spacing,
tracking-normal, all six shadow atoms per mode, and all three fonts map
to existing tokens. Unused: eight derived shadow sizes + four radius
steps (recomputed at build — keep ignoring), `tracking-tighter/wider/
widest` (no kit counterpart — ignore with reason), `tracking-tight/
wide` `calc()` aliases (kit tokens exist; propose single-op `calc()`
evaluation as a follow-up so they map instead of defaulting),
`--color-*` aliases (keep ignoring), directives (now reported).

## §4 Font decision

Default: **Google Fonts**. Rationale: zero asset work for the user, the
three sample families (display/body/mono incl. Orbitron) are all in the
catalogue, and `GoogleFonts.getFont('…')` in generated code stays valid
for any catalogue family. The kit itself never depends on `google_fonts`
(its package pulls Material-only helpers; kit must stay widgets-only) —
only the CLI-added user pubspec entry (`google_fonts: ^9.0.0`, published
2026-09-28, ≥2 weeks old on 2026-10-21) and the generated `GoogleFonts`
reference. Not on Google Fonts → `dashcn font add` local path with an
explicit report line; never a silent fallback font. Catalogue refresh:
CLI fetches `https://fonts.google.com/metadata/fonts` (no key) into
`.dashcn/google-fonts.json`; the bundled const set is the offline
fallback.

## §5 Not done (CLI-repo + hosted follow-ups)

1. `dashcn_cli` wiring (separate repo): add `apply --preset` (refuse
   when a theme exists → point at `update`, `--force` overrides; write
   preset file + fonts + pubspec entries), `update --preset` (backup
   previous preset to `<id>.json.bak`, `diffPresetDocuments` print,
   `--dry-run`), `font add <family> <file>` (copy + pubspec block via
   `localFontPubspecBlock`); vendor-sync `preset_codec.dart`,
   `google_fonts_catalogue.dart`, the `shadow-x/-y` aliases and at-rule
   lines into its `lib/src/theme_interop/` copy (or depend on the kit);
   fetch + cache the font list per §4; run that repo's gates.
2. Hosted short-id store resolving `--preset bciwvKBk` → full string
   (the `PresetStoreResolver` hook is the seam; `Unconfigured…` is the
   placeholder).
3. Single-operation `calc()` evaluation in `@theme` aliases (see §3).
4. New `archive` dep also needed in `dashcn_cli/pubspec.yaml` when it
   vendors the codec.

## §6 Gate exit codes (all 0)

Kit (`dashcn/`): `dart format --output=none --set-exit-if-changed lib
test tool` → 0 (0 changed); `dart analyze` (full) → 0; `dart run
tool/check_names.dart` → 0 (0 hits); `dart run tool/gen_exports.dart
--check` → 0 (158 libs); `flutter test` touched areas → 0 each:
`preset_codec_test` (11), `sample_tailwind_v4_import_test` (8),
`font_source_test` (7), `web_css_fixtures_test` (12).

Docs (`docs/`): `dart format …` → 0; `dart analyze` (full) → 0;
`dart run tool/gen_docs_data.dart --check` → 0;
`bash tool/sync_registry.sh --check` → 0; `flutter test` touched areas
→ 0 each: `preset_share_test` (5, incl. live-update widget test),
`theme_web_bridge_test` (12), `theme_export_test` (9),
`theme_import_dialog_test`, `themes_page_test` (21).

Tests ran one at a time (no parallel flutter runs). Note: early gate
runs captured `tail`'s exit; all gates above were re-verified with
`pipefail` so the codes are the tools' own.

## §7 PR

PR URL: (filled after `gh pr create --repo mibrar-dev/dashcn --base main`)

Body ends with: 🤖 Generated with [Claude Code](https://claude.com/claude-code)
— NOT merged, per the brief.

Co-Authored-By: Claude Haiku 5.5 <noreply@anthropic.com>
