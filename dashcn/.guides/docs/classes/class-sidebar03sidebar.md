---
title: "Class: Sidebar03Sidebar"
description: "The sidebar panel: grouped navigation plus a storage meter."
---

```dart
/// The sidebar panel: grouped navigation plus a storage meter. Shared by the
/// desktop layout and the mobile drawer, so both stay identical.
class Sidebar03Sidebar extends StatelessWidget {
  /// Creates the sidebar panel.
  const Sidebar03Sidebar({super.key, this.selected = 0, this.onSelected});
  /// Index of the selected link; drives the highlight.
  final int selected;
  /// Called with the tapped link index; null leaves the panel static.
  final ValueChanged<int>? onSelected;
  Widget build(BuildContext context);
}
```
