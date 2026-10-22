# REPORT — sidebar example overflow (`feat/sidebar-dashboard`)

## Failure

`docs/test/component_examples_test.dart` — `every listed page renders one
card per example` overflowed by 244 px on the right on the sidebar page
(1400/1440 px viewports). Render diagnostics pointed at
`docs_article.dart:418` — the component-page title row, not the stage
itself: the WIP set (`audio_player`, `video_player`, `sidebar`) carries
three badges (count + stability + the long “Work in progress: bugs may
occur.” note) plus Copy Page + prev/next actions, and the badge `Wrap`
inside an unbounded `Row` never wrapped.

## What changed

- `docs/lib/widgets/docs_article.dart` — title row: badge group wrapped in
  `Flexible` so the `Wrap` gets a bounded width and drops to the next line
  instead of overflowing the 640 px article. Tight (<560 px) column branch
  unchanged.
- `dashcn/lib/src/components/sidebar/preview.dart` (mirrored to
  `docs/lib/ui/dashcn/components/sidebar/preview.dart` via
  `sync_registry.sh`, then `gen_docs_data`) — density-token stage fit:
  - imports `theme/density_tokens.dart`;
  - `kSidebarPhoneWidth` tracks `kPhoneWidthBreakpoint` (600 px), so the
    docs 295 px example stage (375 px viewport) and any narrow stage use
    the phone bar + drawer (narrower, no 240 px rail) instead of
    overflowing;
  - dashboard desktop widths 600–720 px keep the collapsed 56 px rail
    (narrower sidebar inside the stage); wider stages use the full rail
    with the collapse toggle; content scrolls vertically when the stage
    height is bounded (`_DemoContent` internal scroll);
  - drawer cap uses `resolveDensityTokens(context).overlayMaxWidth`
    (320 compact / 400 touch), sized to the stage via
    `min(stageWidth, cap)` — full-bleed at 375 px, capped mock at 1440 px;
  - card thumbs use `tokens.controlHeight`, gaps use `tokens.gap`, menu
    glyph uses `resolveIconSize(tokens)` instead of hard-coded 32/8/18.
- Regen: `registry.json` (preview hash), docs mirror, `gen_docs_data`
  (notably `docs_example_sources.dart`).

## Gates

- `flutter test test/component_examples_test.dart --plain-name "every listed
  page renders one card per example"` (docs): passed (was 244 px overflow).
- `flutter test test/component_examples_test.dart --plain-name "D1b:
  example stage centres content at 1440 and 375"` (docs): passed.
- Remaining `component_examples_test.dart` cases (sweep, code tabs,
  no-overflow 375/1440, toolbar single-row, toolbar pins): passed, one at
  a time.
- `flutter test test/registry/components/sidebar_test.dart` (dashcn):
  9 passed.
- `flutter test test/registry/qa/previews_centered_test.dart
  --plain-name "sidebar"` (dashcn): 3 passed (Dashboard/Drawer/Collapsed).
- `flutter test test/registry/previews_test.dart --plain-name "sidebar"`
  (dashcn): passed.
- `dart format` (touched files): clean.
- `dart analyze` (touched) + `flutter analyze` (dashcn full, docs full):
  no issues.
- `gen_registry_manifest --check`, `gen_exports --check`,
  `gen_previews_test --check`, `gen_scorecards --check`: up to date.
- docs `sync_registry.sh --check`, `gen_docs_data --check`: up to date.

## PR

https://github.com/mibrar-dev/dashcn/pull/53 (open, not merged).
