---
title: "Class: Tree"
description: "A hierarchical list with expand/collapse and selection."
---

```dart
/// A hierarchical list with expand/collapse and selection.
///
/// The tree is immutable and controlled: it renders [nodes] and reports
/// changes through [onSelectionChanged] / [onExpandedChanged]; apply the
/// returned list with the `TreeNodeListExtension` operations.
///
/// ```dart
/// Tree<String>(
///   nodes: nodes,
///   builder: (context, item) => TreeRow(child: Text(item.data)),
///   onExpandedChanged: (node, expanded) => setState(() => _nodes =
///       expanded ? _nodes.expandNode(node) : _nodes.collapseNode(node)),
/// );
/// ```
///
/// When [allowMultiSelect] is on, the modifiers add the usual gestures. They
/// are read from the keyboard at press time, so a modifier released while the
/// focus moved cannot leave a gesture latched:
///
/// | Input | Gesture |
/// |---|---|
/// | click / <kbd>Space</kbd> | replace the selection with the row |
/// | <kbd>Ctrl</kbd>/<kbd>Cmd</kbd> + click | add or remove that one row |
/// | <kbd>Shift</kbd> + click | every row from the anchor to that one |
/// | <kbd>Shift</kbd> + <kbd>↑</kbd>/<kbd>↓</kbd> | extend the range, and move the focus |
/// | <kbd>Ctrl</kbd>/<kbd>Cmd</kbd> + <kbd>A</kbd> | every visible row |
///
/// The anchor is the last plain or Ctrl/Cmd click; a range click leaves it
/// where it is, so repeated <kbd>Shift</kbd> clicks grow and shrink the span.
class Tree<T> extends StatefulWidget {
  /// Creates a tree.
  const Tree({super.key, required this.nodes, required this.builder, this.onSelectionChanged, this.onExpandedChanged, this.allowMultiSelect = true, this.recursiveSelection = true, this.branchLine, this.padding, this.shrinkWrap = false, this.controller, this.focusNode, this.theme});
  /// The nodes to render, root level.
  final List<TreeNode<T>> nodes;
  /// Builds the content of one item.
  final Widget Function(BuildContext context, TreeItem<T> item) builder;
  /// Called when a row is activated.
  final TreeNodeSelectionChanged<T>? onSelectionChanged;
  /// Called when a row is expanded or collapsed.
  final TreeNodeExpandedChanged<T>? onExpandedChanged;
  /// Whether [onSelectionChanged] may report several nodes at once.
  ///
  /// When false every gesture collapses to a plain click: a <kbd>Shift</kbd> or
  /// <kbd>Ctrl</kbd> chord selects that one row and nothing else.
  final bool allowMultiSelect;
  /// Whether selecting a parent also selects its descendants.
  ///
  /// Range and select-all report the visible rows as they are; the subtree
  /// expansion only applies to a plain, toggle or range click on one row.
  final bool recursiveSelection;
  /// Guide style; falls back to the theme.
  final TreeBranchLine? branchLine;
  /// Padding around the tree; falls back to the theme.
  final EdgeInsetsGeometry? padding;
  /// Whether the list shrinks to its content.
  final bool shrinkWrap;
  /// Scroll controller for the list.
  final ScrollController? controller;
  /// Focus scope of the tree.
  final FocusScopeNode? focusNode;
  /// Widget-leg theme override, merged on top of the other legs.
  final TreeTheme? theme;
  State<Tree<T>> createState();
}
```
