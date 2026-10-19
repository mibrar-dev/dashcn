// Radial painter for the `chart` radial family.
//
// Pure CustomPainter: concentric progress rings (one per series, or one per
// value for a single multi-value series), background tracks, optional grid
// circles, ring labels and a single-ring stacked mode. Negative values clamp
// to zero; empty input paints nothing.

import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'chart_cartesian_painter.dart';
import 'chart_model.dart';

/// Paints the [ChartType.radial] family.
class ChartRadialPainter extends CustomPainter {
  /// Creates a radial painter.
  const ChartRadialPainter({
    required this.series,
    required this.maxValue,
    required this.radial,
    required this.gridColor,
    required this.trackColor,
    required this.labelStyle,
    required this.progress,
    required this.selectedIndex,
    required this.textDirection,
  });

  /// Series paints (only the first value of each series is used, unless a
  /// single series carries many values — then one ring per value).
  final List<ChartSeriesPaint> series;

  /// Value at a full sweep; <= 0 is treated as 1.
  final double maxValue;

  /// Radial options.
  final ChartRadialConfig radial;

  /// Grid circle colour.
  final Color gridColor;

  /// Background track colour.
  final Color trackColor;

  /// Ring label style.
  final TextStyle labelStyle;

  /// Entrance progress 0..1 (scales sweeps).
  final double progress;

  /// Highlighted ring index or null.
  final int? selectedIndex;

