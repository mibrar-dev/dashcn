---
title: "Class: StarRating"
description: "An interactive star rating."
---

```dart
/// An interactive star rating.
///
/// Two modes:
/// * uncontrolled — pass a [controller]; `value`/`onChanged` must be null;
/// * controlled — pass `value` and `onChanged` (null `onChanged` renders a
///   read-only row).
///
/// Drag across the row to update the value; arrow keys step by [step] while
/// focused.
class StarRating extends StatefulWidget {
  /// Creates a star rating.
  const StarRating({super.key, this.value, this.controller, this.onChanged, this.enabled, this.step = 0.5, this.max = 5, this.direction = Axis.horizontal, this.focusNode, this.autofocus = false, this.onHover, this.onFocusChange, this.theme});
  final double? value;
  final StarRatingController? controller;
  final ValueChanged<double>? onChanged;
  final bool? enabled;
  final double step;
  final double max;
  final Axis direction;
  final FocusNode? focusNode;
  final bool autofocus;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final StarRatingStyle? theme;
  State<StarRating> createState();
}
```
