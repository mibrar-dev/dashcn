---
title: "Class: SpacingScale"
description: "Spacing scale derived from one base unit (preset `spacing."
---

```dart
/// Spacing scale derived from one base unit (preset `spacing.base`).
class SpacingScale {
  const SpacingScale(this.base);
  /// Base spacing unit.
  final double base;
  double get xs;
  double get sm;
  double get md;
  double get lg;
  double get xl;
  double get xxl;
  SpacingScale copyWith({double? base});
  static SpacingScale lerp(SpacingScale a, SpacingScale b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
