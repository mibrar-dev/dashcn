# FormattedInput

Masked/segmented field: a phone number, a date, a card number, a PIN. Static
separators sit between small editable segments, and the whole field is one
value.

Widgets-only. The segment machinery (controllers, focus order, value model)
lives in `primitives/text_editing/segmented_editing.dart` and
`segmented_value.dart`, so the component folder holds the widget, its style and
its theme.

## When to use

- Phone / date / card / PIN entry where each segment has a fixed length.
- Any field whose visible text is a mask over a shorter underlying value.

For free-form text use `input`; for a step-by-step wizard use `stepper`.

## Snippets

```dart
FormattedInput(
  initialValue: SegmentedValue([
    const SegmentPart.separator('('),
    SegmentPart.editable(length: 3, placeholder: const Text('555')),
    const SegmentPart.separator(') '),
    SegmentPart.editable(length: 3, placeholder: const Text('123')),
    const SegmentPart.separator('-'),
    SegmentPart.editable(length: 4, placeholder: const Text('4567')),
  ]),
  validator: (text) => (text ?? '').replaceAll(RegExp(r'[^0-9]'), '').length == 10
      ? null
      : 'Enter a full number.',
);
```

Separators render exactly where declared, in order (`(555) 123-4567` above).
Segments size themselves from the resolved text style (`length` glyph
advances plus the cursor, floored by the placeholder width so labels like
`MM` never wrap, density-aware); pass `width` only to force a wider box —
it is never shrunk below what the content needs. The field hugs its content
(never stretches in a loose parent) and fills a tight parent instead. Its
height is the dashcn input height (h-9), shared with `Input`.

Controller mode, for a field whose value other widgets also read:

```dart
final controller = FormattedInputController(_phone);
FormattedInput(controller: controller); // controller.value.text -> '(555) 123-4567'
```

## API

| Type | Notes |
|---|---|
| `FormattedInput` | `controller` **or** `value` + `onChanged`, `initialValue`, `leading`, `trailing`, `enabled`, `validator`, `autovalidateMode`, `theme` |
| `FormattedInputController` | `ValueNotifier<SegmentedValue>`; the value of a controller-driven field |
| `SegmentPart` | `.editable(length:, width:? (auto), value:, obscureText:, placeholder:, inputFormatters:)` and `.separator(' / ')` |
| `SegmentedValue` | the parts + each segment's value; `text`, `values`, `withValue(index, value)`, `hasShape(parts)` |
| `TextSegment` / `SegmentedTextController` | the segment primitive: one controller and focus node per segment |

The field is **controlled** when you pass `value` + `onChanged`; it reports the
next value and you decide whether to apply it. Once the field has seen a
non-null `value` it stays controlled: passing `value: null` later clears the
field to the empty shape instead of keeping the stale text. Pass `controller`
(with no `value`/`onChanged`) for uncontrolled-with-listener, or `initialValue`
alone for a purely uncontrolled field.

Keyboard:

- Typing a full segment hands the focus to the next one (caret at its
  start); <kbd>Enter</kbd> does the same from anywhere in a segment.
- <kbd>Backspace</kbd> in an empty segment steps back and deletes the
  previous segment's last glyph; at the start of a non-empty segment (or
  <kbd>←</kbd> at the start) it steps back without deleting.
- <kbd>→</kbd> at the end of a segment steps forward.
- Pasting distributes characters across segments (through each segment's
  `inputFormatters`, so digits-only fields strip separators).

There is intentionally no `LengthLimitingTextInputFormatter`: over-length
input is distributed across the following segments instead of being
truncated, so paste keeps every glyph. Lengths are still enforced per
segment. Round-trips never rewrite the focused box when its text already
matches (the caret and the IME composing range survive); other boxes keep
a clamped selection.

## Theme resolution

`widget (theme:) > ComponentTheme<FormattedInputTheme> in field > app
overrides (formatted_input_theme.dart through ComponentThemes) >
formattedInputDefaults`, merged per field with receiver-wins
`Mergeable.merge`.

| `FormattedInputTheme` field | Default |
|---|---|
| `background` | `input` at 30% |
| `hoveredBackground` | `input` at 50% |
| `borderColor` | the `input` token |
| `borderWidth` | 1 |
| `borderRadius` | `theme.borderRadiusMd` |
| `padding` | `8 x 4` (scaled) |
| `height` | 36 (the dashcn input height) |
| `textStyle` | `text-sm` + `mono` |
| `placeholderStyle` | `text-sm` muted |
| `separatorStyle` | the segment style in `mutedForeground` |
| `leadingGap` | 8 (scaled) |
| `partGap` | 0 |

