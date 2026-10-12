---
title: "Function: pasteTokenClipboard"
description: "Reads the system clipboard's plain text and turns it into [fragments] with  [handler]; null when the clipboard is empty or unreadable."
---

Signature
```dart
Future<List<TokenFragment<T>>?> pasteTokenClipboard<T>(TokenClipboardHandler<T> handler);
```
