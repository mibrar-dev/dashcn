---
title: "Class: ScrollbarTheme"
description: "Theme container for the scrollbar component."
---

```dart
/// Theme container for the scrollbar component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class ScrollbarTheme extends ComponentThemeData implements Mergeable<ScrollbarTheme> {
  /// Creates a scrollbar theme.
  const ScrollbarTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.color, this.thickness, this.radius, this.minThumbLength, this.minOverscrollLength, this.interactive});
  /// Thumb colour. Default: the `border` token.
  final ThemedColor? color;
  /// Thumb thickness. Default: [scrollbarDefaultThickness] times scaling.
  final double? thickness;
  /// Thumb corner radius. Default: `radiusSm` from the ambient tokens.
  final Radius? radius;
  /// Minimum thumb length. Default: [kMinScrollbarThumbExtent].
  final double? minThumbLength;
  /// Minimum thumb length while dragged past an edge; null follows
  /// [minThumbLength] (Flutter's `RawScrollbar` contract).
  final double? minOverscrollLength;
  /// Whether the thumb responds to drags. Default: true.
  final bool? interactive;
  /// Returns a copy with the given fields replaced.
  ScrollbarTheme copyWith({ValueGetter<ThemedColor?>? color, ValueGetter<double?>? thickness, ValueGetter<Radius?>? radius, ValueGetter<double?>? minThumbLength, ValueGetter<double?>? minOverscrollLength, ValueGetter<bool?>? interactive});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  ScrollbarTheme merge(ScrollbarTheme? fallback);
  /// Colours and the interactive flag step at `t = 0.5`; dimensions are
  /// lerped.
  static ScrollbarTheme lerp(ScrollbarTheme a, ScrollbarTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
