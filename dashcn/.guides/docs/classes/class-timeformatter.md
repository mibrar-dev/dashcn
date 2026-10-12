---
title: "Class: TimeFormatter"
description: "Pads/trims typed time text to a fixed [length] with leading zeros."
---

```dart
/// Pads/trims typed time text to a fixed [length] with leading zeros.
///
/// This is the reconciled owner of both old copies: the formatter copy wins.
class TimeFormatter extends TextInputFormatter {
  /// Fixed output length (e.g. 2 for `HH`/`mm` fields, 4 for `HHmm`).
  const TimeFormatter({required this.length});
  /// Fixed output length.
  final int length;
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue);
}
```
