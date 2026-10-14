---
title: "Class: WindowViewport"
description: "The data a [WindowManager] passes down to each rendered window."
---

```dart
/// The data a [WindowManager] passes down to each rendered window.
class WindowViewport {
  /// Creates a viewport.
  const WindowViewport({required this.size, required this.manager, required this.focused, required this.alwaysOnTop, required this.minify, required this.ignorePointer});
  /// Size of the visible navigator area.
  final Size size;
  /// The navigator managing this window.
  final WindowManager manager;
  /// Whether this window is the focused one in its layer.
  final bool focused;
  /// Whether this window is in the always-on-top layer.
  final bool alwaysOnTop;
  /// Whether the window shrinks for a snap preview.
  final bool minify;
  /// Whether pointer events are ignored (the window is being dragged).
  final bool ignorePointer;
  bool operator ==(Object other);
  int get hashCode;
}
```
