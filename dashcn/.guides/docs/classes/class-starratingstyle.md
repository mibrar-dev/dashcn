---
title: "Class: StarRatingStyle"
description: "Appearance of the star row: colours, size, spacing and star geometry."
---

```dart
/// Appearance of the star row: colours, size, spacing and star geometry.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class StarRatingStyle implements Mergeable<StarRatingStyle> {
  /// Creates a star rating style slice.
  const StarRatingStyle({this.activeColor, this.inactiveColor, this.size, this.spacing, this.points, this.pointRounding, this.valleyRounding, this.squash, this.innerRadiusRatio, this.rotation});
  /// Fill colour of the filled part of a star.
  final ThemedColor? activeColor;
  /// Colour of the unfilled part of a star.
  final ThemedColor? inactiveColor;
  /// Side length of one star.
  final double? size;
  /// Gap between two stars.
  final double? spacing;
  /// Number of star points.
  final double? points;
  /// Point rounding as a fraction of the star's size (0..1).
  final double? pointRounding;
  /// Valley rounding as a fraction of the star's size (0..1).
  final double? valleyRounding;
  /// Vertical compression (0 = natural, 1 = fully squashed).
  final double? squash;
  /// Inner-to-outer radius ratio (smaller = deeper valleys).
  final double? innerRadiusRatio;
  /// Rotation in *degrees* (the old field documented radians but handed the
  /// value to `StarBorder.rotation`, which is degrees).
  final double? rotation;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  StarRatingStyle merge(StarRatingStyle? fallback);
  /// Lerps scalar fields; colour references step at t < 0.5.
  static StarRatingStyle lerp(StarRatingStyle a, StarRatingStyle b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
