---
title: "Class: FocusOutline"
description: "Draws an animated focus ring around [child] while [focused] is true."
---

```dart
/// Draws an animated focus ring around [child] while [focused] is true.
class FocusOutline extends StatelessWidget {
  /// The wrapped child.
  final Widget child;
  /// Whether the ring is shown.
  final bool focused;
  /// Corner radius of the ring. Defaults to the child's rectangular edge.
  final BorderRadiusGeometry? borderRadius;
  /// Extra distance between the child edge and the ring. Defaults to 3.
  final double? align;
  /// Ring border. Defaults to a 3px `ring`-colored border at half alpha.
  final Border? border;
  /// Ring shape. Defaults to [BoxShape.rectangle].
  final BoxShape? shape;
  /// Creates a [FocusOutline].
  const FocusOutline({super.key, required this.child, required this.focused, this.borderRadius, this.align, this.border, this.shape});
  Widget build(BuildContext context);
}
```
