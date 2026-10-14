---
title: "Class: ClickDetector"
description: "Counts consecutive taps inside a time and distance window."
---

```dart
/// Counts consecutive taps inside a time and distance window.
///
/// ```dart
/// ClickDetector(
///   threshold: const Duration(milliseconds: 300),
///   onClick: (ClickDetails details) => print(details.clickCount),
///   child: tile,
/// )
/// ```
///
/// A click is part of the current sequence when it arrives within
/// [threshold] of the previous one **and** within [kDoubleTapSlop] of it. The
/// first click of a sequence reports `clickCount: 1`.
class ClickDetector extends StatefulWidget {
  /// Creates a click counter.
  const ClickDetector({super.key, this.onClick, required this.child, this.behavior = HitTestBehavior.deferToChild, this.threshold = const Duration(milliseconds: 300)});
  /// Called for every tap with the running click count. A null callback
  /// disables the detector, so no gesture recogniser is built.
  final ClickCallback<ClickDetails>? onClick;
  /// The widget that receives the clicks.
  final Widget child;
  /// How to behave during hit testing.
  final HitTestBehavior behavior;
  /// Longest gap between two clicks that still counts as consecutive.
  final Duration threshold;
  State<ClickDetector> createState();
}
```
