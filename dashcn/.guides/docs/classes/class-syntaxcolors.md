---
title: "Class: SyntaxColors"
description: "The syntax-highlight palette for one brightness."
---

```dart
/// The syntax-highlight palette for one brightness.
///
/// Const-constructible so user-owned theme files stay values-only. Colors are
/// transcribed from shiki's github-light / github-dark themes (the palette
/// the upstream web kit site uses for code blocks).
class SyntaxColors {
  /// Creates a palette. Every kind has a color; [plain] is the text color.
  const SyntaxColors({required this.plain, required this.keyword, required this.type, required this.function, required this.string, required this.number, required this.comment, required this.operator, required this.annotation, required this.variable, required this.constant, required this.tag, required this.attribute});
  /// Unstyled code.
  final Color plain;
  /// Language keywords and CLI control words.
  final Color keyword;
  /// Type / class names.
  final Color type;
  /// Function names at call sites.
  final Color function;
  /// String literals.
  final Color string;
  /// Numeric literals.
  final Color number;
  /// Comments.
  final Color comment;
  /// Operators and punctuation.
  final Color operator;
  /// Annotations / decorators.
  final Color annotation;
  /// Variables and object properties/members.
  final Color variable;
  /// Constants (`true`/`false`/`null`, ALL_CAPS names).
  final Color constant;
  /// Markup tags.
  final Color tag;
  /// Markup/JSON attribute names.
  final Color attribute;
  /// github-light palette.
  static const SyntaxColors light = SyntaxColors(plain: Color(0xFF24292F), keyword: Color(0xFFCF222E), type: Color(0xFF953800), function: Color(0xFF8250DF), string: Color(0xFF0A3069), number: Color(0xFF0550AE), comment: Color(0xFF6E7781), operator: Color(0xFF57606A), annotation: Color(0xFF953800), variable: Color(0xFF24292F), constant: Color(0xFF0550AE), tag: Color(0xFF116329), attribute: Color(0xFF0550AE));
  /// github-dark palette.
  static const SyntaxColors dark = SyntaxColors(plain: Color(0xFFE6EDF3), keyword: Color(0xFFFF7B72), type: Color(0xFFFFA657), function: Color(0xFFD2A8FF), string: Color(0xFFA5D6FF), number: Color(0xFF79C0FF), comment: Color(0xFF8B949E), operator: Color(0xFFC9D1D9), annotation: Color(0xFFFFA657), variable: Color(0xFFE6EDF3), constant: Color(0xFF79C0FF), tag: Color(0xFF7EE787), attribute: Color(0xFF79C0FF));
  /// The palette for [brightness].
  factory SyntaxColors.forBrightness(Brightness brightness);
  /// Color for [kind].
  Color colorFor(SyntaxTokenKind kind);
  /// Steps at `t = 0.5` (colors cannot lerp mid-flight); mirrors
  /// `ThemeFonts.lerp`.
  static SyntaxColors lerp(SyntaxColors a, SyntaxColors b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
