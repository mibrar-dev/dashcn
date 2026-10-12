---
title: "Class: Sidebar03Content"
description: "The sample screen inside the shell: stats, projects and activity."
---

```dart
/// The sample screen inside the shell: stats, projects and activity.
class Sidebar03Content extends StatelessWidget {
  /// Creates the content area.
  const Sidebar03Content({super.key, required this.selected});
  /// Index of the selected navigation link; drives the heading.
  final int selected;
  Widget build(BuildContext context);
}
```
