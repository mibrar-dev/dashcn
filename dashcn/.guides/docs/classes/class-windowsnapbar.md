---
title: "Class: WindowSnapBar"
description: "Slides the preset bar in while a window is dragged near the top edge."
---

```dart
/// Slides the preset bar in while a window is dragged near the top edge.
///
/// Place it as the last child of a `Stack` covering the window host: it
/// renders a top strip (maximize target + bar reveal) plus the bar itself.
/// While the strip is hovered the dragged window snaps to full screen unless
/// the pointer moves onto a preset cell, which takes over the target.
class WindowSnapBar extends StatefulWidget {
  /// Creates the snap bar.
  const WindowSnapBar({super.key, required this.drag, required this.titleBarHeight, required this.viewportSize});
  /// Drag state of the host; the bar is only active while a drag is running.
  final WindowDragController drag;
  /// Height of the reveal strip along the top edge.
  final double titleBarHeight;
  /// Size of the host, used for the preset aspect ratio.
  final Size viewportSize;
  State<WindowSnapBar> createState();
}
```
