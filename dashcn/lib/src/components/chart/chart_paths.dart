// Line path builders and area stacking math for the `chart` component.
//
// Pure functions (no widgets): strokes for the three [ChartLineStyle]s and
// the per-index stacking bands behind stacked/expanded areas. Tested without
// widgets in `chart_test.dart`.

import 'package:flutter/widgets.dart';

import 'chart_model.dart';

/// One stacked band: fill paints between [base] and [top].
typedef ChartStackBand = ({double base, double top});

/// Stroke path through [pts] for [style].
Path chartLinePath(List<Offset> pts, ChartLineStyle style) {
  if (pts.length < 3 || style == ChartLineStyle.linear) {
    final Path path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (var i = 1; i < pts.length; i++) {
      path.lineTo(pts[i].dx, pts[i].dy);
    }
    return path;
  }
  if (style == ChartLineStyle.step) {
    return chartStepPath(pts);
  }
  return chartSmoothPath(pts);
}

/// Right-angle steps: horizontal first, then vertical (step-after).
Path chartStepPath(List<Offset> pts) {
  final Path path = Path()..moveTo(pts.first.dx, pts.first.dy);
  for (var i = 1; i < pts.length; i++) {
    path.lineTo(pts[i].dx, pts[i - 1].dy);
    path.lineTo(pts[i].dx, pts[i].dy);
  }
  return path;
}

/// Catmull-Rom spline through [pts] as cubic segments.
Path chartSmoothPath(List<Offset> pts) {
  final Path path = Path()..moveTo(pts.first.dx, pts.first.dy);
  for (var i = 0; i < pts.length - 1; i++) {
    final Offset p0 = pts[i == 0 ? 0 : i - 1];
    final Offset p1 = pts[i];
    final Offset p2 = pts[i + 1];
    final Offset p3 = pts[i + 2 > pts.length - 1 ? pts.length - 1 : i + 2];
    final Offset c1 = Offset(
      p1.dx + (p2.dx - p0.dx) / 6,
      p1.dy + (p2.dy - p0.dy) / 6,
    );
    final Offset c2 = Offset(
      p2.dx - (p3.dx - p1.dx) / 6,
      p2.dy - (p3.dy - p1.dy) / 6,
    );
    path.cubicTo(c1.dx, c1.dy, c2.dx, c2.dy, p2.dx, p2.dy);
  }
  return path;
}

/// Per-series stacking bands for stacked areas.
///
/// Positive values stack upward from zero, negatives downward (mirroring
/// stacked bars). With [expanded], every index normalises by its total so
/// bands span 0..1 (an all-zero index maps to zero). Short series read as
/// zero past their end.
List<List<ChartStackBand>> chartStackBands(
  List<List<double>> series, {
  required bool expanded,
}) {
  var n = 0;
  for (final List<double> values in series) {
    if (values.length > n) {
      n = values.length;
    }
  }
  final List<List<ChartStackBand>> out = <List<ChartStackBand>>[
    for (var s = 0; s < series.length; s++)
      List<ChartStackBand>.filled(n, (base: 0, top: 0)),
  ];
  for (var i = 0; i < n; i++) {
    if (expanded) {
      double total = 0;
      for (final List<double> values in series) {
        total += i < values.length ? values[i] : 0;
      }
      double run = 0;
      for (var s = 0; s < series.length; s++) {
        final double v = i < series[s].length ? series[s][i] : 0;
        final double frac = total == 0 ? 0 : v / total;
        out[s][i] = (base: run, top: run + frac);
        run += frac;
      }
    } else {
      double pos = 0;
      double neg = 0;
      for (var s = 0; s < series.length; s++) {
        final double v = i < series[s].length ? series[s][i] : 0;
        if (v >= 0) {
          out[s][i] = (base: pos, top: pos + v);
          pos += v;
        } else {
          out[s][i] = (base: neg + v, top: neg);
          neg += v;
        }
      }
    }
  }
  return out;
}
