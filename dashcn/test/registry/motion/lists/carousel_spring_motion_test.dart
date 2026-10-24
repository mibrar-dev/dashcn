// Motion contract for carousel: a drag release snaps to the nearest page on a
// critically damped spring fed by the fling velocity. The position moves over
// frames, never overshoots the target page, and settles on it. Reduced
// motion jumps straight to the page.

import 'package:dashcn/src/components/carousel/carousel.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<CarouselController> _pump(
  WidgetTester tester, {
  bool reduced = false,
}) async {
  final CarouselController controller = CarouselController();
  await tester.pumpWidget(
    MediaQuery(
      data: const MediaQueryData(
        size: Size(480, 300),
      ).copyWith(disableAnimations: reduced),
      child: Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 320,
            height: 200,
            child: Carousel(
              controller: controller,
              itemCount: 3,
              itemExtent: 300,
              itemBuilder: (BuildContext context, int index) => ColoredBox(
                color: const Color(0xFF336699),
                child: Text('$index'),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  return controller;
}

void main() {
  testWidgets('fling snaps to the next page on a spring, no overshoot', (
    WidgetTester tester,
  ) async {
    final CarouselController controller = await _pump(tester);
    await tester.pump();
    await tester.fling(find.byType(Carousel), const Offset(-200, 0), 1500);
    await tester.pump();
    final List<double> values = <double>[];
    for (int i = 0; i < 40; i++) {
      await tester.pump(const Duration(milliseconds: 16));
      values.add(controller.value);
    }
    // Moves across frames rather than jumping in one step.
    expect(values.first, greaterThan(0));
    expect(values.first, lessThan(1));
    // Critically damped: never past the target page.
    expect(values.every((double v) => v <= 1.0 + 1e-6), isTrue);
    expect(values.last, closeTo(1.0, 0.01));
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced motion jumps to the page with no ticker', (
    WidgetTester tester,
  ) async {
    final CarouselController controller = await _pump(tester, reduced: true);
    await tester.pump();
    await tester.fling(find.byType(Carousel), const Offset(-200, 0), 1500);
    await tester.pump();
    expect(controller.value, closeTo(1.0, 0.01));
    expect(tester.binding.transientCallbackCount, 0);
  });
}
