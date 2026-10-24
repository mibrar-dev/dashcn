// Motion contract for calendar and date picker: a month change slides the new
// grid in the direction of travel over the 200 ms base token. Reduced motion
// swaps the month with no slide.

import 'package:dashcn/src/components/calendar/calendar.dart';
import 'package:dashcn/src/primitives/date_math.dart';
import 'package:dashcn/src/primitives/motion/fade_slide_in.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(
  WidgetTester tester,
  CalendarView view, {
  bool reduced = false,
}) {
  return tester.pumpWidget(
    MediaQuery(
      data: const MediaQueryData(
        size: Size(400, 500),
      ).copyWith(disableAnimations: reduced),
      child: Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              width: 320,
              child: Calendar(view: view, now: DateTime(2026, 3, 15)),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('a forward month change slides the grid in over 200 ms', (
    WidgetTester tester,
  ) async {
    await _pump(tester, const CalendarView(2026, 3));
    await tester.pump();
    await _pump(tester, const CalendarView(2026, 4));
    await tester.pump();
    final FadeSlideIn slide = tester.widget<FadeSlideIn>(
      find.byType(FadeSlideIn).first,
    );
    expect(slide.offset.dx, greaterThan(0));
    expect(slide.offset.dy, 0);
    expect(slide.duration, const Duration(milliseconds: 200));
    await tester.pump(const Duration(milliseconds: 100));
    expect(tester.binding.transientCallbackCount, greaterThan(0));
    expect(tester.takeException(), isNull);
    await tester.pump(const Duration(milliseconds: 250));
    expect(tester.binding.transientCallbackCount, 0);
  });

  testWidgets('reduced motion swaps the month with no slide', (
    WidgetTester tester,
  ) async {
    await _pump(tester, const CalendarView(2026, 3), reduced: true);
    await _pump(tester, const CalendarView(2026, 4), reduced: true);
    await tester.pump();
    expect(tester.binding.transientCallbackCount, 0);
  });
}
