---
title: "Class: Sidebar02Panel"
description: "The inset sidebar panel: product mark, live-filter search, grouped  navigation and the user row."
---

```dart
/// The inset sidebar panel: product mark, live-filter search, grouped
/// navigation and the user row. Shared by the desktop layout and the mobile
/// drawer, so both stay identical.
class Sidebar02Panel extends StatefulWidget {
  /// Creates the panel.
  const Sidebar02Panel({super.key, required this.selected, required this.onSelected});
  /// Index of the selected link across both groups.
  final int selected;
  /// Called with the tapped link index.
  final ValueChanged<int> onSelected;
  State<Sidebar02Panel> createState();
}
```
