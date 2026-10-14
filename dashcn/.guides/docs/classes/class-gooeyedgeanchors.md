---
title: "Class: GooeyEdgeAnchors"
description: "Resolved screen anchors of one gooey toast."
---

```dart
/// Resolved screen anchors of one gooey toast.
///
/// Exactly one horizontal (left/right) and one vertical (top/bottom) anchor is
/// set; the other of each pair is null so the toast keeps its intrinsic size on
/// that axis.
class GooeyEdgeAnchors {
  /// Creates anchors.
  const GooeyEdgeAnchors({this.left, this.right, this.top, this.bottom});
  /// Anchors for [placement] inside [viewport].
  ///
  /// `leading`/`trailing` resolve through [textDirection] so an RTL layout
  /// mirrors the horizontal anchor. A horizontally centred toast spans the full
  /// width and is centred by its child's alignment, never by a left inset.
  factory GooeyEdgeAnchors.resolve({required ToastPlacement placement, required double width, required Size viewport, required TextDirection textDirection, double inset = kGooeyEdgeInset});
  /// Left inset, or null when the toast anchors right.
  final double? left;
  /// Right inset, or null when the toast anchors left or centre.
  final double? right;
  /// Top inset, or null when the toast anchors to the bottom.
  final double? top;
  /// Bottom inset, or null when the toast anchors to the top.
  final double? bottom;
}
```
