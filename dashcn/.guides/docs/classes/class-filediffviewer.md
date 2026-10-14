---
title: "Class: FileDiffViewer"
description: "A file diff viewer with unified and split layouts."
---

```dart
/// A file diff viewer with unified and split layouts.
class FileDiffViewer extends StatefulWidget {
  /// Creates a file diff viewer.
  const FileDiffViewer({super.key, required this.files, this.layout = FileDiffLayout.unified, this.showFileHeaders = true, this.showLineNumbers = true, this.collapseUnchanged = true, this.showCopyAction = true, this.maxHeight, this.minContentWidth = 720.0, this.theme});
  /// Files rendered by the viewer, and the layout mode.
  final List<FileDiff> files;
  final FileDiffLayout layout;
  final bool showFileHeaders;
  final bool showLineNumbers;
  final bool collapseUnchanged;
  final bool showCopyAction;
  final double? maxHeight;
  final double minContentWidth;
  /// Widget-leg theme override, merged on top of the other legs.
  final FileDiffViewerTheme? theme;
  State<FileDiffViewer> createState();
}
```
