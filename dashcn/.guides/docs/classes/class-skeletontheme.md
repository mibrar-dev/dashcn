---
title: "Class: SkeletonTheme"
description: "Visual contract of one skeleton placeholder."
---

```dart
/// Visual contract of one skeleton placeholder.
class SkeletonTheme extends ComponentThemeData implements Mergeable<SkeletonTheme> {
  /// Creates a skeleton theme.
  const SkeletonTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.fromColor, this.toColor, this.duration, this.curve, this.borderRadius});
  /// Leading fill of the shimmer sweep; null resolves the `muted` token.
  final ThemedColor? fromColor;
  /// Trailing fill of the shimmer sweep; null resolves the `accent` token.
  final ThemedColor? toColor;
  /// Length of one sweep; null resolves [kDefaultDuration] * 2.
  final Duration? duration;
  /// Sweep easing; null resolves [Curves.linear].
  final Curve? curve;
  /// Corner radius of the placeholder; null resolves `radiusMd`.
  final BorderRadiusGeometry? borderRadius;
  /// Returns a copy with the given fields replaced.
  SkeletonTheme copyWith({ValueGetter<ThemedColor?>? fromColor, ValueGetter<ThemedColor?>? toColor, ValueGetter<Duration?>? duration, ValueGetter<Curve?>? curve, ValueGetter<BorderRadiusGeometry?>? borderRadius});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  SkeletonTheme merge(SkeletonTheme? fallback);
  /// State scales step at t < 0.5; dimensions and durations lerp.
  static SkeletonTheme lerp(SkeletonTheme a, SkeletonTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
