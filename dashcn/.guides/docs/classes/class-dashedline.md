---
title: "Class: DashedLine"
description: "A horizontal dashed rule."
---

```dart
/// A horizontal dashed rule.
class DashedLine extends StatelessWidget {
  /// Creates a dashed rule.
  const DashedLine({super.key, this.width, this.gap, this.thickness, this.color});
  /// Length of one dash. Default: 8 times the ambient scaling.
  final double? width;
  /// Space between dashes. Default: 5 times the ambient scaling.
  final double? gap;
  /// Stroke thickness. Default: the ambient scaling.
  final double? thickness;
  /// Dash colour. Default: the `border` token.
  final ThemedColor? color;
  Widget build(BuildContext context);
}
```
