// Polar painter for the `chart` radar family.
//
// Pure CustomPainter: concentric polygon/circle grid, spokes, one polygon
// per series, dots at the vertices and optional axis labels. Negative values
// clamp to the centre; empty input paints nothing.

import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'chart_cartesian_painter.dart';
import 'chart_model.dart';

/// Paints the [ChartType.radar] family.
class ChartRadarPainter extends CustomPainter {
  /// Creates a radar painter.
  const ChartRadarPainter({
    required this.series,
    required this.maxValue,
    required this.categories,
    required this.radar,
    required this.gridColor,
    required this.tickStyle,
    required this.progress,
    required this.selectedIndex,
    required this.textDirection,
  });

  /// Series paints (values are raw data, normalised by [maxValue]).
  final List<ChartSeriesPaint> series;

  /// Value at the outer ring; <= 0 is treated as 1.
  final double maxValue;

  /// Axis names, one per category.
  final List<String> categories;

  /// Grid options.
  final ChartRadarConfig radar;

  /// Grid colour.
  final Color gridColor;

  /// Axis label style.
  final TextStyle tickStyle;

  /// Entrance progress 0..1 (scales radii).
  final double progress;

  /// Highlighted axis index or null.
  final int? selectedIndex;

  /// Layout direction (mirrors vertex order).
  final TextDirection textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final int n = _axisCount();
    if (n < 3 || size.width <= 0 || size.height <= 0) {
      return;
    }
    final double scale = maxValue > 0 ? maxValue : 1;
    final List<TextPainter> labels = <TextPainter>[
      for (var i = 0; i < n; i++)
        TextPainter(
          text: TextSpan(text: _axisLabel(i), style: tickStyle),
          textDirection: textDirection,
          textAlign: TextAlign.center,
        )..layout(),
    ];
    final List<TextPainter> values = <TextPainter>[
      if (radar.showValues)
        for (var i = 0; i < n; i++)
          TextPainter(
            text: TextSpan(text: _axisValues(i), style: tickStyle),
            textDirection: textDirection,
            textAlign: TextAlign.center,
          )..layout(),
    ];
    double widest = 0;
    for (final TextPainter label in labels) {
      widest = math.max(widest, label.width);
    }
    for (final TextPainter value in values) {
      widest = math.max(widest, value.width);
    }
    final double labelH =
        (labels.isEmpty ? 12 : labels.first.height) +
        (values.isEmpty ? 0 : values.first.height + 2);
    final double radius = math.max(
      0,
      math.min(
        (size.width - widest - 24) / 2,
        (size.height - labelH * 2 - 24) / 2,
      ),
    );
    if (radius <= 0) {
      return;
    }
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double t = progress.clamp(0.0, 1.0);
    final int rings = radar.rings.clamp(1, 8);
    if (radar.grid != ChartRadarGrid.none) {
      _paintGrid(canvas, center, radius, rings, t);
    }
    if (radar.showSpokes) {
      final Paint spoke = Paint()
        ..color = gridColor
        ..strokeWidth = 1;
      for (var i = 0; i < n; i++) {
        final Offset vertex = _point(center, radius * t, i, n);
        canvas.drawLine(center, vertex, spoke);
      }
    }
    for (var si = 0; si < series.length; si++) {
      _paintSeries(canvas, center, radius, scale, n, si, t);
    }
    _paintLabels(canvas, center, radius, n, labels, values);
  }

  int _axisCount() {
    var n = categories.length;
    for (final ChartSeriesPaint s in series) {
      n = math.max(n, s.values.length);
    }
    return n;
  }

  String _axisLabel(int i) {
    if (i < categories.length) {
      return categories[i];
    }
    return '$i';
  }

  String _axisValues(int i) {
    final List<String> parts = <String>[];
    for (final ChartSeriesPaint s in series) {
      final double v = i < s.values.length ? s.values[i] : 0;
      parts.add(_compact(v));
    }
    return parts.join('/');
  }

  String _compact(double v) {
    if (v == v.roundToDouble()) {
      return v.toInt().toString();
    }
    return v.toStringAsFixed(1);
  }

  Offset _point(Offset center, double r, int i, int n) {
    final double angle = -math.pi / 2 + i * 2 * math.pi / n;
    final bool rtl = textDirection == TextDirection.rtl;
    final double a = rtl ? -angle - math.pi : angle;
    return Offset(center.dx + math.cos(a) * r, center.dy + math.sin(a) * r);
  }

  Path _ring(Offset center, double r, int n) {
    if (radar.grid == ChartRadarGrid.circle) {
      return Path()..addOval(Rect.fromCircle(center: center, radius: r));
    }
    final Path path = Path();
    for (var i = 0; i < n; i++) {
      final Offset p = _point(center, r, i, n);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();
    return path;
  }

  void _paintGrid(
    Canvas canvas,
    Offset center,
    double radius,
    int rings,
    double t,
  ) {
    final int n = _axisCount();
    for (var k = rings; k >= 1; k--) {
      final double r = radius * (k / rings) * t;
      if (r <= 0) {
        continue;
      }
      if (radar.filled) {
        canvas.drawPath(
          _ring(center, r, n),
          Paint()..color = gridColor.withValues(alpha: gridColor.a * 0.12),
        );
      }
      canvas.drawPath(
        _ring(center, r, n),
        Paint()
          ..color = gridColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
    }
  }

  void _paintSeries(
    Canvas canvas,
    Offset center,
    double radius,
    double scale,
    int n,
    int si,
    double t,
  ) {
    final ChartSeriesPaint s = series[si];
    final Path path = Path();
    final List<Offset> pts = <Offset>[];
    for (var i = 0; i < n; i++) {
      final double v = i < s.values.length ? s.values[i] : 0;
      final double frac = (v / scale).clamp(0.0, 1.0);
      final Offset p = _point(center, radius * frac * t, i, n);
      pts.add(p);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();
    canvas.drawPath(
      path,
      Paint()..color = s.color.withValues(alpha: s.color.a * s.fillOpacity),
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = s.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = s.strokeWidth
        ..strokeJoin = StrokeJoin.round,
    );
    if (s.showMarkers) {
      for (var i = 0; i < n; i++) {
        final bool sel = selectedIndex == i;
        canvas.drawCircle(
          pts[i],
          s.markerRadius + (sel ? 2 : 0),
          Paint()..color = s.color,
        );
        canvas.drawCircle(
          pts[i],
          s.markerRadius + (sel ? 2 : 0),
          Paint()
            ..color = const Color(0xFFFFFFFF)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5,
        );
      }
    } else if (selectedIndex != null &&
        selectedIndex! >= 0 &&
        selectedIndex! < n) {
      final Offset p = pts[selectedIndex!];
      canvas.drawCircle(
        p,
        s.markerRadius + 2,
        Paint()..color = s.color.withValues(alpha: s.color.a * 0.25),
      );
      canvas.drawCircle(p, s.markerRadius + 1, Paint()..color = s.color);
    }
  }

  void _paintLabels(
    Canvas canvas,
    Offset center,
    double radius,
    int n,
    List<TextPainter> labels,
    List<TextPainter> values,
  ) {
    for (var i = 0; i < n; i++) {
      final Offset outer = _point(center, radius + 8, i, n);
      double dy = outer.dy - labels[i].height / 2;
      if (i == 0) {
        dy = outer.dy - labels[i].height - 2;
      } else if ((i * 2) == n) {
        dy = outer.dy + 2;
      }
      double dx = outer.dx - labels[i].width / 2;
      dx = dx.clamp(0, double.infinity);
      if (radar.showValues && i < values.length) {
        values[i].paint(canvas, Offset(dx, dy));
        labels[i].paint(
          canvas,
          Offset(outer.dx - labels[i].width / 2, dy + values[i].height + 2),
        );
      } else {
        labels[i].paint(canvas, Offset(dx, dy));
      }
    }
  }

  @override
  bool shouldRepaint(covariant ChartRadarPainter old) {
    return old.maxValue != maxValue ||
        old.categories != categories ||
        old.radar != radar ||
        old.gridColor != gridColor ||
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
          a.fillOpacity != b.fillOpacity ||
          a.showMarkers != b.showMarkers) {
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
