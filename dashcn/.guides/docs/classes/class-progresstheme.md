---
title: "Class: ProgressTheme"
description: "One progress bar's visual contract."
---

```dart
/// One progress bar's visual contract.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields. `borderRadius` resolves at
/// build because its default follows the bar height (a pill).
class ProgressTheme extends ComponentThemeData implements Mergeable<ProgressTheme> {
  /// Creates a progress theme.
  const ProgressTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.color, this.backgroundColor, this.height, this.borderRadius, this.showSparks, this.disableAnimation});
  /// Fill colour; null resolves the `primary` token.
  final ThemedColor? color;
  /// Track colour; null resolves [color] at 20% alpha.
  final ThemedColor? backgroundColor;
  /// Bar height in logical pixels; null resolves `8 * scaling`.
  final double? height;
  /// Corner radius; null resolves a pill at half the height.
  final BorderRadiusGeometry? borderRadius;
  /// Whether to paint a glow at the leading edge of the fill.
  final bool? showSparks;
  /// Whether value changes jump instead of animating.
  final bool? disableAnimation;
  /// Returns a copy with the given fields replaced.
  ProgressTheme copyWith({ValueGetter<ThemedColor?>? color, ValueGetter<ThemedColor?>? backgroundColor, ValueGetter<double?>? height, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<bool?>? showSparks, ValueGetter<bool?>? disableAnimation});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  ProgressTheme merge(ProgressTheme? fallback);
  /// Colours and flags step at t < 0.5; dimensions are lerped.
  static ProgressTheme lerp(ProgressTheme a, ProgressTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
