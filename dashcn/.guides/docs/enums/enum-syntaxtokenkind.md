---
title: "Enum: SyntaxTokenKind"
description: "One kind of syntax token a code tokenizer can emit."
---

```dart
/// One kind of syntax token a code tokenizer can emit.
///
/// The set is fixed: `SyntaxColors` carries a color for every kind, and the
/// tokenizer (`primitives/syntax_highlight`) maps lexemes to these kinds.
enum SyntaxTokenKind {
  /// Unstyled code (identifiers, whitespace, unclassified text).
  plain,
  /// Language keywords and CLI control words.
  keyword,
  /// Type / class names (capitalized identifiers).
  type,
  /// Function names at call sites.
  function,
  /// String literals (including the delimiters).
  string,
  /// Numeric literals.
  number,
  /// Comments.
  comment,
  /// Operators and punctuation.
  operator,
  /// Annotations / decorators (`@override`).
  annotation,
  /// Variables and object properties/members.
  variable,
  /// Constants (`true`/`false`/`null`, ALL_CAPS names).
  constant,
  /// Markup tags (`<div>` in HTML/JSX).
  tag,
  /// Markup/JSON attribute names.
  attribute,
}
```
