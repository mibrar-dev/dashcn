// Widget and unit tests for the `chart` component.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/chart/chart.dart';
import 'package:dashcn/src/primitives/chart/chart_math.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/motion.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

const Color _red = Color(0xFFFF0000);

Widget _frame({
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  TextDirection direction = TextDirection.ltr,
  required Widget child,
}) {
  return Theme(
    data: data,
    child: ComponentThemes(
      themes: app,
      child: Directionality(
        textDirection: direction,
        child: Center(child: SizedBox(width: 400, child: child)),
      ),
    ),
  );
}

ChartSurface _surface(WidgetTester tester) {
  final Chart widget = tester.widget<Chart>(find.byType(Chart));
  return resolveChartSurface(
    tester.element(find.byType(Chart)),
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
}

void main() {
  testWidgets('three-line shorthand renders with token surface', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(child: const Chart(data: <double>[1, 2, 3])),
    );
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.byType(Chart), findsOneWidget);
    final surface = _surface(tester);
    expect(surface.seriesPalette, ThemeColors.lightFallback.chartColors);
    expect(surface.strokeWidth, 2);
    expect(surface.animate, isTrue);
  });

  testWidgets('renders at several sizes without overflow', (tester) async {
    for (final width in <double>[320, 400, 800]) {
      await tester.pumpWidget(
        Theme(
          data: const ThemeData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: SizedBox(
                width: width,
                child: const Chart(
                  type: ChartType.bar,
                  series: <ChartSeries>[
                    ChartSeries(label: 'A', values: <double>[1, 2, 3]),
                    ChartSeries(label: 'B', values: <double>[2, 1, 4]),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 800));
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('every family renders', (tester) async {
    for (final type in ChartType.values) {
      await tester.pumpWidget(
        _frame(
          child: Chart(
            type: type,
            series: const <ChartSeries>[
              ChartSeries(label: 'S', values: <double>[2, 4, 3, 5]),
            ],
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 800));
      expect(tester.takeException(), isNull, reason: '$type');
    }
  });

  testWidgets('grouped and stacked bars render', (tester) async {
    for (final mode in ChartBarMode.values) {
      await tester.pumpWidget(
        _frame(
          child: Chart(
            type: ChartType.bar,
            barMode: mode,
            series: const <ChartSeries>[
              ChartSeries(label: 'A', values: <double>[1, 2]),
              ChartSeries(label: 'B', values: <double>[2, 1]),
            ],
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 800));
      expect(tester.takeException(), isNull, reason: '$mode');
    }
  });

  testWidgets('every part can be disabled', (tester) async {
    await tester.pumpWidget(
      _frame(
        child: const Chart(
          data: <double>[1, 2, 3],
          showGrid: false,
          showAxes: false,
          showTicks: false,
          showLabels: false,
          showLegend: false,
          showTooltip: false,
          showMarkers: false,
          xAxis: ChartAxis.hidden,
          yAxis: ChartAxis.hidden,
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 800));
    final surface = _surface(tester);
    expect(surface.showGrid, isFalse);
    expect(surface.showAxes, isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets('widget args restyle the surface', (tester) async {
    await tester.pumpWidget(
      _frame(
        child: const Chart(
          data: <double>[1, 2, 3],
          gridColor: _red,
          strokeWidth: 5,
          barRadius: 9,
          donutHole: 0.2,
        ),
      ),
    );
    final surface = _surface(tester);
    expect(surface.gridColor, _red);
    expect(surface.strokeWidth, 5);
    expect(surface.barRadius, 9);
    expect(surface.donutHole, 0.2);
  });

  testWidgets('theme legs merge per field', (tester) async {
    await tester.pumpWidget(
      _frame(
        app: const <ComponentThemeData>[
          ChartTheme(strokeWidth: 7, showGrid: false),
        ],
        child: const Chart(data: <double>[1, 2, 3]),
      ),
    );
    expect(_surface(tester).strokeWidth, 7);
    expect(_surface(tester).showGrid, isFalse);
  });

  test('streaming controller keeps the window size', () {
    final ChartController controller = ChartController(
      maxPoints: 3,
      initial: const <ChartSeries>[
        ChartSeries(label: 'S', values: <double>[1, 2, 3]),
      ],
    );
    controller.append(4);
    expect(controller.series.first.values, <double>[2, 3, 4]);
    controller.appendPoints(<double>[5]);
    expect(controller.series.first.values, <double>[3, 4, 5]);
    controller.dispose();
  });

  test('ring buffer trims to maxPoints', () {
    expect(chartWindow(const <double>[1, 2, 3, 4], 2), <double>[3, 4]);
    final ChartRingBuffer<int> buffer = ChartRingBuffer<int>(maxPoints: 2);
    buffer.addAll(const <int>[1, 2, 3]);
    expect(buffer.items, <int>[2, 3]);
  });

  testWidgets('reduced motion settles immediately', (tester) async {
    await tester.pumpWidget(
      Theme(
        data: const ThemeData(motion: MotionTokens(enabled: false)),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              width: 400,
              child: const Chart(data: <double>[1, 5, 3]),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    final Finder tween = find.byType(TweenAnimationBuilder<double>);
    expect(tween, findsOneWidget);
    expect(
      tester.widget<TweenAnimationBuilder<double>>(tween).duration,
      Duration.zero,
    );
  });

  testWidgets('disableAnimation jumps to final state', (tester) async {
    await tester.pumpWidget(
      _frame(
        child: const Chart(data: <double>[1, 2, 3], disableAnimation: true),
      ),
    );
    expect(
      tester
          .widget<TweenAnimationBuilder<double>>(
            find.byType(TweenAnimationBuilder<double>),
          )
          .duration,
      Duration.zero,
    );
  });

  testWidgets('semantics summary and table fallback', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _frame(
        child: const Chart(
          series: <ChartSeries>[
            ChartSeries(label: 'Web', values: <double>[1, 2]),
          ],
          showDataTable: true,
          semanticsLabel: 'Custom summary',
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.textContaining('Web: 1.0, 2.0'), findsOneWidget);
    final semantics = tester.getSemantics(find.byType(Chart));
    expect(semantics.label, contains('Custom summary'));
    handle.dispose();
  });

  testWidgets('RTL renders', (tester) async {
    await tester.pumpWidget(
      _frame(
        direction: TextDirection.rtl,
        child: const Chart(data: <double>[1, 2, 3]),
      ),
    );
    await tester.pump(const Duration(milliseconds: 800));
    expect(tester.takeException(), isNull);
  });

  testWidgets('per-series dash and markers do not crash', (tester) async {
    await tester.pumpWidget(
      _frame(
        child: const Chart(
          type: ChartType.line,
          series: <ChartSeries>[
            ChartSeries(
              label: 'Dashed',
              values: <double>[1, 4, 2, 5],
              dash: <double>[6, 4],
              showMarkers: true,
            ),
          ],
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 800));
    expect(tester.takeException(), isNull);
  });

  testWidgets('radar renders with 0/1/many series, empty and negative data', (
    tester,
  ) async {
    const List<List<ChartSeries>> cases = <List<ChartSeries>>[
      <ChartSeries>[],
      <ChartSeries>[ChartSeries(values: <double>[])],
      <ChartSeries>[
        ChartSeries(values: <double>[5]),
      ],
      <ChartSeries>[
        ChartSeries(label: 'A', values: <double>[1, 2, 3]),
      ],
      <ChartSeries>[
        ChartSeries(label: 'A', values: <double>[1, 2, 3, 4, 5]),
        ChartSeries(label: 'B', values: <double>[5, 4, 3, 2, 1]),
        ChartSeries(label: 'C', values: <double>[-2, 0, 2]),
      ],
    ];
    for (final List<ChartSeries> series in cases) {
      await tester.pumpWidget(
        _frame(
          child: Chart(
            type: ChartType.radar,
            labels: const <String>['a', 'b', 'c', 'd', 'e'],
            series: series,
            showMarkers: true,
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 800));
      expect(tester.takeException(), isNull, reason: '$series');
    }
  });

  testWidgets('radar grid variants render', (tester) async {
    const List<ChartRadarConfig> configs = <ChartRadarConfig>[
      ChartRadarConfig(),
      ChartRadarConfig(grid: ChartRadarGrid.circle),
      ChartRadarConfig(grid: ChartRadarGrid.none),
      ChartRadarConfig(grid: ChartRadarGrid.circle, showSpokes: false),
      ChartRadarConfig(grid: ChartRadarGrid.circle, filled: true),
      ChartRadarConfig(filled: true),
      ChartRadarConfig(rings: 1, showSpokes: false),
      ChartRadarConfig(showValues: true),
    ];
    for (final ChartRadarConfig radar in configs) {
      await tester.pumpWidget(
        _frame(
          child: Chart(
            type: ChartType.radar,
            radar: radar,
            labels: const <String>['a', 'b', 'c', 'd'],
            series: const <ChartSeries>[
              ChartSeries(values: <double>[1, 2, 3, 4]),
            ],
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 800));
      expect(tester.takeException(), isNull, reason: '$radar');
    }
  });

  testWidgets('radial renders with 0/1/many rings, empty and negative data', (
    tester,
  ) async {
    const List<List<ChartSeries>> cases = <List<ChartSeries>>[
      <ChartSeries>[],
      <ChartSeries>[ChartSeries(values: <double>[])],
      <ChartSeries>[
        ChartSeries(values: <double>[5]),
      ],
      <ChartSeries>[
        ChartSeries(label: 'A', values: <double>[1, 2, 3]),
      ],
      <ChartSeries>[
        ChartSeries(label: 'A', values: <double>[4]),
        ChartSeries(label: 'B', values: <double>[-2]),
        ChartSeries(label: 'C', values: <double>[0]),
      ],
    ];
    for (final List<ChartSeries> series in cases) {
      await tester.pumpWidget(
        _frame(
          child: Chart(
            type: ChartType.radial,
            series: series,
            centerLabel: 'x',
            centerSublabel: 'y',
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 800));
      expect(tester.takeException(), isNull, reason: '$series');
    }
  });

  testWidgets('radial config variants render', (tester) async {
    const List<ChartRadialConfig> configs = <ChartRadialConfig>[
      ChartRadialConfig(),
      ChartRadialConfig(showGrid: true),
      ChartRadialConfig(showRingLabels: true),
      ChartRadialConfig(stacked: true, sweep: 0.5, rounded: true),
      ChartRadialConfig(sweep: 250 / 360, rounded: true),
      ChartRadialConfig(sweep: 100 / 360, thickness: 0.35),
    ];
    for (final ChartRadialConfig radial in configs) {
      await tester.pumpWidget(
        _frame(
          child: Chart(
            type: ChartType.radial,
            radial: radial,
            showLegend: false,
            series: const <ChartSeries>[
              ChartSeries(label: 'A', values: <double>[4]),
              ChartSeries(label: 'B', values: <double>[2]),
            ],
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 800));
      expect(tester.takeException(), isNull, reason: '$radial');
    }
  });

  testWidgets('tooltip configs render with a preset selection', (tester) async {
    const List<ChartTooltipConfig> configs = <ChartTooltipConfig>[
      ChartTooltipConfig(),
      ChartTooltipConfig(indicator: ChartTooltipIndicator.line),
      ChartTooltipConfig(indicator: ChartTooltipIndicator.none),
      ChartTooltipConfig(showLabel: false),
      ChartTooltipConfig(showLabel: false, valueSuffix: ' kcal'),
      ChartTooltipConfig(
        showLabel: false,
        valueSuffix: ' kcal',
        showTotal: true,
      ),
    ];
    for (final ChartTooltipConfig tooltip in configs) {
      await tester.pumpWidget(
        _frame(
          child: Chart(
            type: ChartType.bar,
            barMode: ChartBarMode.stacked,
            tooltip: tooltip,
            initialSelectedIndex: 1,
            labels: const <String>['Mon', 'Tue'],
            series: const <ChartSeries>[
              ChartSeries(label: 'Running', values: <double>[4, 3]),
              ChartSeries(label: 'Swimming', values: <double>[3, 4]),
            ],
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 800));
      expect(tester.takeException(), isNull, reason: '$tooltip');
    }
    // The advanced look shows rows, suffix and total.
    await tester.pumpWidget(
      _frame(
        child: const Chart(
          type: ChartType.bar,
          barMode: ChartBarMode.stacked,
          initialSelectedIndex: 1,
          tooltip: ChartTooltipConfig(
            showLabel: false,
            valueSuffix: ' kcal',
            showTotal: true,
          ),
          labels: <String>['Mon', 'Tue'],
          series: <ChartSeries>[
            ChartSeries(label: 'Running', values: <double>[4, 3]),
            ChartSeries(label: 'Swimming', values: <double>[3, 4]),
          ],
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.text('Running'), findsWidgets);
    expect(find.text('3 kcal'), findsWidgets);
    expect(find.text('Total'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  test('tooltip value compaction drops integral decimals', () {
    expect(chartCompactValue(450), '450');
    expect(chartCompactValue(4.5), '4.5');
  });
}
