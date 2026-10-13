// Demo data and callbacks for the Flows pages (P9-3b).
//
// The kit flows take data + callbacks in and hold no backend; everything
// here lives docs-side only. Callbacks report through a gooey toast so the
// reader sees the round-trip without leaving the page.

import 'package:flutter/widgets.dart';

import '../ui/dashcn/components/gooey_toast/gooey_toast.dart';
import '../ui/dashcn/flows/auth-01/flow.dart';
import '../ui/dashcn/flows/chat-01/flow.dart';
import '../ui/dashcn/flows/checkout-01/flow.dart';
import '../ui/dashcn/flows/onboarding-01/flow.dart';
import '../ui/dashcn/flows/settings-01/flow.dart';
import '../ui/dashcn/foundation/icons/radix_icons.dart';

/// Shows a docs-side demo toast (the kit never toasts itself).
void showFlowToast(BuildContext context, String title, [String? description]) {
  gooeyToastControllerOf(context)?.showGooeyToast(
    context,
    GooeyToastOptions(title: title, description: description),
  );
}

/// Demo intro pages for the onboarding flow.
const List<Onboarding01Page> kDemoOnboardingPages = <Onboarding01Page>[
  Onboarding01Page(
    icon: RadixIcons.rocket,
    title: 'Welcome aboard',
    description: 'A quick tour before you start using the app.',
  ),
  Onboarding01Page(
    icon: RadixIcons.chatBubble,
    title: 'Stay in the loop',
    description: 'Messages and updates arrive the moment they happen.',
  ),
  Onboarding01Page(
    icon: RadixIcons.bell,
    title: 'Never miss a thing',
    description: 'Allow notifications to get the most out of the app.',
  ),
];

/// Demo studio thread (also the first entry of [kDemoThreads]).
const Chat01Thread kDemoThreadsFirst = Chat01Thread(
  id: 'studio',
  name: 'Design studio',
  initials: 'DS',
  lastMessage: 'The new mockups are ready.',
  unread: 2,
);

/// Demo studio messages (also `kDemoMessages['studio']`).
const List<Chat01Message> kDemoStudioMessagesList = <Chat01Message>[
  Chat01Message(text: 'Morning! Did the review land?', mine: false),
  Chat01Message(text: 'Just sent the new mockups.', mine: true),
  Chat01Message(text: 'The new mockups are ready.', mine: false),
];

/// Demo threads for the chat flow.
const List<Chat01Thread> kDemoThreads = <Chat01Thread>[
  kDemoThreadsFirst,
  Chat01Thread(
    id: 'ada',
    name: 'Ada Lovelace',
    initials: 'AL',
    lastMessage: 'See you at the demo!',
  ),
];

/// Demo messages per thread id for the chat flow.
const Map<String, List<Chat01Message>> kDemoMessages =
    <String, List<Chat01Message>>{
      'studio': kDemoStudioMessagesList,
      'ada': <Chat01Message>[
        Chat01Message(text: 'See you at the demo!', mine: false),
      ],
    };

/// Demo cart rows for the checkout flow.
const List<Checkout01CartItem> kDemoCart = <Checkout01CartItem>[
  Checkout01CartItem(name: 'Everyday backpack', price: 89),
  Checkout01CartItem(name: 'Insulated bottle', price: 32, quantity: 2),
  Checkout01CartItem(name: 'Desk lamp', price: 54),
];

/// Demo order for the payment screen thumbnail.
const Checkout01Order kDemoOrder = Checkout01Order(
  address: Checkout01Address(
    name: 'Ada Lovelace',
    street: '12 Analytical Engine Ln',
    city: 'London',
  ),
  total: 207,
);

/// Builds the demo flow for [flowId] at [initialScreen].
///
/// Throws [ArgumentError] for unknown ids; every flow carries demo data and
/// toast callbacks, so the kit itself stays backend-free.
Widget buildDemoFlow(String flowId, {String initialScreen = '/'}) {
  return switch (flowId) {
    'onboarding-01' => demoOnboardingFlow(initialScreen: initialScreen),
    'auth-01' => demoAuthFlow(initialScreen: initialScreen),
    'checkout-01' => demoCheckoutFlow(initialScreen: initialScreen),
    'settings-01' => demoSettingsFlow(initialScreen: initialScreen),
    'chat-01' => demoChatFlow(initialScreen: initialScreen),
    _ => throw ArgumentError.value(flowId, 'flowId', 'unknown flow'),
  };
}

