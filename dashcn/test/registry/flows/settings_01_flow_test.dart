// End-to-end test for the `settings-01` flow.
//
// Walks every screen in light + dark and LTR + RTL: grouped home list with
// toggles, nested notification/appearance pages, the account sheet (drag +
// close), and the sign-out confirm (cancel + accept). Asserts callbacks fire
// with the right data.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/pinned_sheet/pinned_sheet.dart';
import 'package:dashcn/src/components/button/button.dart';
import 'package:dashcn/src/components/switch/switch.dart';
import 'package:dashcn/src/flows/settings-01/flow.dart';
import 'package:flutter_test/flutter_test.dart';

import 'flows_support.dart';

void main() {
  for (final brightness in flowBrightnesses) {
    for (final direction in flowDirections) {
      testWidgets('walk ${brightness.name} ${direction.name}', (
        WidgetTester tester,
      ) async {
        final notifications = <bool>[];
        final darkMode = <bool>[];
        final sounds = <bool>[];
        var signedOut = 0;
        await pumpFlow(
          tester,
          Settings01Flow(
            onNotificationsChanged: notifications.add,
            onDarkModeChanged: darkMode.add,
            onSoundsChanged: sounds.add,
            onSignOut: () => signedOut++,
          ),
          brightness: brightness,
          direction: direction,
        );

        // Home: profile row and sections.
        expect(find.text('Ada Lovelace'), findsWidgets);
        expect(find.byType(Switch), findsNWidgets(2));

        // Home toggles report.
        await tester.tap(find.byType(Switch).at(0));
        await flowSettle(tester);
        expect(notifications, <bool>[false]);
        await tester.tap(find.byType(Switch).at(1));
        await flowSettle(tester);
        expect(darkMode, <bool>[true]);

        // Account sheet opens, survives a drag, and closes.
        await tester.tap(find.widgetWithText(Button, 'Account'));
        await flowSettle(tester);
        expect(find.byType(PinnedSheet), findsOneWidget);
        await tester.drag(find.byType(PinnedSheet), const Offset(0, 150));
        await flowSettle(tester);
        expect(find.byType(PinnedSheet), findsOneWidget);
        await tester.tap(find.text('Close'));
        await flowSettle(tester);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));
        expect(find.byType(PinnedSheet), findsNothing);

        // Notifications page with its own toggles, then back.
        await tester.tap(find.widgetWithText(Button, 'Notifications'));
        await flowSettle(tester);
        expect(find.text('Push notifications'), findsOneWidget);
        await tester.tap(find.byType(Switch).at(0));
        await flowSettle(tester);
        expect(notifications, <bool>[false, false]);
        await tester.tap(find.byType(Switch).at(1));
        await flowSettle(tester);
        expect(sounds, <bool>[false]);
        await tester.tap(find.text('Back to settings'));
        await flowSettle(tester);

        // Appearance page, then back.
        await tester.tap(find.widgetWithText(Button, 'Appearance'));
        await flowSettle(tester);
        expect(find.text('Dark mode'), findsOneWidget);
        await tester.tap(find.byType(Switch).first);
        await flowSettle(tester);
        expect(darkMode, <bool>[true, true]);
        await tester.tap(find.text('Back to settings'));
        await flowSettle(tester);

        // Sign out: cancel keeps the session, accept signs out.
        await tester.tap(
          find.byKey(const ValueKey<String>('settings01.signout')),
        );
        await flowSettle(tester);
        expect(find.text('Sign out?'), findsOneWidget);
        await tester.tap(find.text('Cancel'));
        await flowSettle(tester);
        expect(signedOut, 0);
        await tester.tap(
          find.byKey(const ValueKey<String>('settings01.signout')),
        );
        await flowSettle(tester);
        final Finder confirm = find.widgetWithText(Button, 'Sign out');
        expect(confirm, findsNWidgets(2));
        await tester.tap(confirm.at(1));
        await flowSettle(tester);
        expect(signedOut, 1);
      });
    }
  }
}
