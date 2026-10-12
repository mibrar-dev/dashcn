---
title: "Class: FileDiffSurface"
description: "Resolved colours, geometry and text style for one diff viewer build."
---

```dart
/// Resolved colours, geometry and text style for one diff viewer build.
class FileDiffSurface {
  const FileDiffSurface({required this.background, required this.border, required this.headerBackground, required this.hunkBackground, required this.addition, required this.deletion, required this.radius, required this.lineRadius, required this.linePadding, required this.gutterWidth, required this.gutterFill, required this.codeStyle});
  /// Surface, frame, header and hunk fills.
  final Color background;
  final Color border;
  final Color headerBackground;
  final Color hunkBackground;
  /// Addition and deletion accents (also drive the stat badges at a
  /// multiplied alpha).
  final Color addition;
  final Color deletion;
  /// Outer radius and per-line radius.
  final BorderRadius radius;
  final BorderRadius lineRadius;
  /// Padding of every row; the file header uses the horizontal value with
  /// a little more breathing room.
  final EdgeInsetsGeometry linePadding;
  final double gutterWidth;
  final Color gutterFill;
  final TextStyle codeStyle;
  /// Fill for a line of [type]; null for context/hunk rows.
  Color? lineFill(FileDiffLineType type);
  /// Accent for a line of [type]; null when the row is not coloured.
  Color? lineAccent(FileDiffLineType type);
}
```
