---
title: "Class: ResizablePanelGroup"
description: "A container of [ResizablePanel]s separated by [ResizableHandle]s."
---

```dart
/// A container of [ResizablePanel]s separated by [ResizableHandle]s.
class ResizablePanelGroup extends StatefulWidget {
  const ResizablePanelGroup({super.key, this.direction = Axis.horizontal, required this.children, this.theme});
  final Axis direction;
  final List<Widget> children;
  final ResizableTheme? theme;
  State<ResizablePanelGroup> createState();
}
```
