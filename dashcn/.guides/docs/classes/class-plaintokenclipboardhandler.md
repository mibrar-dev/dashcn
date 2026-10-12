---
title: "Class: PlainTokenClipboardHandler"
description: "The default [TokenClipboardHandler]: tokens serialize with [chipSerializer]  (or `toString`) and pasted text stays plain text."
---

```dart
/// The default [TokenClipboardHandler]: tokens serialize with [chipSerializer]
/// (or `toString`) and pasted text stays plain text.
///
/// Two adjacent tokens are separated by [chipSeparator], so a copy of
/// `["ab", "cd"]` is `ab, cd` rather than the unreadable `abcd` the old default
/// produced.
///
/// Give [chipDeserializer] to read pasted text back as chips: the content is
/// split on [chipSeparator] and every piece runs through the parser, so a
/// round-trip of `ab, cd` produces two tokens again instead of one string.
class PlainTokenClipboardHandler<T> extends TokenClipboardHandler<T> {
  /// Creates a plain-text handler.
  const PlainTokenClipboardHandler({this.chipSerializer, this.chipSeparator = ', ', this.chipDeserializer});
  /// Converts a chip value into its clipboard string; defaults to `toString`.
  final String Function(T value)? chipSerializer;
  /// Written between two adjacent chips on copy, and the split point on paste.
  final String chipSeparator;
  /// Turns a pasted piece back into a chip value; null rejects the piece, which
  /// then stays plain text. Null (the default) skips the split entirely and
  /// pastes [content] verbatim.
  final T? Function(String text)? chipDeserializer;
  List<TokenFragment<T>> deserializeClipboard(String content);
  String serializeClipboard(List<TokenFragment<T>> content);
}
```
