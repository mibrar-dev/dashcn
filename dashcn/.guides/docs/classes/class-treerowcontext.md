---
title: "Class: TreeRowContext"
description: "Everything one visible row needs from its tree, published by `Tree` through  a `Data<TreeRowContext>` scope."
---

```dart
/// Everything one visible row needs from its tree, published by `Tree` through
/// a `Data<TreeRowContext>` scope. [TreeRow] falls back to inert, unstyled
/// values outside a tree.
class TreeRowContext {
  /// Creates a row context.
  const TreeRowContext({required this.depth, this.branchLine, this.focusNode, this.theme, required this.expanded, required this.expandable, required this.selectionPosition, required this.onToggle, required this.onSelect});
  /// Indent guides from the root to this row (one entry per level).
  final List<TreeNodeDepth> depth;
  /// Guide style chosen by the tree; null falls back to the theme.
  final TreeBranchLine? branchLine;
  /// Focus node of the row, so tab/arrow traversal reaches it.
  final FocusNode? focusNode;
  /// Widget-leg theme override of the owning tree.
  final TreeTheme? theme;
  /// Whether the row shows its children.
  final bool expanded;
  /// Whether the row has children.
  final bool expandable;
  /// Where the row sits in a run of selected rows; null when unselected.
  final TreeSelectionPosition? selectionPosition;
  /// Expands or collapses the row.
  final ValueChanged<bool>? onToggle;
  /// Selects the row.
  final VoidCallback? onSelect;
}
```
