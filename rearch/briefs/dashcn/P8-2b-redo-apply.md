# P8-2b — redo the plain-name rename on a clean tree

Read `P8-2-plain-names.md`, `P8-2-map-approval.md` (binding rulings) and this brief. The previous agent's apply left a
half-renamed tree and was then hand-patched; the orchestrator reset the tree to HEAD. Its useful work is saved in
`$KIT/rearch/logs/p82_keep/` (git-ignored). `damaged-tree.patch` there shows what went WRONG — read it only as a list of
mistakes to avoid (e.g. `final ShadcnThemeData theme = Theme.of(context)` with only half the names renamed, and
`widgetTheme: this.theme` hacks after a local shadowed a field).

## Steps
0. Restore the tools: copy `p82_keep/tool/*` → `$APP/tool/`, `p82_keep/test/tool/` → `$APP/test/tool/`,
   `p82_keep/qa_gate.sh` → `$KIT/rearch/qa_gate.sh`. `rearch/plans/api_inventory.json` is in place; the earlier
   partial report is `p82_keep/P8-2.md` (reuse its inventory/map sections in your final report). The map (`tool/rename_map.yaml`) is APPROVED, unchanged except the
   ruling below.
1. Preparation (by hand, small): inline `ShadcnUI` into `ShadcnApp._buildApp` and delete it (kit + its 2 tests);
   `git mv` both `flutter_shadcn_complete_user_guide.pdf` → `dashcn_complete_user_guide.pdf` and fix their links;
   `git rm dashcn/dart_analyze_flutter_shadcn_kit.txt` (+ its `.pubignore` line) and
   `dashcn/tool/registry/registry_barrel.dart` + `registry_barrel_generate.dart`.
2. Make the codemod correct (fix the tool, NEVER patch its output):
   - Identifier pass = analyzer scanner/unresolved AST tokens: every identifier token whose lexeme EXACTLY equals a
     map key becomes its `to` (all keys, incl. `ShadcnThemeData`, `ShadcnColors`, `ShadcnLocalizations*` …), plus the
     prefix families. Same inside doc-comment `[Refs]` and `show`/`hide` lists.
   - **Ruling (new):** local variables / parameters named `shadcn` or `shadcnTheme` → `themeData` (never `theme`: the
     kit uses `theme` as a widget field everywhere). Named-argument labels and fields of other classes are NOT locals.
     If `themeData` is already declared in the same function, list it in the report and leave that one for review.
   - Never emit `this.` qualifiers or any other new code shape — names only.
   - Add codemod tests (`$APP/test/tool/rename_api_test.dart`) with fixture snippets: the ChatBubble build method
     (`final ShadcnThemeData shadcn = ShadcnTheme.of(context); … widgetTheme: theme … shadcn.colors`) must become
     `final ThemeData themeData = Theme.of(context); … widgetTheme: theme … themeData.colors`; a `show ShadcnTheme`
     combinator; a `/// See [ShadcnTheme].` comment; a named argument `shadcn: x`; the maskAllow round-trip.
3. Apply in this order, each step verified before the next:
   a. `dart run tool/rename_api.dart --check` (no `timeout`; it runs in about a minute).
   b. Apply. **Immediately** run `flutter analyze` in `$APP` — it must be 0 issues. If not: `git checkout -- .` +
      `git clean -fd -- lib test` (restoring your step-1 edits), fix the TOOL, re-apply. No repair scripts.
   c. Mirror: `git mv docs/lib/ui/shadcn docs/lib/ui/dashcn`, update `docs/tool/sync_registry.sh` + every reference,
      `bash tool/sync_registry.sh`. Same for `dashcn/flutter_cli_verification_example/lib/ui/shadcn`.
   d. String/comment/markdown passes per the approval brief (comments → `upstream`, markdown `shadcn/ui` → `the upstream
      web kit`, everything else → `dashcn`), JS bridge events, regenerate (exports, manifest, previews/blocks tests,
      docs data, `gen/` outputs).
4. Gates: everything in the P8-1 gate list + `rename_api.dart --check` (no pending) + `check_names` (0 outside the
   allow-list) + `flutter test` everywhere. Final `rearch/reports/P8-2.md` (`status: done`): before/after counts,
   10 comment before→after samples, the `themeData` conflicts list, files changed count.

## Owns
Same as P8-2 (`$KIT/dashcn/**`, `$DOCS/lib|test|tool/**`, `$DOCS/web/index.html`, `$DOCS/*.pdf`, `$KIT/rearch/qa_gate.sh`,
`rearch/plans/api_inventory.json`, `rearch/reports/P8-2.md`). Never sleep > 60 s; never wrap the codemod in `timeout`.

## Report
`$KIT/rearch/reports/P8-2.md`
