// Donut/pie painter for `chart`.
//
// Pure CustomPainter: draws slices for the first series, an optional hole,
// and the hover/press highlight.

import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Paints donut and pie families.
class ChartPiePainter extends CustomPainter {
  /// Creates a pie painter.
  const ChartPiePainter({
    required this.values,
    required this.colors,
    required this.hole,
    required this.progress,
    required this.selectedIndex,
    required this.strokeColor,
  });

  /// Slice values (first series).
  final List<double> values;

  /// Slice colours.
  final List<Color> colors;

  /// Hole fraction 0..1 (0 is a pie).
  final double hole;

  /// Entrance progress 0..1 (sweep fraction).
  final double progress;

  /// Highlighted slice or null.
  final int? selectedIndex;

  /// Divider colour between slices.
  final Color strokeColor;

  @override
  void paint(Canvas canvas, Size size) {
    final double total = values.fold(0, (a, b) => a + b.abs());
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = math.min(size.width, size.height) / 2 - 4;
    if (radius <= 0 || total <= 0) {
      return;
    }
    double start = -math.pi / 2;
    final double sweepTotal = math.pi * 2 * progress.clamp(0.0, 1.0);
    double consumed = 0;
    final bool donut = hole > 0.01;
    final double ringWidth = donut
        ? radius * (1 - hole.clamp(0.0, 0.9))
        : radius;
    final double ringRadius = donut ? radius - ringWidth / 2 : radius;
    for (var i = 0; i < values.length; i++) {
      final double frac = values[i].abs() / total;
      final double sweep = math.pi * 2 * frac;
      final double drawStart = start + consumed;
      final double remaining = sweepTotal - consumed;
      if (remaining <= 0) {
        break;
      }
      final double drawSweep = math.min(sweep, remaining);
      final bool sel = selectedIndex == i;
      final Offset offsetCenter = sel
          ? Offset(
              center.dx + math.cos(drawStart + drawSweep / 2) * 6,
              center.dy + math.sin(drawStart + drawSweep / 2) * 6,
            )
          : center;
      final Color color = colors[i % colors.length];
      if (donut) {
        final Rect rect = Rect.fromCircle(
          center: offsetCenter,
          radius: ringRadius,
        );
        canvas.drawArc(
          rect,
          drawStart,
          drawSweep,
          false,
          Paint()
            ..color = color
            ..style = PaintingStyle.stroke
            ..strokeWidth = ringWidth + (sel ? 3 : 0)
            ..strokeCap = StrokeCap.butt,
        );
      } else {
        final Paint fill = Paint()
          ..color = color
          ..style = PaintingStyle.fill;
        final Rect rect = Rect.fromCircle(center: offsetCenter, radius: radius);
        canvas.drawArc(rect, drawStart, drawSweep, true, fill);
        canvas.drawArc(
          rect,
          drawStart,
          drawSweep,
          true,
          Paint()
            ..color = strokeColor
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        );
      }
      consumed += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant ChartPiePainter old) {
    return old.hole != hole ||
        old.progress != progress ||
        old.selectedIndex != selectedIndex ||
        old.strokeColor != strokeColor ||
        old.values.length != values.length ||
        !_same(old.values) ||
        old.colors != colors;
  }

  bool _same(List<double> other) {
    if (other.length != values.length) {
      return false;
    }
    for (var i = 0; i < values.length; i++) {
      if (values[i] != other[i]) {
        return false;
      }
    }
    return true;
  }
}
