---
title: "Class: IntegerTextFormatter"
description: "Integer-only text with optional integer clamping."
---

```dart
/// Integer-only text with optional integer clamping.
class IntegerTextFormatter extends TextInputFormatter {
  /// Creates the formatter.
  const IntegerTextFormatter({this.min, this.max});
  /// Lower clamp bound (int).
  final int? min;
  /// Upper clamp bound (int).
  final int? max;
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue);
}
```
