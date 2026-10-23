// Forgot-password screen of the `auth-01` flow: email form, then a
// confirmation once [Auth01ForgotPasswordScreen.onResetPassword] runs.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/form/form.dart';
import '../../../components/input/input.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import 'scaffold.dart';
import '../../../primitives/localizations/localizations.dart';
import '../../../foundation/component_preview.dart';

/// Forgot-password form with a sent-state.
class Auth01ForgotPasswordScreen extends StatefulWidget {
  /// Creates the forgot-password screen.
  const Auth01ForgotPasswordScreen({super.key, this.onResetPassword});

  /// Called with the validated email.
  final Future<void> Function(String email)? onResetPassword;

  @override
  State<Auth01ForgotPasswordScreen> createState() =>
      _Auth01ForgotPasswordScreenState();
}

class _Auth01ForgotPasswordScreenState
    extends State<Auth01ForgotPasswordScreen> {
  final FormController _controller = FormController();
  final FormKey<String> _emailKey = const FormKey<String>('email');
  bool _busy = false;
  bool _sent = false;

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
      await widget.onResetPassword?.call(
        result.values.getValue(_emailKey) ?? '',
      );
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
          _sent = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = ComponentLocalizations.of(context);
    final ThemeData appTheme = Theme.of(context);
    return Auth01Scaffold(
      title: strings.blockResetPassword,
      subtitle: strings.blockWeWillEmailReset,
      children: <Widget>[
        if (_sent)
          Text(
            docsSample(
              context,
              docsSample(
                context,
                'Reset link sent. Check your inbox to continue.',
              ),
            ),
            style: appTheme.typography.textSmall.copyWith(
              color: appTheme.colors.primary,
            ),
          )
        else
          FormScope(
            controller: _controller,
            child: FormItem<String>(
              key: _emailKey,
              label: Text(strings.authEmail),
              validator: const NotEmptyValidator() & const EmailValidator(),
              // Errors surface on submit only: the mount-time report lands as
              // `changed`, so including it would flag pristine fields.
              showErrors: const <FormValidationMode>{
                FormValidationMode.submitted,
              },
              child: const Input(
                key: ValueKey<String>('auth01.forgot.email'),
                hintText: 'name@example.com',
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
        Gap(appTheme.spacing.lg),
        if (!_sent)
          Button(
            onPressed: _busy ? null : _submit,
            child: Text(
              _busy
                  ? docsSample(context, 'Sending…')
                  : docsSample(context, 'Send reset link'),
            ),
          ),
        Gap(appTheme.spacing.sm),
        Button(
          variant: ButtonVariant.ghost,
          size: ButtonSize.sm,
          onPressed: () => Navigator.of(context).pop(),
          child: Text(strings.blockBackToSignIn),
        ),
      ],
    );
  }
}
