// The `signup-01` block: a create-account card with a validated form.
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
import '../../components/checkbox/checkbox.dart';
import '../../components/form/form.dart';
import '../../components/input/input.dart';
import '../../foundation/gap.dart';
import '../../primitives/localizations/localizations.dart';
import '../../theme/theme.dart';
import '../../foundation/component_preview.dart';

/// Values submitted by [Signup01].
class Signup01Data {
  /// Creates the submitted values.
  const Signup01Data({
    required this.name,
    required this.email,
    required this.password,
  });

  /// The validated display name.
  final String name;

  /// The validated email address.
  final String email;

  /// The validated password.
  final String password;
}

/// A create-account card: validated name/email/password and a required terms
/// checkbox.
class Signup01 extends StatefulWidget {
  /// Creates the block.
  const Signup01({super.key, this.onSubmit, this.onSignIn});

  /// Called once with the typed values after a valid submit (after a short
  /// simulated async call). Null keeps the demo success alert.
  final FutureOr<void> Function(Signup01Data data)? onSubmit;

  /// Called when "Sign in" is tapped.
  final VoidCallback? onSignIn;

  @override
  State<Signup01> createState() => _Signup01State();
}

class _Signup01State extends State<Signup01> {
  final FormController _controller = FormController();
  final FormKey<String> _nameKey = const FormKey<String>('name');
  final FormKey<String> _emailKey = const FormKey<String>('email');
  final FormKey<String> _passwordKey = const FormKey<String>('password');
  final FormKey<CheckboxValue> _termsKey = const FormKey<CheckboxValue>(
    'terms',
  );
  final FocusNode _nameFocus = FocusNode(debugLabel: 'signup-01 name');
  final FocusNode _emailFocus = FocusNode(debugLabel: 'signup-01 email');
  final FocusNode _passwordFocus = FocusNode(debugLabel: 'signup-01 password');
  CheckboxValue _terms = CheckboxValue.unchecked;
  bool _succeeded = false;

  @override
  void dispose() {
    _controller.dispose();
    _nameFocus.dispose();
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
          MapEntry<FormKey, FocusNode>(_nameKey, _nameFocus),
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
    final Signup01Data data = Signup01Data(
      name: values.getValue(_nameKey) ?? '',
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
    final strings = ComponentLocalizations.of(context);
    final ThemeData theme = Theme.of(context);
    final Widget card = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 384),
      child: Card(
        padding: EdgeInsets.all(theme.spacing.xl),
        child: FormScope(
          controller: _controller,
          onSubmit: _handleValidSubmit,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                ComponentLocalizations.of(context).authCreateAccount,
                style: theme.typography.h2,
              ),
              Gap(theme.spacing.sm),
              Text(
                docsSample(
                  context,
                  docsSample(
                    context,
                    docsSample(context, 'Enter your email below to create your account.'),
                  ),
                ),
                style: theme.typography.textMuted.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
              Gap(theme.spacing.xl),
              FormItem<String>(
                key: _nameKey,
                label: Text(ComponentLocalizations.of(context).authName),
                validator:
                    const NotEmptyValidator() &
                    const LengthValidator(min: 2, max: 50),
                showErrors: const <FormValidationMode>{
                  FormValidationMode.changed,
                  FormValidationMode.submitted,
                },
                child: Input(
                  hintText: docsSample(context, 'Ada Lovelace'),
                  textInputAction: TextInputAction.next,
                  focusNode: _nameFocus,
                  onSubmitted: (_) => _emailFocus.requestFocus(),
                ),
              ),
              Gap(theme.spacing.md),
              FormItem<String>(
                key: _emailKey,
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
                  focusNode: _emailFocus,
                  onSubmitted: (_) => _passwordFocus.requestFocus(),
                ),
              ),
              Gap(theme.spacing.md),
              FormItem<String>(
                key: _passwordKey,
                label: Text(ComponentLocalizations.of(context).authPassword),
                hint: Text(ComponentLocalizations.of(context).authPasswordHint),
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
                  focusNode: _passwordFocus,
                  onSubmitted: (_) => _submit(),
                ),
              ),
              Gap(theme.spacing.md),
              FormItem<CheckboxValue>(
                key: _termsKey,
                // The checkbox carries its own inline label; the field
                // label stays empty so no text is duplicated.
                label: const SizedBox.shrink(),
                validator: const _AcceptedValidator(),
                showErrors: const <FormValidationMode>{
                  FormValidationMode.changed,
                  FormValidationMode.submitted,
                },
                child: _Signup01Terms(
                  value: _terms,
                  onChanged: (CheckboxValue value) =>
                      setState(() => _terms = value),
                ),
              ),
              Gap(theme.spacing.xl),
              Button(
                onPressedAsync: () async {
                  if (!await _submit()) {
                    throw StateError('Signup01: validation failed.');
                  }
                },
                child: Text(strings.blockCreateAccount),
              ),
              if (_succeeded) ...<Widget>[
                Gap(theme.spacing.lg),
                Alert(
                  content: Text(
                    docsSample(
                      context,
                      docsSample(
                        context,
                        docsSample(context, 'Account created — check your inbox to verify it.'),
                      ),
                    ),
                    style: theme.typography.textSmall,
                  ),
                ),
              ],
              Gap(theme.spacing.lg),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 4,
                children: <Widget>[
                  Text(
                    docsSample(context, 'Already have an account?'),
                    style: theme.typography.textSmall.copyWith(
                      color: theme.colors.mutedForeground,
                    ),
                  ),
                  Button(
                    variant: ButtonVariant.link,
                    onPressed: widget.onSignIn ?? () {},
                    child: Text(ComponentLocalizations.of(context).authSignIn),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return ColoredBox(
      color: theme.colors.background,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
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

/// Fails unless the terms checkbox is checked.
class _AcceptedValidator extends Validator<CheckboxValue> {
  /// Creates the validator.
  const _AcceptedValidator();

  @override
  FutureOr<ValidationResult?> validate(
    BuildContext context,
    CheckboxValue? value,
    FormValidationMode lifecycle,
  ) {
    if (value == CheckboxValue.checked) {
      return null;
    }
    return InvalidResult(
      docsSample(context, 'You must accept the terms to continue.'),
      state: lifecycle,
    );
  }
}

class _Signup01Terms extends StatelessWidget {
  const _Signup01Terms({required this.value, required this.onChanged});

  final CheckboxValue value;
  final ValueChanged<CheckboxValue> onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Checkbox(value: value, onChanged: onChanged),
        Gap(theme.spacing.sm),
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 0,
            children: <Widget>[
              Text(
                'I agree to the ',
                style: theme.typography.textSmall.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
              Button(
                variant: ButtonVariant.link,
                onPressed: () {},
                child: const Text('terms'),
              ),
              Text(
                ' and the ',
                style: theme.typography.textSmall.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
              Button(
                variant: ButtonVariant.link,
                onPressed: () {},
                child: Text(docsSample(context, 'privacy policy')),
              ),
              Text(
                '.',
                style: theme.typography.textSmall.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
