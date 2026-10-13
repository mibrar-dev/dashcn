// GENERATED CODE - DO NOT MODIFY BY HAND.
//
// Sources:
//   * dashcn/lib/src/manifests/registry.json
//   * dashcn/lib/src/flows/<id>/meta.json
//
// Regenerate: dart run tool/gen_docs_data.dart
//
// Every flow and flow file list is derived from the
// registry manifest; the Flows pages never hard-code flow facts.
// Flow sources (code view) live in lib/flows/flow_sources.dart,
// loaded with the deferred Flows pages.

/// One installable flow, generated from the registry manifest.
class DocsFlow {
  /// Creates a flow entry.
  const DocsFlow({
    required this.id,
    required this.name,
    required this.description,
    required this.viewport,
    required this.screens,
    required this.install,
    required this.import,
    required this.entryClass,
    required this.files,
    required this.deps,
    required this.blockDeps,
    required this.tags,
  });

  /// Registry id / route segment (`/docs/flows/<id>`).
  final String id;

  /// Display name (`Auth 01`).
  final String name;

  /// One-line description from the manifest.
  final String description;

  /// Viewport hint from `meta.json` (`desktop`, `mobile`).
  final String viewport;

  /// Display screen names from `meta.json` (`Sign in`, …).
  final List<String> screens;

  /// `dashcn add flow:<id>` from the manifest.
  final String install;

  /// Corrected import line for the installed layout.
  final String import;

  /// Entry widget class from the flow entry file.
  final String entryClass;

  /// Install-root-relative Dart files, entry first.
  final List<String> files;

  /// Component ids the flow composes (manifest `deps`).
  final List<String> deps;

  /// Block ids the flow composes (manifest `deps.blocks`).
  final List<String> blockDeps;

  /// Manifest tags, sorted.
  final List<String> tags;

  /// Whether the flow targets a phone viewport.
  bool get isMobile => viewport == 'mobile';
}

