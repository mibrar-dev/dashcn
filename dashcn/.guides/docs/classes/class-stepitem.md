---
title: "Class: StepItem"
description: "A step's title plus its content rows."
---

```dart
/// A step's title plus its content rows.
class StepItem extends StatelessWidget {
  /// Creates a step item.
  const StepItem({super.key, required this.title, required this.content});
  /// The step title, rendered as a level-4 heading.
  final Widget title;
  /// Content rows shown under the title.
  final List<Widget> content;
  Widget build(BuildContext context);
}
```
