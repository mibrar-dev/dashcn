---
title: "Class: Density"
description: "Density bases for container padding, content padding and gaps."
---

```dart
/// Density bases for container padding, content padding and gaps.
class Density {
  const Density({required this.baseContainerPadding, required this.baseGap, required this.baseContentPadding});
  static const Density defaultDensity = Density(baseContainerPadding: 16.0, baseGap: 8.0, baseContentPadding: 16.0);
  static const Density reducedDensity = Density(baseContainerPadding: 12.0, baseGap: 6.0, baseContentPadding: 12.0);
  static const Density spaciousDensity = Density(baseContainerPadding: 20.0, baseGap: 10.0, baseContentPadding: 20.0);
  static const Density compactDensity = Density(baseContainerPadding: 8.0, baseGap: 4.0, baseContentPadding: 8.0);
  /// Preset-spacing bridge: container/content = base * 4, gap = base * 2.
  factory Density.fromSpacingScale(SpacingScale spacing);
  final double baseContainerPadding;
  final double baseGap;
  final double baseContentPadding;
  /// Scale of this density relative to [defaultDensity]: exactly 1 at the
  /// upstream reference density (16/16/8), 0.5 at compact, 1.25 at comfortable.
  ///
  /// The `button` size table scales every upstream px value with this factor
  /// (`_buttonMetricsFor`); [EdgeInsetsDensity.pxSymmetric] is the const
  /// spelling of the same rule for theme defaults.
  double get scale;
  /// Density base at [defaultDensity]: the divisor that turns a upstream px
  /// value into an [EdgeInsetsDensity] multiplier.
  static const double pxBase = 16.0;
  SpacingScale toSpacingScale();
  Density copyWith({double? baseContainerPadding, double? baseGap, double? baseContentPadding});
  static Density lerp(Density a, Density b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
