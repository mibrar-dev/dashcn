---
title: "Class: WindowController"
description: "Reactive controller for one window's [WindowState]."
---

```dart
/// Reactive controller for one window's [WindowState].
class WindowController extends ValueNotifier<WindowState> {
  /// Creates a controller.
  WindowController({required Rect bounds, Rect? maximized, bool minimized = false, bool alwaysOnTop = false, bool closable = true, bool resizable = true, bool draggable = true, bool maximizable = true, bool minimizable = true, bool enableSnapping = true, BoxConstraints constraints = kDefaultWindowConstraints});
  /// Current position and size.
  Rect get bounds;
  set bounds(Rect value);
  /// Relative bounds while maximized, or null.
  Rect? get maximized;
  /// Maximizes to [value] or restores with null.
  set maximized(Rect? value);
  bool get minimized;
  set minimized(bool value);
  bool get alwaysOnTop;
  set alwaysOnTop(bool value);
  bool get closable;
  set closable(bool value);
  bool get resizable;
  set resizable(bool value);
  bool get draggable;
  set draggable(bool value);
  bool get maximizable;
  set maximizable(bool value);
  bool get minimizable;
  set minimizable(bool value);
  bool get enableSnapping;
  set enableSnapping(bool value);
  BoxConstraints get constraints;
  set constraints(BoxConstraints value);
}
```
