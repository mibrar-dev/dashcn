// Motion contract for navigation_bar: the active indicator is one pill that
// glides to the newly selected item over the 200 ms base token. Reduced
// motion jumps to the item with no ticker.

import 'package:dashcn/src/components/navigation_bar/navigation_bar.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/primitives/motion/sliding_indicator.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(WidgetTester tester, int index, {bool reduced = false}) {
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
            child: SizedBox(
              width: 360,
              child: NavigationBar(
                index: index,
                onSelected: (_) {},
                children: <NavigationBarItem>[
                  for (final String label in <String>['One', 'Two', 'Three'])
                    NavigationItem(
                      label: Text(label),
                      child: const Icon(LucideIcons.house),
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

/// Left edge of the pill as drawn (the animated position), relative to the
/// indicator track.
double _pillLeft(WidgetTester tester) {
  final double track = tester.getTopLeft(find.byType(SlidingIndicator)).dx;
  final Finder pill = find.descendant(
    of: find.byType(AnimatedPositioned),
    matching: find.byType(DecoratedBox),
  );
  return tester.getTopLeft(pill).dx - track;
}

/// Left edge of item [i] relative to the indicator track.
double _itemLeft(WidgetTester tester, int i) {
  final double track = tester.getTopLeft(find.byType(SlidingIndicator)).dx;
  return tester.getTopLeft(find.byType(NavigationItem).at(i)).dx - track;
}

void main() {
  testWidgets('active pill glides to the next item over 200 ms', (
    WidgetTester tester,
  ) async {
    await _pump(tester, 0);
    await tester.pump();
    await tester.pump();
    final double start = _pillLeft(tester);
    expect(start, closeTo(_itemLeft(tester, 0), 0.5));

    await _pump(tester, 2);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    final double mid = _pillLeft(tester);
    expect(mid, greaterThan(start + 1));
    expect(mid, lessThan(_itemLeft(tester, 2) - 1));

    await tester.pump(const Duration(milliseconds: 300));
    expect(_pillLeft(tester), closeTo(_itemLeft(tester, 2), 0.5));
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced motion jumps to the selected item with no ticker', (
    WidgetTester tester,
  ) async {
    await _pump(tester, 0, reduced: true);
    await tester.pump();
    await _pump(tester, 1, reduced: true);
    await tester.pump();
    await tester.pump();
    expect(_pillLeft(tester), closeTo(_itemLeft(tester, 1), 0.5));
    expect(
      tester
          .widget<AnimatedPositioned>(find.byType(AnimatedPositioned))
          .duration,
      Duration.zero,
    );
  });
}
