---
title: "Extension: WidgetExtension"
description: "Layout and sizing helpers."
---

```dart
/// Layout and sizing helpers.
extension WidgetExtension on Widget {
  /// Wraps this widget in a [SizedBox], preserving an existing one's size
  /// when the argument is null.
  Widget sized({double? width, double? height});
  /// Wraps this widget in a [ConstrainedBox], preserving an existing one's
  /// constraints when the arguments are null.
  Widget constrained({double? minWidth, double? maxWidth, double? minHeight, double? maxHeight, double? width, double? height});
  /// Wraps this widget in a [Padding].
  ///
  /// The single-value and horizontal/vertical forms are mutually exclusive;
  /// combining them asserts.
  Widget withPadding({double? top, double? bottom, double? left, double? right, double? horizontal, double? vertical, double? all, EdgeInsetsGeometry? padding});
  /// Wraps this widget in an [Align].
  Widget withAlign(AlignmentGeometry alignment);
  /// Wraps this widget in an [Expanded].
  Widget expanded({int flex = 1});
  /// Wraps this widget in an [Opacity].
  Widget withOpacity(double opacity);
  /// Wraps this widget in a [ClipPath].
  Widget clipPath({Clip clipBehavior = Clip.antiAlias, required CustomClipper<Path> clipper});
  /// Wraps this widget in a [Transform].
  Widget transform({Key? key, required Matrix4 transform});
}
```
