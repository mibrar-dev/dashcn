---
title: "Class: WindowNavigator"
description: "Hosts a set of [Window]s: z-order, focus and edge snapping."
---

```dart
/// Hosts a set of [Window]s: z-order, focus and edge snapping.
class WindowNavigator extends StatelessWidget {
  /// Creates a window navigator.
  const WindowNavigator({super.key, required this.initialWindows, this.child, this.theme, this.showTopSnapBar = true});
  /// Windows to show on first build.
  final List<Window> initialWindows;
  /// Background content behind every window.
  final Widget? child;
  final WindowTheme? theme;
  /// Whether the top preset snap bar is shown while dragging.
  final bool showTopSnapBar;
  Widget build(BuildContext context);
}
```
