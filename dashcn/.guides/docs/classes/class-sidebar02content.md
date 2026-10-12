---
title: "Class: Sidebar02Content"
description: "The sample content area: stats, usage, files and activity."
---

```dart
/// The sample content area: stats, usage, files and activity.
class Sidebar02Content extends StatelessWidget {
  /// Creates the content area.
  const Sidebar02Content({super.key, required this.selected});
  /// Index of the selected navigation link; drives the heading.
  final int selected;
  Widget build(BuildContext context);
}
```
