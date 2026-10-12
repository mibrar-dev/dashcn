// Shared chrome of the `auth-01` flow screens: centred 400px card column.

import 'package:flutter/widgets.dart';

import '../../../components/card/card.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';

/// Centred card column used by every auth screen.
class Auth01Scaffold extends StatelessWidget {
  /// Creates the shared auth chrome.
  const Auth01Scaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  /// Headline of the screen.
  final String title;

  /// Supporting text of the screen.
  final String subtitle;

  /// Form rows and actions of the screen.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(appTheme.spacing.lg),
              child: Card(
                padding: EdgeInsets.all(appTheme.spacing.xl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(title, style: appTheme.typography.h3),
                    Gap(appTheme.spacing.xs),
                    Text(
                      subtitle,
                      style: appTheme.typography.textMuted.copyWith(
                        color: appTheme.colors.mutedForeground,
                      ),
                    ),
                    Gap(appTheme.spacing.xl),
                    ...children,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
