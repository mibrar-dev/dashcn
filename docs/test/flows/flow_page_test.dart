// P9-3b flow page tests: the framed live flow, the screen map jump, the
// install tabs and the per-screen code view.

import 'package:docs/flows/flow_screen_table.dart';
import 'package:docs/generated/docs_flows.dart';
import 'package:docs/pages/flows_pages.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/widgets/flow_code_panel.dart';
import 'package:docs/widgets/flow_install_block.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';

Future<void> _openFlow(WidgetTester tester, String flowId) async {
  final DocsRouterDelegate delegate = await pumpDocsApp(tester);
  await goTo(tester, delegate, '/docs/flows/$flowId');
}

void main() {
  group('flow page', () {
    testWidgets('runs the live flow in the iPhone frame by default', (
      WidgetTester tester,
    ) async {
      await _openFlow(tester, 'auth-01');
      expect(find.byType(FlowPage), findsOneWidget);
      // The default frame is the iPhone.
      expect(
        find.byKey(const ValueKey<String>('framed-iphone')),
        findsOneWidget,
      );
      // The live flow starts at its first screen.
      expect(find.text('Sign in'), findsWidgets);
    });

    testWidgets('frame bar switches the device', (WidgetTester tester) async {
      await _openFlow(tester, 'auth-01');
      await tester.tap(find.byKey(const ValueKey<String>('frame-bar-android')));
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey<String>('framed-android')),
        findsOneWidget,
      );
    });

    testWidgets('screen-map tap jumps the live flow', (
      WidgetTester tester,
    ) async {
      await _openFlow(tester, 'auth-01');
      // The live flow starts at `/` (the thumbnails also render the other
      // screens, so the jump is asserted inside the live subtree).
      final Finder liveSignIn = find.byKey(
        const ValueKey<String>('flow-auth-01-/'),
      );
      expect(liveSignIn, findsOneWidget);
      expect(
        find.descendant(of: liveSignIn, matching: find.text('Sign in')),
        findsWidgets,
      );
      // Tap the entry label: the thumbnail body hosts the screen's own
      // buttons, which win the gesture arena over the entry itself. The
      // map sits below the framed flow, so scroll it into view first.
      final Finder signUpEntry = find.byKey(
        const ValueKey<String>('flow-screen-Sign up'),
      );
      await tester.ensureVisible(signUpEntry);
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(of: signUpEntry, matching: find.text('Sign up')),
      );
      await tester.pumpAndSettle();
      final Finder liveSignUp = find.byKey(
        const ValueKey<String>('flow-auth-01-/signup'),
      );
      expect(liveSignUp, findsOneWidget);
      expect(
        find.descendant(
          of: liveSignUp,
          matching: find.text('Create an account'),
        ),
        findsOneWidget,
      );
      // The code view follows the selected screen.
      final FlowCodePanel panel = tester.widget<FlowCodePanel>(
        find.byType(FlowCodePanel),
      );
      expect(panel.screenName, 'Sign up');
    });

    testWidgets('screen map lists every manifest screen', (
      WidgetTester tester,
    ) async {
      await _openFlow(tester, 'checkout-01');
      final DocsFlow flow = kFlows.firstWhere(
        (DocsFlow f) => f.id == 'checkout-01',
      );
      for (final String screen in flow.screens) {
        expect(
          find.byKey(ValueKey<String>('flow-screen-$screen')),
          findsOneWidget,
          reason: screen,
        );
      }
      // The table and the manifest agree on the screen set.
      expect([
        for (final entry in flowScreens('checkout-01')) entry.name,
      ], flow.screens);
    });

    testWidgets('install tabs show package and own-the-code commands', (
      WidgetTester tester,
    ) async {
      await _openFlow(tester, 'auth-01');
      expect(find.byType(FlowInstallBlock), findsOneWidget);
      expect(find.textContaining('flutter pub add dashcn'), findsWidgets);
      expect(
        find.textContaining("import 'package:dashcn/flows/auth_01.dart';"),
        findsWidgets,
      );
      // The install block sits below the fold at the test surface:
      // scroll it into view before tapping, like the component tests.
      await tester.ensureVisible(find.text('Own the code').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Own the code').first);
      await tester.pumpAndSettle();
      expect(find.textContaining('dashcn add flow:auth-01'), findsWidgets);
      expect(
        find.textContaining('lib/ui/dashcn/flows/auth-01/flow.dart'),
        findsWidgets,
      );
    });

    testWidgets('code view shows the selected screen files verbatim', (
      WidgetTester tester,
    ) async {
      await _openFlow(tester, 'onboarding-01');
      expect(find.textContaining('screens/pages_screen.dart'), findsWidgets);
      final Finder permissionEntry = find.byKey(
        const ValueKey<String>('flow-screen-Permission'),
      );
      await tester.ensureVisible(permissionEntry);
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(of: permissionEntry, matching: find.text('Permission')),
      );
      await tester.pumpAndSettle();
      expect(
        find.textContaining('screens/permission_screen.dart'),
        findsWidgets,
      );
    });
  });
}
