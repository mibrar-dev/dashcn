---
title: "Class: TripleDots"
description: "A row or column of evenly spaced dots."
---

```dart
/// A row or column of evenly spaced dots.
///
/// ```dart
/// const TripleDots();                       // horizontal, 3 dots
/// const TripleDots(count: 4, direction: Axis.vertical);
/// ```
class TripleDots extends StatelessWidget {
  /// Creates a dots widget.
  const TripleDots({super.key, this.count = 3, this.direction = Axis.horizontal, this.size, this.spacing, this.color, this.padding, this.theme});
  /// Number of dots.
  final int count;
  /// Layout direction of the dots.
  final Axis direction;
  /// Dot diameter override.
  final double? size;
  /// Gap between dots override.
  final double? spacing;
  /// Dot colour override.
  final Color? color;
  /// Padding around the whole run.
  final EdgeInsetsGeometry? padding;
  /// Widget-leg theme override, merged on top of the other legs.
  final TripleDotsTheme? theme;
  Widget build(BuildContext context);
}
```
