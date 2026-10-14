---
title: "Class: TextSegment"
description: "One editable segment of a segmented field."
---

```dart
/// One editable segment of a segmented field.
class TextSegment {
  /// Creates a segment definition.
  const TextSegment({required this.length, this.obscureText = false, this.placeholder, this.inputFormatters = const <TextInputFormatter>[], this.textAlign = TextAlign.center});
  /// Maximum number of characters in the segment.
  final int length;
  /// Whether the segment paints dots instead of its text.
  final bool obscureText;
  /// Widget shown while the segment is empty.
  final Widget? placeholder;
  /// Formatters applied before the length limiter.
  final List<TextInputFormatter> inputFormatters;
  /// Horizontal alignment inside the segment.
  final TextAlign textAlign;
  /// This segment's formatters including the length limiter.
  List<TextInputFormatter> formatters([MaxLengthEnforcement? enforcement]);
}
```
