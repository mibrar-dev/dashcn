---
title: "Class: GridItemPickerLayout"
description: "Grid arrangement of picker items."
---

```dart
/// Grid arrangement of picker items.
class GridItemPickerLayout extends ItemPickerLayout {
  const GridItemPickerLayout({this.crossAxisCount = 4});
  final int crossAxisCount;
  Widget build<T>(BuildContext context, ItemChildDelegate<T> items, ItemPickerBuilder<T> builder);
}
```
