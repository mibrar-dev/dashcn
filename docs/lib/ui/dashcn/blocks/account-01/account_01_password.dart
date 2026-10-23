// The `account-01` block, part 2: the validated password-change form.
//
// Imported by `account_01.dart`; a block never imports another block.

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
import '../../theme/theme.dart';
import '../../primitives/localizations/localizations.dart';
import '../../foundation/component_preview.dart';

/// Values submitted by the [Account01PasswordForm] password form.
class Account01PasswordData {
  /// Creates the submitted values.
  const Account01PasswordData({
    required this.currentPassword,
    required this.newPassword,
  });

  /// The current password.
  final String currentPassword;

  /// The validated new password.
  final String newPassword;
}

/// The password form: current, new (min 8) and a confirm-match check.
class Account01PasswordForm extends StatefulWidget {
  /// Creates the password form.
  const Account01PasswordForm({super.key, required this.onSubmit});

  /// Called once with the typed values after a valid submit.
  final FutureOr<void> Function(Account01PasswordData data)? onSubmit;

  @override
  State<Account01PasswordForm> createState() => _Account01PasswordFormState();
}

class _Account01PasswordFormState extends State<Account01PasswordForm> {
  final FormController _controller = FormController();
  final FormKey<String> _currentKey = const FormKey<String>('currentPassword');
  final FormKey<String> _newKey = const FormKey<String>('newPassword');
  final FormKey<String> _confirmKey = const FormKey<String>('confirmPassword');
  final FocusNode _currentFocus = FocusNode(
    debugLabel: 'account-01 current password',
  );
  final FocusNode _newFocus = FocusNode(debugLabel: 'account-01 new');
  final FocusNode _confirmFocus = FocusNode(debugLabel: 'account-01 confirm');
  bool _succeeded = false;

  Validator<String> get _confirmValidator =>
      const NotEmptyValidator() &
      CompareWith<String>.equal(
        FormKey<String>('newPassword'),
        message: docsSample(context, 'Passwords do not match.'),
      );

  @override
  void dispose() {
    _controller.dispose();
    _currentFocus.dispose();
    _newFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  /// Validates and submits; false when invalid. The button maps false to
  /// its failure state; keyboard paths just focus the first bad field.
  Future<bool> _submit([BuildContext? submitContext]) async {
    if (mounted) {
      setState(() => _succeeded = false);
    }
    final SubmissionResult result = await _controller.submit(
      submitContext ?? context,
    );
    if (!mounted) {
      return false;
    }
    if (!result.isValid) {
      for (final MapEntry<FormKey, FocusNode> entry
          in <MapEntry<FormKey, FocusNode>>[
            MapEntry<FormKey, FocusNode>(_currentKey, _currentFocus),
            MapEntry<FormKey, FocusNode>(_newKey, _newFocus),
            MapEntry<FormKey, FocusNode>(_confirmKey, _confirmFocus),
          ]) {
        if (result.errors.containsKey(entry.key)) {
          entry.value.requestFocus();
          return false;
        }
      }
      return false;
    }
    return true;
  }

  Future<void> _handleValidSubmit(FormMapValues values) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final Account01PasswordData data = Account01PasswordData(
      currentPassword: values.getValue(_currentKey) ?? '',
      newPassword: values.getValue(_newKey) ?? '',
    );
    await widget.onSubmit?.call(data);
    if (!mounted) {
      return;
    }
    setState(() => _succeeded = true);
  }

  static const Set<FormValidationMode> _show = <FormValidationMode>{
    FormValidationMode.changed,
    FormValidationMode.submitted,
  };

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      child: FormScope(
        controller: _controller,
        onSubmit: _handleValidSubmit,
        // The Builder hands the form's inner context to every submit call:
        // cross-field validators (CompareWith) resolve the other field
        // through FormController.maybeOf, which only sees a context under
        // the FormScope, not the State context above it.
        child: Builder(
          builder: (BuildContext formContext) {
            final strings = ComponentLocalizations.of(context);
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(strings.authPassword, style: theme.typography.textLarge),
                Gap(theme.spacing.sm),
                Text(
                  docsSample(
                    context,
                    docsSample(
                      context,
                      'At least 8 characters. Changing it signs you out elsewhere.',
                    ),
                  ),
                  style: theme.typography.textSmall.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
                Gap(theme.spacing.lg),
                const Divider(),
                Gap(theme.spacing.lg),
                FormItem<String>(
                  key: _currentKey,
                  label: Text(strings.blockCurrentPassword),
                  validator: const NotEmptyValidator(),
                  showErrors: _show,
                  child: Input(
                    hintText: '••••••••',
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    focusNode: _currentFocus,
                    onSubmitted: (_) => _newFocus.requestFocus(),
                  ),
                ),
                Gap(theme.spacing.lg),
                FormItem<String>(
                  key: _newKey,
                  label: Text(strings.blockNewPassword),
                  hint: Text(strings.authPasswordHint),
                  validator:
                      const NotEmptyValidator() & const LengthValidator(min: 8),
                  showErrors: _show,
                  child: Input(
                    hintText: '••••••••',
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    focusNode: _newFocus,
                    onSubmitted: (_) => _confirmFocus.requestFocus(),
                  ),
                ),
                Gap(theme.spacing.lg),
                FormItem<String>(
                  key: _confirmKey,
                  label: Text(strings.blockConfirmNewPassword),
                  validator: _confirmValidator,
                  showErrors: _show,
                  child: Input(
                    hintText: '••••••••',
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    focusNode: _confirmFocus,
                    onSubmitted: (_) => _submit(formContext),
                  ),
                ),
                Gap(theme.spacing.xl),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Button(
                    onPressedAsync: () async {
                      if (!await _submit(formContext)) {
                        throw StateError(
                          'Account01Password: validation failed.',
                        );
                      }
                    },
                    child: Text(strings.blockUpdatePassword),
                  ),
                ),
                if (_succeeded) ...<Widget>[
                  Gap(theme.spacing.lg),
                  Alert(
                    content: Text(
                      docsSample(context, 'Password updated.'),
                      style: theme.typography.textSmall,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
