// Public data model for the `chart` component: series, axes, controller.
//
// Owned by the component (single-owner rule); the `chart` primitive owns
// only the windowing math. Widgets-only.

import 'package:flutter/widgets.dart';

import '../../primitives/chart/chart_math.dart';

/// Chart families painted by [Chart].
enum ChartType {
  /// Connected line; multiple series overlay.
  line,

  /// Line with a fill to the baseline.
  area,

  /// Vertical bars; [ChartBarMode] picks grouped vs stacked.
  bar,

  /// Donut ring (pie with a hole).
  donut,

  /// Full pie.
  pie,

  /// Minimal line without axes, legend or grid.
  sparkline,

  /// Dots at (index, value).
  scatter,
}

/// Bar arrangement for [ChartType.bar] with several series.
enum ChartBarMode {
  /// Side-by-side bars per category.
  grouped,

  /// One stacked bar per category.
  stacked,
}

/// One data series: a label for the legend plus the values.
///
/// Three-line usage: `Chart(data: [1, 2, 3])` wraps the list in one series
/// automatically; pass [ChartSeries] explicitly for colours, labels and
/// per-series styling.
class ChartSeries {
  /// Creates a series.
  const ChartSeries({
    this.label,
    required this.values,
    this.color,
    this.gradient,
    this.strokeWidth,
    this.dash,
    this.showMarkers,
    this.markerRadius,
    this.fillOpacity,
    this.barRadius,
  });

  /// Legend label; null hides the series from the legend.
  final String? label;

  /// Y values; x is the index.
  final List<double> values;

  /// Series colour override (theme series palette by index by default).
  final Color? color;

  /// Fill gradient for area/bar/donut slices; null uses [color].
  final Gradient? gradient;

  /// Line width override.
  final double? strokeWidth;

  /// Dash pattern in logical pixels, e.g. `[6, 4]`; null is solid.
  final List<double>? dash;

  /// Marker override; null follows the chart-level flag.
  final bool? showMarkers;

  /// Marker dot radius override.
  final double? markerRadius;

  /// Fill opacity for area/bar (0..1); null resolves the theme default.
  final double? fillOpacity;

  /// Bar corner radius override.
  final BorderRadius? barRadius;

  /// Returns a copy with the given fields replaced.
  ChartSeries copyWith({List<double>? values, String? Function()? label}) {
    return ChartSeries(
      label: label == null ? this.label : label(),
      values: values ?? this.values,
      color: color,
      gradient: gradient,
      strokeWidth: strokeWidth,
      dash: dash,
      showMarkers: showMarkers,
      markerRadius: markerRadius,
      fillOpacity: fillOpacity,
      barRadius: barRadius,
    );
  }
}

/// Axis configuration: every visual part can be toggled or restyled.
class ChartAxis {
  /// Creates an axis configuration.
  const ChartAxis({
    this.show = true,
    this.showGrid = true,
    this.showTicks = true,
    this.showLabels = true,
    this.tickCount = 4,
    this.min,
    this.max,
    this.labels,
    this.format,
  });

  /// Whether the axis line itself paints.
  final bool show;

  /// Whether grid lines paint (y axis only; x grid follows this flag).
  final bool showGrid;

  /// Whether tick marks paint.
  final bool showTicks;

  /// Whether tick labels paint.
  final bool showLabels;

  /// Target tick count.
  final int tickCount;

  /// Explicit range override; null derives from the data.
  final double? min;

  /// Explicit range override; null derives from the data.
  final double? max;

  /// Explicit category labels for the x axis; null numbers the ticks.
  final List<String>? labels;

  /// Formats a tick value; null uses a compact default.
  final String Function(double value)? format;

  /// Disabled axis: no line, grid, ticks or labels.
  static const ChartAxis hidden = ChartAxis(
    show: false,
    showGrid: false,
    showTicks: false,
    showLabels: false,
  );

  /// Returns a copy with the given fields replaced.
  ChartAxis copyWith({
    bool? show,
    bool? showGrid,
    bool? showTicks,
    bool? showLabels,
    int? tickCount,
    double? Function()? min,
    double? Function()? max,
  }) {
    return ChartAxis(
      show: show ?? this.show,
      showGrid: showGrid ?? this.showGrid,
      showTicks: showTicks ?? this.showTicks,
      showLabels: showLabels ?? this.showLabels,
      tickCount: tickCount ?? this.tickCount,
      min: min == null ? this.min : min(),
      max: max == null ? this.max : max(),
      labels: labels,
      format: format,
    );
  }
}

/// Streaming controller: append points with a trailing window.
///
/// ```dart
/// final controller = ChartController(maxPoints: 40, initial: [
///   const ChartSeries(label: 'a', values: [1, 2]),
/// ]);
/// controller.appendSeriesPoint(0, 3); // trims to the last 40
/// ```
class ChartController extends ChangeNotifier {
  /// Creates a controller.
  ChartController({List<ChartSeries>? initial, this.maxPoints = 60})
    : _series = List<ChartSeries>.from(initial ?? const <ChartSeries>[]);

  /// Trailing window per series; <= 0 keeps everything.
  final int maxPoints;

  List<ChartSeries> _series;

  /// Current series snapshot.
  List<ChartSeries> get series => List<ChartSeries>.unmodifiable(_series);

  /// Replaces every series.
  set series(List<ChartSeries> value) {
    _series = List<ChartSeries>.from(value);
    _trim();
    notifyListeners();
  }

  /// Replaces series at [index].
  void replaceAt(int index, ChartSeries series) {
    _series[index] = series;
    _trim();
    notifyListeners();
  }

  /// Appends one point to series [index], creating it when missing.
  void appendSeriesPoint(int index, double value, {String? label}) {
    while (_series.length <= index) {
      _series.add(ChartSeries(label: label, values: const <double>[]));
    }
    final ChartSeries current = _series[index];
    final List<double> next = List<double>.from(current.values)..add(value);
    final List<double> windowed = chartWindow(next, maxPoints);
    _series[index] = current.copyWith(values: windowed);
    notifyListeners();
  }

  /// Appends one point per series; lengths may differ.
  void appendPoints(List<double> points) {
    for (var i = 0; i < points.length; i++) {
      appendSeriesPoint(i, points[i]);
    }
  }

  /// Appends a single value to the first series (single-series shorthand).
  void append(double value) => appendSeriesPoint(0, value);

  /// Clears every series.
  void clear() {
    _series = <ChartSeries>[
      for (final s in _series) s.copyWith(values: const <double>[]),
    ];
    notifyListeners();
  }

  void _trim() {
    if (maxPoints <= 0) {
      return;
    }
    for (var i = 0; i < _series.length; i++) {
      final ChartSeries s = _series[i];
      if (s.values.length > maxPoints) {
        _series[i] = s.copyWith(
          values: s.values.sublist(s.values.length - maxPoints),
        );
      }
    }
  }
}

/// Default tick formatter: integers stay integral, others one decimal.
String chartDefaultTick(double value) {
  if (value == value.roundToDouble()) {
    return value.toInt().toString();
  }
  return value.toStringAsFixed(1);
}
