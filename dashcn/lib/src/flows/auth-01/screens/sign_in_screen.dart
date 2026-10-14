// Sign-in screen of the `auth-01` flow: validated email/password, social
// buttons, and links to sign up and forgot password.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/form/form.dart';
import '../../../components/input/input.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import 'scaffold.dart';
import 'social_buttons.dart';

/// Sign-in form; a valid submit calls [onSignIn] then shows `/otp`.
class Auth01SignInScreen extends StatefulWidget {
  /// Creates the sign-in screen.
  const Auth01SignInScreen({super.key, this.onSignIn, this.onSocialSignIn});

  /// Called with the validated credentials.
  final Future<void> Function(String email, String password)? onSignIn;

  /// Called with the provider id of a social button.
  final Future<void> Function(String provider)? onSocialSignIn;

  @override
  State<Auth01SignInScreen> createState() => _Auth01SignInScreenState();
}

class _Auth01SignInScreenState extends State<Auth01SignInScreen> {
  final FormController _controller = FormController();
  final FormKey<String> _emailKey = const FormKey<String>('email');
  final FormKey<String> _passwordKey = const FormKey<String>('password');
  bool _busy = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final SubmissionResult result = await _controller.submit(context);
    if (!result.isValid || !mounted) {
      return;
    }
    setState(() => _busy = true);
    try {
      await widget.onSignIn?.call(
        result.values.getValue(_emailKey) ?? '',
        result.values.getValue(_passwordKey) ?? '',
      );
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
    if (mounted) {
      Navigator.of(context).pushNamed('/otp');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Auth01Scaffold(
      title: 'Sign in',
      subtitle: 'Enter your credentials to continue.',
      children: <Widget>[
        FormScope(
          controller: _controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FormItem<String>(
                key: _emailKey,
                label: const Text('Email'),
                validator: const NotEmptyValidator() & const EmailValidator(),
                // Errors surface on submit only: the mount-time report lands as
                // `changed`, so including it would flag pristine fields.
                showErrors: const <FormValidationMode>{
                  FormValidationMode.submitted,
                },
                child: const Input(
                  key: ValueKey<String>('auth01.signin.email'),
                  hintText: 'name@example.com',
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Gap(appTheme.spacing.md),
              FormItem<String>(
                key: _passwordKey,
                label: const Text('Password'),
                validator:
                    const NotEmptyValidator() & const LengthValidator(min: 8),
                // Errors surface on submit only: the mount-time report lands as
                // `changed`, so including it would flag pristine fields.
                showErrors: const <FormValidationMode>{
                  FormValidationMode.submitted,
                },
                child: const Input(
                  key: ValueKey<String>('auth01.signin.password'),
                  hintText: '••••••••',
                  obscureText: true,
                ),
              ),
            ],
          ),
        ),
        Gap(appTheme.spacing.md),
        Align(
          alignment: Alignment.centerRight,
          child: Button(
            variant: ButtonVariant.link,
            size: ButtonSize.sm,
            onPressed: () => Navigator.of(context).pushNamed('/forgot'),
            child: const Text('Forgot password?'),
          ),
        ),
        Gap(appTheme.spacing.sm),
        Button(
          onPressed: _busy ? null : _submit,
          child: Text(_busy ? 'Signing in…' : 'Sign in'),
        ),
        Gap(appTheme.spacing.lg),
        Auth01SocialButtons(onSocialSignIn: widget.onSocialSignIn),
        Gap(appTheme.spacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                'No account yet?',
                style: appTheme.typography.textSmall.copyWith(
                  color: appTheme.colors.mutedForeground,
                ),
              ),
            ),
            Gap(appTheme.spacing.xs),
            Button(
              variant: ButtonVariant.link,
              size: ButtonSize.sm,
              onPressed: () => Navigator.of(context).pushNamed('/signup'),
              child: const Text('Create one'),
            ),
          ],
        ),
      ],
    );
  }
}
