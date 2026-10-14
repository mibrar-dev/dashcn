---
title: "Class: SpinnerTheme"
description: "One spinner's visual contract."
---

```dart
/// One spinner's visual contract.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields. `strokeWidth` resolves at
/// build because its default follows the diameter (`size / 12`).
class SpinnerTheme extends ComponentThemeData implements Mergeable<SpinnerTheme> {
  /// Creates a spinner theme.
  const SpinnerTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.size, this.strokeWidth, this.color});
  /// Diameter in logical pixels; null resolves `24 * scaling`.
  final double? size;
  /// Arc thickness; null resolves `size / 12`.
  final double? strokeWidth;
  /// Arc colour; null resolves the `primary` token.
  final ThemedColor? color;
  /// Returns a copy with the given fields replaced.
  SpinnerTheme copyWith({ValueGetter<double?>? size, ValueGetter<double?>? strokeWidth, ValueGetter<ThemedColor?>? color});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  SpinnerTheme merge(SpinnerTheme? fallback);
  /// Colours step at t < 0.5; dimensions are lerped.
  static SpinnerTheme lerp(SpinnerTheme a, SpinnerTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
