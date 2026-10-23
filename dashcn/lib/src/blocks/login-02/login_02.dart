// The `login-02` block: a split login with a validated form and a
// theme-token testimonial panel.
//
// A block is layer 4 of the registry: it may import foundation, theme,
// primitives and components, never another block. Its public widget is the
// preview - the docs page renders it exactly as an app would.
//
// From 900px the page is two equal columns filling the viewport edge to
// edge: the form column centres a 384px (max-w-sm) validated form
// vertically, and the panel fills its half full height with the muted token,
// a subtle dot pattern drawn from tokens, the product mark top-left and a
// testimonial quote anchored at the bottom. Below 900px the panel is hidden
// and the form fills the screen. No network images anywhere, so the block
// renders offline and in tests, and re-themes with every preset in light
// and dark.

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../components/alert/alert.dart';
import '../../components/button/button.dart';
import '../../components/form/form.dart';
import '../../components/input/input.dart';
import '../../foundation/gap.dart';
import '../../primitives/localizations/localizations.dart';
import '../../theme/theme.dart';
import 'login_02_panel.dart';
import '../../foundation/component_preview.dart';

/// Values submitted by [Login02].
class Login02Data {
  /// Creates the submitted values.
  const Login02Data({required this.email, required this.password});

  /// The validated email address.
  final String email;

  /// The validated password.
  final String password;
}

/// A split login page: a validated form beside a testimonial panel.
class Login02 extends StatefulWidget {
  /// Creates the block.
  const Login02({super.key, this.onSubmit});

  /// Called once with the typed values after a valid submit (after a short
  /// simulated async call). Null keeps the demo success alert.
  final FutureOr<void> Function(Login02Data data)? onSubmit;

  @override
  State<Login02> createState() => _Login02State();
}

class _Login02State extends State<Login02> {
  final FormController _controller = FormController();
  final FormKey<String> _emailKey = const FormKey<String>('email');
  final FormKey<String> _passwordKey = const FormKey<String>('password');
  final FocusNode _emailFocus = FocusNode(debugLabel: 'login-02 email');
  final FocusNode _passwordFocus = FocusNode(debugLabel: 'login-02 password');
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
    final Login02Data data = Login02Data(
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
            final Widget form = _Login02Form(
              controller: _controller,
              onValidSubmit: _handleValidSubmit,
              emailKey: _emailKey,
              passwordKey: _passwordKey,
              emailFocus: _emailFocus,
              passwordFocus: _passwordFocus,
              succeeded: _succeeded,
              onSubmit: _submit,
            );
            final bool wide = constraints.maxWidth >= 900;
            final bool bounded = constraints.maxHeight.isFinite;
            // Unbounded fallback (never the docs page-size frame, which is
            // always tight): stack with the panel at natural height so the
            // tree never hands an infinite cross axis to the Row.
            if (!bounded) {
              if (!wide) {
                return SingleChildScrollView(
                  padding: EdgeInsets.all(theme.spacing.lg),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 384),
                      child: form,
                    ),
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.all(theme.spacing.lg),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 384),
                          child: form,
                        ),
                      ),
                    ),
                    const Expanded(child: Login02Panel()),
                  ],
                ),
              );
            }
            final double pageH = constraints.maxHeight;
            if (wide) {
              // Full-page split: no outer padding, each half 50% width and
              // 100% height. The form half scrolls internally and centres
              // the 384px form vertically; the panel fills its half.
              final double pad = theme.spacing.xl;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(pad),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: pageH - pad * 2),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 384),
                            child: form,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: Login02Panel()),
                ],
              );
            }
            // Mobile: the brand panel is hidden; the form fills the screen.
            final double pad = theme.spacing.lg;
            return SingleChildScrollView(
              padding: EdgeInsets.all(pad),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: pageH - pad * 2),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 384),
                    child: form,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// The validated sign-in form, shared by both layouts.
class _Login02Form extends StatelessWidget {
  const _Login02Form({
    required this.controller,
    required this.onValidSubmit,
    required this.emailKey,
    required this.passwordKey,
    required this.emailFocus,
    required this.passwordFocus,
    required this.succeeded,
    required this.onSubmit,
  });

  final FormController controller;
  final FormSubmitCallback onValidSubmit;
  final FormKey<String> emailKey;
  final FormKey<String> passwordKey;
  final FocusNode emailFocus;
  final FocusNode passwordFocus;
  final bool succeeded;
  final Future<bool> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return FormScope(
      controller: controller,
      onSubmit: onValidSubmit,
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
            docsSample(context, 'Enter your details below to continue.'),
            style: theme.typography.textMuted.copyWith(
              color: theme.colors.mutedForeground,
            ),
          ),
          Gap(theme.spacing.xl),
          FormItem<String>(
            key: emailKey,
            label: Text(ComponentLocalizations.of(context).authEmail),
            validator: const NotEmptyValidator() & const EmailValidator(),
            showErrors: const <FormValidationMode>{
              FormValidationMode.changed,
              FormValidationMode.submitted,
            },
            child: Input(
              hintText: 'name@example.com',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              focusNode: emailFocus,
              onSubmitted: (_) => passwordFocus.requestFocus(),
            ),
          ),
          Gap(theme.spacing.md),
          FormItem<String>(
            key: passwordKey,
            label: Text(ComponentLocalizations.of(context).authPassword),
            validator:
                const NotEmptyValidator() & const LengthValidator(min: 8),
            showErrors: const <FormValidationMode>{
              FormValidationMode.changed,
              FormValidationMode.submitted,
            },
            child: Input(
              hintText: ComponentLocalizations.of(context).authPassword,
              obscureText: true,
              textInputAction: TextInputAction.done,
              focusNode: passwordFocus,
              onSubmitted: (_) => onSubmit(),
            ),
          ),
          Gap(theme.spacing.xl),
          Button(
            onPressedAsync: () async {
              if (!await onSubmit()) {
                throw StateError('Login02: validation failed.');
              }
            },
            child: Text(ComponentLocalizations.of(context).authSignIn),
          ),
          if (succeeded) ...<Widget>[
            Gap(theme.spacing.lg),
            Alert(
              content: Text(
                docsSample(context, 'Signed in — welcome back.'),
                style: theme.typography.textSmall,
              ),
            ),
          ],
          Gap(theme.spacing.lg),
          Text(
            docsSample(
              context,
              docsSample(
                context,
                docsSample(context, 'By signing in you agree to our terms of service.'),
              ),
            ),
            textAlign: TextAlign.center,
            style: theme.typography.xSmall.copyWith(
              color: theme.colors.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}
