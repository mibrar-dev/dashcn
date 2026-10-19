// The `chart` component: one widget for line, area, bar, donut/pie,
// sparkline and scatter families, painted with pure `CustomPainter`.
//
// ```dart
// const Chart(data: [1, 2, 3]);
// Chart(series: [ChartSeries(label: 'a', values: [1, 2])], type: ChartType.bar);
// ```

import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../primitives/chart/chart_math.dart';
import '../../primitives/motion/motion_scope.dart';
import '../../theme/theme.dart';
import 'chart_cartesian_painter.dart';
import 'chart_model.dart';
import 'chart_paths.dart';
import 'chart_pie_painter.dart';
import 'chart_radar_painter.dart';
import 'chart_radial_painter.dart';
import 'chart_style.dart';

export 'chart_model.dart';
export 'chart_style.dart';

/// One chart: cartesian and radial families with streaming and a11y.
class Chart extends StatefulWidget {
  /// Creates a chart.
  const Chart({
    super.key,
    this.data,
    this.series,
    this.labels,
    this.type = ChartType.line,
    this.barMode = ChartBarMode.grouped,
    this.barLayout = ChartBarLayout.vertical,
    this.lineStyle = ChartLineStyle.smooth,
    this.areaMode = ChartAreaMode.overlay,
    this.showBarLabels = false,
    this.showBarCategories = false,
    this.showPointLabels = false,
    this.pointLabels,
    this.height = 220,
    this.showGrid,
    this.showAxes,
    this.showTicks,
    this.showLabels,
    this.showLegend,
    this.showTooltip,
    this.showMarkers,
    this.gridColor,
    this.axisColor,
    this.strokeWidth,
    this.markerRadius,
    this.barRadius,
    this.barGap,
    this.barGroupGap,
    this.fillOpacity,
    this.contentPadding,
    this.animationDuration,
    this.animationCurve,
    this.disableAnimation,
    this.donutHole,
    this.xAxis = const ChartAxis(),
    this.yAxis = const ChartAxis(),
    this.maxPoints = 0,
    this.controller,
    this.semanticsLabel,
    this.showDataTable = false,
    this.radar = const ChartRadarConfig(),
    this.radial = const ChartRadialConfig(),
    this.centerLabel,
    this.centerSublabel,
    this.tooltip = const ChartTooltipConfig(),
    this.initialSelectedIndex,
    this.pie = const ChartPieConfig(),
    this.theme,
    this.onSelected,
  });

  /// Single-series shorthand; wrapped as one unnamed series.
  final List<double>? data;

  /// Multi-series input; wins over [data] when non-empty.
  final List<ChartSeries>? series;

  /// X category labels.
  final List<String>? labels;

  /// Chart family.
  final ChartType type;

  /// Bar arrangement.
  final ChartBarMode barMode;

  /// Bar orientation ([ChartType.bar] only).
  final ChartBarLayout barLayout;

  /// Line shape for line/area/sparkline strokes.
  final ChartLineStyle lineStyle;

  /// Area fill arrangement ([ChartType.area] with several series).
  final ChartAreaMode areaMode;

  /// Whether value labels paint at the bar ends ([ChartType.bar] only).
  final bool showBarLabels;

  /// Whether category labels paint inside horizontal bars
  /// ([ChartType.bar] with [ChartBarLayout.horizontal] only).
  final bool showBarCategories;

  /// Whether labels paint above line points ([ChartType.line] only).
  final bool showPointLabels;

  /// Custom point labels by index; null shows compact values.
  final List<String>? pointLabels;

  /// Plot height.
  final double height;

  /// Part toggles (null follows the theme).
  final bool? showGrid;

  /// Part toggles.
  final bool? showAxes;

  /// Part toggles.
  final bool? showTicks;

  /// Part toggles.
  final bool? showLabels;

  /// Part toggles.
  final bool? showLegend;

  /// Part toggles.
  final bool? showTooltip;

  /// Part toggles.
  final bool? showMarkers;

  /// Colour overrides.
  final Color? gridColor;

  /// Colour overrides.
  final Color? axisColor;

  /// Geometry overrides.
  final double? strokeWidth;

  /// Geometry overrides.
  final double? markerRadius;

  /// Geometry overrides.
  final double? barRadius;

  /// Geometry overrides.
  final double? barGap;

  /// Geometry overrides.
  final double? barGroupGap;

