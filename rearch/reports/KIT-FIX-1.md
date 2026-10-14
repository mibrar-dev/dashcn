# KIT-FIX-1 — accessibility + form-validation fixes

Status: done. Branch `wip/kit-fix-1`.

## RESULT
status: done
files_written: [see list below]
commands_run: [see gates below]
key_findings: [see below]
open_questions: [see below]

## Scorecards before / after (84 components)

P9-5a measured 83 components (the listed set at HEAD already holds 84; the
component set is unchanged by this batch):

| check | before (P9-5a, n=83) | after (n=84) |
|---|---|---|
| textContrast pass | 36/83 | **82/84** |
| labeledTapTarget pass | 72/83 | **84/84** |
| androidTapTarget pass | 61/83 | **70/84** |
| iOSTapTarget pass | 61/83 | **70/84** |
| semantics present | 78/83 | **83/84** |

Remaining failures: textContrast `menu`, `refresh_trigger` (both non-bugs,
evidence below); tap-target 14 components (dense/grid/joined controls,
per-component record below); semantics `divider` (decorative by design).

## 1. Text contrast (47 → 2)

Root causes found, in order of impact:

1. **Harness stage had no background and no default text scope** (measurement
   artefact, fixed in `tool/gen_scorecards.dart`). The pixel sampler compared
   bare text against transparent black (`4.43` muted grey, `1.06`/`1.17` dark
   text, `2.06` translucent outline fills) and sampled the white fallback
   style on the then-unpainted stage. The stage now paints
   `ThemeData().colors.background` and installs the same `DefaultTextStyle`
   (`typography.sans` + `foreground`) that `DashcnApp` provides, so scores
   measure what apps render. This alone took 47 → 26 → 8 failures.
2. **Muted-on-muted at the source** (real, fixed in theme). New
   `lib/src/theme/contrast.dart` (`textContrastRatio`, `meetsTextContrast`,
   `ensureTextContrast` with a black/white-fallback 4.5:1 guarantee; names
   avoid the `primitives/color_math.dart` `contrastRatio` export collision;
   theme→primitives imports are a layer-direction error, hence a theme-local
   helper). New `ThemeColors.onMuted` getter (preset JSONs untouched):
   returns `mutedForeground` when it already passes, else blends toward
   `foreground`, else black/white pick. New `test/registry/theme/
   contrast_test.dart` (5 tests) pins known ratios, the neutral-light fix,
   dark pixel-identity, and sweeps **all 43 preset JSONs × light/dark**
   (36 failing preset/mode combos covered by the guarantee).
3. **Real per-component bugs fixed**: `tabs` default unselected label →
   `onMuted` (gated on default-token equality, since merged styles never hold
   nulls); `object_form_field` placeholder → `onMuted` (fixes `date_picker`
   4.43); `file_diff_viewer` stat pills + line markers → blend-aware
   `ensureTextContrast` over the composited tint, status/old-path → `onMuted`,
   gutter numbers → blend-aware over gutter+row fills (a second regen round
   caught the tinted-row gutter case at 4.02/4.29); `card` `CardContent` →
   `cardForeground` `DefaultTextStyle` (bare text was white-on-white outside
   the app scope); `sortable` preview tiles → explicit surface tokens; `chat`,
   `resizable`, `skeleton` previews → `onMuted` on muted fills/shimmer.
4. **Documented non-bugs**: `menu` 3.79 is the *disabled* Delete row
   (`preview.dart:68-72`, `Opacity 0.5`) — WCAG exempts disabled controls.
   `refresh_trigger` 1.41 samples a `GlowingOverscrollIndicator` + an 800px
   unbounded `RenderParagraph` strip: debug test showed the glyphs are
   foreground-on-white (~19:1) and the histogram mode picks adjacent chrome
   (`#D9D9D9`), not the text/background pair.

## 2. Labels and semantics (11 → 0 unlabeled; 5 → 1 missing)

