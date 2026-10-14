---
title: "Class: ToastSlotColumn"
description: "The ordered column of one toast slot: the newest entry sits nearest the  anchor, each unit carries its own gap (so a collapse takes the gap with it)  and is wrapped in a [ToastExitTransition]."
---

```dart
/// The ordered column of one toast slot: the newest entry sits nearest the
/// anchor, each unit carries its own gap (so a collapse takes the gap with it)
/// and is wrapped in a [ToastExitTransition].
class ToastSlotColumn<T> extends StatelessWidget {
  /// Creates a slot column.
  const ToastSlotColumn({super.key, required this.queue, required this.entries, required this.placement, required this.cardBuilder, this.gap = 8, this.collapse = false});
  /// Queue that owns the entries.
  final ToastQueue<T> queue;
  /// Live entries of the slot.
  final List<ToastEntry<T>> entries;
  /// Where the slot is anchored.
  final ToastPlacement placement;
  /// Builds one card; the exit transition and gap are added here.
  final Widget Function(BuildContext context, ToastEntry<T> entry) cardBuilder;
  /// Gap between stacked cards.
  final double gap;
  /// Whether exiting cards also collapse their vertical extent.
  final bool collapse;
  Widget build(BuildContext context);
}
```
