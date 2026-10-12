---
title: "Class: AutoCompleteTheme"
description: "Popover presentation and per-row styling of the suggestion list."
---

```dart
/// Popover presentation and per-row styling of the suggestion list.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class AutoCompleteTheme extends ComponentThemeData implements Mergeable<AutoCompleteTheme> {
  /// Creates an autocomplete theme.
  const AutoCompleteTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.mode, this.popoverConstraints, this.popoverWidthConstraint, this.popoverAlignment, this.popoverAnchorAlignment, this.containerBackground, this.containerForeground, this.containerBorderColor, this.containerBorderWidth, this.containerBorderRadius, this.containerPadding, this.itemBackground, this.itemForeground, this.itemPadding, this.itemRadius, this.itemTextStyle, this.gap, this.maxHeight});
  /// Default replacement strategy; null falls back to
  /// [AutoCompleteMode.replaceWord].
  final AutoCompleteMode? mode;
  /// Size constraints of the suggestion popover.
  final BoxConstraints? popoverConstraints;
  /// How the popover width relates to the anchor.
  final PopoverConstraint? popoverWidthConstraint;
  /// Where the popover sits relative to itself.
  final AlignmentGeometry? popoverAlignment;
  /// Which edge of the field the popover attaches to.
  final AlignmentGeometry? popoverAnchorAlignment;
  /// Surface fill of the popover container.
  final ThemedColor? containerBackground;
  /// Label colour inherited by the popover content.
  final ThemedColor? containerForeground;
  /// Border colour of the popover container; null draws no border.
  final ThemedColor? containerBorderColor;
  /// Border width used when [containerBorderColor] resolves non-null.
  final double? containerBorderWidth;
  /// Corner radius of the popover container.
  final BorderRadiusGeometry? containerBorderRadius;
  /// Inner padding of the popover container; cmdk `p-1` (4) as density
  /// multipliers. Resolved by the `Card` that paints the popover.
  final EdgeInsetsGeometry? containerPadding;
  /// Per-state fill of a suggestion row.
  final StateValue<ThemedColor>? itemBackground;
  /// Per-state label colour of a suggestion row.
  final StateValue<ThemedColor>? itemForeground;
  /// Padding of a suggestion row (upstream `px-2 py-1.5` as density
  /// multipliers); null resolves [autocompleteDefaultItemPadding]. The row is
  /// painted by `Clickable`, so `AutoCompleteFeature` resolves it.
  final EdgeInsetsGeometry? itemPadding;
  /// Corner radius of a suggestion row.
  final BorderRadiusGeometry? itemRadius;
  /// Text style of a suggestion row; its colour comes from
  /// [itemForeground].
  final TextStyle? itemTextStyle;
  /// Vertical space between two suggestion rows.
  final double? gap;
  /// Height cap of the scrollable list; null resolves
  /// [autocompleteDefaultMaxHeight].
  final double? maxHeight;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  AutoCompleteTheme merge(AutoCompleteTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
