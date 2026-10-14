---
title: "Class: BorderLoadingTheme"
description: "Geometry, timing and opacity of one border loader."
---

```dart
/// Geometry, timing and opacity of one border loader.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class BorderLoadingTheme extends ComponentThemeData implements Mergeable<BorderLoadingTheme> {
  /// Creates a border-loading theme.
  const BorderLoadingTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.mode, this.strokeWidth, this.padding, this.borderRadius, this.backgroundColor, this.duration, this.curve, this.opacity});
  /// Rendering mode; null falls through to the widget, then `sweepGradient`.
  final BorderLoadingMode? mode;
  /// Outline thickness; null resolves `2`.
  final double? strokeWidth;
  /// Gap between the painted border and the child; null resolves
  /// `EdgeInsets.all(strokeWidth)`.
  final EdgeInsetsGeometry? padding;
  /// Corner radius; null resolves `12`.
  final BorderRadiusGeometry? borderRadius;
  /// Fill behind the child; null draws none.
  final ThemedColor? backgroundColor;
  /// Cycle duration of the looping modes; null resolves `1200ms`.
  final Duration? duration;
  /// Easing applied to normalized progress; null resolves `Curves.linear`.
  final Curve? curve;
  /// Stroke opacity (`0..1`); null resolves `1`.
  final double? opacity;
  /// Returns a copy with the given fields replaced.
  BorderLoadingTheme copyWith({ValueGetter<BorderLoadingMode?>? mode, ValueGetter<double?>? strokeWidth, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<ThemedColor?>? backgroundColor, ValueGetter<Duration?>? duration, ValueGetter<Curve?>? curve, ValueGetter<double?>? opacity});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  BorderLoadingTheme merge(BorderLoadingTheme? fallback);
  /// Discrete values step at t < 0.5; scalars are lerped.
  static BorderLoadingTheme lerp(BorderLoadingTheme a, BorderLoadingTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