A disabled field is wrapped in `Opacity(0.5)` and `IgnorePointer`, its segments
become `readOnly`, their focus nodes refuse focus (`canRequestFocus: false`)
and the focus ring never paints.

## Validation

`validator` receives the **joined** text (separators included), so a digit
count has to strip them first — see the snippet above. `autovalidateMode` is
`FormValidationMode.initial`, `changed` (default) or `submitted`. Once an error
is on screen it stays live in every mode, so it clears as soon as the value
becomes valid instead of sticking.

## Fixed bugs (old `registry/components/form/formatted_input`)

- The old tree was **2,084 lines across 23 files** of `part` files, with a
  `// ignore_for_file` list on nearly every one of them (including
  `dead_code` and `deprecated_member_use`). It is now 4 files.
- **Every keystroke was dropped in controller mode.** The mirror value was
  seeded from `value ?? initialValue` only, so a controller-driven field wrote
  its next value into an empty `SegmentedValue` — the part list was lost and the
  controller always read back as `''`.
- **A same-shape value swap tore down every segment.** The rebuild check
  compared the whole part list including values, so each parent rebuild (every
  keystroke in controlled mode) disposed the live `TextEditingController`s and
  lost the caret. `SegmentedValue.hasShape` compares the *shape* only; a value
  swap now flows through the existing controllers.
- **Backspace at the start of a segment did nothing.** The key handler looked
  the segment up by node identity, but `Focus.onKeyEvent` is invoked on the
  *handler's* node, not the primary focus, so the lookup always returned `-1`.
  It now finds the focused segment by focus.
- **A visible error could never clear.** `FormValidationMode.initial` and
  `submitted` validate once; the error stayed on screen while the user fixed
  the field. A shown error now revalidates on every change.
- **`SegmentPart.editable(inputFormatters:)` was ignored** — the widget passed
  `part.segment.formatters()`, and `SegmentPart.segment` never copied the
  formatters across, so a digits-only mask silently did nothing.
- The dead cross-part drag selection (`_FormattedSelectionCoordinator`'s
  `onDragStart`/`onDragUpdate`/`onDragEnd`, `_estimateOffset`, `_dragging`,
  `_dragAnchorPart`, `_dragAnchorOffset`) was never wired to a gesture hook —
  the file says so itself — and walked the live element tree on every call to
  find mounted states. It is dropped; `SegmentedTextController` keeps focus
  tracking, `selectAll` and `selectedText` without the tree walk.
- The composing region lost its underline in the port: the old
  `_EditablePartController` styled `textInside` with `TextDecoration.underline`
  and the first port concatenated the three composing spans with no style.
- The filler `_` padding used `theme.colorScheme.mutedForeground` (a non-token
  colour) and `max(0, …)`; it now resolves `Theme.of(context).colors
  .mutedForeground` and clamps.
- `FormattedObjectInput` (and its `_impl` state + controller) is dropped; see
  below.

## Not carried over

- **`FormattedObjectInput`** built a whole object out of several masked fields
  with its own state class and controller. B21 should compose `FormattedInput`
  with `ObjectFormField` instead, so no caller loses the capability.
- **`WidgetPart`** — a part whose content is an arbitrary widget, which made
  the value model describe layout as well as data. Use `leading`/`trailing` for
  decoration.
- **Per-part `FormKey` wiring.** Every segment used to register its own form
  entry; the field registers one `SegmentedValue` now, so a form reports one
  error for one field.
- **`onPartsChanged`, `readOnly`, `autofocus`, `maxLengthEnforcement` and the
  per-part widget list.** Read-only comes from `enabled: false`; autofocus is
  not meaningful when the field owns N focus nodes; the length enforcement mode
  is not used by any dashcn text field.
- **Cross-part select-all / copy and the `Copy` context-action override.**
  `SegmentedTextController.selectAll`/`selectedText` remain available for a
  caller that wants them.

## Getting started

1. Install the component (`dashcn add formatted_input`) or copy the
   folder into `lib/ui/dashcn/formatted_input/`.
2. Import `formatted_input.dart`; it re-exports `SegmentPart`, `SegmentedValue`
   and the theme API.
3. App-wide overrides go in `formatted_input_theme.dart`; per-field overrides
   use `ComponentTheme<FormattedInputTheme>(data: ..., child: ...)`.
