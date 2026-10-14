---
title: "Class: ItemPickerLayout"
description: "How an item picker arranges its items."
---

```dart
/// How an item picker arranges its items.
abstract class ItemPickerLayout {
  /// Vertical scrolling list.
  static const ListItemPickerLayout list = ListItemPickerLayout();
  /// Scrollable grid, 4 columns by default.
  static const GridItemPickerLayout grid = GridItemPickerLayout();
  const ItemPickerLayout();
  Widget build<T>(BuildContext context, ItemChildDelegate<T> items, ItemPickerBuilder<T> builder);
}
```
