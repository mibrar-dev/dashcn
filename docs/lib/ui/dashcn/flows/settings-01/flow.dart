// The `settings-01` flow: grouped list, nested pages, toggles, an account
// sheet and a sign-out confirm.
//
// Entry: [Settings01Flow] owns a nested [Navigator] (`/`, `/notifications`,
// `/appearance`). Toggles report through callbacks; the kit stores nothing.

import 'package:flutter/widgets.dart';

import '../../components/page_route/page_route.dart';
import 'screens/detail_screens.dart';
import 'screens/home_screen.dart';
import '../../foundation/component_preview.dart';

/// Grouped settings with nested pages and an account sheet.
class Settings01Flow extends StatelessWidget {
  /// Creates the flow.
  Settings01Flow({
    super.key,
    String? userName,
    this.userEmail = 'ada@example.com',
    this.userInitials = 'AL',
    this.notifications = true,
    this.darkMode = false,
    this.onNotificationsChanged,
    this.onDarkModeChanged,
    this.onSoundsChanged,
    this.onSignOut,
    this.initialScreen = '/',
  }) : userName = userName ?? docsSample(null, 'Ada Lovelace');

  /// Display name shown in the profile row and account sheet.
  final String userName;

  /// Email shown in the profile row and account sheet.
  final String userEmail;

  /// Fallback initials of the avatar.
  final String userInitials;

  /// Starting notification toggle.
  final bool notifications;

  /// Starting dark-mode toggle.
  final bool darkMode;

  /// Called when the notification toggle flips.
  final ValueChanged<bool>? onNotificationsChanged;

  /// Called when the dark-mode toggle flips.
  final ValueChanged<bool>? onDarkModeChanged;

  /// Called when the sounds toggle flips.
  final ValueChanged<bool>? onSoundsChanged;

  /// Called once the sign-out confirm accepts.
  final VoidCallback? onSignOut;

  /// Initial route of the nested navigator (`/`, `/notifications`,
  /// `/appearance`).
  final String initialScreen;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: initialScreen,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/notifications':
            return AppPageRoute(
              settings: settings,
              builder: (_) => Settings01NotificationsScreen(
                notifications: notifications,
                onNotificationsChanged: onNotificationsChanged,
                onSoundsChanged: onSoundsChanged,
              ),
            );
          case '/appearance':
            return AppPageRoute(
              settings: settings,
              builder: (_) => Settings01AppearanceScreen(
                darkMode: darkMode,
                onDarkModeChanged: onDarkModeChanged,
              ),
            );
          case '/':
          default:
            return AppPageRoute(
              settings: settings,
              builder: (_) => Settings01HomeScreen(
                userName: userName,
                userEmail: userEmail,
                userInitials: userInitials,
                notifications: notifications,
                darkMode: darkMode,
                onNotificationsChanged: onNotificationsChanged,
                onDarkModeChanged: onDarkModeChanged,
                onSignOut: onSignOut,
              ),
            );
        }
      },
    );
  }
}
