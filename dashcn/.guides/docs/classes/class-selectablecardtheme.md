---
title: "Class: SelectableCardTheme"
description: "Card-surface styling for a [RadioCard]."
---

```dart
/// Card-surface styling for a [RadioCard].
///
/// It lives here, not in `primitives/selectable_radio/`, because a card is a
/// component-layer surface: the primitive may not import `Card`, so the shape
/// that draws one belongs to the component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class SelectableCardTheme extends ComponentThemeData implements Mergeable<SelectableCardTheme> {
  /// Creates a card theme.
  const SelectableCardTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.borderColor, this.borderWidth, this.borderRadius, this.padding, this.gap});
  /// Per-state fill.
  final StateValue<ThemedColor>? background;
  /// Per-state border colour.
  final StateValue<ThemedColor>? borderColor;
  /// Border width; null resolves 1. Constant per state, so selecting a card
  /// can never shift its content.
  final double? borderWidth;
  /// Corner radius; null resolves the ambient `radiusLg` at build.
  final BorderRadiusGeometry? borderRadius;
  /// Inner padding; null resolves 16, density-scaled.
  final EdgeInsetsGeometry? padding;
  /// Space between the indicator and the content; null resolves `spacing.md`.
  final double? gap;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  SelectableCardTheme merge(SelectableCardTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
