// Motion contract for collapsible: one 200 ms run sizes the pane and fades
// its content. Opening fades in after 50 ms; closing fades out first.
// Reduced motion swaps the pane with no ticker.

import 'package:dashcn/src/components/collapsible/collapsible.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(
  WidgetTester tester, {
  bool? isExpanded,
  bool disableAnimations = false,
}) {
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
              child: Collapsible(
                isExpanded: isExpanded,
                children: const <Widget>[
                  CollapsibleTrigger(child: Text('title')),
                  CollapsibleContent(child: Text('content')),
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

double _height(WidgetTester tester) {
  return tester.getSize(find.byType(Collapsible)).height;
}

void main() {
  testWidgets('opening grows the pane and fades content in after 50 ms', (
    WidgetTester tester,
  ) async {
    await _pump(tester);
    final double closed = _height(tester);
    await tester.tap(find.text('title'));
    await tester.pump(const Duration(milliseconds: 50));
    expect(_contentOpacity(tester), closeTo(0, 0.001));
    await tester.pump(const Duration(milliseconds: 75));
    expect(_contentOpacity(tester), greaterThan(0));
    expect(_contentOpacity(tester), lessThan(1));
    expect(_height(tester), greaterThan(closed));
    await tester.pump(const Duration(milliseconds: 200));
    expect(_contentOpacity(tester), 1);
    expect(_height(tester), greaterThan(closed));
    expect(tester.takeException(), isNull);
  });

  testWidgets('closing fades the content out before the pane collapses', (
    WidgetTester tester,
  ) async {
    await _pump(tester, isExpanded: true);
    final double open = _height(tester);
    // Controlled close: flipping the flag plays the exit.
    await _pump(tester, isExpanded: false);
    await tester.pump(const Duration(milliseconds: 50));
    final double early = _contentOpacity(tester);
    await tester.pump(const Duration(milliseconds: 100));
    // Content has faded to zero by the first quarter of the run, while the
    // pane is still partly open.
    expect(_contentOpacity(tester), lessThan(early));
    expect(_contentOpacity(tester), closeTo(0, 0.001));
    expect(_height(tester), lessThan(open));
    expect(_height(tester), greaterThan(0));
    await tester.pump(const Duration(milliseconds: 200));
    expect(_height(tester), lessThan(open));
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced motion swaps the pane with no ticker', (
    WidgetTester tester,
  ) async {
    await _pump(tester, disableAnimations: true);
    await tester.tap(find.text('title'));
    await tester.pump();
    expect(find.text('content'), findsOneWidget);
    expect(find.byType(FadeTransition), findsNothing);
    expect(tester.binding.transientCallbackCount, 0);
  });
}
