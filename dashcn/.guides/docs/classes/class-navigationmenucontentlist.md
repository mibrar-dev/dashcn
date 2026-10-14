---
title: "Class: NavigationMenuContentList"
description: "Grid of content entries; rows share equal-width columns."
---

```dart
/// Grid of content entries; rows share equal-width columns.
class NavigationMenuContentList extends StatelessWidget {
  const NavigationMenuContentList({super.key, required this.children, this.crossAxisCount = 3, this.spacing, this.runSpacing, this.reverse = false});
  final List<Widget> children;
  final int crossAxisCount;
  final double? spacing;
  final double? runSpacing;
  /// Whether to reverse the order (for RTL).
  final bool reverse;
  Widget build(BuildContext context);
}
```
