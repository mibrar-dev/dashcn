---
title: "Class: TimeInput"
description: "A typed time field: hour/minute(/second) segments."
---

```dart
/// A typed time field: hour/minute(/second) segments. Controlled with
/// [value] + [onChanged]; uncontrolled with [initialValue]. Incomplete or
/// out-of-range times report null. Null [onChanged] disables.
/// (Dialog picking already lives in `time_picker`.)
class TimeInput extends StatelessWidget {
  /// Creates a time input.
  const TimeInput({super.key, this.value, this.initialValue, this.onChanged, this.enabled = true, this.showSeconds = false, this.separator = ':', this.placeholders, this.validator, this.theme});
  /// Controlled value.
  final TimeOfDay? value;
  /// Uncontrolled seed.
  final TimeOfDay? initialValue;
  /// Called with the next time (null while incomplete/invalid).
  final ValueChanged<TimeOfDay?>? onChanged;
  /// Whether the field accepts input; disabled dims to 50%.
  final bool enabled;
  /// Whether a seconds segment shows.
  final bool showSeconds;
  /// Text between segments.
  final String separator;
  /// Per-part placeholder overrides; null uses locale abbreviations.
  final Map<TimePart, Widget>? placeholders;
  /// Validates the parsed time; a non-null result shows below the field.
  final String? Function(TimeOfDay? value)? validator;
  /// Widget-leg theme override, forwarded to [FormattedInput].
  final FormattedInputTheme? theme;
  Widget build(BuildContext context);
}
```
