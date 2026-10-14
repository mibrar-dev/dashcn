---
title: "Class: TextInputFormatters"
description: "Factory methods for common text input formatters."
---

```dart
/// Factory methods for common text input formatters.
///
/// ```dart
/// TextField(
///   inputFormatters: [
///     TextInputFormatters.toUpperCase,
///     TextInputFormatters.integerOnly(min: 0, max: 100),
///   ],
/// )
/// ```
class TextInputFormatters {
  /// Converts all input text to uppercase.
  static const TextInputFormatter toUpperCase = ToUpperCaseTextFormatter();
  /// Converts all input text to lowercase.
  static const TextInputFormatter toLowerCase = ToLowerCaseTextFormatter();
  /// Creates a time formatter padded left with zeros to [length].
  static TextInputFormatter time({required int length});
  /// Creates an integer-only formatter with optional bounds.
  static TextInputFormatter integerOnly({int? min, int? max});
  /// Creates a decimal formatter with optional bounds and fixed places.
  static TextInputFormatter digitsOnly({double? min, double? max, int? decimalDigits});
  /// Creates a math-expression evaluator formatter.
  static TextInputFormatter mathExpression({Map<String, dynamic>? context});
  /// Creates a hex-only formatter.
  static TextInputFormatter hex({bool hashPrefix = false});
}
```
