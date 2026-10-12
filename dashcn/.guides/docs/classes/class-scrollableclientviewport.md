---
title: "Class: ScrollableClientViewport"
description: "Viewport widget for [ScrollableClient] with two-dimensional scrolling."
---

```dart
/// Viewport widget for [ScrollableClient] with two-dimensional scrolling.
class ScrollableClientViewport extends TwoDimensionalViewport {
  /// Whether the offset may move past the content edges.
  final bool overscroll;
  /// Creates a viewport for a [ScrollableClient].
  const ScrollableClientViewport({super.key, required super.verticalOffset, required super.verticalAxisDirection, required super.horizontalOffset, required super.horizontalAxisDirection, required super.delegate, required super.mainAxis, super.scrollCacheExtent, super.clipBehavior = Clip.hardEdge, required this.overscroll});
  RenderTwoDimensionalViewport createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, RenderScrollableClientViewport renderObject);
}
```
