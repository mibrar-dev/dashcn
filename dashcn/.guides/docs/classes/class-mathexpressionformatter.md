---
title: "Class: MathExpressionFormatter"
description: "Parses a numeric expression on each edit and replaces the text with its  evaluated result (empty string when unparsable or non-numeric)."
---

```dart
/// Parses a numeric expression on each edit and replaces the text with its
/// evaluated result (empty string when unparsable or non-numeric).
class MathExpressionFormatter extends TextInputFormatter {
  /// Creates the formatter with optional [context] variables.
  const MathExpressionFormatter({this.context});
  /// Variables available to the expression evaluator.
  final Map<String, dynamic>? context;
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue);
}
```
