// Motion contract for swipe_actions dismiss: the row slides out of view over
// the first 200 ms, then its height collapses over the next 200 ms, and
// onDismissed fires only after both phases. Reduced motion commits at once.

import 'package:dashcn/src/components/swipe_actions/swipe_actions.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  bool disableAnimations = false,
}) {
  return tester.pumpWidget(
    MediaQuery(
      data: const MediaQueryData(
        size: Size(390, 600),
      ).copyWith(disableAnimations: disableAnimations),
      child: Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(child: SizedBox(width: 390, child: child)),
        ),
      ),
    ),
  );
}

SwipeActions _row(VoidCallback onDismissed) {
  return SwipeActions(
    actions: <SwipeAction>[
      SwipeAction(label: 'Delete', destructive: true, onPressed: () {}),
    ],
    onDismissed: onDismissed,
    child: const Text('row'),
  );
}

/// Horizontal offset of the outermost translate that carries the row.
double _slideX(WidgetTester tester) {
  final Iterable<Transform> ancestors = tester.widgetList<Transform>(
    find.ancestor(of: find.text('row'), matching: find.byType(Transform)),
  );
  double dx = 0;
  for (final Transform t in ancestors) {
    final double x = t.transform.getTranslation().x.abs();
    if (x > dx) {
      dx = x;
    }
  }
  return dx;
}

double _rowHeight(WidgetTester tester) {
  return tester.getSize(find.byType(SwipeActions)).height;
}

void main() {
  testWidgets('delete slides the row out, then collapses its height', (
    WidgetTester tester,
  ) async {
    var dismissed = 0;
    await _pump(tester, _row(() => dismissed++));
    final double full = _rowHeight(tester);
    expect(full, greaterThan(0));
    await tester.fling(find.text('row'), const Offset(-400, 0), 2000);
    await tester.pump();

    // Phase one, mid-slide: the row is moving but still full height.
    await tester.pump(const Duration(milliseconds: 100));
    expect(_slideX(tester), greaterThan(0));
    expect(_slideX(tester), lessThan(390));
    expect(_rowHeight(tester), closeTo(full, 0.5));
    expect(dismissed, 0);

    // Phase two, mid-collapse: slid fully off, height partly closed.
    await tester.pump(const Duration(milliseconds: 250));
    expect(_slideX(tester), closeTo(390, 0.5));
    expect(_rowHeight(tester), greaterThan(0));
    expect(_rowHeight(tester), lessThan(full));
    expect(dismissed, 0);

    // Settled: height zero and the caller is told to remove the row.
    await tester.pump(const Duration(milliseconds: 200));
    expect(_rowHeight(tester), 0);
    expect(dismissed, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced motion commits the dismiss without a ticker', (
    WidgetTester tester,
  ) async {
    var dismissed = 0;
    await _pump(tester, _row(() => dismissed++), disableAnimations: true);
    await tester.fling(find.text('row'), const Offset(-400, 0), 2000);
    await tester.pump();
    expect(dismissed, 1);
    expect(tester.binding.transientCallbackCount, 0);
  });
}
