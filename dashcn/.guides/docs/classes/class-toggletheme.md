---
title: "Class: ToggleTheme"
description: "On/off theme container for the toggle component."
---

```dart
/// On/off theme container for the toggle component.
class ToggleTheme extends ComponentThemeData implements Mergeable<ToggleTheme> {
  /// Creates a toggle theme with one nullable slice per value.
  const ToggleTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.on, this.off});
  /// Style while the toggle is on.
  final ToggleStyle? on;
  /// Style while the toggle is off.
  final ToggleStyle? off;
  /// The slice for the current value, or null when this leg leaves it unset.
  ToggleStyle? forValue(bool value);
  /// Returns a copy with the given fields replaced.
  ToggleTheme copyWith({ValueGetter<ToggleStyle?>? on, ValueGetter<ToggleStyle?>? off});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  ToggleTheme merge(ToggleTheme? fallback);
  /// Lerps each row; state scales step at t < 0.5.
  static ToggleTheme lerp(ToggleTheme a, ToggleTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
