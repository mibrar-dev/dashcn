// Sign-up screen of the `auth-01` flow: name, email and password with the
// same validators as sign in, then `/otp`.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/form/form.dart';
import '../../../components/input/input.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import 'scaffold.dart';
import 'social_buttons.dart';

/// Sign-up form; a valid submit calls [onSignUp] then shows `/otp`.
class Auth01SignUpScreen extends StatefulWidget {
  /// Creates the sign-up screen.
  const Auth01SignUpScreen({super.key, this.onSignUp, this.onSocialSignIn});

  /// Called with the validated values.
  final Future<void> Function(String name, String email, String password)?
  onSignUp;

  /// Called with the provider id of a social button.
  final Future<void> Function(String provider)? onSocialSignIn;

  @override
  State<Auth01SignUpScreen> createState() => _Auth01SignUpScreenState();
}

class _Auth01SignUpScreenState extends State<Auth01SignUpScreen> {
  final FormController _controller = FormController();
  final FormKey<String> _nameKey = const FormKey<String>('name');
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
      await widget.onSignUp?.call(
        result.values.getValue(_nameKey) ?? '',
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
      title: 'Create an account',
      subtitle: 'One account for everything.',
      children: <Widget>[
        FormScope(
          controller: _controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FormItem<String>(
                key: _nameKey,
                label: const Text('Name'),
                validator: const NotEmptyValidator(),
                // Errors surface on submit only: the mount-time report lands as
                // `changed`, so including it would flag pristine fields.
                showErrors: const <FormValidationMode>{
                  FormValidationMode.submitted,
                },
                child: const Input(
                  key: ValueKey<String>('auth01.signup.name'),
                  hintText: 'Ada Lovelace',
                ),
              ),
              Gap(appTheme.spacing.md),
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
                  key: ValueKey<String>('auth01.signup.email'),
                  hintText: 'name@example.com',
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Gap(appTheme.spacing.md),
              FormItem<String>(
                key: _passwordKey,
                label: const Text('Password'),
                hint: const Text('At least 8 characters.'),
                validator:
                    const NotEmptyValidator() & const LengthValidator(min: 8),
                // Errors surface on submit only: the mount-time report lands as
                // `changed`, so including it would flag pristine fields.
                showErrors: const <FormValidationMode>{
                  FormValidationMode.submitted,
                },
                child: const Input(
                  key: ValueKey<String>('auth01.signup.password'),
                  hintText: '••••••••',
                  obscureText: true,
                ),
              ),
            ],
          ),
        ),
        Gap(appTheme.spacing.lg),
        Button(
          onPressed: _busy ? null : _submit,
          child: Text(_busy ? 'Creating…' : 'Create account'),
        ),
        Gap(appTheme.spacing.lg),
        Auth01SocialButtons(onSocialSignIn: widget.onSocialSignIn),
        Gap(appTheme.spacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                'Have an account?',
                style: appTheme.typography.textSmall.copyWith(
                  color: appTheme.colors.mutedForeground,
                ),
              ),
            ),
            Button(
              variant: ButtonVariant.link,
              size: ButtonSize.sm,
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Sign in'),
            ),
          ],
        ),
      ],
    );
  }
}
