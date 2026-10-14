# P7-Z final polish — report

## Scope
Brief `rearch/briefs/fixes/P7-Z-polish.md` (orchestrator visual QA after the P7
batch, commit `102fb81`). Five fixes + file-length rule. No git ops.

## 1. Registry `command` — no focus ring on the search input
- `Input` gains additive `showFocusRing` (default `true`), forwarded to
  `EditableTextShell.showFocusRing` (default `true`), which gates
  `FocusOutline(focused: focused && showFocusRing)`.
- `Command` passes `showFocusRing: false` to its search `Input`. The row keeps
  its transparent surface + 1px bottom divider (border token); the search icon
  stays `size 16` (`size-4`) inside `Opacity(0.5)`. Keyboard focus still lands
  in the field (caret/selection visible, `EditableText.focusNode.hasFocus`).
- Tests (`test/registry/components/command_test.dart`, P7-Z group): focused
  input has `hasFocus == true` while every `FocusOutline` inside `Command` is
  `focused == false`; a bottom-only `Border` divider exists; icon size/opacity
  asserted.
- `command.dart` trimmed 424 → 396 lines (comment condensation only).

## 2. Docs preview card toolbar — tabs left, actions right
- `docs/lib/widgets/example_preview_card.dart`: replaced
  `Flexible(flex:10) + Spacer()` (loose flex leaves trailing space after the
  actions, so toggle/copy sat next to the tabs on desktop) with tight
  `Expanded` tab strip + `Gap(8)` + actions. Single row at all widths; strip
  scrolls internally on 320px phones.
- Tests (`docs/test/component_examples_test.dart`, P7-Z group at 1440/375):
  same-row dy ≤ 8px, `tabs.left == card.left + 16`, `copy.right ==
  card.right - 16`, toggle after tabs. Existing D1b 320/375 row test still
  passes.

## 3. `basic_layout`/`Basic` RTL — directional alignments
- `primitives/basic_layout.dart` and `primitives/layout.dart` (`Basic`) defaults:
  `Alignment.topCenter` → `AlignmentDirectional.topCenter` (leading/trailing),
  `Alignment.topLeft` → `AlignmentDirectional.topStart`
  (title/subtitle/content). Fixes `Alert` + every `BasicLayout` consumer staying
  left-pinned in RTL.
- Tests (`test/registry/primitives/layout_test.dart`, P7-Z RTL group): all
  default `Align`s are `AlignmentDirectional`; title `dx` in RTL > LTR.

## 4. `Clickable.autofocus` — own the node once, drop duplicates
- `Clickable` gains additive `autofocus` (default `false`). `ClickableState`
  tracks ownership (`_ownsFocusNode`), disposes only the owned node (fixes a
  leak — the old state never disposed), and requests focus post-frame guarded
  by `mounted` + node identity; only when `enabled`. `didUpdateWidget` handles
  node swaps and flag flips.
- `Badge` converted `StatefulWidget` → `StatelessWidget`, deletes its
  `_ownedFocusNode`/`_syncAutofocus`, forwards `focusNode`/`autofocus` to
  `Clickable` (212 lines). `Chip`/`ChipButton` delete `_AutofocusClickable`
  (~120 lines) and use `Clickable` directly (275 lines).
- Tests: `clickable_test.dart` P7-Z group (owned, external, off, disabled);
  new `badge_chip_autofocus_test.dart` (static builds no `Clickable`;
  pressable forwards `autofocus` and gains focus; external node focused).
  Existing `badge_test.dart`/`chip_test.dart` untouched (already over-length)
  and still pass.

## 5. `object_form_prompt` dialog — bound unbounded editors
- Root cause: `IntrinsicWidth` queries viewport intrinsics;
  `RenderShrinkWrappingViewport does not support returning intrinsic
  dimensions` for any `ListView`/viewport editor (reproduced).
- Fix: `LayoutBuilder` viewport caps (`maxW = min(viewport, 480)`, `maxH =
  viewport`), editor wrapped in `ConstrainedBox(maxW − cardInsets,
  maxH − cardInsets − 120)` so infinite/viewport editors layout; footer row is
  `MainAxisSize.min` so the card still hugs. Viewport editors
  (`ScrollView`/`SingleChildScrollView`) skip `IntrinsicWidth`; content editors
  (pickers) keep it, preserving the exact shrink-wrap measurements.
- Tests: new `object_form_prompt_test.dart` (infinite-width `SizedBox`,
  `ListView.shrinkWrap`, small-editor floor ≥ 240 / ceiling ≤ 480).
  `p7u2_pickers_test.dart` all 12 pass (card == grid width, ≤ 360×420,
  footer geometry, density scaling, 375 fit).

## 6. File lengths
All touched files kept ≤ 400 lines (no splits needed; over-length risk handled
by trimming comments, deleting duplicates):
`clickable 194`, `clickable_state 327`, `badge 212`, `chip 275`,
`basic_layout 156`, `layout 320`, `command 396`, `input 397`, `shell 223`,
`object_form_prompt 396`, `command_test 391`, `clickable_test 278`,
`layout_test 223`, `badge_chip_autofocus 123`, `object_form_prompt_test 97`,
`example_preview_card 322`, docs `component_examples_test 333`.
Remaining > 400-line registry files (38, untouched, out of scope): calendar
618, typography 613, color_tokens 587, item_picker 510, input_otp 501, carousel
492, theme 472, time_picker 469, menu 458, chat 455, tokens 454,
feature_carousel 441, file_picker 440, formatted_input 435, radio_group 426,
border_loading 426, file_diff_viewer 421, gooey_toast 419, date_picker 419,
filter_bar 418, checkbox 416, window_host 414, error_system 414,
calendar_style 412, select 408, color_picker_style 407, chat_style 407,
tree_style 404, slider 404, tabs 403, window 402, color_picker 402,
refresh_trigger 401, object_input 401, drawer_container 401 (plus 3 generated
icon files excluded from the gate count).

## Gates
- `rearch/qa_gate.sh`: format 0 changed; analyze lib + tests clean;
  `test/registry` +4400 pass; `test/rearch` +42 pass; layers `file-too-long:
  38 (warning)`; owner 1 finding `switcher/preview.dart:76` (pre-existing —
  switcher untouched, verified via `git status`); banned empty.
- Generators: manifest regen + `--check` clean; previews regen + `--check`
  clean (83); blocks regen + `--check` clean (16); `docs/tool/sync_registry.sh`
  + `--check` clean; `docs tool/gen_docs_data.dart` + `--check` clean.
- `docs`: `flutter analyze` clean; toolbar tests (P7-Z + D1b) pass;
  `flutter build web --release` succeeds (`build/web`).
- Full targeted suites: command/clickable/layout/badge_chip_autofocus/
  object_form_prompt/badge/chip/object_input/item_picker_qa all pass.

## Open questions
- `check_single_owner` switcher finding pre-exists on this branch; not caused
  by P7-Z (no switcher files touched).
- `rearch/screenshots/pilot/preview_button_{dark,light}.png` show ~20–55 byte
  PNG diffs after the full test run (likely test-run metadata); PNGs not opened
  per the brief — orchestrator to confirm goldens.
- No `UNVERIFIED` items: every claim above is backed by executed tests/gates.
