---
title: "Class: TokenTextFragment"
description: "A run of plain text, free of token code units."
---

```dart
/// A run of plain text, free of token code units.
class TokenTextFragment<T> extends TokenFragment<T> {
  /// Creates a text fragment.
  const TokenTextFragment(this.text);
  /// The text.
  final String text;
  String toString();
}
```
