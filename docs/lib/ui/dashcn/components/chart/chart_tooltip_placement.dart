// Pure placement maths for anchored chart tooltips.
//
// Widgets-only: `Offset`, `Size` and `Rect` come from `widgets.dart`.
// No `BuildContext`, no layout, so this file is unit-testable.

import 'package:flutter/widgets.dart';

/// Where the tooltip sits relative to its mark.
enum ChartTooltipPlacement {
  /// Above the mark (the default).
  top,

  /// Below the mark.
  bottom,

  /// To the left of the mark.
  left,

  /// To the right of the mark.
  right,
}

/// Resolved tooltip origin plus the placement actually used.
class ChartTooltipLayout {
  /// Creates a resolved layout.
  const ChartTooltipLayout({required this.origin, required this.placement});

  /// Top-left origin inside the chart frame.
  final Offset origin;

  /// Placement after flip (may differ from the request).
  final ChartTooltipPlacement placement;
}

/// Picks the radar tooltip side: toward the chart interior.
///
/// * [anchor] above the frame middle requests [ChartTooltipPlacement.bottom]
///   (the box hangs below the vertex, over the web, clear of the label ring).
/// * [anchor] at or below the middle requests [ChartTooltipPlacement.top].
///
/// Vertical only on purpose: the axis labels sit to the left and right of
/// every upper vertex, so a left/right box from a top vertex always lands on
/// a neighbour label (June to the left, February to the right on a
/// January–June web). The interior has no labels. Flip and clamp still apply
/// downstream in [resolveChartTooltip], and callers honour an explicit
/// non-default [ChartTooltipConfig.placement] untouched.
ChartTooltipPlacement chartRadarTooltipPlacement({
  required Offset anchor,
  required Size frameSize,
}) {
  return anchor.dy < frameSize.height / 2
      ? ChartTooltipPlacement.bottom
      : ChartTooltipPlacement.top;
}

/// Resolves the full radar tooltip request: interior side plus band clearance.
///
/// Returns the [chartRadarTooltipPlacement] side and the total offset: the
/// caller's [baseOffset] plus, for bottom-placed boxes only, a downward push
/// so the box top clears the upper side-label band. The band bottom sits at
/// roughly `frameHeight / 2 - 42` (half the side-label span below the centre
/// on the default 260 px height; on taller frames the target only moves the
/// box deeper over the label-free interior, never back over labels).
/// Lower-half vertices keep plain top placement: their boxes already sit
/// mid-chart, and pushing them further up would drive them into the upper
/// band. [gap] must match the tooltip widget's gap.
({ChartTooltipPlacement placement, Offset offset}) resolveRadarTooltip({
  required Offset anchor,
  required Size frameSize,
  required Offset baseOffset,
  double gap = 8,
}) {
  final ChartTooltipPlacement placement = chartRadarTooltipPlacement(
    anchor: anchor,
    frameSize: frameSize,
  );
  if (placement == ChartTooltipPlacement.top) {
    return (placement: placement, offset: baseOffset);
  }
  final double target = frameSize.height / 2 - 42;
  final double deficit = target - (anchor.dy + gap + baseOffset.dy);
  if (deficit <= 0) {
    return (placement: placement, offset: baseOffset);
  }
  return (placement: placement, offset: baseOffset + Offset(0, deficit));
}

/// Snaps a local pointer offset to the nearest category index.
///
/// [local] is the pointer position along the axis, [extent] is the chart
/// extent (width or height) and [count] is the category count. Uses the
/// centred bucket rule (`(i + 0.5) / count`), so index 0 centres at
/// `extent / count / 2`. Returns 0 when there is nothing to snap to.
int chartTooltipNearestIndex(double local, double extent, int count) {
  if (count <= 0 || extent <= 0) {
    return 0;
  }
  if (count == 1) {
    return 0;
  }
  final double t = (local / extent * count - 0.5).roundToDouble();
  return t.clamp(0, count - 1).toInt();
}

