---
title: "Class: WindowManager"
description: "Window management contract implemented by the `window` component's  navigator and exposed through [WindowViewport."
---

```dart
/// Window management contract implemented by the `window` component's
/// navigator and exposed through [WindowViewport.manager].
///
/// Window identities are the `Window` widgets themselves.
abstract class WindowManager {
  /// Drag/snap state of the current gesture.
  WindowDragController get drag;
  /// Adds [window] to the front.
  void push(Object window);
  /// Moves [window] to the front of its layer and focuses it.
  void focus(Object window);
  /// Drops the focused layer without reordering.
  void unfocus(Object window);
  /// Removes [window].
  void remove(Object window);
  /// Moves [window] between the normal and always-on-top layers.
  void setAlwaysOnTop(Object window, bool value);
  /// Whether [window] is the focused window of its layer.
  bool isFocused(Object window);
  /// All windows, top layer last.
  List<Object> get windows;
}
```
