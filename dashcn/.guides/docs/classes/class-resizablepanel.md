---
title: "Class: ResizablePanel"
description: "Configuration for one pane inside a [ResizablePanelGroup]."
---

```dart
/// Configuration for one pane inside a [ResizablePanelGroup].
class ResizablePanel extends StatelessWidget {
  const ResizablePanel({super.key, required this.child, this.defaultSize, this.flex, this.minSize, this.maxSize, this.collapsedSize, this.collapsed = false, this.controller});
  final Widget child;
  final double? defaultSize;
  final double? flex;
  final double? minSize;
  final double? maxSize;
  final double? collapsedSize;
  final bool collapsed;
  final ResizablePaneController? controller;
  Widget build(BuildContext context);
}
```
