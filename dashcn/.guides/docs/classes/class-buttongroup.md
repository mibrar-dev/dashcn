---
title: "Class: ButtonGroup"
description: "Arranges [children] as one connected control."
---

```dart
/// Arranges [children] as one connected control.
///
/// Wraps every child in a [ButtonGroupData] that flattens the shared inner
/// edges; children keep their own variants, sizes and states.
class ButtonGroup extends StatelessWidget {
  /// Creates a button group.
  const ButtonGroup({super.key, this.direction = Axis.horizontal, this.expands = false, required this.children});
  /// Creates a horizontal (row) button group.
  const ButtonGroup.horizontal({super.key, this.expands = false, required this.children});
  /// Creates a vertical (column) button group.
  const ButtonGroup.vertical({super.key, this.expands = false, required this.children});
  /// Layout direction of the group.
  final Axis direction;
  /// Whether the group takes the full main-axis extent of its parent.
  final bool expands;
  /// Buttons in visual order. First and last are rounded; the rest are not.
  final List<Widget> children;
  Widget build(BuildContext context);
}
```
