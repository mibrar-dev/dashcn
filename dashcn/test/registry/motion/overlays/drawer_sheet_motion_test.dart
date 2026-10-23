// Motion tests for drawer, sheet and action sheet (phone form, which is a
// sheet route). Contract (MOTION.md): the panel slides from its edge over
// 300 ms (decelerate), slides back over 220 ms (accelerate), and always
// animates out on close, including a close through the completer. Reduced
// motion: no slide, a short opacity fade only.

import 'package:dashcn/src/components/action_sheet/action_sheet_show.dart';
import 'package:dashcn/src/components/drawer/drawer.dart';
import 'package:dashcn/src/primitives/drawer_route/drawer_shell.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'overlay_motion_harness.dart';

/// Panel offset along the slide axis of the presented drawer (zero when
/// reduced motion removes the transform). Matrix4 storage holds the
/// translation at indices 12 (x) and 13 (y).
double _offset(WidgetTester tester, {required bool horizontal}) {
  final Finder transform = find.descendant(
    of: find.byType(DrawerRouteShell).first,
    matching: find.byType(Transform),
  );
  if (transform.evaluate().isEmpty) return 0;
  final List<double> storage = tester
      .widget<Transform>(transform.first)
      .transform
      .storage;
  return horizontal ? storage[12] : storage[13];
}

Widget _trigger(void Function(BuildContext) onOpen) => Builder(
  builder: (BuildContext context) =>
      GestureDetector(onTap: () => onOpen(context), child: const Text('Open')),
);

Widget _panelBody() => Builder(
  builder: (BuildContext context) => SizedBox(
    width: 200,
    height: 400,
    child: Column(
      children: <Widget>[
        const Text('Panel body'),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    ),
  ),
);

void main() {
  group('drawer', () {
    testWidgets('open slides in from the edge and settles at 0', (
      WidgetTester tester,
    ) async {
      await pumpOverlayPage(
        tester,
        page: (BuildContext context) => _trigger(
          (BuildContext c) =>
              openDrawer<void>(context: c, builder: (_) => _panelBody()),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pump();
      final List<double> offsets = await sampleFrames(
        tester,
        () => _offset(tester, horizontal: true).abs(),
        frames: 14,
      );
      expect(offsets.first, greaterThan(100), reason: 'starts off the edge');
      expect(offsets.last, lessThan(0.5), reason: 'settles on the edge');
      expect(isNonIncreasing(offsets), isTrue);
      expect(distinctCount(offsets), greaterThan(4));
    });

    testWidgets('close slides back out and then removes the route', (
      WidgetTester tester,
    ) async {
      await pumpOverlayPage(
        tester,
        page: (BuildContext context) => _trigger(
          (BuildContext c) =>
              openDrawer<void>(context: c, builder: (_) => _panelBody()),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(_offset(tester, horizontal: true).abs(), lessThan(0.5));

      await tester.tap(find.text('Close'));
      await tester.pump();
      // Sample the 220 ms exit only: the route is removed after it.
      final List<double> offsets = await sampleFrames(
        tester,
        () => _offset(tester, horizontal: true).abs(),
        frames: 8,
      );
      expect(isNonDecreasing(offsets), isTrue, reason: 'slides back out');
      expect(offsets.last, greaterThan(100), reason: 'ends off the edge');
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Panel body'), findsNothing);
    });

    testWidgets('closing through the completer still animates out', (
      WidgetTester tester,
    ) async {
      late DrawerOverlayCompleter<void> handle;
      await pumpOverlayPage(
        tester,
        page: (BuildContext context) => _trigger((BuildContext c) {
          handle = openDrawerOverlay<void>(
            context: c,
            builder: (_) => _panelBody(),
          );
        }),
      );
      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      handle.remove();
      await tester.pump();
      final List<double> offsets = await sampleFrames(
        tester,
        () => _offset(tester, horizontal: true).abs(),
        frames: 8,
      );
      expect(
        distinctCount(offsets),
        greaterThan(3),
        reason: 'the completer close animates, not an instant removal',
      );
      expect(isNonDecreasing(offsets), isTrue);
    });

    testWidgets('reduced motion: no slide, fade only', (
      WidgetTester tester,
    ) async {
      await pumpOverlayPage(
        tester,
        disabled: true,
        page: (BuildContext context) => _trigger(
          (BuildContext c) =>
              openDrawer<void>(context: c, builder: (_) => _panelBody()),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pump();
      final List<double> offsets = await sampleFrames(
        tester,
        () => _offset(tester, horizontal: true),
        frames: 4,
      );
      expect(offsets.every((double v) => v.abs() < 1e-6), isTrue);
      await tester.pump(const Duration(milliseconds: 150));
      expect(find.text('Panel body'), findsOneWidget);
    });
  });

  group('sheet', () {
    testWidgets('open slides up from the bottom edge and settles', (
      WidgetTester tester,
    ) async {
      await pumpOverlayPage(
        tester,
        page: (BuildContext context) => _trigger(
          (BuildContext c) =>
              openSheet<void>(context: c, builder: (_) => _panelBody()),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pump();
      final List<double> offsets = await sampleFrames(
        tester,
        () => _offset(tester, horizontal: false).abs(),
        frames: 14,
      );
      expect(offsets.first, greaterThan(50), reason: 'starts below the edge');
      expect(offsets.last, lessThan(0.5), reason: 'settles on the edge');
      expect(isNonIncreasing(offsets), isTrue);
    });

    testWidgets('close slides back down and always animates', (
      WidgetTester tester,
    ) async {
      await pumpOverlayPage(
        tester,
        page: (BuildContext context) => _trigger(
          (BuildContext c) =>
              openSheet<void>(context: c, builder: (_) => _panelBody()),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.tap(find.text('Close'));
      await tester.pump();
      final List<double> offsets = await sampleFrames(
        tester,
        () => _offset(tester, horizontal: false).abs(),
        frames: 8,
      );
      expect(isNonDecreasing(offsets), isTrue);
      expect(offsets.last, greaterThan(50));
    });
  });

  group('action sheet', () {
    testWidgets('phone form slides up from the bottom edge', (
      WidgetTester tester,
    ) async {
      await pumpOverlayPage(
        tester,
        size: const Size(400, 800),
        page: (BuildContext context) => _trigger(
          (BuildContext c) => showActionSheet<void>(
            context: c,
            title: 'Actions',
            actions: <ActionSheetAction<void>>[
              ActionSheetAction<void>(label: 'Share', onPressed: () {}),
            ],
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pump();
      final List<double> offsets = await sampleFrames(
        tester,
        () => _offset(tester, horizontal: false).abs(),
        frames: 14,
      );
      expect(offsets.first, greaterThan(50));
      expect(offsets.last, lessThan(0.5));
      expect(isNonIncreasing(offsets), isTrue);
    });

    testWidgets('reduced motion: no slide', (WidgetTester tester) async {
      await pumpOverlayPage(
        tester,
        size: const Size(400, 800),
        disabled: true,
        page: (BuildContext context) => _trigger(
          (BuildContext c) => showActionSheet<void>(
            context: c,
            title: 'Actions',
            actions: <ActionSheetAction<void>>[
              ActionSheetAction<void>(label: 'Share', onPressed: () {}),
            ],
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pump();
      final List<double> offsets = await sampleFrames(
        tester,
        () => _offset(tester, horizontal: false),
        frames: 4,
      );
      expect(offsets.every((double v) => v.abs() < 1e-6), isTrue);
    });
  });
}
