---
title: "Class: Scrollbar"
description: "A scrollbar for the nearest scrollable of [child]."
---

```dart
/// A scrollbar for the nearest scrollable of [child].
///
/// ```dart
/// Scrollbar(
///   thumbVisibility: true,
///   child: ListView(controller: controller, children: items),
/// );
/// ```
class Scrollbar extends StatelessWidget {
  /// Creates a scrollbar.
  const Scrollbar({super.key, required this.child, this.controller, this.thumbVisibility, this.trackVisibility, this.thickness, this.radius, this.minThumbLength, this.minOverscrollLength, this.color, this.interactive, this.notificationPredicate, this.scrollbarOrientation, this.theme});
  /// The scrollable widget the scrollbar is stacked on.
  final Widget child;
  /// Controller of the scrollable; defaults to the primary controller.
  final ScrollController? controller;
  /// Whether the thumb is always visible.
  final bool? thumbVisibility;
  /// Whether the track is painted behind the thumb.
  final bool? trackVisibility;
  /// Thumb thickness override.
  final double? thickness;
  /// Thumb corner radius override.
  final Radius? radius;
  /// Minimum thumb length override.
  final double? minThumbLength;
  /// Minimum thumb length while dragged past an edge.
  final double? minOverscrollLength;
  /// Thumb colour override.
  final ThemedColor? color;
  /// Whether the thumb responds to drags; defaults to true.
  final bool? interactive;
  /// Which scroll notifications the scrollbar reacts to.
  final ScrollNotificationPredicate? notificationPredicate;
  /// Side of the scrollable the bar attaches to.
  final ScrollbarOrientation? scrollbarOrientation;
  /// Widget-leg style override, merged on top of the other resolver legs.
  final ScrollbarTheme? theme;
  Widget build(BuildContext context);
}
```
