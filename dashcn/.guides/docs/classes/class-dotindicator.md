---
title: "Class: DotIndicator"
description: "Navigation indicator with a row or column of animated dots."
---

```dart
/// Navigation indicator with a row or column of animated dots.
///
/// ```dart
/// DotIndicator(index: page, length: pages.length, onChanged: goToPage)
/// ```
class DotIndicator extends StatelessWidget {
  /// Creates a dot indicator.
  const DotIndicator({super.key, required this.index, required this.length, this.onChanged, this.spacing, this.direction = Axis.horizontal, this.padding, this.dotBuilder, this.theme});
  /// Index of the active dot; a value outside `0..length - 1` leaves every dot
  /// inactive.
  final int index;
  /// Number of dots.
  final int length;
  /// Called with the tapped index. Null makes the indicator read-only: no
  /// `Clickable` and no click cursor are built.
  final ValueChanged<int>? onChanged;
  /// Gap between two dots; null uses [DotIndicatorTheme.spacing] then
  /// `8 * scaling`.
  final double? spacing;
  /// Axis of the run of dots.
  final Axis direction;
  /// Padding around the run of dots; null uses [DotIndicatorTheme.padding] then
  /// [dotIndicatorDefaultPadding]. It is applied once, to the run, never per
  /// dot.
  final EdgeInsetsGeometry? padding;
  /// Custom dot builder; null paints the theme rows.
  final DotBuilder? dotBuilder;
  /// Widget-leg theme override, merged on top of the other legs.
  final DotIndicatorTheme? theme;
  Widget build(BuildContext context);
}
```
