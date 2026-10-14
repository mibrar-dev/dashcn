---
title: "Class: SegmentRung"
description: "One editable rung of a structured field."
---

```dart
/// One editable rung of a structured field.
class SegmentRung {
  /// Creates a rung.
  ///
  /// [width] is an explicit override; null sizes from the text style.
  const SegmentRung({required this.length, this.width, required this.placeholder, this.separatorBefore = ''});
  /// Maximum digits accepted.
  final int length;
  /// Explicit width override in logical pixels; null sizes from the style.
  final double? width;
  /// Shown while the segment is empty.
  final Widget placeholder;
  /// Static text before the segment ('' for the first rung).
  final String separatorBefore;
}
```
