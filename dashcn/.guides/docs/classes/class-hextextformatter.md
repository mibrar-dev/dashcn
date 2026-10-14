---
title: "Class: HexTextFormatter"
description: "Allows `[0-9a-fA-F]` only, optionally with a leading `#`."
---

```dart
/// Allows `[0-9a-fA-F]` only, optionally with a leading `#`.
class HexTextFormatter extends TextInputFormatter {
  /// Creates the formatter; [hashPrefix] forces a `#` prefix.
  const HexTextFormatter({this.hashPrefix = false});
  /// Whether the text is kept with a `#` prefix.
  final bool hashPrefix;
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue);
}
```
