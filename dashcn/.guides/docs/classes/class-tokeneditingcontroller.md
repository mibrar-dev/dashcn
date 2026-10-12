---
title: "Class: TokenEditingController"
description: "A [TextEditingController] whose text can hold tokens."
---

```dart
/// A [TextEditingController] whose text can hold tokens.
///
/// A token occupies exactly one code unit from U+E000 to U+F8FF, which is why
/// plain caret movement, selection, undo and every `EditableText` keyboard
/// command keep working. [tokenBuilder] paints each one.
///
/// ```dart
/// final controller = TokenEditingController<String>(
///   initialTokens: const <String>['flutter'],
///   tokenBuilder: (context, token, index) => Chip(child: Text(token)),
/// );
/// ```
class TokenEditingController<T> extends TextEditingController {
  /// Creates a token controller.
  TokenEditingController({super.text, List<T>? initialTokens, required this.tokenBuilder, this.spacing = 4, this.alignment = PlaceholderAlignment.middle});
  /// Builds the widget painted for each token.
  ///
  /// Public and mutable: the field assigns it on every build, so a token always
  /// paints with the current theme. It must stay pure — it runs while
  /// `EditableText` paints, not during `build`.
  TokenWidgetBuilder<T> tokenBuilder;
  /// Horizontal space reserved between two adjacent tokens, in logical pixels.
  double spacing;
  /// How the painted token sits on the text baseline.
  PlaceholderAlignment alignment;
  /// Every token, in text order.
  List<T> get tokens;
  /// Number of tokens in the text.
  int get tokenCount;
  /// The text with every token code unit removed.
  String get plainText;
  /// The run of plain text around the caret, trimmed.
  ///
  /// Empty when the caret touches a token or the field is empty.
  String get textAtCursor;
  /// Whether a token sits immediately before the caret.
  bool get hasTokenBeforeCaret;
  /// Replaces every token with [next], keeping the surrounding text.
  ///
  /// The run keeps its place: it stays between the text before the first token
  /// and the text after the last one. With no token yet, the run is inserted at
  /// the caret. This is what makes reordering the list actually reorder the
  /// rendered tokens.
  set tokens(List<T> next);
  /// Inserts [token] at the caret and returns its index.
  int insertToken(T token);
  /// Inserts every token of [values] at the caret, in order.
  void insertTokens(List<T> values);
  /// Removes the token at [index] in [tokens] order; false when out of range.
  bool removeTokenAt(int index);
  /// Removes the last token; false when there is none.
  bool removeLastToken();
  /// Converts the plain run around the caret into a token.
  ///
  /// [convert] receives the trimmed run and returns the token to insert, or
  /// null to reject it and leave the text untouched. Returns the inserted
  /// token, or null when there was nothing to convert.
  T? submitTokenAtCursor(T? Function(String text) convert);
  /// The fragments [selection] covers, in text order.
  List<TokenFragment<T>> fragmentsIn(TextSelection selection);
  /// Replaces the selection with [fragments].
  void replaceSelectionWith(List<TokenFragment<T>> fragments);
  set value(TextEditingValue newValue);
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing});
}
```
