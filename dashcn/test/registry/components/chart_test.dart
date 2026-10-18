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
}
