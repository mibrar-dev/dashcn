// The `chart` component: one widget for line, area, bar, donut/pie,
// sparkline and scatter families, painted with pure `CustomPainter`.
//
// ```dart
// const Chart(data: [1, 2, 3]);
// Chart(series: [ChartSeries(label: 'a', values: [1, 2])], type: ChartType.bar);
// ```

import 'package:flutter/widgets.dart';

import '../../primitives/chart/chart_math.dart';
import '../../primitives/motion/motion_scope.dart';
import '../../theme/theme.dart';
import 'chart_cartesian_painter.dart';
import 'chart_model.dart';
import 'chart_pie_painter.dart';
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
    this.theme,
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

  /// Widget-leg theme override.
  final ChartTheme? theme;

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
    _listen();
  }

  @override
  void didUpdateWidget(covariant Chart old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      _unlisten();
      _listen();
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
    if (isPie) {
      final List<double> values = series.isEmpty
          ? const <double>[]
          : paints.first.values;
      final List<Color> colors = <Color>[
        for (var i = 0; i < values.length; i++)
          surface.seriesPalette[i % surface.seriesPalette.length],
      ];
      painted = CustomPaint(
        painter: ChartPiePainter(
          values: values,
          colors: series.isNotEmpty && series.first.color != null
              ? List<Color>.filled(values.length, series.first.color!)
              : colors,
          hole: hole,
          progress: progress,
          selectedIndex: _selected,
          strokeColor: Theme.of(context).colors.background,
        ),
      );
    } else {
      final Iterable<double> all = paints.expand((p) => p.values);
      final ext = chartExtent(all);
      final double lo = widget.yAxis.min ?? (barBaseline(ext.min, widget.type));
      final double hi = widget.yAxis.max ?? ext.max;
      final List<double> ticks = chartNiceTicks(lo, hi, widget.yAxis.tickCount);
      painted = CustomPaint(
        painter: ChartCartesianPainter(
          type: widget.type,
          barMode: widget.barMode,
          series: paints,
          min: lo,
          max: hi,
          ticks: ticks,
          format: widget.yAxis.format ?? chartDefaultTick,
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
        ),
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (d) =>
              _selectFromDx(d.localPosition.dx, constraints.maxWidth, series),
          onPanUpdate: (d) =>
              _selectFromDx(d.localPosition.dx, constraints.maxWidth, series),
          child: MouseRegion(
            onHover: (e) =>
                _selectFromDx(e.localPosition.dx, constraints.maxWidth, series),
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
    final List<String> lines = <String>[];
    for (var si = 0; si < series.length; si++) {
      final List<double> v = series[si].values;
      if (index < v.length) {
        final String name = series[si].label ?? 'Series ${si + 1}';
        lines.add('$name: ${v[index]}');
      }
    }
    if (lines.isEmpty) {
      return const SizedBox.shrink();
    }
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: surface.tooltipFill,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: surface.gridColor),
        ),
        child: Text(lines.join('  '), style: surface.tooltipStyle),
      ),
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
    return Wrap(
      spacing: 12,
      runSpacing: 4,
      children: <Widget>[
        for (var i = 0; i < series.length; i++)
          if (series[i].label != null && series[i].label!.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color:
                        series[i].color ??
                        surface.seriesPalette[i % surface.seriesPalette.length],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
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
