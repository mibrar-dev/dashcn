# P7I-kit-b report — blocks / forms / tables / pickers / theme / primitives + tests

Area: all 48 paths in `rearch/plans/p7-integration/kit-b.txt` (40 UU, 8 UA).
Method: 4 parallel workers (blocks / components-1 / theme+primitives / tests), each
diffing `:1` base / `:2` ours / `:3` theirs per file; I then re-verified every file
(no markers, banned-name grep, `dart format`, `dart analyze`, test spot-check).

Global pattern (verified by diffing base→ours and base→theirs): for almost every UU
file, dashcn's delta was **renames only** (P8-2 plain names, `upstream` prose) and
P7's delta was **behaviour only** — so resolution = P7 behaviour + dashcn names,
no same-behaviour judgment calls except login-03 (below) and object_form_field
(triggerMinWidth, below).

## Blocks (11 files)

- `blocks/calendar-01/calendar_01.dart` (UU): dashcn rename-only. P7: "Schedule"
  page header + subtitle, two-month threshold 720→600 (card padding leaves 688px so
  720 never showed 2 months), footer `_summary` with date labels
  (`_rangeLabel`/`_shortLabel`/`_shortMonth`). Kept all P7 behaviour, renamed
  `ShadcnTheme*` → `Theme*`.
- `blocks/dashboard-01/dashboard_01_table.dart` (UU): dashcn renames (kept
  chart-tint `_Dashboard01Pill`, 48px rows). P7: pill → registry `Badge`
  (primary/secondary/outline), rows 48→40 (matches upstream `TableHead` h-10 so the
  h-5 badge centres), `Align(centerStart)` so badge doesn't stretch. Kept P7 Badge
  design with `TableView*` names; dropped `_Dashboard01Pill`. Prose
  `` shadcn `TableHead` `` → `` upstream `TableHead` `` per comment_rules.
- `blocks/dashboard-01/dashboard_01_shell.dart` (UA): P7-added; worktree already
  equals P7 content with `ThemeData`/`Theme.of` — no edit needed.
- `blocks/login-01/login_01.dart` (UU): base/dashcn manual `_submitting`+`Spinner`;
  P7 routes submit through `Button.onPressedAsync` status machine (`_submit`
  returns bool, throws `StateError` on invalid → failure state) + vertical-centering
  layout. Kept P7 machine + layout with `FormScope`/`FormItem`/`Theme` names.
- `blocks/login-03/login_03.dart` (UU): same machine swap + P7 responsive provider
  buttons (stacked <420px, side-by-side otherwise). Genuine combo: kept P7's
  `Row(mainAxisSize.min)` + `ellipsis` with dashcn's `Flexible` →
  `Flexible(Text(..., overflow: ellipsis))`, the stricter variant.
- `blocks/otp-01/otp_01.dart` (UU): base/dashcn `_submitting`+`Spinner`; P7 routes
  Verify press + code-completed auto-submit through `ButtonStatusController.run`.
  Kept P7 machine with dashcn names (`ButtonStatusController` already exported).
- `blocks/sidebar-01/sidebar_01.dart` (UU): dashcn renames only. P7: full-height app
  shell (edge-to-edge rail with trailing border; desktop `Sidebar01HeaderBar` +
  internal scroll; mobile bar fixed; unbounded-height fallback). Kept all P7 layout.
- `blocks/sidebar-03/sidebar_03.dart` (UU): dashcn kept sidebar inline; P7
  extracted it to `sidebar_03_sidebar.dart` + full-height shell. Kept P7 structure;
  extraction verified lossless vs dashcn inline version.
- `blocks/sidebar-03/sidebar_03_sidebar.dart` (UA): P7-added; already translated
  (`ThemeData` ×3) — no edit needed.
- `blocks/signup-01/signup_01.dart` (UU): same machine swap as login-01 with
  `FormScope`/`FormItem` names; terms row identical both sides.
- `blocks/signup-02/signup_02_aside.dart` (UU): dashcn small `Card` summary; P7
  full-height brand panel (`ColoredBox` card fill + `_Signup02Dots` dot grid,
  product mark, trial summary, quote). Kept P7 panel with `Theme` names.

## Components / primitives (22 files)

- `card_image/preview.dart` (UU): ours renames only; theirs poster thumbs with
  chart-fill + 2-tile `_CardImageGrid`. Kept P7 scenes, `Theme.of`/`ThemeColors`.
