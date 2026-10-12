---
title: "Class: MarkdownTheme"
description: "Theme of the markdown renderer."
---

```dart
/// Theme of the markdown renderer.
///
/// Every field is nullable: `null` means "inherit", and the resolver fills
/// the gap from the next leg (defaults < app < scoped < widget).
class MarkdownTheme extends ComponentThemeData implements Mergeable<MarkdownTheme> {
  const MarkdownTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.style, this.linkStyle, this.linkColor, this.codeStyle, this.codeBackgroundColor, this.quoteBorderColor, this.tableHeaderStyle, this.tableBorderColor, this.tableHeaderBackgroundColor, this.heading1Style, this.heading2Style, this.heading3Style, this.heading4Style, this.heading5Style, this.heading6Style, this.horizontalRuleColor, this.blockSpacing});
  /// Base body style. Color is ignored; the ambient `foreground` wins.
  final TextStyle? style;
  /// Link shape (underline). Color is ignored; [linkColor] wins.
  final TextStyle? linkStyle;
  /// Link color. Default: the `primary` token.
  final ThemedColor? linkColor;
  /// Code shape. Family falls back to the ambient `fontMono` at build.
  final TextStyle? codeStyle;
  /// Code-block fill. Default: `foreground` at 7%.
  final ThemedColor? codeBackgroundColor;
  /// Quote left-rule color. Default: the `border` token.
  final ThemedColor? quoteBorderColor;
  /// Table header shape.
  final TextStyle? tableHeaderStyle;
  /// Table rule color. Default: the `border` token.
  final ThemedColor? tableBorderColor;
  /// Table header-row fill. Default: `muted` at 50%.
  final ThemedColor? tableHeaderBackgroundColor;
  /// Heading shapes for levels 1-6.
  final TextStyle? heading1Style;
  final TextStyle? heading2Style;
  final TextStyle? heading3Style;
  final TextStyle? heading4Style;
  final TextStyle? heading5Style;
  final TextStyle? heading6Style;
  /// Horizontal-rule color. Default: the `border` token.
  final ThemedColor? horizontalRuleColor;
  /// Vertical gap after each block.
  final double? blockSpacing;
  MarkdownTheme copyWith({ValueGetter<TextStyle?>? style, ValueGetter<TextStyle?>? linkStyle, ValueGetter<ThemedColor?>? linkColor, ValueGetter<TextStyle?>? codeStyle, ValueGetter<ThemedColor?>? codeBackgroundColor, ValueGetter<ThemedColor?>? quoteBorderColor, ValueGetter<TextStyle?>? tableHeaderStyle, ValueGetter<ThemedColor?>? tableBorderColor, ValueGetter<ThemedColor?>? tableHeaderBackgroundColor, ValueGetter<TextStyle?>? heading1Style, ValueGetter<TextStyle?>? heading2Style, ValueGetter<TextStyle?>? heading3Style, ValueGetter<TextStyle?>? heading4Style, ValueGetter<TextStyle?>? heading5Style, ValueGetter<TextStyle?>? heading6Style, ValueGetter<ThemedColor?>? horizontalRuleColor, ValueGetter<double?>? blockSpacing});
  /// Receiver wins per field; [fallback] only fills null cells.
  MarkdownTheme merge(MarkdownTheme? fallback);
  /// Colors and styles step at `t = 0.5`; scalars interpolate.
  static MarkdownTheme lerp(MarkdownTheme a, MarkdownTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
