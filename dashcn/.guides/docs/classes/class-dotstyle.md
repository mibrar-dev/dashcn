---
title: "Class: DotStyle"
description: "One dot's state-aware styling slice."
---

```dart
/// One dot's state-aware styling slice.
class DotStyle implements Mergeable<DotStyle> {
  /// Creates a dot style.
  const DotStyle({this.background, this.borderColor, this.borderWidth, this.size, this.borderRadius});
  /// Per-state fill of the dot.
  final StateValue<ThemedColor>? background;
  /// Per-state outline; null draws no border.
  final StateValue<ThemedColor>? borderColor;
  /// Outline width used when [borderColor] resolves.
  final double? borderWidth;
  /// Diameter; null resolves `12 * scaling`.
  final double? size;
  /// Corner radius; null resolves a full circle.
  final BorderRadiusGeometry? borderRadius;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  DotStyle merge(DotStyle? fallback);
  /// State scales step at t < 0.5; dimensions lerp.
  static DotStyle lerp(DotStyle a, DotStyle b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
