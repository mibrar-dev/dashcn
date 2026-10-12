---
title: "Class: SyntaxToken"
description: "One recognized range of source text."
---

```dart
/// One recognized range of source text.
class SyntaxToken {
  /// Creates a token of [kind] covering `[start, end)`.
  const SyntaxToken(this.kind, this.start, this.end);
  /// The token kind (picked up by [SyntaxColors.colorFor]).
  final SyntaxTokenKind kind;
  /// Start offset in the source.
  final int start;
  /// End offset (exclusive) in the source.
  final int end;
  String toString();
}
```
