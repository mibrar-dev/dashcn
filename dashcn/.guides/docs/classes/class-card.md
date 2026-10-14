---
title: "Class: Card"
description: "A rounded surface with a border, a token fill and a soft shadow."
---

```dart
/// A rounded surface with a border, a token fill and a soft shadow.
///
/// Inside a sheet overlay (see [SheetOverlayHandler]) only the padding is
/// applied: the sheet already provides the surface, so a second card chrome on
/// top of it would draw a border inside a border.
class Card extends StatelessWidget {
  /// Creates a card.
  const Card({super.key, required this.child, this.padding, this.background, this.borderColor, this.borderWidth, this.borderRadius, this.shadows, this.clipBehavior = Clip.none, this.theme});
  /// Card content.
  final Widget child;
  /// Padding between the card border and its content; null falls back to
  /// `cardDefaults.padding`, a density-scaled upstream `p-6` that `Card`
  /// resolves against `density.baseContentPadding * scaling`. A literal
  /// override passes through unchanged.
  final EdgeInsetsGeometry? padding;
  /// Fill override; null falls back to `CardTheme.background`.
  final ThemedColor? background;
  /// Border colour override; null falls back to `CardTheme.borderColor`.
  final ThemedColor? borderColor;
  /// Border width override; `0` hides the border.
  final double? borderWidth;
  /// Corner radius override; null resolves the ambient `radiusXl`.
  final BorderRadiusGeometry? borderRadius;
  /// Shadow override; null resolves the ambient `shadowSm`.
  final List<BoxShadow>? shadows;
  /// How the card clips its content.
  final Clip clipBehavior;
  /// Widget-leg override, merged over the component/app/defaults legs.
  final CardTheme? theme;
  Widget build(BuildContext context);
}
```
