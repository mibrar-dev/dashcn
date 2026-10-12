---
title: "Class: TimelineTheme"
description: "Geometry and colour of one timeline: the three-column row layout."
---

```dart
/// Geometry and colour of one timeline: the three-column row layout.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class TimelineTheme extends ComponentThemeData implements Mergeable<TimelineTheme> {
  /// Creates a timeline theme.
  const TimelineTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.timeConstraints, this.spacing, this.dotSize, this.connectorThickness, this.color, this.rowGap});
  /// Width constraints of the time column; null resolves `120 * scaling`.
  final BoxConstraints? timeConstraints;
  /// Horizontal gap between the three columns; null resolves the ambient
  /// base content padding.
  final double? spacing;
  /// Diameter of the indicator dot; null resolves `12 * scaling`.
  final double? dotSize;
  /// Thickness of the connector line; null resolves `2 * scaling`.
  final double? connectorThickness;
  /// Fallback colour for dots and connectors; null resolves the `primary`
  /// token. Per-entry colours win over this.
  final ThemedColor? color;
  /// Vertical gap between rows; null resolves `16 * scaling`.
  final double? rowGap;
  /// Returns a copy with the given fields replaced.
  TimelineTheme copyWith({ValueGetter<BoxConstraints?>? timeConstraints, ValueGetter<double?>? spacing, ValueGetter<double?>? dotSize, ValueGetter<double?>? connectorThickness, ValueGetter<ThemedColor?>? color, ValueGetter<double?>? rowGap});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  TimelineTheme merge(TimelineTheme? fallback);
  /// Constraints step at t < 0.5; dimensions and colours are lerped.
  static TimelineTheme lerp(TimelineTheme a, TimelineTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
