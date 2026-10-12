---
title: "Class: SelectableTextTheme"
description: "One selectable text's visual contract."
---

```dart
/// One selectable text's visual contract.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class SelectableTextTheme extends ComponentThemeData implements Mergeable<SelectableTextTheme> {
  /// Creates a selectable text theme.
  const SelectableTextTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.textStyle, this.cursorWidth, this.cursorHeight, this.cursorRadius, this.cursorColor, this.selectionHeightStyle, this.selectionWidthStyle, this.enableInteractiveSelection});
  /// Base text style; its colour is used when non-null, otherwise the
  /// `foreground` token.
  final TextStyle? textStyle;
  /// Caret width; null resolves `2`.
  final double? cursorWidth;
  /// Caret height; null matches the line height.
  final double? cursorHeight;
  /// Caret corner radius; null is square.
  final Radius? cursorRadius;
  /// Caret colour; null resolves the `primary` token.
  final ThemedColor? cursorColor;
  /// Selection box height style; null resolves `BoxHeightStyle.tight`.
  final BoxHeightStyle? selectionHeightStyle;
  /// Selection box width style; null resolves `BoxWidthStyle.tight`.
  final BoxWidthStyle? selectionWidthStyle;
  /// Whether drag/double-tap/long-press selection is enabled; null resolves
  /// `true`.
  final bool? enableInteractiveSelection;
  /// Returns a copy with the given fields replaced.
  SelectableTextTheme copyWith({ValueGetter<TextStyle?>? textStyle, ValueGetter<double?>? cursorWidth, ValueGetter<double?>? cursorHeight, ValueGetter<Radius?>? cursorRadius, ValueGetter<ThemedColor?>? cursorColor, ValueGetter<BoxHeightStyle?>? selectionHeightStyle, ValueGetter<BoxWidthStyle?>? selectionWidthStyle, ValueGetter<bool?>? enableInteractiveSelection});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  SelectableTextTheme merge(SelectableTextTheme? fallback);
  /// Colours, styles and enums step at t < 0.5; dimensions are lerped.
  static SelectableTextTheme lerp(SelectableTextTheme a, SelectableTextTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
