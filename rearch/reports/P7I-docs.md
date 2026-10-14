# P7I-docs report — P7 → dashcn merge resolution for area `docs`

Worktree `dashcn-kit-b`, branch `integrate/p7-into-dashcn`. All 16 `UU` files
in `rearch/plans/p7-integration/docs.txt` resolved in the working tree (still
`UU` — **not staged**, per the brief the orchestrator stages after review).
No `git add/commit/checkout/merge/reset` run. `dart format` applied to the 16
files only (0 changed on the final pass).

Convention below: **ours** = dashcn side (`:2`, HEAD `9c78356`: plain
`dashcn` names, P8-4/P9 site features), **theirs** = P7 side (`:3`,
MERGE_HEAD `426f7eb`: theme-everywhere, app-wide overlays, Theme Studio
fonts + fast switching, working chat cards, full-page block frames, snapshot
theme transition). Every merged file uses dashcn names and has zero
`Shadcn|shadcn|ui/shadcn|showShadcn|flutter_shadcn` matches and zero conflict
markers (verified by grep).

## Per-file resolutions

### 1. `docs/lib/main.dart` — combined (both sides changed behaviour)
- Ours: `DashcnApp`, `ui/dashcn` imports, P8-4/P9 routes (flows, starters,
  scorecards, package-or-own, material interop), `DocsRouteInformationParser`
  with `state:`, title `'dashcn'`, `AnimatedTheme` colour tween.
- Theirs: snapshot `ThemeSwitchTransition` (P7-WD single swap, P7-TS1 kinds),
  `DrawerScaleObserver` + `DrawerBackgroundScale` + `ToastLayer` app-wide
  overlay hosting (P7-WA), `_loadRestoredFonts`, per-document theme cache
  read, `DocsThemeTransition` rail row.
- Kept: everything from ours **except** the `AnimatedTheme` tween, which P7
  deliberately replaces; added all of theirs translated (`ShadcnApp`→
  `DashcnApp`, `ui/shadcn`→`ui/dashcn`, `ShadcnThemeData`→`ThemeData`,
  `ShadcnDrawerRoute`→`DrawerRoute` in the comment). Header comment now
  describes the ~250 ms snapshot cross-fade. `buildDocsPage` is ours verbatim
  (all dashcn routes); `_themeEventColors` is ours (`ThemeData`).
- Analyze: 3 errors, all cross-area (see §Cross-area errors): the docs mirror
  `ui/dashcn/components/drawer/` lacks `drawer_background_scale.dart`
  (kit-a owns the src file; orchestrator regenerates the mirror).

### 2. `docs/lib/pages/landing_page.dart` — combined
- Ours: P9-Z hero (deferred `LandingHeroDemo`, H1 `Every platform at once`,
  flows copy, `Browse flows` CTA). Theirs: P7-TH1 theme spacing + plain
  registry CTA buttons + `kStats.listedComponents` badge count.
- Kept: ours' hero structure, copy and CTAs; applied P7's `theme.spacing`
  gaps, plain `_PillButton` (radius follows Theme Studio), and the
  listed-only badge count.
- Conflict choice: `kStats.listedComponents` (P7) over `kStats.components`
  (ours). P7 adds it alongside `components` as the browsable-only count; it
  does not exist in the working tree's generated `docs_data.dart` yet, so
  this file errors until the orchestrator regenerates docs data with the
  already-staged tool change (`docs/tool/src/render_files.dart` emits
  `listedComponents`). See §Cross-area errors.

### 3. `docs/lib/state/site_theme_model.dart` — combined (additive both sides)
- Ours: `applyDocument` (web-theme import Apply path), dashcn names,
  "upstream neutral base" comment. Theirs: `DocsThemeTransition _transition`
  + `setTransition` (P7-TS1, persisted under `kDocsTransitionKey`, survives
  `Reset`), per-document `_themeCache` + cached `themeFor` + cache clear in
  `_assign` + transition restore.
- Kept both, with dashcn type names (`ThemeData`). No overlapping edits.
- Analyzes clean.

