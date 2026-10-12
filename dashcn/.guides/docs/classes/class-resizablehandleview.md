---
title: "Class: ResizableHandleView"
description: "The interactive region of a resizable divider."
---

```dart
/// The interactive region of a resizable divider. The owning component
/// positions it over the 1px divider line.
class ResizableHandleView extends StatefulWidget {
  /// Creates a handle view.
  const ResizableHandleView({super.key, required this.axis, required this.enabled, required this.withHandle, required this.gripColor, required this.gripSize, required this.active, required this.semanticsLabel, required this.onHoverChanged, required this.onStep, required this.onEdge, required this.onDragStart, required this.onDragUpdate, required this.onDragEnd, required this.onDragCancel, this.cursor, this.focusNode, this.autofocus = false});
  /// The group axis (arrow keys map to it).
  final Axis axis;
  /// Whether the handle responds to drags and keyboard focus.
  final bool enabled;
  /// Whether the grip bar is drawn.
  final bool withHandle;
  /// Grip colour.
  final Color gripColor;
  /// Grip size for a horizontal group.
  final Size gripSize;
  /// Whether the handle is hovered or dragged (highlights the grip).
  final bool active;
  /// Semantics label.
  final String semanticsLabel;
  /// Called when the hover state changes.
  final ValueChanged<bool> onHoverChanged;
  /// Called with a pixel step along the main axis.
  final ValueChanged<double> onStep;
  /// Called with `true` for the end extreme, `false` for the start.
  final ValueChanged<bool> onEdge;
  /// Called when a drag starts.
  final VoidCallback onDragStart;
  /// Called with the drag delta along the main axis.
  final ValueChanged<double> onDragUpdate;
  /// Called when a drag ends.
  final VoidCallback onDragEnd;
  /// Called when a drag is cancelled.
  final VoidCallback onDragCancel;
  /// Mouse cursor override.
  final MouseCursor? cursor;
  /// Focus node override.
  final FocusNode? focusNode;
  /// Whether the handle autofocuses.
  final bool autofocus;
  State<ResizableHandleView> createState();
}
```
