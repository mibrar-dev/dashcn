---
title: "Class: TrackingScale"
description: "Letter-spacing scale (preset `tracking."
---

```dart
/// Letter-spacing scale (preset `tracking.*`).
class TrackingScale {
  const TrackingScale({this.normal = 0, this.tight, this.wide});
  /// Default letter spacing.
  final double normal;
  /// Optional tighter variant.
  final double? tight;
  /// Optional wider variant.
  final double? wide;
  TrackingScale copyWith({double? normal, double? Function()? tight, double? Function()? wide});
  static TrackingScale lerp(TrackingScale a, TrackingScale b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
