# dashcn — package + plain-names plan

Status: **proposal — awaiting approval** (no code changes yet). Owner: orchestrator. Date: 2026-10-12.

## 0. Decisions already made (Ibrar)
- Package name **`dashcn`** (free on pub.dev, as are `dashcn_cli` and `dashcn_ui` — checked 2026-10-12).
- **Plain names**, no "shadcn"/"Shadcn" anywhere in the public API, paths, CLI or site. Where a plain name would clash
  with Flutter's `widgets` library, use a *descriptive* alternative (e.g. `FormScope`, `Picture`), never a prefix.
- Clean break (pre-release): no aliases, no deprecated typedefs, no migrate command.
- The kit stays widgets-only (no Material/Cupertino), one design system on top of `package:flutter/widgets.dart` —
  the same position Material and Cupertino take once they are decoupled into their own packages.

## 1. Target shape

```
dashcn/                          (repo: today's flutter_shadcn_kit, package renamed)
  lib/dashcn.dart                barrel: everything a typical app needs
  lib/foundation.dart            per-layer libraries (tree-shakeable, explicit imports)
  lib/theme.dart
  lib/primitives.dart
  lib/components/<id>.dart       one library per component (e.g. package:dashcn/components/button.dart)
  lib/blocks/<id>.dart           blocks importable too
  lib/src/...                    the current registry tree (foundation/theme/primitives/components/blocks)
  example/                       small runnable app
  CHANGELOG.md, LICENSE, README.md, pubspec.yaml (version 0.1.0)
dashcn_cli/                      (today's shadcn_flutter_cli) executable `dashcn`
docs/                            depends on `dashcn` (path dep in repo, hosted dep in CI)
```

Two ways to use it, from the same source:
1. **Package** — `flutter pub add dashcn`, `import 'package:dashcn/dashcn.dart';` — updates via semver.
2. **Own the code** — `dashcn add button` copies source into `lib/ui/dashcn/` (configurable), as today; and
   `dashcn eject button` turns a package-imported component into owned source in the app.

## 2. Rename map (public API)

