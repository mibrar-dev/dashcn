# P7I-kit-a report — P7 → dashcn merge resolutions for area `kit-a`

39 files (17 lib UU + 8 lib UA + 5 test UU + 9 test UA). All files are
resolved in the worktree (no `<<<<<<<`/`=======`/`>>>>>>>` remain, no
`shadcn`/`Shadcn`/`flutter_shadcn` remains in any of them). Files are NOT
staged (per brief, the orchestrator stages after review).

Global decision (evidence-backed): for every preview/behaviour conflict the
P7 side won on behaviour and dashcn won on names, because the already-merged
(non-conflicted) consumers in the tree assume P7's behaviour:
`alert_dialog/preview.dart` (P7 example names `Delete account`/`Live push`),
`dialog.dart` (calls `dialogEffectiveMaxWidth`), `toast.dart` (`ToastLayer`),
`keyboard_shortcut_theme.dart` (`KbdVariant`/`keyBorderRadius`), and
`table_style.dart` (upstream v4 `TableHead` muted-foreground headers).
Keeping dashcn's conflicting preview variants would have broken those
consumers and all P7-side QA tests.

## Lib resolutions

- `dashcn/lib/src/components/app/app.dart` (UU): combined. Kept dashcn's
  `DashcnApp`, plain names, shortcuts/actions merge, inlined text/icon scope
  (P8-2 removal of `ShadcnUI`), `AnimatedTheme`, `ComponentLocalizations`;
  added P7's whole-app `EyeDropperLayer` (import was already auto-merged into
  the worktree) and P7-FOCUS `_FirstFrameFocusGate` (already auto-merged at
  the return + class; only the `_buildApp` middle hunk conflicted and was
  combined: Builder scope, then `EyeDropperLayer`, then theme).
- `button/button.dart` (UU): combined. P7's status machine
  (`onPressedAsync`/`status`/`successLabel`/`failureLabel`/`statusResetDuration`/`onStatusChanged`/`onAsyncError`,
  `_controller`, `_handlePress`, `ButtonPaintScheme`, `ButtonStatusContent`)
  on dashcn names, PLUS dashcn's KIT-FIX-1 `TouchHitArea` (with group
  exclusion and `touchMinEdge`), `dart:math` import, `upstream` prose.
  Ours-only private layout helpers (`_ButtonSizeMetrics`/`_buttonMetricsFor`/`_innerMin`)
  deleted (moved to P7's `button_layout.dart`).
- `button/button_style.dart` (UU): took P7 (split container: enums +
  `ButtonTheme` with the new `status: ButtonStatusStyle?` leg, re-exports).
  No renames needed (already plain).
- `button/button_defaults.dart`, `button_layout.dart`, `button_status.dart`,
  `button_status_content.dart`, `button_status_style.dart`,
  `button_variant_style.dart`, `button/preview_status.dart` (all UA): took P7,
  translated (`ShadcnThemeData`→`ThemeData`, `ShadcnTheme`→`Theme`,
  `ShadcnColors`→`ThemeColors`, `shadcn` prose→`upstream`).
- `button_status_content.dart`: EXTRA fix beyond translation (see
  key_findings): wrapped both announcement children in `ExcludeSemantics` —
  P7's live-region wrapper (`Loading`/`Success`/`Failure`) merged with
  dashcn's self-labelling `Spinner` (KIT-FIX-1 `label ?? 'Loading'`) into a
  doubled `Loading\nLoading` node.
- `button/preview.dart` (UU): took P7 (status demos via `preview_status.dart`,
  settle-safe idle rest), translated to `Theme`.
- `button/README.md` (UU): combined — P7's status-machine docs translated to
  dashcn (`dashcn add button`, `lib/ui/dashcn/button/`, `dashcn` prose) PLUS
  dashcn's `TouchHitArea` paragraph (kept: the behaviour stays in
  `button.dart`).
- `dialog/dialog_style.dart` (UU): took P7 (`DialogSize` sm/md/lg,
  `dialogSizeWidth`, `size` leg through copyWith/merge/lerp/==/hashCode,
  `dialogEffectiveMaxWidth`, `maxWidth: null` default), prose→`upstream`.
  Required by already-merged `dialog.dart`.
