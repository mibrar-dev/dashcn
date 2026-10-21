// End-to-end test for the `chat-01` flow.
//
// Walks every screen in light + dark and LTR + RTL: thread list with
// pull-to-refresh and swipe actions (mute + dismiss-to-delete), the
// conversation (bubbles + composer send), and the attachments sheet. Asserts
// callbacks fire with the right data.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/button/button.dart';
import 'package:dashcn/src/components/pinned_sheet/pinned_sheet.dart';
import 'package:dashcn/src/components/swipe_actions/swipe_actions.dart';
import 'package:dashcn/src/flows/chat-01/flow.dart';
import 'package:flutter_test/flutter_test.dart';

import 'flows_support.dart';

const ValueKey<String> _composer = ValueKey<String>('chat01.composer');
const ValueKey<String> _send = ValueKey<String>('chat01.send');
const ValueKey<String> _attach = ValueKey<String>('chat01.attach');
const ValueKey<String> _photo = ValueKey<String>('chat01.attach.photo');

/// Width of the revealed two-action run (2 x 56 px compact tiles).
const double _actionsWidth = 112;

/// Fling direction dismissing a row (mirrored under RTL).
Offset _fling(TextDirection direction) => direction == TextDirection.rtl
    ? const Offset(400, 0)
    : const Offset(-400, 0);

void main() {
  for (final brightness in flowBrightnesses) {
    for (final direction in flowDirections) {
      testWidgets('walk ${brightness.name} ${direction.name}', (
        WidgetTester tester,
      ) async {
        var refreshed = 0;
        final sent = <List<String>>[];
        final attached = <List<String>>[];
        final muted = <String>[];
        final deleted = <String>[];
        await pumpFlow(
          tester,
          Chat01Flow(
            onRefresh: () async => refreshed++,
            onSend: (String threadId, String text) async =>
                sent.add(<String>[threadId, text]),
            onAttach: (String threadId, String kind) async =>
                attached.add(<String>[threadId, kind]),
            onThreadMuted: (Chat01Thread thread) => muted.add(thread.id),
            onThreadDeleted: (Chat01Thread thread) => deleted.add(thread.id),
          ),
          brightness: brightness,
          direction: direction,
        );

        // Thread list with two rows.
        expect(find.text('Messages'), findsOneWidget);
        expect(find.byType(SwipeActions), findsNWidgets(2));

        // Swipe reveals the studio actions (gesture; the row's translate
        // transform verifies the reveal), then tapping Mute fires it.
        final Finder studioRow = find.byKey(
          const ValueKey<String>('chat01.thread.studio'),
        );
        await dragOpen(tester, studioRow, direction, totalWidth: _actionsWidth);
        await settleSwipeOpen(
          tester,
          studioRow,
          direction,
          totalWidth: _actionsWidth,
        );
        await tester.tap(
          find.descendant(of: studioRow, matching: find.text('Mute')),
        );
        await flowSettle(tester);
        expect(muted, <String>['studio']);
        expect(find.text('Design studio (muted)'), findsOneWidget);

        // Open the Ada thread.
        await tester.tap(find.widgetWithText(Button, 'Ada Lovelace'));
        await flowSettle(tester);
        expect(find.text('Write a message…'), findsOneWidget);

        // Composer send reports and adds the bubble.
        await tester.enterText(fieldOf(_composer), 'Hello there');
        await tester.tap(find.byKey(_send));
        await flowSettle(tester);
        expect(sent, <List<String>>[
          <String>['ada', 'Hello there'],
        ]);
        expect(find.text('Hello there'), findsOneWidget);

        // Attachments sheet reports the kind and closes.
        await tester.tap(find.byKey(_attach));
        await flowSettle(tester);
        expect(find.text('Attach'), findsOneWidget);
        await tester.drag(find.byType(PinnedSheet), const Offset(0, 150));
        await flowSettle(tester);
        expect(find.text('Attach'), findsOneWidget);
        await tester.tap(find.byKey(_photo));
        await flowSettle(tester);
        expect(attached, <List<String>>[
          <String>['ada', 'photo'],
        ]);
        expect(find.byType(PinnedSheet), findsNothing);

        // Back to the list, refresh, then delete both threads.
        await tester.tap(find.text('‹ Back'));
        await flowSettle(tester);
        expect(find.text('Messages'), findsOneWidget);
        await tester.drag(find.byType(ListView), const Offset(0, 200));
        await flowSettle(tester);
        // The completion pill + retract animation need extra frames before
        // rows are tappable again.
        await tester.pump(const Duration(milliseconds: 500));
        await tester.pump(const Duration(milliseconds: 500));
        expect(refreshed, 1);
        final Finder adaRow = find.byKey(
          const ValueKey<String>('chat01.thread.ada'),
        );
        await dragOpen(tester, adaRow, direction, totalWidth: _actionsWidth);
        await settleSwipeOpen(
          tester,
          adaRow,
          direction,
          totalWidth: _actionsWidth,
        );
        await tester.tap(
          find.descendant(of: adaRow, matching: find.text('Delete')),
        );
        await flowSettle(tester);
        expect(deleted, <String>['ada']);
        expect(find.byType(SwipeActions), findsNWidgets(1));
        await tester.fling(
          find.byKey(const ValueKey<String>('chat01.thread.studio')),
          _fling(direction),
          2000,
        );
        await flowSettle(tester);
        expect(deleted, <String>['ada', 'studio']);
        expect(find.text('No conversations'), findsOneWidget);
      });
    }
  }
}
