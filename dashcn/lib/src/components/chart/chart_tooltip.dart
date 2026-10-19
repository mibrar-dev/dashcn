// Anchored tooltip widget for `chart`: flip, clamp and custom bodies.
//
// Widgets-only. Positioning maths lives in `chart_tooltip_placement.dart`
// (pure, unit-tested); this file only lays out and paints.

import 'package:flutter/widgets.dart';

import 'chart_model.dart';
import 'chart_style.dart';
import 'chart_tooltip_placement.dart';

/// Gutter kept around the tooltip inside the chart frame.
const double chartTooltipGutter = 8;

/// Gap kept between the mark anchor and the tooltip box.
const double chartTooltipGap = 8;

/// Default max width for the tooltip box (capped to the frame at layout).
const double chartTooltipDefaultMaxWidth = 260;

/// Positions [child] near [anchor] with flip then clamp.
///
/// Caps the child width to the frame minus the gutter on both sides and
/// re-runs on every layout (resize/orientation). Clamp keeps an 8 px inset
/// inside the chart frame.
class ChartAnchoredTooltip extends StatelessWidget {
  /// Creates an anchored tooltip.
  const ChartAnchoredTooltip({
    super.key,
    required this.anchor,
    required this.placement,
    required this.offset,
    required this.child,
    this.gutter = chartTooltipGutter,
    this.gap = chartTooltipGap,
  });

  /// Mark pixel in chart-frame coordinates.
  final Offset anchor;

  /// Preferred side; flips when crowded.
  final ChartTooltipPlacement placement;

  /// Extra shift applied to the anchor.
  final Offset offset;

  /// Tooltip body.
  final Widget child;

  /// Inset kept inside the chart frame.
  final double gutter;

  /// Gap kept between the anchor and the box.
  final double gap;

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildLayout(
      delegate: _ChartTooltipDelegate(
        anchor: anchor,
        placement: placement,
        offset: offset,
        gutter: gutter,
        gap: gap,
      ),
      child: child,
    );
  }
}

class _ChartTooltipDelegate extends SingleChildLayoutDelegate {
  const _ChartTooltipDelegate({
    required this.anchor,
    required this.placement,
    required this.offset,
    required this.gutter,
    required this.gap,
  });

  final Offset anchor;
  final ChartTooltipPlacement placement;
  final Offset offset;
  final double gutter;
  final double gap;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final double maxW = chartTooltipMaxWidth(
      constraints.maxWidth,
      gutter: gutter,
    );
    final double capped = maxW < chartTooltipDefaultMaxWidth
        ? maxW
        : chartTooltipDefaultMaxWidth;
    return BoxConstraints(
      minWidth: 0,
      maxWidth: capped <= 0 ? constraints.maxWidth : capped,
      minHeight: 0,
      maxHeight: constraints.maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final ChartTooltipLayout layout = resolveChartTooltip(
      anchor: anchor,
      tooltipSize: childSize,
      frameSize: size,
      placement: placement,
      offset: offset,
      gutter: gutter,
      gap: gap,
    );
    return layout.origin;
  }

  @override
  bool shouldRelayout(covariant _ChartTooltipDelegate old) {
    return old.anchor != anchor ||
        old.placement != placement ||
        old.offset != offset ||
        old.gutter != gutter ||
        old.gap != gap;
  }
}

/// Default tooltip card: title plus one row per series.
///
/// Used when [ChartTooltipConfig.builder] is null. Mirrors the previous
/// top-centre card (popover fill, 6 px radius, grid border) so the tooltip
/// family keeps its look while gaining an anchor.
class ChartTooltipCard extends StatelessWidget {
  /// Creates a default tooltip card.
  const ChartTooltipCard({
    super.key,
    required this.data,
    required this.config,
    required this.surface,
  });

  /// Hovered index, label and rows.
  final ChartTooltipData data;

  /// Content options (indicator, formatters, total).
  final ChartTooltipConfig config;

  /// Resolved colours and text styles.
  final ChartSurface surface;

  @override
  Widget build(BuildContext context) {
    if (config.builder != null) {
      return config.builder!(context, data);
    }
    String? title;
    if (config.showLabel) {
      title = data.label;
    }
    double total = 0;
    for (final ChartTooltipRow row in data.rows) {
      total += row.value;
    }
    return Container(
      constraints: const BoxConstraints(maxWidth: chartTooltipDefaultMaxWidth),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: surface.tooltipFill,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: surface.gridColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                title,
                style: surface.tickStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          for (final ChartTooltipRow row in data.rows) _row(row, strong: false),
          if (config.showTotal && data.rows.length > 1)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: surface.gridColor)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: _row(
                    ChartTooltipRow(
                      label: config.totalLabel,
                      value: total,
                      color: surface.tooltipStyle.color,
                    ),
                    strong: true,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _row(ChartTooltipRow row, {required bool strong}) {
    final TextStyle style = strong
        ? surface.tooltipStyle.copyWith(fontWeight: FontWeight.w600)
        : surface.tooltipStyle;
    final String value =
        '${(config.valueFormatter ?? chartCompactValue)(row.value)}${config.valueSuffix ?? ''}';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (row.icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: IconTheme(
                data: IconThemeData(color: row.color, size: 14),
                child: row.icon!,
              ),
            )
          else if (config.indicator != ChartTooltipIndicator.none)
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: _swatch(config.indicator, row.color),
            ),
          Flexible(
            child: Text(
              row.label,
              style: style,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          Text(value, style: style, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _swatch(ChartTooltipIndicator indicator, Color? color) {
    if (indicator == ChartTooltipIndicator.line) {
      return Container(width: 12, height: 3, color: color);
    }
    return Container(
      width: 9,
      height: 9,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
