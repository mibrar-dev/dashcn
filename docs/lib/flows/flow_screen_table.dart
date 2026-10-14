// The per-flow screen table for the Flows pages (P9-3b).
//
// One entry per `meta.json` screen, in order: the display name, the nested
// route a screen-map tap jumps the live flow to (via `initialScreen`),
// a passive thumbnail builder (docs-side demo data, never kit data), and
// the registry files the per-screen code view shows (verbatim generated
// sources, never hand-copied code).
//
// Sheet screens (address, account, attachments) have no route of their own:
// their jump target is the hosting route, and their thumbnail renders the
// sheet body statically inside a [PinnedSheet]. Arg-routes (`/payment`,
// `/thread`) fall back to their list when jumped without arguments (kit
// route guards), so every tap is safe.

import 'package:flutter/widgets.dart';

import '../ui/dashcn/components/drawer_container/drawer_container.dart';
import '../ui/dashcn/components/pinned_sheet/pinned_sheet.dart';
import '../ui/dashcn/flows/auth-01/screens/forgot_password_screen.dart';
import '../ui/dashcn/flows/auth-01/screens/otp_screen.dart';
import '../ui/dashcn/flows/auth-01/screens/sign_in_screen.dart';
import '../ui/dashcn/flows/auth-01/screens/sign_up_screen.dart';
import '../ui/dashcn/flows/chat-01/screens/attachments_sheet.dart';
import '../ui/dashcn/flows/chat-01/screens/conversation_screen.dart';
import '../ui/dashcn/flows/chat-01/screens/thread_list_screen.dart';
import '../ui/dashcn/flows/checkout-01/screens/address_sheet.dart';
import '../ui/dashcn/flows/checkout-01/screens/cart_screen.dart';
import '../ui/dashcn/flows/checkout-01/screens/payment_screen.dart';
import '../ui/dashcn/flows/checkout-01/screens/success_screen.dart';
import '../ui/dashcn/flows/onboarding-01/screens/pages_screen.dart';
import '../ui/dashcn/flows/onboarding-01/screens/permission_screen.dart';
import '../ui/dashcn/flows/settings-01/screens/account_sheet.dart';
import '../ui/dashcn/flows/settings-01/screens/detail_screens.dart';
import '../ui/dashcn/flows/settings-01/screens/home_screen.dart';
import 'flow_demo_data.dart';

/// One screen-map entry: how to jump, preview and read one screen.
class FlowScreenEntry {
  /// Creates an entry.
  const FlowScreenEntry({
    required this.name,
    required this.route,
    required this.thumbnail,
    required this.files,
  });

  /// Display name from `meta.json` (`Sign in`).
  final String name;

  /// Nested route a tap jumps the live flow to (`/signup`).
  final String route;

  /// Passive thumbnail builder (docs demo data, noop callbacks).
  final Widget Function() thumbnail;

  /// Registry-relative files the code view shows (`screens/x.dart`).
  final List<String> files;
}

