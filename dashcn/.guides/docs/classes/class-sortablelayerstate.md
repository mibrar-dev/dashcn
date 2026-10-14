---
title: "Class: SortableLayerState"
description: "State of [SortableLayer]."
---

```dart
/// State of [SortableLayer]. Public only so the `sortable` component can call
/// [pushSession], [removeSession] and [settle]; not part of the user API.
class SortableLayerState extends State<SortableLayer> with SingleTickerProviderStateMixin {
  void initState();
  void dispose();
  /// Adds [session] and renders its ghost.
  void pushSession(SortableSession session);
  /// Removes [session] and stops listening to it.
  void removeSession(SortableSession session);
  /// Settles [session] to [to] (a layer-space translation) and then removes it.
  ///
  /// When [animate] is false, animations are disabled or [dropDuration] is
  /// zero, the session is removed immediately.
  void settle(SortableSession session, Offset to, {required bool animate});
  Widget build(BuildContext context);
}
```
