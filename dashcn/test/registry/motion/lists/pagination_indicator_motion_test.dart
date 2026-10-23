// Motion contract for pagination: the current page's underline glides to the
// newly selected page over the 200 ms base token. Reduced motion jumps.

import 'package:dashcn/src/components/pagination/pagination.dart';
import 'package:dashcn/src/primitives/motion/sliding_indicator.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(WidgetTester tester, int page, {bool reduced = false}) {
  return tester.pumpWidget(
    MediaQuery(
      data: const MediaQueryData(
        size: Size(480, 200),
      ).copyWith(disableAnimations: reduced),
      child: Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: Pagination(
              page: page,
              totalPages: 5,
              onPageChanged: (_) {},
              showSkipToFirstPage: false,
              showSkipToLastPage: false,
            ),
          ),
        ),
      ),
    ),
  );
}

/// Left edge of the underline as drawn, relative to the indicator track.
double _underlineLeft(WidgetTester tester) {
  final double track = tester.getTopLeft(find.byType(SlidingIndicator)).dx;
  final Finder bar = find.descendant(
    of: find.byType(AnimatedPositioned),
    matching: find.byType(DecoratedBox),
  );
  return tester.getTopLeft(bar).dx - track;
}

/// Left edge of the button for [page], relative to the indicator track.
double _pageLeft(WidgetTester tester, int page) {
  final double track = tester.getTopLeft(find.byType(SlidingIndicator)).dx;
  final Finder button = find.ancestor(
    of: find.text('$page'),
    matching: find.byType(KeyedSubtree),
  );
  return tester.getTopLeft(button.first).dx - track;
}

void main() {
  testWidgets('underline glides to the new page over 200 ms', (
    WidgetTester tester,
  ) async {
    await _pump(tester, 1);
    await tester.pump();
    await tester.pump();
    final double start = _underlineLeft(tester);
    expect(start, closeTo(_pageLeft(tester, 1), 0.5));

    await _pump(tester, 4);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    final double mid = _underlineLeft(tester);
    expect(mid, greaterThan(start + 1));
    expect(mid, lessThan(_pageLeft(tester, 4) - 1));

    await tester.pump(const Duration(milliseconds: 300));
    expect(_underlineLeft(tester), closeTo(_pageLeft(tester, 4), 0.5));
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced motion jumps the underline to the page', (
    WidgetTester tester,
  ) async {
    await _pump(tester, 1, reduced: true);
    await tester.pump();
    await _pump(tester, 3, reduced: true);
    await tester.pump();
    await tester.pump();
    expect(_underlineLeft(tester), closeTo(_pageLeft(tester, 3), 0.5));
    expect(
      tester
          .widget<AnimatedPositioned>(find.byType(AnimatedPositioned))
          .duration,
      Duration.zero,
    );
  });
}
