// Account sheet body of the `settings-01` flow: profile summary shown
// inside the home screen's [PinnedSheet].

import 'package:flutter/widgets.dart';

import '../../../components/avatar/avatar.dart';
import '../../../components/button/button.dart';
import '../../../components/pinned_sheet/pinned_sheet.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import '../../../primitives/localizations/localizations.dart';

/// Account summary with a Close button wired to [controller].
class Settings01AccountSheet extends StatelessWidget {
  /// Creates the account sheet body.
  const Settings01AccountSheet({
    super.key,
    required this.controller,
    required this.userName,
    required this.userEmail,
    required this.userInitials,
    required this.onClose,
  });

  /// Sheet controller for the Close button.
  final SheetController controller;

  /// Display name shown under the avatar.
  final String userName;

  /// Email shown under the name.
  final String userEmail;

  /// Avatar fallback initials.
  final String userInitials;

  /// Hides the sheet.
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final strings = ComponentLocalizations.of(context);
    final ThemeData appTheme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(appTheme.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Avatar(initials: userInitials),
              Gap(appTheme.spacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(userName, style: appTheme.typography.textSmall),
                    Text(
                      userEmail,
                      style: appTheme.typography.textMuted.copyWith(
                        color: appTheme.colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(appTheme.spacing.md),
          Button(
            variant: ButtonVariant.outline,
            onPressed: () {
              controller.close();
              onClose();
            },
            child: Text(strings.actionClose),
          ),
        ],
      ),
    );
  }
}
