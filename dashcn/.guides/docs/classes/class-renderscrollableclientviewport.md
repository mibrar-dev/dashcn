---
title: "Class: RenderScrollableClientViewport"
description: "Render object for [ScrollableClientViewport]."
---

```dart
/// Render object for [ScrollableClientViewport].
///
/// The single child is laid out at the viewport size and translated by the
/// (clamped) offset; both offsets get the content dimensions of that child.
class RenderScrollableClientViewport extends RenderTwoDimensionalViewport {
  /// Whether the offset may move past the content edges.
  bool get overscroll;
  set overscroll(bool value);
  /// Creates a render object for a [ScrollableClientViewport].
  RenderScrollableClientViewport({required super.horizontalOffset, required super.horizontalAxisDirection, required super.verticalOffset, required super.verticalAxisDirection, required super.delegate, required super.mainAxis, required super.childManager, super.scrollCacheExtent, super.clipBehavior = Clip.hardEdge, required this._overscroll});
  void layoutChildSequence();
}
```
