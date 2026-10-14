---
title: "Class: TreeRow"
description: "The themed tree row: indent guides, the expand toggle and the selection  paint."
---

```dart
/// The themed tree row: indent guides, the expand toggle and the selection
/// paint. Wrap the `builder` result of a `Tree` in one of these:
/// `builder: (context, item) => TreeRow(child: Text(item.data))`.
class TreeRow extends StatelessWidget {
  /// Creates a row.
  const TreeRow({super.key, required this.child, this.leading, this.trailing, this.onDoublePressed, this.theme});
  /// Row content.
  final Widget child;
  /// Widget before the content.
  final Widget? leading;
  /// Widget after the content.
  final Widget? trailing;
  /// Called on a double tap of the row.
  final VoidCallback? onDoublePressed;
  /// Widget-leg theme override, merged on top of the other legs.
  final TreeTheme? theme;
  Widget build(BuildContext context);
}
```
