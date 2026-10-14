// The `onboarding-01` flow: swipeable intro pages plus a permission ask.
//
// Entry: [Onboarding01Flow] owns a nested [Navigator]; `/` shows the pages,
// `/permission` the permission ask. Data in via [Onboarding01Page], results
// out via callbacks; there is no backend and no demo data in the kit.

import 'package:flutter/widgets.dart';

import '../../components/page_route/page_route.dart';
import '../../foundation/icons/radix_icons.dart';
import 'screens/pages_screen.dart';
import 'screens/permission_screen.dart';

/// One swipeable intro page of [Onboarding01Flow].
class Onboarding01Page {
  /// Creates an intro page.
  const Onboarding01Page({
    required this.icon,
    required this.title,
    required this.description,
  });

  /// Glyph shown above the title.
  final IconData icon;

  /// Headline of the page.
  final String title;

  /// Supporting text of the page.
  final String description;
}

/// Three-page intro with a permission ask: `<Name>Flow` owns the Navigator.
class Onboarding01Flow extends StatelessWidget {
  /// Creates the flow.
  const Onboarding01Flow({
    super.key,
    this.pages = const <Onboarding01Page>[
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
    ],
    this.onSkip,
    this.onFinished,
    this.onPermissionChanged,
    this.initialScreen = '/',
  });

  /// Intro pages; defaults to a three-page tour.
  final List<Onboarding01Page> pages;

  /// Called when Skip is tapped.
  final VoidCallback? onSkip;

  /// Called when the permission screen resolves, with the choice.
  final ValueChanged<bool>? onPermissionChanged;

  /// Called when the permission screen resolves, after [onPermissionChanged].
  final VoidCallback? onFinished;

  /// Initial route of the nested navigator (`/`, `/permission`).
  final String initialScreen;

  void _resolve(BuildContext context, bool granted) {
    onPermissionChanged?.call(granted);
    onFinished?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: initialScreen,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/permission') {
          return AppPageRoute(
            settings: settings,
            builder: (_) => Onboarding01PermissionScreen(
              onResolve: (bool granted) => _resolve(context, granted),
            ),
          );
        }
        return AppPageRoute(
          settings: settings,
          builder: (_) => Onboarding01PagesScreen(pages: pages, onSkip: onSkip),
        );
      },
    );
  }
}