### 4. `docs/lib/theme/theme_document.dart` — one-hunk combine
- Only conflict was the `theme()` factory head; the `heading`/`body`/`mono`
  slots + getters and the `fontMono`/`fontHeading` wiring had auto-merged.
- Resolved to `ThemeData`/`ThemeFonts` (ours' names) with P7's `fontSans:
  bodyFont` + `fontHeading`/`monoFont` wiring.
- Analyze: 1 error, cross-area: docs mirror `ui/dashcn/theme/tokens.dart`
  has no `fontHeading` (kit src `dashcn/lib/src/theme/tokens.dart` has it —
  7 matches; mirror regen fixes). Verified `ThemeFonts.fontHeading` and
  `Typography.applyFonts` exist in the kit src.

### 5. `docs/lib/widgets/announcement.dart` — theirs translated
- Ours was rename-only. Took P7's hug-cap badge (LayoutBuilder 120–320 px
  cap, px-3/py-1 padding, `textSmall` type, registry radius) with dashcn
  imports/names; `shadcn hero badge` prose → `upstream hero badge`.
- Analyzes clean.

### 6. `docs/lib/widgets/block_viewport.dart` — theirs translated
- Ours was rename + one comment tweak. Took P7-B2 full-page frames
  (1280×800 / 768×1024 / 390×844, scale-down-only `FittedBox` zoom, tight
  page constraints, `BlockPreviewLoader` unchanged) with dashcn names;
  `(shadcn \`/blocks\`)` → `(upstream \`/blocks\`)` (matches ours' wording).
- Analyzes clean.

### 7. `docs/lib/widgets/collage_cards.dart` — theirs translated
- Ours was rename-only. Took P7-TH1 theme-driven card (`theme.spacing`,
  `borderRadiusXl`, `shadowSm`, 5 % ring) with dashcn names. Analyzes clean.

### 8. `docs/lib/widgets/collage_home_media.dart` — theirs translated
- Ours was rename-only. Took P7's working `HomeChatCard` (public
  `HomeChatCardState`, canned replies, typing indicator, auto-scroll, count
  badge, `enabled: canSend` send) with dashcn names. Verified the dashcn kit
  APIs used all exist: `Button.enabled`, `TextArea.controller/
  textInputAction/onSubmitted`, `ChatTheme(background/foreground/alignment/
  avatarAlignment)`, `ThemedColor`/`ColorRef`.
- Analyzes clean.

### 9. `docs/lib/widgets/component_install_block.dart` — combined (both
rewrote the file)
- Ours: P8-4 Package | Own-the-code tabs over `install_commands.dart` + eject
  note. Theirs: P7-TH1 theme spacing/radii on the old Command|Manual+pills
  layout (obsolete structure on the dashcn line).
- Kept ours' structure verbatim; applied P7's tokens throughout:
  `Gap(theme.spacing.lg/md)`, figure `borderRadiusLg`, header padding
  `md/sm`, file-row gaps `xs`, `_LineTab` insets `sm/xs`. Added the missing
  `Theme.of(context)` read in the state build.
- Analyzes clean.

### 10. `docs/lib/widgets/docs_article.dart` — theirs' behaviour, ours' names
- One conflict hunk (the `_titleRow` head); P7's wrapping badges/actions
  `LayoutBuilder` (tight <560 px column branch — also fixes the unbounded-
  height `Expanded` crash), theme gaps and sm pager buttons had auto-merged.
- Resolved the hunk to P7's body with `ThemeData`; `shadcn badge size` prose
  → `upstream badge size`. Analyzes clean.

### 11. `docs/lib/widgets/docs_header.dart` — combined (3 small hunks)
- P7's spacing/`_SearchHint` (⌘K `KeyboardShortcut` caps, P7-WC2) and mobile
  group had auto-merged; ours' flows/starters nav escalation
  (`_headerNavFor`, `_navActive`) intact. Resolved hunks: imports = dashcn
  paths + P7's `keyboard_shortcut` import; two `Theme.of` reads gain P7's
  `theme` local as `ThemeData`. Translated one `shadcn shows…` comment to
  `The reference shows…`. Verified `KeyboardShortcut(keys:)` exists in dashcn.
