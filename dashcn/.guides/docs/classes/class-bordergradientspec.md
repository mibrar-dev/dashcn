---
title: "Class: BorderGradientSpec"
description: "The built-in sweep/linear/radial gradient configuration."
---

```dart
/// The built-in sweep/linear/radial gradient configuration.
class BorderGradientSpec extends BorderLoadingSpec {
  /// Creates a gradient configuration.
  const BorderGradientSpec({this.type = BorderGradientType.sweep, this.colors, this.stops, this.gap = 0.22, this.rotateWithProgress = true, this.startAngle = -math.pi / 2, this.begin = Alignment.topLeft, this.end = Alignment.bottomRight, this.shiftWithProgress = false, this.center = Alignment.center, this.radius = 0.8, this.pulseWithProgress = false});
  /// Gradient family to render.
  final BorderGradientType type;
  /// Gradient colours; null uses the token-derived default palette.
  final List<ThemedColor>? colors;
  /// Optional stops for [colors].
  final List<double>? stops;
  /// Sweep only: unpainted arc fraction (`0` = full ring).
  final double gap;
  /// Sweep only: rotates the gradient over time.
  final bool rotateWithProgress;
  /// Sweep only: start angle before runtime rotation.
  final double startAngle;
  /// Linear only: gradient begin alignment.
  final Alignment begin;
  /// Linear only: gradient end alignment.
  final Alignment end;
  /// Linear only: small animated alignment drift.
  final bool shiftWithProgress;
  /// Radial only: gradient centre alignment.
  final Alignment center;
  /// Radial only: base radius.
  final double radius;
  /// Radial only: animated radius pulsing.
  final bool pulseWithProgress;
  Shader createShader({required Rect bounds, required double progress, required List<Color> colors});
}
```
