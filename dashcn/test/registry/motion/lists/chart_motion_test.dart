// Motion contract for charts: series draw in over 600 ms on first show and
// settle fully drawn. Reduced motion draws the final state at once.

import 'package:dashcn/src/components/chart/chart.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(WidgetTester tester, {bool reduced = false}) {
  return tester.pumpWidget(
    MediaQuery(
      data: const MediaQueryData(
        size: Size(600, 500),
      ).copyWith(disableAnimations: reduced),
      child: Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: const Center(
            child: SizedBox(
              width: 400,
              height: 360,
              child: Chart(
                type: ChartType.bar,
                series: <ChartSeries>[
                  ChartSeries(label: 'A', values: <double>[1, 2, 3]),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

TweenAnimationBuilder<double> _draw(WidgetTester tester) {
  return tester.widget<TweenAnimationBuilder<double>>(
    find.byType(TweenAnimationBuilder<double>).first,
  );
}

void main() {
  testWidgets('series draw in over 600 ms on first show and settle', (
    WidgetTester tester,
  ) async {
    await _pump(tester);
    expect(_draw(tester).duration, const Duration(milliseconds: 600));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    // Still mid-draw at 300 ms: the draw tween is running.
    expect(tester.binding.transientCallbackCount, greaterThan(0));
    await tester.pump(const Duration(milliseconds: 400));
    expect(tester.binding.transientCallbackCount, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced motion draws the chart at once with no ticker', (
    WidgetTester tester,
  ) async {
    await _pump(tester, reduced: true);
    expect(_draw(tester).duration, Duration.zero);
    await tester.pump();
    expect(tester.binding.transientCallbackCount, 0);
  });
}
