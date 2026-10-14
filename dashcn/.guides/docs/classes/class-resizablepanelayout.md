---
title: "Class: ResizablePaneLayout"
description: "Builds and applies the resizer engine's items for a list of handles."
---

```dart
/// Builds and applies the resizer engine's items for a list of handles.
class ResizablePaneLayout {
  /// Creates a layout over [handles].
  ResizablePaneLayout(this.handles);
  /// The managed panes.
  final List<ResizablePaneHandle> handles;
  /// The current engine items for [flexSpace].
  List<ResizableItem> items(double flexSpace);
  /// Applies committed [items] back onto the controllers.
  void apply(List<ResizableItem> items, double flexSpace);
}
```
