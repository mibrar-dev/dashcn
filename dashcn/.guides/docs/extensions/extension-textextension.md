---
title: "Extension: TextExtension"
description: "The fluent text-styling API."
---

```dart
/// The fluent text-styling API.
///
/// Every getter returns a [TextModifier], so calls chain and read left to
/// right. Modifiers resolve against the ambient [Theme], so the same
/// chain restyles itself when the theme changes.
///
/// ```dart
/// Text('Heading').h2.bold;
/// Text('Body').p.muted;
/// ```
extension TextExtension on Widget {
  /// Sans-serif family.
  TextModifier get sans;
  /// Monospace family.
  TextModifier get mono;
  /// 12px.
  TextModifier get xSmall;
  /// 14px.
  TextModifier get small;
  /// 16px.
  TextModifier get base;
  /// 18px.
  TextModifier get large;
  /// 20px.
  TextModifier get xLarge;
  /// 24px.
  TextModifier get x2Large;
  /// 30px.
  TextModifier get x3Large;
  /// 36px.
  TextModifier get x4Large;
  /// 48px.
  TextModifier get x5Large;
  /// 60px.
  TextModifier get x6Large;
  /// 72px.
  TextModifier get x7Large;
  /// 96px.
  TextModifier get x8Large;
  /// 144px.
  TextModifier get x9Large;
  /// Weight 100.
  TextModifier get thin;
  /// Weight 200.
  TextModifier get extraLight;
  /// Weight 300.
  TextModifier get light;
  /// Weight 400.
  TextModifier get normal;
  /// Weight 500.
  TextModifier get medium;
  /// Weight 600.
  TextModifier get semiBold;
  /// Weight 700.
  TextModifier get bold;
  /// Weight 800.
  TextModifier get extraBold;
  /// Weight 900.
  TextModifier get black;
  /// Italic.
  TextModifier get italic;
  /// Underlined.
  TextModifier get underline;
  /// Muted foreground colour.
  TextModifier get muted;
  /// Primary foreground colour.
  TextModifier get primaryForeground;
  /// Secondary foreground colour.
  TextModifier get secondaryForeground;
  /// Body foreground colour.
  TextModifier get foreground;
  /// Primary foreground colour; retained name of [foreground]'s sibling.
  TextModifier get modify;
  /// Heading level 1.
  TextModifier get h1;
  /// Heading level 2, with a rule underneath and top margin.
  TextModifier get h2;
  /// Heading level 3.
  TextModifier get h3;
  /// Heading level 4.
  TextModifier get h4;
  /// Paragraph, with top margin. See [firstP] for the first one on a page.
  TextModifier get p;
  /// Paragraph without the top margin.
  TextModifier get firstP;
  /// Block quote, with a left rule.
  TextModifier get blockQuote;
  /// List item: draws a bullet and increases the nesting depth for children.
  TextModifier get li;
  /// Inline code: monospace style in a rounded, muted chip.
  TextModifier get inlineCode;
  /// Lead paragraph, in the muted colour.
  TextModifier get lead;
  /// Large body text.
  TextModifier get textLarge;
  /// Small body text.
  TextModifier get textSmall;
  /// Small body text in the muted colour.
  TextModifier get textMuted;
  /// One line, no wrapping.
  TextModifier get singleLine;
  /// Truncates with an ellipsis.
  TextModifier get ellipsis;
  /// Centres the text.
  TextModifier get textCenter;
  /// Right-aligns the text.
  TextModifier get textRight;
  /// Left-aligns the text.
  TextModifier get textLeft;
  /// Justifies the text.
  TextModifier get textJustify;
  /// Aligns to the leading edge (left in LTR).
  TextModifier get textStart;
  /// Aligns to the trailing edge (right in LTR).
  TextModifier get textEnd;
}
```
