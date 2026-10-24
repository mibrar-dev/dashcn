// Registry-owned theme data for the `chart` component.
//
// User-owned overrides live in `chart_theme.dart`; CLI updates may replace
// this file. The widget reads the resolved theme through
// `resolveComponentStyle<ChartTheme, ChartTheme>`.

import 'dart:ui' show lerpDouble;

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';

/// Visual contract for every chart family.
class ChartTheme extends ComponentThemeData implements Mergeable<ChartTheme> {
  /// Creates a chart theme.
  const ChartTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.backgroundColor,
    this.gridColor,
    this.axisColor,
    this.tickLabelStyle,
    this.legendTextStyle,
    this.tooltipBackground,
    this.tooltipTextStyle,
    this.seriesColors,
    this.strokeWidth,
    this.markerRadius,
    this.barRadius,
    this.barGap,
    this.barGroupGap,
    this.fillOpacity,
    this.contentPadding,
    this.showGrid,
    this.showAxes,
    this.showTicks,
    this.showLabels,
    this.showLegend,
    this.showTooltip,
    this.showMarkers,
    this.animationDuration,
    this.animationCurve,
    this.disableAnimation,
    this.donutHole,
  });

  /// Chart background; null is transparent.
  final ThemedColor? backgroundColor;

  /// Grid line colour; null resolves `border`.
  final ThemedColor? gridColor;

  /// Axis line colour; null resolves `border`.
  final ThemedColor? axisColor;

  /// Tick label style; null resolves 11px muted foreground.
  final TextStyle? tickLabelStyle;

  /// Legend label style; null resolves 12px foreground.
  final TextStyle? legendTextStyle;

  /// Tooltip fill; null resolves `popover`.
  final ThemedColor? tooltipBackground;

  /// Tooltip text style; null resolves 12px popover foreground.
  final TextStyle? tooltipTextStyle;

  /// Series palette; null resolves chart1..5.
  final List<ThemedColor>? seriesColors;

  /// Line width default.
  final double? strokeWidth;

  /// Marker dot radius default.
  final double? markerRadius;

  /// Bar corner radius default.
  final double? barRadius;

  /// Gap between bars in the same category (0..1 of the slot).
  final double? barGap;

  /// Gap between categories (0..1 of the step).
  final double? barGroupGap;

  /// Area/bar fill opacity default (0..1).
  final double? fillOpacity;

  /// Inset around the plot area.
  final EdgeInsetsGeometry? contentPadding;

  /// Whether grid paints by default.
  final bool? showGrid;

  /// Whether axes paint by default.
  final bool? showAxes;

  /// Whether ticks paint by default.
  final bool? showTicks;

  /// Whether tick labels paint by default.
  final bool? showLabels;

  /// Whether the legend paints by default.
  final bool? showLegend;

  /// Whether the hover/press tooltip paints by default.
  final bool? showTooltip;

  /// Whether line/scatter markers paint by default.
  final bool? showMarkers;

  /// Entrance and value-tween duration.
  final Duration? animationDuration;

  /// Entrance and value-tween curve.
  final Curve? animationCurve;

  /// Whether value changes jump instead of animating.
  final bool? disableAnimation;

  /// Donut hole fraction (0..1); 0 is a pie.
  final double? donutHole;

  /// Returns a copy with the given fields replaced.
  ChartTheme copyWith({
    ValueGetter<ThemedColor?>? backgroundColor,
    ValueGetter<ThemedColor?>? gridColor,
    ValueGetter<ThemedColor?>? axisColor,
    ValueGetter<TextStyle?>? tickLabelStyle,
    ValueGetter<TextStyle?>? legendTextStyle,
    ValueGetter<ThemedColor?>? tooltipBackground,
    ValueGetter<TextStyle?>? tooltipTextStyle,
    ValueGetter<List<ThemedColor>?>? seriesColors,
    ValueGetter<double?>? strokeWidth,
    ValueGetter<double?>? markerRadius,
    ValueGetter<double?>? barRadius,
    ValueGetter<double?>? barGap,
    ValueGetter<double?>? barGroupGap,
    ValueGetter<double?>? fillOpacity,
    ValueGetter<EdgeInsetsGeometry?>? contentPadding,
    ValueGetter<bool?>? showGrid,
    ValueGetter<bool?>? showAxes,
    ValueGetter<bool?>? showTicks,
    ValueGetter<bool?>? showLabels,
    ValueGetter<bool?>? showLegend,
    ValueGetter<bool?>? showTooltip,
    ValueGetter<bool?>? showMarkers,
    ValueGetter<Duration?>? animationDuration,
    ValueGetter<Curve?>? animationCurve,
    ValueGetter<bool?>? disableAnimation,
    ValueGetter<double?>? donutHole,
  }) {
    return ChartTheme(
      themeDensity: themeDensity,
      themeSpacing: themeSpacing,
      themeShadows: themeShadows,
      backgroundColor: backgroundColor == null
          ? this.backgroundColor
          : backgroundColor(),
      gridColor: gridColor == null ? this.gridColor : gridColor(),
      axisColor: axisColor == null ? this.axisColor : axisColor(),
      tickLabelStyle: tickLabelStyle == null
          ? this.tickLabelStyle
          : tickLabelStyle(),
      legendTextStyle: legendTextStyle == null
          ? this.legendTextStyle
          : legendTextStyle(),
      tooltipBackground: tooltipBackground == null
          ? this.tooltipBackground
          : tooltipBackground(),
      tooltipTextStyle: tooltipTextStyle == null
          ? this.tooltipTextStyle
          : tooltipTextStyle(),
      seriesColors: seriesColors == null ? this.seriesColors : seriesColors(),
      strokeWidth: strokeWidth == null ? this.strokeWidth : strokeWidth(),
      markerRadius: markerRadius == null ? this.markerRadius : markerRadius(),
      barRadius: barRadius == null ? this.barRadius : barRadius(),
      barGap: barGap == null ? this.barGap : barGap(),
      barGroupGap: barGroupGap == null ? this.barGroupGap : barGroupGap(),
      fillOpacity: fillOpacity == null ? this.fillOpacity : fillOpacity(),
      contentPadding: contentPadding == null
          ? this.contentPadding
          : contentPadding(),
      showGrid: showGrid == null ? this.showGrid : showGrid(),
      showAxes: showAxes == null ? this.showAxes : showAxes(),
      showTicks: showTicks == null ? this.showTicks : showTicks(),
      showLabels: showLabels == null ? this.showLabels : showLabels(),
      showLegend: showLegend == null ? this.showLegend : showLegend(),
      showTooltip: showTooltip == null ? this.showTooltip : showTooltip(),
      showMarkers: showMarkers == null ? this.showMarkers : showMarkers(),
      animationDuration: animationDuration == null
          ? this.animationDuration
          : animationDuration(),
      animationCurve: animationCurve == null
          ? this.animationCurve
          : animationCurve(),
      disableAnimation: disableAnimation == null
          ? this.disableAnimation
          : disableAnimation(),
      donutHole: donutHole == null ? this.donutHole : donutHole(),
    );
  }

  @override
  ChartTheme merge(ChartTheme? fallback) {
    if (fallback == null) {
      return this;
    }
    return ChartTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      backgroundColor: backgroundColor ?? fallback.backgroundColor,
      gridColor: gridColor ?? fallback.gridColor,
      axisColor: axisColor ?? fallback.axisColor,
      tickLabelStyle: tickLabelStyle ?? fallback.tickLabelStyle,
      legendTextStyle: legendTextStyle ?? fallback.legendTextStyle,
      tooltipBackground: tooltipBackground ?? fallback.tooltipBackground,
      tooltipTextStyle: tooltipTextStyle ?? fallback.tooltipTextStyle,
      seriesColors: seriesColors ?? fallback.seriesColors,
      strokeWidth: strokeWidth ?? fallback.strokeWidth,
      markerRadius: markerRadius ?? fallback.markerRadius,
      barRadius: barRadius ?? fallback.barRadius,
      barGap: barGap ?? fallback.barGap,
      barGroupGap: barGroupGap ?? fallback.barGroupGap,
      fillOpacity: fillOpacity ?? fallback.fillOpacity,
      contentPadding: contentPadding ?? fallback.contentPadding,
      showGrid: showGrid ?? fallback.showGrid,
      showAxes: showAxes ?? fallback.showAxes,
      showTicks: showTicks ?? fallback.showTicks,
      showLabels: showLabels ?? fallback.showLabels,
      showLegend: showLegend ?? fallback.showLegend,
      showTooltip: showTooltip ?? fallback.showTooltip,
      showMarkers: showMarkers ?? fallback.showMarkers,
      animationDuration: animationDuration ?? fallback.animationDuration,
      animationCurve: animationCurve ?? fallback.animationCurve,
      disableAnimation: disableAnimation ?? fallback.disableAnimation,
      donutHole: donutHole ?? fallback.donutHole,
    );
  }

  /// Colours and flags step; dimensions lerp.
  static ChartTheme lerp(ChartTheme a, ChartTheme b, double t) {
    return ChartTheme(
      themeDensity: t < 0.5 ? a.themeDensity : b.themeDensity,
      themeSpacing: t < 0.5 ? a.themeSpacing : b.themeSpacing,
      themeShadows: t < 0.5 ? a.themeShadows : b.themeShadows,
      backgroundColor: t < 0.5 ? a.backgroundColor : b.backgroundColor,
      gridColor: t < 0.5 ? a.gridColor : b.gridColor,
      axisColor: t < 0.5 ? a.axisColor : b.axisColor,
      tickLabelStyle: TextStyle.lerp(a.tickLabelStyle, b.tickLabelStyle, t),
      legendTextStyle: TextStyle.lerp(a.legendTextStyle, b.legendTextStyle, t),
      tooltipBackground: t < 0.5 ? a.tooltipBackground : b.tooltipBackground,
      tooltipTextStyle: TextStyle.lerp(
        a.tooltipTextStyle,
        b.tooltipTextStyle,
        t,
      ),
      seriesColors: t < 0.5 ? a.seriesColors : b.seriesColors,
      strokeWidth: lerpDouble(a.strokeWidth, b.strokeWidth, t),
      markerRadius: lerpDouble(a.markerRadius, b.markerRadius, t),
      barRadius: lerpDouble(a.barRadius, b.barRadius, t),
      barGap: lerpDouble(a.barGap, b.barGap, t),
      barGroupGap: lerpDouble(a.barGroupGap, b.barGroupGap, t),
      fillOpacity: lerpDouble(a.fillOpacity, b.fillOpacity, t),
      contentPadding: EdgeInsetsGeometry.lerp(
        a.contentPadding,
        b.contentPadding,
        t,
      ),
      showGrid: t < 0.5 ? a.showGrid : b.showGrid,
      showAxes: t < 0.5 ? a.showAxes : b.showAxes,
      showTicks: t < 0.5 ? a.showTicks : b.showTicks,
      showLabels: t < 0.5 ? a.showLabels : b.showLabels,
      showLegend: t < 0.5 ? a.showLegend : b.showLegend,
      showTooltip: t < 0.5 ? a.showTooltip : b.showTooltip,
      showMarkers: t < 0.5 ? a.showMarkers : b.showMarkers,
      animationDuration: t < 0.5 ? a.animationDuration : b.animationDuration,
      animationCurve: t < 0.5 ? a.animationCurve : b.animationCurve,
      disableAnimation: t < 0.5 ? a.disableAnimation : b.disableAnimation,
      donutHole: lerpDouble(a.donutHole, b.donutHole, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ChartTheme &&
        other.themeDensity == themeDensity &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.backgroundColor == backgroundColor &&
        other.gridColor == gridColor &&
        other.axisColor == axisColor &&
        other.tickLabelStyle == tickLabelStyle &&
        other.legendTextStyle == legendTextStyle &&
        other.tooltipBackground == tooltipBackground &&
        other.tooltipTextStyle == tooltipTextStyle &&
        other.seriesColors == seriesColors &&
        other.strokeWidth == strokeWidth &&
        other.markerRadius == markerRadius &&
        other.barRadius == barRadius &&
        other.barGap == barGap &&
        other.barGroupGap == barGroupGap &&
        other.fillOpacity == fillOpacity &&
        other.contentPadding == contentPadding &&
        other.showGrid == showGrid &&
        other.showAxes == showAxes &&
        other.showTicks == showTicks &&
        other.showLabels == showLabels &&
        other.showLegend == showLegend &&
        other.showTooltip == showTooltip &&
        other.showMarkers == showMarkers &&
        other.animationDuration == animationDuration &&
        other.animationCurve == animationCurve &&
        other.disableAnimation == disableAnimation &&
        other.donutHole == donutHole;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[
    themeDensity,
    themeSpacing,
    themeShadows,
    backgroundColor,
    gridColor,
    axisColor,
    tickLabelStyle,
    legendTextStyle,
    tooltipBackground,
    tooltipTextStyle,
    seriesColors,
    strokeWidth,
    markerRadius,
    barRadius,
    barGap,
    barGroupGap,
    fillOpacity,
    contentPadding,
    showGrid,
    showAxes,
    showTicks,
    showLabels,
    showLegend,
    showTooltip,
    showMarkers,
    animationDuration,
    animationCurve,
    disableAnimation,
    donutHole,
  ]);
}

/// Token-derived baseline.
const ChartTheme chartDefaults = ChartTheme(
  backgroundColor: null,
  gridColor: ThemedColor.ref(ColorRef.border),
  axisColor: ThemedColor.ref(ColorRef.border),
  seriesColors: <ThemedColor>[
    ThemedColor.ref(ColorRef.chart1),
    ThemedColor.ref(ColorRef.chart2),
    ThemedColor.ref(ColorRef.chart3),
    ThemedColor.ref(ColorRef.chart4),
    ThemedColor.ref(ColorRef.chart5),
  ],
  strokeWidth: 2,
  markerRadius: 3,
  barRadius: 4,
  barGap: 0.2,
  barGroupGap: 0.25,
  fillOpacity: 0.25,
  showGrid: true,
  showAxes: true,
  showTicks: true,
  showLabels: true,
  showLegend: true,
  showTooltip: true,
  showMarkers: false,
  animationDuration: Duration(milliseconds: 600),
  animationCurve: Curves.easeOutCubic,
  disableAnimation: false,
  donutHole: 0.55,
);

// ---------------------------------------------------------------------------
// Build-time resolution.
// ---------------------------------------------------------------------------

/// Resolved visual values for one chart build.
class ChartSurface {
  /// Creates a resolved surface.
  const ChartSurface({
    required this.gridColor,
    required this.axisColor,
    required this.tickStyle,
    required this.legendStyle,
    required this.tooltipFill,
    required this.tooltipStyle,
    required this.seriesPalette,
    required this.strokeWidth,
    required this.markerRadius,
    required this.barRadius,
    required this.barGap,
    required this.barGroupGap,
    required this.fillOpacity,
    required this.contentPadding,
    required this.showGrid,
    required this.showAxes,
    required this.showTicks,
    required this.showLabels,
    required this.showLegend,
    required this.showTooltip,
    required this.showMarkers,
    required this.animationDuration,
    required this.animationCurve,
    required this.animate,
    required this.donutHole,
    required this.backgroundColor,
  });

  /// Grid colour.
  final Color gridColor;

  /// Axis colour.
  final Color axisColor;

  /// Tick label style.
  final TextStyle tickStyle;

  /// Legend label style.
  final TextStyle legendStyle;

  /// Tooltip fill.
  final Color tooltipFill;

  /// Tooltip text style.
  final TextStyle tooltipStyle;

  /// Resolved series palette.
  final List<Color> seriesPalette;

  /// Line width.
  final double strokeWidth;

  /// Marker radius.
  final double markerRadius;

  /// Bar corner radius.
  final double barRadius;

  /// In-category gap fraction.
  final double barGap;

  /// Between-category gap fraction.
  final double barGroupGap;

  /// Area/bar fill opacity.
  final double fillOpacity;

  /// Plot inset.
  final EdgeInsetsGeometry contentPadding;

  /// Flags.
  final bool showGrid;

  /// Flags.
  final bool showAxes;

  /// Flags.
  final bool showTicks;

  /// Flags.
  final bool showLabels;

  /// Flags.
  final bool showLegend;

  /// Flags.
  final bool showTooltip;

  /// Flags.
  final bool showMarkers;

  /// Animation.
  final Duration animationDuration;

  /// Animation.
  final Curve animationCurve;

  /// Whether value changes animate.
  final bool animate;

  /// Donut hole fraction.
  final double donutHole;

  /// Background (may be transparent).
  final Color? backgroundColor;
}

/// Resolves the four theme legs plus widget-leg overrides.
ChartSurface resolveChartSurface(
  BuildContext context, {
  ChartTheme? widgetTheme,
  bool? showGrid,
  bool? showAxes,
  bool? showTicks,
  bool? showLabels,
  bool? showLegend,
  bool? showTooltip,
  bool? showMarkers,
  double? strokeWidth,
  double? markerRadius,
  double? barRadius,
  double? barGap,
  double? barGroupGap,
  double? fillOpacity,
  EdgeInsetsGeometry? contentPadding,
  Duration? animationDuration,
  Curve? animationCurve,
  bool? disableAnimation,
  double? donutHole,
  Color? gridColor,
  Color? axisColor,
}) {
  final ThemeData theme = Theme.of(context);
  final ThemeColors colors = theme.colors;
  final ChartTheme resolved = resolveComponentStyle<ChartTheme, ChartTheme>(
    context,
    widget: widgetTheme,
    select: (t) => t,
    defaults: chartDefaults,
  );
  List<Color> palette =
      resolved.seriesColors?.map((c) => c.resolve(colors)).toList() ??
      colors.chartColors;
  if (palette.isEmpty) {
    palette = colors.chartColors;
  }
  return ChartSurface(
    gridColor:
        gridColor ?? resolved.gridColor?.resolve(colors) ?? colors.border,
    axisColor:
        axisColor ?? resolved.axisColor?.resolve(colors) ?? colors.border,
    tickStyle:
        resolved.tickLabelStyle ??
        TextStyle(fontSize: 11, color: colors.mutedForeground),
    legendStyle:
        resolved.legendTextStyle ??
        TextStyle(fontSize: 12, color: colors.foreground),
    tooltipFill: resolved.tooltipBackground?.resolve(colors) ?? colors.popover,
    tooltipStyle:
        resolved.tooltipTextStyle ??
        TextStyle(fontSize: 12, color: colors.popoverForeground),
    seriesPalette: palette,
    strokeWidth: strokeWidth ?? resolved.strokeWidth ?? 2,
    markerRadius: markerRadius ?? resolved.markerRadius ?? 3,
    barRadius: barRadius ?? resolved.barRadius ?? 4,
    barGap: (barGap ?? resolved.barGap ?? 0.2).clamp(0.0, 0.9),
    barGroupGap: (barGroupGap ?? resolved.barGroupGap ?? 0.25).clamp(0.0, 0.9),
    fillOpacity: (fillOpacity ?? resolved.fillOpacity ?? 0.25).clamp(0.0, 1.0),
    contentPadding:
        contentPadding ??
        resolved.contentPadding ??
        const EdgeInsets.fromLTRB(8, 8, 12, 8),
    showGrid: showGrid ?? resolved.showGrid ?? true,
    showAxes: showAxes ?? resolved.showAxes ?? true,
    showTicks: showTicks ?? resolved.showTicks ?? true,
    showLabels: showLabels ?? resolved.showLabels ?? true,
    showLegend: showLegend ?? resolved.showLegend ?? true,
    showTooltip: showTooltip ?? resolved.showTooltip ?? true,
    showMarkers: showMarkers ?? resolved.showMarkers ?? false,
    animationDuration:
        animationDuration ??
        resolved.animationDuration ??
        const Duration(milliseconds: 600),
    animationCurve:
        animationCurve ?? resolved.animationCurve ?? Curves.easeOutCubic,
    animate: !(disableAnimation ?? resolved.disableAnimation ?? false),
    donutHole: (donutHole ?? resolved.donutHole ?? 0.55).clamp(0.0, 0.9),
    backgroundColor: resolved.backgroundColor?.resolve(colors),
  );
}
