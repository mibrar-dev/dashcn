---
title: "Class: TokenSpan"
description: "An inline span standing for one token."
---

```dart
/// An inline span standing for one token.
///
/// A [WidgetSpan] subclass so the token still paints as a widget while carrying
/// the value behind it; clipboard serialization reads the value instead of the
/// private-use placeholder.
class TokenSpan<T> extends WidgetSpan {
  /// Creates a token span.
  const TokenSpan({required this.value, required this.index, required super.child, super.alignment, super.baseline, super.style});
  /// The token this span stands for.
  final T value;
  /// The token's position in the controller's token list.
  final int index;
}
```
