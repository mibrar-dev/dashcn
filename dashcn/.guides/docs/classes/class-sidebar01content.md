---
title: "Class: Sidebar01Content"
description: "The sample content that sits next to the rail: stats, the mailbox and  recent activity."
---

```dart
/// The sample content that sits next to the rail: stats, the mailbox and
/// recent activity.
class Sidebar01Content extends StatelessWidget {
  /// Creates the content area.
  const Sidebar01Content({super.key, required this.selected});
  /// Index of the selected destination; drives the heading.
  final int selected;
  Widget build(BuildContext context);
}
```
