# Website prose still in English (phased in later)

Docs prose — long article paragraphs, generated registry copy and demo
sample data — stays English for now. Only short website chrome is translated
(see `docs/lib/state/docs_strings.dart`: header, nav, sidebar groups, docs
section names, buttons, footer, search, article actions, component page
section labels, scorecard title, playground controls, placeholder, table
headers, landing hero, back/view buttons). Everything below stays English.

## Prose pages (article paragraphs)

- `docs/lib/pages/introduction_page.dart` — all paragraphs (`Source you
  own`, `One command install`, `Presets included` sections and body copy).
- `docs/lib/pages/getting_started.dart` — step copy (`Create a Flutter
  project`, `Install the layer core`, `Add components`, `Choose a preset`,
  `Verify`, starter/eject paragraphs).
- `docs/lib/pages/package_or_own_page.dart` — `Which one?`, `How eject
  works`, `How updates differ`, `The lock file` prose.
- `docs/lib/pages/material_interop_page.dart` — clashing-names, mixed
  example, theming-island, `DashcnApp vs MaterialApp`, touch-target prose.
- `docs/lib/pages/theming_page.dart` — Tokens, radius, presets, component
  themes, sizing/density, glass surfaces, animated theming, motion prose.
- `docs/lib/pages/dark_mode_page.dart` — How It Works / Setting / Toggling /
  Following-the-System prose.
- `docs/lib/pages/internationalization_page.dart` — switcher/RTL/override/
  install prose (demo strings themselves are translated via the kit).
- `docs/lib/pages/cli_reference.dart` — command documentation prose.
- `docs/lib/pages/scorecards_page.dart` — Metrics / How-produced / Limits
  prose; scorecard detail labels (a11y rows, RTL rows, frame rows, test
  rows, badges) stay English with the registry data.
- `docs/lib/pages/components_index_page.dart` — description + closing
  paragraph.

## Generated registry copy (English source data)

- `component_page.dart` — component names, descriptions, usage snippets,
  API/member/theme/keyboard tables and their `doc` strings (generated).
- `component_examples_section.dart` — example names + descriptions.
- Sidebar component/block/flow/starter names and category ids
  (`sidebar_groups.dart`) — registry proper nouns, intentionally untranslated.
- Palette entries (component/block/flow/starter/preset names, CLI rows).
- `fileCountLabel` details aside, code snippets/commands stay English.

## Marketing/subtitle copy (short but English for now)

- `landing_page.dart` — collage demo content (sample names/messages).
- `blocks_pages.dart` — `Building Blocks for the Web` subtitle, family
  descriptions, `Featured`, `No blocks in this family yet`,
  `Installed with this block` lines.
- `flows_pages.dart` — `Flows that feel like apps` subtitle, flow/screen
  copy, screen counts.
- `starters_pages.dart` — `Start from a template` subtitle, `What you
  get`/`Generated files`/`Next steps` bodies, template descriptions.
- `charts_*.dart` — `Copy-paste charts…` subtitle, family blurbs.
- `themes.dart` + `theme_rail.dart` — Theme Studio rail/control labels
  (`Base colour`, `Surface opacity`, …), canvas labels, dialogs.
- `get_code_dialog.dart`, `theme_import_dialog.dart`,
  `open_preset_dialog.dart` — tab names and hints.
