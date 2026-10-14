---
title: "Class: TreeNode"
description: "One node of a tree: children plus the expanded/selected flags."
---

```dart
/// One node of a tree: children plus the expanded/selected flags.
///
/// Immutable: [updateState] and [updateChildren] return a new node.
abstract class TreeNode<T> {
  /// Creates a node.
  const TreeNode();
  /// Children of this node; empty for a leaf.
  List<TreeNode<T>> get children;
  /// Whether the children are visible.
  bool get expanded;
  /// Whether the node is selected.
  bool get selected;
  /// Whether the node has no children.
  bool get leaf;
  /// Returns a copy with the given flags replaced.
  TreeNode<T> updateState({bool? expanded, bool? selected});
  /// Returns a copy with [children] replaced.
  TreeNode<T> updateChildren(List<TreeNode<T>> children);
}
```
