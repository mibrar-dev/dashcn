// Tests for anchored tooltip placement, snapping and touch behaviour.

import 'dart:math' as math;

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

  test('radar placement parks toward the chart interior', () {
    const Size frame = Size(400, 260);
    // Top vertex (January): the box hangs below the vertex, over the web.
    final Offset top = chartRadarAnchor(
      size: frame,
      index: 0,
      count: 6,
      rtl: false,
    );
    expect(top.dy, lessThan(frame.height / 2));
    expect(
      chartRadarTooltipPlacement(anchor: top, frameSize: frame),
      ChartTooltipPlacement.bottom,
    );
    // Every other vertex follows the same interior rule.
    for (var i = 1; i < 6; i++) {
      final Offset anchor = chartRadarAnchor(
        size: frame,
        index: i,
        count: 6,
        rtl: false,
      );
      expect(
        chartRadarTooltipPlacement(anchor: anchor, frameSize: frame),
        anchor.dy < frame.height / 2
            ? ChartTooltipPlacement.bottom
            : ChartTooltipPlacement.top,
        reason: 'index $i',
      );
    }
  });

  test('radar resolver pushes the top-vertex box below the label band', () {
    const Size frame = Size(400, 260);
    final Offset top = chartRadarAnchor(
      size: frame,
      index: 0,
      count: 6,
      rtl: false,
    );
    final resolved = resolveRadarTooltip(
      anchor: top,
      frameSize: frame,
      baseOffset: Offset.zero,
    );
    expect(resolved.placement, ChartTooltipPlacement.bottom);
    expect(resolved.offset.dy, greaterThan(0));
    // A user offset is kept and the push only covers the remaining deficit.
    final pushed = resolveRadarTooltip(
      anchor: top,
      frameSize: frame,
      baseOffset: const Offset(0, 100),
    );
    expect(pushed.offset.dy, 100);
    // Lower-half vertices keep plain top placement with no extra push.
    final Offset bottom = chartRadarAnchor(
      size: frame,
      index: 3,
      count: 6,
      rtl: false,
    );
    final resolvedBottom = resolveRadarTooltip(
      anchor: bottom,
      frameSize: frame,
      baseOffset: Offset.zero,
    );
    expect(resolvedBottom.placement, ChartTooltipPlacement.top);
    expect(resolvedBottom.offset, Offset.zero);
  });

  testWidgets('radar top-vertex tooltip clears every axis label', (
    tester,
  ) async {
    const List<String> months = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
    ];
    // Desktop and phone widths: the box must never sit over a label and must
    // stay inside the frame gutter.
    for (final double width in <double>[400, 343]) {
      await tester.pumpWidget(
        Theme(
          data: const ThemeData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: SizedBox(
                width: width,
                child: const Chart(
                  type: ChartType.radar,
                  labels: months,
                  height: 260,
                  disableAnimation: true,
                  initialSelectedIndex: 0,
                  series: <ChartSeries>[
                    ChartSeries(
                      label: 'Desktop',
                      values: <double>[186, 305, 237, 73, 209, 214],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull, reason: 'width $width');
      final ChartAnchoredTooltip tip = tester.widget<ChartAnchoredTooltip>(
        find.byType(ChartAnchoredTooltip),
      );
      expect(
        tip.placement,
        ChartTooltipPlacement.bottom,
        reason: 'width $width',
      );
      final Rect tipGlobal = tester.getRect(find.byType(ChartTooltipCard));
      final Rect chartGlobal = tester.getRect(find.byType(Chart));
      final Chart chartWidget = tester.widget<Chart>(find.byType(Chart));
      final ChartSurface surface = resolveChartSurface(
        tester.element(find.byType(Chart)),
        widgetTheme: chartWidget.theme,
        showGrid: chartWidget.showGrid,
        showAxes: chartWidget.showAxes,
        showTicks: chartWidget.showTicks,
        showLabels: chartWidget.showLabels,
        showLegend: chartWidget.showLegend,
        showTooltip: chartWidget.showTooltip,
        showMarkers: chartWidget.showMarkers,
        strokeWidth: chartWidget.strokeWidth,
        markerRadius: chartWidget.markerRadius,
        barRadius: chartWidget.barRadius,
        barGap: chartWidget.barGap,
        barGroupGap: chartWidget.barGroupGap,
        fillOpacity: chartWidget.fillOpacity,
        contentPadding: chartWidget.contentPadding,
        animationDuration: chartWidget.animationDuration,
        animationCurve: chartWidget.animationCurve,
        disableAnimation: chartWidget.disableAnimation,
        donutHole: chartWidget.donutHole,
        gridColor: chartWidget.gridColor,
        axisColor: chartWidget.axisColor,
      );
      final EdgeInsets pad = surface.contentPadding is EdgeInsets
          ? surface.contentPadding as EdgeInsets
          : EdgeInsets.zero;
      final Size frame = Size(chartGlobal.width - pad.left - pad.right, 260);
      final Rect tipFrame = tipGlobal.shift(
        -(chartGlobal.topLeft + Offset(pad.left, pad.top)),
      );
      expect(tipFrame.left, greaterThanOrEqualTo(8), reason: 'width $width');
      expect(tipFrame.top, greaterThanOrEqualTo(8), reason: 'width $width');
      expect(
        tipFrame.right,
        lessThanOrEqualTo(frame.width - 8),
        reason: 'width $width',
      );
      expect(
        tipFrame.bottom,
        lessThanOrEqualTo(frame.height - 8),
        reason: 'width $width',
      );
      // Axis label geometry mirrors ChartRadarPainter (radius from the
      // widest month label, labels at radius + 8).
      final TextStyle monthStyle = surface.tickStyle.copyWith(fontSize: 12);
      final List<TextPainter> labels = <TextPainter>[
        for (final String month in months)
          TextPainter(
            text: TextSpan(text: month, style: monthStyle),
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
          )..layout(),
      ];
      double widest = 0;
      for (final TextPainter label in labels) {
        widest = math.max(widest, label.width);
      }
      final double labelH = labels.first.height;
      final double radius = math.max(
        0,
        math.min(
          (frame.width - widest - 24) / 2,
          (frame.height - labelH * 2 - 24) / 2,
        ),
      );
      final Offset center = Offset(frame.width / 2, frame.height / 2);
      for (var i = 0; i < months.length; i++) {
        final double angle = -math.pi / 2 + i * 2 * math.pi / months.length;
        final Offset outer = Offset(
          center.dx + math.cos(angle) * (radius + 8),
          center.dy + math.sin(angle) * (radius + 8),
        );
        double dy = outer.dy - labels[i].height / 2;
        if (i == 0) {
          dy = outer.dy - labels[i].height / 2 - 10;
        } else if ((i * 2) == months.length) {
          dy = outer.dy + 2;
        }
        final double dx = math.max(0, outer.dx - labels[i].width / 2);
        final Rect labelRect = Rect.fromLTWH(
          dx,
          dy,
          labels[i].width,
          labels[i].height,
        );
        expect(
          tipFrame.overlaps(labelRect),
          isFalse,
          reason: 'width $width covers ${months[i]} ($tipFrame vs $labelRect)',
        );
      }
    }
  });
}
