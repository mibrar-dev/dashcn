// Motion contract for chart tooltips: the tooltip follows the pointer with no
// lag. A moved pointer repositions the card in the first frame after the move
// (no animation to wait for).

import 'dart:ui' show PointerDeviceKind;

import 'package:dashcn/src/components/chart/chart.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(WidgetTester tester) {
  return tester.pumpWidget(
    MediaQuery(
      data: const MediaQueryData(size: Size(600, 500)),
      child: Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: const Center(
            child: SizedBox(
              width: 400,
              height: 300,
              child: Chart(
                type: ChartType.line,
                series: <ChartSeries>[
                  ChartSeries(label: 'A', values: <double>[1, 4, 2, 6, 3]),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('tooltip moves with the pointer in the same frame', (
    WidgetTester tester,
  ) async {
    await _pump(tester);
    // Let the draw-in finish so only pointer motion moves the card.
    await tester.pump(const Duration(milliseconds: 700));
    final Offset chart = tester.getTopLeft(find.byType(Chart));
    final TestPointer pointer = TestPointer(1, PointerDeviceKind.mouse);
    await tester.sendEventToBinding(
      pointer.hover(chart + const Offset(40, 150)),
    );
    await tester.pump();
    final double first = tester.getTopLeft(find.byType(ChartTooltipCard)).dx;

    await tester.sendEventToBinding(
      pointer.hover(chart + const Offset(340, 150)),
    );
    await tester.pump();
    final double afterOneFrame = tester
        .getTopLeft(find.byType(ChartTooltipCard))
        .dx;
    await tester.pump(const Duration(milliseconds: 400));
    final double settled = tester.getTopLeft(find.byType(ChartTooltipCard)).dx;

    expect(afterOneFrame, greaterThan(first + 10));
    // No lag: the position after one frame is already where it settles.
    expect(afterOneFrame, closeTo(settled, 0.5));
    expect(tester.takeException(), isNull);
  });
}
