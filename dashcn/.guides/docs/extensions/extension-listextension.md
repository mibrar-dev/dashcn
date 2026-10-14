---
title: "Extension: ListExtension"
description: "List helpers used across the registry."
---

```dart
/// List helpers used across the registry.
extension ListExtension<T> on List<T> {
  /// Moves [element] to [targetIndex], inserting it when absent.
  bool swapItem(T element, int targetIndex);
}
```
