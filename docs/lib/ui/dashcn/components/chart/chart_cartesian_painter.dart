// Cartesian painter for `chart`: line, area, bar, sparkline, scatter.
//
// Pure CustomPainter: draws grid, axes, ticks, series and selection
// highlight inside the plot rect. Text labels use TextPainter.

import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'chart_model.dart';

/// Resolved per-series paint values computed by the widget.
class ChartSeriesPaint {
  /// Creates paint values.
  const ChartSeriesPaint({
    required this.values,
    required this.color,
    required this.gradient,
    required this.strokeWidth,
    required this.dash,
    required this.showMarkers,
    required this.markerRadius,
    required this.fillOpacity,
    required this.barRadius,
  });

  /// Animated values.
  final List<double> values;

  /// Series colour.
  final Color color;

  /// Fill gradient override.
  final Gradient? gradient;

  /// Line width.
  final double strokeWidth;

  /// Dash pattern or null.
  final List<double>? dash;

  /// Whether markers paint.
  final bool showMarkers;

  /// Marker radius.
  final double markerRadius;

  /// Fill opacity.
  final double fillOpacity;

  /// Bar radius.
  final double barRadius;
}

/// Paints cartesian chart families.
class ChartCartesianPainter extends CustomPainter {
  /// Creates a cartesian painter.
  const ChartCartesianPainter({
    required this.type,
    required this.barMode,
    required this.series,
    required this.min,
    required this.max,
    required this.ticks,
    required this.format,
    required this.xLabels,
    required this.gridColor,
    required this.axisColor,
    required this.tickStyle,
    required this.showGrid,
    required this.showAxes,
    required this.showTicks,
    required this.showLabels,
    required this.progress,
    required this.selectedIndex,
    required this.barGap,
    required this.barGroupGap,
    required this.textDirection,
  });

  /// Chart family (cartesian subset).
  final ChartType type;

  /// Bar arrangement.
  final ChartBarMode barMode;

  /// Series paints.
  final List<ChartSeriesPaint> series;

  /// Y range.
  final double min;

  /// Y range.
  final double max;

  /// Y tick values.
  final List<double> ticks;

  /// Tick formatter.
  final String Function(double) format;

  /// X category labels.
  final List<String>? xLabels;

  /// Grid colour.
  final Color gridColor;

  /// Axis colour.
  final Color axisColor;

  /// Tick label style.
  final TextStyle tickStyle;

  /// Flags.
  final bool showGrid;

  /// Flags.
  final bool showAxes;

  /// Flags.
  final bool showTicks;

  /// Flags.
  final bool showLabels;

  /// Entrance progress 0..1.
  final double progress;

  /// Highlighted category index or null.
  final int? selectedIndex;

  /// Gap fractions.
  final double barGap;

  /// Gap fractions.
  final double barGroupGap;