  /// Geometry overrides.
  final double? fillOpacity;

  /// Plot inset.
  final EdgeInsetsGeometry? contentPadding;

  /// Motion overrides.
  final Duration? animationDuration;

  /// Motion overrides.
  final Curve? animationCurve;

  /// Motion overrides.
  final bool? disableAnimation;

  /// Donut hole fraction 0..1.
  final double? donutHole;

  /// X axis configuration.
  final ChartAxis xAxis;

  /// Y axis configuration.
  final ChartAxis yAxis;

  /// Trailing window for [data]/[series]; <= 0 keeps everything.
  final int maxPoints;

  /// Streaming controller; when set it owns the series.
  final ChartController? controller;

  /// Accessible label; null derives a summary.
  final String? semanticsLabel;

  /// Whether to render a textual data table below the plot.
  final bool showDataTable;

  /// Radar display options ([ChartType.radar] only).
  final ChartRadarConfig radar;

  /// Radial display options ([ChartType.radial] only).
  final ChartRadialConfig radial;

  /// Centre text for radial charts and donut charts with text
  /// (the "Text" look); null hides it.
  final String? centerLabel;

  /// Centre sublabel drawn under [centerLabel]; null hides it.
  final String? centerSublabel;

  /// Tooltip content options (indicator, label, formatters, total).
  final ChartTooltipConfig tooltip;

  /// Initially selected category/ring/slice index, so the tooltip and
  /// highlight paint on first frame (the `defaultIndex` look); null selects
  /// nothing until the user hovers or taps.
  final int? initialSelectedIndex;

  /// Pie display options ([ChartType.pie] and [ChartType.donut] only).
  final ChartPieConfig pie;

  /// Widget-leg theme override.
  final ChartTheme? theme;

