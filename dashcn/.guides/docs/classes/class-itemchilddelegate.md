---
title: "Class: ItemChildDelegate"
description: "Source of the items an item picker shows."
---

```dart
/// Source of the items an item picker shows.
abstract class ItemChildDelegate<T> {
  const ItemChildDelegate();
  /// Total number of items, or null if infinite or unknown.
  int? get itemCount;
  /// Item at [index], or null if unavailable.
  T? operator [](int index);
}
```
