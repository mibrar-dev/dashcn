// The `onboarding-01` flow: swipeable intro pages plus a permission ask.
//
// Entry: [Onboarding01Flow] owns a nested [Navigator]; `/` shows the pages,
// `/permission` the permission ask. Data in via [Onboarding01Page], results
// out via callbacks; there is no backend and no demo data in the kit.

import 'package:flutter/widgets.dart';

import '../../components/page_route/page_route.dart';
import '../../foundation/icons/radix_icons.dart';
import '../../primitives/localizations/localizations.dart';
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
    this.pages,
    this.onSkip,
    this.onFinished,
    this.onPermissionChanged,
    this.initialScreen = '/',
  });

  /// Default intro pages, localized for the ambient locale.
  static List<Onboarding01Page> defaultPages(ComponentLocalizations strings) =>
      <Onboarding01Page>[
        Onboarding01Page(
          icon: RadixIcons.rocket,
          title: strings.blockWelcomeAboard,
          description: strings.blockQuickTour,
        ),
        Onboarding01Page(
          icon: RadixIcons.chatBubble,
          title: strings.blockStayInLoop,
          description: strings.blockMessagesArriveMoment,
        ),
        Onboarding01Page(
          icon: RadixIcons.bell,
          title: strings.blockNeverMissThing,
          description: strings.blockAllowNotificationsBlurb,
        ),
      ];

  /// Intro pages; defaults to a three-page tour.
  final List<Onboarding01Page>? pages;

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
    final strings = ComponentLocalizations.of(context);
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
          builder: (_) => Onboarding01PagesScreen(
            pages: pages ?? Onboarding01Flow.defaultPages(strings),
            onSkip: onSkip,
          ),
        );
      },
    );
  }
}
