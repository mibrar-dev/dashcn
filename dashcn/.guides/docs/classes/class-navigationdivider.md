---
title: "Class: NavigationDivider"
description: "A 1px rule between navigation items."
---

```dart
/// A 1px rule between navigation items.
class NavigationDivider extends StatelessWidget implements NavigationBarItem {
  /// Creates a navigation divider.
  const NavigationDivider({super.key, this.thickness, this.color});
  /// Line thickness; null resolves 1.
  final double? thickness;
  /// Line colour; null resolves the `muted` token.
  final Color? color;
  bool get selectable;
  Widget build(BuildContext context);
}
```