/// The screen table for [flowId], in `meta.json` order.
List<FlowScreenEntry> flowScreens(String flowId) => switch (flowId) {
  'onboarding-01' => <FlowScreenEntry>[
    FlowScreenEntry(
      name: 'Pages',
      route: '/',
      thumbnail: () =>
          const Onboarding01PagesScreen(pages: kDemoOnboardingPages),
      files: const <String>['flow.dart', 'screens/pages_screen.dart'],
    ),
    FlowScreenEntry(
      name: 'Permission',
      route: '/permission',
      thumbnail: () => Onboarding01PermissionScreen(onResolve: (_) {}),
      files: const <String>['flow.dart', 'screens/permission_screen.dart'],
    ),
  ],
  'auth-01' => <FlowScreenEntry>[
    FlowScreenEntry(
      name: 'Sign in',
      route: '/',
      thumbnail: () => const Auth01SignInScreen(),
      files: const <String>[
        'flow.dart',
        'screens/scaffold.dart',
        'screens/sign_in_screen.dart',
        'screens/social_buttons.dart',
      ],
    ),
    FlowScreenEntry(
      name: 'Sign up',
      route: '/signup',
      thumbnail: () => const Auth01SignUpScreen(),
      files: const <String>[
        'flow.dart',
        'screens/scaffold.dart',
        'screens/sign_up_screen.dart',
        'screens/social_buttons.dart',
      ],
    ),
    FlowScreenEntry(
      name: 'OTP',
      route: '/otp',
      thumbnail: () => const Auth01OtpScreen(),
      files: const <String>['flow.dart', 'screens/otp_screen.dart'],
    ),
    FlowScreenEntry(
      name: 'Forgot password',
      route: '/forgot',
      thumbnail: () => const Auth01ForgotPasswordScreen(),
      files: const <String>['flow.dart', 'screens/forgot_password_screen.dart'],
    ),
  ],
  'checkout-01' => <FlowScreenEntry>[
    FlowScreenEntry(
      name: 'Cart',
      route: '/',
      thumbnail: () => const Checkout01CartScreen(items: kDemoCart),
      files: const <String>['flow.dart', 'screens/cart_screen.dart'],
    ),
    FlowScreenEntry(
      name: 'Address sheet',
      route: '/',
      thumbnail: () => _SheetThumb(
        body: (SheetController controller) => Checkout01AddressSheet(
          controller: controller,
          onClose: () {},
          onSaved: (_) async {},
        ),
      ),
      files: const <String>[
        'flow.dart',
        'screens/cart_screen.dart',
        'screens/address_sheet.dart',
      ],
    ),
    FlowScreenEntry(
      name: 'Payment',
      route: '/payment',
      thumbnail: () => const Checkout01PaymentScreen(order: kDemoOrder),
      files: const <String>['flow.dart', 'screens/payment_screen.dart'],
    ),
    FlowScreenEntry(
      name: 'Success',
      route: '/success',
      thumbnail: () => const Checkout01SuccessScreen(),
      files: const <String>['flow.dart', 'screens/success_screen.dart'],
    ),
  ],
  'settings-01' => <FlowScreenEntry>[
    FlowScreenEntry(
      name: 'Home',
      route: '/',
      thumbnail: () => const Settings01HomeScreen(
        userName: 'Ada Lovelace',
        userEmail: 'ada@example.com',
        userInitials: 'AL',
        notifications: true,
        darkMode: false,
      ),
      files: const <String>['flow.dart', 'screens/home_screen.dart'],
    ),
    FlowScreenEntry(
      name: 'Notifications',
      route: '/notifications',
      thumbnail: () => const Settings01NotificationsScreen(notifications: true),
      files: const <String>['flow.dart', 'screens/detail_screens.dart'],
    ),
    FlowScreenEntry(
      name: 'Appearance',
      route: '/appearance',
      thumbnail: () => const Settings01AppearanceScreen(darkMode: false),
      files: const <String>['flow.dart', 'screens/detail_screens.dart'],
    ),
    FlowScreenEntry(
      name: 'Account sheet',
      route: '/',
      thumbnail: () => _SheetThumb(
        body: (SheetController controller) => Settings01AccountSheet(
          controller: controller,
          userName: 'Ada Lovelace',
          userEmail: 'ada@example.com',
          userInitials: 'AL',
          onClose: () {},
        ),
      ),
      files: const <String>[
        'flow.dart',
        'screens/home_screen.dart',
        'screens/account_sheet.dart',
      ],
    ),
  ],
  'chat-01' => <FlowScreenEntry>[
    FlowScreenEntry(
      name: 'Threads',
      route: '/',
      thumbnail: () => const Chat01ThreadListScreen(threads: kDemoThreads),
      files: const <String>['flow.dart', 'screens/thread_list_screen.dart'],
    ),
    FlowScreenEntry(
      name: 'Conversation',
      route: '/thread',
      thumbnail: () => const Chat01ConversationScreen(
        thread: kDemoThreadsFirst,
        messages: kDemoStudioMessagesList,
      ),
      files: const <String>['flow.dart', 'screens/conversation_screen.dart'],
    ),
    FlowScreenEntry(
      name: 'Attachments sheet',
      route: '/',
      thumbnail: () => _SheetThumb(
        body: (SheetController controller) => Chat01AttachmentsSheet(
          controller: controller,
          onClose: () {},
          onPick: (_) async {},
        ),
      ),
      files: const <String>[
        'flow.dart',
        'screens/conversation_screen.dart',
        'screens/attachments_sheet.dart',
      ],
    ),
  ],
  _ => throw ArgumentError.value(flowId, 'flowId', 'unknown flow'),
};

/// The jump route of [screenName] in [flowId] (used by tests).
String flowScreenRoute(String flowId, String screenName) {
  return flowScreens(
    flowId,
  ).firstWhere((FlowScreenEntry entry) => entry.name == screenName).route;
}

/// A static sheet thumbnail: the sheet body inside an expanded sheet.
class _SheetThumb extends StatefulWidget {
  const _SheetThumb({required this.body});

  final Widget Function(SheetController controller) body;

  @override
  State<_SheetThumb> createState() => _SheetThumbState();
}

class _SheetThumbState extends State<_SheetThumb> {
  final SheetController _controller = SheetController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PinnedSheet(
      controller: _controller,
      initialStage: const SheetStage.expanded(),
      child: DrawerContainer(child: widget.body(_controller)),
    );
  }
}
