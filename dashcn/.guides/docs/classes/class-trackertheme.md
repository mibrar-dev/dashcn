---
title: "Class: TrackerTheme"
description: "Appearance of the tracker component."
---

```dart
/// Appearance of the tracker component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class TrackerTheme extends ComponentThemeData implements Mergeable<TrackerTheme> {
  /// Creates a tracker theme.
  const TrackerTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.fine, this.warning, this.critical, this.unknown, this.radius, this.gap, this.itemHeight});
  /// Fill of a [TrackerLevel.fine] segment. Default: the `chart2` token.
  final ThemedColor? fine;
  /// Fill of a [TrackerLevel.warning] segment. Default: the `chart4` token.
  final ThemedColor? warning;
  /// Fill of a [TrackerLevel.critical] segment.
  final ThemedColor? critical;
  /// Fill of a [TrackerLevel.unknown] segment.
  final ThemedColor? unknown;
  /// Outer corner radius; null resolves the ambient `radiusMd` at build.
  final double? radius;
  /// Gap between two segments.
  final double? gap;
  /// Height of every segment.
  final double? itemHeight;
  /// The fill for [level].
  ThemedColor? forLevel(TrackerLevel level);
  /// Returns a copy with the given fields replaced.
  TrackerTheme copyWith({ValueGetter<ThemedColor?>? fine, ValueGetter<ThemedColor?>? warning, ValueGetter<ThemedColor?>? critical, ValueGetter<ThemedColor?>? unknown, ValueGetter<double?>? radius, ValueGetter<double?>? gap, ValueGetter<double?>? itemHeight});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  TrackerTheme merge(TrackerTheme? fallback);
  /// Colours step at `t = 0.5`; dimensions are lerped.
  static TrackerTheme lerp(TrackerTheme a, TrackerTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
