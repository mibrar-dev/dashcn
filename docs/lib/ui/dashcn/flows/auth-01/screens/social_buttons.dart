// Social buttons shared by the sign-in and sign-up screens of `auth-01`.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';

/// Google / Apple buttons reporting the provider id.
class Auth01SocialButtons extends StatelessWidget {
  /// Creates the social buttons.
  const Auth01SocialButtons({super.key, this.onSocialSignIn});

  /// Called with `google` or `apple`.
  final Future<void> Function(String provider)? onSocialSignIn;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Button(
          variant: ButtonVariant.outline,
          onPressed: () => onSocialSignIn?.call('google'),
          child: const Text('Continue with Google'),
        ),
        Gap(appTheme.spacing.sm),
        Button(
          variant: ButtonVariant.outline,
          onPressed: () => onSocialSignIn?.call('apple'),
          child: const Text('Continue with Apple'),
        ),
      ],
    );
  }
}
