---
title: "Class: WindowDragController"
description: "Drag and snap bookkeeping for one navigator."
---

```dart
/// Drag and snap bookkeeping for one navigator.
///
/// The navigator listens for rebuilds; the dragged window itself calls
/// [stop] on pan end and applies the returned strategy.
class WindowDragController extends ChangeNotifier {
  /// The window being dragged, or null.
  Object? get window;
  /// The snap target under the pointer, or null.
  WindowSnapStrategy? get strategy;
  /// Begins dragging [window] (clearing any hovered snap target).
  void start(Object window);
  /// Re-notifies listeners while the pointer moves.
  void update();
  /// Sets or clears the snap target under the pointer.
  void hover(WindowSnapStrategy? strategy);
  /// Ends the drag and returns the snap target to apply, if any.
  WindowSnapStrategy? stop();
}
```
