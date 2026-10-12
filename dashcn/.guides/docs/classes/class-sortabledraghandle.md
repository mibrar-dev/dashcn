---
title: "Class: SortableDragHandle"
description: "A drag handle that starts the parent [Sortable]'s drag."
---

```dart
/// A drag handle that starts the parent [Sortable]'s drag.
class SortableDragHandle extends StatelessWidget {
  /// Creates a drag handle.
  const SortableDragHandle({super.key, required this.child, this.enabled = true, this.behavior, this.cursor});
  /// The handle content.
  final Widget child;
  /// Whether the handle starts a drag.
  final bool enabled;
  /// Hit-test behaviour of the handle gesture.
  final HitTestBehavior? behavior;
  /// Mouse cursor when hovering the handle.
  final MouseCursor? cursor;
  Widget build(BuildContext context);
}
```
