---
title: "Class: NavigationBarItem"
description: "A widget that can live in a `NavigationBar`."
---

```dart
/// A widget that can live in a `NavigationBar`.
abstract class NavigationBarItem extends Widget {
  /// Creates a navigation bar item.
  const NavigationBarItem({super.key});
  /// Whether the container numbers this child for index-based selection.
  bool get selectable;
}
```
