---
title: "Class: CarouselTheme"
description: "Visual contract of the carousel viewport."
---

```dart
/// Visual contract of the carousel viewport.
class CarouselTheme extends ComponentThemeData implements Mergeable<CarouselTheme> {
  /// Creates a carousel theme.
  const CarouselTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.transition, this.alignment, this.direction, this.viewportFraction, this.itemExtent, this.gap, this.speed, this.curve, this.autoplayInterval, this.pauseOnHover, this.draggable, this.wrap});
  /// Page transition; null resolves [CarouselTransition.sliding].
  final CarouselTransition? transition;
  /// Page alignment; null resolves [CarouselAlignment.center].
  final CarouselAlignment? alignment;
  /// Scroll axis; null resolves [Axis.horizontal].
  final Axis? direction;
  /// Fraction of the viewport one page occupies; null resolves 1.
  final double? viewportFraction;
  /// Fixed page extent in logical pixels; wins over [viewportFraction].
  final double? itemExtent;
  /// Gap between two pages; null resolves zero.
  final double? gap;
  /// Page-change duration; null resolves [kDefaultDuration].
  final Duration? speed;
  /// Page-change curve; null resolves [Curves.easeInOut].
  final Curve? curve;
  /// Time one page is held during autoplay; null disables autoplay.
  final Duration? autoplayInterval;
  /// Whether autoplay pauses while the pointer rests on the carousel.
  final bool? pauseOnHover;
  /// Whether the carousel can be dragged; null resolves true.
  final bool? draggable;
  /// Whether the last page wraps to the first; null resolves true.
  final bool? wrap;
  /// Returns a copy with the given fields replaced.
  CarouselTheme copyWith({ValueGetter<CarouselTransition?>? transition, ValueGetter<CarouselAlignment?>? alignment, ValueGetter<Axis?>? direction, ValueGetter<double?>? viewportFraction, ValueGetter<double?>? itemExtent, ValueGetter<double?>? gap, ValueGetter<Duration?>? speed, ValueGetter<Curve?>? curve, ValueGetter<Duration?>? autoplayInterval, ValueGetter<bool?>? pauseOnHover, ValueGetter<bool?>? draggable, ValueGetter<bool?>? wrap});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  CarouselTheme merge(CarouselTheme? fallback);
  /// State scales step at t < 0.5; dimensions lerp.
  static CarouselTheme lerp(CarouselTheme a, CarouselTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
