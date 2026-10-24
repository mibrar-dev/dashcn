// The `progress` component: one linear bar that covers both the old
// `Progress` and `LinearProgressIndicator` components.
//
// Determinate when [Progress.value] is non-null, indeterminate (a sweeping
// segment) when it is null. Widgets-only `CustomPaint`; the old Material
// import and the two-component split are gone (see P4-B03 report).

import 'package:flutter/widgets.dart';

import '../../primitives/animation.dart';
import '../../primitives/motion/motion_scope.dart';
import '../../theme/motion.dart';
import '../../theme/theme.dart';
import 'progress_style.dart';

export 'progress_style.dart';

/// Length of one indeterminate sweep, in fractions of the bar width.
const double _indeterminateSegment = 0.3;

/// One sweep cycle.
const Duration _indeterminateDuration = Duration(milliseconds: 1400);

/// A horizontal progress bar.
///
/// ```dart
/// const Progress(value: 0.4);        // determinate
/// const Progress();                  // indeterminate
/// const Progress(value: 0.4, showSparks: true);
/// ```
///
/// A determinate bar animates value changes over the theme base duration
/// unless [disableAnimation] is set. Values are fractions in `0..1`; values
/// outside the range are clamped. Use `semanticsLabel`/`semanticsValue` for
/// accessible progress reporting.
///
/// The indeterminate sweep keeps its loop; under reduced motion it renders
/// one static segment with no ticker.
class Progress extends StatefulWidget {
  /// Creates a progress bar.
  const Progress({
    super.key,
    this.value,
    this.height,
    this.borderRadius,
    this.color,
    this.backgroundColor,
    this.showSparks,
    this.disableAnimation,
    this.semanticsLabel,
    this.semanticsValue,
    this.theme,
  });

  /// Fraction complete in `0..1`, or null for an indeterminate bar.
  final double? value;

  /// Bar height override.
  final double? height;

  /// Corner radius override.
  final BorderRadiusGeometry? borderRadius;

  /// Fill colour override.
  final Color? color;

  /// Track colour override.
  final Color? backgroundColor;

  /// Whether to paint a glow at the leading edge.
  final bool? showSparks;

  /// Whether value changes jump instead of animating.
  final bool? disableAnimation;

  /// Semantic label, e.g. `'Uploading'`.
  final String? semanticsLabel;

  /// Semantic value, e.g. `'40%'`.
  final String? semanticsValue;

  /// Widget-leg theme override, merged on top of the other legs.
  final ProgressTheme? theme;

  @override
  State<Progress> createState() => _ProgressState();
}

/// State of [Progress]: remembers the previous determinate value so value
/// changes tween from the old fill to the new one.
class _ProgressState extends State<Progress> {
  double? _from;

  @override
  void didUpdateWidget(covariant Progress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _from = oldWidget.value?.clamp(0.0, 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProgressSurface surface = resolveProgressSurface(
      context,
      widgetTheme: widget.theme,
      height: widget.height,
      borderRadius: widget.borderRadius,
      color: widget.color,
      backgroundColor: widget.backgroundColor,
      showSparks: widget.showSparks,
      disableAnimation: widget.disableAnimation,
    );
    final TextDirection direction = Directionality.of(context);
    final double? normalized = widget.value?.clamp(0.0, 1.0);
    final bool reduced = motionReduced(context);
    final MotionTokens motion = Theme.of(context).motion;

    final Widget bar = normalized == null
        ? reduced
              // Static mid-sweep segment: the same painter, no ticker.
              ? CustomPaint(
                  size: Size.infinite,
                  painter: _ProgressPainter(
                    start: 0.35,
                    end: 0.65,
                    color: surface.color,
                    backgroundColor: surface.backgroundColor,
                    showSparks: surface.showSparks,
                    textDirection: direction,
                  ),
                )
              : RepeatedAnimationBuilder(
                  start: 0,
                  end: 1,
                  duration: _indeterminateDuration,
                  builder: (context, t, child) {
                    final double start =
                        -_indeterminateSegment +
                        t * (1 + _indeterminateSegment);
                    return CustomPaint(
                      size: Size.infinite,
                      painter: _ProgressPainter(
                        start: start,
                        end: start + _indeterminateSegment,
                        color: surface.color,
                        backgroundColor: surface.backgroundColor,
                        showSparks: surface.showSparks,
                        textDirection: direction,
                      ),
                    );
                  },
                )
        : TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: _from, end: normalized),
            duration: !surface.animate || reduced
                ? Duration.zero
                : motion.durations.slow,
            curve: motion.curves.standard,
            onEnd: () => _from = normalized,
            builder: (context, animated, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: _ProgressPainter(
                  start: 0,
                  end: animated,
                  color: surface.color,
                  backgroundColor: surface.backgroundColor,
                  showSparks: surface.showSparks,
                  textDirection: direction,
                ),
              );
            },
          );

    return Semantics(
      label: widget.semanticsLabel,
      value: widget.semanticsValue,
      child: ClipRRect(
        borderRadius: surface.borderRadius,
        child: SizedBox(height: surface.height, child: bar),
      ),
    );
  }
}

/// Paints a track and a fill segment, mirrored for RTL.
class _ProgressPainter extends CustomPainter {
  const _ProgressPainter({
    required this.start,
    required this.end,
    required this.color,
    required this.backgroundColor,
    required this.showSparks,
    required this.textDirection,
  });

  /// Fill start, in fractions of the width.
  final double start;

  /// Fill end, in fractions of the width.
  final double end;

  /// Fill colour.
  final Color color;

  /// Track colour.
  final Color backgroundColor;

  /// Whether to paint the leading-edge glow.
  final bool showSparks;

  /// Painting direction.
  final TextDirection textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final bool rtl = textDirection == TextDirection.rtl;
    final double from = (rtl ? 1 - end : start).clamp(0.0, 1.0);
    final double to = (rtl ? 1 - start : end).clamp(0.0, 1.0);
    final Paint paint = Paint()..style = PaintingStyle.fill;

    paint.color = backgroundColor;
    canvas.drawRect(Offset.zero & size, paint);

    if (to > from) {
      paint.color = color;
      canvas.drawRect(
        Rect.fromLTWH(
          size.width * from,
          0,
          size.width * (to - from),
          size.height,
        ),
        paint,
      );
    }

    if (showSparks && to > from) {
      final Offset center = Offset(size.width * to, size.height / 2);
      final double radius = size.height * 2;
      paint.shader = RadialGradient(
        colors: <Color>[color, color.withValues(alpha: 0)],
        stops: const <double>[0, 1],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawCircle(center, radius, paint);
      paint.shader = null;
    }
  }

  @override
  bool shouldRepaint(covariant _ProgressPainter oldDelegate) {
    return oldDelegate.start != start ||
        oldDelegate.end != end ||
        oldDelegate.color != color ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.showSparks != showSparks ||
        oldDelegate.textDirection != textDirection;
  }
}
