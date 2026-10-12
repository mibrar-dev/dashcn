---
title: "Class: ItemList"
description: "Delegate over a fixed list of items."
---

```dart
/// Delegate over a fixed list of items.
class ItemList<T> extends ItemChildDelegate<T> {
  const ItemList(this.items);
  final List<T> items;
  int get itemCount;
  T operator [](int index);
}
```
