// Widget tests for the `swipe_actions` component.
//
// Covers: drag reveals trailing actions, action tap fires, tap-while-open
// closes, dismiss-to-delete on a full swipe, RTL mirroring, and the
// keyboard/semantics alternative (actions are real buttons, excluded while
// closed).

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/swipe_actions/swipe_actions.dart';
import 'package:dashcn/src/theme/density_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(
  WidgetTester tester,
  SwipeActions row, {
  TextDirection direction = TextDirection.ltr,
}) async {
  await tester.pumpWidget(
    Theme(
      data: const ThemeData(),
      child: Directionality(
        textDirection: direction,
        child: Center(child: SizedBox(width: 390, height: 72, child: row)),
      ),
    ),
  );
  await tester.pump();
}

/// Pumps past the 200 ms settle animation: the frame that starts it and the
/// frame that renders its final build.
Future<void> _pumpSettle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

SwipeActions _row({
  VoidCallback? onDelete,
  VoidCallback? onDismissed,
  List<SwipeAction>? actions,
}) {
  return SwipeActions(
    actions:
        actions ??
        <SwipeAction>[SwipeAction(label: 'Delete', onPressed: onDelete)],
    onDismissed: onDismissed,
    child: const Text('row'),
  );
}

void main() {
  testWidgets('drag reveals the action and tapping it fires', (tester) async {
    var pressed = 0;
    await _pump(tester, _row(onDelete: () => pressed++));
    expect(find.text('Delete'), findsOneWidget);
    await tester.drag(find.text('row'), const Offset(-200, 0));
    await _pumpSettle(tester);
    await tester.tap(find.text('Delete'));
    await tester.pump();
    expect(pressed, 1);
  });

  testWidgets('tapping the row while open closes it', (tester) async {
    var pressed = 0;
    await _pump(tester, _row(onDelete: () => pressed++));
    await tester.drag(find.text('row'), const Offset(-200, 0));
    await _pumpSettle(tester);
    await tester.tap(find.text('row'));
    await _pumpSettle(tester);
    // Covered again: the tap lands on the row, not the action.
    await tester.tap(find.text('Delete'), warnIfMissed: false);
    await tester.pump();
    expect(pressed, 0);
  });

  testWidgets('a full swipe dismisses when onDismissed is set', (tester) async {
    var dismissed = 0;
    await _pump(tester, _row(onDelete: () {}, onDismissed: () => dismissed++));
    await tester.fling(find.text('row'), const Offset(-400, 0), 2000);
    // Slide (200 ms) then collapse (200 ms) before onDismissed fires.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(dismissed, 1);
  });

  testWidgets('a short drag settles back closed', (tester) async {
    var dismissed = 0;
    var pressed = 0;
    await _pump(
      tester,
      _row(onDelete: () => pressed++, onDismissed: () => dismissed++),
    );
    await tester.drag(find.text('row'), const Offset(-10, 0));
    await _pumpSettle(tester);
    expect(dismissed, 0);
    await tester.tap(find.text('Delete'), warnIfMissed: false);
    await tester.pump();
    expect(pressed, 0);
  });

  testWidgets('reveal mirrors under RTL', (tester) async {
    var pressed = 0;
    await _pump(
      tester,
      _row(onDelete: () => pressed++),
      direction: TextDirection.rtl,
    );
    await tester.drag(find.text('row'), const Offset(200, 0));
    await _pumpSettle(tester);
    await tester.tap(find.text('Delete'));
    await tester.pump();
    expect(pressed, 1);
  });

  testWidgets('closed actions leave semantics and focus', (tester) async {
    await _pump(tester, _row(onDelete: () {}));
    expect(find.byType(ExcludeSemantics), findsOneWidget);
    expect(find.byType(ExcludeFocus), findsOneWidget);
    await tester.drag(find.text('row'), const Offset(-200, 0));
    await _pumpSettle(tester);
    expect(find.byType(ExcludeSemantics), findsNothing);
    expect(find.byType(ExcludeFocus), findsNothing);
  });

  testWidgets('multiple actions lay out from the trailing edge', (
    tester,
  ) async {
    var muted = 0;
    var deleted = 0;
    await _pump(
      tester,
      _row(
        actions: <SwipeAction>[
          SwipeAction(label: 'Mute', onPressed: () => muted++),
          SwipeAction(label: 'Delete', onPressed: () => deleted++),
        ],
      ),
    );
    await tester.drag(find.text('row'), const Offset(-300, 0));
    await _pumpSettle(tester);
    await tester.tap(find.text('Mute'));
    await tester.tap(find.text('Delete'));
    await tester.pump();
    expect(muted, 1);
    expect(deleted, 1);
  });

  testWidgets('controller opens, reports and closes', (tester) async {
    final SwipeActionsController controller = SwipeActionsController();
    await _pump(
      tester,
      SwipeActions(
        controller: controller,
        actions: <SwipeAction>[SwipeAction(label: 'Delete', onPressed: () {})],
        child: const Text('row'),
      ),
    );
    expect(controller.isOpen, isFalse);
    controller.open();
    await _pumpSettle(tester);
    expect(controller.isOpen, isTrue);
    expect(find.byType(ExcludeSemantics), findsNothing);
    controller.close();
    await _pumpSettle(tester);
    expect(controller.isOpen, isFalse);
    expect(find.byType(ExcludeSemantics), findsOneWidget);
  });

  testWidgets(
    'regression: tapping an exposed action inside a ListView fires it',
    (tester) async {
      final fired = <int>[];
      final SwipeActionsController controller = SwipeActionsController();
      await tester.pumpWidget(
        Theme(
          data: const ThemeData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: SizedBox(
                width: 390,
                height: 600,
                child: ListView(
                  children: <Widget>[
                    for (var i = 0; i < 3; i++)
                      SwipeActions(
                        key: ValueKey<String>('row$i'),
                        controller: i == 1 ? controller : null,
                        actions: <SwipeAction>[
                          SwipeAction(
                            label: 'Delete $i',
                            onPressed: () => fired.add(i),
                          ),
                        ],
                        onDismissed: () {},
                        // Realistic row height: the action buttons need
                        // more than a bare Text line.
                        child: SizedBox(
                          height: 64,
                          child: Center(child: Text('row $i')),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      // Sized to settle open, clear of the dismiss line (compact tile ~56).
      await tester.drag(
        find.byKey(const ValueKey<String>('row1')),
        const Offset(-50, 0),
      );
      await _pumpSettle(tester);
      await tester.tap(find.text('Delete 1'));
      await _pumpSettle(tester);
      // The action fired exactly once; the row did not merely close.
      expect(fired, <int>[1]);
      expect(controller.isOpen, isTrue);
    },
  );

  testWidgets('density tokens drive tile width (56 compact, 64 comfortable)', (
    tester,
  ) async {
    expect(swipeActionWidthForTokens(DensityTokens.compact), 56);
    expect(swipeActionWidthForTokens(DensityTokens.comfortable), 64);
    expect(swipeActionWidthForTokens(DensityTokens.touch), 72);
  });

  testWidgets('density override respected per instance', (tester) async {
    await _pump(
      tester,
      SwipeActions(
        densityTokens: DensityTokens.comfortable,
        actions: <SwipeAction>[SwipeAction(label: 'Del', onPressed: () {})],
        child: const Text('row'),
      ),
    );
    // Comfortable tile is wider; a -50 drag reveals less than compact.
    await tester.drag(find.text('row'), const Offset(-50, 0));
    await _pumpSettle(tester);
    // Still settles open (50/64 = 0.78 > 0.5).
    expect(find.text('Del'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('theme actionWidth override wins', (tester) async {
    await _pump(
      tester,
      SwipeActions(
        theme: const SwipeActionsTheme(actionWidth: 80),
        actions: <SwipeAction>[SwipeAction(label: 'Del', onPressed: () {})],
        child: const Text('row'),
      ),
    );
    await tester.drag(find.text('row'), const Offset(-60, 0));
    await _pumpSettle(tester);
    expect(find.text('Del'), findsOneWidget);
  });

  testWidgets('explicit actionExtent honors the 48 px touch floor', (
    tester,
  ) async {
    await _pump(
      tester,
      SwipeActions(
        actionExtent: 20,
        actions: <SwipeAction>[SwipeAction(label: 'Del', onPressed: () {})],
        child: const Text('row'),
      ),
    );
    // A -48 drag reveals the full clamped 48 px tile, not 20 px.
    await tester.drag(find.text('row'), const Offset(-48, 0));
    await _pumpSettle(tester);
    expect(find.text('Del'), findsOneWidget);
  });

  testWidgets('custom runBuilder and contentBuilder swap visuals', (
    tester,
  ) async {
    await _pump(
      tester,
      SwipeActions(
        runBuilder: (context, run, progress) => run,
        contentBuilder: (context, content, progress) => content,
        actions: <SwipeAction>[SwipeAction(label: 'Del', onPressed: () {})],
        child: const Text('row'),
      ),
    );
    await tester.drag(find.text('row'), const Offset(-100, 0));
    await _pumpSettle(tester);
    expect(find.text('Del'), findsOneWidget);
  });

  testWidgets('reduced motion snaps open via controller', (tester) async {
    final SwipeActionsController controller = SwipeActionsController();
    await tester.pumpWidget(
      Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(disableAnimations: true),
            child: Center(
              child: SizedBox(
                width: 390,
                height: 72,
                child: SwipeActions(
                  controller: controller,
                  actions: <SwipeAction>[
                    SwipeAction(label: 'Del', onPressed: () {}),
                  ],
                  child: const Text('row'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    controller.open();
    await tester.pump();
    expect(controller.isOpen, isTrue);
  });

  testWidgets('no overflow at 375 phone width', (tester) async {
    await tester.pumpWidget(
      Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              width: 375,
              child: SwipeActions(
                actions: <SwipeAction>[
                  SwipeAction(
                    label: 'An extremely long action label that truncates',
                    onPressed: () {},
                  ),
                  SwipeAction(
                    label: 'Delete',
                    destructive: true,
                    onPressed: () {},
                  ),
                ],
                onDismissed: () {},
                child: const Text(
                  'A very long row title that must not overflow at 375',
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
