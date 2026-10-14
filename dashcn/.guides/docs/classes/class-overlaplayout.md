---
title: "Class: OverlapLayout"
description: "Lays out [child] and [overlap] so the overlap sits over [corner], then  aligns the whole union to [alignment] inside the incoming width."
---

```dart
/// Lays out [child] and [overlap] so the overlap sits over [corner], then
/// aligns the whole union to [alignment] inside the incoming width.
///
/// ```dart
/// OverlapLayout(
///   corner: OverlapCorner.bottomRight,
///   alignment: Alignment.centerRight,
///   gap: 8,
///   extraWidth: 8,
///   child: bubble,
///   overlap: const Text('👍 3'),
/// )
/// ```
class OverlapLayout extends MultiChildRenderObjectWidget {
  /// Creates an overlap layout with [child] first and [overlap] second.
  OverlapLayout({super.key, required this.child, required this.overlap, required this.corner, required this.alignment, this.gap = 8, this.extraWidth = 8});
  /// The primary child (a bubble, a card).
  final Widget child;
  /// The badge/chips hung over the corner.
  final Widget overlap;
  /// Corner the overlap hangs from.
  final OverlapCorner corner;
  /// Side of the incoming width the union is aligned to.
  final Alignment alignment;
  /// Distance kept between the overlap and the bubble's edges.
  final double gap;
  /// Extra width the primary child keeps when the overlap is wider than it.
  final double extraWidth;
  RenderObject createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, OverlapLayoutRender renderObject);
}
```
