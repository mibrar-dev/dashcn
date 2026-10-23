// The `account-01` block, part 2: the validated profile form.
//
// Imported by `account_01.dart`; a block never imports another block.

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../components/alert/alert.dart';
import '../../components/avatar/avatar.dart';
import '../../components/button/button.dart';
import '../../components/card/card.dart';
import '../../components/divider/divider.dart';
import '../../components/form/form.dart';
import '../../components/input/input.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import '../../primitives/localizations/localizations.dart';
import '../../foundation/component_preview.dart';

class Account01ProfileData {
  /// Creates the submitted values.
  const Account01ProfileData({
    required this.name,
    required this.username,
    required this.bio,
  });

  /// The validated display name.
  final String name;

  /// The validated username.
  final String username;

  /// The validated bio.
  final String bio;
}

/// The profile form: avatar row, an equal-width name/username grid, bio.
class Account01ProfileForm extends StatefulWidget {
  /// Creates the profile form.
  const Account01ProfileForm({
    super.key,
    required this.onSubmit,
    required this.onUploadAvatar,
  });

  final FutureOr<void> Function(Account01ProfileData data)? onSubmit;
  final VoidCallback? onUploadAvatar;

  @override
  State<Account01ProfileForm> createState() => Account01ProfileFormState();
}

class Account01ProfileFormState extends State<Account01ProfileForm> {
  static final Validator<String> _usernameValidator =
      const NotEmptyValidator() &
      const LengthValidator(min: 2, max: 30) &
      RegexValidator(RegExp(r'^[a-z0-9_]+$'));

  final FormController _controller = FormController();
  final FormKey<String> _nameKey = const FormKey<String>('name');
  final FormKey<String> _usernameKey = const FormKey<String>('username');
  final FormKey<String> _bioKey = const FormKey<String>('bio');
  final FocusNode _nameFocus = FocusNode(debugLabel: 'account-01 name');
  final FocusNode _usernameFocus = FocusNode(debugLabel: 'account-01 username');
  final FocusNode _bioFocus = FocusNode(debugLabel: 'account-01 bio');
  bool _succeeded = false;

  @override
  void dispose() {
    _controller.dispose();
    _nameFocus.dispose();
    _usernameFocus.dispose();
    _bioFocus.dispose();
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
      for (final MapEntry<FormKey, FocusNode> entry
          in <MapEntry<FormKey, FocusNode>>[
            MapEntry<FormKey, FocusNode>(_nameKey, _nameFocus),
            MapEntry<FormKey, FocusNode>(_usernameKey, _usernameFocus),
            MapEntry<FormKey, FocusNode>(_bioKey, _bioFocus),
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
    final Account01ProfileData data = Account01ProfileData(
      name: values.getValue(_nameKey) ?? '',
      username: values.getValue(_usernameKey) ?? '',
      bio: values.getValue(_bioKey) ?? '',
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
    final strings = ComponentLocalizations.of(context);
    final ThemeData theme = Theme.of(context);
    return Card(
      child: FormScope(
        controller: _controller,
        onSubmit: _handleValidSubmit,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(strings.blockProfile, style: theme.typography.textLarge),
            Gap(theme.spacing.sm),
            Text(
              docsSample(
                context,
                docsSample(
                  context,
                  docsSample(context, 'This is how others will see you on the site.'),
                ),
              ),
              style: theme.typography.textSmall.copyWith(
                color: theme.colors.mutedForeground,
              ),
            ),
            Gap(theme.spacing.lg),
            const Divider(),
            Gap(theme.spacing.lg),
            Row(
              children: <Widget>[
                const Avatar(initials: 'AL', size: 56),
                Gap(theme.spacing.lg),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        strings.blockYourAvatar,
                        style: theme.typography.textSmall,
                      ),
                      Gap(theme.spacing.sm),
                      Button(
                        variant: ButtonVariant.outline,
                        onPressed: widget.onUploadAvatar ?? () {},
                        child: Text(strings.blockUploadImage),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(theme.spacing.lg),
            const Divider(),
            Gap(theme.spacing.lg),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final strings = ComponentLocalizations.of(context);
                final Widget name = FormItem<String>(
                  key: _nameKey,
                  label: Text(strings.authName),
                  validator:
                      const NotEmptyValidator() &
                      const LengthValidator(min: 2, max: 50),
                  showErrors: _show,
                  child: Input(
                    hintText: docsSample(context, 'Ada Lovelace'),
                    textInputAction: TextInputAction.next,
                    focusNode: _nameFocus,
                    onSubmitted: (_) => _usernameFocus.requestFocus(),
                  ),
                );
                final Widget username = FormItem<String>(
                  key: _usernameKey,
                  label: Text(strings.blockUsername),
                  hint: Text(strings.blockUsernameHint),
                  validator: _usernameValidator,
                  showErrors: _show,
                  child: Input(
                    hintText: 'ada',
                    textInputAction: TextInputAction.next,
                    focusNode: _usernameFocus,
                    onSubmitted: (_) => _bioFocus.requestFocus(),
                  ),
                );
                // Equal-width columns; a single column below 560px so no
                // control is ever squeezed beyond its sensible width.
                if (constraints.maxWidth >= 560) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child: name),
                      Gap(theme.spacing.lg),
                      Expanded(child: username),
                    ],
                  );
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[name, Gap(theme.spacing.lg), username],
                );
              },
            ),
            Gap(theme.spacing.lg),
            FormItem<String>(
              key: _bioKey,
              label: Text(strings.blockBio),
              hint: Text(strings.blockBioCounterHint),
              validator: const LengthValidator(max: 160),
              showErrors: _show,
              // `Input` (not `TextArea`) so the field reports into the form.
              child: Input(
                hintText: strings.blockBioHint,
                minLines: 3,
                maxLines: 5,
                maxLength: 160,
                focusNode: _bioFocus,
                onSubmitted: (_) => _submit(),
              ),
            ),
            Gap(theme.spacing.lg),
            const Divider(),
            Gap(theme.spacing.lg),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  docsSample(context, 'Email'),
                  style: theme.typography.textSmall.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(theme.spacing.sm),
                Text(
                  'ada@example.com',
                  style: theme.typography.textSmall.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
              ],
            ),
            Gap(theme.spacing.xl),
            Align(
              alignment: Alignment.centerLeft,
              child: Button(
                onPressedAsync: () async {
                  if (!await _submit()) {
                    throw StateError('Account01Profile: validation failed.');
                  }
                },
                child: Text(strings.blockSaveChanges),
              ),
            ),
            if (_succeeded) ...<Widget>[
              Gap(theme.spacing.lg),
              Alert(
                content: Text(
                  docsSample(context, 'Profile saved.'),
                  style: theme.typography.textSmall,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
