---
title: "Class: WindowHandle"
description: "The live handle a rendered window exposes to its chrome and actions."
---

```dart
/// The live handle a rendered window exposes to its chrome and actions.
abstract class WindowHandle {
  /// Current position and size.
  Rect get bounds;
  set bounds(Rect value);
  /// Relative bounds while maximized, or null.
  Rect? get maximized;
  set maximized(Rect? value);
  bool get minimized;
  set minimized(bool value);
  bool get closable;
  bool get resizable;
  bool get draggable;
  bool get maximizable;
  bool get minimizable;
  /// Whether this window currently has focus.
  bool get focused;
  /// Closes the window (removes it after its exit animation).
  void close();
}
```
