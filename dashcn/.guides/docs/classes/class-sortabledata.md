---
title: "Class: SortableData"
description: "Wraps a value so a sortable item can be identified during a drag."
---

```dart
/// Wraps a value so a sortable item can be identified during a drag.
class SortableData<T> {
  /// Creates sortable data.
  const SortableData(this.data);
  /// The wrapped value.
  final T data;
}
```
