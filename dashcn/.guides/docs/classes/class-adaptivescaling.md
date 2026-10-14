---
title: "Class: AdaptiveScaling"
description: "Per-axis scaling factors for adaptive layouts."
---

```dart
/// Per-axis scaling factors for adaptive layouts.
class AdaptiveScaling {
  static const AdaptiveScaling desktop = AdaptiveScaling();
  static const AdaptiveScaling mobile = AdaptiveScaling(1.25);
  final double radiusScaling;
  final double sizeScaling;
  final double textScaling;
  const AdaptiveScaling([double scaling = 1]);
  const AdaptiveScaling.only({this.radiusScaling = 1, this.sizeScaling = 1, this.textScaling = 1});
  /// Returns a copy of [theme] with radius/sizing/typography/icon sizes
  /// scaled. Takes [ThemeData] (new tree) — same factors as before.
  ThemeData scale(ThemeData theme);
  static AdaptiveScaling lerp(AdaptiveScaling a, AdaptiveScaling b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
