---
title: "Class: StepsTheme"
description: "Visual contract of a vertical step list."
---

```dart
/// Visual contract of a vertical step list.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class StepsTheme extends ComponentThemeData implements Mergeable<StepsTheme> {
  /// Creates a steps theme.
  const StepsTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.indicatorSize, this.spacing, this.indicatorColor, this.indicatorForeground, this.connectorColor, this.connectorThickness});
  /// Diameter of the numbered circle. Default: `28` (× scaling).
  final double? indicatorSize;
  /// Gap between the indicator column and the step content. Default: `18`
  /// (× scaling).
  final double? spacing;
  /// Fill of the numbered circle. Default: the `muted` token.
  final ThemedColor? indicatorColor;
  /// Colour of the step number. Default: the `foreground` token.
  final ThemedColor? indicatorForeground;
  /// Colour of the connector line. Default: the `muted` token.
  final ThemedColor? connectorColor;
  /// Thickness of the connector line. Default: `1` (× scaling).
  final double? connectorThickness;
  /// Returns a copy with the given fields replaced.
  StepsTheme copyWith({ValueGetter<double?>? indicatorSize, ValueGetter<double?>? spacing, ValueGetter<ThemedColor?>? indicatorColor, ValueGetter<ThemedColor?>? indicatorForeground, ValueGetter<ThemedColor?>? connectorColor, ValueGetter<double?>? connectorThickness});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  StepsTheme merge(StepsTheme? fallback);
  /// Colours and widgets step at `t < 0.5`; dimensions are lerped.
  static StepsTheme lerp(StepsTheme a, StepsTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
