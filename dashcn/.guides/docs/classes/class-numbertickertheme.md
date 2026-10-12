---
title: "Class: NumberTickerTheme"
description: "Theme of the animated number ticker."
---

```dart
/// Theme of the animated number ticker.
///
/// Every field is nullable: `null` means "inherit", and the resolver fills
/// the gap from the next leg (defaults < app < scoped < widget).
class NumberTickerTheme extends ComponentThemeData implements Mergeable<NumberTickerTheme> {
  /// Creates a number ticker theme.
  const NumberTickerTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.duration, this.curve, this.style});
  /// Animation duration. Default: 500ms.
  final Duration? duration;
  /// Animation curve. Default: `Curves.easeInOut`.
  final Curve? curve;
  /// Text style; null inherits the ambient style.
  final TextStyle? style;
  /// Returns a copy with the given fields replaced.
  NumberTickerTheme copyWith({ValueGetter<Duration?>? duration, ValueGetter<Curve?>? curve, ValueGetter<TextStyle?>? style});
  /// Receiver wins per field; [fallback] only fills null cells.
  NumberTickerTheme merge(NumberTickerTheme? fallback);
  /// Steps at `t = 0.5`, except the duration which interpolates.
  static NumberTickerTheme lerp(NumberTickerTheme a, NumberTickerTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
