---
title: "Class: ColorFieldSlider"
description: "A rounded colour-field surface with a drag cursor."
---

```dart
/// A rounded colour-field surface with a drag cursor.
class ColorFieldSlider extends StatefulWidget {
  /// Creates a colour-field surface.
  const ColorFieldSlider({super.key, required this.x, required this.y, required this.child, required this.cursorFillColor, required this.cursorRingColor, required this.cursorSize, required this.cursorWidth, required this.radius, required this.padding, required this.singleChannel, this.reverse = false, this.enabled = true, this.onPosition, this.onCommit, this.focusNode, this.autofocus = false});
  /// Cursor x in `[0, 1]` (horizontal axis).
  final double x;
  /// Cursor y in `[0, 1]` (vertical axis).
  final double y;
  /// The gradient painted behind the cursor.
  final Widget child;
  /// Fill colour of the drag cursor (the current value's colour).
  final Color cursorFillColor;
  /// Ring colour of the drag cursor.
  final Color cursorRingColor;
  /// Bar thickness / circle diameter of the cursor.
  final double cursorSize;
  /// Width of the cursor ring.
  final double cursorWidth;
  /// Corner radius of the clipped gradient and bar cursor.
  final Radius radius;
  /// Inset between the gradient edge and the cursor bar.
  final EdgeInsets padding;
  /// True for a single-channel bar: reversed bars run horizontally,
  /// otherwise the bar runs horizontally and moves vertically.
  final bool singleChannel;
  /// Swaps the bar orientation for [singleChannel] fields.
  final bool reverse;
  /// Whether gestures and keys are accepted.
  final bool enabled;
  /// Called for every tap/drag keyboard position change (not the final one).
  final ColorFieldPositionCallback? onPosition;
  /// Called on tap/drag end with the last emitted position already applied.
  final VoidCallback? onCommit;
  /// Focus node; one is created internally when null and [autofocus].
  final FocusNode? focusNode;
  /// Request focus on first build.
  final bool autofocus;
  State<ColorFieldSlider> createState();
}
```
