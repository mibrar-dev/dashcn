---
title: "Class: EditableTextShell"
description: "The standard visual shell around a text field's content."
---

```dart
/// The standard visual shell around a text field's content.
///
/// Paints [decoration], wraps [child] in the gesture detector, draws the focus
/// ring, tracks hover through [onHover] and dims/ignores input while disabled.
/// An optional [errorText] is rendered below the field.
class EditableTextShell extends StatelessWidget {
  /// Creates a shell.
  const EditableTextShell({super.key, required this.child, required this.decoration, required this.padding, required this.gestureBuilder, required this.focused, required this.enabled, required this.minHeight, this.borderRadius, this.errorText, this.errorStyle, this.gap = 4, this.hitBehavior = HitTestBehavior.translucent, this.onHover, this.showFocusRing = true});
  /// The field content, usually an [EditableTextFieldRow].
  final Widget child;
  /// Field surface decoration.
  final Decoration decoration;
  /// Corner radius of the focus ring.
  final BorderRadiusGeometry? borderRadius;
  /// Padding between the surface and [child].
  final EdgeInsetsGeometry padding;
  /// Gesture builder from the [EditableTextHost].
  final TextSelectionGestureDetectorBuilder gestureBuilder;
  /// Whether the focus ring is shown.
  final bool focused;
  /// Whether [focused] paints the ring; false keeps caret/selection only.
  final bool showFocusRing;
  /// Whether the field accepts input; false dims and ignores pointers.
  final bool enabled;
  /// Minimum field height.
  final double minHeight;
  /// Error message rendered below the field.
  final String? errorText;
  /// Style of [errorText].
  final TextStyle? errorStyle;
  /// Gap between the field and [errorText].
  final double gap;
  /// Hit-test behavior of the gesture detector.
  final HitTestBehavior hitBehavior;
  /// Called when the hover state changes.
  final ValueChanged<bool>? onHover;
  Widget build(BuildContext context);
}
```
