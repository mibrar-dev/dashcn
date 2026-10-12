---
title: "Class: GooeySwipe"
description: "Wraps [child] with a directional swipe-to-dismiss gesture."
---

```dart
/// Wraps [child] with a directional swipe-to-dismiss gesture.
class GooeySwipe extends StatefulWidget {
  /// Creates a swipe wrapper.
  const GooeySwipe({super.key, required this.child, required this.directions, required this.onDismissed, this.threshold = 72});
  /// Wrapped surface.
  final Widget child;
  /// Directions that trigger the dismissal.
  final Set<ToastSwipeDirection> directions;
  /// Called once when a valid dismiss drag or fling ends.
  final VoidCallback onDismissed;
  /// Minimum drag distance in logical px.
  final double threshold;
  State<GooeySwipe> createState();
}
```
