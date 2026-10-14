---
title: "Class: TokenValueFragment"
description: "A token carried across the clipboard."
---

```dart
/// A token carried across the clipboard.
class TokenValueFragment<T> extends TokenFragment<T> {
  /// Creates a token fragment.
  const TokenValueFragment(this.value);
  /// The token value.
  final T value;
  String toString();
}
```
