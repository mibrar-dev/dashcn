---
title: "Class: AccordionTheme"
description: "Theme container for the accordion component."
---

```dart
/// Theme container for the accordion component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class AccordionTheme extends ComponentThemeData implements Mergeable<AccordionTheme> {
  /// Creates an accordion theme.
  const AccordionTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.duration, this.curve, this.reverseCurve, this.padding, this.iconGap, this.dividerHeight, this.dividerColor, this.arrowIcon, this.arrowIconColor});
  /// Expand/collapse animation duration. Default: 200 ms.
  final Duration? duration;
  /// Curve applied while expanding. Default: easeIn.
  final Curve? curve;
  /// Curve applied while collapsing. Default: easeOut.
  final Curve? reverseCurve;
  /// Vertical padding around triggers and content. Default: content density.
  final double? padding;
  /// Space between the trigger label and the arrow. Default: 16 × scaling.
  final double? iconGap;
  /// Height of the divider between items. Default: 1 × scaling.
  final double? dividerHeight;
  /// Colour of the divider between items. Default: the `muted` token.
  final ThemedColor? dividerColor;
  /// Expand/collapse indicator. Default: Lucide `chevronUp`.
  final IconData? arrowIcon;
  /// Colour of the indicator. Default: the `mutedForeground` token.
  final ThemedColor? arrowIconColor;
  /// Returns a copy with the given fields replaced.
  AccordionTheme copyWith({ValueGetter<Duration?>? duration, ValueGetter<Curve?>? curve, ValueGetter<Curve?>? reverseCurve, ValueGetter<double?>? padding, ValueGetter<double?>? iconGap, ValueGetter<double?>? dividerHeight, ValueGetter<ThemedColor?>? dividerColor, ValueGetter<IconData?>? arrowIcon, ValueGetter<ThemedColor?>? arrowIconColor});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  AccordionTheme merge(AccordionTheme? fallback);
  /// Curves, icons and colours step at `t = 0.5`; dimensions are lerped.
  static AccordionTheme lerp(AccordionTheme a, AccordionTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
