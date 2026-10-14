# P8-2 — plain-name rename (analyzer codemod) + names guardrail

Prerequisite: P8-1 accepted (package at `$KIT/dashcn`, sources in `lib/src`).
Read first: `DASHCN_PACKAGE_PLAN.md` §2, `DASHCN_FEATURES_PLAN.md` §0 (root widget = **`DashcnApp`**).

## Goal
Remove every "shadcn" from identifiers, strings, file names and docs in the kit + docs app, with a reproducible
analyzer-driven codemod. Never hand-rename.

## Steps
1. **Inventory** (`$KIT/dashcn/tool/rename_inventory.dart` → `$KIT/rearch/plans/api_inventory.json`): every declaration
   (public + private) whose name contains `shadcn` (case-insensitive) in `lib/src`, `test`, `example`, `$DOCS/lib`,
   `$DOCS/test`, `$DOCS/tool`; plus file/folder names; plus string literals / comments / markdown / JSON (meta.json,
   manifest, presets). Compare against the table — list anything the table misses.
2. **Rename map** `$KIT/dashcn/tool/rename_map.yaml`: the plan §2 table with `ShadcnApp → DashcnApp`, plus your
   additions for every inventory item (private `_Shadcn…` → plain, localization classes
   `ShadcnLocalizations*` → `ComponentLocalizations*`, `showShadcnX` → `showX`). Flag each addition `proposed: true`;
   the orchestrator approves the map BEFORE step 3 — stop after writing the map and the inventory: write
   `$KIT/rearch/reports/P8-2.md` with a `## RESULT` block, `status: partial`, listing the proposed additions, then stop.
   (The orchestrator resumes you; on resume, overwrite that report with the final one.)
3. **Codemod** `$KIT/dashcn/tool/rename_api.dart` (`package:analyzer`, resolved AST via
   `AnalysisContextCollection` so references are exact): renames declarations + all references (incl. named
   constructors, show/hide combinators, doc-comment `[Refs]`), file names (`git mv` allowed for renamed files only),
   string/markdown/JSON occurrences via a separate explicit pass. Idempotent (`--check` = dry run that exits 1 if any
   rename is pending).
4. **Guardrail** `$KIT/dashcn/tool/check_names.dart`: fails on (a) any `shadcn` (case-insensitive) in tracked text files
   under `dashcn/`, `docs/lib`, `docs/test`, `docs/tool`, `docs/web` (allow-list file
   `tool/check_names_allow.txt` for e.g. upstream attribution lines — keep it tiny and justified); (b) any exported
   public name that is also exported by `package:flutter/widgets.dart` (resolve via analyzer). Wire into
   `rearch/qa_gate.sh` as `names:`.
5. Docs JS bridge: rename the `shadcn_flutter_theme_changed` event on BOTH sides (`$DOCS/web/index.html`,
   `$DOCS/lib/web_bridge_web.dart`) to `dashcn_theme_changed`.
6. Regenerate everything generated (exports, manifest, docs data, previews) with the repo's own generators.

## Owns
`$KIT/dashcn/**`, `$DOCS/lib/**`, `$DOCS/test/**`, `$DOCS/tool/**`, `$DOCS/web/index.html`, `$KIT/rearch/qa_gate.sh`,
`$KIT/rearch/plans/api_inventory.json`. NOT `$CLI` (P8-3 consumes your map).

## Gates
Same as P8-1 plus `dart run tool/rename_api.dart --check` (no pending) and `dart run tool/check_names.dart` (0 hits).
Report the before/after count of `shadcn` occurrences per area.

## Report
`$KIT/rearch/reports/P8-2.md` (partial at the step-2 stop, final at the end).

## Carry-overs from P8-1 (orchestrator rulings)
- Delete `dashcn/tool/registry/registry_barrel.dart` and `registry_barrel_generate.dart` (dead; replaced by
  `tool/gen_exports.dart`) — `git rm` allowed for these two files.
- `dashcn/example/` platform shells (iOS/macOS/Linux/Windows/web names, bundle ids, window titles) are still branded
  `flutter_shadcn_kit`: rename to `dashcn_example` / "dashcn example" as part of the string pass.
- `dashcn/flutter_cli_verification_example/`, `dashcn/gen/`, `dashcn/skills/`, `dashcn/scripts/`: include them in the
  inventory and rename pass like everything else (no "shadcn" may remain).
- Test runs rewrite PNGs under `rearch/screenshots/` and `rearch/design/`: never treat those as your changes.
