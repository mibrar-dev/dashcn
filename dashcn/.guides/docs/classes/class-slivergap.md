---
title: "Class: SliverGap"
description: "A sliver that takes a fixed amount of space."
---

```dart
/// A sliver that takes a fixed amount of space.
class SliverGap extends LeafRenderObjectWidget {
  /// Creates a sliver that takes a fixed [mainAxisExtent] of space.
  const SliverGap(this.mainAxisExtent, {super.key, this.color});
  /// The amount of space this widget takes in the direction of the parent.
  final double mainAxisExtent;
  /// The color used to fill the gap.
  final Color? color;
  RenderObject createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, RenderSliverGap renderObject);
  void debugFillProperties(DiagnosticPropertiesBuilder properties);
}
```
