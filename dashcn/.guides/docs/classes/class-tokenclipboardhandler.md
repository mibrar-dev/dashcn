---
title: "Class: TokenClipboardHandler"
description: "Converts a token selection to and from the system clipboard."
---

```dart
/// Converts a token selection to and from the system clipboard.
///
/// [serialize] receives the selection as fragments — plain text runs and tokens
/// — so a handler can render each token however it likes. [deserialize] parses
/// clipboard text back into fragments to insert.
abstract class TokenClipboardHandler<T> {
  /// Const constructor for subclasses.
  const TokenClipboardHandler();
  /// Converts pasted clipboard [content] into fragments to insert.
  List<TokenFragment<T>> deserializeClipboard(String content);
  /// Converts the selected [content] into a string for the clipboard.
  String serializeClipboard(List<TokenFragment<T>> content);
}
```
