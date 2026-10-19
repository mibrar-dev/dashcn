// Tests for anchored tooltip placement, snapping and touch behaviour.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/chart/chart.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame({required Widget child}) {
  return Theme(
    data: const ThemeData(),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Center(child: SizedBox(width: 400, child: child)),
    ),
  );
}

void main() {
  test('nearest index snaps to bucket centre', () {
    expect(chartTooltipNearestIndex(0, 400, 4), 0);
    expect(chartTooltipNearestIndex(49, 400, 4), 0);
    expect(chartTooltipNearestIndex(51, 400, 4), 0);
    expect(chartTooltipNearestIndex(149, 400, 4), 1);
    expect(chartTooltipNearestIndex(151, 400, 4), 1);
    expect(chartTooltipNearestIndex(399, 400, 4), 3);
    expect(chartTooltipNearestIndex(-10, 400, 4), 0);
    expect(chartTooltipNearestIndex(500, 400, 4), 3);
    expect(chartTooltipNearestIndex(10, 0, 4), 0);
    expect(chartTooltipNearestIndex(10, 400, 0), 0);
  });

  test('spread index snaps to nearest point', () {
    expect(chartTooltipNearestSpreadIndex(0, 400, 4), 0);
    expect(chartTooltipNearestSpreadIndex(200, 400, 4), 2);
    expect(chartTooltipNearestSpreadIndex(400, 400, 4), 3);
    expect(chartTooltipNearestSpreadIndex(500, 400, 4), 3);
  });

  test('max width caps to frame minus gutter', () {
    expect(chartTooltipMaxWidth(400), 384);
    expect(chartTooltipMaxWidth(375), 359);
    expect(chartTooltipMaxWidth(10), lessThanOrEqualTo(10));
  });

  test('top flips to bottom when crowded', () {
    const Size frame = Size(400, 220);
    const Size tip = Size(120, 60);
    final ChartTooltipLayout top = resolveChartTooltip(
      anchor: const Offset(200, 20),
      tooltipSize: tip,
      frameSize: frame,
      placement: ChartTooltipPlacement.top,
    );
    expect(top.placement, ChartTooltipPlacement.bottom);
    expect(top.origin.dy, greaterThanOrEqualTo(8));
  });

  test('bottom flips to top when crowded', () {
    const Size frame = Size(400, 220);
    const Size tip = Size(120, 60);
    final ChartTooltipLayout bottom = resolveChartTooltip(
      anchor: const Offset(200, 210),
      tooltipSize: tip,
      frameSize: frame,
      placement: ChartTooltipPlacement.bottom,
    );
    expect(bottom.placement, ChartTooltipPlacement.top);
  });

  test('left flips to right and clamps with gutter', () {
    const Size frame = Size(400, 220);
    const Size tip = Size(120, 60);
    final ChartTooltipLayout left = resolveChartTooltip(
      anchor: const Offset(10, 110),
      tooltipSize: tip,
      frameSize: frame,
      placement: ChartTooltipPlacement.left,
    );
    expect(left.placement, ChartTooltipPlacement.right);
    expect(left.origin.dx, greaterThanOrEqualTo(8));
    expect(left.origin.dx + tip.width, lessThanOrEqualTo(392));
  });

  test('clamp keeps box inside frame with 8px gutter', () {
    const Size frame = Size(400, 220);
    const Size tip = Size(120, 60);
    final ChartTooltipLayout layout = resolveChartTooltip(
      anchor: const Offset(395, 110),
      tooltipSize: tip,
      frameSize: frame,
      placement: ChartTooltipPlacement.top,
    );
    expect(layout.origin.dx, greaterThanOrEqualTo(8));
    expect(layout.origin.dx + tip.width, lessThanOrEqualTo(392));
    expect(layout.origin.dy, greaterThanOrEqualTo(8));
  });

  test('offset dx/dy shifts the anchor', () {
    const Size frame = Size(400, 220);
    const Size tip = Size(100, 40);
    final ChartTooltipLayout base = resolveChartTooltip(
      anchor: const Offset(200, 120),
      tooltipSize: tip,
      frameSize: frame,
      placement: ChartTooltipPlacement.top,
    );
    final ChartTooltipLayout shifted = resolveChartTooltip(
      anchor: const Offset(200, 120),
      tooltipSize: tip,
      frameSize: frame,
      placement: ChartTooltipPlacement.top,
      offset: const Offset(10, 5),
    );
    expect(shifted.origin.dx, base.origin.dx + 10);
    expect(shifted.origin.dy, base.origin.dy + 5);
  });

  test('cartesian bar anchor sits above the bar centre', () {
    const Rect plot = Rect.fromLTWH(40, 8, 320, 192);
    final Offset anchor = chartCartesianAnchor(
      plot: plot,
      index: 1,
      count: 4,
      topValue: 200,
      min: 0,
      max: 400,
      centered: true,
      horizontal: false,
      rtl: false,
      baseline: 0,
    );
    expect(anchor.dx, closeTo(40 + 1.5 / 4 * 320, 0.01));
    expect(anchor.dy, lessThan(plot.bottom));
  });

  test('pie anchor sits off-centre over its sector', () {
    final Offset anchor = chartPieAnchor(
      size: const Size(300, 250),
      values: const <double>[100, 200, 100],
      index: 1,
      hole: 0.55,
      outsideLabels: false,
    );
    final Offset center = const Offset(150, 125);
    expect((anchor - center).distance, greaterThan(10));
  });

  testWidgets('tap shows anchored tooltip, tap again dismisses', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        child: const Chart(
          type: ChartType.bar,
          labels: <String>['a', 'b', 'c'],
          series: <ChartSeries>[
            ChartSeries(label: 'S', values: <double>[1, 2, 3]),
          ],
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.byType(ChartAnchoredTooltip), findsNothing);
    await tester.tap(find.byType(Chart));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.byType(ChartAnchoredTooltip), findsOneWidget);
    await tester.tap(find.byType(Chart));
    await tester.pump();
    expect(find.byType(ChartAnchoredTooltip), findsNothing);
  });

  testWidgets('custom builder paints user widget', (tester) async {
    await tester.pumpWidget(
      _frame(
        child: Chart(
          type: ChartType.bar,
          labels: const <String>['a', 'b'],
          initialSelectedIndex: 0,
          tooltip: ChartTooltipConfig(
            builder: (context, data) =>
                Text('custom-${data.index}', textDirection: TextDirection.ltr),
          ),
          series: const <ChartSeries>[
            ChartSeries(label: 'S', values: <double>[1, 2]),
          ],
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.text('custom-0'), findsOneWidget);
  });

  testWidgets('placement bottom and offset render without overflow', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        child: const Chart(
          type: ChartType.line,
          labels: <String>['a', 'b', 'c'],
          initialSelectedIndex: 2,
          tooltip: ChartTooltipConfig(
            placement: ChartTooltipPlacement.bottom,
            offset: Offset(4, 6),
          ),
          series: <ChartSeries>[
            ChartSeries(label: 'S', values: <double>[1, 5, 3]),
          ],
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 800));
    expect(tester.takeException(), isNull);
    expect(find.byType(ChartAnchoredTooltip), findsOneWidget);
  });
}
