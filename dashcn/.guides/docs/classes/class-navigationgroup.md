---
title: "Class: NavigationGroup"
description: "A labelled group of navigation items."
---

```dart
/// A labelled group of navigation items.
class NavigationGroup extends StatelessWidget implements NavigationBarItem {
  /// Creates a navigation group.
  const NavigationGroup({super.key, required this.label, this.children = const <Widget>[], this.labelPosition = NavigationLabelPosition.top, this.labelAlignment, this.labelPadding, this.labelOverflow = NavigationOverflow.clip});
  /// Group label.
  final Widget label;
  /// Group items.
  final List<Widget> children;
  /// Label position relative to the items.
  final NavigationLabelPosition labelPosition;
  /// Label alignment.
  final AlignmentGeometry? labelAlignment;
  /// Label padding.
  final EdgeInsetsGeometry? labelPadding;
  /// Label overflow behaviour.
  final NavigationOverflow labelOverflow;
  bool get selectable;
  Widget build(BuildContext context);
}
```
