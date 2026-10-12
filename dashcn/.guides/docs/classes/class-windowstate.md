---
title: "Class: WindowState"
description: "Immutable configuration and runtime state of one window."
---

```dart
/// Immutable configuration and runtime state of one window.
class WindowState {
  /// Creates a window state.
  const WindowState({required this.bounds, this.maximized, this.minimized = false, this.alwaysOnTop = false, this.closable = true, this.resizable = true, this.draggable = true, this.maximizable = true, this.minimizable = true, this.enableSnapping = true, this.constraints = kDefaultWindowConstraints});
  /// Position and size, in navigator coordinates.
  final Rect bounds;
  /// Relative bounds while maximized, or null when restored.
  final Rect? maximized;
  /// Whether the window is minimized.
  final bool minimized;
  /// Whether the window stays above non-top windows.
  final bool alwaysOnTop;
  /// Whether the window can be closed.
  final bool closable;
  /// Whether the window can be resized by its edges.
  final bool resizable;
  /// Whether the window can be dragged by its title bar.
  final bool draggable;
  /// Whether the window can be maximized.
  final bool maximizable;
  /// Whether the window can be minimized.
  final bool minimizable;
  /// Whether dragging near the navigator edges snaps the window.
  final bool enableSnapping;
  /// Resize limits.
  final BoxConstraints constraints;
  /// Returns a copy with the given fields replaced.
  WindowState copyWith({Rect? bounds, bool? minimized, bool? alwaysOnTop, bool? closable, bool? resizable, bool? draggable, bool? maximizable, bool? minimizable, bool? enableSnapping, BoxConstraints? constraints});
  /// Returns a copy with [maximized] replaced (null restores the window).
  WindowState withMaximized(Rect? maximized);
  bool operator ==(Object other);
  int get hashCode;
}
```
