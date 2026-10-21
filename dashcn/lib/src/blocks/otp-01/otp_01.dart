// The `otp-01` block: a one-time-code verification card with a validated
// form.
//
// A block is layer 4 of the registry: it may import foundation, theme,
// primitives and components, never another block. Its public widget is the
// preview - the docs page renders it exactly as an app would.
//
// The card is constrained to 384px (max-w-sm) and centres itself on a
// full-page muted background (`bg-muted min-h-svh`); the card centres
// vertically in the page and scrolls internally when the host is shorter
// than the form. The code must be exactly 6 digits; completing all slots
// submits automatically.

import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../components/alert/alert.dart';
import '../../components/button/button.dart';
import '../../components/card/card.dart';
import '../../components/divider/divider.dart';
import '../../components/form/form.dart';
import '../../primitives/localizations/localizations.dart';
import '../../components/input_otp/input_otp.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';

/// Values submitted by [Otp01].
class Otp01Data {
  /// Creates the submitted values.
  const Otp01Data({required this.code});

  /// The validated 6-digit code.
  final String code;
}

/// A one-time-code verification card with a countdown before resending.
class Otp01 extends StatefulWidget {
  /// Creates the block.
  const Otp01({super.key, this.email, this.onSubmit, this.onChangeEmail});

  /// The address the code was sent to.
  final String? email;

  /// Called once with the typed values after a valid submit (after a short
  /// simulated async call). Null keeps the demo success alert.
  final FutureOr<void> Function(Otp01Data data)? onSubmit;

  /// Called when "Use a different email" is tapped.
  final VoidCallback? onChangeEmail;

  @override
  State<Otp01> createState() => _Otp01State();
}

class _Otp01State extends State<Otp01> {
  static final Validator<String> _codeValidator =
      const NotEmptyValidator() &
      const LengthValidator(min: 6, max: 6) &
      RegexValidator(RegExp(r'^\d{6}$'));

  final FormController _controller = FormController();
  final FormKey<String> _codeKey = const FormKey<String>('code');
  final ButtonStatusController _status = ButtonStatusController();
  Timer? _timer;
  int _secondsLeft = 30;
  bool _succeeded = false;

  @override
  void initState() {
    super.initState();
    _status.addListener(_handleStatus);
    _startCountdown();
  }

  void _handleStatus() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _status
      ..removeListener(_handleStatus)
      ..dispose();
    _controller.dispose();
    super.dispose();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _secondsLeft = 30);
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!mounted) {
        return;
      }
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() => _secondsLeft = 0);
        return;
      }
      setState(() => _secondsLeft -= 1);
    });
  }

  /// Submits through the shared status machine, so the button press and the
  /// code-completed auto-submit show the same loading/success/failure. The
  /// machine maps invalid validation to failure (via the throw) and the
  /// valid 600ms demo submit to success.
  Future<void> _submit() {
    if (mounted) {
      setState(() => _succeeded = false);
    }
    return _status.run(() async {
      final SubmissionResult result = await _controller.submit(context);
      if (!mounted) {
        return;
      }
      if (!result.isValid) {
        throw StateError('Otp01: validation failed.');
      }
    });
  }

  Future<void> _handleValidSubmit(FormMapValues values) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final Otp01Data data = Otp01Data(code: values.getValue(_codeKey) ?? '');
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
    final String email = widget.email ?? 'ada@example.com';
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
              Text(strings.blockVerifyYourEmail, style: theme.typography.h2),
              Gap(theme.spacing.sm),
              Text(
                strings.blockWeSentCodeTo(email),
                style: theme.typography.textMuted.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
              Gap(theme.spacing.xl),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 320),
                  child: FormItem<String>(
                    key: _codeKey,
                    label: Text(ComponentLocalizations.of(context).authCode),
                    validator: _codeValidator,
                    showErrors: const <FormValidationMode>{
                      FormValidationMode.changed,
                      FormValidationMode.submitted,
                    },
                    child: InputOtp(
                      length: 6,
                      onCompleted: (_) => _submit(),
                      onSubmitted: (_) => _submit(),
                    ),
                  ),
                ),
              ),
              Gap(theme.spacing.lg),
              _Otp01Resend(
                secondsLeft: _secondsLeft,
                onResend: _startCountdown,
              ),
              Gap(theme.spacing.xl),
              Button(
                status: _status.status,
                onPressed: _submit,
                child: Text(ComponentLocalizations.of(context).actionVerify),
              ),
              if (_succeeded) ...<Widget>[
                Gap(theme.spacing.lg),
                Alert(
                  content: Text(
                    'Email verified — you are all set.',
                    style: theme.typography.textSmall,
                  ),
                ),
              ],
              Gap(theme.spacing.lg),
              const Divider(),
              Gap(theme.spacing.lg),
              Center(
                child: Button(
                  variant: ButtonVariant.link,
                  onPressed: widget.onChangeEmail ?? () {},
                  child: Text(
                    ComponentLocalizations.of(context).authUseDifferentEmail,
                  ),
                ),
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

class _Otp01Resend extends StatelessWidget {
  const _Otp01Resend({required this.secondsLeft, required this.onResend});

  final int secondsLeft;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      children: <Widget>[
        Flexible(
          child: Text(
            "Didn't get the code?",
            style: theme.typography.textSmall.copyWith(
              color: theme.colors.mutedForeground,
            ),
          ),
        ),
        const Spacer(),
        if (secondsLeft > 0)
          Text(
            ComponentLocalizations.of(context).resendInSeconds(secondsLeft),
            style: theme.typography.textSmall.copyWith(
              color: theme.colors.mutedForeground,
            ),
          )
        else
          Button(
            variant: ButtonVariant.link,
            onPressed: onResend,
            child: Text(ComponentLocalizations.of(context).actionResend),
          ),
      ],
    );
  }
}
