---
title: "Class: AnimatedStyleTransition"
description: "Fades [child] in and transforms it from [style] to rest, driven by  [animation] and eased by [curve]."
---

```dart
/// Fades [child] in and transforms it from [style] to rest, driven by
/// [animation] and eased by [curve].
///
/// Used by carousel-style components: one transition widget covers the fade,
/// slide, scale, rotate and blur combinations without a per-style class.
class AnimatedStyleTransition extends StatelessWidget {
  /// Creates a style transition.
  const AnimatedStyleTransition({super.key, required this.animation, this.curve = Curves.easeOut, this.style = const AnimatedTransitionStyle(), required this.child});
  /// Drives the transition; 0 is the start, 1 is at rest.
  final Animation<double> animation;
  /// Easing applied to [animation].
  final Curve curve;
  /// The starting transform.
  final AnimatedTransitionStyle style;
  /// The child that settles into place.
  final Widget child;
  Widget build(BuildContext context);
}
```
