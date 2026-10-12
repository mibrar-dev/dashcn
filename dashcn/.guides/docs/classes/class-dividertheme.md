---
title: "Class: DividerTheme"
description: "Theme container for the divider component."
---

```dart
/// Theme container for the divider component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class DividerTheme extends ComponentThemeData implements Mergeable<DividerTheme> {
  /// Creates a divider theme.
  const DividerTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.color, this.thickness, this.extent, this.indent, this.endIndent, this.labelPadding, this.labelAlignment, this.labelStyle});
  /// Rule colour. Default: the `border` token.
  final ThemedColor? color;
  /// Stroke width of the rule. Default: 1.
  final double? thickness;
  /// Cross-axis extent of the whole divider: its height when horizontal, its
  /// width when vertical. Default: [dividerDefaultExtent].
  final double? extent;
  /// Space before the rule, measured from the leading edge. Default: 0.
  final double? indent;
  /// Space after the rule, measured from the trailing edge. Default: 0.
  final double? endIndent;
  /// Padding around [Divider.label]: upstream's `px-2` label gutter (8) as
  /// density multipliers, resolved by `Divider`. Default:
  /// [dividerDefaultLabelPadding].
  final EdgeInsetsGeometry? labelPadding;
  /// Cross-axis placement of [Divider.label]. Default:
  /// [DividerLabelAlignment.center].
  final DividerLabelAlignment? labelAlignment;
  /// Label text style; its colour falls back to the `mutedForeground` token.
  final TextStyle? labelStyle;
  /// Returns a copy with the given fields replaced.
  DividerTheme copyWith({ValueGetter<ThemedColor?>? color, ValueGetter<double?>? thickness, ValueGetter<double?>? extent, ValueGetter<double?>? indent, ValueGetter<double?>? endIndent, ValueGetter<EdgeInsetsGeometry?>? labelPadding, ValueGetter<DividerLabelAlignment?>? labelAlignment, ValueGetter<TextStyle?>? labelStyle});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  DividerTheme merge(DividerTheme? fallback);
  /// Colours and the label alignment step at `t = 0.5`; dimensions and padding
  /// are lerped.
  static DividerTheme lerp(DividerTheme a, DividerTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