/// All 5 installable flows, ordered by id.
const List<DocsFlow> kFlows = <DocsFlow>[
  DocsFlow(
    id: 'auth-01',
    name: 'Auth 01',
    description:
        'Sign in, sign up, OTP verify and forgot password with social buttons and form validation.',
    viewport: 'mobile',
    screens: <String>['Sign in', 'Sign up', 'OTP', 'Forgot password'],
    install: 'dashcn add flow:auth-01',
    import: "import 'package:<your_app>/ui/dashcn/flows/auth-01/flow.dart';",
    entryClass: 'Auth01Flow',
    files: <String>[
      'lib/ui/dashcn/flows/auth-01/flow.dart',
      'lib/ui/dashcn/flows/auth-01/screens/forgot_password_screen.dart',
      'lib/ui/dashcn/flows/auth-01/screens/otp_screen.dart',
      'lib/ui/dashcn/flows/auth-01/screens/scaffold.dart',
      'lib/ui/dashcn/flows/auth-01/screens/sign_in_screen.dart',
      'lib/ui/dashcn/flows/auth-01/screens/sign_up_screen.dart',
      'lib/ui/dashcn/flows/auth-01/screens/social_buttons.dart',
    ],
    deps: <String>[
      'button',
      'card',
      'form',
      'input',
      'input_otp',
      'page_route',
    ],
    blockDeps: <String>[],
    tags: <String>['auth', 'otp', 'password', 'sign-in', 'sign-up'],
  ),
  DocsFlow(
    id: 'chat-01',
    name: 'Chat 01',
    description:
        'Thread list with swipe actions and pull-to-refresh, a conversation with composer, and an attachments sheet.',
    viewport: 'mobile',
    screens: <String>['Threads', 'Conversation', 'Attachments sheet'],
    install: 'dashcn add flow:chat-01',
    import: "import 'package:<your_app>/ui/dashcn/flows/chat-01/flow.dart';",
    entryClass: 'Chat01Flow',
    files: <String>[
      'lib/ui/dashcn/flows/chat-01/flow.dart',
      'lib/ui/dashcn/flows/chat-01/screens/attachments_sheet.dart',
      'lib/ui/dashcn/flows/chat-01/screens/conversation_screen.dart',
      'lib/ui/dashcn/flows/chat-01/screens/thread_list_screen.dart',
    ],
    deps: <String>[
      'avatar',
      'button',
      'card',
      'chat',
      'drawer_container',
      'empty_state',
      'input',
      'page_route',
      'pinned_sheet',
      'refresh_trigger',
      'swipe_actions',
    ],
    blockDeps: <String>[],
    tags: <String>['chat', 'composer', 'messages', 'threads'],
  ),
  DocsFlow(
    id: 'checkout-01',
    name: 'Checkout 01',
    description:
        'Cart with swipe-to-delete rows, an address bottom sheet, payment and a success screen.',
    viewport: 'mobile',
    screens: <String>['Cart', 'Address sheet', 'Payment', 'Success'],
    install: 'dashcn add flow:checkout-01',
    import:
        "import 'package:<your_app>/ui/dashcn/flows/checkout-01/flow.dart';",
    entryClass: 'Checkout01Flow',
    files: <String>[
      'lib/ui/dashcn/flows/checkout-01/flow.dart',
      'lib/ui/dashcn/flows/checkout-01/screens/address_sheet.dart',
      'lib/ui/dashcn/flows/checkout-01/screens/cart_screen.dart',
      'lib/ui/dashcn/flows/checkout-01/screens/payment_screen.dart',
      'lib/ui/dashcn/flows/checkout-01/screens/success_screen.dart',
    ],
    deps: <String>[
      'button',
      'card',
      'drawer_container',
      'empty_state',
      'form',
      'input',
      'page_route',
      'pinned_sheet',
      'swipe_actions',
    ],
    blockDeps: <String>[],
    tags: <String>['cart', 'checkout', 'payment', 'sheet', 'shop'],
  ),
  DocsFlow(
    id: 'onboarding-01',
    name: 'Onboarding 01',
    description:
        'Three swipeable intro pages with Skip and Next, ending in a notification permission ask.',
    viewport: 'mobile',
    screens: <String>['Pages', 'Permission'],
    install: 'dashcn add flow:onboarding-01',
    import:
        "import 'package:<your_app>/ui/dashcn/flows/onboarding-01/flow.dart';",
    entryClass: 'Onboarding01Flow',
    files: <String>[
      'lib/ui/dashcn/flows/onboarding-01/flow.dart',
      'lib/ui/dashcn/flows/onboarding-01/screens/pages_screen.dart',
      'lib/ui/dashcn/flows/onboarding-01/screens/permission_screen.dart',
    ],
    deps: <String>['button', 'card', 'carousel', 'dot_indicator', 'page_route'],
    blockDeps: <String>[],
    tags: <String>['carousel', 'intro', 'onboarding', 'permission'],
  ),
  DocsFlow(
    id: 'settings-01',
    name: 'Settings 01',
    description:
        'Grouped settings list with nested pages, toggles, an account sheet and a sign-out confirm.',
    viewport: 'mobile',
    screens: <String>['Home', 'Notifications', 'Appearance', 'Account sheet'],
    install: 'dashcn add flow:settings-01',
    import:
        "import 'package:<your_app>/ui/dashcn/flows/settings-01/flow.dart';",
    entryClass: 'Settings01Flow',
    files: <String>[
      'lib/ui/dashcn/flows/settings-01/flow.dart',
      'lib/ui/dashcn/flows/settings-01/screens/account_sheet.dart',
      'lib/ui/dashcn/flows/settings-01/screens/detail_screens.dart',
      'lib/ui/dashcn/flows/settings-01/screens/home_screen.dart',
    ],
    deps: <String>[
      'alert_dialog',
      'avatar',
      'button',
      'card',
      'drawer_container',
      'page_route',
      'pinned_sheet',
      'switch',
    ],
    blockDeps: <String>[],
    tags: <String>['account', 'settings', 'sheet', 'toggles'],
  ),
];
