---
title: "Class: Sortable"
description: "A draggable item that accepts drops on its four edges."
---

```dart
/// A draggable item that accepts drops on its four edges.
class Sortable<T> extends StatefulWidget {
  /// Creates a sortable item.
  const Sortable({super.key, this.enabled = true, required this.data, this.canAcceptTop, this.canAcceptLeft, this.canAcceptRight, this.canAcceptBottom, this.onAcceptTop, this.onAcceptLeft, this.onAcceptRight, this.onAcceptBottom, this.ghost, this.fallback, this.candidateFallback, this.onDragStart, this.onDragEnd, this.onDragCancel, this.behavior = HitTestBehavior.deferToChild, this.onDropFailed, required this.child});
  /// Whether drag interactions are enabled.
  final bool enabled;
  /// The value identifying this item.
  final SortableData<T> data;
  /// Whether a drop on the top edge is accepted.
  final Predicate<SortableData<T>>? canAcceptTop;
  /// Whether a drop on the left edge is accepted.
  final Predicate<SortableData<T>>? canAcceptLeft;
  /// Whether a drop on the right edge is accepted.
  final Predicate<SortableData<T>>? canAcceptRight;
  /// Whether a drop on the bottom edge is accepted.
  final Predicate<SortableData<T>>? canAcceptBottom;
  /// Called when data is dropped on the top edge.
  final ValueChanged<SortableData<T>>? onAcceptTop;
  /// Called when data is dropped on the left edge.
  final ValueChanged<SortableData<T>>? onAcceptLeft;
  /// Called when data is dropped on the right edge.
  final ValueChanged<SortableData<T>>? onAcceptRight;
  /// Called when data is dropped on the bottom edge.
  final ValueChanged<SortableData<T>>? onAcceptBottom;
  /// Widget rendered in the layer while dragging.
  final Widget? ghost;
  /// Widget shown in place of the child while dragging.
  final Widget? fallback;
  /// Widget shown when this item is the current drop candidate.
  final Widget? candidateFallback;
  /// Called when a drag starts.
  final VoidCallback? onDragStart;
  /// Called when a drag ends (after the accept callback).
  final VoidCallback? onDragEnd;
  /// Called when a drag is cancelled.
  final VoidCallback? onDragCancel;
  /// Hit-test behaviour of the drag gesture.
  final HitTestBehavior behavior;
  /// Called when a drop lands on no valid target.
  final VoidCallback? onDropFailed;
  /// The item content.
  final Widget child;
  State<Sortable<T>> createState();
}
```
