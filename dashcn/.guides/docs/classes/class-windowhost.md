---
title: "Class: WindowHost"
description: "Hosts [ManagedWindow]s; each positions itself from [WindowViewport]."
---

```dart
/// Hosts [ManagedWindow]s; each positions itself from [WindowViewport].
class WindowHost extends StatefulWidget {
  const WindowHost({super.key, required this.initialWindows, this.background, this.titleBarHeight = 32, this.showTopSnapBar = true, this.snapOverlayBuilder});
  final List<ManagedWindow> initialWindows;
  final Widget? background;
  final double titleBarHeight;
  /// Whether the top preset bar is shown while dragging.
  final bool showTopSnapBar;
  final WidgetBuilder? snapOverlayBuilder;
  State<WindowHost> createState();
}
```
