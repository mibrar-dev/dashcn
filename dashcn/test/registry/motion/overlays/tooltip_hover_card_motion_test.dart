// Motion tests for tooltip and hover card. Both open on hover, so each test
// drives a mouse pointer. Tooltip contract (MOTION.md): fade plus 4 px from
// the anchor side over 100 ms, fade-only exit over 80 ms, no scale. Hover
// card is a popover: scale 0.95 to 1 on enter, fade-only exit.

import 'package:dashcn/src/components/hover_card/hover_card.dart';
import 'package:dashcn/src/components/tooltip/tooltip.dart';
import 'package:dashcn/src/primitives/popover_layout.dart';
import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'overlay_motion_harness.dart';

/// Scale of the presented popover.
double _scale(WidgetTester tester) =>
    tester.widget<PopoverLayout>(find.byType(PopoverLayout).first).scale;

/// Opacity of the presented popover content (its outermost FadeTransition).
double _opacity(WidgetTester tester) {
  final Finder fade = find.descendant(
    of: find.byType(PopoverLayout).first,
    matching: find.byType(FadeTransition),
  );
  return tester.widget<FadeTransition>(fade.first).opacity.value;
}

/// Vertical translation of the presented tooltip (the enter slide).
double _slideY(WidgetTester tester) {
  final Finder transform = find.descendant(
    of: find.byType(PopoverLayout).first,
    matching: find.byType(Transform),
  );
  // Reduced motion builds no slide transform at all: the slide is zero.
  if (transform.evaluate().isEmpty) return 0;
  return tester.widget<Transform>(transform.first).transform.getTranslation().y;
}

/// Moves a mouse pointer onto [finder] and returns the gesture.
Future<TestGesture> _hover(WidgetTester tester, Finder finder) async {
  final TestGesture gesture = await tester.createGesture(
    kind: PointerDeviceKind.mouse,
  );
  await gesture.addPointer(location: Offset.zero);
  await gesture.moveTo(tester.getCenter(finder));
  await tester.pump();
  return gesture;
}

/// Anchor used by both widgets: a hit-testable box with a label.
Widget _anchor() => const SizedBox(
  width: 120,
  height: 36,
  child: Center(child: Text('Anchor')),
);

void main() {
  group('tooltip', () {
    testWidgets('enter fades in and slides 4 px, without scaling', (
      WidgetTester tester,
    ) async {
      await pumpOverlayPage(
        tester,
        page: (BuildContext context) => Tooltip(
          tooltip: (BuildContext c) => const Text('Tip body'),
          child: _anchor(),
        ),
      );
      final TestGesture pointer = await _hover(tester, find.text('Anchor'));
      // Wait out the 500 ms show delay, then sample the 100 ms enter.
      await tester.pump(const Duration(milliseconds: 520));
      expect(find.byType(PopoverLayout), findsOneWidget);
      final List<double> opacity = await sampleFrames(
        tester,
        () => _opacity(tester),
        frames: 6,
      );
      expect(opacity.first, lessThan(0.5), reason: 'starts faded out');
      expect(isNonDecreasing(opacity), isTrue);
      expect(opacity.last, closeTo(1.0, 1e-6), reason: 'settles fully shown');

      expect(
        _scale(tester),
        closeTo(1.0, 1e-6),
        reason: 'tooltip never scales',
      );
      await pointer.removePointer();
    });

    testWidgets('slide starts 4 px from the anchor and settles at 0', (
      WidgetTester tester,
    ) async {
      await pumpOverlayPage(
        tester,
        page: (BuildContext context) => Tooltip(
          tooltip: (BuildContext c) => const Text('Tip body'),
          child: _anchor(),
        ),
      );
      final TestGesture pointer = await _hover(tester, find.text('Anchor'));
      await tester.pump(const Duration(milliseconds: 520));
      final List<double> slide = await sampleFrames(
        tester,
        () => _slideY(tester),
        frames: 6,
      );
      expect(slide.first.abs(), closeTo(4.0, 0.5), reason: 'starts 4 px out');
      expect(slide.last.abs(), lessThan(0.01), reason: 'settles at 0');
      expect(distinctCount(slide), greaterThan(2), reason: 'slides over time');
      await pointer.removePointer();
    });

    testWidgets('reduced motion: fade only, no slide, no scale', (
      WidgetTester tester,
    ) async {
      await pumpOverlayPage(
        tester,
        disabled: true,
        page: (BuildContext context) => Tooltip(
          tooltip: (BuildContext c) => const Text('Tip body'),
          child: _anchor(),
        ),
      );
      final TestGesture pointer = await _hover(tester, find.text('Anchor'));
      await tester.pump(const Duration(milliseconds: 520));
      final List<double> slide = await sampleFrames(
        tester,
        () => _slideY(tester),
        frames: 4,
      );
      expect(slide.every((double y) => y.abs() < 1e-6), isTrue);
      expect(_scale(tester), closeTo(1.0, 1e-6));
      await tester.pump(const Duration(milliseconds: 150));
      expect(_opacity(tester), closeTo(1.0, 1e-6));
      await pointer.removePointer();
    });
  });

  group('hover card', () {
    Widget card() => HoverCard(
      wait: Duration.zero,
      debounce: Duration.zero,
      hoverBuilder: (BuildContext context) =>
          const SizedBox(width: 160, height: 60, child: Text('preview-body')),
      child: _anchor(),
    );

    testWidgets('enter scales 0.95 to 1 and fades in, exit fades only', (
      WidgetTester tester,
    ) async {
      await pumpOverlayPage(tester, page: (BuildContext context) => card());
      final TestGesture pointer = await _hover(tester, find.text('Anchor'));
      // The hover timer runs before the card opens; the enter starts there.
      await tester.pump(const Duration(milliseconds: 520));
      final List<double> scales = await sampleFrames(
        tester,
        () => _scale(tester),
        frames: 8,
      );
      expect(scales.first, closeTo(0.95, 0.01));
      expect(scales.last, closeTo(1.0, 1e-6));
      expect(distinctCount(scales), greaterThan(2));
      expect(isNonDecreasing(scales), isTrue);

      await pointer.moveTo(const Offset(790, 590));
      await tester.pump();
      final List<double> fades = await sampleFrames(
        tester,
        () => _opacity(tester),
        frames: 4,
      );
      expect(isNonIncreasing(fades), isTrue, reason: 'fades out');
      expect(_scale(tester), closeTo(1.0, 1e-6), reason: 'exit holds scale');
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(PopoverLayout), findsNothing);
    });

    testWidgets('reduced motion: no scale, fade only', (
      WidgetTester tester,
    ) async {
      await pumpOverlayPage(
        tester,
        disabled: true,
        page: (BuildContext context) => card(),
      );
      final TestGesture pointer = await _hover(tester, find.text('Anchor'));
      await tester.pump(const Duration(milliseconds: 520));
      final List<double> scales = await sampleFrames(
        tester,
        () => _scale(tester),
        frames: 4,
      );
      expect(scales.every((double s) => (s - 1.0).abs() < 1e-6), isTrue);
      await pointer.removePointer();
    });
  });
}