- Shared primitives (one fix covers many): `ChipButton.semanticLabel`
  (chip, multi_select + localizations import/dep, filter_bar, chip_input —
  label moved off the inner `Icon` onto the tappable); `ObjectPromptButton.
  semanticLabel` (object_input, `'Pick a date'`); `NavigationItemRow.
  semanticLabel` + `Text`-data fallback when the label is hidden
  (navigation_bar); `StepperIndicator.semanticLabel` defaulting to
  `'Step N'` for icon phases (numbered phases self-announce);
  tree toggle `Expand`/`Collapse` + `TreeRow.semanticLabel` with `Text`-data
  fallback for expandable rows (their toggle node otherwise splits the row's
  semantics merge — verified with throwaway semantics dumps, since removed).
- Per site: carousel arrows `Previous`/`Next` + `ExcludeSemantics` on the
  focus-request viewport tap; collapsible `ExcludeSemantics` on the icon
  button (outer node already covers the action); pagination ellipsis
  `'Page N'`; scaffold `_AppBarAction` label passthrough; `StarRating.
  semanticLabel` (+ preview `'Rating'`); `Tooltip.semanticLabel` announced as
  tooltip (+ previews); `Tracker.semanticLabel` container (+ preview);
  spinner defaults null → `'Loading'`; image preview `semanticLabel: 'Photo'`.
- `divider` intentionally unchanged: bare rule is `ExcludeSemantics` as
  decorative, which is the correct a11y treatment.

## 3. Tap targets (22 → 14)

New `lib/src/primitives/touch_hit_area.dart` (`TouchHitArea`, `touchMinEdge`:
44 iOS / 48 Android): transparent padding on touch platforms only, inside the
`Semantics` node, zero effect on desktop. Applied where free: `Button`
(vertical slop to platform minimum, skipped inside `ButtonGroup` so joined
segments keep shared edges — covers alert_dialog, button, card, dropzone,
empty_state, number_ticker, toast placement, file_picker browse) and the
collapsible label row. Per-component record: now passing — alert_dialog,
button, card, collapsible, dropzone, empty_state, number_ticker, toast;
still failing (desktop-density by design, layout growth not free) —
calendar (32px grid pitch), carousel arrows + scaffold actions (36px icon
width; 4px-gap app bars), chip/chip_input/multi_select/filter_bar delete
(12px inline), command rows (26px stacked list), dot_indicator/carousel dots
(20px, shared gaps), file_picker remove (28px row), menubar (32px bar),
object_input prompt (16px field slot), phone_input/select triggers (joined
borders), table rows (stacked, overlap precedence), toast close (16px card).
Existing size-table tests now pump a desktop platform theme (test bed runs as
Android); new `touch_hit_area_test.dart` + Button expansion test added.

## 4. Form validation at mount

`FormEntry` tracks pristine/dirty (`_FormEntryState._dirty`): the supplier's
initial publication validates as `initial`, later reports as `changed`
(`didChangeDependencies`/`didUpdateWidget` use the same `_attachMode`).
`{changed}`/`{changed, submitted}` no longer show errors before the first
edit; `{initial}` still validates at mount; `submit`/`revalidateAll`
(`submitted`) untouched. New `test/registry/primitives/
form_mount_validation_test.dart` (5 tests): quiet mount with `{changed}`,
errors after first edit, mount errors with `{initial}`, login-01 first frame
clean, all five flows (`auth/chat/checkout/onboarding/settings-01`) first
frame clean. The mount test was verified to FAIL with the fix temporarily
reverted (file restored afterwards).

## Test updates required by the intended behavior changes

- `button_test`, `pilot_metrics_test`, `button_qa_test`, `file_picker_test`
  (×2), `layout_audit_*` (×2, + theme import): size assertions now pump
  `ThemeData(platform: macOS)`; new touch-expansion test added.
- `tabs_test`, `component_theme_audit_test`: unselected-label expectation is
  now `onMuted` (+ dedicated audit test).
