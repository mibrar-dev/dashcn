---
title: "Class: NumberTicker"
description: "Animated number: counts between values with [duration]/[curve]."
---

```dart
/// Animated number: counts between values with [duration]/[curve].
///
/// Either [formatter] (text variant) or [builder] (custom variant) is given.
class NumberTicker extends StatelessWidget {
  /// Text variant: [formatter] renders the animated value.
  const NumberTicker({super.key, this.initialNumber, required this.number, required this.formatter, this.duration, this.curve, this.style, this.theme});
  /// Custom variant: [builder] renders the animated value.
  const NumberTicker.builder({super.key, this.initialNumber, required this.number, required this.builder, this.child, this.duration, this.curve, this.theme});
  /// Value the first animation runs from; null starts at [number].
  final num? initialNumber;
  /// Target value.
  final num number;
  /// Custom content builder (custom variant).
  final NumberTickerBuilder? builder;
  /// Passed through to [builder].
  final Widget? child;
  /// Text formatter (text variant).
  final NumberTickerFormatted? formatter;
  /// Animation duration override; null falls back to the theme.
  final Duration? duration;
  /// Animation curve override; null falls back to the theme.
  final Curve? curve;
  /// Text style override; null falls back to the theme, then ambient.
  final TextStyle? style;
  /// Widget-leg theme override, merged over the other legs.
  final NumberTickerTheme? theme;
  Widget build(BuildContext context);
}
```
