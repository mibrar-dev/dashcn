---
title: "Class: HistoryTheme"
description: "Surface and selection styling of the color history grid."
---

```dart
/// Surface and selection styling of the color history grid.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class HistoryTheme extends ComponentThemeData implements Mergeable<HistoryTheme> {
  /// Creates a history theme.
  const HistoryTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.selectedBorder, this.selectedBorderWidth, this.borderRadius, this.spacing, this.tileSize});
  /// Outline drawn around the selected swatch. Default: the `primary` token.
  final ThemedColor? selectedBorder;
  /// Width of the selection outline. Default: `2`.
  final double? selectedBorderWidth;
  /// Swatch corner radius; null resolves the ambient `radiusMd` at build.
  final BorderRadiusGeometry? borderRadius;
  /// Gap between swatches. Default: `4`.
  final double? spacing;
  /// Edge length of one swatch. Default: `32`.
  final double? tileSize;
  /// Returns a copy with the given fields replaced.
  HistoryTheme copyWith({ValueGetter<ThemedColor?>? selectedBorder, ValueGetter<double?>? selectedBorderWidth, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<double?>? spacing, ValueGetter<double?>? tileSize});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  HistoryTheme merge(HistoryTheme? fallback);
  /// Colours step at `t = 0.5`; geometry is lerped.
  static HistoryTheme lerp(HistoryTheme a, HistoryTheme b, double t);
}
```
