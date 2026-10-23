// Permission screen of the `onboarding-01` flow: explains the ask, then
// resolves through [Onboarding01PermissionScreen.onResolve].

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/card/card.dart';
import '../../../foundation/gap.dart';
import '../../../foundation/icons/radix_icons.dart';
import '../../../theme/theme.dart';
import '../../../primitives/localizations/localizations.dart';
import '../../../foundation/component_preview.dart';

/// Permission ask; Allow resolves true, Not now resolves false.
class Onboarding01PermissionScreen extends StatelessWidget {
  /// Creates the permission screen.
  const Onboarding01PermissionScreen({super.key, required this.onResolve});

  /// Called with the user's choice.
  final ValueChanged<bool> onResolve;

  @override
  Widget build(BuildContext context) {
    final strings = ComponentLocalizations.of(context);
    final ThemeData appTheme = Theme.of(context);
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        // Scrolls when the card is taller than the screen (short phones,
        // landscape, large text scale, touch-sized buttons).
        child: Center(
          child: SingleChildScrollView(
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
                          docsSample(context, 'Enable notifications?'),
                          style: appTheme.typography.h3,
                          textAlign: TextAlign.center,
                        ),
                        Gap(appTheme.spacing.sm),
                        Text(
                          strings.blockNotifPermissionBlurb,
                          textAlign: TextAlign.center,
                          style: appTheme.typography.textMuted.copyWith(
                            color: appTheme.colors.mutedForeground,
                          ),
                        ),
                        Gap(appTheme.spacing.xl),
                        Button(
                          onPressed: () => onResolve(true),
                          child: Text(strings.blockAllowNotifications),
                        ),
                        Gap(appTheme.spacing.sm),
                        Button(
                          variant: ButtonVariant.outline,
                          onPressed: () => onResolve(false),
                          child: Text(strings.blockNotNow),
                        ),
                        Gap(appTheme.spacing.sm),
                        Button(
                          variant: ButtonVariant.ghost,
                          size: ButtonSize.sm,
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(strings.blockBack),
                        ),
                      ],
                    ),
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
