// Nested pages of the `settings-01` flow: notifications and appearance
// details with their own toggles.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/card/card.dart';
import '../../../components/switch/switch.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';

/// Notifications detail page.
class Settings01NotificationsScreen extends StatefulWidget {
  /// Creates the notifications page.
  const Settings01NotificationsScreen({
    super.key,
    required this.notifications,
    this.onNotificationsChanged,
    this.onSoundsChanged,
  });

  /// Starting notification toggle.
  final bool notifications;

  /// Called when the notification toggle flips.
  final ValueChanged<bool>? onNotificationsChanged;

  /// Called when the sounds toggle flips.
  final ValueChanged<bool>? onSoundsChanged;

  @override
  State<Settings01NotificationsScreen> createState() =>
      _Settings01NotificationsScreenState();
}

class _Settings01NotificationsScreenState
    extends State<Settings01NotificationsScreen> {
  late bool _notifications = widget.notifications;
  bool _sounds = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(appTheme.spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Notifications', style: appTheme.typography.h3),
                  Gap(appTheme.spacing.lg),
                  Card(
                    child: Column(
                      children: <Widget>[
                        Settings01ToggleRow(
                          label: 'Push notifications',
                          value: _notifications,
                          onChanged: (bool value) {
                            setState(() => _notifications = value);
                            widget.onNotificationsChanged?.call(value);
                          },
                        ),
                        Settings01ToggleRow(
                          label: 'Sounds',
                          value: _sounds,
                          onChanged: (bool value) {
                            setState(() => _sounds = value);
                            widget.onSoundsChanged?.call(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  Gap(appTheme.spacing.md),
                  Button(
                    variant: ButtonVariant.ghost,
                    size: ButtonSize.sm,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Back to settings'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Appearance detail page.
class Settings01AppearanceScreen extends StatefulWidget {
  /// Creates the appearance page.
  const Settings01AppearanceScreen({
    super.key,
    required this.darkMode,
    this.onDarkModeChanged,
  });

  /// Starting dark-mode toggle.
  final bool darkMode;

  /// Called when the dark-mode toggle flips.
  final ValueChanged<bool>? onDarkModeChanged;

  @override
  State<Settings01AppearanceScreen> createState() =>
      _Settings01AppearanceScreenState();
}

class _Settings01AppearanceScreenState
    extends State<Settings01AppearanceScreen> {
  late bool _darkMode = widget.darkMode;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(appTheme.spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Appearance', style: appTheme.typography.h3),
                  Gap(appTheme.spacing.lg),
                  Card(
                    child: Settings01ToggleRow(
                      label: 'Dark mode',
                      value: _darkMode,
                      onChanged: (bool value) {
                        setState(() => _darkMode = value);
                        widget.onDarkModeChanged?.call(value);
                      },
                    ),
                  ),
                  Gap(appTheme.spacing.md),
                  Button(
                    variant: ButtonVariant.ghost,
                    size: ButtonSize.sm,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Back to settings'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A label + switch row shared by the nested pages.
class Settings01ToggleRow extends StatelessWidget {
  /// Creates a toggle row.
  const Settings01ToggleRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  /// Row label.
  final String label;

  /// Current toggle value.
  final bool value;

  /// Called with the next value.
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
