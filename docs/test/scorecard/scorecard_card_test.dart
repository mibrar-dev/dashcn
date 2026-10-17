// Scorecard card tests (P9-5b): pass/fail/not-measured badges, expandable
// failure details and the measured footer. Widgets-only (no material).

import 'package:docs/generated/docs_scorecards.dart';
import 'package:docs/ui/dashcn/theme/color_tokens.dart';
import 'package:docs/ui/dashcn/theme/theme.dart' as dashcn;
import 'package:docs/widgets/scorecard/scorecard_card.dart';
import 'package:docs/widgets/scorecard/scorecard_sections.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _pumpCard(
  String componentId, {
  Brightness brightness = Brightness.light,
}) {
  final ThemeColors colors = brightness == Brightness.dark
      ? ThemeColors.darkFallback
      : ThemeColors.lightFallback;
  return WidgetsApp(
    color: const Color(0xFFFFFFFF),
    builder: (BuildContext context, Widget? child) => Directionality(
      textDirection: TextDirection.ltr,
      child: dashcn.Theme(
        data: dashcn.ThemeData(colors: colors),
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 600,
            child: SingleChildScrollView(
              child: ScorecardCard(componentId: componentId),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('passing component shows Pass and no Fail or Not measured', (
    WidgetTester tester,
  ) async {
    expect(kScorecards.containsKey('accordion'), isTrue);
    await tester.pumpWidget(_pumpCard('accordion'));
    await tester.pumpAndSettle();
    expect(find.text('Trust scorecard'), findsOneWidget);
    expect(find.text('Pass'), findsWidgets);
    expect(find.text('Fail'), findsNothing);
    expect(find.text('Not measured'), findsNothing);
    expect(find.text('Accessibility'), findsOneWidget);
    expect(find.text('Right-to-left'), findsOneWidget);
    expect(
      find.text('Frame build time — test environment (relative)'),
      findsOneWidget,
    );
    expect(find.text('Tests'), findsWidgets);
    expect(
      find.textContaining('Mobile tap-target guideline (44/48 px)'),
      findsWidgets,
    );
  });

  testWidgets('calendar shows Pass and the footer', (
    WidgetTester tester,
  ) async {
    expect(kScorecards.containsKey('calendar'), isTrue);
    await tester.pumpWidget(_pumpCard('calendar'));
    await tester.pumpAndSettle();
    expect(find.text('Fail'), findsNothing);
    expect(find.text('Pass'), findsWidgets);
    expect(find.text('How we measure'), findsOneWidget);
    expect(find.textContaining('measured on '), findsOneWidget);
    expect(find.textContaining(kScorecardsCommitShort), findsWidgets);
  });

  testWidgets('unknown component shows Not measured and never a pass', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_pumpCard('not-a-component'));
    await tester.pumpAndSettle();
    expect(find.text('Not measured'), findsWidgets);
    expect(find.text('Pass'), findsNothing);
    expect(find.text('Fail'), findsNothing);
    expect(find.text('Show details'), findsNothing);
  });

  testWidgets('failing detail expands to reveal the guideline message', (
    WidgetTester tester,
  ) async {
    // Synthetic failing record: every measured component passes now, so the
    // Fail path is covered with fixture data on the section directly.
    const DocsScorecard failing = DocsScorecard(
      componentId: 'fixture',
      a11y: DocsScorecardA11y(
        textContrast: DocsScorecardCheck(passed: true),
        labeledTapTarget: DocsScorecardCheck(passed: true),
        androidTapTarget: DocsScorecardCheck(
          passed: false,
          message: 'expected tap target size of at least Size(48.0, 48.0)',
        ),
        iOSTapTarget: DocsScorecardCheck(passed: true),
        semantics: DocsScorecardSemantics(present: true),
      ),
      rtl: DocsScorecardRtl(passed: true, renders: true, mirrored: true),
      frames: DocsScorecardFrames(
        p50Ms: 0.1,
        p90Ms: 0.2,
        frames: 120,
        label: 'test environment (relative)',
      ),
      tests: DocsScorecardTests(count: 1, passed: true),
    );
    await tester.pumpWidget(
      WidgetsApp(
        color: const Color(0xFFFFFFFF),
        builder: (BuildContext context, Widget? child) => Directionality(
          textDirection: TextDirection.ltr,
          child: dashcn.Theme(
            data: dashcn.ThemeData(colors: ThemeColors.lightFallback),
            child: const Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 600,
                child: SingleChildScrollView(
                  child: ScorecardA11ySection(scorecard: failing, rowGap: 8),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Fail'), findsWidgets);
    expect(find.textContaining('expected tap target size'), findsNothing);
    await tester.tap(find.text('Show details').first);
    await tester.pumpAndSettle();
    expect(find.textContaining('expected tap target size'), findsWidgets);
  });

  testWidgets('card renders in dark brightness', (WidgetTester tester) async {
    await tester.pumpWidget(
      _pumpCard('accordion', brightness: Brightness.dark),
    );
    await tester.pumpAndSettle();
    expect(find.text('Trust scorecard'), findsOneWidget);
    expect(find.text('Pass'), findsWidgets);
  });
}
