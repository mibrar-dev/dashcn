// The `initialScreen` jump contract of every flow (P9-3b screen map).
//
// Each flow owns a nested Navigator; `initialScreen` selects its first
// route so the docs screen map can rebuild the flow at any screen.

import 'package:dashcn/src/flows/auth-01/flow.dart';
import 'package:dashcn/src/flows/chat-01/flow.dart';
import 'package:dashcn/src/flows/checkout-01/flow.dart';
import 'package:dashcn/src/flows/onboarding-01/flow.dart';
import 'package:dashcn/src/flows/settings-01/flow.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'flows_support.dart';

void main() {
  for (final Brightness brightness in flowBrightnesses) {
    testWidgets('initialScreen jumps (${brightness.name})', (
      WidgetTester tester,
    ) async {
      await pumpFlow(
        tester,
        Auth01Flow(
          key: ValueKey<String>('auth-signup'),
          initialScreen: '/signup',
        ),
        brightness: brightness,
        direction: TextDirection.ltr,
      );
      expect(find.text('Create an account'), findsOneWidget);

      await pumpFlow(
        tester,
        Auth01Flow(key: ValueKey<String>('auth-otp'), initialScreen: '/otp'),
        brightness: brightness,
        direction: TextDirection.ltr,
      );
      expect(find.text('Check your inbox'), findsOneWidget);

      await pumpFlow(
        tester,
        Auth01Flow(
          key: ValueKey<String>('auth-forgot'),
          initialScreen: '/forgot',
        ),
        brightness: brightness,
        direction: TextDirection.ltr,
      );
      expect(find.text('Reset password'), findsOneWidget);

      await pumpFlow(
        tester,
        Onboarding01Flow(
          key: ValueKey<String>('onb-perm'),
          initialScreen: '/permission',
        ),
        brightness: brightness,
        direction: TextDirection.ltr,
      );
      await pumpFlow(
        tester,
        Checkout01Flow(
          key: ValueKey<String>('co-success'),
          initialScreen: '/success',
        ),
        brightness: brightness,
        direction: TextDirection.ltr,
      );
      expect(find.text('Order placed'), findsOneWidget);

      await pumpFlow(
        tester,
        Settings01Flow(
          key: ValueKey<String>('set-appear'),
          initialScreen: '/appearance',
        ),
        brightness: brightness,
        direction: TextDirection.ltr,
      );
      expect(find.text('Appearance'), findsOneWidget);

      await pumpFlow(
        tester,
        Settings01Flow(
          key: ValueKey<String>('set-notif'),
          initialScreen: '/notifications',
        ),
        brightness: brightness,
        direction: TextDirection.ltr,
      );
      expect(find.text('Notifications'), findsOneWidget);

      await pumpFlow(
        tester,
        Chat01Flow(),
        brightness: brightness,
        direction: TextDirection.ltr,
      );
      expect(find.text('Design studio'), findsOneWidget);

      // Bare arg-routes fall back to their list instead of throwing.
      await pumpFlow(
        tester,
        Checkout01Flow(
          key: ValueKey<String>('co-payment-bare'),
          initialScreen: '/payment',
        ),
        brightness: brightness,
        direction: TextDirection.ltr,
      );
      expect(find.text('Everyday backpack'), findsOneWidget);

      await pumpFlow(
        tester,
        Chat01Flow(
          key: ValueKey<String>('chat-thread-bare'),
          initialScreen: '/thread',
        ),
        brightness: brightness,
        direction: TextDirection.ltr,
      );
      expect(find.text('Design studio'), findsOneWidget);
    });
  }
}
