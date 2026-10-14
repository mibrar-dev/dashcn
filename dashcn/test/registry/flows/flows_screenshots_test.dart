// Screenshot harness for the P9-3a flows (brief: every screen at 390x844).
//
// Runs under `flutter test`: each screen is rendered at device pixel ratio 2
// inside `Theme` + `Directionality` + `Overlay`, captured through a
// `RepaintBoundary` and written as a real PNG to
// `rearch/screenshots/p9-3a/<screen>_<light|dark>.png`.
//
// Read-only with respect to flow code: it observes and captures only.

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/button/button.dart';
import 'package:dashcn/src/flows/auth-01/screens/forgot_password_screen.dart';
import 'package:dashcn/src/flows/auth-01/screens/otp_screen.dart';
import 'package:dashcn/src/flows/auth-01/screens/sign_in_screen.dart';
import 'package:dashcn/src/flows/auth-01/screens/sign_up_screen.dart';
import 'package:dashcn/src/flows/chat-01/flow.dart';
import 'package:dashcn/src/flows/chat-01/screens/conversation_screen.dart';
import 'package:dashcn/src/flows/chat-01/screens/thread_list_screen.dart';
import 'package:dashcn/src/flows/checkout-01/flow.dart';
import 'package:dashcn/src/flows/checkout-01/screens/cart_screen.dart';
import 'package:dashcn/src/flows/checkout-01/screens/payment_screen.dart';
import 'package:dashcn/src/flows/checkout-01/screens/success_screen.dart';
import 'package:dashcn/src/flows/onboarding-01/flow.dart';
import 'package:dashcn/src/flows/onboarding-01/screens/pages_screen.dart';
import 'package:dashcn/src/flows/onboarding-01/screens/permission_screen.dart';
import 'package:dashcn/src/flows/settings-01/screens/detail_screens.dart';
import 'package:dashcn/src/flows/settings-01/screens/home_screen.dart';
import 'package:dashcn/src/foundation/icons/radix_icons.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

/// Device pixel ratio of every capture.
const double _dpr = 2.0;

/// Capture size: a 390x844 phone stage.
const Size _size = Size(390, 844);

/// Output folder `$KIT/rearch/screenshots/p9-3a`, found by walking up to the
/// directory that contains INSTRUCTIONS.md.
Directory get _outDir {
  var dir = Directory.current;
  while (dir.path != dir.parent.path) {
    if (File('${dir.path}/INSTRUCTIONS.md').existsSync()) {
      break;
    }
    dir = dir.parent;
  }
  return Directory('${dir.path}/rearch/screenshots/p9-3a');
}