  /// Layout direction (mirrors sweep).
  final TextDirection textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final List<_Ring> rings = _rings();
    if (rings.isEmpty || size.width <= 0 || size.height <= 0) {
      return;
    }
    final double radius = math.min(size.width, size.height) / 2 - 8;
    if (radius <= 0) {
      return;
    }
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double t = progress.clamp(0.0, 1.0);
    if (radial.showGrid) {
      _paintGrid(canvas, center, radius, rings.length);
    }
    if (radial.stacked) {
      _paintStacked(canvas, center, radius, rings, t);
    } else {
      _paintRings(canvas, center, radius, rings, t);
    }
  }

  /// Resolved rings: value fraction plus colour, innermost first.
  List<_Ring> _rings() {
    final List<double> values = <double>[];
    final List<Color> colors = <Color>[];
    final List<String?> labels = <String?>[];
    if (series.length == 1 && series.first.values.length > 1) {
      for (var i = 0; i < series.first.values.length; i++) {
        values.add(series.first.values[i]);
        colors.add(series.first.color);
        labels.add(null);
      }
    } else {
      for (final ChartSeriesPaint s in series) {
        if (s.values.isEmpty) {
          continue;
        }
        values.add(s.values.first);
        colors.add(s.color);
        labels.add(s.label);
      }
    }
    final double scale = maxValue > 0 ? maxValue : 1;
    final List<_Ring> out = <_Ring>[];
    for (var i = 0; i < values.length; i++) {
      out.add(
        _Ring(
          fraction: (values[i] / scale).clamp(0.0, 1.0),
          color: colors[i],
          label: labels[i],
        ),
      );
    }
    return out;
  }

  double _startAngle() {
    final double a = radial.startAngle;
    if (textDirection == TextDirection.rtl) {
      return -a;
    }
    return a;
  }

  double _sweep(double fraction, double t) {
    final double full = radial.sweep.clamp(0.05, 1.0) * 2 * math.pi;
    final double sweep = full * fraction * t;
    return textDirection == TextDirection.rtl ? -sweep : sweep;
  }

  void _paintGrid(Canvas canvas, Offset center, double radius, int count) {
    final Paint paint = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final double slot = radius / (count + 1);
    for (var i = 1; i <= count + 1; i++) {
      canvas.drawCircle(center, slot * i, paint);
    }
  }

  void _paintRings(
    Canvas canvas,
    Offset center,
    double radius,
    List<_Ring> rings,
    double t,
  ) {
    final double slot = radius / (rings.length + 1);
    final double width = slot * radial.thickness.clamp(0.1, 1.0);
    for (var i = 0; i < rings.length; i++) {
      // First series paints innermost, like recharts RadialBarChart.
      final double ringR = slot * (i + 1);
      final _Ring ring = rings[i];
      _arc(
        canvas,
        center,
        ringR,
        width,
        _startAngle(),
        _sweep(1, 1),
        trackColor,
        selected: false,
      );
      if (ring.fraction > 0) {
        _arc(
          canvas,
          center,
          ringR,
          width + (selectedIndex == i ? 2 : 0),
          _startAngle(),
          _sweep(ring.fraction, t),
          ring.color,
          selected: selectedIndex == i,
        );
      }
      if (radial.showRingLabels) {
        _paintRingLabel(canvas, center, ringR, i, ring);
      }
    }
  }

  void _paintStacked(
    Canvas canvas,
    Offset center,
    double radius,
    List<_Ring> rings,
    double t,
  ) {
    final double width = radius * 0.24 * radial.thickness.clamp(0.1, 1.0);
    final double ringR = radius - width;
    final double total = rings.fold(0.0, (a, r) => a + r.fraction);
    _arc(
      canvas,
      center,
      ringR,
      width,
      _startAngle(),
      _sweep(1, 1),
      trackColor,
      selected: false,
    );
    double cursor = 0;
    for (var i = 0; i < rings.length; i++) {
      final _Ring ring = rings[i];
      final double frac = total > 0 ? ring.fraction / total : 0;
      if (frac <= 0) {
        continue;
      }
      final double start =
          _startAngle() +
          (textDirection == TextDirection.rtl ? -cursor : cursor) *
              radial.sweep.clamp(0.05, 1.0) *
              2 *
              math.pi *
              t;
      _arc(
        canvas,
        center,
        ringR,
        width + (selectedIndex == i ? 2 : 0),
        start,
        _sweep(frac, t),
        ring.color,
        selected: selectedIndex == i,
      );
      cursor += frac;
    }
  }

  void _arc(
    Canvas canvas,
    Offset center,
    double ringR,
    double width,
    double start,
    double sweep,
    Color color, {
    required bool selected,
  }) {
    if (sweep == 0 || width <= 0 || ringR <= 0) {
      return;
    }
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: ringR),
      start,
      sweep,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = width + (selected ? 2 : 0)
        ..strokeCap = radial.rounded ? StrokeCap.round : StrokeCap.butt,
    );
  }

  void _paintRingLabel(
    Canvas canvas,
    Offset center,
    double ringR,
    int index,
    _Ring ring,
  ) {
    final String? raw = ring.label;
    if (raw == null || raw.isEmpty) {
      return;
    }
    // Capitalized white 11px label placed at the start of the arc
    // and rotated tangent to it (the LabelList insideStart look).
    final String text = raw[0].toUpperCase() + raw.substring(1);
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: labelStyle.copyWith(
          fontSize: 11,
          color: const Color(0xFFFFFFFF),
        ),
      ),
      textDirection: textDirection,
      textAlign: TextAlign.center,
    )..layout();
    final double start = _startAngle();
    final double dir = textDirection == TextDirection.rtl ? -1 : 1;
    final double angle = start + dir * 0.15;
    final Offset p = Offset(
      center.dx + math.cos(angle) * ringR,
      center.dy + math.sin(angle) * ringR,
    );
    double rot = angle + dir * math.pi / 2;
    while (rot > math.pi / 2) {
      rot -= math.pi;
    }
    while (rot < -math.pi / 2) {
      rot += math.pi;
    }
    canvas.save();
    canvas.translate(p.dx, p.dy);
    canvas.rotate(rot);
    tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant ChartRadialPainter old) {
    return old.maxValue != maxValue ||
        old.radial != radial ||
        old.gridColor != gridColor ||
        old.trackColor != trackColor ||
        old.progress != progress ||
        old.selectedIndex != selectedIndex ||
        old.textDirection != textDirection ||
        old.series.length != series.length ||
        !_same(old.series);
  }

  bool _same(List<ChartSeriesPaint> other) {
    if (other.length != series.length) {
      return false;
    }
    for (var i = 0; i < series.length; i++) {
      final ChartSeriesPaint a = series[i];
      final ChartSeriesPaint b = other[i];
      if (a.values.length != b.values.length ||
          a.color != b.color ||
          a.label != b.label) {
        return false;
      }
      for (var j = 0; j < a.values.length; j++) {
        if (a.values[j] != b.values[j]) {
          return false;
        }
      }
    }
    return true;
  }
}

/// One resolved ring: sweep fraction, colour and optional arc label.
class _Ring {
  const _Ring({required this.fraction, required this.color, this.label});

  final double fraction;
  final Color color;
  final String? label;
}
