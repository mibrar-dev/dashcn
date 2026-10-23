// Motion contract for skeleton: the shimmer loops on a 1.5 s linear sweep,
// and turning the skeleton off cross-fades to the content over 200 ms.
// Reduced motion parks the sweep with no ticker.

import 'package:dashcn/src/components/skeleton/skeleton.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(
  WidgetTester tester,
  bool enabled, {
  bool disableAnimations = false,
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
            child: SizedBox(
              width: 240,
              child: Skeleton(enabled: enabled, child: const Text('Summary')),
            ),
          ),
        ),
      ),
    ),
  );
}

Finder get _shimmerLayer => find.byWidgetPredicate(
  (Widget w) =>
      w is Container &&
      w.decoration is BoxDecoration &&
      (w.decoration! as BoxDecoration).gradient is LinearGradient,
);

/// Horizontal start of the sweep gradient.
double _sweepX(WidgetTester tester) {
  final BoxDecoration decoration =
      tester.widget<Container>(_shimmerLayer.first).decoration!
          as BoxDecoration;
  final LinearGradient gradient = decoration.gradient! as LinearGradient;
  return (gradient.begin as Alignment).x;
}

void main() {
  testWidgets('shimmer sweep moves between frames and loops every 1.5 s', (
    WidgetTester tester,
  ) async {
    await _pump(tester, true);
    final double start = _sweepX(tester);
    await tester.pump(const Duration(milliseconds: 16));
    await tester.pump(const Duration(milliseconds: 16));
    final double twoFrames = _sweepX(tester);
    expect(twoFrames, isNot(closeTo(start, 1e-6)));
    await tester.pump(const Duration(milliseconds: 750));
    expect(_sweepX(tester), isNot(closeTo(start, 0.05)));
    await tester.pump(const Duration(milliseconds: 750));
    // One full loop later the sweep is back where it started.
    expect(_sweepX(tester), closeTo(start, 0.05));
    expect(tester.takeException(), isNull);
  });

  testWidgets('turning the skeleton off cross-fades to the content in 200 ms', (
    WidgetTester tester,
  ) async {
    await _pump(tester, true);
    await _pump(tester, false);
    await tester.pump(const Duration(milliseconds: 100));
    // Mid-fade: the shimmer is still present but partly transparent.
    expect(_shimmerLayer, findsOneWidget);
    final Iterable<Opacity> fading = tester.widgetList<Opacity>(
      find.ancestor(of: _shimmerLayer, matching: find.byType(Opacity)),
    );
    expect(
      fading.any((Opacity o) => o.opacity > 0.2 && o.opacity < 0.8),
      isTrue,
    );
    await tester.pump(const Duration(milliseconds: 200));
    expect(_shimmerLayer, findsNothing);
    expect(find.text('Summary'), findsOneWidget);
  });

  testWidgets('reduced motion parks the sweep with no ticker', (
    WidgetTester tester,
  ) async {
    await _pump(tester, true, disableAnimations: true);
    await tester.pump(const Duration(milliseconds: 100));
    expect(tester.binding.transientCallbackCount, 0);
    expect(_shimmerLayer, findsOneWidget);
    await _pump(tester, false, disableAnimations: true);
    await tester.pump();
    expect(_shimmerLayer, findsNothing);
    expect(find.text('Summary'), findsOneWidget);
  });
}
