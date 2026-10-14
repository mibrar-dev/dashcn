---
title: "Class: NavigationItem"
description: "One selectable navigation item, or an action when [onPressed] is set."
---

```dart
/// One selectable navigation item, or an action when [onPressed] is set.
///
/// ```dart
/// NavigationItem(child: Icon(RadixIcons.home), label: Text('Home'))
/// NavigationItem(child: Icon(RadixIcons.gear), onPressed: _openSettings)
/// ```
class NavigationItem extends StatelessWidget implements NavigationBarItem {
  /// Creates a navigation item.
  const NavigationItem({super.key, required this.child, this.label, this.index, this.selected, this.onChanged, this.onPressed, this.enabled, this.overflow = NavigationOverflow.ellipsis, this.style, this.activeStyle});
  final Widget child;
  final Widget? label;
  final int? index;
  final bool? selected;
  final ValueChanged<bool>? onChanged;
  final VoidCallback? onPressed;
  final bool? enabled;
  final NavigationOverflow overflow;
  final NavigationItemStyle? style;
  final NavigationItemStyle? activeStyle;
  bool get selectable;
  Widget build(BuildContext context);
}
```
