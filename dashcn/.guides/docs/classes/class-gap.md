---
title: "Class: Gap"
description: "A widget that takes a fixed amount of space in the direction of its parent."
---

```dart
/// A widget that takes a fixed amount of space in the direction of its parent.
///
/// Works as a descendant of a [Row], [Column] or [Flex] (keeping only
/// stateless/stateful widgets in between) and inside a [Scrollable].
class Gap extends StatelessWidget {
  /// Creates a widget that takes a fixed [mainAxisExtent] of space.
  const Gap(this.mainAxisExtent, {super.key, this.crossAxisExtent, this.color});
  /// The amount of space this widget takes in the direction of its parent.
  final double mainAxisExtent;
  /// The amount of space this widget takes in the opposite direction.
  ///
  /// When null, the cross axis extent follows the parent constraints.
  final double? crossAxisExtent;
  /// The color used to fill the gap.
  final Color? color;
  Widget build(BuildContext context);
}
```
