---
title: "Class: ChatTheme"
description: "The four theme legs of every chat widget: bubble surface, tail metrics,  group layout and reaction chips."
---

```dart
/// The four theme legs of every chat widget: bubble surface, tail metrics,
/// group layout and reaction chips. Every field is nullable — an override
/// leg sets only what it changes and [merge] keeps the rest.
class ChatTheme extends ComponentThemeData implements Mergeable<ChatTheme> {
  const ChatTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.foreground, this.variant, this.alignment, this.widthFactor, this.padding, this.borderRadius, this.borderColor, this.borderWidth, this.tailSize, this.tailRadius, this.tailBehavior, this.spacing, this.avatarSpacing, this.avatarAlignment, this.reactionBackground, this.reactionForeground, this.reactionSelectedBackground, this.reactionSelectedForeground, this.reactionPadding});
  /// Bubble fill; null resolves `primary`.
  final ThemedColor? background;
  /// Label/icon colour; null resolves `primaryForeground` (the old copy
  /// picked it by luminance instead).
  final ThemedColor? foreground;
  final ChatBubbleVariant? variant;
  /// Side of the row; null = `AlignmentDirectional.centerEnd`.
  final AlignmentGeometry? alignment;
  final double? widthFactor;
  /// Inner padding; null = the upstream bubble's `px-3 py-2` (12/8) as an
  /// [EdgeInsetsDensity].
  final EdgeInsetsGeometry? padding;
  /// Corner radius; null resolves the ambient `radiusLg`.
  final BorderRadiusGeometry? borderRadius;
  /// Outline colour/width; null draws no border.
  final ThemedColor? borderColor;
  final double? borderWidth;
  /// Tail extent / tip rounding; null = `8 x 8` / ambient `radiusSm`.
  final Size? tailSize;
  final double? tailRadius;
  /// Which bubble of a group carries the tail; null = [ChatTailBehavior.last].
  final ChatTailBehavior? tailBehavior;
  /// Gap between a group's bubbles; null resolves `2` (a `Row`/`Column`
  /// spacing, so it cannot carry a density multiplier).
  final double? spacing;
  /// Avatar gap / edge alignment; null = `8` / the group default. A raw
  /// `double` (`Row.spacing`), so `8` stays a literal.
  final double? avatarSpacing;
  final AlignmentGeometry? avatarAlignment;
  /// Reaction chips: fill, label, selected fill, selected label and padding
  /// (`muted` / `foreground` / `primary` / `primaryForeground` / `6 x 4`).
  ///
  /// The padding is a pill `px-1.5 py-1` [EdgeInsetsDensity].
  final ThemedColor? reactionBackground;
  final ThemedColor? reactionForeground;
  final ThemedColor? reactionSelectedBackground;
  final ThemedColor? reactionSelectedForeground;
  final EdgeInsetsGeometry? reactionPadding;
  ChatTheme copyWith({ValueGetter<ThemedColor?>? background, ValueGetter<ThemedColor?>? foreground, ValueGetter<ChatBubbleVariant?>? variant, ValueGetter<AlignmentGeometry?>? alignment, ValueGetter<double?>? widthFactor, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<ThemedColor?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<Size?>? tailSize, ValueGetter<double?>? tailRadius, ValueGetter<ChatTailBehavior?>? tailBehavior, ValueGetter<double?>? spacing, ValueGetter<double?>? avatarSpacing, ValueGetter<AlignmentGeometry?>? avatarAlignment, ValueGetter<ThemedColor?>? reactionBackground, ValueGetter<ThemedColor?>? reactionForeground, ValueGetter<ThemedColor?>? reactionSelectedBackground, ValueGetter<ThemedColor?>? reactionSelectedForeground, ValueGetter<EdgeInsetsGeometry?>? reactionPadding});
  ChatTheme merge(ChatTheme? fallback);
  static ChatTheme lerp(ChatTheme a, ChatTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