/// Demo auth flow with toast callbacks.
Widget demoAuthFlow({String initialScreen = '/'}) {
  return Builder(
    builder: (BuildContext context) => Auth01Flow(
      key: ValueKey<String>('demo-auth-$initialScreen'),
      initialScreen: initialScreen,
      onSignIn: (String email, String password) async {
        showFlowToast(context, 'Signed in', email);
      },
      onSignUp: (String name, String email, String password) async {
        showFlowToast(context, 'Account created', email);
      },
      onVerifyOtp: (String code) async {
        showFlowToast(context, 'Code verified', code);
      },
      onResetPassword: (String email) async {
        showFlowToast(context, 'Reset link sent', email);
      },
      onSocialSignIn: (String provider) async {
        showFlowToast(context, 'Continue with $provider');
      },
    ),
  );
}

/// Demo onboarding flow with toast callbacks.
Widget demoOnboardingFlow({String initialScreen = '/'}) {
  return Builder(
    builder: (BuildContext context) => Onboarding01Flow(
      key: ValueKey<String>('demo-onboarding-$initialScreen'),
      pages: kDemoOnboardingPages,
      initialScreen: initialScreen,
      onSkip: () => showFlowToast(context, 'Tour skipped'),
      onPermissionChanged: (bool granted) =>
          showFlowToast(context, granted ? 'Allowed' : 'Not now'),
      onFinished: () {},
    ),
  );
}

/// Demo checkout flow with toast callbacks.
Widget demoCheckoutFlow({String initialScreen = '/'}) {
  return Builder(
    builder: (BuildContext context) => Checkout01Flow(
      key: ValueKey<String>('demo-checkout-$initialScreen'),
      items: kDemoCart,
      initialScreen: initialScreen,
      onRemoveItem: (Checkout01CartItem item) =>
          showFlowToast(context, 'Removed ${item.name}'),
      onAddressSaved: (Checkout01Address address) async {
        showFlowToast(context, 'Address saved', address.city);
      },
      onPlaceOrder: (Checkout01Address address, double total) async {
        showFlowToast(context, 'Order placed', '\$${total.toStringAsFixed(2)}');
      },
      onDone: () => showFlowToast(context, 'Back to shopping'),
    ),
  );
}

/// Demo settings flow with toast callbacks.
Widget demoSettingsFlow({String initialScreen = '/'}) {
  return Builder(
    builder: (BuildContext context) => Settings01Flow(
      key: ValueKey<String>('demo-settings-$initialScreen'),
      initialScreen: initialScreen,
      onNotificationsChanged: (bool value) =>
          showFlowToast(context, 'Notifications ${value ? 'on' : 'off'}'),
      onDarkModeChanged: (bool value) =>
          showFlowToast(context, 'Dark mode ${value ? 'on' : 'off'}'),
      onSoundsChanged: (bool value) =>
          showFlowToast(context, 'Sounds ${value ? 'on' : 'off'}'),
      onSignOut: () => showFlowToast(context, 'Signed out'),
    ),
  );
}

/// Demo chat flow with toast callbacks.
Widget demoChatFlow({String initialScreen = '/'}) {
  return Builder(
    builder: (BuildContext context) => Chat01Flow(
      key: ValueKey<String>('demo-chat-$initialScreen'),
      threads: kDemoThreads,
      messages: kDemoMessages,
      initialScreen: initialScreen,
      onRefresh: () async => showFlowToast(context, 'Threads refreshed'),
      onSend: (String threadId, String text) async =>
          showFlowToast(context, 'Sent', text),
      onAttach: (String threadId, String kind) async =>
          showFlowToast(context, 'Attached $kind'),
      onThreadMuted: (Chat01Thread thread) =>
          showFlowToast(context, 'Muted ${thread.name}'),
      onThreadDeleted: (Chat01Thread thread) =>
          showFlowToast(context, 'Deleted ${thread.name}'),
    ),
  );
}
