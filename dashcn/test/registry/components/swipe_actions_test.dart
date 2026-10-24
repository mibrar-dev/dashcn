// Widget tests for the `swipe_actions` component.
//
// Covers: drag reveals trailing actions, action tap fires, tap-while-open
// closes, dismiss-to-delete on a full swipe, RTL mirroring, and the
// keyboard/semantics alternative (actions are real buttons, excluded while
// closed).

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/swipe_actions/preview.dart';
import 'package:dashcn/src/components/swipe_actions/swipe_actions.dart';
import 'package:dashcn/src/primitives/clickable.dart';
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
      // Sized to settle open, clear of the dismiss line (readable tile 64).
      await tester.drag(
        find.byKey(const ValueKey<String>('row1')),
        const Offset(-70, 0),
      );
      await _pumpSettle(tester);
      await tester.tap(find.text('Delete 1'));
      await _pumpSettle(tester);
      // The action fired exactly once; the row did not merely close.
      expect(fired, <int>[1]);
      expect(controller.isOpen, isTrue);
    },
  );

  testWidgets('density tokens drive tile width (64 compact, 64 comfortable)', (
    tester,
  ) async {
    // At least 64 px wide so labels stay readable (compact 56 bumped to 64).
    expect(swipeActionWidthForTokens(DensityTokens.compact), 64);
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

  testWidgets('explicit actionExtent honors the 64 px readable floor', (
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
    // A -64 drag reveals the full clamped 64 px tile, not 20 px.
    await tester.drag(find.text('row'), const Offset(-64, 0));
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

  group(
    'preview list-tile sizing (SIZING.md rows: 32 single, 48 two-line)',
    () {
      Future<void> pumpPreview(WidgetTester tester, int index) async {
        final preview = swipeActionsPreviews[index];
        await tester.pumpWidget(
          Theme(
            data: const ThemeData(),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: SizedBox(
                  width: 400,
                  child: Builder(
                    builder: (BuildContext context) => preview.builder(context),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pump();
        expect(tester.takeException(), isNull, reason: preview.name);
      }

      Size tileSize(WidgetTester tester, String label) {
        final Finder text = find.text(label, skipOffstage: false);
        expect(text, findsWidgets, reason: label);
        final Finder tile = find.ancestor(
          of: text.first,
          matching: find.byType(Clickable),
        );
        expect(tile, findsWidgets, reason: label);
        return tester.getSize(tile.first);
      }

      testWidgets('default rows are 32 px and stay 32 px swiped open', (
        tester,
      ) async {
        await pumpPreview(tester, 0);
        final rows = find.byType(SwipeActions);
        expect(rows, findsNWidgets(3));
        for (int i = 0; i < 3; i++) {
          expect(tester.getSize(rows.at(i)).height, 32.0, reason: 'row $i');
        }
        // Sized to settle open, clear of the full-swipe dismiss line
        // (2 actions x 64 px = 128 px total; -70 reveals 0.55).
        await tester.drag(rows.first, const Offset(-70, 0));
        await _pumpSettle(tester);
        expect(tester.getSize(rows.first).height, 32.0, reason: 'open row');
        // Revealed tiles fill the full row height at 64 px wide each.
        expect(tileSize(tester, 'Archive'), const Size(64.0, 32.0));
        expect(tileSize(tester, 'Delete'), const Size(64.0, 32.0));
        // The inbox caption sits 8 px below the last row.
        final Offset captionTop = tester.getTopLeft(
          find.textContaining('Inbox:'),
        );
        final Rect lastRow = tester.getRect(rows.last);
        expect(captionTop.dy - lastRow.bottom, 8.0);
      });

      testWidgets(
        'compact rows are 32 px, comfortable two-line rows are 48 px',
        (tester) async {
          await pumpPreview(tester, 1);
          final compact = find.byType(SwipeActions);
          expect(compact, findsNWidgets(3));
          for (int i = 0; i < 3; i++) {
            expect(
              tester.getSize(compact.at(i)).height,
              32.0,
              reason: 'compact $i',
            );
          }
          expect(tileSize(tester, 'Archive'), const Size(64.0, 32.0));

          await pumpPreview(tester, 2);
          final comfortable = find.byType(SwipeActions);
          expect(comfortable, findsNWidgets(2));
          for (int i = 0; i < 2; i++) {
            expect(
              tester.getSize(comfortable.at(i)).height,
              48.0,
              reason: 'comfortable $i',
            );
          }
          await tester.drag(comfortable.first, const Offset(-70, 0));
          await _pumpSettle(tester);
          expect(
            tester.getSize(comfortable.first).height,
            48.0,
            reason: 'open row',
          );
          expect(tileSize(tester, 'Archive'), const Size(64.0, 48.0));
          expect(tileSize(tester, 'Delete'), const Size(64.0, 48.0));
        },
      );
    },
  );
}