- `chip_input_test`: remove-button label asserted on the button's `Semantics`
  node instead of the inner `Icon`.
- Docs: `scorecard_card_test` uses `calendar` (not `button`) as the failing
  fixture; rail tests `ensureVisible` rows before tapping (footer touch
  growth shrank the scroll area on the Android test bed — app behavior is
  correct, rows scroll into view).

## Gates (all final lines)

- `rearch/qa_gate.sh` → exit 0: format 0 changed (1216); exports up to date
  (145); analyze lib/src + test/registry No issues; test **+4844 passed**;
  rearch +42 passed; layers 0 errors (file-too-long 46 warnings, 43
  pre-existing + `star_rating` 396→401 / `stepper_style` 386→408 newly over
  the ~400 advisory; unused-dep 3 pre-existing); owner switcher/preview only
  (pre-existing); user_theme 0; banned empty; stray = owned/generated paths.
- `dart run tool/gen_scorecards.dart --check` → up to date (84).
- `dart run tool/gen_exports.dart --check` → up to date (145).
- `dart run tool/registry/gen_registry_manifest.dart --check` → up to date.
- `gen_previews_test --check` → up to date (84); `gen_blocks_test --check`
  → up to date (16).
- `dart run tool/check_names.dart` → 0 hits.
- `dart format --set-exit-if-changed .` (dashcn package) → 0 changed (1460).
- Docs: `sync_registry.sh` + `gen_docs_data.dart` regenerated; both
  `--check` up to date; `flutter analyze` No issues; `flutter test test
  tool` → +594 passed.
- No `flutter pub upgrade`; pubspec.yaml untouched; no state-changing git.

## Files written (kite worktree absolute paths)

New: `dashcn/lib/src/theme/contrast.dart`,
`dashcn/lib/src/primitives/touch_hit_area.dart`,
`dashcn/test/registry/theme/contrast_test.dart`,
`dashcn/test/registry/primitives/touch_hit_area_test.dart`,
`dashcn/test/registry/primitives/form_mount_validation_test.dart`
(+ generated docs mirrors of the two lib files).
Modified (lib): theme/color_tokens, components button(+meta)/card/
carousel/preview/chat/preview/chip/chip+preview/chip_input/collapsible(+meta)/
file_diff_viewer(+meta)/filter_bar/image/preview/multi_select(+meta)/
object_input/pagination/resizable/preview/scaffold/preview/skeleton/preview/
sortable/preview/spinner/star_rating+preview/stepper_style/tabs/tooltip+
preview/tracker+preview/tree_style, primitives form_core/form_entry+
object_form_field/navigation/navigation_item_row/object_segments,
manifests registry.json+scorecards.json, barrels dashcn/primitives/theme.dart,
tool/gen_scorecards.dart, harness + examples regenerated.
Modified (tests): button/chip_input/file_picker/pilot_metrics/tabs tests,
layout_audit ×2, button_qa, component_theme_audit.
Modified (docs): test/scorecard_card, theme_rail_ux, themes_page tests;
regenerated mirror + docs data (expected `sync_registry`/`gen_docs_data`
output). PNG churn under `rearch/screenshots|design` is test-runner output,
not changes.
Untracked non-code: `rearch/logs/kitfix1_qagate*.log` (gate transcripts).

## Open questions

- `divider` still reports semantics-missing: by design (decorative
  `ExcludeSemantics`). If the scorecard must show green, exempt it in the
  harness or pump the labelled preview — orchestrator call.
- `menu` (disabled-row 3.79) and `refresh_trigger` (chrome-sampling 1.41)
  fail textContrast by measurement/exemption, not by bug; same harness-
  presentation question as above.
- 14 tap-target components keep desktop density (32–36px, some 12–28px
  inline controls): accepted per brief ("where it is free"), recorded above.
- `star_rating.dart`/`stepper_style.dart` newly exceed the ~400-line
  advisory (warnings only); shrinking them further would hurt readability.
