// The `login-03` block: a sign-in card with social buttons and a validated
// email form.
//
// A block is layer 4 of the registry: it may import foundation, theme,
// primitives and components, never another block. Its public widget is the
// preview - the docs page renders it exactly as an app would.
//
// The card is constrained to 384px (max-w-sm) and centres itself on a
// full-page muted background (`bg-muted min-h-svh`); the card centres
// vertically in the page and scrolls internally when the host is shorter
// than the form.

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../components/alert/alert.dart';
import '../../components/button/button.dart';
import '../../components/card/card.dart';
import '../../components/divider/divider.dart';
import '../../components/form/form.dart';
import '../../components/input/input.dart';
import '../../foundation/gap.dart';
import '../../primitives/localizations/localizations.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';

/// Values submitted by [Login03].
class Login03Data {
  /// Creates the submitted values.
  const Login03Data({required this.email, required this.password});

  /// The validated email address.
  final String email;

  /// The validated password.
  final String password;
}

/// A sign-in card with social provider buttons and a validated email form.
class Login03 extends StatefulWidget {
  /// Creates the block.
  const Login03({
    super.key,
    this.onSubmit,
    this.onProvider,
    this.onForgotPassword,
    this.onSignUp,
  });

  /// Called once with the typed values after a valid submit (after a short
  /// simulated async call). Null keeps the demo success alert.
  final FutureOr<void> Function(Login03Data data)? onSubmit;

  /// Called with the provider name when a social button is tapped.
  final ValueChanged<String>? onProvider;

  /// Called when "Forgot your password?" is tapped.
  final VoidCallback? onForgotPassword;

  /// Called when "Sign up" is tapped.
  final VoidCallback? onSignUp;

  @override
  State<Login03> createState() => _Login03State();
}

class _Login03State extends State<Login03> {
  final FormController _controller = FormController();
  final FormKey<String> _emailKey = const FormKey<String>('email');
  final FormKey<String> _passwordKey = const FormKey<String>('password');
  final FocusNode _emailFocus = FocusNode(debugLabel: 'login-03 email');
  final FocusNode _passwordFocus = FocusNode(debugLabel: 'login-03 password');
  bool _succeeded = false;

