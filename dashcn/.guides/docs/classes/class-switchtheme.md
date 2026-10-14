---
title: "Class: SwitchTheme"
description: "On/off theme container for the switch component."
---

```dart
/// On/off theme container for the switch component.
class SwitchTheme extends ComponentThemeData implements Mergeable<SwitchTheme> {
  /// Creates a switch theme with one nullable slice per value.
  const SwitchTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.on, this.off, this.labelStyle});
  /// Style while the switch is on.
  final SwitchStyle? on;
  /// Style while the switch is off.
  final SwitchStyle? off;
  /// Label text style shared by both values; a value row wins over it.
  final TextStyle? labelStyle;
  /// The slice for the current value, or null when this leg leaves it unset.
  SwitchStyle? forValue(bool value);
  /// Returns a copy with the given fields replaced.
  SwitchTheme copyWith({ValueGetter<SwitchStyle?>? on, ValueGetter<SwitchStyle?>? off, ValueGetter<TextStyle?>? labelStyle});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  SwitchTheme merge(SwitchTheme? fallback);
  /// Lerps each row; state scales step at t < 0.5.
  static SwitchTheme lerp(SwitchTheme a, SwitchTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