- Analyzes clean.

### 12. `docs/lib/widgets/rail_picker_scales.dart` — combined (3 hunks)
- Took P7's installable-font catalogue (`docsFontCatalogueFor`,
  per-slot heading/body/mono lists, `loadDocsFonts`-before-commit,
  `_fontPickerTitle`) with dashcn names (`showPicker`, `Theme.of`,
  `ui/dashcn`); dropped the now-unused `site_theme_model` import in favour
  of P7's `docs_fonts` import (`kDocsFontOptions` stays defined in
  `site_theme_model.dart` for its other consumers). Radius comment keeps
  ours' `upstream scale` wording. Fixed one auto-merged `ShadcnTheme`
  remnant.
- Analyzes clean.

### 13. `docs/lib/widgets/studio_blocks/studio_media.dart` — import hunk only
- P7's working `StudioChatCard` had auto-merged; resolved the import hunk to
  dashcn paths + P7's `color_tokens` import; fixed one `ShadcnTheme`
  remnant in `_StudioTypingDots`. Analyzes clean.

### 14. `docs/lib/widgets/studio_blocks/studio_paint.dart` — one-hunk combine
- Resolved to `Theme.of` + P7's `chartColors` read; P7's multi-series
  `_ContributionPainter(colors:)`, `listEquals` repaint and `chart1`
  sparkline had auto-merged. Header/imports were already dashcn-side
  (incl. P7's `foundation` import). Analyzes clean.

### 15. `docs/test/docs_app_test.dart` — combined
- Hunk 1: kept P7's `theme_switch_transition` import, dropped ours'
  `ui/dashcn/theme` import (nothing else in the file uses it). Hunk 2: took
  P7's snapshot-transition assertions. Landing H1 expectation had
  auto-merged to ours' `Every platform at once` (matches the merged landing
  page). Analyzes clean in isolation.

### 16. `docs/test/motion_test.dart` — combined
- Hunk 1: took P7's removal of the theme import (unused after hunk 2).
  Hunk 2: took P7's instant-swap assertion. Durations test had auto-merged
  to ours' `(dashcn-site)` name + P7's `kDurationThemeSwitch` line.
  Analyzes clean in isolation.

### 17. `flutter_shadcn_kit/test/registry/theme/theme_lerp_animated_test.dart`
(DU: deleted by ours, updated by theirs) — **no action taken**. The old path
is absent from the worktree (correct: the file lives on as
`dashcn/test/registry/theme/theme_lerp_animated_test.dart` in dashcn names).
Per the integration table row 21 the port of P7's two new tests (lerp-leg
identity reuse) belongs to agent **kit-b**; the `DU` stage entry is already
gone from the index (`git ls-files -u` no longer lists it), so nothing is
left for docs to resolve here. UNVERIFIED: whether kit-b has ported the two
tests yet.

## Gates run
- `dart format <16 files>` → `Formatted 16 files (0 changed)`.
- `dart analyze <16 files>` (from `docs/`) → 5 errors, all in 3 files, all
  cross-area/regen-owned (details below); the other 13 files: **No issues
  found**.
