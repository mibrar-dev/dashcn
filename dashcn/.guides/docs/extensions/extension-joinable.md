---
title: "Extension: Joinable"
description: "Joins a list of widgets with [separator], keeping a [List] result."
---

```dart
/// Joins a list of widgets with [separator], keeping a [List] result.
extension Joinable<T extends Widget> on List<T> {
  /// Returns a new list with [separator] inserted between every two items.
  List<T> joinSeparator(T separator);
}
```
