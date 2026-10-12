---
title: "Class: Switcher"
description: "A swipeable container that transitions between child widgets."
---

```dart
/// A swipeable container that transitions between child widgets.
///
/// ```dart
/// Switcher(
///   index: currentIndex,
///   direction: AxisDirection.right,
///   onIndexChanged: (int index) => setState(() => currentIndex = index),
///   children: pages,
/// )
/// ```
///
/// The fractional position lives in an [AnimationController]: a drag writes its
/// value directly and a release animates it to the nearest integer. Setting
/// [index] from outside cancels any in-flight drag.
class Switcher extends StatefulWidget {
  /// Creates a switcher.
  const Switcher({super.key, this.index = 0, required this.direction, required this.children, this.onIndexChanged, this.duration, this.curve, this.theme});
  /// Index of the active child; values outside `0..children.length - 1` are
  /// clamped.
  final int index;
  /// Called when a drag snaps to an index other than the current one.
  final ValueChanged<int>? onIndexChanged;
  /// Axis the transition runs along; `right` means "the next child enters from
  /// the right".
  final AxisDirection direction;
  /// The pages to switch between; never empty.
  ///
  /// The **length** must not change after the first build: the position lives
  /// in an [AnimationController] whose range is fixed when it is created.
  /// Changing it asserts in debug; build a new [KeyedSubtree] (or give the
  /// [Switcher] a new `Key`) to swap the page list.
  final List<Widget> children;
  /// Snap-back duration; null uses [SwitcherTheme.duration].
  final Duration? duration;
  /// Snap-back curve; null uses [SwitcherTheme.curve].
  final Curve? curve;
  /// Widget-leg theme override, merged on top of the other legs.
  final SwitcherTheme? theme;
  State<Switcher> createState();
}
```
