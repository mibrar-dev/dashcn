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
import '../../primitives/localizations/localizations.dart';
import '../../primitives/motion/motion_scope.dart';
import '../../theme/theme.dart';
import 'chart_cartesian_painter.dart';
import 'chart_model.dart';
import 'chart_paths.dart';
import 'chart_pie_painter.dart';
import 'chart_radar_painter.dart';
import 'chart_radial_painter.dart';
import 'chart_style.dart';
import 'chart_tooltip.dart';
import 'chart_tooltip_anchor.dart';
import 'chart_tooltip_placement.dart';

export 'chart_model.dart';
export 'chart_style.dart';
export 'chart_tooltip_anchor.dart';
export 'chart_tooltip_placement.dart';
export 'chart_tooltip.dart';

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
  ScrollPosition? _scrollPos;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSelectedIndex;
    _listen();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ScrollPosition? pos = Scrollable.maybeOf(context)?.position;
    if (pos != _scrollPos) {
      _scrollPos?.removeListener(_onParentScroll);
      _scrollPos = pos;
      _scrollPos?.addListener(_onParentScroll);
    }
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
    _scrollPos?.removeListener(_onParentScroll);
    _scrollPos = null;
    super.dispose();
  }

  void _onParentScroll() {
    if (_selected != null && mounted) {
      setState(() => _selected = null);
    }
  }

  void _dismiss() {
    if (_selected != null && mounted) {
      setState(() => _selected = null);
      widget.onSelected?.call(null);
    }
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
    double? cartLo;
    double? cartHi;
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
      cartLo = lo;
      cartHi = hi;
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
    if (cartLo == null || cartHi == null) {
      return painted;
    }
    final double loFinal = cartLo;
    final double hiFinal = cartHi;
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool horizontalBars =
            widget.type == ChartType.bar &&
            widget.barLayout == ChartBarLayout.horizontal;
        final Size frame = constraints.biggest;
        Offset? anchor;
        if (!minimal && surface.showTooltip && _selected != null) {
          anchor = _cartesianAnchorFor(
            frame,
            surface,
            series,
            loFinal,
            hiFinal,
            minimal,
            dir,
          );
        }
        return TapRegion(
          onTapOutside: (_) => _dismiss(),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (d) => horizontalBars
                ? _toggleFromDy(
                    d.localPosition.dy,
                    constraints.maxHeight,
                    series,
                  )
                : _toggleFromDx(
                    d.localPosition.dx,
                    constraints.maxWidth,
                    series,
                  ),
            onPanUpdate: (d) => horizontalBars
                ? _selectFromDy(
                    d.localPosition.dy,
                    constraints.maxHeight,
                    series,
                  )
                : _selectFromDx(
                    d.localPosition.dx,
                    constraints.maxWidth,
                    series,
                  ),
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
              onExit: (_) => _dismiss(),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  SizedBox.expand(child: painted),
                  if (anchor != null && _selected != null)
                    ChartAnchoredTooltip(
                      anchor: anchor,
                      placement: widget.tooltip.placement,
                      offset: widget.tooltip.offset,
                      child: ChartTooltipCard(
                        data: _tooltipDataFor(surface, series, _selected!),
                        config: widget.tooltip,
                        surface: surface,
                      ),
                    ),
                ],
              ),
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
    final bool spread =
        widget.type == ChartType.line ||
        widget.type == ChartType.area ||
        widget.type == ChartType.scatter ||
        widget.type == ChartType.sparkline;
    final int idx = spread
        ? chartTooltipNearestSpreadIndex(dx, width, n)
        : chartTooltipNearestIndex(dx, width, n);
    if (idx != _selected) {
      setState(() => _selected = idx);
    }
  }

  void _toggleFromDx(double dx, double width, List<ChartSeries> series) {
    final int n = _categoryLength(series);
    if (n == 0 || width <= 0) {
      return;
    }
    final bool spread =
        widget.type == ChartType.line ||
        widget.type == ChartType.area ||
        widget.type == ChartType.scatter ||
        widget.type == ChartType.sparkline;
    final int idx = spread
        ? chartTooltipNearestSpreadIndex(dx, width, n)
        : chartTooltipNearestIndex(dx, width, n);
    if (idx == _selected) {
      setState(() => _selected = null);
    } else {
      setState(() => _selected = idx);
    }
  }

  void _selectFromDy(double dy, double height, List<ChartSeries> series) {
    final int n = _categoryLength(series);
    if (n == 0 || height <= 0) {
      return;
    }
    final int idx = chartTooltipNearestIndex(dy, height, n);
    if (idx != _selected) {
      setState(() => _selected = idx);
    }
  }

  void _toggleFromDy(double dy, double height, List<ChartSeries> series) {
    final int n = _categoryLength(series);
    if (n == 0 || height <= 0) {
      return;
    }
    final int idx = chartTooltipNearestIndex(dy, height, n);
    if (idx == _selected) {
      setState(() => _selected = null);
    } else {
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
        final Size frame = constraints.biggest;
        Offset? anchor;
        if (surface.showTooltip && _selected != null) {
          final int n = _categoryLength(series);
          anchor = chartRadarAnchor(
            size: frame,
            index: _selected!,
            count: n,
            rtl: Directionality.of(context) == TextDirection.rtl,
          );
        }
        // Radar tooltips park toward the chart interior (upper vertices read
        // bottom, lower vertices read top) with clearance below the upper
        // side-label band, because axis labels ring the web: a side box from
        // a top vertex always lands on a neighbour label. An explicit
        // non-default tooltip placement is honoured untouched (no directional
        // override, no extra offset).
        ChartTooltipPlacement? radarPlacement;
        Offset tooltipOffset = widget.tooltip.offset;
        if (anchor != null &&
            widget.tooltip.placement == ChartTooltipPlacement.top) {
          final ({Offset offset, ChartTooltipPlacement placement}) resolved =
              resolveRadarTooltip(
                anchor: anchor,
                frameSize: frame,
                baseOffset: widget.tooltip.offset,
              );
          radarPlacement = resolved.placement;
          tooltipOffset = resolved.offset;
        }
        return TapRegion(
          onTapOutside: (_) => _dismiss(),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (d) =>
                _toggleRadarAxis(d.localPosition, constraints.biggest, series),
            onPanUpdate: (d) =>
                _selectRadarAxis(d.localPosition, constraints.biggest, series),
            child: MouseRegion(
              onHover: (e) => _selectRadarAxis(
                e.localPosition,
                constraints.biggest,
                series,
              ),
              onExit: (_) => _dismiss(),
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
                  if (anchor != null && _selected != null)
                    ChartAnchoredTooltip(
                      anchor: anchor,
                      placement: radarPlacement ?? widget.tooltip.placement,
                      offset: tooltipOffset,
                      child: ChartTooltipCard(
                        data: _tooltipDataFor(surface, series, _selected!),
                        config: widget.tooltip,
                        surface: surface,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _selectRadarAxis(Offset local, Size size, List<ChartSeries> series) {
    final int? idx = _radarIndex(local, size, series);
    if (idx == null) {
      return;
    }
    if (idx != _selected) {
      setState(() => _selected = idx);
    }
  }

  void _toggleRadarAxis(Offset local, Size size, List<ChartSeries> series) {
    final int? idx = _radarIndex(local, size, series);
    if (idx == null) {
      return;
    }
    if (idx == _selected) {
      setState(() => _selected = null);
    } else {
      setState(() => _selected = idx);
    }
  }

  int? _radarIndex(Offset local, Size size, List<ChartSeries> series) {
    final int n = _categoryLength(series);
    if (n < 3 || size.width <= 0 || size.height <= 0) {
      return null;
    }
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Offset delta = local - center;
    if (delta.distance < 4) {
      return null;
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
    return index;
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
        final Size frame = constraints.biggest;
        Offset? anchor;
        ChartTooltipData? tip;
        if (surface.showTooltip && _selected != null) {
          tip = _radialTooltipData(surface, series, paints, _selected!);
          if (tip != null) {
            final double frac = _radialFraction(series, paints, _selected!);
            anchor = chartRadialAnchor(
              size: frame,
              index: _selected!,
              rings: rings,
              fraction: frac,
              startAngle: widget.radial.startAngle,
              sweepFraction: widget.radial.sweep,
            );
          }
        }
        return TapRegion(
          onTapOutside: (_) => _dismiss(),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (d) =>
                _toggleRadialRing(d.localPosition, constraints.biggest, rings),
            onPanUpdate: (d) =>
                _selectRadialRing(d.localPosition, constraints.biggest, rings),
            child: MouseRegion(
              onHover: (e) => _selectRadialRing(
                e.localPosition,
                constraints.biggest,
                rings,
              ),
              onExit: (_) => _dismiss(),
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
                  if (anchor != null && tip != null)
                    ChartAnchoredTooltip(
                      anchor: anchor,
                      placement: widget.tooltip.placement,
                      offset: widget.tooltip.offset,
                      child: ChartTooltipCard(
                        data: tip,
                        config: widget.tooltip,
                        surface: surface,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _selectRadialRing(Offset local, Size size, int rings) {
    final int? idx = _radialIndex(local, size, rings);
    if (idx == null) {
      if (_selected != null && mounted) {
        setState(() => _selected = null);
      }
      return;
    }
    if (idx != _selected) {
      setState(() => _selected = idx);
    }
  }

  void _toggleRadialRing(Offset local, Size size, int rings) {
    final int? idx = _radialIndex(local, size, rings);
    if (idx == null) {
      _dismiss();
      return;
    }
    if (idx == _selected) {
      setState(() => _selected = null);
    } else {
      setState(() => _selected = idx);
    }
  }

  int? _radialIndex(Offset local, Size size, int rings) {
    if (rings == 0 || size.width <= 0 || size.height <= 0) {
      return null;
    }
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = math.min(size.width, size.height) / 2 - 8;
    final double dist = (local - center).distance;
    if (dist > radius + 8) {
      return null;
    }
    final double slot = radius / (rings + 1);
    return ((dist / slot).floor() - 1).clamp(0, rings - 1);
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

  ChartTooltipData? _radialTooltipData(
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
    double? raw;
    Color? color;
    if (paints.length == 1 && paints.first.values.length > 1) {
      final List<double> v = series.first.values;
      if (index < v.length) {
        raw = v[index];
      }
      if (widget.labels != null && index < widget.labels!.length) {
        label = widget.labels![index];
      }
      color = _sliceColor(surface, series.first, index);
    } else {
      int seen = -1;
      for (var si = 0; si < series.length; si++) {
        if (series[si].values.isEmpty) {
          continue;
        }
        seen++;
        if (seen == index) {
          label =
              series[si].label ??
              ComponentLocalizations.of(context).chartSeriesDefault(si);
          raw = series[si].values.first;
          color =
              series[si].color ??
              surface.seriesPalette[si % surface.seriesPalette.length];
          break;
        }
      }
    }
    if (raw == null) {
      return null;
    }
    String? title;
    if (widget.tooltip.showLabel) {
      title = widget.tooltip.labelFormatter?.call(index) ?? label;
    }
    return ChartTooltipData(
      index: index,
      label: title,
      rows: <ChartTooltipRow>[
        ChartTooltipRow(
          label:
              title ??
              label ??
              ComponentLocalizations.of(context).chartValueDefault,
          value: raw,
          color: color,
        ),
      ],
    );
  }

  /// Tooltip data for stacked pies: one row per series at [index].
  ChartTooltipData? _buildStackedPieTooltip(
    ChartSurface surface,
    List<ChartSeries> series,
    int index,
  ) {
    final List<ChartTooltipRow> rows = <ChartTooltipRow>[
      for (var si = 0; si < series.length; si++)
        if (index < series[si].values.length)
          ChartTooltipRow(
            label:
                series[si].label ??
                ComponentLocalizations.of(context).chartSeriesDefault(si),
            value: series[si].values[index],
            color:
                series[si].color ??
                surface.seriesPalette[si % surface.seriesPalette.length],
            icon: series[si].icon,
          ),
    ];
    if (rows.isEmpty) {
      return null;
    }
    String? title;
    if (widget.tooltip.showLabel) {
      title =
          widget.tooltip.labelFormatter?.call(index) ?? _categoryTitle(index);
    }
    return ChartTooltipData(index: index, label: title, rows: rows);
  }

  double _radialFraction(
    List<ChartSeries> series,
    List<ChartSeriesPaint> paints,
    int index,
  ) {
    double maxValue = widget.yAxis.max ?? 0;
    if (paints.length == 1 && paints.first.values.length > 1) {
      for (final double v in paints.first.values) {
        if (v > maxValue) {
          maxValue = v;
        }
      }
      if (maxValue <= 0) {
        maxValue = 1;
      }
      final List<double> v = paints.first.values;
      if (index < v.length) {
        return (v[index] / maxValue).clamp(0.0, 1.0);
      }
      return 0;
    }
    for (final ChartSeriesPaint p in paints) {
      if (p.values.isEmpty) {
        continue;
      }
      if (p.values.first > maxValue) {
        maxValue = p.values.first;
      }
    }
    if (maxValue <= 0) {
      maxValue = 1;
    }
    int seen = -1;
    for (var si = 0; si < paints.length; si++) {
      if (paints[si].values.isEmpty) {
        continue;
      }
      seen++;
      if (seen == index) {
        return (paints[si].values.first / maxValue).clamp(0.0, 1.0);
      }
    }
    return 0;
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
            ComponentLocalizations.of(context).chartSliceDefault(i),
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
        final Size frame = constraints.biggest;
        Offset? anchor;
        ChartTooltipData? tip;
        if (surface.showTooltip && _selected != null && paints.isNotEmpty) {
          final List<double> values = paints.first.values;
          anchor = chartPieAnchor(
            size: frame,
            values: values,
            index: _selected!,
            hole: hole,
            outsideLabels: widget.pie.labels == ChartPieLabels.outside,
          );
          tip = _radialTooltipData(surface, series, paints, _selected!);
        }
        return TapRegion(
          onTapOutside: (_) => _dismiss(),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (d) =>
                _togglePieSlice(d.localPosition, constraints.biggest, paints),
            onPanUpdate: (d) =>
                _selectPieSlice(d.localPosition, constraints.biggest, paints),
            child: MouseRegion(
              onHover: (e) =>
                  _selectPieSlice(e.localPosition, constraints.biggest, paints),
              onExit: (_) => _dismiss(),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  plot,
                  if (widget.centerLabel != null) _buildCenterLabel(surface),
                  if (anchor != null && tip != null)
                    ChartAnchoredTooltip(
                      anchor: anchor,
                      placement: widget.tooltip.placement,
                      offset: widget.tooltip.offset,
                      child: ChartTooltipCard(
                        data: tip,
                        config: widget.tooltip,
                        surface: surface,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _selectPieSlice(Offset local, Size size, List<ChartSeriesPaint> paints) {
    final int? idx = _pieIndex(local, size, paints);
    if (idx == null) {
      if (_selected != null && mounted) {
        setState(() => _selected = null);
        widget.onSelected?.call(null);
      }
      return;
    }
    if (idx != _selected) {
      setState(() => _selected = idx);
      widget.onSelected?.call(idx);
    }
  }

  void _togglePieSlice(Offset local, Size size, List<ChartSeriesPaint> paints) {
    final int? idx = _pieIndex(local, size, paints);
    if (idx == null) {
      _dismiss();
      return;
    }
    if (idx == _selected) {
      setState(() => _selected = null);
      widget.onSelected?.call(null);
    } else {
      setState(() => _selected = idx);
      widget.onSelected?.call(idx);
    }
  }

  int? _pieIndex(Offset local, Size size, List<ChartSeriesPaint> paints) {
    final List<double> values = paints.isEmpty
        ? const <double>[]
        : paints.first.values;
    if (values.isEmpty || size.width <= 0 || size.height <= 0) {
      return null;
    }
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Offset delta = local - center;
    final double radius = math.min(size.width, size.height) / 2;
    if (delta.distance > radius || delta.distance < radius * 0.2) {
      return null;
    }
    final double total = values.fold(0.0, (a, b) => a + b.abs());
    if (total <= 0) {
      return null;
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
    return index;
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

  ChartTooltipData _tooltipDataFor(
    ChartSurface surface,
    List<ChartSeries> series,
    int index,
  ) {
    final List<ChartTooltipRow> rows = <ChartTooltipRow>[
      for (var si = 0; si < series.length; si++)
        if (index < series[si].values.length)
          ChartTooltipRow(
            label:
                series[si].label ??
                ComponentLocalizations.of(context).chartSeriesDefault(si),
            value: series[si].values[index],
            color:
                series[si].color ??
                surface.seriesPalette[si % surface.seriesPalette.length],
            icon: series[si].icon,
          ),
    ];
    String? title;
    if (widget.tooltip.showLabel) {
      title =
          widget.tooltip.labelFormatter?.call(index) ?? _categoryTitle(index);
    }
    return ChartTooltipData(index: index, label: title, rows: rows);
  }

  String _categoryTitle(int index) {
    final List<String>? labels = widget.labels ?? widget.xAxis.labels;
    if (labels != null && index < labels.length) {
      return labels[index];
    }
    return ComponentLocalizations.of(context).chartCategoryDefault(index);
  }

  Offset? _cartesianAnchorFor(
    Size frame,
    ChartSurface surface,
    List<ChartSeries> series,
    double lo,
    double hi,
    bool minimal,
    TextDirection dir,
  ) {
    final int? selected = _selected;
    if (selected == null) {
      return null;
    }
    final int n = _categoryLength(series);
    if (n == 0) {
      return null;
    }
    final bool horizontal =
        widget.type == ChartType.bar &&
        widget.barLayout == ChartBarLayout.horizontal;
    final Rect plot = _cartesianPlotRect(
      frame,
      surface,
      minimal,
      horizontal,
      series,
      dir,
    );
    if (plot.width <= 0 || plot.height <= 0) {
      return null;
    }
    final bool stackedBar =
        widget.type == ChartType.bar && widget.barMode == ChartBarMode.stacked;
    final bool stackedArea =
        widget.type == ChartType.area &&
        widget.areaMode != ChartAreaMode.overlay &&
        series.length > 1;
    final double top = _cartesianTopValue(
      selected,
      series,
      stacked: stackedBar || stackedArea,
      expanded: stackedArea && widget.areaMode == ChartAreaMode.expanded,
    );
    final bool centered = widget.type == ChartType.bar;
    final double baseline = horizontal
        ? math.min(0, lo)
        : (widget.type == ChartType.bar ? math.min(0, lo) : lo);
    return chartCartesianAnchor(
      plot: plot,
      index: selected,
      count: n,
      topValue: top,
      min: lo,
      max: hi,
      centered: centered,
      horizontal: horizontal,
      rtl: dir == TextDirection.rtl,
      baseline: baseline,
    );
  }

  double _cartesianTopValue(
    int index,
    List<ChartSeries> series, {
    required bool stacked,
    required bool expanded,
  }) {
    if (!stacked) {
      double top = double.negativeInfinity;
      for (final ChartSeries s in series) {
        if (index < s.values.length && s.values[index] > top) {
          top = s.values[index];
        }
      }
      return top == double.negativeInfinity ? 0 : top;
    }
    if (expanded) {
      double total = 0;
      for (final ChartSeries s in series) {
        if (index < s.values.length) {
          total += s.values[index];
        }
      }
      return total == 0 ? 0 : 1;
    }
    double pos = 0;
    double top = 0;
    for (final ChartSeries s in series) {
      if (index >= s.values.length) {
        continue;
      }
      final double v = s.values[index];
      if (v >= 0) {
        pos += v;
        if (pos > top) {
          top = pos;
        }
      } else {
        if (v < top && pos == 0) {
          top = v;
        }
      }
    }
    return top;
  }

  Rect _cartesianPlotRect(
    Size size,
    ChartSurface surface,
    bool minimal,
    bool horizontal,
    List<ChartSeries> series,
    TextDirection dir,
  ) {
    const double leftGutter = 40;
    const double bottomGutter = 20;
    const double topPad = 8;
    const double rightPad = 8;
    final bool showLabels = !minimal && surface.showLabels;
    double plotLeft = minimal || !showLabels ? 4 : leftGutter;
    final double plotBottom = minimal || !showLabels ? 4 : bottomGutter;
    double plotRight = rightPad;
    if (horizontal && widget.showBarLabels == true) {
      plotRight = 44;
    }
    if (horizontal && showLabels) {
      plotLeft = _widestCategory(series, surface, dir).clamp(24, 140) + 16;
    }
    return Rect.fromLTWH(
      plotLeft,
      topPad,
      math.max(0, size.width - plotLeft - plotRight),
      math.max(0, size.height - topPad - plotBottom),
    );
  }

  double _widestCategory(
    List<ChartSeries> series,
    ChartSurface surface,
    TextDirection dir,
  ) {
    final int n = _categoryLength(series);
    double widest = 24;
    for (var i = 0; i < n; i++) {
      final String label = _categoryTitle(i);
      final TextPainter tp = TextPainter(
        text: TextSpan(text: label, style: surface.tickStyle),
        textDirection: dir,
      )..layout();
      if (tp.width > widest) {
        widest = tp.width;
      }
    }
    return widest;
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
                    i < labels.length
                        ? labels[i]
                        : ComponentLocalizations.of(
                            context,
                          ).chartSliceDefault(i),
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
            '${series[i].label ?? ComponentLocalizations.of(context).chartSeriesDefault(i)}: ${series[i].values.join(', ')}',
            style: surface.tickStyle,
          ),
      ],
    );
  }

  String _summary(List<ChartSeries> series) {
    final ComponentLocalizations strings = ComponentLocalizations.of(context);
    final String kind = switch (widget.type) {
      ChartType.line => strings.chartKindLine,
      ChartType.area => strings.chartKindArea,
      ChartType.bar => strings.chartKindBar,
      ChartType.donut => strings.chartKindDonut,
      ChartType.pie => strings.chartKindPie,
      ChartType.sparkline => strings.chartKindSparkline,
      ChartType.scatter => strings.chartKindScatter,
      ChartType.radar => strings.chartKindRadar,
      ChartType.radial => strings.chartKindRadial,
    };
    if (series.isEmpty) {
      return strings.chartSummaryEmpty(kind);
    }
    final int points = series.fold(0, (a, s) => a + s.values.length);
    return strings.chartSummary(series.length, points, kind);
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
