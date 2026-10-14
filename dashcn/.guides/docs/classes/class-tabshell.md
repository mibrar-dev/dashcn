---
title: "Class: TabShell"
description: "Paints one folder tab: focused tabs merge into the content card through  the folder-tab ears; idle tabs get breathing room."
---

```dart
/// Paints one folder tab: focused tabs merge into the content card through
/// the folder-tab ears; idle tabs get breathing room.
class TabShell extends StatelessWidget {
  /// Creates a tab shell.
  const TabShell({super.key, required this.focused, required this.background, required this.borderColor, required this.borderWidth, required this.radius, required this.child});
  /// Whether this tab is focused.
  final bool focused;
  /// Card fill.
  final Color background;
  /// Border colour.
  final Color borderColor;
  /// Border width.
  final double borderWidth;
  /// Content radius shaping the folder ears.
  final BorderRadiusGeometry radius;
  /// Raw tab button.
  final Widget child;
  Widget build(BuildContext context);
}
```