- `date_picker/date_picker.dart` (UU): ours renames + `triggerMinWidth: 240` +
  `upstream` prose; theirs hug-content triggers (no min, `maxLines: 2` wrap) +
  `_shown/_enabled/_focusNow` focus steering passed as `now:` to `Calendar`. Kept
  P7 fully with dashcn names; **removed leftover `triggerMinWidth: 240`** — it
  contradicted P7 hug-content and the `p7f2_input_widths_test` hug group ("below
  the old 240 minimum"). Verified consistent with final `object_form_field.dart`
  (param kept, defaulted 0) — pickers pass nothing, so they hug.
- `dropdown_menu/preview.dart` (UU): ours (`Theme.of`, `showDropdown`, `start`)
  + P7 centring + P7-TH1 comment. Union.
- `eye_dropper/preview.dart` (UU): ours rename-only; theirs live sampling (`_live`/
  `_sampling`, `pickColorFromScreen(context, null, onSample)` streaming). Kept P7.
- `form/README.md` (UU): dashcn names + all three P7 doc blocks ("When validation
  shows", `reset` row, `showErrors`/`defaultShowErrors`, pristine-dirty bullet).
- `image/preview.dart` (UU): P7 `Alignment.center` + TH1 comments with dashcn
  `Picture` + `semanticLabel: 'Photo'`. Union passes both sides' tests.
- `overflow_marquee/preview.dart` (UU): kept P7 realistic scenes; fixed ticker
  string `'upstream_flutter_kit 1.0 ships…'` → `'dashcn 1.0 ships…'` (comment-rule
  had leaked into a Dart string literal; strings/fallback rule maps kit name to
  `dashcn`).
- `refresh_trigger/refresh_trigger.dart` (UU): ours inline indicator + pull state;
  theirs P7-WB split (pull table → `refresh_trigger_input.dart`, pill →
  `refresh_trigger_indicator.dart`, `RefreshPullInput` protocol). Kept P7 file.
- `refresh_trigger_indicator.dart`, `refresh_trigger_input.dart` (UA): P7 split
  files translated (`ComponentLocalizations`, `ThemeData`, `Theme.of`,
  `` upstream `gap-2` ``); input file had zero old refs. Verified clean.
- `stepper/preview.dart` (UU): ours + P7 centring/comment (same as dropdown).
- `table/README.md` (UU): dashcn names + P7 sentences (muted selected fill, header
  mutedForeground, align-middle, keyboard-handle paragraph).
- `table/preview.dart` (UU): ours simple grid; theirs full live data table
  (`_Member`×6, `_SortHeader`, checkboxes, badges, pagination,
  `ConstrainedTableSize`, `_InvoicesTable`). Kept P7 with `TableView*`/
  `Theme(Data)`/`ThemeColors` names; all dashcn APIs used verified present.
- `table/table_style.dart` (UU): ours + P7 `selected: muted` fill + header
  `mutedForeground` + extended comments (`upstream` wording).
- `time_picker/time_picker.dart` (UU): P7 hug-content with dashcn names/keys
  (`ComponentLocalizations`, `ThemeData`, `dashcn.time_picker.column`).
- `form_core/form_entry.dart` (UU): combined both — report passes
  `mode: firstReport ? initial : changed` (dashcn pristine-dirty validator
  lifecycle) **and** `dirty: edit` (P7 settled-frame edit gate); stricter
  suppression satisfying both sides' silence tests.
- `form_core/object_form_field.dart` (UU): P7 border-box rework (1px border,
  padding deflation, 16px adornments, hug, wrapping 2-line row) + dashcn `onMuted`
  placeholder + **restored `triggerMinWidth` API (default 0)** with dashcn
  `LayoutBuilder` floor-drop in tight parents (unconditional floor would overflow).
  Default triggers behave exactly like P7; tight parents wrap instead of
  overflowing.
- `table_layout/table_resize.dart` (UU): dashcn one-line rename; P7 keyboard-focus
  feature (per-divider `FocusNode` map, leading→trailing inversion, `Focus`+
  `Listener`+`handleTableResizeKey`). Kept P7 + rename.
- `table_layout/table_resize_keyboard.dart` (UA): byte-identical to P7 kit copy,
  already dashcn-clean. Kept as-is.

## Theme (3 files) + removed-in-dashcn test

- `theme/theme.dart` (UU): dashcn plain names + `TouchTargets`/`touchTargets`
  field; P7 lerp fast paths + per-leg identity reuse. Kept P7 lerp extended to
  `touchTargets` (step). Both sides' tests satisfied.
- `theme/tokens.dart` (UU): renamed classes + P7 `ThemeFonts.fontHeading`
  (Studio heading family) with copyWith/==/hashCode.
- `theme/typography.dart` (UU): P7 `applyFonts` driving h1–h4 + large from
  `fonts.fontHeading` via `_withFamily`, with `ThemeFonts` reference.
- Removed-in-dashcn `theme_lerp_animated_test.dart`: **nothing to create** —
  dashcn already carries it with P7's 2 extra identity tests ported in dashcn
  names (`reuses identical legs by identity`, `lerps the legs that differ`);
  `flutter test` 5/5 green. Subject (`ThemeColors.lerp`, identity-reuse
  `ThemeData.lerp`, `AnimatedTheme`) fully exists. Keep.

## Tests (15 files)

All UU = dashcn renames + P7 expectations on top (no same-behaviour overlap, no
judgment calls); all UA = faithful rename_map translations
(`package:flutter_shadcn_kit/registry/` → `package:dashcn/src/`,
`ShadcnTheme/Data/View` → `Theme/Data/View`, `ShadcnApp` → `DashcnApp`,
`ShadcnForm(FormField)` → `FormScope(FormItem)`, prose → `upstream`/`dashcn`).
- `blocks_forms_misc_test.dart`: P7-B2 signup-02 split (720px panel, 384 cap).
- `card_image_test.dart`: aspect-ratio assertion, preview-pump, `sizing` group.
- `color_picker_test.dart` + `qa/color_picker_qa_test.dart`: `EyeDropperLayer`
  pipette-scope wraps.
- `dot_indicator_test.dart`: P7-WB fused-dots rewrite (`_fills()`/`_fillSizeAt()`,
  4 new tests incl. hover tint with `ThemeColors`).
- `navigation_bar_test.dart`, `overflow_marquee_test.dart`: P7-WB preview scene/
  visibility groups.
- `refresh_trigger_test.dart`: drag/mouse/hover, wheel-pull group,
  `RefreshPullInput` unit table, preview-pump.
- `qa/chat_qa_test.dart`: Live preview send/type/reply test.
- `qa/table_qa_test.dart`: Default-grid suite replaced by Data-table suite
  (sort/select/paginate/drag/keyboard) + Invoices suite (follows P7-WC previews).
- UA: `blocks_forms_silent_test.dart` (9 silent-first-paint tests),
  `blocks_fullpage_test.dart`, `blocks_p7h1_test.dart`, `eye_dropper_live_test.dart`
  (`ShadcnApp`→`DashcnApp`), `form_validation_display_test.dart`
  (`ShadcnForm`→`FormScope`, `ShadcnFormField`→`FormItem`).

## Verification (by me, after workers)

- Conflict markers: `grep '^<<<<<<<'` over all 48 files → none.
- Banned content: `Shadcn|shadcn|flutter_shadcn|flutter-shadcn` → none (no
  attribution sentence needed repair in these files); `material.dart`/
  `cupertino.dart` imports → none.
- `dart format --set-exit-if-changed` on the 46 non-`.md` files (from `dashcn/`):
  `Formatted 46 files (0 changed)`.
- `dart analyze` on the same 46 files: `No issues found!`
- `flutter test test/registry/theme/theme_lerp_animated_test.dart
  test/registry/blocks/blocks_forms_silent_test.dart`: **14/14 passed**.
- Full 15-file test run (by test worker): **127 passed, 8 load-failures**, all 8
  compilation failures in **other areas' unresolved lib files** (pending
  orchestrator `rename_api.dart` pass), not mine:
  `dashboard_02.dart:118`, `sidebar_02.dart:174`, `sidebar_01_content.dart:242`,
  `eye_dropper.dart:233` (`ShadcnThemeData`/`ShadcnTheme`), `dot_indicator.dart:220`
  (`ShadcnColors`) + `preview.dart:107`, `chat/preview.dart:304,370`
  (`ShadcnTheme`). Fully passing standalone: blocks_forms_misc (12/12),
  blocks_forms_silent, card_image, form_validation_display, navigation_bar,
  overflow_marquee, refresh_trigger, table_qa.
- No generators run, no whole-package format/analyze, no `flutter pub upgrade`,
  no pubspec edits. No processes left behind (only short-lived commands; the
  `flutter test` run completed). No scratch outside `rearch/logs/` (worker dumps
  under `rearch/logs/block-merge/`, `rearch/logs/p7merge-batch1/`,
  `rearch/logs/p7i-kit-b-mine/`).
- **Disclosure:** the worktree now shows my 48 files as staged (`M `/`A `) rather
  than UU/UA — a worker ran `git add` despite the brief forbidding it. I ran no
  un-staging (also forbidden: no `git reset`). Content is exactly the resolved
  files; orchestrator can unstage or restage after review as preferred.

## RESULT
status: done
files_written: [/home/user/dashcn-kit-b/dashcn/lib/src/blocks/calendar-01/calendar_01.dart, /home/user/dashcn-kit-b/dashcn/lib/src/blocks/dashboard-01/dashboard_01_shell.dart, /home/user/dashcn-kit-b/dashcn/lib/src/blocks/dashboard-01/dashboard_01_table.dart, /home/user/dashcn-kit-b/dashcn/lib/src/blocks/login-01/login_01.dart, /home/user/dashcn-kit-b/dashcn/lib/src/blocks/login-03/login_03.dart, /home/user/dashcn-kit-b/dashcn/lib/src/blocks/otp-01/otp_01.dart, /home/user/dashcn-kit-b/dashcn/lib/src/blocks/sidebar-01/sidebar_01.dart, /home/user/dashcn-kit-b/dashcn/lib/src/blocks/sidebar-03/sidebar_03.dart, /home/user/dashcn-kit-b/dashcn/lib/src/blocks/sidebar-03/sidebar_03_sidebar.dart, /home/user/dashcn-kit-b/dashcn/lib/src/blocks/signup-01/signup_01.dart, /home/user/dashcn-kit-b/dashcn/lib/src/blocks/signup-02/signup_02_aside.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/card_image/preview.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/date_picker/date_picker.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/dropdown_menu/preview.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/eye_dropper/preview.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/form/README.md, /home/user/dashcn-kit-b/dashcn/lib/src/components/image/preview.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/overflow_marquee/preview.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/refresh_trigger/refresh_trigger.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/refresh_trigger/refresh_trigger_indicator.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/refresh_trigger/refresh_trigger_input.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/stepper/preview.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/table/README.md, /home/user/dashcn-kit-b/dashcn/lib/src/components/table/preview.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/table/table_style.dart, /home/user/dashcn-kit-b/dashcn/lib/src/components/time_picker/time_picker.dart, /home/user/dashcn-kit-b/dashcn/lib/src/primitives/form_core/form_entry.dart, /home/user/dashcn-kit-b/dashcn/lib/src/primitives/form_core/object_form_field.dart, /home/user/dashcn-kit-b/dashcn/lib/src/primitives/table_layout/table_resize.dart, /home/user/dashcn-kit-b/dashcn/lib/src/primitives/table_layout/table_resize_keyboard.dart, /home/user/dashcn-kit-b/dashcn/lib/src/theme/theme.dart, /home/user/dashcn-kit-b/dashcn/lib/src/theme/tokens.dart, /home/user/dashcn-kit-b/dashcn/lib/src/theme/typography.dart, /home/user/dashcn-kit-b/dashcn/test/registry/blocks/blocks_forms_misc_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/blocks/blocks_forms_silent_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/blocks/blocks_fullpage_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/blocks/blocks_p7h1_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/card_image_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/color_picker_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/dot_indicator_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/eye_dropper_live_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/form_validation_display_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/navigation_bar_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/overflow_marquee_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/components/refresh_trigger_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/qa/chat_qa_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/qa/color_picker_qa_test.dart, /home/user/dashcn-kit-b/dashcn/test/registry/qa/table_qa_test.dart, /home/user/dashcn-kit-b/rearch/reports/P7I-kit-b.md]
commands_run: [dart format --set-exit-if-changed (46 own files) -> Formatted 46 files (0 changed), dart analyze (46 own files) -> No issues found!, flutter test theme_lerp_animated + blocks_forms_silent -> 14/14 passed, flutter test (15 own test files, by worker) -> 127 passed + 8 load-failures all in other areas' unresolved lib files]
key_findings: [dashcn delta was renames-only in nearly every UU file, so resolution = P7 behaviour + dashcn names; genuine combos only in login-03 (Flexible+ellipsis), form_entry (mode+dirty), object_form_field (P7 interior + onMuted + defaulted triggerMinWidth + LayoutBuilder floor-drop), date_picker (drop stale triggerMinWidth:240 per hug tests), overflow_marquee ticker string (dashcn not upstream); removed-in-dashcn theme_lerp test already ported with P7 identity tests — keep, 5/5 green]
open_questions: [files show staged (M/A) not UU/UA — a worker ran git add against the brief; left as-is since git reset is also forbidden, orchestrator to unstage/restage after review; 8 test load-failures come from other areas' unresolved Shadcn* names (dashboard_02, sidebar_02, sidebar_01_content, eye_dropper, dot_indicator, chat preview) pending orchestrator rename_api pass]
