// OTP screen of the `auth-01` flow: six-slot code entry with resend.

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/input_otp/input_otp.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import 'scaffold.dart';
import '../../../primitives/localizations/localizations.dart';
import '../../../foundation/component_preview.dart';

/// OTP verify form; completing the code calls [onVerify] then [onVerified].
class Auth01OtpScreen extends StatefulWidget {
  /// Creates the OTP screen.
  const Auth01OtpScreen({super.key, this.onVerify, this.onVerified});

  /// Called with the completed code.
  final Future<void> Function(String code)? onVerify;

  /// Called after [onVerify] completes.
  final VoidCallback? onVerified;

  @override
  State<Auth01OtpScreen> createState() => _Auth01OtpScreenState();
}

class _Auth01OtpScreenState extends State<Auth01OtpScreen> {
  bool _done = false;
  bool _busy = false;

  Future<void> _completed(String code) async {
    if (_busy) {
      return;
    }
    setState(() => _busy = true);
    try {
      await widget.onVerify?.call(code);
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
          _done = true;
        });
      }
    }
    widget.onVerified?.call();
  }

  @override
  Widget build(BuildContext context) {
    final strings = ComponentLocalizations.of(context);
    final ThemeData appTheme = Theme.of(context);
    return Auth01Scaffold(
      title: strings.blockCheckInbox,
      subtitle: strings.blockEnterSixDigitCode,
      children: <Widget>[
        InputOtp(
          key: const ValueKey<String>('auth01.otp.code'),
          length: 6,
          onCompleted: _completed,
        ),
        Gap(appTheme.spacing.md),
        if (_done)
          Text(
            docsSample(context, 'Code verified. You are signed in.'),
            style: appTheme.typography.textSmall.copyWith(
              color: appTheme.colors.primary,
            ),
          ),
        if (_done) Gap(appTheme.spacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                "Didn't get a code?",
                style: appTheme.typography.textSmall.copyWith(
                  color: appTheme.colors.mutedForeground,
                ),
              ),
            ),
            Gap(appTheme.spacing.xs),
            Button(
              variant: ButtonVariant.link,
              size: ButtonSize.sm,
              onPressed: () {},
              child: Text(
                _busy
                    ? docsSample(context, 'Sending…')
                    : docsSample(context, 'Resend'),
              ),
            ),
          ],
        ),
        Gap(appTheme.spacing.sm),
        Button(
          variant: ButtonVariant.ghost,
          size: ButtonSize.sm,
          onPressed: () => Navigator.of(context).pop(),
          child: Text(strings.blockBack),
        ),
      ],
    );
  }
}
