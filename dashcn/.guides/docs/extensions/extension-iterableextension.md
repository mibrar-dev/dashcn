---
title: "Extension: IterableExtension"
description: "Joins an iterable of widgets with [separator], keeping an [Iterable]."
---

```dart
/// Joins an iterable of widgets with [separator], keeping an [Iterable].
extension IterableExtension<T> on Iterable<T> {
  /// Returns a lazy iterable with [separator] inserted between every two
  /// items.
  Iterable<T> joinSeparator(T separator);
}
```
