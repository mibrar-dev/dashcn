// Motion tests for dialog and alert dialog (both are dialog routes).
// Contract (MOTION.md): the panel fades and scales 0.96 to 1 over 200 ms
// (decelerate); the scrim fades in over 150 ms; the exit fades and scales
// back over 150 ms (accelerate). Reduced motion: a short opacity fade only,
// with no ScaleTransition.

import 'package:dashcn/src/components/alert_dialog/alert_dialog.dart';
import 'package:dashcn/src/components/dialog/dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'overlay_motion_harness.dart';

/// Scale of the presented dialog panel.
double _panelScale(WidgetTester tester) => tester
    .widget<ScaleTransition>(find.byType(ScaleTransition).first)
    .scale
    .value;

/// Opacity of the presented dialog panel (outermost FadeTransition).
double _panelOpacity(WidgetTester tester) {
  final Finder fade = find.descendant(
    of: find.byType(ScaleTransition).first,
    matching: find.byType(FadeTransition),
  );
  return tester.widget<FadeTransition>(fade.first).opacity.value;
}

/// Alpha of the modal scrim.
double _scrimAlpha(WidgetTester tester) {
  final Color? color = tester
      .widget<AnimatedModalBarrier>(find.byType(AnimatedModalBarrier).first)
      .color
      .value;
  return color?.a ?? 0;
}

/// Opacity of the panel under reduced motion (no ScaleTransition present).
double _fadeOpacity(WidgetTester tester) => tester
    .widget<FadeTransition>(find.byType(FadeTransition).last)
    .opacity
    .value;

Widget _trigger(void Function(BuildContext) onOpen) => Builder(
  builder: (BuildContext context) =>
      GestureDetector(onTap: () => onOpen(context), child: const Text('Open')),
);

/// Body with a Close control that pops the route.
Widget _body() => Builder(
  builder: (BuildContext context) => SizedBox(
    width: 240,
    height: 120,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text('Dialog body'),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    ),
  ),
);

void main() {
  group('dialog', () {
    testWidgets('open scales 0.96 to 1 and fades in; scrim fades in', (
      WidgetTester tester,
    ) async {
      await pumpOverlayPage(
        tester,
        page: (BuildContext context) => _trigger(
          (BuildContext c) =>
              showDialog<void>(context: c, builder: (_) => _body()),
        ),
      );
      await tester.tap(find.text('Open'));
      // The route is built on the frame after the tap; it starts there.
      await tester.pump();
      final List<double> scales = <double>[];
      final List<double> scrim = <double>[];
      for (int i = 0; i <= 10; i++) {
        scales.add(_panelScale(tester));
        scrim.add(_scrimAlpha(tester));
        await tester.pump(const Duration(milliseconds: 20));
      }
      expect(scales.first, closeTo(0.96, 0.01), reason: 'starts at 0.96');
      expect(scales.last, closeTo(1.0, 1e-6), reason: 'settles at 1');
      expect(isNonDecreasing(scales), isTrue);
      expect(distinctCount(scales), greaterThan(3));
      expect(scrim.first, closeTo(0.0, 0.02), reason: 'scrim starts clear');
      expect(isNonDecreasing(scrim), isTrue);
      expect(scrim.last, closeTo(0.5, 0.02), reason: 'scrim settles at 50 %');
    });

    testWidgets('close fades and scales back out before it is removed', (
      WidgetTester tester,
    ) async {
      await pumpOverlayPage(
        tester,
        page: (BuildContext context) => _trigger(
          (BuildContext c) =>
              showDialog<void>(context: c, builder: (_) => _body()),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(_panelOpacity(tester), closeTo(1.0, 1e-6));

      await tester.tap(find.text('Close'));
      await tester.pump();
      final List<double> opacity = await sampleFrames(
        tester,
        () => _panelOpacity(tester),
        frames: 4,
      );
      expect(isNonIncreasing(opacity), isTrue, reason: 'fades out');
      expect(opacity.last, lessThan(opacity.first));
      await tester.pump(const Duration(milliseconds: 250));
      expect(find.text('Dialog body'), findsNothing, reason: 'removed at end');
    });

    testWidgets('reduced motion: fade only, no ScaleTransition', (
      WidgetTester tester,
    ) async {
      await pumpOverlayPage(
        tester,
        disabled: true,
        page: (BuildContext context) => _trigger(
          (BuildContext c) =>
              showDialog<void>(context: c, builder: (_) => _body()),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pump();
      expect(find.byType(ScaleTransition), findsNothing);
      final List<double> opacity = await sampleFrames(
        tester,
        () => _fadeOpacity(tester),
        frames: 6,
      );
      expect(isNonDecreasing(opacity), isTrue);
      expect(opacity.last, closeTo(1.0, 1e-6));
    });
  });

  group('alert dialog', () {
    Widget alertTrigger() => _trigger(
      (BuildContext c) => showAlertDialog<void>(
        context: c,
        title: const Text('Delete file?'),
        actionsBuilder: (BuildContext dialogContext) => <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(dialogContext).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );

    testWidgets('open scales 0.96 to 1 and fades in; scrim fades in', (
      WidgetTester tester,
    ) async {
      await pumpOverlayPage(
        tester,
        page: (BuildContext context) => alertTrigger(),
      );
      await tester.tap(find.text('Open'));
      await tester.pump();
      final List<double> scales = <double>[];
      final List<double> scrim = <double>[];
      for (int i = 0; i <= 10; i++) {
        scales.add(_panelScale(tester));
        scrim.add(_scrimAlpha(tester));
        await tester.pump(const Duration(milliseconds: 20));
      }
      expect(scales.first, closeTo(0.96, 0.01));
      expect(scales.last, closeTo(1.0, 1e-6));
      expect(isNonDecreasing(scales), isTrue);
      expect(scrim.last, closeTo(0.5, 0.02));
    });

    testWidgets('reduced motion: fade only, no ScaleTransition', (
      WidgetTester tester,
    ) async {
      await pumpOverlayPage(
        tester,
        disabled: true,
        page: (BuildContext context) => alertTrigger(),
      );
      await tester.tap(find.text('Open'));
      await tester.pump();
      expect(find.byType(ScaleTransition), findsNothing);
      await tester.pump(const Duration(milliseconds: 150));
      expect(_fadeOpacity(tester), closeTo(1.0, 1e-6));
    });
  });
}
