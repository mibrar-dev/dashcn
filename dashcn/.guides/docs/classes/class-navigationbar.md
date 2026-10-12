---
title: "Class: NavigationBar"
description: "A navigation container: horizontal bar, compact rail or sidebar."
---

```dart
/// A navigation container: horizontal bar, compact rail or sidebar.
class NavigationBar extends StatefulWidget {
  /// Creates a navigation container.
  const NavigationBar({super.key, required this.children, this.container = NavigationContainerType.bar, this.direction, this.alignment, this.spacing, this.labelType, this.labelPosition, this.labelSize, this.padding, this.constraints, this.index, this.onSelected, this.backgroundColor, this.expanded = true, this.header = const <Widget>[], this.footer = const <Widget>[], this.theme});
  /// The navigation items.
  final List<NavigationBarItem> children;
  final NavigationContainerType container;
  final Axis? direction;
  final MainAxisAlignment? alignment;
  final double? spacing;
  final NavigationLabelType? labelType;
  final NavigationLabelPosition? labelPosition;
  final NavigationLabelSize? labelSize;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  /// Selected item index.
  final int? index;
  /// Called with the selected item's index.
  final ValueChanged<int>? onSelected;
  final ThemedColor? backgroundColor;
  /// Whether labels follow the expanded state (`NavigationLabelType.expanded`).
  final bool expanded;
  final List<Widget> header;
  final List<Widget> footer;
  final NavigationBarTheme? theme;
  State<NavigationBar> createState();
}
```
