---
title: "Class: ResizableHandle"
description: "A draggable divider between two resizable panes."
---

```dart
/// A draggable divider between two resizable panes.
///
/// The default is a 1px themed line with an enlarged hit area. Set
/// [withHandle] to draw a grip bar; the handle is focusable and moves with the
/// arrow keys (10px steps, Home/End to the extremes).
class ResizableHandle extends StatelessWidget {
  /// Creates a handle.
  const ResizableHandle({super.key, this.withHandle = false, this.enabled = true, this.thickness, this.hitThickness, this.color, this.gripColor, this.gripSize, this.cursor, this.focusNode, this.autofocus = false});
  /// Whether to draw the grip bar.
  final bool withHandle;
  /// Whether the handle responds to drags and keyboard focus.
  final bool enabled;
  /// Divider line thickness; null resolves the theme default.
  final double? thickness;
  /// Gesture hit-area thickness; null resolves the theme default.
  final double? hitThickness;
  /// Divider colour override.
  final ThemedColor? color;
  /// Grip colour override.
  final ThemedColor? gripColor;
  /// Grip size for a horizontal group.
  final Size? gripSize;
  /// Mouse cursor override.
  final MouseCursor? cursor;
  /// Focus node override.
  final FocusNode? focusNode;
  /// Whether the handle autofocuses.
  final bool autofocus;
  Widget build(BuildContext context);
}
```
