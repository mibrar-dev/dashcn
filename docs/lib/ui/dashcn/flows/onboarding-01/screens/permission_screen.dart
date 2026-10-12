// Permission screen of the `onboarding-01` flow: explains the ask, then
// resolves through [Onboarding01PermissionScreen.onResolve].

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/card/card.dart';
import '../../../foundation/gap.dart';
import '../../../foundation/icons/radix_icons.dart';
import '../../../theme/theme.dart';

/// Permission ask; Allow resolves true, Not now resolves false.
class Onboarding01PermissionScreen extends StatelessWidget {
  /// Creates the permission screen.
  const Onboarding01PermissionScreen({super.key, required this.onResolve});

  /// Called with the user's choice.
  final ValueChanged<bool> onResolve;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: EdgeInsets.all(appTheme.spacing.lg),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(appTheme.spacing.xl),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        RadixIcons.bell,
                        size: 44,
                        color: appTheme.colors.primary,
                      ),
                      Gap(appTheme.spacing.lg),
                      Text(
                        'Enable notifications?',
                        style: appTheme.typography.h3,
                        textAlign: TextAlign.center,
                      ),
                      Gap(appTheme.spacing.sm),
                      Text(
                        'We only send what matters: replies, reminders '
                        'and security alerts. You can change this later.',
                        textAlign: TextAlign.center,
                        style: appTheme.typography.textMuted.copyWith(
                          color: appTheme.colors.mutedForeground,
                        ),
                      ),
                      Gap(appTheme.spacing.xl),
                      Button(
                        onPressed: () => onResolve(true),
                        child: const Text('Allow notifications'),
                      ),
                      Gap(appTheme.spacing.sm),
                      Button(
                        variant: ButtonVariant.outline,
                        onPressed: () => onResolve(false),
                        child: const Text('Not now'),
                      ),
                      Gap(appTheme.spacing.sm),
                      Button(
                        variant: ButtonVariant.ghost,
                        size: ButtonSize.sm,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Back'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
