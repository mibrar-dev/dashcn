---
title: "Class: SegmentedValue"
description: "The value of a segmented field: its parts plus the value of each editable  segment."
---

```dart
/// The value of a segmented field: its parts plus the value of each editable
/// segment.
class SegmentedValue {
  /// Creates a value from [parts].
  const SegmentedValue([this.parts = const <SegmentPart>[]]);
  /// The parts, in display order.
  final List<SegmentPart> parts;
  /// The editable parts only, in order.
  Iterable<SegmentPart> get values;
  /// The whole field's text (separators included).
  String get text;
  /// Returns a copy with the editable part at [index] set to [value].
  SegmentedValue withValue(int index, String value);
  bool operator ==(Object other);
  /// Whether [parts] describes the same field as this value: same parts in the
  /// same order with the same lengths and widths. Values are ignored, so a
  /// value swap never rebuilds the field's segment controllers.
  bool hasShape(List<SegmentPart> parts);
  int get hashCode;
  String toString();
}
```
