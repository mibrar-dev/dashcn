---
title: "Class: TreeNodeDepth"
description: "One level of the tree: a row's index among its siblings and the sibling  count."
---

```dart
/// One level of the tree: a row's index among its siblings and the sibling
/// count. The pair drives the branch lines.
class TreeNodeDepth {
  /// Creates a depth entry.
  const TreeNodeDepth(this.index, this.count);
  /// Index of the row among its siblings.
  final int index;
  /// Number of siblings at this level.
  final int count;
  /// Whether this is the last sibling.
  bool get isLast;
  bool operator ==(Object other);
  int get hashCode;
}
```
