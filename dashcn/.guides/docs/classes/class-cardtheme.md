---
title: "Class: CardTheme"
description: "Surface, border, padding and shadow of the card component."
---

```dart
/// Surface, border, padding and shadow of the card component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class CardTheme extends ComponentThemeData implements Mergeable<CardTheme> {
  /// Creates a card theme.
  const CardTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.foreground, this.borderColor, this.borderWidth, this.borderRadius, this.padding, this.shadows});
  /// Fill of the card surface. Default: the `card` token.
  final ThemedColor? background;
  /// Text colour inherited by the card content. Default: the
  /// `cardForeground` token.
  final ThemedColor? foreground;
  /// Border colour; null draws no border. Default: the `border` token.
  final ThemedColor? borderColor;
  /// Border width; `0` hides the border. Default: `1`.
  final double? borderWidth;
  /// Corner radius; null resolves the ambient `radiusXl` at build.
  final BorderRadiusGeometry? borderRadius;
  /// Inner padding; null resolves the upstream `p-6` (24) default at build, as an
  /// [EdgeInsetsDensity] that scales with density. A literal override passes
  /// through unchanged.
  final EdgeInsetsGeometry? padding;
  /// Drop shadows of the card; null resolves the ambient `shadowSm` at build,
  /// `const []` removes them.
  final List<BoxShadow>? shadows;
  /// Returns a copy with the given fields replaced.
  CardTheme copyWith({ValueGetter<ThemedColor?>? background, ValueGetter<ThemedColor?>? foreground, ValueGetter<ThemedColor?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<List<BoxShadow>?>? shadows});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  CardTheme merge(CardTheme? fallback);
  /// Colours step at `t = 0.5`; geometry and shadows are lerped.
  static CardTheme lerp(CardTheme a, CardTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
