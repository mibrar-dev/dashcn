---
title: "Class: Transformers"
description: "Interpolation helpers for the built-in types, for use as a `lerp` argument."
---

```dart
/// Interpolation helpers for the built-in types, for use as a `lerp` argument.
class Transformers {
  /// Integer interpolation (rounds half away from zero like `lerpDouble`).
  static int? typeInt(int? a, int? b, double t);
  /// Double interpolation.
  static double? typeDouble(double? a, double? b, double t);
  /// Colour interpolation.
  static Color? typeColor(Color? a, Color? b, double t);
  /// Offset interpolation.
  static Offset? typeOffset(Offset? a, Offset? b, double t);
  /// Size interpolation.
  static Size? typeSize(Size? a, Size? b, double t);
  /// Rect interpolation.
  static Rect? typeRect(Rect? a, Rect? b, double t);
}
```
