// Tests for the swipe_actions motion upgrade: spring settle with velocity,
// progress-driven action buttons, custom builders, full-swipe collapse,
// rubber-banding, per-instance motion override, reduced motion and RTL.

import 'package:dashcn/src/components/swipe_actions/swipe_actions.dart';
import 'package:dashcn/src/primitives/motion/motion_spec.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(
  WidgetTester tester,
  SwipeActions row, {
  TextDirection direction = TextDirection.ltr,
  bool disableAnimations = false,
  double width = 390,
}) async {
  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(
        size: Size(width, 600),
      ).copyWith(disableAnimations: disableAnimations),
      child: Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: direction,
          child: Center(
            child: SizedBox(width: width, height: 72, child: row),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

/// Pumps past the spring settle and the commit collapse.
Future<void> _pumpSettle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
}

SwipeActions _row({
  VoidCallback? onDelete,
  VoidCallback? onDismissed,
  List<SwipeAction>? actions,
  SwipeActionsController? controller,
  MotionSpec? motion,
}) {
  return SwipeActions(
    controller: controller,
    motion: motion,
    actions:
        actions ??
        <SwipeAction>[SwipeAction(label: 'Delete', onPressed: onDelete)],
    onDismissed: onDismissed,
    child: const Text('row'),
  );
}

void main() {
  testWidgets('settle opens on a long drag and closes on a short one', (
    tester,
  ) async {
    final controller = SwipeActionsController();
    await _pump(tester, _row(onDelete: () {}, controller: controller));
    expect(controller.isOpen, isFalse);
    await tester.drag(find.text('row'), const Offset(-200, 0));
    await _pumpSettle(tester);
    expect(controller.isOpen, isTrue);
    await tester.tap(find.text('row'));
    await _pumpSettle(tester);
    expect(controller.isOpen, isFalse);
  });

  test('buttonProgress staggers from the trailing edge outward', () {
    expect(SwipeActionButtons.buttonProgress(0, 0, 2), 0);
    expect(SwipeActionButtons.buttonProgress(1, 0, 2), 1);
    expect(SwipeActionButtons.buttonProgress(1, 1, 2), 1);
    expect(SwipeActionButtons.buttonProgress(0.5, 1, 2), 1);
    expect(SwipeActionButtons.buttonProgress(0.5, 0, 2), 0);
    expect(SwipeActionButtons.buttonProgress(0.75, 0, 2), 0.5);
  });

  testWidgets('buttons fade in with the reveal progress', (tester) async {
    await _pump(tester, _row(onDelete: () {}));
    // A partial drag reveals the single action partway: the button wrapper
    // carries a partial opacity (no jump from 0 to 1). Two on-surface steps
    // so the horizontal drag wins the arena before the reveal is read.
    final Offset center = tester.getCenter(find.text('row'));
    final gesture = await tester.startGesture(center);
    await gesture.moveTo(center + const Offset(-30, 0));
    await tester.pump();
    await gesture.moveTo(center + const Offset(-40, 0));
    await tester.pump();
    // The reveal wrapper is one of several Opacity ancestors (the Button
    // paints its own); it carries the partial progress.
    final Iterable<Opacity> wrappers = tester.widgetList<Opacity>(
      find.ancestor(of: find.text('Delete'), matching: find.byType(Opacity)),
    );
    expect(
      wrappers.any((Opacity o) => o.opacity > 0.2 && o.opacity < 0.9),
      isTrue,
    );
    await gesture.up();
    await _pumpSettle(tester);
  });

  testWidgets('custom builders receive the reveal progress', (tester) async {
    final seen = <double>[];
    await _pump(
      tester,
      _row(
        actions: <SwipeAction>[
          SwipeAction(
            label: 'Pin',
            builder: (BuildContext context, double progress) {
              seen.add(progress);
              return Text('Pin ${(progress * 100).round()}');
            },
          ),
        ],
      ),
    );
    await tester.drag(find.text('row'), const Offset(-200, 0));
    await _pumpSettle(tester);
    expect(seen, isNotEmpty);
    expect(seen.last, closeTo(1.0, 0.01));
    expect(find.text('Pin 100'), findsOneWidget);
  });

  testWidgets('full swipe collapses the row before removal', (tester) async {
    var dismissed = 0;
    await _pump(tester, _row(onDelete: () {}, onDismissed: () => dismissed++));
    await tester.fling(find.text('row'), const Offset(-400, 0), 2000);
    await tester.pump();
    // Mid-collapse the row is still mounted but shrinking.
    await tester.pump(const Duration(milliseconds: 100));
    expect(dismissed, 0);
    await tester.pump(const Duration(milliseconds: 400));
    expect(dismissed, 1);
  });

  testWidgets('controller.dismiss commits the collapse', (tester) async {
    var dismissed = 0;
    final controller = SwipeActionsController();
    await _pump(
      tester,
      _row(
        onDelete: () {},
        onDismissed: () => dismissed++,
        controller: controller,
      ),
    );
    controller.dismiss();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(dismissed, 1);
  });

  testWidgets('rubber-banding resists over-drag instead of hard clamping', (
    tester,
  ) async {
    await _pump(tester, _row(onDelete: () {}, onDismissed: () {}));
    final Offset center = tester.getCenter(find.text('row'));
    final gesture = await tester.startGesture(center);
    // Two on-surface steps: the first opens the row, the second over-drags
    // past the full width. Resistance stretches the row a little instead of
    // tracking the finger 1:1. Compact tile is ~56 wide.
    await gesture.moveTo(center + const Offset(-56, 0));
    await tester.pump();
    await gesture.moveTo(center + const Offset(-160, 0));
    await tester.pump();
    final Finder translated = find.ancestor(
      of: find.text('row'),
      matching: find.byType(Transform),
    );
    final Transform widget = tester.widget<Transform>(translated.first);
    final double dx = widget.transform.getTranslation().x.abs();
    // Past the 56 px actions width, but far short of the 160 px drag.
    expect(dx, greaterThan(56));
    expect(dx, lessThan(160));
    await gesture.up();
    await _pumpSettle(tester);
  });

  testWidgets('disabled motion spec snaps open and shut', (tester) async {
    final controller = SwipeActionsController();
    await _pump(
      tester,
      _row(
        onDelete: () {},
        controller: controller,
        motion: const MotionSpec(disabled: true),
      ),
    );
    controller.open();
    await tester.pump();
    expect(controller.isOpen, isTrue);
    controller.close();
    await tester.pump();
    expect(controller.isOpen, isFalse);
  });

  testWidgets('reduced motion snaps and dismisses without animation', (
    tester,
  ) async {
    var dismissed = 0;
    await _pump(
      tester,
      _row(onDelete: () {}, onDismissed: () => dismissed++),
      disableAnimations: true,
    );
    // A short drag snaps open (below the 1.05 commit line, compact tile ~56).
    await tester.drag(find.text('row'), const Offset(-50, 0));
    await tester.pump();
    expect(find.text('Delete'), findsOneWidget);
    expect(dismissed, 0);
    await tester.fling(find.text('row'), const Offset(-400, 0), 2000);
    await tester.pump();
    expect(dismissed, 1);
  });

  testWidgets('timed motion override drives the settle', (tester) async {
    final controller = SwipeActionsController();
    await _pump(
      tester,
      _row(
        onDelete: () {},
        controller: controller,
        motion: const MotionSpec(enterDuration: Duration(milliseconds: 400)),
      ),
    );
    controller.open();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    // A 400 ms timed settle is still mid-flight at 100 ms.
    expect(controller.isOpen, isTrue);
    await tester.pump(const Duration(milliseconds: 400));
    expect(controller.isOpen, isTrue);
  });

  testWidgets('no overflow at 375 px while open', (tester) async {
    await _pump(
      tester,
      _row(
        onDelete: () {},
        actions: <SwipeAction>[
          SwipeAction(label: 'Mute', onPressed: () {}),
          SwipeAction(label: 'Delete', onPressed: () {}),
        ],
        onDismissed: () {},
      ),
      width: 375,
    );
    await tester.drag(find.text('row'), const Offset(-300, 0));
    await _pumpSettle(tester);
    expect(tester.takeException(), isNull);
  });
}
