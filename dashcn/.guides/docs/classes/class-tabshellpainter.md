---
title: "Class: TabShellPainter"
description: "Folder-tab painter behind [TabShell]: fills the focused tab and strokes  its open outline so it reads as one surface with the content card below."
---

```dart
/// Folder-tab painter behind [TabShell]: fills the focused tab and strokes
/// its open outline so it reads as one surface with the content card below.
class TabShellPainter extends CustomPainter {
  /// Creates a tab shell painter.
  TabShellPainter({required this.borderRadius, required this.backgroundColor, required this.borderColor, required this.borderWidth});
  /// Content radius shaping the folder ears.
  final BorderRadius borderRadius;
  /// Fill of the focused tab.
  final Color backgroundColor;
  /// Outline colour.
  final Color borderColor;
  /// Outline width.
  final double borderWidth;
  bool shouldRepaint(covariant TabShellPainter old);
  void paint(Canvas canvas, Size size);
}
```
