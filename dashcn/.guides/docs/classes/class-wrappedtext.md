---
title: "Class: WrappedText"
description: "The default [TextModifier]: resolves its builders against the ambient  [Theme] and installs the result as a merged [DefaultTextStyle]."
---

```dart
/// The default [TextModifier]: resolves its builders against the ambient
/// [Theme] and installs the result as a merged [DefaultTextStyle].
///
/// [wrapper] runs outside the style merge, so decorations and padding around
/// the text do not inherit the modifier's text style.
class WrappedText extends TextModifier {
  /// Creates a modifier over [child].
  const WrappedText({super.key, this.style, this.textAlign, this.softWrap, this.overflow, this.maxLines, this.textWidthBasis, this.wrapper, required this.child});
  /// Style builder installed as the default text style.
  final WrappedTextDataBuilder<TextStyle>? style;
  /// Text alignment builder.
  final WrappedTextDataBuilder<TextAlign>? textAlign;
  /// Soft-wrap builder.
  final WrappedTextDataBuilder<bool>? softWrap;
  /// Overflow builder.
  final WrappedTextDataBuilder<TextOverflow>? overflow;
  /// Maximum line count builder.
  final WrappedTextDataBuilder<int>? maxLines;
  /// Text width basis builder.
  final WrappedTextDataBuilder<TextWidthBasis>? textWidthBasis;
  /// Extra widgets placed around the child.
  final WidgetTextWrapper? wrapper;
  /// The widget being modified.
  final Widget child;
  Widget call({Color? color, Color? backgroundColor, double? fontSize, FontWeight? fontWeight, FontStyle? fontStyle, double? letterSpacing, double? wordSpacing, TextBaseline? textBaseline, double? height, TextLeadingDistribution? leadingDistribution, Locale? locale, Paint? foreground, Paint? background, List<Shadow>? shadows, List<FontFeature>? fontFeatures, List<FontVariation>? fontVariations, TextDecoration? decoration, Color? decorationColor, TextDecorationStyle? decorationStyle, double? decorationThickness, String? debugLabel, String? fontFamily, List<String>? fontFamilyFallback, String? package, TextOverflow? overflow});
  Widget build(BuildContext context);
  /// Copies this modifier, replacing only the arguments that are given.
  ///
  /// Each argument is a getter so a builder can be built lazily; omitting an
  /// argument keeps the current value.
  WrappedText copyWith({ValueGetter<WrappedTextDataBuilder<TextStyle>?>? style, ValueGetter<WrappedTextDataBuilder<TextAlign>?>? textAlign, ValueGetter<WrappedTextDataBuilder<bool>?>? softWrap, ValueGetter<WrappedTextDataBuilder<TextOverflow>?>? overflow, ValueGetter<WrappedTextDataBuilder<int>?>? maxLines, ValueGetter<WrappedTextDataBuilder<TextWidthBasis>?>? textWidthBasis, ValueGetter<WidgetTextWrapper?>? wrapper, ValueGetter<Widget>? child});
  /// Copies this modifier with [style] merged underneath the current style.
  ///
  /// The style already set here wins wherever both define a property; [style]
  /// fills in the rest. That is what makes `Text('x').large.call(fontSize: 12)`
  /// keep the large size and only take the colour from the argument.
  WrappedText copyWithStyle(WrappedTextDataBuilder<TextStyle> style);
}
```
