---
title: "Class: TreeItem"
description: "A data-bearing tree node."
---

```dart
/// A data-bearing tree node.
class TreeItem<T> extends TreeNode<T> {
  /// Creates a node.
  const TreeItem({required this.data, this.children = const <Never>[], this.expanded = false, this.selected = false});
  /// The payload this node shows.
  final T data;
  final List<TreeNode<T>> children;
  final bool expanded;
  final bool selected;
  TreeItem<T> updateState({bool? expanded, bool? selected});
  TreeItem<T> updateChildren(List<TreeNode<T>> children);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
