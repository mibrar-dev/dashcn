---
title: "Class: ScaleBackdropTransform"
description: "The default [BackdropTransform]: scales the backdrop down from `1."
---

```dart
/// The default [BackdropTransform]: scales the backdrop down from `1.0` to
/// [minScale] as the sheet opens and, for the root layer, clips its corners
/// with an animated radius.
///
/// This is the classic drawer "zoom-out" effect where the content shrinks
/// slightly to reveal the drawer sliding in from the edge.
class ScaleBackdropTransform extends BackdropTransform {
  /// Creates a scaling backdrop transform.
  const ScaleBackdropTransform({this.minScale = 0.95, this.cornerRadius});
  /// Scale applied when fully open.
  final double minScale;
  /// Corner radius the root backdrop clips to when fully open; null uses
  /// `radiusXxl` of the ambient theme.
  final double? cornerRadius;
  /// The scale factor at progress [t] (1.0 at `t = 0`, [minScale] at `t = 1`).
  double scaleAt(double t);
  Widget wrapBackdrop(BuildContext context, Widget child, double t, {bool isRoot = true});
  Size resolveExtraSize(Size size, double t, {bool isRoot = true});
}
```
