---
title: "Extension: TreeNodeListExtension"
description: "The immutable operations a tree needs: every method returns a new list."
---

```dart
/// The immutable operations a tree needs: every method returns a new list.
///
/// [updateNodes] is the general primitive every other method is built on, so a
/// caller whose operation is not listed here is one call away.
extension TreeNodeListExtension<T> on List<TreeNode<T>> {
  /// Applies [transform] to every node, depth first; null removes it.
  ///
  /// Returns the receiver when nothing changed, so callers can skip a rebuild.
  List<TreeNode<T>> updateNodes(TreeNodeUnaryOperator<T> transform);
  /// Expands every node.
  List<TreeNode<T>> expandAll();
  /// Collapses every node.
  List<TreeNode<T>> collapseAll();
  /// Expands [target].
  List<TreeNode<T>> expandNode(TreeNode<T> target);
  /// Collapses [target].
  List<TreeNode<T>> collapseNode(TreeNode<T> target);
  /// Replaces the selection with [targets].
  List<TreeNode<T>> setSelectedNodes(Iterable<TreeNode<T>> targets);
  /// Flips the selection flag of [target], keeping every other flag.
  ///
  /// The toggle half of Ctrl/Cmd-click: adding or removing one row without
  /// disturbing the rest of the selection.
  List<TreeNode<T>> toggleSelectedNode(TreeNode<T> target);
  /// The selected nodes, depth first.
  List<TreeNode<T>> get selectedNodes;
  /// The data of every selected [TreeItem], depth first.
  List<T> get selectedItems;
}
```
