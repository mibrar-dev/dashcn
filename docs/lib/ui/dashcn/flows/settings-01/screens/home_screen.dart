// Home screen of the `settings-01` flow: profile row, grouped list with
// toggles, nested-page rows, the account sheet and a sign-out confirm.

import 'package:flutter/widgets.dart';

import '../../../components/alert_dialog/alert_dialog.dart';
import '../../../components/avatar/avatar.dart';
import '../../../components/button/button.dart';
import '../../../components/card/card.dart';
import '../../../components/drawer_container/drawer_container.dart';
import '../../../components/pinned_sheet/pinned_sheet.dart';
import '../../../components/switch/switch.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import 'account_sheet.dart';
import '../../../primitives/localizations/localizations.dart';

/// Grouped settings list.
class Settings01HomeScreen extends StatefulWidget {
  /// Creates the home screen.
  const Settings01HomeScreen({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userInitials,
    required this.notifications,
    required this.darkMode,
    this.onNotificationsChanged,
    this.onDarkModeChanged,
    this.onSignOut,
  });

  /// Display name of the profile row.
  final String userName;

  /// Email of the profile row.
  final String userEmail;

  /// Avatar fallback initials.
  final String userInitials;

  /// Starting notification toggle.
  final bool notifications;

  /// Starting dark-mode toggle.
  final bool darkMode;

  /// Called when the notification toggle flips.
  final ValueChanged<bool>? onNotificationsChanged;

  /// Called when the dark-mode toggle flips.
  final ValueChanged<bool>? onDarkModeChanged;

  /// Called once the sign-out confirm accepts.
  final VoidCallback? onSignOut;

  @override
  State<Settings01HomeScreen> createState() => _Settings01HomeScreenState();
}

class _Settings01HomeScreenState extends State<Settings01HomeScreen> {
  late bool _notifications = widget.notifications;
  late bool _darkMode = widget.darkMode;
  final SheetController _sheet = SheetController();
  bool _sheetOpen = false;

  @override
  void dispose() {
    _sheet.dispose();
    super.dispose();
  }

  Future<void> _confirmSignOut() async {
    final bool? confirmed = await showAlertDialog<bool>(
      context: context,
      useRootNavigator: false,
      title: Text(ComponentLocalizations.of(context).blockSignOutConfirm),
      description: Text(ComponentLocalizations.of(context).blockSignOutBlurb),
      actionsBuilder: (BuildContext dialogContext) => <Widget>[
        Button(
          variant: ButtonVariant.outline,
          onPressed: () => Navigator.pop(dialogContext, false),
          child: Text(ComponentLocalizations.of(context).buttonCancel),
        ),
        Button(
          variant: ButtonVariant.destructive,
          onPressed: () => Navigator.pop(dialogContext, true),
          child: Text(ComponentLocalizations.of(context).blockSignOut),
        ),
      ],
    );
    if (confirmed == true) {
      widget.onSignOut?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = ComponentLocalizations.of(context);
    final ThemeData appTheme = Theme.of(context);
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  padding: EdgeInsets.all(appTheme.spacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Avatar(initials: widget.userInitials),
                          Gap(appTheme.spacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.userName,
                                  style: appTheme.typography.textSmall,
                                ),
                                Text(
                                  widget.userEmail,
                                  style: appTheme.typography.textMuted.copyWith(
                                    color: appTheme.colors.mutedForeground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Gap(appTheme.spacing.lg),
                      _Section(
                        title: strings.blockPreferences,
                        children: <Widget>[
                          _ToggleRow(
                            label: strings.blockNotifications,
                            value: _notifications,
                            onChanged: (bool value) {
                              setState(() => _notifications = value);
                              widget.onNotificationsChanged?.call(value);
                            },
                          ),
                          _ToggleRow(
                            label: strings.blockDarkMode,
                            value: _darkMode,
                            onChanged: (bool value) {
                              setState(() => _darkMode = value);
                              widget.onDarkModeChanged?.call(value);
                            },
                          ),
                        ],
                      ),
                      Gap(appTheme.spacing.md),
                      _Section(
                        title: strings.blockGeneral,
                        children: <Widget>[
                          _NavRow(
                            label: strings.blockNotifications,
                            onTap: () => Navigator.of(
                              context,
                            ).pushNamed('/notifications'),
                          ),
                          _NavRow(
                            label: strings.blockAppearance,
                            onTap: () =>
                                Navigator.of(context).pushNamed('/appearance'),
                          ),
                          _NavRow(
                            label: strings.blockAccount,
                            onTap: () => setState(() => _sheetOpen = true),
                          ),
                        ],
                      ),
                      Gap(appTheme.spacing.lg),
                      Button(
                        key: const ValueKey<String>('settings01.signout'),
                        variant: ButtonVariant.outline,
                        onPressed: _confirmSignOut,
                        child: Text(strings.blockSignOut),
                      ),
                    ],
                  ),
                ),
                if (_sheetOpen)
                  PinnedSheet(
                    controller: _sheet,
                    initialStage: const SheetStage.expanded(),
                    child: DrawerContainer(
                      child: Settings01AccountSheet(
                        controller: _sheet,
                        userName: widget.userName,
                        userEmail: widget.userEmail,
                        userInitials: widget.userInitials,
                        onClose: () => setState(() => _sheetOpen = false),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// One grouped card with a section title.
class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          title,
          style: appTheme.typography.textSmall.copyWith(
            color: appTheme.colors.mutedForeground,
          ),
        ),
        Gap(appTheme.spacing.sm),
        Card(child: Column(children: children)),
      ],
    );
  }
}

/// A label + switch row with the same list-row density as [_NavRow].
class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: appTheme.spacing.lg,
        vertical: appTheme.spacing.sm,
      ),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label)),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

/// A tappable row pushing a nested page.
class _NavRow extends StatelessWidget {
  const _NavRow({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Button(
      variant: ButtonVariant.ghost,
      onPressed: onTap,
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label)),
          const Text('›'),
        ],
      ),
    );
  }
}