  @override
  void dispose() {
    _controller.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  /// Validates and submits; false when invalid. The button maps false to
  /// its failure state; keyboard paths just focus the first bad field.
  Future<bool> _submit() async {
    if (mounted) {
      setState(() => _succeeded = false);
    }
    final SubmissionResult result = await _controller.submit(context);
    if (!mounted) {
      return false;
    }
    if (!result.isValid) {
      if (result.errors.containsKey(_emailKey)) {
        _emailFocus.requestFocus();
      } else if (result.errors.containsKey(_passwordKey)) {
        _passwordFocus.requestFocus();
      }
      return false;
    }
    return true;
  }

  Future<void> _handleValidSubmit(FormMapValues values) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final Login03Data data = Login03Data(
      email: values.getValue(_emailKey) ?? '',
      password: values.getValue(_passwordKey) ?? '',
    );
    await widget.onSubmit?.call(data);
    if (!mounted) {
      return;
    }
    setState(() => _succeeded = true);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ColoredBox(
      color: theme.colors.background,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final Widget card = ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 384),
              child: Card(
                padding: EdgeInsets.all(theme.spacing.xl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      ComponentLocalizations.of(context).authSignIn,
                      style: theme.typography.h2,
                    ),
                    Gap(theme.spacing.sm),
                    Text(
                      'Pick the way you prefer.',
                      style: theme.typography.textMuted.copyWith(
                        color: theme.colors.mutedForeground,
                      ),
                    ),
                    Gap(theme.spacing.xl),
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                            final Widget github = Button(
                              variant: ButtonVariant.outline,
                              onPressed: () =>
                                  widget.onProvider?.call('GitHub'),
                              child: const _Login03ProviderButton('GitHub'),
                            );
                            final Widget google = Button(
                              variant: ButtonVariant.outline,
                              onPressed: () =>
                                  widget.onProvider?.call('Google'),
                              child: const _Login03ProviderButton('Google'),
                            );
                            // Stacked on phones so the provider buttons never
                            // overflow a 375 px card; side by side otherwise.
                            if (constraints.maxWidth < 420) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  github,
                                  Gap(theme.spacing.md),
                                  google,
                                ],
                              );
                            }
                            return Row(
                              children: <Widget>[
                                Expanded(child: github),
                                Gap(theme.spacing.md),
                                Expanded(child: google),
                              ],
                            );
                          },
                    ),
                    Gap(theme.spacing.xl),
                    const Divider(),
                    Gap(theme.spacing.xl),
                    FormScope(
                      controller: _controller,
                      onSubmit: _handleValidSubmit,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          FormItem<String>(
                            key: _emailKey,
                            label: Text(
                              ComponentLocalizations.of(context).authEmail,
                            ),
                            validator:
                                const NotEmptyValidator() &
                                const EmailValidator(),
                            showErrors: const <FormValidationMode>{
                              FormValidationMode.changed,
                              FormValidationMode.submitted,
                            },
                            child: Input(
                              hintText: 'name@example.com',
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              focusNode: _emailFocus,
                              onSubmitted: (_) => _passwordFocus.requestFocus(),
                            ),
                          ),
                          Gap(theme.spacing.md),
                          FormItem<String>(
                            key: _passwordKey,
                            label: Text(
                              ComponentLocalizations.of(context).authPassword,
                            ),
                            validator:
                                const NotEmptyValidator() &
                                const LengthValidator(min: 8),
                            showErrors: const <FormValidationMode>{
                              FormValidationMode.changed,
                              FormValidationMode.submitted,
                            },
                            child: Input(
                              hintText: ComponentLocalizations.of(
                                context,
                              ).authPassword,
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              focusNode: _passwordFocus,
                              onSubmitted: (_) => _submit(),
                            ),
                          ),
                          Gap(theme.spacing.sm),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Button(
                              variant: ButtonVariant.link,
                              onPressed: widget.onForgotPassword ?? () {},
                              child: const Text('Forgot your password?'),
                            ),
                          ),
                          Gap(theme.spacing.md),
                          Button(
                            onPressedAsync: () async {
                              if (!await _submit()) {
                                throw StateError('Login03: validation failed.');
                              }
                            },
                            child: const Text('Sign in with email'),
                          ),
                          if (_succeeded) ...<Widget>[
                            Gap(theme.spacing.lg),
                            Alert(
                              content: Text(
                                'Signed in — welcome back.',
                                style: theme.typography.textSmall,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Gap(theme.spacing.lg),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 4,
                      children: <Widget>[
                        Text(
                          "Don't have an account?",
                          style: theme.typography.textSmall.copyWith(
                            color: theme.colors.mutedForeground,
                          ),
                        ),
                        Button(
                          variant: ButtonVariant.link,
                          onPressed: widget.onSignUp ?? () {},
                          child: const Text('Sign up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
            if (!constraints.maxHeight.isFinite) {
              return Padding(
                padding: EdgeInsets.all(theme.spacing.lg),
                child: Center(child: card),
              );
            }
            final double pageH = constraints.maxHeight;
            return SingleChildScrollView(
              padding: EdgeInsets.all(theme.spacing.lg),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: pageH - theme.spacing.lg * 2,
                ),
                child: Center(child: card),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// A social provider button: an icon plus the provider name.
class _Login03ProviderButton extends StatelessWidget {
  const _Login03ProviderButton(this.provider);

  final String provider;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(LucideIcons.github, size: 16, color: theme.colors.foreground),
        Gap(theme.spacing.sm),
        Flexible(
          child: Text(
            provider,
            style: theme.typography.textSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
