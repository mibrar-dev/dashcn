// The `signup-02` block: a split sign-up with a validated form, a
// password strength meter wired to the password field, and a brand panel.
//
// A block is layer 4 of the registry: it may import foundation, theme,
// primitives and components, never another block. Its public widget is the
// preview - the docs page renders it exactly as an app would.
//
// From 900px the page is two equal columns filling the viewport edge to
// edge: the form column centres the validated form vertically, and the brand
// panel fills its half full height with the muted token, the product mark
// top-left, the trial summary and a quote anchored at the bottom. Below
// 900px the panel is hidden and the form fills the screen.

import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../components/checkbox/checkbox.dart';
import '../../components/form/form.dart';
import '../../theme/theme.dart';
import 'signup_02_aside.dart';
import 'signup_02_form.dart';

/// Values submitted by [Signup02].
class Signup02Data {
  /// Creates the submitted values.
  const Signup02Data({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  /// The validated first name.
  final String firstName;

  /// The validated last name.
  final String lastName;

  /// The validated work email.
  final String email;

  /// The validated password.
  final String password;
}

/// A split sign-up: validated form beside a full-height brand panel.
class Signup02 extends StatefulWidget {
  /// Creates the block.
  const Signup02({super.key, this.onSubmit, this.onSignIn});

  /// Called once with the typed values after a valid submit (after a short
  /// simulated async call). Null keeps the demo success alert.
  final FutureOr<void> Function(Signup02Data data)? onSubmit;

  /// Called when "Sign in" is tapped.
  final VoidCallback? onSignIn;

  @override
  State<Signup02> createState() => _Signup02State();
}

class _Signup02State extends State<Signup02> {
  final FormController _controller = FormController();
  final FormKey<String> _firstNameKey = const FormKey<String>('firstName');
  final FormKey<String> _lastNameKey = const FormKey<String>('lastName');
  final FormKey<String> _emailKey = const FormKey<String>('email');
  final FormKey<String> _passwordKey = const FormKey<String>('password');
  final FormKey<CheckboxValue> _termsKey = const FormKey<CheckboxValue>(
    'terms',
  );
  final FocusNode _firstNameFocus = FocusNode(
    debugLabel: 'signup-02 first name',
  );
  final FocusNode _lastNameFocus = FocusNode(debugLabel: 'signup-02 last name');
  final FocusNode _emailFocus = FocusNode(debugLabel: 'signup-02 email');
  final FocusNode _passwordFocus = FocusNode(debugLabel: 'signup-02 password');
  final TextEditingController _passwordController = TextEditingController();
  CheckboxValue _terms = CheckboxValue.unchecked;
  String _password = '';
  bool _succeeded = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_syncPassword);
  }

  void _syncPassword() {
    final String next = _passwordController.text;
    if (next != _password && mounted) {
      setState(() => _password = next);
    }
  }

  @override
  void dispose() {
    _passwordController.removeListener(_syncPassword);
    _passwordController.dispose();
    _controller.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  /// Validates and submits; false when invalid. The button maps false to
  /// its failure state.
  Future<bool> _submit() async {
    if (mounted) {
      setState(() => _succeeded = false);
    }
    final SubmissionResult result = await _controller.submit(context);
    if (!mounted) {
      return false;
    }
    if (!result.isValid) {
      _focusFirstInvalid(result.errors);
      return false;
    }
    return true;
  }

  void _focusFirstInvalid(Map<FormKey, ValidationResult> errors) {
    for (final MapEntry<FormKey, FocusNode> entry
        in <MapEntry<FormKey, FocusNode>>[
          MapEntry<FormKey, FocusNode>(_firstNameKey, _firstNameFocus),
          MapEntry<FormKey, FocusNode>(_lastNameKey, _lastNameFocus),
          MapEntry<FormKey, FocusNode>(_emailKey, _emailFocus),
          MapEntry<FormKey, FocusNode>(_passwordKey, _passwordFocus),
        ]) {
      if (errors.containsKey(entry.key)) {
        entry.value.requestFocus();
        return;
      }
    }
  }

  Future<void> _handleValidSubmit(FormMapValues values) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final Signup02Data data = Signup02Data(
      firstName: values.getValue(_firstNameKey) ?? '',
      lastName: values.getValue(_lastNameKey) ?? '',
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
            final Widget form = Signup02Form(
              controller: _controller,
              onValidSubmit: _handleValidSubmit,
              firstNameKey: _firstNameKey,
              lastNameKey: _lastNameKey,
              emailKey: _emailKey,
              passwordKey: _passwordKey,
              termsKey: _termsKey,
              firstNameFocus: _firstNameFocus,
              lastNameFocus: _lastNameFocus,
              emailFocus: _emailFocus,
              passwordFocus: _passwordFocus,
              passwordController: _passwordController,
              password: _password,
              terms: _terms,
              onTermsChanged: (CheckboxValue value) =>
                  setState(() => _terms = value),
              succeeded: _succeeded,
              onSubmit: _submit,
              onSignIn: widget.onSignIn,
            );
            final bool wide = constraints.maxWidth >= 900;
            final bool bounded = constraints.maxHeight.isFinite;
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
                    const Expanded(child: Signup02Aside()),
                  ],
                ),
              );
            }
            final double pageH = constraints.maxHeight;
            if (wide) {
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
                  const Expanded(child: Signup02Aside()),
                ],
              );
            }
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
