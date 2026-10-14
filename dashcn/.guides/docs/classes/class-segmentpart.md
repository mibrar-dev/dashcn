---
title: "Class: SegmentPart"
description: "One part of a segmented value: a separator or an editable segment."
---

```dart
/// One part of a segmented value: a separator or an editable segment.
///
/// ```dart
/// const SegmentPart.separator('(');
/// const SegmentPart.editable(length: 3, width: 28, placeholder: Text('MM'));
/// ```
class SegmentPart {
  /// Creates a separator part.
  const SegmentPart.separator(this.separator);
  /// Creates an editable segment.
  ///
  /// [width] is an explicit override in logical pixels. Null (the default)
  /// sizes from the resolved text style (`length` glyph advances + cursor);
  /// a provided value is never shrunk below what the content needs.
  const SegmentPart.editable({this.value = '', required this.length, this.width, this.obscureText = false, this.placeholder, this.inputFormatters = const <TextInputFormatter>[]});
  /// The separator text; null when this part is an editable segment.
  final String? separator;
  /// Maximum length of an editable segment.
  final int length;
  /// Explicit width override; null sizes from the text style.
  final double? width;
  /// Whether the segment paints dots.
  final bool obscureText;
  /// Placeholder widget of an editable segment.
  final Widget? placeholder;
  /// Formatters of an editable segment.
  final List<TextInputFormatter> inputFormatters;
  /// The current text of an editable segment.
  final String value;
  /// Whether this part holds a value.
  bool get holdsValue;
  /// The segment definition of an editable part.
  TextSegment get segment;
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