  /// Layout direction.
  final TextDirection textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    const double leftGutter = 40;
    const double bottomGutter = 20;
    const double topPad = 8;
    const double rightPad = 8;
    final bool minimal = type == ChartType.sparkline;
    final double plotLeft = minimal || !showLabels ? 4 : leftGutter;
    final double plotBottom = minimal || !showLabels ? 4 : bottomGutter;
    final Rect plot = Rect.fromLTWH(
      plotLeft,
      topPad,
      math.max(0, size.width - plotLeft - rightPad),
      math.max(0, size.height - topPad - plotBottom),
    );
    if (plot.width <= 0 || plot.height <= 0) {
      return;
    }
    if (!minimal) {
      _paintGridAndAxes(canvas, size, plot);
    }
    switch (type) {
      case ChartType.line:
      case ChartType.area:
      case ChartType.sparkline:
        _paintLines(canvas, plot);
        break;
      case ChartType.bar:
        _paintBars(canvas, plot);
        break;
      case ChartType.scatter:
        _paintScatter(canvas, plot);
        break;
      case ChartType.donut:
      case ChartType.pie:
        break;
    }
  }

  double _yToPx(double value, Rect plot) {
    if (!(max > min)) {
      return plot.center.dy;
    }
    final double t = ((value - min) / (max - min)).clamp(0.0, 1.0);
    return plot.bottom - t * plot.height;
  }

  double _xToPx(int index, int count, Rect plot) {
    if (count <= 1) {
      return plot.center.dx;
    }
    final double t = index / (count - 1);
    if (textDirection == TextDirection.rtl) {
      return plot.right - t * plot.width;
    }
    return plot.left + t * plot.width;
  }

  void _paintGridAndAxes(Canvas canvas, Size size, Rect plot) {
    final Paint grid = Paint()
      ..color = gridColor
      ..strokeWidth = 1;
    final Paint axis = Paint()
      ..color = axisColor
      ..strokeWidth = 1;
    final double span = (max - min).abs() < 1e-9 ? 1 : max - min;
    for (final tick in ticks) {
      final double y = _yToPx(tick, plot);
      if (showGrid) {
        canvas.drawLine(Offset(plot.left, y), Offset(plot.right, y), grid);
      }
      if (showTicks) {
        canvas.drawLine(Offset(plot.left - 5, y), Offset(plot.left, y), axis);
      }
      if (showLabels) {
        final TextPainter tp = TextPainter(
          text: TextSpan(text: format(tick), style: tickStyle),
          textDirection: textDirection,
        )..layout();
        tp.paint(canvas, Offset(plot.left - 6 - tp.width, y - tp.height / 2));
      }
    }
    if (showAxes) {
      canvas.drawLine(
        Offset(plot.left, plot.top),
        Offset(plot.left, plot.bottom),
        axis,
      );
      canvas.drawLine(
        Offset(plot.left, plot.bottom),
        Offset(plot.right, plot.bottom),
        axis,
      );
    }
    if (showLabels) {
      final int n = _categoryCount();
      final int step = n > 6 ? (n / 6).ceil() : 1;
      for (var i = 0; i < n; i += step) {
        final String label = _xLabel(i);
        final TextPainter tp = TextPainter(
          text: TextSpan(text: label, style: tickStyle),
          textDirection: textDirection,
        )..layout(maxWidth: 72);
        final double x = _xToPx(i, n, plot);
        tp.paint(
          canvas,
          Offset(
            (x - tp.width / 2).clamp(0, size.width - tp.width),
            plot.bottom + 4,
          ),
        );
      }
    }
    // Silence unused warning for span in minimal range guard.
    span.isNaN;
  }

  int _categoryCount() {
    var n = 0;
    for (final s in series) {
      n = math.max(n, s.values.length);
    }
    if (xLabels != null) {
      n = math.max(n, xLabels!.length);
    }
    return n;
  }

  String _xLabel(int i) {
    if (xLabels != null && i < xLabels!.length) {
      return xLabels![i];
    }
    return '$i';
  }

  void _paintLines(Canvas canvas, Rect plot) {
    for (var si = 0; si < series.length; si++) {
      final ChartSeriesPaint s = series[si];
      final int n = s.values.length;
      if (n == 0) {
        continue;
      }
      final int reveal = (progress * n).ceil().clamp(1, n);
      final List<Offset> pts = <Offset>[
        for (var i = 0; i < reveal; i++)
          Offset(_xToPx(i, n, plot), _yToPx(s.values[i], plot)),
      ];
      final bool isArea = type == ChartType.area;
      if (isArea && pts.length > 1) {
        final Path fill = Path()..moveTo(pts.first.dx, plot.bottom);
        for (final p in pts) {
          fill.lineTo(p.dx, p.dy);
        }
        fill.lineTo(pts.last.dx, plot.bottom);
        fill.close();
        final Paint fp = Paint()..style = PaintingStyle.fill;
        if (s.gradient != null) {
          fp.shader = s.gradient!.createShader(plot);
        } else {
          fp.color = s.color.withValues(alpha: s.color.a * s.fillOpacity);
        }
        canvas.drawPath(fill, fp);
      }
      if (pts.length == 1) {
        canvas.drawCircle(pts.first, s.strokeWidth, Paint()..color = s.color);
      } else {
        _strokePath(canvas, pts, s);
      }
      if (s.showMarkers && type != ChartType.sparkline) {
        for (var i = 0; i < pts.length; i++) {
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
          selectedIndex! < pts.length &&
          type != ChartType.sparkline) {
        final Offset p = pts[selectedIndex!];
        canvas.drawCircle(
          p,
          s.markerRadius + 2,
          Paint()
            ..color = s.color.withValues(alpha: s.color.a * 0.25)
            ..style = PaintingStyle.fill,
        );
        canvas.drawCircle(p, s.markerRadius + 1, Paint()..color = s.color);
      }
    }
  }

  void _strokePath(Canvas canvas, List<Offset> pts, ChartSeriesPaint s) {
    final Paint paint = Paint()
      ..color = s.color
      ..strokeWidth = s.strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    if (s.dash == null || s.dash!.isEmpty) {
      canvas.drawPath(_smooth(pts), paint);
      return;
    }
    canvas.drawPath(_dashed(_smooth(pts), s.dash!), paint);
  }

  Path _smooth(List<Offset> pts) {
    final Path path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (var i = 1; i < pts.length; i++) {
      path.lineTo(pts[i].dx, pts[i].dy);
    }
    return path;
  }

  Path _dashed(Path source, List<double> dash) {
    // Approximate dash by sampling the path metrics.
    final Path out = Path();
    for (final metric in source.computeMetrics()) {
      double dist = 0;
      var draw = true;
      var di = 0;
      while (dist < metric.length) {
        final double len = dash[di % dash.length].clamp(1.0, 1e6);
        final double next = math.min(dist + len, metric.length);
        if (draw) {
          out.addPath(metric.extractPath(dist, next), Offset.zero);
        }
        dist = next;
        draw = !draw;
        di++;
      }
    }
    return out;
  }

  void _paintBars(Canvas canvas, Rect plot) {
    final int n = _categoryCount();
    if (n == 0 || series.isEmpty) {
      return;
    }
    final int reveal = (progress * n).ceil().clamp(0, n);
    final double step = plot.width / n;
    final double groupW = step * (1 - barGroupGap);
    if (barMode == ChartBarMode.stacked) {
      final List<double> posBase = List<double>.filled(n, 0);
      final List<double> negBase = List<double>.filled(n, 0);
      final double lo = math.min(0, min);
      for (final s in series) {
        for (var i = 0; i < n && i < reveal; i++) {
          final double v = i < s.values.length ? s.values[i] : 0;
          final double base = v >= 0 ? posBase[i] : negBase[i];
          final double top = base + v;
          final Rect bar = _barRect(
            plot,
            step,
            groupW,
            1,
            0,
            1,
            i,
            lo,
            base,
            top,
          );
          _drawBar(canvas, bar, s, selectedIndex == i);
          if (v >= 0) {
            posBase[i] = top;
          } else {
            negBase[i] = top;
          }
        }
      }
      return;
    }
    final int m = series.length;
    final double slot = groupW / m;
    final double bw = slot * (1 - barGap);
    for (var si = 0; si < series.length; si++) {
      final ChartSeriesPaint s = series[si];
      for (var i = 0; i < n && i < reveal; i++) {
        final double v = i < s.values.length ? s.values[i] : 0;
        final double lo = math.min(0, min);
        final Rect bar = _barRect(plot, step, groupW, m, si, bw, i, lo, lo, v);
        _drawBar(canvas, bar, s, selectedIndex == i);
      }
    }
  }

  Rect _barRect(
    Rect plot,
    double step,
    double groupW,
    int m,
    int si,
    double bw,
    int i,
    double lo,
    double base,
    double top,
  ) {
    double x = plot.left + step * i + (step - groupW) / 2;
    if (m > 1 && barMode == ChartBarMode.grouped) {
      x += si * (groupW / m);
    }
    final double w = m > 1 && barMode == ChartBarMode.grouped
        ? bw
        : groupW * (1 - barGap);
    final double yTop =
        (_yToPx(top.clamp(lo, max), plot) * progress.clamp(0, 1));
    // Grow from the baseline with entrance progress.
    final double baseline = _yToPx(lo, plot);
    final double animatedTop = baseline + (yTop - baseline) * 1;
    final double left = textDirection == TextDirection.rtl
        ? plot.right - (x - plot.left) - w
        : x;
    return Rect.fromLTRB(
      left,
      math.min(baseline, animatedTop),
      left + w,
      math.max(baseline, animatedTop),
    );
  }

  void _drawBar(Canvas canvas, Rect bar, ChartSeriesPaint s, bool selected) {
    if (bar.height < 0.5 || bar.width < 0.5) {
      return;
    }
    final RRect rr = RRect.fromRectAndRadius(bar, Radius.circular(s.barRadius));
    final Paint paint = Paint()..style = PaintingStyle.fill;
    if (s.gradient != null) {
      paint.shader = s.gradient!.createShader(bar);
    } else {
      paint.color = selected
          ? s.color
          : s.color.withValues(alpha: s.color.a * 0.9);
    }
    canvas.drawRRect(rr, paint);
    if (selected) {
      canvas.drawRRect(
        rr,
        Paint()
          ..color = s.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
  }

  void _paintScatter(Canvas canvas, Rect plot) {
    for (final s in series) {
      final int n = s.values.length;
      final int reveal = (progress * n).ceil().clamp(0, n);
      for (var i = 0; i < reveal; i++) {
        final Offset p = Offset(_xToPx(i, n, plot), _yToPx(s.values[i], plot));
        final bool sel = selectedIndex == i;
        canvas.drawCircle(
          p,
          s.markerRadius + 1 + (sel ? 2 : 0),
          Paint()
            ..color = s.color.withValues(alpha: s.color.a * (sel ? 1 : 0.85)),
        );
        if (sel) {
          canvas.drawCircle(
            p,
            s.markerRadius + 4,
            Paint()
              ..color = s.color
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.5,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant ChartCartesianPainter old) {
    return old.type != type ||
        old.barMode != barMode ||
        old.min != min ||
        old.max != max ||
        old.ticks != ticks ||
        old.progress != progress ||
        old.selectedIndex != selectedIndex ||
        old.gridColor != gridColor ||
        old.axisColor != axisColor ||
        old.showGrid != showGrid ||
        old.showAxes != showAxes ||
        old.showTicks != showTicks ||
        old.showLabels != showLabels ||
        old.barGap != barGap ||
        old.barGroupGap != barGroupGap ||
        old.textDirection != textDirection ||
        !_sameSeries(old.series);
  }

  bool _sameSeries(List<ChartSeriesPaint> other) {
    if (other.length != series.length) {
      return false;
    }
    for (var i = 0; i < series.length; i++) {
      final a = series[i];
      final b = other[i];
      if (a.values.length != b.values.length ||
          a.color != b.color ||
          a.strokeWidth != b.strokeWidth ||
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
