// Motion contract for badge: a numeric label rolls its digits to the new
// value over the 200 ms base token. Reduced motion shows the value at once.

import 'package:dashcn/src/components/badge/badge.dart';
import 'package:dashcn/src/components/number_ticker/number_ticker.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(WidgetTester tester, String count, {bool reduced = false}) {
  return tester.pumpWidget(
    MediaQuery(
      data: const MediaQueryData(
        size: Size(200, 100),
      ).copyWith(disableAnimations: reduced),
      child: Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(child: Badge(child: Text(count))),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('digits roll to the new count over 200 ms', (
    WidgetTester tester,
  ) async {
    await _pump(tester, '9');
    await tester.pump();
    await _pump(tester, '10');
    await tester.pump();
    final FlipperCharacter roll = tester.widget<FlipperCharacter>(
      find.byType(FlipperCharacter).first,
    );
    expect(roll.duration, const Duration(milliseconds: 200));
    // Mid-roll the first digit is still moving, then it settles on '1'.
    await tester.pump(const Duration(milliseconds: 100));
    expect(tester.takeException(), isNull);
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('1'), findsWidgets);
    expect(find.text('0'), findsWidgets);
    expect(tester.binding.transientCallbackCount, 0);
  });

  testWidgets('reduced motion shows the new count at once', (
    WidgetTester tester,
  ) async {
    await _pump(tester, '9', reduced: true);
    await tester.pump();
    await _pump(tester, '10', reduced: true);
    await tester.pump();
    final FlipperCharacter roll = tester.widget<FlipperCharacter>(
      find.byType(FlipperCharacter).first,
    );
    expect(roll.duration, Duration.zero);
    expect(find.text('10'), findsNothing);
    expect(find.text('1'), findsWidgets);
  });
}
