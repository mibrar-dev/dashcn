// Pure anchor maths for chart tooltips: mark pixel from data index.
//
// Widgets-only and `dart:math` only. No `BuildContext`, so the helpers are
// unit-testable. The widget layer computes the plot rect with the same
// gutters as the cartesian painter, then asks for the anchor of the
// selected index.

import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Anchor for vertical cartesian families (bar/line/area/scatter).
///
/// [plot] is the plot rect, [index]/[count] pick the category and
/// [topValue] is the highest stacked value at that index (already in data
/// units). [min]/[max] are the axis extents. When [centered] is true the x
/// sits at the bucket centre (bars); otherwise it spreads edge to edge
/// (lines). Set [rtl] to mirror x for right-to-left layouts.
Offset chartCartesianAnchor({
  required Rect plot,
  required int index,
  required int count,
  required double topValue,
  required double min,
  required double max,
  required bool centered,
  required bool horizontal,
  required bool rtl,
  required double baseline,
}) {
  double x;
  double y;
  if (horizontal) {
    final double rowY = count <= 1
        ? plot.center.dy
        : plot.top + (index + 0.5) / count * plot.height;
    double t = 0;
    if (max > min) {
      t = ((topValue - baseline) / (max - baseline)).clamp(0.0, 1.0);
      if ((max - baseline).abs() < 1e-9) {
        t = 0;
      }
    }
    double px = plot.left + t * plot.width;
    if (rtl) {
      px = plot.right - (px - plot.left);
    }
    x = px;
    y = rowY;
  } else {
    if (centered) {
      x = count <= 1
          ? plot.center.dx
          : plot.left + (index + 0.5) / count * plot.width;
    } else {
      if (count <= 1) {
        x = plot.center.dx;
      } else {
        final double t = index / (count - 1);
        x = plot.left + t * plot.width;
      }
    }
    if (rtl) {
      x = plot.right - (x - plot.left);
    }
    double t = 0;
    if (max > min) {
      t = ((topValue - min) / (max - min)).clamp(0.0, 1.0);
    } else {
      t = 0.5;
    }
    y = plot.bottom - t * plot.height;
  }
  return Offset(x, y);
}

/// Anchor over a pie/donut sector: mid-angle at ~62% of the radius.
///
/// [size] is the chart frame, [values] the first-series values, [index]
/// the selected slice and [hole] the donut hole fraction. [outsideLabels]
/// mirrors the painter pad (52 px when outside, else 4 px).
Offset chartPieAnchor({
  required Size size,
  required List<double> values,
  required int index,
  required double hole,
  required bool outsideLabels,
}) {
  final double total = values.fold(0.0, (a, b) => a + b.abs());
  if (total <= 0 || values.isEmpty) {
    return Offset(size.width / 2, size.height / 2);
  }
  final Offset center = Offset(size.width / 2, size.height / 2);
  final double pad = outsideLabels ? 52 : 4;
  final double radius = math.min(size.width, size.height) / 2 - pad;
  if (radius <= 0) {
    return center;
  }
  double consumed = 0;
  for (var i = 0; i < values.length; i++) {
    final double frac = values[i].abs() / total;
    final double sweep = math.pi * 2 * frac;
    if (i == index) {
      final double mid = -math.pi / 2 + consumed + sweep / 2;
      final double r = hole > 0.01 ? radius * 0.72 : radius * 0.62;
      return Offset(
        center.dx + math.cos(mid) * r,
        center.dy + math.sin(mid) * r,
      );
    }
    consumed += sweep;
  }
  return center;
}

/// Anchor over a radial ring: mid-arc point of the selected ring.
Offset chartRadialAnchor({
  required Size size,
  required int index,
  required int rings,
  required double fraction,
  required double startAngle,
  required double sweepFraction,
}) {
  final Offset center = Offset(size.width / 2, size.height / 2);
  final double radius = math.min(size.width, size.height) / 2 - 8;
  if (radius <= 0 || rings <= 0) {
    return center;
  }
  final double slot = radius / (rings + 1);
  final double ringR = slot * (index.clamp(0, rings - 1) + 1);
  final double sweep = sweepFraction.clamp(0.05, 1.0) * 2 * math.pi;
  final double mid = startAngle + sweep * fraction.clamp(0.0, 1.0) / 2;
  return Offset(
    center.dx + math.cos(mid) * ringR,
    center.dy + math.sin(mid) * ringR,
  );
}

/// Anchor for radar: vertex in the selected axis direction.
Offset chartRadarAnchor({
  required Size size,
  required int index,
  required int count,
  required bool rtl,
}) {
  final Offset center = Offset(size.width / 2, size.height / 2);
  if (count < 3) {
    return center;
  }
  final double radius = math.min(size.width, size.height) / 2 - 32;
  if (radius <= 0) {
    return center;
  }
  double angle = -math.pi / 2 + index * 2 * math.pi / count;
  if (rtl) {
    angle = -angle - math.pi;
  }
  return Offset(
    center.dx + math.cos(angle) * radius * 0.8,
    center.dy + math.sin(angle) * radius * 0.8,
  );
}
