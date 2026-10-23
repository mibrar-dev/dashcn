// The animated check (or dash) mark of the checkbox.
//
// The mark is a stroked path that draws in once the box is filled: the
// stroke starts 50 ms after the show (the box fill runs first) and takes
// 150 ms, so the whole show is 200 ms. Hiding reverses it: the stroke
// un-draws first, then the box clears. Under reduced motion the mark snaps
// to its end state with no ticker, so nothing moves.

import 'package:flutter/widgets.dart';

import '../../primitives/motion/motion_scope.dart';
import '../../theme/motion.dart';
import '../../theme/theme.dart';

/// Lookup key of the checkbox mark paint.
const ValueKey<String> kCheckboxMarkKey = ValueKey<String>(
  'dashcn.checkbox.mark',
);

/// Fraction of the show run spent before the stroke starts (50 of 200 ms).
const double _strokeStart = 0.25;

/// Draws the check (or the indeterminate dash) with a path draw-in.
class CheckboxMark extends StatefulWidget {
  /// Creates a checkbox mark.
  const CheckboxMark({
    super.key,
    required this.shown,
    required this.indeterminate,
    required this.size,
    required this.color,
  });

  /// Whether the mark is visible (checked or indeterminate).
  final bool shown;

  /// Draws the dash instead of the check.
  final bool indeterminate;

  /// Side of the square the mark is drawn in.
  final double size;

  /// Stroke colour. Null keeps the last colour while the mark un-draws.
  final Color? color;

  @override
  State<CheckboxMark> createState() => CheckboxMarkState();
}

/// State of [CheckboxMark].
///
/// Public for tests, which read [progress] at fixed pump times.
class CheckboxMarkState extends State<CheckboxMark>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    value: widget.shown ? 1.0 : 0.0,
  );
  Color? _lastColor;

  /// Stroke progress 0..1 (the drawn fraction of the path). Snaps to 0 or 1
  /// under reduced motion.
  double get progress => _reduced
      ? (widget.shown ? 1.0 : 0.0)
      : _strokeProgress(_controller.value);

  bool get _reduced => motionReduced(context);

  /// The stroke runs over the second part of the show run.
  static double _strokeProgress(double t) {
    if (t <= _strokeStart) return 0.0;
    return ((t - _strokeStart) / (1.0 - _strokeStart)).clamp(0.0, 1.0);
  }

  @override
  void initState() {
    super.initState();
    _lastColor = widget.color;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final MotionTokens motion = Theme.of(context).motion;
    // The show run is the 50 ms lead plus the 150 ms draw (base, 200 ms).
    _controller.duration = motion.scaledDuration(motion.durations.base);
    _controller.reverseDuration = motion.scaledDuration(
      motion.durations.instant,
    );
    if (_reduced) {
      _controller.value = widget.shown ? 1.0 : 0.0;
    }
  }

  @override
  void didUpdateWidget(covariant CheckboxMark oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.color != null) {
      _lastColor = widget.color;
    }
    if (widget.shown == oldWidget.shown) {
      return;
    }
    if (_reduced) {
      _controller.value = widget.shown ? 1.0 : 0.0;
      return;
    }
    // Continue from the current value so a reversal never restarts at zero.
    if (widget.shown) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color? color = widget.color ?? _lastColor;
    if (color == null) {
      return SizedBox.square(dimension: widget.size);
    }
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          key: kCheckboxMarkKey,
          size: Size.square(widget.size),
          painter: _CheckboxMarkPainter(
            progress: progress,
            indeterminate: widget.indeterminate,
            color: color,
          ),
        );
      },
    );
  }
}

class _CheckboxMarkPainter extends CustomPainter {
  const _CheckboxMarkPainter({
    required this.progress,
    required this.indeterminate,
    required this.color,
  });

  final double progress;
  final bool indeterminate;
  final Color color;

  // Check and dash, drawn in a unit square (matches the lucide geometry).
  static final Path _check = Path()
    ..moveTo(0.2, 0.52)
    ..lineTo(0.42, 0.74)
    ..lineTo(0.8, 0.3);
  static final Path _dash = Path()
    ..moveTo(0.25, 0.5)
    ..lineTo(0.75, 0.5);

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;
    final Path unit = indeterminate ? _dash : _check;
    final Matrix4 scale = Matrix4.diagonal3Values(size.width, size.height, 1);
    final Path scaled = unit.transform(scale.storage);
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.14
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    for (final metric in scaled.computeMetrics()) {
      canvas.drawPath(metric.extractPath(0, metric.length * progress), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CheckboxMarkPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.indeterminate != indeterminate ||
        oldDelegate.color != color;
  }
}