/// Snaps a local offset to the nearest spread point (line/area/scatter).
///
/// Points sit at `i / (count - 1)`, so the first point is at 0 and the last
/// at [extent]. Returns 0 when there is nothing to snap to.
int chartTooltipNearestSpreadIndex(double local, double extent, int count) {
  if (count <= 0 || extent <= 0) {
    return 0;
  }
  if (count == 1) {
    return 0;
  }
  final double t = (local / extent * (count - 1)).roundToDouble();
  return t.clamp(0, count - 1).toInt();
}

/// Caps the tooltip width to the frame minus the gutter on both sides.
double chartTooltipMaxWidth(double frameWidth, {double gutter = 8}) {
  final double max = frameWidth - gutter * 2;
  return max < 0 ? 0 : max;
}

/// Resolves where a tooltip of [tooltipSize] should sit for [anchor].
///
/// * Applies [offset] to the anchor, then places the box [gap] px away
///   along [placement].
/// * Flips (top<->bottom, left<->right) when there is no room on the
///   requested side but there is room on the other side.
/// * Clamps the result into [frameSize] with an [gutter] inset.
///
/// All inputs are in the same chart-frame coordinate space.
ChartTooltipLayout resolveChartTooltip({
  required Offset anchor,
  required Size tooltipSize,
  required Size frameSize,
  required ChartTooltipPlacement placement,
  Offset offset = Offset.zero,
  double gutter = 8,
  double gap = 8,
}) {
  final Offset adjusted = anchor + offset;
  final double w = tooltipSize.width;
  final double h = tooltipSize.height;
  final double fw = frameSize.width;
  final double fh = frameSize.height;

  Offset originFor(ChartTooltipPlacement p) {
    switch (p) {
      case ChartTooltipPlacement.top:
        return Offset(adjusted.dx - w / 2, adjusted.dy - h - gap);
      case ChartTooltipPlacement.bottom:
        return Offset(adjusted.dx - w / 2, adjusted.dy + gap);
      case ChartTooltipPlacement.left:
        return Offset(adjusted.dx - w - gap, adjusted.dy - h / 2);
      case ChartTooltipPlacement.right:
        return Offset(adjusted.dx + gap, adjusted.dy - h / 2);
    }
  }

  bool fits(Offset o) {
    return o.dx >= gutter &&
        o.dy >= gutter &&
        o.dx + w <= fw - gutter &&
        o.dy + h <= fh - gutter;
  }

  ChartTooltipPlacement flipped(ChartTooltipPlacement p) {
    switch (p) {
      case ChartTooltipPlacement.top:
        return ChartTooltipPlacement.bottom;
      case ChartTooltipPlacement.bottom:
        return ChartTooltipPlacement.top;
      case ChartTooltipPlacement.left:
        return ChartTooltipPlacement.right;
      case ChartTooltipPlacement.right:
        return ChartTooltipPlacement.left;
    }
  }

  ChartTooltipPlacement resolved = placement;
  Offset origin = originFor(placement);
  if (!fits(origin)) {
    final ChartTooltipPlacement alt = flipped(placement);
    final Offset altOrigin = originFor(alt);
    if (fits(altOrigin)) {
      resolved = alt;
      origin = altOrigin;
    }
  }

  double x = origin.dx;
  double y = origin.dy;
  if (fw - gutter * 2 <= 0 || w >= fw - gutter * 2) {
    x = gutter;
  } else {
    if (x < gutter) {
      x = gutter;
    }
    final double maxX = fw - w - gutter;
    if (x > maxX) {
      x = maxX < gutter ? gutter : maxX;
    }
  }
  if (fh - gutter * 2 <= 0 || h >= fh - gutter * 2) {
    y = gutter;
  } else {
    if (y < gutter) {
      y = gutter;
    }
    final double maxY = fh - h - gutter;
    if (y > maxY) {
      y = maxY < gutter ? gutter : maxY;
    }
  }
  return ChartTooltipLayout(origin: Offset(x, y), placement: resolved);
}
