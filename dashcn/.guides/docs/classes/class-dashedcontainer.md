---
title: "Class: DashedContainer"
description: "A rounded-rectangle border painted as dashes."
---

```dart
/// A rounded-rectangle border painted as dashes.
class DashedContainer extends StatelessWidget {
  /// Creates a dashed border around [child].
  const DashedContainer({super.key, this.strokeWidth, this.gap, this.thickness, this.color, this.borderRadius, required this.child});
  /// Length of one dash. Default: 8 times the ambient scaling.
  final double? strokeWidth;
  /// Space between dashes. Default: 5 times the ambient scaling.
  final double? gap;
  /// Stroke thickness. Default: the ambient scaling.
  final double? thickness;
  /// Dash colour. Default: the `border` token.
  final ThemedColor? color;
  /// Corner radius. Default: the ambient `borderRadiusLg`.
  final BorderRadiusGeometry? borderRadius;
  /// The child inside the dashed border.
  final Widget child;
  Widget build(BuildContext context);
}
```
