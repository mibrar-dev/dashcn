---
title: "Class: NavigationGap"
description: "A fixed gap between navigation items (the old `NavigationGap`)."
---

```dart
/// A fixed gap between navigation items (the old `NavigationGap`).
class NavigationGap extends StatelessWidget implements NavigationBarItem {
  /// Creates a gap of [gap] logical pixels along the container's main axis.
  const NavigationGap(this.gap, {super.key});
  /// Gap size in logical pixels.
  final double gap;
  bool get selectable;
  Widget build(BuildContext context);
}
```