| Today | New | Why |
|---|---|---|
| `ShadcnApp` | **`App`** | plain; Material uses `MaterialApp`. Alt if `App` is too generic in user code: `DesignApp` |
| `ShadcnTheme`, `ShadcnThemeData`, `ShadcnThemeDataTween` | `Theme`, `ThemeData`, `ThemeDataTween` | widgets has none (Material's are in material.dart) |
| `ShadcnColors` | `ThemeColors` | avoids Material `ColorScheme` |
| `ShadcnFonts` | `ThemeFonts` | |
| `ShadcnTokens` | `DesignTokens` | |
| `ShadcnForm`, `ShadcnFormField` | `FormScope`, `FormItem` | widgets has `Form`/`FormField`; `FormItem` is shadcn's own term |
| `ShadcnImage` | `Picture` | widgets has `Image` |
| `ShadcnTable`, `…Row`, `…Cell`, `…Header`, `…Footer`, `…State` | `TableView`, `TableViewRow`, `TableViewCell`, `TableViewHeader`, `TableViewFooter`, `TableViewState` | widgets has `Table`/`TableRow`/`TableCell` |
| `ShadcnRadioGroup`, `ShadcnRadioGroupController` | `RadioSet`, `RadioSetController` | widgets now has `RadioGroup` |
| `ShadcnPage`, `ShadcnPageRoute`, `ShadcnPageTransition` | `AppPage`, `AppPageRoute`, `AppPageTransition` | widgets has `Page`/`PageRoute` |
| `ShadcnDialogRoute`, `ShadcnDrawerRoute` | `DialogRoute`, `DrawerRoute` | not in widgets |
| `ShadcnLayer` | `AppLayer` | |
| `ShadcnLocalizations` (+ 50 language/part classes, delegate) | `ComponentLocalizations` (+ `ComponentLocalizationsAr` …, `ComponentLocalizationsDelegate`) | widgets has `Localizations`; Material uses `MaterialLocalizations` |
| `ShadcnSelectionControls` | `SelectionControls` | widgets has `TextSelectionControls` only |
| `ShadcnTextSelectionToolbar` | `SelectionToolbar` | |
| `ShadcnUI` | remove (barrel replaces it) | |
| `showShadcnDialog`, `showShadcnPopup`, `showShadcnMenu`, `showShadcnDropdown`, `showShadcnContextMenu` | `showDialog`, `showPopup`, `showMenu`, `showDropdown`, `showContextMenu` | not in widgets (Material's `showDialog`/`showMenu` only clash if mixed) |

Everything else (Button, Card, Badge, Dialog, Select, Calendar, …) is already plain. A guardrail script fails the build
if any public symbol clashes with `package:flutter/widgets.dart` or contains `shadcn`.

**Mixing with Material** (documented, not avoided): `Theme`, `ThemeData`, `Card`, `Chip`, `Dialog`, `Slider`, `Switch`,
`Checkbox`, `Tooltip`, `showDialog`, `showMenu` clash with material.dart → `import 'package:dashcn/dashcn.dart' as ui;`
or `hide`. README section "Using dashcn alongside Material".

## 3. Non-API renames
- Paths: `lib/registry/` → `lib/src/` (package) with the same layer folders; copy-paste install dir `lib/ui/shadcn/` →
  `lib/ui/dashcn/` (configurable in `dashcn.yaml`).
- CLI: package `dashcn_cli`, executable `dashcn` (`dashcn init|add|remove|update|eject|list|search|info|doctor|theme`);
  lock `dashcn.lock`, config `dashcn.yaml` / `.dashcn/`; manifest `registry.json` keeps its schema (renamed fields only
  where they say shadcn).
- Docs site: title/brand `dashcn`, all code samples, install commands, search, CLI reference regenerated.
- Repos (needs Ibrar): rename `mibrar-dev/shadcn_flutter_kit` → `mibrar-dev/dashcn` and `flutter_shadcn_cli` →
  `dashcn_cli` (GitHub keeps redirects); GitHub Pages URL changes accordingly.
- Theme preset JSON + generated `app_theme.dart`: rename symbols inside; preset ids unchanged.

## 4. Phases (each = agent batches + orchestrator QA + commit + push)

**P8-0 Prep (orchestrator)** — finish & commit the in-flight P7 fixes on `refactor/rearchitecture`; open a new branch
`refactor/dashcn` from it; freeze the API inventory (generate `rearch/plans/api_inventory.json` from the manifest).

**P8-1 Package skeleton** — `pubspec.yaml` name `dashcn`, version `0.1.0`, `lib/dashcn.dart` barrel + per-layer and
per-component libraries generated by a tool (`tool/gen_exports.dart --check`), `lib/src/` move (git mv to keep history),
`example/` app, analysis/lints, `dart pub publish --dry-run` clean (pub points: docs, license, example, platforms).

**P8-2 Plain-name rename** — codemod tool (`tool/rename_api.dart`) driven by the table in §2 (analyzer-based, renames
declarations + all references across registry, blocks, previews, tests, docs, CLI templates, READMEs, meta.json api
fields, manifest); guardrail `tool/check_names.dart` (no `shadcn`, no widgets.dart clashes) wired into qa_gate.

**P8-3 CLI** — rename to `dashcn_cli`/`dashcn`; install dir/lock/config renames; new `eject` (package import →
owned copy, rewrites imports in the app); `add --package` mode (adds the pub dependency + import instead of copying);
`init` asks copy vs package; e2e tests for both modes + eject.

**P8-4 Docs** — depend on `dashcn` (path), regenerate data/snippets/CLI reference with the new names, brand strings,
"Package vs own-the-code" page, "Using with Material" page, install tabs (`flutter pub add dashcn` / `dashcn add …`).

**P8-5 Release engineering** — `CHANGELOG.md` (Keep a Changelog), semver policy (0.x = may break; 1.0 after API
review), GitHub Actions: analyze/test on PR, automated publishing to pub.dev on `vX.Y.Z` tag via OIDC (no secrets),
CLI published the same way, GitHub Pages deploy for docs from main.

**P8-6 Final QA + release candidate** — full gates on all three; fresh-app test: `flutter create` → `pub add dashcn` →
run; and `dashcn init/add/eject`; review pub.dev score in dry-run. **Ask Ibrar before**: repo renames, publishing,
merging to main.

## 5. Risks / notes
- `App`/`Theme` are generic: some users have their own `App` widget → documented `as` import; reconsider `App` naming
  at API review (alt `DesignApp`).
- Big mechanical rename touches ~1,000 files: do it with the analyzer-driven codemod in one batch, then run every gate;
  no hand renames.
- The design-identity exploration (branch `design/identity-exploration`) will pick a visual brand; the package name
  `dashcn` is independent and fixed now.
- In-flight agent work must land first (P8-0) to avoid merge pain.

## 6. Approvals needed
1. Go/no-go on this plan (and whether to start right after the current P7 agents finish).
2. `ShadcnApp` → `App` (recommended) or `DesignApp`.
3. Later, separately: GitHub repo renames, first pub.dev publish (`0.1.0`), merge to main.
