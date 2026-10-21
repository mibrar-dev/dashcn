// The `dashboard-01` block, part 2: the app-shell top bar. Imported by
// `dashboard_01.dart`; a block never imports another block.

import 'package:flutter/widgets.dart';

import '../../components/avatar/avatar.dart';
import '../../components/button/button.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import '../../primitives/localizations/localizations.dart';

/// The app-shell top bar: product mark, actions and the account avatar.
class Dashboard01ShellBar extends StatelessWidget {
  /// Creates the shell bar.
  const Dashboard01ShellBar({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = ComponentLocalizations.of(context);
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.md,
        vertical: theme.spacing.sm,
      ),
      decoration: BoxDecoration(
        color: theme.colors.card,
        borderRadius: theme.borderRadiusLg,
        border: Border.all(color: theme.colors.border),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.colors.primary,
              borderRadius: theme.borderRadiusSm,
            ),
            child: Text(
              'A',
              style: theme.typography.textSmall.copyWith(
                color: theme.colors.primaryForeground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Gap(theme.spacing.sm),
          Text(
            'Acme Inc',
            style: theme.typography.textSmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Button(
            variant: ButtonVariant.outline,
            size: ButtonSize.sm,
            onPressed: () {},
            child: Text(strings.menuShare),
          ),
          Gap(theme.spacing.sm),
          const Avatar(initials: 'AC'),
        ],
      ),
    );
  }
}
