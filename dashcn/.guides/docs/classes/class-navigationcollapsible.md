---
title: "Class: NavigationCollapsible"
description: "A navigation item that expands to reveal nested items."
---

```dart
/// A navigation item that expands to reveal nested items.
class NavigationCollapsible extends StatefulWidget implements NavigationBarItem {
  /// Creates a collapsible navigation item.
  const NavigationCollapsible({super.key, required this.label, required this.children, this.leading, this.expanded, this.initialExpanded = false, this.onExpandedChanged, this.selected, this.onChanged, this.enabled, this.childIndent, this.overflow = NavigationOverflow.ellipsis});
  final Widget label;
  final List<Widget> children;
  final Widget? leading;
  final bool? expanded;
  final bool initialExpanded;
  final ValueChanged<bool>? onExpandedChanged;
  final bool? selected;
  final ValueChanged<bool>? onChanged;
  final bool? enabled;
  final double? childIndent;
  final NavigationOverflow overflow;
  bool get selectable;
  State<NavigationCollapsible> createState();
}
```