- `dialog/preview.dart`, `drawer/preview.dart`, `gooey_toast/preview.dart`,
  `toast/preview.dart`, `tooltip/preview.dart`,
  `navigation_menu/preview.dart` (all UU): took P7 (app-wide root-navigator
  overlays, centred triggers, `_Shared` gooey config, shadcn-like nav menu),
  translated (`ShadcnTheme`→`Theme`, `showShadcnDialog`→`showDialog`,
  demo copy `shadcn/ui`→`dashcn/ui`). dashcn's in-stage variants dropped as
  the losing side of the same-behaviour conflict (see global decision).
- `drawer/drawer_background_scale.dart` (UA): took P7, translated
  (`ShadcnDrawerRoute`→`DrawerRoute`, `ShadcnApp`→`DashcnApp` in docs,
  drawer prose→`upstream`).
- `keyboard_shortcut/keyboard_shortcut.dart`, `keyboard_shortcut_style.dart`,
  `preview.dart`, `README.md`, `meta.json` (all UU): took P7 (ghost/subtle
  `KbdVariant`, `keyBorderColor`/`keyBorderWidth`, fixed 4px radius, mono
  face, gap-1=4, py-0.5 vertical 2, h-5 20px, centred previews), translated
  (`shadcnTheme`→`themeData`, `ui/shadcn`→`ui/dashcn`,
  `flutter_shadcn add`→`dashcn add`, ValueKeys→`dashcn.*`). P7 won the
  same-behaviour conflict: the merged `keyboard_shortcut_theme.dart` already
  carries P7's API, and P7's assertions are stricter. dashcn's translucent
  fill / gap-0.5 / ambient-radius variant is dropped. Test-string prose uses
  `dashcn`, comments use `upstream`.

## Test resolutions

