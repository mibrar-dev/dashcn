---
title: "Class: CheckboxTheme"
description: "Per-value theme container for the checkbox component."
---

```dart
/// Per-value theme container for the checkbox component.
class CheckboxTheme extends ComponentThemeData implements Mergeable<CheckboxTheme> {
  /// Creates a checkbox theme with one nullable slice per value.
  const CheckboxTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.checked, this.unchecked, this.indeterminate, this.labelStyle});
  /// Style while [CheckboxValue.checked].
  final CheckboxStyle? checked;
  /// Style while [CheckboxValue.unchecked].
  final CheckboxStyle? unchecked;
  /// Style while [CheckboxValue.indeterminate].
  final CheckboxStyle? indeterminate;
  /// Label text style shared by every value; a value row wins over it.
  final TextStyle? labelStyle;
  /// The slice for [value], or null when this leg leaves it unset.
  CheckboxStyle? forValue(CheckboxValue value);
  /// Returns a copy with the given fields replaced.
  CheckboxTheme copyWith({ValueGetter<CheckboxStyle?>? checked, ValueGetter<CheckboxStyle?>? unchecked, ValueGetter<CheckboxStyle?>? indeterminate, ValueGetter<TextStyle?>? labelStyle});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  CheckboxTheme merge(CheckboxTheme? fallback);
  /// Lerps each row; state scales step at t < 0.5.
  static CheckboxTheme lerp(CheckboxTheme a, CheckboxTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
