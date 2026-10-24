// Motion contract for number_ticker: a changed value rolls to the new number
// over the 200 ms base token and settles on it. Reduced motion shows the new
// number at once.

import 'package:dashcn/src/components/number_ticker/number_ticker.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(
  WidgetTester tester,
  int number, {
  bool disableAnimations = false,
  int? initial,
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
            child: NumberTicker(
              initialNumber: initial,
              number: number,
              formatter: (double v) => v.round().toString(),
            ),
          ),
        ),
      ),
    ),
  );
}

String _text(WidgetTester tester) {
  return tester.widget<Text>(find.byType(Text)).data!;
}

void main() {
  testWidgets('value rolls from the old number to the new one in 200 ms', (
    WidgetTester tester,
  ) async {
    await _pump(tester, 0, initial: 0);
    await _pump(tester, 100);
    await tester.pump(const Duration(milliseconds: 100));
    final int mid = int.parse(_text(tester));
    expect(mid, greaterThan(0));
    expect(mid, lessThan(100));
    await tester.pump(const Duration(milliseconds: 150));
    expect(_text(tester), '100');
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced motion shows the new number at once', (
    WidgetTester tester,
  ) async {
    await _pump(tester, 0, initial: 0, disableAnimations: true);
    await _pump(tester, 100, disableAnimations: true);
    await tester.pump();
    await tester.pump();
    expect(_text(tester), '100');
    expect(tester.binding.transientCallbackCount, 0);
  });
}
