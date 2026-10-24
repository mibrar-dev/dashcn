// Motion contract for accordion: height and chevron share one 200 ms run,
// and the content fades in after 50 ms (a quarter of the run). Reduced
// motion swaps the section with no ticker.

import 'dart:math' as math;

import 'package:dashcn/src/components/accordion/accordion.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(WidgetTester tester, {bool disableAnimations = false}) {
  return tester.pumpWidget(
    MediaQuery(
      data: const MediaQueryData(
        size: Size(600, 600),
      ).copyWith(disableAnimations: disableAnimations),
      child: Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              width: 360,
              child: Accordion(
                items: const <Widget>[
                  AccordionItem(
                    trigger: AccordionTrigger(child: Text('title')),
                    content: Text('content'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

double _contentOpacity(WidgetTester tester) {
  return tester
      .widget<FadeTransition>(find.byType(FadeTransition).first)
      .opacity
      .value;
}

/// Chevron angle in radians, read from the rotation nearest the icon.
double _chevronAngle(WidgetTester tester) {
  final Transform t = tester.widget<Transform>(
    find
        .ancestor(of: find.byType(Icon), matching: find.byType(Transform))
        .first,
  );
  return math.atan2(t.transform.entry(1, 0), t.transform.entry(0, 0));
}

void main() {
  testWidgets('content fades in after 50 ms while the chevron turns', (
    WidgetTester tester,
  ) async {
    await _pump(tester);
    expect(_chevronAngle(tester).abs(), closeTo(math.pi, 0.01));
    await tester.tap(find.text('title'));
    // The first frame after the tap starts the 200 ms run.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(_contentOpacity(tester), closeTo(0, 0.001));
    await tester.pump(const Duration(milliseconds: 50));
    expect(_contentOpacity(tester), greaterThan(0));
    expect(_contentOpacity(tester), lessThan(1));
    // The chevron is mid-turn while the content is still fading in.
    expect(_chevronAngle(tester).abs(), greaterThan(0.1));
    expect(_chevronAngle(tester).abs(), lessThan(math.pi - 0.1));
    await tester.pump(const Duration(milliseconds: 200));
    expect(_contentOpacity(tester), 1);
    expect(_chevronAngle(tester).abs(), closeTo(0, 0.01));
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced motion shows the section at once with no ticker', (
    WidgetTester tester,
  ) async {
    await _pump(tester, disableAnimations: true);
    await tester.tap(find.text('title'));
    await tester.pump();
    await tester.pump();
    expect(_chevronAngle(tester).abs(), closeTo(0, 0.01));
    expect(tester.binding.transientCallbackCount, 0);
  });
}
