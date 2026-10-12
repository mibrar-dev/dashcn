---
title: "Class: DesignTokens"
description: "Non-color tokens for one brightness."
---

```dart
/// Non-color tokens for one brightness.
class DesignTokens {
  const DesignTokens({this.radius = 0.5, this.spacingBase = 4.0, this.trackingNormal = 0, this.trackingTight, this.trackingWide, this.shadows = defaultShadowScale});
  /// Unitless radius factor: the preset `radius` rem number (e.g. 0.625).
  /// `radiusLg` is its px value (`radius * 16`); `sm`/`md` step down
  /// 4/2 px and `xl` steps up 4 px from `lg` (upstream v4), clamped at 0.
  final double radius;
  /// Base spacing unit (preset `spacing.base`).
  final double spacingBase;
  /// Default letter spacing (preset `tracking.normal`).
  final double trackingNormal;
  /// Optional tighter tracking.
  final double? trackingTight;
  /// Optional wider tracking.
  final double? trackingWide;
  /// Elevation scale.
  final ShadowScale shadows;
  SpacingScale get spacing;
  TrackingScale get tracking;
  DesignTokens copyWith({double? radius, double? spacingBase, double? trackingNormal, double? Function()? trackingTight, double? Function()? trackingWide, ShadowScale? shadows});
  static DesignTokens lerp(DesignTokens a, DesignTokens b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
