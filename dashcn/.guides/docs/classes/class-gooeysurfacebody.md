---
title: "Class: GooeySurfaceBody"
description: "Expanded body content with a 16px inner padding, measured through  [GooeyMeasure] so the surface can size its silhouette."
---

```dart
/// Expanded body content with a 16px inner padding, measured through
/// [GooeyMeasure] so the surface can size its silhouette.
class GooeySurfaceBody extends StatelessWidget {
  /// Creates body content.
  const GooeySurfaceBody({super.key, required this.width, required this.onSizeChanged, this.description, this.descriptionStyle, this.body, this.action});
  /// Surface width.
  final double width;
  /// Called when the laid-out body size changes.
  final ValueChanged<Size> onSizeChanged;
  /// Body text; ignored when [body] is set.
  final String? description;
  /// Body text style.
  final TextStyle? descriptionStyle;
  /// Custom body replacing [description] and [action].
  final Widget? body;
  /// Action widget below the description.
  final Widget? action;
  Widget build(BuildContext context);
}
```
