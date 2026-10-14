---
title: "Class: SwitcherTheme"
description: "Motion contract for the `switcher` component."
---

```dart
/// Motion contract for the `switcher` component.
class SwitcherTheme extends ComponentThemeData implements Mergeable<SwitcherTheme> {
  /// Creates a switcher theme.
  const SwitcherTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.duration, this.curve});
  /// Snap-back duration; default 150 ms ([kDefaultDuration]).
  final Duration? duration;
  /// Snap-back curve; default `Curves.easeInOut`.
  final Curve? curve;
  /// Returns a copy with the given fields replaced.
  SwitcherTheme copyWith({ValueGetter<Duration?>? duration, ValueGetter<Curve?>? curve});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  SwitcherTheme merge(SwitcherTheme? fallback);
  /// Discrete fields step at t < 0.5.
  static SwitcherTheme lerp(SwitcherTheme a, SwitcherTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
