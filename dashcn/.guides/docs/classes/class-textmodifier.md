---
title: "Class: TextModifier"
description: "Base of the fluent text modifiers added to every [Widget] by  [TextExtension]."
---

```dart
/// Base of the fluent text modifiers added to every [Widget] by
/// [TextExtension].
///
/// A modifier is a widget: drop it in a tree, or call it to derive a new
/// modifier with a style override merged into the existing one.
///
/// ```dart
/// Text('Total').large.bold.muted;
/// ```
abstract class TextModifier extends StatelessWidget {
  /// Creates a [TextModifier].
  const TextModifier({super.key});
  /// Returns a modifier whose style is this one's style merged with the given
  /// properties.
  ///
  /// Where both define a property, the style already on this modifier wins and
  /// the argument only fills gaps. Passing nothing is the identity.
  Widget call({Color? color, Color? backgroundColor, double? fontSize, FontWeight? fontWeight, FontStyle? fontStyle, double? letterSpacing, double? wordSpacing, TextBaseline? textBaseline, double? height, TextLeadingDistribution? leadingDistribution, Locale? locale, Paint? foreground, Paint? background, List<Shadow>? shadows, List<FontFeature>? fontFeatures, List<FontVariation>? fontVariations, TextDecoration? decoration, Color? decorationColor, TextDecorationStyle? decorationStyle, double? decorationThickness, String? debugLabel, String? fontFamily, List<String>? fontFamilyFallback, String? package, TextOverflow? overflow});
}
```
