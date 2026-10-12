---
title: "Class: DurationInput"
description: "A typed duration field: hour/minute(/second) segments."
---

```dart
/// A typed duration field: hour/minute(/second) segments. Controlled with
/// [value] + [onChanged]; uncontrolled with [initialValue]. Incomplete or
/// out-of-range durations report null. Null [onChanged] disables.
/// (Dialog picking already lives in `time_picker`.)
class DurationInput extends StatelessWidget {
  /// Creates a duration input.
  const DurationInput({super.key, this.value, this.initialValue, this.onChanged, this.enabled = true, this.showSeconds = false, this.separator = ':', this.placeholders, this.validator, this.theme});
  /// Controlled value.
  final Duration? value;
  /// Uncontrolled seed.
  final Duration? initialValue;
  /// Called with the next duration (null while incomplete/invalid).
  final ValueChanged<Duration?>? onChanged;
  /// Whether the field accepts input; disabled dims to 50%.
  final bool enabled;
  /// Whether a seconds segment shows.
  final bool showSeconds;
  /// Text between segments.
  final String separator;
  /// Per-part placeholder overrides; null uses locale abbreviations.
  final Map<DurationPart, Widget>? placeholders;
  /// Validates the parsed duration; a non-null result shows below the field.
  final String? Function(Duration? value)? validator;
  /// Widget-leg theme override, forwarded to [FormattedInput].
  final FormattedInputTheme? theme;
  Widget build(BuildContext context);
}
```
