---
title: "Class: ColorPickerCappedWidth"
description: "Caps [child] at [maxWidth] while reporting [maxWidth] as the max  intrinsic width."
---

```dart
/// Caps [child] at [maxWidth] while reporting [maxWidth] as the max
/// intrinsic width.
///
/// `Wrap.computeMaxIntrinsicWidth` sums its children without their `spacing`,
/// so a plain `ConstrainedBox`-capped `Wrap` would shrink-wrap short of its
/// one-line width and wrap a run early inside shrink-wrapping parents (the
/// picker dialogs and popovers size via `IntrinsicWidth`). This proxy gives
/// the honest answer while layout still passes the real (possibly narrower)
/// constraints through, so the controls `Wrap` reflows instead of
/// overflowing on phones. Not normally constructed directly.
class ColorPickerCappedWidth extends SingleChildRenderObjectWidget {
  /// Creates a cap of [maxWidth] around [child].
  const ColorPickerCappedWidth({super.key, required this.maxWidth, required super.child});
  /// The one-line width; the child never lays out wider than this.
  final double maxWidth;
  RenderObject createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, RenderObject renderObject);
}
```
