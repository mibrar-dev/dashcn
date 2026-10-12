---
title: "Class: BorderLoading"
description: "Wraps [child] and paints a configurable border effect around it:  `BorderLoading(mode: BorderLoadingMode."
---

```dart
/// Wraps [child] and paints a configurable border effect around it:
/// `BorderLoading(mode: BorderLoadingMode.tracer, child: ...)`.
class BorderLoading extends StatefulWidget {
  const BorderLoading({super.key, required this.child, this.strokeWidth, this.padding, this.borderRadius, this.shapeBorder, this.mode, this.progress = 0.0, this.progressStream, this.tracer = const BorderTracerSpec(), this.spec = const BorderGradientSpec(), this.duration, this.curve, this.backgroundColor, this.opacity, this.theme});
  /// The wrapped content.
  final Widget child;
  /// Outline stroke thickness; null uses the theme, then `2`.
  final double? strokeWidth;
  /// Spacing between border and child; null uses `EdgeInsets.all(strokeWidth)`.
  final EdgeInsetsGeometry? padding;
  /// Rounded-rect shape used when [shapeBorder] is null; radius `12` default.
  final BorderRadiusGeometry? borderRadius;
  /// Optional shape override (circle/stadium/custom border).
  final ShapeBorder? shapeBorder;
  /// Rendering mode; null uses the theme, then `sweepGradient`.
  final BorderLoadingMode? mode;
  /// Determinate progress for [BorderLoadingMode.progress].
  final double progress;
  /// Optional progress source; stream values override [progress] (clamped).
  final Stream<double>? progressStream;
  /// Tracer segment configuration.
  final BorderTracerSpec tracer;
  /// Shader spec used by every mode.
  final BorderLoadingSpec spec;
  /// Cycle duration of the looping modes; null uses the theme, then 1200ms.
  final Duration? duration;
  /// Easing of normalized progress; null uses the theme, then linear.
  final Curve? curve;
  /// Fill painted behind the padded child; null uses the theme colour.
  final Color? backgroundColor;
  /// Global stroke opacity; null uses the theme, then `1`.
  final double? opacity;
  /// Widget-leg theme override, merged on top of the other legs.
  final BorderLoadingTheme? theme;
  State<BorderLoading> createState();
}
```
