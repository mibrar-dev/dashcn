---
title: "Class: FormattedInput"
description: "A field made of static separators and small editable segments."
---

```dart
/// A field made of static separators and small editable segments.
///
/// Two modes, like `Toggle`: uncontrolled with a [FormattedInputController],
/// or controlled with [value] + [onChanged].
///
/// ```dart
/// FormattedInput(
///   initialValue: const SegmentedValue([
///     SegmentPart.separator('('),
///     SegmentPart.editable(length: 3),
///     SegmentPart.separator(') '),
///     SegmentPart.editable(length: 3),
///     SegmentPart.separator('-'),
///     SegmentPart.editable(length: 4),
///   ]),
/// );
/// ```
///
/// Static separators render exactly where declared, in order; the field hugs
/// the segments plus separators (never stretches in a loose parent) and fills
/// a tight parent instead.
///
/// A segment sizes itself from the resolved text style (`length` glyph
/// advances plus the cursor, floored by the placeholder width); pass `width`
/// only to force a wider box (never narrower than the content needs).
class FormattedInput extends StatefulWidget {
  /// Creates a formatted input.
  const FormattedInput({super.key, this.controller, this.initialValue, this.value, this.onChanged, this.leading, this.trailing, this.enabled = true, this.validator, this.autovalidateMode = FormValidationMode.changed, this.theme});
  /// Uncontrolled mode: the controller owns the value.
  final FormattedInputController? controller;
  /// Initial value; ignored in controlled mode.
  final SegmentedValue? initialValue;
  /// Controlled mode: the current value.
  final SegmentedValue? value;
  /// Controlled mode: called with the next value.
  final ValueChanged<SegmentedValue>? onChanged;
  /// Widget before the parts.
  final Widget? leading;
  /// Widget after the parts.
  final Widget? trailing;
  /// Whether the field accepts input; a disabled field is dimmed to 50%.
  final bool enabled;
  /// Validation of the joined text; a non-null result shows below the field.
  final String? Function(String? text)? validator;
  /// When [validator] runs: `initial`, `changed` (default) or `submitted`.
  final FormValidationMode autovalidateMode;
  /// Widget-leg theme override, merged on top of the other legs.
  final FormattedInputTheme? theme;
  State<FormattedInput> createState();
}
```