- `flutter test test/motion_test.dart` → fails at load (`+0 -1`) on errors
  in files outside docs ownership (docs mirror `ui/dashcn` blocks still
  reference `onPressedAsync`/`Shadcn*`, i.e. kit-a/kit-b areas unresolved +
  orchestrator's `rename_api.dart` + mirror regen pending).
- `flutter test test/docs_app_test.dart` → same: load errors in
  `theme_switch_transition.dart` (`ui/shadcn` import — orchestrator rename
  pending), docs mirror (`drawer_background_scale.dart` absent, `Shadcn*`
  names), `blocks_pages.dart`. No test body executed.
- No hanging processes left (`ps` clean). Scratch dumps under
  `rearch/logs/p7i-docs/` removed. No generators, no whole-package
  format/analyze, no git state-changing commands run.

## Cross-area errors (expected — owned by others, not fixed per brief)
1. `docs/lib/main.dart:89,215` — `DrawerScaleObserver`/
   `DrawerBackgroundScale` undefined: docs mirror drawer has 4 files, kit src
   has 7. Owner: kit-a (src) → orchestrator (`sync_registry.sh` regen).
2. `docs/lib/pages/landing_page.dart:51` — `listedComponents` missing from
   `DocsStats`: generator tool change already staged
   (`docs/tool/src/render_files.dart`), generated file not yet regenerated.
   Owner: orchestrator (`gen_docs_data.dart`).
3. `docs/lib/theme/theme_document.dart:229` — `fontHeading` missing from docs
   mirror `ThemeFonts` (kit src has it). Owner: orchestrator (mirror regen).
4. Test-load errors in `theme_switch_transition.dart`, `blocks_pages.dart`,
   mirror blocks/components — other areas' unresolved files + pending
   `rename_api.dart` codemod. Owner: orchestrator.

## Open questions
- After the mirror regen, `main.dart`'s `DrawerBackgroundScale(observer:)`
  signature should be re-checked against kit-a's final
  `drawer_background_scale.dart` (I kept P7's call shape translated).
- `landing_page.dart` intentionally uses `kStats.listedComponents`, which
  only exists after the docs-data regen; if the orchestrator prefers the
  tree green before regen, temporarily swap to `kStats.components`.
- The `DU` lerp test port status is UNVERIFIED (kit-b's table row).

## RESULT
status: done
files_written: [/home/user/dashcn-kit-b/docs/lib/main.dart, /home/user/dashcn-kit-b/docs/lib/pages/landing_page.dart, /home/user/dashcn-kit-b/docs/lib/state/site_theme_model.dart, /home/user/dashcn-kit-b/docs/lib/theme/theme_document.dart, /home/user/dashcn-kit-b/docs/lib/widgets/announcement.dart, /home/user/dashcn-kit-b/docs/lib/widgets/block_viewport.dart, /home/user/dashcn-kit-b/docs/lib/widgets/collage_cards.dart, /home/user/dashcn-kit-b/docs/lib/widgets/collage_home_media.dart, /home/user/dashcn-kit-b/docs/lib/widgets/component_install_block.dart, /home/user/dashcn-kit-b/docs/lib/widgets/docs_article.dart, /home/user/dashcn-kit-b/docs/lib/widgets/docs_header.dart, /home/user/dashcn-kit-b/docs/lib/widgets/rail_picker_scales.dart, /home/user/dashcn-kit-b/docs/lib/widgets/studio_blocks/studio_media.dart, /home/user/dashcn-kit-b/docs/lib/widgets/studio_blocks/studio_paint.dart, /home/user/dashcn-kit-b/docs/test/docs_app_test.dart, /home/user/dashcn-kit-b/docs/test/motion_test.dart, /home/user/dashcn-kit-b/rearch/reports/P7I-docs.md]
commands_run: [dart format <16 files> -> Formatted 16 files (0 changed), dart analyze <16 files> (docs/) -> 5 issues found (3 regen/mirror-owned files; 13 clean), flutter test test/motion_test.dart -> load failure on other areas' unresolved mirror/kit files (+0 -1), flutter test test/docs_app_test.dart -> same load failure (theme_switch_transition + mirror + blocks_pages)]
key_findings: [All 16 UU files resolved with dashcn names + P7 behaviour; zero markers and zero shadcn remnants in owned files, Only overlapping-behaviour choice: landing badge uses P7 listedComponents (needs orchestrator docs-data regen), component_install_block keeps dashcn Package|Own structure with P7 theme tokens, main.dart keeps all dashcn routes with P7 snapshot transition + app-wide overlay hosting, 5 analyze errors and both test-load failures are exclusively cross-area (stale docs mirror, unregenerated docs data, unrenamed P7-added widget)]
open_questions: [DrawerBackgroundScale call shape vs kit-a final file needs re-check after regen, listedComponents vs components interim tradeoff noted, kit-b lerp-test port status UNVERIFIED]