const List<Onboarding01Page> _pages = <Onboarding01Page>[
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

const List<Checkout01CartItem> _cart = <Checkout01CartItem>[
  Checkout01CartItem(name: 'Everyday backpack', price: 89),
  Checkout01CartItem(name: 'Insulated bottle', price: 32, quantity: 2),
  Checkout01CartItem(name: 'Desk lamp', price: 54),
];

const Checkout01Order _order = Checkout01Order(
  address: Checkout01Address(
    name: 'Ada Lovelace',
    street: '12 Bernoulli Lane',
    city: 'Springfield',
  ),
  total: 207,
);

const List<Chat01Thread> _threads = <Chat01Thread>[
  Chat01Thread(
    id: 'studio',
    name: 'Design studio',
    initials: 'DS',
    lastMessage: 'The new mockups are ready.',
    unread: 2,
  ),
  Chat01Thread(
    id: 'ada',
    name: 'Ada Lovelace',
    initials: 'AL',
    lastMessage: 'See you at the demo!',
  ),
];

const List<Chat01Message> _messages = <Chat01Message>[
  Chat01Message(text: 'Morning! Did the review land?', mine: false),
  Chat01Message(text: 'Just sent the new mockups.', mine: true),
  Chat01Message(text: 'The new mockups are ready.', mine: false),
];

void main() {
  setUpAll(() async {
    await _loadFonts();
    _outDir.createSync(recursive: true);
  });

  _shot('onboarding-pages', () => const Onboarding01PagesScreen(pages: _pages));
  _shot(
    'onboarding-permission',
    () => Onboarding01PermissionScreen(onResolve: (_) {}),
  );
  _shot('auth-signin', () => const Auth01SignInScreen());
  _shot('auth-signup', () => const Auth01SignUpScreen());
  _shot('auth-otp', () => const Auth01OtpScreen());
  _shot('auth-forgot', () => const Auth01ForgotPasswordScreen());
  _shot('checkout-cart', () => const Checkout01CartScreen(items: _cart));
  _shot(
    'checkout-address',
    () => const Checkout01CartScreen(items: _cart),
    interact: (WidgetTester tester) async {
      await tester.tap(
        find.byKey(const ValueKey<String>('checkout01.checkout')),
      );
      await tester.pump(const Duration(milliseconds: 500));
    },
  );
  _shot('checkout-payment', () => const Checkout01PaymentScreen(order: _order));
  _shot('checkout-success', () => const Checkout01SuccessScreen());
  _shot(
    'settings-home',
    () => const Settings01HomeScreen(
      userName: 'Ada Lovelace',
      userEmail: 'ada@example.com',
      userInitials: 'AL',
      notifications: true,
      darkMode: false,
    ),
  );
  _shot(
    'settings-account',
    () => const Settings01HomeScreen(
      userName: 'Ada Lovelace',
      userEmail: 'ada@example.com',
      userInitials: 'AL',
      notifications: true,
      darkMode: false,
    ),
    interact: (WidgetTester tester) async {
      await tester.tap(find.widgetWithText(Button, 'Account'));
      await tester.pump(const Duration(milliseconds: 500));
    },
  );
  _shot(
    'settings-notifications',
    () => const Settings01NotificationsScreen(notifications: true),
  );
  _shot(
    'settings-appearance',
    () => const Settings01AppearanceScreen(darkMode: false),
  );
  _shot('chat-threads', () => const Chat01ThreadListScreen(threads: _threads));
  _shot(
    'chat-conversation',
    () => const Chat01ConversationScreen(
      thread: Chat01Thread(
        id: 'studio',
        name: 'Design studio',
        initials: 'DS',
        lastMessage: 'The new mockups are ready.',
        unread: 2,
      ),
      messages: _messages,
    ),
  );
  _shot(
    'chat-attachments',
    () => const Chat01ConversationScreen(
      thread: Chat01Thread(
        id: 'studio',
        name: 'Design studio',
        initials: 'DS',
        lastMessage: 'The new mockups are ready.',
        unread: 2,
      ),
      messages: _messages,
    ),
    interact: (WidgetTester tester) async {
      await tester.tap(find.byKey(const ValueKey<String>('chat01.attach')));
      await tester.pump(const Duration(milliseconds: 500));
    },
  );
}

/// Registers the repo's Geist + Radix fonts on the test engine.
Future<void> _loadFonts() async {
  Future<void> load(String family, List<String> assets) async {
    final FontLoader loader = FontLoader(family);
    for (final String asset in assets) {
      final Uint8List bytes = File(
        '${Directory.current.path}/$asset',
      ).readAsBytesSync();
      loader.addFont(Future<ByteData>.value(ByteData.sublistView(bytes)));
    }
    await loader.load();
  }

  await load('GeistSans', const <String>['assets/fonts/Geist-Regular.otf']);
  await load('GeistMono', const <String>['assets/fonts/GeistMono-Regular.otf']);
  await load('RadixIcons', const <String>['assets/fonts/radix.otf']);
}

/// Captures [build] in light + dark at 390x844 into `p9-3a/`.
void _shot(
  String name,
  Widget Function() build, {
  Future<void> Function(WidgetTester tester)? interact,
}) {
  for (final Brightness brightness in const <Brightness>[
    Brightness.light,
    Brightness.dark,
  ]) {
    testWidgets('$name ${brightness.name}', (WidgetTester tester) async {
      tester.view.devicePixelRatio = _dpr;
      tester.view.physicalSize = _size * _dpr;
      addTearDown(tester.view.reset);

      final GlobalKey key = GlobalKey();
      final ThemeData data = ThemeData(
        colors: brightness == Brightness.dark
            ? ThemeColors.darkFallback
            : ThemeColors.lightFallback,
      );
      debugDisableShadows = false;
      await tester.pumpWidget(
        RepaintBoundary(
          key: key,
          child: Theme(
            data: data,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Overlay.wrap(
                child: SizedBox(
                  width: _size.width,
                  height: _size.height,
                  // What DashcnApp provides above the theme: the ambient
                  // text/icon style with the foreground colour. Without it
                  // plain Text falls back to white and vanishes in light
                  // mode; real apps always run under DashcnApp.
                  child: Builder(
                    builder: (BuildContext context) {
                      final ThemeData ambient = Theme.of(context);
                      return DefaultTextStyle(
                        style: ambient.typography.sans.copyWith(
                          color: ambient.colors.foreground,
                        ),
                        child: IconTheme(
                          data: IconThemeData(color: ambient.colors.foreground),
                          child: build(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      if (interact != null) {
        await interact(tester);
        await tester.pump();
      }
      // Settle finite animations (route/sheet transitions) without
      // `pumpAndSettle`, which the focused-field cursor blink would hang.
      await tester.pump(const Duration(milliseconds: 500));

      final RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final ui.Image? image = await tester.runAsync(
        () => boundary.toImage(pixelRatio: _dpr),
      );
      final ByteData? bytes = await tester.runAsync<ByteData?>(
        () => image!.toByteData(format: ui.ImageByteFormat.png),
      );
      final File file = File(
        '${_outDir.path}/${name}_'
        '${brightness == Brightness.dark ? 'dark' : 'light'}.png',
      );
      file.writeAsBytesSync(bytes!.buffer.asUint8List());
      debugDisableShadows = true;
    });
  }
}
