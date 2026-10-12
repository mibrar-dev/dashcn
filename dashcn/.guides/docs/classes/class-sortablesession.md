---
title: "Class: SortableSession"
description: "One drag session owned by a [SortableLayer]."
---

```dart
/// One drag session owned by a [SortableLayer].
class SortableSession {
  /// Creates a session.
  SortableSession({required this.data, required this.size, required this.bounds, required this.ghost, required this.offset});
  /// The value being dragged.
  final Object data;
  /// The dragged item's size.
  final Size size;
  /// The dragged item's layer-space bounds.
  final DragBounds bounds;
  /// The widget rendered under the pointer.
  final Widget ghost;
  /// The current layer-space translation of the ghost.
  final ValueNotifier<Offset> offset;
}
```
