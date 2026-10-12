---
title: "Class: StepperIndicator"
description: "The numbered ring of one step, public so a custom stepper layout can  reuse it."
---

```dart
/// The numbered ring of one step, public so a custom stepper layout can
/// reuse it.
class StepperIndicator extends StatelessWidget {
  /// Creates an indicator.
  const StepperIndicator({super.key, required this.index, required this.phase, required this.style, required this.size, this.icon, this.textStyle, this.iconTheme, this.onPressed, this.focusNode});
  /// Zero-based step index, used for the number.
  final int index;
  /// Which glyph the ring paints.
  final StepperPhase phase;
  /// Ring colours for the phase.
  final StepperIndicatorStyle style;
  /// Diameter of the ring.
  final double size;
  /// Replaces the number.
  final Widget? icon;
  /// Style of the number.
  final TextStyle? textStyle;
  /// Icon slot; merged over the ring's foreground colour.
  final IconThemeData? iconTheme;
  /// Activates the step; null makes the ring inert.
  final VoidCallback? onPressed;
  /// Focus node for keyboard activation; internal when null.
  final FocusNode? focusNode;
  Widget build(BuildContext context);
}
```