- `size_audit_c_test.dart` (UU): kept dashcn (names only) EXCEPT one
  assertion where the sides genuinely disagree: header colour. dashcn expects
  `foreground`, P7 expects `mutedForeground`; the merged subject
  (`table_style.dart: `tableHeaderCellDefaults`, upstream v4 `TableHead`)
  renders muted-foreground, so P7's expectation + test name
  (`medium muted-foreground`) were adopted. All 6 pass.
- `keyboard_shortcut_test.dart` (UU): took P7 body (P7 values), translated
  (`as shadcn`→`as dashcn`, `ShadcnTokens`→`DesignTokens`, strings→`dashcn`).
  All 32 pass.
- `pinned_sheet_test.dart` (UU): kept dashcn base + appended P7's
  `edge handle` group (P7-WB side-aware handles) and `previews` group,
  translated; added the two preview imports. Subject APIs verified present
  (`sheetHandleKey`, `OverlayPosition`, `pinnedSheetPreviews`).
- `alert_dialog_qa_test.dart`, `interactive_previews_test.dart` (UU): took
  P7 bodies (P7 preview names, `ToastLayer` harness, `lib/src/themes/`
  paths), translated; interactive's typed-text round-trip `shadcn`→`dashcn`.
- UA tests translated in place: `app_focus_gate_test`,
  `button_status_controller_test`, `button_status_extra_test`,
  `button_status_test`, `p7i1_trigger_alignment_test`, `p7wa_overlays_test`,
  `previews_centered_test` (`ShadcnThemeDataView`→`ThemeDataView`,
  registry path→`lib/src/themes/neutral.json`, dropped now-unused `dart:io`
  import), `p7wa_screens_test`, `p7wc_screens_test`.
- `button_status_test` icon-button case: pumps `ThemeData(platform:
  TargetPlatform.macOS)` now — `flutter test` runs as Android where
  `TouchHitArea` legitimately grows the box to 48 tall (dashcn's own
  `button_test.dart` documents this and uses a desktop theme for painted
  sizes).

## Gates

- `dart format <39 files>`: clean (0 changed on re-run).
- `dart analyze <39 files>` (from `dashcn/`): No issues found.
- `flutter test`: button_status_controller 6/6, button_status +
  button_status_extra 18/18 (after the 2 fixes above),
  keyboard_shortcut 32/32, p7i1_trigger_alignment 26/26, size_audit_c 6/6,
  p7wa_screens 8/8, p7wc_screens 8/8, button_test 12/12, dialog 15/15,
  drawer 11/11, toast 14/14, tooltip 17/17 — all pass.
- Blocked by other areas (recorded, not fixed): app_focus_gate,
  app_test, gooey_toast_test fail to load on
  `eye_dropper/eye_dropper.dart:233` (`ShadcnThemeData`, kit-b/codemod);
  p7wa_overlays + alert_dialog_qa fail to load on
  `alert_dialog/preview.dart:168` (`ShadcnTheme`, orchestrator codemod);
  pinned_sheet_test fails to load on `pinned_sheet.dart:463` (kit-b);
  interactive_previews + previews_centered fail to load on
  `dot_indicator.dart:220`, `navigation_menu.dart:42`,
  `alert_dialog/preview.dart:168` (kit-b/codemod). Whole-package
  `dart analyze` shows 29 issues, all in non-kit-a files
  (blocks, chat, dot_indicator, eye_dropper, navigation_menu,
  pinned_sheet, table/form tests, toast_qa).

## RESULT
status: done
files_written: [/home/user/dashcn-kit-b/dashcn/lib/src/components/app/app.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/button/README.md, /home/user/dashcn-kit-b/dashcn/lib/src/components/button/button.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/button/button_defaults.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/button/button_layout.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/button/button_status.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/button/button_status_content.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/button/button_status_style.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/button/button_style.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/button/button_variant_style.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/button/preview.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/button/preview_status.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/dialog/dialog_style.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/dialog/preview.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/drawer/drawer_background_scale.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/drawer/preview.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/gooey_toast/preview.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/keyboard_shortcut/README.md, /home/user/dashcn-kit-b/dashcn/lib/src/components/keyboard_shortcut/keyboard_shortcut.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/keyboard_shortcut/keyboard_shortcut_style.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/keyboard_shortcut/meta.json, /home/user/dashcn-kit-b/dashcn/lib/src/components/keyboard_shortcut/preview.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/navigation_menu/preview.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/toast/preview.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/tooltip/preview.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/app_focus_gate_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/button_status_controller_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/button_status_extra_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/button_status_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/keyboard_shortcut_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/p7i1_trigger_alignment_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/p7wa_overlays_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/pinned_sheet_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/size_audit_c_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/qa/alert_dialog_qa_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/qa/interactive_previews_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/qa/previews_centered_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/visual/p7wa_screens_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/visual/p7wc_screens_test.dart, /home/user/dashcn-kit-b/rearch/reports/P7I-kit-a.md]
commands_run: [dart format <39 kit-a files> -> 36 formatted, 0 changed on re-run, final line `Formatted 36 files (0 changed)`; dart analyze <39 kit-a files> from dashcn/ -> `No issues found!`; flutter test button_status_controller_test -> `All tests passed! (6/6)`; flutter test button_status_test + button_status_extra_test -> 2 failed then `All tests passed! (18/18)` after ExcludeSemantics + macOS-platform fixes; flutter test keyboard_shortcut_test -> `All tests passed! (32/32)`; flutter test p7i1_trigger_alignment_test -> `All tests passed! (26/26)`; flutter test size_audit_c_test -> 1 failed then `All tests passed! (6/6)` after adopting P7 muted-foreground expectation; flutter test p7wa/p7wc_screens -> `All tests passed! (8/8 each)`; flutter test button/dialog/drawer/toast/tooltip existing tests -> all pass (12/15/11/14/17); blocked compilations recorded for app_focus_gate/app/gooey_toast/p7wa_overlays/alert_dialog_qa/pinned_sheet/interactive/centered (cross-area Shadcn leftovers)]
key_findings: [Previews/behaviour conflicts resolved P7-wins-on-behaviour/dashcn-wins-on-names, forced by already-merged consumers (alert_dialog P7 names, dialogEffectiveMaxWidth, ToastLayer, KbdVariant theme fields, v4 TableHead); KIT-FIX-1 TouchHitArea kept in button and reconciled with P7 status tests (desktop platform for painted sizes); Found and fixed a real double-announce bug: P7 live-region wrapper + dashcn self-labelling Spinner merged to `Loading\\nLoading` — fixed with ExcludeSemantics in button_status_content (my file); Found and resolved a genuine same-behaviour disagreement in size_audit_c (header foreground vs muted-foreground) in favour of the merged subject + upstream v4; kbd same-behaviour conflict (translucent/gap-0.5/ambient-radius vs muted/gap-1/fixed-4px/mono/ghost) resolved for P7, required by merged keyboard_shortcut_theme]
open_questions: [interactive_previews + previews_centered cannot run until kit-b/codemod clear dot_indicator/navigation_menu/alert_dialog Shadcn leftovers — re-run then; app_focus_gate/app/gooey/p7wa_overlays/alert_dialog_qa/pinned_sheet tests likewise blocked on eye_dropper/alert_dialog/pinned_sheet areas; kit-b is editing concurrently in the same worktree (table_style already looks resolved) — orchestrator should confirm no overwrite races on shared consumers]
