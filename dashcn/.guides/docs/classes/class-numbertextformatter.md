---
title: "Class: NumberTextFormatter"
description: "Numeric text with optional integer/decimal clamping."
---

```dart
/// Numeric text with optional integer/decimal clamping.
class NumberTextFormatter extends TextInputFormatter {
  /// Creates the formatter.
  ///
  /// [decimalDigits] null keeps the input's natural precision;
  /// [min]/[max] clamp the parsed value (old semantics: equality also
  /// clamps, which made the "overwrite at boundary" case identical).
  const NumberTextFormatter({this.min, this.max, this.decimalDigits});
  /// Lower clamp bound.
  final double? min;
  /// Upper clamp bound.
  final double? max;
  /// Fixed decimal places when parsing.
  final int? decimalDigits;
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue);
}
```
