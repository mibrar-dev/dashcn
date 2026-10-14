---
title: "Class: SelectionToolbar"
description: "Cut / Copy / Paste / Select-all toolbar positioned at a selection anchor."
---

```dart
/// Cut / Copy / Paste / Select-all toolbar positioned at a selection anchor.
///
/// Placed by `EditableText.contextMenuBuilder` in the app overlay; the anchors
/// are global coordinates, which is what the overlay uses too.
class SelectionToolbar extends StatelessWidget {
  /// Creates a selection toolbar.
  const SelectionToolbar({super.key, required this.anchorAbove, required this.anchorBelow, required this.buttonItems});
  /// Preferred position (above the selection), in global coordinates.
  final Offset anchorAbove;
  /// Fallback position (below the selection), in global coordinates.
  final Offset anchorBelow;
  /// Items to render, usually [EditableTextState.contextMenuButtonItems].
  final List<ContextMenuButtonItem> buttonItems;
  Widget build(BuildContext context);
}
```
