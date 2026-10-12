---
title: "Class: SwiperTheme"
description: "Behavioural configuration of a [Swiper]'s panel and swipe gesture."
---

```dart
/// Behavioural configuration of a [Swiper]'s panel and swipe gesture.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields. The panel's colours,
/// border and handle come from `DrawerTheme`, resolved by the swiper.
class SwiperTheme extends ComponentThemeData implements Mergeable<SwiperTheme> {
  /// Creates a swiper theme.
  const SwiperTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.expands, this.draggable, this.barrierDismissible, this.useSafeArea, this.showDragHandle, this.borderRadius, this.maxSize, this.barrierColor, this.behavior, this.threshold});
  /// Whether the panel fills its slide axis; null uses the variant default.
  final bool? expands;
  /// Whether the open panel can be dragged away.
  final bool? draggable;
  /// Whether tapping the barrier dismisses the panel.
  final bool? barrierDismissible;
  /// Whether the panel respects the device safe area.
  final bool? useSafeArea;
  /// Whether the panel draws a drag handle; null keeps `DrawerTheme`.
  final bool? showDragHandle;
  /// Inner-corner radius of the panel; null keeps `DrawerTheme`.
  final BorderRadius? borderRadius;
  /// Panel extent along its slide axis; null keeps `DrawerTheme`'s `maxSize`.
  final double? maxSize;
  /// Barrier colour; null uses black at 50%.
  final ThemedColor? barrierColor;
  /// Hit test behaviour of the swipe gesture.
  final HitTestBehavior? behavior;
  /// Fraction (0..1) of the panel at which a release settles it open.
  final double? threshold;
  /// Returns a copy with the given fields replaced.
  SwiperTheme copyWith({ValueGetter<bool?>? expands, ValueGetter<bool?>? draggable, ValueGetter<bool?>? barrierDismissible, ValueGetter<bool?>? useSafeArea, ValueGetter<bool?>? showDragHandle, ValueGetter<BorderRadius?>? borderRadius, ValueGetter<double?>? maxSize, ValueGetter<ThemedColor?>? barrierColor, ValueGetter<HitTestBehavior?>? behavior, ValueGetter<double?>? threshold});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  SwiperTheme merge(SwiperTheme? fallback);
  /// Flags and colours step at t < 0.5; geometry and numbers lerp.
  static SwiperTheme lerp(SwiperTheme a, SwiperTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
