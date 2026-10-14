---
title: "Class: GooeySurfacePill"
description: "Compact pill content: leading icon and title, cross-faded while morphing."
---

```dart
/// Compact pill content: leading icon and title, cross-faded while morphing.
///
/// Morphing keeps both frames in one [Stack] so the pill never changes size:
/// the outgoing label slides out as the incoming one slides in.
class GooeySurfacePill extends StatelessWidget {
  /// Creates pill content.
  const GooeySurfacePill({super.key, required this.title, required this.titleStyle, required this.width, required this.height, required this.morph, this.morphSlide = const Offset(0, 0.10), this.morphScaleFrom = 0.80, this.leading, this.expandUp = false, this.onTap});
  /// Measures the pill width needed to fit [title] and a 24px leading icon.
  static double measureWidth({required String title, required TextStyle style, required TextDirection direction, required double pillHeight, required double maxWidth, double extra = 10});
  /// Compact label.
  final String title;
  /// Compact label style, tone already applied.
  final TextStyle titleStyle;
  /// Pill width.
  final double width;
  /// Pill height.
  final double height;
  /// Current morph frame.
  final GooeyCompactMorphFrame morph;
  /// Slide of both frames in normalized axis units; `dy` scales with [height].
  final Offset morphSlide;
  /// Starting scale of both frames.
  final double morphScaleFrom;
  /// Leading widget (state icon).
  final Widget? leading;
  /// Whether the body grows upwards, flipping the morph slide.
  final bool expandUp;
  /// Called when the pill is tapped; null keeps the pill static.
  final VoidCallback? onTap;
  Widget build(BuildContext context);
}
```