  /// Called when the highlighted slice/category changes through
  /// hover or tap; null when the pointer leaves the plot.
  final ValueChanged<int?>? onSelected;

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<List<double>>? _from;
  int? _selected;
  ChartController? _listened;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSelectedIndex;
    _listen();
  }

  @override
  void didUpdateWidget(covariant Chart old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      _unlisten();
      _listen();
    }
    if (widget.initialSelectedIndex != old.initialSelectedIndex) {
      _selected = widget.initialSelectedIndex;
    }
    final List<List<double>> next = _currentValues();
    final List<List<double>> prev = _displayedValues(old);
    if (!_equal2D(prev, next)) {
      _from = prev;
    }
  }

  @override
  void dispose() {
    _unlisten();
    super.dispose();
  }

  void _listen() {
    _listened = widget.controller;
    _listened?.addListener(_onStream);
  }

  void _unlisten() {
    _listened?.removeListener(_onStream);
    _listened = null;
  }

  void _onStream() {
    setState(() {});
  }

  List<ChartSeries> _effectiveSeries() {
    final ChartController? c = widget.controller;
    if (c != null) {
      return _trimSeries(c.series);
    }
    final List<ChartSeries>? s = widget.series;
    if (s != null && s.isNotEmpty) {
      return _trimSeries(s);
    }
    final List<double>? d = widget.data;
    if (d != null) {
      return _trimSeries(<ChartSeries>[
        ChartSeries(values: List<double>.from(d)),
      ]);
    }
    return const <ChartSeries>[];
  }

  List<ChartSeries> _trimSeries(List<ChartSeries> input) {
    if (widget.maxPoints <= 0 &&
        (widget.controller == null || widget.controller!.maxPoints <= 0)) {
      return input;
    }
    final int cap = widget.controller?.maxPoints ?? widget.maxPoints;
    if (cap <= 0) {
      return input;
    }
    return <ChartSeries>[
      for (final s in input) s.copyWith(values: chartWindow(s.values, cap)),
    ];
  }

  List<List<double>> _currentValues() => <List<double>>[
    for (final s in _effectiveSeries()) List<double>.from(s.values),
  ];

  List<List<double>> _displayedValues([Chart? anchor]) {
    final Chart w = anchor ?? widget;
    final ChartController? c = w.controller;
    List<ChartSeries> src;
    if (c != null) {
      src = c.series;
    } else if (w.series != null && w.series!.isNotEmpty) {
      src = w.series!;
    } else if (w.data != null) {
      src = <ChartSeries>[ChartSeries(values: w.data!)];
    } else {
      src = const <ChartSeries>[];
    }
    return <List<double>>[for (final s in src) List<double>.from(s.values)];
  }

  bool _equal2D(List<List<double>> a, List<List<double>> b) {
    if (a.length != b.length) {
      return false;
    }
    for (var i = 0; i < a.length; i++) {
      if (a[i].length != b[i].length) {
        return false;
      }
      for (var j = 0; j < a[i].length; j++) {
        if (a[i][j] != b[i][j]) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final ChartSurface surface = resolveChartSurface(
      context,
      widgetTheme: widget.theme,
      showGrid: widget.showGrid,
      showAxes: widget.showAxes,
      showTicks: widget.showTicks,
      showLabels: widget.showLabels,
      showLegend: widget.showLegend,
      showTooltip: widget.showTooltip,
      showMarkers: widget.showMarkers,
      strokeWidth: widget.strokeWidth,
      markerRadius: widget.markerRadius,
      barRadius: widget.barRadius,
      barGap: widget.barGap,
      barGroupGap: widget.barGroupGap,
      fillOpacity: widget.fillOpacity,
      contentPadding: widget.contentPadding,
      animationDuration: widget.animationDuration,
      animationCurve: widget.animationCurve,
      disableAnimation: widget.disableAnimation,
      donutHole: widget.donutHole,
      gridColor: widget.gridColor,
      axisColor: widget.axisColor,
    );
    final bool reduced = motionReduced(context);
    final bool minimal = widget.type == ChartType.sparkline;
    final List<ChartSeries> series = _effectiveSeries();
    final String summary = widget.semanticsLabel ?? _summary(series);
    final List<List<double>> to = _currentValues();
    final List<List<double>> from =
        _from ?? to.map((_) => const <double>[]).toList();
    final Duration duration = !surface.animate || reduced
        ? Duration.zero
        : surface.animationDuration;

    Widget plot = TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: duration,
      curve: surface.animationCurve,
      onEnd: () => _from = to,
      builder: (context, t, _) {
        final List<ChartSeriesPaint> paints = _paints(
          series,
          from,
          to,
          t,
          surface,
        );
        return _buildPlot(context, surface, series, paints, t, minimal);
      },
    );

    final List<Widget> column = <Widget>[
      SizedBox(height: widget.height, child: plot),
    ];
    if (!minimal && surface.showLegend && _hasLabels(series)) {
      column.add(const SizedBox(height: 8));
      column.add(_buildLegend(surface, series));
    }
    if (widget.showDataTable) {
      column.add(const SizedBox(height: 8));
      column.add(_buildTable(surface, series));
    }
    return Semantics(
      container: true,
      label: summary,
      child: Padding(
        padding: surface.contentPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: column,
        ),
      ),
    );
  }

  List<ChartSeriesPaint> _paints(
    List<ChartSeries> series,
    List<List<double>> from,
    List<List<double>> to,
    double t,
    ChartSurface surface,
  ) {
    return <ChartSeriesPaint>[
      for (var si = 0; si < series.length; si++)
        ChartSeriesPaint(
          values: chartLerpValues(
            si < from.length ? from[si] : const <double>[],
            si < to.length ? to[si] : const <double>[],
            t,
          ),
          color:
              series[si].color ??
              surface.seriesPalette[si % surface.seriesPalette.length],
          label: series[si].label,
          pointColors: series[si].pointColors,
          markerShape: series[si].markerShape,
          gradient: series[si].gradient,
          strokeWidth: series[si].strokeWidth ?? surface.strokeWidth,
          dash: series[si].dash,
          showMarkers: series[si].showMarkers ?? surface.showMarkers,
          markerRadius: series[si].markerRadius ?? surface.markerRadius,
          fillOpacity: series[si].fillOpacity ?? surface.fillOpacity,
          barRadius: series[si].barRadius?.topLeft.x ?? surface.barRadius,
        ),
    ];
  }

  Widget _buildPlot(
    BuildContext context,
    ChartSurface surface,
    List<ChartSeries> series,
    List<ChartSeriesPaint> paints,
    double progress,
    bool minimal,
  ) {
    final bool isPie =
        widget.type == ChartType.donut || widget.type == ChartType.pie;
    final TextDirection dir = Directionality.of(context);
    final double hole = widget.type == ChartType.pie
        ? 0
        : (widget.donutHole ?? surface.donutHole);
    Widget painted;
    if (widget.type == ChartType.radar) {
      painted = _buildRadarPlot(context, surface, series, paints, progress);
    } else if (widget.type == ChartType.radial) {
      painted = _buildRadialPlot(context, surface, series, paints, progress);
    } else if (isPie) {
      painted = _buildPiePlot(
        context,
        surface,
        series,
        paints,
        progress,
        hole,
        dir,
      );
    } else {
      final bool stackedArea =
          widget.type == ChartType.area &&
          widget.areaMode != ChartAreaMode.overlay &&
          series.length > 1;
      final bool expanded =
          stackedArea && widget.areaMode == ChartAreaMode.expanded;
      final Iterable<double> all = paints.expand((p) => p.values);
      final ext = chartExtent(all);
      double lo = widget.yAxis.min ?? (barBaseline(ext.min, widget.type));
      double hi = widget.yAxis.max ?? ext.max;
      String Function(double) format = widget.yAxis.format ?? chartDefaultTick;
      if (stackedArea) {
        final List<List<ChartStackBand>> bands = chartStackBands(<List<double>>[
          for (final s in series) s.values,
        ], expanded: expanded);
        double stackLo = 0;
        double stackHi = expanded ? 1 : 0;
        for (final List<ChartStackBand> row in bands) {
          for (final ChartStackBand band in row) {
            if (band.base < stackLo) {
              stackLo = band.base;
            }
            if (band.top > stackHi) {
              stackHi = band.top;
            }
          }
        }
        lo = widget.yAxis.min ?? (expanded ? 0 : stackLo);
        hi = widget.yAxis.max ?? stackHi;
        if (expanded && widget.yAxis.format == null) {
          format = chartPercentTick;
        }
      }
      final List<double> ticks = chartNiceTicks(lo, hi, widget.yAxis.tickCount);
      painted = CustomPaint(
        painter: ChartCartesianPainter(
          type: widget.type,
          barMode: widget.barMode,
          barLayout: widget.barLayout,
          lineStyle: widget.lineStyle,
          areaMode: widget.areaMode,
          showBarLabels: widget.showBarLabels,
          showBarCategories: widget.showBarCategories,
          showPointLabels: widget.showPointLabels,
          pointLabels: widget.pointLabels,
          series: paints,
          min: lo,
          max: hi,
          ticks: ticks,
          format: format,
          xLabels: widget.labels ?? widget.xAxis.labels,
          gridColor: surface.gridColor,
          axisColor: surface.axisColor,
          tickStyle: surface.tickStyle,
          showGrid:
              !minimal &&
              surface.showGrid &&
              widget.yAxis.showGrid &&
              widget.xAxis.showGrid,
          showAxes:
              !minimal &&
              surface.showAxes &&
              (widget.yAxis.show || widget.xAxis.show),
          showTicks: !minimal && surface.showTicks && widget.yAxis.showTicks,
          showLabels:
              !minimal &&
              surface.showLabels &&
              (widget.yAxis.showLabels || widget.xAxis.showLabels),
          progress: progress,
          selectedIndex: _selected,
          barGap: surface.barGap,
          barGroupGap: surface.barGroupGap,
          textDirection: dir,
          backgroundColor:
              surface.backgroundColor ?? Theme.of(context).colors.background,
        ),
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool horizontalBars =
            widget.type == ChartType.bar &&
            widget.barLayout == ChartBarLayout.horizontal;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (d) => horizontalBars
              ? _selectFromDy(d.localPosition.dy, constraints.maxHeight, series)
              : _selectFromDx(d.localPosition.dx, constraints.maxWidth, series),
          onPanUpdate: (d) => horizontalBars
              ? _selectFromDy(d.localPosition.dy, constraints.maxHeight, series)
              : _selectFromDx(d.localPosition.dx, constraints.maxWidth, series),
          child: MouseRegion(
            onHover: (e) => horizontalBars
                ? _selectFromDy(
                    e.localPosition.dy,
                    constraints.maxHeight,
                    series,
                  )
                : _selectFromDx(
                    e.localPosition.dx,
                    constraints.maxWidth,
                    series,
                  ),
            onExit: (_) => setState(() => _selected = null),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                SizedBox.expand(child: painted),
                if (!minimal && surface.showTooltip && _selected != null)
                  _buildTooltip(surface, series, _selected!),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectFromDx(double dx, double width, List<ChartSeries> series) {
    final int n = _categoryLength(series);
    if (n == 0 || width <= 0) {
      return;
    }
    final int idx = (dx / width * n).floor().clamp(0, n - 1);
    if (idx != _selected) {
      setState(() => _selected = idx);
    }
  }

  void _selectFromDy(double dy, double height, List<ChartSeries> series) {
    final int n = _categoryLength(series);
    if (n == 0 || height <= 0) {
      return;
    }
    final int idx = (dy / height * n).floor().clamp(0, n - 1);
    if (idx != _selected) {
      setState(() => _selected = idx);
    }
  }

  Widget _buildRadarPlot(
    BuildContext context,
    ChartSurface surface,
    List<ChartSeries> series,
    List<ChartSeriesPaint> paints,
    double progress,
  ) {
    double maxValue = widget.yAxis.max ?? 0;
    for (final ChartSeriesPaint p in paints) {
      for (final double v in p.values) {
        if (v > maxValue) {
          maxValue = v;
        }
      }
    }
    if (maxValue <= 0) {
      maxValue = 1;
    }
    final List<String> categories =
        widget.labels ?? widget.xAxis.labels ?? const <String>[];
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (d) =>
              _selectRadarAxis(d.localPosition, constraints.biggest, series),
          onPanUpdate: (d) =>
              _selectRadarAxis(d.localPosition, constraints.biggest, series),
          child: MouseRegion(
            onHover: (e) =>
                _selectRadarAxis(e.localPosition, constraints.biggest, series),
            onExit: (_) => setState(() => _selected = null),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                SizedBox.expand(
                  child: CustomPaint(
                    painter: ChartRadarPainter(
                      series: paints,
                      maxValue: maxValue,
                      categories: categories,
                      radar: widget.radar,
                      gridColor: surface.gridColor,
                      tickStyle: surface.tickStyle,
                      valueStyle: surface.legendStyle,
                      progress: progress,
                      selectedIndex: _selected,
                      textDirection: Directionality.of(context),
                    ),
                  ),
                ),
                if (surface.showTooltip && _selected != null)
                  _buildTooltip(surface, series, _selected!),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectRadarAxis(Offset local, Size size, List<ChartSeries> series) {
    final int n = _categoryLength(series);
    if (n < 3 || size.width <= 0 || size.height <= 0) {
      return;
    }
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Offset delta = local - center;
    if (delta.distance < 4) {
      return;
    }
    double angle = math.atan2(delta.dy, delta.dx) + math.pi / 2;
    if (Directionality.of(context) == TextDirection.rtl) {
      angle = -angle;
    }
    final double step = 2 * math.pi / n;
    int index = (angle / step).round() % n;
    if (index < 0) {
      index += n;
    }
    if (index != _selected) {
      setState(() => _selected = index);
    }
  }

  Widget _buildRadialPlot(
    BuildContext context,
    ChartSurface surface,
    List<ChartSeries> series,
    List<ChartSeriesPaint> paints,
    double progress,
  ) {
    double maxValue = widget.yAxis.max ?? 0;
    int rings = 0;
    if (paints.length == 1 && paints.first.values.length > 1) {
      rings = paints.first.values.length;
      for (final double v in paints.first.values) {
        if (v > maxValue) {
          maxValue = v;
        }
      }
    } else {
      for (final ChartSeriesPaint p in paints) {
        if (p.values.isEmpty) {
          continue;
        }
        rings++;
        if (p.values.first > maxValue) {
          maxValue = p.values.first;
        }
      }
    }
    if (maxValue <= 0) {
      maxValue = 1;
    }
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (d) =>
              _selectRadialRing(d.localPosition, constraints.biggest, rings),
          onPanUpdate: (d) =>
              _selectRadialRing(d.localPosition, constraints.biggest, rings),
          child: MouseRegion(
            onHover: (e) =>
                _selectRadialRing(e.localPosition, constraints.biggest, rings),
            onExit: (_) => setState(() => _selected = null),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                SizedBox.expand(
                  child: CustomPaint(
                    painter: ChartRadialPainter(
                      series: paints,
                      maxValue: maxValue,
                      radial: widget.radial,
                      gridColor: surface.gridColor,
                      trackColor: surface.gridColor.withValues(
                        alpha: surface.gridColor.a * 0.35,
                      ),
                      labelStyle: surface.tickStyle,
                      progress: progress,
                      selectedIndex: _selected,
                      textDirection: Directionality.of(context),
                    ),
                  ),
                ),
                if (widget.centerLabel != null) _buildCenterLabel(surface),
                if (surface.showTooltip && _selected != null)
                  _buildRadialTooltip(surface, series, paints, _selected!),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectRadialRing(Offset local, Size size, int rings) {
    if (rings == 0 || size.width <= 0 || size.height <= 0) {
      return;
    }
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = math.min(size.width, size.height) / 2 - 8;
    final double dist = (local - center).distance;
    if (dist > radius + 8) {
      if (_selected != null) {
        setState(() => _selected = null);
      }
      return;
    }
    final double slot = radius / (rings + 1);
    final int index = ((dist / slot).floor() - 1).clamp(0, rings - 1);
    if (index != _selected) {
      setState(() => _selected = index);
    }
  }

  Widget _buildCenterLabel(ChartSurface surface) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            widget.centerLabel!,
            style: surface.legendStyle.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          if (widget.centerSublabel != null)
            Text(
              widget.centerSublabel!,
              style: surface.tickStyle,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }

  Widget _buildRadialTooltip(
    ChartSurface surface,
    List<ChartSeries> series,
    List<ChartSeriesPaint> paints,
    int index,
  ) {
    // Stacked pies share one month per slice index: one row per series.
    if (widget.pie.stacked && series.length > 1) {
      return _buildStackedPieTooltip(surface, series, index);
    }
    String? label;
    String? value;
    if (paints.length == 1 && paints.first.values.length > 1) {
      final List<double> v = series.first.values;
      if (index < v.length) {
        value = '${v[index]}';
      }
      if (widget.labels != null && index < widget.labels!.length) {
        label = widget.labels![index];
      }
    } else {
      int seen = -1;
      for (var si = 0; si < series.length; si++) {
        if (series[si].values.isEmpty) {
          continue;
        }
        seen++;
        if (seen == index) {
          label = series[si].label ?? 'Series ${si + 1}';
          value = '${series[si].values.first}';
          break;
        }
      }
    }
    if (value == null) {
      return const SizedBox.shrink();
    }
    final ChartTooltipConfig config = widget.tooltip;
    final double raw = double.tryParse(value) ?? 0;
    final String text =
        '${(config.valueFormatter ?? chartCompactValue)(raw)}${config.valueSuffix ?? ''}';
    String? title;
    if (config.showLabel) {
      title = config.labelFormatter?.call(index) ?? label;
    }
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 260),
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
            Text(
              text,
              style: surface.tooltipStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// Tooltip for stacked pies: one row per series at [index].
  Widget _buildStackedPieTooltip(
    ChartSurface surface,
    List<ChartSeries> series,
    int index,
  ) {
    final ChartTooltipConfig config = widget.tooltip;
    final List<_TooltipRow> rows = <_TooltipRow>[];
    for (var si = 0; si < series.length; si++) {
      final List<double> v = series[si].values;
      if (index >= v.length) {
        continue;
      }
      rows.add(
        _TooltipRow(
          label: series[si].label ?? 'Series ${si + 1}',
          value: v[index],
          color:
              series[si].color ??
              surface.seriesPalette[si % surface.seriesPalette.length],
          icon: series[si].icon,
        ),
      );
    }
    if (rows.isEmpty) {
      return const SizedBox.shrink();
    }
    String? title;
    if (config.showLabel) {
      title = config.labelFormatter?.call(index) ?? _categoryTitle(index);
    }
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 260),
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
            for (final _TooltipRow row in rows)
              _tooltipRow(surface, config, row),
          ],
        ),
      ),
    );
  }

  Widget _buildPiePlot(
    BuildContext context,
    ChartSurface surface,
    List<ChartSeries> series,
    List<ChartSeriesPaint> paints,
    double progress,
    double hole,
    TextDirection dir,
  ) {
    List<Color> sliceColors(ChartSeries s, int count) {
      return <Color>[
        for (var i = 0; i < count; i++) _sliceColor(surface, s, i),
      ];
    }

    List<String> sliceNames(ChartSeries s, int count) {
      final List<String> labels = widget.labels ?? const <String>[];
      return <String>[
        for (var i = 0; i < count; i++)
          if (i < labels.length)
            labels[i]
          else if (s.label != null && count == 1)
            s.label!
          else
            'Slice $i',
      ];
    }

    Widget ring(
      ChartSeriesPaint p,
      ChartSeries s,
      double ringHole, [
      double radiusScale = 1,
    ]) {
      return SizedBox.expand(
        child: CustomPaint(
          painter: ChartPiePainter(
            values: p.values,
            colors: sliceColors(s, p.values.length),
            names: sliceNames(s, p.values.length),
            hole: ringHole,
            pie: widget.pie,
            labelStyle: surface.tickStyle,
            progress: progress,
            selectedIndex: _selected,
            strokeColor: Theme.of(context).colors.background,
            textDirection: dir,
            radiusScale: radiusScale,
          ),
        ),
      );
    }

    Widget plot;
    if (widget.pie.stacked && paints.length > 1) {
      // Inner pie outer 60, outer ring 70-90 of a 90 radius.
      plot = Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ring(paints.first, series.first, 0, 60 / 90),
          for (var i = 1; i < paints.length; i++)
            ring(paints[i], series[i], 70 / 90),
        ],
      );
    } else if (paints.isEmpty) {
      plot = const SizedBox.expand();
    } else {
      plot = ring(paints.first, series.first, hole);
    }
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (d) =>
              _selectPieSlice(d.localPosition, constraints.biggest, paints),
          onPanUpdate: (d) =>
              _selectPieSlice(d.localPosition, constraints.biggest, paints),
          child: MouseRegion(
            onHover: (e) =>
                _selectPieSlice(e.localPosition, constraints.biggest, paints),
            onExit: (_) {
              setState(() => _selected = null);
              widget.onSelected?.call(null);
            },
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                plot,
                if (widget.centerLabel != null) _buildCenterLabel(surface),
                if (surface.showTooltip && _selected != null)
                  _buildRadialTooltip(surface, series, paints, _selected!),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectPieSlice(Offset local, Size size, List<ChartSeriesPaint> paints) {
    final List<double> values = paints.isEmpty
        ? const <double>[]
        : paints.first.values;
    if (values.isEmpty || size.width <= 0 || size.height <= 0) {
      return;
    }
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Offset delta = local - center;
    final double radius = math.min(size.width, size.height) / 2;
    if (delta.distance > radius || delta.distance < radius * 0.2) {
      if (_selected != null) {
        setState(() => _selected = null);
        widget.onSelected?.call(null);
      }
      return;
    }
    final double total = values.fold(0.0, (a, b) => a + b.abs());
    if (total <= 0) {
      return;
    }
    double angle = math.atan2(delta.dy, delta.dx) + math.pi / 2;
    if (Directionality.of(context) == TextDirection.rtl) {
      angle = -angle;
    }
    angle = angle % (2 * math.pi);
    if (angle < 0) {
      angle += 2 * math.pi;
    }
    double cursor = 0;
    int index = values.length - 1;
    for (var i = 0; i < values.length; i++) {
      cursor += values[i].abs() / total * 2 * math.pi;
      if (angle <= cursor) {
        index = i;
        break;
      }
    }
    if (index != _selected) {
      setState(() => _selected = index);
      widget.onSelected?.call(index);
    }
  }

  int _categoryLength(List<ChartSeries> series) {
    var n = 0;
    for (final s in series) {
      if (s.values.length > n) {
        n = s.values.length;
      }
    }
    if (widget.type == ChartType.donut || widget.type == ChartType.pie) {
      n = series.isEmpty ? 0 : series.first.values.length;
    }
    return n;
  }

  Widget _buildTooltip(
    ChartSurface surface,
    List<ChartSeries> series,
    int index,
  ) {
    final ChartTooltipConfig config = widget.tooltip;
    final List<_TooltipRow> rows = <_TooltipRow>[];
    for (var si = 0; si < series.length; si++) {
      final List<double> v = series[si].values;
      if (index < v.length) {
        rows.add(
          _TooltipRow(
            label: series[si].label ?? 'Series ${si + 1}',
            value: v[index],
            color:
                series[si].color ??
                surface.seriesPalette[si % surface.seriesPalette.length],
            icon: series[si].icon,
          ),
        );
      }
    }
    if (rows.isEmpty) {
      return const SizedBox.shrink();
    }
    String? title;
    if (config.showLabel) {
      title = config.labelFormatter?.call(index) ?? _categoryTitle(index);
    }
    double total = 0;
    for (final _TooltipRow row in rows) {
      total += row.value;
    }
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 260),
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
            for (final _TooltipRow row in rows)
              _tooltipRow(surface, config, row),
            if (config.showTotal && rows.length > 1)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: surface.gridColor)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: _tooltipRow(
                      surface,
                      config,
                      _TooltipRow(
                        label: config.totalLabel,
                        value: total,
                        color: surface.tooltipStyle.color,
                        icon: null,
                      ),
                      strong: true,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _categoryTitle(int index) {
    final List<String>? labels = widget.labels ?? widget.xAxis.labels;
    if (labels != null && index < labels.length) {
      return labels[index];
    }
    return 'Category $index';
  }

  Widget _tooltipRow(
    ChartSurface surface,
    ChartTooltipConfig config,
    _TooltipRow row, {
    bool strong = false,
  }) {
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
              child: _tooltipSwatch(config.indicator, row.color),
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

  Widget _tooltipSwatch(ChartTooltipIndicator indicator, Color? color) {
    if (indicator == ChartTooltipIndicator.line) {
      return Container(width: 12, height: 3, color: color);
    }
    return Container(
      width: 9,
      height: 9,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  bool _hasLabels(List<ChartSeries> series) {
    for (final s in series) {
      if (s.label != null && s.label!.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  Widget _buildLegend(ChartSurface surface, List<ChartSeries> series) {
    final bool isPie =
        widget.type == ChartType.donut || widget.type == ChartType.pie;
    if (isPie &&
        series.length == 1 &&
        series.first.values.length > 1 &&
        series.first.label != null &&
        series.first.label!.isNotEmpty &&
        !widget.pie.stacked) {
      final ChartSeries only = series.first;
      final List<String> labels = widget.labels ?? const <String>[];
      return Wrap(
        spacing: 12,
        runSpacing: 4,
        children: <Widget>[
          for (var i = 0; i < only.values.length; i++)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _sliceColor(surface, only, i),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    i < labels.length ? labels[i] : 'Slice $i',
                    style: surface.legendStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
        ],
      );
    }
    return Wrap(
      spacing: 12,
      runSpacing: 4,
      children: <Widget>[
        for (var i = 0; i < series.length; i++)
          if (series[i].label != null && series[i].label!.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (series[i].icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: IconTheme(
                      data: IconThemeData(
                        color:
                            series[i].color ??
                            surface.seriesPalette[i %
                                surface.seriesPalette.length],
                        size: 14,
                      ),
                      child: series[i].icon!,
                    ),
                  )
                else
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color:
                          series[i].color ??
                          surface.seriesPalette[i %
                              surface.seriesPalette.length],
                      shape: BoxShape.circle,
                    ),
                  ),
                if (series[i].icon == null) const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    series[i].label!,
                    style: surface.legendStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
      ],
    );
  }

  Color _sliceColor(ChartSurface surface, ChartSeries s, int i) {
    final List<Color>? pcs = s.pointColors;
    if (pcs != null && pcs.isNotEmpty) {
      return pcs[i % pcs.length];
    }
    return surface.seriesPalette[i % surface.seriesPalette.length];
  }

  Widget _buildTable(ChartSurface surface, List<ChartSeries> series) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (var i = 0; i < series.length; i++)
          Text(
            '${series[i].label ?? 'Series ${i + 1}'}: ${series[i].values.join(', ')}',
            style: surface.tickStyle,
          ),
      ],
    );
  }

  String _summary(List<ChartSeries> series) {
    final String kind = switch (widget.type) {
      ChartType.line => 'Line',
      ChartType.area => 'Area',
      ChartType.bar => 'Bar',
      ChartType.donut => 'Donut',
      ChartType.pie => 'Pie',
      ChartType.sparkline => 'Sparkline',
      ChartType.scatter => 'Scatter',
      ChartType.radar => 'Radar',
      ChartType.radial => 'Radial',
    };
    if (series.isEmpty) {
      return '$kind chart with no data';
    }
    final int points = series.fold(0, (a, s) => a + s.values.length);
    return '$kind chart with ${series.length} series, $points points';
  }
}

/// Baseline for bars: include zero unless the data is all positive/negative.
double barBaseline(double dataMin, ChartType type) {
  if (type != ChartType.bar) {
    return dataMin;
  }
  if (dataMin > 0) {
    return 0;
  }
  return dataMin;
}

/// One resolved tooltip row: series label, raw value and swatch.
class _TooltipRow {
  const _TooltipRow({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  final String label;
  final double value;
  final Color? color;
  final Widget? icon;
}
