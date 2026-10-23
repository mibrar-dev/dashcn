// Motion contract for progress: a determinate value animates its fill over
// 300 ms and settles on the new value. Reduced motion jumps straight to it.

import 'package:dashcn/src/components/progress/progress.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(
  WidgetTester tester,
  double value, {
  bool disableAnimations = false,
}) {
  return tester.pumpWidget(
    MediaQuery(
      data: const MediaQueryData(
        size: Size(400, 300),
      ).copyWith(disableAnimations: disableAnimations),
      child: Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(width: 240, child: Progress(value: value)),
          ),
        ),
      ),
    ),
  );
}

/// The fill fraction the determinate painter is currently drawing.
double _fill(WidgetTester tester) {
  final Finder paint = find.byWidgetPredicate(
    (Widget w) =>
        w is CustomPaint &&
        w.painter.runtimeType.toString() == '_ProgressPainter',
  );
  return (tester.widget<CustomPaint>(paint.first).painter! as dynamic).end
      as double;
}

void main() {
  testWidgets('determinate fill animates over 300 ms and settles on value', (
    WidgetTester tester,
  ) async {
    await _pump(tester, 0.2);
    await tester.pump();
    expect(_fill(tester), closeTo(0.2, 0.01));
    await _pump(tester, 0.8);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 150));
    expect(_fill(tester), greaterThan(0.2));
    expect(_fill(tester), lessThan(0.8));
    await tester.pump(const Duration(milliseconds: 300));
    expect(_fill(tester), closeTo(0.8, 0.01));
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced motion jumps straight to the new value', (
    WidgetTester tester,
  ) async {
    await _pump(tester, 0.2, disableAnimations: true);
    await _pump(tester, 0.8, disableAnimations: true);
    await tester.pump();
    expect(_fill(tester), closeTo(0.8, 0.01));
    expect(tester.binding.transientCallbackCount, 0);
  });
}
