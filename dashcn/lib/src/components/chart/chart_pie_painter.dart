// Donut/pie painter for `chart`.
//
// Pure CustomPainter: draws slices for the first series, an optional hole,
// and the hover/press highlight.

import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'chart_model.dart';

/// Paints donut and pie families.
class ChartPiePainter extends CustomPainter {
  /// Creates a pie painter.
  const ChartPiePainter({
    required this.values,
    required this.colors,
    required this.names,
    required this.hole,
    required this.pie,
    required this.labelStyle,
    required this.progress,
    required this.selectedIndex,
    required this.strokeColor,
    required this.textDirection,
  });

  /// Slice values (first series).
  final List<double> values;

  /// Slice colours.
  final List<Color> colors;

  /// Slice names, one per value.
  final List<String> names;

  /// Hole fraction 0..1 (0 is a pie).
  final double hole;

  /// Pie options.
  final ChartPieConfig pie;

  /// Slice label style.
  final TextStyle labelStyle;

  /// Entrance progress 0..1 (sweep fraction).
  final double progress;

  /// Highlighted slice or null.
  final int? selectedIndex;

  /// Divider colour between slices.
  final Color strokeColor;

  /// Layout direction.
  final TextDirection textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final double total = values.fold(0, (a, b) => a + b.abs());
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double pad = pie.labels == ChartPieLabels.outside ? 52 : 4;
    final double radius = math.min(size.width, size.height) / 2 - pad;
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
        if (pie.showDividers) {
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
      }
      consumed += sweep;
    }
    if (pie.labels != ChartPieLabels.none) {
      _paintLabels(canvas, size, center, radius, total);
    }
  }

  String _sliceName(int i) {
    if (i < names.length) {
      return names[i];
    }
    return 'Slice $i';
  }

  void _paintLabels(
    Canvas canvas,
    Size size,
    Offset center,
    double radius,
    double total,
  ) {
    double consumed = 0;
    final bool donut = hole > 0.01;
    final double innerR = donut
        ? radius - radius * (1 - hole.clamp(0.0, 0.9)) - 2
        : radius * 0.62;
    for (var i = 0; i < values.length; i++) {
      final double frac = values[i].abs() / total;
      final double sweep = math.pi * 2 * frac;
      final double mid = -math.pi / 2 + consumed + sweep / 2;
      consumed += sweep;
      if (sweep <= 0) {
        continue;
      }
      if (pie.labels == ChartPieLabels.inside) {
        if (sweep < 0.35) {
          continue;
        }
        final String text = _sliceName(i);
        final TextPainter tp = TextPainter(
          text: TextSpan(
            text: text,
            style: labelStyle.copyWith(
              color: colors[i % colors.length].computeLuminance() > 0.5
                  ? const Color(0xFF000000)
                  : const Color(0xFFFFFFFF),
            ),
          ),
          textDirection: textDirection,
          textAlign: TextAlign.center,
        )..layout();
        final Offset p = Offset(
          center.dx + math.cos(mid) * innerR,
          center.dy + math.sin(mid) * innerR,
        );
        tp.paint(canvas, Offset(p.dx - tp.width / 2, p.dy - tp.height / 2));
        continue;
      }
      // Outside: names with leader lines, or values without lines.
      final String text = pie.labelValues
          ? chartCompactValue(values[i])
          : _sliceName(i);
      final TextPainter tp = TextPainter(
        text: TextSpan(text: text, style: labelStyle),
        textDirection: textDirection,
      )..layout();
      final bool right = math.cos(mid) >= 0;
      final double elbowR = radius + 10;
      final Offset elbow = Offset(
        center.dx + math.cos(mid) * elbowR,
        center.dy + math.sin(mid) * elbowR,
      );
      final double labelX = right
          ? (center.dx + radius + 16).clamp(0, size.width - tp.width)
          : (center.dx - radius - 16 - tp.width).clamp(
              0,
              size.width - tp.width,
            );
      final Offset labelPos = Offset(labelX, elbow.dy - tp.height / 2);
      if (!pie.labelValues) {
        final Offset arc = Offset(
          center.dx + math.cos(mid) * radius,
          center.dy + math.sin(mid) * radius,
        );
        final Paint line = Paint()
          ..color = strokeColor
          ..strokeWidth = 1;
        canvas.drawLine(arc, elbow, line);
        canvas.drawLine(elbow, Offset(labelX, elbow.dy), line);
      }
      tp.paint(canvas, labelPos);
    }
  }

  @override
  bool shouldRepaint(covariant ChartPiePainter old) {
    return old.hole != hole ||
        old.pie != pie ||
        old.progress != progress ||
        old.selectedIndex != selectedIndex ||
        old.strokeColor != strokeColor ||
        old.textDirection != textDirection ||
        old.values.length != values.length ||
        !_same(old.values) ||
        !_sameNames(old.names) ||
        old.colors != colors;
  }

  bool _sameNames(List<String> other) {
    if (other.length != names.length) {
      return false;
    }
    for (var i = 0; i < names.length; i++) {
      if (names[i] != other[i]) {
        return false;
      }
    }
    return true;
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
