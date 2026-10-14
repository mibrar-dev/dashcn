---
title: "Class: CardImageTheme"
description: "Appearance of the card image component."
---

```dart
/// Appearance of the card image component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class CardImageTheme extends ComponentThemeData implements Mergeable<CardImageTheme> {
  /// Creates a card image theme.
  const CardImageTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.direction, this.hoverScale, this.normalScale, this.imageBackground, this.imageBorderColor, this.imageRadius, this.gap});
  /// Axis of the image/text composition. Defaults to [Axis.vertical].
  final Axis? direction;
  /// Image scale while the card is hovered. Defaults to 1.05.
  final double? hoverScale;
  /// Image scale at rest. Defaults to 1.
  final double? normalScale;
  /// Fill behind the image. Defaults to a fully transparent token.
  final ThemedColor? imageBackground;
  /// Border around the image. Defaults to a fully transparent token.
  final ThemedColor? imageBorderColor;
  /// Corner radius of the image surface. Defaults to the ambient `radiusXl`.
  final BorderRadiusGeometry? imageRadius;
  /// Gap between the image and the text block. Defaults to 12.
  final double? gap;
  /// Returns a copy with the given fields replaced.
  CardImageTheme copyWith({ValueGetter<Axis?>? direction, ValueGetter<double?>? hoverScale, ValueGetter<double?>? normalScale, ValueGetter<ThemedColor?>? imageBackground, ValueGetter<ThemedColor?>? imageBorderColor, ValueGetter<BorderRadiusGeometry?>? imageRadius, ValueGetter<double?>? gap});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  CardImageTheme merge(CardImageTheme? fallback);
  /// Colours and the axis step at `t = 0.5`; dimensions are lerped.
  static CardImageTheme lerp(CardImageTheme a, CardImageTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
