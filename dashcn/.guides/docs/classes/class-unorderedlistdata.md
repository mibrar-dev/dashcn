---
title: "Class: UnorderedListData"
description: "Nesting depth for an unordered list, provided to descendants by the `li`  modifier."
---

```dart
/// Nesting depth for an unordered list, provided to descendants by the `li`
/// modifier.
class UnorderedListData {
  /// Creates list data at nesting level [depth] (0 = top level).
  const UnorderedListData({this.depth = 0});
  /// The nesting depth, 0 for a top-level list item.
  final int depth;
}
```
