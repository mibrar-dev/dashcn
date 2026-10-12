---
title: "Class: SortableLayer"
description: "Coordinates drag sessions between sortable items and renders the ghost."
---

```dart
/// Coordinates drag sessions between sortable items and renders the ghost.
///
/// On drop, the ghost glides to its landing position over [dropDuration]
/// (200ms by default) with [dropCurve] (`easeOut` by default) instead of
/// snapping. The settle is skipped when animations are disabled or
/// [dropDuration] is [Duration.zero].
class SortableLayer extends StatefulWidget {
  /// Creates a sortable layer.
  const SortableLayer({super.key, this.lock = false, this.clipBehavior, this.dropDuration, this.dropCurve, required this.child});
  /// Whether dragging is constrained to the layer bounds.
  final bool lock;
  /// Clip behaviour; defaults to `hardEdge` when [lock] is set.
  final Clip? clipBehavior;
  /// Drop settle duration; null resolves 200ms, `Duration.zero` disables it.
  final Duration? dropDuration;
  /// Drop settle curve; null resolves `Curves.easeOut`.
  final Curve? dropCurve;
  /// The subtree containing the sortable items.
  final Widget child;
  State<SortableLayer> createState();
}
```
